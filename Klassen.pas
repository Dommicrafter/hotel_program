(*
 * Project: Studi_pascal_program
 * User: dschumann
 * Date: 15.11.2018
 *)
unit Klassen;

interface

uses classes, records;
type

//TUserObject gespeichert mit allen Nutzern
TUserObject = class
  private
    NameList, PaswdList : TStringList;
  public
    function getUser(index : Integer): TUser;
    procedure addUser(user : TUser);
    constructor Create(NameList : TStringList; PaswdList:TStringList);
    function size(): Integer;
    destructor Destroy(); override;
end;
  THotelsObject = class
  private
    TitelList, distanceList :tstringlist;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure addHotel(hotel : THotels);
    function getHotel(index : Integer): THotels;

    procedure insert(index: Integer; hotel : THotels);
    function size(): Integer ;
  end;

implementation

uses
  sysutils;

// TUser
procedure TUserObject.addUser(user : Tuser);
begin
  NameList.Add(user.user);
  PaswdList.Add(user.paswd);
end;

function TUserObject.size(): Integer;
begin
  Result := NameList.Count;

end;

destructor TUserObject.Destroy();
begin
  NameList.Free();
  PaswdList.Free();
end;

constructor TUserObject.Create(NameList : TStringList; PaswdList:TStringList);
begin
  Self.NameList := NameList;
  Self.PaswdList := PaswdList;
end;

function TUserObject.getUser(index :Integer): TUser ;
begin
  {if index > NameList.Count -1 then
    Result := nil
  else
  begin}
    Result.user := NameList[index];
    Result.paswd := PaswdList[index];

end;

constructor THotelsObject.Create();
begin
  Self.TitelList := TStringList.Create();
  Self.distanceList := TStringList.Create();
end;

destructor THotelsObject.Destroy();
begin
  TitelList.Free();
  distanceList.Free();
end;

procedure THotelsObject.addHotel(hotel : THotels);
begin
  TitelList.Add(hotel.titel);
  distanceList.Add(IntToStr(hotel.distanceNext));
end;

function THotelsObject.getHotel(index : Integer): THotels;
begin
  Result.name := IntToStr(index -1);
  Result.titel := Titellist[index];
  Result.distanceNext := StrtoInt(distanceList[index]);
end;

procedure THotelsObject.insert(index: Integer; hotel : THotels);
begin
  Self.TitelList.Insert(index,hotel.titel);
  Self.distanceList.Insert(index, IntToStr(hotel.distanceNext));
end;

function THotelsObject.size(): Integer ;
begin
  WriteLn(distanceList.Count);
  Result := distanceList.Count;
end;




end.