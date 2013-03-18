unit zwmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  BGRABitmapTypes, BGRABitmap, BGRACanvas, gfx;

type

  { TMainForm }

  TMainForm = class( TForm )
    HeartBeat : TTimer;
    procedure FormPaint( Sender : TObject );
    procedure HeartBeatTimer( Sender : TObject );
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm : TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.HeartBeatTimer( Sender : TObject );
begin
  Repaint
end;

procedure TMainForm.FormPaint( Sender : TObject );
var
  img : TBGRABitmap;
begin
  img := TBGRABitmap.Create( ClientWidth, ClientHeight, Self.Color );

  img.FillRect(0, 0, ClientWidth, 25, $000000 );

  img.FontHeight := 15;
  img.FontAntialias := true;
  img.FontStyle := [fsBold];
  img.TextOut( 5, 5, 'ZoomWorld', rgb( $ff9933 ));

  img.Draw( self.canvas, 0, 0, True );
  img.Free;
end;

end.
