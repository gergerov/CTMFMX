unit uPointList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style,
  FMX.ScrollBox, FMX.Grid,

  uFormCenter, uPointCrud,

  FMX.Edit, Data.DB, Data.Win.ADODB, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope, Data.Bind.Controls,
  FMX.Layouts, Fmx.Bind.Navigator


  ;

type
  TFormPointList = class(TForm)
    panelTop: TPanel;
    StringGridPointList: TStringGrid;
    panelBot: TPanel;
    btnPostForm: TButton;
    btnPutForm: TButton;
    btnSearch: TButton;
    QueryPointList: TADOQuery;
    editQ: TEdit;
    BindSourceDBPointList: TBindSourceDB;
    BindingsListPointList: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    btnGet: TButton;
    btnSelect: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure settingGrid;
    procedure editQTyping(Sender: TObject);
    procedure btnPostFormClick(Sender: TObject);
    procedure btnPutFormClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPointList: TFormPointList;

implementation uses main;

{$R *.fmx}

procedure TFormPointList.btnGetClick(Sender: TObject);
  var
    frm: TFormPointCrud;
  begin
    if QueryPointList.RecordCount < 1 then
      begin
        ShowMessage('Не выбран пункт!');
        Exit;
      end;
    frm := TFormPointCrud.Create(NIL);
    frm.SetID(StrToInt(QueryPointList.FieldValues['ID']));
    frm.SetMode('GET');
    frm.ShowModal;
    btnSearchClick(btnSearch);
  end;

procedure TFormPointList.btnPostFormClick(Sender: TObject);
  var
    frm: TFormPointCrud;
  begin
    frm := TFormPointCrud.Create(NIL);
    frm.SetMode('POST');
    frm.ShowModal;
    btnSearchClick(btnSearch);
  end;

procedure TFormPointList.btnPutFormClick(Sender: TObject);
  var
    frm: TFormPointCrud;
  begin
    if QueryPointList.RecordCount < 1 then
      begin
        ShowMessage('Не выбран пункт!');
        Exit;
      end;

    frm := TFormPointCrud.Create(NIL);
    frm.SetID(StrToInt(QueryPointList.FieldValues['ID']));
    frm.SetMode('PUT');
    frm.ShowModal;
    btnSearchClick(btnSearch);
end;

procedure TFormPointList.btnSearchClick(Sender: TObject);
  begin
    QueryPointList.Parameters.ParamByName('q').Value := editQ.Text;
    QueryPointList.ACtive := False;
    QueryPointList.ACtive := True;
    settingGrid;
  end;

procedure TFormPointList.editQTyping(Sender: TObject);
  begin
    btnSearchClick(btnSearch);
  end;

procedure TFormPointList.FormCreate(Sender: TObject);
  begin
    setFormOnCenter(self);
    QueryPointList.Connection := FormMain.CTMUser.getConnection;
    btnSearchClick(btnSearch);
  end;

procedure TFormPointList.settingGrid;
  begin
    try
      StringGridPointList.Columns[0].Width := 50;
      StringGridPointList.Columns[0].Header := 'ID';

      StringGridPointList.Columns[1].Width := 50;
      StringGridPointList.Columns[1].Header := 'КОД';

      StringGridPointList.Columns[2].Width := 200;
      StringGridPointList.Columns[2].Header := 'НАЗВАНИЕ';
    finally

    end;

  end;



end.
