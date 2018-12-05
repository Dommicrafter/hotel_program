(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
program start;
{$mode objfpc}


uses sysutils, records, loginCommands, hotelCommands, classes, functions, Klassen, weiteres;


var
  user : TUserObject;
  hotels : THotelsObject;
  i : Integer;
  loginExitCode : Integer;
  input : string;
  stringSplitter : TStringList;
  inputArgs : TUndefinedStringArray;
  exitLoop : Boolean;

const filenameUsers = 'credentialData.dat';
const filenameHotels = 'hotel.list';


//Die Argumente jedes Inputs in einer Liste
function getCommandArgs(splitted : TStringList): TUndefinedStringArray;
var i : Integer;
begin
  SetLength(Result, splitted.Count -1);
  if splitted.Count > 1 then
  begin
    for i:= 1 to splitted.Count -1 do
      Result[i-1] := splitted[i];
  end
  else
    Result := nil;
end;

begin

  hotels := initializeHotels(filenameHotels);
  stringSplitter := TStringList.Create();
  user := parseFileToUserStrings(filenameUsers);

  //Command Loop
  exitLoop := false;
  loginExitCode := 0;
  repeat
    if loginExitCode = -1 then
      break;

    WriteLn('Command eingeben!');
    ReadLn(input);
    split(' ', input, stringSplitter);
    inputArgs := getCommandArgs(stringSplitter);



    case stringSplitter[0] of
      'test' : WriteLn('jo ', inputArgs[0], ' ', inputArgs[1]);
      'login' : loginExitCode := credentialInput(user, inputArgs);
      'exit' : exitLoop := true;
      'hotel':
        begin
          if loginExitCode = 0 then
            WriteLn('Du musst eingeloggt sein um diesen Command auszufuehren! Nutze den Command : login')
          else
            hotels := startHotelAlgorithm(hotels, inputArgs, filenameHotels);
        end;
      'register': addCredentials(filenameUsers, user, inputArgs);
      'zeitmessung': zeitmessung();
      //TODO: help hinzufügen!
    else
      Writeln('Command nicht gefunden! Liste aller Commands : help!');
    end;
    WriteLn('**********************************');
  until(exitLoop);
  WriteLn('Programm wird terminiert!');


  stringSplitter.Free();
  user.Free();
  hotels.Free();

end.
