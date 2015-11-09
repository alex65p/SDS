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

<%    /*
     <file>
     <versions>	
     <version number="1.0" date="22/03/2004" author="Pogrebnoy Yura">
     <comments>
     <comment date="22/03/2004" author="Pogrebnoy Yura">
     <description>Shablon formi COR_DPD_ISC_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Associazioni.personale/corso")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <script>var count = 0;</script>
    </head>
    <script>
        window.dialogWidth = "665px";
        window.dialogHeight = "280px";
    </script>
    <body style="margin:0 0 0 0;">
        <%

            String strCOD_COR = "";
            long lCOD_COR = 0;
            String strDAT_PIF_EGZ_COR = "";
            long lCOD_SCH_EGZ_COR = 0;
            IDipendenteCorsi bean = null;
            IDipendenteCorsiHome home = (IDipendenteCorsiHome) PseudoContext.lookup("DipendenteCorsiBean");
            long lCOD_AZL = Security.getAzienda();
            strDAT_PIF_EGZ_COR = request.getParameter("DAT_PIF_EGZ_COR");
            lCOD_SCH_EGZ_COR = new Long(request.getParameter("COD_SCH_EGZ_COR")).longValue();
            java.sql.Date dDATE = java.sql.Date.valueOf(strDAT_PIF_EGZ_COR);

            if (request.getParameter("ID") != null) {
                strCOD_COR = request.getParameter("ID");
                lCOD_COR = new Long(strCOD_COR).longValue();
            }
        %>

        <!-- form for addind  -->
        <form action="COR_DPD_ISC_Set.jsp" id="frm1" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="COD_COR" type="Hidden" value="<%=strCOD_COR%>">
            <input id="count" name="count" value="0" type="hidden">

            <table width="100%" border="0">
                <tr><td colspan="2" width="100%" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Associazioni.personale/corso")%></td>
                </tr>
                <tr>
                    <td width="10" height="100%" valign="top">
                        <%@ include file="../_include/ToolBar.jsp" %>
                        <%ToolBar.bShowDelete = false;
                            ToolBar.bShowPrint = false;
                            ToolBar.bShowSearch = false;
                            ToolBar.bShowReturn = false;
                        %>
                        <%=ToolBar.build(2)%>

                        <table  width="600px" border="0">
                            <tr><td><fieldset><legend><%=ApplicationConfigurator.LanguageManager.getString("Associazione.dipendente/corso")%></legend>
                                        <table width="600px" border="0">
                                            <tr><td width="35%"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%></strong></td>
                                                <td width="40%"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Corso")%></strong></td>
                                                <td colspan="2"><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%></strong></td></tr>
                                            <tr><td colspan="4" align="center">
                                                    <div id="ifrmRow" style="overflow:auto; width:630px; height:140px;">
                                                        <table  width="600px" border="0">
                                                            <%

                                                                java.util.Collection col = home.getDipendente_View(lCOD_AZL, lCOD_COR, dDATE, lCOD_SCH_EGZ_COR);
                                                                java.util.Iterator it = col.iterator();
                                                                int i = 1;
                                                                while (it.hasNext()) {
                                                                    Dipendente_View obj = (Dipendente_View) it.next();

                                                                    out.print("<tr ID='" + obj.COD_DPD + "'>");
                                                                    out.print("<td class='dataTd' width='35%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_DPD) + " " + Formatter.format(obj.COG_DPD) + "\" style='width:100%'></td>");
                                                                    out.print("<td class='dataTd' width='40%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_COR) + "\" style='width:100%'></td>");
                                                                    out.print("<td class='dataTd' width='20%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.DAT_PIF_EGZ_COR) + "\" style='width:100%'></td>");
                                                                    out.print("<td class='dataTd' width='5%'> <input type='checkbox' class='checkbox' id='check" + i + "'></td>");
                                                                    out.print("<input type='hidden' readonly class='dataInput'  value=\"" + Formatter.format(obj.COD_DPD) + "\" name='COD_DPD" + i + "'></td>");
                                                                    out.print("<input type='hidden' readonly class='dataInput'  value=\"" + Formatter.format(obj.COD_SCH_EGZ_COR) + "\" name='COD_SCH_EGZ_COR" + i++ + "'></td>");
                                                                    out.print("</tr>");
                                                                }

                                                                out.print("<script>document.all['count'].value=" + i + ";</script>");

                                                            %>
                                                        </table>
                                                    </div>
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
    </body>
</html>
<script>
    btn1 = ToolBar.Save.getButton();
    btn1.onclick = goSave;
    btn2 = ToolBar.New.getButton();
    btn2.onclick = goNew;

    function goSave() {
        if (document.all["count"].value > 0) {
            for (i = 1; i < document.all["count"].value; i++) {
                if (document.all["check" + i].checked == false)
                    document.all["COD_DPD" + i].value = "";
            }
            document.all["frm1"].submit();
            goNew();
        }
    }
    function goNew() {
        parent.ToolBar.OnNew("ID=<%=strCOD_COR%>");
    }
</script>
