<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%!
//---------------FUNCTIONS FOR TABS-------------------------

/* 	--- Domande --- 
  ITestVerificaHome home = Home intarface of TestVerifica
	String COD_TES_VRF = COD_TES_VRF of current TestVerifica
*/
String BuildDomandeTab(ITestVerificaHome home, String COD_TES_VRF)
{
	String str;
	String str1;
	java.util.Collection col_dmd = home.getDomandeByTESVRFID_View(new Long(COD_TES_VRF).longValue());
	str="<table border='0' id='DomandeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td  align='center' width='50%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Domanda") + "</strong></td>";
	str+="<td align='center' width='50%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Punteggio.domanda") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='Domande' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TES_VRF)+"'><td width='50%' class='dataTd'><input type='text' name='IDE_DMD' class='dataInput' readonly  value=''></td>";
	str+="<td width='50%' class='dataTd'><input type='text' name='DOMANDE' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TES_VRF.equals("") ){
		java.util.Iterator it_dmd = col_dmd.iterator();
 		while(it_dmd.hasNext()){
		str1="";
			DomandeByTESVRFID_View dmd=(DomandeByTESVRFID_View)it_dmd.next();
			if (dmd.NUM_PTG_DMD!=0){str1=Formatter.format(dmd.NUM_PTG_DMD);}
    	str+="<tr INDEX='"+Formatter.format(COD_TES_VRF)+"' ID='"+dmd.COD_DMD+"'>";
			str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(dmd.NOM_DMD)+"\"></td>";
			str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+str1+"\"></td>";
			str+="</tr>";
  		}
	}// TestVerifica = null	
	str+="</table>";
	return str;
} 
%>
