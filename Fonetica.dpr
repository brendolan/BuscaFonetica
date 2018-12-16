program Fonetica;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {FrmFonetica},
  untFonetica in 'untFonetica.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmFonetica, FrmFonetica);
  Application.Run;
end.
