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
    <version number="1.0" date="21/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="21/01/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi ANA_COU_Form.jsp</description>
					<comment date="01/02/2004" author="Pogrebnoy Yura">
				   <description>Dopolneniya v svyazi s toolbarom</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!	String ReqMODE;	// parameter of request%>
<script>
 var err=false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IUtenteHome Uhome=(IUtenteHome)PseudoContext.lookup("UtenteBean");
IConsultant cou=null;
Long lCOD_COU=null;
String ERRORER = "0";
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	
        //- checking for required fields
	String strNOM_COU=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"),request.getParameter("NOM_COU"),true);   
	String strUSD_COU=c.checkString(ApplicationConfigurator.LanguageManager.getString("Userid"),request.getParameter("USD_COU"),true);
	String strPSW_COU=c.checkString(ApplicationConfigurator.LanguageManager.getString("Password"),request.getParameter("PSW_COU"),true);
	String strSTA_COU=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"),request.getParameter("STA_COU"),true);
	
        //- checking for not required fields		
	String strRUO_COU=c.checkString(ApplicationConfigurator.LanguageManager.getString("Ruolo"),request.getParameter("RUO_COU"),false);
	java.sql.Date dDAT_ATT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attivazione"),request.getParameter("DAT_ATT"),false);
	java.sql.Date dDAT_DIS=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.disattivazione"),request.getParameter("DAT_DIS"),false);

	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
long lCOD_AZL=Security.getAzienda();
Collection col = Uhome.getUtente_View(lCOD_AZL);
Iterator it = col.iterator();
 while(it.hasNext()){
     Utente_View view = (Utente_View)it.next();
		 if (strUSD_COU.equals(view.USD_UTN))
		 {
		   ERRORER="1";
		 }
	}
 if ("0".equals(ERRORER))
 {	
  if(ReqMODE.equals("edt"))
  {
		lCOD_COU=new Long(c.checkLong("Consulente ID",request.getParameter("COD_COU"),true));
  	if (c.isError)
  	{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		IConsultantHome home=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
	  cou = home.findByPrimaryKey(lCOD_COU);
		try
		{			
	  	cou.setUSD_COU(strUSD_COU);
		}
		catch(Exception ex)
		{
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
 			cou.setNOM_COU(strNOM_COU);
		  cou.setPSW_COU(strPSW_COU);
	  	cou.setSTA_COU(strSTA_COU);
	}
	if(ReqMODE.equals("new"))
	{
		IConsultantHome home=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
		try
		{
		  cou=home.create(strUSD_COU,strPSW_COU,strSTA_COU,strNOM_COU);
		}
		catch(Exception ex)
		{
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		out.print ("<script>isNew=true;</script>");		
	}

//=======================================================================================
  if (cou!=null)
  {
	//   *Not require Fields*
		cou.setRUO_COU(strRUO_COU);
		cou.setDAT_ATT(dDAT_ATT);
		cou.setDAT_DIS(dDAT_DIS);
	}
 }
 else
 {
   out.print("<script>Alert.Error.showDublicate();err=true;</script>");
	 return;
 }
}
%>	
<script>
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
			parent.ToolBar.OnNew("ID=<%=cou.getCOD_COU()%>");
		}else{
	     Alert.Success.showSaved();
		}
  	parent.returnValue="OK";
//	  parent.window.close();
   }else{
	  Alert.Error.showDublicate();
	 }
 }
//-->
</script>
