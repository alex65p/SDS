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

import com.apconsulting.luna.ejb.AssociativaAgentoChimico.Documenti_View;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.FrasiR_View;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.FrasiS_View;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.IAssociativaAgentoChimico;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.IAssociativaAgentoChimicoHome;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.LuoghiFisici_View;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.NormSent_View;
import com.apconsulting.luna.ejb.AssociativaAgentoChimico.ReportRischi_View;
import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.Simbolo.ISimbolo;
import com.apconsulting.luna.ejb.Simbolo.ISimboloHome;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import java.io.IOException;
import java.util.Iterator;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.util.SecurityWrapper;
import s2s.report.CenterMiddleTable;
import s2s.report.Report;
import s2s.utils.plain.Formatter;

/**
 *
 * @author Dario
 */
public class Report_REP_SOS_CHI extends Report {

    public long lCOD_SOS_CHI = 0;
    private boolean IncludeLogo = true;

    public Report_REP_SOS_CHI(long lCOD_SOS_CHI) {
        this.lCOD_SOS_CHI = lCOD_SOS_CHI;
    }

    public Report_REP_SOS_CHI(long lCOD_SOS_CHI, boolean _IncludeLogo) {
        this(lCOD_SOS_CHI);
        this.IncludeLogo = _IncludeLogo;
    }

    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------

        SecurityWrapper Security = SecurityWrapper.getInstance();
        long lTemp = 0;
        IAssociativaAgentoChimicoHome home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
        IAssociativaAgentoChimico bean = home.findByPrimaryKey(new Long(lCOD_SOS_CHI));

        lCOD_AZL = Security.getAziendaR();
        IAziendaHome home_az = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean_az = home_az.findByPrimaryKey(new Long(lCOD_AZL));

        initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.SOSTANZA.CHIMICA"), bean_az.getRAG_SCL_AZL(), bean.getNOM_COM_SOS());
        if (IncludeLogo) {
            AddImage();
        }

        //writeTitle(bean_lf.getNOM_LUO_FSC());
        writeIndent();
        {
            CenterMiddleTable tbl = new CenterMiddleTable(1);
            if (bStandAlone) {
                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                tbl.addCell(bean_az.getRAG_SCL_AZL());
            }

            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.SOSTANZA.CHIMICA"));
            tbl.addTitleCell(bean.getNOM_COM_SOS());
            m_document.add(tbl);
        }
        {
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            tbl.toLeft();
            int width[] = {20, 80};
            tbl.setWidths(width);
            tbl.setDefaultColspan(2);
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"), 2);
            tbl.setDefaultColspan(1);

            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
            tbl.addCell(bean.getDES_SOS());
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Classificazione"));
            tbl.addCell(Formatter.format(bean.getCOD_STA_FSC()));
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Simbolo"));
            tbl.addCell(Formatter.format(bean.getSIM_RIS()));
            tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione.del.simbolo"));
            lTemp = bean.getCOD_SIM();
            if (lTemp != 0) {
                ISimboloHome h = (ISimboloHome) PseudoContext.lookup("SimboloBean");
                ISimbolo b = h.findByPrimaryKey(new Long(lTemp));
                tbl.addCell(Formatter.format(b.getDES_SIM()));
            } else {
                tbl.addCell("");
            }
            m_document.add(tbl);
        }
        {//Frase R.
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            int width[] = {20, 80};
            tbl.setWidths(width);
            tbl.toLeft();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Frase.R"), 2);
            tbl.endHeaders();

            Iterator it = home.getFrasiR_View(lCOD_SOS_CHI).iterator();
            while (it.hasNext()) {
                FrasiR_View w = (FrasiR_View) it.next();
                tbl.addCell(w.NUM_FRS_R);
                tbl.addCell(w.DES_FRS_R);
            }
            m_document.add(tbl);
        }
        {// Frase S
            CenterMiddleTable tbl = new CenterMiddleTable(2);
            int width[] = {20, 80};
            tbl.setWidths(width);
            tbl.toLeft();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Frase.S"), 2);
            tbl.endHeaders();

            Iterator it = home.getFrasiS_View(lCOD_SOS_CHI).iterator();
            while (it.hasNext()) {
                FrasiS_View w = (FrasiS_View) it.next();
                tbl.addCell(w.NUM_FRS_S);
                tbl.addCell(w.DES_FRS_S);
            }
            m_document.add(tbl);
        }
        int width[] = {62, 19, 19};
        {//Luoghi fisici
            CenterMiddleTable tbl = new CenterMiddleTable(3);
            tbl.setWidths(width);
            tbl.toLeft();
            //tbl.setDefaultColspan();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici.di.utilizzo.della.sostanza"));
            tbl.toCenter();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Qtà.in.uso"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Qtà.in.giacenza"));
            tbl.endHeaders();

            Iterator it = home.getLuoghiFisici_View(lCOD_SOS_CHI, lCOD_AZL).iterator();
            while (it.hasNext()) {
                LuoghiFisici_View w = (LuoghiFisici_View) it.next();
                tbl.toLeft();
                tbl.addCell(w.NOM_LUO_FSC);
                tbl.toCenter();
                tbl.addCell(Formatter.format(w.QTA_USO));
                tbl.addCell(Formatter.format(w.QTA_GIA));
            }
            m_document.add(tbl);
        }
        {//Normative sentenze
            CenterMiddleTable tbl = new CenterMiddleTable(3);

            tbl.setWidths(width);
            tbl.toLeft();
            //tbl.setDefaultColspan();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Normative.e.sentenze.emesse.per.la.sostanza"));
            tbl.toCenter();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("N.Documento"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.documento"));
            tbl.endHeaders();

            Iterator it = home.getNormSent_View(lCOD_SOS_CHI).iterator();
            while (it.hasNext()) {
                NormSent_View w = (NormSent_View) it.next();
                tbl.toLeft();
                tbl.addCell(w.TIT_NOR_SEN);
                tbl.toCenter();
                tbl.addCell(w.NUM_DOC_NOR_SEN);
                tbl.addCell(Formatter.format(w.DAT_NOR_SEN));
            }
            m_document.add(tbl);
        }
        {//Rischi
            CenterMiddleTable tbl = new CenterMiddleTable(3);

            tbl.setWidths(width);
            tbl.toLeft();
            //tbl.setDefaultColspan();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Classificazione.dei.rischi.associati"));
            tbl.toCenter();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Entità.danno"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rif.Valut."));
            tbl.endHeaders();

            Iterator it = home.getReportRischi_View(lCOD_AZL, lCOD_SOS_CHI).iterator();
            while (it.hasNext()) {
                ReportRischi_View w = (ReportRischi_View) it.next();
                tbl.toLeft();
                tbl.addCell(w.strCLF_RSO);
                tbl.toCenter();
                tbl.addCell(Formatter.format(w.lENT_DAN));
                tbl.addCell(Formatter.format(w.lRFC_VLU_RSO_MES));
            }
            m_document.add(tbl);
        }
        {//Documenti
            CenterMiddleTable tbl = new CenterMiddleTable(3);

            tbl.setWidths(width);
            tbl.toLeft();
            //tbl.setDefaultColspan();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Documenti.associati"));
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
            tbl.toCenter();
            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Rev.Doc."));
            tbl.endHeaders();

            Iterator it = home.getDocumenti_View(lCOD_SOS_CHI).iterator();
            while (it.hasNext()) {
                Documenti_View w = (Documenti_View) it.next();
                tbl.toLeft();
                tbl.addCell(Formatter.format(w.TIT_DOC));
                tbl.toCenter();
                tbl.addCell(Formatter.format(w.RSP_DOC));
                tbl.addCell(Formatter.format(w.DAT_REV_DOC));
                if (true) {
                    continue;
                }

                //tbl.addCell();
                //tbl.toCenter();
                //tbl.addCell();
                //tbl.addCell("");
            }
            m_document.add(tbl);
        }
        closeDocument();
    }
}
