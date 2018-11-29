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

implementation

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

end.