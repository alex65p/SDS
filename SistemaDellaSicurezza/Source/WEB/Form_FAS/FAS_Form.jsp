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

<%-- 
    Document   : FAS_Form
    Created on : 6-apr-2011, 15.43.40
    Author     : Alessandro
--%>

<%@page import="s2s.file.io.BynaryFileReader"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.Fascicolo.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.PSC.*" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.utils.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title>
            <%=ApplicationConfigurator.LanguageManager.getString("Fascicolo.dell.opera")%> 
            - 
            <%=ApplicationConfigurator.LanguageManager.getString("Revisioni")%>
        </title>
        
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
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <script type="text/javascript" src="../_scripts/utility-date.js"></script>
        <script type="text/javascript" src="../Form_SEZ_GEN/SEZ_GEN.js"></script>
        <script type="text/javascript" src="../Form_ANA_PSC/ANA_PSC_JS.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script>
            window.dialogWidth="816px";
            window.dialogHeight="310px";
        </script>
        <script language="JavaScript" src="../_scripts/textarea.js"></script>
    </head>
    <body>
        <%
            IFascicolo bean;
            IFascicoloHome home = (IFascicoloHome) PseudoContext.lookup("FascicoloBean");
            IAnagrProcedimentoHome d_home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");

            long lCOD_FAS = 0;
            long lCOD_PSC = 0;
            long lCOD_PRO = 0;
            long lCOD_AZL = 0;
            lCOD_AZL = Security.getAzienda();
            String strCOD = "F01";
            String strOGG = "";
            String strREV = "";
            String dtDAT_EMI = "";
            String dtDAT_PRO = "";
            String strDOC_COL = "";
            String strID_PARENT = "";
            strID_PARENT = request.getParameter("ID_PARENT");
            String strCOD_PRO = "";
            strCOD_PRO = request.getParameter("COD_PRO");
            lCOD_PRO = Long.parseLong(strCOD_PRO);
            if (request.getParameter("ID_PARENT") != null) {
                if (request.getParameter("ID") != null) {
                    String strCOD_FAS = request.getParameter("ID");
                    Long fas_id = new Long(strCOD_FAS);
                    bean = home.findByPrimaryKey(fas_id);
                    lCOD_FAS = fas_id.longValue();
                    strCOD = Formatter.format(bean.getstrCOD());
                    strOGG = Formatter.format(bean.getstrOGG());
                    strREV = Formatter.format(bean.getstrREV());
                    dtDAT_EMI = Formatter.format(bean.getdtDAT_EMI());
                    dtDAT_PRO = Formatter.format(bean.getdtDAT_PRO());
                    strDOC_COL = Formatter.format(bean.getstrDOC_COL());
                    lCOD_AZL = bean.getlCOD_AZL();
                } else {
                    lCOD_PRO = Long.parseLong(strCOD_PRO);
                }
            }
            IPSC psc = null;
            IPSCHome PSCHome = (IPSCHome) PseudoContext.lookup("PSCBean");
            Long psc_id = new Long(strID_PARENT);
            psc = PSCHome.findByPrimaryKey(psc_id);/**/
            String strCOD_PSC = psc.getstrCOD();
            String strTIT_PSC = psc.getstrTIT();
            String strCOD_ELA = psc.getCOD_ELA();
            String strREV4COD_ELA = strREV.equals("0")?"":strREV.equals("1")?"-":strREV;
        %>

        <!-- form for addind  -->
        <form action="FAS_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%if ((lCOD_FAS == 0)) {
                    out.print("new");
                } else {
                    out.print("edt");
                }%>">
            <input type="hidden" name="COD_PSC" value="<%=lCOD_PSC%>">
            <input type="hidden" name="COD_FAS" value="<%=lCOD_FAS%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <input name="ID_PARENT" type="Hidden" value="<%=strID_PARENT%>">
            <input name="COD_PRO" id="COD_PRO" type="Hidden" value="<%=strCOD_PRO%>">
            <input id="frmCode" type="hidden" value="F">
            <table width="100%" border="0">
                <tr>
                    <td width="10" height="100%" valign="top">
                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td align="center" class="title" valign="top" >
                                    <%=ApplicationConfigurator.LanguageManager.getString("Fascicolo.dell.opera")%> 
                                    - 
                                    <%=ApplicationConfigurator.LanguageManager.getString("Revisioni")%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bShowNew = false;%>
                                        <%ToolBar.bShowSearch = false;%>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%ToolBar.bShowReturn = false;%>
                                        <%=ToolBar.build(2)%>
                                    </table>
                                    <fieldset>
                                        <legend></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right" width="10%"><%=ApplicationConfigurator.LanguageManager.getString("Titolo.PSC")%>&nbsp;</td>
                                                <td colspan="3"><input readonly tabindex="1" size="55" class="textBackground" style="width: 100%;" maxlength="50"  value="<%=strTIT_PSC%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Codice.PSC")%>&nbsp;</td>
                                                <td><input readonly tabindex="2" size="20" class="textBackground" maxlength="50" style="width: 100%;" value="<%=strCOD_PSC%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Codice")%>&nbsp;</b></td>
                                                <td colspan="5"><input tabindex="3" readonly size="20" type="text" maxlength="50" name="COD" value="<%=strCOD%>"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Oggetto")%>&nbsp;</td>
                                                <td colspan="5"><s2s:textarea tabindex="4" cols="74" rows="3" maxlength="1000" id="OGG" name="OGG"><%=strOGG%></s2s:textarea></td>
                                                </tr>
                                                <tr>
                                                <input name="COD_PSC" id="COD_PSC" type="hidden" value="<%=lCOD_PSC%>">
                                            <input name="COD_PRO" type="hidden" value="<%=lCOD_PRO%>">
                                            <%IAnagrProcedimento bean_vr = d_home.findByPrimaryKey(new Long(lCOD_PRO));%>
                                            <td ><input tabindex="5" size="36" type="hidden" maxlength="50" name="COD" value="PSC-<%=bean_vr.getstrCOD()%>">
                                                </tr>
                                                <%
                                                    Alphabet c = new Alphabet();
                                                    String REV1 = home.getUltimaRevisione(lCOD_PRO);
                                                    if (REV1 != "") {
                                                        REV1 = c.getNextElement(REV1);
                                                    }
                                                %>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Revisione")%>&nbsp;</b></td>
                                                <td>
                                                    <div id="REV_ajaxReturnDiv">
                                                        <input readonly tabindex="6" size="25" maxlength="1" id="REV" name="REV" value="<%=strREV%>">
                                                    </div>
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.emissione")%>&nbsp;</td>
                                                <td > <s2s:Date tabindex="7" id="DAT_EMI" onchange="confronta_date();checkDateRevisionePrecedente(this.value);dis(this.value);getRev();" name="DAT_EMI" value="<%=dtDAT_EMI%>"/></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.protocollo")%>&nbsp;</td>
                                                <td ><s2s:Date tabindex="8" id="" id="DAT_PRO" onchange="confronta_date();data_protocollo(document.getElementById('DAT_EMI').value);" name="DAT_PRO" value="<%=dtDAT_PRO%>"/></td>
                                            </tr>
                                            <%if (request.getParameter("ID") == null) {
                                                    if ((strREV.equals("0")) || (strREV.equals(""))) {
                                                        strDOC_COL = "PSC-" + bean_vr.getstrCOD() + "-" + "SC" + "-" + strCOD + ".docx";
                                                    }
                                                    if ((strREV.equals("0")) && (strREV.equals("")) && (!REV1.equals("1"))) {
                                                        strDOC_COL = "PSC-" + bean_vr.getstrCOD() + "-" + "SC" + "-" + strCOD + "-" + REV1 + ".docx";
                                                    }
                                                    if ((strREV.equals("")) && (!REV1.equals("1"))) {
                                                        strDOC_COL = "PSC-" + bean_vr.getstrCOD() + "-" + "SC" + "-" + strCOD + "-" + REV1 + ".docx";
                                                    }
                                                }
                                                if (request.getParameter("ID") != null) {
                                                    if ((strREV.equals("1")) || (strREV.equals("0"))) {
                                                        strDOC_COL = "PSC-" + bean_vr.getstrCOD() + "-" + "SC" + "-" + strCOD + ".docx";
                                                    }
                                                    if ((!REV1.equals("1")) && (!REV1.equals("0")) && (strREV.equals("0"))) {
                                                        strDOC_COL = "PSC-" + bean_vr.getstrCOD() + "-" + "SC" + "-" + strCOD + "-" + REV1 + ".docx";
                                                    }
                                                }
                                                if (strREV.equals("0")) {
                                                    strREV = "In lavorazione";
                                                }

                                                String DOC_PRE = home.getUltimo_Doc_Sez(lCOD_PRO);
                                                BynaryFileReader doc = new BynaryFileReader();
                                                if (StringManager.isEmpty(DOC_PRE) && !doc.fileExists(ApplicationConfigurator.document_link + strDOC_COL)) {
                                                    // Creo il primo documento
                                                    // doc.createWordFile(ApplicationConfigurator.document_link + strDOC_COL, strDOC_COL);
                                                    doc.copyfile(ApplicationConfigurator.document_link + "empty.docx", ApplicationConfigurator.document_link + strDOC_COL);
                                                } else if (!doc.fileExists(ApplicationConfigurator.document_link + strDOC_COL)) {
                                                    // Creo la copia a partire dal precedente
                                                    doc.copyfile(ApplicationConfigurator.document_link + DOC_PRE, ApplicationConfigurator.document_link + strDOC_COL);
                                                }
                                            %>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Documento.collegato")%>&nbsp;</b></td>
                                                <td valign="middle">
                                                    <a href="<%=ApplicationConfigurator.document_link + strDOC_COL%>" target="_blank"><%=strDOC_COL%></a>
                                                    <input id="DOC_COL" type="Hidden" value="<%=strDOC_COL%>" name="ATTACHMENT_FILE" type="text" style="width:100%">
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Codifica.elaborato")%>:
                                                </td>
                                                <td colspan="3">
                                                    <%=(StringManager.isNotEmpty(strCOD_ELA)
                                                        ?strCOD_ELA+strCOD+strREV4COD_ELA
                                                        :ApplicationConfigurator.LanguageManager.getString("Non.impostato"))%>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                </tr>
            </table>
        </form>
        <textarea id="ajaxReturn" style="display: none;"></textarea>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
    </body>
    <script>
        getRev();dis(document.getElementById("DAT_EMI").value);
    </script>
</html>

