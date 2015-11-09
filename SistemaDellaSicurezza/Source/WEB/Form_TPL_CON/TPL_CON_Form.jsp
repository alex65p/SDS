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
        <version number="1.0" date="02/09/2009" author="Dario Massaroni">
            <comments>
                <comment date="02/09/2009" author="Dario Massaroni">
                    <description>Form</description>
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
<%@ page import="com.apconsulting.luna.ejb.TipologiaContratti.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
    <script type="text/javascript" src="../_scripts/textarea.js"></script>

    <script type="text/javascript">
        document.write("<title>"+getCompleteMenuPath(SubMenuAzienda,3)+"</title>");
        window.dialogWidth="560px";
        window.dialogHeight="260px";
    </script>

    <LINK REL=STYLESHEET
          HREF="../_styles/style.css"
          TYPE="text/css">
</head>
<body>
<%
    //   *require Fields*
    String strCOD_TPL_CON="";
    String strNOM_TPL_CON="";

    //   *Not require Fields*
    String strDES_TPL_CON="";

    ITipologiaContratti TipologiaContratti = null;
    if(request.getParameter("ID")!=null)
    {
        ITipologiaContrattiHome home=(ITipologiaContrattiHome)PseudoContext.lookup("TipologiaContrattiBean");
        strCOD_TPL_CON = request.getParameter("ID");
        TipologiaContratti = home.findByPrimaryKey(new Long(strCOD_TPL_CON));

        // getting of object variables
        strNOM_TPL_CON=TipologiaContratti.getNOM_TPL_CON();
        strDES_TPL_CON=TipologiaContratti.getDES_TPL_CON();/**/
}
%>

<!-- form for addind  -->
<form action="TPL_CON_Set.jsp?par=add"  method="POST" target="ifrmWork">
    <table  width="100%">
        <tr>
            <td class="title">
                <script type="text/javascript">
                    document.write(getCompleteMenuPathFunction
                        (SubMenuAzienda,3,<%=request.getParameter("ID")%>));
                </script>
            </td>
        </tr>
        <tr>
            <td>
  		<table width="100%" border="0">
                    <tr>
                        <td>
                            <%@ include file="../_include/ToolBar.jsp" %>
      		<%
                ToolBar.bCanDelete=(TipologiaContratti!=null);
                %>
                <%=ToolBar.build(2)%>
                        </td>
                    </tr>
		</table>
            </td>
        </tr>
        <tr>
            <td>
                <input name="SBM_MODE" type="hidden" value="<%if(strCOD_TPL_CON==""){out.print("new");}else{out.print("edt");}%>">
                <input name="COD_TPL_CON" type="hidden" value="<%=strCOD_TPL_CON%>">
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" cellspacing="2">
                    <tr>
                        <td>
                            <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.contrattuale")%></legend>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                            <td><input tabindex="1"  style="width:100%;" type="text" maxlength="30" name="NOM_TPL_CON" value="<%=strNOM_TPL_CON%>"></td>
                                        </tr>
                                        <tr>
                                            <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                            <td><s2s:textarea maxlength="350" cols="1" rows="5" tabindex="2" style="height:50" style="width:100%;" name="DES_TPL_CON"><%=strDES_TPL_CON%></s2s:textarea></td>
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
<!-- /form for addind  -->
<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
