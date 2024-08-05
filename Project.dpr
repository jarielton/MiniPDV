program Project;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  uPDV in 'Viewer\uPDV.pas' {frmPDV},
  uConn in 'DataModule\Connect\uConn.pas',
  DM in 'DataModule\DM.pas' {uDM: TDataModule},
  uVenda in 'Controller\uVenda.pas',
  uVendasItens in 'Controller\uVendasItens.pas',
  uProdutos in 'Controller\uProdutos.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TuDM, uDM);
  Application.Run;

end.
