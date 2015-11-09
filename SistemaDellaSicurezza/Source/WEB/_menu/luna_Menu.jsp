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

<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="menu/menuStructure.jsp" %>


<%!
    String isDisabled(String strMenu) throws Exception {
        return Security.userHasPermission(strMenu) ? "" : "disabled";
    }

    String isDisabled2(String strMenu) throws Exception {
        return Security.userHasPermission(strMenu) ? "false" : "true";
    }
%>
<!--Attenzione: Decommentare la riga qui sotto per far sparire il menu originale il relativo tag di chiusura 
  alla fine dei document.write();
-->
<script language="VBScript">
    function FileExists(Fname)
      Set fs = CreateObject("Scripting.FileSystemObject")

      if fs.FileExists(Fname) = False then
        FileExists = -1
      else
        FileExists = 0
      end if
    Set fs = Nothing
    end function
</script>
<script type="text/javascript">
    var specialEdition = <%=ApplicationConfigurator.isSpecialEdition()%>;
    var Separator = " ";
    var splitted;

    document.write("<div style='display:block;'>");
    document.write('<div id="DivMenuLine" onclick="MenuBarOnClick(event)" onresize="MenuBarClose()" class="MenuBar" style="height:28px;">')
    
    document.write('<table border="0" cellspacing="0" cellpadding="0" width="100%">');
    document.write('<tr>');
    
    //---------------------------------------------------------------------------
    //                  Eliminazione logo dal menu                              -
    //---------------------------------------------------------------------------
    //document.write('<td class="MenuBarItem">');
    //document.write('<img src="_images/s2s-piccolo' + (specialEdition ? 'SE' : '') + '.png" width="40px" alt="logo" style="border:none;vertical-align:top;">')
    //document.write('</td>');
    //---------------------------------------------------------------------------
    //                 fine eliminazione logo dal menu                          -
    //---------------------------------------------------------------------------
    //
    //
    //
    //
    //---------------------------------------------------------------------------
    //                  DEFINIZIONE DELLE VOCI DI MENU DI PRIMO LIVELLO         -
    //---------------------------------------------------------------------------

    // GESTIONE                                                -
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=1>&nbsp;&nbsp;' + MenuRoot[0] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');
    
    // ANAGRAFICHE AZIENDA
    splitted = MenuRoot[1].split(Separator)
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=2 <%=isDisabled("STRU_AZIE")%> >&nbsp;&nbsp;' + splitted[0] + '&nbsp;&nbsp;<br>&nbsp;&nbsp;' + splitted[1] + '</span>')
    document.write('</td>');
    
    // MANSIONI
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=3 <%=isDisabled("MANSIONI")%>>&nbsp;&nbsp;' + MenuRoot[2] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');
    
    // MACCHINARI
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=4 <%=isDisabled("MACC_ATTR")%>>&nbsp;&nbsp;' + MenuRoot[3] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');

    // AGENTI CHIMICI
    splitted = MenuRoot[4].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=5 <%=isDisabled("SOST_CHIM")%>>&nbsp;&nbsp;' + splitted[0] + '<br>&nbsp;&nbsp;' + splitted[1] + '&nbsp;&nbsp;</span>')
    document.write('</td>');

    // RISCHI
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=6 <%=isDisabled("RISC")%>>&nbsp;&nbsp;' + MenuRoot[5] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');

    // STRUMENTI DI CONTROLLO DEI RISCHI
    splitted = MenuRoot[6].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=7 <%=isDisabled("STR_CON_RIS")%>>&nbsp;&nbsp;' + splitted[0] + '&nbsp;' + splitted[1] + '&nbsp;' + splitted[2] + '&nbsp;&nbsp;<br>&nbsp;&nbsp;' + splitted[3] + '&nbsp;' + splitted[4] + '</span>')
    document.write('</td>');

    // FORMAZIONE DEL PERSONALE
    splitted = MenuRoot[7].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=8 <%=isDisabled("FORM")%>>&nbsp;&nbsp;' + splitted[0] + '<br>&nbsp;&nbsp;' + splitted[1] + '&nbsp;' + splitted[2] + '&nbsp;&nbsp;</span>')
    document.write('</td>');

    // VERIFICHE SANITARIE
    splitted = MenuRoot[8].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=9 <%=isDisabled("CONT_SANI")%>>&nbsp;&nbsp;' + splitted[0] + '<br>&nbsp;&nbsp;' + splitted[1] + '&nbsp;&nbsp;</span>')
    document.write('</td>');

    // INFORTUNI
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=10 <%=isDisabled("INFO_INCI")%>>&nbsp;&nbsp;' + MenuRoot[9] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');

    // PRESIDI ANTINCENDIO
    splitted = MenuRoot[10].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=11 <%=isDisabled("ANTI")%>>&nbsp;&nbsp;' + splitted[0] + '<br>&nbsp;&nbsp;' + splitted[1] + '&nbsp;&nbsp;</span>')
    document.write('</td>');

    // DOCUMENTI
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=12 <%=isDisabled("DOCU")%>>&nbsp;&nbsp;' + MenuRoot[11] + '&nbsp;&nbsp;<br>&nbsp;</span>')
    document.write('</td>');

    // VERIFICHE S.P.P.
    splitted = MenuRoot[12].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=13 <%=isDisabled("AUDI")%>>&nbsp;&nbsp;' + splitted[0] + '&nbsp;&nbsp;<br>&nbsp;&nbsp;' + splitted[1] + '</span>')
    document.write('</td>');

    // ANALISI E CONTROLLO
    splitted = MenuRoot[13].split(Separator);
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=14 <%=isDisabled("SCAD")%>>&nbsp;&nbsp;' + splitted[0] + '&nbsp;' + splitted[1] + '<br>&nbsp;&nbsp;' + splitted[2] + '&nbsp;&nbsp;</span>')
    document.write('</td>');

    // D.V.R.
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=15 <%=isDisabled("GEST_DOCU_VALU")%>>&nbsp;&nbsp;' + MenuRoot[14] + '<br>&nbsp;&nbsp;</span>')
    document.write('</td>');

    <%
        // D.U.V.R.I.
        if (ApplicationConfigurator.isModuleEnabled(MODULES.DUVRI)) {
            out.println("document.write('<td class=\"MenuBarItem\">')");
            out.println("document.write('<span menu=16 " + isDisabled("DUVRI") + " >&nbsp;&nbsp;'+MenuRoot[15]+'<br>&nbsp;</span>')");
            out.println("document.write('</td>')");
        }
        
        // GESTIONE CANTIERI
        if (ApplicationConfigurator.isModuleEnabled(MODULES.TIT_4)) {
            out.println("document.write('<td class=\"MenuBarItem\">')");
            out.println("document.write('<span menu=17 " + isDisabled("CANTIERI") + " >&nbsp;&nbsp;'+MenuRoot[16]+'<br>&nbsp;</span>')");
            out.println("document.write('</td>')");
        }
        
        // REPORT B.I.
        if (ApplicationConfigurator.isModuleEnabled(MODULES.REPORT_BO)) {
            out.println("document.write('<td class=\"MenuBarItem\">')");
            out.println("document.write('<span menu=18 " + isDisabled("REPORT_BI") + " >&nbsp;&nbsp;'+MenuRoot[17]+'<br>&nbsp;</span>')");
            out.println("document.write('</td>')");
        }
    %>
        
    //---------------------------------------------------------------------------
    //                  Eliminazione HELP dal menu                              -
    //---------------------------------------------------------------------------
    document.write('<td class="MenuBarItem">');
    document.write('<span menu=19>&nbsp;&nbsp;' + MenuRoot[18] + '<br>&nbsp;</span>')
    document.write('</td>');
    //---------------------------------------------------------------------------
    //                  FINE ELIMINAZIONE  HELP dal menu                       -
    //---------------------------------------------------------------------------
    
    document.write('</tr>');
    document.write('</table>');

    document.write("</div>");
    document.write("</div>");

    var MenuBarMenus = new Array()
    var current = null
    var popup


    //---------------------------------------------------------------------------
    //          DEFINIZIONE DELLE VOCI DI MENU DI SECONDO E TERZO LIVELLO       -
    //---------------------------------------------------------------------------
    
    function DocOnLoad() {
        MenuInit();
        
        //-----------------------------------------------------------------------
        //                              GESTIONE                                -
        //-----------------------------------------------------------------------

        // Il dettaglio della  voce di menù "Gestione" è visibile solamente nel
        // caso si acceda al sistema come "Consulente", e non è vincolato al ruolo.
        // A questa regola fa eccezione la sola voce "Opzioni" che invece è sempre visibile,
        // sia che si acceda come "Utente" che come "Consulente". Anch'essa non è
        // sottoposta a ruolo.

        // GESTIONE
        var Consultant = new Menu(0, 0)
    <%if (Security.isConsultant()) {%>
        // LISTA AZIENDE
        Consultant.addItem(new MenuItem(false, SubMenuGestione[0], 'Form_MULTIAZIENDA/MULTIAZIENDA_View.jsp?_Refresh=1'))
        // ACCESSI
        var Acessi_Sistema = new Menu(0, 0);
        // CONSULENTI
        Acessi_Sistema.addItem(new MenuItem(false, SubMenuAccessi[0], 'Form_ANA_COU/ANA_COU_View.jsp?_Refresh=1'))
        // UTENTI
        Acessi_Sistema.addItem(new MenuItem(false, SubMenuAccessi[1], 'Form_ANA_UTN/ANA_UTN_View.jsp?_Refresh=1'))
        // RUOLI
        Acessi_Sistema.addItem(new MenuItem(false, SubMenuAccessi[2], 'Form_ANA_RUO/ANA_RUO_View.jsp?_Refresh=1'))
        Consultant.addItem(new MenuItem(false, SubMenuGestione[1], null, null, Acessi_Sistema))
        Consultant.addItem(new MenuItem(null, null, null, null, null, true));
    <%}%>
        // OPZIONI
        Consultant.addItem(new MenuItem(false, SubMenuGestione[2], 'Form_SDS_OPT/SDS_OPT_View.jsp?_Refresh=1'))
        Consultant.show(true);

        //-----------------------------------------------------------------------
        //                      ANAGRAFICHE AZIENDA                             -
        //-----------------------------------------------------------------------

        // ANAGRAFICHE AZIENDA
        var Struttura = new Menu(0, 0)

        // GENERALE
        Struttura.addItem(new MenuItem(<%=isDisabled2("ANAG_AZIE_LICE")%>, SubMenuAzienda[0], 'Form_ANA_AZL/ANA_AZL_View.jsp?_Refresh=1'))
        // FORNITORI
        Struttura.addItem(new MenuItem(<%=isDisabled2("ANAG_FORN_AZIE")%>, SubMenuAzienda[1], 'Form_ANA_FOR/ANA_FOR_View.jsp?_Refresh=1'))
        // FORNITORI PERSONALE / SERVIZI
        Struttura.addItem(new MenuItem(<%=isDisabled2("ANAG_DITT_ESTE")%>, SubMenuAzienda[2], 'Form_ANA_DTE/ANA_DTE_View.jsp?_Refresh=1'))
    <%
        // TIPOLOGIE CONTRATTUALI
        if (ApplicationConfigurator.isModuleEnabled(MODULES.ANA_TPL_CON)) {
            out.println("Struttura.addItem(new MenuItem(" + isDisabled2("TIPOLOGIE_CONTRATTUALI") + ",SubMenuAzienda[3], 'Form_TPL_CON/TPL_CON_View.jsp?_Refresh=1'))");
        }
    %>
        // LAVORATORI
        Struttura.addItem(new MenuItem(<%=isDisabled2("ANAG_DIPE")%>, SubMenuAzienda[4], 'Form_ANA_DPD/ANA_DPD_View.jsp?_Refresh=1'))
        // SITI
        var Struttura_Strutturale = new Menu(0, 0);
        // SEDI
        Struttura_Strutturale.addItem(new MenuItem(<%=isDisabled2("SITI_AZIE")%>, SubMenuDistribuzioneTerritorialie[0], 'Form_ANA_SIT_AZL/ANA_SIT_AZL_View.jsp?_Refresh=1&lista=dpd'))
    <%
        // IMMOBILI
        if (ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI)) {
            out.println("Struttura_Strutturale.addItem(new MenuItem(" + isDisabled2("IMMOBILI_3_LIVELLI") + ",SubMenuDistribuzioneTerritorialie[2], 'Form_ANA_IMM_3LV/ANA_IMM_3LV_View.jsp?_Refresh=1'))");
        }
    %>
        // LUOGHI FISICI
        Struttura_Strutturale.addItem(new MenuItem(<%=isDisabled2("LUOG_FISI")%>, SubMenuDistribuzioneTerritorialie[1], 'Form_ANA_LUO_FSC/ANA_LUO_FSC_View.jsp?_Refresh=1'))
    <%
        // IMMOBILI
        if (!ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI)) {
            out.println("Struttura_Strutturale.addItem(new MenuItem(" + isDisabled2("ANAG_IMMO") + ",SubMenuDistribuzioneTerritorialie[2], 'Form_ANA_IMO/ANA_IMO_View.jsp?_Refresh=1'))");
        }
    %>
        // ALI
        Struttura_Strutturale.addItem(new MenuItem(<%=isDisabled2("ANAG_ALAA")%>, SubMenuDistribuzioneTerritorialie[3], 'Form_ANA_ALA/ANA_ALA_View.jsp?_Refresh=1'))
        // PIANI
        Struttura_Strutturale.addItem(new MenuItem(<%=isDisabled2("ANAG_PIAN")%>, SubMenuDistribuzioneTerritorialie[4], 'Form_ANA_PNO/ANA_PNO_View.jsp?_Refresh=1'))
        Struttura.addItem(new MenuItem(<%=isDisabled2("STRU_STAT")%>, SubMenuAzienda[5], null, null, Struttura_Strutturale))
        // ORGANIZZAZIONE
        var Struttura_Organizzativa = new Menu(0, 0);
        // TIPOLOGIE UNITA' ORGANIZZATIVE
        Struttura_Organizzativa.addItem(new MenuItem(<%=isDisabled2("TIPO_UNIT_ORGA")%>, SubMenuOrganizzazione[0], 'Form_TPL_UNI_ORG/TPL_UNI_ORG_View.jsp?_Refresh=1'))
        // GESTIONE UNITA' ORGANIZZATIVE
        Struttura_Organizzativa.addItem(new MenuItem(<%=isDisabled2("UNIT_ORGA")%>, SubMenuOrganizzazione[1], 'Form_ANA_UNI_ORG/ANA_UNI_ORG_View.jsp?_Refresh=1'))
        // RUOLI AZIENDALI
        Struttura_Organizzativa.addItem(new MenuItem(<%=isDisabled2("ANAG_FUNZ_AZIE")%>, SubMenuOrganizzazione[2], 'Form_ANA_FUZ_AZL/ANA_FUZ_AZL_View.jsp?_Refresh=1'))
    <%
        // RUOLI PER LA SICUREZZA
        if (ApplicationConfigurator.isModuleEnabled(MODULES.ANA_RUO_SIC)) {
            out.println("Struttura_Organizzativa.addItem(new MenuItem(" + isDisabled2("RUOLI_SICUREZZA") + ",SubMenuOrganizzazione[3], 'Form_ANA_RUO_SIC/ANA_RUO_SIC_View.jsp?_Refresh=1'))");
        }
    %>
        // UNITA' DI SICUREZZA
        Struttura_Organizzativa.addItem(new MenuItem(<%=isDisabled2("UNIT_SICU")%>, SubMenuOrganizzazione[4], 'Form_ANA_UNI_SIC/ANA_UNI_SIC_View.jsp?_Refresh=1'))
        Struttura.addItem(new MenuItem(<%=isDisabled2("STRU_DINA")%>, SubMenuAzienda[6], null, null, Struttura_Organizzativa))
        Struttura.show(true);

        //-----------------------------------------------------------------------
        //                              MANSIONI                                -
        //-----------------------------------------------------------------------

        // MANSIONI
        var Attivita = new Menu(0, 0)
        // ATTIVITA' LAVORATIVE
        Attivita.addItem(new MenuItem(<%=isDisabled2("ATTI_LAVO")%>, SubMenuAttivitaLavorative[0], 'Form_ANA_MAN/ANA_MAN_View.jsp?_Refresh=1'))
        // OPERAZIONI SVOLTE
        Attivita.addItem(new MenuItem(<%=isDisabled2("OPER_SVOL")%>, SubMenuAttivitaLavorative[1], 'Form_ANA_OPE_SVO/ANA_OPE_SVO_View.jsp?_Refresh=1'))
    <%
        if (ApplicationConfigurator.isModuleEnabled(MODULES.ASSOC_SAP_S2S)) {
            if (Security.isConsultant()) {
                // ASSOCIAZIONE SAP / S2S
                out.println("Attivita.addItem(new MenuItem(" + isDisabled2("ASS_MAN_SAP_S2S") + ",SubMenuAttivitaLavorative[2], 'Form_ASS_MAN_SAP_S2S/ASS_MAN_SAP_S2S_View.jsp?_Refresh=1'))");
            }
        }
    %>
        Attivita.show(true);

        //-----------------------------------------------------------------------
        //                              MACCHINARI                              -
        //-----------------------------------------------------------------------

        // MACCHINARI
        var Macchinari = new Menu(0, 0)
        // TIPOLOGIE MACCHINE / ATTREZZATURE
        Macchinari.addItem(new MenuItem(<%=isDisabled2("TIPO_MACC_ATTR")%>, SubMenuMacchinari[0], 'Form_TPL_MAC/TPL_MAC_View.jsp?_Refresh=1'))
        // MACCHINE
        Macchinari.addItem(new MenuItem(<%=isDisabled2("ANAG_MACC_ATTR")%>, SubMenuMacchinari[1], 'Form_ANA_MAC/ANA_MAC_View.jsp?_Refresh=1'))
        // MANUTENZIONE / SOSTITUZIONE
        Macchinari.addItem(new MenuItem(<%=isDisabled2("SCHE_INTE")%>, SubMenuMacchinari[2], 'Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_View.jsp?_Refresh=1'))
        Macchinari.show(true);

        //-----------------------------------------------------------------------
        //                              AGENTI CHIMICI                          -
        //-----------------------------------------------------------------------

        // AGENTI CHIMICI
        var AgentiChimici = new Menu(0, 0);
        // FRASI R
        AgentiChimici.addItem(new MenuItem(<%=isDisabled2("SOST_CHIM_FRASI_R")%>, SubMenuAgentiChimici[0], 'Form_ANA_FRS_R/ANA_FRS_R_View.jsp?_Refresh=1'))
        // FRASI S
        AgentiChimici.addItem(new MenuItem(<%=isDisabled2("SOST_CHIM_FRASI_S")%>, SubMenuAgentiChimici[1], 'Form_ANA_FRS_S/ANA_FRS_S_View.jsp?_Refresh=1'))
        // CLASSIFICAZIONE
        AgentiChimici.addItem(new MenuItem(<%=isDisabled2("CLAS_SOST_CHIM")%>, SubMenuAgentiChimici[2], 'Form_ANA_CLF_SOS/ANA_CLF_SOS_View.jsp?_Refresh=1'))
        // CARATTERISTICHE CHIMICO / FISICHE
        AgentiChimici.addItem(new MenuItem(<%=isDisabled2("ANAG_SOST_CHIM")%>, SubMenuAgentiChimici[3], 'Form_ANA_SOS_CHI/ANA_SOS_CHI_View.jsp?_Refresh=1'))
        AgentiChimici.show(true);

        //-----------------------------------------------------------------------
        //                                  RISCHI                              -
        //-----------------------------------------------------------------------

        // RISCHI
        var Rischio = new Menu(0, 0);
        // CATEGORIE FATTORI DI RISCHIO
        Rischio.addItem(new MenuItem(<%=isDisabled2("CATE_FATT_RISC")%>, SubMenuRischi[0], 'Form_CAG_FAT_RSO/CAG_FAT_RSO_View.jsp?_Refresh=1'))
        // FATTORI DI RISCHIO
        Rischio.addItem(new MenuItem(<%=isDisabled2("FATT_RISC")%>, SubMenuRischi[1], 'Form_ANA_FAT_RSO/ANA_FAT_RSO_View.jsp?_Refresh=1'))
        // RISCHI
        Rischio.addItem(new MenuItem(<%=isDisabled2("ANAG_RISC")%>, SubMenuRischi[2], 'Form_ANA_RSO/ANA_RSO_View.jsp?_Refresh=1'))
        Rischio.show(true);

        //-----------------------------------------------------------------------
        //                  STRUMENTI DI CONTROLLO DEI RISCHI                   -
        //-----------------------------------------------------------------------

        // STRUMENTI DI CONTROLLO DEI RISCHI
        var ContrRis = new Menu(0, 0);
        // MISURE DI PREVENZIONE E PROTEZIONE
        ContrRis.addItem(new MenuItem(<%=isDisabled2("GEST_MISU_PREV")%>, SubMenuStrumenti[0], 'Form_ANA_MIS_PET/ANA_MIS_PET_View.jsp?_Refresh=1'))
        // PERIZIE
        ContrRis.addItem(new MenuItem(<%=isDisabled2("GEST_MISU_PREV_AZIE")%>, SubMenuStrumenti[1], 'Form_ANA_MIS_PET_AZL/ANA_MIS_PET_AZL_View.jsp'));
        // D.P.I.
        var ContrDPI = new Menu(0, 0);
        // TIPOLOGIE
        ContrDPI.addItem(new MenuItem(<%=isDisabled2("TIPO_DPII")%>, SubMenuDPI[0], 'Form_TPL_DPI/TPL_DPI_View.jsp?_Refresh=1'))
        // LOTTI
        ContrDPI.addItem(new MenuItem(<%=isDisabled2("GEST_LOTT_DPII")%>, SubMenuDPI[1], 'Form_ANA_LOT_DPI/ANA_LOT_DPI_View.jsp?_Refresh=1'))
        // SCHEDE DI INTERVENTO
        ContrDPI.addItem(new MenuItem(<%=isDisabled2("SCHE_INTE_DISP")%>, SubMenuDPI[2], 'Form_SCH_INR_DPI/SCH_INR_DPI_View.jsp?_Refresh=1'))
        ContrRis.addItem(new MenuItem(<%=isDisabled2("DISP_PROT")%>, SubMenuStrumenti[2], null, null, ContrDPI))
        ContrRis.show(true);

        //-----------------------------------------------------------------------
        //                      FORMAZIONE DEL PERSONALE                        -
        //-----------------------------------------------------------------------

        // FORMAZIONE DEL PERSONALE
        var Formazione = new Menu(0, 0)
        // CORSI
        var Formazione_Corsi = new Menu(0, 0);
        // TIPOLOGIA
        Formazione_Corsi.addItem(new MenuItem(<%=isDisabled2("TIPO_CORS")%>, SubMenuCorsi[0], 'Form_TPL_COR/TPL_COR_View.jsp?_Refresh=1'))
        // LISTA CORSI
        Formazione_Corsi.addItem(new MenuItem(<%=isDisabled2("ANAG_CORS")%>, SubMenuCorsi[1], 'Form_ANA_COR/ANA_COR_View.jsp?_Refresh=1'))
        // EROGAZIONE
        Formazione_Corsi.addItem(new MenuItem(<%=isDisabled2("EROG_CORS")%>, SubMenuCorsi[2], 'Form_SCH_EGZ_COR/SCH_EGZ_COR_View.jsp?_Refresh=1'))
        Formazione.addItem(new MenuItem(<%=isDisabled2("CORS")%>, SubMenuFormazione[0], null, null, Formazione_Corsi))
        // TEST DI VERIFICA
        var Formazione_Test = new Menu(0, 0);
        // LISTA TEST DI VERIFICA
        Formazione_Test.addItem(new MenuItem(<%=isDisabled2("ANAG_TEST_VERI")%>, SubMenuTestVerifica[0], 'Form_ANA_TES_VRF/ANA_TES_VRF_View.jsp?_Refresh=1'))
        // DOMANDE
        Formazione_Test.addItem(new MenuItem(<%=isDisabled2("ANAG_DOMA")%>, SubMenuTestVerifica[1], 'Form_ANA_DMD/ANA_DMD_View.jsp?_Refresh=1'))
        // RISPOSTE
        Formazione_Test.addItem(new MenuItem(<%=isDisabled2("ANAG_RISP")%>, SubMenuTestVerifica[2], 'Form_ANA_RST/ANA_RST_View.jsp?_Refresh=1'))
        Formazione.addItem(new MenuItem(<%=isDisabled2("TEST_VERI")%>, SubMenuFormazione[1], null, null, Formazione_Test))
        // PERCORSI FORMATIVI
        Formazione.addItem(new MenuItem(<%=isDisabled2("GEST_PERC_FORM")%>, SubMenuFormazione[2], 'Form_ANA_PCS_FRM/ANA_PCS_FRM_View.jsp?_Refresh=1'))
        // DEBITI FORMATIVI
        Formazione.addItem(new MenuItem(<%=isDisabled2("SCH_DBT_FRM")%>, SubMenuFormazione[3], 'Form_SCH_DBT_FRM/SCH_DBT_FRM_View.jsp?_Refresh=1'))
        Formazione.show(true);

        //-----------------------------------------------------------------------
        //                          VERIFICHE SANITARIE                         -
        //-----------------------------------------------------------------------

        // VERIFICHE SANITARIE
        var Controllo_Sanitario = new Menu(0, 0)
        // VISITE MEDICHE
        Controllo_Sanitario.addItem(new MenuItem(<%=isDisabled2("GEST_VISI_MEDI_PRED")%>, SubMenuVerificheSanitarie[0], 'Form_ANA_VST_MED/ANA_VST_MED_View.jsp?_Refresh=1'))
        // VISITE DI IDONEITA'
        Controllo_Sanitario.addItem(new MenuItem(<%=isDisabled2("GEST_VISI_IDON_PRED")%>, SubMenuVerificheSanitarie[1], 'Form_ANA_VST_IDO/ANA_VST_IDO_View.jsp?_Refresh=1'))
        // CARTELLE CLINICHE
        Controllo_Sanitario.addItem(new MenuItem(<%=isDisabled2("GEST_CART_SANI")%>, SubMenuVerificheSanitarie[2], 'Form_ANA_CTL_SAN/ANA_CTL_SAN_View.jsp?_Refresh=1'))
        // PROTOCOLLI
        Controllo_Sanitario.addItem(new MenuItem(<%=isDisabled2("GEST_PROT_SANI_LAVO")%>, SubMenuVerificheSanitarie[3], 'Form_ANA_PRO_SAN/ANA_PRO_SAN_View.jsp?_Refresh=1'))
        Controllo_Sanitario.show(true);

        //-----------------------------------------------------------------------
        //                              INFORTUNI                               -
        //-----------------------------------------------------------------------

        // INFORTUNI
        var Infortuni_Incidenti = new Menu(0, 0)
        // SEDI LESIONI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("ANAG_SEDE_LESI")%>, SubMenuInfortuni[0], 'Form_ANA_SED_LES/ANA_SED_LES_View.jsp?_Refresh=1'))
        // NATURA LESIONI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("ANAG_NATU_LESI")%>, SubMenuInfortuni[1], 'Form_ANA_NAT_LES/ANA_NAT_LES_View.jsp?_Refresh=1'))
        // CATEGORIE AGENTI MATERIALI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("CATE_AGEN_MATE")%>, SubMenuInfortuni[2], 'Form_CAG_AGE_MAT/CAG_AGE_MAT_View.jsp?_Refresh=1'))
        // AGENTI MATERIALI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("ANAG_AGEN_MATE")%>, SubMenuInfortuni[3], 'Form_ANA_AGE_MAT/ANA_AGE_MAT_View.jsp?_Refresh=1'))
        // FORME DI INFORTUNIO
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("TIPO_FORM_INFO")%>, SubMenuInfortuni[4], 'Form_TPL_FRM_INO/TPL_FRM_INO_View.jsp?_Refresh=1'))
        // ACCERTAMENTI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("TIPO_ACCE")%>, SubMenuInfortuni[5], 'Form_TPL_INO/TPL_INO_View.jsp?_Refresh=1'))
        // LISTA INFORTUNI
        Infortuni_Incidenti.addItem(new MenuItem(<%=isDisabled2("GEST_INFO_INCI")%>, SubMenuInfortuni[6], 'Form_ANA_INO/ANA_INO_View.jsp?_Refresh=1'))
        Infortuni_Incidenti.show(true);

        //-----------------------------------------------------------------------
        //                      PRESIDI ANTINCENDIO                             -
        //-----------------------------------------------------------------------

        // PRESIDI ANTINCENDIO
        var Anticendio = new Menu(0, 0)
        // CATEGORIE
        Anticendio.addItem(new MenuItem(<%=isDisabled2("CATE_PRES")%>, SubMenuPresidi[0], 'Form_CAG_PSD_ACD/CAG_PSD_ACD_View.jsp?_Refresh=1'))
        // PRESIDI
        Anticendio.addItem(new MenuItem(<%=isDisabled2("ANAG_PRES")%>, SubMenuPresidi[1], 'Form_ANA_PSD_ACD/ANA_PSD_ACD_View.jsp?_Refresh=1'))
        // SCHEDE DI INTERVENTO
        Anticendio.addItem(new MenuItem(<%=isDisabled2("SCHE_INTE_ANTI")%>, SubMenuPresidi[2], 'Form_SCH_INR_PSD/SCH_INR_PSD_View.jsp?_Refresh=1'))
        Anticendio.show(true);

        //-----------------------------------------------------------------------
        //                              DOCUMENTI                               -
        //-----------------------------------------------------------------------

        // DOCUMENTI
        var Documentazione = new Menu(0, 0)
        // TIPOLOGIE
        Documentazione.addItem(new MenuItem(<%=isDisabled2("TIPO_DOCU")%>, SubMenuDocumenti[0], 'Form_TPL_DOC/TPL_DOC_View.jsp?_Refresh=1'))
        // CATEGORIE
        Documentazione.addItem(new MenuItem(<%=isDisabled2("CATE_DOCU")%>, SubMenuDocumenti[1], 'Form_CAG_DOC/CAG_DOC_View.jsp?_Refresh=1'))
        // DOCUMENTI / VERSIONI
        Documentazione.addItem(new MenuItem(<%=isDisabled2("ANAG_DOCU_VERS")%>, SubMenuDocumenti[2], 'Form_ANA_DOC/ANA_DOC_View.jsp?_Refresh=1'))
        // NORMATIVE
        var NormativeSentenze = new Menu(0, 0);
        // SETTORI
        NormativeSentenze.addItem(new MenuItem(<%=isDisabled2("ANAG_SETT")%>, SubMenuNormative[0], 'Form_ANA_SET/ANA_SET_View.jsp?_Refresh=1'))
        // SOTTOSETTORI
        NormativeSentenze.addItem(new MenuItem(<%=isDisabled2("ANAG_SOTT_SETT")%>, SubMenuNormative[1], 'Form_ANA_SOT_SET/ANA_SOT_SET_View.jsp?_Refresh=1'))
        // ORGANI
        NormativeSentenze.addItem(new MenuItem(<%=isDisabled2("ANAG_ORGA")%>, SubMenuNormative[2], 'Form_ANA_ORN/ANA_ORN_View.jsp?_Refresh=1'))
        // TIPOLOGIE
        NormativeSentenze.addItem(new MenuItem(<%=isDisabled2("GEST_TIPO")%>, SubMenuNormative[3], 'Form_TPL_NOR_SEN/TPL_NOR_SEN_View.jsp?_Refresh=1'))
        // NORME / SENTENZE
        NormativeSentenze.addItem(new MenuItem(<%=isDisabled2("GEST_NORM_SENT")%>, SubMenuNormative[4], 'Form_ANA_NOR_SEN/ANA_NOR_SEN_View.jsp?_Refresh=1'))
        Documentazione.addItem(new MenuItem(<%=isDisabled2("NORM_SENT")%>, SubMenuDocumenti[3], null, null, NormativeSentenze))
        Documentazione.show(true);

        //-----------------------------------------------------------------------
        //                          VERIFICHE S.P.P.                            -
        //-----------------------------------------------------------------------

        // VERIFICHE S.P.P.
        var Audit = new Menu(0, 0)
        // AUDIT
        Audit.addItem(new MenuItem(<%=isDisabled2("ANAG_INTE")%>, SubMenuVerificheSPP[0], 'Form_ANA_INR_ADT/ANA_INR_ADT_View.jsp?_Refresh=1'))
        // NON CONFORMITA'
        Audit.addItem(new MenuItem(<%=isDisabled2("GEST_CONF")%>, SubMenuVerificheSPP[1], 'Form_ANA_NON_CFO/ANA_NON_CFO_View.jsp?_Refresh=1'))
        // SEGNALAZIONI
        Audit.addItem(new MenuItem(<%=isDisabled2("GEST_RAPP_SEGN")%>, SubMenuVerificheSPP[2], 'Form_ANA_SGZ/ANA_SGZ_View.jsp?_Refresh=1'))
        // R.A.C. / R.A.P.
        Audit.addItem(new MenuItem(<%=isDisabled2("GEST_MODU_AZIO_CORR_PREV")%>, SubMenuVerificheSPP[3], 'Form_AZN_CRR_PET/AZN_CRR_PET_View.jsp?_Refresh=1'))
        // A.C. / A.P.
        Audit.addItem(new MenuItem(<%=isDisabled2("GEST_MODU_RICH_CORR_PREV")%>, SubMenuVerificheSPP[4], 'Form_GEST_AZN_CRR_PET/GEST_AZN_CRR_PET_View.jsp?_Refresh=1'))
        Audit.show(true);

        //-----------------------------------------------------------------------
        //                      ANALISI E CONTROLLO                             -
        //-----------------------------------------------------------------------

        // ANALISI E CONTROLLO
        var Scadenzari = new Menu(0, 0)
        // VERIFICHE SANITARIE
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("VISI_MEDI_IDON")%>, SubMenuAnalisiControllo[0], 'Form_SCH_VST/SCH_VST_View.jsp?_Refresh=1'))
        // MISURE DI PREVENZIONE E PROTEZIONE
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("INTE_MISU_PREV")%>, SubMenuAnalisiControllo[1], 'Form_SCH_MIS_PET/SCH_MIS_PET_View.jsp?_Refresh=1'))
        // PERIZIE
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("PERIZIE")%>, SubMenuAnalisiControllo[2], 'Form_SCH_MIS_PET_AZL/SCH_MIS_PET_AZL_View.jsp?_Refresh=1'))
        // AUDIT
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("INTE_AUDI")%>, SubMenuAnalisiControllo[3], 'Form_SCH_INR_ADT/SCH_INR_ADT_View.jsp?_Refresh=1'))
        // FORMAZIONE DEL PERSONALE
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("CORS_FORM")%>, SubMenuAnalisiControllo[4], 'Form_SCH_COR/SCH_COR_View.jsp?_Refresh=1'))
        // DOCUMENTI
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("DOC_VERSI")%>, SubMenuAnalisiControllo[5], 'Form_SCH_DOC/SCH_DOC_View.jsp?_Refresh=1'))
        // RISCHI
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("RIVALUTAZIONE_RISCHI")%>, SubMenuAnalisiControllo[6], 'Form_SCH_RIV_RSO/SCH_RIV_RSO_View.jsp?_Refresh=1'))
        // SEGNALAZIONI
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("SEGNALAZIONE_DI_AUDIT")%>, SubMenuAnalisiControllo[7], 'Form_SCH_ADT/SCH_ADT_View.jsp?_Refresh=1'))
        Scadenzari.addItem(new MenuItem(null, null, null, null, null, true))
        // PRESIDI ANTINCENDIO
        var Manutenzione = new Menu(0, 0);
        // MANUTENZIONE
        Manutenzione.addItem(new MenuItem(<%=isDisabled2("PRES_ANTI_MANU")%>, SubMenuPresidiAntincendio[0], 'Form_SCH_PSD_ACD/SCH_PSD_ACD_View.jsp?_Refresh=1&SCH_PSD_ACD=M'))
        // SOSTITUZIONE
        Manutenzione.addItem(new MenuItem(<%=isDisabled2("PRES_ANTI_SOST")%>, SubMenuPresidiAntincendio[1], 'Form_SCH_PSD_ACD/SCH_PSD_ACD_View.jsp?_Refresh=1&SCH_PSD_ACD=S'))
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("MAN_SOS_PRES_ANTI")%>, SubMenuAnalisiControllo[8], null, null, Manutenzione))
        // MACCHINARI
        var ManutenzioneMacchinari = new Menu(0, 0);
        // MANUTENZIONE
        ManutenzioneMacchinari.addItem(new MenuItem(<%=isDisabled2("MACC_ATTR_MANU")%>, SubMenuMacchinari2[0], 'Form_SCH_MAC/SCH_MAC_View.jsp?_Refresh=1&FROM=MAN'))
        // SOSTITUZIONE
        ManutenzioneMacchinari.addItem(new MenuItem(<%=isDisabled2("MACC_ATTR_SOST")%>, SubMenuMacchinari2[1], 'Form_SCH_MAC/SCH_MAC_View.jsp?_Refresh=1&FROM=SOS'))
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("MAN_SOS_MACC_ATTR")%>, SubMenuAnalisiControllo[9], null, null, ManutenzioneMacchinari))
        // D.P.I.
        var ManutenzioneDPI = new Menu(0, 0);
        // MANUTENZIONE
        ManutenzioneDPI.addItem(new MenuItem(<%=isDisabled2("DPII_MANU")%>, SubMenuDPI2[0], 'Form_SCH_DPI/SCH_DPI_View.jsp?_Refresh=1&FROM=M'))
        // SOSTITUZIONE
        ManutenzioneDPI.addItem(new MenuItem(<%=isDisabled2("DPII_SOST")%>, SubMenuDPI2[1], 'Form_SCH_DPI/SCH_DPI_View.jsp?_Refresh=1&FROM=S'))
        Scadenzari.addItem(new MenuItem(<%=isDisabled2("MAN_SOS_DPI")%>, SubMenuAnalisiControllo[10], null, null, ManutenzioneDPI))
        Scadenzari.show(true);

        //-----------------------------------------------------------------------
        //                              D.V.R.                                  -
        //-----------------------------------------------------------------------

        // D.V.R.
        var DVR = new Menu(0, 0)
        // SEZIONI
        DVR.addItem(new MenuItem(<%=isDisabled2("GEST_SEZI")%>, SubMenuDVR[0], 'Form_ANA_ARE/ANA_ARE_View.jsp?_Refresh=1'))
        // CAPITOLI
        DVR.addItem(new MenuItem(<%=isDisabled2("GEST_CAPI")%>, SubMenuDVR[1], 'Form_ANA_CPL/ANA_CPL_View.jsp?_Refresh=1'))
        // PARAGRAFI
        DVR.addItem(new MenuItem(<%=isDisabled2("GEST_PARA")%>, SubMenuDVR[2], 'Form_ANA_PRG/ANA_PRG_View.jsp?_Refresh=1'))
        // DOCUMENTI DI VALUTAZIONE DEI RISCHI
        DVR.addItem(new MenuItem(<%=isDisabled2("ANAG_DOCU_VALU")%>, SubMenuDVR[3], 'Form_ANA_DOC_VLU/ANA_DOC_VLU_View.jsp?_Refresh=1&MENU=1'))
        DVR.show(true);

        //-----------------------------------------------------------------------
        //                              D.U.V.R.I.                              -
        //-----------------------------------------------------------------------

        // D.U.V.R.I.
        var DUVRI = new Menu(0, 0)
        // CONTRATTI / SERVIZI
        var DUVRI_ContrattiServizi = new Menu(0, 0);
        // ANAGRAFICA
        DUVRI_ContrattiServizi.addItem(new MenuItem(<%=isDisabled2("ANAG_CONTR_SERV")%>, SubMenuContrattiServizi[0], 'Form_ANA_CON_SER/ANA_CON_SER_View.jsp?_Refresh=1'))
        // DETTAGLIO COMMITTENTE
        DUVRI_ContrattiServizi.addItem(new MenuItem(<%=isDisabled2("DETT_COMMIT")%>, SubMenuContrattiServizi[1], 'Form_DET_CMT/DET_CMT_View.jsp?_Refresh=1'))
        // DETTAGLIO APPALTATRICE
        DUVRI_ContrattiServizi.addItem(new MenuItem(<%=isDisabled2("DETT_APPALT")%>, SubMenuContrattiServizi[2], 'Form_DET_APL/DET_APL_View.jsp?_Refresh=1'))
        // DETTAGLIO SUBAPPALTATRICI
        DUVRI_ContrattiServizi.addItem(new MenuItem(<%=isDisabled2("CONTR_SERV_SUB_APPALT")%>, SubMenuContrattiServizi[3], 'Form_CON_SER_SUB_APP/CON_SER_SUB_APP_View.jsp?_Refresh=1'))
        DUVRI.addItem(new MenuItem(<%=isDisabled2("CONTR_SERV")%>, SubMenuDUVRI[0], null, null, DUVRI_ContrattiServizi))
        // STAMPA
        DUVRI.addItem(new MenuItem(<%=isDisabled2("STAMPA_DUVRI")%>, SubMenuDUVRI[1], 'Form_STP_DUVRI/STP_DUVRI_View.jsp?_Refresh=1'))
        DUVRI.show(true);

        //-----------------------------------------------------------------------
        //                              GESTIONE CANTIERI                                    -
        //-----------------------------------------------------------------------

        // GESTIONE CANTIERI
        var Gestionecantieri = new Menu(0, 0);

        // ANAGRAFICA GENERALE
        var AnagraficaGenerale = new Menu(0, 0);
        // PROCEDIMENTO
        AnagraficaGenerale.addItem(new MenuItem(<%=isDisabled2("CANTIERI_ANAGR_PROCEDIMENTO")%>, SubMenuAnagraficagenerale[0], 'Form_ANA_PRO/ANA_PRO_View.jsp?_Refresh=1'));
        // CANTIERI
        AnagraficaGenerale.addItem(new MenuItem(<%=isDisabled2("CANTIERI_ANAGR_CANTIERI")%>, SubMenuAnagraficagenerale[1], 'Form_ANA_CAN/ANA_CAN_View.jsp?_Refresh=1'));
        // OPERE
        AnagraficaGenerale.addItem(new MenuItem(<%=isDisabled2("CANTIERI_ANAGR_OPERE")%>, SubMenuAnagraficagenerale[2], 'Form_ANA_OPE/ANA_OPE_View.jsp?_Refresh=1'));
        // ANAGRAFICA ATTIVITA'
        AnagraficaGenerale.addItem(new MenuItem(<%=isDisabled2("CANTIERI_ANAGR_ATTIVITA")%>, SubMenuAnagraficagenerale[3], 'Form_ANA_ATT/ANA_ATT_View.jsp?_Refresh=1'));
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_ANAGR")%>, SubMenuGestionecantieri[0], null, null, AnagraficaGenerale));
        Gestionecantieri.addItem(new MenuItem(null, null, null, null, null, true));

        // RISCHI CANTIERE
        var RischiCantiere = new Menu(0, 0);
        // FATTORE RISCHIO
        RischiCantiere.addItem(new MenuItem(<%=isDisabled2("CANTIERI_RISCHI_FATTORI")%>, SubMenuRischiCantiere[0], 'Form_ANA_FAT_RSO_CAN/ANA_FAT_RSO_CAN_View.jsp?_Refresh=1'));
        // RISCHIO
        RischiCantiere.addItem(new MenuItem(<%=isDisabled2("CANTIERI_RISCHI_RISCHI")%>, SubMenuRischiCantiere[1], 'Form_ANA_RSO_CAN/ANA_RSO_CAN_View.jsp?_Refresh=1'));
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_RISCHI")%>, SubMenuGestionecantieri[1], null, null, RischiCantiere));

        // DOCUMENTI AREA SICUREZZA
        var DocumentiAreaSicurezza = new Menu(0, 0);
        // TIPOLOGIA
        DocumentiAreaSicurezza.addItem(new MenuItem(<%=isDisabled2("CANTIERI_DOCUMENTI_TIPOLOGIA")%>, SubMenuDocumentiAreaSicurezza[0], 'Form_TPL_DOC_CAN/TPL_DOC_CAN_View.jsp?_Refresh=1'));
        // DOCUMENTO
        DocumentiAreaSicurezza.addItem(new MenuItem(<%=isDisabled2("CANTIERI_DOCUMENTI_DOCUMENTO")%>, SubMenuDocumentiAreaSicurezza[1], 'Form_ANA_DOC_GES_CAN/ANA_DOC_GES_CAN_View.jsp?_Refresh=1'));
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_DOCUMENTI")%>, SubMenuGestionecantieri[2], null, null, DocumentiAreaSicurezza));
        Gestionecantieri.addItem(new MenuItem(null, null, null, null, null, true));

        // PSC
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_PSC")%>, SubMenuGestionecantieri[3], 'Form_ANA_PSC/ANA_PSC_View.jsp?_Refresh=1'));
        // REGISTRO POS
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_POS")%>, SubMenuGestionecantieri[4], 'Form_GEST_POS/GEST_POS_View.jsp?_Refresh=1'));

        // SOPRALLUOGHI
        var Sopralluoghi = new Menu(0, 0);
        // ANAGRAFICA CONSTATAZIONI
        Sopralluoghi.addItem(new MenuItem(<%=isDisabled2("CANTIERI_SOP_CONSTATAZIONI")%>, SubMenuSopralluoghi[0], 'Form_ANA_CST/ANA_CST_View.jsp?_Refresh=1'));
        // ANAGRAFICA DISPOSIZIONI
        Sopralluoghi.addItem(new MenuItem(<%=isDisabled2("CANTIERI_SOP_DISPOSIZIONI")%>, SubMenuSopralluoghi[1], 'Form_ANA_DSP/ANA_DSP_View.jsp?_Refresh=1'));
        // PIANIFICAZIONE
        // Sopralluoghi.addItem(new MenuItem(true,SubMenuSopralluoghi[2], ''));
        // RAPPORTI DI SOPRALLUOGO
        Sopralluoghi.addItem(new MenuItem(<%=isDisabled2("CANTIERI_SOP_RAPPORTI")%>, SubMenuSopralluoghi[3], 'Form_ANA_SOP/ANA_SOP_View.jsp?_Refresh=1'));
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_SOP")%>, SubMenuGestionecantieri[5], null, null, Sopralluoghi));
        Gestionecantieri.addItem(new MenuItem(null, null, null, null, null, true));

        // INFORTUNI CANTIERE
        var InfortuniCantiere = new Menu(0, 0);
        // SEDI LESIONI
        InfortuniCantiere.addItem(new MenuItem(<%=isDisabled2("CANTIERI_INFORTUNI_SEDI")%>, SubMenuInfortuniCantiere[0], 'Form_ANA_SED_LES_CAN/ANA_SED_LES_CAN_View.jsp?_Refresh=1'));
        // FORME DI INFORTUNIO
        InfortuniCantiere.addItem(new MenuItem(<%=isDisabled2("CANTIERI_INFORTUNI_FORME")%>, SubMenuInfortuniCantiere[1], 'Form_CAU_INF_CAN/CAU_INF_CAN_View.jsp?_Refresh=1'));
        // LISTA INFORTUNI
        InfortuniCantiere.addItem(new MenuItem(<%=isDisabled2("CANTIERI_INFORTUNI_LISTA")%>, SubMenuInfortuniCantiere[2], 'Form_ANA_INO_CAN/ANA_INO_CAN_View.jsp?_Refresh=1'));
        Gestionecantieri.addItem(new MenuItem(<%=isDisabled2("CANTIERI_INFORTUNI")%>, SubMenuGestionecantieri[6], null, null, InfortuniCantiere));

        //-----------------------------------------------------------------------
        //                          REPORT B.I.                                 -
        //-----------------------------------------------------------------------

        // REPORT B.I.
        var ReportBI = new Menu(0, 0);
        // AVVIA
        ReportBI.addItem(new MenuItem(<%=isDisabled2("REPORT_BI_AVVIA")%>, SubMenuReportBI[0], function() {
            // Verifica che sia valorizzata l'opzione relativa al percorso eseguibile di firefox
            // e che tale percorso esista effettivamento sul disco locale.
            eseguiChiamataAjax('Form_SDS_OPT/getFOX_PTH.jsp', document.getElementById("workAjaxArea"), false);
            var FOX_PTH_value = document.getElementById("getFOX_PTH").value;
            if (FOX_PTH_value != ""){
                if (FileExists(FOX_PTH_value)==0){
                    // Lancia firefox per BO.
                    g_openReportLink(FOX_PTH_value, '<%=ApplicationConfigurator.BI_SERVER_ADDRESS%>');
                } else {
                    // Il percorso di firefox configurato nelle opzioni utente non è
                    // presente sul disco locale.
                    alert(arraylng["MSG_0222"]);
                }
            } else {
                // Il percorso di firefox non è stato configurato nelle opzioni utente.
                alert(arraylng["MSG_0221"]);
            }
        }));
        ReportBI.addItem(new MenuItem(null, null, null, null, null, true));
        // DOCUMENTAZIONE
        ReportBI.addItem(new MenuItem(<%=isDisabled2("REPORT_BI_DOC")%>, SubMenuReportBI[1],
                function() {
                    g_openReportDocLink('<%=ApplicationConfigurator.getApplicationURI()%>' + 'WEB/doc/Sistema_di_reportistica.pdf')
                }));
        ReportBI.show(true);

        //-----------------------------------------------------------------------
        //                              HELP          
        //                              forse va tolto anche questo                          -
        //-----------------------------------------------------------------------

        // HELP
        var Help = new Menu(0, 0);
        // HELP GENERALE
        Help.addItem(new MenuItem(false, SubMenuHelp[0], function() {
            g_openHelpWindow('Form_HELP/HELP.jsp')
        }));
        Help.addItem(new MenuItem(null, null, null, null, null, true));
        // ABOUT
        Help.addItem(new MenuItem(false, SubMenuHelp[1], function() {
            g_openAboutWindow('Form_ABOUT/ABOUT.jsp')
        }));
        Help.show(true);

        MenuBarMenus[1] = Consultant;
        MenuBarMenus[2] = Struttura;
        MenuBarMenus[3] = Attivita;
        MenuBarMenus[4] = Macchinari;
        MenuBarMenus[5] = AgentiChimici;
        MenuBarMenus[6] = Rischio;
        MenuBarMenus[7] = ContrRis;
        MenuBarMenus[8] = Formazione;
        MenuBarMenus[9] = Controllo_Sanitario;
        MenuBarMenus[10] = Infortuni_Incidenti;
        MenuBarMenus[11] = Anticendio;
        MenuBarMenus[12] = Documentazione;
        MenuBarMenus[13] = Audit;
        MenuBarMenus[14] = Scadenzari;
        MenuBarMenus[15] = DVR;
        MenuBarMenus[16] = DUVRI;
        MenuBarMenus[17] = Gestionecantieri;
        MenuBarMenus[18] = ReportBI;
        MenuBarMenus[19] = Help;
    }
    DocOnLoad();
</script>
