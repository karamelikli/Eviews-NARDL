

	
	'-------------------------------------------------------- Get Opened SERIES name' 

	if %type= "GROUP" AND %vars=""  then
	
	    for !i=1 to _this.@count
	    %vars=%vars+" "+  _this.@seriesname(!i)
	    next i
	endif
!licence=1
%DifferentAsymLag2="yyyyyyyyyy"
	'------------------------ End of Get Opened SERIES name' 
	'Bringing up the user selection dialog'
	!result = @uidialog( "Caption",%caption, _

			 _
		      "edit", %vars,%nameofvars,300, _
		      "edit", %evars,%ExogenousTxt,100, _
		      "edit", %asvars,%SAsymmetricTxt,100, _
		      "edit", %alvars,%LAsymmetricTxt,100, _
				"text", "For more information, contact Huseyin Karamelikli at https://github.com/karamelikli/Eviews-NARDL", _	      
		      "edit",%maxlag,%maxlagT,10, _
		      "list",!sig,%sigprompt,%sigchoice, _
		      "edit", %userdefined,%userdefinedText,50 , _
		      "list",!criterion,%critprompt,%critchoice, _
		      "list",!rest,%ResUnresText,%ResUnres, _
		      "check",!PlotShortRun, %PlotShortRun, _
		      "check",!DifferentAsymLag, %DifferentAsymLag _
		      
		      
		      )
	




