unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Rtti, System.Bindings.Outputs,
  System.Hash,

  IniFiles,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, FMX.Grid, FMX.Bind.DBEngExt, FMX.Bind.Editors,
  FMX.Bind.Grid, FMX.Grid.Style,

  uFamalyTree, uTreeViewBuilder, uADOConnectionSetup, uConnectionForm,
  uCustomUser, uPointList,

  Data.FMTBcd, Data.DB, Data.SqlExpr, FMX.Layouts, FMX.TreeView,

  Data.Bind.EngExt, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.Win.ADODB, FMX.ListBox, FMX.Edit;

type
  TFormMain = class(TForm)
    CTMConnection: TADOConnection;
    panelTop: TPanel;
    btnConnectionForm: TButton;
    btnDisconnect: TButton;
    labelStatusDBTime: TEdit;
    panelBot: TPanel;
    labelStatusUsername: TEdit;
    panelFuncs: TPanel;
    btnPoints: TButton;
    btnFlts: TButton;
    procedure btnConnectionFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnPointsClick(Sender: TObject);
    procedure disconnectedUI;
    procedure connectedUI;
  private
    { Private declarations }
  public
    CTMUser: TCTMUser;
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  Conset: TADOConnectionSetup;

implementation

{$R *.fmx}

procedure TFormMain.btnConnectionFormClick(Sender: TObject);
  var
    frm: TFormConnection;
  begin
    frm := TFormConnection.Create(NIL);
    frm.editUsername.Text := 'CTM';
    frm.editPassword.Text := 'CTM';
    frm.editIniFilePath.Text := 'F:\delphi_projects\CTMFMX\connection.ini';
    frm.btnReadIniFileClick(frm.btnReadIniFile);
//    frm.btnConnectClick(frm.btnConnect);
    frm.ShowModal;

    if frm.ModalResult = mrOk then
      begin
        connectedUI;
        labelStatusDBTime.Text :=
          'Connected at: '
          + DateToStr(Now()) + ' '
          + TimeToStr(Now());
        labelStatusUsername.Text :=
          'Name: ' + CTMUser.Username + '. '
          + 'ID: ' + IntToStr(CTMUser.ID);
      end;
    if frm.ModalResult = mrCancel then
      begin
        disconnectedUI;
      end;
    frm.Free;
  end;

procedure TFormMain.btnDisconnectClick(Sender: TObject);
  begin
    CTMUSer.isAuth := False;
    disconnectedUI;
    labelStatusDBTime.Text :=
      'Disconnected at: '
      + DateToStr(Now()) + ' '
      + TimeToStr(Now());
    labelStatusUsername.Text :=
      'Disconnected at: '
      + DateToStr(Now()) + ' '
      + TimeToStr(Now());
  end;

procedure TFormMain.btnPointsClick(Sender: TObject);
  var
    frm: TFormPointList;
  begin
    frm := TFormPointList.Create(self);
    frm.btnSelect.Enabled := False;
    frm.ShowModal;
  end;

procedure TFormMain.FormCreate(Sender: TObject);
  begin
    CTMUser := TCTMUser.Create;
    btnConnectionForm.OnClick(btnConnectionForm);
    Width := 1200;
    Height := 800;
    left := (Screen.WorkAreaWidth - Width) div 2;
    top := (Screen.WorkAreaHeight - Height) div 2;
  end;

procedure TFormMain.connectedUI;
  begin
    panelFuncs.Enabled := True;
    btnDisconnect.Enabled := True;
    btnConnectionForm.Enabled := False;
  end;

procedure TFormMain.disconnectedUI;
  begin
    panelFuncs.Enabled := False;
    btnDisconnect.Enabled := False;
    btnConnectionForm.Enabled := True;
  end;

end.
