unit CTM.Backend.Bond;

interface

uses
  CTM.Models.Connection, CTM.Models.User , CTM.Modules.Startapp,
  SysUtils,
  Data.Win.ADODB
  ;

procedure CTMConnect;
procedure CTMDisconnect;

implementation

procedure CTMConnect;
  var
    q: TADOQuery;
  begin
    q := TADOQuery.Create(NIL);
    q.Connection := CTMConnection;

    q.SQL.Add(
      'exec CTMUsers#login '
      + QuotedStr(CTMUser.Username)
      + ','
      + QuotedStr(CTMUser.Password)
    );

    q.Open;

    if q.RecordCount = 1 then
      begin
        CTMUser.ID := q.FieldValues['ID'];
        CTMUser.Auth := True;
      end
    else
      begin
        CTMUser.ID := -1;
        CTMUser.Auth := False;
        raise Exception.Create('Неверное имя пользователя или пароль (При попытке соединения)');
      end;

  end;

procedure CTMDisconnect;
  begin
    CTMConnection.Reset;
    CTMUser.Reset;
  end;

end.
