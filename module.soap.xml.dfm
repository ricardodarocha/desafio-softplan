inherited apiXml: TapiXml
  OldCreateOrder = True
  inherited RESTRequestBuscaCep: TRESTRequest
    Resource = '{CEP}/xml'
  end
  inherited RESTResponseCep: TRESTResponse
    ContentType = 'application/xhtml+xml'
  end
  inherited RESTRequestBuscaEndereco: TRESTRequest
    Resource = '{uf}/{localidade}/{logradouro}/xml'
  end
  inherited RESTResponseEndereco: TRESTResponse
    ContentType = 'application/xhtml+xml'
  end
  object FDMemTableXml: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 304
    Top = 272
  end
end
