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
    Document   : menuStructure
    Created on : 18-feb-2008, 14.58.55
    Author     : Dario
--%>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<script>
    MenuRoot = new Array;
    MenuRoot[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Gestione")%>";
        SubMenuGestione = new Array;
        SubMenuGestione.ParentMenu = MenuRoot;
        SubMenuGestione.ParentItemIndex = 0;
        SubMenuGestione.AbsolutePath = buildCompleteMenuPath(SubMenuGestione);
        SubMenuGestione[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Lista.aziende")%>";
        SubMenuGestione[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Accessi")%>";
            SubMenuAccessi = new Array;
            SubMenuAccessi.ParentMenu = SubMenuGestione;
            SubMenuAccessi.ParentItemIndex = 1;
            SubMenuAccessi.AbsolutePath = buildCompleteMenuPath(SubMenuAccessi);
            SubMenuAccessi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Consulenti")%>";
            SubMenuAccessi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Utenti")%>";
            SubMenuAccessi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Ruoli")%>";
        SubMenuGestione[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Opzioni")%>";
    MenuRoot[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafiche.azienda")%>";
        SubMenuAzienda = new Array;
        SubMenuAzienda.ParentMenu = MenuRoot;
        SubMenuAzienda.ParentItemIndex = 1;
        SubMenuAzienda.AbsolutePath = buildCompleteMenuPath(SubMenuAzienda);
        SubMenuAzienda[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Generale")%>";
        SubMenuAzienda[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Fornitori")%>";
        SubMenuAzienda[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Fornitori.personale/servizi")%>";
        SubMenuAzienda[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie.contrattuali")%>";
        SubMenuAzienda[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Lavoratori")%>";
        SubMenuAzienda[5] = "<%=ApplicationConfigurator.LanguageManager.getString("Siti")%>";
            SubMenuDistribuzioneTerritorialie = new Array;
            SubMenuDistribuzioneTerritorialie.ParentMenu = SubMenuAzienda;
            SubMenuDistribuzioneTerritorialie.ParentItemIndex = 5;
            SubMenuDistribuzioneTerritorialie.AbsolutePath = buildCompleteMenuPath(SubMenuDistribuzioneTerritorialie);
            SubMenuDistribuzioneTerritorialie[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Sedi")%>";
            SubMenuDistribuzioneTerritorialie[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>";
            SubMenuDistribuzioneTerritorialie[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Immobili")%>";
            SubMenuDistribuzioneTerritorialie[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Ali")%>";
            SubMenuDistribuzioneTerritorialie[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Piani")%>";
        SubMenuAzienda[6] = "<%=ApplicationConfigurator.LanguageManager.getString("Organizzazione")%>";
            SubMenuOrganizzazione = new Array;
            SubMenuOrganizzazione.ParentMenu = SubMenuAzienda;
            SubMenuOrganizzazione.ParentItemIndex = 6;
            SubMenuOrganizzazione.AbsolutePath = buildCompleteMenuPath(SubMenuOrganizzazione);
            SubMenuOrganizzazione[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie.unita.organizzative")%>";
            SubMenuOrganizzazione[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Gestione.unita.organizzative")%>";
            SubMenuOrganizzazione[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Ruoli.aziendali")%>";
            SubMenuOrganizzazione[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Ruoli.sicurezza")%>";
            SubMenuOrganizzazione[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Unita.di.sicurezza")%>";
    MenuRoot[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Mansioni")%>";
            SubMenuAttivitaLavorative = new Array;
            SubMenuAttivitaLavorative.ParentMenu = MenuRoot;
            SubMenuAttivitaLavorative.ParentItemIndex = 2;
            SubMenuAttivitaLavorative.AbsolutePath = buildCompleteMenuPath(SubMenuAttivitaLavorative);
            SubMenuAttivitaLavorative[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Attivita.lavorative")%>";
            SubMenuAttivitaLavorative[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Operazioni.svolte")%>";
            SubMenuAttivitaLavorative[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Associazione.SAP/S2S")%>";
    MenuRoot[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Macchinari")%>";
            SubMenuMacchinari = new Array;
            SubMenuMacchinari.ParentMenu = MenuRoot;
            SubMenuMacchinari.ParentItemIndex = 3;
            SubMenuMacchinari.AbsolutePath = buildCompleteMenuPath(SubMenuMacchinari);
            SubMenuMacchinari[0] = "<%=ApplicationConfigurator.LanguageManager.getString(
                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                ?"Tipologie.macchine.attrezzature.impianti"
                                                :"Tipologie.macchine/attrezzature"
                                                                    )%>";
            SubMenuMacchinari[1] = "<%=ApplicationConfigurator.LanguageManager.getString(
                                            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                ?"Macchine.attrezzature.impianti"
                                                :"Macchine/Attrezzature"
                                                                    )%>";
            SubMenuMacchinari[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione/Sostituzione")%>";
    MenuRoot[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Agenti.chimici")%>";
        SubMenuAgentiChimici = new Array;
        SubMenuAgentiChimici.ParentMenu = MenuRoot;
        SubMenuAgentiChimici.ParentItemIndex = 4;
        SubMenuAgentiChimici.AbsolutePath = buildCompleteMenuPath(SubMenuAgentiChimici);
        SubMenuAgentiChimici[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Frasi.R")%>"; 
        SubMenuAgentiChimici[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Frasi.S")%>"; 
        SubMenuAgentiChimici[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Classificazione")%>";
        SubMenuAgentiChimici[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Caratteristiche.chimico/fisiche")%>";
    MenuRoot[5] = "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>";
        SubMenuRischi = new Array;
        SubMenuRischi.ParentMenu = MenuRoot;
        SubMenuRischi.ParentItemIndex = 5;
        SubMenuRischi.AbsolutePath = buildCompleteMenuPath(SubMenuRischi);
        SubMenuRischi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Categorie.fattori.di.rischio")%>";
        SubMenuRischi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Fattori.di.rischio")%>";
        SubMenuRischi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>";
    MenuRoot[6] = "<%=ApplicationConfigurator.LanguageManager.getString("Strumenti.di.controllo.dei.rischi")%>";
        SubMenuStrumenti = new Array;
        SubMenuStrumenti.ParentMenu = MenuRoot;
        SubMenuStrumenti.ParentItemIndex = 6;
        SubMenuStrumenti.AbsolutePath = buildCompleteMenuPath(SubMenuStrumenti);
        SubMenuStrumenti[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>";
        SubMenuStrumenti[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Perizie")%>";
        SubMenuStrumenti[2] = "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>";
            SubMenuDPI = new Array;
            SubMenuDPI.ParentMenu = SubMenuStrumenti;
            SubMenuDPI.ParentItemIndex = 2;
            SubMenuDPI.AbsolutePath = buildCompleteMenuPath(SubMenuDPI);
            SubMenuDPI[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie")%>";    
            SubMenuDPI[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Lotti")%>";
            SubMenuDPI[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Schede.di.intervento")%>";
    MenuRoot[7] = "<%=ApplicationConfigurator.LanguageManager.getString("Formazione.del.personale")%>";
        SubMenuFormazione = new Array;
        SubMenuFormazione.ParentMenu = MenuRoot;
        SubMenuFormazione.ParentItemIndex = 7;
        SubMenuFormazione.AbsolutePath = buildCompleteMenuPath(SubMenuFormazione);
        SubMenuFormazione[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>";
            SubMenuCorsi = new Array;
            SubMenuCorsi.ParentMenu = SubMenuFormazione;
            SubMenuCorsi.ParentItemIndex = 0;
            SubMenuCorsi.AbsolutePath = buildCompleteMenuPath(SubMenuCorsi);
            SubMenuCorsi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>";
            SubMenuCorsi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Lista.corsi")%>";
            SubMenuCorsi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Erogazione")%>";
        SubMenuFormazione[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Test.di.verifica")%>";
            SubMenuTestVerifica = new Array;
            SubMenuTestVerifica.ParentMenu = SubMenuFormazione;
            SubMenuTestVerifica.ParentItemIndex = 1;
            SubMenuTestVerifica.AbsolutePath = buildCompleteMenuPath(SubMenuTestVerifica);
            SubMenuTestVerifica[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Lista.test.di.verifica")%>";
            SubMenuTestVerifica[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Domande")%>";
            SubMenuTestVerifica[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Risposte")%>";
        SubMenuFormazione[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Percorsi.formativi")%>";
        SubMenuFormazione[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Debiti.formativi")%>";
    MenuRoot[8] = "<%=ApplicationConfigurator.LanguageManager.getString("Verifiche.sanitarie")%>";
        SubMenuVerificheSanitarie = new Array;
        SubMenuVerificheSanitarie.ParentMenu = MenuRoot;
        SubMenuVerificheSanitarie.ParentItemIndex = 8;
        SubMenuVerificheSanitarie.AbsolutePath = buildCompleteMenuPath(SubMenuVerificheSanitarie);
        SubMenuVerificheSanitarie[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Visite.mediche")%>";
        SubMenuVerificheSanitarie[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita")%>";
        SubMenuVerificheSanitarie[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Cartelle.cliniche")%>";
        SubMenuVerificheSanitarie[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Protocolli")%>";
    MenuRoot[9] = "<%=ApplicationConfigurator.LanguageManager.getString("Infortuni")%>";
        SubMenuInfortuni = new Array;
        SubMenuInfortuni.ParentMenu = MenuRoot;
        SubMenuInfortuni.ParentItemIndex = 9;
        SubMenuInfortuni.AbsolutePath = buildCompleteMenuPath(SubMenuInfortuni);
        SubMenuInfortuni[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Sedi.lesioni")%>";
        SubMenuInfortuni[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Natura.lesioni")%>";
        SubMenuInfortuni[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Categorie.agenti.materiali")%>";
        SubMenuInfortuni[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Agenti.materiali")%>";
        SubMenuInfortuni[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Forme.di.infortunio")%>";
        SubMenuInfortuni[5] = "<%=ApplicationConfigurator.LanguageManager.getString("Accertamenti")%>";
        SubMenuInfortuni[6] = "<%=ApplicationConfigurator.LanguageManager.getString("Lista.infortuni")%>";
    MenuRoot[10] = "<%=ApplicationConfigurator.LanguageManager.getString("Presidi.antincendio")%>";
        SubMenuPresidi = new Array;
        SubMenuPresidi.ParentMenu = MenuRoot;
        SubMenuPresidi.ParentItemIndex = 10;
        SubMenuPresidi.AbsolutePath = buildCompleteMenuPath(SubMenuPresidi);
        SubMenuPresidi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Categorie")%>";
        SubMenuPresidi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Presidi")%>";
        SubMenuPresidi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Schede.di.intervento")%>";
    MenuRoot[11] = "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>";
        SubMenuDocumenti = new Array;
        SubMenuDocumenti.ParentMenu = MenuRoot;
        SubMenuDocumenti.ParentItemIndex = 11;
        SubMenuDocumenti.AbsolutePath = buildCompleteMenuPath(SubMenuDocumenti);
        SubMenuDocumenti[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie")%>";
        SubMenuDocumenti[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Categorie")%>";
        SubMenuDocumenti[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Documenti/Versioni")%>";
        SubMenuDocumenti[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Normative")%>";
            SubMenuNormative = new Array;
            SubMenuNormative.ParentMenu = SubMenuDocumenti;
            SubMenuNormative.ParentItemIndex = 3;
            SubMenuNormative.AbsolutePath = buildCompleteMenuPath(SubMenuNormative);
            SubMenuNormative[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Settori")%>";
            SubMenuNormative[1] = "<%=ApplicationConfigurator.LanguageManager.getString("SottoSettori")%>";
            SubMenuNormative[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Organi")%>";
            SubMenuNormative[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologie")%>";
            SubMenuNormative[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Norme/Sentenze")%>";
    MenuRoot[12] = "<%=ApplicationConfigurator.LanguageManager.getString("Verifiche.S.P.P.")%>";
        SubMenuVerificheSPP = new Array;
        SubMenuVerificheSPP.ParentMenu = MenuRoot;
        SubMenuVerificheSPP.ParentItemIndex = 12;
        SubMenuVerificheSPP.AbsolutePath = buildCompleteMenuPath(SubMenuVerificheSPP);
        SubMenuVerificheSPP[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Audit")%>";
        SubMenuVerificheSPP[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Non.conformita")%>";
        SubMenuVerificheSPP[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Segnalazioni")%>";
        SubMenuVerificheSPP[3] = "<%=ApplicationConfigurator.LanguageManager.getString("R.A.C./R.A.P.")%>";
        SubMenuVerificheSPP[4] = "<%=ApplicationConfigurator.LanguageManager.getString("A.C/A.P")%>";
    MenuRoot[13] = "<%=ApplicationConfigurator.LanguageManager.getString("Analisi.e.controllo")%>";
        SubMenuAnalisiControllo = new Array;
        SubMenuAnalisiControllo.ParentMenu = MenuRoot;
        SubMenuAnalisiControllo.ParentItemIndex = 13;
        SubMenuAnalisiControllo.AbsolutePath = buildCompleteMenuPath(SubMenuAnalisiControllo);
        SubMenuAnalisiControllo[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Verifiche.sanitarie")%>";
        SubMenuAnalisiControllo[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione")%>";
        SubMenuAnalisiControllo[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Perizie")%>";
        SubMenuAnalisiControllo[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Audit")%>";
        SubMenuAnalisiControllo[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Formazione.del.personale")%>";
        SubMenuAnalisiControllo[5] = "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>";
        SubMenuAnalisiControllo[6] = "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>";
        SubMenuAnalisiControllo[7] = "<%=ApplicationConfigurator.LanguageManager.getString("Segnalazioni")%>";
        SubMenuAnalisiControllo[8] = "<%=ApplicationConfigurator.LanguageManager.getString("Presidi.antincendio")%>";
            SubMenuPresidiAntincendio = new Array;
            SubMenuPresidiAntincendio.ParentMenu = SubMenuAnalisiControllo;
            SubMenuPresidiAntincendio.ParentItemIndex = 8;
            SubMenuPresidiAntincendio.AbsolutePath = buildCompleteMenuPath(SubMenuPresidiAntincendio);
            SubMenuPresidiAntincendio[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%>";
            SubMenuPresidiAntincendio[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%>";
        SubMenuAnalisiControllo[9] = "<%=ApplicationConfigurator.LanguageManager.getString("Macchinari")%>";
            SubMenuMacchinari2 = new Array;
            SubMenuMacchinari2.ParentMenu = SubMenuAnalisiControllo;
            SubMenuMacchinari2.ParentItemIndex = 9;
            SubMenuMacchinari2.AbsolutePath = buildCompleteMenuPath(SubMenuMacchinari2);
            SubMenuMacchinari2[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%>";
            SubMenuMacchinari2[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%>";
        SubMenuAnalisiControllo[10] = "<%=ApplicationConfigurator.LanguageManager.getString("D.P.I.")%>";
            SubMenuDPI2 = new Array;
            SubMenuDPI2.ParentMenu = SubMenuAnalisiControllo;
            SubMenuDPI2.ParentItemIndex = 10;
            SubMenuDPI2.AbsolutePath = buildCompleteMenuPath(SubMenuDPI2);
            SubMenuDPI2[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%>";
            SubMenuDPI2[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%>";
    MenuRoot[14] = "<%=ApplicationConfigurator.LanguageManager.getString("D.V.R.")%>";
        SubMenuDVR = new Array;
        SubMenuDVR.ParentMenu = MenuRoot;
        SubMenuDVR.ParentItemIndex = 14;
        SubMenuDVR.AbsolutePath = buildCompleteMenuPath(SubMenuDVR);
        SubMenuDVR[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Sezioni")%>";
        SubMenuDVR[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Capitoli")%>";
        SubMenuDVR[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Paragrafi")%>";
        SubMenuDVR[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.di.valutazione.dei.rischi")%>";
   MenuRoot[15] = "<%=ApplicationConfigurator.LanguageManager.getString("DUVRI")%>";
        SubMenuDUVRI = new Array;
        SubMenuDUVRI.ParentMenu = MenuRoot;
        SubMenuDUVRI.ParentItemIndex = 15;
        SubMenuDUVRI.AbsolutePath = buildCompleteMenuPath(SubMenuDUVRI);
        SubMenuDUVRI[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Contratti/Servizi")%>";
            SubMenuContrattiServizi = new Array;
            SubMenuContrattiServizi.ParentMenu = SubMenuDUVRI;
            SubMenuContrattiServizi.ParentItemIndex = 0;
            SubMenuContrattiServizi.AbsolutePath = buildCompleteMenuPath(SubMenuContrattiServizi);
            SubMenuContrattiServizi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica")%>";
            SubMenuContrattiServizi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Dettaglio.committente")%>";
            SubMenuContrattiServizi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Dettaglio.appaltatrice")%>";
            SubMenuContrattiServizi[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Dettaglio.subappaltatrici")%>";
        SubMenuDUVRI[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Stampa")%>";
    MenuRoot[16] = "<%=ApplicationConfigurator.LanguageManager.getString("Gestionecantieri")%>";
        SubMenuGestionecantieri = new Array;
        SubMenuGestionecantieri.ParentMenu = MenuRoot;
        SubMenuGestionecantieri.ParentItemIndex = 16;
        SubMenuGestionecantieri.AbsolutePath = buildCompleteMenuPath(SubMenuGestionecantieri);
        SubMenuGestionecantieri[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.generale")%>";
           SubMenuAnagraficagenerale = new Array;
           SubMenuAnagraficagenerale.ParentMenu = SubMenuGestionecantieri;
           SubMenuAnagraficagenerale.ParentItemIndex = 0;
           SubMenuAnagraficagenerale.AbsolutePath = buildCompleteMenuPath(SubMenuAnagraficagenerale);
           SubMenuAnagraficagenerale[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Procedimento")%>";
           SubMenuAnagraficagenerale[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Cantieri")%>";
           SubMenuAnagraficagenerale[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Opere")%>";
           SubMenuAnagraficagenerale[3] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.attivita")%>";
        SubMenuGestionecantieri[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>";
           SubMenuRischiCantiere = new Array;
           SubMenuRischiCantiere.ParentMenu = SubMenuGestionecantieri;
           SubMenuRischiCantiere.ParentItemIndex = 1;
           SubMenuRischiCantiere.AbsolutePath = buildCompleteMenuPath(SubMenuRischiCantiere);
           SubMenuRischiCantiere[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Fattori.di.rischio")%>";
           SubMenuRischiCantiere[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Rischi")%>";
        SubMenuGestionecantieri[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Documenti.area.sicurezza")%>";
           SubMenuDocumentiAreaSicurezza = new Array;
           SubMenuDocumentiAreaSicurezza.ParentMenu = SubMenuGestionecantieri;
           SubMenuDocumentiAreaSicurezza.ParentItemIndex = 2;
           SubMenuDocumentiAreaSicurezza.AbsolutePath = buildCompleteMenuPath(SubMenuDocumentiAreaSicurezza);
           SubMenuDocumentiAreaSicurezza[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Tipologia.documento")%>";
           SubMenuDocumentiAreaSicurezza[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Documento")%>";
        SubMenuGestionecantieri[3] = "<%=ApplicationConfigurator.LanguageManager.getString("PSC")%>";
        SubMenuGestionecantieri[4] = "<%=ApplicationConfigurator.LanguageManager.getString("Registro.POS")%>";        
        SubMenuGestionecantieri[5] = "<%=ApplicationConfigurator.LanguageManager.getString("Sopralluoghi")%>";
           SubMenuSopralluoghi = new Array;
           SubMenuSopralluoghi.ParentMenu = SubMenuGestionecantieri;
           SubMenuSopralluoghi.ParentItemIndex = 5;
           SubMenuSopralluoghi.AbsolutePath = buildCompleteMenuPath(SubMenuSopralluoghi);
           SubMenuSopralluoghi[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.Constatazioni")%>";
           SubMenuSopralluoghi[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.Disposizioni")%>";
           SubMenuSopralluoghi[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Pianificazione")%>";
           SubMenuSopralluoghi[3] = "<%=ApplicationConfigurator.LanguageManager.getString("RS")%>";
        SubMenuGestionecantieri[6] = "<%=ApplicationConfigurator.LanguageManager.getString("Infortuni")%>";
           SubMenuInfortuniCantiere = new Array;
           SubMenuInfortuniCantiere.ParentMenu = SubMenuGestionecantieri;
           SubMenuInfortuniCantiere.ParentItemIndex = 6;
           SubMenuInfortuniCantiere.AbsolutePath = buildCompleteMenuPath(SubMenuInfortuniCantiere);
           SubMenuInfortuniCantiere[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Sedi.lesioni")%>";
           SubMenuInfortuniCantiere[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Forme.di.infortunio")%>";
           SubMenuInfortuniCantiere[2] = "<%=ApplicationConfigurator.LanguageManager.getString("Lista.infortuni")%>";
    MenuRoot[17] = "<%=ApplicationConfigurator.LanguageManager.getString("ReportBI")%>";
        SubMenuReportBI = new Array;
        SubMenuReportBI.ParentMenu = MenuRoot;
        SubMenuReportBI.ParentItemIndex = 17;
        SubMenuReportBI.AbsolutePath = buildCompleteMenuPath(SubMenuReportBI);
        SubMenuReportBI[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Avvia")%>";
        SubMenuReportBI[1] = "<%=ApplicationConfigurator.LanguageManager.getString("Documentazione")%>";
    MenuRoot[18] = "<%=ApplicationConfigurator.LanguageManager.getString("Help")%>";
        SubMenuHelp = new Array;
        SubMenuHelp.ParentMenu = MenuRoot;
        SubMenuHelp.ParentItemIndex = 18;
        SubMenuHelp.AbsolutePath = buildCompleteMenuPath(SubMenuHelp);
        SubMenuHelp[0] = "<%=ApplicationConfigurator.LanguageManager.getString("Help.Generale")%>";
        SubMenuHelp[1] = "<%=ApplicationConfigurator.LanguageManager.getString("About")%>";

    function buildCompleteMenuPath(MenuRoot){
        CompleteMenuPath = "";
        menuLevel = getMenuLevel(MenuRoot);
        while (MenuRoot.ParentMenu != null){
            CompleteMenuPath = MenuRoot.ParentMenu[MenuRoot.ParentItemIndex] + buidMenuLevel(menuLevel) + CompleteMenuPath;
            MenuRoot = MenuRoot.ParentMenu;
            menuLevel--;
        }
        return CompleteMenuPath;
    }

    function getMenuLevel(MenuRoot){
        i = 0;
        while (MenuRoot.ParentMenu != null){
            i++;
            MenuRoot = MenuRoot.ParentMenu;
        }
        return i;
    }

    function buidMenuLevel(menuLevel){
        menuSeparator = ">";
        returnString = "";
        for (i=1;i<=menuLevel;i++){
            returnString = returnString + menuSeparator;
        }
        return " " + returnString + " ";
    }

    function getCompleteMenuPath(MenuRoot, index){
        return MenuRoot.AbsolutePath + MenuRoot[index];
    }

    function getCompleteMenuPathFunction(MenuRoot, index, id){
        SpaceChar = " - ";
        if (id==null || id=="")
            return getCompleteMenuPath(MenuRoot, index) + SpaceChar + "<%=ApplicationConfigurator.LanguageManager.getString("Inserimento")%>";
        else
            return getCompleteMenuPath(MenuRoot, index) + SpaceChar + "<%=ApplicationConfigurator.LanguageManager.getString("Gestione")%>";
    }

    function getCompleteMenuPathHelp(MenuRoot, index){
        SpaceChar = " - ";
        return getCompleteMenuPath(MenuRoot, index) + SpaceChar + "Help";
    }
</script>
