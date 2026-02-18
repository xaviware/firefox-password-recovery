Option Strict Off
Option Explicit On
Module Module1
	'UPGRADE_ISSUE: No se admite la declaración de un parámetro 'As Any'. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Public Declare Function CreatePipe Lib "kernel32.dll" (ByRef phReadPipe As Integer, ByRef phWritePipe As Integer, ByRef lpPipeAttributes As Any, ByVal nSize As Integer) As Integer
	'UPGRADE_WARNING: La estructura PROCESS_INFORMATION puede requerir que se pasen atributos de cálculo de referencia como argumento en esta instrucción Declare. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	'UPGRADE_WARNING: La estructura STARTUPINFO puede requerir que se pasen atributos de cálculo de referencia como argumento en esta instrucción Declare. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	'UPGRADE_WARNING: La estructura SECURITY_ATTRIBUTES puede requerir que se pasen atributos de cálculo de referencia como argumento en esta instrucción Declare. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	'UPGRADE_WARNING: La estructura SECURITY_ATTRIBUTES puede requerir que se pasen atributos de cálculo de referencia como argumento en esta instrucción Declare. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function CreateProcessA Lib "kernel32.dll" (ByVal lpApplicationName As Integer, ByVal lpCommandLine As String, ByRef lpProcessAttributes As SECURITY_ATTRIBUTES, ByRef lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Integer, ByVal dwCreationFlags As Integer, ByVal lpEnvironment As Integer, ByVal lpCurrentDirectory As Integer, ByRef lpStartupInfo As STARTUPINFO, ByRef lpProcessInformation As PROCESS_INFORMATION) As Integer
	Public Declare Function CloseHandle Lib "kernel32.dll" (ByVal hHandle As Integer) As Integer
	'UPGRADE_ISSUE: No se admite la declaración de un parámetro 'As Any'. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Public Declare Function ReadFile Lib "kernel32.dll" (ByVal hFile As Integer, ByVal lpBuffer As String, ByVal nNumberOfBytesToRead As Integer, ByRef lpNumberOfBytesRead As Integer, ByVal lpOverlapped As Any) As Integer
	Structure PROCESSENTRY32
		Dim dwSize As Integer
		Dim cntUsage As Integer
		Dim th32ProcessID As Integer
		Dim th32DefaultHeapID As Integer
		Dim th32ModuleID As Integer
		Dim cntThreads As Integer
		Dim th32ParentProcessID As Integer
		Dim pcPriClassBase As Integer
		Dim dwFlags As Integer
		'UPGRADE_WARNING: El tamaño de la cadena de longitud fija debe caber en el búfer. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="3C1E4426-0B80-443E-B943-0627CD55D48B"'
		<VBFixedString(260),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=260)> Public szExeFile() As Char
	End Structure
	Private Structure PROCESS_INFORMATION
		Dim hProcess As Integer
		Dim hThread As Integer
		Dim dwProcessId As Integer
		Dim dwThreadID As Integer
	End Structure
	Private Structure STARTUPINFO
		Dim cb As Integer
		Dim lpReserved As Integer
		Dim lpDesktop As Integer
		Dim lpTitle As Integer
		Dim dwX As Integer
		Dim dwY As Integer
		Dim dwXSize As Integer
		Dim dwYSize As Integer
		Dim dwXCountChars As Integer
		Dim dwYCountChars As Integer
		Dim dwFillAttribute As Integer
		Dim dwFlags As Integer
		Dim wShowWindow As Short
		Dim cbReserved2 As Short
		Dim lpReserved2 As Integer
		Dim hStdInput As Integer
		Dim hStdOutput As Integer
		Dim hStdError As Integer
	End Structure
	Private Structure SECURITY_ATTRIBUTES
		Dim nLength As Integer
		Dim lpSecurityDescriptor As Integer
		Dim bInheritHandle As Integer
	End Structure
	Public Function DOSOutput(ByVal mCommand As String) As String
		On Error Resume Next
		Dim proc As PROCESS_INFORMATION
		Dim start As STARTUPINFO
		Dim sa As SECURITY_ATTRIBUTES
		Dim hWritePipe, ret, hReadPipe, lngBytesread As Integer
		Dim strBuff As String
		
		sa.nLength = Len(sa)
		sa.bInheritHandle = 1
		sa.lpSecurityDescriptor = 0
		
		'UPGRADE_WARNING: No se puede resolver la propiedad predeterminada del objeto sa. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		If CreatePipe(hReadPipe, hWritePipe, sa, 0) = 0 Then Exit Function
		
		start.cb = Len(start)
		start.dwFlags = 257
		start.hStdOutput = hWritePipe
		start.hStdError = hWritePipe
		
		If CreateProcessA(0, mCommand, sa, sa, 1, 32, 0, 0, start, proc) <> 1 Then Exit Function
		
		CloseHandle(hWritePipe)
		
		strBuff = New String(vbNullChar, 256)
		Do 
			ret = ReadFile(hReadPipe, strBuff, 256, lngBytesread, 0)
			DOSOutput = DOSOutput & Left(strBuff, lngBytesread)
			System.Windows.Forms.Application.DoEvents()
		Loop While ret <> 0
		
		CloseHandle(proc.hProcess)
		CloseHandle(proc.hThread)
		CloseHandle(hReadPipe)
		CloseHandle(lngBytesread)
	End Function
End Module