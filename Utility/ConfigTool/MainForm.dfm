object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 634
  ClientWidth = 983
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 634
    Align = alLeft
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = cxButton1
        Row = 0
      end
      item
        Column = 0
        Control = cxButton2
        Row = 1
      end
      item
        Column = 0
        Control = cxButton3
        Row = 2
      end>
    RowCollection = <
      item
        Value = 9.988777075419978000
      end
      item
        Value = 9.976202947710616000
      end
      item
        Value = 9.987033426881158000
      end
      item
        Value = 10.001974652924070000
      end
      item
        Value = 10.009902392686720000
      end
      item
        Value = 10.012382398054110000
      end
      item
        Value = 10.011088592403550000
      end
      item
        Value = 10.007722846020730000
      end
      item
        Value = 10.003903135748910000
      end
      item
        Value = 10.001012532150170000
      end>
    TabOrder = 0
    ExplicitLeft = -24
    ExplicitTop = -8
    object cxButton1: TcxButton
      Left = 1
      Top = 1
      Width = 295
      Height = 63
      Margins.Top = 5
      Align = alClient
      Caption = 'cxButton1'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 1
      Top = 64
      Width = 295
      Height = 63
      Margins.Top = 5
      Align = alClient
      Caption = 'cxButton1'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 1
    end
    object cxButton3: TcxButton
      Left = 1
      Top = 127
      Width = 295
      Height = 63
      Margins.Top = 5
      Align = alClient
      Caption = 'cxButton1'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 2
    end
  end
  object cxGroupBox1: TcxGroupBox
    Left = 297
    Top = 0
    Align = alLeft
    Caption = 'cxGroupBox1'
    PanelStyle.Active = True
    Style.Shadow = False
    TabOrder = 1
    Height = 634
    Width = 263
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 5
      Top = 60
      Width = 253
      Height = 514
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = cxcbsNone
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = True
      object cxGrid1DBTableView1: TcxGridDBTableView
        DataController.DataSource = DataSource1
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.ScrollBars = ssNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLines = glNone
        OptionsView.RowSeparatorColor = clInfoBk
        OptionsView.RowSeparatorWidth = 4
        object cxGrid1DBTableView1NAME: TcxGridDBColumn
          DataBinding.FieldName = 'NAME'
        end
        object cxGrid1DBTableView1KOD: TcxGridDBColumn
          DataBinding.FieldName = 'KOD'
        end
        object cxGrid1DBTableView1ORG: TcxGridDBColumn
          DataBinding.FieldName = 'ORG'
        end
      end
      object cxGrid1DBBandedTableView1: TcxGridDBBandedTableView
        Navigator.InfoPanel.Visible = True
        OnCellClick = cxGrid1DBBandedTableView1CellClick
        DataController.DataSource = DataSource1
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Editing = False
        OptionsSelection.InvertSelect = False
        OptionsView.FocusRect = False
        OptionsView.ScrollBars = ssNone
        OptionsView.ColumnAutoWidth = True
        OptionsView.DataRowHeight = 50
        OptionsView.GridLines = glNone
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        OptionsView.RowSeparatorColor = clMenu
        OptionsView.RowSeparatorWidth = 6
        OptionsView.BandHeaders = False
        Bands = <
          item
          end>
        object cxGrid1DBBandedTableView1KOD: TcxGridDBBandedColumn
          DataBinding.FieldName = 'KOD'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 1
        end
        object cxGrid1DBBandedTableView1NAME: TcxGridDBBandedColumn
          DataBinding.FieldName = 'NAME'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taCenter
          Options.Focusing = False
          Options.CellMerging = True
          Styles.Content = cxStyle1
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxGrid1DBBandedTableView1ORG: TcxGridDBBandedColumn
          DataBinding.FieldName = 'ORG'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Options.Focusing = False
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 1
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBBandedTableView1
      end
    end
    object cxButton4: TcxButton
      Left = 2
      Top = 2
      Width = 259
      Height = 55
      Align = alTop
      Caption = 'cxButton4'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.Flat = True
      TabOrder = 1
    end
    object cxButton5: TcxButton
      Left = 2
      Top = 577
      Width = 259
      Height = 55
      Align = alBottom
      Caption = 'cxButton4'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.Flat = True
      TabOrder = 2
    end
  end
  object cxButton6: TcxButton
    Left = 608
    Top = 60
    Width = 75
    Height = 25
    Caption = 'cxButton6'
    TabOrder = 2
  end
  object cxDBVerticalGrid1: TcxDBVerticalGrid
    Left = 592
    Top = 168
    Width = 329
    Height = 345
    OptionsView.RowHeaderWidth = 147
    TabOrder = 3
    Version = 1
    object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
      Properties.EditPropertiesClassName = 'TcxPopupEditProperties'
      Properties.EditProperties.ImmediateDropDownWhenActivated = False
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow
      Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 272
    Top = 16
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = '192.168.0.5:b52'
    Params.Strings = (
      'user_name=sysdba'
      'password=211834'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    SQLDialect = 1
    Left = 224
    Top = 40
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from spr_podr where name containing '#39#1057#39)
    Left = 128
    Top = 72
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 176
    Top = 192
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from spr_podr where name containing '#39#1057#39
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 152
    Top = 248
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = IBQuery1
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 208
    Top = 136
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <>
    StorageName = 'cxPropertiesStore1'
    Left = 488
    Top = 320
  end
end
