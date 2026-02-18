VERSION 5.00
Begin VB.Form frmAbout 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acerca de MiApl"
   ClientHeight    =   5715
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6165
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5715
   ScaleWidth      =   6165
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      BackColor       =   &H00FFFFFF&
      Cancel          =   -1  'True
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   345
      Left            =   4560
      TabIndex        =   0
      Top             =   5280
      Width           =   1500
   End
   Begin VB.Image ImgCabeceraEnglish 
      Height          =   1080
      Left            =   0
      Picture         =   "frmAbout.frx":0CCA
      Top             =   0
      Width           =   6255
   End
   Begin VB.Image ImgCabeceraSpanish 
      Height          =   1080
      Left            =   0
      Picture         =   "frmAbout.frx":16D2E
      Top             =   0
      Width           =   6255
   End
   Begin VB.Label lblDesarrolladoPor 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Desarrollado por :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   1680
      TabIndex        =   10
      Top             =   2640
      Width           =   4605
   End
   Begin VB.Line Line 
      X1              =   120
      X2              =   6000
      Y1              =   3840
      Y2              =   3840
   End
   Begin VB.Label lblDisclaimer 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   1185
      Left            =   120
      TabIndex        =   9
      Top             =   3960
      Width           =   5895
   End
   Begin VB.Label lblVersion 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Versión"
      Height          =   225
      Left            =   1680
      TabIndex        =   8
      Top             =   1440
      Width           =   4125
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00FFFFFF&
      BorderWidth     =   2
      Index           =   0
      X1              =   120
      X2              =   6000
      Y1              =   3840
      Y2              =   3840
   End
   Begin VB.Label lblTitle 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Título de la aplicación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   1680
      TabIndex        =   7
      Top             =   1200
      Width           =   4245
   End
   Begin VB.Label lblDescription 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Mozilla Firefox Password Recovery"
      ForeColor       =   &H00000000&
      Height          =   930
      Left            =   1680
      TabIndex        =   6
      Top             =   1680
      Width           =   4245
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      Caption         =   "Javier Orellana (XaviWare) - "
      Height          =   225
      Left            =   1560
      TabIndex        =   5
      Top             =   2880
      Width           =   2205
   End
   Begin VB.Image Image 
      Height          =   1560
      Index           =   0
      Left            =   120
      Picture         =   "frmAbout.frx":2CD90
      Stretch         =   -1  'True
      Top             =   1200
      Width           =   1440
   End
   Begin VB.Label lblDev 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Desarrollador de Software"
      Height          =   255
      Left            =   3840
      TabIndex        =   4
      Top             =   2880
      Width           =   2175
   End
   Begin VB.Label lblTrans 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Traductora de Interfaz"
      Height          =   255
      Left            =   3720
      TabIndex        =   3
      Top             =   3360
      Width           =   2175
   End
   Begin VB.Label lblTranslator 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      Caption         =   "Pamela Ubeda - "
      ForeColor       =   &H00C00000&
      Height          =   225
      Left            =   0
      MouseIcon       =   "frmAbout.frx":32EDA
      MousePointer    =   99  'Custom
      TabIndex        =   2
      Top             =   3360
      Width           =   3645
   End
   Begin VB.Label lblColaborador 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Colaboradores :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   240
      Left            =   1680
      TabIndex        =   1
      Top             =   3120
      Width           =   4605
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'---------------------------------------------------------------------------------------
' Module    : frmAbout
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Acerca de ...
'---------------------------------------------------------------------------------------

Private Sub cmdOK_Click()
'---------------------------------------------------------------------------------------
' Procedure : cmdOK_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------

   On Error GoTo cmdOK_Click_Error

10      Unload Me

   On Error GoTo 0
   Exit Sub

cmdOK_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure cmdOK_Click of Formulario frmAbout in Line " & Erl& & vbNewLine)
End Sub

Private Sub Form_Load()
'---------------------------------------------------------------------------------------
' Procedure : Form_Load
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : Manejador de Error
'---------------------------------------------------------------------------------------

Dim strIndex As String
Dim strTraductor As String
          
   On Error GoTo Form_Load_Error
   
    'JAOO 20091104 : cabecera según el idioma correspondiente
1     If IsSpanish Then
2         Me.ImgCabeceraSpanish.Visible = True
3         Me.ImgCabeceraEnglish.Visible = False
4     Else
5         Me.ImgCabeceraSpanish.Visible = False
6         Me.ImgCabeceraEnglish.Visible = True
7     End If

10        strIndex = getCfgLngIndex
20        If strIndex <> "" Then
30            Call LoadFrmLng(Me, Val(strIndex))
40        End If

50        Me.Caption = AppName
60        lblVersion.Caption = "v." & App.Major & "." & App.Minor & "." & App.Revision & " Shareware"
70        lblTitle.Caption = AppName
          
          'Cargo al Traductor
80        strTraductor = ReadINI(modLang.strLngFile, "GralInfo", "TranslatorName")
90        Me.lblTranslator = strTraductor & " -"

   On Error GoTo 0
   Exit Sub

Form_Load_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure Form_Load of Formulario frmAbout in Line " & Erl& & vbNewLine)
End Sub

Private Sub lblTranslator_Click()
'---------------------------------------------------------------------------------------
' Procedure : lblTranslator_Click
' Author    : Administrador - JAOO
' Date      : 20/01/2008
' Purpose   : 'Javier Orellana - 02/10/2006 21:55 hrs.
'---------------------------------------------------------------------------------------
Dim strTransWeb As String
Dim strTransEmail As String

   On Error GoTo lblTranslator_Click_Error

10        strTransWeb = ReadINI(modLang.strLngFile, "GralInfo", "TranslatorURL")
20        strTransEmail = ReadINI(modLang.strLngFile, "GralInfo", "TranslatorEmail")
          
30        If Trim(strTransWeb) <> Empty Then
40            GoToInternet Me, strTransWeb, Normal
50        Else
60            If Trim(strTransEmail) <> Empty Then
70                GoToInternet Me, "mailto:" & strTransEmail, Normal
80            End If
90        End If

   On Error GoTo 0
   Exit Sub

lblTranslator_Click_Error:
    WriteLogToFile (Format(Now(), "yyyy-mm-dd hh:mm:ss") & " - Error " & Err.Number & " (" & Err.Description & ") in procedure lblTranslator_Click of Formulario frmAbout in Line " & Erl& & vbNewLine)
End Sub
