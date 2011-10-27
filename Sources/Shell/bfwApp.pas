unit bfwApp;

interface

uses windows, classes, forms, sysutils,
  AbstractApp, CoreClasses, ShellIntf,
  ShellLogin, ShellLock, ShellSplashForm,
  ConfigServiceIntf, ConfigService,
  NavBarServiceIntf, NavBarService,
  SecurityIntf, SecurityService,
  EntityServiceIntf, EntityManagerService,
  ReportServiceIntf, ReportService,
  UIServiceIntf, UIService,
  ViewServiceIntf, ViewManagerService,
  ActivityServiceIntf, ActivityService;

const
  APP_VERSION = 'ver 1.0';

type
  TRootWorkItem = class(TWorkItem)
  protected
    //function OnGetApplication: IInterface; override;
  end;

  TApp = class(TAbstractApplication, IApp)
  private
    FSplash: TShellSplash;
    FShell: TForm;
    FEntityManager: TEntityManagerService;
    FSecurity: TSecurityService;
    procedure AppLockHandler(Sender: IAction);
    procedure SplashShow;
    procedure SplashHide;
    procedure SplashUpdate;
  protected
    function GetWorkItemClass: TWorkItemClass; override;
    procedure AddServices; override;
    procedure Start; override;
    procedure ShellInitialization; override;
    procedure OnLoadModule(const AModuleName, AInfo: string; Kind: TModuleKind); override;
    //IApp
    function Version: string;
    function Settings: ISettings;
    function UserProfile: IProfile;
    function HostProfile: IProfile;
    function UI: IUIService;
    function Views: IViewManagerService;
    function Entities: IEntityManagerService;
    function Reports: IReportService;
    function Security: ISecurityService;
    function Activities: IActivityService;
    function ContentWorkspace: IWorkspace;
    function DialogWorkspace: IWorkspace;
    function WorkItem: TWorkItem;
  public
    class procedure ShellInstantiate;
  end;

procedure ShellApplicationInitialization;
exports
  ShellApplicationInitialization;

implementation

var
  AppInstance: TApp;

function GetAppInstance: IApp;
begin
  Result := AppInstance;
end;

procedure ShellApplicationInitialization;
begin
  GetIApp := @GetAppInstance;
  AppInstance := TApp.Create(nil);
  AppInstance.Run;
end;

{ TApp }

procedure TApp.AddServices;
var
  Intf: IInterface;
begin

  RootWorkItem.Services.Add(IConfigurationService(TConfigurationService.Create(Self, RootWorkItem)));

  //UI
  RootWorkItem.Services.Add(
    TUIService.Create(Self, RootWorkItem) as IUIService);

  //Views
  RootWorkItem.Services.Add(
    IViewManagerService(TViewManagerService.Create(Self, RootWorkItem)));

  {Security}
  FSecurity := TSecurityService.Create(Self, RootWorkItem);
  RootWorkItem.Services.Add(ISecurityService(FSecurity));
  RootWorkItem.Services.Add(IAuthenticationService(FSecurity));


  Intf := ILoginUserSelectorService(TLoginUserSelectorService.Create(Self, RootWorkItem));
  RootWorkItem.Services.Add(ILoginUserSelectorService(Intf));

  {DAL}
  FEntityManager := TEntityManagerService.Create(Self, RootWorkItem);
  RootWorkItem.Services.Add(IEntityManagerService(FEntityManager));

  //Activity
  RootWorkItem.Services.Add(
    IActivityService(TActivityService.Create(Self, RootWorkItem)));

  //Reports
  RootWorkItem.Services.Add(
    IReportService(TReportService.Create(Self,
      IEntityManagerService(FEntityManager), RootWorkItem)));

  RootWorkItem.Services.Add(
    INavBarService(TNavBarService.Create(Self, RootWorkItem)));

  RootWorkItem.Actions[COMMAND_LOCK_APP].SetHandler(AppLockHandler);
end;


procedure TApp.AppLockHandler(Sender: IAction);
begin
  ShellLock.DoShellLock;
end;

function TApp.Settings: ISettings;
begin
  Result := IConfigurationService(RootWorkItem.
    Services[IConfigurationService]).Settings;
end;

procedure TApp.ShellInitialization;
begin
  Application.Initialize;

  if Settings['Application.Title'] <> '' then
    Application.Title := Settings['Application.Title'];

  if Settings.CurrentAlias <> '' then
    Application.Title := Application.Title + ' <' +
      Settings.CurrentAlias  + '>';

  if not Assigned(ShellIntf.ShellFormClass) then
    raise Exception.Create('MainForm class not setting');

  Application.CreateForm(ShellIntf.ShellFormClass, FShell);

  SplashShow;

  TCustomShellForm(FShell).Initialize(RootWorkItem);

end;

class procedure TApp.ShellInstantiate;
begin
  GetIApp := @GetAppInstance;
  AppInstance := Self.Create(nil);
  AppInstance.Run;
end;

procedure TApp.Start;
begin
  SplashHide;
  Application.Run;
end;

function TApp.UI: IUIService;
begin
  Result := RootWorkItem.Services[IUIService] as IUIService;
end;

function TApp.UserProfile: IProfile;
begin
  Result := IConfigurationService(RootWorkItem.
    Services[IConfigurationService]).UserProfile;
end;

function TApp.HostProfile: IProfile;
begin
  Result := IConfigurationService(RootWorkItem.
    Services[IConfigurationService]).HostProfile;
end;


function TApp.GetWorkItemClass: TWorkItemClass;
begin
  Result := TRootWorkItem;
end;

function TApp.Entities: IEntityManagerService;
begin
  Result := IEntityManagerService(RootWorkItem.Services[IEntityManagerService]);
end;


function TApp.Reports: IReportService;
begin
  Result := IReportService(RootWorkItem.Services[IReportService]);
end;


function TApp.Security: ISecurityService;
begin
  Result := ISecurityService(RootWorkItem.Services[ISecurityService]);
end;

function TApp.ContentWorkspace: IWorkspace;
begin
  Result := RootWorkItem.Workspaces[WS_CONTENT];
end;

function TApp.DialogWorkspace: IWorkspace;
begin
  Result := RootWorkItem.Workspaces[WS_DIALOG];
end;

function TApp.Activities: IActivityService;
begin
  Result := RootWorkItem.Services[IActivityService] as IActivityService;
end;


{ TRootWorkItem }

{function TRootWorkItem.OnGetApplication: IInterface;
begin
  Result := IApp(AppInstance);
end;}


function TApp.Views: IViewManagerService;
begin
  Result := IViewManagerService(RootWorkItem.Services[IViewManagerService]);
end;

function TApp.Version: string;
var
  exeDate: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  exeDate := FileDateToDateTime(FileAge(Application.ExeName));
  DecodeDate(exeDate, Year, Month, Day);
  DecodeTime(exeDate, Hour, Min, Sec, MSec);
  Result := format('%d.%d.%d.%d.%d', [Year, Month, Day, Hour, Min]);
  Result := APP_VERSION + ' [' + Result + ']';
end;

procedure TApp.OnLoadModule(const AModuleName, AInfo: string; Kind: TModuleKind);
begin
  SplashUpdate;
end;

procedure TApp.SplashHide;
begin
  if Assigned(FSplash) then FSplash.Hide;
end;

procedure TApp.SplashShow;
begin
 // FSplash := TShellSplash.Create;
//  FSplash.Show('', 100);
end;

procedure TApp.SplashUpdate;
begin
  if Assigned(FSplash) then FSplash.Update('');
end;

function TApp.WorkItem: TWorkItem;
begin
  Result := GetRootWorkItem;
end;


end.