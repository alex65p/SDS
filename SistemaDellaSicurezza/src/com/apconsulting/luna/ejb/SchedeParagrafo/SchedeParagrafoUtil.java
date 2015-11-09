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
import s2s.luna.conf.ApplicationConfigurator;
import s2s.utils.Formatter;

/**
 *
 * @author Dario
 */
class SchedeParagrafoUtil {

    public String BuildSchedeParagrafoTab(ISchedeParagrafoHome home, long lCOD_PRG, long lCOD_AZL, long lCOD_UNI_ORG1111) {
        String TYPE = "";
        String str = "";
        long COD_PAR = 0;
        long CK_VAL = 0;
        String NOM_PAR = "";
        String TYPE_PAR = "";
        long lCOD_MAC = 0;
        long lCOD_UNI_ORG = 0;
        long lCOD_UNI_SIC = 0;
        long lCOD_SOS_CHI = 0;
        long lCOD_MAN = 0;
        long lCOD_LUO_FSC = 0;
        long lCOD_FAT_RSO = 0;
        long lCOD_IMM_3LV = 0;
        long lCOD_PNO = 0;
        long lCOD_MIS_PET = 0;
        long lCOD_RSO = 0;
        long lCOD_SCH_PRG_D = 0;
        java.util.Collection col = home.getSchedeParagrafo_GetType_View_ALL(lCOD_PRG, lCOD_UNI_ORG1111);
        java.util.Collection col1 = new ArrayList(1);
        col1.add(
                TipoParagrafo.ANAGRAFICA_AZIENDA.getType() 
                + "," + TipoParagrafo.VALUTAZIONE_RISCHIO.getType()
                + "," + TipoParagrafo.SCHEDA_RISCHI.getType());

        str = "<table border='0' align='left' width='650' id='SchedeParagrafoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='440'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>";
        str += "<td width='210'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
        str += "</tr>";
        str += "</table>";

        str += "<table border='0' align='left' width='650' id='SchedeParagrafo' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_PRG) + "'>";
        str += "<td class='dataTd'><input type='text' name='NOMINATIVO' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='TIPOLOGIA' class='dataInput' readonly  value=''></td>";
        str += "</tr>";

        java.util.Iterator it = col.iterator();
        SchedeParagrafo_GetType_View obj = null;
        while (it.hasNext()) {
            obj = (SchedeParagrafo_GetType_View) it.next();
            TYPE = obj.TPL_SCH;
            lCOD_MAC = obj.COD_MAC;
            lCOD_UNI_ORG = obj.COD_UNI_ORG;
            lCOD_UNI_SIC = obj.COD_UNI_SIC;
            lCOD_SOS_CHI = obj.COD_SOS_CHI;
            lCOD_MAN = obj.COD_MAN;
            lCOD_LUO_FSC = obj.COD_LUO_FSC;
            lCOD_FAT_RSO = obj.COD_FAT_RSO;
            lCOD_IMM_3LV = obj.COD_IMM_3LV;
            lCOD_PNO = obj.COD_PNO;
            lCOD_MIS_PET = obj.COD_MIS_PET;
            lCOD_RSO = obj.COD_RSO;
            lCOD_SCH_PRG_D = obj.COD_SCH_PRG;

            if (TYPE.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType())
                    || TYPE.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                col1 = home.getSchedeParagrafo_MAC_View(lCOD_AZL, lCOD_MAC);
            } else if (TYPE.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType())
                    || TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                col1 = home.getSchedeParagrafo_UNI_ORG_View(lCOD_AZL, lCOD_UNI_ORG);
            } else if (TYPE.equals(TipoParagrafo.UNITA_SICUREZZA.getType())
                    || TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                col1 = home.getSchedeParagrafo_UNI_SIC_View(lCOD_AZL, lCOD_UNI_SIC);
            } else if (TYPE.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                col1 = home.getSchedeParagrafo_SOS_CHI_View(lCOD_AZL, lCOD_SOS_CHI);
            } else if (TYPE.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType())
                    || TYPE.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                col1 = home.getSchedeParagrafo_MAN_View(lCOD_AZL, lCOD_MAN);
            } else if (TYPE.equals(TipoParagrafo.LUOGO_FISICO.getType())
                    || TYPE.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                col1 = home.getSchedeParagrafo_LUO_FSC_View(lCOD_AZL, lCOD_LUO_FSC);
            } else if (TYPE.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                col1 = home.getSchedeParagrafo_FAT_RSO_View(lCOD_AZL, lCOD_FAT_RSO);
            } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                col1 = home.getSchedeParagrafo_IMM_3LV_View(lCOD_AZL, lCOD_IMM_3LV);
            } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                col1 = home.getSchedeParagrafo_PNO_View(lCOD_AZL, lCOD_PNO);
            } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                col1 = home.getSchedeParagrafo_MIS_PET_View(lCOD_AZL, lCOD_MIS_PET);
            } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                col1 = home.getSchedeParagrafo_RSO_View(lCOD_AZL, lCOD_RSO);
            }

            java.util.Iterator it1 = col1.iterator();
            java.util.Collection colprg = home.getSchedeParagrafo_ByPRG_View(lCOD_PRG, TYPE);

            while (it1.hasNext()) {
                if (TYPE.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType())
                        || TYPE.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                    SchedeParagrafo_MAC_View rst = (SchedeParagrafo_MAC_View) it1.next();
                    COD_PAR = rst.COD_MAC;
                    NOM_PAR = rst.DES_MAC;
                    if (TYPE.equals(TipoParagrafo.MACCHINA_ATTREZZATURA.getType())) {
                        TYPE_PAR = TipoParagrafo.MACCHINA_ATTREZZATURA.getTableColumnLabel();
                    } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType())) {
                        TYPE_PAR = TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getTableColumnLabel();
                    }
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_MAC) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType())
                        || TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                    SchedeParagrafo_UNI_ORG_View rst = (SchedeParagrafo_UNI_ORG_View) it1.next();
                    COD_PAR = rst.COD_UNI_ORG;
                    NOM_PAR = rst.NOM_UNI_ORG;
                    if (TYPE.equals(TipoParagrafo.UNITA_ORGANIZZATIVA.getType())) {
                        TYPE_PAR = TipoParagrafo.UNITA_ORGANIZZATIVA.getTableColumnLabel();
                    } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType())) {
                        TYPE_PAR = TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getTableColumnLabel();
                    }
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_UNI_ORG) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.UNITA_SICUREZZA.getType())
                        || TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                    SchedeParagrafo_UNI_SIC_View rst = (SchedeParagrafo_UNI_SIC_View) it1.next();
                    COD_PAR = rst.COD_UNI_SIC;
                    NOM_PAR = rst.NOM_UNI_SIC;
                    if (TYPE.equals(TipoParagrafo.UNITA_SICUREZZA.getType())) {
                        TYPE_PAR = TipoParagrafo.UNITA_SICUREZZA.getTableColumnLabel();
                    } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType())) {
                        TYPE_PAR = TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getTableColumnLabel();
                    }
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_UNI_SIC) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.SOSTANZA_CHIMICA.getType())) {
                    SchedeParagrafo_SOS_CHI_View rst = (SchedeParagrafo_SOS_CHI_View) it1.next();
                    COD_PAR = rst.COD_SOS_CHI;
                    NOM_PAR = rst.NOM_COM_SOS;
                    TYPE_PAR = TipoParagrafo.SOSTANZA_CHIMICA.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_SOS_CHI) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType())
                        || TYPE.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                    SchedeParagrafo_MAN_View rst = (SchedeParagrafo_MAN_View) it1.next();
                    COD_PAR = rst.COD_MAN;
                    NOM_PAR = rst.NOM_MAN;
                    if (TYPE.equals(TipoParagrafo.ATTIVITA_LAVORATIVA.getType())) {
                        TYPE_PAR = TipoParagrafo.ATTIVITA_LAVORATIVA.getTableColumnLabel();
                    } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType())) {
                        TYPE_PAR = TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getTableColumnLabel();
                    }
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_MAN) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.LUOGO_FISICO.getType())
                        || TYPE.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                    SchedeParagrafo_LUO_FSC_View rst = (SchedeParagrafo_LUO_FSC_View) it1.next();
                    COD_PAR = rst.COD_LUO_FSC;
                    NOM_PAR = rst.NOM_LUO_FSC;
                    if (TYPE.equals(TipoParagrafo.LUOGO_FISICO.getType())) {
                        TYPE_PAR = TipoParagrafo.LUOGO_FISICO.getTableColumnLabel();
                    } else if (TYPE.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType())) {
                        TYPE_PAR = TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getTableColumnLabel();
                    }
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_LUO_FSC) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.FATTORE_DI_RISCHIO.getType())) {
                    SchedeParagrafo_FAT_RSO_View rst = (SchedeParagrafo_FAT_RSO_View) it1.next();
                    COD_PAR = rst.COD_FAT_RSO;
                    NOM_PAR = rst.NOM_FAT_RSO;
                    TYPE_PAR = TipoParagrafo.FATTORE_DI_RISCHIO.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_FAT_RSO) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType())) {
                    SchedeParagrafo_IMM_3LV_View rst = (SchedeParagrafo_IMM_3LV_View) it1.next();
                    COD_PAR = rst.COD_IMM;
                    NOM_PAR = rst.NOM_IMM;
                    TYPE_PAR = TipoParagrafo.DESCRIZIONI_IMMOBILI.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_IMM_3LV) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType())) {
                    SchedeParagrafo_PNO_View rst = (SchedeParagrafo_PNO_View) it1.next();
                    COD_PAR = rst.COD_PNO;
                    NOM_PAR = rst.NOM_PNO;
                    TYPE_PAR = TipoParagrafo.DESCRIZIONI_PIANI.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_PNO) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType())) {
                    SchedeParagrafo_MIS_PET_View rst = (SchedeParagrafo_MIS_PET_View) it1.next();
                    COD_PAR = rst.COD_MIS_PET;
                    NOM_PAR = rst.NOM_MIS_PET;
                    TYPE_PAR = TipoParagrafo.DESCRIZIONI_MISURA_PP.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_MIS_PET) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType())) {
                    SchedeParagrafo_RSO_View rst = (SchedeParagrafo_RSO_View) it1.next();
                    COD_PAR = rst.COD_RSO;
                    NOM_PAR = rst.NOM_RSO;
                    TYPE_PAR = TipoParagrafo.DESCRIZIONI_RISCHI.getTableColumnLabel();
                    java.util.Iterator itprg = colprg.iterator();
                    while (itprg.hasNext()) {
                        SchedeParagrafo_ByPRG_View rstprg = (SchedeParagrafo_ByPRG_View) itprg.next();
                        if (COD_PAR == rstprg.COD_RSO) {
                            CK_VAL = rstprg.COD_SCH_PRG;
                        }
                    }
                } else
                if (TYPE.equals(TipoParagrafo.ANAGRAFICA_AZIENDA.getType())) {
                    CK_VAL = lCOD_SCH_PRG_D;
                    NOM_PAR = TipoParagrafo.ANAGRAFICA_AZIENDA.getSchedaLabel();
                    TYPE_PAR = TipoParagrafo.ANAGRAFICA_AZIENDA.getTableColumnLabel();
                    it1.next();
                } else
                if (TYPE.equals(TipoParagrafo.VALUTAZIONE_RISCHIO.getType())) {
                    CK_VAL = lCOD_SCH_PRG_D;
                    NOM_PAR = TipoParagrafo.VALUTAZIONE_RISCHIO.getSchedaLabel();
                    TYPE_PAR = TipoParagrafo.VALUTAZIONE_RISCHIO.getTableColumnLabel();
                    it1.next();
                } else
                if (TYPE.equals(TipoParagrafo.SCHEDA_RISCHI.getType())) {
                    CK_VAL = lCOD_SCH_PRG_D;
                    NOM_PAR = TipoParagrafo.SCHEDA_RISCHI.getSchedaLabel();
                    TYPE_PAR = TipoParagrafo.SCHEDA_RISCHI.getTableColumnLabel();
                    it1.next();
                }
                str += "<tr ID='" + CK_VAL + "' INDEX='" + Formatter.format(lCOD_PRG) + "'>";
                str += "<td class='1dataTd'><input name='NOM_PAR' type='text' style='width: 440px;' readonly class='dataInput' size='48'  value=\"" + NOM_PAR + "\"></td>";
                str += "<td class='1dataTd'><input name='TYPE_PAR' type='text' style='width: 210px;' readonly class='dataInput' size='5'  value=\"" + TYPE_PAR + "\"></td>";
                str += "</tr>";
            }
        }
        str += "</table>";
        return str;
    }
}
