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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaCorsi/TipologiaCorsiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
        <script language="JavaScript" src="../_scripts/textarea.js"></script>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuCorsi,0) + "</title>");
        </script>
    </head>
    <script>
        window.dialogWidth="600px";
        window.dialogHeight="290px";
    </script>
    <body style="margin:0 0 0 0;">
        <%!    boolean EdFlag = false;		//flag of editing
            String strCOD_TPL_COR;			//1
            String strNOM_TPL_COR;     	//2
            //----------------------------   
            String strDES_TPL_COR;           	//3
        %>

        <%
            strCOD_TPL_COR = "";
            strNOM_TPL_COR = "";
            strDES_TPL_COR = "";

            ITipologiaCorsi TipologiaCorsi = null;
            if (request.getParameter("ID") != null) {
                strCOD_TPL_COR = "0";
                strCOD_TPL_COR = request.getParameter("ID");
                // editing of TipologiaCorsi 
                //out.print("editting of TipologiaCorsi<br>");
                //getting of TipologiaCorsi object
                EdFlag = true;
                ITipologiaCorsiHome home = (ITipologiaCorsiHome) PseudoContext.lookup("TipologiaCorsiBean");
                Long tpl_cor_id = new Long(strCOD_TPL_COR);
                TipologiaCorsi = home.findByPrimaryKey(tpl_cor_id);
                // getting of object variables
                strNOM_TPL_COR = Formatter.format(TipologiaCorsi.getNOM_TPL_COR());
                // --- 
                strDES_TPL_COR = Formatter.format(TipologiaCorsi.getDES_TPL_COR());
            }// if request
%>
        <form action="TPL_COR_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%if (strCOD_TPL_COR == "") {
        out.print("new");
    } else {
        out.print("edt");
    }%>">
            <input name="TPL_COR_ID" type="Hidden" value="<%=strCOD_TPL_COR%>">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                    </td>
                    <td valign="top" width="100%">
                        <table width="100%"> 	
                            <tr><td class="title" align="center">
                                    <script>
        document.write(getCompleteMenuPathFunction
        (SubMenuCorsi,0,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr>
                                <td>
                                    <!-- ############################ -->  
                                    <table width="100%" border="0">		
                                        <%@ include file="../_include/ToolBar.jsp" %>      
                                        <%ToolBar.bCanDelete = (TipologiaCorsi != null);%>		
                                        <%=ToolBar.build(2)%> 
                                    </table>
                                    <!-- ########################### -->
                                    <br>
                                    <fieldset>
                                        <legend>
                                            <%=ApplicationConfigurator.LanguageManager.getString("Tipologia.corso")%>
                                        </legend>

                                        <table width="100%">
                                            <tr>
                                                <td align="right" width="15%">
                                                    <B><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</B>
                                                </td>
                                                <td align="left" width="85%">
                                                    <input tabindex="1" type="text" name="nome" style="width:100%;" value="<%=strNOM_TPL_COR%>" maxlength="70">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td>
                                                    <s2s:textarea style="width:100%;" tabindex="2" maxlength="3500" rows="5" cols="65" name="descr"><%=strDES_TPL_COR%></s2s:textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe id="ifr" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
