unit Unit17;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm17 }

  TForm17 = class(TForm)
    Edit1: TEdit;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form17: TForm17;
  ab: array[1..66] of String;

implementation
uses Unit1;
{$R *.lfm}

{ TForm17 }

procedure TForm17.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s, getabbrev: String;
    nbook: String;
    nverse: String;
    i, memi, twodotspos, trypozicija, numbook, numverse, icheck1, icheck2: Integer;
    bsuccessmemi : Boolean;

begin
  if Key = 13 then begin
       s:= Edit1.Text;
       s:= trim(s);
       // check if input is correct
       getabbrev:= copy(s, 1, 3);
       s:=copy(s,4, length(s));
       s:=trim(s);
       twodotspos:= pos(':', s);
       nbook:= copy(s, 1, twodotspos -1);
       nverse:= copy(s, twodotspos + 1, length(s));
       //  arPozicija : array[1..66, 1..150, 1..176] of Integer;
       bsuccessmemi:= False;
       for i:= 1 to 66 do
         if ab[i] = getabbrev then begin
                                     memi:= i;
                                     bsuccessmemi:= True;
                                   end;
       if bsuccessmemi then begin
           val(nbook, numbook, icheck1);
           val(nverse, numverse, icheck2);
           if (icheck1 = 0) and (icheck2 = 0) then
               if (numbook <= 150) and (numbook > 0) and (numverse > 0) and (numverse < 177) then begin
                  trypozicija:= arPozicija[memi, numbook, numverse];
                  if (trypozicija >= 1) and (trypozicija <=31102) then pozicija:=trypozicija;
           end;
       end;

     sekundi:= 1;
     Edit1.Text:='';
     Form17.Hide;
     Form1.Timer1.Enabled:=true;
     Form1.Label1.Visible:=false;
     pauza:=false;
     Form1.SetFocus;
     end;
end;

procedure TForm17.FormCreate(Sender: TObject);
begin
    ab[1]:='gen'; //'Genesis'
    ab[2]:='exo'; //'Exodus'
    ab[3]:='lev'; //'Leviticus'
    ab[4]:='num'; //'Numbers'
    ab[5]:='deu'; //'Deuteronomy'
    ab[6]:='jos'; //'Joshua'
    ab[7]:='jud'; //'Judges'
    ab[8]:='rut'; //'Ruth'
    ab[9]:='1sa'; //'1Samuel'
    ab[10]:='2sa'; //'2Samuel'
    ab[11]:='1ki'; //'1Kings'
    ab[12]:='2ki'; //'2Kings'
    ab[13]:='1ch'; //'1Chronicles'
    ab[14]:='2ch'; //'2Chronicles'
    ab[15]:='ezr'; //'Ezra'
    ab[16]:='neh'; //'Nehemiah'
    ab[17]:='est'; //'Esther'
    ab[18]:='job'; //'Job'
    ab[19]:='psa'; //'Psalms'
    ab[20]:='pro'; //'Proverbs'
    ab[21]:='ecc'; //'Ecclesiastes''
    ab[22]:='son'; //'SongofSolomon'
    ab[23]:='isa'; //'Isaiah'
    ab[24]:='jer'; //'Jeremiah'
    ab[25]:='lam'; //'Lamentations'
    ab[26]:='eze'; //'Ezekiel'
    ab[27]:='dan'; //'Daniel'
    ab[28]:='hos'; //'Hosea'
    ab[29]:='joe'; //'Joel'
    ab[30]:='amo'; //'Amos'
    ab[31]:='oba'; //'Obadiah'
    ab[32]:='jon'; //'Jonah'
    ab[33]:='mic'; //'Micah'
    ab[34]:='nah'; //'Nahum'
    ab[35]:='hab'; //'Habakkuk'
    ab[36]:='zep'; //'Zephaniah'
    ab[37]:='hag'; //'Haggai'
    ab[38]:='zec'; //'Zechariah'
    ab[39]:='mal'; //'Malachi'
    ab[40]:='mat'; //'Matthew'
    ab[41]:='mar'; //'Mark'
    ab[42]:='luk'; //'Luke'
    ab[43]:='joh'; //'John'
    ab[44]:='act'; //'Acts'
    ab[45]:='rom'; //'Romans'
    ab[46]:='1co'; //'1Corinthians'
    ab[47]:='2co'; //'2Corinthians'
    ab[48]:='gal'; //'Galatians'
    ab[49]:='eph'; //'Ephesians'
    ab[50]:='phi'; //'Philippians'
    ab[51]:='col'; //'Colossians'
    ab[52]:='1th'; //'1Thessalonians'
    ab[53]:='2th'; //'2Thessalonians'
    ab[54]:='1ti'; //'1Timothy'
    ab[55]:='2ti'; //'2Timothy'
    ab[56]:='tit'; //'Titus'
    ab[57]:='phi'; //'Philemon'
    ab[58]:='heb'; //'Hebrews'
    ab[59]:='jam'; //'James'
    ab[60]:='1pe'; //'1Peter'
    ab[61]:='2pe'; //'2Peter'
    ab[62]:='1jo'; //'1John'
    ab[63]:='2jo'; //'2John'
    ab[64]:='3jo'; //'3John'
    ab[65]:='jue'; //'Jude'
    ab[66]:='rev'; //'Revelation'

end;

end.

