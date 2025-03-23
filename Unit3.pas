unit Unit3; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Unit4, Unit1;

type

  { TForm3 }

  TForm3 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form3: TForm3;
  U3Sekundi: integer;
  sU3Sekundi : String;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
  U3Sekundi:=3;
  Label2.Caption:='';
  Form3.Timer1.Enabled:=False;
  //centriraj label1
  label1.left:=round(Form3.width/2)-round(Label1.width/2);
end;

procedure TForm3.Timer1Timer(Sender: TObject);
begin
  if U3Sekundi <= 1 then begin
    Timer1.Enabled:=false;
    Form3.Hide;

  end else begin
  //  Image1.Refresh;
  //  Image2.Refresh;
  //  Image3.Refresh;
    U3Sekundi:=U3Sekundi-1;
    str(U3Sekundi, sU3Sekundi);
    Label2.Caption:=sU3Sekundi;
    Form3.Refresh;
  end;
end;

end.
