private["_distancePlus","_distanceNeg","_IsNearPlot","_IsNearPlotS","_IsNearPlotM","_IsNearPlotL","_IsNearPlotEL","_sFound","_mFound","_lFound","_elFound"];

_player = player;
_nearestPole = "";
_findNearestPole = [];
_IsNearPlot = 0;
_IsNearPlotS = 0;
_IsNearPlotM = 0;
_IsNearPlotL = 0;
_IsNearPlotEL = 0;

if (isNil "DZE_PlotPoleMod") then {
  DZE_PlotPoleMod = [[30,45],[60,90],[90,135],[120,180],[150,215]];
};

_distancePole = ((DZE_PlotPoleMod select 0)select 0);
_distanceModS = ((DZE_PlotPoleMod select 1) select 0);
_distanceModM = ((DZE_PlotPoleMod select 2) select 0);
_distanceModL = ((DZE_PlotPoleMod select 3) select 0);
_distanceModEL = ((DZE_PlotPoleMod select 4) select 0);

_pos = [vehicle _player] call FNC_getPos;

_findNearestPole = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distancePole];
_findModSmall = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModS];
_findModMedium = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModM];
_findModLarge = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModL];
_findModELarge = _pos nearEntities ["Plastic_Pole_EP1_DZ", _distanceModEL];

_IsNearPlot = count (_findNearestPole);
_IsNearPlotS = count (_findModSmall);
_IsNearPlotM = count (_findModMedium);
_IsNearPlotL = count (_findModLarge);
_IsNearPlotEL = count (_findModELarge);

_elFound = false;
_lFound = false;
_mFound = false;
_sFound = false;

if (_IsNearPlotEL > 0) then {
  _pole = _findModELarge select 0;
  _polePos = getPos _pole;
  _findELMods = nearestObjects [(_polePos), ["MAP_telek1"], (_distancePole)];
  _nearELMods = count _findELMods;
  if (_nearELMods > 0) exitWith {
    _distancePlus = (DZE_PlotPoleMod select 4) select 1;
    _distanceNeg = (DZE_PlotPoleMod select 4) select 0;
    _elFound = true;
  };
} else {
  _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
};
if !(_elFound) then {
  if (_IsNearPlotL > 0) then {
    _pole = _findModLarge select 0;
    _polePos = getPos _pole;
    _findLMods = nearestObjects [(_polePos), ["MAP_Vysilac_FM"], (_distancePole)];
    _nearLMods = count _findLMods;
    if (_nearLMods > 0) exitWith {
      _distancePlus = (DZE_PlotPoleMod select 3) select 1;
      _distanceNeg = (DZE_PlotPoleMod select 3) select 0;
      _lFound = true;
    };
  } else {
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
  };
  if !(_lFound) then {
    if (_IsNearPlotM > 0) then {
      _pole = _findModMedium select 0;
      _polePos = getPos _pole;
      _findMMods = nearestObjects [(_polePos), ["MAP_Antenna"], (_distancePole)];
      _nearMMods = count _findMMods;
      if (_nearMMods > 0) exitWith {
        _distancePlus = (DZE_PlotPoleMod select 2) select 1;
        _distanceNeg = (DZE_PlotPoleMod select 2) select 0;
        _mFound = true;
      };
    } else {
      _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
    };
    if !(_mFound) then {
      if (_IsNearPlotS > 0) then {
        _pole = _findModSmall select 0;
        _polePos = getPos _pole;
        _findSMods = nearestObjects [(_polePos), ["MAP_antenna_small_roof"], (_distancePole)];
        _nearSMods = count _findSMods;
        if (_nearSMods > 0) exitWith {
          _distancePlus = (DZE_PlotPoleMod select 1) select 1;
          _distanceNeg = (DZE_PlotPoleMod select 1) select 0;
          _sFound = true;
        };
      } else {
        _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
      };
    };
  };
};
if !((_elFound) || (_lFound) || (_mFound) || (_sFound)) then {
  if (_IsNearPlot > 0) then {
    _distancePlus = (DZE_PlotPoleMod select 0) select 1;
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
  } else {
    _distancePlus = (DZE_PlotPoleMod select 0) select 0;
    _distanceNeg = (DZE_PlotPoleMod select 0) select 0;
  };
};

_callBack = [_distancePlus,_distanceNeg];
_callBack