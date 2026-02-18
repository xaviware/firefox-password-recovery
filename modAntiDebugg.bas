Attribute VB_Name = "modAntiDebugg"
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : modAntiDebugg
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : ' Name : Detect Numega Smart Check, W32Dasm, Hex Workshop
'---------------------------------------------------------------------------------------

'*-------------------------------------
'Stores the truncated class names of
'applications which are to be monitored in the
'system while this application is running
Public Sub FillClassName()
'---------------------------------------------------------------------------------------
' Procedure : FillClassName
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   :
'---------------------------------------------------------------------------------------
Dim i As Integer
          
   On Error GoTo FillClassName_Error

          'Clear the Array
10        For i = 0 To NoOfAppClassMonitored
20            AppClassName(i) = ""
30        Next i
40        AppClassName(0) = "HexWorks" 'Hex Workshop 3.1
50        AppClassName(1) = "OWL_Window" 'WinDasm
60        AppClassName(2) = "NMSCMW" 'for various versions of Numega Smart Check
70        AppClassName(3) = "UltraEdit-32" 'Ultra Edit
          
          'WinAmp Playlist, WinAmp Mnibrowser, WinAmp version x.x, Winamp Equaliser
          'AppClassName(4) = "Notepad" 'Notepad
          'AppClassName(5) = "UltraEdit-32" 'Ultra Edit

   On Error GoTo 0
   Exit Sub

FillClassName_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure FillClassName of Módulo modAntiDebugg in Line " & Erl& & vbNewLine)
End Sub
Public Function AppPresent(TgtClassName As String, frmName As Object) As Long
'---------------------------------------------------------------------------------------
' Procedure : AppPresent
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   :
'---------------------------------------------------------------------------------------
'Check if the windows classname matches with
'our list in the array (TgtClassName i.e. target
'classname)

   On Error GoTo AppPresent_Error

10        AppPresent = SearchAppsByClassName(TgtClassName, frmName)

   On Error GoTo 0
   Exit Function

AppPresent_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure AppPresent of Módulo modAntiDebugg in Line " & Erl& & vbNewLine)
End Function
Function SearchAppsByClassName(TgtClassName As String, frmName As Object)
'---------------------------------------------------------------------------------------
' Procedure : SearchAppsByClassName
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   :
'---------------------------------------------------------------------------------------
'Searches all the applications running in
'Windows environment either in the
'foreground or in the background
Dim ThisAppHandle As Long
Dim NextAppHandle As Long
Dim AppClassName As String
          
   On Error GoTo SearchAppsByClassName_Error

          'Get your current application owner's
          'handle
10        ThisAppHandle = getwindow(frmName.hwnd, GW_OWNER)
          'Pass it on as a seed for the next handle
          'so all the windows in the z order can be
          'searched
20        NextAppHandle = ThisAppHandle
          'Perform the iterations in the Z order till
          'all the running applications (either foreground
          'or background) have been run through
30        Do While NextAppHandle <> 0
40            DoEvents
              'Get the handle of the next window
              'in the Z order
50            NextAppHandle = getwindow(NextAppHandle, GW_HWNDNEXT)
              'Retrieve its window's classname
60            AppClassName = GetAppClassName(NextAppHandle)
              'If a part of TgtClassName is found
              'then retrieve this applications handle
70            If InStr(1, LCase(Trim(AppClassName)), LCase(Trim(TgtClassName))) <> 0 Then
80                SearchAppsByClassName = NextAppHandle
90                Exit Do
100               Exit Function
110           End If
120       Loop

   On Error GoTo 0
   Exit Function

SearchAppsByClassName_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure SearchAppsByClassName of Módulo modAntiDebugg in Line " & Erl& & vbNewLine)
End Function
Private Function GetAppClassName(HwndWindow As Long) As String
'---------------------------------------------------------------------------------------
' Procedure : GetAppClassName
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : 'Get the Window's Class Name
'---------------------------------------------------------------------------------------
Dim BufferAll&
Dim WindowClassName$

   On Error GoTo GetAppClassName_Error

10        WindowClassName$ = String(100, Chr(0))
20        BufferAll& = GetClassName(HwndWindow, WindowClassName$, 100)
30        GetAppClassName = Left(WindowClassName$, BufferAll&)
40        DoEvents

   On Error GoTo 0
   Exit Function

GetAppClassName_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure GetAppClassName of Módulo modAntiDebugg in Line " & Erl& & vbNewLine)
End Function
Public Sub KillWin(hwnd As Long)
'---------------------------------------------------------------------------------------
' Procedure : KillWin
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : 'Close the selected application
'---------------------------------------------------------------------------------------
Dim dummy

   On Error GoTo KillWin_Error

10        dummy = sendmessagebystring(hwnd, WM_CLOSE, 0, 0)
          'If frmcheck.chkFound = 1 Then
              'Raise an exception
          '    RaiseException EXCEPTION_ACCESS_VIOLATION, 0, 0, 0
          'End If

   On Error GoTo 0
   Exit Sub

KillWin_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure KillWin of Módulo modAntiDebugg in Line " & Erl& & vbNewLine)
End Sub
