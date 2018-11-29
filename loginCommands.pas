(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
unit loginCommands;

interface
uses records, Klassen;

  function credentialInput(users : TUserObject; args : TUndefinedStringArray) : Integer;
  function addCredentials(filename : String; users : TUserObject; args : TUndefinedStringArray) : TUserObject;

implementation


uses sysutils, classes, functions;

var trys :Integer;

function getCredentials(name : string; users : TUserObject) : string;
var
  i, j : Integer;
  found : Boolean;
Begin
  result := '';
  for j := 0 to users.size() -1 do
    begin
      if users.getUser(j).user = name then
        Result := users.getUser(j).paswd;
    end;

End;

//Exit code -1: 3 mal Falsch 0:falsch eingegeben 1:richtig
function credentialInput(users : TUserObject; args : TUndefinedStringArray) : Integer;
var
  i : Integer;
  input, inputpw, return : string;
begin
  case Length(args) of
  0:
    begin
      WriteLn('Benutzername eingeben: ');
      ReadLn(input);
      WriteLn('Passwort eingeben: ');
      ReadLn(inputpw);
    end;
  1:
    begin
      input := args[0];
      WriteLn('Passwort eingeben: ');
      ReadLn(inputpw);
    end;
  else
    begin
      input := args[0];
      inputpw := args[1];
    end;

  end;

  return := getCredentials(input, users);
  Result := 0;

  if trys = 0 then
  begin
    WriteLn('3 mal Falsch eingegeben!');
    Result := -1;
    exit;
  end;

  if return = '' then

  Begin
    WriteLn('Benutzer nicht gefunden! Es existiert kein Benutzer mit dem Namen ', input);
    WriteLn('Usage: login [User] [Password] !');
    exit;
  end
  else if return = inputpw then
  begin
    WriteLn('Erfolgreich eingeloggt! Willkommen!');
    Result := 1
  end
  else
  begin
    WriteLn('Passwort falsch!');
    trys := trys - 1;
    WriteLn('Noch ', IntToStr(trys + 1), ' Versuch/e uebrig!');
    WriteLn('Usage: login [User] [Password] !');
    exit;
  end;
end;

function addCredentials(filename : string; users : TUserObject; args : TUndefinedStringArray) : TUserObject;
var
  i : Integer;
  inputUser, inputpaswd, abfrage : string;
  erfolgreich : Boolean;
begin
  WriteLn('Neuen Benutzer anlegen!');
  //Abfrage ob in den Argumenten schon der Benutzer geschrieben steht
  case Length(args) of
    0:
    begin
      WriteLn('Benutzername eingeben:');
      ReadLn(inputUser);
      WriteLn('Passwort eingeben:');
      ReadLn(inputpaswd);

    end;
    1:
    begin
      WriteLn('Passwort eingeben:');
      ReadLn(inputpaswd);
      inputUser := args[0];
    end;
    2:
    begin
      inputUser := args[0];
      inputpaswd := args[1];
    end;
  else
    WriteLn('Usage : register [Username] [Password]!');
  end;

  for i := 0 to users.size() -1 do
  begin
    if users.getUser(i).user = inputUser then
    begin
      WriteLn('Benutzer existiert bereits!');
      exit;
    end;
  end;


    repeat
      erfolgreich := true;
      WriteLn('Möchten Sie den Benutzer ', inputUser, ' wirklich speichern? [Yes/no]');
      ReadLn(abfrage);
      if (abfrage = '') or (abfrage = 'Yes') or (abfrage = 'Y') or (abfrage = 'y') or (abfrage = 'yes') then
        Result := writeUserStringsToFile(filename, inputUser, inputpaswd, users)
      else if (abfrage = 'no') or (abfrage = 'N') or (abfrage = 'n') or (abfrage = 'No') then
      begin
        WriteLn('Benutzer nicht gespeichert!');
        exit;
      end
      else
        erfolgreich := false;
    until(erfolgreich);

    WriteLn('Benutzer wurde gespeichert!');


end;


begin
  trys := 2;
end.