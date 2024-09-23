unit form.cep;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Variants,
  System.UITypes,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Interfaces,  // Todas as abstrações
  Controller,  // Controlador
  Strategy,    // XML | Json
  Model.Cep;   // Modelos

type

  TfrmAppBuscarCep = class(TForm, IBuscaCepView)
    ScrollBox1: TScrollBox;
    edtCEP: TEdit;
    btnBuscarEndereco: TButton;
    Panel1: TPanel;
    lbLogradouro: TLabel;
    Image2: TImage;
    lbBairro: TLabel;
    lbCidade: TLabel;
    lbIBGE: TLabel;
    DBGrid1: TDBGrid;
    Shape1: TShape;
    edtLogradouro: TEdit;
    Shape3: TShape;
    EdtLocalidade: TEdit;
    Shape4: TShape;
    Shape5: TShape;
    cbUf: TComboBox;
    btnBuscarCep: TButton;
    Bevel1: TBevel;
    console: TMemo;
    source_dados: TDataSource;
    radio_json: TRadioButton;
    radio_xml: TRadioButton;
    procedure press_enter_cep(Sender: TObject; var Key: Char);
    procedure buscarCep(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure proximoControle(Sender: TObject; var Key: Char);
    procedure press_enter_endereco(Sender: TObject; var Key: Char);
    procedure BuscarEndereco(Sender: TObject);
    procedure source_dadosDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
  private
    FController: IBuscaCepController;
    procedure Notify (message: String; Logradouro, Localidade, Uf: String);

    procedure ExibirCepDb(ADataset: Tdataset);
    procedure ExibirCepApi(ACep: TEndereco);
    procedure ExibirCepDto(Acep: TEnderecoDto);
    procedure Mensagem(AMenasgem: String; tipo: TMsgDlgType);
    procedure Log(AMensagem: String; const Alfa: String = ''; Beta: String = ''; Gama: String = '');

    //Retorna a estratégia selecionada pelo usuário (Xml ou Json)
    function ApiProvider: IBuscaCepApiProvider;
  public
    { Public declarations }
  end;

var
  frmAppBuscarCep: TfrmAppBuscarCep;

implementation

{$R *.dfm}

uses
  Module.Database.Suport,
  Module.Rest.Suport,
  Winapi.Messages,
  Module.Rest.Json,
  Module.Soap.Xml;


procedure TfrmAppBuscarCep.FormDestroy(Sender: TObject);
begin
  FController := nil;
end;

procedure TfrmAppBuscarCep.FormShow(Sender: TObject);
begin
  FController := TCepController.Create(Self, Dados);
//  FController.MostrarTodos;
end;

procedure TfrmAppBuscarCep.Log(AMensagem: String; const Alfa: String; Beta, Gama: String);
begin
  console.lines.add(format('%s %s %s %s ', [AMensagem,
    Alfa,
    Beta,
    Gama]));
end;

procedure TfrmAppBuscarCep.Mensagem(AMenasgem: String; tipo: TMsgDlgType);
begin
  case Tipo of
    MTInformation, MTError, MtWarning: MessageDlg(AMenasgem, tipo, [mbok],0);
    MTConfirmation: MessageDlg(AMenasgem, tipo, [mbYes, Mbno],0);
    Else Showmessage(AMenasgem);
  end;
end;

function TfrmAppBuscarCep.ApiProvider: IBuscaCepApiProvider;
begin
  if radio_json.checked then
    Result := ApiJson
  else
    Result := ApiXml;
end;

procedure TfrmAppBuscarCep.ExibirCepApi(ACep: TEndereco);
begin
  console.lines.add(format('%s %s %s %s ', ['consulta na API...',
    ACep.Logradouro,
    ACep.Cidade,
    ACep.uf]));
end;

procedure TfrmAppBuscarCep.ExibirCepDb(ADataset: Tdataset);
begin
  Source_Dados.dataset := ADataset;
  Notify('Uma nova tabela foi atribuída', '{', ADataset.RecordCount.toString, 'resultado(s) }');
end;

procedure TfrmAppBuscarCep.ExibirCepDto(Acep: TEnderecoDto);
begin
  if Assigned(ACep) then
    Notify('Um cep foi encontrado no banco de dados', '[', Acep.Cep ,']');
end;

procedure TfrmAppBuscarCep.Notify(message, Logradouro, Localidade, Uf: String);
begin
  console.lines.add(format('%s %s %s %s ', [message, logradouro, localidade, uf]));
end;

procedure TfrmAppBuscarCep.press_enter_cep(Sender: TObject; var Key: Char);
begin
  if key = #13 then buscarCep(Sender);
end;

procedure TfrmAppBuscarCep.BuscarCep(Sender: TObject);
begin
  FController.Buscarcep(edtCep.Text, ApiProvider);
end;

procedure TfrmAppBuscarCep.press_enter_endereco(Sender: TObject; var Key: Char);
begin
  if key = #13 then BuscarEndereco(Sender);
end;

procedure TfrmAppBuscarCep.BuscarEndereco(Sender: TObject);
begin
  FController.BuscarEndereco( EdtLogradouro.Text, edtLocalidade.Text, CbUF.Text, ApiProvider);
end;

procedure TfrmAppBuscarCep.proximoControle(Sender: TObject; var Key: Char);
begin
  if key = #13 then perform(Wm_nextDlgCtl, 0,0);
end;

procedure TfrmAppBuscarCep.source_dadosDataChange(Sender: TObject; Field: TField);

begin
  TThread.Synchronize( nil,
  procedure
  var col: Integer;
  begin
    for col := 0 to DBGrid1.Columns.Count -1 do
    try
      if Assigned(DBGrid1.Columns.Items[col]) then
        DBGrid1.Columns.Items[col].Width := 80;
    finally

    end;
  end);


end;

//   [ VIEW ]  --> Controller --> Service --> Infra {Xml, Json, Database}

end.




