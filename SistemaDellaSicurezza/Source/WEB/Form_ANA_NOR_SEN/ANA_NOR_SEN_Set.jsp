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
    <version number="1.0" date="27/01/2004" author="Alexey Kolesnik">		
      <comments>
			   <comment date="27/01/2004" author="Alexey Kolesnik">
				   <description> Shablon formi ANA_NOR_SEN_Set.jsp </description>
			   </comment>		
				 <comment date="30/01/2004" author="Treskina Maria">
				   <description> added functions to work as TAB element on Tipologia DPI form </description>
				 </comment>	
				  <comment date="31/01/2004" author="Alexey Kolesnik">
				   <description> Added new toolbar </description>
				 </comment>
				 <comment date="01/02/2004" author="Alexey Kolesnik">
				   <description> Change return in parent window </description>
				 </comment>		
				 <comment date="06/02/2004" author="Yuriy Kushkarov">
					<description> set Return from Tab+Alerts </description>
				</comment>
				<comment date="13/02/2004" author="Treskina Mary">
					<description> comment parent.dialogArguments for dinamic tabs</description>
				</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.NormativeSentenze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" type="text/javascript">
<!--
		var err=false;
		var isNew = false;
//-->
</script>

<%!
	String ReqMODE;	// parameter of request 
%>
	
<%
INormativeSentenze bean=null;

	Long lCOD_TPL_DPI = null;
	String strCOD_TPL_DPI = request.getParameter("ID_PARENT");
	if (strCOD_TPL_DPI!=null && !strCOD_TPL_DPI.equals("") && !strCOD_TPL_DPI.equals("null")){
		//out.print("<script>alert(\"bvbc-"+request.getParameter("ID_PARENT")+"\");</script>");
		lCOD_TPL_DPI = new Long (request.getParameter("ID_PARENT"));
	}

//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_NOR_SEN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.normativa/sentenza"),request.getParameter("COD_NOR_SEN"),true);
java.sql.Date dtDAT_NOR_SEN=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"),request.getParameter("DAT_NOR_SEN"),true);
String strNUM_DOC_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero"),request.getParameter("NUM_DOC_NOR_SEN"),false);
String strTIT_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),request.getParameter("TIT_NOR_SEN"),true);
String strFON_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Fonte"),request.getParameter("FON_NOR_SEN"),false);
String strDES_NOR_SEN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_NOR_SEN"),true);
long lCOD_ORN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Organo"),request.getParameter("COD_ORN"),true);
long lCOD_SET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Settore"),request.getParameter("COD_SET"),true);
long lCOD_TPL_NOR_SEN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia"),request.getParameter("COD_TPL_NOR_SEN"),true);
long lCOD_SOT_SET=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sottosettore"),request.getParameter("COD_SOT_SET"),true);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}

INormativeSentenzeHome home=(INormativeSentenzeHome)PseudoContext.lookup("NormativeSentenzeBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_NOR_SEN));
		
		try{
				bean.setTIT_NOR_SEN(strTIT_NOR_SEN);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
			return;
		}
		bean.setDES_NOR_SEN(strDES_NOR_SEN);
 		bean.setDAT_NOR_SEN(dtDAT_NOR_SEN);
		bean.setCOD_ORN(lCOD_ORN);
		bean.setCOD_SET(lCOD_SET);
		bean.setCOD_TPL_NOR_SEN(lCOD_TPL_NOR_SEN);
		bean.setCOD_SOT_SET(lCOD_SOT_SET);	
	}
	else{
		try{
				bean=home.create(strTIT_NOR_SEN, strDES_NOR_SEN, dtDAT_NOR_SEN, lCOD_ORN, lCOD_SET, lCOD_TPL_NOR_SEN, lCOD_SOT_SET);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate(); err=true;</script>");
		}
		 out.print ("<script>isNew=true;</script>");
		
		  ///////////////////////////////////////
    	// adding link on anagrafica domande //
    	///////////////////////////////////////
    	/*if (lCOD_TPL_DPI!=null){
      	lCOD_NOR_SEN = bean.getCOD_NOR_SEN();
      	ITipologiaDPI tipologiaDPI=null;
      	ITipologiaDPIHome tplhome=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
      	tipologiaDPI = tplhome.findByPrimaryKey(lCOD_TPL_DPI);
    		
				try{
					tipologiaDPI.addCOD_NOR_SEN(lCOD_NOR_SEN);
    		}catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate(); err=true;</script>");
    		}
				
    	}*/
		
	}
	if(bean!=null){
 		bean.setNUM_DOC_NOR_SEN(strNUM_DOC_NOR_SEN);
		bean.setFON_NOR_SEN(strFON_NOR_SEN);
	}
}
%>
<script language="JavaScript" type="text/javascript">
<!--
	if (!err){
		if(isNew){
    		Alert.Success.showCreated();
    		parent.ToolBar.OnNew("ID=<% if (bean!=null) out.print(bean.getCOD_NOR_SEN()); %>");
		}else{
				Alert.Success.showSaved();
		}
	}
</script>
