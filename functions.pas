(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 10.11.2018
 *)
unit functions;

interface

uses classes, records, Klassen;

  procedure split(Del : Char; Str: String;list : tstringlist );
  function SichereEingabe(Text: String): Integer;
  function parseFileToUserStrings(filename : string): TUserObject;
  function writeUserStringsToFile(filename : String; username : string; paswd : string; user :TUserObject): TUserObject;
  function SichereHotelEingabe(input : string): Boolean ;
  function getHotelIndex(hotels:THotelsObject; titel: String): Integer;

implementation

uses sysutils;

//Alle Zeilen einer Datei auslesen und in TUserObject einbinden
function parseFileToUserStrings(filename : string): TUserObject;
var List, splitList, passwdlist, namelist: TStringList;
    i, j : Integer;
begin
  List :=TStringList.Create();
  list.LoadFromFile(filename);
  passwdlist := TStringList.Create();
  namelist := TStringList.Create();
  for i := 0 to list.Count -1 do
  begin
    splitList :=TStringList.Create();
    split(' ', List[i] , splitList);

    namelist.Add(splitList[0]);
    passwdlist.Add(splitList[1]);

    splitList.Clear();
    splitList.Free();
  end;
  Result := TUserObject.Create(namelist, passwdlist);
  list.Free();
End;

function writeUserStringsToFile(filename : String; username : string; paswd : string; user :TUserObject): TUserObject;
var
  f : TextFile;
  SingleUser : TUser;
  i : Integer;
  text : string;
  fileList : TStringList;
begin
  //User hinzufügen
  SingleUser.user := username;
  SingleUser.paswd := paswd;
  user.addUser(SingleUser);

  //In Datei schreiben
  fileList := TStringList.Create();
  for i := 0 to user.size() -1 do
  begin
    text := user.getUser(i).user + ' ' + user.getUser(i).paswd;
    fileList.Add(text);
  end;
  fileList.SaveToFile(filename);
  fileList.Free();

  //Erneut einlesen zur weiterverarbeitung
  Result := parseFileToUserStrings(filename);
End;

//splitet einen String auf in seine Bestandteile getrennt vom 'Del'.
procedure split(Del : Char; Str: String;list : tstringlist );
Begin
  list.Clear();
  list.Delimiter       := Del;
  list.StrictDelimiter := True; // Requires D2006 or newer.
  list.DelimitedText   := Str;
End;

//Sichert die Eingabe ob es wirklich ein Integer ist.
function SichereEingabe(Text: String): Integer;
var
  Wert, Code: Integer;
  WertEin : string;
begin
  repeat
    WriteLn(Text+' ');
    Readln(WertEin);
    Val(WertEin,Wert,Code); //Wenn Code <> 0, dann war in der Eingabe ein ungültiges Zeichen
    if Code <> 0 then
      Writeln('Ungueltige Eingabe');
  until Code=0;
  SichereEingabe := Wert;
end;

//Exitcode true = Integer false = String
function SichereHotelEingabe(input : string): Boolean ;
var i : Integer;
begin
  Result := true;
  try
    i := StrToInt(input);
  except
    on E : EConvertError do
      Result := false;
  end;
end;

//Exitcode 0 = Kein Hotel gefunden!
function getHotelIndex(hotels:THotelsObject; titel: String): Integer;
var
  i : Integer;
begin
  Result := 0;
  for i := 0 to hotels.size()-1 do
  begin
    if hotels.getHotel(i).titel = titel then
      Result := i
    else if LowerCase(hotels.getHotel(i).titel) = LowerCase(titel) then
      Result := i;
  end;
  if Result = 0 then
    WriteLn('Es gibt kein Hotel mit diesen Namen!');

end;

end.