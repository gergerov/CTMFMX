unit uConnectionForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.ListBox,

  uADOConnectionSetup
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
    { Public declarations }
  end;

var
  FormConnection: TFormConnection;


implementation

{$R *.fmx}

procedure TFormConnection.btnConnectClick(Sender: TObject);
  begin
    ConnectionString := ConnectionSetup.GetConnectionString(cbIniSection.Selected.Text);
    ModalResult := mrOk;
  end;

procedure TFormConnection.btnReadIniFileClick(Sender: TObject);
  begin
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
      end;
  end;

procedure TFormConnection.FormCreate(Sender: TObject);
  begin
    Width := 450;
    Height := 450;
    left := (Screen.WorkAreaWidth - Width) div 2;
    top := (Screen.WorkAreaHeight - Height) div 2;
    editIniFilePath.Text := '.\connection.ini';
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
