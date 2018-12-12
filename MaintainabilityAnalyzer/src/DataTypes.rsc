module DataTypes

alias Rank = tuple[str rank, str label];
alias Ranking = tuple[tuple[str rank, str label] veryHigh,
	tuple[str rank, str label] high,
	tuple[str rank, str label] moderate,
	tuple[str rank, str label] low,
	tuple[str rank, str label] veryLow];

public Ranking Rankings = <
	<"++", "Very high">,
	<"+", "High">,
	<"o", "Moderate">,
	<"-", "Low">,
	<"--", "Very low">
>;

alias RiskValues = tuple[UnitInfos units, int linesOfCode, num percentage];

alias MetricTresholds = tuple[num moderate, num high, num veryHigh];

alias RiskCategory = tuple[str category, str risk];
alias RiskCategories = tuple[RiskCategory low,
	RiskCategory moderate,
	RiskCategory high,
	RiskCategory veryHigh
];

alias RiskEvaluation = map[RiskCategory category, RiskValues values]; 

public RiskCategories RiskCategories = <
	<"Simple", "Without much risk">,
	<"More complex", "Moderate risk">,
	<"Complex", "High risk">,
	<"Untestable", "Very high risk"> 
>;
	
alias LineCounts = tuple[loc location, int code, int comment, int blank, int total];


alias LineOfCode = tuple[str line, loc location];
alias LinesOfCode = list[LineOfCode];


alias UnitInfo = tuple[loc unit, int size, int complexity];
alias UnitInfos = set[UnitInfo];

alias VolumeAnalysisResult = tuple[Rank ranking, int totalLinesOfCode, int codeLines, int blankLines, int commentLines, set[LineCounts] counts];

alias UnitSizeAnalysisResult = tuple[Rank ranking, RiskEvaluation risk, int unitsCount];

alias ComplexityAnalysisResult = tuple[Rank ranking, RiskEvaluation risk, int unitsCount];

alias DuplicationAnalysisResult = tuple[Rank ranking, int totalLinesOfCode, int duplicateLines, num percentage];

alias Results = tuple[VolumeAnalysisResult 		volume, 
					  UnitSizeAnalysisResult 	unitSize, 
					  ComplexityAnalysisResult	complexity,
					  DuplicationAnalysisResult duplicates];
					  
					  
					  