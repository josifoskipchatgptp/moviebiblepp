unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, dos, LCLProc, LCLType, Unix, Unit5, Unit7, Unit9, Unit10, Unit11, Unit15, Unit17, LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Timer1: TTimer;
    mbfbh_TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button2Click(Sender: TObject);
    procedure Button2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button3Click(Sender: TObject);
    procedure Button3KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button4Click(Sender: TObject);
    procedure Button4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure Button5Click(Sender: TObject);
    procedure Button5KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure mbfbh_TrayIcon1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;
  fbiblija1, fbiblija2, bt , mv, mvkoja, scl, sc : text;
  arKniga : array [1..31102] of String;
  arGlava : array [1..31102] of String;
  arStih : array [1..31102] of String;
  arTekst : array [1..31102] of String;
  arTekst2 : array [1..31102] of String;
  arKnigaNaslov : array [1..67] of String;
  arBibles : array [1..100, 1..32000] of String;
  arKoiBeBiblii : array [1..100] of String;
  pozicija, some13pozicija, sekundi, BrSekundi, Knigabe, Glavabe : Integer;
  SeOtvoriLiForm2 : boolean;
  Kniga, Glava, Stih : Integer;
  PreKniga, PreGlava : Integer;
  arKnigaGlava : array [1..66, 1..150] of Integer;
  stKnigaGlavaImaStihovi : String;
  arKnigakonGlava : array[1..66] of Integer;
  arPozicija : array[1..66, 1..150, 1..176] of Integer;
  PositionSeSmeni, pauza , prvpatBack, ShowBibleNames: Boolean;
  poz : text;
  sPozicija : String;
  probaPozicija , ZapamtiPozicija: Integer;
  TrialZavrsi : Boolean;
  LevaGranicaMatej11 : Integer;
  ParalelMode , EdnasProcitani, NapunetoPole: boolean;
  KojaBiblija1, KojaBiblija2, boti, KojFont, KojaBrzina,  KojParalel : String;
  nKojFont, nKojaBrzina : integer;
  ye, mo, da , wda:word;
  stye, stmo, stda, stwda, OS:string;
  prvopustanje : integer;
  SlikiBrojac , ichapter, conditionexit, vrtisuchi, iStopAtPosition : integer;
  strChapter , stizlez, minintray, stcelo, sStopAtPosition: String;
  Form1Color, CB1I, Font1Color, CB2I, f1width, f1height, PreLines, ecounter : Integer;
  OneByOne, OneByOne2, LevoDesno, mbmany , bStopAtPosition: Boolean;
  dash : String;
  //else if da > 30 then TrialZavrsi:=true

implementation
uses Unit2;
{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var linija, linija2, stKniga, stGlava, stStih , sindex: String;
    i , ibre, ibib, spejs, dvetocki, index, KolkuStihaimaGlavata: integer;
    boolNeSkokaj : Boolean;
    k : Word;


begin
    prvopustanje:=0;
    OS:='/';
    TrialZavrsi:=false;
    getdate(ye, mo, da, wda);
    conditionexit:=11;
    ShowBibleNames:=True;
    NapunetoPole := False;
    OneByOne2 := False;
    ecounter := 1;
    dash := '❤';
    bStopAtPosition:=False;
    AssignFile(scl, 'scramblel.txt');
    AssignFile(sc, 'scramble.txt');

    // Vcituvanje na Biblijata/Bibliite
  AssignFile(poz, 'mbfbhSettings.txt');
  if FileExists('mbfbhSettings.txt') then begin
                                           reset(poz);
                                           readln(poz, sPozicija);
                                           readln(poz, minintray);
                                           readln(poz, sPozicija);
                                           val(sPozicija, probaPozicija);
                                           if (probaPozicija <= 0) or (probaPozicija > 31100) then pozicija:=23146
                                                                                              else pozicija:=round(probaPozicija);
                                           if TrialZavrsi and (probaPozicija < 23146) then pozicija:=23146;
                                           readln(poz, KojaBiblija1);
                                           KojaBiblija1:=trim(KojaBiblija1);
                                           readln(poz, KojaBiblija2);
                                           KojaBiblija2:=trim(KojaBiblija2);
                                           readln(poz, boti);
                                           boti:=trim(boti);
                                           readln(poz, KojFont);
                                           readln(poz, KojaBrzina);
                                           readln(poz, KojParalel);
                                           KojParalel:=trim(KojParalel);
                                           readln(poz, linija);
                                           Form1Color:=StrToInt(linija);
                                           readln(poz, linija);
                                           CB1I:=StrToInt(linija);
                                           readln(poz, linija);
                                           Font1Color:=StrToInt(linija);
                                           readln(poz, linija);
                                           CB2I:=StrToInt(linija);
                                           readln(poz, linija);
                                           f1width:=StrToInt(linija);
                                           readln(poz, linija);
                                           f1height:=StrToInt(linija);
                                           readln(poz, linija);
                                           if linija='T' then OneByOne:=True
                                                         else OneByOne:=False;
                                           readln(poz, linija);
                                           if linija='T' then LevoDesno:=True
                                                         else LevoDesno:=False;
                                           readln(poz, linija);
                                           PreLines:=StrToInt(linija);
                                           readln(poz, linija);
                                           if linija='mbmanyF' then mbmany:=False
                                                               else mbmany:=True;
                                         end else begin
                                           minintray:='normal';
                                           pozicija:=25000;
                                           KojaBiblija1:='EN_Bible_NET.txt';
                                           KojaBiblija2:='/';
                                           boti:='English.txt';
                                           KojFont:='16';
                                           KojaBrzina:='10';
                                           KojParalel:='Single';
                                           Form1Color:=16777215;
                                           CB1I:=15;
                                           Font1Color:=0;
                                           CB2I:=0;
                                           f1width:=500;
                                           f1height:=400;
                                         end;
  CloseFile(poz);
  if trim(kojparalel)='paralel' then begin
                                    ParalelMode:=true
                               end
                          else begin
                            ParalelMode:=false;
                            kojparalel:='single';
                          end;
  if KojaBiblija1 = KojaBiblija2 then paralelmode:=false;
  assignfile(fbiblija1, 'Bibles'+OS+trim(KojaBiblija1));
  if paralelmode then assignfile(fbiblija2, 'Bibles'+OS+trim(KojaBiblija2));
  reset(fbiblija1);
  if paralelmode then reset(fbiblija2);
  ibre :=0;
  PreKniga:=1;
  PreGlava:=1;
  // vcituvanje na biblijata/bibliite
  for ibib:=1 to 62204 do begin
   readln(fbiblija1, linija);
   if paralelmode then readln(fbiblija2, linija2);
   ibre:=ibre+1;
   if (ibre mod 2) = 1 then begin
     spejs:=0;
     dvetocki:=0;
     for i:=1 to length(linija) do begin
       if linija[i] = ' ' then spejs:=i;
       if linija[i] = ':' then dvetocki:=i;
     end; // for i
     stKniga:= copy(linija, 4,spejs-4);
     stGlava := copy(linija, spejs+1, dvetocki-spejs-1);
     stStih := copy(linija, dvetocki+1, length(linija)-dvetocki);
     index :=(ibre div 2)+1;
     arKniga[index]:=stKniga;
     arGlava[index]:=stGlava;
     arStih[index]:=stStih;
     val(stKniga, Kniga);
     val(stGlava, Glava);
     val(stStih, Stih);
     arPozicija[Kniga, Glava, Stih]:=index;
     if Kniga <> PreKniga then  begin
                          arKnigakonGlava[PreKniga]:=PreGlava;
                          val(arStih[index-1], KolkuStihaimaGlavata);
                          arKnigaGlava[Kniga-1, PreGlava]:=KolkuStihaImaGlavata;
                          PreKniga:=Kniga;
                          boolNeSkokaj:=false;
     end else boolNeSkokaj:=true;
     if (Glava <> PreGlava) AND boolNeSkokaj then  begin
                               val(arStih[index-1], KolkuStihaimaGlavata);
                               arKnigaGlava[Kniga, PreGlava]:=KolkuStihaImaGlavata;
                               PreGlava:=Glava;
     end;
   end // if (ibre mod 2) = 1
   else begin
            arTekst[ibre div 2]:=linija;
            if paralelmode then arTekst2[ibre div 2]:=linija2;
        end;
  end; // for i:=1 to 62204

  closefile(fbiblija1);
  if paralelmode then closefile(fbiblija2);
  arKnigakonGlava[66]:=22;
  arKnigaGlava[66, 22]:=21;
   //vcituvanje na naslovite
  assignfile(bt, 'BooksTitles'+OS+trim(boti));
  reset(bt);
  i:=0;
  while not(eof(bt)) do begin
    i:=i+1;
    readln(bt, linija);
    arKnigaNaslov[i]:=linija;

  end;
  closefile(bt);

  val(KojaBrzina, nKojaBrzina);
  sekundi:=1;
  BrSekundi:=nKojaBrzina;
  SeOtvoriLiForm2:=false;
  pauza:=true;
  prvpatback:=false;
  FormResize(Form1);
  val(KojFont, nKojFont);
  Memo1.Font.Size:=nKojFont;
  Label1.Visible:=false;
  EdnasProcitani:=true; // ova e za brzinata i fontot da se prenesat vo combo4 i 5
  Form1.Color:=Form1Color;
  Memo1.Color:=Form1Color;
  Memo1.Font.Color:=Font1Color;
  Label1.Font.Color:=Font1Color;
  Label2.Font.Color:=Font1Color;
  mbfbh_TrayIcon1.Icon.LoadFromFile('mbfbh.ico');
  mbfbh_TrayIcon1.Show;
  if minintray='minimizedintray' then begin
       form1.WindowState := wsNormal;
       form1.Hide;
       Form1.ShowInTaskBar := stNever;
     end // if minintray
     else begin
               Form1.Show;
               minintray:='normal';
      end;
  if not(NapunetoPole) then begin
  vrtisuchi:=1;
  AssignFile(mv, 'BibleList.txt');
  reset(mv);
  while not(eof(mv)) do begin
     readln(mv, linija);
     if ( trim(copy(linija, 1, 1)) <> '#' ) AND ( trim(linija) <> '' )then begin
      if FileExists('Bibles'+OS+trim(linija)) then begin
       assignfile(mvkoja, 'Bibles'+OS+trim(linija));
       reset(mvkoja);
       arKoiBeBiblii[vrtisuchi]:=trim(linija);
       for i:=1 to 62204 do begin
        readln(mvkoja, linija);
        if i mod 2 = 0 then arBibles[vrtisuchi, i DIV 2]:=linija;
       end; // for i:=1 to 62204
       CloseFile(mvkoja);
       vrtisuchi:=vrtisuchi + 1;
      end; // if FileExists
     end; // if trim(copy
  end; // while not
  CloseFile(mv);
  end; // if not(NapunetoPole
  NapunetoPole := True;
  knigabe:=StrToInt(arKniga[pozicija]);
end;  // Form1Create

procedure CripplingText(st: String);
var i,j,k,m, randchoise, dolzina, spznaci, hiding, plus:Integer;
    remarr : array [1..10000] of integer;
    skokni, skokni1, skokni2, NajdenaBukva, NajdenaBukva1, NajdenaBukva2 : Boolean;
    charP, charP1, charP2 , znak, st2, LevZbor, DesenZbor: String;
    Zbor, Zbor2 : array [1..1000] of String;

begin
  hiding:=conditionexit;
  dolzina:=UTF8length(st);
  if st='' then st:=' ';
  i:=0;
  spznaci:=0;
  for j:=1 to dolzina do begin
   znak:=UTF8Copy(st, j, 1);
   if (znak=' ') or (znak=',') or (znak='.') or (znak=';') or (znak='!') or (znak='?') or (znak=':') or (znak='"') or (znak='„') or (znak='“') or (znak='(') or (znak=')') or (znak='[') or (znak=']') or (znak='{') or (znak='}') or (znak=#13) then spznaci:=spznaci+1;
  end;

  if ((hiding > 0) AND (hiding <=90))then begin
  repeat
    randchoise:=random(dolzina)+1;
    skokni:=false;
    charP:=UTF8Copy(st, randchoise, 1);
    if (charP=' ') or (charP=',') or (charP='.') or (charP=';') or (charP='!') or (charP='?') or (charP=':') or (charP='"') or (charP='„') or (charP='“') or (charP='(') or (charP=')') or (charP='[') or (charP=']') or (charP='{') or (charP='}') or (charP=#13) then begin
           skokni:=true;
    end;
    for j:=1 to i do
     if randchoise = remarr[j] then skokni:=true;
    if not(skokni) then begin
      i:=i+1;
      remarr[i]:=randchoise;
    end;
  until (i >= round(dolzina/(100/conditionexit))) or (i >= (dolzina - spznaci -1));
  end; // if hiding > 0  and hiding < 90

  if (hiding=91) OR (hiding=92) OR (hiding=93) OR (hiding=95) then begin
      // skrsi ja recenicata na zborovi
      k:=1;
      st:=trim(st);
      for i:=1 to UTF8length(st)do begin
          if UTF8Copy(st, i, 1) <> ' ' then Zbor[k]:=Zbor[k]+UTF8Copy(st, i, 1)
                      else begin
                         k:=k+1;
                      end;   // if UTF8Copy
                      end;   // for i:=1 to UTF8


      for i:=1 to k do begin
        NajdenaBukva:=False;
        NajdenaBukva1:=False;
        NajdenaBukva2:=False;
        LevZbor:='';
        DesenZbor:='';
        if UTF8Length(Zbor[i]) mod 2 = 0 then plus:=0
                                         else plus:=1;
        for m:=1 to UTF8Length(Zbor[i]) do begin
          if (hiding=91) OR (hiding=95) then charP:=UTF8Copy(Zbor[i], m, 1)
                         else charP:=UTF8Copy(Zbor[i], UTF8Length(Zbor[i])-m+1, 1);
          if (hiding=93) then begin
           if m <= ((UTF8Length(Zbor[i]) DIV 2) + plus) then begin
                                     charP1:=UTF8Copy(Zbor[i], m, 1);
                                     CharP2:=UTF8Copy(Zbor[i], UTF8Length(Zbor[i])-m+1, 1);
           if (charP1=' ') or (charP1=',') or (charP1='.') or (charP1=';') or (charP1='!') or (charP1='?') or (charP1=':') or (charP1='"') or (charP1='„') or (charP1='“') or (charP1='(') or (charP1=')') or (charP1='[') or (charP1=']') or (charP1='{') or (charP1='}') then
             skokni1:=true else skokni1:=false;
            if (charP2=' ') or (charP2=',') or (charP2='.') or (charP2=';') or (charP2='!') or (charP2='?') or (charP2=':') or (charP2='"') or (charP2='„') or (charP2='“') or (charP2='(') or (charP2=')') or (charP2='[') or (charP2=']') or (charP2='{') or (charP2='}') then
             skokni2:=true else skokni2:=false;
             if skokni1 then LevZbor:=LevZbor + charP1
                      else if NajdenaBukva1 then LevZbor:=LevZbor+dash
                                           else begin
                                              LevZbor:=LevZbor+charP1;
                                              NajdenaBukva1:=True;
                                           end;
             if not(m = ((UTF8Length(Zbor[i]) DIV 2) + 1)) then
             if skokni2 then DesenZbor:=charP2 + DesenZbor
                       else if NajdenaBukva2 then DesenZbor:=dash + DesenZbor
                                            else begin
                                               DesenZbor:=charP2 + DesenZbor;
                                               NajdenaBukva2:=True;
                                            end;
           end; // if m <= round
          end; // if crippling=93

          if (charP=' ') or (charP=',') or (charP='.') or (charP=';') or (charP='!') or (charP='?') or (charP=':') or (charP='"') or (charP='„') or (charP='“') or (charP='(') or (charP=')') or (charP='[') or (charP=']') or (charP='{') or (charP='}') then
             skokni:=true
             else skokni:=false;

          if (hiding=91) OR (hiding=95) then begin
             if skokni then Zbor2[i]:=Zbor2[i] + charP
                       else if NajdenaBukva then
                                               if (hiding=91) then Zbor2[i]:= Zbor2[i] + dash
                                                              else
                                            else begin
                                               Zbor2[i]:=Zbor2[i]+charP;
                                               NajdenaBukva:=True;
                                            end;
          end; // if hiding=91
          if hiding=92 then begin
             if skokni then Zbor2[i]:=charP + Zbor2[i]
                       else if NajdenaBukva then Zbor2[i]:=dash + Zbor2[i]
                                            else begin
                                               Zbor2[i]:=charP + Zbor2[i];
                                               NajdenaBukva:=True;
                                            end;
          end; // if hiding=92
        end; // for m:=1 to
        if hiding=93 then Zbor2[i]:=LevZbor+DesenZbor;
       end; // for i:=1 to k
    end; // if (hiding=91) OR (hiding=92) OR (hiding=93)

  st2:=st;

  if ((hiding > 0) AND (hiding <=90)) then
   for j:=1 to i do begin
             UTF8Delete(st2, remarr[j],1);
             UTF8Insert(AnsiToUTF8(dash), st2, remarr[j]);
       end;

  if (hiding=91) OR (hiding=92) OR (hiding=93) OR (hiding=95) then begin
    st2:='';
    for i:=1 to k do begin
       st2:=st2+Zbor2[i]+'  ';
       Zbor[i]:='';
       Zbor2[i]:='';
      end; // for i
  end; // if (hiding=91

  if hiding = 94 then begin
      rewrite(scl);
      writeln(scl, st);
      CloseFile(scl);
      FpSystem('./mbfbh_scramble.py');
      reset(sc);
      readln(sc, st2);
      CloseFile(sc); // python method
  end; // if hiding=94

  if hiding = 96 then begin
      rewrite(scl);
      writeln(scl, st);
      CloseFile(scl);
      FpSystem('./mbfbh_vowels.py');
      reset(sc);
      readln(sc, st2);
      CloseFile(sc); // python method
  end; // if hiding=96


  if hiding > 0 then
                  stizlez:=st2
                else
                  stizlez:=st;

end;

procedure TForm1.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var skey , smalo, st, st1, st2, linija: String;
    i, incounter : integer;

begin
    // showmessage(IntToStr(key));

   if (Key=77) then begin                // Many views M=77
    pauza:=true;
    Label1.Visible:=true;
    Timer1.Enabled:=false;
    Form11.Memo1.Clear;
    val(arGlava[pozicija], Glavabe);
    str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
    Form11.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';

    if not(NapunetoPole) then begin
    vrtisuchi:=1;
    AssignFile(mv, 'BibleList.txt');
    reset(mv);
    while not(eof(mv)) do begin
       readln(mv, linija);
       if ( trim(copy(linija, 1, 1)) <> '#' ) AND ( trim(linija) <> '' )then begin
        if FileExists('Bibles'+OS+trim(linija)) then begin
         assignfile(mvkoja, 'Bibles'+OS+trim(linija));
         reset(mvkoja);
         arKoiBeBiblii[vrtisuchi]:=trim(linija);
         for i:=1 to 62204 do begin
          readln(mvkoja, linija);
          if i mod 2 = 0 then arBibles[vrtisuchi, i DIV 2]:=linija;
         end; // for i:=1 to 62204
         CloseFile(mvkoja);
         vrtisuchi:=vrtisuchi + 1;
        end; // if FileExists
       end; // if trim(copy
    end; // while not
    CloseFile(mv);
    end; // if not(NapunetoPole
    NapunetoPole := True;

    for i:=1 to vrtisuchi-1 do begin
      if ShowBibleNames then Form11.Memo1.Append(arKoiBeBiblii[i]);
      Form11.Memo1.Append(arBibles[i, pozicija]);
      Form11.Memo1.Append(' ');
    end;

    Form11.Show;
    Form11.Color:=Form1Color;
    Form11.Memo1.Color:=Form1Color;
    Form11.Memo1.Font.Color:=Font1Color;
    Form11.Memo1.Font.Size:=StrToInt(KojFont);
    Form11.Memo1.SelStart:=0;
   end; // Key=78 M

   if (Key=78) then begin                // Note  N=78
      pauza:=true;
      Label1.Visible:=true;
      Timer1.Enabled:=false;
      Form5.Show;
      Form5.Color:=Form1Color;
      Form5.Memo1.Color:=Form1Color;
      Form5.Memo1.Font.Color:=Font1Color;
      Form5.Memo1.Font.Size:=StrToInt(KojFont);
   end;
   if (Key=80) then begin  // P=80   play/pause
    if pauza=false then
    begin
     Label1.Visible:=true;
     Timer1.Enabled:=false;
     pauza:=true;
    end else begin
        Label1.Visible:=false;
        Timer1.Enabled:=true;
        pauza:=false;
        PrvPatBack:=false;
    end;
  end;
   if Key=67 then begin // C=Chapter view
    Label1.Visible:=true;
    Timer1.Enabled:=false;
    pauza:=true;
    incounter:= 0;
    If EmptyRows then begin
                       Form9.Memo1.Clear;
                       // strChapter:='';
                       for ichapter:=1 to 31102 do
                        if arKniga[ichapter]=arKniga[pozicija] then
                         if arGlava[ichapter]=arGlava[pozicija] then
                           if paralelmode then begin
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter] + '●');
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst2[ichapter] + '●');
                                                incounter:= incounter + 1;
                                               end
                                            // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter]+ ' -*- ' + arTekst2[ichapter] + '  '
                                          else begin
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter] + '●');
                                                incounter:= incounter + 1;
                                               end;
                                            // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter] + '  ';
                       Form9.Show;
                       val(arKniga[pozicija], Knigabe);

                 end
                 else begin
                       Form9.Memo1.Clear;
                       // strChapter:='';
                       for ichapter:=1 to 31102 do
                        if arKniga[ichapter]=arKniga[pozicija] then
                         if arGlava[ichapter]=arGlava[pozicija] then
                           if paralelmode then begin
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter]  + '●');
                                                Form9.Memo1.Append(' ');
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst2[ichapter]  + '●');
                                                Form9.Memo1.Append(' ');
                                                incounter:= incounter + 1;
                                               end
                                            // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter]+ ' -*- ' + arTekst2[ichapter] + '  '
                                          else begin
                                                Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter]  + '●');
                                                Form9.Memo1.Append(' ');
                                                incounter:= incounter + 1;
                                               end;
                                            // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter] + '  ';
                       Form9.Show;
                       val(arKniga[pozicija], Knigabe);

                 end;
    val(arKniga[pozicija], Knigabe);
    Form9.Caption:=arKnigaNaslov[Knigabe] + ' ' + arGlava[pozicija] + ' (' + IntToStr(incounter) + ')';
    (*
    Form9.Memo1.Clear;
    // strChapter:='';
    incounter:= 0;
    for ichapter:=1 to 31102 do
     if arKniga[ichapter]=arKniga[pozicija] then
      if arGlava[ichapter]=arGlava[pozicija] then
        if paralelmode then begin
                             Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter] + '●');
                             Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst2[ichapter] + '●');
                             incounter:= incounter + 1;
                            end
                         // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter]+ ' -*- ' + arTekst2[ichapter] + '  '
                       else begin
                              Form9.Memo1.Append(arStih[ichapter]+'. '+arTekst[ichapter] + '●');
                              incounter:= incounter + 1;
                            end;
                         // strChapter:=strChapter+arStih[ichapter]+'. '+arTekst[ichapter] + '  ';
    Form9.Show;
    val(arKniga[pozicija], Knigabe);
    Form9.Caption:=arKnigaNaslov[Knigabe] + ' ' + arGlava[pozicija] + ' (' + IntToStr(incounter) + ')';
    // Form9.Memo1.Text:=strChapter; *)

   end;
   If Key=191 then begin  // '/' = button ? visible-unvisible

   end;
   If Key=86 then begin  // V=verse search
      Form7.Show;
      Label1.Visible:=true;
      Timer1.Enabled:=false;
      pauza:=true;
   end;

   if Key=VK_RIGHT then begin   // next
    Label1.Visible:=true;
    Label2.Visible:=false;
    Timer1.Enabled:=false;
    pauza:=true;
    if not(mbmany) then begin
{    if not(prvpatback) then begin
                               ZapamtiPozicija:=pozicija+1;
                               pozicija:=pozicija+1;
                            end; }
    prvpatback:=true;
    pozicija:=pozicija+1;
    if OneByOne AND OneByOne2 then pozicija:=pozicija-1;
    if pozicija > 31102 then pozicija:=31102;
    if TrialZavrsi and (pozicija=23145) then pozicija:=23146;
    val(arKniga[pozicija], Knigabe);
    Memo1.Clear;
    if ParalelMode then begin
                          if not(OneByOne) then begin
                               st1:=arTekst[pozicija];
                               st2:=arTekst2[pozicija];
                               stcelo:=st1 + #13#10#13#10 + st2;
                          end else begin
                             if not(OneByOne2) then begin
                               st1:=arTekst[pozicija];
                               st2:='';
                               stcelo:=st1 + #13#10#13#10 + st2;
                               OneByOne2:=not(OneByOne2);
                             end else begin
                               st1:=arTekst[pozicija];
                               st2:=arTekst2[pozicija];
                               stcelo:=st1 + #13#10#13#10 + st2;
                               OneByOne2:=not(OneByOne2);
                             end;
                          end;
                     end
                     else begin
                               st1:=arTekst[pozicija];
                               stcelo:=st1;
                          end;

    CripplingText(st1);
    st1:=stizlez;
    If ParalelMode then begin
                          CripplingText(st2);
                          st2:=stizlez;
                          stizlez:=st1 + #13#10#13#10 + st2;
                         end;

    Memo1.Clear;
    for i:=1 to PreLines do Memo1.Append(' ');
    Memo1.Append(stizlez);
    val(arGlava[pozicija], Glavabe);
    str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
    Form1.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
    end // if not(mbmany)
    else begin
          Memo1.Clear;
          for i:=1 to PreLines do Memo1.Append(' ');
          Memo1.Append(arBibles[ecounter, pozicija]);
          ecounter:=ecounter+1;
          val(arKniga[pozicija], Knigabe);
          val(arGlava[pozicija], Glavabe);
          str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
          Form1.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
          if ecounter >= vrtisuchi then begin
               ecounter:=1;
               pozicija:=pozicija+1;
          end;
          if pozicija > 31102 then pozicija:=31102;
    end;
   end; // if key=VK_RIGHT

   if Key=VK_LEFT then begin  // back
    Label1.Visible:=true;
    Label2.Visible:=false;
    Timer1.Enabled:=false;
    pauza:=true;
 {    if not(prvpatback) then begin
                               ZapamtiPozicija:=pozicija-1;
                               pozicija:=pozicija-1;
                            end; }
    prvpatback:=true;
    pozicija:=pozicija-1;
    if pozicija < 1 then pozicija:=1;
    if TrialZavrsi and (pozicija=23145) then pozicija:=23146;
    val(arKniga[pozicija], Knigabe);
     Memo1.Clear;
    if ParalelMode then begin
                               st1:=arTekst[pozicija];
                               st2:=arTekst2[pozicija];
                               stcelo:=st1 + #13#10#13#10 + st2;
                     end
                     else begin
                             st1:=arTekst[pozicija];
                             stcelo:=st1;
                          end;
    CripplingText(st1);
    st1:=stizlez;
    If ParalelMode then begin
                          CripplingText(st2);
                          st2:=stizlez;
                          stizlez:=st1 + #13#10#13#10 + st2;
                         end;
    Memo1.Clear;
    for i:=1 to PreLines do Memo1.Append(' ');
    Memo1.Append(stizlez);

    val(arGlava[pozicija], Glavabe);
    str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
    Form1.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
   end;

   if Key=VK_UP then begin
                        Memo1.Clear;
                        for i:=1 to PreLines do Memo1.Append(' ');
                        Memo1.Append(stcelo);
                     end;
   if Key=VK_DOWN then begin
                        Memo1.Clear;
                        for i:=1 to PreLines do Memo1.Append(' ');
                        Memo1.Append(stizlez);
                       end;

  { if Key=83 then begin  // S for simple reader
     Label1.Visible:=true;
     Timer1.Enabled:=false;
     pauza:=true;
     form10.Show;
     Form10.Color:=Form1Color;
     Form10.Memo1.Color:=Form1Color;
     Form10.Memo1.Font.Color:=Font1Color;
     Form10.Memo1.Font.Size:=StrToInt(KojFont);
     form1.Hide;
   end; }
   if Key=79 then ShowMessage(IntToStr(pozicija));

   if (Key=66) then begin                // Bookmarks  B=66
      Form15.Show;
   end;

   if Key=83 then begin                // Speed navigation S=88
      Form1.Timer1.Enabled:= False;
      Form1.Label1.Visible:= True;
      pauza:= True;
      Form17.Show;
   end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var shif : TShiftState;
    Key : Word;
begin
  Key := VK_LEFT;
  Button1KeyDown(Button1, Key, shif);
end;

procedure TForm1.Button3Click(Sender: TObject);
var shif : TShiftState;
    Key : Word;
begin
  Key := VK_RIGHT;
  Button1KeyDown(Button1, Key, shif);
end;

procedure TForm1.Button2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Button1KeyDown(Button1, Key, Shift);
end;

procedure TForm1.Button3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Button1KeyDown(Button1, Key, Shift);
end;

procedure TForm1.Button4Click(Sender: TObject);
var shif : TShiftState;
    Key : Word;
begin
  Key:= VK_UP;
  Button1KeyDown(Button1, Key, shif);
end;

procedure TForm1.Button4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Button1KeyDown(Button1, Key, Shift);
end;

procedure TForm1.Button5Click(Sender: TObject);
var shif : TShiftState;
    Key : Word;
begin
  Key:= VK_DOWN;
  Button1KeyDown(Button1, Key, shif);
end;

procedure TForm1.Button5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Button1KeyDown(Button1, Key, Shift);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
  Timer1.enabled:=false;
  Label1.visible:=true;
  pauza:=true;
  Form2.Show;
  Form2.ColorButton1.ButtonColor:=Form1Color;
  Form2.ColorButton2.ButtonColor:=Font1Color;
  case PreLines of
       0 : Form2.ComboBox7.ItemIndex:=0;
       1 : Form2.ComboBox7.ItemIndex:=1;
       2 : Form2.ComboBox7.ItemIndex:=2;
       3 : Form2.ComboBox7.ItemIndex:=3;
       4 : Form2.ComboBox7.ItemIndex:=4;
       else  Form2.ComboBox7.ItemIndex:=0;
  end;
  if mbmany then Form2.CheckBox3.Checked:=True
            else Form2.CheckBox3.Checked:=False;
  if minintray='minimizedintray' then Form2.CheckBox1.Checked:=True
                                 else Form2.CheckBox1.Checked:=False;
  PositionSeSmeni:=false;
  if SeOtvoriLiForm2=false then begin
   for i:=1 to 66 do Form2.Combobox1.AddItem(arKnigaNaslov[i],nil);
  end;
  SeOtvoriLiForm2:=true;
  val(arKniga[pozicija-1], Kniga);
  Form2.Combobox1.Itemindex:=Kniga-1;
  Form2.ComboBox1Change(form2.ComboBox1);
  val(arGlava[pozicija-1], Glava);
  Form2.Combobox2.Itemindex:=Glava-1;
  Form2.ComboBox2Change(form2.ComboBox2);
  val(arStih[pozicija-1], Stih);
  Form2.Combobox3.Itemindex:=Stih-1;
  if EdnasProcitani then begin
  case nKojaBrzina of
       1 : Form2.ComboBox4.ItemIndex:=0;
       2 : Form2.ComboBox4.ItemIndex:=1;
       3 : Form2.ComboBox4.ItemIndex:=2;
       4 : Form2.ComboBox4.ItemIndex:=3;
       5 : Form2.ComboBox4.ItemIndex:=4;
       6 : Form2.ComboBox4.ItemIndex:=5;
       7 : Form2.ComboBox4.ItemIndex:=6;
       8 : Form2.ComboBox4.ItemIndex:=7;
       9 : Form2.ComboBox4.ItemIndex:=8;
       10 : Form2.ComboBox4.ItemIndex:=9;
       11 : Form2.ComboBox4.ItemIndex:=10;
       12 : Form2.ComboBox4.ItemIndex:=11;
       13 : Form2.ComboBox4.ItemIndex:=12;
       14 : Form2.ComboBox4.ItemIndex:=13;
       15 : Form2.ComboBox4.ItemIndex:=14;
       16 : Form2.ComboBox4.ItemIndex:=15;
       17 : Form2.ComboBox4.ItemIndex:=16;
       18 : Form2.ComboBox4.ItemIndex:=17;
       19 : Form2.ComboBox4.ItemIndex:=18;
       20 : Form2.ComboBox4.ItemIndex:=19;
       21 : Form2.ComboBox4.ItemIndex:=20;
       22 : Form2.ComboBox4.ItemIndex:=21;
       23 : Form2.ComboBox4.ItemIndex:=22;
       24 : Form2.ComboBox4.ItemIndex:=23;
       25 : Form2.ComboBox4.ItemIndex:=24;
       26 : Form2.ComboBox4.ItemIndex:=25;
       27 : Form2.ComboBox4.ItemIndex:=26;
       28 : Form2.ComboBox4.ItemIndex:=27;
       29 : Form2.ComboBox4.ItemIndex:=28;
       30 : Form2.ComboBox4.ItemIndex:=29;
       31 : Form2.ComboBox4.ItemIndex:=30;
       32 : Form2.ComboBox4.ItemIndex:=31;
       33 : Form2.ComboBox4.ItemIndex:=32;
       34 : Form2.ComboBox4.ItemIndex:=33;
       35 : Form2.ComboBox4.ItemIndex:=34;
       36 : Form2.ComboBox4.ItemIndex:=35;
       37 : Form2.ComboBox4.ItemIndex:=36;
       38 : Form2.ComboBox4.ItemIndex:=37;
       39 : Form2.ComboBox4.ItemIndex:=38;
       40 : Form2.ComboBox4.ItemIndex:=39;
       41 : Form2.ComboBox4.ItemIndex:=40;
       42 : Form2.ComboBox4.ItemIndex:=41;
       43 : Form2.ComboBox4.ItemIndex:=42;
       44 : Form2.ComboBox4.ItemIndex:=43;
       45 : Form2.ComboBox4.ItemIndex:=44;
       46 : Form2.ComboBox4.ItemIndex:=45;
       47 : Form2.ComboBox4.ItemIndex:=46;
       48 : Form2.ComboBox4.ItemIndex:=47;
       49 : Form2.ComboBox4.ItemIndex:=48;
       50 : Form2.ComboBox4.ItemIndex:=49;
       51 : Form2.ComboBox4.ItemIndex:=50;
       52 : Form2.ComboBox4.ItemIndex:=51;
       53 : Form2.ComboBox4.ItemIndex:=52;
       54 : Form2.ComboBox4.ItemIndex:=53;
       55 : Form2.ComboBox4.ItemIndex:=54;
       56 : Form2.ComboBox4.ItemIndex:=55;
       57 : Form2.ComboBox4.ItemIndex:=56;
       58 : Form2.ComboBox4.ItemIndex:=57;
       59 : Form2.ComboBox4.ItemIndex:=58;
       60 : Form2.ComboBox4.ItemIndex:=59;
       61 : Form2.ComboBox4.ItemIndex:=60;
       62 : Form2.ComboBox4.ItemIndex:=61;
       63 : Form2.ComboBox4.ItemIndex:=62;
       64 : Form2.ComboBox4.ItemIndex:=63;
       65 : Form2.ComboBox4.ItemIndex:=64;
       66 : Form2.ComboBox4.ItemIndex:=65;

       else Form2.Combobox4.ItemIndex:=0;
  end;
  case nKojFont of
       12 : Form2.ComboBox5.ItemIndex:=0;
       13 : Form2.ComboBox5.ItemIndex:=1;
       14 : Form2.ComboBox5.ItemIndex:=2;
       15 : Form2.ComboBox5.ItemIndex:=3;
       16 : Form2.ComboBox5.ItemIndex:=4;
       17 : Form2.ComboBox5.ItemIndex:=5;
       19 : Form2.ComboBox5.ItemIndex:=6;
       20 : Form2.ComboBox5.ItemIndex:=7;
       22 : Form2.ComboBox5.ItemIndex:=8;
       30 : Form2.ComboBox5.ItemIndex:=9;
       40 : Form2.ComboBox5.ItemIndex:=10;
       50 : Form2.ComboBox5.ItemIndex:=11;
       60 : Form2.ComboBox5.ItemIndex:=12;
       70 : Form2.ComboBox5.ItemIndex:=13;
       80 : Form2.ComboBox5.ItemIndex:=14;
       90 : Form2.ComboBox5.ItemIndex:=15;
       100 : Form2.ComboBox5.ItemIndex:=16;
       else Form2.ComboBox5.ItemIndex:=0;
   end;
   end; // ednas procitani
  EdnasProcitani:=false;
  if Pauza then Form2.Edit2.Text:=IntToStr(pozicija)
           else Form2.Edit2.Text:=IntToStr(pozicija-1);

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer1.Enabled:=False;
  f1width:=Form1.Width;
  f1height:=Form1.Height;
  rewrite(poz);
  Writeln(poz, 'Do not change this file manually!');
  Writeln(poz, minintray);
  str(pozicija, sPozicija);
  writeln(poz, sPozicija);
  writeln(poz, KojaBiblija1);
  writeln(poz, KojaBiblija2);
  writeln(poz, boti);
  writeln(poz, KojFont);
  str(BrSekundi, KojaBrzina);
  writeln(poz, KojaBrzina);
  if paralelmode then KojParalel:='paralel' else KojParalel:='single';
  writeln(poz, KojParalel);
  writeln(poz, IntToStr(Form1Color));
  writeln(poz, IntToStr(CB1I));
  writeln(poz, IntToStr(Font1Color));
  writeln(poz, intToStr(CB2I));
  writeln(poz, IntToStr(f1width));
  writeln(poz, IntToStr(f1height));
  if OneByOne then writeln(poz, 'T')
              else writeln(poz, 'F');
  if Form2.CheckBox2.Checked then writeln(poz, 'T')
                             else writeln(poz, 'F');
  writeln(poz, IntToStr(PreLines));
  if mbmany then writeln(poz, 'mbmanyT')
            else writeln(poz, 'mbmanyF');
  writeln(poz, ' ');
  CloseFile(poz);
  Form15.ListBox1.Items.SaveToFile('bookmarks.dat');
  // Halt;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin

end;

procedure TForm1.FormResize(Sender: TObject);
begin
    Label1.Left:=Form1.Width - 92;
    Button1.Left:=Form1.Width - 60;
    Memo1.Width:=Form1.Width - 50;
    Memo1.Height:=Form1.Height - 100;
    Button2.Left:=Form1.Width - 150;
    Button2.Top:=Form1.Height - 40;
    Button3.Left:=Form1.Width - 97;
    Button3.Top:=Form1.Height - 40;
    Button4.Left:=Form1.Width - 204 ;
    Button4.Top:=Form1.Height - 40;
    Button5.Left:=Form1.Width - 204;
    Button5.Top:=Form1.Height - 27;
    if form1.WindowState=wsminimized then begin
        Label1.Visible:=true;
        Timer1.Enabled:=false;
        pauza:=true;
    end;
end;

procedure TForm1.Memo1Enter(Sender: TObject);
begin
//   if not(prvopustanje=0) then Button1.SetFocus;
//   prvopustanje:=1;
   Button1.SetFocus;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var st, st1, st2 : String;
    i : integer;
begin
  if not(pauza) then begin
    if pozicija > 31102 then begin
                               pozicija:=31102;
                               pauza:=true;
                               Label1.Visible:=True;
                             end;
    if sekundi < 2 then begin
    SlikiBrojac:=SlikiBrojac+1;
    val(arKniga[pozicija], Knigabe);
    Memo1.Clear;
    if ParalelMode then begin
                            if not(OneByOne) then begin
                                 st1:=arTekst[pozicija];
                                 st2:=arTekst2[pozicija];
                                 stcelo:=st1 + #13#10#13#10 + st2;
                            end else begin
                               if not(OneByOne2) then begin
                                 st1:=arTekst[pozicija];
                                 st2:='';
                                 stcelo:=st1 + #13#10#13#10 + st2;
                                 OneByOne2:=not(OneByOne2);
                               end else begin
                                 st1:=arTekst[pozicija];
                                 st2:=arTekst2[pozicija];
                                 stcelo:=st1 + #13#10#13#10 + st2;
                                 OneByOne2:=not(OneByOne2);
                               end;
                            end;
                       end
                       else begin
                                 st1:=arTekst[pozicija];
                                 stcelo:=st1;
                            end;

    CripplingText(st1);
    st1:=stizlez;
    If ParalelMode then begin
                          CripplingText(st2);
                          st2:=stizlez;
                          stizlez:=st1 + #13#10#13#10 + st2;
                         end;
    val(arGlava[pozicija], Glavabe);
    str(arKnigaGlava[Knigabe, Glavabe], stKnigaGlavaImaStihovi);
    Form1.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[pozicija]+','+arStih[pozicija]+'('+stKnigaGlavaImaStihovi+')';
    Memo1.Clear;
    if bStopAtPosition then
      if pozicija = iStopAtPosition then begin
         timer1.Enabled:=false;
         label1.Visible:=true;
         Pauza:=true;
      end;
    for i:=1 to PreLines do Memo1.Append(' ');
    if not(mbmany) then begin
                         Memo1.Append(stizlez);
                         pozicija:=pozicija+1;
                         if OneByOne AND OneByOne2 then pozicija:=pozicija-1;
                        end
                        else begin
                               Memo1.Append(arBibles[ecounter, pozicija]);
                               ecounter:=ecounter+1;
                               if ecounter >= vrtisuchi then begin
                                    ecounter:=1;
                                    pozicija:=pozicija+1;
                               end;
                        end;
    if StrToInt(arStih[pozicija-1]) = 1 then begin
                                      Label2.Caption:=arGlava[pozicija-1];
                                      Label2.Visible:=True;
                                 end
                                      else Label2.Visible:=False;
    sekundi:=BrSekundi;
    end else sekundi:=sekundi-1;
  end;
end;

procedure TForm1.mbfbh_TrayIcon1Click(Sender: TObject);
begin
   if not(form1.Showing) then
     Form1.Show
    else begin
     form1.WindowState := wsNormal;
     form1.Hide;
     Form1.ShowInTaskBar := stNever;
     Label1.Visible:=true;
     Timer1.Enabled:=false;
     pauza:=true;
  end;
end;

end.

