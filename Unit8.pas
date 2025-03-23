unit Unit8; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit1;

type

  { TForm8 }

  TForm8 = class(TForm)
    Button2: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure ListBox2SelectionChange(Sender: TObject; User: boolean);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form8: TForm8;
  fb1, fb2, u8bt : text;
  u8kniga, u8glava, u8stih : integer;

implementation
 uses unit2;
{$R *.lfm}

{ TForm8 }

procedure TForm8.FormCreate(Sender: TObject);

Const FileFound = 0;
      CharCR = Chr(13);
      CharLF = Chr(10); //Windows ?30?
      StringCRLF = CharCR + CharLF;
      WildcardSearch = '\*';


Var
   SearchResult : TSearchRec;
   MoreFiles : Integer;
   NajdenaDatoteka : String;
   i , tojeindeksot: integer;
   ss : String;

Begin
If FindFirst ('Bibles'+OS+'*.txt', (faAnyFile And Not faDirectory) , SearchResult) = FileFound Then
   Begin
   NajdenaDatoteka := SearchResult.Name;
   ListBox1.Items.Add(NajdenaDatoteka);
   ListBox2.Items.Add(NajdenaDatoteka);
   While FindNext (SearchResult) = FileFound Do
         Begin
             NajdenaDatoteka := SearchResult.Name;
             ListBox1.Items.Add(NajdenaDatoteka);
             ListBox2.Items.Add(NajdenaDatoteka);
         End;
   End;
FindClose (SearchResult);
if FindFirst ('BooksTitles'+OS+'*.txt', (faAnyFile And Not faDirectory) , SearchResult) = FileFound Then
   Begin
   NajdenaDatoteka := SearchResult.Name;
   ComboBox1.Items.Add(NajdenaDatoteka);
   While FindNext (SearchResult) = FileFound Do
         Begin
             NajdenaDatoteka := SearchResult.Name;
             ComboBox1.Items.Add(NajdenaDatoteka);
         End;
   End;
FindClose (SearchResult);

ListBox1.Sorted:=True;
ListBox2.Sorted:=True;

if ParalelMode then RadioButton2.Checked:=true;

for i:=0 to ListBox1.Items.count-1 do begin
 if ListBox1.Items.ValueFromIndex[i]=KojaBiblija1 then ListBox1.Selected[i]:=true;
end;

if paralelmode then for i:=0 to ListBox2.Items.count-1 do begin
  if ListBox2.Items.ValueFromIndex[i]=KojaBiblija2 then ListBox2.Selected[i]:=true;
end;

for i:=0 to ComboBox1.Items.count-1 do begin
  if ComboBox1.Items.ValueFromIndex[i]=boti then ComboBox1.ItemIndex:=i;
end;
End;

procedure TForm8.ListBox1SelectionChange(Sender: TObject; User: boolean);
begin
  KojaBiblija1:=ListBox1.Items.ValueFromIndex[ListBox1.ItemIndex];
end;

procedure TForm8.ListBox2SelectionChange(Sender: TObject; User: boolean);
begin
  KojaBiblija2:=ListBox2.Items.ValueFromIndex[ListBox2.ItemIndex];
end;

procedure TForm8.RadioButton1Change(Sender: TObject);
begin
  if RadioButton1.checked=true then begin
                                         ParalelMode:=false;
                                         // ListBox2.Enabled:=false;
                                         // KojaBiblija2:='/';
                                         CheckBox1.Enabled:=False;
                                     end
                               else begin
                                         ParalelMode:=true;
                                         ListBox2.Enabled:=true;
                                    end;
end;

procedure TForm8.RadioButton2Change(Sender: TObject);
var mozeli : boolean;

begin
   if RadioButton2.checked=true then begin
                                          ParalelMode:=True;
                                          ListBox2.Enabled:=True;
                                          CheckBox1.Enabled:=True;
                                     end
                               else begin
                                 ParalelMode:=false;
                                 // ListBox2.Enabled:=false;
                               end;
end;

procedure TForm8.Button2Click(Sender: TObject);
var ibib : integer;
    linija, linija2 : String;


begin

  // vcituvanje na biblijata/bibliite
  if RadioButton2.Checked then paralelmode:=true;
  if ListBox1.ItemIndex = ListBox2.ItemIndex then paralelmode:=false;
  assignfile(fb1, 'Bibles'+OS+ListBox1.Items.ValueFromIndex[ListBox1.ItemIndex]);
  reset(fb1);
  if paralelmode then assignfile(fb2, 'Bibles'+OS+ListBox2.Items.ValueFromIndex[ListBox2.ItemIndex]);
  if paralelmode then reset(fb2);
  for ibib:=1 to 62204 do begin
    readln(fb1, linija);
    if paralelmode then readln(fb2, linija2);
    if (ibib mod 2) = 0 then begin
                                arTekst[ibib div 2]:=linija;
                                if paralelmode then arTekst2[ibib div 2]:=linija2;
                           end;
  end;
  closefile(fb1);
  if paralelmode then closefile(fb2);
  // BooksTitles
  assignfile(u8bt, 'BooksTitles'+OS+ComboBox1.Items.ValueFromIndex[ComboBox1.ItemIndex]);
  reset(u8bt);
  for ibib:=1 to 66 do begin
              readln(u8bt, arKnigaNaslov[ibib]);
  end;
  u8kniga:=Form2.ComboBox1.ItemIndex;
  u8glava:=Form2.ComboBox2.ItemIndex;
  u8stih:=Form2.ComboBox3.ItemIndex;
  closefile(u8bt);
  Form2.ComboBox1.Clear;
  for ibib:=1 to 66 do Form2.ComboBox1.AddItem(arKnigaNaslov[ibib], nil);
  Form2.ComboBox1.ItemIndex:=u8kniga;
  Form2.ComboBox2.ItemIndex:=u8glava;
  Form2.ComboBox3.ItemIndex:=u8stih;
  Form8.Hide;
end;

procedure TForm8.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then OneByOne:=True
                       else OneByOne:=False;
end;



procedure TForm8.ComboBox1Change(Sender: TObject);
begin
  boti:=ComboBox1.Items.ValueFromIndex[ComboBox1.ItemIndex];
end;


end.
