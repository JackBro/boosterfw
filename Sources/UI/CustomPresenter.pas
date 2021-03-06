unit CustomPresenter;

interface
uses Classes, CoreClasses, ShellIntf, Controls, UIStr,
  UIClasses, SysUtils, EntityServiceIntf, Variants, db, StrUtils, typinfo,
  UIServiceIntf, forms;

type
  TCustomPresenter = class;
  TPresenterClass = class of TCustomPresenter;

  TCustomPresenter = class(TPresenter)
  private
    FViewURI: string;
    FViewTitle: string;
    FWorkspace: IWorkspace;
    FView: IView;
    FFreeOnViewClose: boolean;
    FViewVisible: boolean;
    FViewHidden: boolean;
    FCallerURI: string;
    procedure SetViewTitle(const Value: string);

    function InstantiateView(const AViewURI: string; AViewClass: TViewClass): IView;

    procedure Init(Sender: TWorkItem; Activity: IActivity; AViewClass: TViewClass);
    procedure ReInit(Activity: IActivity);

    procedure ViewShowHandler;
    procedure ViewCloseHandler;
    procedure ViewCloseQueryHandler(var CanClose: boolean);

    procedure SetCallerURI(const Value: string);
    procedure CmdUpdateCommandStatus(Sender: TObject);

    function GetEntityViewValue(AWorkItem: TWorkItem; const AName: string;
      var Done: boolean): Variant;
  protected
    class function GetWorkspaceDefault: string; virtual;

    // AbstractPresenter
    function OnGetWorkItemState(const AName: string; var Done: boolean): Variant; override;
    procedure OnSetWorkItemState(const AName: string; const Value: Variant; var Done: boolean); override;
    procedure Terminate; override;
    procedure Activate; override;
    procedure Deactivate; override;
    //

    procedure OnInit(Activity: IActivity); virtual;
    procedure OnReinit(Activity: IActivity); virtual;
    procedure OnViewReady; virtual;

    procedure OnViewShow; virtual;
    procedure OnViewClose; virtual;
    procedure OnViewCloseQuery(var CanClose: boolean); virtual;

    //
    function GetViewURI: string;
    function GetView: ICustomView;
    function ViewInfo: IActivity;
    procedure ShowView;
    procedure CloseView(ABackToCaller: boolean = true);

    function GetEView(const AEntityName, AEntityViewName: string;
      AParams: array of variant): IEntityView; overload;
    function GetEView(const AEntityName, AEntityViewName: string): IEntityView; overload;

    property Workspace: IWorkspace read FWorkspace;
    property ViewTitle: string read FViewTitle write SetViewTitle;
    property FreeOnViewClose: boolean read FFreeOnViewClose write FFreeOnViewClose;
    property ViewHidden: boolean read FViewHidden write FViewHidden;

    function GetCaller: TWorkItem;
    function GetVisibleCaller: TWorkItem;
    property CallerURI: string read FCallerURI write SetCallerURI;
    property ViewVisible: boolean read FViewVisible write FViewVisible;
    //
    procedure CmdClose(Sender: TObject);
    procedure CmdReloadCaller(Sender: TObject);
    procedure SetCommandStatus(const AName: string; AEnable: boolean);
    procedure UpdateCommandStatus;
    procedure OnUpdateCommandStatus; virtual;
  public
    class procedure Execute(Sender: TWorkItem; Activity: IActivity; AViewClass: TViewClass); override;

    //TODO: move to protected section
    function EntityName: string;
    function EntityViewName: string;

  end;


implementation

{ TCustomPresenter }

procedure TCustomPresenter.CloseView(ABackToCaller: boolean = true);
var
  viewIntf: IView;
  ctrl: TControl;
  visibleCaller: TWorkItem;
begin
  if not FViewVisible then Exit;

  GetView.QueryInterface(IView, viewIntf);
  ctrl := viewIntf.GetViewControl;
  viewIntf := nil;

  if Assigned(FWorkspace) and FWorkspace.ViewExists(ctrl) then
    Workspace.Close(ctrl);

  if ABackToCaller then
  begin
    visibleCaller := GetVisibleCaller;
    if Assigned(visibleCaller) then
      visibleCaller.Activate;
  end;
end;

function TCustomPresenter.GetView: ICustomView;
begin
  Result := nil;
  if Assigned(FView) then
    FView.QueryInterface(ICustomView, Result);
end;

function TCustomPresenter.ViewInfo: IActivity;
begin
  Result := WorkItem.Activities[FViewURI];
end;

procedure TCustomPresenter.OnViewShow;
begin

end;

procedure TCustomPresenter.OnViewReady;
begin
 
end;

procedure TCustomPresenter.SetCommandStatus(const AName: string;
  AEnable: boolean);
begin
  if WorkItem.Commands[AName].Status = csUnavailable then Exit;
  
  if AEnable then
    WorkItem.Commands[AName].Status := csEnabled
  else
    WorkItem.Commands[AName].Status := csDisabled;
end;

procedure TCustomPresenter.SetViewTitle(const Value: string);
var
  vsInfo: TViewSiteInfo;
  viewIntf: IView;
begin
  FViewTitle := Value;
  if Assigned(FWorkspace) and Assigned(FView) then
  begin
    FView.QueryInterface(IView, viewIntf);
    vsInfo := FWorkspace.GetViewSiteInfo(viewIntf.GetViewControl);
    if Assigned(vsInfo) then
      vsInfo.Title := FViewTitle;
  end;
end;


procedure TCustomPresenter.Init(Sender: TWorkItem; Activity: IActivity;
  AViewClass: TViewClass);
var
  I: integer;
  extensions: TInterfaceList;
begin

  FViewHidden := false;
  FFreeOnViewClose := true;

  FViewURI := Activity.URI;
  FCallerURI := Sender.ID;

  WorkItem.CallStack.Add(Sender.ID);
  WorkItem.CallStack.AddStrings(Sender.CallStack);

  if VarToStr(Activity.Params[TViewActivityParams.Title]) <> '' then
    FViewTitle := Activity.Params[TViewActivityParams.Title];

  Activity.Params.AssignTo(WorkItem);

  FView := InstantiateView(FViewURI, AViewClass);

  if not Supports(FView, ICustomView) then
  begin
    FView := nil;
    raise Exception.CreateFmt('View for uri %s not supported ICustomView',
      [GetViewURI]);
  end;

  WorkItem.Commands[COMMAND_CLOSE].SetHandler(CmdClose);
  WorkItem.Commands[COMMAND_CLOSE].ShortCut := COMMAND_CLOSE_SHORTCUT;

  WorkItem.Commands[COMMAND_RELOAD_CALLER].SetHandler(CmdReloadCaller);

  GetView.SetShowHandler(ViewShowHandler);
  GetView.SetCloseHandler(ViewCloseHandler);
  GetView.SetCloseQueryHandler(ViewCloseQueryHandler);

  OnInit(Activity);
  OnViewReady;

  extensions := GetView.Extensions(IExtensionCommand);
  for I := 0 to extensions.Count - 1 do
    (extensions[I] as IExtensionCommand).CommandExtend;

  UpdateCommandStatus;
  WorkItem.Commands[COMMAND_UPDATE_COMMAND_STATUS].SetHandler(CmdUpdateCommandStatus);
end;

function TCustomPresenter.InstantiateView(const AViewURI: string;
  AViewClass: TViewClass): IView;
var
  view: TObject;
  viewID: string;
begin
  viewID := 'View_' + AViewURI;
  view := WorkItem.Items[viewID, TView];
  if Assigned(view) then
  begin
    Result := TView(view) as IView;
    Exit;
  end;

  view := AViewClass.Create(WorkItem, AViewURI);
  Result := (view as TView) as IView;
  if not Assigned(Result) then
  begin
    view.Free;
    raise Exception.CreateFmt('ViewClass %s not implement %s interface',
      [AViewClass.ClassName, 'IView'{GUIDToString(IView)}]);
  end;

  WorkItem.Items.Add(viewID, view);

  UIClasses.InstantiateViewExtensions(view as TView);

  (view as TForm).ScaleBy(
    (WorkItem.Services[IUIService] as IUIService).Scale, 100);


end;

procedure TCustomPresenter.ViewCloseHandler;
begin
  OnViewClose;
  FViewVisible := false;
  if FFreeOnViewClose then
    WorkItem.Free;
end;

procedure TCustomPresenter.ViewCloseQueryHandler(var CanClose: boolean);
begin
  OnViewCloseQuery(CanClose);
end;

procedure TCustomPresenter.OnViewClose;
begin

end;

procedure TCustomPresenter.OnViewCloseQuery(var CanClose: boolean);
begin

end;

function TCustomPresenter.GetEView(const AEntityName,
  AEntityViewName: string; AParams: array of variant): IEntityView;
var
  I: integer;  
begin
  Result := App.Entities[AEntityName].GetView(AEntityViewNAME, WorkItem);

  for I := 0 to High(AParams) do
    if Result.Params.Count > I then
      Result.Params[I].Value := AParams[I];

  if not Result.IsLoaded then
    Result.Load;

end;

function TCustomPresenter.GetCaller: TWorkItem;
begin
  Result := WorkItem.Root.WorkItems.Find(FCallerURI);
end;

function TCustomPresenter.GetEntityViewValue(AWorkItem: TWorkItem;
  const AName: string; var Done: boolean): Variant;
const
  ENTITY_VIEW_VALUE_PREFIX = 'EV.';

var
  evName: string;
  fieldName: string;
  tmpStr: string;
  Svc: IEntityService;
  entityView: IEntityView;
begin
  Result := Unassigned;

  if not AnsiStartsText(ENTITY_VIEW_VALUE_PREFIX, AName) then Exit;

  tmpStr := StringReplace(AName, ENTITY_VIEW_VALUE_PREFIX, '', [rfIgnoreCase]);

  if EntityName = '' then Exit;

  evName := AnsiLeftStr(tmpStr, Pos('.', tmpStr) - 1);
  fieldName :=  AnsiRightStr(tmpStr, Length(tmpStr) - Pos('.', tmpStr));

  if evName = '' then Exit;

  Svc := AWorkItem.Services[IEntityService] as IEntityService;

  if not Svc.EntityViewExists(entityName, evName) then Exit;

  entityView := Svc.Entity[entityName].GetView(evName, AWorkItem);

  if not entityView.IsLoaded then Exit;
   // entityView.Load(); //Exit;  !!! AV on destroy form

  if entityView.DataSet.FindField(fieldName) <> nil then
  begin
    Done := true;
    Result := entityView.DataSet[fieldName];
  end;

end;

function TCustomPresenter.GetEView(const AEntityName,
  AEntityViewName: string): IEntityView;
begin
  Result := App.Entities[AEntityName].GetView(AEntityViewNAME, WorkItem);
  Result.Load(false);
end;


procedure TCustomPresenter.ShowView;
var
  viewIntf: IView;
begin
  FWorkspace := WorkItem.Workspaces[GetWorkspaceDefault];
  FView.QueryInterface(IView, viewIntf);
  FWorkspace.Show(viewIntf.GetViewControl, FViewTitle);
end;

procedure TCustomPresenter.ReInit(Activity: IActivity);
begin
  Activity.Params.AssignTo(WorkItem);
  OnReinit(Activity);
end;

procedure TCustomPresenter.OnInit(Activity: IActivity);
begin

end;

procedure TCustomPresenter.OnReinit(Activity: IActivity);
begin

end;

function TCustomPresenter.OnGetWorkItemState(const AName: string; var Done: boolean): Variant;
begin
  Result := GetEntityViewValue(WorkItem, AName, Done);
  if Done then Exit;
end;

procedure TCustomPresenter.OnSetWorkItemState(const AName: string;
  const Value: Variant; var Done: boolean);
begin
end;

procedure TCustomPresenter.Terminate;
begin
  CloseView;
end;

procedure TCustomPresenter.ViewShowHandler;
begin
  FViewVisible := true;
  OnViewShow;
end;

procedure TCustomPresenter.CmdClose(Sender: TObject);
begin
  CloseView;
end;

procedure TCustomPresenter.CmdReloadCaller(Sender: TObject);
var
  callerWI: TWorkItem;
begin
  callerWI := GetVisibleCaller;
  if callerWI <> nil then
    callerWI.Commands[COMMAND_RELOAD].Execute;
end;

procedure TCustomPresenter.CmdUpdateCommandStatus(Sender: TObject);
begin
  UpdateCommandStatus;
end;

procedure TCustomPresenter.Activate;
begin
  if Assigned(Workspace) and Workspace.ViewExists(FView.GetViewControl) then
    ShowView;
end;


procedure TCustomPresenter.Deactivate;
begin


end;

function TCustomPresenter.EntityName: string;
begin
  Result := ViewInfo.OptionValue(TViewActivityOptions.EntityName);
end;

function TCustomPresenter.EntityViewName: string;
begin
  Result := ViewInfo.OptionValue(TViewActivityOptions.EntityViewName);
end;

class procedure TCustomPresenter.Execute(Sender: TWorkItem; Activity: IActivity;
  AViewClass: TViewClass);

  function FindPresenterWI(const InstanceID: string): TWorkItem;
  var
    I: integer;
  begin
    for I := 0 to Sender.Root.WorkItems.Count - 1 do
    begin
      Result := Sender.Root.WorkItems[I];
      if Assigned(Result.Controller) and
        (Result.Controller.ClassType.InheritsFrom(TCustomPresenter)) and
        (Result.ID = InstanceID) then Exit;
    end;
    Result := nil;
  end;

  function GetInstanceID: string;
  var
    lst: TStringList;
    instIDParams: string;
    I: integer;
  begin
    Result := VarToStr(Activity.Params[TViewActivityParams.InstanceID]);

    if (Result = '') and (not activity.OptionExists(TViewActivityOptions.Singleton)) then
    begin
      instIDParams := activity.OptionValue(TViewActivityOptions.InstanceIdentifiers);
      if instIDParams = '' then
      begin
        for I := 0 to activity.Params.Count - 1 do
          if I = 0 then
            instIDParams := activity.Params.ValueName(I)
          else
            instIDParams := instIDParams + ',' + activity.Params.ValueName(I);
      end;

      if instIDParams <> '' then
      begin
        lst := TStringList.Create;
        try
          ExtractStrings([','], [], PWideChar(instIDParams), lst);
          for I := 0 to lst.Count - 1 do
            Result := Result + VarToStr(Activity.Params[lst[I]]);
        finally
          lst.Free;
        end;
      end;
    end;

    Result := Activity.URI + '.' + Result;
  end;

var
  instWI: TWorkItem;
  inst: TCustomPresenter;
  instID: string;
begin

  instID := GetInstanceID;

  instWI := FindPresenterWI(instID);
  if not Assigned(instWI) then
  begin
    instWI := Sender.Root.WorkItems.Add(Self, instID);
    try
      inst := instWI.Controller as TCustomPresenter;
      inst.Init(Sender, Activity, AViewClass);
    except
      instWI.Free;
      raise;
    end;
  end
  else
  begin
    inst := instWI.Controller as TCustomPresenter;
    inst.ReInit(Activity);
  end;

  if not inst.ViewHidden then
    inst.ShowView;

  Activity.Outs.Assign(inst.WorkItem);

  if inst.ViewHidden and inst.FreeOnViewClose then
    inst.WorkItem.Free;
end;


class function TCustomPresenter.GetWorkspaceDefault: string;
begin
  Result := WS_CONTENT;
end;

function TCustomPresenter.GetViewURI: string;
begin
  Result := FViewURI;
end;

function TCustomPresenter.GetVisibleCaller: TWorkItem;
var
  I: integer;
begin
  for I := 0 to Workitem.CallStack.Count - 1 do
  begin
    Result := WorkItem.Root.WorkItems.Find(WorkItem.CallStack[I]);
    if Assigned(Result) and (Result.Controller is TCustomPresenter)
       and (Result.Controller as TCustomPresenter).ViewVisible then
      Exit;
  end;
  Result := nil;
end;

procedure TCustomPresenter.UpdateCommandStatus;
var
  extensions: TInterfaceList;
  I: integer;
begin
  OnUpdateCommandStatus;

  extensions := GetView.Extensions(IExtensionCommand);
  for I := 0 to extensions.Count - 1 do
    (extensions[I] as IExtensionCommand).CommandUpdate;

end;

procedure TCustomPresenter.OnUpdateCommandStatus;
begin

end;

procedure TCustomPresenter.SetCallerURI(const Value: string);
begin
  FCallerURI := Value;
end;

end.
