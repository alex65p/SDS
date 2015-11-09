/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

// ** I18N

// Calendar EN language
// Author: Mihai Bazon, <mihai_bazon@yahoo.com>
// Translator: Fabio Di Bernardini, <altraqua@email.it>
// Encoding: any
// Distributed under the same terms as the calendar itself.

// For translators: please use UTF-8 if possible.  We strongly believe that
// Unicode is the answer to a real internationalized world.  Also please
// include your contact information in the header, as can be seen above.

// full day names
Calendar._DN = new Array
(arraylng["MSG_0002"],
 arraylng["MSG_0116"],
 arraylng["MSG_0117"],
 arraylng["MSG_0118"],
 arraylng["MSG_0119"],
 arraylng["MSG_0120"],
 arraylng["MSG_0121"],
 arraylng["MSG_0002"]);

// Please note that the following array of short day names (and the same goes
// for short month names, _SMN) isn't absolutely necessary.  We give it here
// for exemplification on how one can customize the short day names, but if
// they are simply the first N letters of the full name you can simply say:
//
//   Calendar._SDN_len = N; // short day name length
//   Calendar._SMN_len = N; // short month name length
//
// If N = 3 then this is not needed either since we assume a value of 3 if not
// present, to be compatible with translation files that were written before
// this feature.

// short day names
Calendar._SDN = new Array
(arraylng["MSG_0122"],
 arraylng["MSG_0123"],
 arraylng["MSG_0124"],
 arraylng["MSG_0125"],
 arraylng["MSG_0126"],
 arraylng["MSG_0127"],
 arraylng["MSG_0128"],
 arraylng["MSG_0122"]);

// full month names
Calendar._MN = new Array
(arraylng["MSG_0129"],
 arraylng["MSG_0130"],
 arraylng["MSG_0131"],
 arraylng["MSG_0132"],
 arraylng["MSG_0133"],
 arraylng["MSG_0134"],
 arraylng["MSG_0135"],
 arraylng["MSG_0136"],
 arraylng["MSG_0137"],
 arraylng["MSG_0138"],
 arraylng["MSG_0139"],
 arraylng["MSG_0140"]);

// short month names
Calendar._SMN = new Array
(arraylng["MSG_0141"],
 arraylng["MSG_0142"],
 arraylng["MSG_0143"],
 arraylng["MSG_0144"],
 arraylng["MSG_0145"],
 arraylng["MSG_0146"],
 arraylng["MSG_0147"],
 arraylng["MSG_0148"],
 arraylng["MSG_0149"],
 arraylng["MSG_0150"],
 arraylng["MSG_0151"],
 arraylng["MSG_0152"]);

// tooltips
Calendar._TT = {};
Calendar._TT["INFO"] = arraylng["MSG_0153"];

Calendar._TT["ABOUT"] =
arraylng["MSG_0154"] +
arraylng["MSG_0155"] +
arraylng["MSG_0156"] + " " + String.fromCharCode(0x2039) + ", " + String.fromCharCode(0x203a) + " " + arraylng["MSG_0157"] +
arraylng["MSG_0158"];
Calendar._TT["ABOUT_TIME"] = "\n\n" +
arraylng["MSG_0159"] +
arraylng["MSG_0160"] +
arraylng["MSG_0161"] +
arraylng["MSG_0162"];

Calendar._TT["PREV_YEAR"] = arraylng["MSG_0163"];
Calendar._TT["PREV_MONTH"] = arraylng["MSG_0164"];
Calendar._TT["GO_TODAY"] = arraylng["MSG_0165"];
Calendar._TT["NEXT_MONTH"] = arraylng["MSG_0166"];
Calendar._TT["NEXT_YEAR"] = arraylng["MSG_0167"];
Calendar._TT["SEL_DATE"] = arraylng["MSG_0168"];
Calendar._TT["DRAG_TO_MOVE"] = arraylng["MSG_0169"];
Calendar._TT["PART_TODAY"] = " " + arraylng["MSG_0170"];

// the following is to inform that "%s" is to be the first day of week
// %s will be replaced with the day name.
Calendar._TT["DAY_FIRST"] = arraylng["MSG_0171"] + " %s";

// This may be locale-dependent.  It specifies the week-end days, as an array
// of comma-separated numbers.  The numbers are from 0 to 6: 0 means Sunday, 1
// means Monday, etc.
Calendar._TT["WEEKEND"] = "0,6";

Calendar._TT["CLOSE"] = arraylng["MSG_0172"];
Calendar._TT["TODAY"] = arraylng["MSG_0173"];
Calendar._TT["TIME_PART"] = arraylng["MSG_0174"];

// date formats
Calendar._TT["DEF_DATE_FORMAT"] = "%d-%m-%Y";
Calendar._TT["TT_DATE_FORMAT"] = "%a:%b:%e";

Calendar._TT["WK"] = arraylng["MSG_0175"];
Calendar._TT["TIME"] = arraylng["MSG_0176"];
