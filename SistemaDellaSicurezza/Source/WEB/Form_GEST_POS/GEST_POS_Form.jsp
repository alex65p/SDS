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


<%@page import="com.apconsulting.luna.ejb.Cantiere.ICantiereHome"%>
<%@page import="com.apconsulting.luna.ejb.Cantiere.ICantiere"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.*"%>
<%@page import="com.apconsulting.luna.ejb.AnagrProcedimento.IAnagrProcedimento"%>
<%
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@page import="com.apconsulting.luna.ejb.AnagrProcedimento.AnagrProcedimento_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOSHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieri"%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOS"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="GEST_POS_Util.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuGestionecantieri,4) + "</title>");
        </script>
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
        <script type="text/javascript" src="GEST_POS.js"></script>
        <script type="text/javascript" src="../_scripts/ajax.js"></script>
        <script>
            window.dialogWidth="690px";
            window.dialogHeight="305px";

            function getPOS1(){
                var cod_doc=document.getElementById('COD_DOC').value;
                document.all["ifrmWork"].src = 'GEST_POS.jsp?COD_DOC='+cod_doc;
            }
        </script>
    </head>
    <body>
        <%
            long lCOD_POS;
            long lCOD_DTE;
            long lCOD_DOC;
            long lCOD_PRO;
            long lCOD_OPE;
            long lCOD_CAN;
            String strTIT;
            String strUFF;                                 //3
            String strSTA;
            String strFAL;
            String strPRO;
            String datData;
            String pro = "";
            String ope = "";
            String can = "";

            IErogazioneCorsiHome aHome = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");

            lCOD_DTE = 0;
            lCOD_POS = 0;
            lCOD_DOC = 0;
            lCOD_PRO = 0;
            lCOD_OPE = 0;
            lCOD_CAN = 0;
            strTIT = "";
            strUFF = "";                                 //3
            strSTA = "";
            strFAL = "";
            strPRO = "";
            datData = "";

            IAnagrPOS bean = null;
            IAnagrPOSHome home = (IAnagrPOSHome) PseudoContext.lookup("AnagrPOSBean");
            IAnagrProcedimentoHome home_pro = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
            IAnagrOpereHome home_ope = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
            ICantiereHome home_can = (ICantiereHome) PseudoContext.lookup("CantiereBean");
            IAnagrDocumentiGestioneCantieri bean_doc = null;
            IAnagrDocumentiGestioneCantieriHome home_doc = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");

            if (request.getParameter("ID") != null) {
                String strCOD_POS = request.getParameter("ID");

                Long pos_id = new Long(strCOD_POS);
                bean = home.findByPrimaryKey(pos_id);

                lCOD_POS = pos_id.longValue();
                lCOD_DTE = bean.getlCOD_DTE();
                lCOD_DOC = bean.getlCOD_DOC();
                lCOD_PRO = bean.getlCOD_PRO();
                lCOD_OPE = bean.getlCOD_OPE();
                lCOD_CAN = bean.getlCOD_CAN();
                strTIT = Formatter.format(bean.getstrTIT());
                strUFF = Formatter.format(bean.getstrUFF());
                strSTA = Formatter.format(bean.getstrSTA());
                strFAL = Formatter.format(bean.getstrFAL());
                strPRO = Formatter.format(bean.getstrPRO());
                datData = Formatter.format(bean.getdatData());
            }
        %>
        <!-- form for addind azienda -->
        <form action="GEST_POS_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0; ">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_POS == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_POS" value="<%=lCOD_POS%>">
            <table width="100%" border="0">
                <tr>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr>
                                <td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuGestionecantieri,4,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <!-- 	********************************** -->
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%=ToolBar.build(3)%>
                                    </table>
                                    <!-- 	********************************** -->
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <fieldset>  
                                        <legend>Registro POS</legend>
                                        <table  width="100%" border="0" cellspacing='2' cellpadding='1'>
                                            <tr>
                                                <td align="right" style="width: 100px;"><b><%=ApplicationConfigurator.LanguageManager.getString("Documento.di.acquisizione")%>&nbsp;</b></td>
                                                <td align="left" colspan="5">
                                                    <select tabindex="1" name="COD_DOC" id="COD_DOC" onchange="getPOS1()" style="width: 100%;">
                                                        <option></option>
                                                        <%
                                                            out.print(BuildDocumentoComboBox(home_doc, lCOD_DOC, Security.getAzienda()));
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</b></td>
                                                <td align="left" colspan="5">
                                                    <input tabindex="2"  type="text" maxlength="110" name="TIT" id="TIT" value="<%=strTIT%>" style="width: 100%;"></td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Impresa")%>&nbsp;</b></td>
                                                <td colspan="3">
                                                    <select tabindex="3" name="COD_IMP" id="COD_IMP" style="width: 100%;">
                                                        <option value=''></option>
                                                        <%
                                                            out.print(BuildFornitoriComboBox(aHome, lCOD_DTE));
                                                        %>
                                                    </select>
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%>&nbsp;</b></td>
                                                <td><s2s:Date id="DATA"  tabindex="4" name="DATA" value="<%=datData%>"/></td>
                                            </tr>
                                            <input type="hidden"  maxlength="20"  name="COD_PRO" value="<%=Formatter.format(lCOD_PRO)%>">
                                            <input type="hidden"  maxlength="20"  name="COD_CAN" value="<%=Formatter.format(lCOD_CAN)%>">
                                            <input type="hidden"  maxlength="20"  name="COD_OPE" value="<%=Formatter.format(lCOD_OPE)%>">
                                            <tr>
                                                <%
                                                    if (bean != null) {
                                                        IAnagrProcedimento bean_pro = home_pro.findByPrimaryKey(new Long(lCOD_PRO));
                                                        ICantiere bean_can = home_can.findByPrimaryKey(new Long(lCOD_CAN));
                                                        pro = bean_pro.getstrDES();
                                                        can = bean_can.getNOM_CAN();
                                                        if (lCOD_OPE != 0){
                                                            IAnagrOpere bean_ope = home_ope.findByPrimaryKey(new Long(lCOD_OPE));
                                                            ope = bean_ope.getstrNOM_OPE();
                                                        }
                                                   }
                                                %>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>&nbsp;</b></td>
                                                <td align="left">
                                                    <input tabindex="5" readonly  size="25" maxlength="100" name="PRO" id="PRO" value="<%=pro%>">
                                                </td>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Cantiere")%>&nbsp;</b></td>
                                                <td align="left"> 
                                                    <input tabindex="6" readonly size="25" maxlength="100" name="CAN" id="CAN" value="<%=can%>">
                                                </td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Opera")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="7" readonly size="25" maxlength="100" name="OPE" id="OPE" value="<%=ope%>">
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Conservazione")%></legend>
                                        <table border="0" width="100%" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td align="right" style="width: 100px;"><%=ApplicationConfigurator.LanguageManager.getString("Ufficio")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="8" size="43" maxlength="100" name="UFF" id="UFF" value="<%=strUFF%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Stanza")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="9" size="43" maxlength="100" name="STA" id="STA" value="<%=strSTA%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Faldone")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="10" size="43" maxlength="100" name="FAL" id="FAL" value="<%=strFAL%>"></td>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Progressivo")%>&nbsp;</td>
                                                <td align="left">
                                                    <input tabindex="11" size="43" maxlength="100" name="PRG" id="PRG" value="<%=strPRO%>">
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
            <tr>
                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
            </tr>
        </form>
        <!-- /form for addind Dipendente -->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
