unit uPDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uConn, Vcl.DBGrids, Vcl.WinXPanels, System.IniFiles,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask, uFuncoes,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, uVenda, uVendasItens, uProdutos,
  Vcl.Buttons;

type
  TfrmPDV = class(TForm)
    pnlPDV: TPanel;
    dbGridProdutos: TDBGrid;
    CardPanel1: TCardPanel;
    Card1: TCard;
    pnlTopo: TPanel;
    lblCaixa: TLabel;
    pnlEdits: TPanel;
    pnl4vTotal: TPanel;
    pnl3Preco: TPanel;
    pnl2QTD: TPanel;
    pnl1IDProduto: TPanel;
    pnlLeft: TPanel;
    pnlTotal: TPanel;
    Label1: TLabel;
    lblGravarPedido: TLabel;
    pnlBtns: TPanel;
    Panel8: TPanel;
    lblAdd: TLabel;
    Panel9: TPanel;
    lblCancel: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edID: TEdit;
    edQTD: TEdit;
    edVL_UN: TEdit;
    edSUB_TOTAL: TEdit;
    TimerReset: TTimer;
    pnlAcao: TPanel;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    lblPedido: TLabel;
    Label9: TLabel;
    Panel3: TPanel;
    lblDelete: TLabel;
    Label11: TLabel;
    lblCliente: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edIDChange(Sender: TObject);
    procedure edIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblAddClick(Sender: TObject);
    procedure lblCancelClick(Sender: TObject);
    procedure CalcSubTotal(Sender: TObject);
    procedure edIDExit(Sender: TObject);
    procedure edQTDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edVL_UNKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSUB_TOTALKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblGravarPedidoClick(Sender: TObject);
    procedure edIDClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure TimerResetTimer(Sender: TObject);
    procedure dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbGridProdutosCellClick(Column: TColumn);
    procedure lblPedidoClick(Sender: TObject);
    procedure lblDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    TotalVenda: double;
    procedure ProdutoSelecionando;
    procedure SetDS(ds: TDataSource);
    procedure Adicionar(AddItem: Boolean = false);
    procedure CalcTotal;
    procedure ResetaCampos;
    function ShowProduto: Boolean;
    procedure FinalizarVenda;
    procedure AddCliente;
    procedure ShowCliente;
    { Private declarations }
  public
    { Public declarations }
    idClient: Integer;
    SelecionarCliente: Boolean;
  end;

var
  frmPDV: TfrmPDV;
  Conn: TConn;
  Venda: TVendas;
  Pedidos: TVendasItens;
  Produtos: TProdutos;

implementation

{$R *.dfm}

uses
  DM;

procedure TfrmPDV.edIDChange(Sender: TObject);
var iD: Integer;
begin
  iD := StrToIntDef(edID.Text, 0);
  Produtos.Selecionar(iD);
  SetDS(Produtos.DsPesquisa);
  if Produtos.DsPesquisa.DataSet.RecordCount > 0 then
    ProdutoSelecionando;
end;

procedure TfrmPDV.edIDClick(Sender: TObject);
begin
  Produtos.Selecionar(0);
  SetDS(Produtos.DsPesquisa);
end;

procedure TfrmPDV.ProdutoSelecionando;
begin
  if ShowProduto then
  begin
    edQTD.Text := '1';
    edVL_UN.Text := FormatFloat('R$ #,0.00', Produtos.DsPesquisa.DataSet.fieldbyname('preco_venda').AsFloat);
    edSUB_TOTAL.Text := edVL_UN.Text;
  end;
end;

procedure TfrmPDV.edIDExit(Sender: TObject);
begin
  if ShowProduto then
    edID.Text := Produtos.DsPesquisa.DataSet.fieldbyname('codigo').AsString;
end;

procedure TfrmPDV.edIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 38 then
    dbGridProdutos.DataSource.DataSet.prior;
  if Key = 40 then
    dbGridProdutos.DataSource.DataSet.next;
  if Key = 13 then
    if ShowProduto then
      edQTD.SetFocus
    else
      begin
        dbGridProdutos.SetFocus;
        dbGridProdutos.SelectedIndex := 2;
        dbGridProdutos.DataSource.DataSet.Edit;
      end;
  if Key = 46 then
    ResetaCampos;
end;

function TfrmPDV.ShowProduto:Boolean;
begin
  Result := false;
  if Produtos.DsPesquisa.DataSet.Name = dbGridProdutos.DataSource.DataSet.Name then
    Result := true;
end;

procedure TfrmPDV.edQTDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    edVL_UN.SetFocus;
end;

procedure TfrmPDV.edSUB_TOTALKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if edSUB_TOTAL.Text <> 'R$ 0,00' then
    Adicionar(true);
end;

procedure TfrmPDV.edVL_UNKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    edSUB_TOTAL.SetFocus;
end;

procedure TfrmPDV.SetDS(ds: TDataSource);
begin
  dbGridProdutos.DataSource := ds;
end;

procedure TfrmPDV.FormCreate(Sender: TObject);
begin
  try
    Conn        := TConn.Create;
    Venda       := TVendas.Create(Conn);
    Produtos    := TProdutos.Create(Conn);
    Pedidos     := TVendasItens.Create(Conn);
    Pedidos     := TVendasItens.Create(Conn);
  except
   on E: Exception do
    ShowMessage('Erro: ' + E.Message );
  end;
end;

procedure TfrmPDV.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if TotalVenda > 0 then
  begin
    if (CardPanel1.ActiveCard = Card1) and (Msg.CharCode = 122) then
        lblGravarPedidoClick(Self);

    if Msg.CharCode = 46 then
      if application.MessageBox('Deseja Excluir esse registro ?','ATENÇÃO',MB_YESNO + MB_ICONWARNING)=MRYES then
      begin
        dbGridProdutos.DataSource.DataSet.Delete;
      end;
  end;
  if Msg.CharCode = 112 then
    AddCliente;
end;

procedure TfrmPDV.FormShow(Sender: TObject);
begin
  ResetaCampos;
  ShowCliente;
end;

procedure TfrmPDV.ShowCliente;
begin
  pnlAcao.Visible := false;
  lblCliente.Caption := 'Cliente cod:' +idClient.ToString;
  if idClient = 0 then
  begin
    pnlAcao.Visible := true;
    lblCliente.Caption := 'F1 - Cliente';
  end;
end;

procedure TfrmPDV.AddCliente;
begin
  SelecionarCliente := true;
  Close;
  exit;
end;

procedure TfrmPDV.Adicionar(AddItem: Boolean = false);
begin
  if AddItem and ShowProduto then
  begin
    Pedidos.idProduto := Produtos.DsPesquisa.DataSet.fieldbyname('codigo').AsInteger;
    Pedidos.ValorUn   := StrToFloat(TFuncoes.SoNumero(edVL_UN.Text));
    Pedidos.Qtd       := StrToFloat(edQTD.Text);
    Pedidos.Inserir;
  end;
  ResetaCampos;
end;

procedure TfrmPDV.ResetaCampos;
begin
  Perform(CM_DialogKey, VK_TAB, 0);
  edID.Text        := '0';
  edQTD.Text       := '0';
  edVL_UN.Text     := FormatFloat('R$ #,0.00', 0);
  edSUB_TOTAL.Text := FormatFloat('R$ #,0.00', 0);
  edID.SetFocus;
  SetDS(Pedidos.DsPesquisa);
  CalcTotal;
end;

procedure TfrmPDV.TimerResetTimer(Sender: TObject);
begin
  TimerReset.Enabled := false;
  ResetaCampos;
end;

procedure TfrmPDV.lblAddClick(Sender: TObject);
begin
  Adicionar(true);
end;

procedure TfrmPDV.lblCancelClick(Sender: TObject);
begin
  Adicionar;
end;

procedure TfrmPDV.lblGravarPedidoClick(Sender: TObject);
begin
  if idClient > 0 then
    begin
      FinalizarVenda;
      ResetaCampos;
      idClient := 0;
      ShowCliente
    end
  else
    if application.MessageBox('Pedido sem cliente '+#13+
    'Deseja informar cliente agora?','ATENÇÃO',MB_YESNO + MB_ICONWARNING)=MRYES then
    begin
      AddCliente;
    end;
end;

procedure TfrmPDV.FinalizarVenda;
begin
  if TotalVenda > 0 then
  begin
    try
      Venda.IdCliente := idClient;
      Venda.Total     := TotalVenda;
      Venda.Inserir;
      if Venda.Id > 0 then
        Pedidos.GravaItens(Venda.Id);
    except on e:exception do
      raise Exception.Create('Erro ao finalizar venda: ' + e.Message);
    end;
  end;
end;

procedure TfrmPDV.lblDeleteClick(Sender: TObject);
var
  sCodigo: String;
  iCodigo: Integer;
  msg: Char;
begin
  if InputQuery('Deletar Pedido', 'Informe o codigo:', sCodigo) then
  begin
    iCodigo := StrToIntDef(sCodigo, 0);
    if iCodigo > 0 then
      if application.MessageBox('Deseja essa venda ?','ATENÇÃO',MB_YESNO + MB_ICONWARNING)=MRYES then
        Venda.Deletar(iCodigo);
  end;
end;

procedure TfrmPDV.lblPedidoClick(Sender: TObject);
var
  sCodigo: String;
  iCodigo: Integer;
begin
  if InputQuery('Localizar Pedido', 'Informe o codigo:', sCodigo) then
  begin
    iCodigo := StrToIntDef(sCodigo, 0);
    if iCodigo > 0 then
      begin
        Pedidos.Selecionar(iCodigo);
        SetDS(Pedidos.DsPesquisa);
      end;
  end;
end;

procedure TfrmPDV.CalcSubTotal(Sender: TObject);
var SubTotal: double;
begin
  if Produtos.Id > 0 then
  begin
    SubTotal := StrToFloat(edQTD.Text) * StrToFloat(TFuncoes.SoNumero(edVL_UN.Text));
    edSUB_TOTAL.Text := FormatFloat('R$ #,0.00', SubTotal);
  end;
end;

procedure TfrmPDV.CalcTotal;
begin
  with Pedidos.DsPesquisa.DataSet do
  begin
    TotalVenda := 0;
    DisableControls;
    First;
    while not Eof do
    begin
      TotalVenda := TotalVenda + fieldbyname('Total').AsFloat;
      Next;
    end;
    First;
    EnableControls;

    lblGravarPedido.Caption := FormatFloat('R$ #,0.00', TotalVenda);
  end;
end;

procedure TfrmPDV.dbGridProdutosCellClick(Column: TColumn);
begin
  if dbGridProdutos.SelectedIndex < 2 then
    dbGridProdutos.SelectedIndex := 2;
end;

procedure TfrmPDV.dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if not ShowProduto and (dbGridProdutos.DataSource.DataSet.State in dsEditModes) then
    begin
      if dbGridProdutos.SelectedIndex = dbGridProdutos.Columns.Count - 2 then
        begin
          dbGridProdutos.DataSource.DataSet.Post;
          ResetaCampos;
        end
      else
        dbGridProdutos.Perform(WM_KEYDOWN, VK_TAB, 0);
    end;
  end;
end;

end.
