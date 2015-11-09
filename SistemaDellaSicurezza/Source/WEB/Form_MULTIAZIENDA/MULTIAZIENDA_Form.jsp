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

<%    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache");         //HTTP 1.0
    response.setDateHeader("Expires", 0);             //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script src='../_scripts/help.js' type='text/javascript'></script>
        <script type="text/javascript">
            document.write("<title>" + getCompleteMenuPath(SubMenuGestione, 0) + "</title>");
        </script>
        <link rel="stylesheet" href="../_styles/style.css">
    </head>
    <body>
        <%
            String strCOD_COU = Security.getUserPrincipal().getName();

            IConsultantHome home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
            IConsultant bean = home.findByPrimaryKey(strCOD_COU);
        %>
        <form id="frmMain" action="MULTIAZIENDA_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table cellpadding="3" cellspacing="3" width="100%" border="0">
                <tr>
                    <td>
                        <table border="0" cellpadding="0" cellspacing="0" style="height:100%; width:100%;">
                            <tr>
                                <td align="center" class="title">
                                    <script type="text/javascript">
                                        document.write(getCompleteMenuPath(SubMenuGestione, 0));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table cellpadding="4" cellspacing="4" border="0">
                                        <tr>
                                            <td>
                                                <button type="submit" id='btnOk' disabled
                                                        title="<%=ApplicationConfigurator.LanguageManager.getString("Seleziona.azienda")%>" style="padding: 0px 0px 0px 0px;">
                                                    <img border="0" src='../_images/new/RETURN.GIF' alt="<%=ApplicationConfigurator.LanguageManager.getString("Seleziona.azienda")%>">
                                                </button>
                                            </td>
                                            <td>
                                                <button type="button" id='btnExit' onclick="window.returnValue = 'CANCEL';
                                                        window.close();"
                                                        title="<%=ApplicationConfigurator.LanguageManager.getString("Uscita")%>" style="padding: 0px 0px 0px 0px;">
                                                    <img src='../_images/new/EXIT.GIF' alt="<%=ApplicationConfigurator.LanguageManager.getString("Uscita")%>">
                                                </button>
                                            </td>
                                            <td>
                                                <button type="button" id='btnHelp' onclick="g_openHelpWindow('MULTIAZIENDA_Help.jsp');"
                                                        title="<%=ApplicationConfigurator.LanguageManager.getString("Help")%>" style="padding: 0px 0px 0px 0px;">
                                                    <img src='../_images/new/HELP.GIF' alt="<%=ApplicationConfigurator.LanguageManager.getString("Help")%>">
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <fieldset style="height:100%;">
                                        <legend style="text-align:left;"><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%>
                                        </legend>
                                        <div style="width:100%; height:220px; overflow:auto;border:0px solid gray">
                                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <%
                                                            Iterator it = bean.getAziende().iterator();
                                                            ArrayList col = Security.getAziende();
                                                            boolean bSelected;
                                                            if (request.getParameter("SCAD_REPORT") != null) {%>
                                                        <table width="100%" border="0">
                                                            <% while (it.hasNext()) {
                                                                    ConsultantAzienda_Id_Name_View w = (ConsultantAzienda_Id_Name_View) it.next();
                                                                    bSelected = false;
                                                                    if (col != null) {
                                                                        for (int i = 0; i < col.size(); i++) {
                                                                            if (((Long) col.get(i)).longValue() == w.COD_AZL) {
                                                            %>
                                                            <tr>
                                                                <td width="35%"
                                                                    align="left"><%= Formatter.format(w.RAG_SCL_AZL)%>
                                                                </td>
                                                                <td width="5%" align="center">&nbsp;</td>
                                                                <td width="60%" align="left">
                                                                    <input class="checkbox" type="Checkbox"
                                                                           onClick="checkAzienda()"
                                                                           name="AZIENDA_ID" <%=(bSelected ? "checked" : "")%>
                                                                           value="<%=w.COD_AZL%>">
                                                                </td>
                                                            </tr>
                                                            <%
                                                                                break;
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            %>
                                                        </table>
                                                        <%
                                                        } else {
                                                        %>
                                                        <table width="100%" border="0">
                                                            <%
                                                                    while (it.hasNext()) {
                                                                        ConsultantAzienda_Id_Name_View w = (ConsultantAzienda_Id_Name_View) it.next();
                                                                        bSelected = false;
                                                                        if (col != null) {
                                                                            for (int i = 0; i < col.size(); i++) {
                                                                                if (((Long) col.get(i)).longValue() == w.COD_AZL) {
                                                                                    bSelected = true;
                                                                                    break;
                                                                                }
                                                                            }
                                                                        }

                                                                        out.println("<tr>");
                                                                        out.println("<td width=\"15%\" align=\"left\">");
                                                                        out.println("<input class=\"checkbox\" type='radio' name='COD_AZL' value=\"" + w.COD_AZL + "\"");
                                                                        out.println(" onclick=disable();>");
                                                                        out.println("</td>");
                                                                        out.println("<td width=\"85%\" align=\"left\">");
                                                                        out.println(Formatter.format(w.RAG_SCL_AZL));
                                                                        out.println("</td>");
                                                                        out.println("</tr>");

                                                                        if (it.hasNext()) {
                                                                            out.println("<tr>");
                                                                            out.println("<td colspan=\"2\">");
                                                                            out.println("<hr>");
                                                                            out.println("</td>");
                                                                            out.println("</tr>");
                                                                        }
                                                                    }
                                                                }
                                                            %>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <script type="text/javascript">
            function disable() {
                frmMain.btnOk.disabled = false;

            }
            <% if (request.getParameter("SCAD_REPORT") != null) {%>
            btnOk = document.all["btnOk"];
            btnOk.onclick = OnOk;
            function OnOk() {
                var strCkeckBox = "";
                window.returnValue = "CANCEL";
                if (dialogArguments) {
                    checks = document.getElementsByName("AZIENDA_ID");
                    doc = dialogArguments;
                    frm = doc.forms[0];
                    if (doc.all["cCont"])
                        doc.all["cCont"].removeNode(true);
                    dObj = document.createElement("DIV");
                    dObj.id = "cCont";
                    dObj.style.display = "none";
                    frm.insertAdjacentHTML("BeforeEnd", dObj.outerHTML);
                    dObj = doc.all["cCont"];
                    for (i = 0; i < checks.length; i++) {
                        if (checks[i].type == "checkbox") {
                            if (checks[i].checked) {
                                strCkeckBox += "<input type='checkbox' name='AZIENDA_ID' value='" + checks[i].value + "' checked>"

                            }
                        }
                        window.returnValue = "OK";
                    }
                    dObj.innerHTML = strCkeckBox;
                }
                window.close();
            }
            function checkAzienda() {
                checks = document.getElementsByName("AZIENDA_ID");
                btnOk.disabled = true;
                for (i = 0; i < checks.length; i++) {
                    if (checks[i].type == "checkbox") {
                        if (checks[i].checked) {
                            btnOk.disabled = false;
                            break;
                        }
                    }
                }
            }
            checkAzienda();
            <% }%>
        </script>
        <iframe name="ifrmWork" src="../empty.txt" class="ifrmWork" style="display:none"></iframe>
    </body>
</html>
