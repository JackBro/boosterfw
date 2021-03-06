inherited frEntityItemExtView: TfrEntityItemExtView
  Caption = 'frEntityItemExtView'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    object cxGroupBox1: TcxGroupBox
      Left = 0
      Top = 40
      Align = alClient
      Caption = 'cxGroupBox1'
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      Style.TransparentBorder = False
      TabOrder = 1
      Transparent = True
      ExplicitWidth = 504
      Height = 475
      Width = 409
      object grHeader: TcxDBVerticalGrid
        Left = 0
        Top = 0
        Width = 409
        Height = 201
        Align = alTop
        LayoutStyle = lsBandsView
        LookAndFeel.Kind = lfOffice11
        OptionsView.AutoScaleBands = False
        OptionsView.CategoryExplorerStyle = True
        OptionsView.GridLineColor = clBtnFace
        OptionsView.RowHeaderWidth = 300
        OptionsView.ValueWidth = 300
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsData.Editing = False
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        TabOrder = 0
        DataController.DataSource = HeadDataSource
        ExplicitWidth = 504
        Version = 1
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 201
        Width = 409
        Height = 8
        AlignSplitter = salTop
        Control = grHeader
        ExplicitWidth = 504
      end
      object grDetails: TcxGrid
        Left = 0
        Top = 209
        Width = 409
        Height = 266
        Align = alClient
        TabOrder = 2
        LookAndFeel.Kind = lfOffice11
        OnActiveTabChanged = grDetailsActiveTabChanged
        ExplicitWidth = 504
      end
    end
    object pnPick: TcxGroupBox
      Left = 417
      Top = 40
      Align = alRight
      Caption = 'pnPick'
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      Style.LookAndFeel.Kind = lfOffice11
      Style.TransparentBorder = False
      StyleDisabled.LookAndFeel.Kind = lfOffice11
      StyleFocused.LookAndFeel.Kind = lfOffice11
      StyleHot.LookAndFeel.Kind = lfOffice11
      TabOrder = 2
      ExplicitLeft = 512
      Height = 475
      Width = 253
      object pnPickCommands: TcxGroupBox
        Left = 0
        Top = 435
        Align = alBottom
        PanelStyle.Active = True
        PanelStyle.OfficeBackgroundKind = pobkStyleColor
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        Style.TransparentBorder = False
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 3
        Height = 40
        Width = 253
        object btPickItemAdd: TcxButton
          AlignWithMargins = True
          Left = 80
          Top = 5
          Width = 77
          Height = 30
          Margins.Top = 5
          Margins.Right = 8
          Margins.Bottom = 5
          Align = alRight
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 0
        end
        object btPickPanelHide: TcxButton
          AlignWithMargins = True
          Left = 168
          Top = 5
          Width = 77
          Height = 30
          Margins.Top = 5
          Margins.Right = 8
          Margins.Bottom = 5
          Align = alRight
          Caption = #1057#1082#1088#1099#1090#1100
          SpeedButtonOptions.CanBeFocused = False
          TabOrder = 1
        end
      end
      object pnPickSearch: TcxGroupBox
        Left = 0
        Top = 0
        Align = alTop
        PanelStyle.Active = True
        PanelStyle.OfficeBackgroundKind = pobkStyleColor
        Style.BorderStyle = ebsNone
        Style.LookAndFeel.Kind = lfOffice11
        Style.TransparentBorder = False
        StyleDisabled.LookAndFeel.Kind = lfOffice11
        StyleFocused.LookAndFeel.Kind = lfOffice11
        StyleHot.LookAndFeel.Kind = lfOffice11
        TabOrder = 0
        Height = 21
        Width = 253
        object edPickSearch: TcxTextEdit
          Left = 0
          Top = 0
          Align = alClient
          Properties.ValidateOnEnter = True
          Properties.OnChange = edPickSearchPropertiesChange
          Properties.OnEditValueChanged = edPickSearchPropertiesEditValueChanged
          Style.LookAndFeel.Kind = lfOffice11
          StyleDisabled.LookAndFeel.Kind = lfOffice11
          StyleFocused.LookAndFeel.Kind = lfOffice11
          StyleHot.LookAndFeel.Kind = lfOffice11
          TabOrder = 0
          OnKeyDown = edPickSearchKeyDown
          Width = 253
        end
      end
      object gridPickList: TcxGrid
        AlignWithMargins = True
        Left = 0
        Top = 24
        Width = 253
        Height = 228
        Margins.Left = 0
        Margins.Right = 0
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfOffice11
        object grPickList: TcxGridDBTableView
          OnKeyDown = grPickListKeyDown
          FilterBox.Position = fpTop
          OnCellDblClick = grPickListCellDblClick
          DataController.DataSource = PickListDataSource
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.PullFocusing = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
        end
        object cxGridLevel1: TcxGridLevel
          Caption = 'Table'
          GridView = grPickList
        end
      end
      object grPickItem: TcxDBVerticalGrid
        Left = 0
        Top = 255
        Width = 253
        Height = 180
        Align = alBottom
        LookAndFeel.Kind = lfOffice11
        OptionsView.AutoScaleBands = False
        OptionsView.CategoryExplorerStyle = True
        OptionsView.GridLineColor = clBtnFace
        OptionsView.RowHeaderWidth = 125
        OptionsView.ValueWidth = 300
        OptionsBehavior.AlwaysShowEditor = True
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsData.Appending = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        TabOrder = 2
        Visible = False
        OnKeyDown = grPickItemKeyDown
        DataController.DataSource = PickItemDataSource
        Version = 1
      end
    end
    object PickPanelSplitter: TcxSplitter
      Left = 409
      Top = 40
      Width = 8
      Height = 475
      AlignSplitter = salRight
      MinSize = 250
      Control = pnPick
      ExplicitLeft = 504
    end
  end
  object HeadDataSource: TDataSource
    Left = 144
    Top = 120
  end
  object cxGridViewRepository: TcxGridViewRepository
    Left = 64
    Top = 288
    object cxGridViewRepositoryDBTableView: TcxGridDBTableView
      FilterBox.Position = fpTop
      OnCellDblClick = cxGridViewRepositoryDBTableViewCellDblClick
      OnFocusedRecordChanged = cxGridViewRepositoryDBTableViewFocusedRecordChanged
      OnSelectionChanged = cxGridViewRepositoryDBTableViewSelectionChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
    end
  end
  object PickListDataSource: TDataSource
    Left = 240
    Top = 120
  end
  object PickItemDataSource: TDataSource
    Left = 328
    Top = 120
  end
end
