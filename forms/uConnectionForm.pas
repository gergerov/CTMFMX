unit uConnectionForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListBox,

  Data.Win.ADODB,

  uADOConnectionSetup,

  CTM.Modules.Startapp,
  CTM.Backend.Bond,
  CTM.Models.Connection, CTM.Models.User

  ;

type
  TFormConnection = class(TForm)
    panelLeft: TPanel;
    btnConnect: TButton;
    panelLeftTop: TPanel;
    gbIniFilePath: TGroupBox;
    labelIniFilePath: TLabel;
    editIniFilePath: TEdit;
    panelClient: TPanel;
    gbData: TGroupBox;
    labelConnectionSection: TLabel;
    btnReadIniFile: TButton;
    cbIniSection: TComboBox;
    labelUsername: TLabel;
    editUsername: TEdit;
    editPassword: TEdit;
    labelPassword: TLabel;
    OpenDialogIniFilePath: TOpenDialog;
    btnSearch: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure btnReadIniFileClick(Sender: TObject);
    procedure disableGBData;
    procedure activateGBData;
    procedure btnConnectClick(Sender: TObject);

  private
    { Private declarations }
  public
    ConnectionSetup: TADOConnectionSetup;
    ConnectionString: string;
//    CTMConnection: TADOConnection;
    ConnectionStatusInfo: string;
//    CTMUser: TCTMUser;
    { Public declarations }
  end;

var
  FormConnection: TFormConnection;

implementation
  uses main;
{$R *.fmx}

procedure TFormConnection.btnConnectClick(Sender: TObject);
  begin
//    FormMain.CTMUser.setConnectionString(ConnectionSetup.GetConnectionString(cbIniSection.Selected.Text));
//    FormMain.CTMUser.Auht(editUsername.Text, editPassword.Text);
//    CTMUser := TCTMuser.Create(NIL);
    CTMConnection.ConnectionString := ConnectionSetup.GetConnectionString(cbIniSection.Selected.Text);
    CTMUser.Username := editUsername.Text;
    CTMUser.Password := editUsername.Text;
    CTMConnect;
    if not CTMUser.Auth then
      begin
        ShowMessage('Неверное имя пользователя или пароль');
        ModalResult := mrCancel;
      end
    else
      begin
      ModalResult := mrOk;
      end;
  end;

procedure TFormConnection.btnReadIniFileClick(Sender: TObject);
  begin
    disableGBData;
    cbIniSection.Items.Clear;
    ConnectionSetup := TADOConnectionSetup.Create('MSSQL', editIniFilePath.Text);
    ConnectionSetup.SetSectionSelector(cbIniSection.Items);
    if cbIniSection.Count > 0 then
      begin
        cbIniSection.ItemIndex := 0;
        activateGBData;
        exit;
      end;
    ShowMessage('Нет данных для подключения');
  end;

procedure TFormConnection.btnSearchClick(Sender: TObject);
  begin
    if OpenDialogIniFilePath.Execute then
      begin
        editIniFilePath.Text := OpenDialogIniFilePath.FileName;
        btnReadIniFile.OnClick(btnReadIniFile);
      end;
  end;

procedure TFormConnection.FormCreate(Sender: TObject);
  begin
    Width := 450;
    Height := 450;
    left := (Screen.WorkAreaWidth - Width) div 2;
    top := (Screen.WorkAreaHeight - Height) div 2;
    disableGBData;
  end;

procedure TFormConnection.activateGBData;
  begin
    editUsername.Enabled := True;
    editPassword.Enabled := True;
    cbIniSection.Enabled := True;
    btnConnect.Enabled := True;
  end;

procedure TFormConnection.disableGBData;
  begin
    editUsername.Enabled := False;
    editPassword.Enabled := False;
    cbIniSection.Enabled := False;
    btnConnect.Enabled := False;
  end;

end.
