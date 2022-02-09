unit uPointCrud;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  uFormCenter, FMX.Edit, Data.DB, Data.Win.ADODB
  ;

type
  TFormPointCrud = class(TForm)
    panelData: TPanel;
    panelButtons: TPanel;
    editCode: TEdit;
    editName: TEdit;
    labelCode: TLabel;
    labelName: TLabel;
    btnPost: TButton;
    btnPut: TButton;
    btnCancel: TButton;
    PointCrudQuery: TADOQuery;
    labelID: TLabel;
    editID: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure SetID(Value: integer); // первым
    procedure SetMode(Value: string); // вторым

    procedure btnPostClick(Sender: TObject);
    procedure btnPutClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

  private
    FMode: string;
    FCrudResult: boolean;
    FID: integer;

    procedure SetupUI;
    procedure SetupQuery(pMode: string);
    procedure ExecuteQuery(pMode: string);
    procedure ClearQuery;
    procedure Post;
    procedure Put;
    procedure SetFieldsFromDB;
    function CheckFields: boolean;
    { Private declarations }
  public
    { Public declarations }
    property Mode: string read FMode write SetMode;
    property ID: integer read FID write setID;
  end;

var
  FormPointCrud: TFormPointCrud;

implementation uses main;

{$R *.fmx}

procedure TFormPointCrud.FormCreate(Sender: TObject);
  begin
    setFormOnCenter(self);
    PointCrudQuery.Connection := FormMain.CTMUser.getConnection;
  end;

procedure TFormPointCrud.SetMode(Value: string);
  begin
    FMode := Value;
    SetupUI;

    if Value = 'GET' then
      begin
        SetupQuery('GET');
        ExecuteQuery('GET');
        SetFieldsFromDB;
        ClearQuery;
      end

    else if Value = 'POST' then
      begin
        //
      end

    else if Value = 'PUT' then
      begin
        SetupQuery('GET');
        ExecuteQuery('GET');
        SetFieldsFromDB;
        ClearQuery;
      end

    else
      begin
        ShowMessage('Режим не определён');
      end;

  end;

procedure TFormPointCrud.SetupUI;
  begin
    if FMode = 'POST' then
      begin
        btnPost.Enabled := True;
        btnPut.Enabled := False;
        editID.Visible := False;
        labelID.Visible := False;
      end
    else if FMode = 'PUT' then
      begin
        btnPost.Enabled := False;
        btnPut.Enabled := True;
      end
    else if FMode = 'GET' then
      begin
        btnPost.Enabled := False;
        btnPut.Enabled := False;
        editCode.Enabled := False;
        editName.Enabled := False;
      end
    else
      begin
        ShowMessage('Режим не определен');
      end;
  end;

procedure TFormPointCrud.SetupQuery(pMode: string);
  begin
    if pMode = 'POST' then
      begin
        PointCrudQuery.SQL.Clear;
        PointCrudQuery.Parameters.Clear;
        PointCrudQuery.SQL.Add('exec POINT#POST :code , :name');
        PointCrudQuery.Parameters.ParamByName('code').Value := editCode.Text;
        PointCrudQuery.Parameters.ParamByName('name').Value := editName.Text;
      end

    else if pMode = 'PUT' then
      begin
        PointCrudQuery.SQL.Clear;
        PointCrudQuery.Parameters.Clear;
        PointCrudQuery.SQL.Add('exec POINT#PUT :id, :code , :name');
      end

    else if pMode = 'GET' then
      begin
        PointCrudQuery.SQL.Clear;
        PointCrudQuery.Parameters.Clear;
        PointCrudQuery.SQL.Add('exec POINT#GET :id');
      end

    else
      begin
        ShowMessage('Режим не определен');
      end;
  end;

procedure TFormPointCrud.ExecuteQuery(pMode: string);
  begin
    if pMode = 'POST' then
      begin
        PointCrudQuery.Parameters.ParamByName('code').Value := editCode.Text;
        PointCrudQuery.Parameters.ParamByName('name').Value := editName.Text;
        PointCrudQuery.ExecSQL;
      end
    else if pMode = 'PUT' then
      begin
        PointCrudQuery.Parameters.ParamByName('id').Value := FID;
        PointCrudQuery.Parameters.ParamByName('code').Value := editCode.Text;
        PointCrudQuery.Parameters.ParamByName('name').Value := editName.Text;
        PointCrudQuery.ExecSQL;
      end
    else if pMode = 'GET' then
      begin
        PointCrudQuery.Parameters.ParamByName('id').Value := FID;
        PointCrudQuery.Open;
      end;
  end;

procedure TFormPointCrud.ClearQuery;
  begin
    PointCrudQuery.SQL.Clear;
    PointCrudQuery.Parameters.Clear;
    PointCrudQuery.Close;
  end;

procedure TFormPointCrud.SetID(Value: integer);
  begin
    FID := Value;
  end;

procedure TFormPointCrud.SetFieldsFromDB;
  begin
    if PointCrudQuery.RecordCount < 1 then
      begin
        ShowMessage('Нет данных для заполения полей!');
        exit;
      end;
    editCode.Text := PointCrudQuery.FieldValues['code'];
    editName.Text := PointCrudQuery.FieldValues['name'];
    editID.Text := PointCrudQuery.FieldValues['id'];
  end;

procedure TFormPointCrud.Post;
  begin
    SetupQuery('POST');
    ExecuteQuery('POST');
  end;

procedure TFormPointCrud.Put;
  begin
    SetupQuery('PUT');
    ExecuteQuery('PUT');
  end;

function TFormPointCrud.CheckFields: boolean;
  var
    msg: string;
  begin
    if editCode.Text = '' then msg := msg + 'Не заполнено поле Code!'#13#10;
    if editName.Text = '' then msg := msg + 'Не заполнено поле Name!'#13#10;
    if msg <> '' then
      begin
        ShowMessage(msg);
        result := False;
      end
    else result := True;
  end;

procedure TFormPointCrud.btnCancelClick(Sender: TObject);
  begin
    ModalResult := mrCancel;
  end;

procedure TFormPointCrud.btnPostClick(Sender: TObject);
  begin
    if not CheckFields then exit;
    try
      begin
        Post;
        ModalResult := mrOk;
      end;
    except
      begin
        ShowMessage('Что-то пошло не так');
        ModalResult := mrCancel;
      end;
    end;
  end;

procedure TFormPointCrud.btnPutClick(Sender: TObject);
  begin
    if not CheckFields then exit;
    try
      begin
        Put;
        ModalResult := mrOk;
      end;
    except
      begin
        ShowMessage('Что-то пошло не так');
        ModalResult := mrCancel;
      end;
    end;
  end;

end.
