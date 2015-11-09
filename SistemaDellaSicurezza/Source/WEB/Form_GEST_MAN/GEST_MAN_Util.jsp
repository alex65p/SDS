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
     <version number="1.0" date="23/02/2004" author="Pogrebnoy Yura">
     <comments>
     <comment date="23/02/2004" author="Pogrebnoy Yura">
     <description>Functions for GEST_MAN_Form</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>

<%!
    String AGGIORNA_MANSIONE_COR(IAttivitaLavorativeHome home, String strCOD_RSO, String strCOD_COR, boolean bIsMan) {
        String tab = "";
        java.util.Collection col_cor = null;
        java.util.Iterator it_cor = null;
        long lCOD_AZL = Security.getAzienda();
        long i;
        if (bIsMan) {
            tab += "<table id=\"man_tab_body\"   cellpadding=\"0\" cellspacing=\"0\" width='100%'>";
            col_cor = home.getAGGIORNA_MANSIONE_COR_View(strCOD_RSO, strCOD_COR, lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                AGGIORNA_MANSIONE_View obj = (AGGIORNA_MANSIONE_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_COR + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_MAN) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_MAN\" type='checkbox' onclick=\"setCheckedATT(" + Formatter.format(obj.COD_MAN) + ",this.id)\" value=\"" + Formatter.format(obj.COD_MAN) + "\" id='checkATT" + i + "'></td><td></td>";
                tab += "</tr>";
            }
            tab += "</table>";
            tab += "<script>checksum=" + i + "</script>";

        } else {
            tab += "<table id=\"luo_tab_body\" cellpadding=\"0\" cellspacing=\"0\" width='100%'>";
            col_cor = home.getGEST_MAN_LUO_View(strCOD_RSO, strCOD_COR, "cor", lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                GEST_MAN_LUO_View obj = (GEST_MAN_LUO_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_COR + "\" id=\"" + Formatter.format(obj.COD_LUO_FSC) + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_LUO_FSC) + "\" size='45' onclick=\"changeLUO(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_LUO_FSC\" type='checkbox' onchange='setCheckedLUO(" + Formatter.format(obj.COD_LUO_FSC) + ",this.id)' value=\"" + Formatter.format(obj.COD_LUO_FSC) + "\" id='checkLUO" + i + "'></td><td></td>";
                tab += "</tr>";
            }

            tab += "</table>";
            tab += "<script>checksumluo=" + i + "</script>";
        }
        return tab;
    }

    String AGGIORNA_MANSIONE_DPI(IAttivitaLavorativeHome home, String strCOD_RSO, String strCOD_TPL_DPI, boolean bIsMan) {
        String tab = "";
        java.util.Collection col_cor = null;
        java.util.Iterator it_cor = null;
        long i;
        long lCOD_AZL = Security.getAzienda();
        if (bIsMan) {
            tab += "<table  id=\"man_tab_body\" width='100%' cellpadding=\"0\" cellspacing=\"0\" >";
            col_cor = home.getAGGIORNA_MANSIONE_DPI_View(strCOD_RSO, strCOD_TPL_DPI, lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                AGGIORNA_MANSIONE_View obj = (AGGIORNA_MANSIONE_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_TPL_DPI + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_MAN) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_MAN\" type='checkbox' onchange='setCheckedATT(" + Formatter.format(obj.COD_MAN) + ",this.id)' value=\"" + Formatter.format(obj.COD_MAN) + "\" id='checkATT" + i + "'><td></td>";
                tab += "</tr>";
            }
            tab += "<script>checksum=" + i + "</script>";
            tab += "</table>";
        } else {
            tab += "<table id=\"luo_tab_body\" width='100%'>";
            col_cor = home.getGEST_MAN_LUO_View(strCOD_RSO, strCOD_TPL_DPI, "dpi", lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                GEST_MAN_LUO_View obj = (GEST_MAN_LUO_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_TPL_DPI + "\" id=\"" + Formatter.format(obj.COD_LUO_FSC) + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_LUO_FSC) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_LUO_FSC\" type='checkbox' value=\"" + Formatter.format(obj.COD_LUO_FSC) + "\" id='checkLUO" + i + "' onchange='setCheckedLUO(" + Formatter.format(obj.COD_LUO_FSC) + ",this.id)'><td></td>";
                tab += "</tr>";
            }

            tab += "</table>";
            tab += "<script>checksumluo=" + i + "</script>";

        }
        return tab;
    }

    String AGGIORNA_MANSIONE_PRO_SAN(IAttivitaLavorativeHome home, String strCOD_RSO, String strCOD_PRO_SAN, boolean bIsMan) {
        String tab = "";
        java.util.Collection col_cor = null;
        java.util.Iterator it_cor = null;
        long lCOD_AZL = Security.getAzienda();
        long i;
        if (bIsMan) {
            tab += "<table id=\"man_tab_body\"  width='100%'>";
            col_cor = home.getAGGIORNA_MANSIONE_PRO_SAN_View(strCOD_RSO, strCOD_PRO_SAN, lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;

            while (it_cor.hasNext()) {
                i++;
                AGGIORNA_MANSIONE_View obj = (AGGIORNA_MANSIONE_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_PRO_SAN + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_MAN) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_MAN\" class='checkbox' type='checkbox' onchange='setCheckedATT(" + Formatter.format(obj.COD_MAN) + ",this.id)' value=\"" + Formatter.format(obj.COD_MAN) + "\" id='checkATT" + i + "'><td></td>";
                tab += "</tr>";
            }
            tab += "<script>checksum=" + i + "</script>";
            tab += "</table>";
        } else {
            tab += "<table id=\"luo_tab_body\" width='100%'>";
            col_cor = home.getGEST_MAN_LUO_View(strCOD_RSO, strCOD_PRO_SAN, "pro_san", lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                GEST_MAN_LUO_View obj = (GEST_MAN_LUO_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_PRO_SAN + "\" id=\"" + Formatter.format(obj.COD_LUO_FSC) + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_LUO_FSC) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_LUO_FSC\" type='checkbox' value=\"" + Formatter.format(obj.COD_LUO_FSC) + "\" id='checkLUO" + i + "' onchange='setCheckedLUO(" + Formatter.format(obj.COD_LUO_FSC) + ",this.id)'><td></td>";
                tab += "</tr>";
            }
            tab += "</table>";
            tab += "<script>checksumluo=" + i + "</script>";
        }
        return tab;
    }

    String AGGIORNA_MANSIONE_MIS_PET(IAttivitaLavorativeHome home, String strCOD_RSO, String strCOD_MIS_PET, boolean bIsMan) {
        String tab = "";
        java.util.Collection col_cor = null;
        java.util.Iterator it_cor = null;
        long lCOD_AZL = Security.getAzienda();
        long i;
        if (bIsMan) {
            tab += "<table id=\"man_tab_body\"  width='100%'>";
            col_cor = home.getAGGIORNA_MANSIONE_MIS_PET_View(strCOD_RSO, strCOD_MIS_PET, lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;

            while (it_cor.hasNext()) {
                i++;
                AGGIORNA_MANSIONE_View obj = (AGGIORNA_MANSIONE_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_MIS_PET + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_MAN) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_MAN\" class='checkbox' type='checkbox' onchange='setCheckedATT(" + Formatter.format(obj.COD_MAN) + ",this.id)' value=\"" + Formatter.format(obj.COD_MAN) + "\" id='checkATT" + i + "'><td></td>";
                tab += "</tr>";
            }
            tab += "<script>checksum=" + i + "</script>";
            tab += "</table>";
        } else {
            tab += "<table id=\"luo_tab_body\" width='100%'>";
            col_cor = home.getAGGIORNA_LUOGO_FISICO_MIS_PET_View(strCOD_RSO, strCOD_MIS_PET, lCOD_AZL);
            it_cor = col_cor.iterator();
            i = 0;
            while (it_cor.hasNext()) {
                i++;
                GEST_MAN_LUO_View obj = (GEST_MAN_LUO_View) it_cor.next();
                tab += "<tr INDEX=\"" + strCOD_MIS_PET + "\" id=\"" + Formatter.format(obj.COD_LUO_FSC) + "\">";
                tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_LUO_FSC) + "\" size='45' onclick=\"changeATT(" + i + ")\"></td>";
                tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_LUO_FSC\" type='checkbox' value=\"" + Formatter.format(obj.COD_LUO_FSC) + "\" id='checkLUO" + i + "' onchange='setCheckedLUO(" + Formatter.format(obj.COD_LUO_FSC) + ",this.id)'><td></td>";
                tab += "</tr>";
            }
            tab += "</table>";
            tab += "<script>checksumluo=" + i + "</script>";
        }
        return tab;
    }
    
    String CARICA_MANSIONI(IAttivitaLavorativeHome home, String strCOD_OPE_SVO, long lCOD_MAN, long lCOD_AZL) {
        String tab = "";
        tab = "<table id=\"man_tab_body\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  width='100%'>";
        java.util.Collection col_cor = home.getCARICA_MANSIONI_View(strCOD_OPE_SVO, lCOD_AZL);
        java.util.Iterator it_cor = col_cor.iterator();
        long i = 0;
        while (it_cor.hasNext()) {
            i++;
            AGGIORNA_MANSIONE_View obj = (AGGIORNA_MANSIONE_View) it_cor.next();
            String checked = "";
            if (lCOD_MAN == obj.COD_MAN) {
                checked = " checked current=1";
            }
            tab += "<tr INDEX=\"" + strCOD_OPE_SVO + "\">";
            tab += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(obj.NOM_MAN) + "\" size='100%' onclick=\"changeATT(" + i + ")\"></td>";
            tab += "<td class='dataTd' align='center'><input class='checkbox' name=\"cbCOD_MAN\" type='checkbox' " + checked + "  onchange='setCheckedATT(" + Formatter.format(obj.COD_MAN) + ",this.id)' value=\"" + Formatter.format(obj.COD_MAN) + "\" id='checkATT" + i + "'></td><td></td>";
            tab += "</tr>";
        }
        tab += "</table>";
        tab += "<script>checksum=" + i + "</script>";
        return tab;
    }

    String CARICA_ExLUOGHI_FISICI(Collection col, long lCOD, long lCOD_LUO_FSC, String strType) {
        String tab = "";
        long i = 0;
        tab = "<table id=\"luo_tab_body\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  width='100%'>";
        if (col != null) {
            java.util.Iterator it = col.iterator();
            if (strType.equals("sos_chi_rischio")) {
                while (it.hasNext()) {
                    i++;
                    Sostanza_LuoghiFisiciView obj = (Sostanza_LuoghiFisiciView) it.next();
                    tab += getStrLuogo(obj.lCOD_LUO_FSC, lCOD, obj.strNOM_LUO_FSC, lCOD_LUO_FSC, i);
                }
            }
            if (strType.equals("macchina_rischio")) {
                while (it.hasNext()) {
                    i++;
                    Macchina_LuoghiFisiciView obj = (Macchina_LuoghiFisiciView) it.next();
                    tab += getStrLuogo(obj.lCOD_LUO_FSC, lCOD, obj.strNOM_LUO_FSC, lCOD_LUO_FSC, i);
                }
            }
        }
        tab += "</table>";
        tab += "<script>checksumluo=" + i + ";</script>";
        return tab;
    }

    String CARICA_ExATTIVITA_LAVORATIVE(Collection col, long lCOD, long lCOD_MAN, String strType) {
        String tab = "";
        tab = "<table id=\"man_tab_body\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  width='100%'>";
        long i = 0;
        if (col != null) {
            java.util.Iterator it = col.iterator();
            if (strType.equals("sos_chi_rischio")) {
                while (it.hasNext()) {
                    i++;
                    SostanzaAttivitaLavorative_View obj = (SostanzaAttivitaLavorative_View) it.next();
                    tab += getStrAttivita(obj.lCOD_MAN, lCOD, obj.strNOM_MAN, lCOD_MAN, i);
                }
            }
            if (strType.equals("macchina_rischio")) {
                while (it.hasNext()) {
                    i++;
                    MacchinaAttivitaLavorative_View obj = (MacchinaAttivitaLavorative_View) it.next();
                    tab += getStrAttivita(obj.lCOD_MAN, lCOD, obj.strNOM_MAN, lCOD_MAN, i);
                }
            }
        }
        tab += "</table>";
        tab += "<script>checksum=" + i + ";</script>";
        return tab;
    }

    String getStrLuogo(long lCOD, long lCOD_OBJ, String strNOM, long lCOD_ex, long i) {
        return getStr(lCOD, lCOD_OBJ, strNOM, lCOD_ex, i, "l");
    }

    String getStrAttivita(long lCOD, long lCOD_OBJ, String strNOM, long lCOD_ex, long i) {
        return getStr(lCOD, lCOD_OBJ, strNOM, lCOD_ex, i, "m");
    }

    String getStr(long lCOD, long lCOD_OBJ, String strNOM, long lCOD_ex, long i, String strType) {
        String str = "";
        String checked = "";
        String strNameCb = "";
        String strID = "";
        String strAct = "";
        if (strType.equals("l")) {
            strNameCb = "cbCOD_LUO_FSC";
            strID = "LUO";

        } else if (strType.equals("m")) {
            strNameCb = "cbCOD_MAN";
            strID = "ATT";
        }
        if (lCOD_ex == lCOD) {
            checked = " checked disabled";
        }
        str += "<tr INDEX=\"" + lCOD_OBJ + "\">";
        str += "<td class='dataTd' width='72%'><input type='text' readonly class='dataInput' value=\"" + Formatter.format(strNOM) + "\" size='100%' onclick=\"change" + strID + "(" + i + ")\"></td>";
        str += "<td class='dataTd' align='center'><input class='checkbox' name=\"" + strNameCb + "\" type='checkbox' " + checked + "  onchange='setChecked" + strID + "(" + Formatter.format(lCOD) + ",this.id)' value=\"" + Formatter.format(lCOD) + "\" id='check" + strID + i + "'><td></td>";
        str += "</tr>";
        return str;

    }

%>
