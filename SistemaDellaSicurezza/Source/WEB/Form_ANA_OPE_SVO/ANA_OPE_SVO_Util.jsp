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
    <version number="1.0" date="06/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="06/02/2004" author="Roman Chumachenko">
				<description>ANA_OPE_SVO_Util.jsp</description>
			</comment>
			
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//---------------FUNCTIONS FOR TABS----------------------------
/* 	IOperazioneSvolta bean = exsempliar of OperazioneSvoltaBean
*/
String BuildRischiTab(IOperazioneSvolta bean, long lCOD_AZL)
{
	String str="";
	java.util.Collection col = bean.getRischi_View(lCOD_AZL);
	str+="<table border='0' align='left' width='660' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='330'><strong>&nbsp;" +
                ApplicationConfigurator.LanguageManager.getString("Nominativo.rischio") +
                "</strong></td>";
	str+="<td width='330'><strong>&nbsp;" +
                ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio") +
                "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='660' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"'>";
	str+="<td width='330' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
	str+="<td width='330' class='dataTd'><input type='text' name='NOM_FAT_RSO' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			OpSvolte_Rischi_View rc=(OpSvolte_Rischi_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"' ID='"+rc.COD_RSO+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 330px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_RSO)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 330px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_FAT_RSO)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------

/* 	IOperazioneSvolta bean = exsempliar of OperazioneSvoltaBean
*/
String BuildDocumentiTab(IOperazioneSvolta bean, long lCOD_AZL)
{
	String str="";
	java.util.Collection col = bean.getDocumenti_View(lCOD_AZL);
	str+="<table border='0' align='left' width='660' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile.documento") + "</strong></td>";
	str+="<td width='160'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='660' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"'>";
	str+="<td width='250' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='250' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='160' class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			OpSvolte_Documenti_View rc=(OpSvolte_Documenti_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"' ID='"+rc.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(rc.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='inputstyle'  value=\""+Formatter.format(rc.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 160px;' class='inputstyle'  value=\""+Formatter.format(rc.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
/* 	IOperazioneSvolta bean = exsempliar of OperazioneSvoltaBean
*/
String BuildMacchineTab(IOperazioneSvolta bean, long lCOD_AZL)
{
	String str="";
	java.util.Collection col = bean.getMacchine_View(lCOD_AZL);
	str+="<table border='0' align='left' width='660' id='MacchineHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='160'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong></td>";
	str+="<td width='500'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='660' id='Macchine' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"'>";
	str+="<td width='160' class='dataTd'><input type='text' name='IDE_MAC' class='dataInput' readonly  value=''></td>";
	str+="<td width='500' class='dataTd'><input type='text' name='DES_MAC' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			OpSvolte_Macchine_View rc=(OpSvolte_Macchine_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"' ID='"+rc.COD_MAC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 160px;' class='inputstyle'  value=\""+Formatter.format(rc.IDE_MAC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 500px;' class='inputstyle'  value=\""+Formatter.format(rc.DES_MAC)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
/* 	IOperazioneSvolta bean = exsempliar of OperazioneSvoltaBean
*/
String BuildAgentiChimiciTab(IOperazioneSvolta bean)
{
	String str="";
	java.util.Collection col = bean.getAgentiChimici_View();
	str+="<table border='0' align='left' width='660' id='AgentiChimiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='330'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.sostanza") + "</strong></td>";
	str+="<td width='330'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='660' id='AgentiChimici' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"'>";
	str+="<td width='330' class='dataTd'><input type='text' name='NOM_COM_SOS' class='dataInput' readonly  value=''></td>";
	str+="<td width='330' class='dataTd'><input type='text' name='DES_CLF_SOS' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			OpSvolte_AgentiChimici_View rc=(OpSvolte_AgentiChimici_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_OPE_SVO())+"' ID='"+rc.COD_SOS_CHI+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 330px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_COM_SOS)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 330px;' class='inputstyle'  value=\""+Formatter.format(rc.DES_CLF_SOS)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
%>
