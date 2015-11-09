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
    Document   : ANA_SOP_Util
    Created on : 23-mar-2011, 10.38.31
    Author     : Alessandro
--%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.jbConstatazione"%>
<%@page import="s2s.utils.Formatter"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>

<%--
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
--%>
<%!
    String ListaFattoriRischio(ISopraluogoHome home, Long SELECTED_ID, Long lCOD_AZL) {
        String str = "";
        if ((lCOD_AZL == null) || (lCOD_AZL == 0)) {
            return "<BR/><BR/>";
        }

        Collection col = home.getFattoriRischio(lCOD_AZL);
        Iterator it = col.iterator();

        String strSEL = null;
        str = "<select "
                + "id='lista_fattori' "
                + "style='width: 100%; height: 100%' "
                + "size='100%' "
                + "onchange='prepare4FatRsoChange();ajaxListCONST();gestCONSTadditionalInfo();' "
                + "name='lista_fattori' "
                + "tabindex='8'>"
                     + "<option  value='0'></option>";
        while (it.hasNext()) {
            jbFattoreRischio rec = (jbFattoreRischio) it.next();
            strSEL = "";
            if (SELECTED_ID != null && SELECTED_ID != 0) {
                if (SELECTED_ID.equals(rec.lCOD_FAT_RSO)) {
                    strSEL = "selected";
                }
            }
            str = str + "<option " + strSEL + " value='" + Formatter.format(rec.lCOD_FAT_RSO) + "'>" + Formatter.format(rec.sNOM_FAT_RSO) + "</option>";
        }
        str += "</select>";
        return str;
    }

    String ListaConstatazioni(ISopraluogoHome home, Long lcod_fat_rso, Long SELECTED_ID, Long lCOD_AZL) {
        String str = "";
        if ((lCOD_AZL == null) || (lCOD_AZL == 0)) {
            return "<BR/><BR/>";
        }

        Collection col = home.getConstatazioni(lcod_fat_rso, lCOD_AZL);
        Iterator it = col.iterator();

        String strSEL = null;
        str = "<select "
                + "id='lista_constatazioni' "
                + "style='width: 100%; height: 100%' "
                + "size='100%' "
                + "onchange='ajaxListCONST();gestCONSTadditionalInfo();' "
                + "ondblclick='apriEditor(this);' "
                + "name='lista_constatazioni' "
                + "tabindex='9'>"
                    + "<option  value='0'></option>";
        while (it.hasNext()) {
            jbConstatazione rec = (jbConstatazione) it.next();
            strSEL = "";
            if (SELECTED_ID != null && SELECTED_ID != 0) {
                if (SELECTED_ID.equals(rec.lCOD_CST)) {
                    strSEL = "selected";
                }
            }
            str = str + "<option " + strSEL + " value='" + Formatter.format(rec.lCOD_CST) + "'>" + Formatter.format(rec.sDESC) + "</option>";
        }
        str += "</select>";
        return str;
    }

    String ListaRischi(ISopraluogoHome home, Long SELECTED_ID, Long lCOD_AZL, Long lCOD_CST) {
        String str = "";
        if ((lCOD_CST == null) || (lCOD_CST == 0)) {
            return "<BR/><BR/>";
        }

        Collection col = home.getRischi(lCOD_AZL, lCOD_CST);
        Iterator it = col.iterator();
        int num = col.size() + 1;

        String strSEL = null;

        if (num > 1) {
            str = "<select disabled=\"disabled\" id='lista_rischi' style='width: 100%; height:100%;' size='" + num + "' name='lista_rischi' tabindex='10'>";
            while (it.hasNext()) {
                jbRischio rec = (jbRischio) it.next();
                strSEL = "";
                if (SELECTED_ID != null && SELECTED_ID != 0) {
                    if (SELECTED_ID == rec.lCOD) {
                        strSEL = "selected";
                    }
                }
                str = str + "<option " + strSEL + " value='" + Formatter.format(rec.lCOD) + "'>" + Formatter.format(rec.sNOME) + "</option>";
            }
            str += "</select>";
        } else {
            str = "<select id='lista_rischi' style='width: 100%; height:100%; background-color: white;' disabled size='100%' name='lista_rischi' tabindex='10'>";
            str = str + "<option " + strSEL + " value=''></option>";
            str += "</select>";
        }
        return str;
    }

    String ListaDisposizioni(ISopraluogoHome home, Long SELECTED_ID, Long lCOD_AZL, Long lCOD_CST) {
        String str = "";
        if ((lCOD_CST == null) || (lCOD_CST == 0)) {
            return "<BR/><BR/>";
        }

        Collection col = home.getDisposizioni(lCOD_AZL, lCOD_CST);
        Iterator it = col.iterator();
        int num = col.size() + 1;

        String strSEL = null;

        if (num > 1) {
            str = "<select id='lista_disposizioni' style='width: 100%; height:100%; background-color: #ffffcc;'readonly size='" + num + "' name='lista_disposizioni'>";
            while (it.hasNext()) {
                jbDisposizione rec = (jbDisposizione) it.next();
                strSEL = "";
                if (SELECTED_ID != null && SELECTED_ID != 0) {
                    if (SELECTED_ID == rec.lCOD) {
                        strSEL = "selected";
                    }
                }
                str = str + "<option " + strSEL + " value='" + Formatter.format(rec.lCOD) + "'>" + Formatter.format(rec.sNOME) + "</option>";
            }
            str += "</select>";
        } else {
            str = "<select id='lista_disposizioni' style='width: 100%; height:100%; background-color: white;' disabled size='100%' name='lista_disposizioni'>";
            str = str + "<option " + strSEL + " value=''></option>";
            str += "</select>";
        }
        return str;
    }

    String ListaDisposizioniGenerate(ISopraluogoHome home, Long SELECTED_ID, Long lCOD_AZL, Long lCOD_CST, Long lCOD_SOP_CST, int flg, boolean onlyDisp) {
        // Se non ho selezionato una constatazione esco dal metodo.
        if ((lCOD_CST == null) || (lCOD_CST == 0)) {
            return "<BR/><BR/>";
        }

        // RICOSTRUISCO LA DISPOSIZIONE GENERATA
        Collection col = null;
        col = home.getDisposizioni(lCOD_AZL, lCOD_CST);
        Iterator it = col.iterator();
        int num = col.size();

        String dispSalvata = "";
        String dispGenerata = "";

        int j = 0;
        while (it.hasNext()) {
            j++;
            jbDisposizione rec_dsp = (jbDisposizione) it.next();
            dispGenerata += rec_dsp.sDESC;
            dispGenerata += "\n";
            Collection col_art = home.getArticoliDaDisp(lCOD_AZL, rec_dsp.lCOD, lCOD_CST);
            Iterator it_art = col_art.iterator();
            int num_art = col_art.size();
            if (col_art.size() > 0) {
                dispGenerata += "( ";
                int i = 0;
                while (it_art.hasNext()) {
                    i += 1;
                    jbArticolo rec_art = (jbArticolo) it_art.next();
                    dispGenerata += rec_art.sNOME;
                    if (i < num_art) {
                        dispGenerata += ", ";
                    }
                }
                dispGenerata += " )\n";
            }
            if (j < num) {
                dispGenerata += "------------------\n";
            }
        }
        
        String dispBoxStyle = "text";
        
        // Se stò in inserimento di una constatazione...
        if (lCOD_SOP_CST == 0) {
            //... la disposizione da salvare diventa quella generata.
            dispSalvata = dispGenerata;
        // Se stò in modifica di una constatazione...
        } else {
            // ...estraggo la disposizione salvata per questa constatazione.
            jbConstatazione constatazione = home.getConstatazioneSOP(lCOD_SOP_CST);
            dispSalvata = constatazione.sDIS_GEN;
            
            // Se la disposizione salvata è uguale a quella generata allora imposto
            // il box "DISPOSIZIONE GENERATA" in VERDE.
            if (dispSalvata.trim().replace("\r\n","").equals(dispGenerata.trim().replace("\n",""))) {
                dispBoxStyle = "text_gendis_eq";
            // Se la disposizione salvata è diversa da quella generata allora imposto
            // il box "DISPOSIZIONE GENERATA" in ROSSO.
            } else {
                dispBoxStyle = "text_gendis_ne";
            }
        }
        
        return "<textarea "
                    + "style='width: 310px; height:160px;' "
                    + "id='text_gendis' "
                    + "tabindex='11' "
                    + "class='" + dispBoxStyle + "' "
                    + "name='text_gendis' "
                    + "rows='8' "
                    + "align='left'>" + (onlyDisp?dispGenerata:dispSalvata) + 
                "</textarea>";
    }

    String ListaArticoliLegge(ISopraluogoHome home, Long SELECTED_ID, Long lCOD_AZL, Long lCOD_CST, int flg) {
        String str = "";

        if ((lCOD_CST == null) || (lCOD_CST == 0)) {
            return "<BR/><BR/>";
        }

        Collection col = null;
        col = home.getArticoli_GEN(lCOD_AZL, lCOD_CST);
        Iterator it = col.iterator();

        String strTxt = "";

        int j = 0;
        while (it.hasNext()) {
            j++;
            jbArticolo rec_art = (jbArticolo) it.next();
            strTxt += rec_art.sNOME;
            strTxt += "\n";
            strTxt += rec_art.sDESC;
            strTxt += "\n";
            strTxt += ", ";
        }
        str += "<textarea readonly "
                + "id='text_gendis' "
                + "style='width: 310px; height:160px;' "
                + "tabindex='12' "
                + "class='art_leg' "
                + "name='text_art_leg' "
                + "rows='8' "
                + "align='left'>" + strTxt + "</textarea>";
        return str;
    }

%>
