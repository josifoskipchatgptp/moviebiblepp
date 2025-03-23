unit Unit7; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLProc, LCLType, LazUTF8;

type

  { TForm7 }

  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form7: TForm7;
  vf, vfi : text;
  PamtiStih1, PamtiStih2 : String;
  argoto : array[1..31102] of integer;

implementation
uses Unit1, Unit2;
{$R *.lfm}

{ TForm7 }

procedure TForm7.Button1Click(Sender: TObject);
var i,j, k, BrojacNajdeni: integer;
    si , stri, sbn : String;
    Zbor : array[1..100] of String;
    iKniga , Hajde: integer;
    SveTrebaDaSeNajde, SveTrebaDaSeNajde2, SveTrebaDaSeNajde3 : Boolean;
    arSveTrebaDaSeNajde : array[1..66] of Boolean;
    U7pocetok : Integer;
    a_int : Integer;


begin
  ListBox1.Clear;
  Memo1.Clear;
  Memo2.Clear;
  // skrsi ja recenicata na zborovi
  j:=1;
  si:=trim(Edit1.Text);
  for i:=1 to UTF8length(si)do begin
    if UTF8Copy(si, i, 1) <> ' ' then Zbor[j]:=Zbor[j]+UTF8Copy(si, i, 1)
                    else begin
                       j:=j+1;
                    end;
  end;
  // prebaraj niz Biblijata

  BrojacNajdeni:=0;
  if TrialZavrsi then U7pocetok:=23146 else U7pocetok:=1;

  for i:=U7pocetok to 31102 do begin

    if CheckBox1.Checked=False then begin
    SveTrebaDaSeNajde:=true;
    for k:=1 to j do begin
      Hajde:=UTF8pos(UTF8UpperCase(Zbor[k]), UTF8UpperCase(arTekst[i]));
      if Hajde=0 then SveTrebaDaSeNajde:=false;
    end;

    svetrebadasenajde2:=false;
    if paralelmode then begin
    SveTrebaDaSeNajde2:=true;
    for k:=1 to j do begin
      Hajde:=UTF8pos(UTF8UpperCase(Zbor[k]), UTF8UpperCase(arTekst2[i]));
      if Hajde=0 then SveTrebaDaSeNajde2:=false;
    end;
    end; // if paralelmode
    SveTrebaDaSeNajde3:=False;
    end; // if checkbox1.checked=false


    if CheckBox1.Checked then begin
    for a_int:=1 to vrtisuchi-1 do begin
      arSveTrebaDaSeNajde[a_int]:=True;
      for k:=1 to j do begin
       Hajde:=UTF8pos(UTF8UpperCase(Zbor[k]), UTF8UpperCase(arBibles[a_int, i]));
       if Hajde=0 then arSveTrebaDaSeNajde[a_int]:=false;
      end; // for k
    end; // for a_int
    SveTrebaDaSeNajde3:=False;
    for a_int:=1 to vrtisuchi-1 do
      SveTrebaDaSeNajde3:=SveTrebaDaSeNajde3 or arSveTrebaDaSeNajde[a_int];
    SveTrebaDaSeNajde:=False;
    SveTrebaDaSeNajde2:=False;
    end; // if CheckBox1


    val(arKniga[i], iKniga);
    str(i, stri);
    If SveTrebaDaSeNajde or SveTrebaDaSeNajde2 or svetrebadasenajde3 then begin
       BrojacNajdeni:=BrojacNajdeni+1;
       str(BrojacNajdeni, sbn);
       argoto[BrojacNajdeni]:=i;
       ListBox1.Items.Add(sbn+'.'+arKniga[i]+'$'+arKnigaNaslov[iKniga]+' '+arGlava[i]+','+arStih[i]);
    end;
  end; // for i:=U7pocetok to 31102

  AssignFile(vfi, 'VersesFind_Interests.txt');
  if FileExists('VersesFind_Interests.txt')  then begin
                                          append(vfi);
                                     end else
                                     begin
                                          rewrite(vfi);
                                     end;
   str(ye, stye); str(mo, stmo); str(da, stda);
   writeln(vfi, ' ');
   writeln(vfi, si + '   '+stye+'/'+stmo+'/'+stda);
   closeFile(vfi);

  //  ListBox1.Items.SaveToFile('VersesFinded.txt');

    if ListBox1.Items.count > 0 then ListBox1.ItemIndex:=0;


   // ShowMessage('Done!');

   // ListBox1.Items.Add(si);
   // ListBox1.Items.Delete (i);
   // ListBox1.Items.ValueFromIndex[ListBox1.ItemIndex];
   // ListBox1.Items.count
end;

procedure TForm7.Button2Click(Sender: TObject);
var k : Word;
begin
   if ListBox1.Items.Count > 0 then begin
   if mbmany then begin
      ecounter:=1;
      pozicija:=argoto[ListBox1.ItemIndex+1];
   end else pozicija:=argoto[ListBox1.ItemIndex+1]-1;
   k:=39;
   Form1.Button1KeyDown(Button1, k, []);
   end;
end;

procedure TForm7.Button3Click(Sender: TObject);
var i, j, tpozicija : integer;
    s, mesto : String;
begin
    s:='';
    if ListBox1.Items.Count > 0 then begin
      for i:=0 to ListBox1.Items.Count-1 do begin
        mesto:=ListBox1.Items.ValueFromIndex[i];
        s:=s+#13#10;
        s:=s+'('+mesto+')'+#13#10;
        tpozicija:=argoto[i+1];
        for j:=1 to vrtisuchi-1 do
          s:=s+arBibles[j, tpozicija]+#13#10#13#10;
      end;
      AssignFile(vfi, 'VersesFinded.txt');
      rewrite(vfi);
      writeln(vfi, s);
      closeFile(vfi);
      ShowMessage('done!');
    end;
end;

procedure TForm7.CheckBox1Change(Sender: TObject);
var k : Word;
begin

end;

procedure TForm7.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=13 then Button1Click(Button1);
end;

procedure TForm7.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form7.Edit1.Clear;
  ListBox1.Clear;
  Memo1.Clear; Memo2.Clear;
  CheckBox1.Checked:=False;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin

end;

procedure TForm7.ListBox1SelectionChange(Sender: TObject; User: boolean);
var i,j , spejs, zapirka, tocka, dolar: integer;
    x, y, z : Integer;
    sx, sy, sz : String;
    s1, s2 : string;
begin
     s1:= ListBox1.Items.ValueFromIndex[ListBox1.ItemIndex];
     for i:=1 to length(s1) do begin
       if s1[i] = '.' then tocka:=i;
       if s1[i] = '$' then dolar:=i;
       if s1[i] = ' ' then spejs:=i;
       if s1[i] = ',' then zapirka:=i;
     end; // for i

     sx:= copy(s1, tocka+1,dolar-tocka-1);
     sy:= copy(s1, spejs+1, zapirka-spejs-1);
     sz:= copy(s1, zapirka+1, length(s1)-zapirka);
     val(sx, x); val(sy, y); val(sz, z);
     Memo1.Text:=arTekst[arPozicija[x,y,z]];
     if paralelmode then Memo2.Text:=arTekst2[arPozicija[x,y,z]];
     PamtiStih1:=arTekst[arPozicija[x,y,z]];
     if paralelmode then PamtiStih2:=arTekst2[arPozicija[x,y,z]];

end;

end.

