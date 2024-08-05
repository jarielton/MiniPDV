unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.ComCtrls, Vcl.WinXPanels, Vcl.Buttons;

type
  TfrmMain = class(TForm)
    pnlPDV: TPanel;
    cPanel: TCardPanel;
    cStart: TCard;
    cClient: TCard;
    edCliente: TEdit;
    pnlHeader: TPanel;
    lblDate: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pnlNovo: TPanel;
    Label5: TLabel;
    lblNovo: TLabel;
    pnlSair: TPanel;
    Label7: TLabel;
    lblSair: TLabel;
    lblSelectCliente: TLabel;
    GridClientes: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    lblCancel: TLabel;
    Label13: TLabel;
    pnlBtns: TPanel;
    Label11: TLabel;
    pnlCenter: TPanel;
    lblConfirmar: TLabel;
    Timer1: TTimer;
    procedure edClienteChange(Sender: TObject);
    procedure edClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lblConfirmarClick(Sender: TObject);
    procedure lblCancelClick(Sender: TObject);
    procedure lblNovoClick(Sender: TObject);
    procedure lblSairClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
          { Private declarations }
  public
          { Public declarations }
end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  DM, uPDV;

procedure TfrmMain.edClienteChange(Sender: TObject);
begin
  uDM.TBClient.Filtered := False;
  uDM.TBClient.Filter := 'NOME LIKE ' +
    QuotedStr('%' + edCliente.Text + '%');
  uDM.TBClient.Filtered := True;
end;

procedure TfrmMain.edClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 38 then
    uDM.TBClient.prior;
  if Key = 40 then
    uDM.TBClient.next;
end;

procedure TfrmMain.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if (cPanel.ActiveCard = cClient) then
    begin
      if (Msg.CharCode = 13) then
        lblConfirmarClick(Self);
    end
  else
    if Msg.CharCode = 113 then
      lblNovoClick(Self);

  if Msg.CharCode = 27 then
    lblSairClick(Self);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  pnlCenter.Left := (Screen.Width div 2) - (pnlCenter.Width div 2);
  pnlCenter.Top := (Screen.Height div 2) - (pnlCenter.Height div 2) - 100;
end;

procedure TfrmMain.lblCancelClick(Sender: TObject);
begin
  cPanel.ActiveCard := cStart;
  uDM.TBClient.Filtered := False;
end;

procedure TfrmMain.lblConfirmarClick(Sender: TObject);
var
  frmPDV: TfrmPDV;
begin
  if uDM.TBClientID.AsInteger > 0 then
  begin
    frmPDV := TfrmPDV.Create(nil);
    try
      cPanel.ActiveCard := cStart;
      uDM.TBClient.Filtered := False;
      frmPDV.idClient := uDM.TBClientID.AsInteger;
      frmPDV.ShowModal;
    finally
      frmPDV.Free;
    end;
  end;

end;

procedure TfrmMain.lblNovoClick(Sender: TObject);
begin
  cPanel.ActiveCard := cClient;
  edCliente.SetFocus;
end;

procedure TfrmMain.lblSairClick(Sender: TObject);
begin
  if application.MessageBox('Deseja fechar aplicação ?','ATENÇÃO',MB_YESNO + MB_ICONWARNING)=MRYES then
    Close;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  lblDate.Caption := FormatDateTime('HH:mm DD/MM/YYYY', Now);
end;

end.
