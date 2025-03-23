unit Unit12; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm12 }

  TForm12 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form12: TForm12; 

implementation
Uses Unit1, Unit11;

{$R *.lfm}

{ TForm12 }

procedure TForm12.Button1Click(Sender: TObject);
var i : integer;
    k : Word;
begin
  for i:=Memo2.lines.Count downto 1 do
   if trim(Memo2.lines.Strings[i])='' then
     Memo2.lines.Delete(i);
  Memo2.lines.SaveToFile('BibleList.txt');
  Form12.Hide;
  NapunetoPole := False;
  k:=77;
  Form1.Button1KeyDown(Button1, k, []);
  Form11.Hide;
end;

procedure TForm12.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then ShowBibleNames:=True
                       else ShowBibleNames:=False;
end;

end.

