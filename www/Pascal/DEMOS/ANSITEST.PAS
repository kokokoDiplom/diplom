{
  �ணࠬ�� �஢���� ࠡ��� ⥪�⮢��� �ࠩ���
  ��� ����஢�� Windows.
}
uses ANSIFile, CRT;
var F : Text;
    N, S : String;
begin
  ClrScr;
  WriteLn('���������� ����� AnsiFile');
  WriteLn;
  WriteLn('�᫨ ⠪�� 䠩� �������, �� �㤥� ��१���ᠭ!');
  Write('������ ��� ������ 䠩�� (���ਬ��, y:\test.txt): ');
  ReadLn(N);
  if N <> '' then
  begin
    WriteLn('>>> AssignANSI(F, ''', N, ''');');
    AssignANSI(F, N);
    WriteLn('>>> ReWrite(F);');
    ReWrite(F);
    WriteLn('>>> WriteLn(F, ''���᪨� ⥪�� � ����஢�� Windows-1251'');');
    WriteLn(F, '���᪨� ⥪�� � ����஢�� Windows-1251');
    WriteLn('>>> Close(F);');
    Close(F);
    WriteLn('���� ����ᠭ, ⥯��� �⥭�� 䠩��');
    Write('������ Enter...');
    ReadLn;
    WriteLn('>>> AssignANSI(F, ''', N, ''');');
    AssignANSI(F, N); { �� �뫮 ����易⥫쭮 }
    WriteLn('>>> ReSet(F);');
    ReSet(F);
    WriteLn('>>> ReadLn(F, S);');
    ReadLn(F, S);
    WriteLn('>>> Close(F);');
    Close(F);
    WriteLn('�� 䠩�� �뫠 ��⠭� ��ப� S: ', S);
    Write('������ Enter...');
    ReadLn;
  end;
end.
