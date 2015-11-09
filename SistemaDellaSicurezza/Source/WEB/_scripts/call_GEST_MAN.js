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

var DEBUG_TABS_OPEN = false;
var res=false;
/*
	- parametry showGestMan i showGestManDel
		1 - COD
		2 - TypeMan
		3 - COD_RSO
		4 - COD_MAC
*/

function showGestMan(COD, TypeMAN, COD_RSO){
	var COD_MAC;

	cnf=confirm(arraylng["MSG_0177"]);
	if (parent.DEBUG_TABS_OPEN) DEBUG_TABS_OPEN = parent.DEBUG_TABS_OPEN;
	if(cnf){
		if (showGestMan.arguments.length==4){
			COD_MAC=showGestMan.arguments[3];
		}
		if(DEBUG_TABS_OPEN){
			window.open("../Form_GEST_MAN/GEST_MAN_Form.jsp?COD_RSO="+COD_RSO+"&TypeMAN="+TypeMAN+"&COD="+COD+"&COD_MAC="+COD_MAC);
		}
		else{	
			var str = window.showModalDialog("../Form_GEST_MAN/GEST_MAN_Form.jsp?COD_RSO="+COD_RSO+"&TypeMAN="+TypeMAN+"&COD="+COD+"&COD_MAC="+COD_MAC, null, "dialogHeight:360px; dialogWidth:800px;help:no;resizable:no;status:no;scroll:no;");
			parent.ToolBar.Return.Do();
		}	
	}
	else{
		return false;	
	}
}
