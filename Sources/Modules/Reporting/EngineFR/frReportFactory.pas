unit frReportFactory;

interface
uses windows, classes, CoreClasses, ReportCatalogConst, EntityServiceIntf,
  SysUtils, db, ibdatabase,  ComObj, controls,
  frxClass, frxExportXML, frxExportXLS, frxExportCSV, frxIBXComponents, frxDesgn,
  frxChBox, frxCross, frxBarCode, frxDCtrl, variants,
  frReportPreviewPresenter, frReportPreviewView, UIClasses,
  Generics.Collections;

const
  VIEW_FASTREPORT_PREVIEW = 'views.reports.fastreport.preview';

type

  TFastReportLauncher = class(TComponent, IReportLauncher)
  private
    FWorkItem: TWorkItem;
    FIBXComponents: TfrxIBXComponents;
    FReport: TfrxReport;
    FXLSExportFilter: TfrxXLSExport;
    FCSVExportFilter: TfrxCSVExport;
    FCallerWI: TWorkItem;
    FProgressCallback: TReportProgressCallback;
    FTemplate: string;
    FParams: TDictionary<string, variant>;
    function GetReportFileName: string;
    procedure OnAfterPrintReport(Sender: TObject);
    procedure OnReportGetValue(const VarName: String; var Value: Variant);
    procedure OnBeforePrintReport(Sender: TfrxReportComponent);
    procedure EndHandler(Sender: TObject);
    procedure DoReportProgressStart(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure DoReportProgress(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    procedure DoReportProgressStop(Sender: TfrxReport;
      ProgressType: TfrxProgressType; Progress: Integer);
    function IsControlKeyDown: boolean;
    procedure Preview(const ATitle: string);
  protected
    //IReportLauncher
    function Params: TDictionary<string, variant>;
    procedure Execute(Caller: TWorkItem; ALaunchMode: TReportLaunchMode;
      const ATitle: string; ProgressCallback: TReportProgressCallback);
    procedure Design(Caller: TWorkItem);
  public
    constructor Create(AOwner: TComponent;
      AConnection: IEntityStorageConnection; AWorkItem: TWorkItem); reintroduce;
    destructor Destroy; override;
    property Template: string read FTemplate write FTemplate;
  end;

  TFastReportFactory = class(TWorkItemController, IReportLauncherFactory)
  private
    FWorkItem: TWorkItem;
    FLauncher: TFastReportLauncher;
  protected
    //IReportFactory
    function GetLauncher(AWorkItem: TWorkItem; const ATemplate: string): IReportLauncher;
  public
    constructor Create(AOwner: TWorkItem); override;
  end;


implementation

{ TFastReportFactory }

constructor TFastReportFactory.Create(AOwner: TWorkItem);
begin
  inherited;
  FWorkItem := AOwner;
 // (WorkItem.Services[IReportService] as IReportService).RegisterLauncherFactory(Self);

  (WorkItem.Services[IReportCatalogService] as IReportCatalogService).
    RegisterLauncherFactory(Self);

  WorkItem.Activities[VIEW_FR_PREVIEW].
    RegisterHandler(TViewActivityHandler.Create(TfrReportPreviewPresenter, TfrfrReportPreviewView));

end;

function TFastReportFactory.GetLauncher(AWorkItem: TWorkItem;
  const ATemplate: string): IReportLauncher;
begin
  Result := nil;
  if ExtractFileExt(ATemplate) = '.fr3' then
  begin
    if not Assigned(FLauncher) then
      FLauncher := TFastReportLauncher.Create(Self,
       (AWorkItem.Services[IEntityService] as IEntityService).Connections.GetDefault,
       FWorkItem);

    FLauncher.Template := ATemplate;
    Result := FLauncher;
  end;
end;

{ TFastReportLauncher }

constructor TFastReportLauncher.Create(AOwner: TComponent;
  AConnection: IEntityStorageConnection; AWorkItem: TWorkItem);
begin
  inherited Create(AOwner);
  FWorkItem := AWorkItem;
  FParams := TDictionary<string, variant>.Create;
  FReport := TfrxReport.Create(Self);
  FReport.OnGetValue := OnReportGetValue;
  FReport.OnProgress := DoReportProgress;
  FReport.OnProgressStart := DoReportProgressStart;
  FReport.OnProgressStop := DoReportProgressStop;
  FReport.OnEndDoc := EndHandler;
  FReport.OnBeforePrint := OnBeforePrintReport;
//  FReport.OldStyleProgress := true;
  FReport.OnAfterPrintReport := OnAfterPrintReport;
  FIBXComponents := TfrxIBXComponents.Create(Self);
  FIBXComponents.DefaultDatabase := TIBDataBase(AConnection.GetStubConnectionComponent);
  FXLSExportFilter := TfrxXLSExport.Create(Self);
  FCSVExportFilter := TfrxCSVExport.Create(Self);
end;

procedure TFastReportLauncher.Design(Caller: TWorkItem);
begin
  FCallerWI := Caller;
  FReport.LoadFromFile(GetReportFileName);
  FReport.DesignReport();
end;

destructor TFastReportLauncher.Destroy;
begin
  FParams.Free;
  inherited;
end;

procedure TFastReportLauncher.DoReportProgress(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FProgressCallback) then
    FProgressCallback(rpsProcess);
end;

procedure TFastReportLauncher.DoReportProgressStart(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FProgressCallback) then
    FProgressCallback(rpsStart);
end;

procedure TFastReportLauncher.DoReportProgressStop(Sender: TfrxReport;
  ProgressType: TfrxProgressType; Progress: Integer);
begin
  if Assigned(FProgressCallback) then
    FProgressCallback(rpsFinish);
end;

procedure TFastReportLauncher.EndHandler(Sender: TObject);
begin
  if FIBXComponents.DefaultDatabase.DefaultTransaction.InTransaction then
    FIBXComponents.DefaultDatabase.DefaultTransaction.Commit;
end;

procedure TFastReportLauncher.Execute(Caller: TWorkItem; ALaunchMode: TReportLaunchMode;
   const ATitle: string; ProgressCallback: TReportProgressCallback);
begin
  FCallerWI := Caller;
  if IsControlKeyDown then
  begin
    Design(FCallerWI);
    Exit;
  end;

  FProgressCallback := ProgressCallback;
  try
    FReport.LoadFromFile(GetReportFileName);
    FReport.ReportOptions.Name := ChangeFileExt(ExtractFileName(GetReportFileName), '');
    if FIBXComponents.DefaultDatabase.DefaultTransaction.InTransaction then
      FIBXComponents.DefaultDatabase.DefaultTransaction.Commit;

    try
      FReport.PrepareReport(false);
    finally
      if FIBXComponents.DefaultDatabase.DefaultTransaction.InTransaction then
        FIBXComponents.DefaultDatabase.DefaultTransaction.Commit;
    end;

    if ALaunchMode <> lmHold then
    begin
      Preview(ATitle);
      FReport.PreviewPages.Clear;
    end;

  finally
    FProgressCallback := nil;
  end;
end;

function TFastReportLauncher.GetReportFileName: string;
begin
  Result := FTemplate;
end;

function TFastReportLauncher.IsControlKeyDown: boolean;
begin
  result:=(Word(GetKeyState(VK_CONTROL)) and $8000)<>0;
end;

procedure TFastReportLauncher.OnAfterPrintReport(Sender: TObject);
begin
  if Assigned(FReport.PreviewForm) then
    FReport.PreviewForm.Caption := '����� ���������';
end;

procedure TFastReportLauncher.OnBeforePrintReport(Sender: TfrxReportComponent);
begin
  if (Sender is TfrxView) then
  begin
    if ((Sender as TfrxView).TagStr <> '') then
      (Sender as TfrxView).Cursor := crHandPoint
    else
      (Sender as TfrxView).Cursor := crDefault;
  end;
end;

procedure TFastReportLauncher.OnReportGetValue(const VarName: String;
  var Value: Variant);
var
  val: variant;
begin
  if VarIsEmpty(Value) and FParams.TryGetValue(UpperCase(VarName), val) then
    Value := val;
end;


function TFastReportLauncher.Params: TDictionary<string, variant>;
begin
  Result := FParams;
end;

procedure TFastReportLauncher.Preview(const ATitle: string);
var
 stream: TMemoryStream;
begin
  stream := TMemoryStream.Create;
  try
    FReport.PreviewPages.SaveToStream(stream);
    with FWorkItem.Activities[VIEW_FR_PREVIEW] do
    begin
      Params[TViewActivityParams.PresenterID] := CreateClassID;
      Params[TViewActivityParams.Title] := ATitle;
      Params['DATA'] := integer(stream);
      Execute(FCallerWI);
    end;
  finally
    stream.Free
  end;

end;


end.
