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
  uPointCrud in 'forms\Point\uPointCrud.pas' {FormPointCrud},
  CTM.Modules.Startapp in 'modules\CTM.Modules.Startapp.pas',
  CTM.Models.Connection in 'models\CTM.Models.Connection.pas',
  CTM.Models.User in 'models\CTM.Models.User.pas',
  CTM.Backend.Bond in 'backend\CTM.Backend.Bond.pas',
  dataModule in 'dataModule.pas' {DataModule1: TDataModule};

var
  CTMConnection: TCTMConnection;
  CTMUser: TCTMUser;
{$R *.res}

begin
  Application.Initialize;

  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;



end.
