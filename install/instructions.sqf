//add the code inside !isDedicated to your custom compiles

if (!isDedicated) then {
	diag_log "Loading custom client compiles";
  
  PlotObjects =               compile preprocessFileLineNumbers "dayz_code\actions\plotManagement\plotObjects.sqf";
  PlotPreview =               compile preprocessFileLineNumbers "dayz_code\actions\plotManagement\plotToggleMarkers.sqf";
  dze_buildChecks =           compile preprocessFileLineNumbers "dayz_code\compile\dze_buildChecks.sqf";
  FNC_find_plots =            compile preprocessFileLineNumbers "dayz_code\compile\fn_find_plots.sqf";
  player_removeObject =       compile preprocessFileLineNumbers "dayz_code\actions\remove.sqf";
  
  FNC_plotBoundaries =        compile preprocessFileLineNumbers "dayz_code\compile\plotBoundaries.sqf";
};

//in fn_selfActions, make sure you reference the new toggleMarkers.sqf
		if (s_player_plot_boundary < 0 && (_allowed || (_hasAccess select 1))) then {
			s_player_plot_boundary = player addAction [localize "STR_EPOCH_PLOTMANAGEMENT_SHOW_BOUNDARY", "dayz_code\actions\plotManagement\plotToggleMarkers.sqf", "", 1, false]; //plotBoundaries mod
		};