program CMTFMXProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  main in 'main.pas' {FormMain},
  mInfoAboutForm in 'mInfoAboutForm.pas',
  uFamalyTree in '..\UNITS\uFamalyTree.pas',
  uTreeViewBuilder in '..\UNITS\uTreeViewBuilder.pas',
  uADOConnectionSetup in '..\UNITS\uADOConnectionSetup.pas',
  uConnectionForm in 'forms\uConnectionForm.pas' {FormConnection},
  uCustomUser in '..\UNITS\uCustomUser.pas',
  uPointList in 'forms\Point\uPointList.pas' {FormPointList},
  uFormCenter in '..\UNITS\uFormCenter.pas',
  uPointCrud in 'forms\Point\uPointCrud.pas' {FormPointCrud};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormPointList, FormPointList);
  Application.CreateForm(TFormPointCrud, FormPointCrud);
  Application.Run;

end.
