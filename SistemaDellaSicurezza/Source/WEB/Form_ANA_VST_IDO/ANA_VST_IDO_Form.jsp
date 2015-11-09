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
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSanitarie,1) + "</title>");
</script>
</head>
<script>
window.dialogWidth="740px";
window.dialogHeight="320px";
</script>
<body style="margin:0 0 0 0;">
<LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
<%!  
	boolean EdFlag=false;		//flag of editing
%>
<%
	long 	lCOD_VST_IDO = 0;
	Long	lCOD_PRO_SAN = null;
	String 	strCOD_VST_IDO = "";
	String 	strNOM_AZL = "";
	String 	strFAT_PER = "";
	String 	strNOM_VST_IDO = "";
	long   	lCOD_AZL = Security.getAzienda();;
 	//----------------------------
	String strDES_VST_IDO = "";
	long lCOD_VST_IDO_RPO = 0;
	String strPER_VST = "";
	IGestioneVisiteIdoneita GestioneVisiteIdoneita=null;
	String strCOD_PRO_SAN=request.getParameter("ID_PARENT");
  	if (strCOD_PRO_SAN!=null && !strCOD_PRO_SAN.equals("") && !strCOD_PRO_SAN.equals("null"))
	{
		lCOD_PRO_SAN = new Long (request.getParameter("ID_PARENT"));
	}
//
 if(request.getParameter("ID")!=null)
{
	strCOD_VST_IDO = "0";	
	strCOD_VST_IDO = request.getParameter("ID");	
  	// editing of GestioneVisiteIdoneita 
	EdFlag=true;
	IGestioneVisiteIdoneitaHome home=(IGestioneVisiteIdoneitaHome)PseudoContext.lookup("GestioneVisiteIdoneitaBean");
	Long vst_ido_id=new Long(strCOD_VST_IDO);
	GestioneVisiteIdoneita = home.findByPrimaryKey(vst_ido_id);
	// getting of object variables
	lCOD_VST_IDO = vst_ido_id.longValue();
	strNOM_VST_IDO=Formatter.format(GestioneVisiteIdoneita.getNOM_VST_IDO());
	strFAT_PER=Formatter.format(GestioneVisiteIdoneita.getFAT_PER());
	strNOM_VST_IDO=Formatter.format(GestioneVisiteIdoneita.getNOM_VST_IDO());
	// --- 
	strDES_VST_IDO=Formatter.format(GestioneVisiteIdoneita.getDES_VST_IDO());
	lCOD_VST_IDO_RPO=GestioneVisiteIdoneita.getCOD_VST_IDO_RPO();
	//strPER_VST=Formatter.format(GestioneVisiteIdoneita.getPER_VST());
	//if (strPER_VST.equals("0")) {strPER_VST="";}
        
        	if (GestioneVisiteIdoneita.getPER_VST()!=0)
		 {
		 	strPER_VST = Formatter.format(GestioneVisiteIdoneita.getPER_VST());
		 }
        
}

IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
strNOM_AZL = azienda.getRAG_SCL_AZL();
%>

<form action="ANA_VST_IDO_Set.jsp" method="POST" id="frm1"  target="ifrmWork" style="margin:0 0 0 0;">
<input type="hidden" name="SBM_MODE" value="<%=(lCOD_VST_IDO==0)?"new":"edt"%>">
<input type="hidden" name="VST_IDO_ID" value="<%=lCOD_VST_IDO%>">
<input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
<input type="hidden" name="COD_VST_IDO_RPO" value="<%=lCOD_VST_IDO_RPO%>">
<input type="hidden" name="ID_PARENT" value="<%=strCOD_PRO_SAN%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
			<td valign="top">
			 <table width="100%">
			 <td>
			 <tr><td class="title">
                            <script>
                                document.write(getCompleteMenuPathFunction
                                    (SubMenuVerificheSanitarie,1,<%=request.getParameter("ID")%>));
                            </script>
			 </td></tr>
			 <tr><td width="100%">
		 <table border=0>
 		 <!-- ############################ -->  		
		 <%@ include file="../_include/ToolBar.jsp" %>      
		 <%ToolBar.bCanDelete=(GestioneVisiteIdoneita!=null);%>		
		 <%=ToolBar.build(2)%> 
		 <!-- ########################### -->
		 </table>
			 <fieldset><legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.di.idoneità")%></legend>													
				  <table width="100%">
					 <tr>
 	 		 		  <td align="right">
						<b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b>
						</td>
						 <td><b><input readonly type="text" name="Azienda" size="116" value="<%=strNOM_AZL%>"></td>												 
						 </tr>
						 <tr>
				 		 <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.visita")%>&nbsp;</b></td>
				 		 <td><b><input tabindex="1" type="text" name="NOM_VST_IDO" size="116" value="<%=strNOM_VST_IDO%>" maxlength="100"></b></td>																					 
						 </tr>
						 <tr>
                                                      <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>&nbsp;</b></td>
						 		<td valign="top">		
						 				<table width="100%" valign="top">
								 				<tr>
								 				<td valign="top"><input tabindex="2"  type="radio" value="M" name="FAT_PER" class="checkbox" <%=(strFAT_PER.equals("M"))?"checked":""%>>
                                                                                               &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Mensile")%></input>
                                                                                                <br><input tabindex="3"  type="radio" value="U" name="FAT_PER" class="checkbox"  <%=(!strFAT_PER.equals("M")) ? "checked" : ""%>>
                                                                                               &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unica")%></input></td>

<td align="center" valign="center" width="400"><table><tr>
<td><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.visita")%>&nbsp;
<input tabindex="4" type="text" name="PER_VST" size="10" value="<%=strPER_VST%>"></td>
                 <td align="center">
	<!--fieldset valign="middle" style="margin: 0 0 0 8; width:100%;height:100%;">
	<legend>Repository</legend>	
	<table  border="0" style="width:100%; height:100%">
	<tr>
		<td width="50%" align="center"> 
			<button tabindex="5"  onclick="CaricaDbRischio()"><img src="../_images/new/connect1.gif"/></button>
		</td>
		<td width="50%" align="center">
			<button tabindex="6"  onclick="CaricaRpRischio()" ><img src="../_images/new/pen2.gif"/></button>	
	</td>																																			</tr>
	</table>
	</fieldset-->
										</td></tr></table></td>
								</tr>
			 				</table>
						</td>
					 </tr>
					 <tr>
			<td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
			<td align="left"><textarea tabindex="7" rows="3" cols="50" name="DES_VST_IDO"><%=strDES_VST_IDO%></textarea>
			</td>
</table>
											</fieldset>
			</td></tr>
			</table>
				</td>
			</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script language="JavaScript">
function CaricaDbRischio(){
<%if(DEBUG){%>
	window.open("../Form_CRM_VST_IDO/CRM_VST_IDO_Form.jsp");
<%}else{%>
	window.showModalDialog("../Form_CRM_VST_IDO/CRM_VST_IDO_Form.jsp?ADD=y", 0, "dialogWidth:830px;dialogHeight:320px;status:no;help:no;scroll:no;");
<%}%>
}
function CaricaRpRischio(){
    document.all["frm1"].action="ANA_VST_IDO_Repository.jsp";
    document.all["frm1"].submit();
  /*nom=document.all['NOM_VST_IDO'].value;
	azl=document.all['COD_AZL'].value;
	document.all['ifrmWork'].src="ANA_VST_IDO_Repository.jsp?AZIENDA="+azl+"&NOME="+nom+"&FROM=right";
	*/
}
</script>
</body>
</html>
