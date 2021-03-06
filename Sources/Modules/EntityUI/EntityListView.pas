unit EntityListView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomView, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, ActnList, StdCtrls,
  cxButtons, cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  UIClasses, CoreClasses, EntityListPresenter;

type
  TfrEntityListView = class(TfrCustomView, IEntityListView)
    pnInfo: TcxGroupBox;
    ListDataSource: TDataSource;
    grList: TcxGrid;
    grListView: TcxGridDBTableView;
    grListLevel1: TcxGridLevel;
    procedure grListViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
  protected
    //IEntityListView
    procedure SetInfoText(const AText: string);
    function Selection: ISelection;
    procedure SetListDataSet(ADataSet: TDataSet);
  end;


implementation

{$R *.dfm}

{ TfrCustomEntityListView }

function TfrEntityListView.Selection: ISelection;
begin
  Result := GetChildInterface(grListView.Name) as ISelection;
end;

procedure TfrEntityListView.SetListDataSet(ADataSet: TDataSet);
begin
  LinkDataSet(ListDataSource, ADataSet);
end;

procedure TfrEntityListView.grListViewCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  WorkItem.Commands[COMMAND_OPEN].Execute;
  WorkItem.Commands[ON_DBLCLICK].Execute;
end;

procedure TfrEntityListView.SetInfoText(const AText: string);
begin
  pnInfo.Caption := AText;
  pnInfo.Visible := Trim(AText) <> '';
end;


end.
