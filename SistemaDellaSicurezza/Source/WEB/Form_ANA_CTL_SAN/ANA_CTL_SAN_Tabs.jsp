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
    <version number="1.0" date="26/02/2004" author="Malyuk Sergey">		
      <comments>
			   <comment date="26/02/2004" author="Malyuk Sergey">
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script>
var err = false;
</script>
<div id="dContent">
<%
	long lCOD_CTL_SAN=0;
	String strID = (String)request.getParameter("ID_PARENT");
	lCOD_CTL_SAN=new Long(strID).longValue();
 ICartelleSanitarieHome home=(ICartelleSanitarieHome)PseudoContext.lookup("CartelleSanitarieBean");
try{
		if (request.getParameter("TAB_NAME").equals("tab1"))
			 {
			 out.print(BuildDocumentiCartelleTab(home, lCOD_CTL_SAN));
			 }
		else
	 if (request.getParameter("TAB_NAME").equals("tab2"))
 	 		{
 			out.print(BuildProtocolliSanitariTab(home,lCOD_CTL_SAN));
			}
		else
	  if (request.getParameter("TAB_NAME").equals("tab3"))
		 		{
				out.print(BuildVisiteIdoneitaTab(home,lCOD_CTL_SAN));
				}
		else
	  if (request.getParameter("TAB_NAME").equals("tab4"))
		 		{
	 			out.print(BuildVisiteMedicheTab(home,lCOD_CTL_SAN));
				}
		else
				{
				return;
				}
}
catch(Exception ex){
    ex.printStackTrace();
	//out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
%>
 </div>
 
 <script>
 if (!err)
 		{
	   parent.tabbar.ReloadTabTable(document);
 		}	
 </script>
 
<%!
/* 	--- SchedeIntervento --- 
  ISchedeInterventoDPIhome = Home intarface of SchedeInterventoDPI
	String COD_CTL_SAN = COD_CTL_SAN of current Lotti DPI
*/

String BuildDocumentiCartelleTab(ICartelleSanitarieHome home, long COD_CTL_SAN)
{
	String str;
	java.util.Collection col = home.getDocumentiCartelle_View(COD_CTL_SAN);
	str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='384' class='dataTd'><input type='text' name='NOM_TIT_DOC' readonly class='inputstyle' value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='NOM_RSP_DOC' readonly class='inputstyle' value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='inputstyle' value=''></td>";
	str+="</tr>";
	str+="</table>";
	str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='384'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='724' id='DocumentiCartelle' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='384' class='dataTd'><input type='text' name='NOM_TIT_DOC' readonly class='inputstyle' value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='NOM_RSP_DOC' readonly class='inputstyle' value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='inputstyle' value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while (it.hasNext())
				{
		DocumentiCartelle_View obj=(DocumentiCartelle_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(COD_CTL_SAN)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 384px;' class='inputstyle'  value=\""+Formatter.format(obj.NB_TIT_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(obj.NB_RSP_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.NB_DAT_REV_DOC)+"\"></td>";
		str+="</tr>";
				}
	str+="</table>";
	return str;
}

String BuildProtocolliSanitariTab(ICartelleSanitarieHome home, long COD_CTL_SAN)
{
	String str;
	java.util.Collection col = home.getProtocolliSanitari_View(COD_CTL_SAN);
	
	str="<table border='0' align='left' width='724' id='ProtocolliSanitariHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='724'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.protocollo") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='724' id='ProtocolliSanitari' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='724' class='dataTd'><input type='text' name='NOM_PRO_SAN' readonly class='dataInput' value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
	  ProtocolliSanitari_View obj=(ProtocolliSanitari_View)it.next();
   	str+="<tr INDEX='"+Formatter.format(COD_CTL_SAN)+"' ID='"+obj.COD_PRO_SAN+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 724px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_PRO_SAN)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildVisiteIdoneitaTab(ICartelleSanitarieHome home, long COD_CTL_SAN)
{
	String str;
	java.util.Collection col = home.getVisiteIdoneita_View(COD_CTL_SAN);
	
    str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='550' class='dataTd'><input type='text' name='NOM_VST_IDO' readonly class='dataInput' value=''></td>";
	str+="<td width='174' class='dataTd'><input type='text' name='DAT_PIF_VST_IDO' readonly class='dataInput' value=''></td>";
	str+="</tr>";
	str+="</table>";
	str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='550'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.visita") + "</strong></td>";
	str+="<td width='174'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.visita") + "</strong></td>";
	str+="</table>";
	str+="<table border='0' align='left' width='724' id='DocumentiCartelle' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='550' class='dataTd'><input type='text' name='NOM_VST_IDO' readonly class='inputstyle' value=''></td>";
	str+="<td width='174' class='dataTd'><input type='text' name='DAT_PIF_VST_IDO' readonly class='inputstyle' value=''></td>";
	str+="</tr>";


	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		VisiteIdoneita_View obj=(VisiteIdoneita_View)it.next();
        str+="<tr INDEX='"+Formatter.format(COD_CTL_SAN)+"' ID='"+obj.COD_VST_IDO+"' paramsList='dat_pif_vst_ido="+obj.DAT_PIF_VST_IDO+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 550px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_VST_IDO)+"\"></td>";
        str+="<td class='dataTd'><input type='text' readonly style='width: 174px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_PIF_VST_IDO)+"\"></td>";
		str+="</tr>";
   	}
	str+="</table>";
	return str;
}

String BuildVisiteMedicheTab(ICartelleSanitarieHome home, long COD_CTL_SAN)
{
	String str;
	java.util.Collection col = home.getVisiteMediche_View(COD_CTL_SAN);
	
    str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='550' class='dataTd'><input type='text' name='NOM_VST_IDO' readonly class='dataInput' value=''></td>";
	str+="<td width='174' class='dataTd'><input type='text' name='DAT_PIF_VST_IDO' readonly class='dataInput' value=''></td>";
	str+="</tr>";
	str+="</table>";
	str="<table border='0' align='left' width='724' id='DocumentiCartelleHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='550'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Visita.medica") + "</strong></td>";
	str+="<td width='174'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.visita") + "</strong></td>";
	str+="</table>";
	str+="<table border='0' align='left' width='724' id='DocumentiCartelle' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_CTL_SAN)+"'>";
	str+="<td width='550' class='dataTd'><input type='text' name='NOM_VST_MED' readonly class='dataInput' value=''></td>";
	str+="<td width='174' class='dataTd'><input type='text' name='DAT_PIF_VST_MED' readonly class='dataInput' value=''></td>";
	str+="</tr>";

	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		VisiteMediche_View obj=(VisiteMediche_View)it.next();
        
        str+="<tr INDEX='"+Formatter.format(COD_CTL_SAN)+"' ID='"+obj.COD_VST_MED+"'  paramsList='dat_pif_vst_med="+obj.DAT_PIF_VST_MED+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 550px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_VST_MED)+"\"></td>";
        str+="<td class='dataTd'><input type='text' readonly style='width: 174px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_PIF_VST_MED)+"\"></td>";
		str+="</tr>";
       	}
	str+="</table>";
	return str;
}

	
%>
