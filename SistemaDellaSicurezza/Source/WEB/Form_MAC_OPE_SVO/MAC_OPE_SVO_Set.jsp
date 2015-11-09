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
    <version number="1.0" date="10/02/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="10/02/2004" author="Pogrebnoy Yura">
				   <description>MAC_OPE_SVO_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<%!	String ReqMODE;%>
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" src="../_scripts/call_GEST_MAN.js"></script>
<%
IMacchina mac=null;
IMacchinaHome home=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");
Long lCOD_MAC=null;

if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	long lCOD_TPL_MAC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Descrizione.tipologia"),request.getParameter("COD_TPL_MAC"),true);   
	String strDES_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_MAC"),true);
	String strMDL_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Modello"),request.getParameter("MDL_MAC"),true);
	String strIDE_MAC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Identificativo"),request.getParameter("IDE_MAC"),true);
    String strDIT_CST_MAC=request.getParameter("DIT_CST_MAC");
	if( "".equals(strDIT_CST_MAC) )strDIT_CST_MAC="-";
	strDIT_CST_MAC=c.checkString("DIT_CST_MAC",strDIT_CST_MAC,true);
    String strFBR_MAC=request.getParameter("FBR_MAC");
	if( "".equals(strFBR_MAC) )strFBR_MAC="-";
	strFBR_MAC=c.checkString("FBR_MAC",strFBR_MAC,true);
	
    long lCOD_AZL=Security.getAzienda();
	String strID_PARENT=(String)request.getParameter("ID_PARENT");
	String NomeParent=request.getParameter("NomeParent");
	
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

  if(ReqMODE.equals("edt"))	{
		lCOD_MAC=new Long(c.checkLong(
                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ? "Associativa.macchine.attrezzature.impianti"
                        : "Associativa.macchine/attrezzature"
                        ,request.getParameter("COD_MAC"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		try{
			//mac = home.findByPrimaryKey(lCOD_MAC);
			//mac.setMDL_MAC(strMDL_MAC);
			//mac.setCOD_TPL_MAC(lCOD_TPL_MAC);
			//mac.setIDE_MAC__DES_MAC(strIDE_MAC, strDES_MAC);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
	}
	if(ReqMODE.equals("new"))	{
		try{
			//mac=home.create(strIDE_MAC,strDES_MAC,strMDL_MAC,strDIT_CST_MAC,strFBR_MAC,lCOD_TPL_MAC,lCOD_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
		out.print ("<script>isNew=true;</script>");
	}
//	if((home.getOPE_SVO_MAN_View(strID_PARENT)!=0) && ("MACCHINA".equals(NomeParent))){%>
	  <script>
	  //sFeatures="dialogWidth:800px; dialogHeight:600px; resizable:no; scroll:no; status:no;";
//dialogstr=window.showModalDialog("../Form_GEST_MAN/GEST_MAN_Form.jsp?COD=<%=strID_PARENT%>&TypeMAN=ope_svo&COD_RSO=1","",sFeatures);
		showGestMan(<%=strID_PARENT%>,"ope_svo",1);
	</script>
<%//}
}
if(mac==null)return;
%>
<script>
<!--
   if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=mac.getCOD_MAC()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
//-->
</script>
