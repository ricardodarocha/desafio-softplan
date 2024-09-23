program DesafioDelphiCep;

uses
  Vcl.Forms,
  menu in 'menu.pas' {frmMenu},
  form.cep in 'form.cep.pas' {frmAppBuscarCep},
  model.cep in 'model.cep.pas',
  Controller in 'Controller.pas',
  interf.iterator in 'interf.iterator.pas',
  dataset.iterator.concrete in 'dataset.iterator.concrete.pas',
  dataset.utils in 'dataset.utils.pas',
  CepPanelComponent in 'CepPanelComponent.pas',
  CepMapperComponent in 'CepMapperComponent.pas',
  module.rest.suport in 'module.rest.suport.pas' {api: TDataModule},
  module.database.suport in 'module.database.suport.pas' {dados: TDataModule},
  strings.utils in 'strings.utils.pas',
  interfaces in 'interfaces.pas',
  Service in 'Service.pas',
  module.rest.json in 'module.rest.json.pas' {apiJson: TDataModule},
  module.soap.xml in 'module.soap.xml.pas' {apiXml: TDataModule},
  Strategy in 'Strategy.pas',
  Strategy.Json in 'Strategy.Json.pas',
  Strategy.Xml in 'Strategy.Xml.pas',
  interf.result in 'interf.result.pas',
  form.manutencao in 'form.manutencao.pas' {Manutencao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(Tdados, dados);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmAppBuscarCep, frmAppBuscarCep);
  Application.CreateForm(TapiJson, apiJson);
  Application.CreateForm(TapiXml, apiXml);
  Application.CreateForm(TManutencao, Manutencao);
  Application.Run;
end.
