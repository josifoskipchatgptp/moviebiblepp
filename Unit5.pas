unit Unit5; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,  dos;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form5: TForm5;
  mp : text;

implementation
uses Unit1, Unit2;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
var ye, mo, da , wda: word;
    sye, smo, sda, swda : String;
    ho, mi, se, ms : word;
    sho, smi : String;
begin
  AssignFile(mp, 'mb_notes.txt');
  if FileExists('mb_notes.txt')    then   Append(mp)
                                   else Rewrite(mp);
  GetDate(ye,mo,da, wda);
  str(ye, sye);  str(mo, smo); str(da, sda);
  GetTime(ho, mi, se, ms);
  str(ho, sho); str(mi, smi);
  if Memo1.text <> '' then writeln(mp, sye,'-',smo,'-',sda,' /',sho,':',smi,'  ',Memo1.text);
  CloseFile(mp);
  Memo1.text:='';
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  ShowMessage('in future most probably in His Kingdom');
end;

procedure TForm5.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then Memo1.Font.Color:=Form1Color
                       else Memo1.Font.Color:=Font1Color;
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    Memo1.text:='';
end;

procedure TForm5.FormCreate(Sender: TObject);
begin

end;

procedure TForm5.FormResize(Sender: TObject);
begin
   Memo1.Width:=Form5.Width-54;
   Memo1.Height:=Form5.Height-96;
   Button1.Left:=Form5.Width-122;
   Button1.Top:=Form5.Height-40;
   Button2.Left:=Form5.Width-231;
   CheckBox1.Top:=Form5.Height-32;
   Label1.Top:=Form5.Height-48;
end;

end.
