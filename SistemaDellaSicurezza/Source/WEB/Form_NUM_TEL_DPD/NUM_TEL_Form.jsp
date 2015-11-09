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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head><title><%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%></title></head>
<link rel="stylesheet" href="../_styles/style.css">

<script>
window.dialogWidth="250px";
window.dialogHeight="180px";
</script>

<body style="margin:0 0 0 0;">
<%
  long lCOD_NUM_TEL_DPD=0;  	//1
  long lCOD_DPD=0;          	//2
  long lCOD_AZL=Security.getAzienda();          	//3
  String strTPL_NUM_TEL= "";  	//4
  String strNUM_TEL = "";	  	//5
  IDipendenteTelefono Tel=null;
  IDipendenteTelefonoHome TelHome=(IDipendenteTelefonoHome)PseudoContext.lookup("DipendenteTelefonoBean");

 if(request.getParameter("ID")!=null)
 {
 	// getting parameters of azienda
			String strCOD_NUM_TEL_DPD = (String)request.getParameter("ID");
	 		//getting of azienda object
			Long tel_id=new Long(strCOD_NUM_TEL_DPD);
			Tel = TelHome.findByPrimaryKey(tel_id);
			// getting of object variables
			lCOD_NUM_TEL_DPD = tel_id.longValue();
			lCOD_DPD = Tel.getCOD_DPD();
			lCOD_AZL = Tel.getCOD_AZL();
			strTPL_NUM_TEL = Tel.getTPL_NUM_TEL();
			strNUM_TEL = Tel.getNUM_TEL();
 }// if request
	Checker c = new Checker();
	lCOD_DPD = c.checkLong("",request.getParameter("ID_PARENT"), false);
%>
<form action="NUM_TEL_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table cellpadding="0" cellspacing="0" border='0' style='height:150px;'>
<tr  valign="top"><td width="100%">
		<table border="0" width="100%" height="100%">		 
  	<tr valign="top" >
  			<td align="center" class="title" valign="top" >
                             <%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%><br>
				</td>
		</tr>
		<tr>
				<td>
<table border="0">
<!-- ############################################################################## -->
  		<%@ include file="../_include/ToolBar.jsp" %>
		<%ToolBar.bShowNew=false;%>
		<%ToolBar.bShowSearch=false;%>
		<%ToolBar.bShowDelete=false;%>
		<%ToolBar.bShowPrint=false;%>
		<%//ToolBar.bShowExit=false;%>
		<%=ToolBar.build(3)%>
<!-- ############################################################################## -->
</table>
  					<fieldset>
   					<legend><%=ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico")%></legend>
                   <table cellpadding="0" cellspacing="0">
   										<tr>
													<td></td>
													<td><input name="SBM_MODE" type="hidden" value="<%if(lCOD_NUM_TEL_DPD!=0){out.print("edt");}else{out.print("new");}%>">								
													</td>
											</tr>
   										<tr> <td></td>
   												 <td>	
													 			<input name="COD_NUM_TEL_AZL" id="COD_NUM_TEL_DPD" type="hidden" value="<%=lCOD_NUM_TEL_DPD%>">
  															<input name="COD_DPD" type="hidden" value="<%=lCOD_DPD%>">
  															<input name="COD_AZL" type="hidden" value="<%=lCOD_AZL%>">
													</td>
											</tr>
     									<tr>
                                                                             <br>
                                                                             <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td>
		 											<td colspan="2">
                                                                                                             <select name="TPL_NUM_TEL" style="width:'175'">
                                                                                                                    <option value="FISSO" <%=(strTPL_NUM_TEL.equals("FISSO"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("FISSO")%></option>
                                                                                                                    <option value="CELLULARE" <%=(strTPL_NUM_TEL.equals("CELLULARE"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("CELLULARE")%></option>
                                                                                                                    <option value="FAX" <%=(strTPL_NUM_TEL.equals("FAX"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("FAX")%></option>
                                                                                                                    <option value="CERCA PERSONE" <%=(strTPL_NUM_TEL.equals("CERCA PERSONE"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("CERCA.PERSONE")%></option>
                                                                                                             </select>
                                                                                                        </td>
											</tr>	
   										<tr>
	  											<td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td><td colspan="4"><input size="30" id="NUM_TEL" type="text" name="NUM_TEL" maxlength="15" value="<%=Formatter.format(strNUM_TEL)%>"></td>
		 											<td width="3"></td>
	 										</tr>
   					</table>	  
   					</fieldset>
   			</td>
 		</tr>
 		<tr><td>&nbsp;</td></tr>
		</table>
</tr></td>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
