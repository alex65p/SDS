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

<%@ include file="../src/com/apconsulting/luna/ejb/DittaEsternaTelefono/DittaEsternaTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DittaEsternaTelefono/DittaEsternaTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head><title><%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%></title></head>
<link rel="stylesheet" href="../_styles/style.css">
<script>
window.dialogWidth="290px";
window.dialogHeight="200px";
</script>
<body style="margin:0 0 0 0;">
<%
  long COD_NUM_TEL_DTE=0;	  		//1
  long COD_DTE=0; 	         		//2
  String TPL_NUM_TEL = "";			//3
  String NUM_TEL = "";  			//4
  IDittaEsternaTelefono Tel=null;
  IDittaEsternaTelefonoHome TelHome=(IDittaEsternaTelefonoHome)PseudoContext.lookup("DittaEsternaTelefonoBean");
//if (true) return;
 if(request.getParameter("ID")!=null)
 {
 	// getting parameters of ditta esterna
	String strCOD_NUM_TEL_DTE = (String)request.getParameter("ID");
	//getting of DittaEsternaTelefono object
	Long tel_id=new Long(strCOD_NUM_TEL_DTE);  
	Tel = TelHome.findByPrimaryKey(tel_id); 
	// getting of object variables          
	COD_NUM_TEL_DTE = tel_id.longValue();   
	COD_DTE = Tel.getCOD_DTE();             
	TPL_NUM_TEL = Tel.getTPL_NUM_TEL();     
	NUM_TEL = Tel.getNUM_TEL();             
 }// if request
	Checker c = new Checker();
	COD_DTE = c.checkLong("",request.getParameter("ID_PARENT"), false);
%>

<form action="NUM_TEL_DTE_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table cellpadding="0" cellspacing="0" border=0 width='100%'>

<tr style='height:10'><td></td></tr>
<tr valign="top"><td>
<table border="0" cellpadding="0" cellspacing="0" width='100%'>
  <tr><td align="center" class="title" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%></td></tr>
	<tr><td>
	<!-- ##################################################################################### -->
<table width="100%" border="0">
  		<%@ include file="../_include/ToolBar.jsp" %>
		<%ToolBar.bShowNew=true;%>
		<%ToolBar.bShowSearch=false;%>
		<%ToolBar.bShowDelete=false;%>
		<%ToolBar.bShowPrint=false;
		ToolBar.bShowReturn=false;
		%>
		<%=ToolBar.build(3)%>
		</table>
<!-- ##################################################################################### -->
	

<table width="100%"> <tr> <td>
        <fieldset style="padding:10 10 10 10">			
  	          <legend><%=ApplicationConfigurator.LanguageManager.getString("Contatto.telefonico")%></legend>
                   <table border="0" cellpadding="0" cellspacing="0" width='100%'>
                <tr><td></td><td><input name="SBM_MODE" type="hidden"  value="<%if(COD_NUM_TEL_DTE!=0){out.print("edt");}else{out.print("new");}%>">
		</td>
	</tr>
   	<tr><td></td>
   		<td>	
			<input name="COD_NUM_TEL_DTE" id="COD_NUM_TEL_DTE" type="hidden" value="<%=COD_NUM_TEL_DTE%>">
   			<input name="COD_DTE" type="hidden" value="<%=COD_DTE%>">
		</td>
	</tr>
     <tr>
         <br>
		          <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</td>
		          <td colspan="4">
                              <select name="TPL_NUM_TEL" style="width:'192'">
                                    <option value="FISSO" <%=(TPL_NUM_TEL.equals("FISSO"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("FISSO")%></option>
                                    <option value="CELLULARE" <%=(TPL_NUM_TEL.equals("CELLULARE"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("CELLULARE")%></option>
                                    <option value="FAX" <%=(TPL_NUM_TEL.equals("FAX"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("FAX")%></option>
                                    <option value="CERCA PERSONE" <%=(TPL_NUM_TEL.equals("CERCA PERSONE"))?"selected":""%>><%=ApplicationConfigurator.LanguageManager.getString("CERCA.PERSONE")%></option>
                             </select>                              
                          </td>

      <tr>
	  	          <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Numero")%>&nbsp;</td>
                  <td colspan="4"><input style="width:100%" id="NUM_TEL" type="text" name="NUM_TEL" maxlength="15" value="<%=Formatter.format(NUM_TEL)%>"></td>
		 <td width="3"></td>
	 </tr>
       </tr>  
   </table>	  
   </fieldset>
      </td>
 </tr>
 </table>
</td></tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
<script>
	//---------------
	ToolBar.Return.setEnabled(false);
</script>
</body>
</html>
