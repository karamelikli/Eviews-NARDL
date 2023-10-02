


subroutine JBTest( )
if !ifVarLar=1 then
    
    %jb=@getnextname("ZZ__stats")
    freeze({%jb}) resid.stats
    
    !renk=1
    if @val({%jb}(15,2))<!pcrit2 then
    !renk=2
    endif
    call TabloRenkEkle(" Jarque-Bera (Prob): ",{%jb}(14,2) + " ("+ {%jb}(15,2)+")",!renk)


'    if !autocor=1 then
'    call TabloRenkEkle(" Breusch-Godfrey Serial Correlation LM Test: ","There is problem",2)
'    else
'    call TabloRenkEkle(" Breusch-Godfrey Serial Correlation LM Test: ","There is No problem",1)
'    endif
    !testSirasi=!testSirasi+1
        {%Diagnostics}.append {%eqname}.hist
    {%Diagnostics}.name  !testSirasi "Normality"

endif
endsub


subroutine LmTest(   scalar !q )
if !ifVarLar=1 then
     %autoBG=@getnextname("ZZ__autoBG")
     freeze({%autoBG})  {%eqname}.auto(!q)
     !renk=1
	if @val({%autoBG}(3,5))<!pcrit2 then
	!renk=2
	endif
     %lmyaz="Breusch-Godfrey Serial Correlation LM("+@str(!q)+") F(Prob): "
     %lmicYaz={%autoBG}(3,2) + " ("+ {%autoBG}(3,5)+")"
     call TabloRenkEkle(%lmyaz,%lmicYaz,!renk)
    {%Diagnostics}.append {%autoBG} '%bu
      !testSirasi=!testSirasi+1
      %adi="Auto_correlation_"+@str(!q) 
    {%Diagnostics}.name  !testSirasi  {%adi} 
    
endif
endsub


subroutine ResetTest(   scalar !q )
if !ifVarLar=1 then
    ' sadece q=1 olduğunda 8. satira kayiyor
 '   !satirno=7
 '   if !q=1 then
 '   !satirno=8
 '   endif
 !satirno=1
        %ResetTest=@getnextname("ZZ__ResetTest")
        freeze({%ResetTest})  {%eqname}.reset(!q)
        while @wfindnc({%ResetTest}(!satirno,1),"F-statistic")<>1
            !satirno=1+!satirno

        wend
         
        !renk=1
            if @val({%ResetTest}(!satirno,4))<!pcrit2 then
            !renk=2
            endif
        %lmyaz="Ramsey RESET Test("+@str(!q)+") F(Prob): "
        %lmicYaz={%ResetTest}(!satirno,2) + " ("+ {%ResetTest}(!satirno,4)+")"
        call TabloRenkEkle(%lmyaz,%lmicYaz,!renk)
        {%Diagnostics}.append {%ResetTest} '%bu
        !testSirasi=!testSirasi+1
        %adi="Ramsey_RESET_"+@str(!q) 
        {%Diagnostics}.name  !testSirasi {%adi}
    
endif
endsub

subroutine HETR_BPG()
if !ifVarLar=1 then

 %hettest=@getnextname("ZZ__hettest")
    freeze({%hettest})  {%eqname}.hettest(type=BPG) @REGS
	!renk=1
	if @val({%hettest}(3,5))<!pcrit2 then
	!renk=2
	endif
	call TabloRenkEkle("Heteroskedasticity Breusch-Pagan-Godfrey F(Prob): ",{%hettest}(3,2) + " ("+ {%hettest}(3,5)+")",!renk)
    {%Diagnostics}.append {%hettest} '%bu
      !testSirasi=!testSirasi+1
    {%Diagnostics}.name  !testSirasi "BPG_Heteroskedasticity" 
endif
endsub

subroutine HETR_WHITE()
if !ifVarLar=1 then

 %hettest=@getnextname("ZZ__hettest")
    freeze({%hettest})  {%eqname}.hettest(c,type=White) @white(@comp)
	!renk=1
	if @val({%hettest}(3,5))<!pcrit2 then
	!renk=2
	endif
	call TabloRenkEkle("Heteroskedasticity White F(Prob): ",{%hettest}(3,2) + " ("+ {%hettest}(3,5)+")",!renk)
    {%Diagnostics}.append {%hettest} '%bu
      !testSirasi=!testSirasi+1
    {%Diagnostics}.name  !testSirasi "White_Heteroskedasticity" 
endif
endsub

'the null hypothesis that there is no ARCH 
subroutine HETR_ARCH(scalar !q )
if !ifVarLar=1 then

 %hettest=@getnextname("ZZ__hettest")
    freeze({%hettest})  {%eqname}.hettest(lags =!q,type=Arch) @REGS
	!renk=1
	if @val({%hettest}(3,5))<!pcrit2 then
	!renk=2
	endif
	call TabloRenkEkle("Heteroskedasticity ARCH("+@str(!q) +") F(Prob): ",{%hettest}(3,2) + " ("+ {%hettest}(3,5)+")",!renk)
    {%Diagnostics}.append {%hettest} '%bu
      !testSirasi=!testSirasi+1
      %adi= "ARCH"+@str(!q) +"_Heteros"
    {%Diagnostics}.name  !testSirasi {%adi}
endif
endsub


'null hypothesis of no heteroskedasticity against heteroskedasticity 
subroutine HETR_Harvey()
if !ifVarLar=1 then

 %hettest=@getnextname("ZZ__hettest")
    freeze({%hettest})  {%eqname}.hettest(type=Harvey) @REGS
	!renk=1
	if @val({%hettest}(3,5))<!pcrit2 then
	!renk=2
	endif
	call TabloRenkEkle("Heteroskedasticity Harvey F(Prob): ",{%hettest}(3,2) + " ("+ {%hettest}(3,5)+")",!renk)
    {%Diagnostics}.append {%hettest} '%bu
      !testSirasi=!testSirasi+1
      %adi= "Harvey_Heteros"
    {%Diagnostics}.name  !testSirasi {%adi}
endif
endsub


