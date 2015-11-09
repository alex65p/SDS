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
package s2s.luna.reports;

import com.apconsulting.luna.ejb.Azienda.Azienda_MOD_CLC_RSO;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischio_Name_Address_View;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.ICategorioRischioHome;
import com.apconsulting.luna.ejb.Rischio.*;
import com.apconsulting.luna.ejb.RischioFattore.FattoreRischio_View;
import com.apconsulting.luna.ejb.RischioFattore.IRischioFattoreHome;
import com.lowagie.text.*;
import java.awt.Color;
import java.io.IOException;
import java.util.Collection;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.util.SecurityWrapper;
import s2s.report.MiddleTable;
import s2s.report.Report;
import s2s.report.ZREPORT_SETTINGS;
import s2s.utils.plain.Formatter;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class Report_REP_SCH_RSO_NEW_DVR extends Report {

    public long lCOD_AZL = 0;

    public Report_REP_SCH_RSO_NEW_DVR(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }

    private MiddleTable prepareAttivitaTableHeader(short sMOD_CLC_RSO) throws Exception{
        int numberOfColumnsAttivitaLavorative = (sMOD_CLC_RSO==Azienda_MOD_CLC_RSO.MOD_EXTENDED)?7:5;
        MiddleTable rischioMansioneTable = new MiddleTable(numberOfColumnsAttivitaLavorative);
        rischioMansioneTable.setBorder(Rectangle.LEFT | Rectangle.RIGHT | Rectangle.TOP | Rectangle.BOTTOM);
        
        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
            int rischiAttivitaLavorativeWidth[] = {45, 40, 5, 5, 5};
            rischioMansioneTable.setWidths(rischiAttivitaLavorativeWidth);
        } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
            int rischiAttivitaLavorativeWidth[] = {45, 30, 5, 5, 5, 5, 5};
            rischioMansioneTable.setWidths(rischiAttivitaLavorativeWidth);
        }

        // Intestazione della tabella
        rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("Gruppo.omogeneo.di.lavoratori"), 1, true, 8);
        rischioMansioneTable.toCenter();
        rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("MPP.applicate"), 1, true, 8);
        rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("P"), 1, true, 8);
        rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("D"), 1, true, 8);
        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
            rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("F"), 1, true, 8);
            rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("N"), 1, true, 8);
        }
        rischioMansioneTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("R"), 1, true, 8);
        rischioMansioneTable.toLeft();
        
        return rischioMansioneTable;
    }
    
    private MiddleTable prepareLuogoFisicoTableHeader(short sMOD_CLC_RSO) throws Exception{
        int numberOfColumnsLuoghiFisici = (sMOD_CLC_RSO==Azienda_MOD_CLC_RSO.MOD_EXTENDED)?7:5;
        MiddleTable rischiLuoghiFisiciTable = new MiddleTable(numberOfColumnsLuoghiFisici);
        rischiLuoghiFisiciTable.setBorder(Rectangle.LEFT | Rectangle.RIGHT | Rectangle.TOP | Rectangle.BOTTOM);
        
        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_BASE) {
            int rischiLuoghiFisiciWidth[] = {45, 40, 5, 5, 5};                            
            rischiLuoghiFisiciTable.setWidths(rischiLuoghiFisiciWidth);
        } else if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED) {
            int rischiLuoghiFisiciWidth[] = {45, 30, 5, 5, 5, 5, 5};                            
            rischiLuoghiFisiciTable.setWidths(rischiLuoghiFisiciWidth);
        }

        // Intestazione della tabella
        rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici"), 1, true, 8);
        rischiLuoghiFisiciTable.toCenter();
        rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("MPP.applicate"), 1, true, 8);
        rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("P"), 1, true, 8);
        rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("D"), 1, true, 8);
        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
            rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("F"), 1, true, 8);
            rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("N"), 1, true, 8);
        }
        rischiLuoghiFisiciTable.addHeaderCellBI(ApplicationConfigurator.LanguageManager.getString("R"), 1, true, 8);
        rischiLuoghiFisiciTable.toLeft();
        
        return rischiLuoghiFisiciTable;
    }
    
    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));
        ZREPORT_SETTINGS ZREPORT_SETTINGS = new ZREPORT_SETTINGS();
        
        SecurityWrapper Security = SecurityWrapper.getInstance();
        short sMOD_CLC_RSO = Security.getAziendaModalitaCalcoloRischio();

        initDocument("the doc", null,
                ApplicationConfigurator.LanguageManager.getString("Schede.di.valutazione.del.rischio"),
                bean.getRAG_SCL_AZL(), null);

        {
            // Intestazione generale
            /*
            CenterMiddleTable tblTopHeader = new CenterMiddleTable(1);
            tblTopHeader.toCenter();
            tblTopHeader.toMiddle();
            tblTopHeader.addHeaderCellB
                    (ApplicationConfigurator.LanguageManager.getString("Schede.di.valutazione.del.rischio").toUpperCase(), 1, true, 12);
            m_document.add(tblTopHeader);
            writeLine();
            */

            // Categorie dei fattori di rischio.
            ICategorioRischioHome home_cr = (ICategorioRischioHome) PseudoContext.lookup("CategorioRischioBean");
            Collection<CategorioRischio_Name_Address_View> cat_ris_list = home_cr.getCategorieWithRischi_View(bean.getCOD_AZL());
            
            int categoriaCount = 0;
            for (CategorioRischio_Name_Address_View categoria : cat_ris_list) {
                categoriaCount++;
                //  ---------------------------------------------------------
                //  -           TABELLA CATEGORIA   -   INIZIO              -
                //  ---------------------------------------------------------
                /*
                MiddleTable categoriaTable = new MiddleTable(2);
                int categoriaWidth[] = {15, 85};
                categoriaTable.setWidths(categoriaWidth);
                // CATEGORIA
                Cell categoriaCell = new Cell(new Phrase(ApplicationConfigurator.LanguageManager.getString("Categoria").toUpperCase(),
                        ZREPORT_SETTINGS.ftTableHeader9B));
                categoriaCell.setRowspan(2);
                categoriaCell.setBackgroundColor(Color.ORANGE);
                categoriaTable.addCell(categoriaCell);
                // NOME CATEGORIA
                Cell nomeCategoriaCell = new Cell(new Phrase(Formatter.format(categoria.NOM_CAG_FAT_RSO), ZREPORT_SETTINGS.ftTableHeader9B));
                nomeCategoriaCell.setBackgroundColor(Color.ORANGE);
                categoriaTable.addCell(nomeCategoriaCell);
                // DESCRIZIONE CATEGORIA
                categoriaTable.addCell(StringManager.isNotEmpty(categoria.DES_CAG_FAT_RSO)
                        ? Formatter.format(categoria.DES_CAG_FAT_RSO) : EMPTY_STRING, 8);
                m_document.add(categoriaTable);
                writeLine();
                */
                //  ---------------------------------------------------------
                //  -           TABELLA CATEGORIA   -   FINE                -
                //  ---------------------------------------------------------

                // Fattori di rischio.
                IRischioFattoreHome home_fat_rso = (IRischioFattoreHome) PseudoContext.lookup("RischioFattoreBean");
                Collection<FattoreRischio_View> listaFattori =
                        home_fat_rso.getFattoriWithRischi4Categoria(categoria.COD_CAG_FAT_RSO, bean.getCOD_AZL());
                
                int fattoreRischioCount = 0;
                for (FattoreRischio_View fattore : listaFattori) {
                    fattoreRischioCount++;
                    //  ---------------------------------------------------------
                    //  -           TABELLA FATTORE DI RISCHIO  -   INIZIO      -
                    //  ---------------------------------------------------------
                    /*
                    MiddleTable fattoreTable = new MiddleTable(2);
                    int fattoreWidth[] = {20, 80};
                    fattoreTable.setWidths(fattoreWidth);
                    // FATTORE DI RISCHIO
                    Cell fattoreCell = new Cell(new Phrase(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio").toUpperCase(),
                            ZREPORT_SETTINGS.ftTableHeader9B));
                    fattoreCell.setRowspan(2);
                    fattoreCell.setBackgroundColor(Color.PINK);
                    fattoreTable.addCell(fattoreCell);
                    // NOME FATTORE DI RISCHIO
                    Cell nomeFattoreCell = new Cell(new Phrase(Formatter.format(fattore.NOM_FAT_RSO), ZREPORT_SETTINGS.ftTableHeader9B));
                    nomeFattoreCell.setBackgroundColor(Color.PINK);
                    fattoreTable.addCell(nomeFattoreCell);
                    // DESCRIZIONE FATTORE DI RISCHIO
                    fattoreTable.addCell(StringManager.isNotEmpty(fattore.DES_FAT_RSO)
                            ? Formatter.format(fattore.DES_FAT_RSO) : EMPTY_STRING, 8);
                    m_document.add(fattoreTable);
                    writeLine();
                    */
                    //  ---------------------------------------------------------
                    //  -           TABELLA FATTORE DI RISCHIO  -   FINE        -
                    //  ---------------------------------------------------------

                    // Rischi
                    IRischioHome home_rso = (IRischioHome) PseudoContext.lookup("RischioBean");
                    Collection<Rischio_ComboBox> listaRischi =
                            home_rso.getRischio_ComboBox(bean.getCOD_AZL(), fattore.COD_FAT_RSO);
                    
                    int rischioCount = 0;
                    for (Rischio_ComboBox rischio : listaRischi) {
                        rischioCount++;
                        //  ---------------------------------------------------------
                        //  -           TABELLA RISCHI  -   INIZIO                  -
                        //  ---------------------------------------------------------
                        MiddleTable rischioTable = new MiddleTable(2);
                        int rischioWidth[] = {25, 75};
                        rischioTable.setWidths(rischioWidth);
                        // RISCHIO
                        Cell rischioCell = new Cell(new Phrase(ApplicationConfigurator.LanguageManager.getString("Rischio").toUpperCase(),
                                ZREPORT_SETTINGS.ftTableHeader9B));
                        rischioCell.setRowspan(2);
                        rischioCell.setBackgroundColor(Color.YELLOW);
                        rischioTable.addCell(rischioCell);
                        // NOME RISCHIO
                        rischioTable.addHeaderCellB(Formatter.format(rischio.strNOM_RSO), 1, true, 9);
                        // DESCRIZIONE RISCHIO
                        rischioTable.addCell(StringManager.isNotEmpty(rischio.strDES_RSO)
                                ? Formatter.format(rischio.strDES_RSO) : EMPTY_STRING, 8);
                        m_document.add(rischioTable);
                        writeLine();
                        //  ---------------------------------------------------------
                        //  -           TABELLA RISCHI  -   FINE                    -
                        //  ---------------------------------------------------------

                        // Misure di prevenzione e protezione
                        Collection<RischioMisurePp_Nome_Descrizione_View> listaMisure =
                                home_rso.getMisurePpView(rischio.lCOD_RSO, bean.getCOD_AZL());
                        //  ---------------------------------------------------------
                        //  -           TABELLA MISURE  -   INIZIO                  -
                        //  ---------------------------------------------------------
                        MiddleTable misuraTable = new MiddleTable(2);
                        int misuraWidth[] = {30, 70};
                        misuraTable.setWidths(misuraWidth);
                        misuraTable.addHeaderCellBI(
                                ApplicationConfigurator.LanguageManager.getString("Misure.associate.rischio"), 2, true, 9);
                        for (RischioMisurePp_Nome_Descrizione_View misura : listaMisure) {
                            misuraTable.addCellB(Formatter.format(misura.strNOM_MIS_PET), 9);
                            misuraTable.addCellFirstLineBold(Formatter.format(misura.strDES_MIS_PET), 1, 8);
                        }
                        m_document.add(misuraTable);
                        writePage();
                        //  ---------------------------------------------------------
                        //  -           TABELLA MISURE  -   FINE                    -
                        //  ---------------------------------------------------------
                        
                        // VALUTAZIONE DEL RISCHIO NEL CONTESTO LAVORATIVO
                        MiddleTable rischioValutazioneLuoghiFisiciHeader = new MiddleTable(1);
                        rischioValutazioneLuoghiFisiciHeader.addHeaderCellBI(
                                ApplicationConfigurator.LanguageManager.getString("Valutazione.del.rischio.nel.contesto.lavorativo").toUpperCase()
                                , 1, true, 10);
                        m_document.add(rischioValutazioneLuoghiFisiciHeader);
                        writeLine();
                        
                        // Estraggo gli immobili
                        Collection<Rischio4LuoghiFisici_View> listaImmobili =
                                home_rso.getReportRischio4LuoghiFisici_IMMOBILI_View(rischio.lCOD_RSO, bean.getCOD_AZL());

                        // Scorro gli immobili...
                        for (Rischio4LuoghiFisici_View immobile : listaImmobili) {
                            
                            // Scrivo la riga di intestazione degli immobili
                            MiddleTable rischioEdificioHeader = new MiddleTable(1);
                            rischioEdificioHeader.addHeaderCellB(
                                    ApplicationConfigurator.LanguageManager.getString("Edificio") + ": " + Formatter.format(immobile.NOM_IMM)
                                    , 1, true, 10);
                            m_document.add(rischioEdificioHeader);
                            writeLine();
                            
                            // Scrivo la riga di intestazione dei luoghi fisici
                            MiddleTable rischioLuoghiFisiciTable = 
                                    prepareLuogoFisicoTableHeader(sMOD_CLC_RSO);

                            // Estraggo i luoghi fisici
                            Collection<Rischio4LuoghiFisici_View> listaLuoghiFisici =
                                    home_rso.getReportRischio4LuoghiFisici_LUOGHI_FISICI_View
                                        (rischio.lCOD_RSO, bean.getCOD_AZL(), immobile.COD_IMM);

                            // scorro i luoghi fisici...
                            for (Rischio4LuoghiFisici_View luogoFisico : listaLuoghiFisici) {
                                
                                // Estraggo le misure di prevenzione e protezione
                                Collection<Rischio4LuoghiFisici_View> listaMisurePP =
                                        home_rso.getReportRischio4LuoghiFisici_MISURE_View
                                            (rischio.lCOD_RSO, bean.getCOD_AZL(), immobile.COD_IMM, luogoFisico.COD_LUO_FSC);
                                
                                int misureCount = listaMisurePP.isEmpty()
                                        ?1:listaMisurePP.size();
                                
                                // scrivo il luogo fisico
                                rischioLuoghiFisiciTable.addCell
                                        (Formatter.format(luogoFisico.NOM_LUO_FSC), 8, 1,misureCount);

                                // scorro le misure di prevenzione e protezione...
                                boolean writeValoriRischio = true;
                                for (Rischio4LuoghiFisici_View misura : listaMisurePP) {
                                    rischioLuoghiFisiciTable.addCellB(Formatter.format(misura.NOM_MIS_PET),8);

                                    if (writeValoriRischio){
                                        rischioLuoghiFisiciTable.toCenter();
                                        rischioLuoghiFisiciTable.addCell(Formatter.format(luogoFisico.lPRB_EVE_LES), 8, 1, misureCount);
                                        rischioLuoghiFisiciTable.addCell(Formatter.format(luogoFisico.lENT_DAN), 8, 1, misureCount);
                                        if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
                                            rischioLuoghiFisiciTable.addCell(Formatter.format(luogoFisico.lFRQ_RIP_ATT_DAN), 8, 1, misureCount);
                                            rischioLuoghiFisiciTable.addCell(Formatter.format(luogoFisico.lNUM_INC_INF), 8, 1, misureCount);
                                        }
                                        rischioLuoghiFisiciTable.addCell(Formatter.format(luogoFisico.lSTM_NUM_RSO), 8, 1, misureCount);
                                        rischioLuoghiFisiciTable.toLeft();
                                    }
                                    writeValoriRischio = false;
                                }
                            }
                            m_document.add(rischioLuoghiFisiciTable);
                            writePage();
                        }
                        
                        // VALUTAZIONE DEL RISCHIO DI ESPOSIZIONE DEI LAVORATORI
                        MiddleTable rischioValutazioneMansioniHeader = new MiddleTable(1);
                        rischioValutazioneMansioniHeader.addHeaderCellBI(
                                ApplicationConfigurator.LanguageManager.getString("Valutazione.del.rischio.di.esposizione.dei.lavoratori").toUpperCase()
                                , 1, true, 10);
                        m_document.add(rischioValutazioneMansioniHeader);
                        writeLine();
                        
                        // Scrivo la riga di intestazione delle attività
                        MiddleTable rischioMansioneTable = 
                                prepareAttivitaTableHeader(sMOD_CLC_RSO);
                        
                        // Estraggo le attività
                        Collection<Rischio4AttivitaLavorative_View> listaAttivita =
                                home_rso.getReportRischio4AttivitaLavorative_ATTIVITA_View(rischio.lCOD_RSO, bean.getCOD_AZL());
                        
                        // scorro le attività lavorative...
                        for (Rischio4AttivitaLavorative_View attivita : listaAttivita) {
                            
                            // Estraggo le misure di prevenzione e protezione
                            Collection<Rischio4AttivitaLavorative_View> listaMisurePP =
                                    home_rso.getReportRischio4AttivitaLavorative_MISURE_View(rischio.lCOD_RSO, bean.getCOD_AZL(), attivita.COD_MAN);
                            
                            int misureCount = listaMisurePP.isEmpty()
                                    ?1:listaMisurePP.size();
                                    
                            // scrivo l'attività
                            rischioMansioneTable.addCell
                                    (Formatter.format(attivita.NOM_MAN), 8, 1, misureCount);
                            
                            // scorro le misure di prevenzione e protezione...
                            boolean writeValoriRischio = true;
                            for (Rischio4AttivitaLavorative_View misura : listaMisurePP) {
                                rischioMansioneTable.addCellB(Formatter.format(misura.NOM_MIS_PET), 8);
                                
                                if (writeValoriRischio){
                                    rischioMansioneTable.toCenter();
                                    rischioMansioneTable.addCell(Formatter.format(attivita.lPRB_EVE_LES), 8, 1, misureCount);
                                    rischioMansioneTable.addCell(Formatter.format(attivita.lENT_DAN), 8, 1, misureCount);
                                    if (sMOD_CLC_RSO == Azienda_MOD_CLC_RSO.MOD_EXTENDED){
                                        rischioMansioneTable.addCell(Formatter.format(attivita.lFRQ_RIP_ATT_DAN), 8, 1, misureCount);
                                        rischioMansioneTable.addCell(Formatter.format(attivita.lNUM_INC_INF), 8, 1, misureCount);
                                    }
                                    rischioMansioneTable.addCell(Formatter.format(attivita.lSTM_NUM_RSO), 8, 1, misureCount);
                                    rischioMansioneTable.toLeft();
                                }
                                writeValoriRischio = false;
                            }
                        }
                        m_document.add(rischioMansioneTable);
                        
                        /*
                         * Questo controllo evita di inserire una pagina bianca 
                         * quando sono giunto a fine elaborazione,
                         * quando stò cioè trattando l'ultimo: 
                         * RISCHIO / FATTORE DI RISCHIO / CATEGORIA DEL FATTORE DI RISCHIO
                         * 
                         */
                        if (!(categoriaCount == cat_ris_list.size() && 
                            fattoreRischioCount == listaFattori.size() &&
                            rischioCount == listaRischi.size()))
                        {
                            writePage();
                        }
                    }
                }
                closeDocument();
            }
        }
    }
}
