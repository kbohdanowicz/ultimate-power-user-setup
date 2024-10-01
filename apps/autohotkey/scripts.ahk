
; =======================================
; =============== NOTES =================
; =======================================
; -- Expressions
; <^ -> hold LCtrl
; <! -> hold LAlt
; <+ -> hold LShift
; <# -> hold LWin
; %variable% -> Get variable value
; % expression -> Evaluate expression
; ${ -> Escape '{''
;
; -- Other
; WinGet window, ID, A
; "A" -> active window
;
; =======================================
; =============== CONFIG ================
; =======================================

; !!!!!!!!!!!!!!! TODO: Remove "could not close previous instance" prompt
; #SingleInstance Force

; Required for loop to run I guess
Persistent

; Process Close Autohotkey.exe
; Run as admin
if !A_IsAdmin {
   Run("*RunAs " (A_IsCompiled ? "" : A_AhkPath " ") Chr(34) A_ScriptFullPath Chr(34))
}

; 2 = A window's title can contain WinTitle anywhere inside it to be a match.
SetTitleMatchMode 2

; =======================================
; ========== GLOBAL CONSTANTS ===========
; =======================================

trayAhkClass := "ahk_class Shell_TrayWnd"
firefoxAhkClass := "ahk_class MozillaWindowClass"
intellijAhkClass := "ahk_class SunAwtFrame"

smoothScrollWindowName := "SmoothScroll License"
vbaWindowName := "Microsoft Visual Basic for Applications"
vscodeWindowName := "Visual Studio Code"
grimDawnExe := "ahk_exe Grim Dawn.exe"

; =======================================
; ============ DEFAULT RUN ==============
; =======================================

; ========================== GRIM DAWN ==========================
global isTeleportUiPrepared := false

loop {
	WinWait grimDawnExe
	; MsgBox "Grim Dawn started"
	isTeleportUiPrepared := false
	WinWaitClose
	; MsgBox "Grim Dawn closed"
	Sleep 300
}

; =======================================
; =========== KEY REBINDINGS ============
; =======================================

; -- Bind Capslock to Backspace
CapsLock::         Send "{Backspace}"
LCtrl  & CapsLock::Send "{Backspace}"
LAlt   & CapsLock::Send "{Backspace}"
LShift & CapsLock::Send "{Backspace}"

; -- Bind Semicolon to Colon
`;::Send "{Text}:"

; -- Bind Colon to Semicolon
:::Send "{Text};"

; -- Bind Hyphen to Underscore
; -::Send {Text}_

; -- Bind Underscore to Hyphen
; _::Send {Text}-

; -- Bind Quote to Double Quote
; '::Send {Text}"

; -- Bind Double Quote to Quote
; "::Send {Text}'

; -- Bind Tilde to single press Tilde
; LShift & `::
;    SendRaw ~1 ; '1' could be any char
;    Send {BackSpace}
; return

; -- Add space and move cursor left once after bracket opening
; ${::SendRaw {
; #If (A_PriorHotkey = "${" AND A_TimeSincePriorHotkey < 2000)
;    Space::
;       Send {Space}
;       Send {Space}
;       SendInput {Left 1}
;    return
; #If

; ; -- Automatically close smoothscroll licence window
; Loop {
; 	WinWait(smoothScrollWindowName)
; 	WinClose(smoothScrollWindowName)
; }
; =======================================
; ============== HOTKEYS ================
; =======================================


; Windows Explorer
#HotIf WinActive("ahk_class CabinetWClass")
   LWin & n::CreateNewTextFile()

   CreateNewTextFile() {
      Send "{PgUp}"     ; Force select the first file
      Send "^{Space}"	; Clear the selection
      Send "{AppsKey}"	; Menu key
      Send "w"			   ; Skip
      Send "w" 			; New
      Send "{Right} "	; Right arrow
      Send "t" 			; Create Text Document
   }
#HotIf

; OLD Hide taskbar
; xd := "ahk_id " . DllCall('GetTaskmanWindow')
; MsgBox xd
; WinHide("ahk_id {DllCall('GetTaskmanWindow')}")

; LWin & t::ToggleTaskbarVisibility()

; ToggleTaskbarVisibility() {
;    ; MsgBox "ahk_class Shell_TrayWnd"
;    if WinExist("ahk_class Shell_TrayWnd") {
;       WinHide "ahk_class Shell_TrayWnd"
;    ; } else if WinActive(trayAhkClass) {
;    ; } else if A_PriorKey == "LWin" {
;       ; MsgBox A_ThisHotkey
;       ; MsgBox A_PriorHotkey
;       ; MsgBox A_PriorKey
;       ; WinShow trayAhkClass
;    } else {
;       WinShow "ahk_class Shell_TrayWnd"
;    }
; }

; LWin & [::Run("toggle_tshokz.bat -c", , "Hide")

; LWin & ]::Run("toggle_shokz.bat -r", , "Hide")

GetActiveWindowTitle() {
   return WinGetTitle("A")
}

; #HotIf WinActive(intellijAhkClass)



; #HotIf

#HotIf WinActive(firefoxAhkClass)
   ; Hijack these hotkeys to not let firefox recognize them
	LShift & Enter::DoNothing()
   RShift & Enter::DoNothing()
	^+w::DoNothing()

	LAlt & q::ToggleFirefoxSidebar()

   DoNothing() {

   }

	Debug() {
		MsgBox "Shortcut works"
	}
	; To be used with my custom css for firefox and sidebery
	ToggleFirefoxSidebar() {
		static isSidebarVisible := false
	
		if (isSidebarVisible) {
			MoveMouseToBottom()
			isSidebarVisible := false
		} else {
			MoveMouseToBottomLeft()
			isSidebarVisible := true
		}
		
		MoveMouseToBottomLeft() {
			MouseMove 0, 1080
			Sleep 80
			MouseClick "left", 0, 1080
		}

		MoveMouseToBottom() {
			; In Sidebery the "Activate selection" key must be set to "Ctrl + Shift + Q" 
			Send "^{Q}" ; Actually it sends a Ctrl + Shift + Q
			Sleep 50
			MouseMove 960, 1080
			MouseClick "left", 960, 1080
		}
	}
#HotIf 

#HotIf WinActive("| Trello")

	<^<!<+UP::MoveCardUp()
	<^<!<+DOWN::MoveCardDown()

	MoveCardUp() {
		MoveCard("UP")	
	}

	MoveCardDown() {
		MoveCard("DOWN")	
	}

	MoveCard(direction) {
		direction := "{" . direction . "}"
		Send "e"    ; Enter edit mode 
		SendDelayed "{TAB}"  ; Unfocus title
		SendDelayed "q", 75  ; Show Saka shortcuts
		SendDelayed "q", 75  ; Open Move menu
		SendDelayed "w", 75
		SendDelayed "{TAB}"  ; Focus position menu
		SendDelayed "{TAB}"
		SendDelayed "{TAB}"
		SendDelayed "{TAB}"
		SendDelayed "{TAB}"
		SendDelayed "{TAB}"
		SendDelayed direction  ; Open Position menu
		SendDelayed direction  ; Select up or down position
		SendDelayed "{ENTER}"  ; Accept
		SendDelayed "{TAB}"  ; Accept
		SendDelayed "{ENTER}"  ; Accept
	}

	SendDelayed(key, delay := 65) {
		Sleep delay
		Send key
	}

#HotIf

; Close/minimize window shortcut
#HotIf GetKeyState("LAlt")
   ; LShift & e::MinimizeActiveWindow()

	LShift & =::RestartAudio()
	
   LShift & q::CloseActiveWindow()
   LCtrl & q::KillActiveWindow()

	RestartAudio() {
		Run "restart-audio.bat"
	}

	MinimizeActiveWindow() {
		WinMinimize GetActiveWindowTitle()
	}

	CloseActiveWindow() {
		windowTitle := GetActiveWindowTitle()
		MsgBox "Closing window"
		if (WinActive(firefoxAhkClass)) {
			return
		}
		if (InStr(windowTitle, "System Shock", true)) {
			return
		}
		
		WinClose windowTitle
	}

	KillActiveWindow() {
		MsgBox "Killing window"
		if (WinActive(firefoxAhkClass)) {
			return
		}

		Send "!{F4}"
	}
#HotIf

; ===================== GAMES =====================
#HotIf WinActive("Sid Meier's Civilization V (DX11)")
   ; Requires BorderlessGaming
   ; Works for 1920x1080 resolution
   RCtrl & End::EnableBorderless()

   EnableBorderless() {
      Click  955, 537  ; Options
      Click  932, 302  ; Video Options
      Click  791, 369  ; 1920x1080
      Click  800, 425  ; 1680x1050
      Click  708, 500  ; Apply resolution
      Click  836, 557  ; Yes
      Click  682, 364  ; 1680x1050
      Click  680, 391  ; 1920x1080
      Click  585, 492  ; Apply resolution
      Click  962, 574  ; Yes
      Click 1272, 829 ; Accept
      Click  963, 500  ; Mods
      Click 1271, 824 ; Next
   }
   
   Click(x, y) {
      MouseClick "left", x, y
      Sleep 100
   }
#HotIf
   
#HotIf WinActive("Borderlands 3")
   ; bind space to enter
#HotIf

#HotIf WinActive("Grim Dawn")
	XButton2::OpenTeleportList()
#HotIf

OpenTeleportList() {
	global isTeleportUiPrepared

	delay := 25

	Send "{F5}" ; Open dpyes window
	Sleep delay
	
	Send "{Up}" ; Select tab
	Sleep delay

	if (not isTeleportUiPrepared) {
		Send "{Right}" ; Select teleport tab
		Sleep delay

		Send "{Enter}" ; Open teleport tab
		Sleep delay
		
		Send "{Down}" ; Select "Require double click to teleport"
		Sleep delay

		Send "{Enter}" ; Uncheck "Require double click to teleport"
		Sleep delay
		
		Send "{Up}" ; Select teleport tab
		Sleep delay

		isTeleportUiPrepared := true
	}

	Send "{Down}"
	Sleep delay
	Send "{Down}"
	Sleep delay
	Send "{Down}"
	Sleep delay
	Send "{Down}"
	Sleep delay
	Send "{Enter}"
}

; -- Active Window Info
#HotIf GetKeyState("RCtrl")
   RShift & [::CopyActiveWindowTitle()
   
   RShift & p::CopyActiveWindowClass()

   RShift & i::CopyActiveWindowClass()

   RShift & =::CopyActiveWindowSize()

   RShift & ]::CopyMousePosition()

   ; LShift & Delete::MakeActiveWindowAppearMaximized()

   CopyActiveWindowTitle() {
      A_Clipboard := GetActiveWindowTitle()
		MsgBox "" . A_Clipboard
   }

	CopyWindowProcessName() {
		A_Clipboard := WinGetProcessName()
	}

   CopyActiveWindowClass() {
      A_Clipboard := WinGetClass("A")
   }

   CopyActiveWindowSize() {
      WinGetPos(&x, &y, &width, &height, &A)
      A_Clipboard := "" . x . ", " . y . ", " . width . ", " . height
   }

   CopyMousePosition() {
      MouseGetPos(&x, &y)
      A_Clipboard := "" . x . ", " . y
   }

   ; Resize window to take up the whole secondary screen with 1920x1080 resolution without maximizing the window (use with hidden taskbar)
   ; MakeActiveWindowAppearMaximized() {
   ;    windowName := WinGetTitle("A")
   ;    WinRestore %windowName%
   ;    if InStr(windowName, "Discord") {
   ;       x := 1921
   ;       y := 0
   ;       width := 1920
   ;       height := 1080
   ;    } else {
   ;       x := 1913
   ;       y := 0
   ;       width := 1933
   ;       height := 1087
   ;    }
   ;    WinMove %windowName%, , x, y, width, height
   ; }
   
   ; TODO On moving a window to another screen a via LWin + Shift + R/L Arrow make window appear maximized (set size for each display)
   ; IsWindowMaximized() {
   ;    WinGetTitle windowName, A
   ;    WinGet isMaximized, MinMax, windowName
   ;    return isMaximized
   ; }
#HotIf

; Hide mouse cursor and disable its ability to move
; ScrollLock::
; {
;    if my_flag := !my_flag {
;       MouseGetPos, , , hwnd
;       Gui Cursor:+Owner%hwnd%
;       BlockInput MouseMove
;       DllCall("ShowCursor", Int, 0)
;    } else {
;       BlockInput MouseMoveOff
;       DllCall("ShowCursor", Int, 1)
;    }
; }

; LCtrl & Enter::MouseClick left

#HotIf WinActive(vscodeWindowName)
   LCtrl & 1::ExecuteVbaScript()
   ExecuteVbaScript() {
		delay := 80
		; MsgBox "running"
      Send "^a"
      Sleep delay
      Send "^c"
      Sleep delay
      Send "{Escape}"

      WinActivate vbaWindowName

      Send "^a"
      Sleep delay
      Send "^v"
      Sleep delay
      Send "{Escape}"

      Sleep delay
      Send "{F5}"
      ;Send "{Enter}"
      
      ;WinActivate vscodeWindowName
   }
#HotIf
