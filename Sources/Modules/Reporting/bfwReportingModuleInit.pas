unit bfwReportingModuleInit;

interface
uses classes, CoreClasses, ReportingController, frReportFactory, xlReportFactory,
  UIServiceIntf, ReportCatalogConst;

type
  TReportingModuleInit = class(TModule)
  public
    class function Kind: TModuleKind; override;
    procedure Load; override;
  end;

implementation
{$R Reporting.res}


{ TReportingModuleInit }

class function TReportingModuleInit.Kind: TModuleKind;
begin
  Result := mkFoundation;
end;

procedure TReportingModuleInit.Load;
begin
  Localization((WorkItem.Services[IUIService] as IUIService).Locale);

  WorkItem.WorkItems.Add(TReportingController);

  WorkItem.WorkItems.Add(TFastReportFactory);

  (WorkItem.Services[IReportCatalogService] as IReportCatalogService).
    RegisterLauncherFactory(TXLReportFactory.Create(Self));
end;


initialization
  RegisterModule(TReportingModuleInit);

end.
