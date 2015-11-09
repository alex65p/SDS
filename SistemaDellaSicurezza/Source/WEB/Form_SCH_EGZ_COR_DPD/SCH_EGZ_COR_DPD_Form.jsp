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
    <version number="1.0" date="30/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="30/01/2004" author="Kushkarov Yura">
				   <description>SCH_EGZ_COR_DPD_Form.jsp</description>
				 </comment>	
				 <comment date="13/05/2004" author="Treskina Maria">
				   <description>polychenie parametrov pri peregryzke</description>
				 </comment>	
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>



<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<% String Title = ApplicationConfigurator.LanguageManager.getString("Lavoratori.iscritti"); %>

<html>
<head>
<script>
window.dialogWidth="650px";
window.dialogHeight="240px";
</script>
    
	<title><%=Title%></title>
	<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
</head>
<body>
<%
	// * require fields *
	String strCOD_SCH_EGZ_COR="";
  long lCOD_AZL = Security.getAzienda();
	long lCOD_COR = 0;
	long lCOD_SCH_EGZ_COR = 0;
	long lCOD_DPD = 0;
	long lCOD_DTE=0; //
	long lSELECTED_ID=0;
	String SELECTED_ID="";
	IAzienda azienda;
	IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
	Long azl_id=new Long(lCOD_AZL);
	long COD_AZL=new Long(lCOD_AZL).longValue();
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
	IErogazioneCorsiHome home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean"); 
	IErogazioneCorsi ErogazioneCorsi = null;
if( request.getParameter("ID_PARENT")!=null)
{
		strCOD_SCH_EGZ_COR = request.getParameter("ID_PARENT");		
		Long COD_SCH_EGZ_COR=new Long(strCOD_SCH_EGZ_COR);
		lCOD_SCH_EGZ_COR=new Long(strCOD_SCH_EGZ_COR).longValue();
		// getting of object variables
		ErogazioneCorsi = home.findByPrimaryKey(COD_SCH_EGZ_COR);
		// getting of object variables
		lCOD_COR=ErogazioneCorsi.getCOD_COR();
		if(request.getParameter("ID")!=null)
		{
		  SELECTED_ID=request.getParameter("ID");
			lSELECTED_ID=new Long(SELECTED_ID).longValue();
		}
		if(request.getParameter("ID1")!=null)
		{
		  lCOD_DTE=new Long(request.getParameter("ID1")).longValue();
			//lSELECTED_ID=new Long(SELECTED_ID).longValue();
		}
}
%>

<!-- form  -->
<form action="SCH_EGZ_COR_DPD_Set.jsp"  method="POST" target="ifrmWork"  style="margin:0 0 0 0;">
<input type="hidden" value="<%=strRAG_SCL_AZL%>" name="RAG_AZL">
<table width="100%" border="0">

<tr>
 <td valign="top">
         <table  width="100%" border="0">
             <tr><td class="title" width="100%"><%=Title%>&nbsp;-&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Gestione")%></td></tr>
             <input name="SBM_MODE" type="hidden" value="<%if(lCOD_DPD==0){out.print("new");}else{out.print("edt");}%>">
             <input name="COD_SCH_EGZ_COR" type="Hidden" value="<%=lCOD_SCH_EGZ_COR%>">
             <input name="COD_COR" type="Hidden" value="<%=lCOD_COR%>">
             <input name="COD_AZL" type="Hidden" value="<%=lCOD_AZL%>">
             <tr>
                 
                 <td>
                     <%@ include file="../_include/ToolBar.jsp" %>
                     <%ToolBar.bShowNew=false;%>
                     <%ToolBar.bShowSearch=false;%>
                     <%ToolBar.bShowDelete=false;%>
                     <%ToolBar.bShowPrint=false;
                     ToolBar.bCanReturn = true;
                     %>
                     <%=ToolBar.build(3)%>
                 </td>
             </tr>
         </table>
         <table width="100%">
             <tr> <td>
                         <fieldset>
                         <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></legend>
                         <table  width="100%" border="0">
                         <tr><td valign="top" align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>&nbsp;</strong></td>
                             <td valign="top" colspan="100">
                                 <select name="COD_DTE" id="COD_DTE" style="width:400">
                                     <option></option>
                                     <%
                                     String str="";
                                     String strSEL="";
                                     java.util.Collection col = home.getErogazioneCorsi_DTEGet_View();
                                     java.util.Iterator it = col.iterator();
                                     while(it.hasNext()){
                                     ErogazioneCorsi_DTEGet_View  dt = (ErogazioneCorsi_DTEGet_View)it.next();
                                     long var1=dt.COD_DTE;
                                     if (lCOD_DTE==var1) strSEL="selected";
                                     else strSEL="";
                                     str=str+"<option "+strSEL+" value=\""+var1+"\">"+dt.RAG_SCL_DTE+"</option>";
                                     }
                                     out.print(str);
                                     %>
                             </select></td>
                         </tr>
                         <tr><td valign="top" align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</strong></td>
                             <td valign="top" colspan="100">
                                 <select name="COD_DPD" id="COD_DPD" style="width:400">
                                     <option></option>
                                     <% 
                                     IDipendenteHome d_home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                                     out.print(BuildDipendenteComboBox(d_home, lSELECTED_ID, lCOD_AZL));
                                     %>
                             </select></td>
                         </tr>
                 </td></tr>
             </table>
             </fieldset>
	 </td></tr>
  </table>
 </td>
</tr>
</table>
</form>
<!-- /form -->
<script>
	btnReturn=ToolBar.Return.getButton();
	btnReturn.onclick= submitForm;
	
	function submitForm(){
		frm = document.forms[0];
		frm.action+="?return=1";
		
		frm.submit();
	}
</script>
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>//ToolBar.Return.setEnabled(false);</script>
</body>
</html>
