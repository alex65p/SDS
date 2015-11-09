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
<%@ page import="com.apconsulting.luna.ejb.Ruoli.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head> 
    <script>
        document.write("<title>" + getCompleteMenuPath(SubMenuAccessi,2) + "</title>");
    </script>
    <LINK REL=STYLESHEET
          HREF="../_styles/style.css"
          TYPE="text/css">
</head>
<script language="JavaScript" src="../_scripts/textarea.js"></script>
<script>
    window.dialogWidth="600px";
    window.dialogHeight="630px";
</script>
<body>
<%
        long lCOD_RUO = 0;			    //1
        String strNOM_RUO = "";			//2
        String strDES_RUO = "";			//3

        IRuoli Ruoli = null;
        IRuoliHome home = (IRuoliHome) PseudoContext.lookup("RuoliBean");

        if (request.getParameter("ID") != null) {
            String strCOD_RUO = request.getParameter("ID");
            Long RUO_id = new Long(strCOD_RUO);
            Ruoli = home.findByPrimaryKey(RUO_id);

            lCOD_RUO = RUO_id.longValue(); 						//1
            strNOM_RUO = Ruoli.getNOM_RUO();					//2
            strDES_RUO = Ruoli.getDES_RUO();					//3
        }
%>
<!-- form for addind  Ruoli-->
<form action="ANA_RUO_Set.jsp"  method="post" target="ifrmWork" style="margin:0 0 0 0;">
    <input name="SBM_MODE" type="hidden" value="<%=(lCOD_RUO == 0) ? "new" : "edt"%>">
    <input type="hidden" name="str_edit" id="str_edit" value="edit">
    <!-- <input type="hidden" name="hvost" id="hvost" value=""> -->
    <input type="hidden" name="RUO_ID" value="<%=lCOD_RUO%>">
    <table border="0" width="100%">
        <tr>
        <td valign="top">
        <tr><td class="title">
                <script>
                    document.write(getCompleteMenuPathFunction
                    (SubMenuAccessi,2,<%=request.getParameter("ID")%>));
                </script>
        </td></tr>
    </table>
    <table border="0">
        <!-- ############################ -->
        <%@ include file="../_include/ToolBar.jsp" %>
        <%ToolBar.bCanDelete = (Ruoli != null);
        ToolBar.bShowPrint = false;
        ToolBar.bShowReturn = false;
        %>
        <%=ToolBar.build(2)%>
        <!-- ########################### -->
    </table>
    <table border="0">
        <tr><td>
                <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%></legend>
                    <table  border="0" width="100%">
                        <tr>
                            <td align="right" style="width:80px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%>&nbsp;</b></td>
                            <td align="left"><input tabindex="1" style="width:100%;" maxlength="100" type="text" name="RUOLO" value="<%=strNOM_RUO%>"></td>
                        </tr>
                        <tr>
                            <td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                            <td align="left">
                                <s2s:textarea tabindex="2" rows="5" cols="1" style="width:100%;" name="DESC" maxlength="900"><%=strDES_RUO%></s2s:textarea>
                            </td>
                        </tr>
                    </table>
                </fieldset>
        </td></tr>
        <tr><td>
                <fieldset>
                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Copia.da")%></legend>
                    <table   border="0" width="100%">
                        <tr>
                            <td align="right" style="width:80px;"><%=ApplicationConfigurator.LanguageManager.getString("Ruolo")%>&nbsp;</td>
                            <td align="left">
                                <select tabindex="3" style="width:100%;" name="COPIARUOLO" id="COPIARUOLO" onchange="populate(this);">
                                    <option value=""></option>
                                    <%
        out.print(new RuoliUtility().BuildRuoliComboBox(home));
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                            <td align="left">
                                <s2s:textarea tabindex="4" rows="5" cols="1" style="width:100%;" name="COPIADESC" maxlength="900">&nbsp</s2s:textarea>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <fieldset>
                    <table border='0' id='RuoliHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>
                        <tr><td width='300'><strong>&nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Funzionalità")%></strong></td>
                            <td align='center' width='100'><strong><%=ApplicationConfigurator.LanguageManager.getString("Gestionale")%></strong></td>
                            <td align='center' width='100'><strong><%=ApplicationConfigurator.LanguageManager.getString("Lettura")%></strong></td>
                            <td align='center' width='100'><strong><%=ApplicationConfigurator.LanguageManager.getString("Non.disponibile")%></strong></td>
                        </tr>
                    </table>
                    <div id="divTab" style="height:220px;overflow:auto;"></div>
                </fieldset>
        </td></tr>
    </table>
</form>
<!-- /form for addind  Ruoli-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<iframe name="ifrmTab" id="ifrmTab" class="ifrmWork" src="../empty.txt"></iframe>
<script type="text/javascript" language="JavaScript">
    function populate(obj) {
        if (obj.COPIARUOLO != 0 ) {
            document.all["COPIADESC"].value = obj.options(obj.selectedIndex).value1;
            document.all["ifrmTab"].src="ANA_RUO_BuildTab.jsp?COD_RUO="+obj.options(obj.selectedIndex).value;
        } else {
            document.all["COPIADESC"].value = "";
        }
    }

    function SelectAll(Type){
        var el = document.forms[0].elements;

        for (i=0; i<el.length; i++){
            if (el[i].type == 'radio' && el[i].value == Type){
                el[i].checked = true;
            }
        }
    }
</script>
<script>
    document.all["ifrmTab"].src="ANA_RUO_BuildTab.jsp?COD_RUO="+document.all["RUO_ID"].value;
</script>	 
</body>
</html>
