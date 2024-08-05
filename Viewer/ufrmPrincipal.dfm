object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 120
    Top = 46
    Width = 42
    Height = 15
    Caption = 'Clientes'
  end
  object Label2: TLabel
    Left = 120
    Top = 235
    Width = 25
    Height = 15
    Caption = 'Itens'
  end
  object Label3: TLabel
    Left = 120
    Top = 214
    Width = 37
    Height = 15
    Caption = 'Vendas'
  end
  object DBGridMaster: TDBGrid
    Left = 120
    Top = 72
    Width = 320
    Height = 120
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGridMasterCellClick
    OnDblClick = DBGridMasterDblClick
  end
  object DBGridDetail: TDBGrid
    Left = 120
    Top = 256
    Width = 320
    Height = 120
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGridDetailDblClick
  end
  object DBNavMaster: TDBNavigator
    Left = 200
    Top = 41
    Width = 240
    Height = 25
    TabOrder = 2
  end
  object DBNavDetail: TDBNavigator
    Left = 200
    Top = 209
    Width = 240
    Height = 25
    TabOrder = 3
  end
end
