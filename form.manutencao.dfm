object Manutencao: TManutencao
  Left = 0
  Top = 0
  Caption = 'Manutencao'
  ClientHeight = 596
  ClientWidth = 996
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 265
    Top = 0
    Width = 731
    Height = 596
    Align = alClient
    DataSource = source_dados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 596
    Align = alLeft
    TabOrder = 1
    DesignSize = (
      265
      596)
    object btnBuscarCep: TSpeedButton
      Left = 8
      Top = 15
      Width = 246
      Height = 49
      Caption = 'LIMPAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btnBuscarCepClick
    end
    object btnFechar: TSpeedButton
      Left = 8
      Top = 541
      Width = 246
      Height = 49
      Anchors = [akLeft, akBottom]
      Caption = 'FECHAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btnFecharClick
    end
  end
  object source_dados: TDataSource
    DataSet = dados.listar_todos
    OnDataChange = source_dadosDataChange
    Left = 712
    Top = 120
  end
end
