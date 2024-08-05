object frmInsereCompra: TfrmInsereCompra
  Left = 0
  Top = 0
  Caption = 'frmInsereCompra'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 184
    Top = 72
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object lblClienteSelecionado: TLabel
    Left = 184
    Top = 112
    Width = 114
    Height = 15
    Caption = 'lblClienteSelecionado'
  end
  object BitBtn1: TBitBtn
    Left = 192
    Top = 312
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object RgProdutos: TRadioGroup
    Left = 184
    Top = 152
    Width = 185
    Height = 105
    Caption = 'RgProdutos'
    Items.Strings = (
      'item 1'
      'item 2'
      'item 3')
    TabOrder = 1
  end
end
