unit CepPanelComponent;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Model.Cep,
  CepMapperComponent;

type
  TPanelCep = class(TPanel)
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  private
    FEndereco: TCepMapperComponent;
    FLabelLogradouro: TLabel;
    FLabelCidade: TLabel;
    FLabelUf: TLabel;
    FLabelCep: TLabel;

    procedure Render;
    procedure SetEndereco(const Value: TCepMapperComponent);

  protected
    { Protected declarations }
  public
    procedure Atualize;
  published
    property Endereco: TCepMapperComponent read FEndereco write SetEndereco;
    property LabelCep: TLabel read FLabelCep;
    property LabelLogradouro: TLabel read FLabelLogradouro;
    property LabelCidade: TLabel read FLabelCidade;
    property LabelUf: TLabel read FLabelUf;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TPanelCep]);
end;

{ TPanelCep }

procedure TPanelCep.Atualize;
begin
  Render;
end;

constructor TPanelCep.Create(AOwner: TComponent);
Const
  FONTSIZE = 16;
  MARGINLEFT = 50;
  MARGINTOP = 30;
  GAP = 20;
  FONTNAME = 'Century Gothic';
begin
  inherited;
  { 0 }
  FLabelCep := TLabel.Create(AOwner);
  FLabelCep.Name := 'LabelCEP1';
  FLabelCep.Parent := self;
  FLabelCep.Left := MARGINLEFT;
  FLabelCep.Top := MARGINTOP + GAP * 0;
  FLabelCep.font.Name := FONTNAME;
  FLabelCep.font.Size := FONTSIZE;
  { 1 }
  FLabelLogradouro := TLabel.Create(AOwner);
  FLabelLogradouro.Name := 'LabelLOGRADOURO1';
  FLabelLogradouro.Parent := self;
  FLabelLogradouro.parent := Self;
  FLabelLogradouro.Left := MARGINLEFT;
  FLabelLogradouro.Top := MARGINTOP + GAP * 1;
  FLabelLogradouro.font.Name := FONTNAME;
  FLabelLogradouro.font.Size := FONTSIZE;
  { 2 }
  FLabelUf := TLabel.Create(AOwner);
  FLabelUf.Name := 'LabelUF1';
  FLabelUf.Parent := self;
  FLabelUf .parent := Self;
  FLabelUf .Left := MARGINLEFT;
  FLabelUf .Top := MARGINTOP + GAP * 2;
  FLabelUf .font.Name := FONTNAME;
  FLabelUf .font.Size := FONTSIZE;
  { 3 }
  FLabelCidade := TLabel.Create(AOwner);
  FLabelCidade.Name := 'LabelCIDADE1';
  FLabelCidade.Parent := self;
  FLabelCidade.parent := Self;
  FLabelCidade.Left := MARGINLEFT;
  FLabelCidade.Top := MARGINTOP + GAP * 3;
  FLabelCidade.font.Name := FONTNAME;
  FLabelCidade.font.Size := FONTSIZE;

  Self.BevelInner := bvSpace;
  Self.BevelOuter := bvLowered;
  Self.Caption := '<Irá renderizar em RunTime>' ;

end;

destructor TPanelCep.Destroy;
begin
  FreeAndNil(FLabelCep);
  FreeAndNil(FLabelLogradouro);
  FreeAndNil(FLabelCidade);
  FreeAndNil(FLabelUf);
  inherited;
end;

procedure TPanelCep.Render;
begin
  Self.Caption := '' ;
  Self.Parent := Self.Parent;
  Self.Visible := Self.Visible;

//  labelCidade.Repaint;
  Self.Invalidate;
end;

procedure TPanelCep.SetEndereco(const Value: TCepMapperComponent);
begin
  FEndereco := Value;
  FLabelLogradouro.Caption := Value.Logradouro;
  FLabelCidade.Caption :=  Value.Localidade;
  FLabelUf.Caption := Value.Uf;
  FLabelCep.Caption :=  Value.Cep;

  Render;
end;

initialization
  RegisterClass(TLabel);
  RegisterClass(TPanelCep);

end.
