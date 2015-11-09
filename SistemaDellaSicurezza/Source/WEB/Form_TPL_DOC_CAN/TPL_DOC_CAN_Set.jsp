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
    <version number="1.0" date="23/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="23/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi TPL_DOC_Form.jsp</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%@ page import="com.apconsulting.luna.ejb.TipologiaDocumentiCantiere.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request%>
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
java.util.Hashtable hs = new java.util.Hashtable();
ITipologiaDocumentiCantiere tpldoc=null;
ITipologiaDocumentiCantiereHome home=(ITipologiaDocumentiCantiereHome)PseudoContext.lookup("TipologiaDocumentiCantiereBean");
Long lCOD_TPL_DOC=null;
String strDES_TPL_DOC="";
String strALL_STA_SOP="";
String strTPL_ACQ_POS="";
String strCOL_SOP="";
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	String strNOM_TPL_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_TPL_DOC"),true);
	strDES_TPL_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_TPL_DOC"),false);
        strCOL_SOP=c.checkString(ApplicationConfigurator.LanguageManager.getString("Collegamento.con.sopralluogo"),request.getParameter("COL_SOP"),false);
        strALL_STA_SOP=c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.acquisizione.POS"),request.getParameter("ALL_STA_SOP"),false);
        strTPL_ACQ_POS=c.checkString(ApplicationConfigurator.LanguageManager.getString("Allegato.stampa.sopralluogo"),request.getParameter("TPL_ACQ_POS"),false);
	if (c.isError){
		String err = c.printErrors();
		%><script>alert("<%=err%>");</script><%
		return;
	}
        if (strCOL_SOP.equals("on")){
		 strCOL_SOP="S";
	}
	else{
		 strCOL_SOP="N";
	}
        if (strALL_STA_SOP.equals("on")){
		 strALL_STA_SOP="S";
	}
	else{
		 strALL_STA_SOP="N";
	}
        if (strTPL_ACQ_POS.equals("on")){
		 strTPL_ACQ_POS="S";
	}
	else{
		 strTPL_ACQ_POS="N";
	}
        

  //------------------------------------
    if("edt".equals(ReqMODE))	{
		lCOD_TPL_DOC=new Long(c.checkLong("TipologiaDocumenti ID",request.getParameter("COD_TPL_DOC"),true));
                if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
    try{
  		tpldoc = home.findByPrimaryKey(lCOD_TPL_DOC);
		  tpldoc.setNOM_TPL_DOC(strNOM_TPL_DOC);
		}catch(Exception ex){
			out.print("<script>err=true;</script>");
		}
	}
	if("new".equals(ReqMODE)){
		try{
		  tpldoc=home.create(strNOM_TPL_DOC);
	  }catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		out.print ("<script>isNew=true;</script>");
	}
}
if (tpldoc!=null){
	tpldoc.setDES_TPL_DOC(strDES_TPL_DOC);
	tpldoc.setCOL_SOP(strCOL_SOP);
	tpldoc.setALL_STA_SOP(strALL_STA_SOP);
        tpldoc.setTPL_ACQ_POS(strTPL_ACQ_POS);
%>
<script language="JavaScript" type="text/javascript">
<!--
 if (parent.dialogArguments){
 	if (!err){
//		fatrso=parent.dialogArguments;
//		fatrso.ID = "< %=colint.getCOD_COL_INT()%>";
//		fatrso.INDEX="< %=lCOD_FAT_RSO%>";
//		fatrso.indirizzo="< %=colint.getIDZ_COL_INT()%>";
//		fatrso.codFATRSO="< %=lCOD_FAT_RSO%>";
		parent.returnValue="OK";
		if(isNew){
		  Alert.Success.showCreated();
			parent.ToolBar.Return.OnClick();
		}else{
	     Alert.Success.showSaved();
			 parent.ToolBar.Exit.setEnabled(false);
			 parent.ToolBar.Return.setEnabled(true);
		}
	}else{
		   parent.returnValue="ERROR";
	}
 }else{
   if(!err){
 		if(isNew){
		  Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=tpldoc.getCOD_TPL_DOC()%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
   }else{
	  Alert.Error.showDublicate();
		parent.returnValue="ERROR";
	 }
 }
//-->
</script>
<%}%>
