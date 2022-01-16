' author: mario gnad
' last modified: 2022-01-16 06:46
' description:
' licence:

#include once "vbcompat.bi"
#include once "inc/curses.bi"

function main AS Integer
  dim i as Integer
  for i=0 to 10 
    print i;". Hallo Welt"
  next i
  CursesTest
  Main=0
end function

system main

' vim: bs=2 sw=2 ss=2 ts=2 nu et ft=basic
