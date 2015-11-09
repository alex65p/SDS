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
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DestinatarioDocumento/DestinatarioDocumento_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DestinatarioDocumento/DestinatarioDocumentoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ page import="s2s.luna.util.combobuilder.*"%>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Liste.destinatari/documenti")%></title>
        <!-- autocompose data field -->
        <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
        <!-- import the calendar script -->
        <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
        <!-- import the language module -->
        <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
        <!-- import calendar utility function -->
        <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
        <!-- style sheet for calendar -->
        <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <link rel="stylesheet" href="../_styles/tabs.css">
    <script language="JavaScript" src="../_scripts/tabs.js"></script>
    <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
    <script language="JavaScript" src="../_scripts/Alert.js"></script>

    <script>
        window.dialogWidth="740px";
        window.dialogHeight="400px";
    </script>

    <body style="margin:0 0 0 0;">
        <%!    long lCOD_LST_DSI_DOC;
    String strNOM_DSI_ESR;
    String strDES_DSI_ESR;
    String strIDZ_PSA_ELT_DSI_ESR;
    java.sql.Date dtDAT_CSG_DOC_DSI;
    long lCOD_DOC;
    long lCOD_DTE;
    long lCOD_DPD;
    long lCOD_AZL;
    long lCOD_UNI_ORG;
        %>

        <%
        lCOD_LST_DSI_DOC = 0;
        strNOM_DSI_ESR = "";
        strDES_DSI_ESR = "";
        strIDZ_PSA_ELT_DSI_ESR = "";
        dtDAT_CSG_DOC_DSI = null;
        lCOD_DOC = 0;
        lCOD_DTE = 0;
        lCOD_DPD = 0;
        lCOD_AZL = Security.getAzienda();
        lCOD_UNI_ORG = 0;

        IDestinatarioDocumento bean = null;
        IDestinatarioDocumentoHome home = null;

        String strID = "";

        if (request.getParameter("ID_PARENT") == null) {
            return;
        }

        lCOD_DOC = Long.parseLong((String) request.getParameter("ID_PARENT"));
        //out.println(lCOD_DOC);
        //if(true) return;

        if (request.getParameter("ID") != null && request.getParameter("ID_PARENT") != null) {
            // getting parameters of azienda
            strID = (String) request.getParameter("ID");

            try {
                home = (IDestinatarioDocumentoHome) PseudoContext.lookup("DestinatarioDocumentoBean");
                Long id = new Long(strID);
                bean = home.findByPrimaryKey(id);

                lCOD_LST_DSI_DOC = bean.getCOD_LST_DSI_DOC();
                strNOM_DSI_ESR = bean.getNOM_DSI_ESR();
                strDES_DSI_ESR = bean.getDES_DSI_ESR();
                strIDZ_PSA_ELT_DSI_ESR = bean.getIDZ_PSA_ELT_DSI_ESR();
                dtDAT_CSG_DOC_DSI = bean.getDAT_CSG_DOC_DSI();
                lCOD_DOC = bean.getCOD_DOC();
                lCOD_DTE = bean.getCOD_DTE();
                lCOD_DPD = bean.getCOD_DPD();
                lCOD_AZL = bean.getCOD_AZL();
                lCOD_UNI_ORG = bean.getCOD_UNI_ORG();

            } catch (Exception ex) {
        %>

        <div id="errDiv" style="display:none">
            <%=Formatter.format(ex.getMessage())%>
        </div>
        <script>Alert.Error.showNotFound()</script>

        <%
            //out.println("<script>err=true;alert(errDiv.innerText)</script>");
            }
        }// if request
%>


        <form action="LST_DSI_DOC_Set.jsp" method="POST"  target="ifrmWork" style="margin:0 0 0 0;" >
            <table cellpadding="0" cellspacing="10" border=0>
                <tr><td>

                    <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" class="title" ## colspan=2 ##><%=ApplicationConfigurator.LanguageManager.getString("Liste.destinatari/documenti")%></td>
                    </tr>
                    <tr>
                        <td>
                            <!-- ########################################################################################################## -->
                            <table border=0>
                                <%@ include file="../_include/ToolBar.jsp" %>

                                <%
        //ToolBar.bShowDelete=false;
        ToolBar.bShowSearch = false;
        ToolBar.bShowPrint = false;
        ToolBar.bShowReturn = false;
                                %>

                                <%=ToolBar.build(2)%>

                            </table>
                            <!-- ########################################################################################################## -->
                            <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.destinatario/documento")%></legend>
                                <table border="0"><!-- cellpadding="0" cellspacing="0" style="margin:5 5 5 5"-->
                                    <tr><td>
                                            <% if (bean != null) {%>
                                            <input name="SBM_MODE" type="Hidden" value="edt">
                                            <%} else {%>
                                            <input name="SBM_MODE" type="Hidden" value="new">
                                            <%}%>
                                    </td></tr>

                                    <tr><td>
                                            <input name="ID" type="Hidden" value="<%=Formatter.format(lCOD_LST_DSI_DOC)%>">
                                            <input name="COD_DOC" type="Hidden" value="<%=Formatter.format(lCOD_DOC)%>">
                                    </td></tr>

                                    <tr>
                                        <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi")%>&nbsp;</b></td>
                                        <td colspan=1 width="35%">

                                            <%
        class ComboParser1 implements IComboParser {

            public void parse(Object obj, ComboItem item) {
                DittaEsterneByAZLID_View w = (DittaEsterneByAZLID_View) obj;
                item.lIndex = w.COD_DTE;
                item.strValue = w.RAG_SCL_DTE;
            }
        }

        IDittaEsternaHome h1 = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
        ComboBuilder b1 = new ComboBuilder(lCOD_DTE, new ComboParser1(), h1.getDittaEsterneByAZLID_View(lCOD_AZL));
        b1.strName = "COD_DTE";
        b1.strExtra = " onchange=onDittaChange(this)";
                                            %>

                                            <%=b1.build()%>

                                            <script>
                                                function onDittaChange(obj){
                                                    tdLavoratore.innerText="Loading...";
                                                    ifrmWork.location.reload("LST_DSI_DOC_EmployeesS.jsp?lCOD_DPD=<%=lCOD_DPD%>&lCOD_DTE="+obj.options[obj.selectedIndex].value);
                                                }

                                                function onDependenteUpdated(str){
                                                    tdLavoratore.innerHTML=str;
                                                }
                                            </script>
                                        </td>
                                        <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</b></td>
                                        <td colspan=1 id="tdLavoratore" width="35%">
                                            <%@ include file="LST_DSI_DOC_Employees.jsp"%>
                                        </td>
                                        <!--  <td align="right"></td> -->
                                    </tr>

                                    <tr>
                                        <td align="right" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%>&nbsp;</b></td>
                                        <td colspan="3" width="85%">
                                            <select name="COD_UNI_ORG" style="width:80%">
                                                <option> </option>
                                                <%
        IUnitaOrganizzativa uoBean = null;
        IUnitaOrganizzativaHome uoHome = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
        String nodes = buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG);
        out.println(nodes);%>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan=4>
                                            <fieldset>
                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Destinatario.esterno")%></legend>
                                                <table border="0" width="100%">
                                                    <tr>
                                                        <td  align="right" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Nominativo")%>&nbsp;</td>
                                                        <td colspan=1 width="40%">
                                                            <input type="text" size="50" maxlength="100"  name="NOM_DSI_ESR" value="<%=Formatter.format(strNOM_DSI_ESR)%>">
                                                        </td>
                                                        <td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;</td>
                                                        <td>
                                                            <input type="text" size="36" maxlength="50"  name="IDZ_PSA_ELT_DSI_ESR" value="<%=Formatter.format(strIDZ_PSA_ELT_DSI_ESR)%>">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan=4>
                                            <fieldset>
                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Consegna")%></legend>
                                                <table border="0" width="100%">
                                                    <tr>
                                                        <td  align="right" width="15%" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</td>
                                                        <td >
                                                            <s2s:Date id="DAT_CSG_DOC_DSI" name="DAT_CSG_DOC_DSI" value="<%=Formatter.format(dtDAT_CSG_DOC_DSI)%>"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" valign="top" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                        <td colspan=3>
                                                            <TEXTAREA cols=115 rows=5 name="DES_DSI_ESR" style="width:550px;"><%=Formatter.format(strDES_DSI_ESR)%></TEXTAREA>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>

                                    <!--	<tr><td height="15">&nbsp;</td></tr> -->
                                </table>
                    </fieldset></td></tr>
                    <tr>
                        <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                    </tr>

                </td>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%!    public String buildTreeNodes(IUnitaOrganizzativa bean, IUnitaOrganizzativaHome home, long n, long COD_UNI_ORG) {

        boolean isError = false;
        String strError = "";
        java.util.Collection c;
        java.util.Iterator i;
        String selected;
        // se=new Security();
        long azienda = Security.getAzienda();
        String strNodes = "";

        try {
            if (n == 0) {
                c = home.getTopOfTree(azienda);
                i = c.iterator();
                if (i != null) {
                    while (i.hasNext()) {
                        n++;
                        UnitaOrganizzativaView view = (UnitaOrganizzativaView) i.next();

                        String strNOM_UNI_ORG = view.strNOM_UNI_ORG;
                        long lCOD_UNI_ORG = view.lCOD_UNI_ORG;
                        if (COD_UNI_ORG == lCOD_UNI_ORG) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">" + strNOM_UNI_ORG + "</option>";
                        bean = home.findByPrimaryKey(new Long(lCOD_UNI_ORG));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_ORG);
                        if (isError) {
                            return "";
                        }

                    }
                }
            } else {
                c = bean.getChildren(azienda);
                i = c.iterator();
                if (i != null) {
                    while (i.hasNext()) {
                        n++;
                        UnitaOrganizzativaView view = (UnitaOrganizzativaView) i.next();
                        String strNOM_UNI_ORG = view.strNOM_UNI_ORG;
                        long lCOD_UNI_ORG = view.lCOD_UNI_ORG;
                        if (COD_UNI_ORG == lCOD_UNI_ORG) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }

                        strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">";
                        for (long y = 0; y < n; y++) {
                            strNodes += "&nbsp;&nbsp;&nbsp;";
                        }
                        strNodes += strNOM_UNI_ORG + "</option>";
                        bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_ORG));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_ORG);
                        if (isError) {
                            return "";
                        }

                    }
                }
            }
        } catch (Exception ex) {
            strError += ex.getMessage();
            return "";
        }
        return strNodes;
    }
        %>
    </body>
</html>



