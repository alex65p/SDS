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
        <version number="1.0" date="19/02/2004" author="Khomenko Juliya">
        <comments>
        <comment date="19/02/2004" author="Khomenko Juliya">
        <description>MAN_DPD_Form.jsp</description>
        </comment>
        </comments>
        <comment date="23/02/2004" author="Malyuk Sergey">
        <description>Realizaciia formi MAN_DPD_Form.jsp</description>
        </comment>
        </version>
        </versions>
        </file>
         */
%>

<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaContratti.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="MAN_DPD_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%></title>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
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

        <script type="text/javascript">
            window.dialogWidth="550px";
            window.dialogHeight="225px";
        </script>

    </head>
    <body>
        <%
        IDipendente bean = null;
        IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
        ITipologiaContrattiHome TplConHome = (ITipologiaContrattiHome) PseudoContext.lookup("TipologiaContrattiBean");

        java.sql.Date dtDAT_INZ = null;
        java.sql.Date dtDAT_FIE = null;
        long lCOD_UNI_ORG = 0;
        long lCOD_MAN = 0;
        Long ID_PARENT = new Long(request.getParameter("ID_PARENT"));
        long lCOD_AZL = 0;
        long lCOD_TPL_CON = 0;
        bean = home.findByPrimaryKey(ID_PARENT);
        lCOD_AZL = bean.getCOD_AZL();


         if (request.getParameter("ID") != null) {
           if (request.getParameter("dat_inz") == null || request.getParameter("dat_inz").equals("null")){}
             else
               dtDAT_INZ = java.sql.Date.valueOf(request.getParameter("dat_inz"));

           if (request.getParameter("dat_fie") == null || request.getParameter("dat_fie").equals("null")){}
             else
               dtDAT_FIE = java.sql.Date.valueOf(request.getParameter("dat_fie"));

            String strID = request.getParameter("ID");
            String strCOD_UNI_ORG = strID.substring(0, strID.indexOf('|'));
            String strCOD_MAN = strID.substring(strID.indexOf('|') + 1, strID.length());

            lCOD_UNI_ORG = new Long(strCOD_UNI_ORG).longValue();
            lCOD_MAN = new Long(strCOD_MAN).longValue();

            Collection att_lav_list =
               home.findDipendenteAttivitaLavorativaByCOD_UNI_ORG(lCOD_AZL, bean.getCOD_DPD(), lCOD_MAN, lCOD_UNI_ORG,dtDAT_INZ, false);

            dtDAT_INZ = bean.getDAT_INZ(lCOD_MAN, lCOD_UNI_ORG,dtDAT_INZ);
            dtDAT_FIE = bean.getDAT_FIE(lCOD_MAN, lCOD_UNI_ORG,dtDAT_INZ);




            if (att_lav_list != null && att_lav_list.isEmpty() == false) {
                Dipendenti_Lavoratori_View att_lav =
                        (Dipendenti_Lavoratori_View) att_lav_list.iterator().next();
                lCOD_TPL_CON = att_lav.COD_TPL_CON;
          
            }
        }
        %>
        <form action="MAN_DPD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_MAN == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_DPD" value="<%=ID_PARENT%>">
            <input type="hidden" name="oldCOD_UNI_ORG" value="<%=lCOD_UNI_ORG%>">
            <input type="hidden" name="oldCOD_MAN" value="<%=lCOD_MAN%>">
            <input type="hidden" name="oldDAT_INZ" value="<%=dtDAT_INZ%>">
            <table width="100%" border="0">
                <!-- ############################ -->
            <!-- ########################### -->
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%" border="0">
                                        <tr>
                                            <td>
                                                <%@ include file="../_include/ToolBar.jsp" %>
                                                <%ToolBar.bCanDelete = (bean != null);
        if (request.getParameter("ID_PARENT") != null) {
            ToolBar.strSearchUrl = ToolBar.strSearchUrl.replace('&', '|');
        }
                                                %>
                                                <%ToolBar.bShowSearch = false;%>
                                                <%ToolBar.bShowDelete = false;%>
                                                <%ToolBar.bShowPrint = false;%>
                                                <%ToolBar.bShowReturn = false;%>
                                                <%=ToolBar.build(2)%>
                                            </td>
                                        </tr>
                                    </table>

                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.lavorativa")%></legend>
                                        <table border="0" width="100%" cellpadding="3" cellspacing="0">
                                            <tr>
                                                <td style="width:35%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.inizio")%>&nbsp;</b></td>
                                                <td> <s2s:Date id="DAT_INZ"  name="DAT_INZ" value="<%=Formatter.format(dtDAT_INZ)%>"/>
                                                    </td>
                                                <td style="width:20%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.fine")%>&nbsp;</td>
                                                <td> <s2s:Date id="DAT_FIE"  name="DAT_FIE" value="<%=Formatter.format(dtDAT_FIE)%>"/> </td>
                                                <!--<td> <input type="text" size="14" maxlength="14"  name="DAT_FIE" value="<%if (dtDAT_FIE != null) {
                                                    out.print(Formatter.format(dtDAT_FIE));
                                                               }%>"> </td> -->
                                            </tr>
                                            <tr>
                                                <td align="right" style="width:30%"><b><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%>&nbsp;</b></td>
                                                <td colspan="3">
                                                    <select name="COD_UNI_ORG" style="width:100%">
                                                        <option></option>
                                                     <%
                                                                    IUnitaOrganizzativa uoBean=null;
                                                                    IUnitaOrganizzativaHome uoHome=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
                                                                    String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG,lCOD_AZL,false);
                                                                    out.println(nodes);
                                                     %>
                                                                    
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")%>&nbsp;</b></td>
                                                <td colspan="3">
                                                    <select name="COD_MAN" style="width:100%">
                                                        <option></option>
                                                        <%
                                                           IAttivitaLavorativeHome ana_man_home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
                                                           out.print(BuildMANComboBox(ana_man_home, lCOD_MAN));
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr style="display:<%=ApplicationConfigurator.isModuleEnabled(MODULES.DPD_UO_MAN_TPL_CON) ? "yes" : "none"%>">
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.contrattuale")%>&nbsp;</td>
                                                <td colspan="3">
                                                    <select name="COD_TPL_CON" style="width:100%">
                                                        <option></option>
                                                        <%= BuildTipologiaContrattiCombobox(TplConHome.getTipologia_View(), lCOD_TPL_CON)%>
                                                    </select>
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
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
    </body>
</html>
