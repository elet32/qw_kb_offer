RegRead, Flgss, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\i8042prt, Start
if Flgss = 3
{
  Flgs = 有効
}
Else
{
  Flgs = 無効
}

Gui, 1:default
Gui, Add, Text, , 現在の設定 : %Flgs% ( %Flgss% )
Gui, Add, Button, gNarrow, 本体キーボードを無効化
Gui, Add, Button, gArrow, 本体キーボードを有効化
Gui, Add, Checkbox, vRbt, 適用と同時に再起動しちゃう
Gui, Add, Text, , ※設定は、再起動後に適用されます。

Gui, Show
return 


Arrow:
  GUI, Submit
  RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\i8042prt, Start, 3
  if A_LastError != 0
  {
    msgbox, 書き換え失敗！ regファイルで書き換えます。
    RunWait, reg\master_ketboard_on.reg
  }
;  msgbox, on!
  if Rbt = 1
  {
    Gosub, Reboot
  }
  ExitApp
return

Narrow:
  GUI, Submit
  RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Services\i8042prt, Start, 4
  if A_LastError != 0
  {
    msgbox, 書き換え失敗！ regファイルで書き換えます。
    RunWait, reg\master_ketboard_off.reg
  }
;  msgbox, off!
  if Rbt = 1
  {
    Gosub, Reboot
  }
  ExitApp
return

Guiclose:
GUI, Hide
ExitApp
return

Reboot:
    GUI, Hide
    Shutdown, 2
return
