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

type
  TCard = class
    bounds : TRect;
    text   : String;
    fg, bg : TBGRAPixel;
    constructor create;
  end;
  TDeck = array of TCard;
var
  deck : TDeck;
  i : integer;

constructor TCard.Create;
begin
  bounds.Left := random( 800 );
  bounds.Top  := random( 600 );
  bounds.Right := bounds.left + 45;
  bounds.Bottom := bounds.top + 25;
  fg := rgb(clBlack);
  bg := rgb(clWhite);
  text := IntToHex(i, 4);
end;


{$R *.lfm}

{ TMainForm }

procedure TMainForm.HeartBeatTimer( Sender : TObject );
 var j : integer;
begin
  for i := low(deck) to high(deck) do
    with deck[i].bounds do begin
      j := random(3) - 1;
      left += j; right += j;
      j := random(3) - 1;
      top += j; bottom += j;
    end;
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


  for i := low(deck) to high(deck) do
    with deck[i] do
    begin
      img.FillRect(bounds, bg, dmSet);
      img.TextRect(bounds, text, taCenter, tlCenter, fg )
    end;

  img.Draw( self.canvas, 0, 0, True );
  img.Free;
end;

begin
  SetLength( deck, 100 );
  for i := low(deck) to high(deck) do
     deck[i] := TCard.create;
end.
