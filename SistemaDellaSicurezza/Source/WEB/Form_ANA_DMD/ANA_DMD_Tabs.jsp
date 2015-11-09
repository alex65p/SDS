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
    <version number="1.0" date="26/02/2004" author="Alexey Kolesnik">		
      <comments>
			   <comment date="26/02/2004" author="Alexey Kolesnik">
				ANAGRAFICA DOMANDE Tabs
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
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
	var err = false;
</script>
<script src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
 	long   lCOD_DMD = 0;			 //UID
 	long   lCOD_RST = 0;			 //UID
	long   lCOD_AZL = Security.getAzienda();

	IDomande bean = null;
	IDomandeHome home=(IDomandeHome)PseudoContext.lookup("DomandeBean");

	String strID = (String)request.getParameter("ID_PARENT");
	String strCOD_RST = (String)request.getParameter("COD_RST");
	try{
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_DMD=bean.getCOD_DMD();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildRisposteTab(home, Formatter.format(lCOD_DMD)));
		}
		
		else{
			return;
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
String BuildRisposteTab(IDomandeHome home, String COD_DMD)
{
	String str;
	String strFlag = "";
	java.util.Collection col_rst = home.getDomandeRisposteByDMDID_View(new Long(COD_DMD).longValue());
	
	str="<table border='0' align='left' width='714' id='DomandeRisposteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='614'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.risposta") + "</strong></td>";
	str+="<td align='center' width='100' nowrap><strong>" + ApplicationConfigurator.LanguageManager.getString("Esito") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='714' id='DomandeRisposte' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_DMD)+"'><td width='614' class='dataTd'><input type='text' name='COD_RST' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd' ><input type='text' name='RST_ESI' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_DMD.equals("") ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			DomandeRisposteByDMDID_View rst=(DomandeRisposteByDMDID_View)it_rst.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_DMD)+"' ID='"+rst.COD_RST+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 614;' class='inputstyle'  value=\""+Formatter.format(rst.NOM_RST)+"\"></td>";
			if (Formatter.format(rst.RST_ESI)!=null && Formatter.format(rst.RST_ESI).equals("S")) { strFlag = "checked"; } else { strFlag = ""; } 
			str+="<td align='center' class='dataTd'><input name='CHK_RIPOSTA' type='checkbox' value='"+rst.COD_RST+"'  class='inputstyle'  "+strFlag+"></td>";
			str+="</tr>";
  		}
	}// 	readonlyonClick=\"javascript:return false;\"
	str+="</table>";
	return str;
}

%>
