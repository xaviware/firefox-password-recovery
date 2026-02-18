Attribute VB_Name = "modLang"
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : modLang
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Modulo para Manejo de Idioma de Interfaz
'---------------------------------------------------------------------------------------
Global strLngFile As String

Sub LoadFrmLng(frm As Form, Index As Integer)
'---------------------------------------------------------------------------------------
' Procedure : LoadFrmLng
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : 'Javier Orellana 14/08/2004 17:00 Hrs.
'             'Carga el Idioma al Formulario
'---------------------------------------------------------------------------------------
Dim ctlCtrl As Control
Dim strTipo As String
Dim strAux As String
Dim intI As Integer

    On Error Resume Next
    strLngFile = App.Path & "\" & frmMain.mnuLang(Index).Caption & ".lng"
    frmMain.mnuLang(Index).Checked = True
    For intI = 0 To MAX_LANGUAGE Step 1
        If intI <> Index Then
            frmMain.mnuLang(intI).Checked = False
        End If
    Next intI
 
    For Each ctlCtrl In frm.Controls
        strTipo = TypeName(ctlCtrl)
        If strTipo = "Label" Or strTipo = "Menu" Or strTipo = "CommandButton" Or strTipo = "Frame" Then
            strAux = ReadINI(strLngFile, ctlCtrl.Name, "Caption")
            If Len(Trim(strAux)) <> 0 Then
                ctlCtrl.Caption = Replace(strAux, "<APP/>", AppName)
            End If
            
            'JAOO 20090222 - Incluir ToolTipText de Botones
            strAux = ReadINI(strLngFile, ctlCtrl.Name, "ToolTipText")
            If Len(Trim(strAux)) <> 0 Then
                ctlCtrl.ToolTipText = Replace(strAux, "<APP/>", AppName)
            End If
        End If
    Next
    
    Call LoadMsgLng(Index)
End Sub

Sub LoadMsgLng(Index As Integer)
'---------------------------------------------------------------------------------------
' Procedure : LoadMsgLng
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : 'Javier Orellana 16/08/2004 11:06 Hrs.
'             'Carga los mensajes de la aplicaciónn
'---------------------------------------------------------------------------------------
Dim strAux As String
Dim strLngFile As String

10       On Error GoTo LoadMsgLng_Error

20        strLngFile = App.Path & "\" & frmMain.mnuLang(Index).Caption & ".lng"
          
          'Cargo los por defecto
          
50        strAux = ReadINI(strLngFile, "MSG", "MSGREGISTERED")
60        If Len(Trim(strAux)) <> 0 Then MSGREGISTERED = Replace(strAux, "<APP/>", AppName)
          
70        strAux = ReadINI(strLngFile, "MSG", "MSGERRINVALIDKEY")
80        If Len(Trim(strAux)) <> 0 Then MSGERRINVALIDKEY = strAux
          
110       strAux = ReadINI(strLngFile, "MSG", "MSGPWDNOTSTORED")
120       If Len(Trim(strAux)) <> 0 Then MSGPWDNOTSTORED = Replace(strAux, "<APP/>", AppName)

130       strAux = ReadINI(strLngFile, "MSG", "MSGPWDFOUND")
140       If Len(Trim(strAux)) <> 0 Then MSGPWDFOUND = Replace(strAux, "<APP/>", AppName)

'JAOO 20091226 : Se agregan los mensajes especificos para este programa

150       strAux = ReadINI(strLngFile, "MSG", "MSGUSR")
160       If Len(Trim(strAux)) <> 0 Then MSGUSR = Replace(strAux, "<APP/>", AppName)

170       strAux = ReadINI(strLngFile, "MSG", "MSGPWD")
180       If Len(Trim(strAux)) <> 0 Then MSGPWD = Replace(strAux, "<APP/>", AppName)

190       strAux = ReadINI(strLngFile, "MSG", "MSGWARRANTY")
200       If Len(Trim(strAux)) <> 0 Then MSGWARRANTY = Replace(strAux, "<APP/>", AppName)

210      On Error GoTo 0
220      Exit Sub

LoadMsgLng_Error:
230       WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure LoadMsgLng of Módulo modLang in Line " & Erl& & vbNewLine)
End Sub

Sub LoadLngFiles(strPath As String)
'XaviWare(c). 2004' Javier Orellana
'Carga los Archivos de Idioma al Menu
Dim strFile As String
Dim intCont As Integer
Dim intI As Integer

    On Error Resume Next
    intCont = 0
    strFile = Dir(strPath & "*.lng", vbArchive)
    Do While strFile <> ""
        frmMain.mnuLang(intCont).Caption = gLetraCapital(Mid(strFile, 1, (Len(strFile) - 4)))
        intCont = intCont + 1
        strFile = Dir()
    Loop
    
    'Visible False, para los no asignados
    For intI = intCont To MAX_LANGUAGE Step 1
        frmMain.mnuLang(intI).Visible = False
    Next intI
End Sub

Function getCfgLngIndex() As String
'---------------------------------------------------------------------------------------
' Procedure : getCfgLngIndex
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Obtiene Indice de Idioma
'---------------------------------------------------------------------------------------

   On Error GoTo getCfgLngIndex_Error

10        getCfgLngIndex = ReadINI(App.Path & "\config.cfg", "Idioma", "Index")

   On Error GoTo 0
   Exit Function

getCfgLngIndex_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure getCfgLngIndex of Módulo modLang in Line " & Erl& & vbNewLine)
End Function

Sub SetCfgLngIndex(Index As Integer)
'---------------------------------------------------------------------------------------
' Procedure : SetCfgLngIndex
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Setea Indice de Idioma
'---------------------------------------------------------------------------------------

   On Error GoTo SetCfgLngIndex_Error

10        Call WriteINI(App.Path & "\config.cfg", "Idioma", "Index", Str(Index))

   On Error GoTo 0
   Exit Sub

SetCfgLngIndex_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure SetCfgLngIndex of Módulo modLang in Line " & Erl& & vbNewLine)
End Sub
