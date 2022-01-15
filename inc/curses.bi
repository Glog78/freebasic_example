' author: mario gnad
' last modified: 2022-01-15 04:35
' description:
'
' licence:

#inclib "curses"

declare function CursesInit alias "initscr" () as any ptr
declare function CursesGetMaxX alias "getmaxx" (win as any ptr) as Integer
declare function CursesGetMaxY alias "getmaxy" (win as any ptr) as Integer
declare function CursesCreateWindow alias "newwin" (lines AS Integer, colums AS Integer, begin_y AS Integer, begin_x AS Integer) as Integer Ptr
declare function CursesGetChar alias "getch" () AS UByte

declare sub CursesDeleteWindow alias "delwin" (win as any ptr)
declare sub CursesExit alias "endwin" ()
declare sub CursesRefresh alias "refresh" ()
declare sub CursesPrintW alias "printw" (_out as ZString)
declare sub CursesWPrintW alias "wprintw" (win as any ptr, _out as ZString)

#inclib "SDL2"

declare sub CursesTest

sub CursesTest
  dim AS Integer Ptr stdout,subwindow
  stdout=CursesInit()
  DIM AS ZString * 13 str1 => "hello, world"
  CursesPrintW(str1)
  subwindow=CursesCreateWindow(5,30,5,5)
  CursesWPrintW(subwindow,str1)
  CursesRefresh()
  CursesGetChar()
  CursesDeleteWindow(subwindow)
  CursesRefresh()
  CursesGetChar()
  CursesExit()
end sub

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
