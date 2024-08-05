unit uProdutos;

interface

uses DB, SysUtils, uConn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TProdutos = class
  private
    FId: integer;
    FDescricao: string;
    FPreco: double;
    FQry: TFDQuery;
    FQryPesquisa: TFDQuery;
    FDs: TDataSource;
    FDsPesquisa: TDataSource;
    Conexao: TConn;
    procedure SetId(const Value: integer);
    procedure SetDescricao(const Value: string);
    procedure SetPreco(const Value: double);

    procedure SetDs(const Value: TDataSource);
    procedure SetDsPesquisa(const Value: TDataSource);
    procedure SetQry(const Value: TFDQuery);
    procedure SetQryPesquisa(const Value: TFDQuery);
  public
    constructor Create(Conn: TConn);

    property Id: integer read FId write SetId;
    property Preco: double read FPreco write SetPreco;
    property Descricao: string read FDescricao write SetDescricao;

    property Qry: TFDQuery read FQry write SetQry;
    property QryPesquisa: TFDQuery read FQryPesquisa write SetQryPesquisa;
    property Ds: TDataSource read FDs write SetDs;
    property DsPesquisa: TDataSource read FDsPesquisa write SetDsPesquisa;

    function Inserir: Boolean;
    function Alterar: Boolean;
    function Deletar(Id: integer): Boolean;
    function Selecionar(Id: Integer): Boolean;

  end;

implementation

{ TProdutos }

function TProdutos.Alterar: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Update Produto Set ' +
      ' Preco = :Preco,' + ' Descricao = :Descricao' +
      ' Where ' + ' id = :id';
    ParamByName('Preco').AsFloat := FPreco;
    ParamByName('Descricao').AsString := FDescricao;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

constructor TProdutos.Create(Conn: TConn);
begin
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

function TProdutos.Deletar(Id: integer): Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' delete from Produto' + ' where id = :Id';
    ParamByName('Id').Value := Id;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TProdutos.Inserir: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Insert into Produto' + ' ( Descricao, Preco)' +
      ' Values ' + ' (:Descricao, :Preco)';
    ParamByName('Descricao').Value := FDescricao;
    ParamByName('Preco').AsFloat := FPreco;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TProdutos.Selecionar(Id: Integer): Boolean;
begin
  with QryPesquisa do
  begin
    Close;
    SQL.Text := ' Select * from Produto where 1=1 ';
    if Id > 0 then
    begin
      SQL.add(' and id = :Id');
      ParamByName('Id').Value := Id;
    end;

    try
      Open;
      if not eof then
        Result := true
      else
        Result := False;
    except
      Result := False;
    end;
  end;
end;

procedure TProdutos.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TProdutos.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProdutos.SetPreco(const Value: double);
begin
  FPreco := Value;
end;

procedure TProdutos.SetDs(const Value: TDataSource);
begin
  FDs := Value;
end;

procedure TProdutos.SetDsPesquisa(const Value: TDataSource);
begin
  FDsPesquisa := Value;
end;

procedure TProdutos.SetQry(const Value: TFDQuery);
begin
  FQry := Value;
end;

procedure TProdutos.SetQryPesquisa(const Value: TFDQuery);
begin
  FQryPesquisa := Value;
end;

end.
