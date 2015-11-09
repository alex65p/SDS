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
     <version number="1.0" date="20/02/2004" author="Pogrebnoy Yura">
     <comments>
     <comment date="20/02/2004" author="Pogrebnoy Yura">
     <description>Shablon formi GEST_MAN_Form.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/ExtendedMode.jsp"%>
<%@ include file="GEST_MAN_Util.jsp"%>

<%
    String Title = ApplicationConfigurator.LanguageManager.getString("Gestione.mansioni/luoghi.fisici");
%>

<html>
    <head>
        <title><%=Title%></title>
        <LINK REL=STYLESHEET     HREF="../_styles/style.css"     TYPE="text/css">
        <LINK REL=STYLESHEET     HREF="../_styles/tabs.css"     TYPE="text/css">

        <script>
            window.dialogHeight = "400px";
        </script>
    </head>
    <script>var checksum = 0, checksumluo = 0;</script>
    <script src="GEST_MAN_Script.js"></script>
    <body style="margin:0 0 0 0;">
        <%
            String strTypeMAN = "";
            String strCOD = "";

            String strCOD_COR = "";
            String strCOD_TPL_DPI = "";
            String strCOD_PRO_SAN = "";
            String strCOD_MIS_PET = "";
            String strCOD_OPE_SVO = "";

            String strCOD_RSO = "";
            String strCOD_MAN = "";

            String strCOD_MAC = "";
            long lCOD_MAN = 0;
            long lCOD_MAC = 0;
            String strCOD_SOS_CHI = "";
            long lCOD_SOS_CHI = 0;
            String strType = "";
            long lCOD_AZL = Security.getAzienda();
            boolean bExtended = false;
            
            //------------ Initiation ----------------
            Checker c = new Checker();
            IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
            strCOD = request.getParameter("COD");
            strTypeMAN = request.getParameter("TypeMAN");
            strCOD_RSO = request.getParameter("COD_RSO");
            String strDEL = c.checkString("DEL", request.getParameter("DEL"), false);

            if (strTypeMAN.equals("mac_ope_svo")) {
                strCOD_MAN = request.getParameter("COD_RSO");
                lCOD_MAN = (new Long(strCOD_MAN)).longValue();
                strCOD_MAC = request.getParameter("COD_MAC");
            }
            if (strTypeMAN.equals("sos_chi_ope_svo")) {
                strCOD_MAN = request.getParameter("COD_RSO");
                lCOD_MAN = (new Long(strCOD_MAN)).longValue();
                strCOD_SOS_CHI = request.getParameter("COD_MAC");
            }
            if (strTypeMAN.equals("sos_chi_rischio")) {
                strCOD_RSO = request.getParameter("COD_RSO");
                strType = request.getParameter("COD_MAC");
                strCOD_SOS_CHI = strCOD;
                lCOD_SOS_CHI = Long.parseLong(strCOD);
            }
            if (strTypeMAN.equals("macchina_rischio")) {
                strCOD_RSO = request.getParameter("COD_RSO");
                strType = request.getParameter("COD_MAC");
                strCOD_MAC = strCOD;
                lCOD_MAC = Long.parseLong(strCOD);
            }

            if (Security.isExtendedMode()) {
                bExtended = true;
        %><script>isExtendedForm = true;</script><%
            }

            //--------Take params
            String strMan = "";
            String strLuoFsc = "";
            try {
                if (strTypeMAN.equals("cor")) {
                    strCOD_COR = strCOD;
                    strMan = AGGIORNA_MANSIONE_COR(home, strCOD_RSO, strCOD_COR, true);
                    strLuoFsc = AGGIORNA_MANSIONE_COR(home, strCOD_RSO, strCOD_COR, false);
                }
                if (strTypeMAN.equals("dpi")) {
                    strCOD_TPL_DPI = strCOD;
                    strMan = AGGIORNA_MANSIONE_DPI(home, strCOD_RSO, strCOD_TPL_DPI, true);
                    strLuoFsc = AGGIORNA_MANSIONE_DPI(home, strCOD_RSO, strCOD_TPL_DPI, false);
                }
                if (strTypeMAN.equals("pro_san")) {
                    strCOD_PRO_SAN = strCOD;
                    strMan = AGGIORNA_MANSIONE_PRO_SAN(home, strCOD_RSO, strCOD_PRO_SAN, true);
                    strLuoFsc = AGGIORNA_MANSIONE_PRO_SAN(home, strCOD_RSO, strCOD_PRO_SAN, false);
                }
                if (strTypeMAN.equals("mis_pet")) {
                    strCOD_MIS_PET = strCOD;
                    strMan = AGGIORNA_MANSIONE_MIS_PET(home, strCOD_RSO, strCOD_MIS_PET, true);
                    strLuoFsc = AGGIORNA_MANSIONE_MIS_PET(home, strCOD_RSO, strCOD_MIS_PET, false);
                }
                if (strTypeMAN.equals("ope_svo") || strTypeMAN.equals("mac_ope_svo") || strTypeMAN.equals("sos_chi_ope_svo")) {
                    strCOD_OPE_SVO = strCOD;
                    strMan = CARICA_MANSIONI(home, strCOD_OPE_SVO, lCOD_MAN, lCOD_AZL);
                }
                if (strTypeMAN.equals("sos_chi_rischio")) {
                    IAssociativaAgentoChimicoHome sos_home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
                    Collection col_luo;
                    Collection col_man;

                    if (strType.equals("O")) {
                        col_man = sos_home.getCARICA_ATTIVITA_View(lCOD_SOS_CHI, lCOD_AZL);
                        strMan = CARICA_ExATTIVITA_LAVORATIVE(col_man, lCOD_SOS_CHI, 0, "sos_chi_rischio");
                    } else if (strType.equals("T")) {
                        col_luo = sos_home.getCARICA_LUOGHI_FISICI_View(lCOD_SOS_CHI, lCOD_AZL);
                        strLuoFsc = CARICA_ExLUOGHI_FISICI(col_luo, lCOD_SOS_CHI, 0, "sos_chi_rischio");
                    } else if (strType.equals("O/T")) {
                        col_luo = sos_home.getCARICA_LUOGHI_FISICI_View(lCOD_SOS_CHI, lCOD_AZL);
                        col_man = sos_home.getCARICA_ATTIVITA_View(lCOD_SOS_CHI, lCOD_AZL);
                        strMan = CARICA_ExATTIVITA_LAVORATIVE(col_man, lCOD_SOS_CHI, 0, "sos_chi_rischio");
                        strLuoFsc = CARICA_ExLUOGHI_FISICI(col_luo, lCOD_SOS_CHI, 0, "sos_chi_rischio");
                    }
                }
                if (strTypeMAN.equals("macchina_rischio")) {
                    IMacchinaHome mac_home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                    Collection col_luo;
                    Collection col_man;

                    if (strType.equals("O")) {
                        col_man = mac_home.getCARICA_ATTIVITA_View(lCOD_MAC, lCOD_AZL);
                        strMan = CARICA_ExATTIVITA_LAVORATIVE(col_man, lCOD_MAC, 0, "macchina_rischio");
                    } else if (strType.equals("T")) {
                        col_luo = mac_home.getCARICA_LUOGHI_FISICI_View(lCOD_MAC, lCOD_AZL);
                        strLuoFsc = CARICA_ExLUOGHI_FISICI(col_luo, lCOD_MAC, 0, "macchina_rischio");
                    } else if (strType.equals("O/T")) {
                        col_luo = mac_home.getCARICA_LUOGHI_FISICI_View(lCOD_MAC, lCOD_AZL);
                        col_man = mac_home.getCARICA_ATTIVITA_View(lCOD_MAC, lCOD_AZL);
                        strMan = CARICA_ExATTIVITA_LAVORATIVE(col_man, lCOD_MAC, 0, "macchina_rischio");
                        strLuoFsc = CARICA_ExLUOGHI_FISICI(col_luo, lCOD_MAC, 0, "macchina_rischio");
                    }
                }
            } catch (Exception ex) {
                out.print("<script>alert(\"" + ex.getMessage() + "\");</script>");
            }
            boolean isMono = (!strCOD_OPE_SVO.equals(""));
        %>

        <!-- form for addind  -->
        <form action="GEST_MAN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="COD" type="Hidden" value="<%=strCOD%>">
            <input name="TYPE_MAN" type="Hidden" value="<%=strTypeMAN%>">
            <input name="IDSATT" id="IDSATT" type="hidden" value="," size="100">
            <input value="," name="IDSLUO" id="IDSLUO" type="hidden">
            <input value="<%=strCOD_MAN%>" name="COD_MAN" id="COD_MAN" type="hidden">
            <input value="<%=strCOD_MAC%>" name="COD_MAC" id="COD_MAC" type="hidden">
            <input value="<%=strCOD_SOS_CHI%>" name="COD_SOS_CHI" id="COD_SOS_CHI" type="hidden">
            <input value="<%=strDEL%>" name="DEL" id="DEL" type="hidden">
            <input value="<%=strCOD_RSO%>" name="COD_RSO" id="COD_RSO" type="hidden">
            <input value="<%=strType%>" name="TPL_CLF_RSO" id="TPL_CLF_RSO" type="hidden">
            <input value="<%=strCOD_OPE_SVO%>" name="COD_OPE_SVO" id="COD_OPE_SVO" type="hidden">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" class="title">
                        <%=Title%>
                    </td>
                </tr>
                <tr>
                    <td width="10" height="100%" valign="top">
                        <table>
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%
                                ToolBar.bShowDelete = false;
                                ToolBar.bShowPrint = false;
                                ToolBar.bShowSearch = false;
                                ToolBar.bShowAziende = Security.isExtendedMode();
                            %>
                            <%=ToolBar.build(2)%>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style=" border:0px inset white;">
                        <table width="750px"    border="0" cellspacing="0" cellpadding="2" border="0" >
                            <tr>
                                <td valign='top'  <%if (!isMono) {%>width='50%'<%} else {%>style="width:100%"<%}%> >
                                    <div style="border:1px inset white; width:100%; height:100px; padding:10 10 10 10" >
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="man_tab_header">
                                            <tr>
                                                <td></td>
                                                <td align='center' colspan="2"><%=ApplicationConfigurator.LanguageManager.getString("Seleziona.tutto")%></td>
                                            </tr>
                                            <tr>
                                                <td style="width:72%"><b><%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%></b></td>
                                                <td align="<%= (isMono) ? "center" : "right"%>" ><input class='checkbox' type='checkbox' name='checkATT' onclick='selectATT()' style="margin-left:20px">&nbsp;</td>
                                                <td style="width:10px">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width:100%" colspan="3" align="left">
                                                    <div id="ifrmRow"  style="overflow-y:auto; width:100%; height:250px;">
                                                        <%out.print(strMan);%>
                                                    </div>
                                                </td>
                                            </tr>	
                                        </table>
                                    </div>  
                                </td>
                                <%if (strCOD_OPE_SVO.equals("")) {%>
                                <td valign="top" style="width:50%" >
                                    <div style="border:1px inset white; width:100%; padding:10 10 10 10">
                                        <table width="100%" cellpadding="0" cellspacing="0" border="0" id="luo_tab_header">
                                            <tr>
                                                <td></td>
                                                <td align='center' colspan="2">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Seleziona.tutto")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width:72%">
                                                    <b><%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%></b>
                                                </td>
                                                <td align='right'>
                                                    <input class='checkbox' type='checkbox' name='checkLUO' onclick='selectLUO()'>
                                                </td>
                                                <td style="width:10px">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width:100%" colspan="3" align="left">
                                                    <div id="ifrmRow1" style="overflow-y:auto; width:100%; height:250px;">
                                                        <%out.print(strLuoFsc);%>
                                                    </div>
                                                </td>
                                            </tr>	
                                        </table>
                                    </div>
                                </td>
                                <%}%>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="cCont" style="display:none">
                <%
                    try {
                        if (bExtended) {
                            String strCOD_COU = Security.getUserPrincipal().getName();
                            IConsultantHome cou_home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                            IConsultant cou_bean = cou_home.findByPrimaryKey(strCOD_COU);
                            long COD_CUR_AZL = Security.getAzienda();
                            ;
                            Iterator it = cou_bean.getAziende().iterator();
                            while (it.hasNext()) {
                                ConsultantAzienda_Id_Name_View obj = (ConsultantAzienda_Id_Name_View) it.next();
                                if (Long.parseLong(Formatter.format(obj.COD_AZL)) == COD_CUR_AZL) {
                                    continue;
                                }
                %>
                <input  name="AZIENDA_ID" id="AZIENDA_ID" type="checkbox"  value="<%=Formatter.format(obj.COD_AZL)%>" checked>
                <% 	}
                        }
                    } catch (Exception ex) {
                    }%>	
            </div>
        </form>
        <iframe id="ifrmWork" name="ifrmWork"  class="ifrmWork" src="../empty.txt" style="width:100%; height:300px;"></iframe>

        <script>
        document.onload = init();
        function init() {
            tabHeader1 = document.all["man_tab_header"];
            tabHeader2 = document.all["luo_tab_header"];
            tabBody1 = document.all["man_tab_body"];
            tabBody2 = document.all["luo_tab_body"];
            if (tabBody1)
                adaptTable(tabHeader1, tabBody1, (document.all["ifrmRow"].clientWidth == document.all["ifrmRow"].offsetWidth));
            if (tabBody2)
                adaptTable(tabHeader2, tabBody2, (document.all["ifrmRow1"].clientWidth == document.all["ifrmRow1"].offsetWidth));

        }
        function adaptTable(tableHeader, table, isOffset) {
            counter = new Object();
            counter.i = 0;
            counter.y = 0;
            counter.z = 0;
            if (table.rows.length == 0)
                return;

            for (counter.i = 0; counter.i < table.rows.length; counter.i++) {
                for (counter.y = 0; counter.y < table.rows[counter.i].cells.length; counter.y++) {
                    iCol = table.rows[counter.i].cells[counter.y].getElementsByTagName("INPUT");
                    for (counter.z = 0; counter.z < iCol.length; counter.z++) {
                        width = tableHeader.rows[0].cells[counter.y].offsetWidth;
                        if (iCol[counter.z].type == "text") {
                            iCol[counter.z].width = width;
                            table.rows[counter.i].cells[counter.y].style.width = width;
                            break;
                        } else
                        if (iCol[counter.z].type == "checkbox") {
                            if (isOffset) {
                                table.rows[counter.i].cells[counter.y + 1].innerHTML = "&nbsp;";
                                table.rows[counter.i].cells[counter.y + 1].style.width = <%= (isMono) ? "\"16px\"" : "\"10px\""%>;

                            }
                            break;
                        }
                    }
                }
            }
            counter = null;
        }
        </script>
    </body>
</html>
