VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "msmask32.ocx"
Begin VB.Form frmRegistro 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mozilla Firefox Password Recovery"
   ClientHeight    =   4620
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6180
   Icon            =   "frmRegistro.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4620
   ScaleWidth      =   6180
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame frameReg 
      Caption         =   "Enter your Key of Registration"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   120
      TabIndex        =   2
      Top             =   1800
      Width           =   6015
      Begin VB.CommandButton cmdBuyNow 
         Height          =   735
         Left            =   4680
         Picture         =   "frmRegistro.frx":0CCA
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   240
         Width           =   1215
      End
      Begin MSMask.MaskEdBox mskReg 
         Height          =   375
         Left            =   1883
         TabIndex        =   3
         Top             =   360
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   661
         _Version        =   393216
         AutoTab         =   -1  'True
         MaxLength       =   24
         Mask            =   ">AAAA-AAAA-AAAA-AAAA-AAAA"
         PromptChar      =   "_"
      End
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "Accept"
      Default         =   -1  'True
      Height          =   345
      Left            =   2880
      TabIndex        =   1
      Top             =   4200
      Width           =   1500
   End
   Begin VB.Timer Timer 
      Interval        =   100
      Left            =   120
      Top             =   3600
   End
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   345
      Left            =   4560
      TabIndex        =   0
      Top             =   4200
      Width           =   1500
   End
   Begin VB.Image ImgCabeceraEnglish 
      Height          =   1080
      Left            =   0
      Picture         =   "frmRegistro.frx":1014
      Top             =   0
      Width           =   6255
   End
   Begin VB.Label lblGracias 
      Caption         =   "Thank you for choosing XaviWare Software. Register today to enable all functionalities of   "
      Height          =   495
      Left            =   120
      TabIndex        =   7
      Top             =   1200
      Width           =   6015
   End
   Begin VB.Label lblPorFavor 
      Caption         =   "Please, send an email to :"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   3000
      Width           =   6015
   End
   Begin VB.Label lblMail 
      Caption         =   "xaviware@xaviware.cl"
      ForeColor       =   &H00FF0000&
      Height          =   255
      Left            =   120
      MouseIcon       =   "frmRegistro.frx":17078
      MousePointer    =   99  'Custom
      TabIndex        =   5
      Top             =   3240
      Width           =   1695
   End
   Begin VB.Label lblRegEmail 
      Height          =   855
      Left            =   1800
      TabIndex        =   4
      Top             =   3240
      Width           =   4215
   End
   Begin VB.Image ImgCabeceraSpanish 
      Height          =   1080
      Left            =   0
      Picture         =   "frmRegistro.frx":17382
      Top             =   0
      Width           =   6255
   End
End
Attribute VB_Name = "frmRegistro"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : frmRegistro
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Formulario de Registro
'---------------------------------------------------------------------------------------

Private Sub cmdBuyNow_Click()
'---------------------------------------------------------------------------------------
' Procedure : cmdBuyNow_Click
' Author    : Javier Orellana - XaviWare Software Ltda.
' Date      : 04/11/2009
' Purpose   : Envia a la página de compra del producto
'---------------------------------------------------------------------------------------
'
    frmMain.mnuCompra_Click
End Sub

Private Sub cmdCancel_Click()
'---------------------------------------------------------------------------------------
' Procedure : cmdCancel_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Cancelar
'---------------------------------------------------------------------------------------

   On Error GoTo cmdCancel_Click_Error

10        blnRegistrado = False
20        Unload Me

   On Error GoTo 0
   Exit Sub

cmdCancel_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure cmdCancel_Click of Formulario frmRegistro in Line " & Erl& & vbNewLine)
End Sub
Private Sub cmdOK_Click()
'---------------------------------------------------------------------------------------
' Procedure : cmdOK_Click
' Author    : Administrador - JAOO
' Date      : 03/12/2007
' Purpose   : Actualización Manejador de Error
'---------------------------------------------------------------------------------------
'Javier Orellana
'Modificación Para Mozilla Firefox Password Recovery   14/02/2010 02:22 Hrs.
'---------------------------------------------------------------------------------------
Dim strAux As String
Dim strReg As String

   On Error GoTo cmdOK_Click_Error

10        blnRegistrado = False
          
20        strAux = Mid(mskReg.Text, 6, 4)
30        If Not Equals(Left(strAux, 1), Mid(strAux, 2, 1), Mid(strAux, 3, 1), Right(strAux, 1)) Then
40            If Left(strAux, 1) = "A" Then
50                strReg = strAux & "-" & KeyGen(Left(strAux, 2), Right(strAux, 2), 3)
55                strReg = Mid(strReg, 16, 5) & Left(strReg, 15) & Right(strReg, 4)
60                If strReg = mskReg.Text Then
70                    blnRegistrado = True
80                End If
90            End If
100       End If
          
110       If blnRegistrado Then
120           Call WriteINI(App.Path & "\config.cfg", "Registro", "Clave", strReg)
130           MsgBox MSGREGISTERED, vbInformation, AppName
140           Unload Me
150       Else
160           MsgBox MSGERRINVALIDKEY, vbCritical, AppName
170       End If

   On Error GoTo 0
   Exit Sub

cmdOK_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure cmdOK_Click of Formulario frmRegistro in Line " & Erl& & vbNewLine)
End Sub

Private Sub Form_Load()
'---------------------------------------------------------------------------------------
' Procedure : Form_Load
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Load
'---------------------------------------------------------------------------------------
Dim strIndex As String
          
   On Error GoTo Form_Load_Error
   
    'JAOO 20091104 : cabecera según el idioma correspondiente
1     If IsSpanish Then
2         Me.ImgCabeceraSpanish.Visible = True
3         Me.ImgCabeceraEnglish.Visible = False
4     Else
5         Me.ImgCabeceraSpanish.Visible = False
6         Me.ImgCabeceraEnglish.Visible = True
7     End If

10        blnRegistrado = False
          
20        strIndex = getCfgLngIndex
30        If strIndex <> "" Then
40            Call LoadFrmLng(Me, Val(strIndex))
50        End If

   On Error GoTo 0
   Exit Sub

Form_Load_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure Form_Load of Formulario frmRegistro in Line " & Erl& & vbNewLine)
End Sub

Private Sub lblMail_Click()
'---------------------------------------------------------------------------------------
' Procedure : lblMail_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : e-Mail
'---------------------------------------------------------------------------------------

   On Error GoTo lblMail_Click_Error

10        ShellExecute Me.hwnd, vbNullString, "mailto:xaviware@xaviware.cl?SUBJECT=Register MF", vbNullString, "C:\", SW_SHOWNORMAL

   On Error GoTo 0
   Exit Sub

lblMail_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure lblMail_Click of Formulario frmRegistro in Line " & Erl& & vbNewLine)
End Sub

Private Sub Timer_Timer()
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
