unit EntityItemExtView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomView, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ActnList, cxGroupBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSplitter, cxInplaceContainer, cxVGrid, cxDBVGrid,
  EntityItemExtPresenter, UIClasses, Menus, cxLabel, cxDBLabel, cxTextEdit,
  StdCtrls, cxButtons;

type
  TfrEntityItemExtView = class(TfrCustomView, IEntityItemExtView)
    HeadDataSource: TDataSource;
    cxGridViewRepository: TcxGridViewRepository;
    cxGridViewRepositoryDBTableView: TcxGridDBTableView;
    cxGroupBox1: TcxGroupBox;
    grHeader: TcxDBVerticalGrid;
    cxSplitter1: TcxSplitter;
    grDetails: TcxGrid;
    pnPick: TcxGroupBox;
    PickPanelSplitter: TcxSplitter;
    pnPickCommands: TcxGroupBox;
    btPickItemAdd: TcxButton;
    pnPickSearch: TcxGroupBox;
    edPickSearch: TcxTextEdit;
    btPickPanelHide: TcxButton;
    gridPickList: TcxGrid;
    grPickList: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    grPickItem: TcxDBVerticalGrid;
    PickListDataSource: TDataSource;
    PickItemDataSource: TDataSource;
    procedure grDetailsActiveTabChanged(Sender: TcxCustomGrid;
      ALevel: TcxGridLevel);
    procedure cxGridViewRepositoryDBTableViewCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridViewRepositoryDBTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxGridViewRepositoryDBTableViewSelectionChanged(
      Sender: TcxCustomGridTableView);
    procedure edPickSearchPropertiesEditValueChanged(Sender: TObject);
    procedure edPickSearchPropertiesChange(Sender: TObject);
    procedure grPickListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edPickSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grPickListCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grPickItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FDetails: TStringList;
    FPickPanelPreferenceLoaded: boolean;
  protected
    procedure LinkHeadData(AData: TDataSet);
    procedure LinkDetailData(const AName, ACaption: string; AData: TDataSet);
    function GetActiveDetailData: string;
    procedure LinkPickListData(AData: TDataSet);
    procedure LinkPickItemData(AData: TDataSet);
    //
    procedure ShowPickPanel;
    procedure HidePickPanel;
    procedure ShowPickItemPanel;
    procedure HidePickItemPanel;
    procedure SetPickBulkMode;
    function GetPickSeartText: string;
    function PickListSelection: ISelection;
    //
    procedure Initialize; override;
  public
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TfrEntityItemExtView }

procedure TfrEntityItemExtView.cxGridViewRepositoryDBTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[ON_DETAIL_DBLCLICK].Execute;

end;

procedure TfrEntityItemExtView.cxGridViewRepositoryDBTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  WorkItem.Commands[COMMAND_UPDATE_COMMAND_STATUS].Execute;
end;

procedure TfrEntityItemExtView.cxGridViewRepositoryDBTableViewSelectionChanged(
  Sender: TcxCustomGridTableView);
begin
  WorkItem.Commands[COMMAND_UPDATE_COMMAND_STATUS].Execute;
end;

destructor TfrEntityItemExtView.Destroy;
begin
  if PickPanelSplitter.Visible then
    SetPreferenceValue('PickPanel.Width', IntToStr(pnPick.Width));
  FDetails.Free;
  inherited;
end;

procedure TfrEntityItemExtView.edPickSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (not edPickSearch.ModifiedAfterEnter) and (Key = VK_RETURN) then
  begin
     if grPickList.DataController.RowCount <> 0 then
       gridPickList.SetFocus;
  end;
end;

procedure TfrEntityItemExtView.edPickSearchPropertiesChange(Sender: TObject);
begin
  edPickSearch.Style.Color := clInfoBk;
end;

procedure TfrEntityItemExtView.edPickSearchPropertiesEditValueChanged(
  Sender: TObject);
begin
  edPickSearch.Style.Color := clWindow;
  WorkItem.Commands[COMMAND_PICK_SEARCH].Execute;
  if grPickList.DataController.RowCount <> 0 then
    gridPickList.SetFocus;
end;

function TfrEntityItemExtView.GetActiveDetailData: string;
begin
  if grDetails.ActiveLevel <> nil then
    Result := FDetails[grDetails.ActiveLevel.Index]
  else
    Result := '';
end;


function TfrEntityItemExtView.GetPickSeartText: string;
begin
  Result := edPickSearch.Text;
end;

procedure TfrEntityItemExtView.LinkDetailData(const AName, ACaption: string;
  AData: TDataSet);

  function MakeValidViewName(const AName: string): string;
  const
    Alpha = ['A'..'Z', 'a'..'z', '_'];
    AlphaNumeric = Alpha + ['0'..'9'];
  var
    I: Integer;
  begin
    Result := AName;
    for I := 1 to Length(Result) do
      if not CharInSet(Result[I], AlphaNumeric) then
        Result[I] := '_';
  end;
var
  dataSource: TDataSource;
  level: TcxGridLevel;
  view: TcxGridDBTableView;
begin
  dataSource := TDataSource.Create(Self);
  level := grDetails.Levels.Add;

  level.Caption := ACaption;
  if level.Caption <> '' then
    grDetails.RootLevelOptions.DetailTabsPosition := dtpTop;

  view := TcxGridDBTableView(grDetails.CreateView(TcxGridDBTableView));
  view.Name := MakeValidViewName('grDetails' + AName);
  view.AssignSettings(cxGridViewRepositoryDBTableView); //grDetails.Views[0]);
  view.DataController.DataSource := dataSource;
  view.DataController.Options :=
    view.DataController.Options + [dcoImmediatePost];
  level.GridView := view;
  FDetails.Add(AName);
  LinkDataSet(dataSource, AData);
end;

procedure TfrEntityItemExtView.LinkHeadData(AData: TDataSet);
begin
  LinkDataSet(HeadDataSource, AData);
end;

procedure TfrEntityItemExtView.LinkPickItemData(AData: TDataSet);
var
  I: integer;
begin
  if AData = nil then
    UnLinkDataSet(PickItemDataSource)
  else if PickItemDataSource.DataSet <> AData then
    LinkDataSet(PickItemDataSource, AData);

  if AData <> nil then
    for I := 0 to AData.FieldCount - 1 do
      AData.Fields[I].Alignment := taLeftJustify;
end;

procedure TfrEntityItemExtView.LinkPickListData(AData: TDataSet);
begin
  if PickListDataSource.DataSet <> AData then
    LinkDataSet(PickListDataSource, AData);
end;

function TfrEntityItemExtView.PickListSelection: ISelection;
begin
  Result := GetChildInterface(grPickList.Name) as ISelection;
end;

procedure TfrEntityItemExtView.SetPickBulkMode;
begin
  grPickList.OptionsSelection.MultiSelect := true;
end;

procedure TfrEntityItemExtView.ShowPickItemPanel;
begin
  grPickItem.Visible := true;
  grPickItem.SetFocus;
end;

procedure TfrEntityItemExtView.ShowPickPanel;
var
  widthPickPanel: integer;
begin
  PickPanelSplitter.Visible := true;
  PickPanelSplitter.OpenSplitter;
  edPickSearch.SetFocus;

  if not FPickPanelPreferenceLoaded then
  begin
    widthPickPanel := StrToIntDef(GetPreferenceValue('PickPanel.Width'), 0);
    if (widthPickPanel = 0) or (ViewControl.Width <= widthPickPanel) then
      widthPickPanel := ViewControl.Width div 3;
    pnPick.Width := widthPickPanel;
    FPickPanelPreferenceLoaded := true;
  end;
end;

procedure TfrEntityItemExtView.Initialize;
begin
  inherited;
  FDetails := TStringList.Create;
  WorkItem.Commands[COMMAND_PICK_ITEM_ADD].AddInvoker(btPickItemAdd, 'OnClick');
  WorkItem.Commands[COMMAND_PICK_PANEL_HIDE].AddInvoker(btPickPanelHide, 'OnClick');
  PickPanelSplitter.CloseSplitter;
  PickPanelSplitter.Visible := false;
end;

procedure TfrEntityItemExtView.grDetailsActiveTabChanged(Sender: TcxCustomGrid;
  ALevel: TcxGridLevel);
begin
  WorkItem.Commands[COMMAND_UPDATE_COMMAND_STATUS].Execute;
end;

procedure TfrEntityItemExtView.grPickItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and (not grPickItem.DataController.IsEditing)  then
    WorkItem.Commands[COMMAND_PICK_ITEM_CANCEL].Execute
  else if (Key = VK_RETURN) and (ssShift in Shift) then
    WorkItem.Commands[COMMAND_PICK_ITEM_ADD].Execute
  else if (Key = VK_RETURN) and (Shift = [])
          and (not grPickItem.DataController.IsEditing)
          and (grPickItem.FocusedRow = grPickItem.LastVisibleRow) then
    WorkItem.Commands[COMMAND_PICK_ITEM_ADD].Execute;
end;

procedure TfrEntityItemExtView.grPickListCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_PICK_ITEM_SELECTED].Execute
end;

procedure TfrEntityItemExtView.grPickListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE  then
    edPickSearch.SetFocus
  else if (Key = VK_RETURN) and (grPickList.Controller.SelectedRowCount <> 0) then
    WorkItem.Commands[COMMAND_PICK_ITEM_SELECTED].Execute;

end;

procedure TfrEntityItemExtView.HidePickItemPanel;
begin
  grPickItem.Visible := false;
  edPickSearch.SetFocus;
end;

procedure TfrEntityItemExtView.HidePickPanel;
begin
  SetPreferenceValue('PickPanel.Width', IntToStr(pnPick.Width));
  edPickSearch.Text := '';
  PickPanelSplitter.CloseSplitter;
  PickPanelSplitter.Visible := false;
end;

end.
