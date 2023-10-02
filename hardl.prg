!ifVarLar=1 'subroutineler kapatılsın diye var.

include ".\libs.hardl.prg"
include ".\libs.general.prg"
include ".\settings.prg"
include ".\libs.tests.prg"

!displayIT=1 
%type = @getthistype
if  %type="NONE" then 
      @uiprompt("Please open any things! group series etc.")
      stop
endif

if !debug = 1 then
	logmode +debug
	 %Logtxt = @getnextname("Log_test")
	 text {%Logtxt}
else 
	logmode +addin
endif

include ".\nardlMenu.prg"
include ".\Ardlim.prg"
d  zzz__*


