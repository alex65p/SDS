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
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.CategorieFattoreRischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
    <LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuRischi,0) + "</title>");
</script>
<script>
window.dialogWidth="700px";
window.dialogHeight="300px";
</script>
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
<table width="100%" border="0">
			 <tr>
				  <td valign="top">
					<table width="100%">	
					 <tr><td class="title">
                                            <script>
                                                document.write(getCompleteMenuPathFunction
                                                    (SubMenuRischi,0,<%=request.getParameter("ID")%>));
                                            </script>
					 </td></tr>
					 <tr><td>
					 <table><tr><td>

					 </table>
						 	<!-- ############################ -->  
							<table width="100%" border="0">
								<%@ include file="../_include/ToolBar.jsp" %>      
								<%ToolBar.bCanDelete=(CategorioRischio!=null);%>		
								<%=ToolBar.build(2)%> 
								</table>		
							<!-- ########################### -->
							<br>					 
						<fieldset>
							<legend>
								<%=ApplicationConfigurator.LanguageManager.getString("Categoria.fattore.di.rischio")%>
							</legend>
					<br>
							
              <table width="100%" cellspacing="2">
                <tr>
								 		 
                  <td width="15%" align="right"> 
                    <div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b>
									                                           </div></td>
										 
                  <td width="85%"> 
                    <input type="text" name="nome"style="width:100%;" maxlength="50" value="<%=strNOM_CAG_FAT_RSO%>">
										 </td>
								</tr>
								<tr>
										
                  <td width="15%" align="right" valign="top"> 
                    <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</div></td>
										
                  <td width="85%"> 
                    <textarea rows="5" cols="65" style="width:100%;" name="descr"><%=strDES_CAG_FAT_RSO%></textarea>
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
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
