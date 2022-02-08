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
  uCustomUser,

  Data.FMTBcd, Data.DB, Data.SqlExpr, FMX.Layouts, FMX.TreeView,

  Data.Bind.EngExt, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.Win.ADODB, FMX.ListBox, FMX.Edit;

type
  TFormMain = class(TForm)
    TreeView1: TTreeView;
    CTMConnection: TADOConnection;
    panelTop: TPanel;
    btnConnectionForm: TButton;
    btnDisconnect: TButton;
    labelStatusDBTime: TEdit;
    panelBot: TPanel;
    labelStatusUsername: TEdit;
    procedure btnConnectionFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
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
    q: TADOQuery;
  begin
    frm := TFormConnection.Create(NIL);
    // предустановка на ПК
    frm.editUsername.Text := 'CTM';
    frm.editPassword.Text := 'CTM';
    frm.editIniFilePath.Text := 'F:\delphi_projects\CTMFMX\connection.ini';
    frm.btnReadIniFile.OnClick(frm.btnReadIniFile);
    frm.ShowModal;

    if frm.ModalResult = mrOk then
      begin
        btnConnectionForm.Enabled := False;
        btnDisconnect.Enabled := True;
          // проверка подключения
//        q := TADOQuery.Create(NIL);
//        q.Connection := ctmuser.getConnection;
//        q.SQL.Add('SELECT GETDATE() as d');
//        q.Open;
//        ShowMessage(DATETOSTR(Q.FieldValues['d']));

        labelStatusDBTime.Text :=
          'Connected at: '
          + DateToStr(Now()) + ' '
          + TimeToStr(Now());
        labelStatusUsername.Text :=
          'Name: ' + CTMUser.Username + '. '
          + 'ID: ' + IntToStr(CTMUser.ID);
      end;

    frm.Free;
  end;

procedure TFormMain.btnDisconnectClick(Sender: TObject);
  var
    q: TADOQuery;
  begin
    btnConnectionForm.Enabled := True;
    btnDisconnect.Enabled := False;
    CTMUSer.isAuth := False;

    labelStatusDBTime.Text :=
      'Disconnected at: '
      + DateToStr(Now()) + ' '
      + TimeToStr(Now());
    labelStatusUsername.Text :=
      'Disconnected at: '
      + DateToStr(Now()) + ' '
      + TimeToStr(Now());
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

end.
