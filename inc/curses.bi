' author: mario gnad
' last modified: 2022-01-15 08:31
' description:
'   https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/include/freebasic/ext/database/drivers/sqlite3driver_int.bi 
' licence:

#inclib "curses"

extern "c"

#define NCURSES_SIZE_T ushort
#define NCURSES_WIDECHAR 0

' easy route i am on 64bit
type chtype as ulongint
type mmask_t as ulongint
' 32bit would be 
'   type chtype as uinteger
'   type mmask_t as uinteger

type attr_t as chtype

type ldat as any

type pdat
  dim as NCURSES_SIZE_T _pad_y,_pad_x
  dim as NCURSES_SIZE_T _pad_top,_pad_left
  dim as NCURSES_SIZE_T _pad_bottom,_pad_right
end type

type wchar_t 
  dim as byte _0
  dim as byte _1
  dim as byte _2
  dim as byte _3
end type

#define CCHARW_MAX 5

type cchar_t
  dim as attr_t attr 
  ' wchar_t on linux = byte(4)
  dim as wchar_t chars(CCHARW_MAX)
  #if 1 
    #undef NCURSES_EXT_COLORS
    #define NCURSES_EXT_COLORS 20211021
    dim as integer ext_color
  #endif
end type

type _win_st_new
  dim as NCURSES_SIZE_T _cury, _curx
  dim as NCURSES_SIZE_T _maxy, _maxx
  dim as ushort _flags
  dim as attr_t _attrs
  dim as chtype _bkgd
  dim as boolean _notimeout
  dim as boolean _clear
  dim as boolean _leaveok
  dim as boolean _scroll
  dim as boolean _idlok
  dim as boolean _idcok
  dim as boolean _immed
  dim as boolean _sync
  dim as boolean _use_keypad
  dim as integer _delay

  dim as ldat ptr _line

  dim as NCURSES_SIZE_T _regtop
  dim as NCURSES_SIZE_T _regbottom

  dim as integer _parx
  dim as integer _pary

  dim as _win_st_new ptr _parent

  dim as pdat _pad_y

  dim as NCURSES_SIZE_T _yoffset
  
  #if(NCURSES_WIDECHAR)
    dim as cchar_t _bkgrnd
    #if 1 
      dim as integer _color 
    #endif
  #endif
end type

'' the next line is still not right
type _window as _win_st_new

declare function CursesInit alias "initscr" () as _window ptr
declare function CursesGetMaxX alias "getmaxx" (byval win as _window ptr) as integer
declare function CursesGetMaxY alias "getmaxy" (byval win as _window ptr) as integer
declare function CursesCreateWindow alias "newwin" (byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as _window ptr
declare function CursesCreateSubWindow alias "subwin" (byval win as _window ptr, byval lines as integer, byval colums as integer, byval begin_y as integer, byval begin_x as integer) as _window ptr
declare function CursesGetChar alias "getch" () AS UByte

declare sub CursesErease alias "erase" ()
declare sub CursesClear alias "clear" ()
declare sub CursesWErease alias "werase" (byval win as _window ptr)
declare sub CursesWClear alias "wclear" (byval win as _window ptr)
declare sub CursesDeleteWindow alias "delwin" (byval win as _window ptr)
declare sub CursesExit alias "endwin" ()
declare sub CursesRefresh alias "refresh" ()
declare sub CursesWRefresh alias "wrefresh" (byval win as _window ptr)
declare sub CursesPrintW alias "printw" (_out as ZString)
declare sub CursesWPrintW alias "wprintw" (byval win as _window ptr, _out as ZString)

end extern

declare sub CursesTest

sub CursesTest
  dim as _window ptr stdout=CursesInit()
  dim as integer subwin_max_x=0,subwin_max_y=0
  print "terminal max x:";CursesGetMaxX(stdout);" | terminal max y:";CursesGetMaxY(stdout)
  dim as WString * 13 str1 => "hello, world"
  CursesClear()
  CursesPrintW(str1)
  dim as _window ptr subwin
  subwin=CursesCreateSubWindow(stdout,5,30,2,2)
    'dim as ZString str2 = "Hallo, hier"
    subwin_max_x=CursesGetMaxX(subwin)
    subwin_max_y=CursesGetMaxY(subwin)
    CursesWPrintW(subwin,str1)
    CursesGetChar()
    CursesWClear(subwin)
  CursesDeleteWindow(subwin)
  CursesGetChar()
  CursesExit()
  print "subwin max x:";subwin_max_x;" | subwin max y:";subwin_max_y
end sub

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
