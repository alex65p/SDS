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
    <version number="1.0" date="26/02/2004" author="Mike Kondratyuk">
      <comments>
			   <comment date="26/02/2004" author="Mike Kondratyuk">
				   <description>Realizazija EJB dlia objecta DocentiCorso
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

<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DocentiCorso/DocentiCorsoBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>

<script>
var err=false;
var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%
IDocentiCorso bean = null;
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_DCT_COR=c.checkLong("COD_DCT_COR",request.getParameter("COD_DCT_COR"),true);
long lCOD_COR=c.checkLong("COD_COR",request.getParameter("COD_COR"),true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Docente"),request.getParameter("COD_DPD"),true);
long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
String strNOM_DCT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Docente"),request.getParameter("NOM_DCT"),false);
java.sql.Date dtDAT_INZ=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Inizio(default)"),request.getParameter("DAT_INZ"),true);
java.sql.Date dtDAT_FIE=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Fine"),request.getParameter("DAT_FIE"),false);
String strDES_DCT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_DCT"),false);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}

IDocentiCorsoHome home=(IDocentiCorsoHome)PseudoContext.lookup("DocentiCorsoBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_DCT_COR));
    try{
 		bean.setCOD_COR(lCOD_COR);
		bean.setCOD_DPD__COD_AZL__NOM_DCT__DAT_INZ(lCOD_DPD, lCOD_AZL, strNOM_DCT, dtDAT_INZ);
  		}catch(Exception ex){
  			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
  			return;
  		}
	}
	else{
		%><script type="text/javascript">isNew=true;</script><%
  		try{
			bean=home.create(lCOD_COR, lCOD_DPD, lCOD_AZL, strNOM_DCT, dtDAT_INZ);
  		}catch(Exception ex){
  			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
  			return;
  		}
	}
}
	if(bean!=null){
 		bean.setDAT_FIE(dtDAT_FIE);
		bean.setDES_DCT(strDES_DCT);

%>
<script type="text/javascript">
<!--
	if(!err)
	{
		parent.window.returnValue="OK";
		if(isNew) {
		  Alert.Success.showCreated();
		  parent.ToolBar.OnNew("ID=<%=bean.getCOD_DCT_COR()%>");
		} else {
		  Alert.Success.showSaved();
		}
	}
	else
	{
		parent.window.returnValue="ERROR";
	}
// -->
</script>
<%}%>
