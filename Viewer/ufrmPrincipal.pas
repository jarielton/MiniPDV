unit ufrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls, uConn, uClientes,
  uCompras, Menus, ufrmInsereCompra, Data.DB,
  //-------------------------------------------------------------------------------
  Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

type
  TfrmPrincipal = class(TForm)
    DBGridMaster: TDBGrid;
    DBGridDetail: TDBGrid;
    DBNavMaster: TDBNavigator;
    DBNavDetail: TDBNavigator;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridMasterCellClick(Column: TColumn);
    procedure DBGridMasterDblClick(Sender: TObject);
    procedure DBGridDetailDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  Conn: TConn;
  Cliente: TClientes;
  Compra: TCompras;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    Conn := TConn.Create; // cria o obj de conexão e conecta
    Cliente := TClientes.Create(Conn);
    // cria o obj cliente e vicula o mesmo a conexão
    Compra := TCompras.Create(Conn); // cria o obj compra...
    Cliente.Selecionar(0, '', 'Nome');
    DBGridMaster.DataSource := Cliente.DsPesquisa;
    DBNavMaster.DataSource := Cliente.DsPesquisa;
    DBGridDetail.DataSource := Compra.DsPesquisa;
    DBNavDetail.DataSource := Compra.DsPesquisa;
  except
   on E: Exception do
    ShowMessage('Erro: ' + E.Message );
  end;
end;

procedure TfrmPrincipal.DBGridDetailDblClick(Sender: TObject);
begin // deleta registro
  if Compra.Deletar(DBGridDetail.DataSource.DataSet.FieldByName('id').AsInteger)
  then
  begin
    Application.MessageBox('Registro deletado com sucesso!',
      'Confirmação', MB_OK);
  end
  else
  begin
    Application.MessageBox('O registro não foi deletado!', 'Atenção', MB_OK);
  end;
  // refresh no grid
  Compra.Selecionar(0, DBGridMaster.DataSource.DataSet.FieldByName('id')
    .AsInteger, '', 'Produto ');
end;

procedure TfrmPrincipal.DBGridMasterCellClick(Column: TColumn);
begin
  { Com um clique realiza um select na tabela de compras }
  Compra.Selecionar(0, DBGridMaster.DataSource.DataSet.FieldByName('id')
    .AsInteger, '', 'Produto ');
end;

procedure TfrmPrincipal.DBGridMasterDblClick(Sender: TObject);
var
  frmVende: TfrmInsereCompra;
begin
  // chama form de venda
  try
    frmVende := TfrmInsereCompra.Create(nil);
    frmVende.ShowModal;
  finally
    FreeandNil(frmVende);
  end;

end;

end.
