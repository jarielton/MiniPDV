unit uCompras;

interface

uses DB, SysUtils, uConn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TCompras = class
  private
    FChave: integer;
    FChaveCliente: integer;
    FValor: string;
    FProduto: string;
    FData: string;
    FQry: TFDQuery;
    FQryPesquisa: TFDQuery;
    FDs: TDataSource;
    FDsPesquisa: TDataSource;
    Conexao: TConn;
    procedure SetChave(const Value: integer);
    procedure SetChaveCliente(const Value: integer);
    procedure SetData(const Value: string);
    procedure SetDs(const Value: TDataSource);
    procedure SetDsPesquisa(const Value: TDataSource);
    procedure SetProduto(const Value: string);
    procedure SetQry(const Value: TFDQuery);
    procedure SetQryPesquisa(const Value: TFDQuery);
    procedure SetValor(const Value: string);
  public
    constructor Create(Conn: TConn); // utiliza a classe de conexão

    // Propriedades
    property Chave: integer read FChave write SetChave;
    property Produto: string read FProduto write SetProduto;
    property Valor: string read FValor write SetValor;
    // ou Real
    property Data: string read FData write SetData;
    // ou TDatetime
    property ChaveCliente: integer read FChaveCliente write SetChaveCliente;
    // Componentes
    property Qry: TFDQuery read FQry write SetQry;
    property QryPesquisa: TFDQuery read FQryPesquisa write SetQryPesquisa;
    property Ds: TDataSource read FDs write SetDs;
    property DsPesquisa: TDataSource read FDsPesquisa write SetDsPesquisa;
    // Métodos
    function Selecionar(Chave, ChaveCliente: integer;
      Produto, Ordem: String): Boolean;
    function Inserir: Boolean;
    function Alterar: Boolean;
    function Deletar(Chave: integer): Boolean;

  end;

implementation

{ TCompras }

function TCompras.Alterar: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Update Compras Set ' + ' Produto = :Produto,' +
      ' Valor = :Valor,' + ' Data = :Data,' + ' idCliente = :idCliente' +
      ' Where ' + ' id = :id';
    // Observe a utilização dos Fileds (FChave,Fnome...etc...)
    ParamByName('id').Value := FChave;
    ParamByName('Produto').Value := FProduto;
    ParamByName('Valor').Value := FValor;
    ParamByName('Data').Value := FData;
    ParamByName('idCliente').Value := ChaveCliente;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

constructor TCompras.Create(Conn: TConn);
begin
  { No create é passada a conection das Qrys }
  Conexao := Conn;
  Qry := TFDQuery.Create(nil);
  Ds := TDataSource.Create(nil);
  QryPesquisa := TFDQuery.Create(nil);
  DsPesquisa := TDataSource.Create(nil);
  Qry.Connection := Conexao.Conn;
  QryPesquisa.Connection := Conexao.Conn;
  Ds.DataSet := Qry;
  DsPesquisa.DataSet := QryPesquisa;
end;

function TCompras.Deletar(Chave: integer): Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' delete from Compras' + ' where id = :Chave';
    ParamByName('Chave').Value := Chave;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TCompras.Inserir: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Insert into Compras' + ' (Produto, Valor, Data, idCliente)' +
      ' Values ' + ' (:Produto, :Valor, :Data, :idCliente)';
    ParamByName('Produto').Value := FProduto;
    ParamByName('Valor').Value := FValor;
    ParamByName('Data').Value := FData;
    ParamByName('idCliente').Value := ChaveCliente;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TCompras.Selecionar(Chave, ChaveCliente: integer;
  Produto, Ordem: String): Boolean;
begin
  { Observe que posso buscar por id da compra ou id do cliente }
  Produto := '%' + Produto + '%';
  with QryPesquisa do
  begin
    Close;
    SQL.Text := ' Select * from Compras where 1=1 ';
    if Chave > 0 then
    begin
      SQL.add(' and id = :Chave');
      ParamByName('Chave').Value := Chave;
    end;
    if ChaveCliente > 0 then
    begin
      SQL.add(' and idCliente = :ChaveCliente');
      ParamByName('ChaveCliente').Value := ChaveCliente;
    end;
    if Produto <> '' then
      SQL.add(' and Produto like ' + quotedstr(Produto));
    if Ordem <> '' then
      SQL.add(' Order by ' + Ordem);
    try
      Open;
      if not eof then
        Result := true
      else
        Result := False;
    except
      Result := False;
    end;
  end; // end do begin with Qrypesquisa do end;
end;

procedure TCompras.SetChave(const Value: integer);
begin
  FChave := Value;
end;

procedure TCompras.SetChaveCliente(const Value: integer);
begin
  FChaveCliente := Value;
end;

procedure TCompras.SetData(const Value: string);
begin
  FData := Value;
end;

procedure TCompras.SetDs(const Value: TDataSource);
begin
  FDs := Value;
end;

procedure TCompras.SetDsPesquisa(const Value: TDataSource);
begin
  FDsPesquisa := Value;
end;

procedure TCompras.SetProduto(const Value: string);
begin
  FProduto := Value;
end;

procedure TCompras.SetQry(const Value: TFDQuery);
begin
  FQry := Value;
end;

procedure TCompras.SetQryPesquisa(const Value: TFDQuery);
begin
  FQryPesquisa := Value;
end;

procedure TCompras.SetValor(const Value: string);
begin
  FValor := Value;
end;

end.
