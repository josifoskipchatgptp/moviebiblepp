unit Unit6; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Unit1;

type

  { TForm6 }

  TForm6 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form6: TForm6;
  randombroj, U6Knigabe, U6Sekundi, IzbraniSekundi, pojavuvanje : Integer;

implementation

{$R *.lfm}

{ TForm6 }

procedure TForm6.FormCreate(Sender: TObject);
begin
  Randomize;
  U6Sekundi:=2;
  IzbraniSekundi:=5;
  pojavuvanje:=0;
  randombroj:=arPozicija[40,1,1]+random(arPozicija[44,1,1]-arPozicija[40,1,1]);
  Label1.Visible:=false;
  Memo1.text:=arTekst[randombroj];
  val(arKniga[randombroj], U6Knigabe);
  Form6.Caption:=arKnigaNaslov[U6Knigabe]+' '+arGlava[randombroj]+','+arStih[randombroj];
end;



end.

