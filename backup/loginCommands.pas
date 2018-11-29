(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
unit loginCommands;

interface
uses records;

  function credentialInput(trys : Integer; users : TUserArray) : Boolean;

implementation


uses start, sysutils;

function getCredentials(name : string; users : TUserArray) : string;
var
  j : Integer;
  found : Boolean;
Begin
  getCredentials := '';
  for j := 1 to Length(users) do
  begin
    if (users[j].user = name)then
    begin
      Result := users[j].paswd;
    end;
  end;
End;

function credentialInput(trys : Integer; users : TUserArray) : Boolean;
var
  i : Integer;
  input, inputpw, return : string;
begin
  WriteLn('Benutzername eingeben: ');
  ReadLn(input);
  WriteLn('Passwort eingeben: ');
  ReadLn(inputpw);
  return := getCredentials(input, users);
  Result := false;

  if trys = 0 then
  begin
    Result := false;
    exit;
  end;

  if return = '' then

  Begin
    WriteLn('Benutzer nicht gefunden! Es existiert kein Benutzer mit dem Namen ', input);
    Result := credentialInput(trys, users);
  end
  else if return = inputpw then
    Result := true
  else
  begin
    WriteLn('Passwort falsch!');
    trys := trys - 1;
    WriteLn('Noch ', IntToStr(trys + 1), ' Versuch/e uebrig!');
    Result := credentialInput(trys, users);
  end;
end;

end.