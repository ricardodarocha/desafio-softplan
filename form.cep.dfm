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
      Left = 28
      Top = 352
      Width = 341
      Height = 249
      TabOrder = 5
      Visible = False
      object lbLogradouro: TLabel
        Left = 72
        Top = 32
        Width = 234
        Height = 29
        AutoSize = False
        Caption = 'LOGRADOURO'
        WordWrap = True
      end
      object Image2: TImage
        Left = 17
        Top = 16
        Width = 32
        Height = 32
      end
      object lbBairro: TLabel
        Left = 72
        Top = 67
        Width = 234
        Height = 13
        AutoSize = False
        Caption = 'LOGRADOURO'
      end
      object lbCidade: TLabel
        Left = 72
        Top = 86
        Width = 234
        Height = 13
        AutoSize = False
        Caption = 'LOGRADOURO'
      end
      object lbIBGE: TLabel
        Left = 72
        Top = 121
        Width = 234
        Height = 32
        AutoSize = False
        Caption = 'LOGRADOURO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
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
    object console: TMemo
      Left = 28
      Top = 607
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
      TabOrder = 7
    end
    object radio_json: TRadioButton
      Left = 40
      Top = 296
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
      TabOrder = 8
      TabStop = True
    end
    object radio_xml: TRadioButton
      Left = 159
      Top = 296
      Width = 113
      Height = 17
      Caption = 'XML'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Century Gothic'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
  end
  object DBGrid1: TDBGrid
    Left = 376
    Top = 0
    Width = 702
    Height = 710
    Align = alClient
    DataSource = source_dados
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
  object source_dados: TDataSource
    OnDataChange = source_dadosDataChange
    Left = 1008
    Top = 32
  end
end
