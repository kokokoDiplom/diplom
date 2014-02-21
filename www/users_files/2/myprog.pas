program EXAMPLE26;	{заголовок программы}
uses Unit1, Unit2;	{используемые модули}
var i: Integer;	 
begin	 
  Change(Arr);	{процедура замены в Unitl, массив Arr - в Unit2}
  for i := 1 to N do	{N-в Unit2}
    WriteLn(Arr[i])	 
end.	 
