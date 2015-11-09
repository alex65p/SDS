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
package com.apconsulting.luna.ejb.AnagrLuoghiFisici;

import java.util.ArrayList;
import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IAnagrLuoghiFisici extends EJBObject {
//   *Require Fields*
//1 COD_LUO_FSC (AnagrLuoghiFisici ID)

    public long getCOD_LUO_FSC();

    public String getsCOD_LUO_FSC();
//2 NOM_LUO_FSC (Ragione Sociale)

    public String getNOM_LUO_FSC();

    public void setNOM_LUO_FSC(String newNOM_LUO_FSC);
//3

    public void setCOD_SIT_AZL(long newCOD_SIT_AZL);

    public long getCOD_SIT_AZL();
//4

    public void setCOD_AZL(long newCOD_AZL);

    public long getCOD_AZL();
//-----------------------------
//5

    public void setCOD_ALA(long newCOD_ALA);

    public long getCOD_ALA();
//6

    public void setCOD_IMO(long newCOD_IMO);

    public long getCOD_IMO();


    public void setCOD_IMM_3LV(long newCOD_IMM_3LV);

    public long getCOD_IMM_3LV();

//7

    public void setCOD_PNO(long newCOD_PNO);

    public long getCOD_PNO();
//8

    public String getDES_LUO_FSC();

    public void setDES_LUO_FSC(String newDES_LUO_FSC);
//9

    public String getQLF_RSP_LUO_FSC();

    public void setQLF_RSP_LUO_FSC(String newQLF_RSP_LUO_FSC);
//10

    public String getNOM_RSP_LUO_FSC();

    public void setNOM_RSP_LUO_FSC(String newNOM_RSP_LUO_FSC);
//11

    public String getIDZ_PSA_ELT_RSP_LUO_FSC();

    public void setIDZ_PSA_ELT_RSP_LUO_FSC(String newIDZ_PSA_ELT_RSP_LUO_FSC);
//12

    public String getFLG_IMP();

    public void setFLG_IMP(String newFLG_IMP);
//13

    public void addDocumento(long l);

    public void removeDocumento(long l);

    public void addMacchine(long l);

    public void removeMacchine(long l, long lCOD_AZL);
//

    public Collection getRischiByLuoghiFisiciView(long lCOD_AZL);

    public Collection getInfortuniIncidentiView();

    public Collection getDpiView();

    public Collection getCorsiView();

    public Collection getDocumentiView();
//

    public void addLUO_FSC_COR(long lCOD_COR, java.sql.Date dDAT_INZ);

    public void addLUO_FSC_DPI(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ);

    public void addLUO_FSC_PRO_SAN(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ);

//<report>
    public Collection getReportAnagrLuoghiFisici_Rischi_View();
//</report>

    public boolean isMultiple();

    public void store(
            long lCOD_SIT_AZL,
            long lCOD_AZL,
            String strNOM_LUO_FSC,
            long lCOD_IMO,
            long lCOD_IMM_3LV,
            long lCOD_PNO,
            long lCOD_ALA,
            String strDES_LUO_FSC,
            String strNOM_RSP_LUO_FSC,
            String strQLF_RSP_LUO_FSC,
            String strIDZ_PSA_ELT_RSP_LUO_FSC,
            String strFLG_IMP,
            ArrayList alAziende);
}
