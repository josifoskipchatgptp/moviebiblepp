unit Unit13; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit1;

type

  { TForm13 }

  TForm13 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form13: TForm13; 

implementation

{$R *.lfm}

{ TForm13 }

procedure TForm13.Button1Click(Sender: TObject);
var someint, some13endingpozicija : integer;
begin
   val(Edit1.Text, someint);
   if (some13pozicija + someint) > 31102 then some13endingpozicija:=31102
    else if (some13pozicija + someint) < 1 then some13endingpozicija:=1
     else some13endingpozicija:=some13pozicija+someint;
  val(arKniga[some13endingpozicija], Knigabe);
  val(arGlava[some13endingpozicija], Glavabe);
  Label5.Visible:=True;
  Form13.Label5.Caption:=arKnigaNaslov[Knigabe]+' '+arGlava[some13endingpozicija]+','+arStih[some13endingpozicija];
end;

end.

