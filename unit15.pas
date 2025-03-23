unit Unit15;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm15 }

  TForm15 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form15: TForm15;

implementation
uses Unit1, Unit2;

{$R *.lfm}

{ TForm15 }

procedure TForm15.Button1Click(Sender: TObject);
var spozaddplus : String;
begin
  if Form1.Timer1.Enabled then pozicija:=pozicija-1;
  spozaddplus:=IntToStr(pozicija);
  val(arGlava[pozicija], Glavabe);
  str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
  ListBox1.Items.Append(spozaddplus + ' : '+ arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]);
end;

procedure TForm15.Button2Click(Sender: TObject);
var N : Integer;
begin
  if (ListBox1.Items.Count > 0) and ( ListBox1.ItemIndex >=0 ) then begin
   N:=ListBox1.ItemIndex;
   ListBox1.Items.Delete(N);
   if ListBox1.Items.Count > 0 then
    if N=0 then ListBox1.ItemIndex:=0
           else ListBox1.ItemIndex:=N-1;
  end; // if ListBox1.Items
end;

procedure TForm15.Button3Click(Sender: TObject);
begin
  ListBox1.Clear;
end;

procedure TForm15.FormCreate(Sender: TObject);
begin
  if FileExists('bookmarks.dat') then ListBox1.Items.LoadFromFile('bookmarks.dat');
end;

procedure TForm15.ListBox1Click(Sender: TObject);
var lp, i15 : Integer;
    k : Word;
    s15, s152 : String;
begin
   lp:=ListBox1.ItemIndex;
   s15 := ListBox1.Items.ValueFromIndex[lp];
   for i15:=3 to 7 do
    if s15[i15]=':' then begin
    s152:=copy(s15, 1, i15-2);
    pozicija:=StrToInt(s152)-1;
    k:=39;
    Form1.Button1KeyDown(Button1, k, []);
    break;
   end;
end;

end.

