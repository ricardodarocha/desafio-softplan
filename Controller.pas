unit Controller;

interface

uses
  System.Classes,
  Data.Db,
  Model.Cep,
  Interfaces,
  Service;

type

  // O Controller Delega a operação para a camada de serviços, que possui as instâncias concretas da camada semântica e possui
  // um acesso mais próximo da infraestura
  TCepController = class(TInterfacedObject, IBuscaCepController)
  private
    FService: IBuscaCepDomain;

  public
    constructor Create(AView: IBuscaCepView; ADatabaseRepository: IDatabaseRepository);
    destructor Destroy; override;

    procedure BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);
    procedure BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);

  strict private
    property Service: IBuscaCepDomain read FService;

  end;

implementation

{ TCepController }

constructor TCepController.Create(AView: IBuscaCepView; ADatabaseRepository: IDatabaseRepository);
begin
  inherited Create;

  FService := TBuscaCepService.Create()
    .PlugarViewObserver(AView)
    .PlugarDatabaseRepository(ADatabaseRepository);

end;

destructor TCepController.Destroy;
begin
  FService := nil;
  inherited;
end;

procedure TCepController.BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);
begin
  Service.BuscarCep(ACep, AApiProvider)
end;

procedure TCepController.BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);
begin
  Service.BuscarEndereco(AEndereco, ACidade, AUf, AApiProvider);
end;

//   View  --> [ CONTROLLER ] --> Service --> Infra {Xml, Json, Database}

end.
