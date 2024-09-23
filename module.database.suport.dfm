object dados: Tdados
  OldCreateOrder = False
  Height = 405
  Width = 576
  object Conexao: TFDConnection
    Params.Strings = (
      'ConnectionDef=CepDb')
    LoginPrompt = False
    Left = 104
    Top = 104
  end
  object listar_todos: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from consultas')
    Left = 104
    Top = 168
  end
  object busca_cep: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from consultas where cep = :cep'
      'limit 1')
    Left = 104
    Top = 224
    ParamData = <
      item
        Name = 'CEP'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
  end
  object busca_endereco: TFDQuery
    Connection = Conexao
    SQL.Strings = (
      'select * from consultas '
      
        #10'WHERE (UPPER(Localidade) LIKE '#39'%'#39' || UPPER(:localidade) || '#39'%'#39' ' +
        'or UPPER(Localidade_) LIKE '#39'%'#39' || UPPER(:localidade) || '#39'%'#39') AND' +
        ' ( UPPER(UF) = UPPER(:uf)'#10'  ) '
      
        'and (UPPER(Logradouro) LIKE '#39'%'#39' || UPPER(:logradouro) || '#39'%'#39' or ' +
        'UPPER(Logradouro_) LIKE '#39'%'#39' || UPPER(:logradouro) || '#39'%'#39')'
      '   LIMIT 50')
    Left = 104
    Top = 280
    ParamData = <
      item
        Name = 'LOCALIDADE'
        DataType = ftString
        ParamType = ptInput
        Value = 'Belo Horiz'
      end
      item
        Name = 'UF'
        DataType = ftString
        ParamType = ptInput
        Value = 'MG'
      end
      item
        Name = 'LOGRADOURO'
        DataType = ftString
        ParamType = ptInput
        Value = 'Ephigenio'
      end>
  end
end
