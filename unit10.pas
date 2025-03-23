unit Unit10; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm10 }

  TForm10 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Memo1: TMemo;
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form10: TForm10; 

implementation
uses Unit1;

{$R *.lfm}

{ TForm10 }

procedure TForm10.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Memo1.Text:='';
  Form10.Caption:='';
  Form1.Show;
end;

procedure TForm10.FormResize(Sender: TObject);
begin
  Memo1.Left:=20;
  Memo1.Width:=Form10.Width-40;
  Memo1.Height:=Form10.Height-51;
  Memo1.Top:=24;
  CheckBox1.Left:=Form10.Width-29;
  CheckBox1.Top:=0;
  CheckBox2.Left:=8;
  CheckBox2.Top:=Form10.Height-29;
  CheckBox3.Left:=Form10.Width-77;
  CheckBox4.Left:=Form10.Width-127;
end;

procedure TForm10.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    if not(prvpatback) then begin
                               ZapamtiPozicija:=pozicija+1;
                               pozicija:=pozicija+1;
                            end;
    prvpatback:=true;
    pozicija:=pozicija+1;
    if pozicija > 31102 then pozicija:=31102;
    if TrialZavrsi and (pozicija=23145) then pozicija:=23146;
    val(arKniga[pozicija], Knigabe);
    if ParalelMode then begin
                             Memo1.Clear;
                             Memo1.Lines.Append(arTekst[pozicija]);
                             Memo1.Lines.Append(' ');
                             Memo1.Lines.Append(arTekst2[pozicija]);
                   end
                   else Memo1.text :=arTekst[pozicija];
    val(arGlava[pozicija], Glavabe);
    str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
    Form10.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
    CheckBox1.Checked:=false;
  end;
end;

procedure TForm10.CheckBox2Change(Sender: TObject);
begin
  if CheckBox2.Checked then begin
      if not(prvpatback) then begin
                                 ZapamtiPozicija:=pozicija-1;
                                 pozicija:=pozicija-1;
                              end;
      prvpatback:=true;
      pozicija:=pozicija-1;
      if pozicija < 1 then pozicija:=1;
      if TrialZavrsi and (pozicija=23145) then pozicija:=23146;
      val(arKniga[pozicija], Knigabe);
      if ParalelMode then begin
                               Memo1.Clear;
                               Memo1.Lines.Append(arTekst[pozicija]);
                               Memo1.Lines.Append(' ');
                               Memo1.Lines.Append(arTekst2[pozicija]);
                     end
                     else Memo1.text :=arTekst[pozicija];
      val(arGlava[pozicija], Glavabe);
      str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
      Form10.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
      CheckBox2.Checked:=false;
  end;
end;

procedure TForm10.CheckBox3Change(Sender: TObject);
begin
      val(arKniga[pozicija], Knigabe);
      if ParalelMode then begin
                               Memo1.Clear;
                               Memo1.Lines.Append(arTekst[pozicija]);
                               Memo1.Lines.Append(' ');
                               Memo1.Lines.Append(arTekst2[pozicija]);
                     end
                     else Memo1.text :=arTekst[pozicija];
      val(arGlava[pozicija], Glavabe);
      str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
      Form10.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
      CheckBox3.Checked:=false;
end;

procedure TForm10.CheckBox4Change(Sender: TObject);
begin
  Memo1.Clear;
  Form10.Caption:='';
  CheckBox4.Checked:=false;
end;

end.

