unit mInfoAboutForm;

interface

uses
  Classes,
  System.SysUtils,
  FMX.Forms, FMX.Memo, FMX.Types, FMX.Edit;

procedure get_parent_class_info(cls: TClass; strings: TStrings; lvl: integer);
procedure draw_info(cls: TClass);
function get_class_info(cls: TClass): string;

implementation

uses TypInfo;

procedure get_parent_class_info(cls: TClass; strings: TStrings; lvl: integer);
var
  ClassTypeInfo: PTypeInfo;
  ClassTypeData: PTypeData;
begin
  if cls = TObject then
    exit;
  lvl := lvl + 1;
  ClassTypeInfo := cls.ClassParent.ClassInfo;
  ClassTypeData := GetTypeData(ClassTypeInfo);

  strings.Append(IntToStr(lvl) + ' ' + cls.ClassParent.ClassName + ' ' + '(' +
    Format('%s', [ClassTypeData.UnitName]) + ')');
  get_parent_class_info(cls.ClassParent, strings, lvl);
end;

function get_class_info(cls: TClass): string;
var
  ClassTypeInfo: PTypeInfo;
  ClassTypeData: PTypeData;
  str: string;
begin
  ClassTypeInfo := cls.ClassInfo;
  ClassTypeData := GetTypeData(ClassTypeInfo);
  str := str + cls.ClassName;
  str := str + ' ';
  str := str + '(';
  str := str + Format('%s', [ClassTypeData.UnitName]);
  str := str + ')';
  result := str;
end;

procedure draw_info(cls: TClass);
var
  frm: TForm;
  Memo: TMemo;
  Edit: TEdit;

begin

  frm := TForm.CreateNew(NIL);

  frm.Width := 450;
  frm.Height := 450;
  frm.left := (Screen.WorkAreaWidth - frm.Width) div 2;
  frm.top := (Screen.WorkAreaHeight - frm.Height) div 2;

  Edit := TEdit.Create(frm);
  Edit.parent := frm;
  Edit.Align := TAlignLayout.top;
  Edit.Text := get_class_info(cls);
  Edit.ReadOnly := True;

  Memo := TMemo.Create(frm);
  Memo.parent := frm;
  Memo.Align := TAlignLayout.Client;
  get_parent_class_info(cls, Memo.Lines, 0);
  Memo.ReadOnly := True;

  frm.ShowModal;

end;

end.
