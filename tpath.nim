import termkey
import os
import terminal
import strformat

proc main() =
  offCursor()
  initScreen()


  while true:
    let keyc = getFunc()
    case keyc
      of TKey.F3:
        #....#
        break

      of TKey.F12:
     
        gotoXY(1,1)
        writeStyled("getEnv USER :")

        gotoXY(1,20)
        writeStyled(getEnv("USER"))

        gotoXY(2,1)
        writeStyled("getEnv PATH :")

        gotoXY(2,20)
        writeStyled(getEnv("PATH"))


        gotoXY(10,1)
        writeStyled("getHomeDir :")

        gotoXY(10,20)
        writeStyled(getHomeDir())

        gotoXY(12,1)
        writeStyled("getTempDir :")

        gotoXY(12,20)
        writeStyled(getTempDir())

        gotoXY(14,1)
        writeStyled("getCurrentDir :")

        gotoXY(14,20)
        writeStyled(getCurrentDir())

        gotoXY(16,1)
        writeStyled("getConfigDir :")

        gotoXY(16,20)
        writeStyled(getConfigDir())

        gotoXY(17,1)
        writeStyled("paramCount() :")

        gotoXY(17,20)
        writeStyled(fmt"{paramCount()}")

        gotoXY(18,1)
        writeStyled("commandLineParams() :")

        gotoXY(18,20)
        writeStyled($commandLineParams())

        gotoXY(19,1)
        writeStyled("getAppDir() :")
        
        gotoXY(19,20)
        writeStyled($getAppDir())

        
      else: discard
main()
closeScren()
