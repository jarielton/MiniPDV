unit uConnect;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TdmX = class(TDataModule)
    Conn: TFDConnection;
    procedure connAfterConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmX: TdmX;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmX.connAfterConnect(Sender: TObject);
begin
     Conn.ExecSQL('CREATE TABLE IF NOT EXISTS Clientes( id int IDENTITY(1,1) NOT NULL, '+
                  ' Nome varchar(50),       '+
                  ' Endereco varchar(50),   '+
                  ' Telefones varchar(50),  '+
                  ' Obs varchar(200) );     ');
     Conn.ExecSQL('CREATE TABLE IF NOT EXISTS Compras( id int IDENTITY(1,1) NOT NULL, '+
                  ' Produto varchar(50),       '+
                  ' Valor varchar(50), Data varchar(50), idCliente int );     ');
//    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS conta (id INTEGER, email VARCHAR(100));');
//    Conn.ExecSQL('CREATE TABLE IF NOT EXISTS char (id INTEGER, char VARCHAR(100));');
end;

procedure TdmX.DataModuleCreate(Sender: TObject);
begin
  with Conn do
  begin
    DriverName := 'SQLite';
    {$IFDEF MSWINDOWS}
    Params.Values['Database'] := System.SysUtils.GetCurrentDir + '\DB\banco.db';
    {$ELSE}
    Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco.db');
    {$ENDIF}
  end;
end;

end.
