uses CRT, DOS;

var Hour, Minute, Second, Sec100 : Word;
    OrigMode : Integer;
begin
  OrigMode := LastMode;
  TextMode(C80 + Font8x8);
  WriteLn('Программа позволяет оценить качество реализации Crt.Delay');
  WriteLn;
  WriteLn('3 балла: длительность интервала близка к одной секунде');
  WriteLn;
  WriteLn('4 балла: сотые доли секунды не съезжают. Погрешность при');
  WriteLn(' измерении времени составляет порядка 5 сотых секунды, так');
  WriteLn(' что колебания в пределах 5 или 6 сотых допустимы.');
  WriteLn;
  WriteLn('5 баллов: загрузка процессора не 100% (для DOSBox может');
  WriteLn(' потребоваться idle.com)');
  WriteLn;

  repeat
    GetTime(Hour, Minute, Second, Sec100);
    WriteLn(Hour : 2, ':', Minute : 2, ':', Second : 2, '.', Sec100 : 2);
    Crt.Delay(1000);
  until KeyPressed;
  if ReadKey = #0 then ReadKey;
  TextMode(OrigMode);
end.
