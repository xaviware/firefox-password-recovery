Attribute VB_Name = "mSqlite"
'---------------------------------------------------------------------------------------
' Module      : mSqlite
' DateTime    : 25/07/2009 05:29
' Author      : Cobein
' Mail        : cobein27@hotmail.com
' WebPage     : http://www.advancevb.com.ar
' Purpose     : Mini Sqlite wrapper
' Usage       : At your own risk
' Requirements: cCDECL.cls from Paul Caton
' Distribution: You can freely use this code in your own
'               applications, but you may not reproduce
'               or publish this code on any web site,
'               online service, or distribute as source
'               on any media without express permission.
'
' History     : 25/07/2009 First Cut....................................................
'---------------------------------------------------------------------------------------
Option Explicit

Private Const CP_UTF8                   As Long = 65001

Private Declare Function WideCharToMultiByte Lib "kernel32" (ByVal CodePage As Long, ByVal dwFlags As Long, ByVal lpWideCharStr As Long, ByVal cchWideChar As Long, ByRef lpMultiByteStr As Any, ByVal cchMultiByte As Long, ByVal lpDefaultChar As String, ByVal lpUsedDefaultChar As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (pDst As Any, pSrc As Any, ByVal ByteLen As Long)
Private Declare Function VirtualAlloc Lib "kernel32" (ByVal lpAddress As Long, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As Long
Private Declare Function VirtualFree Lib "kernel32" (ByVal lpAddress As Long, ByVal dwSize As Long, ByVal dwFreeType As Long) As Long

Private m_cCDECL As cCDECL

Public Function sqlite3_init(ByVal sPath As String) As Boolean
    Set m_cCDECL = New cCDECL
    sqlite3_init = m_cCDECL.DllLoad(sPath & "sqlite3.dll")
End Function

Public Function sqlite3_terminate() As Boolean
    m_cCDECL.DllUnload
    Set m_cCDECL = Nothing
End Function

Public Function sqlite3_open(ByVal sPath As String) As Long
    'int sqlite3_open(
    '  const char *filename,   /* Database filename (UTF-8) */
    '  sqlite3 **ppDb          /* OUT: SQLite db handle */
    ');

    Dim lRet As Long
    Dim lMem As Long
        
    sPath = UnicodeToUTF8(sPath) & vbNullChar
    lMem = VirtualAlloc(0, Len(sPath), &H1000&, &H40&)
    SetString sPath, lMem
    
    With m_cCDECL
        If .CallFunc("sqlite3_open", lMem, VarPtr(lRet)) = 0 Then
            sqlite3_open = lRet
        End If
    End With
    
    VirtualFree lMem, 0, &H8000&
End Function

Public Function sqlite3_close(ByVal lHandle As Long) As Boolean
    'int sqlite3_close(sqlite3 *);
    
    With m_cCDECL
        If .CallFunc("sqlite3_close", lHandle) = 0 Then
            sqlite3_close = True
        End If
    End With
End Function

Public Function sqlite3_prepare_v2(ByVal lHandle As Long, ByVal sStatement As String) As Long
    'int sqlite3_prepare_v2(
    '  sqlite3 *db,            /* Database handle */
    '  const char *zSql,       /* SQL statement, UTF-8 encoded */
    '  int nByte,              /* Maximum length of zSql in bytes. */
    '  sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
    '  const char **pzTail     /* OUT: Pointer to unused portion of zSql */
    ');
    
    Dim lRet As Long
    Dim lTail As Long
    Dim lMem As Long

    sStatement = UnicodeToUTF8(sStatement) & vbNullChar
    
    lMem = VirtualAlloc(0, Len(sStatement), &H1000&, &H40&)
   
    SetString sStatement, lMem

    With m_cCDECL
        If .CallFunc("sqlite3_prepare_v2", lHandle, lMem, Len(sStatement), VarPtr(lRet), VarPtr(lTail)) = 0 Then
            sqlite3_prepare_v2 = lRet
        End If
    End With
    
    VirtualFree lMem, 0, &H8000&
End Function

Public Function sqlite3_step(ByVal lStatement As Long) As Boolean
    'int sqlite3_step(sqlite3_stmt*);
    With m_cCDECL
        If .CallFunc("sqlite3_step", lStatement) = 100 Then
            sqlite3_step = True
        End If
    End With
End Function

Public Function sqlite3_finalize(ByVal lStatement As Long) As Boolean
    'int sqlite3_finalize(sqlite3_stmt *pStmt);
    
    With m_cCDECL
        If .CallFunc("sqlite3_finalize", lStatement) = 0 Then
            sqlite3_finalize = True
        End If
    End With
End Function

Public Function sqlite3_column_text(ByVal lStatement As Long, ByVal lCol As Long) As String
    'const unsigned char *sqlite3_column_text(sqlite3_stmt*, int iCol);
    Dim lRet As Long
    With m_cCDECL
        lRet = .CallFunc("sqlite3_column_text", lStatement, lCol)
        sqlite3_column_text = StringFromPtr(lRet)
    End With
    
End Function

Private Function StringFromPtr(ByVal lAddr As Long) As String
    Dim b       As Byte
    
    If lAddr = 0 Then Exit Function
    Do
        CopyMemory b, ByVal lAddr, 1
        lAddr = lAddr + 1
        If b = 0 Then Exit Do
        StringFromPtr = StringFromPtr & Chr$(b)
    Loop
End Function

Private Function SetString(ByVal sData As String, ByVal lMem As Long)
    Dim bvData() As Byte
    Dim i As Long

    bvData = StrConv(sData, vbFromUnicode)
    
    For i = 0 To UBound(bvData)
        CopyMemory ByVal lMem + i, bvData(i), 1
    Next
End Function

'Ported from Leandro Ascierto routine.
Public Function UnicodeToUTF8(ByVal sData As String) As String
    Dim bvData()    As Byte
    Dim lSize       As Long
    Dim lRet        As Long
    
    If LenB(sData) Then
        lSize = Len(sData) * 2
        ReDim bvData(lSize)
    
        lRet = WideCharToMultiByte(CP_UTF8, 0, StrPtr(sData), _
           Len(sData), bvData(0), lSize + 1, vbNullString, 0)
    
        If lRet Then
            ReDim Preserve bvData(lRet - 1)
            UnicodeToUTF8 = StrConv(bvData, vbUnicode)
        End If
    End If

End Function

