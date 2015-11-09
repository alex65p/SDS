/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.SchedeParagrafo;

import java.util.ArrayList;
import java.util.Collection;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public enum TipoParagrafo {

    // Macchina/Attrezzatura
    MACCHINA_ATTREZZATURA(
    "M",
    ApplicationConfigurator.LanguageManager.getString(
        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
            ?"Macchina.attrezzatura.impianto"
            :"Macchina/Attrezzatura"),
    ApplicationConfigurator.LanguageManager.getString(
    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
        ?"Macchina.attrezzatura.impianto"
        :"Macchina/Attrezzatura")),
    // Unità organizzativa
    UNITA_ORGANIZZATIVA(
    "U",
    ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"),
    ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")),
    // Unità di sicurezza
    UNITA_SICUREZZA(
    "S",
    ApplicationConfigurator.LanguageManager.getString("Unita.di.sicurezza"),
    ApplicationConfigurator.LanguageManager.getString("Unita.di.sicurezza")),
    // Sostanza chimica
    SOSTANZA_CHIMICA(
    "C",
    ApplicationConfigurator.LanguageManager.getString("Sostanza.chimica"),
    ApplicationConfigurator.LanguageManager.getString("Sostanza.chimica")),
    // Anagrafica attività lavorativa
    ATTIVITA_LAVORATIVA(
    "A",
    ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),
    ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa")),
    // Luogo fisico
    LUOGO_FISICO(
    "L",
    ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),
    ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")),
    // Fattore di rischio
    FATTORE_DI_RISCHIO(
    "F",
    ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"),
    ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")),
    // Anagrafica azienda
    ANAGRAFICA_AZIENDA(
    "D",
    ApplicationConfigurator.LanguageManager.getString("Anagrafica.azienda"),
    ApplicationConfigurator.LanguageManager.getString("Anagrafica.azienda")),
    // Descrizioni
    DESCRIZIONI(
    "B",
    ApplicationConfigurator.LanguageManager.getString("Descrizioni"),
    ApplicationConfigurator.LanguageManager.getString("Descrizioni")),
    // Valutazione del rischio
    VALUTAZIONE_RISCHIO(
    "V",
    ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio"),
    ApplicationConfigurator.LanguageManager.getString("Valutazione.rischio")),
    // Scheda rischi
    SCHEDA_RISCHI(
    "R",
    ApplicationConfigurator.LanguageManager.getString("Rischi"),
    ApplicationConfigurator.LanguageManager.getString("Rischi")),
    // BLOCCO DELLE DESCRIZIONI - INIZIO
    DESCRIZIONI_ATTIVITA_LAVORATIVA(
    "BA",
    ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),
    ApplicationConfigurator.LanguageManager.getString("Attivita.lavorativa.descr")),
    DESCRIZIONI_IMMOBILI(
    "BI",
    ApplicationConfigurator.LanguageManager.getString("Immobili"),
    ApplicationConfigurator.LanguageManager.getString("Immobili.descr")),
    DESCRIZIONI_PIANI(
    "BN",
    ApplicationConfigurator.LanguageManager.getString("Piani"),
    ApplicationConfigurator.LanguageManager.getString("Piani.descr")),
    DESCRIZIONI_LUOGO_FISICO(
    "BL",
    ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),
    ApplicationConfigurator.LanguageManager.getString("Luogo.fisico.descr")),
    DESCRIZIONI_MACCHINA_ATTREZZATURA(
    "BM",
    ApplicationConfigurator.LanguageManager.getString(
        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
            ?"Macchina.attrezzatura.impianto"
            :"Macchina/Attrezzatura"),
    ApplicationConfigurator.LanguageManager.getString(
        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
            ?"Macchina.attrezzatura.impianto.descr"
            :"Macchina.attrezzatura.descr")),
    DESCRIZIONI_RISCHI(
    "BR",
    ApplicationConfigurator.LanguageManager.getString("Rischi"),
    ApplicationConfigurator.LanguageManager.getString("Rischi.descr")),
    DESCRIZIONI_MISURA_PP(
    "BP",
    ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione"),
    ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione.descr")),
    DESCRIZIONI_UNITA_ORGANIZZATIVA(
    "BU",
    ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"),
    ApplicationConfigurator.LanguageManager.getString("Unita.organizzativa.descr")),
    DESCRIZIONI_UNITA_SICUREZZA(
    "BS",
    ApplicationConfigurator.LanguageManager.getString("Unita.di.sicurezza"),
    ApplicationConfigurator.LanguageManager.getString("Unita.di.sicurezza.descr"));
    // BLOCCO DELLE DESCRIZIONI - FINE
    private final String type;
    private final String formLabel;
    private final String tableColumnLabel;

    TipoParagrafo(String type, String formLabel, String tableColumnLabel) {
        this.type = type;
        this.formLabel = formLabel;
        this.tableColumnLabel = tableColumnLabel;
    }

    //Getter and setter
    public String getType() {
        return type;
    }

    public String getFormLabel() {
        return formLabel;
    }

    public String getTableColumnLabel() {
        return tableColumnLabel;
    }

    public String getSchedaLabel() {
        return ApplicationConfigurator.LanguageManager.getString("Scheda")
                + " " + StringManager.quote(getTableColumnLabel());
    }

    public static Collection valuesType_DESC() {
        TipoParagrafo[] tipoParagrafoValues = TipoParagrafo.values();
        ArrayList valuesType_DESC = new ArrayList(tipoParagrafoValues.length);
        String desc_type = TipoParagrafo.DESCRIZIONI.getType();

        for (TipoParagrafo tp : tipoParagrafoValues) {
            String tp_type = tp.getType();
            if (tp_type.length() == 2 && tp_type.substring(0, 1).equals(desc_type)) {
                valuesType_DESC.add(tp.getType());
            }
        }
        return valuesType_DESC;
    }

    public static String valuesType_DESC_4sql() {
        String returnString = valuesType_DESC().toString();
        return "'" + returnString.substring(1, returnString.length() - 1).replaceAll(", ", "','") + "'";
    }
    
    public static boolean checkBloccoDescrizioni(String value) {
        Collection<String> listDESC = valuesType_DESC();
        for (String element: listDESC){
            if (element.equals(value)) return true;
        }
        return false;
    }
}
