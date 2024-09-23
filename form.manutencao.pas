unit form.manutencao;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  module.database.suport;

type
  TManutencao = class(TForm)
    DBGrid1: TDBGrid;
    source_dados: TDataSource;
    Panel1: TPanel;
    btnBuscarCep: TSpeedButton;
    btnFechar: TSpeedButton;
    procedure btnFecharClick(Sender: TObject);
    procedure source_dadosDataChange(Sender: TObject; Field: TField);
    procedure btnBuscarCepClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CarregarDados;
  end;

var
  Manutencao: TManutencao;

implementation

uses
  Vcl.Dialogs,
  System.UITypes;

{$R *.dfm}

procedure TManutencao.btnBuscarCepClick(Sender: TObject);
begin
  if messageDlg('Tem certeza que deseja excluir todos os CEPs da base local?', mtConfirmation, [mbYes, MbNo],0 ) = mrYes  then
  begin
    Dados.LimparTodos;
    CarregarDados;
  end;
end;

procedure TManutencao.btnFecharClick(Sender: TObject);
begin
close;
end;

procedure TManutencao.CarregarDados;
begin
  Dados.MostrarTodos;
end;

procedure TManutencao.FormActivate(Sender: TObject);
begin
  CarregarDados;
end;

procedure TManutencao.source_dadosDataChange(Sender: TObject; Field: TField);
begin
  TThread.Synchronize( nil,
  procedure
  var col: Integer;
  begin
    for col := 0 to DBGrid1.Columns.Count -1 do
      DBGrid1.Columns.items[col].Width := 80;
  end);


end;

end.
