unit ScpGraph;

interface
uses Graph;

function InitScpGraph(Xres, Yres, Colors : Integer;
                      ForceNonSVGA : Boolean; Path : String) : Integer;

{svgautil.inc}

const
  XNOR_PUT        = 5;
  NOR_PUT         = 6;
  NAND_PUT        = 7;
  TRANS_COPY_PUT  = 8;  (* Doesn't work on 16-color systems *)

type DacPalette16  = array[0..15] of array[0..2] of Byte;
type DacPalette256 = array[0..255] of array[0..2] of Byte;

type TColor = LongInt; { IRGB, I = Index }

(* Setvgapalette sets the entire 16 color palette *)
(* PalBuf contains RGB values for all 16 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette16(PalBuf : DacPalette16);

(* Setvgapalette sets the entire 256 color palette *)
(* PalBuf contains RGB values for all 256 colors   *)
(* R,G,B values range from 0 to 63	           *)
procedure SetVGAPalette256(PalBuf : DacPalette256);

function RGB(R, G, B : Integer) : TColor;

function IRGB(I, R, G, B : Integer) : TColor;

function RealDrawColor(Color : TColor) : Integer;

function RealFillColor(Color : TColor) : Integer;

function RealColor(Color : TColor) : Integer;

function RealPixelColor(PixColor : Integer) : TColor;

function GetStdColor(C : Integer) : TColor;

implementation

uses DOS;

function ScpTrim(S : String) : String;
var
  Left, Right : Integer;
begin
  if S = '' then ScpTrim := '' else
  begin
    Left := 1;
    while (S[Left] <= #32) and (Left <= Length(S)) do Inc(Left);
    if Left > Length(S) then ScpTrim := '' else
    begin
      Right := Length(S);
      while (S[Right] <= #32) do Dec(Right);
      ScpTrim := Copy(S, Left, Right - Left + 1);
    end;
  end;
end;

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

function RGB(R, G, B : Integer) : TColor;
begin
  RGB := ((LongInt(R) AND $FF) SHL 16) OR
   ((LongInt(G) AND $FF) SHL 8) OR
   (LongInt(B) AND $FF);
end;

function IRGB(I, R, G, B : Integer) : TColor;
begin
  IRGB := ((LongInt(I) AND $FF) SHL 24) OR
   ((LongInt(R) AND $FF) SHL 16) OR
   ((LongInt(G) AND $FF) SHL 8) OR
   (LongInt(B) AND $FF);
end;

function I(Color : TColor) : Integer;
begin
  I := (Color shr 24) and $ff;
end;

function R(Color : TColor) : Integer;
begin
  R := (Color shr 16) and $ff;
end;

function G(Color : TColor) : Integer;
begin
  G := (Color shr 8) and $ff;
end;

function B(Color : TColor) : Integer;
begin
  B := Color and $ff;
end;

procedure SetRgbSlot(Slot : Integer; Color : TColor);
var
  MaxC : LongInt;
begin
  MaxC := GetMaxColor;

  if (MaxC = 65535) then
    SetRgbPalette(Slot, (Color SHR 19) AND $1F,
                        (Color SHR 10) AND $3F,
                        (Color SHR 3) AND $1F)
  else if (MaxC = 32767) then
    SetRgbPalette(Slot, (Color SHR 19) AND $1F,
                        (Color SHR 11) AND $1F,
                        (Color SHR 3) AND $1F)
  else if (MaxC = 16777) then
    SetRgbPalette(Slot, (Color SHR 16) AND 255,
                        (Color SHR 8) AND 255,
                        Color AND 255);
end;

function RealDrawColor(Color : TColor) : Integer;
var
  MaxC : LongInt;
begin
  MaxC := GetMaxColor;

  if (MaxC <= 256) then
    RealDrawColor := I(Color) else
  begin
    SetRgbSlot(1024, Color);
    RealDrawColor := 1024;
  end;
end;

function RealFillColor(Color : LongInt) : Integer;
var
  MaxC : LongInt;
begin
  MaxC := GetMaxColor;

  if (MaxC <= 256) then
    RealFillColor := I(Color) else
  begin
    SetRgbSlot(1025, Color);
    RealFillColor := 1025;
  end;
end;

function RealColor(Color : LongInt) : Integer;
var
  MaxC : LongInt;
begin
  MaxC := GetMaxColor;

  if (MaxC <= 256) then
    RealColor := I(Color) else
  begin
    SetRgbSlot(1026, Color);
    RealColor := 1026;
  end;
end;

function RealPixelColor(PixColor : Integer) : TColor;
var
  Color_Int : LongInt;
  MaxC : LongInt;
  MyR, MyG, MyB : Integer;
begin
  Color_Int := PixColor;
  inline($89/$56/<Color_Int);
  MaxC := GetMaxColor;
  if MaxC <= 256 then
    RealPixelColor := IRGB(Color_Int, 0, 0, 0) else
  if MaxC = 65535 then
  begin
    MyR := (Color_Int shr 11) and $1f;
    MyG := (Color_Int shr 5) and $3f;
    MyB := Color_Int and $1f;
    RealPixelColor :=
      RGB((MyR shl 3) or (MyR shr 2),
          (MyG shl 2) or (MyG shr 4),
          (MyB shl 3) or (MyB shr 2));
  end else
  if MaxC = 32767 then
  begin
    MyR := (Color_Int shr 10) and $1f;
    MyG := (Color_Int shr 5) and $1f;
    MyB := Color_Int and $1f;
    RealPixelColor :=
      RGB((MyR shl 3) or (MyR shr 2),
          (MyG shl 3) or (MyG shr 2),
          (MyB shl 3) or (MyB shr 2));
  end else
  if MaxC = 16777 then
  begin
    MyR := (Color_Int shr 16) and $ff;
    MyG := (Color_Int shr 8) and $ff;
    MyB := Color_Int and $ff;
    RealPixelColor := RGB(MyR, MyG, MyB);
  end;
end;

type
  TStdColorPalette = array[0 .. 15] of TColor;
  PStdColorPalette = ^TStdColorPalette;

const StdColor : TStdColorPalette =
 ($00000000, $010000aa, $0200aa00, $0300aaaa,
  $04aa0000, $05aa00aa, $06aa5500, $07aaaaaa,
  $08555555, $095555ff, $0a55ff55, $0b55ffff,
  $0cff5555, $0dff55ff, $0effff55, $0fffffff);

function GetStdColor(C : Integer) : TColor;
begin
  GetStdColor := StdColor[C];
end;

{$I-}

function InitScpGraph(Xres, Yres, Colors : Integer;
                      ForceNonSVGA : Boolean; Path : String) : Integer;
var
  Detect386, DetectSVGA : Boolean;
  DetectedDriver, SuggestedMode : Integer;
  F : Text;
  TPath : String;
  C : Char;
  I : Integer;
  FileXres, FileYres, FileColors, FileSVGA, FileGrMode, FileGrDriver : Integer;
  FileGrDriverName : String;
  ErrorCode : Integer;
begin
  Detect386 := Test8086 >= 2;
  if ForceNonSVGA then
    DetectSVGA := False
  else
  begin
    DetectGraph(DetectedDriver, SuggestedMode);
    DetectSVGA := (DetectedDriver = VGA) or (DetectedDriver = MCGA);
  end;

  if Path = '' then
    TPath := 'TABLE.BGT'
  else if (Path[Length(Path)] = '\') or (Path[Length(Path)] = ':') then
    TPath := Path + 'TABLE.BGT'
  else
    TPath := Path + '\TABLE.BGT';
  Assign(F, TPath);
  ReSet(F);
  InitScpGraph := grNotDetected;
  if IOResult = 0 then
  begin
    while not Eof(F) do
    begin
      if Eoln(F) then ReadLn(F) else
      begin
        Read(F, C);
        if C = ';' then ReadLn(F) else { комментарий }
        if C = '!' then                { стандартный режим }
        begin
          ReadLn(F, FileXres, FileYres, FileColors, FileSVGA, FileGrMode, FileGrDriver);
          if (FileXres = Xres) and (FileYres = Yres) and
             (FileColors = Colors) and (DetectSVGA or (FileSVGA = 0)) then
          begin
            InitGraph(FileGrDriver, FileGrMode, Path);
            ErrorCode := GraphResult;
            InitScpGraph := ErrorCode;
            if ErrorCode = grOk then Break;
          end;
        end else
        if C = '+' then
        begin
          ReadLn(F, FileXres, FileYres, FileColors, FileSVGA, FileGrMode, FileGrDriverName);
          if (FileXres = Xres) and (FileYres = Yres) and
             (FileColors = Colors) and (DetectSVGA or (FileSVGA = 0)) then
          begin
            FileGrDriver := InstallUserDriver(ScpTrim(FileGrDriverName), nil);
            InitGraph(FileGrDriver, FileGrMode, Path);
            ErrorCode := GraphResult;
            InitScpGraph := ErrorCode;
            if ErrorCode = grOk then Break;
          end;
        end else
        if C = '-' then
        begin
          ReadLn(F, FileXres, FileYres, FileColors, FileSVGA, FileGrMode, FileGrDriverName);
          if (FileXres = Xres) and (FileYres = Yres) and
             (FileColors = Colors) and (DetectSVGA or (FileSVGA = 0))
             and Detect386 then
          begin
            FileGrDriver := InstallUserDriver(ScpTrim(FileGrDriverName), nil);
            InitGraph(FileGrDriver, FileGrMode, Path);
            ErrorCode := GraphResult;
            InitScpGraph := ErrorCode;
            if ErrorCode = grOk then Break;
          end;
        end;
      end;
    end;
    Close(F)
  end
  else
    InitScpGraph := grFileNotFound;
end;


end.
