(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 08.11.2018
 *)
unit records;

interface

type
  TUser = record
    user, paswd : string;
  end;

  THotels = record
    name : string;
    distanceNext : Integer;
  end;

  TUserArray = array[1..5] of TUser;
  THotelsArray = array[1..40] of THotels;

implementation

end.