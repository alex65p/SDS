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
    <version number="1.0" date="05/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="05/02/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta AnagrDocumento
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>


<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>


<%@ include file="../src/com/apconsulting/luna/ejb/DestinatarioDocumento/DestinatarioDocumento_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DestinatarioDocumento/DestinatarioDocumentoBean.jsp" %>


<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ page import="org.apache.commons.fileupload.*"%>

<%!
	String ReqMODE;	// parameter of request 
%>

<script src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
var bRefresh=false;
</script>


<%
IDestinatarioDocumento bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_LST_DSI_DOC=c.checkLong("Lavoratore",request.getParameter("ID"),true);
long lCOD_DOC=c.checkLong("Documento",request.getParameter("COD_DOC"),true);
long lCOD_AZL=Security.getAzienda();

String strNOM_DSI_ESR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"),request.getParameter("NOM_DSI_ESR"),false);
String strDES_DSI_ESR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_DSI_ESR"),false);
String strIDZ_PSA_ELT_DSI_ESR=c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"),request.getParameter("IDZ_PSA_ELT_DSI_ESR"),false);
java.sql.Date dtDAT_CSG_DOC_DSI=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.consegna"),request.getParameter("DAT_CSG_DOC_DSI"),false);

long lCOD_DTE=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi"),request.getParameter("COD_DTE"),true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"),request.getParameter("COD_DPD"),true);
long lCOD_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"),request.getParameter("COD_UNI_ORG"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

//------end check section--------------------------------
if((String)request.getParameter("SBM_MODE")!=null)
{
	try{
		IDestinatarioDocumentoHome home=(IDestinatarioDocumentoHome)PseudoContext.lookup("DestinatarioDocumentoBean");
		if(request.getParameter("SBM_MODE")!=null){
			ReqMODE=request.getParameter("SBM_MODE");
			if(ReqMODE.equals("edt"))
			{
				bean = home.findByPrimaryKey(new Long(lCOD_LST_DSI_DOC));
			}
			else{
				bean=home.create(lCOD_DOC, lCOD_AZL);
				out.print(printScriptIsNew());
				lCOD_LST_DSI_DOC=bean.getCOD_LST_DSI_DOC();
			}
			if(bean!=null){
				bean.setCOD_DPD(lCOD_DPD);
		 		bean.setNOM_DSI_ESR(strNOM_DSI_ESR);
				bean.setDES_DSI_ESR(strDES_DSI_ESR);
				bean.setIDZ_PSA_ELT_DSI_ESR(strIDZ_PSA_ELT_DSI_ESR);
				bean.setDAT_CSG_DOC_DSI(dtDAT_CSG_DOC_DSI);
				bean.setCOD_DTE(lCOD_DTE);
				bean.setCOD_DPD(lCOD_DPD);
				//if (true) throw new Exception(" "+lCOD_UNI_ORG);
				bean.setCOD_UNI_ORG(lCOD_UNI_ORG);
			}
		}
	}
	catch(Exception ex){
		%>
			<div id="divErr">
				<%=ex%>
			</div>
		<%
		out.print("<script>err=true;</script>");
	}
}

%>
<script>
if (!err){
  if(isNew){
   		Alert.Success.showCreated()
   		parent.ToolBar.OnNew("ID=<%=lCOD_LST_DSI_DOC%>");
  }
  else{
  	Alert.Success.showSaved();
  }
}
else{
	Alert.Error.showDublicate();
}
</script>
