Attribute VB_Name = "Module1"
Public Declare Function CreatePipe Lib "kernel32.dll" (phReadPipe As Long, phWritePipe As Long, lpPipeAttributes As Any, ByVal nSize As Long) As Long
Public Declare Function CreateProcessA Lib "kernel32.dll" (ByVal lpApplicationName As Long, ByVal lpCommandLine As String, lpProcessAttributes As SECURITY_ATTRIBUTES, lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, ByVal lpEnvironment As Long, ByVal lpCurrentDirectory As Long, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Long
Public Declare Function CloseHandle Lib "kernel32.dll" (ByVal hHandle As Long) As Long
Public Declare Function ReadFile Lib "kernel32.dll" (ByVal hFile As Long, ByVal lpBuffer As String, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, ByVal lpOverlapped As Any) As Long
 Type PROCESSENTRY32
    dwSize As Long
    cntUsage As Long
    th32ProcessID As Long
    th32DefaultHeapID As Long
    th32ModuleID As Long
    cntThreads As Long
    th32ParentProcessID As Long
    pcPriClassBase As Long
    dwFlags As Long
    szExeFile As String * 260
End Type
Private Type PROCESS_INFORMATION
    hProcess As Long
    hThread As Long
    dwProcessId As Long
    dwThreadID As Long
End Type
Private Type STARTUPINFO
    cb As Long
    lpReserved As Long
    lpDesktop As Long
    lpTitle As Long
    dwX As Long
    dwY As Long
    dwXSize As Long
    dwYSize As Long
    dwXCountChars As Long
    dwYCountChars As Long
    dwFillAttribute As Long
    dwFlags As Long
    wShowWindow As Integer
    cbReserved2 As Integer
    lpReserved2 As Long
    hStdInput As Long
    hStdOutput As Long
    hStdError As Long
End Type
Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type
Public Function DOSOutput(ByVal mCommand As String) As String
    On Error Resume Next
    Dim proc As PROCESS_INFORMATION, start As STARTUPINFO, sa As SECURITY_ATTRIBUTES, ret As Long, hReadPipe As Long, hWritePipe As Long, lngBytesread As Long, strBuff As String
    
    sa.nLength = Len(sa)
    sa.bInheritHandle = 1
    sa.lpSecurityDescriptor = 0
    
    If CreatePipe(hReadPipe, hWritePipe, sa, 0) = 0 Then Exit Function
    
    start.cb = Len(start)
    start.dwFlags = 257
    start.hStdOutput = hWritePipe
    start.hStdError = hWritePipe
    
    If CreateProcessA(0, mCommand, sa, sa, 1, 32, 0, 0, start, proc) <> 1 Then Exit Function
    
    CloseHandle hWritePipe
    
    strBuff = String$(256, vbNullChar)
    Do
        ret = ReadFile(hReadPipe, strBuff, 256, lngBytesread, 0&)
        DOSOutput = DOSOutput & Left$(strBuff, lngBytesread)
        DoEvents
    Loop While ret <> 0
    
    CloseHandle proc.hProcess
    CloseHandle proc.hThread
    CloseHandle hReadPipe
    CloseHandle lngBytesread
End Function


