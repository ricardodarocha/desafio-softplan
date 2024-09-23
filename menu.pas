unit menu;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Form.Manutencao;

type
  TfrmMenu = class(TForm)
    btnBuscarCep: TSpeedButton;
    Image1: TImage;
    btnFechar: TSpeedButton;
    btnManutencao: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnBuscarCepClick(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses
  form.cep;

{$R *.dfm}

procedure TfrmMenu.btnBuscarCepClick(Sender: TObject);
begin
  frmAppBuscarCep.Showmodal();
end;

procedure TfrmMenu.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMenu.btnManutencaoClick(Sender: TObject);
begin
  Manutencao.ShowModal;
end;

end.
