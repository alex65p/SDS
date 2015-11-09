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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.CategorieFattoreRischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Categorie.fattori.di.rischio")%></title>
</head>
<body style="margin:0 0 0 0;">
<%! 
	boolean EdFlag=false;		//flag of editing
	
	String strCOD_CAG_FAT_RSO;			//1
	String strNOM_CAG_FAT_RSO;     	//2
  	//----------------------------   
 	String strDES_CAG_FAT_RSO;      //3
%>

<%
	strCOD_CAG_FAT_RSO = "";	
	strNOM_CAG_FAT_RSO = "";
	strDES_CAG_FAT_RSO = "";
ICategorioRischio CategorioRischio=null;
if(request.getParameter("ID")!=null)
{
	strCOD_CAG_FAT_RSO = request.getParameter("ID");	
 	// editing of CategorioRischio 
		//out.print("editting of CategorioRischio<br>");
	 	//getting of CategorioRischio object
		EdFlag=true;
		ICategorioRischioHome home=(ICategorioRischioHome)PseudoContext.lookup("CategorioRischioBean");
		Long cag_fat_rso_id = new Long(strCOD_CAG_FAT_RSO);
		CategorioRischio = home.findByPrimaryKey(cag_fat_rso_id);
		// getting of object variables
		strNOM_CAG_FAT_RSO=Formatter.format(CategorioRischio.getNOM_CAG_FAT_RSO());
		// --- 
		strDES_CAG_FAT_RSO=Formatter.format(CategorioRischio.getDES_CAG_FAT_RSO());
}// if request
%>
<form action="CAG_FAT_RSO_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input tabindex="1" name="SBM_MODE" type="Hidden" value="<%if(strCOD_CAG_FAT_RSO==""){out.print("new");}else{out.print("edt");}%>">
<input tabindex="2" name="CAG_FAT_RSO_ID" type="Hidden" value="<%=strCOD_CAG_FAT_RSO%>">
<table width="100%" cellpadding="0" cellspacing="0" border="0">
			 <tr>
			 		<td>
					 		 <!-- ############################ -->  		
							 <%@ include file="../_include/ToolBar.jsp" %>      
							 <%ToolBar.bCanDelete=(CategorioRischio!=null);%>		
							 <%=ToolBar.build(2)%> 
							 <!-- ########################### -c->
					</td>
				  <td valign="top">
					<table width="100%">	
					 <tr><td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Categorie.fattori.di.rischio")%></td></tr>
					 <tr><td>
						<fieldset>
										<legend>
											<%=ApplicationConfigurator.LanguageManager.getString("Categoria.fattore.di.rischio")%>
										</legend>
					<br>
							<table>
								 <tr>
								 		 <td align="right">
										 	<b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b>
									   </td>
										 <td>
										 		 <input type="text" name="nome" size="85%" value="<%=strNOM_CAG_FAT_RSO%>">
										 </td>
								</tr>
								<tr>
										<td align="right" valign="top">
										           <%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;
										</td>
										<td> 
												 <textarea rows="5" cols="65" name="descr"><%=strDES_CAG_FAT_RSO%></textarea>
										</td>
							  </tr>
				 		  </table>
							</fieldset>
						</td></tr>
					</table>	
				 </td>
			</tr>
</table>
</form>
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt" style="display:none"></iframe>
</body>
</html>
