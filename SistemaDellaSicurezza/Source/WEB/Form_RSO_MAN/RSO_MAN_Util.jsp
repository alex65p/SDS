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
    <version number="1.0" date="13/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="13/02/2004" author="Roman Chumachenko">
				<description>RSO_MAN_Util.jsp</description>
			</comment>
			
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//---------------FUNCTIONS FOR TABS----------------------------
/* 	IAssRischioAttivita bean = exsempliar of AssRischioAttivitaBean
*/
String BuildMisurePreventiveTab(IAssRischioAttivita bean)
{
	String str="";
	String strFlag = "";
	java.util.Collection col = bean.getMisurePreventive_View();
	str+="<table border='1' id='MisurePreventiveHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='770'><tr>";
	str+="<td width='565'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine") + "</strong></td>";
	str+="<td width='5'>&nbsp;</td>";
	str+="</tr></table>";
	str+="<table border='1' id='MisurePreventive' class='dataTable' cellpadding='0' cellspacing='0' style=width=''>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='565' class='dataTd'><input type='text' name='NOM_MIS_PET' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_INZ' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_FIE' class='dataInput' readonly  value=''></td>";
	str+="<td width='5' class='dataTd'><input type='text' name='CHK_PRS_MIS_PET' type='checkbox'  class='dataInput' value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssRA_MisurePreventive_View rc=(AssRA_MisurePreventive_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_MIS_PET_MAN+"'>";
			str+="<td class='dataTd' ><input type='text' readonly style=width='565' class='inputstyle'  value=\""+Formatter.format(rc.NOM_MIS_PET)+"\" ></td>";
			str+="<td class='dataTd' ><input type='text' readonly style=width='100' class='inputstyle'  value='"+Formatter.format(rc.DAT_INZ)+"'></td>";
			str+="<td class='dataTd' ><input type='text' readonly style=width='100' class='inputstyle'  value='"+Formatter.format(rc.DAT_FIE)+"'  id='DAT_FIE_"+rc.COD_MIS_PET_MAN+"'></td>";
			if(Formatter.format(rc.PRS_MIS_PET).equals("S")) 
			{strFlag = " checked ";}else{strFlag = " disabled ";}
			if(rc.DAT_FIE==null)
				strFlag = strFlag+" onclick='setDAT_FIE(this)' ";
			str+="<td align='center' class='dataTd'><input name='CHK_PRS_MIS_PET'  id='CHK_PRS_MIS_PET_"+rc.COD_MIS_PET_MAN+"' type='checkbox'  value='"+rc.COD_MIS_PET_MAN+"' class='dataInput'  "+strFlag+"><input name='CHK_PRS_MIS_HID' type='checkbox'  value='"+rc.COD_MIS_PET_MAN+"' style='display:none' style=width='5' id='CHK_PRS_MIS_HID_"+rc.COD_MIS_PET_MAN+"'></td>";
			str+="</tr>";
			strFlag = "";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------

/* 	IAssRischioAttivita bean = exsempliar of AssRischioAttivitaBean
*/
String BuildDocumentiTab(IAssRischioAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getDocumenti_View();
	str+="<table border='1' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='770'><tr>";
	str+="<td width='770'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='1' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0' width=''>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='770' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssRA_Documenti_View rc=(AssRA_Documenti_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=770' class='inputstyle'  value='"+Formatter.format(rc.TIT_DOC)+"' ></td>";
			str+="</tr>";
		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
/*  IAssRischioAttivita bean = exsempliar of AssRischioAttivitaBean
*/
String BuildNormativeSentenzeTab(IAssRischioAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getNormativeSentenze_View();
	str+="<table border='1' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='770'><tr>";
	str+="<td width='770'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='1' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0' width=''>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='770' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssRA_NormativeSentenze_View rc=(AssRA_NormativeSentenze_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_NOR_SEN+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=770' class='inputstyle'  value='"+Formatter.format(rc.TIT_NOR_SEN)+"' ></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
%>
