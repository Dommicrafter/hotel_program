(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
unit hotelCommands;

interface
  uses records;

  function initializeHotels(hotels : THotelsArray; filename : String) : THotelsArray;
  procedure startHotelAlgorithm(hotels : THotelsArray; args : TUndefinedStringArray);
  procedure startHotelSimpleAlgorithm(hotels : THotelsArray);
  procedure startHotelComplexAlgorithm(hotels :THotelsArray);

implementation


uses sysutils, functions, classes;

function initializeHotels(hotels : THotelsArray; filename : String) : THotelsArray;
var
  i : Integer;
  reader : tstringlist;
begin
  Randomize();
  reader := TStringList.Create();
  reader.LoadFromFile(filename);
  for i := 1 to Length(hotels) do
  begin
    hotels[i].titel := reader[i-1];
    hotels[i].name := IntToStr(i);

    if i = Length(hotels) then
    begin
      hotels[i].distanceNext := 0;
    end
    else
    begin
      hotels[i].distanceNext := Random(50) + 1;
    end
  end;
  Result := hotels;
  reader.Free();
end;

procedure startHotelAlgorithm(hotels : THotelsArray; args : TUndefinedStringArray);
var i : Integer;
begin
  if Length(args) = 0 then
  begin
    WriteLn('Missing argument:  simple(Gibt den einfachen Algorithmus bis zum nächsten Hotel aus) complex(Von Hotel bis Hotel)');
    WriteLn('Usage hotel [argument]');
    exit;
  end
  else if Length(args) = 1 then
  begin
    if args[0] = 'simple' then
      startHotelSimpleAlgorithm(hotels)
    else if args[0] = 'complex' then
      startHotelComplexAlgorithm(hotels)
    else if args[0] = 'list' then
      for i := 1 to Length(hotels) do
      begin
        WriteLn('Hotel Nr.: ',hotels[i].name,' Hotel Name: ', hotels[i].titel, '. Entfernung bis zum nächstem Hotel beträgt: ', hotels[i].distanceNext, ' km.');
      end
    else
    begin
      WriteLn('False Arguments:  simple(Gibt den einfachen Algorithmus bis zum nächsten Hotel aus) complex(Von Hotel bis Hotel) list(Liste von allen Hotels)');
      WriteLn('Usage hotel [argument]');
      WriteLn('blö');
    end;



  end;
end;

procedure startHotelComplexAlgorithm(hotels :THotelsArray);
var
  inputHotel, geschwindigkeit, inputHotelGoal, i, hotelDistanceComplete, inputzw : Integer;
  inputText : string;
  erfolgreich : Boolean;
begin
  repeat
    erfolgreich := true;
    WriteLn('Von welchem Hotel moechten Sie starten?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(Length(hotels)) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotel := StrToInt(inputText)
    else
      inputHotel := getHotelIndex(hotels,inputText);

    if inputHotel = 0 then
      erfolgreich := false;

    if (inputHotel > Length(hotels)) or (inputHotel <= 0) then
      erfolgreich := false;
  until (erfolgreich);

  repeat
    erfolgreich := true;
    WriteLn('Zu welchem Hotel möchten Sie?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(Length(hotels)) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotelGoal := StrToInt(inputText)
    else
      inputHotelGoal := getHotelIndex(hotels,inputText);

    if inputHotelGoal = 0 then
      erfolgreich:=false;

    if (inputHotelGoal > Length(hotels)) or (inputHotelGoal <= 0) then
      erfolgreich := false;
  until (erfolgreich);

  if inputHotel > inputHotelGoal then
  begin
    inputzw := inputHotel;
    inputHotel := inputHotelGoal;
    inputHotelGoal := inputzw;
  end
  else if inputHotelGoal = inputHotel then
  begin
    WriteLn('Anfang ist gleich dem Ziel!');
    exit;
  end;

  hotelDistanceComplete := 0;
  for i := inputHotel to inputHotelGoal -1 do
  begin
    WriteLn('Hotel Nr.: ', hotels[i].name, '. Hotel Name: ', hotels[i].titel, '. Distanz bis zum naechstem Hotel: ', IntToStr(hotels[i].distanceNext), ' km.');
    hotelDistanceComplete := hotelDistanceComplete + hotels[i].distanceNext;
  end;

  WriteLn('Distanz von Hotel Nr.: ' , inputHotel , ' bis Hotel Nr.: ' , inputHotelGoal , ' beträgt insgesamt: ', hotelDistanceComplete , ' km.');

  repeat
    erfolgreich := true;
    geschwindigkeit := SichereEingabe('Wie schnell sind Sie? in km/h');
    if geschwindigkeit <= 0 then
      erfolgreich := false;
  until (erfolgreich);

  WriteLn('Sie brauchen: ', FloatToStrF(hotelDistanceComplete / geschwindigkeit, ffFixed, 6, 2), ' Stunden.');
end;

procedure startHotelSimpleAlgorithm(hotels : THotelsArray);
var
  erfolgreich : Boolean;
  inputHotel : Integer;
  geschwindigkeitT, inputText : string;
  geschwindigkeit : Integer;
begin

  repeat
    erfolgreich := true;
    WriteLn('Von welchem Hotel moechten Sie starten?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(Length(hotels)) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotel := StrToInt(inputText)
    else
      inputHotel := getHotelIndex(hotels,inputText);

    if inputHotel = 0 then
      erfolgreich:=false;

    if (inputHotel > Length(hotels)) or (inputHotel <= 0) then
      erfolgreich := false
    else if inputHotel = Length(hotels) then
    begin
      erfolgreich := false;
      WriteLn('Sie befinden sich bereits am Ende der Hotels!');
    end;

  until (erfolgreich);
  WriteLn('Hotel Nr.: ', hotels[inputHotel].name,'. Hotel Name: ', hotels[inputHotel].titel, '. Distanz bis zum naechstem Hotel: ', IntToStr(hotels[inputHotel].distanceNext), ' km.');

  repeat
    erfolgreich := true;
    geschwindigkeit := SichereEingabe('Wie schnell sind Sie? in km/h');
    if geschwindigkeit <= 0 then
      erfolgreich := false;
  until (erfolgreich);


  WriteLn('Sie brauchen: ', FloatToStrF(hotels[inputHotel].distanceNext / geschwindigkeit, ffFixed, 4, 2), ' Stunden.');

end;
end.