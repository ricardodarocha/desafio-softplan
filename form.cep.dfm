object frmAppBuscarCep: TfrmAppBuscarCep
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio de Busca de Cep'
  ClientHeight = 710
  ClientWidth = 1078
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TLabel
    Left = 50
    Top = 30
    Width = 51
    Height = 24
    Caption = 'Teste'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 376
    Height = 710
    HorzScrollBar.Visible = False
    VertScrollBar.Smooth = True
    VertScrollBar.Style = ssFlat
    VertScrollBar.Tracking = True
    Align = alLeft
    BorderStyle = bsNone
    TabOrder = 0
    object Shape1: TShape
      Left = 32
      Top = 19
      Width = 297
      Height = 40
      Pen.Color = 12615808
      Shape = stRoundRect
    end
    object Shape3: TShape
      Left = 32
      Top = 209
      Width = 297
      Height = 40
      Pen.Color = 12615808
      Shape = stRoundRect
    end
    object Shape4: TShape
      Left = 33
      Top = 161
      Width = 297
      Height = 40
      Pen.Color = 12615808
      Shape = stRoundRect
    end
    object Shape5: TShape
      Left = 32
      Top = 114
      Width = 297
      Height = 40
      Pen.Color = 12615808
      Shape = stRoundRect
    end
    object Bevel1: TBevel
      Left = 29
      Top = 104
      Width = 305
      Height = 4
    end
    object edtCEP: TEdit
      Left = 37
      Top = 26
      Width = 289
      Height = 26
      Alignment = taCenter
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Century Gothic'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      Text = '36515-000'
      TextHint = 'digite seu CEP'
      OnKeyPress = press_enter_cep
    end
    object btnBuscarEndereco: TButton
      Left = 33
      Top = 255
      Width = 297
      Height = 30
      Caption = 'Buscar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BuscarEndereco
    end
    object Panel1: TPanel
      Left = 29
      Top = 296
      Width = 341
      Height = 401
      TabOrder = 5
      object Image2: TImage
        Left = 296
        Top = 24
        Width = 16
        Height = 17
        Picture.Data = {
          07544269746D617036040000424D360400000000000036000000280000001000
          0000100000000100200000000000000400000000000000000000000000000000
          0000C49A8CFFB07462FFAF7461FFAF7460FFAE735FFFAE735FFFAE725FFFAD71
          5EFFAD715EFFAC705CFFAC705CFFAC6F5BFFAC6F5BFFAB6F5BFFAB6E5AFFC095
          86FFB67E6CFFFBF6F3FFFAF5F2FFFAF5F2FFFAF5F2FFFAF5F2FFFAF5F1FFFAF4
          F1FFFAF4F1FFF9F4F0FFF9F4F0FFF9F3F0FFF8F3EFFFF9F3EFFFF8F2EEFFB379
          68FFB77F6FFFFBF7F4FFC89167FFC89167FFC89167FFC89167FFC89167FFC791
          66FFC79066FFC79066FFC79066FFC79066FFC79065FFC79065FFF9F4F0FFB47B
          6AFFB88171FFFBF8F5FFC99369FFC89268FFC89268FFC89268FFC89268FFC892
          68FFC89267FFC89167FFC89167FFC89167FFC89167FFC79166FFFAF4F2FFB47C
          6BFFB98472FFFCF9F7FFF8F0ECFFF8F1ECFFF7F0ECFFF7F0ECFFF7F0EBFFF8F0
          EBFFF7F0EBFFF7F0EAFFF7EFEAFFF7EFE9FFF7EFE9FFF6EFEAFFFAF6F3FFB67F
          6DFFBB8674FFBB8573FFBA8473FFBA8473FFB98472FFB98472FFB98472FFB984
          72FFB98472FFB98372FFB98371FFB98371FFB98371FFB88371FFB98271FFB780
          6FFFBB8674FFFDFAF8FFF8F1EDFFF8F2EEFFF8F2EEFFF8F2EEFFF8F2EDFFF7F1
          EDFFF8F0ECFFF8F0ECFFF8F0EBFFF7F0EBFFF7EFEAFFF7F0EAFFFAF7F5FFB780
          6FFFBB8674FFFDFAF8FFCB976FFFCB976EFFCB976EFFCB976EFFCB976EFFCB96
          6DFFCB966DFFCA966DFFCA966DFFF8F0ECFFF7F0ECFFF7F0EAFFFAF7F5FFB780
          6FFFBF8C7AFFFEFCFBFFCC9970FFCC9870FFCC9870FFCC9870FFCC986FFFCB98
          6FFFCB976FFFCB976FFFCB976EFFF8F3EFFFF8F3EEFFF9F2EEFFFCFAF9FFBB86
          75FFC08D7DFFFEFDFCFFFAF5F2FFFAF6F3FFFAF6F2FFFAF6F2FFFAF5F2FFFAF5
          F1FFF9F4F1FFF9F4F0FFF9F3F0FFF8F3EFFFF8F3EFFFF9F3F0FFFDFBFAFFBC88
          77FFC28F7EFFBE8B7AFFBE8A79FFBE8B79FFBD8A78FFBD8A78FFBD8A78FFBE89
          78FFBE8978FFBC8978FFBC8977FFBD8977FFBD8977FFBC8877FFBC8876FFBE8A
          79FFC39281FFFEFEFDFFFBF7F4FFFBF7F4FFFAF7F5FFFAF7F5FFFBF7F4FFFAF6
          F4FFFAF6F4FFFAF6F3FFFAF6F2FFF9F5F2FFF9F5F2FFF9F6F2FFFDFCFCFFBF8D
          7BFFC49483FFFFFEFEFFCF9E77FFCF9E77FFCF9D76FFCF9D76FFCE9D76FFCE9D
          76FFFBF7F5FFFAF6F4FFFBF6F3FFFAF6F3FFF9F6F3FFFAF6F3FFFEFDFCFFC08F
          7EFFC59584FFFFFEFEFFD09F78FFD09F78FFCF9F78FFCF9F78FFCF9E77FFCF9E
          77FFFBF8F5FFFCF8F5FFFBF8F5FFFBF7F4FFFBF7F4FFFBF7F4FFFEFDFDFFC290
          7FFFC69786FFFFFFFEFFFFFFFEFFFFFEFEFFFFFFFEFFFFFFFEFFFFFEFEFFFFFE
          FEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFFFEFEFFFFFEFDFFFEFEFDFFC392
          81FFD9B8ADFFCFA494FFCFA393FFCEA393FFCEA393FFCEA393FFCEA292FFCEA2
          92FFCDA292FFCDA191FFCDA090FFCCA090FFCC9F8FFFCB9E8EFFCB9E8EFFD3B1
          A5FF}
      end
      object console: TMemo
        Left = 0
        Top = 311
        Width = 341
        Height = 89
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMedGray
        Font.Height = -11
        Font.Name = 'System'
        Font.Style = []
        Lines.Strings = (
          'sistema iniciado')
        ParentFont = False
        TabOrder = 0
      end
      object radio_json: TRadioButton
        Left = 16
        Top = 24
        Width = 113
        Height = 17
        Caption = 'JSON'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = True
      end
      object radio_xml: TRadioButton
        Left = 135
        Top = 24
        Width = 113
        Height = 17
        Caption = 'XML'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object PanelCep1: TPanelCep
        Left = 0
        Top = 48
        Width = 341
        Height = 257
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Caption = '<Ir'#225' renderizar em RunTime>'
        Color = 8454016
        ParentBackground = False
        TabOrder = 3
      end
    end
    object edtLogradouro: TEdit
      Left = 37
      Top = 215
      Width = 289
      Height = 26
      Alignment = taCenter
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TextHint = 'Nome da Rua'
      OnKeyPress = press_enter_endereco
    end
    object EdtLocalidade: TEdit
      Left = 37
      Top = 168
      Width = 289
      Height = 26
      Alignment = taCenter
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      TextHint = 'Cidade'
      OnKeyPress = proximoControle
    end
    object cbUf: TComboBox
      Left = 46
      Top = 118
      Width = 278
      Height = 32
      AutoDropDown = True
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkSoft
      BevelOuter = bvNone
      CharCase = ecUpperCase
      DropDownCount = 16
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'Selecione o Estado'
      OnKeyPress = proximoControle
      Items.Strings = (
        'AC ACRE '
        'AL ALAGOAS '
        'AP AMAP'#193' '
        'AM AMAZONAS '
        'BA BAHIA '
        'CE CEAR'#193' '
        'DF DISTRITO FEDERAL '
        'ES ESP'#205'RITO SANTO '
        'GO GOI'#193'S '
        'MA MARANH'#195'O '
        'MT MATO GROSSO '
        'MS MATO GROSSO DO SUL '
        'MG MINAS GERAIS '
        'PA PAR'#193' '
        'PB PARA'#205'BA '
        'PR PARAN'#193' '
        'PE PERNAMBUCO '
        'PI PIAU'#205' '
        'RJ RIO DE JANEIRO '
        'RN RIO GRANDE DO NORTE '
        'RS RIO GRANDE DO SUL '
        'RO ROND'#212'NIA '
        'RR RORAIMA '
        'SC SANTA CATARINA '
        'SP S'#195'O PAULO '
        'SE SERGIPE '
        'TO TOCANTINS ')
    end
    object btnBuscarCep: TButton
      Left = 33
      Top = 65
      Width = 296
      Height = 30
      Caption = 'Buscar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = buscarCep
    end
  end
  object DBGrid1: TDBGrid
    Left = 376
    Top = 0
    Width = 702
    Height = 710
    Align = alClient
    DataSource = FonteDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object FonteDados: TDataSource
    OnDataChange = FonteDadosDataChange
    Left = 752
    Top = 104
  end
  object AdaptadorCep: TCepMapperComponent
    Left = 688
    Top = 176
  end
end
