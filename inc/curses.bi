' author: mario gnad
' last modified: 2022-01-15 09:21
' description:
'   https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/include/freebasic/ext/database/drivers/sqlite3driver_int.bi 
' licence:

#include once "curses_h.bi"

#inclib "curses"   

extern "c"
  declare function CInit alias "initscr" () as CWindow ptr
  declare function CGetMaxX alias "getmaxx" (byval win as CWindow ptr) as integer
  declare function CGetMaxY alias "getmaxy" (byval win as CWindow ptr) as integer
  declare function CCreateWindow alias "newwin" (byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as CWindow ptr
  declare function CCreateSubWindow alias "subwin" (byval win as CWindow ptr, byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as CWindow ptr
  declare function CGetChar alias "getch" () AS UByte

  declare sub CEreaseTerm alias "erase" ()
  declare sub CClearTerm alias "clear" ()
  declare sub CEreaseWindow alias "werase" (byval win as CWindow ptr)
  declare sub CClearWindow alias "wclear" (byval win as CWindow ptr)
  declare sub CDeleteWindow alias "delwin" (byval win as CWindow ptr)
  declare sub CExit alias "endwin" ()
  declare sub CRefresTerm alias "refresh" ()
  declare sub CRefreshWindow alias "wrefresh" (byval win as CWindow ptr)
  declare sub CPrintTerm alias "printw" (byref _out as ZString)
  declare sub CPrintWindow alias "wprintw" (byval win as CWindow ptr, byref _out as ZString)
end extern

declare sub CursesTest


sub CursesTest

  dim as WString * 13 str1 => "hello, world"
  dim as CWindow ptr subwin,stdout=CInit()
  dim as integer subwin_max_x=0,subwin_max_y=0

  print "terminal max x:";CGetMaxX(stdout);" | terminal max y:";CGetMaxY(stdout)

  CClearTerm
  CPrintTerm(str1)
  subwin=CCreateSubWindow(stdout,5,30,2,2)
    subwin_max_x=CGetMaxX(subwin)
    subwin_max_y=CGetMaxY(subwin)
    CPrintWindow(subwin,str1)
    CGetChar
    CClearWindow(subwin)
  CDeleteWindow(subwin)
  CGetChar
  CExit

  print "subwin max x:";subwin_max_x;" | subwin max y:";subwin_max_y

end sub

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
