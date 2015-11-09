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

<%
/*
<file>
  <versions>	
    <version number="1.0" date="23/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="23/01/2004" author="Pogrebnoy Yura">
				   <description>ANA_COU_Util.jsp-functions for ANA_COU_Form.jsp</description>
				   <description>Functions for comboboxes</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//---------------FUNCTION FOR TAB-------------------------
String BuildRischioTab(IMacchinaHome home, String strCOD_MAC){
	String str="";
	java.util.Collection col_rsomac = home.getRischioMacchina_View(strCOD_MAC);
	str="<table border='0' align='left' width='650' id='RischioMacchinaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td width='400'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Entità.danno") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.rifacimento.valutazione.rischio") + "</strong></td></tr>";
	str+="<table border='0' align='left' width='650' id='RischioMacchina' class='dataTable' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr INDEX=\""+strCOD_MAC+"\" id='0' style='display:none'>";
	str+="<td class='dataTd' width='400'><input type='text' readonly class='dataInput'  value='0'></td>";
	str+="<td class='dataTd' width='100'><input type='text' readonly class='dataInput'  value='0'></td>";
	str+="<td class='dataTd' width='150'><input type='text' readonly class='dataInput'  value='0'></td>";
	str+="</tr>";
	if ( !strCOD_MAC.equals("") ){
		java.util.Iterator it_rsomac = col_rsomac.iterator();
 		while(it_rsomac.hasNext()){
			RischioMacchina_View rsomac=(RischioMacchina_View)it_rsomac.next();
			str+="<tr INDEX=\""+strCOD_MAC+"\" id=\""+Formatter.format(rsomac.COD_RSO)+"\" >";
			str+="<td class='dataTd'><input type='text' readonly style='width: 400px;' class='inputstyle'  value=\""+Formatter.format(rsomac.NOM_RSO)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(rsomac.ENT_DAN)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(rsomac.RFC_VLU_RSO_MES)+"\"></td>";
			str+="</tr>";
  	}
	}
	str+="</table>";
	return str;
}

/*/===============================================================================================================
// ------------ combobox for descrizione tipologia ---------------
String BuildTipologieComboBox(String COD_TPL_MAC){
 String str="";
 ITipologieMacchine tpl=null;
 ITipologieMacchineHome tplhome=(ITipologieMacchineHome)PseudoContext.lookup("TipologieMacchineBean");
 java.util.Collection tplcol = tplhome.findAll();
 java.util.Iterator it = tplcol.iterator();
 int iCount=0;
 while(it.hasNext()){
   Long i=(Long)it.next();
   tpl = tplhome.findByPrimaryKey(i);
	  String selstr="";
		if(COD_TPL_MAC.equals(Formatter.format(tpl.getCOD_TPL_MAC())))selstr="selected";
    str=str+"<option "+selstr+" value=\""+Formatter.format(tpl.getCOD_TPL_MAC())+"\">"+Formatter.format(tpl.getDES_TPL_MAC())+"</option>";
 	}
	return str;
}*/
//----------------------------------------

%>
