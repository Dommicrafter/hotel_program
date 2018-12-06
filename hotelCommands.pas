(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 07.11.2018
 *)
unit hotelCommands;

interface
  uses records,Klassen;

  function initializeHotels(filename : String) : THotelsObject;
  function startHotelAlgorithm(hotels : THotelsObject; args : TUndefinedStringArray; HotelFilename : string) : THotelsObject;
  procedure startHotelSimpleAlgorithm(hotels : THotelsObject);
  procedure startHotelComplexAlgorithm(hotels :THotelsObject);

implementation


uses sysutils, functions, classes;
//Alle Hotels werden von der Datei aus eingelesen
function initializeHotels(filename : String) : THotelsObject;
var
  i,j : Integer;
  reader,splitter, userlist, paswdlist : tstringlist;
  hotel : THotels;
begin
  Result := THotelsObject.Create();
  reader := TStringList.Create();
  reader.LoadFromFile(filename);
  for j := 0 to reader.Count-1 do
  begin
  splitter := TStringList.Create();
  split(' ',reader[j],splitter);
  hotel.name := IntToStr(j);
  hotel.titel := splitter[0];
  hotel.distanceNext := StrToInt(splitter[1]);

    if reader.Count-1 = j then
      hotel.distanceNext := 0;
  Result.addHotel(hotel);
  end;
  reader.Free();
end;
//Hotels werden in Datei geschrieben
function writeHotel(filename : string; hotel : THotels; hotels: THotelsObject): THotelsObject;
var i : Integer;
    writer : TStringList;
    text : string;
begin
  writer := TStringList.Create();
  hotels.insert(StrToInt(hotel.name),hotel);
  for i := 0  to hotels.size() -1 do
  begin
    text := hotels.getHotel(i).titel + ' ' + IntToStr(hotels.getHotel(i).distanceNext);
    writer.Add(text);
  end;
  writer.SaveToFile(filename);
  WriteLn(hotel.titel, ' wurde erfolgreich hinzugefügt!');
  Result := initializeHotels(filename);
end;
//Abfrage wie Hotel heißen soll etc.
function addHotel(filename: string; hotels: THotelsObject ; args : TUndefinedStringArray): THotelsObject ;
var inputName : string;
    index, hoteldistance : Integer;
    hotel : THotels;
begin
  case Length(args) of
    1 :
    begin
      index := SichereEingabe('An welche Position soll das Hotel eingefügt werden? ') -1;
      WriteLn('Hotel Name eingeben: ');
      Readln(inputName);
      hoteldistance := SichereEingabe('Entfernung zum nächsten Hotel angeben:');
    end;
    2:
    begin
      try
        index := StrToInt(args[1])-1;
      except
        on E : EConvertError do
        begin
          WriteLn('Falsche Parameterwahl! Fuer weitere Hilfe nutzen sie bitte "hotel help"!');
          exit;
        end;
      end;
      WriteLn('Hotel Name eingeben: ');
      Readln(inputName);
      hoteldistance := SichereEingabe('Entfernung zum nächsten Hotel angeben:');
    end;
    3:
    begin
      try
        index := StrToInt(args[1]) -1;
      except
        on E : EConvertError do
        begin
          WriteLn('Falsche Parameterwahl! Fuer weitere Hilfe nutzen sie bitte "hotel help"!');
          exit;
        end;
      end;
      inputName := args[2];
    end;
    4:
    begin
      try
        index := StrToInt(args[1])-1;
        hoteldistance := StrToInt(args[3]);
      except
        on E : EConvertError do
        begin
          WriteLn('Falsche Parameterwahl! Fuer weitere Hilfe nutzen sie bitte "hotel help"!');
          exit;
        end;
      end;
      inputName := args[2];
    end;

    //TODO: Hotel help hinzufügen!
    else
      WriteLn('Falsche Parameterwahl! Fuer weitere Hilfe nutzen sie bitte "hotel help"!')
  end;

  hotel.name := IntToStr(index);
  hotel.titel := inputName;
  hotel.distanceNext := hoteldistance;

  Result := writeHotel(filename,hotel,hotels);

end;

function startHotelAlgorithm(hotels : THotelsObject; args : TUndefinedStringArray; HotelFilename : string) : THotelsObject;
var i : Integer;
begin
  Result := hotels;
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
      for i := 0 to hotels.size() -1 do
      begin
        WriteLn('Hotel Nr.: ',i+1,' Hotel Name: ', hotels.getHotel(i).titel, '. Entfernung bis zum naechstem Hotel beträgt: ', hotels.getHotel(i).distanceNext, ' km.');
      end
    else if args[0] = 'add' then
      Result := addHotel(HotelFilename, hotels, args)
    else
    begin
      WriteLn('sssssssssssFalse Arguments:  simple(Gibt den einfachen Algorithmus bis zum naechsten Hotel aus) complex(Von Hotel bis Hotel) list(Liste von allen Hotels)');
      WriteLn('Usage hotel [argument]');
    end;



  end;
end;

procedure startHotelComplexAlgorithm(hotels :THotelsObject);
var
  inputHotel, geschwindigkeit, inputHotelGoal, i, hotelDistanceComplete, inputzw : Integer;
  inputText : string;
  erfolgreich : Boolean;
begin
  repeat
    erfolgreich := true;
    WriteLn('Von welchem Hotel moechten Sie starten?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(hotels.size()) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotel := StrToInt(inputText)
    else
      inputHotel := getHotelIndex(hotels,inputText);

    if inputHotel = 0 then
      erfolgreich := false;

    if (inputHotel > hotels.size()) or (inputHotel <= 0) then
      erfolgreich := false;
  until (erfolgreich);

  repeat
    erfolgreich := true;
    WriteLn('Zu welchem Hotel möchten Sie?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(hotels.size()) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotelGoal := StrToInt(inputText)
    else
      inputHotelGoal := getHotelIndex(hotels,inputText);

    if inputHotelGoal = 0 then
      erfolgreich:=false;

    if (inputHotelGoal > hotels.size()) or (inputHotelGoal <= 0) then
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
    WriteLn('Hotel Nr.: ', hotels.getHotel(i-1).name, '. Hotel Name: ', hotels.getHotel(i-1).titel, '. Distanz bis zum naechstem Hotel: ', IntToStr(hotels.getHotel(i-1).distanceNext), ' km.');
    hotelDistanceComplete := hotelDistanceComplete + hotels.getHotel(i).distanceNext;
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

procedure startHotelSimpleAlgorithm(hotels : THotelsObject);
var
  erfolgreich : Boolean;
  inputHotel : Integer;
  geschwindigkeitT, inputText : string;
  geschwindigkeit : Integer;
begin

  repeat
    erfolgreich := true;
    WriteLn('Von welchem Hotel moechten Sie starten?');
    WriteLn('Es gibt insgesamt beginnend von Nr.1 - ' + IntToStr(hotels.size()) + ' Hotels.');
    ReadLn(inputText);
    if SichereHotelEingabe(inputText) then
      inputHotel := StrToInt(inputText)
    else
      inputHotel := getHotelIndex(hotels,inputText);

    if inputHotel = 0 then
      erfolgreich:=false;

    if (inputHotel > hotels.size()) or (inputHotel <= 0) then
      erfolgreich := false
    else if inputHotel = hotels.size() then
    begin
      erfolgreich := false;
      WriteLn('Sie befinden sich bereits am Ende der Hotels!');
    end;

  until (erfolgreich);
  WriteLn('Hotel Nr.: ', hotels.getHotel(inputHotel).name,'. Hotel Name: ',hotels.getHotel(inputHotel).titel, '. Distanz bis zum naechstem Hotel: ', hotels.getHotel(inputHotel).distanceNext, ' km.');

  repeat
    erfolgreich := true;
    geschwindigkeit := SichereEingabe('Wie schnell sind Sie? in km/h');
    if geschwindigkeit <= 0 then
      erfolgreich := false;
  until (erfolgreich);


  WriteLn('Sie brauchen: ', FloatToStrF(hotels.getHotel(inputHotel).distanceNext / geschwindigkeit, ffFixed, 4, 2), ' Stunden.');

end;
end.