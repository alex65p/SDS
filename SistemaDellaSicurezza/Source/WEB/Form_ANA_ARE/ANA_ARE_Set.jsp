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
    <version number="1.0" date="22/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="22/01/2004" author="Mike Kondratyuk">
				   <description>Shablon formi ANA_TPL_UNI_ORG_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err=false;
var isNew=false;
</script>
<%!
	String ReqMODE;	// parameter of request
%>
<%
IGestioniSezioni GestioniSezioni=null;
Checker c = new Checker();

  long ID_PARENT=0;
	Long lCOD_DOC_VLU = null;
	long Priority=0;
	String strCOD_DOC_VLU = request.getParameter("ID_PARENT");
	Priority=c.checkLong("Priority",request.getParameter("PRT"),false);

	if (strCOD_DOC_VLU!=null && !strCOD_DOC_VLU.equals("") && !strCOD_DOC_VLU.equals("null")){
		//out.print("<script>alert(\"bvbc-"+request.getParameter("ID_PARENT")+"\");</script>");
		lCOD_DOC_VLU = new Long (request.getParameter("ID_PARENT"));
		//out.print("<script>alert("+lCOD_DOC_VLU+");</script>");
	}

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	//out.println(ReqMODE);

	//- checking for required fields
	long lCOD_ARE=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sezione"),request.getParameter("COD_ARE"),true);
	long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	String strNOM_ARE=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_ARE"),true);

	//- checking for not required fields
	long lCOD_ARE_R=c.checkLong("Sezione repository ID",request.getParameter("COD_ARE_R"),false);

	if (c.isError)
	{
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}
	ID_PARENT=c.checkLong("",request.getParameter("ID_PARENT"),false);

//=======================================================================================
	if(ReqMODE.equals("edt"))
	{
		// editing of attivitaLavorative--------------------
		// gettinf of object
		String strCOD_ARE=request.getParameter("COD_ARE");					//ID of attivitaLavorative
		IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
		Long are_id=new Long(strCOD_ARE);
		GestioniSezioni = home.findByPrimaryKey(are_id);

		try{
			GestioniSezioni.setNOM_ARE__COD_AZL(strNOM_ARE, lCOD_AZL);
			GestioniSezioni.setPriority_ANA_DOC_VLU(lCOD_ARE, ID_PARENT,lCOD_AZL, Priority);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new GestioniSezioni--------------------------
	// creating of object
		IGestioniSezioniHome home=(IGestioniSezioniHome)PseudoContext.lookup("GestioniSezioniBean");
		try{
			%><script>isNew=true;</script><%
			GestioniSezioni=home.create(strNOM_ARE, lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================
	if (GestioniSezioni!=null){
	//   *Not require Fields*
	//out.print(lCOD_ARE_R);
		GestioniSezioni.setCOD_ARE_R(lCOD_ARE_R);
	}
}
%>
<script>
/*
Dlya tabi
*/
<%
if(ID_PARENT!=0)
{
%>
	if(!err)
	{
		parent.window.returnValue="OK";
		if(isNew) {
		  Alert.Success.showCreated();
		  parent.ToolBar.OnNew("ID=<%=GestioniSezioni.getCOD_ARE()%>");
		} else {
		  Alert.Success.showSaved();
		}

	}
	else
	{
		parent.window.returnValue="ERROR";
	}
<%
}
else
{
%>
 	//------------------------------------------------
 	if(!err){
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=GestioniSezioni.getCOD_ARE()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";
	}
<%
}
%>

</script>
