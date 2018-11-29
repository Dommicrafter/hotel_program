(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
program start;



uses  records, loginCommands, hotelCommands;


var
  user : TUserArray;
  hotels : THotelsArray;
  i : Integer;
  return : Boolean;
  input : string;
  //stringSplitter : TStringList;

{procedure split(Del : Char; Str: String;list : tstringlist );
Begin
  list.clear;
  list.Delimiter       := Del;
  list.StrictDelimiter := True; // Requires D2006 or newer.
  list.DelimitedText   := Str;
End;}

begin
  initializeHotels(hotels);
  //stringSplitter.Create();

  WriteLn('Command eingeben!');
  ReadLn(input);
  //split(' ', input, stringSplitter);

  {case stringSplitter[0] of
    'test' : WriteLn('jo' , stringSplitter[1]);
  end;}


  for i := 1 to 5 do
  Begin
    user[i].user := IntToStr(i);
    user[i].paswd := IntToStr(i);
  End;

  return := credentialInput(2, user);
  WriteLn('test');
  WriteLn('jo');
  if return then
  begin
    WriteLn('Erfolgreich eingeloggt! Willkommen! jo');
    startHotelAlgorithm(hotels);
  end
  else if not(return) then
    WriteLn('3 mal Falsch eingegeben!');

  ReadLn();


end.
