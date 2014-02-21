{ Демонстрация доополнительных графических возможностей }
{ дополнительные шрифты и дополнительные видеорежимы }

uses Crt, Graph, ScpGraph;

var
  GraphDriver, GraphMode, ErrCode : Integer;
  Font1, Font2, Font3 : Integer;
  i : Integer;

function LoadFont(Name : String; Font : String) : Integer;
var F : File;
    P : Pointer;
    Size : LongInt;
begin
  InstallUserFont(Font);
  Assign(F, Name);
  FileMode := 0;
  ReSet(F, 1);
  Size := FileSize(F);
  GetMem(P, Size);
  BlockRead(F, P^, Size);
  Close(F);
  LoadFont := RegisterBGIFont(P);
end;

begin
  Write('Сейчас будет произведена демонстрация шрифтов в режиме 640x480x16...');
  ReadLn;

  GraphDriver := VGA;
  GraphMode := VGAHi;
  InitGraph(GraphDriver, GraphMode, 'X:\BP');
  ErrCode := GraphResult;
  if ErrCode <> grOk then
  begin
    WriteLn('Ошибка инициализации графики: ', GraphErrorMsg(ErrCode));
    ReadLn;
    Halt(1);
  end;

  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
  OutTextXY(10, 10, 'Это DefaultFont (0), размер 2');
  SetTextStyle(TriplexFont, HorizDir, 3);
  OutTextXY(10, 30, 'Это TriplexFont (1), размер 3');
  SetTextStyle(SmallFont, HorizDir, 8);
  OutTextXY(10, 55, 'Это SmallFont (2), размер 8');
  SetTextStyle(SansSerifFont, HorizDir, 3);
  OutTextXY(10, 80, 'Это SansSerifFont (3), размер 3');
  SetTextStyle(GothicFont, HorizDir, 3);
  OutTextXY(10, 105, 'Это GothicFont (4), размер 3');
  SetTextStyle(5, HorizDir, 3);
  OutTextXY(10, 130, 'Это SCRI.CHR (5), размер 3');
  SetTextStyle(6, HorizDir, 3);
  OutTextXY(10, 160, 'Это SIMP.CHR (6), размер 3');
  SetTextStyle(7, HorizDir, 3);
  OutTextXY(10, 185, 'Это TSCR.CHR (7), размер 3');
  SetTextStyle(8, HorizDir, 3);
  OutTextXY(10, 210, 'Это LCOM.CHR (8), размер 3');
  SetTextStyle(9, HorizDir, 1);
  OutTextXY(10, 235, 'Это EURO.CHR (9), размер 1');
  SetTextStyle(10, HorizDir, 3);
  OutTextXY(10, 270, 'Это BOLD.CHR (10), размер 2');

  ReadLn;
  CloseGraph;

  Write('Сейчас будет произведена демонстрация нестандартных шрифтов в режиме 800x600x32k');
  ReadLn;

  Font1 := LoadFont('X:\BP\_NOBL.CHR', 'NOBL');
  ErrCode := Font1;
  if ErrCode < 0 then
  begin
    WriteLn('Error loading font: ', GraphErrorMsg(ErrCode));
    ReadLn;
    Halt(1);
  end;

  Font2 := LoadFont('X:\BP\_DRFT.CHR', 'DRFT');
  ErrCode := Font2;
  if ErrCode < 0 then
  begin
    WriteLn('Error loading font: ', GraphErrorMsg(ErrCode));
    ReadLn;
    Halt(1);
  end;

  Font3 := LoadFont('X:\BP\_RRTR.CHR', 'RRTR');
  ErrCode := Font3;
  if ErrCode < 0 then
  begin
    WriteLn('Error loading font: ', GraphErrorMsg(ErrCode));
    ReadLn;
    Halt(1);
  end;

  ErrCode := InitScpGraph(800, 600, 1600, False, 'X:\BP');
  if ErrCode <> grOk then
  begin
    WriteLn('Ошибка инициализации графики: ', GraphErrorMsg(ErrCode));
    ReadLn;
    Halt(1);
  end;

  SetColor(RealDrawColor(GetStdColor(White)));
  SetTextStyle(Font1, HorizDir, 7);
  OutTextXY(10, 10, 'NOBL, size = 7');
  SetTextStyle(Font2, HorizDir, 4);
  OutTextXY(10, 130, 'Это DRFT, размер 4');
  SetTextStyle(Font3, HorizDir, 6);
  OutTextXY(10, 170, 'Это RRTR, размер 6');

  for i := 0 to 255 do
  begin
    SetColor(RealDrawColor(RGB($ff, i, 255 - i)));
    Line(0, 250 + i, GetMaxX, 250 + i);
  end;

  ReadLn;
  CloseGraph;

  Write('The End...');
  ReadLn; Halt;

  Randomize;
  repeat
    SetColor(Random(GetMaxColor) + 1);
    MoveTo(Random(GetMaxX), Random(GetMaxY));
    OutText(Chr(Random(256)));
    Delay(2);
  until KeyPressed;
  if ReadKey = #0 then ReadKey;
  CloseGraph;
end.
