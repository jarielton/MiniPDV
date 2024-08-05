object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 724
  ClientWidth = 1092
  Color = 8074511
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnShortCut = FormShortCut
  OnShow = FormShow
  TextHeight = 15
  object pnlCenter: TPanel
    Left = 0
    Top = 0
    Width = 1092
    Height = 724
    BevelOuter = bvNone
    Color = 8074511
    ParentBackground = False
    TabOrder = 0
    object cPanel: TCardPanel
      Left = 0
      Top = 0
      Width = 1092
      Height = 724
      Align = alClient
      ActiveCard = cStart
      BevelOuter = bvNone
      TabOrder = 0
      object cStart: TCard
        Left = 0
        Top = 0
        Width = 1092
        Height = 724
        Caption = 'cStart'
        CardIndex = 0
        Color = 8074511
        ParentBackground = False
        TabOrder = 0
        object pnlPDV: TPanel
          AlignWithMargins = True
          Left = 5
          Top = 5
          Width = 532
          Height = 714
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alLeft
          BevelOuter = bvNone
          Color = 7352334
          ParentBackground = False
          TabOrder = 0
          object Label4: TLabel
            Left = 83
            Top = 279
            Width = 348
            Height = 71
            Caption = 'CAIXA ABERTO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -53
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
        end
        object pnlHeader: TPanel
          AlignWithMargins = True
          Left = 547
          Top = 5
          Width = 534
          Height = 156
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelOuter = bvNone
          Color = 7352334
          ParentBackground = False
          TabOrder = 1
          object lblDate: TLabel
            Left = 320
            Top = -3
            Width = 215
            Height = 37
            Caption = '12:30 03/08/2024'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 101
            Top = 31
            Width = 428
            Height = 82
            Alignment = taRightJustify
            Caption = 'RAZ'#195'O SOCIAL OU NOME DA EMPRESA'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -30
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object Label3: TLabel
            Left = 262
            Top = 111
            Width = 273
            Height = 37
            Caption = 'OPERADOR - CAIXA 01'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
        end
        object pnlNovo: TPanel
          AlignWithMargins = True
          Left = 800
          Top = 181
          Width = 270
          Height = 116
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelOuter = bvNone
          Color = 16512
          ParentBackground = False
          TabOrder = 2
          object Label5: TLabel
            Left = 0
            Top = 64
            Width = 270
            Height = 37
            Alignment = taCenter
            AutoSize = False
            Caption = 'F2 - NOVA VENDA'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object lblNovo: TLabel
            Left = 0
            Top = 0
            Width = 270
            Height = 113
            Cursor = crHandPoint
            Alignment = taCenter
            AutoSize = False
            Caption = '+'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -53
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = lblNovoClick
          end
        end
        object pnlSair: TPanel
          AlignWithMargins = True
          Left = 800
          Top = 565
          Width = 270
          Height = 116
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          BevelOuter = bvNone
          Color = clMaroon
          ParentBackground = False
          TabOrder = 3
          object Label7: TLabel
            Left = 64
            Top = 64
            Width = 153
            Height = 41
            Alignment = taCenter
            AutoSize = False
            Caption = 'ESC - SAIR'
            Color = clMaroon
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object lblSair: TLabel
            Left = 0
            Top = 0
            Width = 265
            Height = 113
            Cursor = crHandPoint
            Alignment = taCenter
            AutoSize = False
            Caption = 'x'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWhite
            Font.Height = -53
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = lblSairClick
          end
        end
      end
      object cClient: TCard
        Left = 0
        Top = 0
        Width = 1092
        Height = 724
        Caption = 'cClient'
        CardIndex = 1
        Color = 8074511
        ParentBackground = False
        TabOrder = 1
        object lblSelectCliente: TLabel
          AlignWithMargins = True
          Left = 50
          Top = 20
          Width = 992
          Height = 37
          Margins.Left = 50
          Margins.Top = 20
          Margins.Right = 50
          Align = alTop
          Caption = 'SELECIONAR CLIENTE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 258
        end
        object edCliente: TEdit
          AlignWithMargins = True
          Left = 50
          Top = 80
          Width = 992
          Height = 45
          Margins.Left = 50
          Margins.Top = 20
          Margins.Right = 50
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = 'Nome do cliente'
          OnChange = edClienteChange
          OnKeyDown = edClienteKeyDown
        end
        object GridClientes: TDBGrid
          AlignWithMargins = True
          Left = 50
          Top = 148
          Width = 992
          Height = 477
          Margins.Left = 50
          Margins.Top = 20
          Margins.Right = 50
          Align = alTop
          DataSource = uDM.dsClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Width = 54
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME'
              Width = 479
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CIDADE'
              Width = 340
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UF'
              Width = 58
              Visible = True
            end>
        end
        object pnlBtns: TPanel
          AlignWithMargins = True
          Left = 50
          Top = 644
          Width = 992
          Height = 65
          Margins.Left = 50
          Margins.Right = 50
          Margins.Bottom = 15
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object Panel1: TPanel
            Left = 652
            Top = 0
            Width = 340
            Height = 65
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alRight
            BevelOuter = bvNone
            Color = 4953856
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            object Label11: TLabel
              Left = 0
              Top = 0
              Width = 100
              Height = 65
              Alignment = taCenter
              AutoSize = False
              Caption = #10003
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -53
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lblConfirmar: TLabel
              Tag = 4
              Left = 0
              Top = 0
              Width = 340
              Height = 65
              Cursor = crHandPoint
              Alignment = taCenter
              AutoSize = False
              Caption = 'CONFIRMAR'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -27
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
              OnClick = lblConfirmarClick
            end
          end
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 340
            Height = 65
            Margins.Left = 5
            Margins.Top = 5
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alLeft
            BevelOuter = bvNone
            Color = clMaroon
            ParentBackground = False
            TabOrder = 1
            object lblCancel: TLabel
              Tag = 4
              Left = 0
              Top = 0
              Width = 340
              Height = 65
              Cursor = crHandPoint
              Alignment = taCenter
              AutoSize = False
              Caption = 'CANCELAR'
              Color = clMaroon
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -27
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentColor = False
              ParentFont = False
              Layout = tlCenter
              OnClick = lblCancelClick
            end
            object Label13: TLabel
              Left = 0
              Top = 0
              Width = 100
              Height = 65
              Alignment = taCenter
              AutoSize = False
              Caption = #10007
              Font.Charset = ANSI_CHARSET
              Font.Color = clWhite
              Font.Height = -53
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
        end
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 112
    Top = 592
  end
end
