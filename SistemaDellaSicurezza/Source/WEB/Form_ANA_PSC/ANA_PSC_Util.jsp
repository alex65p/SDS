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
    Document   : ANA_PSC_Util
    Created on : 22-mar-2011, 10.14.40
    Author     : Alessandro
--%>

<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>

<%!
    String BuildSezioneGeneraleTab(IPSC bean) {
        String str = "";
        String strTemp = "";
        String strRev = "";
        java.util.Collection col = bean.getSezioneGeneraleView();
        str += "<table border='0' align='left' width='749' id='' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Codice") + "</strong></td>";
        str += "<td width='229'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Oggetto") + "</strong></td>";
        str += "<td width='90'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Revisione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.emissione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.protocollo") + "</strong></td>";
        str += "<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento.collegato") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='1' align='left' width='749' id='SezioneGenerale' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD="+ "001" + "' INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "'>";
        str += "<td width='50' class='dataTd'><input type='text' name='COD' readonly class='dataInput'  value=''></td>";
        str += "<td width='229' class='dataTd'><input type='text' name='OGG' readonly class='dataInput'  value=''></td>";
        str += "<td width='90' class='dataTd'><input type='text' name='REV' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_EMI' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_PRO' readonly class='dataInput'  value=''></td>";
        str += "<td width='180' class='dataTd'><input type='text' name='DOC_COL' readonly class='dataInput'  value=''></td>";
        if (bean != null) {
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                Sezione_Generale_All_View rc = (Sezione_Generale_All_View) it.next();                       
                str += "<tr INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "' ID='" + rc.COD_SEZ_GEN + "' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD=" + Formatter.format(rc.COD) + "&DAT=" + Formatter.format(rc.DAT_EMI) + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\"" + Formatter.format(rc.COD) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 229px;' class='inputstyle'  value=\"" + Formatter.format(rc.OGG) + "\"></td>";
                strTemp = (rc.REV.equals("0")) ? "In lavorazione" : (rc.REV.equals("1")) ? "Emissione" : Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 90px;' class='inputstyle'  value=\"" + strTemp + "\"></td>";
                // str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.REV) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_EMI) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_PRO) + "\"></td>";
                strRev = (rc.REV.equals("0")) ? "" : (rc.REV.equals("1")) ? "" : "-"+Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\"" + Formatter.format(rc.DOC_COL)+  "\"></td>";
                str += "</tr>";
            }
        }// bean = null
        str += "</table>";
        return str;
    }

    String BuildSchedeSicurezzaTab(IPSC bean) {
        String strTemp = "";
        String str = "";
        String strRev = "";
        java.util.Collection col = bean.getSchedediSicurezzaView();
        str += "<table border='1' align='left' width='749' id='' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Codice") + "</strong></td>";
        str += "<td width='229'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Oggetto") + "</strong></td>";
        str += "<td width='90'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Revisione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.emissione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.protocollo") + "</strong></td>";
        str += "<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento.collegato") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='749' id='' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD="+ "S01" + "' INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "' >";
        str += "<td width='50' class='dataTd'><input type='text' name='COD' readonly class='dataInput'  value=''></td>";
        str += "<td width='229' class='dataTd'><input type='text' name='OGG' readonly class='dataInput'  value=''></td>";
        str += "<td width='90' class='dataTd'><input type='text' name='REV' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_EMI' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_PRO' readonly class='dataInput'  value=''></td>";
        str += "<td width='180' class='dataTd'><input type='text' name='DOC_COL' readonly class='dataInput'  value=''></td>";
        if (bean != null) {
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                SchedeSicurezza_All_View rc = (SchedeSicurezza_All_View) it.next();
                str += "<tr INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "' ID='" + rc.COD_SCH_SIC + "' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD=" + Formatter.format(rc.COD)  + "&DAT=" + Formatter.format(rc.DAT_EMI) + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\"" + Formatter.format(rc.COD) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 229px;' class='inputstyle'  value=\"" + Formatter.format(rc.OGG) + "\"></td>";
                strTemp = (rc.REV.equals("0")) ? "In lavorazione" : (rc.REV.equals("1")) ? "Emissione" : Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 90px;' class='inputstyle'  value=\"" + strTemp + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_EMI) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_PRO) + "\"></td>";
                strRev = (rc.REV.equals("0")) ? "" : (rc.REV.equals("1")) ? "" : "-"+Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\"" + Formatter.format(rc.DOC_COL)+ "\"></td>";
                str += "</tr>";
            }
        }// bean = null
        str += "</table>";
        return str;
    }

    String BuildSezioneParticolareTab(IPSC bean) {
        String str = "";
        String strTemp = "";
        String strRev = "";
        java.util.Collection col = bean.getSezioneParticolareView();
        str += "<table border='1' align='left' width='754' id='' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Codice") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
        str += "<td width='134'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Oggetto") + "</strong></td>";
        str += "<td width='90'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Revisione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.emissione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.protocollo") + "</strong></td>";
        str += "<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento.collegato") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='754' id='' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD=" + "" + "' INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "'>";
        str += "<td width='50' class='dataTd'><input type='text' name='COD' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='TIT' readonly class='dataInput'  value=''></td>";
        str += "<td width='134' class='dataTd'><input type='text' name='OGG' readonly class='dataInput'  value=''></td>";
        str += "<td width='90' class='dataTd'><input type='text' name='REV' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_EMI' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_PRO' readonly class='dataInput'  value=''></td>";
        str += "<td width='180' class='dataTd'><input type='text' name='DOC_COL' readonly class='dataInput'  value=''></td>";
        if (bean != null) {
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                SezioneParticolare_All_View rc = (SezioneParticolare_All_View) it.next();
                str += "<tr INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "' ID='" + rc.COD_SEZ_PAR + "' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD=" + Formatter.format(rc.COD) + "&TIT=" + Formatter.format(rc.TIT) + "&DAT_PRO=" + Formatter.format(rc.DAT_PRO)  + "&DAT=" + Formatter.format(rc.DAT_EMI) + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\"" + Formatter.format(rc.COD) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.TIT) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 134px;' class='inputstyle'  value=\"" + Formatter.format(rc.OGG) + "\"></td>";
                strTemp = (rc.REV.equals("0")) ? "In lavorazione" : (rc.REV.equals("1")) ? "Emissione" : Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 90px;' class='inputstyle'  value=\"" + strTemp + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_EMI) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_PRO) + "\"></td>";
                strRev = (rc.REV.equals("0")) ? "" : (rc.REV.equals("1")) ? "" : "-"+Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\"" + Formatter.format(rc.DOC_COL)+ "\"></td>";
                str += "</tr>";
            }
        }// bean = null
        str += "</table>";
        return str;
    }

    String BuildFascicoloTab(IPSC bean) {
        String str = "";
        String strTemp = "";
        String strRev = "";
        java.util.Collection col = bean.getFascicoloView();
        str += "<table border='1' align='left' width='749' id='' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Codice") + "</strong></td>";
        str += "<td width='229'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Oggetto") + "</strong></td>";
        str += "<td width='90'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Revisione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.emissione") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.protocollo") + "</strong></td>";
        str += "<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento.collegato") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='749' id='' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD="+ "F01" + "' INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "'>";
        str += "<td width='50' class='dataTd'><input type='text' name='COD' readonly class='dataInput'  value=''></td>";
        str += "<td width='229' class='dataTd'><input type='text' name='OGG' readonly class='dataInput'  value=''></td>";
        str += "<td width='90' class='dataTd'><input type='text' name='REV' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_EMI' readonly class='dataInput'  value=''></td>";
        str += "<td width='100' class='dataTd'><input type='text' name='DAT_PRO' readonly class='dataInput'  value=''></td>";
        str += "<td width='180' class='dataTd'><input type='text' name='DOC_COL' readonly class='dataInput'  value=''></td>";
        if (bean != null) {
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                Fascicolo_All_View rc = (Fascicolo_All_View) it.next();
                str += "<tr INDEX='" + Formatter.format(bean.getlCOD_PSC()) + "' ID='" + rc.COD_FAS + "' paramsList='COD_PRO=" + bean.getlCOD_PRO() + "&COD=" + Formatter.format(rc.COD)  + "&DAT=" + Formatter.format(rc.DAT_EMI) + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\"" + Formatter.format(rc.COD) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 229px;' class='inputstyle'  value=\"" + Formatter.format(rc.OGG) + "\"></td>";
                strTemp = (rc.REV.equals("0")) ? "In lavorazione" : (rc.REV.equals("1")) ? "Emissione" : Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 90px;' class='inputstyle'  value=\"" + strTemp + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_EMI) + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(rc.DAT_PRO) + "\"></td>";
                strRev = (rc.REV.equals("0")) ? "" : (rc.REV.equals("1")) ? "" : "-"+Formatter.format(rc.REV);
                str += "<td class='dataTd'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\"" + Formatter.format(rc.DOC_COL)+ "\"></td>";
                str += "</tr>";
            }
        }// bean = null
        str += "</table>";
        return str;
    }

    String BuildProcedimentoComboBox(IAnagrProcedimentoHome home, long SELECTED_ID, long lCOD_AZL) {
        String str = "";
        String strSEL = "";
        java.util.Collection col = home.getAnagrProcedimento_All_View(lCOD_AZL);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnagrProcedimento_All_View dt = (AnagrProcedimento_All_View) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == dt.COD_PRO) {
                    strSEL = "selected";
                }
            }
            str = str + "<option " + strSEL + " value='" + Formatter.format(dt.COD_PRO) + "' codiceprocedimento='" + Formatter.format(dt.COD) + "'>" + Formatter.format(dt.DES) + "</option>";
        }
        return str;
    }
%>
