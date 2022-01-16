' author: mario gnad
' last modified: 2022-01-16 07:23
' description:
'
' licence:

namespace curses_priv 'privat don't use
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

    type win
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

      dim as win ptr _parent

      dim as pdat _pad_y

      dim as NCURSES_SIZE_T _yoffset
  
      #if(NCURSES_WIDECHAR)
        dim as cchar_t _bkgrnd
        #if 1 
          dim as integer _color 
        #endif
      #endif
    end type

    namespace test_another 'just to test ctag implementation
      dim somethig as integer
      sub nothing_to_see_here
      end sub
    end namespace

  end extern

end namespace 'end of curses_priv namespace

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
