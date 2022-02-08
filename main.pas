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
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  ConnectionIniFileName: string = '.\connection.ini';
  Conset: TADOConnectionSetup;
  CTMUser: TCTMUser;

implementation

{$R *.fmx}

procedure TFormMain.btnConnectionFormClick(Sender: TObject);
  var
    frm: TFormConnection;
    q: TADOQuery;
  begin
    frm := TFormConnection.Create(NIL);
    frm.btnReadIniFile.OnClick(frm.btnReadIniFile);
    frm.editUsername.Text := 'CTM';
    frm.editPassword.Text := 'CTM';
    frm.panelLeft.Visible := False;
    frm.ShowModal;

    if frm.ModalResult = mrOk then
      begin
        // проверка подключения
        try
          CTMConnection.ConnectionString := frm.ConnectionString;
          q := TADOQuery.Create(NIL);
          q.Connection := CTMConnection;
          q.SQL.Add('select getdate() as date');
          q.Open;
          labelStatusDBTime.Text :=
            'Тест подключения (время): '
            + VarToStr(q.FieldValues['date'])
        except
          labelStatusDBTime.Text := 'Тест подключения (время): Не подключено';
          exit;
        end;

        try
            begin
              CTMUser := TCTMUser.Create(
                frm.editUsername.Text,
                frm.editPassword.Text,
                CTMConnection
              );
            end;
          CTMUser.Auth;
          if not CTMUser.FisAUTH then
            begin
              labelStatusUsername.Text := 'Неверное имя пользователя или пароль';
              exit;
            end;
          labelStatusUsername.Text :=
            'Имя пользователя: '
            + CTMUser.FUSERNAME
            + '('
            + IntToStr(CTMUser.FID)
            + ')'
            ;
          btnConnectionForm.Enabled := False;
          btnDisconnect.Enabled := True;
        except
          ShowMessage('Авторизация не пройдена');
          labelStatusUsername.Text := 'Авторизация не пройдена';
          exit;
        end;
      end;
    frm.Free;
  end;

procedure TFormMain.btnDisconnectClick(Sender: TObject);
  begin
    CTMUser.Destroy;
    btnConnectionForm.Enabled := True;
    btnDisconnect.Enabled := False;
    CTMConnection.Connected := False;
    CTMConnection.ConnectionString := '';
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
    btnConnectionForm.OnClick(btnConnectionForm);

    Width := 1200;
    Height := 800;
    left := (Screen.WorkAreaWidth - Width) div 2;
    top := (Screen.WorkAreaHeight - Height) div 2;
  end;

end.
