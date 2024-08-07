unit uConn;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IniFiles, FireDAC.Phys.MySQL;

type
  TConn = class

  public
    Conn: TFDConnection;
    MySQLDriver: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);

    constructor Create;
  end;

implementation

uses
  System.SysUtils, Vcl.Forms;

{ TConn }

constructor TConn.Create;
var pathExe, pathDll: String;
  ini: TIniFile;
begin
  pathExe := ExtractFileDir(Application.ExeName);
  ini := TIniFile.Create(pathExe + '\Banco.ini');

  MySQLDriver := TFDPhysMySQLDriverLink.Create(nil);
  MySQLDriver.VendorLib := ExtractFilePath(Application.ExeName) +
    'libmysql.dll';


  Conn := TFDConnection.Create(nil);

  Conn.Params.Values['DriverID']  := 'MySQL';
  Conn.Params.Values['Port']  := '3306';
  Conn.Params.Values['Database']  := ini.ReadString('DB', 'Database', '');
  Conn.Params.Values['User_Name'] := ini.ReadString('DB', 'User', '');
  Conn.Params.Values['Server']    := ini.ReadString('DB', 'IP', '');
  Conn.Params.Values['Password']  := ini.ReadString('DB', 'Pass', '');



  Conn.LoginPrompt := False;
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
