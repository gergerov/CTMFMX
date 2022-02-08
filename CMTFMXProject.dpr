program CMTFMXProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {Form1},
  mInfoAboutForm in 'mInfoAboutForm.pas',
  uFamalyTree in '..\UNITS\uFamalyTree.pas',
  uTreeViewBuilder in '..\UNITS\uTreeViewBuilder.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
