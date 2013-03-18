{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }
{$mode objfpc}
unit gfx;

interface

uses
  SysUtils, BGRABitmapTypes, LazarusPackageIntf;

function rgb( hex : cardinal ) : TBGRAPixel;

implementation

function rgb( hex : cardinal ) : TBGRAPixel;
begin
  // bizzarely, BGRA takes parameters in r,g,b,a order
  result := BGRA(( $FF0000 and hex ) shr 16,
                 ( $00FF00 and hex ) shr  8,
                 ( $0000FF and hex ),
                  $ff );
end;


procedure Register;
begin
end;

initialization
  RegisterPackage( 'gfx', @Register );
end.
