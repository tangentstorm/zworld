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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
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
    x, y, w, h : integer;
    fg, bg : TBGRAPixel;
    sprite : TBGRABitmap;
    constructor Create;
    destructor Destroy; override;
  end;
  TDeck = array of TCard;
var
  deck : TDeck;
  i : integer;

constructor TCard. Create;
begin
  x := random( 800 );
  y := random( 600 );
  w := 45;
  h := 25;
  bounds.Left := 0;
  bounds.Top := 0;
  bounds.Right := w;
  bounds.Bottom := h;
  fg := rgb(clBlack);
  bg := rgb(clWhite);
  text := IntToHex(i, 4);
  sprite := TBGRABitmap.Create(w,h);
  sprite.FontHeight := 15;
  sprite.FontAntialias := true;
  sprite.FontStyle := [fsBold];
  { the -1 here gives it a slight drop shadow effect }
  sprite.FillRect(0, 0, w-1, h-1, bg, dmSet);
  sprite.TextRect( bounds, text, taCenter, tlCenter, fg );
  bounds.Left := x;
  bounds.Top  := y;
  bounds.Right := bounds.left + w;
  bounds.Bottom := bounds.top + h;
end;

destructor TCard.Destroy;
begin
  sprite.Free;
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

var
  img : TBGRABitmap;

procedure TMainForm.FormPaint( Sender : TObject );
begin
  img.FillRect(0, 0, ClientWidth, 25, $000000 );
  img.FillRect(0, 25, ClientWidth, ClientHeight, Self.Color );

  img.FontHeight := 15;
  img.FontAntialias := true;
  img.FontStyle := [fsBold];
  img.TextOut( 5, 5, 'ZoomWorld', rgb( $ff9933 ));


  for i := low(deck) to high(deck) do
    with deck[i] do
    begin
      img.PutImage( bounds.left, bounds.top, sprite, dmSet );
    end;

  img.Draw( self.canvas, 0, 0, True );
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  img := TBGRABitmap.Create( ClientWidth, ClientHeight, Self.Color );
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  img.Free;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key = #27 then begin
    HeartBeat.Enabled := false;
    Close
  end
end;

begin
  SetLength( deck, 256 );
  for i := low(deck) to high(deck) do
     deck[i] := TCard.create;
end.
