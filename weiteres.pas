(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 22.11.2018
 *)
unit weiteres;

interface

  procedure zeitmessung();

implementation

uses records, sysutils,dateutils;

procedure quadBerechnen(quadArr : TZuqArray; i : Integer);
begin
  quadArr[i].zahl := i;
  quadArr[i].quadrat := i*i;
  WriteLn('Zahl: ',i,' und Quadrat: ',i*i);
end;

procedure zeitmessung();
var
  zeit : TDateTime;
  quadArr : TZuqArray;
  i : Integer;
begin
  zeit :=TimeOf(now);
  for i := 0 to Length(quadArr) -1 do
    quadBerechnen(quadArr, i);
  WriteLn('Gesamtzeit: ',MilliSecondSpan(zeit,TimeOf(now)));
end;


end.