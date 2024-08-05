unit DM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TuDM = class(TDataModule)
    dsClient: TDataSource;
    TBProductID: TIntegerField;
    TBProductDESCRICAO: TStringField;
    TBProductPRECO: TFloatField;
    dsProduct: TDataSource;
    dsVendas: TDataSource;
    TBVenda: TFDMemTable;
    TBItens: TFDMemTable;
    IntegerField1: TIntegerField;
    dsItens: TDataSource;
    TBVendaID: TIntegerField;
    TBVendaDT_EMISSAO: TDateField;
    TBVendaID_CLIENT: TIntegerField;
    TBVendaTOTAL: TFloatField;
    TBItensID_VENDA: TIntegerField;
    TBItensID_PRODUCT: TIntegerField;
    TBItensQTD: TFloatField;
    TBItensVALOR_UN: TFloatField;
    TBItensTOTAL: TFloatField;
    TBItensPRODUTO: TStringField;
    TBClient: TFDMemTable;
    TBClientID: TIntegerField;
    TBClientNOME: TStringField;
    TBClientCIDADE: TStringField;
    TBClientUF: TStringField;
    TBProduct: TFDMemTable;
    procedure TBItensCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uDM: TuDM;

implementation

{$R *.dfm}

procedure TuDM.TBItensCalcFields(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('TOTAL').AsFloat := FieldByName('VALOR_UN').AsFloat *
      FieldByName('QTD').AsFloat;
  end;
end;

end.
