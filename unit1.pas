unit Unit1;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, ExtCtrls, Menus;

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
    Button5: TButton;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    main: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    checklist1: TMenuItem;
    checklist2: TMenuItem;
    popreverse: TMenuItem;
    menulistconnect: TMenuItem;
    separatebysel: TMenuItem;
    sortbyp: TMenuItem;
    sortbym: TMenuItem;
    sortbyc: TMenuItem;
    sortbyh: TMenuItem;
    sortbyw: TMenuItem;
    sortbyr: TMenuItem;
    sortbyd: TMenuItem;
    sortbyf: TMenuItem;
    menusort: TMenuItem;
    menulistlen2: TMenuItem;
    menulistlen: TMenuItem;
    menulistlen1: TMenuItem;
    menulist2: TMenuItem;
    menulist1: TMenuItem;
    menulist: TMenuItem;
    menulistdel: TMenuItem;
    popdelsec: TMenuItem;
    popedit: TMenuItem;
    popadd: TMenuItem;
    popfindmax: TMenuItem;
    popfindmin: TMenuItem;
    PopupMenu1: TPopupMenu;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure checklist1Click(Sender: TObject);
    procedure checklist2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure menulist1Click(Sender: TObject);
    procedure menulist2Click(Sender: TObject);
    procedure menulistconnectClick(Sender: TObject);
    procedure menulistlen1Click(Sender: TObject);
    procedure menulistlen2Click(Sender: TObject);
    procedure menusortClick(Sender: TObject);
    procedure popaddClick(Sender: TObject);
    procedure popdelsecClick(Sender: TObject);
    procedure popeditClick(Sender: TObject);
    procedure popfindmaxClick(Sender: TObject);
    procedure popfindminClick(Sender: TObject);
    procedure popreverseClick(Sender: TObject);
    procedure separatebyselClick(Sender: TObject);
    procedure sortbycClick(Sender: TObject);
    procedure sortbydClick(Sender: TObject);
    procedure sortbyfClick(Sender: TObject);
    procedure sortbyhClick(Sender: TObject);
    procedure sortbymClick(Sender: TObject);
    procedure sortbypClick(Sender: TObject);
    procedure sortbyrClick(Sender: TObject);
    procedure sortbywClick(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private

  public

  end;
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
  check:=1;if gl=1 then ShowMessage('Список заполнен [listcheck]');
 end
else
begin
   if gl=1 then ShowMessage('Список пуст [listcheck]');
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
var i,j:integer;
begin
 if check(L)=0 then
  begin
   //for i:=1 to Form1.StringGrid1.RowCount;
   for i:=1 to Form1.StringGrid1.RowCount-1 do
    begin
      Form1.StringGrid1.Rows[i][0]:='' ;Form1.StringGrid1.Rows[i][1]:='' ;Form1.StringGrid1.Rows[i][2]:='' ;Form1.StringGrid1.Rows[i][3]:='' ;Form1.StringGrid1.Rows[i][4]:='' ;Form1.StringGrid1.Rows[i][5]:='' ;Form1.StringGrid1.Rows[i][6]:='' ;Form1.StringGrid1.Rows[i][7]:='' ;
    end;

  end
else
begin
for j:=1 to Form1.StringGrid1.RowCount-1 do
   begin
     Form1.StringGrid1.Rows[j][0]:='' ;Form1.StringGrid1.Rows[j][1]:='' ;Form1.StringGrid1.Rows[j][2]:='' ;Form1.StringGrid1.Rows[j][3]:='' ;Form1.StringGrid1.Rows[j][4]:='' ;Form1.StringGrid1.Rows[j][5]:='' ;Form1.StringGrid1.Rows[j][6]:='' ;Form1.StringGrid1.Rows[j][7]:='' ;
   end;
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
{procedure finder(n:integer;value:string);//finder (###)
var i:integer;
begin
 for i:=1 to Form1.StringGrid1.RowCount-2 do begin
   if Form1.StringGrid1.Rows[i][n]=value then begin
      Form1.StringGrid1.Row:=i+1;
      Form1.StringGrid1.Selection := TGridRect(Rect(0,i,Form1.StringGrid1.RowCount-n-1,i));
      Form1.StringGrid1.SelectedColor:=clRed;
      //Form1.StringGrid1.ClientToScreen(Point(500,400));
      ShowMessage('Искомое найдено и выделено!');
      Abort; end;
      end;
   ShowMessage('Не найдено');
end;}
procedure findmin(i:integer;L:list);//find min()
var n:integer;min:string;
begin
if (i=0) or (i=2) then
 begin
 min:='';
 if i=0 then
  for n:=1 to listlength(L) do
   begin
   if min='' then min:=L^.manufacturer;
   if L^.manufacturer<min then min:=L^.manufacturer;
   L:=L^.next;
   end
  else if i=2 then
  for n:=1 to listlength(L) do
   begin
   if min='' then min:=L^.processor;
   if L^.processor<min then min:=L^.processor;
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
else if (i=1) or (i=3) or (i=6) then
 begin
 min:='100000000';
if i=1 then
  for n:=1 to listlength(L) do
   begin
   if L^.diagonal<StrToFloat(min) then min:=FloatToStr(L^.diagonal);
   L:=L^.next;
   end
else if i=3 then
  for n:=1 to listlength(L) do
   begin
   if L^.frequency<StrToFloat(min) then min:=FloatToStr(L^.frequency);
   L:=L^.next;
   end
else if i=6 then
  for n:=1 to listlength(L) do
   begin
   if L^.weight<StrToFloat(min) then min:=FloatToStr(L^.weight);
   L:=L^.next;
   end;
end;
ShowMessage('Минимальный - '+min);

end;
procedure findmax(i:integer;L:list);//find max ()
var n:integer;max:string;
begin
if (i=0) or (i=2) then
 begin
 max:='';
 if i=0 then
  for n:=1 to listlength(L) do
   begin
   if L^.manufacturer>max then max:=L^.manufacturer;
   L:=L^.next;
   end
  else if i=2 then
  for n:=1 to listlength(L) do
   begin
   if L^.processor>max then max:=L^.processor;
   L:=L^.next;
   end;
 end
else if  (i=4) or (i=5) or (i=7) then
 begin
 max:='-1';
 if i=4 then
for n:=1 to listlength(L) do
   begin
   if L^.ram>StrToInt(max) then max:=IntToStr(L^.ram);
   L:=L^.next;
   end
else  if i=5 then
  for n:=1 to listlength(L) do
   begin
   if L^.hddssd>StrToInt(max) then max:=IntToStr(L^.hddssd);
   L:=L^.next;
   end
else  if i=7 then
  for n:=1 to listlength(L) do
   begin
   if L^.cost>StrToInt(max) then max:=IntToStr(L^.cost);
   L:=L^.next;
   end
 end
else if (i=1) or (i=3) or (i=6) then
 begin
 max:='-1';
if i=1 then
  for n:=1 to listlength(L) do
   begin
   if L^.diagonal>StrToFloat(max) then max:=FloatToStr(L^.diagonal);
   L:=L^.next;
   end
else if i=3 then
  for n:=1 to listlength(L) do
   begin
   if L^.frequency>StrToFloat(max) then max:=FloatToStr(L^.frequency);
   L:=L^.next;
   end
else if i=6 then
  for n:=1 to listlength(L) do
   begin
   if L^.weight>StrToFloat(max) then max:=FloatToStr(L^.weight);
   L:=L^.next;
   end;
end;
ShowMessage('Максимальный - '+max);
end;
procedure searcher(i:integer;s:string;L:list);// searcher ()
var r:string;j:integer;
begin
 if (i=0) or (i=2) then begin
  if i=0 then begin
   for j:=1 to listlength(L) do begin
   if L^.manufacturer=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end
  else begin
     for j:=1 to listlength(L) do begin
     if L^.processor=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end;
  end////------
  else if  (i=4) or (i=5) or (i=7) then begin
     if i=4 then begin
   for j:=1 to listlength(L) do begin
   if IntToStr(L^.ram)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end
  else  if i=5 then begin
   for j:=1 to listlength(L) do begin
   if IntToStr(L^.hddssd)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end
  else begin
     for j:=1 to listlength(L) do begin
   if IntToStr(L^.cost)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end;
  end//-------
  else if  (i=1) or (i=3) or (i=6) then begin
    if i=1 then begin
   for j:=1 to listlength(L) do begin
   if FloatToStr(L^.diagonal)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end
  else  if i=3 then begin
   for j:=1 to listlength(L) do begin
   if FloatToStr(L^.frequency)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
   end
  else begin
     for j:=1 to listlength(L) do begin
   if FloatToStr(L^.weight)=s then r:=r+IntTostr(j)+' '+L^.manufacturer+' '+ FloatToStr(L^.diagonal)+' '+ L^.processor+' '+ FloatToStr(L^.frequency)+' '+ IntToStr(L^.ram)+' '+ IntToStr(L^.hddssd)+' '+ FloatToStr(L^.weight)+' '+ IntToStr(L^.cost)+#13;
   L:=L^.next;
   end;
 end;
 end;
  begin
  if r.Length=0 then ShowMessage('Не найдено')
  else ShowMessage('Найдено:'+#13+r);
  ;
  end;
end;
procedure swipe(s:list;var p1,p2:list);//swipe ()
begin
 p1:=s;p2:=s^.next;
 p1^.prev^.next:=p2;
 p2^.next^.prev:=p1;
 p1^.next:=p2^.next;
 p2^.prev:=p1^.prev;
 p2^.next:=p1;
 p1^.prev:=p2;
end;
procedure sortbyparam(i:integer;var L:list); //sort ()
var p,q1,q2:list;j:integer;
begin
 insert(0,'0','0','0','0','0','0','0','0',L);
  p:=L^.next;
  if (i=0) or (i=2) then
   begin
    if (i=0) then
     begin
       for j:=1 to listlength(L) do begin
       while p^.next^.manufacturer<>'empty' do begin
         if p^.manufacturer>p^.next^.manufacturer then begin
                 swipe(p,q1,q2);
                 end else
                p:=p^.next;
                 end;p:=L^.next;
       end;
      end
    else
      begin
               for j:=1 to listlength(L) do begin  while p^.next^.manufacturer<>'empty' do begin
                while p^.next^.manufacturer<>'empty' do begin
                 if p^.processor>p^.next^.processor then begin
                    swipe(p,q1,q2);
                   end else
                 p:=p^.next; end;
                end;
               p:=L^.next;
               end;
       end;
      end
  else if (i=1) or (i=3) or (i=6) then
   begin
    if (i=1) then
      begin
           for j:=1 to listlength(L) do begin while p^.next^.manufacturer<>'empty' do begin
                 if p^.diagonal>p^.next^.diagonal then begin
                    swipe(p,q1,q2);
                   end else
                 p:=p^.next;  end;p:=L^.next;
               end;
       end
    else if (i=3) then
      begin
           for j:=1 to listlength(L) do begin  while p^.next^.manufacturer<>'empty' do begin
                 if p^.frequency>p^.next^.frequency then begin
                   swipe(p,q1,q2);;
                   end else
                 p:=p^.next;  end;p:=L^.next;
               end;
      end
    else
      begin
           for j:=1 to listlength(L) do begin  while p^.next^.manufacturer<>'empty' do begin
                 if p^.weight>p^.next^.weight then begin
                    swipe(p,q1,q2);;
                   end else
                 p:=p^.next;      end;p:=L^.next;
               end;
      end;
   end
  else
    begin
     if (i=4) then
       begin
             for j:=1 to listlength(L) do begin  while p^.next^.manufacturer<>'empty' do begin
                 if p^.ram>p^.next^.ram then begin
                    swipe(p,q1,q2);
                   end else
                 p:=p^.next;  end;p:=L^.next;
               end;
       end
     else if (i=5) then
       begin
             for j:=1 to listlength(L) do begin
              while p^.next^.manufacturer<>'empty' do begin
                 if p^.hddssd>p^.next^.hddssd then begin
                    swipe(p,q1,q2);
                   end else
                 p:=p^.next;
              end; p:=L^.next;
               end;
       end
     else
      begin
          for j:=1 to listlength(L) do begin  while p^.next^.manufacturer<>'empty' do begin
                 if p^.cost>p^.next^.cost then begin
                    swipe(p,q1,q2);
                   end else
                 p:=p^.next;end;p:=L^.next;
               end;
      end;
    end;
  del(0,L);
end;
procedure connector(var LINOUT,LIN:list);// conector ()
var i:integer;p:list;
  begin
  p:=LINOUT;
   for i:=1 to listlength(LINOUT)-1 do p:=p^.next;
    p^.next:=LIN;
    LIN:=nil;
  end;
procedure separatorbyparam(param:integer;var LIN,LOUT:list);//separator by param ()
var p,q:list;j:integer;
    begin
    p:=LIN;
    for j:=1 to param do LIN:=LIN^.next;
    LOUT:=LIN^.next;
    new(q);
    q^.manufacturer:='empty';
    q^.next:=nil;
    LIN^.next:=q;
    LIN:=p;
    end;
procedure reverse(var LIN:list);
var p:list;i,y:integer;len:real;
begin
p:=L;
for i:=1 to listlength(LIN) do
 begin
  insert(0,p^.manufacturer,FloatToStr(p^.diagonal),p^.processor,FloatToStr(p^.frequency),IntToStr(p^.ram),IntToStr(p^.hddssd),FloatToStr(p^.weight),IntToStr(p^.cost),LIN);
  p:=p^.next;
 end;                      // y=StrToFloat(FloatToStrF(x,ffFixed,8,0));
len:=listlength(LIN)/2;
//ShowMessage(FloatToStr(len));
y:=trunc(len);
//ShowMessage(IntToStr(y)); //(listlength(LIN)/2);
for i:=1 to y do
 begin
 del(i+y-1,LIN);
 end;
ShowMessage('s');
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
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  eraser(L);
  updategrid(L);
end;
procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  eraser(L2);
  updategrid(L2);
end;
procedure TForm1.menulist1Click(Sender: TObject);// list 1
begin
  menulist.Caption:='Текущий список #1';
  updategrid(L);
end;
procedure TForm1.menulist2Click(Sender: TObject);// list 2
begin
  menulist.Caption:='Текущий список #2'; updategrid(L2);
end;
procedure TForm1.menulistconnectClick(Sender: TObject);
begin
  connector(L,L2);
  updategrid(L);
end;
procedure TForm1.menulistlen1Click(Sender: TObject);// len  1
begin
  ShowMessage('Длина списка 1 - '+IntToStr(listlength(L)));
end;
procedure TForm1.menulistlen2Click(Sender: TObject);// len 2
begin
  ShowMessage('Длина списка 2 - '+IntToStr(listlength(L2)));
end;
procedure TForm1.menusortClick(Sender: TObject);
begin
end;
procedure TForm1.popaddClick(Sender: TObject);// add
begin
  Form2.rb1.Visible:=True;Form2.rb2.Visible:=True;
 Form2.title.Caption:='Заполните данные для добавления';
 Form2.ShowModal;
 //Form2.findb.Visible:=True;
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
procedure TForm1.popdelsecClick(Sender: TObject);//del sel
var j:integer;
begin
   j:=StringGrid1.Row;
   del(StringGrid1.Row-1,L);
   StringGrid1.Row:=j;
   for j:=1 to Form1.StringGrid1.ColCount-2 do
   begin
    Form1.StringGrid1.Rows[Form1.StringGrid1.RowCount-2][j-1]:='';
   end;
   updategrid(L);
end;
procedure TForm1.popeditClick(Sender: TObject);// edit
var i:integer;
begin
 begin
  for i := 0 to Form2.ComponentCount - 1 do
    if Form2.Components[i] is TEdit then
      TEdit(Form2.Components[i] as TEdit).Caption:=StringGrid1.Rows[StringGrid1.Row][i];  // найденный эдит очистить
   end;
 Form2.title.Caption:='Заполните данные для изменения';
 Form2.addb.Caption:='Изменить';
 Form2.ShowModal;
 edit(StringGrid1.Row,Form2.Edit1.Caption,Form2.Edit2.Caption,Form2.Edit3.Caption,Form2.Edit4.Caption,Form2.Edit5.Caption,Form2.Edit6.Caption,Form2.Edit7.Caption,Form2.Edit8.Caption,L);
 updategrid(L);
 CleanAllEdits(Form2);
end;
procedure TForm1.popfindmaxClick(Sender: TObject);//find max sel col
begin
  findmax(Form1.StringGrid1.SelectedColumn.Index,L);
end;
procedure TForm1.popfindminClick(Sender: TObject);//find min sel col
begin
   findmin(Form1.StringGrid1.SelectedColumn.Index,L);
end;

procedure TForm1.popreverseClick(Sender: TObject);
begin
  reverse(L);
  updategrid(L);
end;

procedure TForm1.separatebyselClick(Sender: TObject);
begin
   separatorbyparam(Form1.StringGrid1.Row-1,L,L2);
   updategrid(L);
end;
procedure TForm1.sortbycClick(Sender: TObject);//sort by cost
begin
  sortbyparam(7,L);
  updategrid(L);
end;
procedure TForm1.sortbydClick(Sender: TObject);//sort by diagonal
begin
  sortbyparam(1,L);
  updategrid(L);
end;
procedure TForm1.sortbyfClick(Sender: TObject);//sort by frequency
begin
  sortbyparam(3,L);
  updategrid(L);
end;
procedure TForm1.sortbyhClick(Sender: TObject);//sort by hddssd
begin
  sortbyparam(5,L);
  updategrid(L);
end;
procedure TForm1.sortbymClick(Sender: TObject);//sort by manufacturer
begin
  sortbyparam(0,L);
  updategrid(L);
end;
procedure TForm1.sortbypClick(Sender: TObject);//sort by processor
begin
  sortbyparam(2,L);
  updategrid(L);
end;
procedure TForm1.sortbyrClick(Sender: TObject);//sort by RAM
begin
  sortbyparam(4,L);
  updategrid(L);
end;
procedure TForm1.sortbywClick(Sender: TObject);//sort by weight
begin
    sortbyparam(6,L);
  updategrid(L);
end;
procedure TForm1.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;// auto focus
  Shift: TShiftState; X, Y: Integer);
var ACol, ARow: Integer;
begin
   StringGrid1.MouseToCell(X, Y, ACol, ARow);
  StringGrid1.Col:=ACol;
  StringGrid1.Row:=ARow;
  StringGrid1.SelectedColor:=clBlue;
end;
{procedure TForm1.Button3Click(Sender: TObject);//find  (###)
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
end;}
{procedure TForm1.Button4Click(Sender: TObject);  //del  (###)
begin
 Form2.checkbox.Visible:=True;FindHideAllEdits(Form2);FindHideAllLabels(Form2);Form2.title.Visible:=True;Form2.Edit9.Visible:=True;Form2.elems.Visible:=True;Form2.addb.Visible:=False;Form2.findb.Visible:=False;Form2.title.Caption:='Введите один из параметров для удаления';
  Form2.ShowModal;
  Form2.findb.Visible:=True;Form2.addb.Visible:=True;Form2.Edit9.Visible:=False;
  ShowAllLabels(Form2);
  ShowAllEdits(Form2);
  Form2.elems.Visible:=False;Form2.Edit9.Visible:=False;Form2.checkbox.Visible:=False;
  delete(Form2.elems.ItemIndex,Form2.Edit9.Caption,L);cleargrid();
  updategrid(L);
end;}
procedure TForm1.Button5Click(Sender: TObject);//printer
begin
 printer(L);
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
if AnsiPos('1',menulist.Caption)=30   then begin
  searcher(StringGrid1.SelectedColumn.Index,Edit1.Text,L)
end
else
  searcher(StringGrid1.SelectedColumn.Index,Edit1.Text,L2);
end;
procedure TForm1.checklist1Click(Sender: TObject);// check 1
begin
  gl:=1;check(L);gl:=0;
end;
procedure TForm1.checklist2Click(Sender: TObject);// check 2
begin
  gl:=1;check(L2);gl:=0;
end;
procedure TForm1.Edit1Click(Sender: TObject);
begin
  Edit1.Caption:='';
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
