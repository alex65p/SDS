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
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
<script language="JavaScript" src="ANA_VST_MED_Script.js"></script>
<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuVerificheSanitarie,0) + "</title>");
</script>
</head>
<script>
window.dialogWidth="740px";
window.dialogHeight="300px";
</script>
<body>
<%! 
	boolean EdFlag=false;		//flag of editing
%>

<%
long	lCOD_VST_MED = 0;				 					  //1
String	strCOD_VST_MED = "";				 				  //1
String	strFAT_PER = "";     			 					  //2
String	strNOM_VST_MED = ""; 	 		 					  //3
long	lCOD_AZL = Security.getAzienda();					  //4
 	//----------------------------
String	strDES_VST_MED = ""; 								  //5
long 	lCOD_VST_MED_RPO = 0; 	 							  //6
String 	strPER_VST = ""; 			 						  //7
Long lCOD_PRO_SAN=null;   
String	strNOM_AZL="";

IGestioneVisiteMediche GestioneVisiteMediche=null;

String strCOD_PRO_SAN=request.getParameter("ID_PARENT");
	  if (strCOD_PRO_SAN!=null && !strCOD_PRO_SAN.equals("") && !strCOD_PRO_SAN.equals("null"))
			 {
			 	lCOD_PRO_SAN = new Long (request.getParameter("ID_PARENT"));
				}

if(request.getParameter("ID")!=null)
{
	strCOD_VST_MED = request.getParameter("ID");	
	EdFlag=true;

	IGestioneVisiteMedicheHome home=(IGestioneVisiteMedicheHome)PseudoContext.lookup("GestioneVisiteMedicheBean");
	Long vst_ido_id=new Long(strCOD_VST_MED);
	GestioneVisiteMediche = home.findByPrimaryKey(vst_ido_id);
	lCOD_VST_MED = vst_ido_id.longValue();

	// getting of object variables
	lCOD_AZL = GestioneVisiteMediche.getCOD_AZL();
	strNOM_VST_MED = Formatter.format(GestioneVisiteMediche.getNOM_VST_MED());
	strFAT_PER = Formatter.format(GestioneVisiteMediche.getFAT_PER());
	// --- 
	strDES_VST_MED = Formatter.format(GestioneVisiteMediche.getDES_VST_MED());
	lCOD_VST_MED_RPO = GestioneVisiteMediche.getCOD_VST_MED_RPO();
	if (GestioneVisiteMediche.getPER_VST()!=0)
		 {
		 	strPER_VST = Formatter.format(GestioneVisiteMediche.getPER_VST());
		 }
}// if request

IAzienda azienda;
IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

azienda = AziendaHome.findByPrimaryKey(new Long(lCOD_AZL));
strNOM_AZL = azienda.getRAG_SCL_AZL();
%>
<form action="ANA_VST_MED_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input type="hidden" name="SBM_MODE" value="<%=(lCOD_VST_MED==0)?"new":"edt"%>">
<input type="hidden" name="VST_MED_ID" value="<%=lCOD_VST_MED%>">
<input type="hidden" name="COD_AZL" id="COD_AZL" value="<%=lCOD_AZL%>">
<input type="hidden" name="COD_VST_MED_RPO" value="<%=lCOD_VST_MED_RPO%>">
<input type="hidden" name="ID_PARENT" value="<%=strCOD_PRO_SAN%>">
	<table width="100%" border="0">
 <%if (strCOD_PRO_SAN!=null && !strCOD_PRO_SAN.equals("") && !strCOD_PRO_SAN.equals("null")){%>
	<script>
	//ToolBar.Return.setEnabled(false);
	//ToolBar.Delete.setEnabled(false);
	</script>
 <%}%>
 				<tr><td class="title" colspan="100%">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                            (SubMenuVerificheSanitarie,0,<%=request.getParameter("ID")%>));
                                    </script>
 				</td></tr>
			 	<tr valign="top"><td>
 <!-- ############################ -->  		
 <table border=0>
 <%@ include file="../_include/ToolBar.jsp" %>      
 <%ToolBar.bCanDelete=(GestioneVisiteMediche!=null);%>		
 <%=ToolBar.build(3)%> 
 </table>
 <!-- ########################### -->
 				<fieldset>
					<legend>
						<%=ApplicationConfigurator.LanguageManager.getString("Dati.visita.medica")%>
					</legend>													
					<table width="100%">
					 <tr>
				 		 <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
				 		 <td width = 605><b><input type="text" size="88" readonly value="<%=strNOM_AZL%>" style="width:602px;"></b></td>												 
					 </tr>
					 <tr>
				 		 <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome.visita")%>&nbsp;</b></td>
						 <td><input tabindex="1" type="text" maxlength="100" id="NOM_VST_MED" name="NOM_VST_MED" size="88" value="<%=strNOM_VST_MED%>" style="width:602px;"></td>
					 </tr>
					 <tr>
				 		 <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Periodicità")%>&nbsp;</b></td>
				 		 <td valign="top">		
			 				<table width="100%" valign="top">
				 				<tr>
			 						<td valign="top"><input tabindex="2" type="radio" class="checkbox" value="M" name="FAT_PER" <%=(!strFAT_PER.equals("U"))?"checked":""%>>
                                                                                 &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Mensile")%></input>
										<br><input tabindex="3" type="radio" class="checkbox" value="U" name="FAT_PER" <%=(strFAT_PER.equals("U"))?"checked":""%>>
                                                                                 &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Unica")%></input></td>
									<td valign="top">
										<table width="100%"><tr>
										<td align="left" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.visita")%>&nbsp;
                                                                                 <input tabindex="4"  type="text" name="PER_VST" size="10" value="<%=strPER_VST%>"></td>
										<td align="center">
											<!--fieldset style="height:45px;">
												<legend>
													Repository
												</legend>					
													<button tabindex="5" type="button" value="&nbsp;&nbsp;&nbsp;" onclick="leftClick();" ><img src="../_images/new/connect1.gif"/></button>
													<button tabindex="6" type="button" value="&nbsp;&nbsp;&nbsp;" onclick="rightClick();"><img src="../_images/new/pen2.gif"/></button>	
                      </fieldset-->
										</td></tr></table></td>
								</tr>
			 				</table>
						</td>
					 </tr>
					 <tr>
						<td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
						<td><textarea tabindex="7" rows="3" cols="66" name="DES_VST_MED" style="width:602px;"><%=strDES_VST_MED%></textarea></td>
					 </tr>
					</table>
				</fieldset>
			</td></tr>
		</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" id="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
