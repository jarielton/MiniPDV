unit uConn;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TConn = class

  public
    Conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure connAfterConnect(Sender: TObject);
    procedure connBeforeConnect(Sender: TObject);

    constructor Create;
  end;

implementation

{ TConn }

constructor TConn.Create;
begin
  Conn := TFDConnection.Create(nil);
  Conn.Params.Values['LockingMode'] := 'Normal';
  Conn.Params.Values['DriverID'] := 'SQLite';

  Conn.LoginPrompt := False;
  Conn.AfterConnect := connAfterConnect;
  Conn.BeforeConnect := connBeforeConnect;
end;


procedure TConn.connAfterConnect(Sender: TObject);
begin
  try
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS Produto( Id INTEGER PRIMARY KEY '+
                ' AUTOINCREMENT NOT NULL,     '+
                ' Descricao varchar(30),       '+
                ' Preco REAL );     ');
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS Clientes( Id INTEGER PRIMARY KEY '+
                ' AUTOINCREMENT NOT NULL, '+
                ' Nome varchar(30),       '+
                ' Cidade varchar(20),   '+
                ' Uf varchar(2),  '+
                ' Obs varchar(200) );     ');
    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS Vendas( Id INTEGER PRIMARY KEY '+
                ' AUTOINCREMENT NOT NULL, '+
                ' Id_Cliente INTEGER,       '+
                ' Dt_Emissao NUMERIC,       '+
                ' Total REAL );     ');

    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS VendasItens( Id INTEGER PRIMARY KEY '+
                ' AUTOINCREMENT NOT NULL, '+
                ' Id_Venda INTEGER,       '+
                ' Id_Produto INTEGER,       '+
                ' Qtd REAL, ValorUn REAL, Total REAL );     ');
  except on e:exception do
    raise Exception.Create('Erro de conexao com o banco de dados: ' + e.Message);
  end;
end;

procedure TConn.connBeforeConnect(Sender: TObject);
begin
    conn.DriverName := 'SQLite';

    {$IFDEF MSWINDOWS}
    conn.Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\DB\banco.db';
    {$ELSE}
    conn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}
end;

procedure TConn.DataModuleCreate(Sender: TObject);
begin
    try
        Conn.Connected := true;
    except on e:exception do
        raise Exception.Create('Erro de conexao com o banco de dados: ' + e.Message);
    end;
end;

end.
