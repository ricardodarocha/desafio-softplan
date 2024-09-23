unit interfaces;

interface

  uses
    Data.Db,
    Model.Cep,
    Interf.Iterator,
    Vcl.Dialogs,
    System.SysUtils
  ;

  type
    IBuscaCepDomain = interface;
    IBuscaCepController = interface;
    IBuscaCepApiProvider = interface;
    IDatabaseRepository = interface;
    IBuscaCepView = interface;

    IBuscaCepDomain = interface
      ['{71DAB881-7101-43F7-9CA2-B52BAE1A9B84}']

      procedure BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);
      procedure BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);

      function PlugarViewObserver(AView: IBuscaCepView): IBuscaCepDomain;
      function PlugarDatabaseRepository(ADatabaseRepository: IDatabaseRepository): IBuscaCepDomain;
//
//      property View: IBuscaCepView;
//      property ApiProvider: IBuscaCepApiProvider;
//      property DatabaseRepository: IDatabaseRepository;

    end;

    IBuscaCepController = interface
      ['{48F07E3B-8DE1-4BD0-9D8D-F77D5ACC6742}']

      procedure BuscarCep(const ACep: String; AApiProvider: IBuscaCepApiProvider);
      procedure BuscarEndereco(const AEndereco, ACidade, AUf: String; AApiProvider: IBuscaCepApiProvider);
//
//      property Service: IBuscaCepDomain;
//      property View: IBuscaCepView;

    end;

    IBuscaCepApiProvider = interface
      ['{0FCE75D8-D490-4030-9651-FA63BC3ECCEE}']

      function SetupBaseUrl(const BaseUrl: String = 'http://viacep.com.br/ws'): IBuscaCepApiProvider;
      procedure BuscarCep(const ACep: String);
      procedure BuscarEndereco(const AEndereco, ACidade, AUf: String);
      procedure SetOnReceive(e: TDatasetNotifyEvent);
      procedure SetOnReceiveAll(e: TDatasetNotifyEvent);
      procedure SetOnResponse(f: TProc<TCepResponse>);
      procedure SetOnResponseMany(f: TProc<TCepResponse>);
      function getString: String;
      function getResponse: TCepResponse;
      property Response: TCepResponse read getResponse;

    end;

    IDatabaseRepository = interface
      ['{C1FFD738-3D96-4C41-B0BC-56872A41E9AB}']

      function SetupDatabase(const DatabaseFile: String = 'database/cepdb.sqlite'): IDatabaseRepository;
      function BuscarCep(const ACep: String): TDataset;
      function MostrarTodos: TDataset;
      function BuscarEndereco(const AEndereco, ACidade, AUf: String): TDataset;
      procedure ExcluirCep(ACep: String);
      procedure IncluirEndereco(ACep, ALogradouro, AComplemento, ABairro, ALocalidade, AUf: String);
  end;

    IBuscaCepView = interface
      ['{06A898E7-01C8-41B4-AF95-4889C823A9CF}']
        procedure ExibirCepDb(ADataset: Tdataset);
        procedure ExibirCepApi(ACep: TEndereco);
        procedure ExibirCepDto(Acep: TEnderecoDto);
        procedure Mensagem(AMenasgem: String; tipo: TMsgDlgType);
        procedure Log(AMensagem: String; const Alfa: String = ''; Beta: String = ''; Gama: String = '');
    end;

implementation

end.
