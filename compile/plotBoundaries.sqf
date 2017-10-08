private["_distancePlus","_distanceNeg","_IsNearPlot","_IsNearPlotS","_IsNearPlotM","_IsNearPlotL","_IsNearPlotEL","_sFound","_mFound","_lFound","_elFound"];

_player = player;
_nearestPole = "";
_findNearestPole = [];
_IsNearPlot = 0;
_IsNearPlotS = 0;
_IsNearPlotM = 0;
_IsNearPlotL = 0;
_IsNearPlotEL = 0;

//idea, plot pole is the only constant. everything else must revolve around pole
//find a pole, then look for anything that fits our modded classes
if (isNil "DZE_PlotPoleMod") then {
  DZE_PlotPoleMod = [[30,45],[60,90],[90,135],[120,180],[150,215]]; //stock range
};

/*//small
MAP_antenna_big_roof
MAP_antenna_small_roof
MAP_antenna_small_roof_1
//medium
MAP_Antenna 50ft Tower
//large
MAP_Vysilac_FM1
//elarge
MAP_telenk1
//?? should it even be legal?
MAP_A_TVTower_Top EXTREME RANGE ZOMFG*/

//script to calc distance for each script that calls for plot distance check ie  _distance = call FNC_plotBoundary
//need to make this script look for the range towers and modify distance accordingly else leave it at stock
//top of this page may be invalid due to this thought process

//assign the various distances
_distancePole = ((DZE_PlotPoleMod select 0)select 0); //look for poles in stock 
_distanceModS = ((DZE_PlotPoleMod select 1) select 0); //look for poles in small 
_distanceModM = ((DZE_PlotPoleMod select 2) select 0); //look for poles in medium 
_distanceModL = ((DZE_PlotPoleMod select 3) select 0); //look for poles in large 
_distanceModEL = ((DZE_PlotPoleMod select 4) select 0); //look for poles in elarge 

//assign var holding players position
_pos = [vehicle _player] call FNC_getPos; //get players position

//assign the vars looking for poles at various distances
_findNearestPole = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distancePole];
_findModSmall = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModS];
_findModMedium = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModM];
_findModLarge = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModL];
_findModELarge = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModEL];

//assign vars counting plots found at various distances
_IsNearPlot = count (_findNearestPole);
_IsNearPlotS = count (_findModSmall);
_IsNearPlotM = count (_findModMedium);
_IsNearPlotL = count (_findModLarge);
_IsNearPlotEL = count (_findModELarge);

//var workaround for verifying we found a larger stage amplifier
_elFound = false;
_lFound = false;
_mFound = false;
_sFound = false;


//first look for plotpole at ALL DISTANCES starting at largest
if (_IsNearPlotEL > 0) then {
  diag_log format["[Boundary][ELarge][VARS] Pole found at %1 meters!",_distanceModEL];
  _pole = _findModELarge select 0;
  diag_log format["[Boundary][ELarge][VARS] _pole = %1",_pole];
  _polePos = getPos _pole;
  diag_log format["[Boundary][ELarge][VARS] _polePos = %1",_polePos];
  _findELMods = nearestObjects [(_polePos), ["MAP_telek1"], (_distancePole)];
  diag_log format["[Boundary][ELarge][VARS] _findELMods = %1",_findELMods];
  _nearELMods = count _findELMods;
  diag_log format["[Boundary][ELarge][VARS] _nearELMods = %1",_nearELMods];
  if (_nearELMods > 0) exitWith {
    _distancePlus = (DZE_PlotPoleMod select 4) select 1;
    _distanceNeg = (DZE_PlotPoleMod select 4) select 0;
    _elFound = true;
    diag_log format["[Boundary][ELarge] Amplifiers found, setting _distancePlus to %1 meters! _distanceNeg = %2",_distancePlus,_distanceNeg];
  };/* else {
    _distance = (DZE_PlotPoleMod select 4) select 0;
    diag_log format["[Boundary][Large] Amplifiers not found, setting _distance to %1 meters!",_distance];
  };*/
} else {
  _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
  diag_log format["[Boundary][ELarge] Pole not found at %1 meters, setting _distanceNeg to %2 now looking further!",_distanceModL,_distanceNeg];
};
if !(_elFound) then {
  if (_IsNearPlotL > 0) then {
    diag_log format["[Boundary][Large][VARS] Pole found at %1 meters!",_distanceModL];
    _pole = _findModLarge select 0;
    diag_log format["[Boundary][Large][VARS] _pole = %1",_pole];
    _polePos = getPos _pole;
    diag_log format["[Boundary][Large][VARS] _polePos = %1",_polePos];
    _findLMods = nearestObjects [(_polePos), ["MAP_Vysilac_FM"], (_distancePole)];
    diag_log format["[Boundary][Large][VARS] _findLMods = %1",_findLMods];
    _nearLMods = count _findLMods;
    diag_log format["[Boundary][Large][VARS] _nearLMods = %1",_nearLMods];
    if (_nearLMods > 0) exitWith {
      _distancePlus = (DZE_PlotPoleMod select 3) select 1;
      _distanceNeg = (DZE_PlotPoleMod select 3) select 0;
      _lFound = true;
      diag_log format["[Boundary][Large] Amplifiers found, setting _distancePlus to %1 meters! _distanceNeg = %2",_distancePlus,_distanceNeg];
    };/* else {
      _distance = (DZE_PlotPoleMod select 3) select 0;
      diag_log format["[Boundary][Large] Amplifiers not found, setting _distance to %1 meters!",_distance];
    };*/
  } else {
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
    diag_log format["[Boundary][Large] Pole not found at %1 meters, setting _distanceNeg to %2 now looking further!",_distanceModL,_distanceNeg];
  };
  if !(_lFound) then {
    if (_IsNearPlotM > 0) then {
      diag_log format["[Boundary][Medium] Pole found at %1 meters!",_distanceModM];
      _pole = _findModMedium select 0;
      diag_log format["[Boundary][Medium][VARS] _pole = %1",_pole];
      _polePos = getPos _pole;
      diag_log format["[Boundary][Medium][VARS] _polePos = %1",_polePos];
      _findMMods = nearestObjects [(_polePos), ["MAP_Antenna"], (_distancePole)];
      diag_log format["[Boundary][Medium][VARS] _findMMods = %1",_findMMods];
      _nearMMods = count _findMMods;
      diag_log format["[Boundary][Medium][VARS] _nearMMods = %1",_nearMMods];
      if (_nearMMods > 0) exitWith {
        _distancePlus = (DZE_PlotPoleMod select 2) select 1;
        _distanceNeg = (DZE_PlotPoleMod select 2) select 0;
        _mFound = true;
        diag_log format["[Boundary][Medium] Amplifiers found, setting _distancePlus to %1 meters! _distanceNeg = %2",_distancePlus,_distanceNeg];
      };/* else {
        _distance = (DZE_PlotPoleMod select 2) select 0;
        diag_log format["[Boundary][Medium] Amplifiers not found, setting _distance to %1 meters!",_distance];
      };*/
    } else {
      _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
      diag_log format["[Boundary][Medium] Pole not found at %1 meters, setting _distanceNeg to %2 now looking further!",_distanceModM,_distanceNeg];
    };
    if !(_mFound) then {
      if (_IsNearPlotS > 0) then {
        diag_log format["[Boundary][Small] Pole found at %1 meters!",_distanceModS];
        _pole = _findModSmall select 0;
        diag_log format["[Boundary][Small][VARS] _pole = %1",_pole];
        _polePos = getPos _pole;
        diag_log format["[Boundary][Small][VARS] _polePos = %1",_polePos];
        _findSMods = nearestObjects [(_polePos), ["MAP_antenna_small_roof"], (_distancePole)];
        diag_log format["[Boundary][Small][VARS] _findSMods = %1",_findSMods];
        _nearSMods = count _findSMods;
        diag_log format["[Boundary][Small][VARS] _nearSMods = %1",_nearSMods];
        if (_nearSMods > 0) exitWith {
          _distancePlus = (DZE_PlotPoleMod select 1) select 1;
          _distanceNeg = (DZE_PlotPoleMod select 1) select 0;
          _sFound = true;
          diag_log format["[Boundary][Small] Amplifiers found, setting _distancePlus to %1 meters! _distancePlus = %2",_distancePlus,_distanceNeg];
        }; /*else {
          _distance = (DZE_PlotPoleMod select 1) select 0;
          diag_log format["[Boundary][Small] Amplifiers not found, setting _distance to %1 meters!",_distance];
        };*/
      } else {
        _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
        diag_log format["[Boundary][Small] Pole not found at %1 meters, setting _distanceNeg to %2 now looking further!",_distanceModS,_distanceNeg];
      };
    };
  };
};
if !((_elFound) || (_lFound) || (_mFound) || (_sFound)) then {
  if (_IsNearPlot > 0) then {
    _distancePlus = (DZE_PlotPoleMod select 0) select 1;
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
    diag_log format["[Boundary][Plot] Pole found at %1 meters, setting _distancePlus to %2, _distanceNeg = %3!",_distancePole,_distancePlus,_distanceNeg];
  } else {
    _distancePlus = (DZE_PlotPoleMod select 0) select 0;
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
    diag_log format["[Boundary][Plot] Pole not found at %1 meters, setting _distancePlus to %2, _distanceNeg = %3!",_distancePole,_distancePlus,_distanceNeg];
  };
};

_callBack = [_distancePlus,_distanceNeg];
diag_log format["[Boundary][End] Testing callback array! _callback = %1",_callBack];
_callBack





//if (_IsNearPlot > 0) then{_nearestPole = _findNearestPole select 0;}else{_nearestPole = objNull;};