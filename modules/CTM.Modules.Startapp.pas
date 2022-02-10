unit CTM.Modules.Startapp;

interface

uses
  CTM.Models.Connection, CTM.Models.User
  ;

var
  CTMConnection: TCTMConnection;
  CTMUser: TCTMUser;

  procedure CTMStartapp;

implementation

procedure CTMStartapp;
  begin
    CTMConnection := TCTMConnection.Create(NIL);
    CTMUser := TCTMUser.Create(NIL);
  end;

end.
