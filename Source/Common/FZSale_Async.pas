unit FZSale_Async;

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
  {RemObjects:} uROXMLIntf, uROClasses, uROTypes, uROClientIntf, uROAsync,
  {Project:} FZSale_Intf;

type
  { ISrvDB_Async }
  ISrvDB_Async = interface(IROAsyncInterface)
    ['{B16FF35F-997D-47AF-93C2-2F12BA003EC3}']
    procedure Invoke_SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString);
    procedure Invoke_SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem);
    procedure Invoke_SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean);
    function Retrieve_SQLQuery(out nData: Binary): SrvResult;
    function Retrieve_SQLExecute: SrvResult;
    function Retrieve_SQLUpdates: SrvResult;
  end;

  { ISrvConn_Async }
  ISrvConn_Async = interface(IROAsyncInterface)
    ['{FAD50DA8-2C52-4929-A010-6775B0245871}']
    procedure Invoke_SweetHeart;
    procedure Invoke_SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString);
    procedure Invoke_RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean);
    function Retrieve_SweetHeart: SrvResult;
    function Retrieve_SignIn: SrvResult;
    function Retrieve_RegistMe: SrvResult;
  end;

  { CoSrvDB_Async }
  CoSrvDB_Async = class
    class function Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvDB_Async;
  end;

  { CoSrvConn_Async }
  CoSrvConn_Async = class
    class function Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvConn_Async;
  end;

  { TSrvDB_AsyncProxy }
  TSrvDB_AsyncProxy = class(TROAsyncProxy, ISrvDB_Async)
  private
  protected
    function __GetInterfaceName:string; override;

    procedure Invoke_SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString);
    procedure Invoke_SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem);
    procedure Invoke_SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean);
    function Retrieve_SQLQuery(out nData: Binary): SrvResult;
    function Retrieve_SQLExecute: SrvResult;
    function Retrieve_SQLUpdates: SrvResult;
  end;

  { TSrvConn_AsyncProxy }
  TSrvConn_AsyncProxy = class(TROAsyncProxy, ISrvConn_Async)
  private
  protected
    function __GetInterfaceName:string; override;

    procedure Invoke_SweetHeart;
    procedure Invoke_SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString);
    procedure Invoke_RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean);
    function Retrieve_SweetHeart: SrvResult;
    function Retrieve_SignIn: SrvResult;
    function Retrieve_RegistMe: SrvResult;
  end;

implementation

uses
  {vcl:} SysUtils;

{ CoSrvDB }

class function CoSrvDB_Async.Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvDB_Async;
begin
  result := TSrvDB_AsyncProxy.Create(aMessage, aTransportChannel);
end;

{ TSrvDB_AsyncProxy }

function TSrvDB_AsyncProxy.__GetInterfaceName:string;
begin
  result := 'SrvDB';
end;

procedure TSrvDB_AsyncProxy.Invoke_SQLQuery(const nZID: AnsiString; const nDID: AnsiString; const nSQL: AnsiString);
begin
  __AssertProxyNotBusy('SQLQuery');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLQuery');
  __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
  __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
  __Message.Write('nSQL', TypeInfo(AnsiString), nSQL, []);
  __DispatchAsyncRequest('SQLQuery',__Message);
    __Message.UnsetAttributes(__TransportChannel);
end;

function TSrvDB_AsyncProxy.Retrieve_SQLQuery(out nData: Binary): SrvResult;
var __response:TStream;
begin
  nData := nil;
  result := nil;
  __response := __RetrieveAsyncResponse('SQLQuery');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);
  __Message.Read('nData', TypeInfo(Binary), nData, []);

  __response.Free();
end;

procedure TSrvDB_AsyncProxy.Invoke_SQLExecute(const nZID: AnsiString; const nDID: AnsiString; const nSQL: SQLItem);
begin
  __AssertProxyNotBusy('SQLExecute');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLExecute');
  __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
  __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
  __Message.Write('nSQL', TypeInfo(SQLItem), nSQL, []);
  __DispatchAsyncRequest('SQLExecute',__Message);
    __Message.UnsetAttributes(__TransportChannel);
end;

function TSrvDB_AsyncProxy.Retrieve_SQLExecute: SrvResult;
var __response:TStream;
begin
  result := nil;
  __response := __RetrieveAsyncResponse('SQLExecute');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);

  __response.Free();
end;

procedure TSrvDB_AsyncProxy.Invoke_SQLUpdates(const nZID: AnsiString; const nDID: AnsiString; const nSQLList: SQLItems; const nAtomic: Boolean);
begin
  __AssertProxyNotBusy('SQLUpdates');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SQLUpdates');
  __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
  __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
  __Message.Write('nSQLList', TypeInfo(SQLItems), nSQLList, []);
  __Message.Write('nAtomic', TypeInfo(Boolean), nAtomic, []);
  __DispatchAsyncRequest('SQLUpdates',__Message);
    __Message.UnsetAttributes(__TransportChannel);
end;

function TSrvDB_AsyncProxy.Retrieve_SQLUpdates: SrvResult;
var __response:TStream;
begin
  result := nil;
  __response := __RetrieveAsyncResponse('SQLUpdates');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);

  __response.Free();
end;


{ CoSrvConn }

class function CoSrvConn_Async.Create(const aMessage: IROMessage; aTransportChannel: IROTransportChannel): ISrvConn_Async;
begin
  result := TSrvConn_AsyncProxy.Create(aMessage, aTransportChannel);
end;

{ TSrvConn_AsyncProxy }

function TSrvConn_AsyncProxy.__GetInterfaceName:string;
begin
  result := 'SrvConn';
end;

procedure TSrvConn_AsyncProxy.Invoke_SweetHeart;
begin
  __AssertProxyNotBusy('SweetHeart');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SweetHeart');
  __DispatchAsyncRequest('SweetHeart',__Message);
end;

function TSrvConn_AsyncProxy.Retrieve_SweetHeart: SrvResult;
var __response:TStream;
begin
  result := nil;
  __response := __RetrieveAsyncResponse('SweetHeart');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);

  __response.Free();
end;

procedure TSrvConn_AsyncProxy.Invoke_SignIn(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nUser: AnsiString; const nPwd: AnsiString);
begin
  __AssertProxyNotBusy('SignIn');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'SignIn');
  __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
  __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
  __Message.Write('nMAC', TypeInfo(AnsiString), nMAC, []);
  __Message.Write('nUser', TypeInfo(AnsiString), nUser, []);
  __Message.Write('nPwd', TypeInfo(AnsiString), nPwd, []);
  __DispatchAsyncRequest('SignIn',__Message);
    __Message.UnsetAttributes(__TransportChannel);
end;

function TSrvConn_AsyncProxy.Retrieve_SignIn: SrvResult;
var __response:TStream;
begin
  result := nil;
  __response := __RetrieveAsyncResponse('SignIn');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);

  __response.Free();
end;

procedure TSrvConn_AsyncProxy.Invoke_RegistMe(const nZID: AnsiString; const nDID: AnsiString; const nMAC: AnsiString; const nIsFirst: Boolean);
begin
  __AssertProxyNotBusy('RegistMe');

  __Message.InitializeRequestMessage(__TransportChannel, 'FZSale', __InterfaceName, 'RegistMe');
  __Message.Write('nZID', TypeInfo(AnsiString), nZID, []);
  __Message.Write('nDID', TypeInfo(AnsiString), nDID, []);
  __Message.Write('nMAC', TypeInfo(AnsiString), nMAC, []);
  __Message.Write('nIsFirst', TypeInfo(Boolean), nIsFirst, []);
  __DispatchAsyncRequest('RegistMe',__Message);
    __Message.UnsetAttributes(__TransportChannel);
end;

function TSrvConn_AsyncProxy.Retrieve_RegistMe: SrvResult;
var __response:TStream;
begin
  result := nil;
  __response := __RetrieveAsyncResponse('RegistMe');
  __Message.ReadFromStream(__response);

  __Message.Read('Result', TypeInfo(SrvResult), Result, []);

  __response.Free();
end;


initialization
end.
