object frmPDV: TfrmPDV
  Left = 0
  Top = 0
  Caption = 'PDV'
  ClientHeight = 860
  ClientWidth = 1162
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  OnShow = FormShow
  TextHeight = 15
  object CardPanel1: TCardPanel
    Left = 0
    Top = 0
    Width = 1162
    Height = 860
    Align = alClient
    ActiveCard = Card1
    BevelOuter = bvNone
    Caption = 'CardPanel1'
    TabOrder = 0
    object Card1: TCard
      Left = 0
      Top = 0
      Width = 1162
      Height = 860
      Caption = 'Card1'
      CardIndex = 0
      Padding.Left = 50
      Padding.Top = 20
      Padding.Right = 50
      Padding.Bottom = 20
      TabOrder = 0
      object pnlPDV: TPanel
        Left = 50
        Top = 125
        Width = 1062
        Height = 715
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object pnlEdits: TPanel
          Left = 693
          Top = 0
          Width = 369
          Height = 715
          Margins.Left = 0
          Margins.Top = 20
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alRight
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 20
            Width = 356
            Height = 37
            Cursor = crHandPoint
            Margins.Top = 20
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'CODIGO'
            Color = 4953856
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4605510
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            ExplicitLeft = -5
            ExplicitTop = -20
          end
          object Label2: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 133
            Width = 356
            Height = 37
            Cursor = crHandPoint
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'QUANTIDADE'
            Color = 4953856
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4605510
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            ExplicitTop = 176
          end
          object Label6: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 246
            Width = 356
            Height = 37
            Cursor = crHandPoint
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'VALOR UNITARIO'
            Color = 4953856
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4605510
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            ExplicitLeft = -5
            ExplicitTop = 307
          end
          object Label7: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 359
            Width = 356
            Height = 37
            Cursor = crHandPoint
            Margins.Right = 10
            Align = alTop
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'SUB TOTAL'
            Color = 4953856
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4605510
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            Layout = tlCenter
            ExplicitTop = 452
          end
          object pnl4vTotal: TPanel
            AlignWithMargins = True
            Left = 30
            Top = 399
            Width = 339
            Height = 70
            Margins.Left = 30
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            BevelOuter = bvNone
            Color = 8074511
            ParentBackground = False
            TabOrder = 0
            object edSUB_TOTAL: TEdit
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 329
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2368548
              Font.Height = -47
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = 'R$ 0,00'
              TextHint = 'R$ 0,00'
              OnKeyDown = edSUB_TOTALKeyDown
              ExplicitHeight = 70
            end
          end
          object pnl3Preco: TPanel
            AlignWithMargins = True
            Left = 30
            Top = 286
            Width = 339
            Height = 70
            Margins.Left = 30
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            BevelOuter = bvNone
            Color = 8074511
            ParentBackground = False
            TabOrder = 1
            object edVL_UN: TEdit
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 329
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2368548
              Font.Height = -47
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TextHint = 'R$ 0,00'
              OnExit = CalcSubTotal
              OnKeyDown = edVL_UNKeyDown
              ExplicitHeight = 70
            end
          end
          object pnl2QTD: TPanel
            AlignWithMargins = True
            Left = 30
            Top = 173
            Width = 339
            Height = 70
            Margins.Left = 30
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            BevelOuter = bvNone
            Color = 8074511
            ParentBackground = False
            TabOrder = 2
            object edQTD: TEdit
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 329
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              Alignment = taRightJustify
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2368548
              Font.Height = -47
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = '0'
              TextHint = '0'
              OnExit = CalcSubTotal
              OnKeyDown = edQTDKeyDown
              ExplicitHeight = 70
            end
          end
          object pnl1IDProduto: TPanel
            AlignWithMargins = True
            Left = 30
            Top = 60
            Width = 339
            Height = 70
            Margins.Left = 30
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alTop
            BevelOuter = bvNone
            Color = 8074511
            ParentBackground = False
            TabOrder = 3
            object edID: TEdit
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 329
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              Alignment = taRightJustify
              BevelInner = bvNone
              BevelOuter = bvNone
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 2368548
              Font.Height = -47
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              TextHint = '0'
              OnChange = edIDChange
              OnClick = edIDClick
              OnExit = edIDExit
              OnKeyDown = edIDKeyDown
              ExplicitHeight = 70
            end
          end
          object pnlBtns: TPanel
            AlignWithMargins = True
            Left = 30
            Top = 570
            Width = 339
            Height = 145
            Margins.Left = 30
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 4
            object Panel8: TPanel
              Tag = 4
              Left = 0
              Top = 0
              Width = 339
              Height = 65
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alTop
              BevelOuter = bvNone
              Color = 4953856
              ParentBackground = False
              TabOrder = 0
              object lblAdd: TLabel
                Left = 0
                Top = 0
                Width = 339
                Height = 65
                Cursor = crHandPoint
                Alignment = taCenter
                AutoSize = False
                Caption = 'INSERIR'
                Color = 4953856
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -27
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
                OnClick = lblAddClick
              end
              object Label3: TLabel
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
            end
            object Panel9: TPanel
              Left = 0
              Top = 80
              Width = 339
              Height = 65
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alBottom
              BevelOuter = bvNone
              Color = clMaroon
              ParentBackground = False
              TabOrder = 1
              object lblCancel: TLabel
                Left = 0
                Top = 0
                Width = 339
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
          object pnlAcao: TPanel
            Left = 32
            Top = 488
            Width = 337
            Height = 62
            TabOrder = 5
            object SpeedButton1: TSpeedButton
              Left = 0
              Top = 0
              Width = 73
              Height = 57
              Caption = 'X'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
            end
            object Panel2: TPanel
              Tag = 4
              Left = 1
              Top = 1
              Width = 160
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alLeft
              BevelOuter = bvNone
              Color = 9858305
              ParentBackground = False
              TabOrder = 0
              object Label9: TLabel
                Left = 4
                Top = 5
                Width = 49
                Height = 49
                Alignment = taCenter
                AutoSize = False
                Caption = #55357#56589
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -40
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblPedido: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 154
                Height = 54
                Cursor = crHandPoint
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = '      PEDIDO'
                Color = 4953856
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -27
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
                OnClick = lblPedidoClick
                ExplicitLeft = 45
                ExplicitTop = 8
                ExplicitWidth = 109
                ExplicitHeight = 41
              end
            end
            object Panel3: TPanel
              Tag = 4
              Left = 176
              Top = 1
              Width = 160
              Height = 60
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alRight
              BevelOuter = bvNone
              Color = 197547
              ParentBackground = False
              TabOrder = 1
              object Label11: TLabel
                Left = 4
                Top = 5
                Width = 49
                Height = 49
                Alignment = taCenter
                AutoSize = False
                Caption = #55357#56785
                Font.Charset = ANSI_CHARSET
                Font.Color = clWhite
                Font.Height = -40
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object lblDelete: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 154
                Height = 54
                Cursor = crHandPoint
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = '      DELETAR'
                Color = 4953856
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -27
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Layout = tlCenter
                OnClick = lblDeleteClick
                ExplicitLeft = 45
                ExplicitTop = 8
                ExplicitWidth = 109
                ExplicitHeight = 41
              end
            end
          end
        end
        object pnlLeft: TPanel
          Left = 0
          Top = 0
          Width = 693
          Height = 715
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 1
          object dbGridProdutos: TDBGrid
            AlignWithMargins = True
            Left = 0
            Top = 20
            Width = 693
            Height = 530
            Margins.Left = 0
            Margins.Top = 20
            Margins.Right = 0
            Margins.Bottom = 20
            TabStop = False
            Align = alClient
            DataSource = uDM.dsItens
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -27
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            OnCellClick = dbGridProdutosCellClick
            OnKeyDown = dbGridProdutosKeyDown
          end
          object pnlTotal: TPanel
            Left = 0
            Top = 570
            Width = 693
            Height = 145
            Align = alBottom
            BevelOuter = bvNone
            Color = 8074511
            ParentBackground = False
            TabOrder = 1
            object Label1: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 98
              Width = 673
              Height = 37
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alBottom
              Alignment = taCenter
              Caption = 'F11 - GRAVAR PEDIDO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -27
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
              ExplicitWidth = 267
            end
            object lblGravarPedido: TLabel
              Left = 0
              Top = 0
              Width = 693
              Height = 98
              Cursor = crHandPoint
              Margins.Left = 10
              Margins.Top = 15
              Margins.Right = 10
              Margins.Bottom = 0
              Align = alClient
              Alignment = taCenter
              AutoSize = False
              Caption = 'R$ 0,00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -67
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              OnClick = lblGravarPedidoClick
              ExplicitLeft = 10
              ExplicitTop = 15
              ExplicitWidth = 673
              ExplicitHeight = 122
            end
          end
        end
      end
      object pnlTopo: TPanel
        Left = 50
        Top = 20
        Width = 1062
        Height = 105
        Margins.Left = 50
        Margins.Top = 20
        Margins.Right = 50
        Align = alTop
        BevelOuter = bvNone
        Color = 8074511
        ParentBackground = False
        TabOrder = 1
        object lblCliente: TLabel
          AlignWithMargins = True
          Left = 10
          Top = 58
          Width = 1042
          Height = 37
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alBottom
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 7
        end
        object lblCaixa: TLabel
          Left = 0
          Top = 0
          Width = 1062
          Height = 58
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'CAIXA ABERTO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -53
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitLeft = 10
          ExplicitTop = 10
          ExplicitWidth = 348
          ExplicitHeight = 71
        end
      end
    end
  end
  object TimerReset: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerResetTimer
    Left = 576
    Top = 432
  end
end
