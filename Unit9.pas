unit Unit9; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType;

type

  { TForm9 }

  TForm9 = class(TForm)
    CheckBox1: TCheckBox;
    Memo1: TMemo;
    procedure CheckBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form9: TForm9;
  EmptyRows: boolean;

implementation
Uses Unit1, Unit2;

{$R *.lfm}

{ TForm9 }

procedure TForm9.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm9.CheckBox1Change(Sender: TObject);
var incounter : Integer;
begin
  EmptyRows:=not(EmptyRows);
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
  Form9.Caption:=arKnigaNaslov[Knigabe] + ' ' + arGlava[pozicija] + ' (' + IntToStr(incounter) + ')';
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  EmptyRows:= False;
end;

procedure TForm9.FormResize(Sender: TObject);
begin
  Memo1.Width := Form9.Width-20;
  Memo1.Height := Form9.Height-30;
  CheckBox1.Left :=10;
  CheckBox1.Top := Form9.Height - 20;
end;

procedure TForm9.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
var k : Word;
begin
  val(arKniga[pozicija], Knigabe);
  val(arGlava[pozicija], Glavabe);
  if Key=VK_RIGHT then begin

      pozicija:= arPozicija[KnigaBe, GlavaBe + 1, 1];
      k := 67;
      Form1.Button1KeyDown(Form1.Button1, k, []);
  end;
  if Key=VK_LEFT then begin
      pozicija:= arPozicija[KnigaBe, GlavaBe - 1, 1];
      k := 67;
      Form1.Button1KeyDown(Form1.Button1, k, []);
  end;
  Key:=0;
end;

end.

