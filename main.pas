unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  System.Rtti, System.Bindings.Outputs,

  IniFiles,

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.StdCtrls, FMX.Grid, FMX.Bind.DBEngExt, FMX.Bind.Editors,
  FMX.Bind.Grid, FMX.Grid.Style,

  uFamalyTree, uTreeViewBuilder, uADOConnectionSetup,

  Data.FMTBcd, Data.DB, Data.SqlExpr, FMX.Layouts, FMX.TreeView,

  Data.Bind.EngExt, Data.Bind.Components, Data.Bind.Grid,
  Data.Bind.DBScope,
  Data.Win.ADODB, FMX.ListBox;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    CTMConnection: TADOConnection;
    panelTop: TPanel;
    btnConnect: TButton;
    ComboBox1: TComboBox;
    btnSetSectionSelector: TButton;
    btnShowInfo: TButton;
    procedure btnConnectClick(Sender: TObject);
    procedure btnSetSectionSelectorClick(Sender: TObject);
    procedure btnShowInfoClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  ConnectionIniFileName: string = '.\connection.ini';
  Conset: TADOConnectionSetup;
  test: TStringList;

implementation

{$R *.fmx}

procedure TForm1.btnConnectClick(Sender: TObject);
var
  IniFile: TIniFile;
  Provider: string;
  Sections: string;
  values: string;
  q: TADOQuery;

begin

    CTMConnection.ConnectionString := conset.GetConnectionString(ComboBox1.Selected.Text);
    CTMConnection.Connected := True;
    q := TADOQuery.Create(NIL);
    q.Connection := CTMConnection;
    q.SQL.Add('select getdate() as date');
    q.Open;
    ShowMessage(VarToStr(q.FieldValues['date']));
end;

procedure TForm1.btnSetSectionSelectorClick(Sender: TObject);

  begin
    conset :=  TADOConnectionSetup.Create('MSSQL', ConnectionIniFileName);
    conset.SetSectionSelector(ComboBox1.items);
  end;

procedure TForm1.btnShowInfoClick(Sender: TObject);
  begin
    Draw_Info(self.ClassType);
  end;

end.
