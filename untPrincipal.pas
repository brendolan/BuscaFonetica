unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmFonetica = class(TForm)
    edtEntrada: TEdit;
    edtSaida: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure edtEntradaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFonetica: TFrmFonetica;

implementation

{$R *.dfm}

uses untFonetica;

procedure TFrmFonetica.edtEntradaChange(Sender: TObject);
begin
  edtSaida.Text := TFonetica.GetCodigoFonetico(edtEntrada.Text);
end;

end.
