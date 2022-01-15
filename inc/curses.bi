' author: mario gnad
' last modified: 2022-01-15 02:26
' description:
'
' licence:

#inclib "curses"
Declare Sub CursesInit Alias "initscr" ()
Declare Sub CursesExit Alias "endwin" ()
Declare Sub CursesRefresh Alias "refresh" ()
Declare Function CursesGetChar Alias "getch" () AS UByte

Declare Sub CursesTest

Sub CursesTest
  CursesInit()
  CursesRefresh()
  CursesGetChar()
  CursesExit()
End Sub

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
