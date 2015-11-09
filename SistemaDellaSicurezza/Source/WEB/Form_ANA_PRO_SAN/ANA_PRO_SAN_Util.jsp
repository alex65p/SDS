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

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
//---------------FUNCTIONS FOR TABS-------------------------

String BuildDocumenteSanitareTab(IProtocoleSanitareHome home, long lCOD_AZL, String COD_PRO_SAN)
{
	String str;
	java.util.Collection col_doc = home.getDocumenteSanitareByPROSANID_View(lCOD_AZL ,new Long(COD_PRO_SAN).longValue());
	
	str="<table border='0' align='left' width='650' id='DocumenteSanitareHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='310'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='DocumenteSanitare' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_PRO_SAN)+"'><td class='dataTd'><input type='text' name='IDE_PRO_SAN' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='TITOLO' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_PRO_SAN.equals("") ){
		java.util.Iterator it_doc = col_doc.iterator();
 		while(it_doc.hasNext()){
			DocumenteSanitareByPROSANID_View doc=(DocumenteSanitareByPROSANID_View)it_doc.next();
    	str+="<tr INDEX='"+Formatter.format(COD_PRO_SAN)+"' ID='"+Formatter.format(doc.COD_DOC)+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 310px;' class='inputstyle'  value=\""+Formatter.format(doc.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(doc.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(doc.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// ProtocoleSanitare = null	
	str+="</table>";
	return str;
} 

String BuildVisiteIdoneiteTab(IProtocoleSanitareHome home, long lCOD_AZL, String COD_PRO_SAN)
{
	String str="";
	java.util.Collection col_vst_ido = home.getVisiteIdoneiteByPROSANID_View(lCOD_AZL, new Long(COD_PRO_SAN).longValue());
	
	str="<table border='0' align='left' width='650' id='VisiteIdoneiteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.visita") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Periodicità") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='VisiteIdoneite' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_PRO_SAN)+"'>";
	str+="<td width='250' class='dataTd'><input type='text' name='IDE_PRO_SAN' class='dataInput' readonly  value=''></td>";
	str+="<td width='250' class='dataTd'><input type='text' name='NOME' readonly class='dataInput'  value=''></td>";
	str+="<td width='150' class='dataTd'><input type='text' name='DESCR' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_PRO_SAN.equals("") ){
		java.util.Iterator it_vst_ido = col_vst_ido.iterator();
 		while(it_vst_ido.hasNext()){
			VisiteIdoneiteByPROSANID_View vst_ido=(VisiteIdoneiteByPROSANID_View)it_vst_ido.next();
    	str+="<tr INDEX='"+Formatter.format(COD_PRO_SAN)+"' ID='"+vst_ido.COD_VST_IDO+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(vst_ido.NOM_VST_IDO)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(vst_ido.DES_VST_IDO)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(vst_ido.PER_VST)+"\"></td>";
			str+="</tr>";
  		}
	}// ProtocoleSanitare = null	
	str+="</table>";
	return str;
} 

String BuildVisiteMedicheTab(IProtocoleSanitareHome home, long lCOD_AZL, String COD_PRO_SAN)
{
	String str="";
	java.util.Collection col_vst_med = home.getVisiteMedicheByPROSANID_View(lCOD_AZL, new Long(COD_PRO_SAN).longValue());
	
	str="<table border='0' align='left' width='650' id='VisiteMedicheHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.visita") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Periodicità") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='VisiteMediche' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+COD_PRO_SAN+"'>";
	str+="<td width='250' class='dataTd'><input type='text' name='IDE_PRO_SAN' class='dataInput' readonly  value=''></td>";
	str+="<td width='250' class='dataTd'><input type='text' name='NOME' readonly class='dataInput'  value=''></td>";
	str+="<td width='150' class='dataTd'><input type='text' name='DESCR' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_PRO_SAN.equals("") ){
		java.util.Iterator it_vst_med = col_vst_med.iterator();
 		while(it_vst_med.hasNext()){
			VisiteMedicheByPROSANID_View vst_med=(VisiteMedicheByPROSANID_View)it_vst_med.next();
    	    str+="<tr INDEX='"+COD_PRO_SAN+"' ID='"+vst_med.COD_VST_MED+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(vst_med.NOM_VST_MED)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(vst_med.DES_VST_MED)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+vst_med.PER_VST+"\"></td>";
			str+="</tr>";
  		}
	}// ProtocoleSanitare = null	
	str+="</table>";
	return str;
} 

%>
