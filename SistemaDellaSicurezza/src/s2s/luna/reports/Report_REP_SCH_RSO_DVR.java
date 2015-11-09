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

import com.apconsulting.luna.ejb.Azienda.IAzienda;
import com.apconsulting.luna.ejb.Azienda.IAziendaHome;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.CategorioRischio_Name_Address_View;
import com.apconsulting.luna.ejb.CategorieFattoreRischio.ICategorioRischioHome;
import com.apconsulting.luna.ejb.Rischio.IRischioHome;
import com.apconsulting.luna.ejb.Rischio.RischioMisurePp_Nome_Descrizione_View;
import com.apconsulting.luna.ejb.Rischio.Rischio_Nome_Fattore_View;
import com.lowagie.text.BadElementException;
import com.lowagie.text.DocumentException;
import java.io.IOException;
import java.util.Collection;
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
public class Report_REP_SCH_RSO_DVR extends Report {
    
    public long lCOD_AZL = 0;
    
    public Report_REP_SCH_RSO_DVR(long lCOD_AZL) {
        this.lCOD_AZL = lCOD_AZL;
    }
    
    @Override
    public void doReport() throws DocumentException, IOException, BadElementException, Exception {
        SecurityWrapper Security = SecurityWrapper.getInstance();
        IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
        IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));
        
        initDocument("the doc", null,
                ApplicationConfigurator.LanguageManager.getString("Scheda.rischi"),
                bean.getRAG_SCL_AZL(), null);
        
        writeIndent();
        {
            // Intestazione generale
            CenterMiddleTable tblTopHeader = new CenterMiddleTable(1);
            tblTopHeader.toCenter();
            tblTopHeader.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scheda.rischi").toUpperCase());
            m_document.add(tblTopHeader);
            writeLine();

            // Categorie dei fattori di rischio.
            ICategorioRischioHome home_cr = (ICategorioRischioHome) PseudoContext.lookup("CategorioRischioBean");
            Collection<CategorioRischio_Name_Address_View> cat_ris_list = home_cr.getCategorieWithRischi_View(lCOD_AZL);
            for (CategorioRischio_Name_Address_View categoria : cat_ris_list) {
                writeParagrafo(Formatter.format(categoria.NOM_CAG_FAT_RSO));
                writeLine();
                
                // Rischi
                IRischioHome home_rso = (IRischioHome) PseudoContext.lookup("RischioBean");
                Collection<Rischio_Nome_Fattore_View> listaRischi =
                        home_rso.getRischio4CAG_FAT_RSO_View(lCOD_AZL, categoria.COD_CAG_FAT_RSO);
                for (Rischio_Nome_Fattore_View rischio : listaRischi) {
                    writeText2Bold(Formatter.format(rischio.strNOM_RSO));
                    writeText2(Formatter.format(rischio.strDES_RSO));
                    
                    // Misure di prevenzione e protezione
                    Collection<RischioMisurePp_Nome_Descrizione_View> listaMisure =
                            home_rso.getMisurePpView(rischio.lCOD_RSO, lCOD_AZL);
                    for (RischioMisurePp_Nome_Descrizione_View misura : listaMisure) {
                        writeText3(Formatter.format(misura.strNOM_MIS_PET),5);
                    }
                    writeLine();
                }
                closeDocument();
            }
        }
    }
}
