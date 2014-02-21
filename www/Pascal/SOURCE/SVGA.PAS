unit SVGA;
interface

(************************************************)
(* 						*)
(*	  SuperVGA 16 BGI driver defines	*)
(*		Copyright (c) 1991		*)
(*	    Jordan Hargraphix Software		*)
(*						*)
(************************************************)

(* These are the currently supported modes *)
const
  SVGA320x200x16	= 0;	(* 320x200x16 Standard EGA/VGA *)
  SVGA640x200x16	= 1;	(* 640x200x16 Standard EGA/VGA *)
  SVGA640x350x16	= 2;	(* 640x350x16 Standard EGA/VGA *)
  SVGA640x480x16	= 3;	(* 640x480x16 Standard VGA *)
  SVGA800x600x16	= 4;	(* 800x600x16 SuperVGA/VESA *)
  SVGA1024x768x16	= 5;	(* 1024x768x16 SuperVGA/VESA *)
  SVGA1280x1024x16	= 6;	(* 1280x1024x16 SuperVGA/VESA *)

{

(************************************************)
(* 						*)
(*	 SuperVGA 256 BGI driver defines	*)
(*		Copyright (c) 1991		*)
(*	    Jordan Hargraphix Software		*)
(*						*)
(************************************************)

(* These are the currently supported modes *)
const
  SVGA320x200x256	= 0;	(* 320x200x256 Standard VGA *)
  SVGA640x400x256	= 1;	(* 640x400x256 Svga *)
  SVGA640x480x256	= 2;	(* 640x480x256 Svga *)
  SVGA800x600x256	= 3;	(* 800x600x256 Svga *)
  SVGA1024x768x256	= 4;	(* 1024x768x256 Svga *)
  SVGA640x350x256	= 5;	(* 640x350x256 Svga *)
  SVGA1280x1024x256	= 6;	(* 1280x1024x256 Svga *)

 Jordan Hargraphix SVGA256.BGI doesn't work in 800x600 :(
 Replaced by SVGA.BGI by Ullrich von Bassewitz
 This is just for 256color modes!
}

const
  SVGA320x200x256       = 0;    (* 320*200. Dieser Modus wird von
                                   jeder VGA-Karte beherrscht, also
                                   nicht nur von den vom Treiber
                                   unterstÁtzten Karten.             *)
  SVGA_Autodetectx256   = 1;    (* Autodetect. Verwendet die hÔchste
                                   AuflÔsung der Karte. Siehe den
                                   entsprechenden Abschnitt.         *)
  SVGA640x400x256       = 2;    (* 640*400, Autodetect, siehe
                                   Abschnitt "Autodetect".           *)
  SVGA640x480x256       = 3;    (* 640*480, Autodetect, siehe
                                   Abschnitt "Autodetect".           *)
  SVGA800x600x256       = 4;    (* 800*600, Autodetect, siehe
                                   Abschnitt "Autodetect".           *)
  SVGA1024x768x256      = 5;    (* 1024*768, Autodetect, siehe
                                   Abschnitt "Autodetect".           *)
  SVGA1280x1024x256     = 6;    (* 1280*1024, Autodetect, siehe
                                   Abschnitt "Autodetect".           *)

(************************************************)
(* 						*)
(*	 SuperVGA 32768 BGI driver defines	*)
(*		Copyright (c) 1991		*)
(*	    Jordan Hargraphix Software		*)
(*						*)
(************************************************)

(* These are the currently supported modes *)
const
  SVGA320x200x32768	= 0;	(* 320x200x32768 HiColor VGA *)
  SVGA640x350x32768	= 1;	(* 640x350x32768 HiColor VGA *)
  SVGA640x400x32768	= 2;	(* 640x400x32768 HiColor VGA *)
  SVGA640x480x32768	= 3;	(* 640x480x32768 HiColor VGA *)
  SVGA800x600x32768	= 4;	(* 800x600x32768 HiColor VGA *)
  SVGA1024x768x32768	= 5;	(* 1024x768x32768 HiColor VGA *)
  SVGA1280x1024x32768	= 6;	(* 1280x1024x32768 HiColor VGA *)

(************************************************)
(* 						*)
(*	 SuperVGA 65536 BGI driver defines	*)
(*		Copyright (c) 1993		*)
(*	    Jordan Hargraphix Software		*)
(*						*)
(************************************************)

(* These are the currently supported modes *)
const
  SVGA320x200x65536	= 0;	(* 320x200x65536 HiColor VGA *)
  SVGA640x350x65536	= 1;	(* 640x350x65536 HiColor VGA *)
  SVGA640x400x65536	= 2;	(* 640x400x65536 HiColor VGA *)
  SVGA640x480x65536	= 3;	(* 640x480x65536 HiColor VGA *)
  SVGA800x600x65536	= 4;	(* 800x600x65536 HiColor VGA *)
  SVGA1024x768x65536	= 5;	(* 1024x768x65536 HiColor VGA *)
  SVGA1280x1024x65536	= 6;	(* 1280x1024x65536 HiColor VGA *)

{svgautil.inc}

const
  XNOR_PUT		= 5;
  NOR_PUT		= 6;
  NAND_PUT		= 7;
  TRANS_COPY_PUT	= 8;	(* Doesn't work on 16-color systems *)

type DacPalette16  = array[0..15] of array[0..2] of Byte;
type DacPalette256 = array[0..255] of array[0..2] of Byte;

(* Setvgapalette sets the entire 16 color palette *)
(* PalBuf contains RGB values for all 16 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette16(PalBuf : DacPalette16);

(* Setvgapalette sets the entire 256 color palette *)
(* PalBuf contains RGB values for all 256 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette256(PalBuf : DacPalette256);

function RGB(R,G,B : LongInt) : LongInt;

function RealDrawColor(Color : LongInt) : LongInt;

function RealFillColor(Color : LongInt) : LongInt;

function RealColor(Color : LongInt) : LongInt;

function RealPixelColor(PixColor : LongInt) : LongInt;

var
  SVGA16, SVGA256, SVGA32k, SVGA64k : Integer;

function GetStdColor(C : Integer) : LongInt;

implementation
uses Graph, DOS;

(* Setvgapalette sets the entire 16 color palette *)
(* PalBuf contains RGB values for all 16 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette16(PalBuf : DacPalette16);
var
  Reg : Registers;

begin
  reg.ax := $1012;
  reg.bx := 0;
  reg.cx := 16;
  reg.es := Seg(PalBuf);
  reg.dx := Ofs(PalBuf);
  intr($10,reg);
end;

(* Setvgapalette sets the entire 256 color palette *)
(* PalBuf contains RGB values for all 256 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette256(PalBuf : DacPalette256);
var
  Reg : Registers;

begin
  reg.ax := $1012;
  reg.bx := 0;
  reg.cx := 256;
  reg.es := Seg(PalBuf);
  reg.dx := Ofs(PalBuf);
  intr($10,reg);
end;

function RGB(R,G,B : LongInt) : LongInt;
var
  MaxC : Longint;
begin
  MaxC := GetMaxColor;

  if (MaxC = 65535) then
    RGB := (((R SHR 3) AND $1F) SHL 11) OR (((G SHR 2) AND $3F) SHL 5) OR
	    ((B SHR 3) AND $1F)
  else if (MaxC = 32767) then
    RGB := (((R SHR 3) AND $1F) SHL 10) OR (((G SHR 3) AND $1F) SHL 5) OR 
	    ((B SHR 3) and $1F)
  else if (MaxC = 16777) then
    RGB := ((R AND $FF) SHL 16) OR ((G AND $FF) SHL 8) OR (B AND $FF);
end;

function RealDrawColor(Color : LongInt) : LongInt;
var
  MaxC : Longint;
begin
  MaxC := GetMaxColor;

  if (MaxC = 65535) then
    SetRgbPalette(1024,(Color SHR 11) AND $1F,(Color SHR 5)AND $3F,Color AND $1F)
  else if (MaxC = 32767) then
    SetRgbPalette(1024,(Color SHR 10) AND $1F,(Color SHR 5)AND $1F,Color AND $1F)
  else if (MaxC = 16777) then
    SetRgbPalette(1024,(Color SHR 16) AND 255,(Color SHR 8)AND 255,Color AND 255);
  RealDrawColor := 1024;
end;

function RealFillColor(Color : LongInt) : LongInt;
var
  MaxC : Longint;
begin
  MaxC := GetMaxColor;

  if (MaxC = 65535) then
    SetRgbPalette(1025,(Color SHR 11) AND $1F,(Color SHR 5)AND $3F,Color AND $1F)
  else if (MaxC = 32767) then
    SetRgbPalette(1025,(Color SHR 10) AND $1F,(Color SHR 5)AND $1F,Color AND $1F)
  else if (MaxC = 16777) then
    SetRgbPalette(1025,(Color SHR 16) AND 255,(Color SHR 8)AND 255,Color AND 255);
  RealFillColor := 1025;
end;

function RealColor(Color : LongInt) : LongInt;
var
  MaxC : Longint;
begin
  MaxC := GetMaxColor;

  if (MaxC = 65535) then
    SetRgbPalette(1026,(Color SHR 11) AND $1F,(Color SHR 5)AND $3F,Color AND $1F)
  else if (MaxC = 32767) then
    SetRgbPalette(1026,(Color SHR 10) AND $1F,(Color SHR 5)AND $1F,Color AND $1F)
  else if (MaxC = 16777) then
    SetRgbPalette(1026,(Color SHR 16) AND 255,(Color SHR 8)AND 255,Color AND 255);
  RealColor := 1026;
end;

function RealPixelColor(PixColor : LongInt) : LongInt;
var
  CurC : Integer;
begin
  RealPixelColor := PixColor;
end;

{$F+}
function DetectVGA16 : integer;
{ Detects VGA or MCGA video cards }
var
  DetectedDriver : integer;
  SuggestedMode  : integer;
begin
  DetectGraph(DetectedDriver, SuggestedMode);
  if (DetectedDriver = EGA) or (DetectedDriver = VGA) then
    DetectVGA16 := SVGA800x600x16
  else
    DetectVGA16 := grError; { Couldn't detect hardware }
end; { DetectVGA16 }
{$F-}

{$F+}
function DetectVGA256 : integer;
{ Detects VGA or MCGA video cards }
var
  DetectedDriver : integer;
  SuggestedMode  : integer;
begin
  DetectGraph(DetectedDriver, SuggestedMode);
  if (DetectedDriver = VGA) or (DetectedDriver = MCGA) then
    DetectVGA256 := SVGA800x600x256
  else
    DetectVGA256 := grError; { Couldn't detect hardware }
end; { DetectVGA256 }
{$F-}

{$F+}
function DetectVGA32k : integer;
{ Detects VGA or MCGA video cards }
var
  DetectedDriver : integer;
  SuggestedMode  : integer;
begin
  DetectGraph(DetectedDriver, SuggestedMode);
  if (DetectedDriver = VGA) or (DetectedDriver = MCGA) then
    DetectVGA32k := SVGA800x600x32768
  else
    DetectVGA32k := grError; { Couldn't detect hardware }
end; { DetectVGA32k }
{$F-}

{$F+}
function DetectVGA64k : integer;
{ Detects VGA or MCGA video cards }
var
  DetectedDriver : integer;
  SuggestedMode  : integer;
begin
  DetectGraph(DetectedDriver, SuggestedMode);
  if (DetectedDriver = VGA) or (DetectedDriver = MCGA) then
    DetectVGA64k := SVGA800x600x65536
  else
    DetectVGA64k := grError; { Couldn't detect hardware }
end; { DetectVGA64k }
{$F-}

type
  TStdColorPalette = array[0 .. 15] of LongInt;
  PStdColorPalette = ^TStdColorPalette;

const StdColor : array[1 .. 4] of TStdColorPalette =
 ({SVGA16, SVGA256}
  (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15),

  {SVGA32k}
  ($0000, $0015, $02a0, $02b5, $5400, $5415, $5540, $56b5,
   $294a, $295f, $2bea, $2bff, $7d4a, $7d5f, $7fea, $7fff),

  {SVGA64k}
  ($0000, $0015, $0540, $0555, $a800, $a815, $aaa0, $ad55,
   $52aa, $52bf, $57ea, $57ff, $faaa, $fabf, $ffea, $ffff),
  
  {SVGATC}
  ($000000, $0000aa, $00aa00, $00aaaa, $aa0000, $aa00aa, $aa5500, $aaaaaa,
   $555555, $5555ff, $55ff55, $55ffff, $ff5555, $ff55ff, $ffff55, $ffffff));

function GetStdColor(C : Integer) : LongInt;
var
  Clr : LongInt;
begin
  Clr := GetMaxColor;

  if (Clr = 65535) then      Clr := StdColor[3, C]
  else if (Clr = 32767) then Clr := StdColor[2, C]
  else if (Clr = 16777) then Clr := StdColor[4, C]
  else Clr := 15;
  GetStdColor := Clr;
end;

begin
  { order matters -- the first get detected earlier }
  if Test8086 >= 2 then
    SVGA256 := InstallUserDriver('SVGA386', @DetectVGA256)
  else
    SVGA256 := InstallUserDriver('SVGA', @DetectVGA256);
  SVGA16  := InstallUserDriver('SVGA16',  @DetectVGA16);
  SVGA32k := InstallUserDriver('SVGA32k', @DetectVGA32k);
  SVGA64k := InstallUserDriver('SVGA64k', @DetectVGA64k);
end.
