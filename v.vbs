Option Explicit

Const POP_MSG = "PopMessage.exe"
if ProcessCount(POP_MSG) >= 10 then
  WScript.Quit
end if

Dim Args

Dim strScriptPath
strScriptPath = Replace(WScript.ScriptFullName,WScript.ScriptName,"")

Dim popMessagePath
popMessagePath = strScriptPath&"PopMessage.exe"

Dim WSH
Set WSH = Wscript.CreateObject("Wscript.Shell")

Set Args = WScript.Arguments
'パラメータ数チェック
If Args.Count < 1 Then
  WSH.Run popMessagePath&" /t:ERROR /i:16 /w:3600 引数が指定されていません\n"&FormatDateTime(Now, 4), 1, false
  WScript.Quit
End If

Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(Args(0)) = False Then
  'ファイル存在チェック
  WSH.Run popMessagePath&" /t:ERROR /i:16 /w:3600 ファイルが存在しません\n"&FormatDateTime(Now, 4), 1, false
  WScript.Quit
End If
If LCase(fso.GetExtensionName(Args(0))) <> "eml" Then
  '拡張子チェック
  WSH.Run popMessagePath&" /t:ERROR /i:16 /w:3600 ファイルがEML形式ではありません\n"&FormatDateTime(Now, 4), 1, false
  WScript.Quit
End If

Dim msg
Set msg = GetMessage(Args(0))

Dim popupBody
If Args.Count =>4 Then
  Dim i
  For i = 1 to Len(Args(3))
    Select Case Mid(Args(3),i,1)
      Case "T"
        popupBody = popupBody & "To:" & msg.To & "\n"
      case "F"
        popupBody = popupBody & "From:" & msg.From & "\n"
      case "C"
        If Len(msg.CC) > 0 then
          popupBody = popupBody & "CC:" & msg.CC & "\n"
        End If
      case "B"
        If Len(msg.BCC) > 0 then
          popupBody = popupBody & "BCC:" & msg.BCC & "\n"
        End If
      case "A"
        popupBody = popupBody & Left(msg.TextBody, 500) & "\n"
    End Select
  Next
Else
  popupBody = msg.TextBody
End If

Dim optionCommand
optionCommand = "/t:""" & msg.Subject & """"
If Args.Count =>2 Then
optionCommand = optionCommand&" /w:"&Args(1)
End If
If Args.Count =>3 Then
optionCommand = optionCommand&" /i:"&Args(2)
End If

WSH.Run popMessagePath&" """&popupBody&""" "&optionCommand, 1, false

Private Function GetMessage(ByVal FilePath)
  'emlファイルからMessage取得
  Dim stm
  Dim msg
  Set stm = CreateObject("ADODB.Stream")
  Set msg = CreateObject("CDO.Message")
  stm.Open
  stm.LoadFromFile FilePath
  msg.DataSource.OpenObject stm, "_Stream"
  stm.Close
  Set GetMessage = msg
End Function

Function ProcessCount(ProcessName)
    Dim Service,QfeSet, Qfe, r
    Set Service = WScript.CreateObject("WbemScripting.SWbemLocator").ConnectServer
    Set QfeSet = Service.ExecQuery("Select * From Win32_Process Where Caption='" & ProcessName & "'")
    r = 0
    for each Qfe in QfeSet
      r = r+1
    next
    ProcessCount = r
End Function