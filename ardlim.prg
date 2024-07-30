
	'This code has been written by Huseyin Karamelikli (Hossein Haghparast Gharamaleki) 
	'For any questions or comments please contact hakperest@gmail.com '
	'@npers
	'---------------------------------------------------------------------------'
			
		
		
%statmsg1="Getting the things needed for test"
'	statusline %statmsg1
	if !result=-1 then
		stop
	endif
	
	' Creating help text to be called in AddHelp function


	'---------------------------------------------------------------------------------------'
	%vars=@upper(%vars)
	%asvars=@upper(%asvars)
	%alvars=@upper(%alvars)	
	%evars=@upper(%evars)
	
	%avars=@wunique(%asvars+" "+%alvars)
	
	
	!n_var=@wcount(%vars)
	!e_var=@wcount(%evars)
	%DependVar=@word(%vars,1)
	!a_vars=@wcount(%avars)
	!a_Lvars=@wcount(%alvars)
	!a_Svars=@wcount(%asvars)
	'---------------------------------------------------------------------------------------'
	!autocor=0 'auto correlation sorunu yoktur
	
	
	'########  CHECK FOR NARDL
	
	%NVarlar=@wintersect(%avars,%vars)
	!NARDL=0
	 
	if(!a_vars > 0)then 
	!NARDL=1
	    if(@wcount(%NVarlar) <> !a_vars) then
		@uiprompt( "Assymetric variables must be at above variable list.")
		stop
	    endif
	    if @wcount(@wintersect( %avars , %DependVar )) then 
	      @uiprompt( "Dependent variable can not be set  as Assymetric variable")
		stop
	    endif
	    
	    
	    for !j=1 to !a_vars
		  %v=@word(%avars,!j)
		  call GetMin( %v  , 0)
		  call GetMax( %v  , 0)
	    next j
	
	endif
	'stop
	'######## END of CHECK FOR NARDL
	'########  CHECK FOR User Defined Lag_Criterion
	!ulags_num=@wcount(%userdefined)
	if(!ulags_num > 0)then 
	    !mismatchVars=0
            if(!a_Svars > 0 AND !DifferentAsymLag > 0  )then 
                if(!n_var+!a_Svars <> !ulags_num)then
                 !mismatchVars=1
                endif
            else
                if (!n_var <> !ulags_num) then
                !mismatchVars=1
                 endif
            endif
         if   !mismatchVars>0 then               
                    @uiprompt( "All variables must have lag number. Mismatch Defined lags and variables number")
                    stop
	    endif
	    for !j=1 to !ulags_num 
		  %v=@word(%userdefined,!j)
		  if {%v} <0 or @round({%v}) <>{%v} then
            @uiprompt(%v +" is not proper lag value")
            stop
		  endif
		  
	    next j
	    
	endif

	'######## END of CHECK FOR User Defined Lag_Criterion
	
	
	
	%statmsg2="Checking that variable's name exist and it is series"
'	statusline %statmsg2
	'check that an object exists and it is series"
	for !j=1 to !n_var
	%v=@word(%vars,!j)
	%prompt1="Variable "+" "+"("+%v+")"+ " can not be found.Please make sure enter the series name correctly "
		%prompt2="It seems "+" "+"("+%v+")"+" isn't a time series"
		if @isobject(%v)=0 then
			@uiprompt(%prompt1)
			stop
		else
		%isser={%v}.@type
		' check the type of object'
		if %isser<>"SERIES" then
			@uiprompt(%prompt2)
			stop
		endif
		endif
	next j
	
	

	'-------  Unit Root Hesaplama ---------'
'	call UrootHesapla 
	'------------------------------------------------------------------------'
	!maxlag=@val(%maxlag)
	!sayfaNo=0
	%LagArdl1=""
	%LagArdl2=""
	%LagArdl3=""
	%LagArdl4=""
	!logLine=0

	 
	'-------------------------------------------------------------------------'
	'getting the signifance LVOL level' 
	if !sig=1 then 
		!pcrit=0.99
		!pcrit2=0.01
		else 
			if !sig=2 then
				!pcrit=0.95
				!pcrit2=0.05
				else
				!pcrit=0.90
				!pcrit2=0.10
			endif
	endif
	'------------------------------------------------------------------------'
	
	if(!rest = 1) then
	%syntaxintercept=""
	%syntaxtrent=""
	%VarPesMat="matNcNt"
	endif
	
	if(!rest = 2) then
	%syntaxintercept="c"
	%syntaxtrent=""
	%VarPesMat="matUcNt"
	
	endif
	if(!rest = 3) then
	%syntaxintercept="c"
	%syntaxtrent=" @Trend "
	%VarPesMat="matUcUt"
	endif
	
	
	
if @isobject(%eqname) then 
else
%eqname ="HARDL"
endif

'%eqname = @getnextname("ZZ__ARDL")

    

if !criterion=4 then
	call GenToSpec
	equation {%eqname}.stepls(method = uni, back, btol = 0.05)   {%ls} 

else
      if(!ulags_num > 0)then 
	  call MatrisOlustur2 
      else
	  call MatrisOlustur 
      endif
      call TabloBasiHazirla
      call GecikmeHesapla(!toplam) ' eger yetmiyorsa sorun hemen verilsin diye

      for !i=1 to !toplam
	  call GecikmeHesapla(!i)
      next i
      call TabloSonuHazirla
      '############### equation 
      equation {%eqname}.ls  {%ls}  
endif





!usedObs={%eqname}.@npers
!dataSay={%DependVar}.@obs



 %OzetTable=@getnextname("OzetTable")
 table {%OzetTable}
 !tabloOzetSira=0





if !criterion <> 4 then
    call ARstracture
endif

%waldt=""
for !v=1 to !n_var +!a_Lvars
  %waldt=%waldt+" c("+@str(!v)+")= "
next
  %waldt=%waldt+"0"
 ' @uiprompt(@str(!n_var)+" << "+@str(!a_Lvars)+"  ++ "+%waldt+" >> "+@str(!a_Lvars+!n_var)+" << "+%ls)
 ' stop
%WaTest=@getnextname("ZZ__WaTest")
freeze({%WaTest}) {%eqname}.wald {%waldt}
!WaldF = @val({%WaTest}(6,2)) 
 
 call PesaranTable
 if(!rest > 1 AND !usedObs<100)	then
  call NarayanTable 
endif

 

   %Outputs=@getnextname("ZZ__OutPuts")
    spool {%Outputs}
	%DDependVar="d("+%DependVar+")"
	{%Outputs}.append {%DDependVar}.line
	{%Outputs}.name  1  "Dependent_Var_Graphics"
	
	{%Outputs}.append  {%eqname}.representations 
	{%Outputs}.name 2  "Representations"
 
 
 if !PlotShortRun =1 then
	%Graphs=@getnextname("My_Graphs")
	    spool {%Graphs}
	    !SpoolNo=0
	    for !v=2 to !n_var
		%buDeg=  @word(%vars,!v)
		call MakeGraph(%DependVar,%buDeg,!maxlag)
		!w=!v-1
		
		{%Graphs}.append {%graph}
		{%Graphs}.name !w %buDeg
		d {%graph} 
			
	      next v
 endif
 
 
 
if !NARDL=1  then
  %NARDLTESTS=@getnextname("ZZ__NARDLTESTS")
    spool {%NARDLTESTS}
    !SpoolNo=0
    if !a_Lvars >0 then
	    !nwald=0
	    !SpoolNo=!SpoolNo+1
	    %NARDLTESTSl=@getnextname("ZZ__NARDLTESTS_l")
	    spool {%NARDLTESTSl}
	      for !k=1 to !a_Lvars
		  %WaTestN=@getnextname("ZZ__WaTestN")
		  !nwald=!nwald+1
		  %Wyazi=@word(%alvars,!k)
		  %buDegL="NARDLWaldTxtL"+@str(!k)
		  freeze({%WaTestN}) {%eqname}.wald {%{%buDegL}}
			  !renk=1
			  if @val({%WaTestN}(7,4))>!pcrit2 then
			  !renk=2
			  endif
			  call TabloRenkEkle("Long Run Assymetry for "+%Wyazi+" Wald(Prob): ",{%WaTestN}(7,2) + " ("+ {%WaTestN}(7,4)+")",!renk)		  
		  {%NARDLTESTSl}.append  {%WaTestN}
		  {%NARDLTESTSl}.name  !nwald   %Wyazi
		  d {%WaTestN}
		next k
	{%NARDLTESTS}.append  {%NARDLTESTSl}
	{%NARDLTESTS}.name !SpoolNo "Long_Run" 
	d {%NARDLTESTSl}
    endif
   
    if !a_Svars >0 AND !criterion<>4  then
	    !nwald=0
	    !SpoolNo=!SpoolNo+1
	    %NARDLTESTSs=@getnextname("ZZ__NARDLTESTS_s")
	    spool {%NARDLTESTSs}
		  for !k=1 to !a_Svars
		      %WaTestN=@getnextname("ZZ__WaTestN")
		      !nwald=!nwald+1
		      %Wyazi=@word(%asvars,!k) 
		      %buDegS1="NARDLWaldTxtS1"+@str(!k)
		      %buDegS2="NARDLWaldTxtS2"+@str(!k)	
		      %buDegS=%{%buDegS1}+" = "+  %{%buDegS2}	
		     	
		    '  @uiprompt(%buDegS1+" > "+ %buDegS2+" /// " +{%NARDLWaldTxtS21}+%buDegS+" *** "+{%NARDLWaldTxtS11})
		      freeze({%WaTestN}) {%eqname}.wald {%buDegS}
			  !renk=1
			  if @val({%WaTestN}(7,4))>!pcrit2 then
			  !renk=2
			  endif
			  call TabloRenkEkle("Short Run Assymetry for "+%Wyazi+" Wald(Prob): ",{%WaTestN}(7,2) + " ("+ {%WaTestN}(7,4)+")",!renk)
		      {%NARDLTESTSs}.append  {%WaTestN}
		      {%NARDLTESTSs}.name  !nwald   %Wyazi
		      d {%WaTestN}
		    next k
	{%NARDLTESTS}.append  {%NARDLTESTSs}
	{%NARDLTESTS}.name !SpoolNo "Short_Run" 
	d {%NARDLTESTSs}
    endif
   

endif

call ShortRunECM
	call WriteToLog("lsAR = "+%lsAR)
	call WriteToLog("lsSAR = "+%lsSAR)
	call WriteToLog("ls2  = "+%ls2 )
	call WriteToLog("ls   = "+%ls )
	call WriteToLog("SRECM   = "+ %KisaDonemVars  )
	
%Stability=@getnextname("ZZ__Stability")
spool {%Stability}
	%StabilityM=@getnextname("ZZ__StabilityM")
	spool {%StabilityM}
		
{%StabilityM}.append {%eqname}.resids
		{%StabilityM}.name  1 "Fitted" 
		{%StabilityM}.append {%eqname}.rls(q)
		{%StabilityM}.name  2 "CUSUM"
		{%StabilityM}.append {%eqname}.rls(v)
		{%StabilityM}.name  3 "CUSUMSQ" 
		

'###### not available for eviews 9
'if !Emethod=1 then
'		{%StabilityM}.append   {%eqnamear}.arma(type=root,g)
'		{%StabilityM}.name  4 "AR_Roots"
'endif		
		
	{%Stability}.append  {%StabilityM}
	{%Stability}.name  1 "ARDL"
	%StabilityS=@getnextname("ZZ__StabilityS")
	spool {%StabilityS}
		{%StabilityS}.append {%SRECM}.resids
		{%StabilityS}.name  1 "Fitted" 
		{%StabilityS}.append {%SRECM}.rls(q)
		{%StabilityS}.name  2 "CUSUM"
		{%StabilityS}.append {%SRECM}.rls(v)
		{%StabilityS}.name  3 "CUSUMSQ"
'if !Emethod=1 then
'		
'		{%StabilityS}.append   {%eqnamearS}.arma(type=root,g)
'		{%StabilityS}.name  4 "AR_Roots"
'endif		
	{%Stability}.append  {%StabilityS}
	{%Stability}.name  2 "ECM"
	




'------------------ call LmTests ------------------

 
call LmTests
!testSirasi=0
%Diagnostics=@getnextname("ZZ__Diagnostics")
    spool {%Diagnostics}
    
include ".\tests.prg"

  
'    {%Diagnostics}.append     {%LmTable}
 '   {%Diagnostics}.name  2 "Auto_correlation"

   ' %bu=%eqname+".hettest(type=BPG) @REGS"
   

 


if !criterion<>4 then
	%spLag=@getnextname("ZZ__spLag")
	spool {%spLag}
	{%spLag}.append {%tn2}
	{%spLag}.name  1 "Lag_Criterion"
	if !AddCriterionTable=1 then
	    {%spLag}.append {%tn}
	    {%spLag}.name  2 "Lag_Tables"
	endif
 endif
 

 


 call TabloOzetEkle("Variables are: ",%vars ,"")
call TabloOzetEkle( "Dependent variable : " , %DependVar  ,"")
call TabloOzetEkle(%ExogenousTxt ,%evars  ,"")
call TabloOzetEkle( %LAsymmetricTxt, %alvars ,"")
call TabloOzetEkle( %SAsymmetricTxt, %asvars ,"")
 

call TabloOzetEkle( "Criterion" , @word(%critchoice,!criterion ) ,"")
call TabloOzetEkle( %maxlagT ,%maxlag   ,"")
call TabloOzetEkle( "Final Model" ,%ARDLN  ,""  )

call TabloOzetEkle( "Our model is : " ,@word(%ResUnres,!rest)  ,"" )
call TabloOzetEkle(" significance level"  , @word(%sigchoice,!sig) ,"" )
call TabloOzetEkle("Total Iteration" ,@str(!toplam) ,"" )
call TabloOzetEkle("Total Observation" ,@str(!dataSay) ,"" )
call TabloOzetEkle( "used Observation",@str(!usedObs) ,"" )

      {%OzetTable}.setlines(@all) +a
      {%OzetTable}.setwidth(1) 40
      {%OzetTable}.setwidth(2) 36
      {%OzetTable}.setjust(@all) top left

 
 
 
' ############################################################################################################## 
' Creat display Panel 
%sp=@getnextname("My__Sonuc")
spool {%sp}

	%HelpText=@getnextname("ZZ__HelpText")
	table(5,1) {%HelpText} 
      {%HelpText}(1,1)=  "For detailed results for ARDL and NARDL, please check the left menus. The critical test results are presented"
      {%HelpText}(2,1)=  "in the abstract table."      
      {%HelpText}(3,1) ="The ARDL menu contains the results for the most fitted models. The Long Run menu has normalized for long-"
      {%HelpText}(4,1)=	"run results."      
      {%HelpText}(5,1)=	"The estimates for cointegration are presented in the Wald_test menu. If you have a nonlinear model,  the Wald "
      {%HelpText}(6,1)=	 "tests for asymmetry will be shown in the Assymetry_Wald_test menu."  
      {%HelpText}(7,1)=	"For details, please visit https://github.com/karamelikli/Eviews-NARDL ."      
 {%HelpText}.setwidth(1) 85
 {%HelpText}.setjust(@all) left
 
{%sp}.append(name="Help" )   {%HelpText}
{%sp}.flatten
{%sp}.append(name="Abstract")  {%OzetTable}
 

'!sayfaNo=!sayfaNo+1
'{%sp}.name !sayfaNo "Abstract"
 
{%sp}.append(name="ARDL")  {%eqname}
 
 
 call UzunDonem 
 {%sp}.append(name="Long_Run")  {%longRun} 

 
 {%sp}.append(name="Wald_test")   {%WaTest}
if !NARDL=1  then
	{%sp}.append(name="Assymetry_Wald_test")     {%NARDLTESTS} 
endif
	{%sp}.append(name="ECM")   {%SRECM} 
	

  if !PlotShortRun =1 then
    {%sp}.append(name="Dynamic_Multipliers")     {%Graphs} 
 endif
	
 
 
if !MakeLibreFormulas=1 then
	call MakeLibreFormulas
	    {%sp}.append(name="LibreFormulas")    {%LibreFormulas}

 endif
 
  {%sp}.append(name="Estimations")   {%Outputs}

 

 


{%sp}.append(name="Stability_Test")   {%Stability}
 
 {%sp}.append(name="Diagnostic_Tests")   {%Diagnostics}
 
 


if !criterion<>4 then
	{%sp}.append(name="Lags")  {%spLag}
 endif
 
 if !debug = 1 then
      if @isobject(%WriteLog) then
	  {%sp}.append(name="Logs")   {%WriteLog} 
      endif
endif


 
 
 
 if !displayIT=1 then
_this.display {%sp}
endif

if !a_vars>0 and !KeepEquation <1 then
      for !j=1 to !a_vars
	    %v=@word(%avars,!j)
	    %Max=%v +"_P"
	    %Min=%v +"_N"
	     d {%Max}  {%Min}
      next j
endif

if !KeepEquation=0 then
  d {%eqname} 
endif
if !keepAbstract=0 then 
 d {%OzetTable} 
endif

if !KeepPlot=0 then 
 d {%Graphs} 
endif
if !KeepMainFrame=0 then 
 d {%sp} 
endif

'd {%tn} {%tn2} {%eqnamear} {%Abst} {%LmTable} {%spLag} {%WaTest}    {%matNcNt}  {%matRcNt}  {%matUcNt} {%matUcRt} {%matUcUt} {%NmatRcNt} 
'd {%NmatUcNt} {%NmatUcRt} {%NmatUcUt} {%ttext} {%uygunmatrix} {%Nuygunmatrix} {%Stability} {%Outputs} {%Diagnostics}  {%NARDLTESTS} 

'd    {%Graphs}  {%mn} {%jb} {%hettest}  {%OzetTable} {%LibreFormulas} {%SRECM}  {%LRECM} {%LRECMresid}  {%license} {%WriteLog} {%StabilityM} {%StabilityS} {%eqnamearS}
d {%LRECMresid}
d  zz__* 



'stop


