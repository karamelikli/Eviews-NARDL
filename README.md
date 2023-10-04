# N-ARDL Eviews 

This add-in can estimate the symmetric and asymmetric ARDL in [Eviews](https://eviews.com). All necessary tests are included in the results panel. 
This Add-in helps analyze linear and non-linear ARDL. There are four options that users can select:

 - Linear Format (ordinary ARDL)
 - Asymmetry in both short and long-run
 - Asymmetry in short-run and symmetry in long-run
 - Symmetry in  short-run and asymmetry in long-run

External variables, like dummy variables, can be added to the model. 

The old version of this project [https://github.com/karamelikli/Eviews.NARDL](https://github.com/karamelikli/Eviews.NARDL) migrated here. The previous version is not supported anymore. 

### Contributors

This add-in is dedicated to the renowned economist **Prof. Mohsen Bahmani Oskooee**.

This code has been written by  [Huseyin Karamelikli](https://github.com/karamelikli) (Hossein Haghparast Gharamaleki). Thanks to Yashar Tarverdi. His works are expanded here in some directions.

For further contributions and advice, please visit [https://github.com/karamelikli/Eviews.NARDL](https://github.com/karamelikli/Eviews.NARDL) 

All new commits are welcome.

### Current version

The last version of the executable add-in (N-ARDL.aipz) is **2.55**.

## Installation
Download N-ARDL.aipz file from this repository and click on it or download from addins menu in Eviews.

## Manual 
Open a series or a group of time series in Eviews. Then, click on Add-in > Make N-ARDL Bound Test

![Open the Add-in](https://github.com/karamelikli/Eviews-NARDL/assets/6809318/0482d41d-53e2-49ab-8ca2-c74534bd645f)
All of your selected series will be displayed in the variables box. The first one is your dependent variable. You can enter dummy variables in the Exogenous Variables box. If you want to define a variable as an asymetric one, you should put its name in both short-run and long-run asymmetric variables boxes. Otherwise, you can have asymmetry just in the short-run or long-run based on the boxes filled. 
By selcting Plot, dynamic multipliers will be plotted. If you prefer to diffentiation of lags of asymetric variables in Negative and Positive decompositions you should check **different Asymmetric Vars Lags**.

![Main menu](https://github.com/karamelikli/Eviews-NARDL/assets/6809318/ffa5d563-baba-44a7-a39b-6ff119df6966)
The results would be as follows. The first page is an abstract of all contained results, which may be useful to see all the results at a glance. 

![The reulsts](https://github.com/karamelikli/Eviews-NARDL/assets/6809318/c31d79b8-a797-4c24-858e-53f77df91cea)

  
# How to Use OpenOffice/LibreOffice to make the model’s formulas

All required formulas would be produced in the final panel. It can be copied and pasted to LibreOffice. Then, selecting and clicking on insert formula object or by menu (Insert > Object > Formula Object...) will change it to a regular visible formula. You can continue working on LibreOffice or save it as a .docx file if you are willing to continue in MS Word.

# Theoretical Framework

## The long-run model is defined as follow: 
$${y}_t =  \alpha_0     + \alpha _1   {x}_{t }  + \alpha _2   {z}_{t }  + \epsilon _t $$

## The error correction model can be defined as: 

$$\Delta {y}_t =  \beta_0 +  \sum_{j=1}^{p} { \beta_{1j}  \Delta {y}_{t-j} }+ \sum_{j=0}^{q} { \beta_{2j}   \Delta {x}_{t-j} }+ \sum_{j=0}^{n} { \beta_{3j}   \Delta {z}_{t-j} }+ \gamma_1 {W}_{t}  + \theta  \epsilon _{t-1} + e_t $$

### By using the long-run model into the ECM model we can have: 

$$\Delta {y}_t =  \psi  +  \eta _0   {y}_{t-1}  + \eta _1   {x}_{t-1}  + \eta _2   {z}_{t-1} +\sum_{j=1}^{p} { \beta_{1j}  \Delta {y}_{t-j} }+ \sum_{j=0}^{q} { \beta_{2j}   \Delta {x}_{t-j} }+ \sum_{j=0}^{n} { \beta_{3j}   \Delta {z}_{t-j} }+ \gamma_1 {W}_{t}  + e_t $$

### We have ARDL model with following definiation: 

$$ARDL(p,q,n) $$

### We used following modifications to obtain the ARDL model: 

$$\psi = \beta_0 -  \theta  \alpha_0  ~, ~    \eta _0  =\theta  ~ , ~  \eta _1 = -{\theta  \alpha _1 }   ~ , ~  \eta _2 = -{\theta  \alpha _2 }  $$

## Then, for reobtaining the long-run coefficients...: 

$$~ \theta  = \eta _0    ~ , ~ { \alpha _1 =- \frac { \eta _1 }  {\theta }}    ~ , ~ { \alpha _2 =- \frac { \eta _2 }  {\theta }}  $$

## Asymetrics : 

$${x}^{+ }_t = \sum_{i=1}^{t} { \Delta {x}^{+ }_i } =  \sum_{i=1}^{t} {max(\Delta {x}_i ,0) } ~;~{x}^{- }_t = \sum_{i=1}^{t} { \Delta {x}^{- }_i }=  \sum_{i=1}^{t} {min(\Delta {x}_i ,0) } $$

## Asymetrics Long Run : 

$${y}_t =  \alpha_0     + \alpha^{+ } _1   {x}^{+ }_{t } +   \alpha^{- } _1   {x}^{- }_{t } + \alpha _2   {z}_{t }  + \epsilon _t $$

## Asymetrics Model : 

$$\Delta {y}_t =  \psi  +  \eta _0   {y}_{t-1}  + \eta^{+ } _1   {x}^{+ }_{t-1} +  \eta^{- } _1   {x}^{- }_{t-1}  + \eta _2   {z}_{t-1} +\sum_{j=1}^{p} { \beta_{1j}  \Delta {y}_{t-j} }+ \sum_{j=0}^{q}{\beta^{+ }_{2j} \Delta {x}^{+ }_{t-j}}+\sum_{j=0}^{m} {\beta^{- }_{2j}   \Delta {x}^{- }_{t-j}}+ \sum_{j=0}^{n} { \beta_{3j}   \Delta {z}_{t-j} }+ \gamma_1 {W}_{t}  + e_t $$

### Where: 

$$\psi = \beta_0 -  \theta  \alpha_0  ~, ~    \eta _0  =\theta  ~ , ~   \eta^{+ } _1 =  -{\theta  \alpha^{+ } _1 } ~ , ~  \eta^{- } _1 =   -{\theta  \alpha^{- } _1 }   ~ , ~  \eta _2 = -{\theta  \alpha _2 }  $$

## Long run Coeficients: 

$$~ \theta  = \eta _0    ~ , ~ \alpha^{+ } _1  =- { \frac { \eta^{+ } _1 }  {\theta }}  ~ , ~ \alpha^{- } _1   =  -{ \frac{ \eta^{- } _1 }  {\theta }}    ~ , ~  \alpha _2 =  -{\frac{ \eta _2 }  {\theta }} $$

## Asymetrics Short Run Model: 

$$\Delta {y}_t =  \psi  +  \eta _0   {y}_{t-1}  + \eta _1   {x}_{t-1}  + \eta _2   {z}_{t-1} +\sum_{j=1}^{p} { \beta_{1j}  \Delta {y}_{t-j} }+ \sum_{j=0}^{q}{\beta^{+ }_{2j} \Delta {x}^{+ }_{t-j}}+\sum_{j=0}^{m} {\beta^{- }_{2j}   \Delta {x}^{- }_{t-j}}+ \sum_{j=0}^{n} { \beta_{3j}   \Delta {z}_{t-j} }+ \gamma_1 {W}_{t}  + e_t $$

## Asymetrics Long Run Model: 

$$\Delta {y}_t =  \psi  +  \eta _0   {y}_{t-1}  + \eta^{+ } _1   {x}^{+ }_{t-1} +  \eta^{- } _1   {x}^{- }_{t-1}  + \eta _2   {z}_{t-1} +\sum_{j=1}^{p} { \beta_{1j}  \Delta {y}_{t-j} }+ \sum_{j=0}^{q} { \beta_{2j}   \Delta {x}_{t-j} }+ \sum_{j=0}^{n} { \beta_{3j}   \Delta {z}_{t-j} }+ \gamma_1 {W}_{t}  + e_t $$

## Asymetrics Dynamic: 

$$m^{+ } _h =  \sum_{i=0}^{h}  { \frac{ \partial  {y} _{t+i} } {\partial  {x}^{+ } _t}  } ~;~ m^{- } _h =  \sum_{i=0}^{h}  { \frac{ \partial  {y} _{t+i} } {\partial  {x}^{- } _t}  }  \\  \lim_ { h  \to    \infty  } m^{+ } _h  =  \alpha^{+ } _1 ~ , ~  \lim_ { h  \to    \infty  } m^{- } _h  =  \alpha^{- } _1   $$


 

 
## Options
***Please don't change the default options unless you have the required knowledge about them.*** 
For any additional options, open `C:\Users\YOURUSERNAME\Documents\EViews Addins\N-ARDL\settings.prg` and modify the values in the parentheses. 


| Option | Default | Description |
|--------| --------| ------------|
| treeSortable | #tree | The tree root ID selector. If you change the root selector then you have to update the CSS as per requirements.|
| %vars|  	|  All vars that should be in the all variables boxes| 
| %evars|  	|Exogenous Variables |
| %asvars|  	|Short-run Asymmetric Variables|
|	%alvars|  	|Long-run Asymmetric Variables|
|%maxlag |3|Max lag | 
|!sig|2|significance level for automatic differencing test     1 = 1%, 2=5%, 3=10%|
|!rest|2| 1 "No intercept and no trend" 2 "intercept and no trend" 3"Intercept and trend"|
|	!Astype|1|1 "Short Run" 2"Long Run" 3"Both"|
|	%userdefined||User defined ARDL lags|
|	!criterion|2|1 "Akaike Info Criterion(AIC)" 2 "Schwarz Criterion(SC)" 3"Hannan-Quinn criter" 4 "General to Specified"|

### Process Settings
Yes=1 No=0

| Option | Default | Description |
|--------| --------| ------------|
|!KeepMainFrame|1|Save All results in workfile|
|	!KeepEquation|1|Save final equation in workfile|
|	!keepAbstract|0|Save final Abstract in workfile|
|	!AddCriterionTable|1|Add  Criterion Table values in output|
|	!MakeLibreFormulas|1|Add  Libre Office formulas in output|
|	!incZeroLag|1|start Zero lag of ind vars? Sum from 0 to p	|

### Plot Settings
Yes=1 No=0

| Option | Default | Description |
|--------| --------| ------------|
|	!PlotShortRun|0	|Plot short run effects in model.|
|	!DifferentAsymLag|0	|different Asymmetric Variables Lag.|
|	!KeepPlot|0	|Save all Plots in model|
|	!Graphlength|39|multiplier Graph length|
|	!PlotDiffs|1	|Add differences of two options.|
|	!PlotTrashhold|1|Add trasholds for Asymmetric ARDL.|
|	%IncreaseColor|black|regular colors|
|	%DecreaseColor|blue|Decrease Color|
|	%DiffColor|red|Diff Color|
|	%TrashholdColor|red|Trashhold Color|
|	!IncreaseWidth|2	|Increase Width|
|	!DecreaseWidth|2	|Decrease Width|
|	!DiffWidth|2	|Diff Width|
|	!TrashholdWidth|1	|Trashhold Width|
|	!IncreasePat|4	|Increase Pat|
|	!DecreasePat|1	|Decrease Pat|
|	!DiffPat|1	|Diff Pat|
|	!TrashholdPat|2|Trashhold Pat|
	
### Texts
| Option | Default |
|--------| --------|
|	%caption|Non Linear And Linear ARDL Bound Approach|
|%nameofvars|Enter name of variables. First variable would be set as depended variable|
|	%ExogenousTxt|Exogenous Variables |
|	%LAsymmetricTxt|Long-run Asymmetric Variables |
|	%SAsymmetricTxt|Short-run Asymmetric Variables|
|%ResUnresText|What is you Model Type|
|	%ResUnres|"""No intercept and no trend""  ""intercept and no trend"" ""Intercept and trend"""|
|	%maxlagT |Maximum lag (k-1)|
|	%sigprompt|Significance level|
|	%sigchoice| ""1%"" ""5%"" ""10%""|
|	%userdefinedText|User defined ARDL lags|
|	%critprompt|Which criterion do you want to use?|
|	%critchoice| ""Akaike Info Criterion (AIC)"" ""Schwarz Criterion (SC)"" ""Hannan-Quinn Criterion (HQ)"" ""General to Specified""|
|%TableStatus|""Valid"" ""Rejected"" ""Ambiguous""|
|	%incZeroStartTxt|include Zero lag of model?|
|	%PlotShortRun|Plot Short run multiplier|
|	%DifferentAsymLag|different Asymmetric Vars Lags|

