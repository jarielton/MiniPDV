unit uVendasItens;

interface

uses DB, SysUtils, uConn, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TVendasItens = class
  private
    FId: integer;
    FidVenda: integer;
    FidProduto: integer;
    FProduto: string;
    FQtd: double;
    FValorUn: double;
    FQry: TFDQuery;
    FQryPesquisa: TFDQuery;
    FDs: TDataSource;
    FDsPesquisa: TDataSource;
    Conexao: TConn;
    procedure SetId(const Value: integer);
    procedure SetidVenda(const Value: integer);
    procedure SetidProduto(const Value: integer);
    procedure SetProduto(const Value: string);
    procedure SetQtd(const Value: double);
    procedure SetValorUn(const Value: double);

    procedure SetDs(const Value: TDataSource);
    procedure SetDsPesquisa(const Value: TDataSource);
    procedure SetQry(const Value: TFDQuery);
    procedure SetQryPesquisa(const Value: TFDQuery);

    function InserirDB: Boolean;
    function Descricao(Id: Integer): String;
  public
    constructor Create(Conn: TConn);

    property Id: integer read FId write SetId;
    property Qtd: double read FQtd write SetQtd;
    property ValorUn: double read FValorUn write SetValorUn;
    property idVenda: integer read FidProduto write SetidVenda;
    property idProduto: integer read FidProduto write SetidProduto;
    property Produto: string read FProduto write SetProduto;

    property Qry: TFDQuery read FQry write SetQry;
    property QryPesquisa: TFDQuery read FQryPesquisa write SetQryPesquisa;
    property Ds: TDataSource read FDs write SetDs;
    property DsPesquisa: TDataSource read FDsPesquisa write SetDsPesquisa;

    function Inserir: Boolean;
    function Alterar: Boolean;
    function Deletar(Id: integer): Boolean;
    function GravaItens(iVenda: Integer): Boolean;
    function Selecionar(Id: Integer): Boolean;

  end;

implementation

{ TVendasItens }

uses
  DM;

constructor TVendasItens.Create(Conn: TConn);
begin
  Conexao := Conn;
  Qry := TFDQuery.Create(nil);
  Ds := TDataSource.Create(nil);
  QryPesquisa := TFDQuery.Create(nil);
  DsPesquisa := TDataSource.Create(nil);
  Qry.Connection := Conexao.Conn;
  QryPesquisa.Connection := Conexao.Conn;
  Ds.DataSet := Qry;
  DsPesquisa.DataSet := uDM.TBItens;
end;

function TVendasItens.Deletar(Id: integer): Boolean;
begin
  uDM.TBItens.Delete;
end;

function TVendasItens.Inserir: Boolean;
begin
  with uDM.TBItens do
  begin
    Insert;
    uDM.TBItensID_VENDA.Value := FidVenda;
    uDM.TBItensID_PRODUCT.Value := FidProduto;
    uDM.TBItensQTD.AsFloat := FQtd;
    uDM.TBItensVALOR_UN.AsFloat := FValorUn;
    uDM.TBItensTOTAL.AsFloat := FQtd * FValorUn;
    uDM.TBItensPRODUTO.AsString :=  Descricao(FidProduto);
    try
      Post;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TVendasItens.Alterar: Boolean;
begin
  with uDM.TBItens do
  begin
    Edit;
    uDM.TBItensQTD.AsFloat := FQtd;
    uDM.TBItensVALOR_UN.AsFloat := FValorUn;
    uDM.TBItensTOTAL.AsFloat := FQtd * FValorUn;
    try
      Post;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TVendasItens.GravaItens(iVenda: Integer): Boolean;
begin
  with uDM.TBItens do
  begin
    First;
    while not Eof do
    begin
      FidVenda    := iVenda;
      FidProduto  := uDM.TBItensID_PRODUCT.AsInteger;
      FQtd        := uDM.TBItensQTD.AsFloat;
      FValorUn    := uDM.TBItensVALOR_UN.AsFloat;
      InserirDB;
      try
        Next;
        Result := true;
      except
        Result := False;
      end;
    end;
    Close;
    CreateDataSet;
  end;
end;

function TVendasItens.InserirDB: Boolean;
begin
  with Qry do
  begin
    Close;
    SQL.Text := ' Insert into pedidos_produtos (numero_pedido, codigo_produto,' +
    ' quantidade, valor_unitario, valor_total) Values (:idVenda, :idProduto, :Qtd,' +
    ' :ValorUn, :Total)';
    ParamByName('idVenda').Value := FidVenda;
    ParamByName('idProduto').Value := FidProduto;
    ParamByName('Qtd').AsFloat := FQtd;
    ParamByName('ValorUn').AsFloat := FValorUn;
    ParamByName('Total').AsFloat := FQtd * FValorUn;
    try
      ExecSQL;
      Result := true;
    except
      Result := False;
    end;
  end;
end;

function TVendasItens.Selecionar(Id: Integer): Boolean;
begin
  if ID = 0 then
    DsPesquisa.DataSet := uDM.TBItens
  else
  begin
    with QryPesquisa do
    begin
      Close;
      SQL.Text := ' Select id, numero_pedido N_Pedido, codigo_produto '+
      ' Cod_Produto, descricao, quantidade QTD, valor_unitario Preço, '+
      ' valor_total Total from pedidos_produtos pp '+
      ' INNER JOIN produtos p ON pp.codigo_produto = p.codigo';
      if Id > 0 then
      begin
        SQL.add(' where numero_pedido = :Id');
        ParamByName('Id').Value := Id;
      end;

      try
        Open;
        TNumericField(QryPesquisa.FieldByName('Preço')).DisplayFormat :=  '#0.00';
        TNumericField(QryPesquisa.FieldByName('Total')).DisplayFormat :=  '#0.00';
        if not eof then
          Result := true
        else
          Result := False;
      except
        Result := False;
      end;
    end;
    DsPesquisa.DataSet := QryPesquisa;
  end;
end;

function TVendasItens.Descricao(Id: Integer): String;
begin

  with QryPesquisa do
  begin
    Close;
    SQL.Text := ' Select descricao from produtos where 1=1 ';
    if Id > 0 then
    begin
      SQL.add(' and codigo = :Id');
      ParamByName('Id').Value := Id;
    end;

    try
      Open;
      if not eof then
        Result := FieldByName('Descricao').AsString
      else
        Result := '';
    except
      Result := '';
    end;
  end;
end;

procedure TVendasItens.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TVendasItens.SetidVenda(const Value: integer);
begin
  FidVenda := Value;
end;

procedure TVendasItens.SetidProduto(const Value: integer);
begin
  FidProduto := Value;
end;

procedure TVendasItens.SetProduto(const Value: string);
begin
  FProduto := Value;
end;

procedure TVendasItens.SetValorUn(const Value: double);
begin
  FValorUn := Value;
end;

procedure TVendasItens.SetQtd(const Value: double);
begin
  FQtd := Value;
end;

procedure TVendasItens.SetDs(const Value: TDataSource);
begin
  FDs := Value;
end;

procedure TVendasItens.SetDsPesquisa(const Value: TDataSource);
begin
  FDsPesquisa := Value;
end;

procedure TVendasItens.SetQry(const Value: TFDQuery);
begin
  FQry := Value;
end;

procedure TVendasItens.SetQryPesquisa(const Value: TFDQuery);
begin
  FQryPesquisa := Value;
end;

end.
