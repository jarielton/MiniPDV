unit uPDV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uConn, Vcl.DBGrids, Vcl.WinXPanels,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, uVenda, uVendasItens, uProdutos;

type
  TfrmPDV = class(TForm)
    pnlPDV: TPanel;
    dbGridProdutos: TDBGrid;
    CardPanel1: TCardPanel;
    Card1: TCard;
    pnlTopo: TPanel;
    Label4: TLabel;
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
  private
    TotalVenda: double;
    procedure ProdutoSelecionando;
    procedure SetDS(ds: TDataSource);
    procedure Adicionar(AddItem: Boolean = false);
    procedure CalcTotal;
    procedure ResetaCampos;
    function ShowProduto: Boolean;
    { Private declarations }
  public
    { Public declarations }
    idClient: Integer;
  end;

var
  frmPDV: TfrmPDV;
  Conn: TConn;
  Venda: TVendas;
  VendaItens: TVendasItens;
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
    edVL_UN.Text := FormatFloat('R$ #,0.00', Produtos.DsPesquisa.DataSet.fieldbyname('Preco').AsFloat);
    edSUB_TOTAL.Text := edVL_UN.Text;
  end;
end;

procedure TfrmPDV.edIDExit(Sender: TObject);
begin
  if ShowProduto then
    edID.Text := Produtos.DsPesquisa.DataSet.fieldbyname('Id').AsString;
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
    Conn := TConn.Create;
    Produtos := TProdutos.Create(Conn);
    VendaItens := TVendasItens.Create(Conn);
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
end;

procedure TfrmPDV.Adicionar(AddItem: Boolean = false);
begin
  if AddItem and ShowProduto then
  begin
    VendaItens.idProduto := Produtos.DsPesquisa.DataSet.fieldbyname('id').AsInteger;
    VendaItens.ValorUn := Produtos.DsPesquisa.DataSet.fieldbyname('Preco').AsFloat;
    VendaItens.Qtd := StrToFloat(edQTD.Text);
    VendaItens.Inserir;
  end;
  ResetaCampos;
end;

procedure TfrmPDV.ResetaCampos;
begin
  TimerReset.Enabled := true;
end;

procedure TfrmPDV.TimerResetTimer(Sender: TObject);
begin
  TimerReset.Enabled := false;
  Perform(CM_DialogKey, VK_TAB, 0);
  edID.Text        := '0';
  edQTD.Text       := '0';
  edVL_UN.Text     := FormatFloat('R$ #,0.00', 0);
  edSUB_TOTAL.Text := FormatFloat('R$ #,0.00', 0);
  SetDS(VendaItens.DsPesquisa);
  CalcTotal;
  edID.SetFocus;
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
  if TotalVenda > 0 then
  begin
    try
      Venda := TVendas.Create(Conn);
      Venda.IdCliente := idClient;
      Venda.Data := FormatDateTime('DD/MM/YYYY', now);
      Venda.Total := TotalVenda;
      Venda.Inserir;
      if Venda.Id > 0 then
        VendaItens.GravaItens(Venda.Id);
    finally
      ResetaCampos;
    end;
  end;
end;

procedure TfrmPDV.CalcSubTotal(Sender: TObject);
var SubTotal: double;
begin
  if Produtos.Id > 0 then
  begin
    SubTotal := StrToFloat(edQTD.Text) * Produtos.DsPesquisa.DataSet.fieldbyname('Preco').AsFloat;
    edSUB_TOTAL.Text := FormatFloat('R$ #,0.00', SubTotal);
  end;
end;

procedure TfrmPDV.CalcTotal;
begin
  with VendaItens.DsPesquisa.DataSet do
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
