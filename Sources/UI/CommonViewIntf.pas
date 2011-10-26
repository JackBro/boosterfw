unit CommonViewIntf;

interface
uses classes, db, CoreClasses, sysutils, controls, ViewServiceIntf, ActivityServiceIntf;

const
  COMMAND_CLOSE = 'commands.view.close';
  COMMAND_CLOSE_CAPTION = '�������';
  COMMAND_CLOSE_SHORTCUT = 'Ctrl+W';

  COMMAND_SAVE = 'commands.view.save';
  COMMAND_SAVE_CAPTION = '���������';
  COMMAND_SAVE_SHORTCUT = 'Ctrl+S;Ctrl+Enter';

  COMMAND_OK = 'commands.view.ok';
  COMMAND_OK_CAPTION = 'OK';
  COMMAND_OK_SHORTCUT = 'Enter';

  COMMAND_CANCEL = 'commands.view.cancel';
  COMMAND_CANCEL_CAPTION = '������';
  COMMAND_CANCEL_SHORTCUT = 'Ctrl+W';

 // COMMAND_NEXT = 'commands.view.next';
 // COMMAND_NEXT_CAPTION = '�����';

  COMMAND_RELOAD = 'commands.view.reload';
  COMMAND_RELOAD_CAPTION = '��������';
  COMMAND_RELOAD_SHORTCUT = 'F5';

  COMMAND_OPEN = 'commands.view.open';
  COMMAND_OPEN_CAPTION = '�������';
  COMMAND_OPEN_SHORTCUT = 'Ctrl+Enter';

  COMMAND_NEW = 'commands.view.new';
  COMMAND_NEW_CAPTION = '��������';
  COMMAND_NEW_SHORTCUT = 'Ins';

  COMMAND_DELETE = 'commands.view.del';
  COMMAND_DELETE_CAPTION = '�������';
  COMMAND_DELETE_SHORTCUT = 'Ctrl+Del';

  COMMAND_DETAIL_OPEN = 'commands.view.detail.open';
  COMMAND_DETAIL_OPEN_CAPTION = '������� ������';
  COMMAND_DETAIL_OPEN_SHORTCUT = 'Ctrl+Enter';

  COMMAND_DETAIL_NEW = 'commands.view.detail.new';
  COMMAND_DETAIL_NEW_CAPTION = '�������� ������';
  COMMAND_DETAIL_NEW_SHORTCUT = 'Ins';

  COMMAND_DETAIL_DELETE = 'commands.view.detail.del';
  COMMAND_DETAIL_DELETE_CAPTION = '������� ������';
  COMMAND_DETAIL_DELETE_SHORTCUT = 'Ctrl+Del';

  COMMAND_STATE_CHANGE_NEXT = 'commands.view.statechange.next';
  COMMAND_STATE_CHANGE_NEXT_CAPTION = '��������� ���������';

  COMMAND_STATE_CHANGE_PREV = 'commands.view.statechange.prev';
  COMMAND_STATE_CHANGE_PREV_CAPTION = '���������� ���������';

type

  TViewActivateHandler = procedure of object;
  TViewDeactivateHandler = procedure of object;
  TViewShowHandler = procedure of object;
  TViewCloseHandler = procedure of object;
  TViewCloseQueryHandler = procedure(var CanClose: boolean) of object;

  TViewValueChangedHandler = procedure(const AName: string) of object;
  TViewFocusedFieldChangedHandler = procedure(ADataSet: TDataSet);

  TValueStatus = (vsEnabled, vsDisabled, vsUnavailable);

  ICommandBar = interface;

  ICustomView = interface(IView)
  ['{5A77F2C8-C19A-4BD6-A8B0-E9F737BC4775}']
    function CommandBar: ICommandBar;

    function GetValue(const AName: string): Variant;
    procedure SetValue(const AName: string; AValue: Variant);
    property Value[const AName: string]: Variant read GetValue write SetValue; default;

    function GetValueStatus(const AName: string): TValueStatus;
    procedure SetValueStatus(const AName: string; AStatus: TValueStatus);
    property ValueStatus[const AName: string]: TValueStatus read GetValueStatus write SetValueStatus;

    procedure FocusValueControl(const AName: string);
    procedure FocusDataSetControl(ADataSet: TDataSet; const AFieldName: string = '');

    function GetPreferencePath: string;
    procedure SetPreferenceValue(const AName, AValue: string);
    function GetPreferenceValue(const AName: string): string;
    property PreferenceValue[const AName: string]: string read GetPreferenceValue
      write SetPreferenceValue;

    procedure SetActivateHandler(AHandler: TViewActivateHandler);
    procedure SetDeactivateHandler(AHandler: TViewDeactivateHandler);
    procedure SetShowHandler(AHandler: TViewShowHandler);
    procedure SetCloseHandler(AHandler: TViewCloseHandler);
    procedure SetCloseQueryHandler(AHandler: TViewCloseQueryHandler);
    procedure SetValueChangedHandler(AHandler: TViewValueChangedHandler);
  end;

//------------------------------------------------------------------------------


  TTabChangedHandler = procedure of object;

  ITabs = interface
  ['{2CD9A2D9-98FC-46A4-AA71-B6797E89C4D5}']
    function Add(ATab: string): integer;
    procedure Delete(AIndex: integer);
    procedure Hide(AIndex: integer);
    procedure Show(AIndex: integer);
    function GetActive: integer;
    procedure SetActive(AIndex: integer);
    property Active: integer read GetActive write SetActive;
    function GetTabCaption(AIndex: integer): string;
    procedure SetTabCaption(AIndex: integer; const AValue: string);
    property TabCaption[AIndex: integer]: string read GetTabCaption write SetTabCaption;
    function Count: integer;
    procedure SetTabChangedHandler(AHandler: TTabChangedHandler);
  end;

  IList = interface
  ['{E0D5178B-E286-42C6-88D8-C3008CAAA877}']
    function Count: integer;
    function GetItem(AIndex: integer): Variant;
    function First: Variant;
    function AsArray: variant;
    function AsString(ADelimiter: char = ';'): string;
    property Items[AIndex: integer]: Variant read GetItem; default;
  end;

  TSelectionChangedHandler = procedure of object;

  ISelection = interface(IList)
  ['{F348CAB1-78EF-4F87-9428-D76AC586FFB4}']
    procedure SetChangedCommand(const AName: string);
    procedure SetSelectionChangedHandler(AHandler: TSelectionChangedHandler);
    procedure ChangeSelection(AItem: Variant; ASelected: boolean);
    procedure SelectFocused;
    procedure SelectAll;
    procedure ClearSelection;
    function GetCanMultiSelect: boolean;
    procedure SetCanMultiSelect(AValue: boolean);
    property CanMultiSelect: boolean read GetCanMultiSelect write SetCanMultiSelect;
  end;


  ICommandBar = interface
  ['{BF9EB98D-ABA0-4EE0-9776-28AB336431E4}']
    procedure AddCommand(const AName: string; AGroup: string = ''; ADefault: boolean = false); overload;
    procedure AddCommand(const AName, ACaption, AShortCut: string; AHandler: TNotifyEvent;
      AGroup: string = ''; ADefault: boolean = false); overload;
  end;


  IContentView = interface(ICustomView)
  ['{45410026-2DBE-4CBF-B2EE-D0AD93B7AF6A}']
  end;

  IDialogView = interface(ICustomView)
  ['{7C1DBBD0-90BF-431D-BF48-D4EC34E39244}']
  end;


  IExtensionCommand = interface
  ['{C4670269-B360-45A6-A3DD-836A1B635DA0}']
    procedure CommandExtend;
    procedure CommandUpdate;
  end;

//------------------------------------------------------------------------------
  IPickListPresenterData = interface
  ['{BE5EEC85-24BF-4BB8-9EC1-3C9A5BD43C22}']
    function GetFilter: string;
    function GetID: Variant;
    function GetName: Variant;
    procedure SetFilter(Value: string);
    procedure SetID(Value: Variant);
    procedure SetName(Value: Variant);
    property Filter: string read GetFilter write SetFilter;
    property ID: Variant read GetID write SetID;
    property NAME: Variant read GetNAME write SetNAME;
  end;

  TViewActivityBuilder = class(TActivityBuilder)
  private
    FWorkItem: TWorkItem;
    FActivityClass: string;
    FPresenterClass: TPresenterClass;
    FViewClass: TViewClass;
  public
    constructor Create(AWorkItem: TWorkItem; const AActivityClass: string;
      APresenterClass: TPresenterClass; AViewClass: TViewClass);

    function ActivityClass: string; override;
    procedure Build(ActivityInfo: IActivityInfo); override;
    property WorkItem: TWorkItem read FWorkItem;
    property PresenterClass: TPresenterClass read FPresenterClass;
    property ViewClass: TViewClass read FViewClass;

  end;

implementation




{ TViewActivityBuilder }

function TViewActivityBuilder.ActivityClass: string;
begin
  Result := FActivityClass;
end;

procedure TViewActivityBuilder.Build(ActivityInfo: IActivityInfo);
begin
  (FWorkItem.Services[IViewManagerService] as IViewManagerService).
    RegisterView(ActivityInfo.URI, FViewClass, FPresenterClass);

  //RegisterExtension(URI, TEntityViewExtension);
end;

constructor TViewActivityBuilder.Create(AWorkItem: TWorkItem; const AActivityClass: string;
      APresenterClass: TPresenterClass; AViewClass: TViewClass);
begin
  FWorkItem := AWorkItem;
  FActivityClass := AActivityClass;
  FPresenterClass := APresenterClass;
  FViewClass := AViewClass;
end;

end.
