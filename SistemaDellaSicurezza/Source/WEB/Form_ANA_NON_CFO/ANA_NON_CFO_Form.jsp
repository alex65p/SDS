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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="com.apconsulting.luna.ejb.NonConformita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_NON_CFO_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSPP,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
</head>

<script>
window.dialogWidth="740px";
window.dialogHeight="390px";
</script>
<body>
<%
	long	lCOD_AZL = Security.getAzienda();	//2 
	String	strDES_NON_CFO = "";				//3
	String	strDAT_RIL_NON_CFO = "";			//4
	String	strNOM_RIL_NON_CFO = "";			//5
	String	strOSS_NON_CFO = "";				//6
	long	lCOD_INR_ADT = 0;					//7
	String 	strCOD_NON_CFO = "";   				//1

IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
INonConformita NonConformita=null;

if(request.getParameter("ID")!=null)
{
		strCOD_NON_CFO = request.getParameter("ID");
		INonConformitaHome home=(INonConformitaHome)PseudoContext.lookup("NonConformitaBean"); 
		Long COD_NON_CFO=new Long(strCOD_NON_CFO);
		NonConformita = home.findByPrimaryKey(COD_NON_CFO);
		// getting of object variables
		strDES_NON_CFO=NonConformita.getDES_NON_CFO();
		strNOM_RIL_NON_CFO=NonConformita.getNOM_RIL_NON_CFO();
		strOSS_NON_CFO=NonConformita.getOSS_NON_CFO();
		lCOD_INR_ADT=NonConformita.getCOD_INR_ADT();
		strDAT_RIL_NON_CFO=Formatter.format(NonConformita.getDAT_RIL_NON_CFO());/**/
}
Long azl_id=new Long(lCOD_AZL);
long COD_AZL=new Long(lCOD_AZL).longValue();
	azienda = AziendaHome.findByPrimaryKey(azl_id);
	String	strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
%>

<!-- form for addind  -->
<form action="ANA_NON_CFO_Set.jsp?par=add"  method="POST" target="ifrmWork">
<table width="100%" border="0">

<tr>
 <td width="10" height="100%" valign="top"></td>
 <td valign="top">
  <table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuVerificheSPP,1,<%=request.getParameter("ID")%>));
    </script>      
  </td></tr>
<input name="SBM_MODE" type="hidden" value="<%if(strCOD_NON_CFO==""){out.print("new");}else{out.print("edt");}%>">
<input name="COD_NON_CFO" type="hidden" value="<%=strCOD_NON_CFO%>">
<input name="COD_AZL" type="Hidden" value="<%=COD_AZL%>">
  <tr>
	<td>
<!-- ############################ -->

 <!-- ########################### -->	
 
<!-- Inizo modifica effettuata da Francesco Di Martino 01-10-2004 -->
<table>
	<tr>
		<td>
			<%@ include file="../_include/ToolBar.jsp" %>
        	<%ToolBar.bCanDelete=(NonConformita!=null);
		  	ToolBar.bCanReturn=(request.getParameter("ATTACH_SUBJECT")!=null && request.getParameter("ID")!=null);	
		  	ToolBar.strSearchUrl=ToolBar.strSearchUrl.replace('&','|');
			%>
			<%=ToolBar.build(2)%>
		</td>
	</tr>
</table>
<!-- Fine modifica effettuata da Francesco Di Martino 01-10-2004 --> 
 
 
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.non.conformità")%></legend>
   <table  width="100%" border="0">
   <tr>
      <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
      <td  style="width:100%"><input size="100%" type="text" name="RAG_SCL_AZL" value="<%=strRAG_SCL_AZL%>" readonly>
   </td></tr>
	 <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento.d'audit")%>&nbsp;</td>
	 <td><select tabindex="1" style="width:52%" name="COD_INR_ADT">
	 
	 <%
	 IInterventoAudutHome conf_home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
	 if (request.getParameter("ATTACH_SUBJECT")!=null){
	 	if (request.getParameter("ATTACH_SUBJECT").equals("INR_NON_CFO")){
			Long id = new Long(request.getParameter("ID_PARENT"));
			try{
				IInterventoAudut auBean=conf_home.findByPrimaryKey(id);
				long lCOD_INR=auBean.getCOD_INR_ADT();
				String strDES_INR = auBean.getDES_INR_ADT();
				out.println("<option value='"+lCOD_INR+"'>"+strDES_INR+"</option>");
			}
			catch(Exception ex){
				
			}	
		}
	 }
	 else{
	 	%><option value=""></option><%
	 	String conf_cb=BuildNonConformitaComboBox(conf_home, lCOD_INR_ADT, COD_AZL);
	 	out.print(conf_cb);
	 }
	 %>
	 </select></td>
	 </tr>
	 <tr><td valign="top" nowrap align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.non.conformità")%>&nbsp;</td>
	 <td><textarea style="width:100%" tabindex="2" cols="102" rows="4" name="DES_NON_CFO"><%=strDES_NON_CFO%></textarea></td>
	 </tr>
	 <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Data.rilievo.non.conformità")%>&nbsp;</b></td>
         <td ><s2s:Date tabindex="3" id="DAT_RIL_NON_CFO" name="DAT_RIL_NON_CFO" value="<%=strDAT_RIL_NON_CFO%>"/></td></tr>
	 <td align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("Rilevatore.non.conformità")%>&nbsp;</b></td>
	 <td ><input tabindex="4" size="50" maxlength="100" type="text" name="NOM_RIL_NON_CFO" value="<%=strNOM_RIL_NON_CFO%>">
   </td></tr>
	 <tr><td valign="top" nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Osservazione.non.conformità")%>&nbsp;</td>
	 <td><textarea style="width:100%" tabindex="5" cols="102" rows="4" name="OSS_NON_CFO" ><%=strOSS_NON_CFO%></textarea></td>
	 </tr>
	 </tr>
   </td></tr>

   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
</table>
</form>
<!-- /form for addind  -->

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>
var btnSave, btnReturn;
function init(){
	btnSave = ToolBar.Save.getButton();
	btnReturn = ToolBar.Return.getButton();
	btnReturn.onclick = OnReturn;
}
function OnReturn(){
	document.forms[0].action += "&ATTACH_SUBJECT=INR_NON_CFO"; 
	btnSave.click();
}
</script>
</body>
</html>
