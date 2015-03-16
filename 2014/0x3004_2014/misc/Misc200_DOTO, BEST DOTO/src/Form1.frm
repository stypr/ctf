VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   855
      Left            =   480
      TabIndex        =   0
      Top             =   600
      Width           =   2295
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Dim winhttp As New winhttp.WinHttpRequest
    Dim no$, att() As Variant, trial$, dump$
    On Error GoTo GiveMeFlag
    att = Array("50", "125", "115", "100", "50", "150", "150", "150", "175", "225", "250", "450", "200", "325", "350", "450", "470", "485", "500", "525", "500", "600", "800", "875", "2250", "2670", "2700", "2700", "2150", "2600", "2950", "3000", "2125", "2200", "2225", "3300", "1850", "1900", "2050", "2050", "275", "875", "875", "1000", "1750", "3300", "5050", "6200", "135", "200", "250", "325", "550", "1450", "1350", "1400")
    'MsgBox att(46)
    'Exit Sub
    winhttp.Open "GET", "http://challenges.wargame.vn/200-doto_8a89b5cb130e8e18259b1ec13595c39c/"
    winhttp.SetRequestHeader "Cookie", "PHPSESSID=givemeleflag"
    winhttp.Send
    dump = winhttp.ResponseText
    trial = Split(Split(winhttp.ResponseText, " TIMES REMAINING!")(0), "<body>")(1)
    no = Split(Split(winhttp.ResponseText, "<img src='items/")(1), ".png' />")(0)
    Form1.Caption = trial
    On Error Resume Next
    dump = att(no)
    If dump = vbNullString Or dump = 0 Then
        dump = 2150
    End If
    winhttp.Open "POST", "http://challenges.wargame.vn/200-doto_8a89b5cb130e8e18259b1ec13595c39c/"
    winhttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    winhttp.SetRequestHeader "Cookie", "PHPSESSID=givemele_flag"
    winhttp.Send "gold=" & att(no)
    winhttp.WaitForResponse
    Exit Sub
GiveMeFlag:
        MsgBox winhttp.ResponseText
        
End Sub
