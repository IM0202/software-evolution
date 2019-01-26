module Visualisation::Window

import Prelude;
import vis::Figure;
import vis::Render;
import vis::KeySym;
import util::Math;


import DataTypes;
import Main;

import Utils::MetricsInformation;

import Visualisation::ProjectBrowser;
import Visualisation::MethodInformationPanel;
import Visualisation::ComplexityTreemapPanel;
import Visualisation::Controls;

import lang::java::jdt::m3::Core;
import analysis::graphs::Graph;

private int currentIndex = 0;

void onPBNewLocationSelected(loc location) {
	if(isMethod(location)){
		mip_setCurrentMethod(location);
		currentIndex = 1;
	} else {
		ctp_setMethods(location.path, pb_getMethodsOfSelectedLocation());
		currentIndex = 2;
	}
}

/**
 * Event listener for MethodInformationPanel new selected method.
 */
void onMIPNewMethodSelected(loc method) {
	pb_setLocation(method);
}

void onCTPMethodSelected(loc method) {
	pb_setLocation(method);
	mip_setCurrentMethod(method);
	currentIndex = 1;
}


void begin() {
	currentIndex = 0;

	bool miReInit = mi_initialize(false);
	pb_initialize(miReInit);
	
	pb_addNewLocationSelectedEventListener(onPBNewLocationSelected);
	pb_addProjectRefreshRequestEventListener(mi_refreshProjectMetrics);
	mip_addNewMethodSelectedEventListener(onMIPNewMethodSelected);
	
	ctp_addMethodSelectedEventListener(onCTPMethodSelected);
	
	menu = menuBar([]);
	
	render(
		page("Maintainance Analyzer",
			 menu,
			 createMain(
			 	panel(projectBrowser(), "", 0),
				 	fswitch(int(){return currentIndex;},[
				 		welcomePanel(),
				 		methodInformationPanel(),
				 		complexityTreemapPanel()
				 	])
				 ),
			 footer("Copyright by A. Walgreen & E. Postma ©2019\t")
		)
	);
}


public Figure createMain(Figure left, Figure right) {
	return box(
		hcat(
		[
			space(left, hsize(350), hresizable(false)),
			space(right)
		],
		gap(48), startGap(true), endGap(true)),
		fillColor(color("white", 0.0)), lineWidth(0)
	);
}

private Figure welcomePanel() {
	return panel(
				text(
					"Select a project in the browser on the left to start", 
					center()
				), 
				"Welcome to the Maintainability Analyzer"
			);
}


