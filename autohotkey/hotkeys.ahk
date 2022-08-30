; =======================================
; ================ NOTES ================
; =======================================
; ------ Expressions ------
; # -> hold LWin
; ! -> hold LAlt
; %variable% -> Get variable value
; % expression -> Evaluate expression
; ${ -> Escape '{''
;
; ------ Other ------
; WinGet window, ID, A
; THERE ARE ONLY GLOBAL VARIABLES
;

#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

; Works in "Windows Explorer"
#IfWinActive ahk_class CabinetWClass
   LWin & n::CreateNewTextFile()

   CreateNewTextFile() {
      Send {PgUp} 	; Force select the first file
      Send ^{Space} 	; Clear the selection
      Send {AppsKey}	; Menu key
      Send w 			; Skip
      Send w 			; New
      Send {Right} 	; Right arrow
      Send t 			; Create Text Document
   }
#If

; =======================================
; =========== KEY REBINDINGS ============
; =======================================

; ------ Bind Capslock to Backspace ------
CapsLock::Send {Backspace}
LCtrl & CapsLock::Send {Backspace}
LAlt & CapsLock::Send {Backspace}
LShift & CapsLock::Send {Backspace}

; ------ Bind Semicolon to Colon ------
`;::Send {Text}:

; ------ Bind Colon to Semicolon ------
:::Send {Text};

; ------ Bind Colon to Semicolon ------
; -::Send {Text}_

; ------ Bind Underscore to Hyphen ------
; _::Send {Text}-

; ------ Bind Quote to Double Quote ------
; '::Send {Text}"

; ------ Bind Double Quote to Quote ------
; "::Send {Text}'

; ------ Bind Tilde to single press Tilde ------
; LShift & `::
;    SendRaw ~1 ; '1' could be any char
;    Send {BackSpace}
; return

; ------ Add space and move cursor left once after bracket opening ------
; ${::SendRaw {
; #If (A_PriorHotkey = "${" AND A_TimeSincePriorHotkey < 2000)
;    Space::
;       Send {Space}
;       Send {Space}
;       SendInput {Left 1}
;    return
; #If

; =======================================
; ================ OTHER ================
; =======================================

; ------ Taskbar ------
; Toggle taskbar visibility
LWin & t::
   if toggle := !toggle {
      WinHide ahk_class Shell_TrayWnd
      WinHide, Start ahk_class Button 
   } else {
      WinShow ahk_class Shell_TrayWnd
      WinShow, Start ahk_class Button 
   }
return

; Hides taskbar
WinHide, % "ahk_id " DllCall("GetTaskmanWindow")

#If GetKeyState("LAlt")
   LShift & e::MinimizeWindow()

   LShift & q::CloseWindow()

   ; LAlt + F4
   LCtrl & q::Send !{F4}

   MinimizeWindow() {  
      WinGetActiveTitle windowTitle
      WinMinimize % windowTitle
   }

   CloseWindow() {
      WinGetActiveTitle windowTitle
      WinClose % windowTitle
   }
#If

#IfWinActive Sid Meier's Civilization V (DX11)
   ; Requires BorderlessGaming
   ; Works for 1920x1080 resolution
   LCtrl & End::EnableBorderless()
   EnableBorderless() {
      MouseClick left, 955, 537  ; Options
      MouseClick left, 932, 302  ; Video Options
      MouseClick left, 791, 369  ; 1920x1080
      MouseClick left, 800, 425  ; 1680x1050
      MouseClick left, 708, 500  ; Apply resolution
      MouseClick left, 836, 557  ; Yes
      MouseClick left, 682, 364  ; 1680x1050
      MouseClick left, 680, 391  ; 1920x1080
      MouseClick left, 585, 492  ; Apply resolution
      MouseClick left, 962, 574  ; Yes
      MouseClick left, 1272, 829 ; Accept
      MouseClick left, 963, 500  ; Mods
      MouseClick left, 1271, 824 ; Next
   }
#If

; ------ Firefox ------
#IfWinActive ahk_class MozillaWindowClass
   ; Hijacks these hotkeys to not let firefox recognize them
   RShift & Enter::DoNothing()
   LShift & Enter::DoNothing()
   ^+w::DoNothing()

   LWin & q::MakeFirefoxWindowAppearMaximized()

   DoNothing() {
   }

   ; Extends the window to secondary screen on the right to. Sidebery addon can be fitted on the secondary screen to not take space on the main screen 
   MakeFirefoxWindowAppearMaximized() {
      x := -8
      y := 0
      width := 2374
      height := 1086
      WinMove ahk_class MozillaWindowClass, , x, y, width, height
   }
#If

#If GetKeyState("RCtrl")
   ; ------ Get Window Info ------
   RShift & b::CopyActiveWindowTitle()
   
   RShift & v::CopyActiveWindowClass()

   RShift & w::CopyActiveWindowSize()

   RShift & f::CopyMousePosition()

   RShift & Delete::MakeActiveWindowAppearMaximized()

   CopyActiveWindowTitle() {
      WinGetActiveTitle windowTitle
      clipboard := windowTitle
   }

   CopyActiveWindowClass() {
      WinGetClass windowClass, A
      clipboard := windowClass
   }

   CopyActiveWindowSize() {
      WinGetPos x, y, width, height, A
      clipboard := "" . x . ", " . y . ", " . width . ", " . height
   }

   CopyMousePosition() {
      MouseGetPos x, y
      clipboard := "" . x . ", " . y
   }

   ; Resizes window to take up the whole secondary screen with 1920x1080 resolution without maximizing the window (use with hidden taskbar)
   MakeActiveWindowAppearMaximized() {
      WinGetTitle windowName, A
      WinRestore % windowName
      if InStr(windowName, "Discord") {
         x := 1921
         y := 0
         width := 1920
         height := 1080
      } else {
         x := 1913
         y := 0
         width := 1933
         height := 1087
      }
      WinMove % windowName, , x, y, width, height
   }
   
   ; TODO On moving a window to another screen a via LWin + Shift + R/L Arrow make window appear maximized (set size for each display)
   ; IsWindowMaximized() {
   ;    WinGetTitle windowName, A
   ;    WinGet isMaximized, MinMax, windowName
   ;    return isMaximized
   ; }
#If

; Hides mouse cursor and disables its ability to move
ScrollLock::
   if my_flag := !my_flag {
      MouseGetPos, , , hwnd
      Gui Cursor:+Owner%hwnd%
      BlockInput MouseMove
      DllCall("ShowCursor", Int, 0)
   } else {
      BlockInput MouseMoveOff
      DllCall("ShowCursor", Int, 1)
   }
return
