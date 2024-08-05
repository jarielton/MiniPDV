unit ufrmInsereCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmInsereCompra = class(TForm)
    Label1: TLabel;
    lblClienteSelecionado: TLabel;
    BitBtn1: TBitBtn;
    RgProdutos: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations } public
    { Public declarations } end;

var
  frmInsereCompra: TfrmInsereCompra;

implementation

uses ufrmPrincipal, uCompras;
// para ter acesso aos objetos criados la.
{$R *.dfm}

procedure TfrmInsereCompra.BitBtn1Click(Sender: TObject);
begin
  with Compra do // para valores as properties
  begin
    Case RgProdutos.ItemIndex of // para exemplificar o case
      0:
        begin
          Produto := 'Corsa 1.0';
          valor := 'R$ 30,00';
        end;
      1:
        begin
          Produto := 'Sabão em pó';
          valor := 'R$ 150,00';
        end;
      2:
        begin
          Produto := 'Galinha Caipira';
          valor := 'R$ 80,00';
        end;
      3:
        begin
          Produto := 'Revista Playboy';
          valor := 'R$ 50,00';
        end;
    end; // end case
    Data := Formatdatetime('dd/mm/yyyy', date);
    ChaveCliente := Cliente.DsPesquisa.DataSet.fieldbyname('id').asinteger;
    if Inserir then // operação incluir
    begin
      Application.MessageBox('O registro incluído com sucesso !',
        'Confirmação', MB_OK);
    end
    else
    begin
      Application.MessageBox('O registro não foi incluído!', 'Atenção', MB_OK);
    end;
  end;
end;

procedure TfrmInsereCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // antes de fechar dar um refresh no grid
  Compra.Selecionar(0, frmPrincipal.DBGridMaster.DataSource.DataSet.fieldbyname
    ('id').AsInteger, '', 'Produto');
end;

procedure TfrmInsereCompra.FormCreate(Sender: TObject);
begin
  // Observem, o cliente aqui é o mesmo usado no formPrincipal...
  lblClienteSelecionado.Caption := Cliente.DsPesquisa.DataSet.fieldbyname
    ('Nome').asstring;
end;

end.
