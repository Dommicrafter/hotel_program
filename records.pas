(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 08.11.2018
 *)
unit records;

interface
uses classes, fgl;
type
  TUser = record
    user, paswd : string;
  end;

  THotels = record
    name, titel : string;
    distanceNext : Integer;
  end;
  zuq = record
    quadrat:QWord;
    zahl : Integer;
  end;

  TZuqArray = array[0..100000] of zuq;
  TUserList = TStringList;
  TUserArrayList = array[0..1] of TUserList;
  TLoginsImporter = TStringList;
  TMyFile = TextFile;
  THotelsArray = array[1..40] of THotels;
  TUndefinedStringArray = array of string;

implementation



end.