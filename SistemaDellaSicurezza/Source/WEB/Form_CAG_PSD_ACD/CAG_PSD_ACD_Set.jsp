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
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	  <comments>
				 <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Shablon CAG_PSD_ACD_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script>
 var isNew = false;
 var err=false;
</script>
<script src="../_scripts/Alert.js"></script>
<%
ICategoriePreside CategoriePreside=null;
long lCOD=0;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");

		Checker c = new Checker();
		//- checking for required fields
			String strNOM_CAG_PSD_ACD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.categoria"),request.getParameter("NOM"),true);

		//- checking for not required fields
		String strDES_CAG_PSD_ACD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES"),false);
		long iPER_MES_SST=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.sostituzione"),request.getParameter("SST"),false);
		long iPER_MES_MNT=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.manutenzione"),request.getParameter("MNT"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of CategoriePreside--------------------
		// gettinf of object
		ICategoriePresideHome home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");

		Long for_id=new Long(c.checkLong("CategoriePreside ID",request.getParameter("FOR_ID"),true));

		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		CategoriePreside = home.findByPrimaryKey(for_id);
		//getting of parameters and set the new object variables
		try{
			CategoriePreside.setNOM_CAG_PSD_ACD(strNOM_CAG_PSD_ACD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}

		/*
		CategoriePreside.setDES_CAG_PSD_ACD( strDES_CAG_PSD_ACD);
		CategoriePreside.setPER_MES_SST( iPER_MES_SST);
		CategoriePreside.setPER_MES_MNT( iPER_MES_MNT);
		*/
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new CategoriePreside--------------------------
	// creating of object

	 out.print("<script>isNew=true;</script>");
		ICategoriePresideHome home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean");
	try
		 {
		CategoriePreside=home.create(strNOM_CAG_PSD_ACD);
		lCOD=CategoriePreside.getCOD_CAG_PSD_ACD();
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}		
	}
//=======================================================================================
  if (CategoriePreside!=null){
		//*Not require Fields*
	  	CategoriePreside.setDES_CAG_PSD_ACD( strDES_CAG_PSD_ACD);
		CategoriePreside.setPER_MES_SST( iPER_MES_SST);
		CategoriePreside.setPER_MES_MNT( iPER_MES_MNT);
	}
}
%>
<script>
 if (!err){
 						 if(isNew) {Alert.Success.showCreated();
						 					 parent.ToolBar.OnNew("ID=<%=lCOD%>");
						 }
						 else
						 {Alert.Success.showSaved(); }
					}
</script>
