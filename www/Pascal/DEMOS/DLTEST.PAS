uses CRT, DOS;

var Hour, Minute, Second, Sec100 : Word;
    OrigMode : Integer;
begin
  OrigMode := LastMode;
  TextMode(C80 + Font8x8);
  WriteLn('�ணࠬ�� �������� �業��� ����⢮ ॠ����樨 Crt.Delay');
  WriteLn;
  WriteLn('3 �����: ���⥫쭮��� ���ࢠ�� ������ � ����� ᥪ㭤�');
  WriteLn;
  WriteLn('4 �����: ��� ���� ᥪ㭤� �� �ꥧ����. ����譮��� ��');
  WriteLn(' ����७�� �६��� ��⠢��� ���浪� 5 ���� ᥪ㭤�, ⠪');
  WriteLn(' �� ��������� � �।���� 5 ��� 6 ���� �����⨬�.');
  WriteLn;
  WriteLn('5 ������: ����㧪� ������ �� 100% (��� DOSBox �����');
  WriteLn(' ���ॡ������� idle.com)');
  WriteLn;

  repeat
    GetTime(Hour, Minute, Second, Sec100);
    WriteLn(Hour : 2, ':', Minute : 2, ':', Second : 2, '.', Sec100 : 2);
    Crt.Delay(1000);
  until KeyPressed;
  if ReadKey = #0 then ReadKey;
  TextMode(OrigMode);
end.
