' author: mario gnad
' last modified: 2022-02-05 04:45
' description:
'   https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/include/freebasic/ext/database/drivers/sqlite3driver_int.bi 
'   https://invisible-island.net/ncurses/ncurses-intro.html
' licence:

namespace curses 'public use this
	#include "curses_priv.bi"
	#inclib "curses"

	extern "c"

		type win as curses.curses_priv._win_st

		declare function _Init alias "initscr" () as win ptr
		declare function GetMaxX alias "getmaxx" (byval as win ptr) as integer
		declare function GetMaxY alias "getmaxy" (byval as win ptr) as integer
		declare function CreateWindow alias "newwin" (byval as integer, byval as integer, byval as integer, byval as integer) as win
		declare function CreateSubWindow alias "subwin" (byval as win ptr, byval as integer, byval as integer, byval as integer, byval as integer) as win ptr
		declare function GetChar alias "getch" () as UByte
		declare function CBreak alias "cbreak" () as integer
		declare function EreaseTerm alias "erase" () as integer
		declare function ClearTerm alias "clear" () as integer
		declare function EreaseWindow alias "werase" (byval as win ptr) as integer
		declare function ClearWindow alias "wclear" (byval as win ptr) as integer
		declare function DeleteWindow alias "delwin" (byval as win ptr) as integer
		declare function _Exit alias "endwin" () as integer
		declare function RefresTerm alias "refresh" () as integer
		declare function RefreshWindow alias "wrefresh" (byval as win ptr) as integer
		declare function PrintTerm  alias "printw" (byval as zstring ptr, ... ) as integer
		declare function PrintWindow alias "wprintw" (byval as win ptr, byval as zstring ptr, ... ) as integer
		declare function SetCursorPositionTerm alias "move" (byval as integer,byval as integer) as integer
		declare function SetCursorPositionWindow alias "wmove" (byval as win ptr, byval as integer, byval as integer) as integer

	end extern

end namespace 'curses

sub CursesTest
	dim as curses.win ptr subwin,stdout=curses._Init
	dim i as integer

	curses.PrintTerm !"terminal size: max_x->%i | max_y->%i\n",curses.GetMaxX(stdout),curses.GetMaxY(stdout)

	for i=0 to curses.GetMaxY(stdout)-5
		curses.PrintTerm !"dfuafhgerqzfgefgerwzfgrewzfgrezfgzerfgerzfgerz\n"
	next i

	subwin=curses.CreateSubWindow(stdout,5,40,2,2)
		curses.ClearWindow subwin
		curses.SetCursorPositionWindow subwin,1,1
		curses.PrintWindow subwin,!"window size: max_x->%i | max_y->%i\n",curses.GetMaxX(subwin),curses.GetMaxY(subwin)
		curses.GetChar
		curses.ClearWindow subwin
	curses.DeleteWindow subwin
	curses.GetChar
	curses._Exit
end sub

' vim: bs=2 sw=2 ss=2 ts=2 nu noet ft=basic
