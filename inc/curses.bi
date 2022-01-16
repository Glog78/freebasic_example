' author: mario gnad
' last modified: 2022-01-16 08:25
' description:
'   https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/include/freebasic/ext/database/drivers/sqlite3driver_int.bi 
' licence:

namespace curses 'public use this
  #include "curses_priv.bi"
  #inclib "curses"   
  extern "c"
    
    type win as curses.curses_priv._win_st

    declare function _Init alias "initscr" () as win ptr
    declare function GetMaxX alias "getmaxx" (byval _win as win ptr) as integer
    declare function GetMaxY alias "getmaxy" (byval _win as win ptr) as integer
    declare function CreateWindow alias "newwin" (byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as win
    declare function CreateSubWindow alias "subwin" (byval _win as win ptr, byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as win ptr
    declare function GetChar alias "getch" () AS UByte

    declare sub EreaseTerm alias "erase" ()
    declare sub ClearTerm alias "clear" ()
    declare sub EreaseWindow alias "werase" (byval _win as win ptr)
    declare sub ClearWindow alias "wclear" (byval _win as win ptr)
    declare sub DeleteWindow alias "delwin" (byval _win as win ptr)
    declare sub _Exit alias "endwin" ()
    declare sub RefresTerm alias "refresh" ()
    declare sub RefreshWindow alias "wrefresh" (byval _win as win ptr)
    declare sub PrintTerm alias "printw" (byref _out as ZString)
    declare sub PrintWindow alias "wprintw" (byval _win as win ptr, byref _out as ZString)
  end extern
end namespace 'curses

sub CursesTest
  dim as WString * 13 str1 => "hello, world"
  dim as curses.win ptr subwin,stdout=curses._Init
  dim as integer subwin_max_x=0,subwin_max_y=0

  print "terminal max x:";Curses.GetMaxX(stdout);" | terminal max y:";Curses.GetMaxY(stdout)

  curses.ClearTerm
  curses.PrintTerm(str1)
  subwin=curses.CreateSubWindow(stdout,5,30,2,2)
    subwin_max_x=curses.GetMaxX(subwin)
    subwin_max_y=curses.GetMaxY(subwin)
    curses.PrintWindow(subwin,str1)
    curses.GetChar
    curses.ClearWindow(subwin)
  curses.DeleteWindow(subwin)
  curses.GetChar
  curses._Exit

  print "subwin max x:";subwin_max_x;" | subwin max y:";subwin_max_y
end sub

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
