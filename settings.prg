!debug = 0

'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Defult in []
	%vars="" 	' [""] All vars
	%evars="" 	' [""] Exogenous Variables 
	%asvars="" 	' [""] Short-run Asymmetric Variables
	%alvars="" 	' [""] Long-run Asymmetric Variables
	
	%maxlag = "3" 	' ["3"] 
	!sig=2 		' [2] significance level for automatic differencing test     1 = 1%, 2=5%, 3=10%
	!rest=2	 	' [2] ""No intercept and no trend""  ""intercept and no trend"" ""Intercept and trend""
	!Astype=1 	' [1] ""Short Run"" ""Long Run"" ""Both""
	%userdefined="" ' [""] User defined ARDL lags
	!criterion=2	' [1]  ""Akaike Info Criterion(AIC)"" ""Schwarz Criterion(SC)"" ""Hannan-Quinn criter"" ""General to Specified""	
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Proccess Settings
        !KeepMainFrame=1	' [0] Save All results in workfile.
	!KeepEquation=1		' [0] Save final equation in workfile.
	!keepAbstract=0		' [0] Save final Abstract in workfile.
	!AddCriterionTable=1	' [1] Add  Criterion Table values in output.
	!MakeLibreFormulas=1	' [1] Add  Libre Office formulas in output.
	!incZeroLag=1		' [1] start Zero lag of ind vars? Sum from 0 to p	
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Plot Settings
	!PlotShortRun=0	' [0] Plot short run effects in model.
	!DifferentAsymLag=0	' [0] different Asymmetric Variables Lag.
	!KeepPlot=0	' [0] Save all Plots in model.
	!Graphlength=39 ' [39] multiplier Graph length
	!PlotDiffs=1	' [1]	Add differences of two options.
	!PlotTrashhold=1' [1]	Add trasholds for Asymmetric ARDL.
	%IncreaseColor="black"	' [black] regular colors
	%DecreaseColor="blue"	' [blue]
	%DiffColor="red"	' [red]
	%TrashholdColor="red"	' [red]
	!IncreaseWidth=2	' [2]
	!DecreaseWidth=2	' [2]
	!DiffWidth=2		' [2]
	!TrashholdWidth=1	' [1]
	!IncreasePat=4		' [4]
	!DecreasePat=1		' [1]
	!DiffPat=1		' [1]
	!TrashholdPat=2		' [2]
	

	
'@@@@@@@@@@@@@@@@@@@@@@@@@@@@@q
	%caption="Non Linear And Linear ARDL Bound Approach"
	%nameofvars="Enter name of variables. First variable would be set as depended variable"
	
	%ExogenousTxt="Exogenous Variables "
	
	
	%LAsymmetricTxt="Long-run Asymmetric Variables "
	%SAsymmetricTxt="Short-run Asymmetric Variables "
	
	
	%ResUnresText="What is you Model Type"
	%ResUnres="""No intercept and no trend""  ""intercept and no trend"" ""Intercept and trend"""
	%maxlagT ="Maximum lag (k-1)"

		
	%sigprompt="Significance level"
	%sigchoice=" ""1%"" ""5%"" ""10%"""
	%userdefinedText="User defined ARDL lags"
	%critprompt="Which criterion do you want to use?"
	%critchoice=" ""Akaike Info Criterion (AIC)"" ""Schwarz Criterion (SC)"" ""Hannan-Quinn Criterion (HQ)"" ""General to Specified"""
%TableStatus="""Valid"" ""Rejected"" ""Ambiguous"""
'	%incZeroLagTxt="start Zero lag of ind vars?"
	%incZeroStartTxt="include Zero lag of model?"

	
	%PlotShortRun ="Plot Short run multiplier"
	%DifferentAsymLag="different Asymmetric Vars Lags"


