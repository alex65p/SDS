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

<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
        response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
        response.setHeader("Pragma", "no-cache"); //HTTP 1.0
        response.setDateHeader("Expires", 0); //prevents caching at the proxy server
//-------------------------------------------------------------------------------

        long lCOD_AZL = Security.getAzienda();
        long lCOD_UNI_ORG = 0;
        String strVISITA = "M";
        String strSTATO = "N";
        java.sql.Date dDAT_PIF_VST_D = null;
        java.sql.Date dDAT_PIF_VST_A = null;
        java.sql.Date dDAT_EFT_VST_D = null;
        java.sql.Date dDAT_EFT_VST_A = null;
        String strTPL_ACR_VLU_RSO = "";
        String strRAGGRUPPATI = "N";
        String strSTA_INT = "";
//--- per sort
        String strSORT_DAT_PIF = ", 'a'.'dat_pif_vst_med' asc ";
        String strSORT_DAT_EFT = "X";
        String strSORT_TPL_ACC = "X";

        Checker c = new Checker();

//if (request.getParameter("COD_AZIENDA")!=null)
        lCOD_AZL = c.checkLong("COD Azienda", request.getParameter("COD_AZIENDA"), true);

        if (request.getParameter("COD_UNI_ORG") != null) {
            lCOD_UNI_ORG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.org."), request.getParameter("COD_UNI_ORG"), false);
        }

        if (request.getParameter("R_VISITA") != null) {
            strVISITA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Visita"), request.getParameter("R_VISITA"), false);
        }

        if (request.getParameter("R_STATO") != null) {
            strSTATO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Status"), request.getParameter("R_STATO"), false);
        }

        if (request.getParameter("TPL_ACR_VLU_RSO") != null) {
            strTPL_ACR_VLU_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.accertamento"), request.getParameter("TPL_ACR_VLU_RSO"), false);
        }

        if (request.getParameter("DAT_PIF_VST_D") != null) {
            dDAT_PIF_VST_D = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"), request.getParameter("DAT_PIF_VST_D"), false);
        }

        if (request.getParameter("DAT_PIF_VST_A") != null) {
            dDAT_PIF_VST_A = c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"), request.getParameter("DAT_PIF_VST_A"), false);
        }

        if (request.getParameter("DAT_EFT_VST_D") != null) {
            dDAT_EFT_VST_D = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal"), request.getParameter("DAT_EFT_VST_D"), false);
        }

        if (request.getParameter("DAT_EFT_VST_A") != null) {
            dDAT_EFT_VST_A = c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"), request.getParameter("DAT_EFT_VST_A"), false);
        }


//<comment>Added by Podmasteriev at 10/03/2004
        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>alert(\"" + err + "\");</script>");
            return;
        }
//</comment>

        if ((dDAT_PIF_VST_D != null) && (dDAT_PIF_VST_A != null)) {
            if (dDAT_PIF_VST_D.compareTo(dDAT_PIF_VST_A) > 0) {
                out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
                return;
            }
        }

        if ((dDAT_EFT_VST_D != null) && (dDAT_EFT_VST_A != null)) {
            if (dDAT_EFT_VST_D.compareTo(dDAT_EFT_VST_A) > 0) {
                out.print("<script>parent.alert(arraylng[\"MSG_0078\"]);</script>");
                return;
            }
        }

        if (request.getParameter("R_RAGGRUPPATI") != null) {
            strRAGGRUPPATI = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"), request.getParameter("R_RAGGRUPPATI"), false);
        }

//************************ SORT *******************
        if (request.getParameter("SORT_DAT_PIF") != null) {
            strSORT_DAT_PIF = c.checkString("", request.getParameter("SORT_DAT_PIF"), false);
        }

        if (request.getParameter("SORT_DAT_EFT") != null) {
            strSORT_DAT_EFT = c.checkString("", request.getParameter("SORT_DAT_EFT"), false);
        }

        if (request.getParameter("SORT_TPL_ACC") != null) {
            strSORT_TPL_ACC = c.checkString("", request.getParameter("SORT_TPL_ACC"), false);
        }


        if (request.getParameter("STA_INT") != null) {
            strSTA_INT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"), request.getParameter("STA_INT"), false);
        }
        /*out.println("<br>lCOD_AZL="+lCOD_AZL);
        out.println("<br>lCOD_UNI_ORG="+lCOD_UNI_ORG);
        out.println("<br>strTPL_ACR_VLU_RSO="+strTPL_ACR_VLU_RSO);
        out.println("<br>strSTATO="+strSTATO);
        out.println("<br>dDAT_PIF_VST_D="+dDAT_PIF_VST_D);
        out.println("<br>dDAT_PIF_VST_A="+dDAT_PIF_VST_A);
        out.println("<br>strSTA_INT="+strSTA_INT);
        out.println("<br>dDAT_EFT_VST_D="+dDAT_EFT_VST_D);
        out.println("<br>dDAT_EFT_VST_A="+dDAT_EFT_VST_A);*/

        out.println("<br>strRAGGRUPPATI=" + strRAGGRUPPATI);
        out.println("<br>strSORT_DAT_PIF=" + strSORT_DAT_PIF);
        out.println("<br>strSORT_DAT_EFT=" + strSORT_DAT_EFT);
        out.println("<br>strSORT_TPL_ACC=" + strSORT_TPL_ACC);

//String , String , String , String

        IGestioneVisiteMedicheHome homeM = (IGestioneVisiteMedicheHome) PseudoContext.lookup("GestioneVisiteMedicheBean");

        IGestioneVisiteIdoneitaHome homeI = (IGestioneVisiteIdoneitaHome) PseudoContext.lookup("GestioneVisiteIdoneitaBean");

//--- create table
        String str;

//return;
        java.util.Collection col_nr = null;
        if (strVISITA.equals("M")) {
            col_nr = homeM.getVisiteMediche_foo_SCHVST_View(lCOD_AZL, lCOD_UNI_ORG, strTPL_ACR_VLU_RSO, strSTATO, dDAT_PIF_VST_D, dDAT_PIF_VST_A, strSTA_INT, dDAT_EFT_VST_D, dDAT_EFT_VST_A, strRAGGRUPPATI, strSORT_DAT_PIF, strSORT_DAT_EFT, strSORT_TPL_ACC);
        } else if (strVISITA.equals("I")) {
            col_nr = homeI.getVisiteIdoneita_for_SCHVST_View(lCOD_AZL, lCOD_UNI_ORG, strTPL_ACR_VLU_RSO, strSTATO, dDAT_PIF_VST_D, dDAT_PIF_VST_A, strSTA_INT, dDAT_EFT_VST_D, dDAT_EFT_VST_A, strRAGGRUPPATI, strSORT_DAT_PIF, strSORT_DAT_EFT, strSORT_TPL_ACC);
        } else {
            return;
        }
//long	COD_CTL_SAN, COD_VST_MED, COD_DPD, COD_AZL;

        out.print("<div id=divFile><table border='0' align='left' width='796' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
        out.print("<tr style='display:none' ID='' ><td width=32>&nbsp;<td>");
        out.print("<td width='' class='dataTd'><input type='text' name='DAT_PIF_VST_MED' class='dataInput' readonly  value=''></td>");
        out.print("<td width='' class='dataTd'><input type='text' name='DAT_EFT_VST_MED' readonly class='dataInput'  value='' size=10></td>");
        out.print("<td width='' class='dataTd'><input type='text' name='DAT_EFT_VST_MED' readonly class='dataInput'  value='' size=10></td>");
        out.print("<td width='' class='dataTd'><input type='text' name='TPL_ACR_VLU_RSO' readonly class='dataInput'  value=''></td>");
        out.print("<td width='' class='dataTd'><input type='text' name='DPD' readonly class='dataInput'  value=''></td>");
        out.print("<td width='' class='dataTd'><input type='text' name='RAG_SCL_AZL' readonly class='dataInput'  value=''></td></tr>");
//if ( !COD_TPL_DPI.equals("") ){
        java.util.Iterator it_nr = col_nr.iterator();
        String strColor = "", strImg = "";
        long difTime = 0;

        java.util.Date cdt = new java.util.Date();
        java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());

        if (it_nr.hasNext()) {
            out.print("<script>if (parent.curOpen==1) parent.document.all['imgDP'].style.display='';parent.curOpen=2;</script>");
        }
        long curNumRec = 1;
        while (it_nr.hasNext()) {
            VisiteMediche_foo_SCHVST_View nr;
            if (strVISITA.equals("M")) {
                nr = (VisiteMediche_foo_SCHVST_View) it_nr.next();
            } else {
                VisiteIdoneita_for_SCHVST_View nr1 = (VisiteIdoneita_for_SCHVST_View) it_nr.next();
                nr = new VisiteMediche_foo_SCHVST_View();
                nr.COD_CTL_SAN = nr1.COD_CTL_SAN;
                nr.COD_VST = nr1.COD_VST;
                nr.COD_DPD = nr1.COD_DPD;
                nr.COD_AZL = nr1.COD_AZL;
                nr.DAT_PIF_VST_MED = nr1.DAT_PIF_VST_MED;
                nr.DAT_EFT_VST_MED = nr1.DAT_EFT_VST_MED;
                nr.TPL_ACR_VLU_RSO = nr1.TPL_ACR_VLU_RSO;
                nr.DPD = nr1.DPD;
                nr.RAG_SCL_AZL = nr1.RAG_SCL_AZL;
            }
            /*			if (strVISITA.equals("M")) {VisiteMediche_foo_SCHVST_View nr=(VisiteMediche_foo_SCHVST_View)it_nr.next();}
            if (strVISITA.equals("I")) {VisiteIdoneita_for_SCHVST_View nr=(VisiteIdoneita_for_SCHVST_View)it_nr.next();}*/

            strColor = "";
            strImg = "&nbsp;";
            if (nr.DAT_EFT_VST_MED != null) {
                strColor = "green";
            }
            if ((nr.DAT_EFT_VST_MED == null) && (dtDAT_INZ.compareTo(nr.DAT_PIF_VST_MED) == 0)) {
                strColor = "blue";
            }
            if ((nr.DAT_EFT_VST_MED == null) && (nr.DAT_PIF_VST_MED.compareTo(dtDAT_INZ) < 0)) {
                strColor = "red";
                difTime = dtDAT_INZ.getTime() - nr.DAT_PIF_VST_MED.getTime();
                difTime = difTime / 1000 / 3600 / 24;
                //out.print ("<br>difTime="+difTime);

                if (difTime == 1) {
                    strImg = "<img src='../_images/1-r.gif' alt='1'>";
                } else if (difTime == 2) {
                    strImg = "<img src='../_images/2-r.gif' alt='2'>";
                } else if (difTime == 3) {
                    strImg = "<img src='../_images/3-r.gif' alt='3'>";
                } else if (difTime == 4) {
                    strImg = "<img src='../_images/4-r.gif' alt='4'>";
                } else if (difTime >= 5) {
                    strImg = "<img src='../_images/5-r.gif' alt='5'>";
                }
            }
//out.print ("<br><br>nr.DAT_EFT_VST_MED="+nr.DAT_EFT_VST_MED+"===nr.DAT_PIF_VST_MED"+nr.DAT_PIF_VST_MED+"dtDAT_INZ="+dtDAT_INZ+"==strColor="+strColor);

            out.print("<tr INDEX=\"" + Formatter.format(nr.COD_CTL_SAN) + "\" ID='tr" + curNumRec + "' class=listTr onclick='selTrSCH_VST(5," + curNumRec + "," + nr.COD_VST + ")' ondblclick='showDetailSCH_VST()'>");
            out.print("<td width='40'>" + strImg + "</td>");
            out.print("<td><input type='text' id='inp1" + curNumRec + "' readonly class='dataInput'  style='width:110; color:" + strColor + ";'  value=\"" + Formatter.format(nr.DAT_PIF_VST_MED) + "\"></td>");
            out.print("<td><input type='text' id='inp2" + curNumRec + "' readonly class='dataInput'  style='width:110; color:" + strColor + ";' value=\"" + Formatter.format(nr.DAT_EFT_VST_MED) + "\"></td>");
            out.print("<td><input type='text' id='inp3" + curNumRec + "' readonly class='dataInput' style='width:186; color:" + strColor + ";' value=\"" + Formatter.format(nr.TPL_ACR_VLU_RSO) + "\"></td>");
            out.print("<td><input type='text' id='inp4" + curNumRec + "' readonly class='dataInput' style='width:175; color:" + strColor + ";' value=\"" + Formatter.format(nr.DPD) + "\"></td>");
            out.print("<td><input type='text' id='inp5" + curNumRec + "' readonly class='dataInput' style='width:175; color:" + strColor + ";' value=\"" + Formatter.format(nr.RAG_SCL_AZL) + "\"></td>");
            out.print("</tr>");
            curNumRec = curNumRec + 1;
        }
        out.print("</table></div>");
//out.print(str);
/**/
%>


<script>
    parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
