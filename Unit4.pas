unit Unit4; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit5, Unit6;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4: TForm4;
  mozze:boolean;
  U6 : text;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.RadioButton1Click(Sender: TObject);
begin
  if not(mozze) then begin
    RadioButton2.Checked:=true;
    Button1.SetFocus;
  end;
end;

procedure TForm4.RadioButton2Change(Sender: TObject);
begin
  if RadioButton2.Checked then mozze:=false;
end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   Halt;

end;

procedure TForm4.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var s1:string;
begin
    if Key=89 then begin
      mozze:=true;
      RadioButton1.Checked:=true;
    end;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if mozze then begin
    form5.Show;
    form4.Hide;
  end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
   mozze:=false;
end;

end.

