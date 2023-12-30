
; =======================================
; =============== NOTES =================
; =======================================
; -- Expressions
; # -> hold LWin
; ! -> hold LAlt
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

#SingleInstance Force

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

smoothScrollWindowName := "SmoothScroll License"
vbaWindowName := "Microsoft Visual Basic for Applications"
vscodeWindowName := "Visual Studio Code"

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

; =======================================
; ============ DEFAULT RUN ==============
; =======================================
; WinHide trayAhkClass

Loop {
	Sleep 60000
	Reload
	; Should be unreachable
	Sleep 1000
	MsgBox "Script could not be reloaded"
}

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

; Close/minimize window shortcut
#HotIf GetKeyState("LAlt")
   ; LShift & e::MinimizeActiveWindow()

	LShift & =::RestartAudio()

	RestartAudio() {
		Run "restart_audio.bat"
	}

   LShift & q::CloseActiveWindow()

	MinimizeActiveWindow() {
		WinMinimize GetActiveWindowTitle()
	}

	CloseActiveWindow() {
		windowTitle := GetActiveWindowTitle()
		; if (InStr(windowTitle, "Access_Control_System_Administration", true)) {
		; 	return
		; }
		WinClose GetActiveWindowTitle()
	}

   ; LAlt + F4
   LCtrl & q::Send "!{F4}"
#HotIf

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
   
; -- Firefox
#HotIf WinActive(firefoxAhkClass)
   ; Hijack these hotkeys to not let firefox recognize them
   RShift & Enter::DoNothing()
   LShift & Enter::DoNothing()
   ^+w::DoNothing()

   LWin & q::MakeFirefoxWindowAppearMaximized()

	LAlt & q::ToggleSidebar()

   DoNothing() {

   }

   ; Extend the window to secondary screen on the right to. Sidebery addon can be fitted on the secondary screen to not take space on the main screen 
   MakeFirefoxWindowAppearMaximized() {
      x := -8
      y := 0
      width := 2374
      height := 1086
      WinMove(firefoxAhkClass, , x, y, width, height)
   }

	; To be used with my custom css for firefox and sideberry
	ToggleSidebar() {
		static isSidebarVisible := false
		if (isSidebarVisible) {
			MoveMouseToBottom()
			isSidebarVisible := false
		} else {
			MoveMouseToBottomLeft()
			isSidebarVisible := true
		}
	}

	MoveMouseToBottomLeft() {
		MouseMove 0, 1080
	}

	MoveMouseToBottom() {
		MouseMove 960, 1080
	}
#HotIf

#HotIf WinActive("Borderlands 3")
   ; bind space to enter
#HotIf

; -- Active Window Info
#HotIf GetKeyState("RCtrl")
   RShift & o::CopyActiveWindowTitle()
   
   RShift & p::CopyActiveWindowClass()

   RShift & i::CopyActiveWindowClass()

   RShift & [::CopyActiveWindowSize()

   RShift & ]::CopyMousePosition()

   ; LShift & Delete::MakeActiveWindowAppearMaximized()

   CopyActiveWindowTitle() {
      A_Clipboard := GetActiveWindowTitle()
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
