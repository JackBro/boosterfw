unit ReportingController;

interface
uses classes, CoreClasses,  sysutils, variants, Contnrs,
  ShellIntf,
  CommonUtils, ConfigServiceIntf, graphics, UIClasses,
  EntityServiceIntf, UIServiceIntf,
  ReportCatalogConst, ReportCatalogClasses,
  ReportCatalogPresenter, ReportCatalogView,
  ReportLauncherPresenter, ReportLauncherView,
  ReportSetupPresenter, ReportSetupView, IOUtils;

const
  COMMAND_REPORT_CATALOG_RELOAD = '{04496C3E-9A87-40A5-84BD-CD6E409F4C13}';
  COMMAND_REPORT_CATALOG_DESIGN = '{C7D77C62-FDC2-4C68-BBE2-783FE93C447F}';
  COMMAND_DATA_REPORTID = 'ReportID';

  SETTING_REPORTS_LOCATION = 'Reports.Location';

type
  TReportingController = class(TWorkItemController, IReportCatalogService)
  private
    FActivityImage: TBitmap;
    FCatalogPath: string;
    FReportCatalog: TReportCatalog;
    FFactories: TComponentList;
    procedure LoadCatalogItems;
    procedure UnLoadCatalogItem(AItem: TReportCatalogItem);

    procedure RegisterSettings;
    procedure LoadActivityImage;

    procedure ReportProgressCallback(AProgressState: TReportProgressState);
  protected
    //
    function GetItem(const URI: string): TReportCatalogItem;
    procedure RegisterLauncherFactory(Factory: TComponent);
    procedure LaunchReport(Caller: TWorkItem; const AURI, ALayout: string;
      ALaunchMode: TReportLaunchMode);
    //
    procedure Initialize; override;
    procedure Terminate; override;
  type
    TReportLaunchHandler = class(TActivityHandler)
      procedure Execute(Sender: TWorkItem; Activity: IActivity); override;
    end;
  end;

implementation

{ TReportCatalogController }


procedure TReportingController.LaunchReport(Caller: TWorkItem;
  const AURI, ALayout: string; ALaunchMode: TReportLaunchMode);
var
  I: integer;
  Factory: IReportLauncherFactory;
  rLauncher: IReportLauncher;
  repItem: TReportCatalogItem;
  tmpl: string;
begin

  repItem := GetItem(AURI);

  tmpl := repItem.Path + repItem.Manifest.Layouts[ALayout].Template;

  rLauncher := nil;
  for I := 0 to FFactories.Count - 1 do
  begin
    FFactories[I].GetInterface(IReportLauncherFactory, Factory);
    rLauncher := Factory.GetLauncher(WorkItem, tmpl);
    if rLauncher <> nil then Break;
  end;

  if rLauncher = nil then
    raise Exception.Create('Report factory not found.');

  with rLauncher do
  begin
    Params.Clear;
    for I := 0 to repItem.Manifest.ParamNodes.Count - 1 do
      Params.Add(UpperCase(repItem.Manifest.ParamNodes[I].Name),
        Caller.State[repItem.Manifest.ParamNodes[I].Name]);

    Execute(Caller, ALaunchMode, repItem.Caption, ReportProgressCallback);
  end;
end;

function TReportingController.GetItem(
  const URI: string): TReportCatalogItem;
begin
  Result := FReportCatalog.GetItem(URI);
end;

procedure TReportingController.LoadActivityImage;
var
  ImgRes: TResourceStream;
begin
  ImgRes := TResourceStream.Create(HInstance, 'REPORT_NAVBAR_IMAGE', 'file');
  try
    FActivityImage.LoadFromStream(ImgRes);
  finally
    ImgRes.Free;
  end;
end;


procedure TReportingController.LoadCatalogItems;

  procedure LoadItem(AItem: TReportCatalogItem);
  var
    I: integer;
  begin

    with WorkItem.Activities[AItem.ID] do
    begin
      Title := AItem.Caption;
      if not AItem.IsTop then
        MenuIndex := -1;
      RegisterHandler(TReportLaunchHandler.Create);

      Group := AItem.Group.Caption;
      Image := FActivityImage;
      UsePermission := true;

      for I := 0 to  AItem.Manifest.ParamNodes.Count - 1 do
        Params.Value[AItem.Manifest.ParamNodes[I].Name] := Unassigned;
    end;
  end;

var
  I, Y: integer;
begin

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
      LoadItem(FReportCatalog.Groups[I].Items[Y]);
end;

procedure TReportingController.Initialize;
begin
  FFactories := TComponentList.Create(false);

  WorkItem.Services.Add(Self as IReportCatalogService);

  FActivityImage := TBitmap.Create;
  LoadActivityImage;

  RegisterSettings;

  FReportCatalog := TReportCatalog.Create(Self);

  FCatalogPath := App.Settings[SETTING_REPORTS_LOCATION];

  with  WorkItem.Activities[VIEW_RPT_CATALOG] do
  begin
    Title := VIEW_RPT_CATALOG_CAPTION;
    Group := MENU_GROUP_SERVICE;
    UsePermission := true;
    RegisterHandler(TViewActivityHandler.Create(TReportCatalogPresenter, TfrReportCatalogView));
  end;

  WorkItem.Activities[TReportLauncherPresenter.ACTIVITY_REPORT_LAUNCHER].
    RegisterHandler(TViewActivityHandler.Create(TReportLauncherPresenter, TfrReportLauncherView));

  LoadCatalogItems;

end;

procedure TReportingController.RegisterLauncherFactory(Factory: TComponent);
var
  Intf: IReportLauncherFactory;
begin
  if not Factory.GetInterface(IReportLauncherFactory, Intf) then
    raise Exception.Create('Bad report factory');

  FFactories.Add(Factory);
end;

procedure TReportingController.RegisterSettings;
begin
  with App.Settings.Add(SETTING_REPORTS_LOCATION) do
  begin
    Category := '������';
    Caption := '����';
    DefaultValue := '%ROOTDIR%\Reports\';
    //StorageLevels := StorageLevels - [slUserProfile, slHostProfile];
  end;
end;

procedure TReportingController.ReportProgressCallback(
  AProgressState: TReportProgressState);
begin
  case AProgressState of
    rpsStart: WorkItem.EventTopics[ET_WAITBOX_START].Fire;
    rpsFinish: WorkItem.EventTopics[ET_WAITBOX_STOP].Fire;
    rpsProcess: WorkItem.EventTopics[ET_WAITBOX_UPDATE].Fire;
  end;
end;

procedure TReportingController.Terminate;
begin
  WorkItem.Services.Remove(Self as IReportCatalogService);
end;

procedure TReportingController.UnLoadCatalogItem(
  AItem: TReportCatalogItem);
begin
end;


{ TReportingController.TReportActivityHandler }

procedure TReportingController.TReportLaunchHandler.Execute(Sender: TWorkItem;
  Activity: IActivity);
var
  I: integer;
begin

  with Sender.Activities[TReportLauncherPresenter.ACTIVITY_REPORT_LAUNCHER] do
  begin
    Params[TViewActivityParams.PresenterID] := Activity.URI + Sender.ID;
    Params[TReportLaunchParams.ReportURI] := Activity.URI;
    Params[TReportLaunchParams.InitLayout] :=
      Activity.Params[TReportActivityParams.Layout];
    Params[TReportLaunchParams.LaunchMode] :=
      Activity.Params[TReportActivityParams.LaunchMode];

    for I := 0 to  Activity.Params.Count - 1 do
      Params[TReportLauncherPresenter.PARAM_PREFIX + Activity.Params.ValueName(I)] :=
        Activity.Params[Activity.Params.ValueName(I)];


    Execute(Sender);
  end;
end;


end.
