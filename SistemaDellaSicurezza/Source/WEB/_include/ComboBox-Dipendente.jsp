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

<%!
    /* 	Questo Metodo è usato da tutte le funzionalità che utilizzano al loro
        interno una lista dei dipendenti nel formato "combo-box" e più in 
        dettaglio:
            - VERIFICHE S.P.P. > SEGNALAZIONI (tab "Attività Segnalazione")
            - VERIFICHE SANITARIE > CARTELLE CLINICHE
            - INFORTUNI > LISTA INFORTUNI
            - ANAGRAFICHE AZIENDA > ORGANIZZAZIONE >> UNITA' DI SICUREZZA (tab "Unità Organizzativa")
            - ANAGRAFICHE AZIENDA > LAVORATORI (tab "Consegne D.P.I.")
            - PRESIDI ANTINCENDIO > CATEGORIE (tab "Responsabili Categoria")
            - MACCHINARI > MANUTENZIONE/SOSTITUZIONE (tab "Schede Attività Segnalazione")
            - FORMAZIONE DEL PERSONALE > CORSI >> EROGAZIONE (tab "Lavoratori Iscritti")
            - ANALISI E CONTROLLO > MACCHINARI >> MANUTENZIONE
            - ANALISI E CONTROLLO > MACCHINARI >> SOSTITUZIONE
            - ANALISI E CONTROLLO > SEGNALAZIONI
            - ANALISI E CONTROLLO > AUDIT
 
        In alcuni particolari casi vengono invece utilizzati per la stessa
        situazione altri metodi, che sono sotto riportati e descritti.
 
        IDipendenteHome home = home interface of DipendenteBean
        long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
        long FILTER_ID = ID (COD_AZL) of current Aziendale
     */
    String BuildDipendenteComboBox(IDipendenteHome home, long SELECTED_ID, long FILTER_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDipendentiByAZLID_View(FILTER_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendentiByAZLID_View dt = (DipendentiByAZLID_View) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == dt.COD_DPD) {
                    strSEL = "selected";
                }
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value='")
                    .append(Formatter.format(dt.COD_DPD))
                    .append("'>")
                    .append(Formatter.format(dt.MTR_DPD))
                    .append(" - ")
                    .append(Formatter.format(dt.COG_DPD))
                    .append(" ")
                    .append(Formatter.format(dt.NOM_DPD))
                    .append("</option>");
        }
        return str.toString();
    }

    /* 	Questo Metodo è usato dalle funzioni
            - ANALISI E CONTROLLO > D.P.I. >> MANUTENZIONE
            - ANALISI E CONTROLLO > D.P.I. >> SOSTITUZIONE
            - STRUMENTI DI CONTROLLO DEI RISCHI > D.P.I. >> SCHEDE DI INTERVENTO
            - ANAGRAFICHE AZIENDA > GENERALE
            - DOCUMENTI > DOCUMENTI/VERSIONI*
     *   Questa funzione non utilizza il presente metodo, ma contiene il 
         codice necessario alla creazione delle liste dei dipendenti 
         direttamente al suo interno.
     */
    String BuildDipendenteComboBox(IDipendenteHome home, String SELECTED_ID, long newCOD_AZL) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDipendenti_Names_View(newCOD_AZL);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendenti_Names_View dt = (Dipendenti_Names_View) it.next();
            strSEL = "";
            String CurrentRow = dt.MTR_DPD + " " + dt.COG_DPD + " " + dt.NOM_DPD;
            if (SELECTED_ID != "") {
                if ((SELECTED_ID != null) && (SELECTED_ID.equals(CurrentRow))) {
                    strSEL = "selected";
                }
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(dt.MTR_DPD)
                    .append(" ")
                    .append(dt.COG_DPD)
                    .append(" ")
                    .append(dt.NOM_DPD)
                    .append("\">")
                    .append(dt.MTR_DPD)
                    .append(" - ")
                    .append(dt.COG_DPD)
                    .append(" ")
                    .append(dt.NOM_DPD)
                    .append("</option>");
        }
        return str.toString();
    }


    /*questo metodo e' usato dalla funzione
            -INFORTUNI > LISTA INFORTUNI (cantiere)*/

    String BuildDipendenteComboBox1(IDipendenteHome home, long SELECTED_ID, long FILTER_ID,long COD_DTE) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDipendentiByAZLID_View_CAN(FILTER_ID,COD_DTE);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendentiByAZLID_View dt = (DipendentiByAZLID_View) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == dt.COD_DPD) {
                    strSEL = "selected";
                }
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value='")
                    .append(Formatter.format(dt.COD_DPD))
                    .append("'>")
                    .append(Formatter.format(dt.MTR_DPD))
                    .append(" - ")
                    .append(Formatter.format(dt.COG_DPD))
                    .append(" ")
                    .append(Formatter.format(dt.NOM_DPD))
                    .append("</option>");
        }
        return str.toString();
    }



    /* 	Questo Metodo è usato dalle funzioni 
            - DUVRI > CONTRATTI/SERVIZI >> DETTAGLIO COMMITTENTE 
     */
    String BuildDipendenteComboBox_DET_CMT(IDipendenteHome home, long SELECTED_ID, long newCOD_AZL) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDipendenti_Search_View(newCOD_AZL);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendenti_Search_View obj = (Dipendenti_Search_View) it.next();
            strSEL = "";
/*
            if (SELECTED_ID == 0) {
                str.append("<option ").append(strSEL).append(" value=\"").append("\"").append(" valueNOM=\"").append("\">").append("</option>");
            }
            */
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == obj.COD_DPD) {
                    strSEL = "selected ";
                }
            }
            
            str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(Formatter.format(obj.COD_DPD))
                    .append("\"")
                    .append(" valueNOM=\"")
                    .append(Formatter.format(obj.NOM_FUZ_AZL))
                    .append("\">")
                    .append(Formatter.format(obj.MTR_DPD))
                    .append(" - ")
                    .append(Formatter.format(obj.COG_DPD))
                    .append(" ")
                    .append(Formatter.format(obj.NOM_DPD))
                    .append("</option>");
        }
        return str.toString();
    }

    /* 	Questo Metodo è usato dalle funzioni 
            - FORMAZIONE DEL PERSONALE > CORSI >> LISTA CORSI (tab "Docenti Corso")
     */
    String BuildDipendenteComboBox_DCT_COR(IDipendenteHome home, long SELECTED_ID, long FILTER_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDipendenti_Search_View(FILTER_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendenti_Search_View obj = (Dipendenti_Search_View) it.next();
            strSEL = "";
            if (SELECTED_ID == obj.COD_DPD) {
                strSEL = "selected";
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(Formatter.format(obj.COD_DPD))
                    .append("\" value1=\"")
                    .append(Formatter.format(obj.NOM_DPD))
                    .append(" ")
                    .append(Formatter.format(obj.COG_DPD))
                    .append("\">")
                    .append(Formatter.format(obj.MTR_DPD))
                    .append(" - ")
                    .append(Formatter.format(obj.COG_DPD))
                    .append(" ")
                    .append(Formatter.format(obj.NOM_DPD))
                    .append(" - ")
                    .append(Formatter.format(obj.NOM_FUZ_AZL))
                    .append("</option>");
        }
        return str.toString();
    }
%>
