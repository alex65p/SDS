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

function rightClick()
{
  nom=document.all['NOM_VST_MED'].value;
	azl=document.all['COD_AZL'].value;
	document.all['ifrmWork'].src="ANA_VST_MED_Repository.jsp?AZIENDA="+azl+"&NOME="+nom+"&FROM=right";
}

function leftClick()
{
  //azl=document.all['COD_AZL'].value;
	result=window.showModalDialog('../Form_CRM_VST_MED/CRM_VST_MED_Form.jsp','','dialogHeight:320px;dialogwidth:800px;scroll:yes;status:no;help:no');
}
