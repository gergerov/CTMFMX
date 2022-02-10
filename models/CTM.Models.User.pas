unit CTM.Models.User;

interface uses
  System.Hash, System.Classes,
  SysUtils,
  Data.Win.ADODB,
  FMX.Dialogs
;

Type
  TCTMUser = class(TComponent)
    public
      procedure SetUsername(Value: string);
      procedure SetPassword(Value: string);
      procedure SetId(Value: integer);
      procedure SetAuth(Value: boolean);
      procedure Reset;

      constructor Create(AOwner: TComponent); override;
    private
      FId: integer;
      FPassword: string;
      FUsername: string;
      FAuth: boolean;
    published
      property Id: integer read FId write SetId;
      property Username: string read FUsername write SetUsername;
      property Password: string read FPassword write SetPassword;
      property Auth: boolean read FAuth write SetAuth;
  end;

implementation

constructor TCTMUser.Create(AOwner: TComponent);
  begin
    FUsername := '';
  end;

procedure TCTMUser.SetUsername(Value: string);
  begin
    if FUsername <> Value then
      begin
        FUsername := Value;
      end;
  end;

procedure TCTMUser.SetPassword(Value: string);
  begin
    if FPassword <> THashMD5.GetHashString(Value) then
      begin
        FPassword := THashMD5.GetHashString(Value);
      end;
  end;

procedure TCTMUser.SetId(Value: Integer);
  begin
    if FId <> Value then
      begin
        FId := Value;
      end;
  end;

procedure TCTMUser.SetAuth(Value: Boolean);
  begin
    if FAuth <> Value then
      begin
        FAuth := Value;
      end;
  end;

procedure TCTMUser.Reset;
  begin
    Id := 0;
    Username := '';
    Password := '';
    Auth := False;
  end;

end.
