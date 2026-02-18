VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mozilla Firefox Password Recovery"
   ClientHeight    =   3435
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   6825
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   ScaleHeight     =   3435
   ScaleWidth      =   6825
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtResult 
      Height          =   2415
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   840
      Width           =   6495
   End
   Begin VB.CommandButton cmdBuyNow 
      Height          =   735
      Left            =   1440
      Picture         =   "frmMain.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   0
      Width           =   1215
   End
   Begin VB.CommandButton cmdSalir 
      Height          =   735
      Left            =   720
      Picture         =   "frmMain.frx":1014
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   0
      Width           =   735
   End
   Begin VB.CommandButton cmdObtener 
      Height          =   735
      Left            =   0
      Picture         =   "frmMain.frx":18DE
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   0
      Width           =   735
   End
   Begin VB.Timer Timer 
      Interval        =   100
      Left            =   2760
      Top             =   360
   End
   Begin VB.Label lblRegistrado 
      Caption         =   "Software Registrado"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2760
      TabIndex        =   5
      Top             =   120
      Width           =   3855
   End
   Begin VB.Label lblLnkWeb 
      Caption         =   "http://www.xaviware.cl"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   4800
      MouseIcon       =   "frmMain.frx":21A8
      MousePointer    =   99  'Custom
      TabIndex        =   4
      Top             =   480
      Width           =   1815
   End
   Begin VB.Menu mnuOpciones 
      Caption         =   "&Opciones"
      Begin VB.Menu mnuIdioma 
         Caption         =   "&Idioma"
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   0
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   1
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   2
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   3
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   4
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   5
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   6
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   7
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   8
         End
         Begin VB.Menu mnuLang 
            Caption         =   ""
            Index           =   9
         End
      End
      Begin VB.Menu mnuProducts 
         Caption         =   "Otros Productos"
         Begin VB.Menu mnuWebbrowsers 
            Caption         =   "Web Browsers"
            Begin VB.Menu mnuPWDIE 
               Caption         =   "Internet Explorer Password Recovery Utility"
            End
            Begin VB.Menu mnuPWDCHR 
               Caption         =   "Google Chrome Password Recovery"
            End
            Begin VB.Menu mnuCAPE 
               Caption         =   "Content Advisor Password Eliminator"
            End
            Begin VB.Menu mnuPWDSafari 
               Caption         =   "Safari Password Recovery"
            End
            Begin VB.Menu mnulin9 
               Caption         =   "-"
            End
            Begin VB.Menu mnuPWDFLOCK 
               Caption         =   "Flock Password Recovery"
            End
            Begin VB.Menu mnuPWDCHRPLUS 
               Caption         =   "ChromePlus Password Recovery"
            End
            Begin VB.Menu mnuPWDRAGON 
               Caption         =   "Comodo Dragon Password Recovery"
            End
            Begin VB.Menu mnuRockPWD 
               Caption         =   "RockMelt Password Recovery"
            End
            Begin VB.Menu mnuPWDIRON 
               Caption         =   "SRWare Iron Password Recovery"
            End
         End
         Begin VB.Menu mnuG1 
            Caption         =   "-"
         End
         Begin VB.Menu mnuPWDMSN 
            Caption         =   "Windows Live Messenger Password Recovery"
         End
         Begin VB.Menu mnuPWDGTALK 
            Caption         =   "Google Talk Password Decryptor"
         End
         Begin VB.Menu pwdTRILLIAN 
            Caption         =   "Trillian and Trillian Astra Password Recovery"
         End
         Begin VB.Menu pwdPIDGIN 
            Caption         =   "Pidgin Password Recovery"
         End
         Begin VB.Menu mnuG2 
            Caption         =   "-"
         End
         Begin VB.Menu mnuPWDFB 
            Caption         =   "Facebook Password Recovery"
         End
         Begin VB.Menu mnuPWDTW 
            Caption         =   "Twitter Password Recovery"
         End
         Begin VB.Menu mnuPWDGMAIL 
            Caption         =   "Google Mail Password Recovery"
         End
         Begin VB.Menu mnuG4 
            Caption         =   "-"
         End
         Begin VB.Menu mnuPWDMDB 
            Caption         =   "Password Recovery .MDB"
         End
         Begin VB.Menu mnuPWDXLS 
            Caption         =   "Password Eliminator .XLS"
         End
         Begin VB.Menu mnuRRPDF 
            Caption         =   "Restrictions Remover .PDF"
         End
         Begin VB.Menu mnuG3 
            Caption         =   "-"
         End
         Begin VB.Menu mnuPWDFZ 
            Caption         =   "FileZilla Password Recovery Tool"
         End
      End
   End
   Begin VB.Menu mnuAyuda 
      Caption         =   "&Ayuda"
      Begin VB.Menu mnuAyudaF1 
         Caption         =   "Ayuda"
         Shortcut        =   {F1}
      End
      Begin VB.Menu mnuAcercaDe 
         Caption         =   "A&cerca de ..."
      End
      Begin VB.Menu mnulin1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCompra 
         Caption         =   "Compre en Línea"
      End
      Begin VB.Menu mnuRegistro 
         Caption         =   "Registrar..."
      End
      Begin VB.Menu mnulin2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFeedBack 
         Caption         =   "Enviar Sugerencia"
      End
      Begin VB.Menu mnuGoToWeb 
         Caption         =   "Ir a la Web de Windows Live Messenger Password Recovery"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'---------------------------------------------------------------------------------------
' Module    : frmMain
' Author    : Administrador - JAOO
' Date      : 22/02/2009
' Purpose   : Recuperardor de Contraseñas de MSN Messenger
'---------------------------------------------------------------------------------------
Option Explicit

Private Sub cmdBuyNow_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuCompra_Click
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 20/01/2008
' Purpose   : 'Redireccionar al formulario de compra
'---------------------------------------------------------------------------------------

    Call mnuCompra_Click
End Sub

Private Sub cmdObtener_Click()
'---------------------------------------------------------------------------------------
' Procedure : cmdObtener_Click
' Author    : Administrador - JAOO
' Date      : 09/02/2010
' Purpose   : Obtener las Contraseñas almacenadas de Mozilla Firefox 3.5.x
'---------------------------------------------------------------------------------------
Dim c As New cFFPD
Dim strResult As String
Dim strMFPass As String

    On Error GoTo cmdObtener_Click_Error
   
    Screen.MousePointer = vbHourglass
   
    strMFPass = c.Enumerate 'Recupera las contraseñas de Mozilla Firefox
   
    strResult = Empty
    
    'si hay claves almacenadas y no esta registrado
    If (strMFPass <> Empty) And (Not blnRegistrado) Then
        strResult = strResult + MSGPWDFOUND + vbNewLine + vbNewLine
    End If
    
    'si no hay claves almacenadas
    If strMFPass = Empty Then
        strResult = strResult + MSGPWDNOTSTORED + vbNewLine + vbNewLine
    End If
    
    'si no esta registrado y hay contraseña
    If (Not blnRegistrado) And (strMFPass <> Empty) Then
        strResult = strResult + MSGWARRANTY + vbNewLine + vbNewLine
        strResult = strResult + strMFPass
    End If
    
    'si esta registrado
    If blnRegistrado Then
        strResult = strResult + strMFPass
    End If
   
    Me.txtResult.Text = strResult
   
    Screen.MousePointer = vbDefault

    On Error GoTo 0
    Exit Sub

cmdObtener_Click_Error:

    MsgBox "Error " & Err.Number & " (" & Err.Description & ") in procedure cmdObtener_Click of Formulario frmMain"
    Screen.MousePointer = vbDefault 'JAOO 20100309 - Aplicar en todos los programas
End Sub

Private Sub cmdSalir_Click()
    End
End Sub

Public Sub Form_Load()
'---------------------------------------------------------------------------------------
' Procedure : Form_Load
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Load
'---------------------------------------------------------------------------------------
Dim strIndex  As String
          
   On Error GoTo Form_Load_Error

10        Call LoadLngFiles(App.Path & "\")
20        strIndex = getCfgLngIndex
30        If strIndex <> "" Then
40            Call LoadFrmLng(Me, Val(strIndex))
50        Else
60            Call LoadFrmLng(Me, 1)
70        End If

          'Chequea si esta Registrado
110       Call CheckRegister
120       Call Me.VisibleByRegister

   On Error GoTo 0
   Exit Sub

Form_Load_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure Form_Load of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Public Sub VisibleByRegister()
'---------------------------------------------------------------------------------------
' Procedure : VisibleByRegister
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 04/11/2009
' Purpose   : Habilita o Desabilita opciones según si el software esta registrado o no
'---------------------------------------------------------------------------------------
'
120       If blnRegistrado Then
130           lblRegistrado.Visible = True
131           Me.cmdBuyNow.Visible = False
    'JAOO 20091104
132           Me.mnuRegistro.Visible = False
133           Me.mnuCompra.Visible = False
134           Me.mnulin2.Visible = False
140       Else
150           lblRegistrado.Visible = False
151           Me.cmdBuyNow.Visible = True
    'JAOO 20091104
152           Me.mnuRegistro.Visible = True
153           Me.mnuCompra.Visible = True
154           Me.mnulin2.Visible = True
160       End If
End Sub

Private Sub lblLnkWeb_Click()
'---------------------------------------------------------------------------------------
' Procedure : lblLnkWeb_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------

   On Error GoTo lblLnkWeb_Click_Error
   
    'JAOO 20091104: Visita la web del producto en el idioma correspondiente
1    If IsSpanish Then
2         GoToInternet Me, "http://www.xaviware.cl/pwdmff_es.aspx", Normal
3    Else
10        GoToInternet Me, "http://www.xaviware.cl/pwdmff.aspx", Normal
11   End If

   On Error GoTo 0
   Exit Sub

lblLnkWeb_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure lblLnkWeb_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuAcercaDe_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuAcercaDe_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------

   On Error GoTo mnuAcercaDe_Click_Error

10        frmAbout.Show vbModal

   On Error GoTo 0
   Exit Sub

mnuAcercaDe_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure mnuAcercaDe_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuAyudaF1_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuAyudaF1_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------

   On Error GoTo mnuAyudaF1_Click_Error
   
    'JAOO 20091104: se incluye la ayuda según el idioma
1    If IsSpanish Then
5         ShellExecute Me.hwnd, "Open", App.Path & "\ayuda.htm", "", "", Normal
7    Else
10        ShellExecute Me.hwnd, "Open", App.Path & "\help.htm", "", "", Normal
12   End If

   On Error GoTo 0
   Exit Sub

mnuAyudaF1_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure mnuAyudaF1_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuCAPE_Click()
    Call GOTOWeb("http://www.xaviware.com/cape_es.aspx", "http://www.xaviware.com/cape.aspx")
End Sub

Public Sub mnuCompra_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuCompra_Click
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 20/01/2008
' Purpose   : 'Redireccionar al formulario de compra
'---------------------------------------------------------------------------------------
   On Error GoTo mnuCompra_Click_Error
   
   'JAOO 20091104 : redirecciona según el idioma
   If IsSpanish Then
        GoToInternet Me, "http://www.xaviware.cl/purchase_es.aspx?productid=pwdmff", Normal
   Else
        GoToInternet Me, "http://www.xaviware.cl/purchase.aspx?productid=pwdmff", Normal
   End If

   On Error GoTo 0
   Exit Sub

mnuCompra_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure mnuCompra_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuFeedBack_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuFeedBack_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------
Dim strAux As String
          
   On Error GoTo mnuFeedBack_Click_Error

10        strAux = Empty
20        strAux = strAux & "mailto:support@xaviware.cl"
30        strAux = strAux & "?SUBJECT=Feedback - " & AppName
40        GoToInternet Me, strAux, Normal

   On Error GoTo 0
   Exit Sub

mnuFeedBack_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure mnuFeedBack_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuGoToWeb_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuGoToWeb_Click
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 04/11/2009
' Purpose   : Redireccionar al home del producto en el idioma correspondiente
'---------------------------------------------------------------------------------------

    Call lblLnkWeb_Click
End Sub

Private Sub mnuLang_Click(Index As Integer)
'---------------------------------------------------------------------------------------
' Procedure : mnuLang_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------
   On Error GoTo mnuLang_Click_Error

10        Call LoadFrmLng(Me, Index)
20        Call SetCfgLngIndex(Index)

   On Error GoTo 0
   Exit Sub

mnuLang_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure mnuLang_Click of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

Private Sub mnuPWDCHR_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdchr_es.aspx", "http://www.xaviware.com/pwdchr.aspx")
End Sub

Private Sub mnuPWDCHRPLUS_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdchromeplus_es.aspx", "http://www.xaviware.com/pwdchromeplus.aspx")
End Sub

Private Sub mnuPWDFB_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdfb_es.aspx", "http://www.xaviware.com/pwdfb.aspx")
End Sub

Private Sub mnuPWDFLOCK_Click()
'JAOO 20110111
    Call GOTOWeb("http://www.xaviware.com/pwdflock_es.aspx", "http://www.xaviware.com/pwdflock.aspx")
End Sub

Private Sub mnuPWDFZ_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdfz_es.aspx", "http://www.xaviware.com/pwdfz.aspx")
End Sub

Private Sub mnuPWDGMAIL_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdgmail_es.aspx", "http://www.xaviware.com/pwdgmail.aspx")
End Sub

Private Sub mnuPWDGTALK_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdgtalk_es.aspx", "http://www.xaviware.com/pwdgtalk.aspx")
End Sub

Private Sub mnuPWDIE_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdie_es.aspx", "http://www.xaviware.com/pwdie.aspx")
End Sub

Private Sub mnuPWDIRON_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdiron_es.aspx", "http://www.xaviware.com/pwdiron.aspx")
End Sub

Private Sub mnuPWDMDB_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdmdb_es.aspx", "http://www.xaviware.com/pwdmdb.aspx")
End Sub

Private Sub mnuPWDMSN_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdmsn_es.aspx", "http://www.xaviware.com/pwdmsn.aspx")
End Sub

Private Sub mnuPWDRAGON_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdragon_es.aspx", "http://www.xaviware.com/pwdragon.aspx")
End Sub

Private Sub mnuPWDSafari_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdsafari_es.aspx", "http://www.xaviware.com/pwdsafari.aspx")
End Sub

Private Sub mnuPWDTW_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdtw_es.aspx", "http://www.xaviware.com/pwdtw.aspx")
End Sub

Private Sub mnuPWDXLS_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdxls_es.aspx", "http://www.xaviware.com/pwdxls.aspx")
End Sub

Private Sub mnuRegistro_Click()
'---------------------------------------------------------------------------------------
' Procedure : mnuRegistro_Click
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 04/11/2009
' Purpose   : Llama al formulario de registro
'---------------------------------------------------------------------------------------
'
    frmRegistro.Show vbModal
    Call Me.VisibleByRegister 'debe recargar en caso de quedar registrado
End Sub

Private Sub mnuRockPWD_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdrockmelt_es.aspx", "http://www.xaviware.com/pwdrockmelt.aspx")
End Sub

Private Sub mnuRRPDF_Click()
    Call GOTOWeb("http://www.xaviware.com/rrpdf_es.aspx", "http://www.xaviware.com/rrpdf.aspx")
End Sub

Private Sub pwdPIDGIN_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdpidgin_es.aspx", "http://www.xaviware.com/pwdpidgin.aspx")
End Sub

Private Sub pwdTRILLIAN_Click()
    Call GOTOWeb("http://www.xaviware.com/pwdtrillian_es.aspx", "http://www.xaviware.com/pwdtrillian.aspx")
End Sub

Private Sub Timer_Timer()
'JAOO 20100515 - Protección Mínima
'Detección de Debuggers
Dim hwnd As Long
Dim i As Integer
    
    On Error Resume Next    'Revisa con Kernel de Win
    If IsDebuggerPresent <> 0 Then
        End
    End If
    
    'Llena el Arreglo con las ClassNames
    Call FillClassName

    'Monitorea Todas las Aplicaciones que Estan Corriendo en el
    'Entorno de Windows y Cierra Aquellas cuyos ClassNames estan
    'almacenadas en el Arreglo AppClassName
    For i = 0 To NoOfAppClassMonitored
        hwnd = AppPresent(Trim(AppClassName(i)), frmMain)
        If hwnd <> 0 Then
            KillWin hwnd
        End If
    Next i
End Sub

Public Sub GOTOWeb(url_spanish As String, url_english As String)
'---------------------------------------------------------------------------------------
' Procedure : GOTOWeb
' Author    : XaviWare
' Date      : 15-05-2010
' Purpose   :
'---------------------------------------------------------------------------------------
'
On Error GoTo GOTOWEB_Error
   
1    If IsSpanish Then
2         GoToInternet Me, url_spanish, Normal
3    Else
10        GoToInternet Me, url_english, Normal
11   End If

   On Error GoTo 0
   Exit Sub

GOTOWEB_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure GOTOWEB of Formulario frmMain in Line " & Erl& & vbNewLine)
End Sub

