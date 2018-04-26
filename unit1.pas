unit Unit1;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, ExtCtrls;

type
  list=^elem;
  elem=record
    manufacturer:String;
    diagonal:Real;
    processor:string;
    frequency:Real;
    ram:SmallInt;
    hddssd:integer;
    weight:real;
    cost:integer;
    next:list;
    prev:list;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    listb1: TRadioButton;
    list2b: TRadioButton;
    StringGrid1: TStringGrid;
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure list2bChange(Sender: TObject);
    procedure listb1Change(Sender: TObject);
  private

  public

  end;

//////////
/////var
var
  Form1: TForm1;
  tslist,t:TStringList;
  p1,p2,p3,p4,p5,p6,p7,p8:string;
  L,L2:list;
  gl:integer;

implementation
uses unit2;
{$R *.lfm}

{ TForm1 }
procedure cleargrid();
var i:integer;
begin
 for i:=1 to Form1.StringGrid1.RowCount-1 do
  begin
     Form1.StringGrid1.Rows[i][0]:='' ;
     Form1.StringGrid1.Rows[i][1]:='';
     Form1.StringGrid1.Rows[i][2]:='';
     Form1.StringGrid1.Rows[i][3]:='';
     Form1.StringGrid1.Rows[i][4]:='';
     Form1.StringGrid1.Rows[i][5]:='';
     Form1.StringGrid1.Rows[i][6]:='';
     Form1.StringGrid1.Rows[i][7]:='';
  end;
 end;
procedure listinit(var L:list);
   begin
     new(L);
     L^.next:=nil;
     L^.manufacturer:='empty';
     L^.diagonal:=0;
     L^.processor:='empty';
     L^.frequency:=0;
     L^.ram:=0;
     L^.hddssd:=0;
     L^.weight:=0;
     L^.cost:=0;
     L^.prev:=nil;
   end;//ORIENT
function check(var L:list):integer;
begin
if L<>nil then
 begin
  check:=1;if gl=1 then ShowMessage('Список заполнен [listlength]');
 end
else
begin
   if gl=1 then ShowMessage('Список пуст [listlength]');
   check:=0;
end;

end;
function listlength(L:list):integer;
   begin
     listlength:=0;
     //ShowMessage(IntToStr(L^.manufacturer.Length));
     if check(L)=0 then begin ShowMessage('Список не существует [check][listlength]');Abort;end
     else if L^.manufacturer='empty' then begin ShowMessage('Список пуст [listlength]');Abort;end
     else
     begin
         while L^.next<>nil do
         begin
             listlength+=1;
             L:=L^.next;
         end;
     end;
   end;//ORIENT
procedure insert(n:Integer;a1,a2,a3,a4,a5,a6,a7,a8:string;var L:list);
var p,q:list;i:integer;
begin
  if n=0 then begin
       new(p);
       p^.manufacturer:=a1;
       p^.diagonal:=StrToFloat(a2);
       p^.processor:=a3;
       p^.frequency:=StrToFloat(a4);
       p^.ram:=StrToInt(a5);
       p^.hddssd:=StrToInt(a6);
       p^.weight:=StrToFloat(a7);
       p^.cost:=StrToInt(a8);
       p^.prev:=nil;
       L^.prev:=p;
       p^.next:=L;
       L:=p;
     end
  else
  begin
       begin
       q:=L;
       for i:=0 to n-2 do
         q:=q^.next;
       new(p);
       p^.manufacturer:=a1;
       p^.diagonal:=StrToFloat(a2);
       p^.processor:=a3;
       p^.frequency:=StrToFloat(a4);
       p^.ram:=StrToInt(a5);
       p^.hddssd:=StrToInt(a6);
       p^.weight:=StrToFloat(a7);
       p^.cost:=StrToInt(a8);
       p^.next:=q^.next;
       q^.next^.prev:=p;
       p^.prev:=q;
       q^.next:=p;
       end;
  end;

end;
procedure fixer();//fixer()
 begin
 if Form1.StringGrid1.RowCount<=listlength(L)+1 then
   Form1.StringGrid1.RowCount:=Form1.StringGrid1.RowCount+1;
end;
procedure printer(L:list);//printer()
var i:integer;s:string;
begin
 for i:=1 to listlength(L) do
  begin
    s:=L^.manufacturer+' '+FloatToStr(L^.diagonal)+' '+
    L^.processor+' '+FloatToStr(L^.frequency)+' '+
    IntToStr(L^.ram)+' '+IntToStr(L^.hddssd)+' '+
    FloatToStr(L^.weight)+' '+IntToStr(L^.cost);
    ShowMessage(s);
    L:=L^.next;
  end;
end;
procedure eraser(var L:list);//eraser()
 var del:list;i:integer;//RE
  begin
  if L=nil then begin ShowMessage('Список пуст/не существует');exit;end;
    for i:=1 to listlength(L) do
    begin
      del:=L;
      L:=L^.next;
      del^.next:=nil;
      L^.prev:=nil;
      dispose(del);
    end;
    dispose(L);
    L:=nil;
  end;
procedure del(i:integer;var L:list);//del()
var p:list;j:integer;
begin
p:=L;
//ShowMessage(p^.manufacturer);
for j:=0 to i-1 do begin p:=p^.next;end;
//ShowMessage(p^.manufacturer+' '+j.ToString);
if i=0 then
  begin
       L:=p^.next;
       L^.prev:=nil;
       p^.next:=nil;
       dispose(p);
  end
else
  begin
    p^.prev^.next:=p^.next;
    p^.next^.prev:=p^.prev;
    p^.prev:=nil;
    p^.next:=nil;
    dispose(p);
  end;
//printer(L);
end;///////////
procedure delete(n:integer;value:string;var L:list);//delete()
var p:list;i:integer;
begin
p:=L;
if n=0 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.manufacturer=value then begin del(i,L);break end;
      //ShowMessage(p^.manufacturer);
      p:=p^.next;end;end
else if n=1 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.diagonal=StrToFloat(value) then begin del(i,L);break; end;p:=p^.next;end;end
else if n=2 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.processor=value then begin del(i,L);break; end;p:=p^.next;end;end
else if n=3 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.frequency=StrToFloat(value) then begin del(i,L);break; end;p:=p^.next;end;end
else if n=4 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.ram=StrToInt(value) then begin del(i,L);break; end;p:=p^.next;end;end
else if n=5 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.hddssd=StrToInt(value) then begin del(i,L);break; end;p:=p^.next;end;end
else if n=6 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.weight=StrToFloat(value) then begin del(i,L);break; end;p:=p^.next;end;end
else if n=7 then begin
      for i:=0 to listlength(L)-1 do begin
      if p^.cost=StrToInt(value) then begin del(i,L);break; end;p:=p^.next;end;end
end;
procedure updategrid(L:list);//updategrid()
var i:integer;
begin
 if check(L)=0 then
  begin
   for i:=1 to Form1.StringGrid1.RowCount-1 do
    begin
      Form1.StringGrid1.Rows[i][0]:='' ;Form1.StringGrid1.Rows[i][1]:='' ;Form1.StringGrid1.Rows[i][2]:='' ;Form1.StringGrid1.Rows[i][3]:='' ;Form1.StringGrid1.Rows[i][4]:='' ;Form1.StringGrid1.Rows[i][5]:='' ;Form1.StringGrid1.Rows[i][6]:='' ;Form1.StringGrid1.Rows[i][7]:='' ;
    end;
  end
else
begin
 for i:=1 to listlength(L) do
  begin
     Form1.StringGrid1.Rows[i][0]:=L^.manufacturer ;
     Form1.StringGrid1.Rows[i][1]:=FloatToStr(L^.diagonal);
     Form1.StringGrid1.Rows[i][2]:=L^.processor;
     Form1.StringGrid1.Rows[i][3]:=FloatToStr(L^.frequency);
     Form1.StringGrid1.Rows[i][4]:=IntToStr(L^.ram);
     Form1.StringGrid1.Rows[i][5]:=IntToStr(L^.hddssd);
     Form1.StringGrid1.Rows[i][6]:=FloatToStr(L^.weight);
     Form1.StringGrid1.Rows[i][7]:=IntToStr(L^.cost);
     L:=L^.next;
  end;
 end;
end;
procedure FindHideAllEdits(F: TForm);//hide edits()
var i: Integer;
begin
  for i := 0 to F.ComponentCount - 1 do       // пройтись по всей форме
    if F.Components[i] is TEdit then          // найти на ней все эдиты
      TEdit(F.Components[i] as TEdit).Visible:=False;  // найденный эдит очистить
end;
procedure ShowAllLabels(F: TForm);//show labels()
var i: Integer;
begin
  for i := 0 to F.ComponentCount - 1 do       // пройтись по всей форме
    if F.Components[i] is TLabel then          // найти на ней все эдиты
      TEdit(F.Components[i] as TLabel).Visible:=True;  // найденный эдит очистить
end;
procedure ShowAllEdits(F: TForm);//show edits()
var i: Integer;
begin
  for i := 0 to F.ComponentCount - 1 do
    if F.Components[i] is TEdit then
      TEdit(F.Components[i] as TEdit).Visible:=True;
end;
procedure FindHideAllLabels(F: TForm);//hide labels()
var i: Integer;
begin
  for i := 0 to F.ComponentCount - 1 do
    if F.Components[i] is TLabel then
      TEdit(F.Components[i] as TLabel).Visible:=False;
end;
procedure edit(i:integer;a1,a2,a3,a4,a5,a6,a7,a8:string;var L:list);//edit
var j:integer;p:list;
begin
 p:=L;
 for j:=1 to i-1 do p:=p^.next;
  p^.manufacturer:=a1;
  p^.diagonal:=StrToFloat(a2);
  p^.processor:=a3;
  p^.frequency:=StrToFloat(a4);
  p^.ram:=StrToInt(a5);
  p^.hddssd:=StrToInt(a6);
  p^.weight:=StrToFloat(a7);
  p^.cost:=StrToInt(a8);
end;
procedure finder(n:integer;value:string);//delete()
var i:integer;
begin
 for i:=1 to Form1.StringGrid1.RowCount-2 do begin
   if Form1.StringGrid1.Rows[i][n]=value then begin
      Form1.StringGrid1.Selection := TGridRect(Rect(0,i,Form1.StringGrid1.RowCount-n-1,i));
      ShowMessage('Искомое найдено и выделено!');
      Abort; end;
      end;
   ShowMessage('Не найдено');
end;
procedure findmin(i:integer;L:list);//find min
var n:integer;min:string;
begin
if (i=0) or (i=2) then
 begin
 min:='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
 if i=0 then
  for n:=1 to listlength(L) do
   begin
   if L^.manufacturer.Length<min.Length then min:=L^.manufacturer;
   L:=L^.next;
   end
  else if i=2 then
  for n:=1 to listlength(L) do
   begin
   if L^.processor.Length<min.Length then min:=L^.processor;
   L:=L^.next;
   end;
 end
else if  (i=4) or (i=5) or (i=7) then
 begin
 min:='1000000000';
 if i=4 then
  for n:=1 to listlength(L) do
   begin
   if L^.ram<StrToInt(min) then min:=IntToStr(L^.ram);
   L:=L^.next;
   end
  else  if i=5 then
  for n:=1 to listlength(L) do
   begin
   if L^.hddssd<StrToInt(min) then min:=IntToStr(L^.hddssd);
   L:=L^.next;
   end
  else  if i=7 then
  for n:=1 to listlength(L) do
   begin
   if L^.cost<StrToInt(min) then min:=IntToStr(L^.cost);
   L:=L^.next;
   end
 end
else if (i=1) or (i=6) then
 begin
 min:='100000000';
 if i=1 then
  for n:=1 to listlength(L) do
   begin
   if L^.diagonal<StrToFloat(min) then min:=FloatToStr(L^.diagonal);
   L:=L^.next;
   end
  else if i=6 then
  for n:=1 to listlength(L) do
   begin
   if L^.frequency<StrToFloat(min) then min:=FloatToStr(L^.frequency);
   L:=L^.next;
   end;
 end;
Form1.StringGrid1.Selection := TGridRect(Rect(0,n,Form1.StringGrid1.ColCount-1,n));
ShowMessage('Минимальный - '+min);

end;
procedure findmax(i:integer;L:list);//find max
var n:integer;min:string;
begin
if (i=0) or (i=2) then
 begin
 min:='';
 if i=0 then
  for n:=1 to listlength(L) do
   begin
   if L^.manufacturer.Length>min.Length then min:=L^.manufacturer;
   L:=L^.next;
   end
  else if i=2 then
  for n:=1 to listlength(L) do
   begin
   if L^.processor.Length>min.Length then min:=L^.processor;
   L:=L^.next;
   end;
 end
else if  (i=4) or (i=5) or (i=7) then
 begin
 min:='-1000';
 if i=4 then
  for n:=1 to listlength(L) do
   begin
   if L^.ram>StrToInt(min) then min:=IntToStr(L^.ram);
   L:=L^.next;
   end
  else  if i=5 then
  for n:=1 to listlength(L) do
   begin
   if L^.hddssd>StrToInt(min) then min:=IntToStr(L^.hddssd);
   L:=L^.next;
   end
  else  if i=7 then
  for n:=1 to listlength(L) do
   begin
   if L^.cost>StrToInt(min) then min:=IntToStr(L^.cost);
   L:=L^.next;
   end
 end
else if (i=1) or (i=6) then
 begin
 min:='-1000';
 if i=1 then
  for n:=1 to listlength(L) do
   begin
   if L^.diagonal>StrToFloat(min) then min:=FloatToStr(L^.diagonal);
   L:=L^.next;
   end
  else if i=6 then
  for n:=1 to listlength(L) do
   begin
   if L^.frequency>StrToFloat(min) then min:=FloatToStr(L^.frequency);
   L:=L^.next;
   end;
 end;
ShowMessage('Максимальный - '+min);
Form1.StringGrid1.Selection := TGridRect(Rect(0,n,Form1.StringGrid1.ColCount-1,n));
end;
///\
//||| Здесь разрыв, Сэр.
////
procedure CleanAllEdits(F: TForm);//CLEAN ALL EDITS
var i: Integer;
begin
 for i := 0 to F.ComponentCount - 1 do       // пройтись по всей форме
   if F.Components[i] is TEdit then          // найти на ней все эдиты
     TEdit(F.Components[i] as TEdit).Caption:='0';  // найденный эдит очистить
end;
procedure TForm1.FormCreate(Sender: TObject);//FORM CREATE
var
  s:string;i,par:integer;
begin

   i:=0;
   tslist:=TStringList.Create;
   t:=TStringList.Create;
   tslist.LoadFromFile('list.txt');
   listinit(L);
   for s in tslist do
   begin
      i+=1;
       ExtractStrings([';'], [' '], pchar(s), t);
       if i=1 then par:=0
       else par:=listlength(L);
       insert(par,t[0],t[1],t[2],t[3],t[4],t[5],t[6],t[7],L);
       t.Clear;
       fixer();
   end;
   updategrid(L);
end;
procedure TForm1.list2bChange(Sender: TObject);//list2
begin
   updategrid(L2);
end;
procedure TForm1.listb1Change(Sender: TObject);//list1
begin
  updategrid(L);
end;
procedure TForm1.Button1Click(Sender: TObject);//len
begin
  ShowMessage('Длина списка= '+IntToStr(listlength(L)));
end;

procedure TForm1.Button10Click(Sender: TObject);//min
begin
  FindHideAllEdits(Form2);
  FindHideAllLabels(Form2);
  Form2.title.Visible:=True;
  Form2.Edit9.Visible:=False;
  Form2.elems.Visible:=True;
  Form2.elems.Left:=Form2.elems.Left+80;
  Form2.addb.Visible:=False;Form2.delb.Visible:=False;Form2.title.Caption:='          Найти минимумальный по:';Form2.ShowModal;Form2.delb.Visible:=True;Form2.addb.Visible:=True;
  Form2.elems.Left:=Form2.elems.Left-80;
  ShowAllLabels(Form2);
  ShowAllEdits(Form2);
  Form2.elems.Visible:=False;
  Form2.Edit9.Visible:=False;
  if Form2.findb.Tag=Form2.Tag then Abort;
  findmin(Form2.elems.ItemIndex,L);
  CleanAllEdits(Form2);
end;

procedure TForm1.Button11Click(Sender: TObject);//max
begin
    FindHideAllEdits(Form2);
  FindHideAllLabels(Form2);
  Form2.title.Visible:=True;
  Form2.Edit9.Visible:=False;
  Form2.elems.Visible:=True;
  Form2.elems.Left:=Form2.elems.Left+80;
  Form2.addb.Visible:=False;Form2.delb.Visible:=False;Form2.title.Caption:='          Найти максимальный по:';Form2.ShowModal;Form2.delb.Visible:=True;Form2.addb.Visible:=True;
  Form2.elems.Left:=Form2.elems.Left-80;
  ShowAllLabels(Form2);
  ShowAllEdits(Form2);
  Form2.elems.Visible:=False;
  Form2.Edit9.Visible:=False;
  if Form2.findb.Tag=Form2.Tag then Abort;
  findmax(Form2.elems.ItemIndex,L);
  CleanAllEdits(Form2);
end;

procedure TForm1.Button2Click(Sender: TObject);//add
begin
 Form2.Edit9.Visible:=False;Form2.elems.Visible:=False;
 Form2.rb1.Visible:=True;Form2.rb2.Visible:=True;
 Form2.delb.Visible:=False;Form2.findb.Visible:=False;Form2.title.Caption:='Заполните данные для добавления';Form2.ShowModal;Form2.delb.Visible:=True;Form2.findb.Visible:=True;
 Form2.rb1.Visible:=False;Form2.rb2.Visible:=False;
 p1:=Form2.Edit1.Caption;p2:=Form2.Edit2.Caption;
 p3:=Form2.Edit3.Caption;p4:=Form2.Edit4.Caption;
 p5:=Form2.Edit5.Caption;p6:=Form2.Edit6.Caption;
 p7:=Form2.Edit7.Caption;p8:=Form2.Edit8.Caption;
 if Form2.addb.Tag=Form2.Tag then Abort;
 if Form2.rb1.Checked=True then
  begin
    insert(StringGrid1.Row,p1,p2,p3,p4,p5,p6,p7,p8,L);
    updategrid(L);
  fixer();
  end
 else
  begin
   if StringGrid1.Row=1 then insert(0,p1,p2,p3,p4,p5,p6,p7,p8,L)
   else insert(StringGrid1.Row-1,p1,p2,p3,p4,p5,p6,p7,p8,L);
   updategrid(L);
   fixer();
  end;
end;
procedure TForm1.Button3Click(Sender: TObject);//find
begin
  FindHideAllEdits(Form2);
  FindHideAllLabels(Form2);
  Form2.title.Visible:=True;
  Form2.Edit9.Visible:=True;
  Form2.elems.Visible:=True;
  Form2.addb.Visible:=False;Form2.delb.Visible:=False;Form2.title.Caption:='Введите один из параметров для поиска';Form2.ShowModal;Form2.delb.Visible:=True;Form2.addb.Visible:=True;
  Form2.Edit9.Visible:=False;
  ShowAllLabels(Form2);
  ShowAllEdits(Form2);
  Form2.elems.Visible:=False;
  Form2.Edit9.Visible:=False;
  if Form2.findb.Tag=Form2.Tag then Abort;
  finder(Form2.elems.ItemIndex,Form2.Edit9.Caption);
  CleanAllEdits(Form2);
end;
procedure TForm1.Button4Click(Sender: TObject);//del
begin
 Form2.checkbox.Visible:=True;FindHideAllEdits(Form2);FindHideAllLabels(Form2);Form2.title.Visible:=True;Form2.Edit9.Visible:=True;Form2.elems.Visible:=True;Form2.addb.Visible:=False;Form2.findb.Visible:=False;Form2.title.Caption:='Введите один из параметров для удаления';
  Form2.ShowModal;
  Form2.findb.Visible:=True;Form2.addb.Visible:=True;Form2.Edit9.Visible:=False;
  ShowAllLabels(Form2);
  ShowAllEdits(Form2);
  Form2.elems.Visible:=False;Form2.Edit9.Visible:=False;Form2.checkbox.Visible:=False;
  delete(Form2.elems.ItemIndex,Form2.Edit9.Caption,L);cleargrid();
  updategrid(L);
end;
procedure TForm1.Button5Click(Sender: TObject);//printer
begin
 printer(L);
end;
procedure TForm1.Button6Click(Sender: TObject);//check
begin
 gl:=1;check(L);gl:=0;updategrid(L);
end;
procedure TForm1.Button7Click(Sender: TObject);//eraser
begin
  eraser(L);
end;
procedure TForm1.Button8Click(Sender: TObject);//sel del
begin
   del(StringGrid1.Row-1,L);
   updategrid(L);
end;
procedure TForm1.Button9Click(Sender: TObject);//sel edit
var i:integer;
begin
 begin
  for i := 0 to Form2.ComponentCount - 1 do
    if Form2.Components[i] is TEdit then
      TEdit(Form2.Components[i] as TEdit).Caption:=StringGrid1.Rows[StringGrid1.Row][i];  // найденный эдит очистить
   end;

 Form2.Edit9.Visible:=False;
 Form2.elems.Visible:=False;
 Form2.delb.Visible:=False;
 Form2.findb.Visible:=False;
 Form2.title.Caption:='Заполните данные для изменения';
 Form2.addb.Caption:='Изменить';
 Form2.ShowModal;
 Form2.delb.Visible:=True;
 Form2.findb.Visible:=True;
 Form2.rb1.Visible:=False;
 Form2.rb2.Visible:=False;
 edit(StringGrid1.Row,Form2.Edit1.Caption,Form2.Edit2.Caption,Form2.Edit3.Caption,Form2.Edit4.Caption,Form2.Edit5.Caption,Form2.Edit6.Caption,Form2.Edit7.Caption,Form2.Edit8.Caption,L);
 updategrid(L);
 CleanAllEdits(Form2);

end;
procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);//FORM CLOSE ()
var i:integer;s:string;tofile:TStringList;
begin
 tofile:=TStringList.Create;
 for i:=1 to listlength(L) do
 begin
  s:=L^.manufacturer+';'+FloatToStr(L^.diagonal)+';'+L^.processor+';'+FloatToStr(L^.frequency)+';'+IntToStr(L^.ram)+';'+IntToStr(L^.hddssd)+';'+FloatToStr(L^.weight)+';'+IntToStr(L^.cost);
  tofile.Append(s);
  L:=L^.next;
 end;
 tofile.SaveToFile('list.txt');
end;
end.

