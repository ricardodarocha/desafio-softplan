object api: Tapi
  OldCreateOrder = False
  Height = 534
  Width = 737
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://viacep.com.br/ws/'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 96
    Top = 88
  end
  object RESTRequestBuscaCep: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'CEP'
        Options = [poAutoCreated]
        Value = '36507158'
      end>
    Resource = '{CEP}/json'
    Response = RESTResponseCep
    SynchronizedEvents = False
    Left = 136
    Top = 152
  end
  object RESTResponseCep: TRESTResponse
    ContentType = 'application/json'
    Left = 304
    Top = 152
  end
  object RESTRequestBuscaEndereco: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'uf'
        Options = [poAutoCreated]
        Value = 'SP'
      end
      item
        Kind = pkURLSEGMENT
        name = 'localidade'
        Options = [poAutoCreated]
        Value = 'S'#227'o Paulo'
      end
      item
        Kind = pkURLSEGMENT
        name = 'logradouro'
        Options = [poAutoCreated]
        Value = 'Morumbi'
      end>
    Resource = '{uf}/{localidade}/{logradouro}/json'
    Response = RESTResponseEndereco
    SynchronizedEvents = False
    Left = 136
    Top = 208
  end
  object RESTResponseEndereco: TRESTResponse
    Left = 304
    Top = 208
  end
end
