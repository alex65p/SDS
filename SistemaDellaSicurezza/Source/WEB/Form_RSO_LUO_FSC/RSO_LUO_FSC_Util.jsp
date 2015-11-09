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
    <version number="1.0" date="12/02/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="12/02/2004" author="Alexey Kolesnik">
				   <description>RSO_LUO_FSC_Util.jsp-functions for RSO_LUO_FSC_Form.jsp</description>
				 </comment>		
				  <comment date="12/02/2004" author="Alexey Kolesnik">
				   <description> Added functions for comboboxes </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
/*
String BuildRischiTab(ILuogoFisicoRischioHome home, String COD_AZL, String COD_LUO_FSC)
{
	String str;
//	java.util.Collection col_tel = home.getLuogoFisicoRischio_View(new Long(COD_AZL).longValue());
	java.util.Collection col = home.getLuogoFisicoRischio_Tab_View(new Long(COD_AZL).longValue(), new Long(COD_LUO_FSC).longValue());
	str="<table border='1' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td  align='center'><b>Rischi trasmissibili</td></tr></table>";
	str+="<table border='1' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_LUO_FSC)+"'>";
	str+="<td class='dataTd'><input type='text' name='NOM_RSO' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_LUO_FSC.equals("") ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			LuogoFisicoRischio_Tab_View obj=(LuogoFisicoRischio_Tab_View)it.next();
	    str+="<tr INDEX='"+Formatter.format(COD_LUO_FSC)+"' ID='"+obj.COD_RSO_LUO_FSC+"'>";
			str+="<td class='dataTd'><input type='text' readonly class='dataInput'  value='"+Formatter.format(obj.NOM_RSO)+"'></td>";
			str+="</tr>";
  		}
	}	
	str+="</table>";
	return str;
}
*/


String BuildFattoreRischioComboBox(IRischioHome home, long SELECTED_ID, long FILTER_ID)
{
	String str = "";

	java.util.Collection col = home.getRischio_Nome_Fattore_ComboBox(FILTER_ID);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_Nome_Fattore_ComboBox obj = (Rischio_Nome_Fattore_ComboBox)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.lCOD_FAT_RSO) strSEL="selected";
	    str=str+"<option " + strSEL + " value='" + Formatter.format(obj.lCOD_FAT_RSO) + "'>" + Formatter.format(obj.strNOM_FAT_RSO) + "</option>";
  	}
	
	return str;
}

String BuildRischioComboBox(IRischioHome home, long SELECTED_ID, long FILTER_ID)
{
	String str = "";

	java.util.Collection col = home.getRischio_ComboBox(FILTER_ID, 0);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_ComboBox obj = (Rischio_ComboBox)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.lCOD_RSO) strSEL="selected";
	    str=str+"<option " + strSEL + " value='" + Formatter.format(obj.lCOD_RSO) + 
                    "' value1='" + Formatter.format(obj.lCOD_FAT_RSO) + 
                    "' value2='" + Formatter.format(obj.strNOM_RIL_RSO) + 
                    "' value3='" + Formatter.format(obj.strCLF_RSO) + 
                    "' value4='" + Formatter.format(obj.dtDAT_RFC_VLU_RSO) + 
                    "' value5='" + Formatter.format(obj.lENT_DAN) + 
                    "' value6='" + Formatter.format(obj.lPRB_EVE_LES) + 
                    "' value7='" + Formatter.format(obj.lSTM_NUM_RSO) + 
                    "' value8='" + Formatter.format(obj.lFRQ_RIP_ATT_DAN) + 
                    "' value9='" + Formatter.format(obj.lNUM_INC_INF) + 
                    "'>" + Formatter.format(obj.strNOM_RSO) + "</option>";
  	}
	
	return str;
}

String BuildRischiLOV(IRischioHome home, long lCOD_AZL, long lCOD_FAT_RSO)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"25%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
	str=str+" <td width=\"40%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione.rischio") + "</strong></td>";
	str=str+" <td width=\"10%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.rilievo") + "</strong></td>";
	str=str+" <td width=\"25%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getRischio_ComboBox(lCOD_AZL, lCOD_FAT_RSO);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_ComboBox obj=(Rischio_ComboBox)it.next();

		str=str+"<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str=str+" <td width=\"25%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str=str+" <td width=\"40%\">&nbsp;"+Formatter.format(obj.strDES_RSO)+"</td>";
		str=str+" <td width=\"10%\">&nbsp;"+Formatter.format(obj.dtDAT_RFC_VLU_RSO)+"</td>";
		str=str+" <td width=\"25%\">&nbsp;"+Formatter.format(obj.strNOM_FAT_RSO)+"</td>";
		str=str+"</tr>";
  }
	return str;
}

%>
