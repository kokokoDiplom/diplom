{
  Программа проверяет работу текстового драйвера
  для кодировки Windows.
}
uses ANSIFile, CRT;
var F : Text;
    N, S : String;
begin
  ClrScr;
  WriteLn('Демонстрация модуля AnsiFile');
  WriteLn;
  WriteLn('Если такой файл существует, он будет перезаписан!');
  Write('Введите имя нового файла (например, y:\test.txt): ');
  ReadLn(N);
  if N <> '' then
  begin
    WriteLn('>>> AssignANSI(F, ''', N, ''');');
    AssignANSI(F, N);
    WriteLn('>>> ReWrite(F);');
    ReWrite(F);
    WriteLn('>>> WriteLn(F, ''Русский текст в кодировке Windows-1251'');');
    WriteLn(F, 'Русский текст в кодировке Windows-1251');
    WriteLn('>>> Close(F);');
    Close(F);
    WriteLn('Файл записан, теперь чтение файла');
    Write('Нажмите Enter...');
    ReadLn;
    WriteLn('>>> AssignANSI(F, ''', N, ''');');
    AssignANSI(F, N); { это было необязательно }
    WriteLn('>>> ReSet(F);');
    ReSet(F);
    WriteLn('>>> ReadLn(F, S);');
    ReadLn(F, S);
    WriteLn('>>> Close(F);');
    Close(F);
    WriteLn('Из файла была считана строка S: ', S);
    Write('Нажмите Enter...');
    ReadLn;
  end;
end.
