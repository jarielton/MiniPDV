unit uVenda;

interface

uses DB, SysUtils, uConn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.SQLiteWrapper;

type
  TVendas = class
  private
    FId: integer;
    FIdCliente: integer;
    FTotal: double;
    FDtEmissao: string;
    FQry: TFDQuery;
    FQryPesquisa: TFDQuery;
    FDs: TDataSource;
    FDsPesquisa: TDataSource;
    Conexao: TConn;
    procedure SetId(const Value: integer);
    procedure SetIdCliente(const Value: integer);
    procedure SetDtEmissao(const Value: string);
    procedure SetDs(const Value: TDataSource);
    procedure SetDsPesquisa(const Value: TDataSource);
    procedure SetQry(const Value: TFDQuery);
    procedure SetQryPesquisa(const Value: TFDQuery);
    procedure SetTotal(const Value: double);
  public
    constructor Create(Conn: TConn);

    property Id: integer read FId write SetId;
    property Total: double read FTotal write SetTotal;
    property Data: string read FDtEmissao write SetDtEmissao;
    property IdCliente: integer read FIdCliente write SetIdCliente;
    property Qry: TFDQuery read FQry write SetQry;
    property QryPesquisa: TFDQuery read FQryPesquisa write SetQryPesquisa;
    property Ds: TDataSource read FDs write SetDs;
    property DsPesquisa: TDataSource read FDsPesquisa write SetDsPesquisa;
    function Inserir: Boolean;
    function Alterar: Boolean;
    function Deletar(Id: integer): Boolean;

  end;

implementation

{ TVendas }

function TVendas.Alterar: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Update pedidos Set ' +
      ' valor_total = :Total, data_emissao = :Data, codigo_cliente = :idCliente' +
      ' Where numero_pedido = :id';
    ParamByName('id').AsInteger := FId;
    ParamByName('Total').AsFloat := FTotal;
    ParamByName('Data').AsDate := StrToDate(FDtEmissao);
    ParamByName('idCliente').AsInteger := IdCliente;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

constructor TVendas.Create(Conn: TConn);
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

function TVendas.Deletar(Id: integer): Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' delete from pedidos where numero_pedido = :Id';
    ParamByName('Id').Value := Id;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TVendas.Inserir: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Insert into pedidos (valor_total, data_emissao, codigo_cliente)' +
      ' Values (:Total, :Data, :idCliente)';
    ParamByName('Total').AsFloat := FTotal;
    ParamByName('Data').AsString := FormatDateTime('yyyy-MM-dd', now);
    ParamByName('idCliente').AsInteger := IdCliente;
    try
      ExecSQL;
      Close;
      SQL.Text := 'SELECT LAST_INSERT_ID() as ID';
      Open;
      FId := FieldByName('ID').AsInteger;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

procedure TVendas.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TVendas.SetIdCliente(const Value: integer);
begin
  FIdCliente := Value;
end;

procedure TVendas.SetDtEmissao(const Value: string);
begin
  FDtEmissao := Value;
end;

procedure TVendas.SetTotal(const Value: double);
begin
  FTotal := Value;
end;

procedure TVendas.SetDs(const Value: TDataSource);
begin
  FDs := Value;
end;

procedure TVendas.SetDsPesquisa(const Value: TDataSource);
begin
  FDsPesquisa := Value;
end;

procedure TVendas.SetQry(const Value: TFDQuery);
begin
  FQry := Value;
end;

procedure TVendas.SetQryPesquisa(const Value: TFDQuery);
begin
  FQryPesquisa := Value;
end;

end.
