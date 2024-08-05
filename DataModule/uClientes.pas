unit uClientes;

interface

uses DB, SysUtils, uConn, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client;
type

  TClientes = class
  private
    FObs: string;
    FNome: string;
    FChave: integer;
    FEndereco: string;
    FTelefone: string;
    FQry: TFDQuery;
    FDs: TDataSource;
    Conexao: TConn;
    FDsPesquisa: TDataSource;
    FQryPesquisa: TFDQuery;
    procedure SetChave(const Value: integer);
    procedure SetEndereco(const Value: string);
    procedure SetNome(const Value: string);
    procedure SetObs(const Value: string);
    procedure SetTelefone(const Value: string);
    procedure SetDs(const Value: TDataSource);
    procedure SetQry(const Value: TFDQuery);
    procedure SetDsPesquisa(const Value: TDataSource);
    procedure SetQryPesquisa(const Value: TFDQuery);
  published

  public
    constructor Create(Conn: TConn); // utiliza a classe de conexão
    // Propriedades
    property Chave: integer read FChave write SetChave;
    property Nome: string read FNome write SetNome;
    property Endereco: string read FEndereco write SetEndereco;
    property Telefone: string read FTelefone write SetTelefone;
    property Obs: string read FObs write SetObs;
    // Componentes
    property Qry: TFDQuery read FQry write SetQry;
    property QryPesquisa: TFDQuery read FQryPesquisa write SetQryPesquisa;
    property Ds: TDataSource read FDs write SetDs;
    property DsPesquisa: TDataSource read FDsPesquisa write SetDsPesquisa;
    // Métodos
    function Selecionar(Chave: integer; Nome, Ordem: String): Boolean;
    function Inserir: Boolean;
    function Alterar: Boolean;
    function Deletar(Chave: integer): Boolean;
  end;

implementation

{ TClientes }

function TClientes.Alterar: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Update Clientes Set ' + ' Nome = :Nome,' +
      ' Endereco = :Endereco,' + ' Telefones = :Telefones,' + ' Obs = :Obs' +
      ' Where ' + ' id = :id';
    // Observe a utilização dos Fileds (FChave,Fnome...etc...)
    ParamByName('id').Value := FChave;
    ParamByName('Nome').Value := FNome;
    ParamByName('Endereco').Value := FEndereco;
    ParamByName('Telefones').Value := FTelefone;
    ParamByName('Obs').Value := FObs;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

constructor TClientes.Create(Conn: TConn);
begin
  try
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
  except
   on E: Exception do
    ShowMessage('Erro: ' + E.Message );
  end;
end;

function TClientes.Deletar(Chave: integer): Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' delete from Clientes' + ' where id = :Chave';
    ParamByName('Chave').Value := Chave;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TClientes.Inserir: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Insert into Clientes' + ' (Nome, Endereco, Telefones, Obs)' +
      ' Values ' + ' (:Nome, :Endereco, :Telefones, :Obs)';
    // Observe a utilização dos Fileds (FChave,Fnome...etc...)
    ParamByName('Nome').Value := FNome;
    ParamByName('Endereco').Value := FEndereco;
    ParamByName('Telefones').Value := FTelefone;
    ParamByName('Obs').Value := FObs;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TClientes.Selecionar(Chave: integer; Nome, Ordem: String): Boolean;
begin
  Nome := '%' + Nome + '%';
  with QryPesquisa do
  begin
    Close;
    SQL.Text := ' Select * from Clientes where 1=1 ';
    if Chave > 0 then
    begin
      SQL.add(' and id = :Chave');
      ParamByName('Chave').Value := Chave;
    end;

    if Nome <> '' then
      SQL.add(' and Nome like ' + quotedstr(Nome));

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
  end;
end;

procedure TClientes.SetChave(const Value: integer);
begin
  FChave := Value;
end;

procedure TClientes.SetDs(const Value: TDataSource);
begin
  FDs := Value;
end;

procedure TClientes.SetDsPesquisa(const Value: TDataSource);
begin
  FDsPesquisa := Value;
end;

procedure TClientes.SetEndereco(const Value: string);
begin
  FEndereco := Value;
end;

procedure TClientes.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TClientes.SetObs(const Value: string);
begin
  FObs := Value;
end;

procedure TClientes.SetQry(const Value: TFDQuery);
begin
  FQry := Value;
end;

procedure TClientes.SetQryPesquisa(const Value: TFDQuery);
begin
  FQryPesquisa := Value;
end;

procedure TClientes.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

end.
