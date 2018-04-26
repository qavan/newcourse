unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    addb: TButton;
    checkbox: TCheckBox;
    elems: TComboBox;
    Edit9: TEdit;
    findb: TButton;
    delb: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    rb1: TRadioButton;
    rb2: TRadioButton;
    title: TLabel;
    procedure addbClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure delbClick(Sender: TObject);
    procedure findbClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses unit1;
{$R *.lfm}

{ TForm2 }

procedure TForm2.addbClick(Sender: TObject);
begin
  Form2.Close;
  addb.Tag:=addb.Tag+1;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  ShowMessage(elems.ItemIndex.ToString);
end;

procedure TForm2.delbClick(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.findbClick(Sender: TObject);
begin
   Form2.findb.Tag:=0;
   Form2.Close;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  findb.Tag:=1;
  Form2.Tag:=1;
  addb.Tag:=1;
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm2.FormDeactivate(Sender: TObject);
begin
end;

end.

