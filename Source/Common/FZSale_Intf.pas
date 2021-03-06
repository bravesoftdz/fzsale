unit FZSale_Intf;

{----------------------------------------------------------------------------}
{ This unit was automatically generated by the RemObjects SDK after reading  }
{ the RODL file associated with this project .                               }
{                                                                            }
{ Do not modify this unit manually, or your changes will be lost when this   }
{ unit is regenerated the next time you compile the project.                 }
{----------------------------------------------------------------------------}

{$I RemObjects.inc}

interface

uses
  {vcl:} Classes, TypInfo,
  {RemObjects:} uROXMLIntf, uROClasses, uROClient, uROTypes, uROClientIntf;

const
  { Library ID }
  LibraryUID = '{34EF457B-16B4-449F-99E8-E602D03B2C77}';
  TargetNamespace = '';

  { Service Interface ID's }
  ISrvDB_IID : TGUID = '{67AE7A34-B074-4CB3-AA40-DC57D60F950C}';
  ISrvConn_IID : TGUID = '{BA2637C5-07A2-466C-8675-5F269C550B83}';

  { Event ID's }

type
  { Forward declarations }
  ISrvDB = interface;
  ISrvConn = interface;

  SQLItems = class;

  SrvResult = class;
  SQLItem = class;


  { SrvResult }

  { Description:
      服务执行返回结果的数据结构 }
  SrvResult = class(TROComplexType)
  private
    fRe_sult: Boolean;
    fAction: Integer;
    fDataStr: AnsiString;
    fDataInt: Integer;
  public
    procedure Assign(iSource: TPersistent); override;
    procedure ReadComplex(ASerializer: TObject); override;
    procedure WriteComplex(ASerializer: TObject); override;
  published

  { Description:
      执行结果(成功,失败) }
    property Re_sult:Boolean read fRe_sult write fRe_sult;

  { Description:
      结果要触发的动作(错误,跳转,升级等) }
    property Action:Integer read fAction write fAction;

  { Description:
      动作所需的字符数据 }
    property DataStr:AnsiString read fDataStr write fDataStr;

  { Description:
      动作所需的数值型数据 }
    property DataInt:Integer read fDataInt write fDataInt;
  end;

  { SrvResultCollection }
  SrvResultCollection = class(TROCollection)
  protected
    constructor Create(aItemClass: TCollectionItemClass); overload;
    function GetItems(aIndex: integer): SrvResult;
    procedure SetItems(aIndex: integer; const Value: SrvResult);
  public
    constructor Create; overload;
    function Add: SrvResult; reintroduce;
    property Items[Index: integer]:SrvResult read GetItems write SetItems; default;
  end;

  { SQLItem }

  { Description:
      按条件执行的SQL语句.若IfRun存在,则先执行,然后按照IfType判断条件是否满足.满足后执行SQL. 可用IfType如下: 1.IfType=1: IfRun为查询语句,且查询记录数<1时通过. 2.IfType=2: IfRun为查询语句,且查询记录数>0时通过. 3.IfType=5: IfRun为操作语句,且影响记录数<1时通过. 4.IfType=6: IfRun为操作语句,且影响记录数>0时通过. }
  SQLItem = class(TROComplexType)
  private
    fSQL: AnsiString;
    fIfRun: AnsiString;
    fIfType: Integer;
  public
    procedure Assign(iSource: TPersistent); override;
    procedure ReadComplex(ASerializer: TObject); override;
    procedure WriteComplex(ASerializer: TObject); override;
  published

  { Description:
      SQL语句 }
    property SQL:AnsiString read fSQL write fSQL;

  { Description:
      SQL执行条件 }
    property IfRun:AnsiString read fIfRun write fIfRun;
    property IfType:Integer read fIfType write fIfType;
  end;

  { SQLItemCollection }
  SQLItemCollection = class(TROCollection)
  protected
    constructor Create(aItemClass: TCollectionItemClass); overload;
    function GetItems(aIndex: integer): SQLItem;
    procedure SetItems(aIndex: integer; const Value: SQLItem);
  public
    constructor Create; overload;
    function Add: SQLItem; reintroduce;
    procedure SaveToArray(anArray: SQLItems);
    procedure LoadFromArray(anArray: SQLItems);
    property Items[Index: integer]:SQLItem read GetItems write SetItems; default;
  end;

  { SQLItems }

  { Description:
      包含SQLItem的数组 }
  SQLItems_SQLItem = array of SQLItem;
  SQLItems = class(TROArray)
  private
    fCount: Integer;
    fItems : SQLItems_SQLItem;
  protected
    procedure Grow; virtual;
    function GetItems(aIndex: integer): SQLItem;
    procedure SetItems(aIndex: integer; const Value: SQLItem);
    function GetCount: integer; override;
  public
    class function GetItemType: PTypeInfo; override;
    class function GetItemClass: TClass; override;
    class function GetItemSize: integer; override;

    function GetItemRef(aIndex: integer): pointer; override;
    procedure SetItemRef(aIndex: integer; Ref: pointer); override;
    procedure Clear; override;
    procedure Delete(aIndex: integer); override;
    procedure Resize(ElementCount: integer); override;

    procedure Assign(iSource:TPersistent); override;
    procedure ReadComplex(ASerializer: TObject); override;
    procedure WriteComplex(ASerializer: TObject); override;
    function Add: SQLItem; overload;
    function Add(const Value: SQLItem):integer; overload;

    property Count : integer read GetCount;
    property Items[Index: integer]:SQLItem read GetItems write SetItems; default;
    property InnerArray: SQLItems_SQLItem read fItems;
  end;

  { ISrvDB }

  { Description:
      数据服务 }
  ISrvDB = interface
    ['{67AE7A34-B074-4CB3-AA40-DC57D60F950C}']

    { Description:
        使用SQL查询数据

      Return Type: SrvResult
      Params
        1) nZID (AnsiString) : 终端店标识
        2) nDID (AnsiString) : 代理商标识
        3) nSQL (AnsiString) : SQL语句
        4) nData (Binary) : 查询结果
    }
    function SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString; out nData: Binary): SrvResult;

    { Description:
        执行写操作

      Return Type: SrvResult
      Params
        1) nZID (AnsiString) : 终端店标识
        2) nDID (AnsiString) : 代理商标识
        3) nSQL (SQLItem) : SQL语句
    }
    function SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem): SrvResult;

    { Description:
        批量写操作

      Return Type: SrvResult
      Params
        1) nZID (AnsiString) : 终端店标识
        2) nDID (AnsiString) : 代理商标识
        3) nSQLList (SQLItems) : SQL列表组
        4) nAtomic (Boolean) : 是否事务操作
    }
    function SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean): SrvResult;
  end;

  { CoSrvDB }
  CoSrvDB = class
    class function Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvDB;
  end;

  { TSrvDB_Proxy }
  TSrvDB_Proxy = class(TROProxy, ISrvDB)
  protected
    function __GetInterfaceName:string; override;

    function SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString; out nData: Binary): SrvResult;
    function SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem): SrvResult;
    function SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean): SrvResult;
  end;

  { ISrvConn }

  { Description:
      链路连接服务,包括登录、心跳、安全认证等. }
  ISrvConn = interface
    ['{BA2637C5-07A2-466C-8675-5F269C550B83}']

    { Description:
        心跳指令,返回服务器时间

      Return Type: SrvResult
      Params
    }
    function SweetHeart: SrvResult;
    function SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString; 
                    const nVerMIT: AnsiString; const nVerClient: AnsiString): SrvResult;
    function RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean): SrvResult;
  end;

  { CoSrvConn }
  CoSrvConn = class
    class function Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvConn;
  end;

  { TSrvConn_Proxy }
  TSrvConn_Proxy = class(TROProxy, ISrvConn)
  protected
    function __GetInterfaceName:string; override;

    function SweetHeart: SrvResult;
    function SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString; 
                    const nVerMIT: AnsiString; const nVerClient: AnsiString): SrvResult;
    function RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean): SrvResult;
  end;

implementation

uses
  {vcl:} SysUtils,
  {RemObjects:} uROEventRepository, uROSerializer, uRORes;

{ SQLItems }

procedure SQLItems.Assign(iSource: TPersistent);
var lSource:SQLItems;
    i:integer;
begin
  if (iSource is SQLItems) then begin
    lSource := SQLItems(iSource);
    Clear();
    Resize(lSource.Count);

    for i := 0 to Count-1 do begin
      if Assigned(lSource.Items[i]) then begin
        Items[i].Assign(lSource.Items[i]);
      end;
    end;
  end
  else begin
    inherited Assign(iSource);
  end;
end;

class function SQLItems.GetItemType: PTypeInfo;
begin
  result := TypeInfo(SQLItem);
end;

class function SQLItems.GetItemClass: TClass;
begin
  result := SQLItem;
end;

class function SQLItems.GetItemSize: integer;
begin
  result := SizeOf(SQLItem);
end;

function SQLItems.GetItems(aIndex: integer): SQLItem;
begin
  if (aIndex < 0) or (aIndex >= Count) then RaiseError(err_ArrayIndexOutOfBounds,[aIndex]);
  result := fItems[aIndex];
end;

function SQLItems.GetItemRef(aIndex: integer): pointer;
begin
  if (aIndex < 0) or (aIndex >= Count) then RaiseError(err_ArrayIndexOutOfBounds,[aIndex]);
  result := fItems[aIndex];
end;

procedure SQLItems.SetItemRef(aIndex: integer; Ref: pointer);
begin
  if (aIndex < 0) or (aIndex >= Count) then RaiseError(err_ArrayIndexOutOfBounds,[aIndex]);
  if Ref <> fItems[aIndex] then begin
    if fItems[aIndex] <> nil then fItems[aIndex].Free;
    fItems[aIndex] := Ref;
  end;
end;

procedure SQLItems.Clear;
var i: integer;
begin
  for i := 0 to (Count-1) do fItems[i].Free();
  SetLength(fItems, 0);
  FCount := 0;
end;

procedure SQLItems.Delete(aIndex: integer);
var i: integer;
begin
  if (aIndex>=Count) then RaiseError(err_InvalidIndex, [aIndex]);

  fItems[aIndex].Free();

  if (aIndex<Count-1) then
    for i := aIndex to Count-2 do fItems[i] := fItems[i+1];

  SetLength(fItems, Count-1);
  Dec(FCount);
end;

procedure SQLItems.SetItems(aIndex: integer; const Value: SQLItem);
begin
  if (aIndex < 0) or (aIndex >= Count) then RaiseError(err_ArrayIndexOutOfBounds,[aIndex]);
  if fItems[aIndex] <> Value then begin
    fItems[aIndex].Free;
    fItems[aIndex] := Value;
  end;
end;

procedure SQLItems.Resize(ElementCount: integer);
var i: Integer;
begin
  if fCount = ElementCount then Exit;
  for i := FCount -1 downto ElementCount do
    FItems[i].Free;
  SetLength(fItems, ElementCount);
  for i := FCount to ElementCount -1 do
    FItems[i] := SQLItem.Create;
  FCount := ElementCount;
end;

function SQLItems.GetCount: integer;
begin
  result := FCount;
end;

procedure SQLItems.Grow;
var
  Delta, Capacity: Integer;
begin
  Capacity := Length(fItems);
  if Capacity > 64 then
    Delta := Capacity div 4
  else
    if Capacity > 8 then
      Delta := 16
   else
      Delta := 4;
  SetLength(fItems, Capacity + Delta);
end;

function SQLItems.Add: SQLItem;
begin
  result := SQLItem.Create;
  Add(Result);
end;

function SQLItems.Add(const Value:SQLItem): integer;
begin
  Result := Count;
  if Length(fItems) = Result then
    Grow;
  fItems[result] := Value;
  Inc(fCount);
end;

procedure SQLItems.ReadComplex(ASerializer: TObject);
var
  lval: SQLItem;
  i: integer;
begin
  for i := 0 to Count-1 do begin
    with TROSerializer(ASerializer) do
      ReadStruct(GetArrayElementName(GetItemType, GetItemRef(i)), SQLItem, lval, i);
    Items[i] := lval;
  end;
end;

procedure SQLItems.WriteComplex(ASerializer: TObject);
var
  i: integer;
begin
  for i := 0 to Count-1 do
    with TROSerializer(ASerializer) do
      WriteStruct(GetArrayElementName(GetItemType, GetItemRef(i)), fItems[i], SQLItem, i);
end;

{ SrvResult }

procedure SrvResult.Assign(iSource: TPersistent); 
var lSource: FZSale_Intf.SrvResult;
begin
  inherited Assign(iSource);
  if (iSource is FZSale_Intf.SrvResult) then begin
    lSource := FZSale_Intf.SrvResult(iSource);
    Re_sult := lSource.Re_sult;
    Action := lSource.Action;
    DataStr := lSource.DataStr;
    DataInt := lSource.DataInt;
  end;
end;

procedure SrvResult.ReadComplex(ASerializer: TObject);
var
  l_Action: Integer;
  l_DataInt: Integer;
  l_DataStr: AnsiString;
  l_Re_sult: Boolean;
begin
  if TROSerializer(ASerializer).RecordStrictOrder then begin
    l_Re_sult := Re_sult;
    TROSerializer(ASerializer).ReadEnumerated('Re_sult',TypeInfo(boolean), l_Re_sult);
    Re_sult := l_Re_sult;
    l_Action := Action;
    TROSerializer(ASerializer).ReadInteger('Action', otSLong, l_Action);
    Action := l_Action;
    l_DataStr := DataStr;
    TROSerializer(ASerializer).ReadAnsiString('DataStr', l_DataStr);
    DataStr := l_DataStr;
    l_DataInt := DataInt;
    TROSerializer(ASerializer).ReadInteger('DataInt', otSLong, l_DataInt);
    DataInt := l_DataInt;
  end
  else begin
    l_Action := Action;
    TROSerializer(ASerializer).ReadInteger('Action', otSLong, l_Action);
    Action := l_Action;
    l_DataInt := DataInt;
    TROSerializer(ASerializer).ReadInteger('DataInt', otSLong, l_DataInt);
    DataInt := l_DataInt;
    l_DataStr := DataStr;
    TROSerializer(ASerializer).ReadAnsiString('DataStr', l_DataStr);
    DataStr := l_DataStr;
    l_Re_sult := Re_sult;
    TROSerializer(ASerializer).ReadEnumerated('Re_sult',TypeInfo(boolean), l_Re_sult);
    Re_sult := l_Re_sult;
  end;
end;

procedure SrvResult.WriteComplex(ASerializer: TObject);
var
  l_Action: Integer;
  l_DataInt: Integer;
  l_DataStr: AnsiString;
  l_Re_sult: Boolean;
begin
  if TROSerializer(ASerializer).RecordStrictOrder then begin
    TROSerializer(ASerializer).ChangeClass(SrvResult);
    l_Re_sult := Re_sult;
    TROSerializer(ASerializer).WriteEnumerated('Re_sult',TypeInfo(boolean), l_Re_sult);
    l_Action := Action;
    TROSerializer(ASerializer).WriteInteger('Action', otSLong, l_Action);
    l_DataStr := DataStr;
    TROSerializer(ASerializer).WriteAnsiString('DataStr', l_DataStr);
    l_DataInt := DataInt;
    TROSerializer(ASerializer).WriteInteger('DataInt', otSLong, l_DataInt);
  end
  else begin
    l_Action := Action;
    TROSerializer(ASerializer).WriteInteger('Action', otSLong, l_Action);
    l_DataInt := DataInt;
    TROSerializer(ASerializer).WriteInteger('DataInt', otSLong, l_DataInt);
    l_DataStr := DataStr;
    TROSerializer(ASerializer).WriteAnsiString('DataStr', l_DataStr);
    l_Re_sult := Re_sult;
    TROSerializer(ASerializer).WriteEnumerated('Re_sult',TypeInfo(boolean), l_Re_sult);
  end;
end;

{ SrvResultCollection }
constructor SrvResultCollection.Create;
begin
  inherited Create(SrvResult);
end;

constructor SrvResultCollection.Create(aItemClass: TCollectionItemClass);
begin
  inherited Create(aItemClass);
end;

function SrvResultCollection.Add: SrvResult;
begin
  result := SrvResult(inherited Add);
end;

function SrvResultCollection.GetItems(aIndex: integer): SrvResult;
begin
  result := SrvResult(inherited Items[aIndex]);
end;

procedure SrvResultCollection.SetItems(aIndex: integer; const Value: SrvResult);
begin
  SrvResult(inherited Items[aIndex]).Assign(Value);
end;

{ SQLItem }

procedure SQLItem.Assign(iSource: TPersistent); 
var lSource: FZSale_Intf.SQLItem;
begin
  inherited Assign(iSource);
  if (iSource is FZSale_Intf.SQLItem) then begin
    lSource := FZSale_Intf.SQLItem(iSource);
    SQL := lSource.SQL;
    IfRun := lSource.IfRun;
    IfType := lSource.IfType;
  end;
end;

procedure SQLItem.ReadComplex(ASerializer: TObject);
var
  l_IfRun: AnsiString;
  l_IfType: Integer;
  l_SQL: AnsiString;
begin
  if TROSerializer(ASerializer).RecordStrictOrder then begin
    l_SQL := SQL;
    TROSerializer(ASerializer).ReadAnsiString('SQL', l_SQL);
    SQL := l_SQL;
    l_IfRun := IfRun;
    TROSerializer(ASerializer).ReadAnsiString('IfRun', l_IfRun);
    IfRun := l_IfRun;
    l_IfType := IfType;
    TROSerializer(ASerializer).ReadInteger('IfType', otSLong, l_IfType);
    IfType := l_IfType;
  end
  else begin
    l_IfRun := IfRun;
    TROSerializer(ASerializer).ReadAnsiString('IfRun', l_IfRun);
    IfRun := l_IfRun;
    l_IfType := IfType;
    TROSerializer(ASerializer).ReadInteger('IfType', otSLong, l_IfType);
    IfType := l_IfType;
    l_SQL := SQL;
    TROSerializer(ASerializer).ReadAnsiString('SQL', l_SQL);
    SQL := l_SQL;
  end;
end;

procedure SQLItem.WriteComplex(ASerializer: TObject);
var
  l_IfRun: AnsiString;
  l_IfType: Integer;
  l_SQL: AnsiString;
begin
  if TROSerializer(ASerializer).RecordStrictOrder then begin
    TROSerializer(ASerializer).ChangeClass(SQLItem);
    l_SQL := SQL;
    TROSerializer(ASerializer).WriteAnsiString('SQL', l_SQL);
    l_IfRun := IfRun;
    TROSerializer(ASerializer).WriteAnsiString('IfRun', l_IfRun);
    l_IfType := IfType;
    TROSerializer(ASerializer).WriteInteger('IfType', otSLong, l_IfType);
  end
  else begin
    l_IfRun := IfRun;
    TROSerializer(ASerializer).WriteAnsiString('IfRun', l_IfRun);
    l_IfType := IfType;
    TROSerializer(ASerializer).WriteInteger('IfType', otSLong, l_IfType);
    l_SQL := SQL;
    TROSerializer(ASerializer).WriteAnsiString('SQL', l_SQL);
  end;
end;

{ SQLItemCollection }
constructor SQLItemCollection.Create;
begin
  inherited Create(SQLItem);
end;

constructor SQLItemCollection.Create(aItemClass: TCollectionItemClass);
begin
  inherited Create(aItemClass);
end;

function SQLItemCollection.Add: SQLItem;
begin
  result := SQLItem(inherited Add);
end;

function SQLItemCollection.GetItems(aIndex: integer): SQLItem;
begin
  result := SQLItem(inherited Items[aIndex]);
end;

procedure SQLItemCollection.LoadFromArray(anArray: SQLItems);
var i : integer;
begin
  Clear;
  for i := 0 to (anArray.Count-1) do
    Add.Assign(anArray[i]);
end;

procedure SQLItemCollection.SaveToArray(anArray: SQLItems);
var i : integer;
begin
  anArray.Clear;
  anArray.Resize(Count);
  for i := 0 to (Count-1) do begin
    anArray[i] := SQLItem.Create;
    anArray[i].Assign(Items[i]);
  end;
end;

procedure SQLItemCollection.SetItems(aIndex: integer; const Value: SQLItem);
begin
  SQLItem(inherited Items[aIndex]).Assign(Value);
end;

{ CoSrvDB }

class function CoSrvDB.Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvDB;
begin
  result := TSrvDB_Proxy.Create(aMessage, aTransportChannel);
end;

{ TSrvDB_Proxy }

function TSrvDB_Proxy.__GetInterfaceName:string;
begin
  result := 'SrvDB';
end;

function TSrvDB_Proxy.SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString; out nData: Binary): SrvResult;
begin
  try
    nData := nil;
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLQuery');
    __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
    __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
    __Message.Write('nSQL', TypeInfo(AnsiString), nSQL, []);
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
    __Message.Read('nData', TypeInfo(Binary), nData, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

function TSrvDB_Proxy.SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem): SrvResult;
begin
  try
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLExecute');
    __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
    __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
    __Message.Write('nSQL', TypeInfo(FZSale_Intf.SQLItem), nSQL, []);
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);
    nSQL.Free;

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

function TSrvDB_Proxy.SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean): SrvResult;
begin
  try
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLUpdates');
    __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
    __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
    __Message.Write('nSQLList', TypeInfo(FZSale_Intf.SQLItems), nSQLList, []);
    __Message.Write('nAtomic', TypeInfo(Boolean), nAtomic, []);
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);
    nSQLList.Free;

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

{ CoSrvConn }

class function CoSrvConn.Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvConn;
begin
  result := TSrvConn_Proxy.Create(aMessage, aTransportChannel);
end;

{ TSrvConn_Proxy }

function TSrvConn_Proxy.__GetInterfaceName:string;
begin
  result := 'SrvConn';
end;

function TSrvConn_Proxy.SweetHeart: SrvResult;
begin
  try
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SweetHeart');
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

function TSrvConn_Proxy.SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString; 
                               const nVerMIT: AnsiString; const nVerClient: AnsiString): SrvResult;
begin
  try
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SignIn');
    __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
    __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
    __Message.Write('nMAC', TypeInfo(AnsiString), nMAC, []);
    __Message.Write('nUser', TypeInfo(AnsiString), nUser, []);
    __Message.Write('nPwd', TypeInfo(AnsiString), nPwd, []);
    __Message.Write('nVerMIT', TypeInfo(AnsiString), nVerMIT, []);
    __Message.Write('nVerClient', TypeInfo(AnsiString), nVerClient, []);
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

function TSrvConn_Proxy.RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean): SrvResult;
begin
  try
    result := nil;
    __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'RegistMe');
    __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
    __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
    __Message.Write('nMAC', TypeInfo(AnsiString), nMAC, []);
    __Message.Write('nIsFirst', TypeInfo(Boolean), nIsFirst, []);
    __Message.Finalize;

    __TransportChannel.Dispatch(__Message);

    __Message.Read('Result', TypeInfo(FZSale_Intf.SrvResult), result, []);
  finally
    __Message.UnsetAttributes(__TransportChannel);
    __Message.FreeStream;
  end
end;

initialization
  RegisterROClass(SrvResult);
  RegisterROClass(SQLItem);
  RegisterROClass(SQLItems);
  RegisterProxyClass(ISrvDB_IID, TSrvDB_Proxy);
  RegisterProxyClass(ISrvConn_IID, TSrvConn_Proxy);


finalization
  UnregisterROClass(SrvResult);
  UnregisterROClass(SQLItem);
  UnregisterROClass(SQLItems);
  UnregisterProxyClass(ISrvDB_IID);
  UnregisterProxyClass(ISrvConn_IID);

end.
