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
    <version number="1.0" date="22/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="22/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_RST_Form.jsp</description>
				 </comment>		
				  <comment date="24/01/2004" author="Alexey Kolesnik">
				   <description> added functions to work as TAB element on Anagrafica Domande form </description>
				 </comment>		
				  <comment date="31/01/2004" author="Alexey Kolesnik">
				   <description> Added new toolbar </description>
				 </comment>		
				  <comment date="26/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
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

<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean.jsp" %>

<% // DomandeBean for create link on Domande...  added by forest  %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;%>

<script language="JavaScript" type="text/javascript">
<!--
		var err=false;
		var isNew = false;
//-->
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IRisposta risposta=null;

Long lCOD_DMD = null;
String strCOD_DMD = request.getParameter("ID_PARENT");
if (strCOD_DMD!=null && !strCOD_DMD.equals("") && !strCOD_DMD.equals("null")){
	lCOD_DMD = new Long (request.getParameter("ID_PARENT"));
}
	
out.print(Formatter.format(request.getParameter("SBM_MODE")));
if(request.getParameter("SBM_MODE")!=null){
	
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	String strNOM_RST=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_RST"),true);   
	String strDES_RST=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_RST"),false);
	if (c.isError){
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}

	if(ReqMODE.equals("edt")){
		Long lCOD_RST=new Long(c.checkLong("Risposta ID",request.getParameter("COD_RST"),true));
		if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert("+err+");</script>");
			return;
		}

		IRispostaHome home=(IRispostaHome)PseudoContext.lookup("RispostaBean");
		risposta = home.findByPrimaryKey(lCOD_RST);
		try{
			risposta.setNOM_RST(strNOM_RST);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
	}
	if(ReqMODE.equals("new")){
		IRispostaHome home=(IRispostaHome)PseudoContext.lookup("RispostaBean");
		try{
			risposta=home.create(strNOM_RST);
			out.print("NOM_RST= "+strNOM_RST);
			out.print ("<script>isNew=true;</script>");
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
		}
    	///////////////////////////////////////
    	// adding link on anagrafica domande //
    	///////////////////////////////////////
/*    	if (lCOD_DMD!=null && risposta!=null){
	      	long lCOD_RST = risposta.getCOD_RST();
   	   	IDomande Domande=null;
	      	IDomandeHome dhome=(IDomandeHome)PseudoContext.lookup("DomandeBean");
	      	Domande = dhome.findByPrimaryKey(lCOD_DMD);
     		try{
    			Domande.addCOD_RST(lCOD_RST, new String("S"));
    		}catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    		}	
    	}*/
	}
	if (risposta!=null){
		risposta.setDES_RST(strDES_RST);
%>
		<script language="JavaScript" type="text/javascript">
<!--
			if(!err){
				if(isNew){
					Alert.Success.showCreated();
					parent.ToolBar.OnNew("ID=<%=risposta.getCOD_RST()%>");
				}else{
					Alert.Success.showSaved();
				}
		  		parent.returnValue="OK";
			}
//-->
</script>
<%
	}
}
%>	

