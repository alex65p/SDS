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
    <version number="1.0" date="13/02/2004" author="Kushkarov Yuriy">		
      <comments>
			   <comment date="13/02/2004" author="Kushkarov Yuriy">
				RischioFattore
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
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">
&nbsp;
<% long lCOD_MIS_PET=0;
   String s;
	 String q;
	 String w;
	 String e;
	IUtente bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	
try{
		String strCOD_MIS_PET = new Long(lCOD_MIS_PET).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			IUtenteHome nr_home=(IUtenteHome)PseudoContext.lookup("UtenteBean");
			s=BuildCategoriaTab(nr_home,  strID);
			out.println(s);
		}else{
		  if(request.getParameter("TAB_NAME").equals("tab2")){
			  IUtenteHome d_home=(IUtenteHome)PseudoContext.lookup("UtenteBean");
				q=BuildTipologiaTab(d_home, strID);
				out.print(q);
		  }else{
					 if(request.getParameter("TAB_NAME").equals("tab3")){
					   IUtenteHome ns_home=(IUtenteHome)PseudoContext.lookup("UtenteBean");
						 w=BuildRuoliTab(ns_home, strID);
						 out.println(w);
		       }else{
										 return;
										}
					}
		 }

}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
	 %>
</div>	
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
 
<%! 
//---------------FUNCTIONS FOR TABS-------------------------
String BuildCategoriaTab(IUtenteHome home, String strID)
{
	String str;
	java.util.Collection col_d = home.getUtente_CAG_DOC_TAB_View(new Long(strID).longValue());
	str="<table border='0' align='left' width='790' id='CategoriaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='790'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Categoria") + "</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='790' id='Categoria' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(strID)+"\"><td width='790' class='dataTd'><input type='text' name='NOM_CAG_DOC' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	if ( !strID.equals("") ){
		java.util.Iterator it_d = col_d.iterator();
 		while(it_d.hasNext()){
			Utente_CAG_DOC_TAB_View d=(Utente_CAG_DOC_TAB_View)it_d.next();
			str+="<tr INDEX=\""+Formatter.format(strID)+"\" ID=\""+d.COD_CAG_DOC+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width:791' class='inputstyle'  value=\""+Formatter.format(d.NOM_CAG_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

String BuildTipologiaTab(IUtenteHome home, String strID)
{
	String str;
	java.util.Collection col_ns = home.getUtente_TPL_DOC_TAB_View(new Long(strID).longValue());
	str="<table border='0' align='left' width='790' id='TipologiaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='790'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Tipologia")+"</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='790' id='Tipologia' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(strID)+"\"><td width='790' class='dataTd'><input type='text' name='NOM_TPL_DOC' class='dataInput' readonly  value=''></td>";
  str+="</tr>";
	if ( !strID.equals("") ){
		java.util.Iterator it_ns = col_ns.iterator();
 		while(it_ns.hasNext()){
			Utente_TPL_DOC_TAB_View ns=(Utente_TPL_DOC_TAB_View)it_ns.next();
	    str+="<tr INDEX=\""+Formatter.format(strID)+"\" ID=\""+ns.COD_TPL_DOC+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 790px;' class='inputstyle'  value=\""+Formatter.format(ns.NOM_TPL_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

String BuildRuoliTab(IUtenteHome home, String strID)
{
	String str;
	java.util.Collection col_as = home.getUtente_RUO_TAB_View(new Long(strID).longValue());
	str="<table border='0' align='left' width='790' id='RuoliHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='790'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Ruolo")+"</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='790' id='Ruoli' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(strID)+"\"><td width='790' class='dataTd'><input type='text' name='DES_RUO' class='dataInput' readonly  value=''></td>";
  str+="</tr>";
	if ( !strID.equals("") ){
		java.util.Iterator it_as = col_as.iterator();
 		while(it_as.hasNext()){
			Utente_RUO_TAB_View as=(Utente_RUO_TAB_View)it_as.next();
	    str+="<tr INDEX=\""+Formatter.format(strID)+"\" ID=\""+as.COD_RUO+"\">";
			str+="<td class='dataTd' width='100%'><input type='text' readonly style='width: 790px;' class='inputstyle'  value=\""+Formatter.format(as.DES_RUO)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

 %>
