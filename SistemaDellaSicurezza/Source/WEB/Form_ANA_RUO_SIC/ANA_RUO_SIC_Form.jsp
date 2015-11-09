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
<%@ page import="com.apconsulting.luna.ejb.RuoliSicurezza.*" %>

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
        document.write("<title>"+getCompleteMenuPath(SubMenuOrganizzazione,3)+"</title>");
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
    String strCOD_RUO_SIC="";
    String strNOM_RUO_SIC="";

    //   *Not require Fields*
    String strDES_RUO_SIC="";

    IRuoliSicurezza RuoliSicurezza = null;
    if(request.getParameter("ID")!=null)
    {
        IRuoliSicurezzaHome home=(IRuoliSicurezzaHome)PseudoContext.lookup("RuoliSicurezzaBean");
        strCOD_RUO_SIC = request.getParameter("ID");
        RuoliSicurezza = home.findByPrimaryKey(new Long(strCOD_RUO_SIC));

        // getting of object variables
        strNOM_RUO_SIC=RuoliSicurezza.getNOM_RUO_SIC();
        strDES_RUO_SIC=RuoliSicurezza.getDES_RUO_SIC();/**/
}
%>

<!-- form for addind  -->
<form action="ANA_RUO_SIC_Set.jsp?par=add"  method="POST" target="ifrmWork">
    <table  width="100%">
        <tr>
            <td class="title">
                <script type="text/javascript">
                    document.write(getCompleteMenuPathFunction
                        (SubMenuOrganizzazione,3,<%=request.getParameter("ID")%>));
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
                ToolBar.bCanDelete=(RuoliSicurezza!=null);
                %>
                <%=ToolBar.build(2)%>
                        </td>
                    </tr>
		</table>
            </td>
        </tr>
        <tr>
            <td>
                <input name="SBM_MODE" type="hidden" value="<%if(strCOD_RUO_SIC==""){out.print("new");}else{out.print("edt");}%>">
                <input name="COD_RUO_SIC" type="hidden" value="<%=strCOD_RUO_SIC%>">
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" cellspacing="2">
                    <tr>
                        <td>
                            <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.ruolo.sicurezza")%></legend>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                            <td><input tabindex="1"  style="width:100%;" type="text" maxlength="50" name="NOM_RUO_SIC" value="<%=strNOM_RUO_SIC%>"></td>
                                        </tr>
                                        <tr>
                                            <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                            <td><s2s:textarea maxlength="3500" cols="1" rows="5" tabindex="2" style="height:50" style="width:100%;" name="DES_RUO_SIC"><%=strDES_RUO_SIC%></s2s:textarea></td>
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
