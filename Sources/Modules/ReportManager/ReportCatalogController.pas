unit ReportCatalogController;

interface
uses classes, CoreClasses, CustomUIController, sysutils,
  ShellIntf, ReportServiceIntf, ViewServiceIntf, ActivityServiceIntf,
  CommonUtils, ConfigServiceIntf,
  ReportCatalogConst, ReportCatalogClasses,
  ReportCatalogPresenter, ReportCatalogView,
  ReportLauncherPresenter, ReportLauncherView,
  ReportSetupPresenter, ReportSetupView;

const
  COMMAND_REPORT_CATALOG_RELOAD = '{04496C3E-9A87-40A5-84BD-CD6E409F4C13}';
  COMMAND_REPORT_CATALOG_DESIGN = '{C7D77C62-FDC2-4C68-BBE2-783FE93C447F}';
  COMMAND_DATA_REPORTID = 'ReportID';

  SETTING_REPORTS_LOCATION = 'Reports.Location';

type

  TReportCatalogController = class(TCustomUIController, IReportCatalogService)
  private
    FCatalogPath: string;
    FReportCatalog: TReportCatalog;
    FReportService: IReportService;
    FActivitySvc: IActivityManagerService;
    procedure LoadCatalogItems;
    procedure LoadCatalogItem(AItem: TReportCatalogItem);
    procedure UnLoadCatalogItem(AItem: TReportCatalogItem);

    procedure ActionReportCatalogReload(Sender: IAction);
    procedure ActionReportLaunch(Sender: IAction);
    procedure CmdReportLaunch(Sender: TObject);
    procedure CmdReportInfo(Sender: TObject);
    procedure CmdReportSetup(Sender: TObject);
    procedure RegisterSettings;
  protected
   function GetItem(const URI: string): TReportCatalogItem;
    procedure OnInitialize; override;
    procedure Terminate; override;
  end;

implementation

{ TReportCatalogController }

procedure TReportCatalogController.ActionReportCatalogReload(
  Sender: IAction);
begin
  LoadCatalogItems;
end;

procedure TReportCatalogController.ActionReportLaunch(Sender: IAction);
var
  action: IAction;
  launcherData: TReportLauncherPresenterData;
  launchData: TReportLaunchData;
begin
  launchData := Sender.Data as TReportLaunchData;
  App.Security.DemandPermission(SECURITY_PERMISSION_REPORT_EXECUTE, launchData.ReportURI);

  action := WorkItem.Actions[VIEW_REPORT_LAUNCHER];
  action.ResetData;
  launcherData := action.Data as TReportLauncherPresenterData;
  launcherData.PresenterID := launchData.ReportURI + Sender.Caller.ID;
  launcherData.ReportURI := launchData.ReportURI;
  launcherData.ImmediateRun := launchData.ImmediateRun;
  launcherData.AssignLaunchData(launchData);
  action.Execute(Sender.Caller);
end;

procedure TReportCatalogController.CmdReportInfo(Sender: TObject);
var
  Intf: ICommand;
  ItemID: string;
  rcItem: TReportCatalogItem;
begin
  Sender.GetInterface(ICommand, Intf);
  ItemID := Intf.Data[COMMAND_DATA_REPORTID];
  rcItem := FReportCatalog.GetItem(ItemID);

  if rcItem.LoadErrorCode = 0 then
    App.Views.MessageBox.InfoMessage(rcItem.ID + #10#13 + rcItem.Manifest.Description)
  else
    App.Views.MessageBox.ErrorMessage(rcItem.ID + #10#13 + rcItem.LoadErrorInfo);

end;

procedure TReportCatalogController.CmdReportLaunch(Sender: TObject);
var
  Intf: ICommand;
  _ReportID: string;
begin
  Sender.GetInterface(ICommand, Intf);
  _ReportID := Intf.Name;
  Intf := nil;
  WorkItem.Actions[_ReportID].Execute(WorkItem);
end;

procedure TReportCatalogController.CmdReportSetup(Sender: TObject);
var
  Intf: ICommand;
  _ReportID: string;
  action: IAction;
begin
  Sender.GetInterface(ICommand, Intf);
  _ReportID := Intf.Data[COMMAND_DATA_REPORTID];
  Intf := nil;

  App.Security.DemandPermission(SECURITY_PERMISSION_REPORT_SETUP, _ReportID);

  action := WorkItem.Actions[VIEW_RPT_ITEM_SETUP];
  (action.Data as TReportSetupPresenterData).ReportID := _ReportID;
  action.Execute(WorkItem);

end;

function TReportCatalogController.GetItem(
  const URI: string): TReportCatalogItem;
begin
  Result := FReportCatalog.GetItem(URI);
end;

procedure TReportCatalogController.LoadCatalogItem(
  AItem: TReportCatalogItem);
var
  reportItem: IReport;
  I: integer;

  activityItem: IActivity;
  activityItemChild: IActivity;
begin

  reportItem := FReportService.Add(AItem.ID);
  reportItem.Template := AItem.Path + AItem.Manifest.Template;
  reportItem.Group  := AItem.Group.Caption;
  reportItem.Caption := AItem.Caption;

  WorkItem.Root.Actions[AItem.ID].SetHandler(ActionReportLaunch);
  WorkItem.Root.Actions[AItem.ID].SetDataClass(TReportLaunchData);

  //Layouts
  for I := 0 to AItem.Manifest.Layouts.Count - 1 do
    FReportService.Add(AItem.Manifest.Layouts[I].ID).Template :=
      AItem.Manifest.Layouts[I].Template;

  if not AItem.IsTop then Exit;

  activityItem := FActivitySvc.Items.Add(AItem.ID, false);
  activityItem.Data[COMMAND_DATA_REPORTID] := AItem.ID;
  activityItem.Caption := AItem.Caption;
  activityItem.Category := ACT_CTG_REPORTS;
  activityItem.Group := AItem.Group.Caption;

  activityItem.SetCustomPermissionOptions(
    AItem.ID, SECURITY_PERMISSION_REPORT_EXECUTE);
  activityItem.SetHandler(CmdReportLaunch);


  {Subitems}

  for I := 0 to AItem.Manifest.ExtendCommands.Count - 1 do
  begin
    activityItemChild := activityItem.Items.
      Add(AItem.Manifest.ExtendCommands.ValueFromIndex[I]);
    activityItemChild.Caption := AItem.Manifest.ExtendCommands.Names[I];
    activityItemChild.Data[COMMAND_DATA_REPORTID] := AItem.ID;
  end;

  activityItemChild := activityItem.Items.Add('ReportInfo_' + AItem.ID, false);
  activityItemChild.Data[COMMAND_DATA_REPORTID] := AItem.ID;
  activityItemChild.Caption := '�������� ������';
  activityItemChild.Section := 99;
  activityItemChild.SetHandler(CmdReportInfo);

  activityItemChild := activityItem.Items.Add('ReportSetup_' + AItem.ID, false);
  activityItemChild.Data[COMMAND_DATA_REPORTID] := AItem.ID;
  activityItemChild.Caption := '��������� ������';
  activityItemChild.Section := 99;
  activityItemChild.SetCustomPermissionOptions(
    AItem.ID, SECURITY_PERMISSION_REPORT_SETUP);
  activityItemChild.SetHandler(CmdReportSetup);

end;

procedure TReportCatalogController.LoadCatalogItems;
var
  I, Y: integer;
begin

  {Clear Report&NavBar Items}
{  for I := WorkItem.WorkItems.Count - 1 downto 0 do
    if Assigned(WorkItem.WorkItems[I].Controller) and
       (WorkItem.WorkItems[I].Controller is TReportLauncherPresenter) then
       TReportLauncherPresenter(WorkItem.WorkItems[I].Controller).CloseView;}

  for I := WorkItem.WorkItems.Count - 1 downto 0 do
    if Assigned(WorkItem.WorkItems[I].Controller) and
       (WorkItem.WorkItems[I].Controller is TReportLauncherPresenter) then
       WorkItem.WorkItems[I].Free;

  for I := 0 to FReportCatalog.Groups.Count - 1 do
    for Y := 0 to FReportCatalog.Groups[I].Items.Count - 1 do
      UnLoadCatalogItem(FReportCatalog.Groups[I].Items[Y]);

  FReportCatalog.Open(FCatalogPath);

  {Add Report&NavBar Items}
  for I := 0 to FReportCatalog.Groups.Count - 1 do
    for Y := 0 to FReportCatalog.Groups[I].Items.Count - 1 do
      LoadCatalogItem(FReportCatalog.Groups[I].Items[Y]);
end;

procedure TReportCatalogController.OnInitialize;
begin
  WorkItem.Root.Services.Add(Self as IReportCatalogService);

  RegisterSettings;
  FReportService := IReportService(WorkItem.Services[IReportService]);
  FActivitySvc := IActivityManagerService(WorkItem.Services[IActivityManagerService]);
  FReportCatalog := TReportCatalog.Create(Self);

  FCatalogPath := App.Settings[SETTING_REPORTS_LOCATION];

  RegisterActivity(VIEW_RPT_CATALOG, MAIN_MENU_CATEGORY, MAIN_MENU_SERVICE_GROUP,
    VIEW_RPT_CATALOG_CAPTION, TReportCatalogPresenter, TfrReportCatalogView);

  RegisterActivity(COMMAND_REPORT_CATALOG_RELOAD, MAIN_MENU_CATEGORY, MAIN_MENU_SERVICE_GROUP,
    '�������� ������ �������', ActionReportCatalogReload, false);

  RegisterView(VIEW_REPORT_LAUNCHER, TReportLauncherPresenter, TfrReportLauncherView);

  RegisterView(VIEW_RPT_ITEM_SETUP, TReportSetupPresenter, TfrReportSetupView);

  LoadCatalogItems;

end;

procedure TReportCatalogController.RegisterSettings;
begin
  with App.Settings.Add(SETTING_REPORTS_LOCATION) do
  begin
    Category := '������';
    Caption := '����';
    DefaultValue := '%ROOTDIR%\Reports\';
    //StorageLevels := StorageLevels - [slUserProfile, slHostProfile];
  end;
end;

procedure TReportCatalogController.Terminate;
begin
  WorkItem.Root.Services.Remove(Self as IReportCatalogService);
end;

procedure TReportCatalogController.UnLoadCatalogItem(
  AItem: TReportCatalogItem);
begin
  FReportService.Remove(AItem.ID);
  FActivitySvc.Items.Remove(AItem.ID);
end;


end.
