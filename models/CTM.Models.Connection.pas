unit CTM.Models.Connection;

interface

uses
  Data.Win.ADODB,
  System.SysUtils, System.Classes
  ;

const
  CTMConnectionTimeout: integer = 10;
  CTMCommandTimeout: integer = 10;

type
  TCTMConnection = Class(TADOConnection)
    public
      constructor Create(AOwner: TComponent); override;
      procedure Reset;

  End;

implementation

constructor TCTMConnection.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);
    ConnectionTimeout := CTMConnectionTimeout;
    CommandTimeout := CTMCommandTimeout;
  end;

procedure TCTMConnection.Reset;
  begin
    ConnectionString := '';
  end;

end.
