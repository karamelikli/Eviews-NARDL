

subroutine ARstracture(   )
if !ifVarLar=1 then

	%eqnamear = @getnextname("ZZ__ARStru")
	equation {%eqnamear}.ls  {%lsAR}
	%eqnamearS = @getnextname("ZZ__SARStru")
	equation {%eqnamearS}.ls  {%lsSAR}
	
		
	'	{%eqnamear}.arma(type=root,g) 
endif
endsub



subroutine GecikmeHesapla(  scalar sayi )
if !ifVarLar=1 then

	call MakeLsEquation (sayi)
	%lsAR=%BagimliDegisken+%ls1 +%ARvars +%DigerDegiskenler
	%lsSAR=%BagimliDegisken+%ARvars +%DigerDegiskenler
	%ls=%BagimliDegisken+%ls1 + %ls2 +%DigerDegiskenler
	'{%Logtxt}.append  %ls
	'%statmsg4="Computing....."+%ls 
	'statusline %statmsg4
	'seterr %NARDLWaldTXTQ
	call WriteToLog(%ARDLN +" : "+ %ls)
	%buyazi= "Estimate of "+ %vars +" "+ %ARDLN
    statusline {%buyazi}
	equation {%eqname}.ls  {%ls}  
	!ac={%eqname}.@aic
	!sw={%eqname}.@schwarz
	!hq= {%eqname}.@hq
	!lg= {%eqname}.@logl
	if(!ac<!a_1) then
        !a_1=!ac
        !b_1=sayi
        %LagArdl1=%ARDLNa
	endif
	if(!sw<!a_2) then
        !a_2=!sw
        !b_2=sayi
        %LagArdl2=%ARDLNa
	endif
	if(!hq<!a_3) then
        !a_3=!hq
        !b_3=sayi
        %LagArdl3=%ARDLNa
	endif
	if(!lg<!a_4) then
        !a_4=!lg
        !b_4=sayi
        %LagArdl4=%ARDLNa
	endif
	  {%tn}(sayi+1,1)= %ARDLNa
	  {%tn}(sayi+1,2)=!ac
	  {%tn}(sayi+1,3)=!sw
	  {%tn}(sayi+1,4)=!hq
	  {%tn}(sayi+1,5)=!lg
	 ' {%tn}(sayi+1,6)= %ls
	'{%mn}(sayi,!a_1y)=!ac
	'{%mn}(sayi,!a_2y)=!sw
	'{%mn}(sayi,!a_3y)=!hq
	d {%eqname}
endif
endsub


subroutine   GenToSpec( )
 if !ifVarLar=1 then 
	  %mn = @getnextname("ZZ___mat")	
	  !toplam=1
	  matrix(1 ,!n_var) {%mn}
	for !j=1 to !n_var 
	  {%mn}(1,!j)=!maxlag		  
	 next j
   call MakeLsEquation(1)
    %ls= %BagimliDegisken +%ls1+ %DigerDegiskenler+"  @  "+ %ls2
   call WriteToLog(" stepls(method = uni, back, btol = 0.05)   : "+ %ls)
	
 endif
 endsub
 
 
 
  subroutine   GetMin(  string %in, scalar !q1)
 if !ifVarLar=1 then 
      %Min = %in +"_N"
	  if @isobject(%Min) then
	  d {%Min}
	  endif
      %Din = @getnextname("ZZ__DNARDL"+%in)
      %gs = @getnextname("ZZ__NARDL")
      series  {%Din}=d({%in})
      series  {%gs}= @recode({%Din}>=!q1  ,0,{%Din})
      series 	{%Min}  = @cumsum( {%gs})
      d {%gs} {%Din}
      

 endif	
endsub

 subroutine   GetMax(string %in, scalar !q1)
  if !ifVarLar=1 then 
      %Max = %in +"_P"
	  if @isobject(%Max) then
	 d {%Max}
	  endif
      %Din = @getnextname("ZZ__DNARDL"+%in)
      %gs = @getnextname("ZZ__NARDL")
      series  {%Din}=d({%in})
      series  {%gs}= @recode({%Din}<=!q1  ,0,{%Din})
      series 	{%Max}  = @cumsum( {%gs})
      d {%gs} {%Din}
      

 endif
endsub




subroutine LmTests(    )
if !ifVarLar=1 then

	  %LmTable=@getnextname("ZZ__LmTable")
	  table {%LmTable}
	  {%LmTable}(1,1)="Lag"
	  {%LmTable}(1,2)="F-statistic"
	  {%LmTable}(1,3)="F Prob"
	  {%LmTable}(1,4)="n*R-Square"
	  {%LmTable}(1,5)="Prob. Chi-Square"

	  %LMtest=@getnextname("ZZ__LMTest")
	  for !lmm=1 to !maxlag 
	  freeze({%LMtest})  {%eqname}.auto(!lmm)
	  {%LmTable}(1+!lmm,1)=@str(!lmm)
	  {%LmTable}(1+!lmm,2)={%LMtest}(3,2)
	  %FprobTable={%LMtest}(3,5)
	     if( @val(%FprobTable)  < !pcrit2 ) then
	      !autocor=1
	      %FprobTable=%FprobTable +"*"
	      endif
	   %KprobTable={%LMtest}(4,5)
	      if( @val(%KprobTable)  < !pcrit2 ) then
	      !autocor=1
	      %KprobTable=%KprobTable +"*"
	      endif

	  {%LmTable}(1+!lmm,3)=%FprobTable
	  {%LmTable}(1+!lmm,4)={%LMtest}(4,2)
	  {%LmTable}(1+!lmm,5)=%KprobTable

	  d {%LMtest}
	  next
	  {%LmTable}(2+!maxlag,1) ="* shows auto correlation at lag"
	  {%LmTable}.title "Breusch-Godfrey Serial Correlation LM Test"
	  {%LmTable}.setlines(@all) +a

endif
endsub

 
subroutine MakeBoundsTable(scalar !pl , scalar !ph ,scalar !nl , scalar !nh )
if !ifVarLar=1 then
	%tnb = @getnextname("ZZ__tableBounds")
	table {%tnb} 
	{%tnb}(1,2)="I(0)"
	{%tnb}(1,3)="I(1)"
	{%tnb}(2,1)="Pesaran"
	{%tnb}(2,2)= !pl
	{%tnb}(2,3)= !ph
	{%tnb}(3,1)="Narayan"
	if(!rest > 1)	then
	  {%tnb}(3,2)= !nl
	  {%tnb}(3,3)= !nh
	endif
	{%tnb}.setlines(@all) +a
	{%tnb}.title=" bound table values"
	{%Abst}.append  {%tnb}
	d {%tnb}
	

endif
endsub



subroutine MakeLibreFormulas(  )
if !ifVarLar=1 then
    %LibreFormulas = @getnextname("ZZ__LibreFormulas")
    %gostergeler="p q m n v w b h g d s r o"
    %Libre_ex=""
    %asVar=""
    %Libre_SSum_InDep =""
    %LibreO_AsyShort=""
    %LibreO_AsyLong=""
    %Libre_SSum_InDep2=""
    %anlamAsy1=""
    %anlamAsy2=""
     %anlam1=""
    %anlam2=""
    %LDependVar=""""+%DependVar+""""
    text {%LibreFormulas}
	  %Libre_Dependent =" %DELTA "+%LDependVar+"_t = "
	  %Libre_Long_Dependent ="  "+%LDependVar+"_t = " 'Uzun Dönem
	  %anlam1Oratk="  %eta _0  =%theta"
	   %anlam2Ortak =" ~ %theta  = %eta _0  " 
	 if(!a_vars  > 0) then
	 %LibreO_Asy1=""
	 %LibreO_AsyDyn=""
	      for !aslar=1 to !a_vars
		 %asVar=""""+@word(%avars,!aslar )+""""
		 if !aslar>1 then %SonrakiSatir=" newline " else %SonrakiSatir="" endif
		
		%LibreO_Asy1= %LibreO_Asy1+%SonrakiSatir+%asVar+"^{size 12 {+"" ""}}_t = sum from{i=1} to{t} { %DELTA "+ %asVar+"^{size 12 {+"" ""}}_i } =  sum from{i=1} to{t} {max(%DELTA "+ %asVar+"_i ,0) } ~;~"+ %asVar+"^{size 12 {-"" ""}}_t = sum from{i=1} to{t} { %DELTA "+ %asVar+"^{size 12 {-"" ""}}_i }=  sum from{i=1} to{t} {min(%DELTA "+ %asVar+"_i ,0) }"
		
		%LibreO_AsyDyn=%LibreO_AsyDyn+%SonrakiSatir+"m^{size 12 {+"" ""}} _h =  sum from{i=0} to{h}  { { partial "+%LDependVar+" _{t+i} }over {partial "+%asVar+"^{size 12 {+"" ""}} _t}  } ~;~ m^{size 12 {-"" ""}} _h =  sum from{i=0} to{h}  { { partial "+%LDependVar+" _{t+i} }over {partial "+%asVar+"^{size 12 {-"" ""}} _t}  } newline lim from{ h toward  %infinite  } m^{size 12 {+"" ""}} _h  =  %alpha^{size 12 {+"" ""}} _1 ~ , ~  lim from{ h toward  %infinite  } m^{size 12 {-"" ""}} _h  =  %alpha^{size 12 {-"" ""}} _1   "
		
	      next !aslar
	endif
	 if(!rest <> 1) then
		  %Libre_C =" %beta_0 +  "
		  %Libre_C1 =" %alpha_0    "
		  %Libre_C2 =" %psi  +  "
		  %anlam1Oratk= "%psi = %beta_0 -  %theta  %alpha_0  ~, ~  "+%anlam1Oratk 	   
	  endif
	  !ekGosterde=0
	  %Libre_SSum_Dep ="sum from{j=1} to{"+@word(%gostergeler,1)+"} { %beta_1j  %DELTA "+%LDependVar+"_{t-j} }"
	  %LibreO_ulaTxtLOrtak ="%eta _0   "+%LDependVar+"_{t-1} "
	  %ARDLFormF="ARDL("+@word(%gostergeler,1)
	     if(!DifferentAsymLag > 0 AND  !a_Svars >0 )then
	     !eklenecekSayi=1
	     else
	     !eklenecekSayi=0
	     
	     endif
	  
	  for !v=2 to !n_var
		%buDeg=  @word(%vars,!v)
		%LbuDeg=""""+%buDeg+""""
	      %Libre_SSum_InDep =%Libre_SSum_InDep +"+ sum from{j=0} to{"+@word(%gostergeler,!v+!ekGosterde)+"} { %beta_"+@str(!v)+"j   %DELTA "+%LbuDeg+"_{t-j} }"
	      %ARDLFormF=%ARDLFormF+","+@word(%gostergeler,!v+!ekGosterde)
	       %Libre_SSum_InDep2 =%Libre_SSum_InDep2 +" + %eta _"+@str(!v-1)+"   "+%LbuDeg+"_{t-1} "
	       %Libre_SSum_InDep1 =%Libre_SSum_InDep1 +" + %alpha _"+@str(!v-1)+"   "+%LbuDeg+"_{t } "
		    if !a_vars  > 0 then
			    
			    if  @wcount(@wintersect( %asvars , %buDeg )) then 
				  %LibreO_AsyShort= %LibreO_AsyShort+"+ sum from{j=0} to{"+@word(%gostergeler,!v+!ekGosterde)+"}{%beta^{size 12 {+"" ""}}_"+@str(!v)+"j %DELTA "+%LbuDeg+"^{size 12 {+"" ""}}_{t-j}}+"
				  !ekGosterde= !ekGosterde+!eklenecekSayi
				  %LibreO_AsyShort= %LibreO_AsyShort+"sum from{j=0} to{"+@word(%gostergeler,!v+!ekGosterde)+"} {%beta^{size 12 {-"" ""}}_"+@str(!v)+"j   %DELTA "+%LbuDeg+"^{size 12 {-"" ""}}_{t-j}}"
				 
			    else
				  %LibreO_AsyShort= %LibreO_AsyShort+"+ sum from{j=0} to{"+@word(%gostergeler,!v+!ekGosterde)+"} { %beta_"+@str(!v)+"j   %DELTA "+%LbuDeg+"_{t-j} }"
				  
			    endif
			     if  @wcount(@wintersect( %alvars , %buDeg )) then 
				      %LibreO_AsyLong=%LibreO_AsyLong+" + %eta^{size 12 {+"" ""}} _"+@str(!v-1)+"   "+%LbuDeg+"^{size 12 {+"" ""}}_{t-1} +  %eta^{size 12 {-"" ""}} _"+@str(!v-1)+"   "+%LbuDeg+"^{size 12 {-"" ""}}_{t-1} "
				      %LibreO_ulaAsyTxtS1 =%LibreO_ulaAsyTxtS1 +" + %alpha^{size 12 {+"" ""}} _"+@str(!v-1)+"   "+%LbuDeg+"^{size 12 {+"" ""}}_{t } +   %alpha^{size 12 {-"" ""}} _"+@str(!v-1)+"   "+%LbuDeg+"^{size 12 {-"" ""}}_{t }"
				  %anlamAsy1=%anlamAsy1+"  ~ , ~   %eta^{size 12 {+"" ""}} _"+@str(!v-1)+" `=  `-`{%theta  %alpha^{size 12 {+"" ""}} _"+@str(!v-1)+" } ~ , ~  %eta^{size 12 {-"" ""}} _"+@str(!v-1)+" =   `-{%theta  %alpha^{size 12 {-"" ""}} _"+@str(!v-1)+" } "
				  %anlamAsy2=%anlamAsy2+"  ~ , ~ %alpha^{size 12 {+"" ""}} _"+@str(!v-1)+" ` =`- `{  { %eta^{size 12 {+"" ""}} _"+@str(!v-1)+" }over  {%theta }}  ~ , ~ %alpha^{size 12 {-"" ""}} _"+@str(!v-1)+"  `=  ` - `{ { %eta^{size 12 {-"" ""}} _"+@str(!v-1)+" }over  {%theta }}  "
			
			     
			     else
				      %LibreO_AsyLong=%LibreO_AsyLong+" + %eta _"+@str(!v-1)+"   "+%LbuDeg+"_{t-1} "
				      %LibreO_ulaAsyTxtS1 =%LibreO_ulaAsyTxtS1 +" + %alpha _"+@str(!v-1)+"   "+%LbuDeg+"_{t } "
				 
			     	 %anlamAsy1=%anlamAsy1+"  ~ , ~  %eta _"+@str(!v-1)+" `= -  `{%theta  %alpha _"+@str(!v-1)+" } "
				  %anlamAsy2=%anlamAsy2+"  ~ , ~  %alpha _"+@str(!v-1)+" `=  - `{{ %eta _"+@str(!v-1)+" }over  {%theta }}  "
			 
			     endif
		    
		    
		    endif
	       %anlam1=%anlam1+"  ~ , ~  %eta _"+@str(!v-1)+" = -  `{%theta  %alpha _"+@str(!v-1)+" } "
	       %anlam2=%anlam2+"  ~ , ~ `{ %alpha _"+@str(!v-1)+" =`- ` { %eta _"+@str(!v-1)+" }over  {%theta }}  "
	       
	  next !v
	  %ARDLFormF=%ARDLFormF+")"
	  if !e_var >0 then
		for !v=1 to !e_var
		    %Libre_ex=%Libre_ex+"+ %gamma_"+@str(!v)+" """+@word(%evars,!v)+"""_{t}  "		
		 next !v		
	  endif
	  
	if(!rest = 3) then
	     %Libre_ex=%Libre_ex+" + %varphi t "
	endif
	  %LibreO_ECM =%Libre_Dependent +%Libre_C+%Libre_SSum_Dep+%Libre_SSum_InDep+%Libre_ex+"+ %theta  %epsilon _{t-1} + e_t" 
	  %LibreO_Long =%Libre_Long_Dependent+ %Libre_C1 +%Libre_SSum_InDep1+" + %epsilon _t"
	 %LibreO_ARDL =%Libre_Dependent +%Libre_C2+%LibreO_ulaTxtLOrtak+%Libre_SSum_InDep2+"+"+%Libre_SSum_Dep+%Libre_SSum_InDep+%Libre_ex+"+ e_t" 
	 %LibreO_AsyEq=  %Libre_Dependent +%Libre_C2+%LibreO_ulaTxtLOrtak+%LibreO_AsyLong+"+"+%Libre_SSum_Dep+%LibreO_AsyShort+%Libre_ex+"+ e_t" 
	  %LibreO_AsyEqShort=  %Libre_Dependent +%Libre_C2+%LibreO_ulaTxtLOrtak+%Libre_SSum_InDep2+"+"+%Libre_SSum_Dep+%LibreO_AsyShort+%Libre_ex+"+ e_t" 
	  %LibreO_AsyEqLong=  %Libre_Dependent +%Libre_C2+%LibreO_ulaTxtLOrtak+%LibreO_AsyLong+"+"+%Libre_SSum_Dep+%Libre_SSum_InDep+%Libre_ex+"+ e_t" 
	 
	 %LibreO_AsyTxt1=%Libre_Long_Dependent+ %Libre_C1 +%LibreO_ulaAsyTxtS1+" + %epsilon _t"
	    
    
    
    {%LibreFormulas}.append  ___Long run _________________________________________
    {%LibreFormulas}.append %LibreO_Long
     {%LibreFormulas}.append ___ECM_______________________________________________
    {%LibreFormulas}.append %LibreO_ECM
     {%LibreFormulas}.append ___ARDL______________________________________________
     {%LibreFormulas}.append %LibreO_ARDL
     {%LibreFormulas}.append ___Model_____________________________________________
     {%LibreFormulas}.append %ARDLFormF 
     {%LibreFormulas}.append _____Where___________________________________________
     %anlam1 = %anlam1Oratk + %anlam1 
     {%LibreFormulas}.append  %anlam1
     {%LibreFormulas}.append _____Long run Coeficients____________________________
     %anlam2 = %anlam2Ortak + %anlam2
     {%LibreFormulas}.append    %anlam2
     
      if(!a_vars  > 0) then
		
	      {%LibreFormulas}.append ____Asymetrics__________________________________
	      {%LibreFormulas}.append %LibreO_Asy1 
	      {%LibreFormulas}.append ____Asymetrics Long Run_________________________
	      {%LibreFormulas}.append  %LibreO_AsyTxt1 
	      {%LibreFormulas}.append ____Asymetrics Model____________________________
	      {%LibreFormulas}.append %LibreO_AsyEq 
	      {%LibreFormulas}.append _____Where___________________________________________
	      %anlamAsy1 = %anlam1Oratk+ %anlamAsy1
	      {%LibreFormulas}.append   %anlamAsy1 
	      {%LibreFormulas}.append _____Long run Coeficients____________________________
	      %anlamAsy2 = %anlam2Ortak + %anlamAsy2 
	      {%LibreFormulas}.append  %anlamAsy2
	       {%LibreFormulas}.append ____Asymetrics Short Run Model____________________________
	      {%LibreFormulas}.append %LibreO_AsyEqShort 
	       {%LibreFormulas}.append ____Asymetrics Long Run Model____________________________
	      {%LibreFormulas}.append %LibreO_AsyEqLong 
	      {%LibreFormulas}.append ____Asymetrics Dynamic____________________________
	      {%LibreFormulas}.append %LibreO_AsyDyn 
	      
	 endif    
endif
endsub

subroutine  MakeLsEquation ( scalar sayi )
if !ifVarLar=1 then
	%ls=""
 	%ls1=""
	%ls2=""
	%lsECM1=""
	%ARvars=""
	%lsAR=""
	%lsSAR=""
	!DegSay=0
	!SDegSay=!n_var
	if  @wcount(%alvars) >0   then
	!SDegSay=!SDegSay+@wcount(%alvars)
	endif
	%NARDLWaldTXTQ=""
	%NARDLWaldTXTp=""
	%NARDLWaldTXTm=""
	%NARDLEQ=""
	%ARDLNa=""
	%ARDLN=""
	!matrisSutunu1=0
	    for !v=1 to !n_var
            !DegSay=!DegSay+1
            %NARDLEpm=""
            %NARDLEpm2=""
            %degisken=@word(%vars,!v)
            !SNARDLsay= @wfind( %asvars , %degisken)
            '   @uiprompt(@str( !SNARDLsay)+ " >> "+%asvars + " ___ "+ %degisken)
            if(!v>1 AND  !SNARDLsay >0 ) then
                %buDegS1="NARDLWaldTxtS1"+@str(!SNARDLsay)
                %{%buDegS1}=""
                %buDegS2="NARDLWaldTxtS2"+@str(!SNARDLsay)
                %{%buDegS2}=""
            endif
            !LNARDLsay= @wfind( %alvars , %degisken)
            %buDegL="NARDLWaldTxtL"+@str(!LNARDLsay)
            %{%buDegL}=""

            ' !SNARDLsay=@wcount(@wintersect( %asvars , %degisken ))
            ' !LNARDLsay=@wcount(@wintersect( %alvars , %degisken ))
            if(!v>1 AND  !LNARDLsay >0) then	
                %ls1 =%ls1+" "+%degisken+"_N(-1) "+%degisken+"_P(-1) "
                %lsECM1=%lsECM1+" "+%degisken+"_N "+%degisken+"_P "
                !DegSay=!DegSay+1			
                %{%buDegL}=" -C("+@str(!DegSay-1)+")/c(1)  =-C("+@str(!DegSay)+")/c(1)   "
                '	@uiprompt(%NARDLWaldTxtL1)
                '	stop
            else
                %ls1 =%ls1+" "+%degisken+"(-1) "
                %lsECM1=%lsECM1+" "+%degisken+" "
            endif
	    'kisa döneme gidelim
            if(!v>1 ) then
                !basla=0
            else
                !basla=1		
            endif
            !matrisSutunu1=!matrisSutunu1+1    
            %ARDLNa=%ARDLNa+@str({%mn}(sayi,!matrisSutunu1))
            if( !v<!n_var )then            
                %ARDLNa=%ARDLNa+","
            endif       
            for !j=!basla to {%mn}(sayi,!matrisSutunu1)
                !SDegSay=!SDegSay+1
                if(!v>1 AND  !SNARDLsay >0 ) then
                    if %{%buDegS1}<>"" then
                        %NARDLEpm=" + "
                    endif                    
                    %{%buDegS1}=%{%buDegS1}+%NARDLEpm+"C("+@str(!SDegSay)+")   "
                    %LaggedVars=" d("+%degisken+"_N(-"+@str(!j)+"))"                    
                else                    
                    %LaggedVars=" d("+%degisken+"(-"+@str(!j)+")) "                    
                endif
                %ls2=%ls2+ %LaggedVars   '%ls2=%ls2+"_1_"+ %LaggedVars+"_2_"
            next j   
            if(!DifferentAsymLag > 0 AND  !a_Svars >0 AND !SNARDLsay >0)then
                !matrisSutunu1=!matrisSutunu1+1  
                
                %ARDLNa=@left(%ARDLNa,@length(%ARDLNa)-1)+":"+@str({%mn}(sayi,!matrisSutunu1)) '@left(%ARDLNa,@length(%ARDLNa)-1) remove last , 
                if( !v<!n_var)then
                    %ARDLNa=%ARDLNa+","
                endif                 
            endif
          
            for !j2=!basla to {%mn}(sayi,!matrisSutunu1)
                if(!v>1 AND  !SNARDLsay >0 ) then                    
                if %{%buDegS2}<>"" then
                    %NARDLEpm2=" + "
                endif
                %LaggedVars=" d("+%degisken+"_P(-"+@str(!j2)+")) "
                !SDegSay=!SDegSay+1
                %{%buDegS2}=%{%buDegS2}+%NARDLEpm2+"C("+@str(!SDegSay)+")   "
                
                    %ls2=%ls2+ %LaggedVars   '%ls2=%ls2+"_3_"+ %LaggedVars+"_4_"
                endif
            next j2
           ' {%Logtxt}.append ____________      
           ' {%Logtxt}.append %{%buDegS1} "=="  %{%buDegS2}  +" XXXX "+  !LNARDLsay   
	    next v

	       
	    
	    %ARDLN="ARDL("+%ARDLNa+")"
	    %DigerDegiskenler=%syntaxtrent+%syntaxintercept+" "+ %evars
	    %BagimliDegisken="  d("+@word(%vars,1)+") "
endif
endsub





subroutine MatrisOlustur()
if !ifVarLar=1 then
	%mn = @getnextname("ZZ___mat")	
	!yn_var=!n_var
	
	if(!a_Svars > 0)then 
        if(!DifferentAsymLag > 0)then 
        !yn_var=!n_var+!a_Svars
        endif
    endif
	
	    !toplam=(!maxlag+1)^!yn_var-(!maxlag+1)^(!yn_var-1) ' sifirdan baslayan icin
	    !baslangic=0 ' 0 sifirdan baslar

'	  @uiprompt(!toplam)
'	  stop
	matrix(!toplam ,!yn_var) {%mn}
	!satir=1
	
	for !k_1=1 to !maxlag
	{%mn}(!satir,1)=!k_1
	      if !yn_var>1 then
		  for !k_2=!baslangic to !maxlag
		  {%mn}(!satir,1)=!k_1
		  {%mn}(!satir,2)=!k_2
		  
		      if !yn_var>2 then
		      for !k_3=!baslangic to !maxlag
		      {%mn}(!satir,1)=!k_1
		      {%mn}(!satir,2)=!k_2
		      {%mn}(!satir,3)=!k_3
		      
			    if !yn_var>3 then
			    for !k_4=!baslangic to !maxlag
			    {%mn}(!satir,1)=!k_1
			    {%mn}(!satir,2)=!k_2
			    {%mn}(!satir,3)=!k_3
			    {%mn}(!satir,4)=!k_4
			    
                    if !yn_var>4 then
                    for !k_5=!baslangic to !maxlag
                    {%mn}(!satir,1)=!k_1
                    {%mn}(!satir,2)=!k_2
                    {%mn}(!satir,3)=!k_3
                    {%mn}(!satir,4)=!k_4
                    {%mn}(!satir,5)=!k_5
                    
                        if !yn_var>5 then
                        for !k_6=!baslangic to !maxlag
                        {%mn}(!satir,1)=!k_1
                        {%mn}(!satir,2)=!k_2
                        {%mn}(!satir,3)=!k_3
                        {%mn}(!satir,4)=!k_4
                        {%mn}(!satir,5)=!k_5			
                        {%mn}(!satir,6)=!k_6
                        
                            if !yn_var>6 then
                                for !k_7=!baslangic to !maxlag
                                {%mn}(!satir,1)=!k_1
                                {%mn}(!satir,2)=!k_2
                                {%mn}(!satir,3)=!k_3
                                {%mn}(!satir,4)=!k_4
                                {%mn}(!satir,5)=!k_5			
                                {%mn}(!satir,6)=!k_6			
                                {%mn}(!satir,7)=!k_7
                                
                                if !yn_var>7 then
                                for !k_8=!baslangic to !maxlag
                                {%mn}(!satir,1)=!k_1
                                {%mn}(!satir,2)=!k_2
                                {%mn}(!satir,3)=!k_3
                                {%mn}(!satir,4)=!k_4
                                {%mn}(!satir,5)=!k_5			
                                {%mn}(!satir,6)=!k_6			
                                {%mn}(!satir,7)=!k_7			
                                {%mn}(!satir,8)=!k_8
                                    if !yn_var>8 then
                                    for !k_9=!baslangic to !maxlag
                                    {%mn}(!satir,1)=!k_1
                                    {%mn}(!satir,2)=!k_2
                                    {%mn}(!satir,3)=!k_3
                                    {%mn}(!satir,4)=!k_4
                                    {%mn}(!satir,5)=!k_5			
                                    {%mn}(!satir,6)=!k_6			
                                    {%mn}(!satir,7)=!k_7			
                                    {%mn}(!satir,8)=!k_8			
                                    {%mn}(!satir,9)=!k_9
                                        if !yn_var>9 then
                                        for !k_10=!baslangic to !maxlag
                                        {%mn}(!satir,1)=!k_1
                                        {%mn}(!satir,2)=!k_2
                                        {%mn}(!satir,3)=!k_3
                                        {%mn}(!satir,4)=!k_4
                                        {%mn}(!satir,5)=!k_5			
                                        {%mn}(!satir,6)=!k_6			
                                        {%mn}(!satir,7)=!k_7			
                                        {%mn}(!satir,8)=!k_8			
                                        {%mn}(!satir,9)=!k_9			
                                        {%mn}(!satir,10)=!k_10
                                            if !yn_var>10 then
                                            for !k_11=!baslangic to !maxlag
                                            {%mn}(!satir,1)=!k_1
                                            {%mn}(!satir,2)=!k_2
                                            {%mn}(!satir,3)=!k_3
                                            {%mn}(!satir,4)=!k_4
                                            {%mn}(!satir,5)=!k_5			
                                            {%mn}(!satir,6)=!k_6			
                                            {%mn}(!satir,7)=!k_7			
                                            {%mn}(!satir,8)=!k_8			
                                            {%mn}(!satir,9)=!k_9			
                                            {%mn}(!satir,10)=!k_10			
                                            {%mn}(!satir,11)=!k_11									  
                                                if !yn_var>11 then
                                                for !k_12=!baslangic to !maxlag
                                                {%mn}(!satir,1)=!k_1
                                                {%mn}(!satir,2)=!k_2
                                                {%mn}(!satir,3)=!k_3
                                                {%mn}(!satir,4)=!k_4
                                                {%mn}(!satir,5)=!k_5			
                                                {%mn}(!satir,6)=!k_6			
                                                {%mn}(!satir,7)=!k_7			
                                                {%mn}(!satir,8)=!k_8			
                                                {%mn}(!satir,9)=!k_9			
                                                {%mn}(!satir,10)=!k_10		
                                                {%mn}(!satir,11)=!k_11			
                                                {%mn}(!satir,12)=!k_12		
                                                    if !yn_var>12 then
                                                    for !k_13=!baslangic to !maxlag
                                                    {%mn}(!satir,1)=!k_1
                                                    {%mn}(!satir,2)=!k_2
                                                    {%mn}(!satir,3)=!k_3
                                                    {%mn}(!satir,4)=!k_4
                                                    {%mn}(!satir,5)=!k_5			
                                                    {%mn}(!satir,6)=!k_6			
                                                    {%mn}(!satir,7)=!k_7			
                                                    {%mn}(!satir,8)=!k_8			
                                                    {%mn}(!satir,9)=!k_9			
                                                    {%mn}(!satir,10)=!k_10		
                                                    {%mn}(!satir,11)=!k_11			
                                                    {%mn}(!satir,12)=!k_12			
                                                    {%mn}(!satir,13)=!k_13				
                                                        if !yn_var>13 then
                                                        for !k_14=!baslangic to !maxlag
                                                        {%mn}(!satir,1)=!k_1
                                                        {%mn}(!satir,2)=!k_2
                                                        {%mn}(!satir,3)=!k_3
                                                        {%mn}(!satir,4)=!k_4
                                                        {%mn}(!satir,5)=!k_5			
                                                        {%mn}(!satir,6)=!k_6			
                                                        {%mn}(!satir,7)=!k_7			
                                                        {%mn}(!satir,8)=!k_8			
                                                        {%mn}(!satir,9)=!k_9			
                                                        {%mn}(!satir,10)=!k_10		
                                                        {%mn}(!satir,11)=!k_11			
                                                        {%mn}(!satir,12)=!k_12			
                                                        {%mn}(!satir,13)=!k_13			
                                                        {%mn}(!satir,14)=!k_14					  
                                            
                                            
                                            
                                            
                                                        !satir=!satir+1
                                                        next k_14
                                                        endif
                                    
                                                    next k_13
                                                else
                                                !satir=!satir+1
                                                endif 								
                                                next k_12
                                            else
                                            !satir=!satir+1
                                            endif 								
                                            next k_11
                                        else
                                        !satir=!satir+1
                                        endif 								
                                        next k_10
                                    else
                                    !satir=!satir+1
                                    endif 								
                                    next k_9
                                else
                                !satir=!satir+1
                                endif 
                                next k_8
                            else
                            !satir=!satir+1
                            endif 
                            next k_7
                        else
                        !satir=!satir+1
                        endif 
                        next k_6
                    else
                    !satir=!satir+1
                    endif 
                    next k_5
                else
                !satir=!satir+1
                endif 
                next k_4
            else
            !satir=!satir+1
            endif
            next k_3
        else
        !satir=!satir+1
        endif
        next k_2 
	else
	!satir=!satir+1
	endif
	next k_1

endif
endsub


subroutine MatrisOlustur2()
if !ifVarLar=1 then
	%mn = @getnextname("ZZ___mat")	
	!toplam=1
	matrix(1 ,!ulags_num) {%mn}
	for !j=1 to !ulags_num 
	  %v=@word(%userdefined,!j)
	  {%mn}(1,!j)={%v}		  
	 next j

endif
endsub


subroutine MakeGraph(string %i ,string %independent ,scalar !laglength)
' %i independent var.
if !ifVarLar=1 then
            local smpl
	    !bandwidth = 1.64
	    !multiplierlength=!Graphlength-1
	  %buSmpl={%eqname}.@smpl
	  %firstperiod = @word(%buSmpl,1)
	  %lastperiod = @word(%buSmpl,2)
	  !height = @obsrange
	  if @wcount(@wintersect( %avars , %independent  )) then 
	      !GASYM_var=1
	  else
	      !GASYM_var=0
	  endif
	  !BurdakiLaglength=!laglength+2 'making it work as d(dependent) make it smaller at begining of series


	  %Model=@getnextname("ZZ__Model")
	  %graph=@getnextname("ZZ__graph")
	  model {%Model}
	  {%Model}.merge  {%eqname}
	 
	'  %ttg={%eqname}.@smpl
	'  seterr ( %ttg)

	  if !GASYM_var>0 then
	    !uzunluq=14
	    %ind_P=%independent+"_P"
	    %ind_N=%independent+"_N"
	    {%Model}.append @identity {%independent} = {%ind_P} + {%ind_N}
	  '  {%Model}.append @identity  d{%i} = d({%i})
	  else
	    !uzunluq=10
	    %ind_P=%independent
	    %ind_N=%independent
	  endif

	  matrix(!height, !uzunluq) multiplier_h
	  smpl %firstperiod+!BurdakiLaglength  %lastperiod
	  {%Model}.scenario baseline
	' call WriteToLog(%firstperiod +@str(!laglength) +"1"+ %lastperiod )
	  
	  {%Model}.stochastic(c = t, b = .95)
	  {%Model}.solve(s = s, a = t)
	  {%Model}.scenario(c) "baseline"
	  '***Compute multiplier for {%independent}_p

	      {%Model}.scenario(n) "Scenario 2"
	      copy {%ind_P} {%ind_P}_2
	      {%Model}.override {%ind_P}
	      smpl %lastperiod-!multiplierlength %lastperiod
	      {%ind_P}_2 = {%ind_P}+1
	      smpl %firstperiod+!BurdakiLaglength  %lastperiod
	      {%Model}.stochastic(c = t, b = .95)
	      {%Model}.solve(s = s, a = t)

	    '***Restore baseline as active scenario

	      {%Model}.scenario baseline
	      smpl %firstperiod+!BurdakiLaglength  %lastperiod
	      {%Model}.stochastic(c = t, b = .95)
	      {%Model}.solve(s = s, a = t)
	      
	  if !GASYM_var >0 then
		{%Model}.scenario(n) "Scenario 3"
		copy {%ind_N} {%ind_N}_3
		{%Model}.override {%ind_N}
		smpl %lastperiod-!multiplierlength %lastperiod
		{%ind_N}_3 = {%ind_N}+1
		smpl %firstperiod+!BurdakiLaglength %lastperiod
		{%Model}.stochastic(c = t, b = .95)
		{%Model}.solve(s = s, a = t)

	  endif

	    '***Calculates the difference line and it's SE's:
	    
	      {%Model}.scenario(c) "Scenario 2"
	      {%Model}.stochastic(c = t, b = .95)
	      {%Model}.solve(s = s, a = t)

		  '***Places coefficients into matrix
	  if !GASYM_var >0 then
	  '      colplace(multiplier_h, {%i}_0_0m, 1)
	  '        colplace(multiplier_h, {%i}_0_0s, 2)
	  '         colplace(multiplier_h, {%i}_0m, 3)
	    '          colplace(multiplier_h, {%i}_0s, 4)
	    '           colplace(multiplier_h, {%i}_2_0m, 5)
	      '            colplace(multiplier_h, {%i}_2_0s, 6)
	      '             colplace(multiplier_h, {%i}_2m, 7)
		'             colplace(multiplier_h, {%i}_2s, 8)   
		  '              colplace(multiplier_h, {%i}_3_0m, 9)
		  '               colplace(multiplier_h, {%i}_3_0s, 10)
		    '                colplace(multiplier_h, {%i}_3_2m, 11)
		    '                 colplace(multiplier_h, {%i}_3_2s, 12)
		      '                  colplace(multiplier_h, {%i}_3m, 13)
		      '                   colplace(multiplier_h, {%i}_3s, 14)

	  else
	  '    colplace(multiplier_h, {%i}_0_0m, 1)
	  '    colplace(multiplier_h, {%i}_0_0s, 2)
	  '   colplace(multiplier_h, {%i}_0_2m, 3)
	    '  colplace(multiplier_h, {%i}_0_2s, 4)
	    ' colplace(multiplier_h, {%i}_0m, 5)
	      'colplace(multiplier_h, {%i}_0s, 6)
	  '    colplace(multiplier_h, {%i}_2_0m, 7)
	  '   colplace(multiplier_h, {%i}_2_0s, 8)
	    '  colplace(multiplier_h, {%i}_2m, 9)
	    ' colplace(multiplier_h, {%i}_2s, 10)   
	  endif
	  '***Plot multipliers
	      
		'  smpl %lastperiod-!multiplierlength+1 %lastperiod
		'  series tarih =1
		' tarih= @cumsum(tarih)
		 smpl %lastperiod-!multiplierlength-1 %lastperiod
		 
	  %trend=@getnextname("ZZ__trend")
	  %index=@getnextname("ZZ__index")
	  %mygroup=@getnextname("ZZ__mygroup")
	  series {%trend}=@trend 
	  series {%index} = {%trend}-@first({%trend})
	   smpl %lastperiod-!multiplierlength-1 %lastperiod
	  %legendArti=%independent+ " +"
	  %legendEksi=%independent+ " -"
	  if !GASYM_var >0 then
	      if !PlotDiffs=1 then
		  if !PlotTrashhold=1 then
		      group {%mygroup}  {%index}  {%i}_2_0m -{%i}_3_0m -{%i}_3_2m (-{%i}_3_2m + !bandwidth*{%i}_3_2s) (-{%i}_3_2m - !bandwidth*{%i}_3_2s)
		  else
		      group {%mygroup}  {%index}  {%i}_2_0m -{%i}_3_0m -{%i}_3_2m 		  
		  endif
	      else
		group {%mygroup}  {%index}  {%i}_2_0m -{%i}_3_0m 	      
	      endif
	 else
	      if !PlotDiffs=1 then
		group {%mygroup}  {%index}   {%i}_2_0m -{%i}_2_0m ({%i}_2_0m -{%i}_2_0m)
	      else
		group {%mygroup}  {%index}   {%i}_2_0m -{%i}_2_0m 	      
	      endif
	 endif
	    
	    freeze({%graph}) {%mygroup}.xyline
		
		{%graph}.shade(shade, left) 0
		{%graph}.options linepat
		{%graph}.setelem(1) lcolor({%IncreaseColor}) lwidth(!IncreaseWidth) lpat(!IncreasePat) legend() 
		{%graph}.setelem(2) lcolor({%DecreaseColor}) lwidth(!DecreaseWidth ) lpat(!DecreasePat) legend({%legendArti})
		{%graph}.setelem(3) lcolor({%DiffColor}) lwidth(!DiffWidth) lpat(!DiffPat) legend({%legendEksi}) 		
		{%graph}.setelem(4) lcolor({%TrashholdColor}) lwidth(!TrashholdWidth ) lpat(!TrashholdPat) legend(diff) 
		{%graph}.setelem(5) lcolor({%TrashholdColor}) lwidth(!TrashholdWidth) lpat(!TrashholdPat)legend()
		{%graph}.setelem(6) lcolor(red) lwidth(0) lpat(2) legend()
		{%graph}.options size(4,2) -inbox
		{%graph}.legend position(botcenter)
'		  {%graph}.shade(shade, left) 0
'		  {%graph}.options linepat
'		  {%graph}.setelem(2) lcolor(black) lwidth(2) lpat(1)legend({%legendEksi})		
'		  {%graph}.setelem(3) lcolor(red) lwidth(2) lpat(1) legend(diff) 
'		  {%graph}.setelem(1) lcolor(black) lwidth(2) lpat(2) legend({%legendArti}) 
'		  {%graph}.setelem(4) lcolor(red) lwidth(1) lpat(2) legend() 
'		  {%graph}.setelem(5) lcolor(red) lwidth(1) lpat(2)legend()	       
'		  {%graph}.options size(4,2) -inbox
'		  {%graph}.axis(bottom) 
		
	      
	    '***Clean up
		  smpl %buSmpl
		 
	    delete {%independent}_0* {%independent}_2*  {%independent}_3* d{%independent}_0* d{%independent}_2*  d{%independent}_3*
	    delete {%ind_P}_0* {%ind_P}_2*  {%ind_P}_3* d{%ind_P}_0* d{%ind_P}_2*  d{%ind_P}_3* 
	    delete {%ind_N}_0* {%ind_N}_2*  {%ind_N}_3* d{%ind_N}_0* d{%ind_N}_2*  d{%ind_N}_3*
	    delete {%i}_0* {%i}_2*  {%i}_3* d{%i}_0* d{%i}_2*  d{%i}_3* 
	  delete multiplier_h {%Model}
  
 '###################################################################  


endif
endsub


subroutine ShortRunECM(  )
if !ifVarLar=1 then
  %LRECM= @getnextname("ZZ__LRECM")
 %SRECM= @getnextname("ZZ__SRECM")
    if @isobject("ECM") then 
    %LRECMresid= @getnextname("ECM")
    else
    %LRECMresid= "ECM"
    endif
  
	'equation {%LRECM}.ls  {%vars}   {%syntaxintercept} 
	equation {%LRECM}.ls   {%lsECM1}   {%syntaxintercept} 

	{%LRECM}.makeresid {%LRECMresid}

	if !criterion=4 then
	    %KisaDonemVars =   %BagimliDegisken+ %DigerDegiskenler+" "+%LRECMresid+"(-1)"+" @ "+%ls2
	    equation {%SRECM}.stepls(method = uni, back, btol = 0.05)    {%KisaDonemVars}	   
	else
	    %KisaDonemVars =   %BagimliDegisken+ %DigerDegiskenler+%ls2+%LRECMresid+"(-1)"
	    equation {%SRECM}.ls {%KisaDonemVars}
	   
	endif
	
endif
endsub

subroutine UzunDonem()
if !ifVarLar=1 then

	%longRun = @getnextname("ZZ__longRun")
	table {%longRun} 
		%TheResults=@getnextname("TheResults")
		freeze({%TheResults}) {%eqname}
		
		sym zcov1={%eqname}.@coefcov
		
	{%longRun}(1,1)="Variable"
	{%longRun}(1,2)="Coeficient"
	{%longRun}(1,3)="Std. Error"
	{%longRun}(1,4)="t-statistic"
	{%longRun}(1,5)="Prob."
	!dep_coef={%eqname}.@coefs(1)
	!mydf={%eqname}.@df'{%eqname}.@df
	!n_LongVars=@wcount(%lsECM1)
		for !j=2 to !n_LongVars
			%v=@word(%lsECM1,!j)
			{%longRun}(!j,1)=%v
			!ind_coef={%eqname}.@coefs(!j)
			!A=1/!dep_coef
			!B=-!ind_coef/!dep_coef^2
			!longRuncoef=-!ind_coef/!dep_coef
			{%longRun}(!j,2)=!longRuncoef
			
			 !stde= @sqrt((!A^2)*zcov1(!j,!j)+2*!A*!B*zcov1(!j,1)+(!B^2)*zcov1(1,1)) '@sqrt({%eqname}.@coefcov(!j,!j))
			  {%longRun}(!j,3)=!stde
			  !myt=!longRuncoef/!stde
			 {%longRun}(!j,4)=!myt			
			 {%longRun}(!j,5)= 2* @ctdist(-abs(!myt),!mydf)
			'{%longRun}(!j,4)=-{%eqname}.@coefs(!j)/!dep_coef
		next j	
	!ConstantRow={%eqname}.@ncoefs
	{%longRun}(!j,1)="C"
	!ind_coef={%eqname}.@coefs(!ConstantRow)
		!A=1/!dep_coef
		!B=-!ind_coef/!dep_coef^2		
		!longRuncoef=-!ind_coef/!dep_coef
		{%longRun}(!j,2)=!longRuncoef
		!stde= @sqrt((!A^2)*zcov1(!ConstantRow,!ConstantRow)+2*!A*!B*zcov1(!ConstantRow,1)+(!B^2)*zcov1(1,1)) '@sqrt({%eqname}.@coefcov(!j,!j))
		{%longRun}(!j,3)=!stde
		!myt=!longRuncoef/!stde
		{%longRun}(!j,4)=!myt
		{%longRun}(!j,5)= 2* @ctdist(-abs(!myt),!mydf)
 
endif
endsub


subroutine TabloBasiHazirla()
if !ifVarLar=1 then

      %statmsg4="Stimating"
    '  statusline %statmsg4
      !a_1=1000000
      !a_2=!a_1
      !a_3=!a_1
      !a_4=!a_1
      !b_1=0
      !b_2=0
      !b_3=0
      !b_4=0
      !a_1y=!n_var+1
      !a_2y=!n_var+2
      !a_3y=!n_var+3

	%tn = @getnextname("ZZ__tabletest")
	table {%tn} 
	%tn2 = @getnextname("ZZ__tabletest2")
	table {%tn2} 
	' {%tn}.displayname "All Computed information criterion values"
	' {%tn2}.label "Best Models based on information criterion values"
	{%tn}(1,1)="ARDL"
	{%tn}(1,2)="AIC"
	{%tn}(1,3)="Schwarz"
	{%tn}(1,4)="Hannan-Quinn"
	{%tn}(1,5)="Log Likelihood"
	
      {%tn2} ={%tn}
	'{%tn}(1,6)="LS"
endif
endsub

subroutine TabloSonuHazirla()
if !ifVarLar=1 then

	{%tn2}(2,2)= %LagArdl1
	{%tn2}(2,3)= %LagArdl2
	{%tn2}(2,4)= %LagArdl3
	{%tn2}(2,5)= %LagArdl4
	{%tn2}(3,1)="Selected criterion is colored. Max lag is "+%maxlag
	
      if(!criterion=1)then
     
      call GecikmeHesapla(!b_1)
       {%tn}.setfillcolor(!b_1+1) @rgb(255, 255, 0)
      {%tn2}.setfillcolor(2,2) @rgb(255, 255, 0)
      endif
      if(!criterion=2)then
    '   @uiprompt(@str(!b_2)+" > "+ %buDegS1+" > "+ %buDegS2  )
      call GecikmeHesapla(!b_2)
      {%tn}.setfillcolor(!b_2+1) @rgb(255, 255, 0)
      {%tn2}.setfillcolor(2,3) @rgb(255, 255, 0)
      endif
      if(!criterion=3)then
      call GecikmeHesapla(!b_3)
      {%tn}.setfillcolor(!b_3+1) @rgb(255, 255, 0)
      {%tn2}.setfillcolor(2,4) @rgb(255, 255, 0)
      endif
      if(!criterion=4)then
      call GecikmeHesapla(!b_4)
      {%tn}.setfillcolor(!b_4+1) @rgb(255, 255, 0)
      {%tn2}.setfillcolor(2,5) @rgb(255, 255, 0)
      endif

	{%tn}(!b_1+1,2)= {%tn}(!b_1+1,2)+"*"
	{%tn}(!b_2+1,3)= {%tn}(!b_2+1,3)+"*" 
	{%tn}(!b_3+1,4)= {%tn}(!b_3+1,4)+"*"
	{%tn}(!b_4+1,5)= {%tn}(!b_4+1,5)+"*"
	{%tn}.setfont(!b_1+1 ) "Times New Roman" -s +u  +b
	{%tn}.setfont(!b_2+1 ) "Times New Roman" -s +u  +b
	{%tn}.setfont(!b_3+1 ) "Times New Roman" -s +u  +b   
	{%tn}.setfont(!b_4+1 ) "Times New Roman" -s +u  +b
	
	{%tn2}.setlines(@all) +a
	
endif
endsub

subroutine TabloOzetEkle(  string %bir,string %iki,string %uc)
if !ifVarLar=1 then
     !tabloOzetSira= !tabloOzetSira+1
     {%OzetTable}(!tabloOzetSira,1)= %bir
     {%OzetTable}(!tabloOzetSira,2)= %iki
     {%OzetTable}(!tabloOzetSira,3)= %uc
endif
endsub


subroutine TabloRenkEkle(  string %bir,string %iki,scalar !rengi) 
if !ifVarLar=1 then
    '!rengi 1: onay ,2 :ret , 3:belki
    
    %ucuncu=@word(%TableStatus,!rengi)
     call TabloOzetEkle(   %bir, %iki, %ucuncu)
     if !rengi=1 then 'onayli
	 %color="green"
	 %colora="white"
	else
	    if  !rengi=2  then 'ret
	       %color="red"
	      %colora="white"
	    else
		  if  !rengi=3  then 'belki
		   %color="yellow"
	    %colora="blue"
		 
		  endif
	    endif
      endif
	 {%OzetTable}.settextcolor(!tabloOzetSira,1,!tabloOzetSira,3)  {%colora}
	  {%OzetTable}.setfillcolor(!tabloOzetSira,1,!tabloOzetSira,3)  {%color}
	
endif
endsub

