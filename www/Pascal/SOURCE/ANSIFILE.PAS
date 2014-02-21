{
                    written by Humble Jedis; public domain

  Большая часть перекодировок возникает именно при чтении/записи
  текстовых файлов. Поэтому специально для текстовых файлов было
  сделано особое решение: текстовый драйвер, автоматически
  производящий преобразование.

  Вместо того, чтобы каждый раз писать WriteLn(F, OemToAnsi(S)),
  можно один раз заменить Assign на AssignANSI и всё!!!

  Функции и таблицы преобразования кодировки тоже имеются, но они,
  очень может быть, так и не пригодятся.

  Модуль является достоянием общественности.
}

unit AnsiFile;
interface

procedure AssignANSI(var F : Text; Name : string);

{ dos-866 => windows-1251 }
function OemToAnsi(s : string) : string;

{ windows-1251 => dos-866 }
function AnsiToOem(s : string) : string;

const XLAT1251_866 : array[Char] of Char =
(#$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0a,#$0b,#$0c,#$0d,#$0e,#$0f,
 #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1a,#$1b,#$1c,#$1d,#$1e,#$1f,
 #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2a,#$2b,#$2c,#$2d,#$2e,#$2f,
 #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3a,#$3b,#$3c,#$3d,#$3e,#$3f,
 #$40,#$41,#$42,#$43,#$44,#$45,#$46,#$47,#$48,#$49,#$4a,#$4b,#$4c,#$4d,#$4e,#$4f,
 #$50,#$51,#$52,#$53,#$54,#$55,#$56,#$57,#$58,#$59,#$5a,#$5b,#$5c,#$5d,#$5e,#$5f,
 #$60,#$61,#$62,#$63,#$64,#$65,#$66,#$67,#$68,#$69,#$6a,#$6b,#$6c,#$6d,#$6e,#$6f,
 #$70,#$71,#$72,#$73,#$74,#$75,#$76,#$77,#$78,#$79,#$7a,#$7b,#$7c,#$7d,#$7e,#$7f,
 #$81,#$83,#$27,#$a3,#$22,#$2e,#$c5,#$d8,#$f3,#$25,#$8b,#$3c,#$8d,#$8a,#$68,#$96,
 #$68,#$27,#$27,#$22,#$22,#$fe,#$c4,#$c4,#$ff,#$74,#$ab,#$3e,#$ad,#$aa,#$68,#$e6,
 #$ff,#$f6,#$f7,#$4a,#$fd,#$83,#$7c,#$53,#$f0,#$63,#$f2,#$22,#$bf,#$2d,#$72,#$f4,
 #$f8,#$2b,#$49,#$69,#$a3,#$75,#$50,#$f9,#$f1,#$fc,#$f3,#$22,#$6a,#$53,#$73,#$f5,
 #$80,#$81,#$82,#$83,#$84,#$85,#$86,#$87,#$88,#$89,#$8a,#$8b,#$8c,#$8d,#$8e,#$8f,
 #$90,#$91,#$92,#$93,#$94,#$95,#$96,#$97,#$98,#$99,#$9a,#$9b,#$9c,#$9d,#$9e,#$9f,
 #$a0,#$a1,#$a2,#$a3,#$a4,#$a5,#$a6,#$a7,#$a8,#$a9,#$aa,#$ab,#$ac,#$ad,#$ae,#$af,
 #$e0,#$e1,#$e2,#$e3,#$e4,#$e5,#$e6,#$e7,#$e8,#$e9,#$ea,#$eb,#$ec,#$ed,#$ee,#$ef);

const XLAT866_1251 : array[Char] of Char =
(#$00,#$01,#$02,#$03,#$04,#$05,#$06,#$07,#$08,#$09,#$0a,#$0b,#$0c,#$0d,#$0e,#$0f,
 #$10,#$11,#$12,#$13,#$14,#$15,#$16,#$17,#$18,#$19,#$1a,#$1b,#$1c,#$1d,#$1e,#$1f,
 #$20,#$21,#$22,#$23,#$24,#$25,#$26,#$27,#$28,#$29,#$2a,#$2b,#$2c,#$2d,#$2e,#$2f,
 #$30,#$31,#$32,#$33,#$34,#$35,#$36,#$37,#$38,#$39,#$3a,#$3b,#$3c,#$3d,#$3e,#$3f,
 #$40,#$41,#$42,#$43,#$44,#$45,#$46,#$47,#$48,#$49,#$4a,#$4b,#$4c,#$4d,#$4e,#$4f,
 #$50,#$51,#$52,#$53,#$54,#$55,#$56,#$57,#$58,#$59,#$5a,#$5b,#$5c,#$5d,#$5e,#$5f,
 #$60,#$61,#$62,#$63,#$64,#$65,#$66,#$67,#$68,#$69,#$6a,#$6b,#$6c,#$6d,#$6e,#$6f,
 #$70,#$71,#$72,#$73,#$74,#$75,#$76,#$77,#$78,#$79,#$7a,#$7b,#$7c,#$7d,#$7e,#$7f,
 #$c0,#$c1,#$c2,#$c3,#$c4,#$c5,#$c6,#$c7,#$c8,#$c9,#$ca,#$cb,#$cc,#$cd,#$ce,#$cf,
 #$d0,#$d1,#$d2,#$d3,#$d4,#$d5,#$d6,#$d7,#$d8,#$d9,#$da,#$db,#$dc,#$dd,#$de,#$df,
 #$e0,#$e1,#$e2,#$e3,#$e4,#$e5,#$e6,#$e7,#$e8,#$e9,#$ea,#$eb,#$ec,#$ed,#$ee,#$ef,
 #$a0,#$a0,#$a0,#$7c,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$7c,#$2b,#$2b,#$2b,#$2b,#$2b,
 #$2b,#$2b,#$2b,#$2b,#$2d,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$3d,#$2b,#$2b,
 #$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$2b,#$a0,#$a0,#$a0,#$a0,#$a0,
 #$f0,#$f1,#$f2,#$f3,#$f4,#$f5,#$f6,#$f7,#$f8,#$f9,#$fa,#$fb,#$fc,#$fd,#$fe,#$ff,
 #$a8,#$b8,#$aa,#$ba,#$af,#$bf,#$a1,#$a2,#$b0,#$b7,#$b7,#$56,#$b9,#$a4,#$95,#$a0);

implementation
uses DOS;


function AnsiToOem(s : string) : string;
var
  r : string;
  i : Integer;
begin
  r := '';
  for i := 1 to Length(s) do
  begin
    case s[i] of
      #$85 : r := r + #$2e#$2e#$2e;
      #$89 : r := r + #$25#$2e;
      #$8a : r := r + #$8b#$9c;
      #$8c : r := r + #$8d#$9c;
      #$97 : r := r + #$c4#$c4;
      #$99 : r := r + #$54#$4d;
      #$9a : r := r + #$ab#$ec;
      #$9c : r := r + #$ad#$ec;
      #$a9 : r := r + #$28#$63#$29;
      #$ab : r := r + #$3c#$3c;
      #$ae : r := r + #$28#$52#$29;
      #$b1 : r := r + #$2b#$2f#$2d;
      #$b5 : r := r + #$6d#$75;
      #$bb : r := r + #$3e#$3e;
    else
      r := r + XLAT1251_866[s[i]];
    end;
  end;
  AnsiToOem := r;
end;


function OemToAnsi(s : string) : string;
var
  r : string;
  i : Integer;
begin
  r := s;
  for i := 1 to Length(s) do
  begin
     r[i] := XLAT866_1251[s[i]];
  end;
  OemToAnsi := r;
end;

var
  OriginalOpen, OriginalInput, OriginalOutput, OriginalOutFlush :
  function(var F: TextRec) : Integer;

const
  InitOpen : Boolean = False;
  InitInput : Boolean = False;
  InitOutput : Boolean = False;
  InitOutFlush : Boolean = False;

function InputANSI(var F: TextRec) : Integer; far;
var SaveBufSize : Word;
  NewBufSize : Word;
  S : String;
  R : Integer;
begin
  SaveBufSize := F.BufSize;
  NewBufSize := SaveBufSize div 3;
  if NewBufSize > 85 { 85 = 255 div 3 } then
    NewBufSize := 85;
  F.BufSize := NewBufSize;

  R := OriginalInput(F);

  InputANSI := R;
  if R = 0 then
  begin
    Byte(S[0]) := F.BufEnd - F.BufPos;
    Move(F.BufPtr^, S[1], Length(S));
    S := AnsiToOem(S);
    Move(S[1], F.BufPtr^, Length(S));
    F.BufEnd := F.BufPos + Length(S);
  end;

  F.BufSize := SaveBufSize;
end;

function OutputANSI(var F: TextRec) : Integer; far;
var R, i : Integer;
begin
  for i := 0 to F.BufPos - 1 do
    PChar(F.BufPtr)[i] := XLAT866_1251[PChar(F.BufPtr)[i]];
  R := OriginalOutput(F);
  OutputANSI := R;
end;

function OutFlushANSI(var F: TextRec) : Integer; far;
var R, i : Integer;
begin
  for i := 0 to F.BufPos - 1 do
    PChar(F.BufPtr)[i] := XLAT866_1251[PChar(F.BufPtr)[i]];
  R := OriginalOutFlush(F);
  OutFlushANSI := R;
end;

function OpenANSI(var F: TextRec) : Integer; far;
var
  P : Pointer;
  R : Integer;
begin
  if F.Mode = fmInput then
  begin
    R := OriginalOpen(F);
    if R = 0 then
    begin
      P := F.InOutFunc;
      if not InitInput then
        if P <> nil then
        begin
          Pointer(@OriginalInput) := P;
          InitInput := True;
        end;
      if P <> nil then
        F.InOutFunc := @InputANSI;
    end;
  end else
  begin
    R := OriginalOpen(F);
    if R = 0 then
    begin
      P := F.InOutFunc;
      if not InitOutput then
        if P <> nil then
        begin
          Pointer(@OriginalOutput) := P;
          InitOutput := True;
        end;
      if P <> nil then
        F.InOutFunc := @OutputANSI;

      P := F.FlushFunc;
      if not InitOutFlush then
        if P <> nil then
        begin
          Pointer(@OriginalOutFlush) := P;
          InitOutFlush := True;
        end;
      if P <> nil then
        F.FlushFunc := @OutFlushANSI;
    end;

  end;
  OpenANSI := R;
end;

procedure AssignANSI(var F : Text; Name : String);
var P : Pointer;
begin
  Assign(F, Name);
  P := TextRec(F).OpenFunc;
  if not InitOpen then
    if P <> nil then
    begin
      Pointer(@OriginalOpen) := P;
      InitOpen := True;
    end;
  if P <> nil then
    TextRec(F).OpenFunc := @OpenANSI;
end;

end.