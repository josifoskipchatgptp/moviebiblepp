unit Unit11; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType, Unit12, Unit5, Unit7;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button2Click(Sender: TObject);
    procedure Button2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dvizi_se;
    procedure FormResize(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form11: TForm11; 

implementation
uses Unit1;

{$R *.lfm}

{ TForm11 }

procedure TForm11.FormResize(Sender: TObject);
begin
  Memo1.Width:=Form11.Width - 20;
  Memo1.Height:=Form11.Height - 41;
  Button1.Left:=Form11.Width - 73;
  Button1.Top:=Form11.Height- 33;
  Button2.Left:=Form11.Width - 41;
  Button2.Top:=Form11.Height- 33;
  CheckBox1.Top:=Form11.Height - 33;
end;

procedure TForm11.dvizi_se;
var linija : String;
    i : integer;
begin
      Form11.Memo1.Clear;
      val(arKniga[pozicija], Knigabe);
      val(arGlava[pozicija], Glavabe);
      str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
      Form11.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';

      for i:=1 to vrtisuchi-1 do begin
       if ShowBibleNames then Form11.Memo1.Append(arKoiBeBiblii[i]);
       Form11.Memo1.Append(arBibles[i, pozicija]);
       Form11.Memo1.Append(' ');
      end;

      Form11.Memo1.SelStart:=0;
end;

procedure TForm11.Button1Click(Sender: TObject);
begin
       pozicija:=pozicija-1;
       if pozicija < 1 then pozicija:=1;
       dvizi_se;
end;

procedure TForm11.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   Form11.Memo1.OnKeyDown(Memo1, Key, Shift);
end;

procedure TForm11.Button2Click(Sender: TObject);
begin
       pozicija:=pozicija+1;
       if pozicija > 31102 then pozicija:=31102;
       dvizi_se;
end;

procedure TForm11.Button2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Form11.Memo1.OnKeyDown(Memo1, Key, Shift);
end;

procedure TForm11.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then ShowBibleNames:=True
                       else ShowBibleNames:=False;
  dvizi_se;
end;

procedure TForm11.CheckBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    Form11.Memo1.OnKeyDown(Memo1, Key, Shift);
end;

procedure TForm11.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   // showmessage(IntToStr(Key));
   if Key=VK_LEFT then begin
       pozicija:=pozicija-1;
       if pozicija < 1 then pozicija:=1;
       Key:=0;
       dvizi_se;
   end;
   if Key=VK_Right then begin
       pozicija:=pozicija+1;
       if pozicija > 31102 then pozicija:=31102;
       Key:=0;
       dvizi_se;
   end;

   if (Key=78) then begin                // Note  N=78
      Form5.Show;
      Form5.Color:=Form1Color;
      Form5.Memo1.Color:=Form1Color;
      Form5.Memo1.Font.Color:=Font1Color;
      Form5.Memo1.Font.Size:=StrToInt(KojFont);
      Key:=0;
   end;

   If Key=86 then begin  // V=verse search
      Form7.Show;
      Key:=0;
   end;
end;

end.

