unit CepPanelComponent;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Model.Cep,
  Vcl.StdCtrls,
  CepMapperComponent;

type
  TPanelCep = class(TPanel)
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy;  override;
  private
    FEndereco: TCepMapperComponent;
    FLabelCidade: TLabel;

    procedure Render;
    procedure SetEndereco(const Value: TCepMapperComponent);
    procedure SetLabelCidade(const Value: TLabel);

  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property Endereco: TCepMapperComponent read FEndereco write SetEndereco;
    property LabelCidade: TLabel read FLabelCidade write SetLabelCidade;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Standard', [TPanelCep]);
end;

{ TPanelCep }

constructor TPanelCep.Create(AOwner: TComponent);
begin
  inherited;
  FLabelCidade := TLabel.Create(Aowner);
  FLabelCidade.parent := Self;
  FLabelCidade.Left := 50;
  FlabelCidade.Top := 30;
  FLabelCidade.font.Name := 'Century Gothic';
  FLabelCidade.font.Size := 16;
end;

destructor TPanelCep.Destroy;
begin
  FreeAndNil(FLabelCidade);
  inherited;
end;

procedure TPanelCep.Render;
begin
  labelCidade.caption := Endereco.Localidade;
  labelCidade.Repaint;
end;

procedure TPanelCep.SetEndereco(const Value: TCepMapperComponent);
begin
  FEndereco := Value;
  Self.render;
end;

procedure TPanelCep.SetLabelCidade(const Value: TLabel);
begin
  FLabelCidade := Value;
end;

end.
