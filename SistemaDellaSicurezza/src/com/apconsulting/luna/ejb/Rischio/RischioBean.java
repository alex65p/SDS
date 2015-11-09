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
package com.apconsulting.luna.ejb.Rischio;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class RischioBean extends BMPEntityBean implements IRischio, IRischioHome {
    //<member-varibles description="Member Variables">

    long lCOD_AZL;
    long lCOD_RSO;
    String strNOM_RSO;
    String strDES_RSO;
    java.sql.Date dtDAT_RIL;
    String strNOM_RIL_RSO;
    String strCLF_RSO;
    long lPRB_EVE_LES;
    long lENT_DAN;
    long lFRQ_RIP_ATT_DAN;
    long lNUM_INC_INF;
    float lSTM_NUM_RSO;
    long lRFC_VLU_RSO_MES;
    long lCOD_FAT_RSO;
    long lCOD_RSO_RPO;
    RischioPK primaryKEY;
    //</member-varibles>
    //<IRischioHome-implementation>
    public static final String BEAN_NAME = "RischioBean";
    static final boolean THROW_ASSOCIATE_EXCEPTION = false;
    private static RischioBean ys = null;

    private RischioBean() {
    }

    public static RischioBean getInstance() {
        if (ys == null) {
            ys = new RischioBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        RischioBean bean = new RischioBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((RischioPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public void remove(Object primaryKey, java.util.ArrayList alAziende) {
        RischioBean bean = new RischioBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((RischioPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove(alAziende);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public IRischio create(
            long lCOD_AZL, String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO,
            long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN,
            long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES,
            long lCOD_FAT_RSO, long lCOD_RSO_RPO,
            java.util.ArrayList alAziende) throws javax.ejb.CreateException {
        RischioBean bean = new RischioBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, strNOM_RSO, strDES_RSO, dtDAT_RIL,
                    strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN,
                    lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO,
                    lRFC_VLU_RSO_MES, lCOD_FAT_RSO, lCOD_RSO_RPO, alAziende);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, strNOM_RSO, strDES_RSO, dtDAT_RIL,
                    strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN,
                    lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO,
                    lRFC_VLU_RSO_MES, lCOD_FAT_RSO, lCOD_RSO_RPO, alAziende);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IRischio findByPrimaryKey(RischioPK primaryKey) throws javax.ejb.FinderException {
        RischioBean bean = new RischioBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll(long lAzienda) throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll(lAzienda);
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_OPE_SVO, long lCOD_RSO) {
        return this.ejbGetReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(lCOD_AZL, lCOD_OPE_SVO, lCOD_RSO);
    }

    public Collection getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_RSO) {
        return this.ejbGetReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(lCOD_AZL, lCOD_RSO);
    }

    public Collection getReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_OPE_SVO, long lCOD_MON, long lCOD_AZL) {
        return this.ejbGetReportRischioSostanzeChimiche_View(lCOD_RSO, lCOD_OPE_SVO, lCOD_MON, lCOD_AZL);
    }

    public Collection getReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_MON) {
        return this.ejbGetReportRischioSostanzeChimiche_View(lCOD_RSO, lCOD_MON);
    }

    public Collection getRischio_Nome_Fattore_View(long lAzienda) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_Nome_Fattore_View(lAzienda);
    }

    public Collection getRischio_Nome_Fattore_ComboBox(long lAzienda) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_Nome_Fattore_ComboBox(lAzienda);
    }

    public Collection getRischio_ComboBox(long lAzienda, long lCOD_FAT_RSO) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_ComboBox(lAzienda, lCOD_FAT_RSO);
    }
    //-------------

    public Collection getRischio_MAN_ComboBox(long lAzienda, String strNOM, String strCLF) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_MAN_ComboBox(lAzienda, strNOM, strCLF);
    }

    public Collection getRischio_LUO_FSC_ComboBox(long lAzienda, String strNOM, String strCLF) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_LUO_FSC_ComboBox(lAzienda, strNOM, strCLF);
    }

    public Collection getRischio_MAN_LUO_FSC_ComboBox(long lAzienda) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_MAN_LUO_FSC_ComboBox(lAzienda);
    }
    //

    //<report alex lst_rso>
    public Collection getRischiRepositoryView(long lCOD_FAT_RSO) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischiRepositoryView(lCOD_FAT_RSO);
    }
    //

    public Collection getRischio4CAG_FAT_RSO_View(long lCOD_AZL, long lCOD_CAG_FAT_RSO) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio4CAG_FAT_RSO_View(lCOD_AZL, lCOD_CAG_FAT_RSO);
    }

    public Collection getRischio_foo_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDAT_RFC_VLU_RSO_DAL, dtDAT_RFC_VLU_RSO_AL, strTIP_RSO, strRG_GROUP, strVAR_RIV);
    }

    public Collection getRischio_collection_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_collection_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDAT_RFC_VLU_RSO_DAL, dtDAT_RFC_VLU_RSO_AL, strTIP_RSO, strRG_GROUP, strVAR_RIV);
    }

    public Collection getRischio_Elenco_View(long lCOD_AZL, String strAPL_A, long lCOD_MIS_PET_LUO_MAN) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_Elenco_View(lCOD_AZL, strAPL_A, lCOD_MIS_PET_LUO_MAN);
    }

    public Collection getRischio_CRM_RSO_View(String strNOM, long lCOD_AZL) {
        RischioBean bean = new RischioBean();
        return bean.ejbGetRischio_CRM_RSO_View(strNOM, lCOD_AZL);
    }

    public boolean checkRischio_ByName(String strNOM, long lCOD_AZL) {
        RischioBean bean = new RischioBean();
        return bean.ejbCheckRischio_ByName(strNOM, lCOD_AZL);
    }

    public boolean caricaDbRischi(long P_COD_AZL, long P_COD_RSO) {
        RischioBean bean = new RischioBean();
        return bean.ejbCaricaDbRischi(P_COD_AZL, P_COD_RSO);
    }

    public boolean caricaRpRischi(long P_COD_AZL, String P_NOM_RSO) {
        RischioBean bean = new RischioBean();
        return bean.ejbCaricaRpRischi(P_COD_AZL, P_NOM_RSO);
    }
//---------------------

    public Collection ejbFindAll(long lAzienda) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_rso FROM ana_rso_tab WHERE cod_azl=? ");
            ps.setLong(1, lAzienda);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public RischioPK ejbFindByPrimaryKey(RischioPK primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.primaryKEY = ((RischioPK) this.getEntityKey());
        this.lCOD_RSO = primaryKEY.lCOD_RSO;
        this.lCOD_AZL = primaryKEY.lCOD_AZL;
    }

    public void ejbPassivate() {
        this.primaryKEY = null;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl,cod_rso,nom_rso,des_rso,dat_ril,nom_ril_rso,clf_rso,prb_eve_les,ent_dan,stm_num_rso,rfc_vlu_rso_mes,cod_fat_rso,cod_rso_rpo,frq_rip_att_dan,num_inc_inf FROM ana_rso_tab WHERE cod_rso=?  AND cod_azl=? ");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_AZL = rs.getLong(1);
                lCOD_RSO = rs.getLong(2);
                strNOM_RSO = rs.getString(3);
                strDES_RSO = rs.getString(4);
                dtDAT_RIL = rs.getDate(5);
                strNOM_RIL_RSO = rs.getString(6);
                strCLF_RSO = rs.getString(7);
                lPRB_EVE_LES = rs.getLong(8);
                lENT_DAN = rs.getLong(9);
                lSTM_NUM_RSO = rs.getFloat(10);
                lRFC_VLU_RSO_MES = rs.getLong(11);
                lCOD_FAT_RSO = rs.getLong(12);
                lCOD_RSO_RPO = rs.getLong(13);
                lFRQ_RIP_ATT_DAN = rs.getLong(14);
                lNUM_INC_INF = rs.getLong(15);
            } else {
                throw new NoSuchEntityException("Rischio with ID=" + lCOD_RSO + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        ejbRemove(null);
    }

    public void ejbRemove(java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_rso_tab WHERE cod_rso=? AND ( cod_azl=? OR cod_azl IN (" + toString(alAziende) + ") )");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio with ID=" + lCOD_RSO + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public RischioPK ejbCreate(long lCOD_AZL, String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES, long lCOD_FAT_RSO, long lCOD_RSO_RPO, java.util.ArrayList alAziende) {
        this.lCOD_RSO = NEW_ID();
        this.lCOD_AZL = lCOD_AZL;
        this.strNOM_RSO = strNOM_RSO;
        this.strDES_RSO = strDES_RSO;
        this.dtDAT_RIL = dtDAT_RIL;
        this.strNOM_RIL_RSO = strNOM_RIL_RSO;
        this.strCLF_RSO = strCLF_RSO;
        this.lPRB_EVE_LES = lPRB_EVE_LES;
        this.lENT_DAN = lENT_DAN;
        this.lFRQ_RIP_ATT_DAN = lFRQ_RIP_ATT_DAN;
        this.lNUM_INC_INF = lNUM_INC_INF;
        this.lSTM_NUM_RSO = lSTM_NUM_RSO;
        this.lRFC_VLU_RSO_MES = lRFC_VLU_RSO_MES;
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;
        this.lCOD_RSO_RPO = lCOD_RSO_RPO;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_rso_tab "
                    + "(cod_rso, "
                    + "cod_azl, "
                    + "nom_rso, "
                    + "des_rso, "
                    + "dat_ril, "
                    + "nom_ril_rso, "
                    + "clf_rso, "
                    + "prb_eve_les, "
                    + "ent_dan, "
                    + "stm_num_rso, "
                    + "rfc_vlu_rso_mes, "
                    + "cod_fat_rso, "
                    + "cod_rso_rpo, "
                    + "frq_rip_att_dan, "
                    + "num_inc_inf) "
                    + "VALUES "
                    + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strNOM_RSO);
            ps.setString(4, strDES_RSO);
            ps.setDate(5, dtDAT_RIL);
            ps.setString(6, strNOM_RIL_RSO);
            ps.setString(7, strCLF_RSO);
            ps.setLong(8, lPRB_EVE_LES);
            ps.setLong(9, lENT_DAN);
            ps.setFloat(10, lSTM_NUM_RSO);
            ps.setLong(11, lRFC_VLU_RSO_MES);
            ps.setLong(12, lCOD_FAT_RSO);
            ps.setLong(13, lCOD_RSO_RPO);
            ps.setLong(14, lFRQ_RIP_ATT_DAN);
            ps.setLong(15, lNUM_INC_INF);
            ps.executeUpdate();

            Iterator it = alAziende.iterator();
            while (it.hasNext()) {
                long cod_azl = ((Long) it.next()).longValue();
                if (cod_azl == lCOD_AZL) {
                    continue;
                }
                createSecurityObject(bmp, lCOD_RSO, cod_azl);
                ps.setLong(2, cod_azl);
                ps.executeUpdate();
            }
            bmp.commitTrans();
            return new RischioPK(lCOD_AZL, lCOD_RSO);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lCOD_AZL, String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES, long lCOD_FAT_RSO, long lCOD_RSO_RPO, java.util.ArrayList alAziende) {
    }

    public boolean isMultiple() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT COUNT(*) FROM ana_rso_tab WHERE cod_rso=? ");
            ps.setLong(1, lCOD_RSO);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            }
            return rs.getLong(1) > 1;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        store(strNOM_RSO, strDES_RSO, dtDAT_RIL, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, lRFC_VLU_RSO_MES, lCOD_FAT_RSO, null);
    }

    public void store(String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES, long lCOD_FAT_RSO, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_rso_tab SET nom_rso=?, des_rso=?, dat_ril=?, nom_ril_rso=?, clf_rso=?, prb_eve_les=?, ent_dan=?, stm_num_rso=?, rfc_vlu_rso_mes=?, cod_fat_rso=?, cod_rso_rpo=?, frq_rip_att_dan=?, num_inc_inf=? WHERE cod_rso=? AND (cod_azl=? OR cod_azl IN (" + toString(alAziende) + "))");
            ps.setString(1, strNOM_RSO);
            ps.setString(2, strDES_RSO);
            ps.setDate(3, dtDAT_RIL);
            ps.setString(4, strNOM_RIL_RSO);
            ps.setString(5, strCLF_RSO);
            ps.setLong(6, lPRB_EVE_LES);
            ps.setLong(7, lENT_DAN);
            ps.setFloat(8, lSTM_NUM_RSO);
            ps.setLong(9, lRFC_VLU_RSO_MES);
            ps.setLong(10, lCOD_FAT_RSO);
            if (lCOD_RSO_RPO == 0) {
                ps.setNull(11, java.sql.Types.BIGINT);
            } else {
                ps.setLong(11, lCOD_RSO_RPO);
            }
            ps.setLong(12, lFRQ_RIP_ATT_DAN);
            ps.setLong(13, lNUM_INC_INF);
            ps.setLong(14, lCOD_RSO);
            ps.setLong(15, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio with ID=" + lCOD_RSO + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<object-methods>
    public Collection ejbGetReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_OPE_SVO, long lCOD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                    + "C.COD_MAC, "
                    + "C.MDL_MAC, "
                    + "C.DES_MAC "
                    + "FROM "
                    + "RSO_MAC_TAB A, "
                    + "MAC_OPE_SVO_TAB B, "
                    + "ANA_MAC_TAB C "
                    + "WHERE "
                    + "A.COD_MAC = B.COD_MAC "
                    + "AND B.COD_MAC = C.COD_MAC "
                    + "AND A.COD_AZL = C.COD_AZL "
                    + "AND A.COD_MAC = C.COD_MAC "
                    + "AND A.COD_AZL = ? "
                    + "AND B.COD_OPE_SVO = ? "
                    + "AND A.COD_RSO = ? "
                    + "ORDER BY "
                    + "C.MDL_MAC");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_OPE_SVO);
            ps.setLong(3, lCOD_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View v = new ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View();
                v.lCOD_MAC = rs.getLong(1);
                v.strMDL_MAC = rs.getString(2);
                v.strDES_MAC = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT distinct "
                    + " e.cod_mac,"
                    + " e.mdl_mac, "
                    + " e.des_mac"
                    + " FROM"
                    + " RSO_MAC_TAB D,"
                    + " ana_mac_tab E,"
                    + " ope_svo_man_tab G,"
                    + " mac_ope_svo_tab H "
                    + " WHERE  "
                    + " d.cod_mac = e.cod_mac"
                    + " and d.cod_mac = h.cod_mac"
                    + " and g.cod_ope_svo = h.cod_ope_svo"
                    + " and h.cod_mac = e.cod_mac"
                    + " and  d.cod_azl = ?"
                    + " and  e.cod_azl = ?"
                    + " and  d.cod_rso = ?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View v = new ReportRischioMachineAttrezzature_Numero_Modelo_Descr_View();
                v.lCOD_MAC = rs.getLong(1);
                v.strMDL_MAC = rs.getString(2);
                v.strDES_MAC = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_OPE_SVO, long lCOD_MON, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                    + "a.cod_sos_chi, "
                    + "a.nom_com_sos, "
                    + "a.des_sos, "
                    + "c.des_sta_fsc, "
                    + "a.frs_r, "
                    + "a.frs_s, "
                    + "e.des_sim "
                    + "FROM "
                    + "ana_sos_chi_tab a "
                    + "LEFT OUTER JOIN ana_sim_tab e "
                    + "ON (a.cod_sim = e.cod_sim), "
                    + "ana_clf_sos_tab b, "
                    + "ana_sta_fsc_tab c, "
                    + "sos_chi_luo_fsc_tab d, "
                    + "rso_sos_chi_tab f, "
                    + "ope_svo_man_tab g, "
                    + "sos_chi_ope_svo_tab h "
                    + "WHERE "
                    + "a.cod_clf_sos = b.cod_clf_sos "
                    + "AND a.cod_sta_fsc = c.cod_sta_fsc "
                    + "AND a.cod_sos_chi = d.cod_sos_chi "
                    + "AND a.cod_sos_chi = f.cod_sos_chi "
                    + "AND g.cod_ope_svo = h.cod_ope_svo "
                    + "AND h.cod_sos_chi = a.cod_sos_chi "
                    + "AND f.cod_azl=? "
                    + "AND g.cod_man=? "
                    + "AND g.cod_ope_svo=? "
                    + "AND f.cod_rso=? "
                    + "ORDER BY "
                    + "a.nom_com_sos");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MON);
            ps.setLong(3, lCOD_OPE_SVO);
            ps.setLong(4, lCOD_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischioSostanzeChimiche_View v = new ReportRischioSostanzeChimiche_View();
                v.lCOD_SOS_CHI = rs.getLong(1);
                v.strNOM_COM_SOS = rs.getString(2);
                v.strDES_SOS_CHI = rs.getString(3);
                v.strDES_STA_FSC = rs.getString(4);
                v.strFRS_R = rs.getString(5);
                v.strFRS_S = rs.getString(6);
                v.strDES_SIM = rs.getString(7);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_MON) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                    + " a.cod_sos_chi,"
                    + " a.nom_com_sos,"
                    + " a.des_sos,"
                    + " c.des_sta_fsc,"
                    + " a.frs_r,"
                    + " a.frs_s,"
                    + " e.des_sim "
                    + " FROM   "
                    + " ana_sos_chi_tab        a,"
                    + " ana_clf_sos_tab        b,"
                    + " ana_sta_fsc_tab     c,"
                    + " sos_chi_luo_fsc_tab d,"
                    + " ana_sim_tab         e,"
                    + " rso_sos_chi_tab     f,"
                    + " ope_svo_man_tab g,"
                    + " sos_chi_ope_svo_tab h  "
                    + " WHERE  a.cod_clf_sos = +b.cod_clf_sos"
                    + " AND    a.cod_sta_fsc = +c.cod_sta_fsc"
                    + " AND    a.cod_sim     = +e.cod_sim"
                    + " AND    a.cod_sos_chi = +d.cod_sos_chi"
                    + " AND    a.cod_sos_chi = +f.cod_sos_chi "
                    + " AND    g.cod_ope_svo = h.cod_ope_svo"
                    + " AND     h.cod_sos_chi = a.cod_sos_chi"
                    + " AND g.cod_man=?"
                    + " AND f.cod_rso=?");
            ps.setLong(1, lCOD_MON);
            ps.setLong(2, lCOD_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischioSostanzeChimiche_View v = new ReportRischioSostanzeChimiche_View();
                v.lCOD_SOS_CHI = rs.getLong(1);
                v.strNOM_COM_SOS = rs.getString(2);
                v.strDES_SOS_CHI = rs.getString(3);
                v.strDES_STA_FSC = rs.getString(4);
                // v.lFRS_R = rs.getLong(5);
                // v.lFRS_S = rs.getLong(6);
                v.strDES_SIM = rs.getString(7);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public int addCorso(long lCorso, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        int iCalls = 0;
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO cor_rso_tab (cod_rso,cod_azl, cod_cor) VALUES(?,?,?)");
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, lCorso);
                ps.executeUpdate();
                if (alAziende != null) {
                    PreparedStatement ps1 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? AND cod_azl IN (" + toString(alAziende) + ")");
                    ps1.setLong(1, lCOD_AZL);
                    ps1.setLong(2, lCOD_RSO);
                    ResultSet rs = ps1.executeQuery();
                    while (rs.next()) {
                        ps.setLong(2, rs.getLong(1));
                        try {
                            ps.executeUpdate();
                        } catch (Exception ex) {
                            if (THROW_ASSOCIATE_EXCEPTION) {
                                throw ex;
                            }
                        }
                    }
                }
            }
            {
                PreparedStatement ps2
                        = bmp.prepareStatement(SQLContainer.getAddCorso());
                ps2.setLong(1, lCOD_RSO);
                ps2.setLong(2, lCorso);
                ps2.setLong(3, lCOD_RSO);
                ps2.setLong(4, lCorso);
                ResultSet rs = ps2.executeQuery();
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
            }
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
            return iCalls;
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //----------------------------------------------------
    public void removeCorso(long lCorso, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps1 = bmp.prepareStatement(SQLContainer.getRemoveCorsoQUERY_STEP1());
            PreparedStatement ps2 = bmp.prepareStatement(SQLContainer.getRemoveCorsoQUERY_STEP2());
            PreparedStatement ps3 = bmp.prepareStatement(SQLContainer.getRemoveCorsoQUERY_STEP3());

            ps1.setLong(1, lCorso);
            ps1.setLong(2, lCorso);
            ps1.setLong(3, lCOD_RSO);
            ps1.setLong(4, lCOD_AZL);
            ps1.setLong(5, lCorso);
            ps1.setLong(6, lCOD_RSO);
            ps1.setLong(7, lCOD_AZL);

            ps2.setLong(1, lCorso);
            ps2.setLong(2, lCorso);
            ps2.setLong(3, lCOD_RSO);
            ps2.setLong(4, lCOD_AZL);
            ps2.setLong(5, lCorso);
            ps2.setLong(6, lCOD_RSO);
            ps2.setLong(7, lCOD_AZL);

            ps3.setLong(1, lCOD_RSO);
            ps3.setLong(2, lCorso);
            ps3.setLong(3, lCOD_AZL);

            ps1.executeUpdate();
            ps2.executeUpdate();
            ps3.executeUpdate();

            if (alAziende != null) {
                PreparedStatement ps4 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? AND cod_azl IN (" + toString(alAziende) + ")");
                ps4.setLong(1, lCOD_AZL);
                ps4.setLong(2, lCOD_RSO);
                ResultSet rs = ps4.executeQuery();
                while (rs.next()) {
                    long cod_azl = rs.getLong(1);
                    ps1.setLong(4, cod_azl);
                    ps1.setLong(7, cod_azl);
                    ps2.setLong(4, cod_azl);
                    ps2.setLong(7, cod_azl);
                    ps3.setLong(3, cod_azl);
                    ps4.executeUpdate();
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //==================================================================================================

    public void addNormativaSentenza(long lNormativa) {
        BMPConnection bmp = getConnection();
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_rso_tab (cod_rso,cod_azl, cod_nor_sen) VALUES(?,?,?)");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lNormativa);
            ps.executeUpdate();
            PreparedStatement ps1 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? ");
            ps1.setLong(1, lCOD_AZL);
            ps1.setLong(2, lCOD_RSO);
            ResultSet rs = ps1.executeQuery();
            while (rs.next()) {
                ps.setLong(2, rs.getLong(1));
                try {
                    ps.executeUpdate();
                } catch (Exception ex) {
                    if (THROW_ASSOCIATE_EXCEPTION) {
                        throw ex;
                    }
                }
            }

            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------

    public void removeNormativaSentenza(long lNormativa) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM nor_sen_rso_tab WHERE cod_rso=? AND  cod_nor_sen=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lNormativa);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Normativa with ID=" + lNormativa + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //==================================================================================================

    public int addDpi(long lDpi, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        int iCalls = 0;
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO dpi_rso_tab (cod_rso,cod_azl, cod_tpl_dpi) VALUES(?,?,?)");
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, lDpi);
                ps.executeUpdate();
                if (alAziende != null) {
                    PreparedStatement ps1 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? AND cod_azl IN (" + toString(alAziende) + ")");
                    ps1.setLong(1, lCOD_AZL);
                    ps1.setLong(2, lCOD_RSO);

                    ResultSet rs = ps1.executeQuery();
                    while (rs.next()) {
                        ps.setLong(2, rs.getLong(1));
                        try {
                            ps.executeUpdate();
                        } catch (Exception ex) {
                            if (THROW_ASSOCIATE_EXCEPTION) {
                                throw ex;
                            }
                        }
                    }
                }
            }
            {
                PreparedStatement ps
                        = bmp.prepareStatement(SQLContainer.getAddDpi());
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lDpi);
                ps.setLong(3, lCOD_RSO);
                ps.setLong(4, lDpi);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
            }
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
            return iCalls;
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------

    public void removeDpi(long lDpi, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps1 = bmp.prepareStatement(SQLContainer.getRemoveDpiQUERY_STEP1());
            PreparedStatement ps2 = bmp.prepareStatement(SQLContainer.getRemoveDpiQUERY_STEP2());
            PreparedStatement ps3 = bmp.prepareStatement(SQLContainer.getRemoveDpiQUERY_STEP3());

            ps1.setLong(1, lDpi);
            ps1.setLong(2, lDpi);
            ps1.setLong(3, lCOD_RSO);
            ps1.setLong(4, lCOD_AZL);
            ps1.setLong(5, lDpi);
            ps1.setLong(6, lCOD_RSO);
            ps1.setLong(7, lCOD_AZL);

            ps2.setLong(1, lDpi);
            ps2.setLong(2, lDpi);
            ps2.setLong(3, lCOD_RSO);
            ps2.setLong(4, lCOD_AZL);
            ps2.setLong(5, lDpi);
            ps2.setLong(6, lCOD_RSO);
            ps2.setLong(7, lCOD_AZL);

            ps3.setLong(1, lCOD_RSO);
            ps3.setLong(2, lDpi);
            ps3.setLong(3, lCOD_AZL);

            ps1.executeUpdate();
            ps2.executeUpdate();
            ps3.executeUpdate();

            if (alAziende != null) {
                PreparedStatement ps4 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? ");
                ps4.setLong(1, lCOD_AZL);
                ps4.setLong(2, lCOD_RSO);
                ResultSet rs = ps4.executeQuery();
                while (rs.next()) {
                    long cod_azl = rs.getLong(1);
                    ps1.setLong(4, cod_azl);
                    ps1.setLong(7, cod_azl);
                    ps2.setLong(4, cod_azl);
                    ps2.setLong(7, cod_azl);
                    ps3.setLong(3, cod_azl);
                    ps4.executeUpdate();
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //==================================================================================================

    // multiple for extended Mode
    public int addProtocolloSanitario(long lProtocolloSanitaro, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        int iCalls = 0;
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO pro_san_rso_tab (cod_rso,cod_azl, cod_pro_san) VALUES(?,?,?)");
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, lProtocolloSanitaro);
                ps.executeUpdate();
                if (alAziende != null) {
                    ResultSet rs2 = getExtendedObjectsEx(bmp, "ana_pro_san_tab", lProtocolloSanitaro, lCOD_AZL, alAziende);
                    while (rs2.next()) {
                        ps.setLong(2, rs2.getLong(1));
                        ps.setLong(3, rs2.getLong(2));
                        try {
                            ps.executeUpdate();
                        } catch (Exception ex) {
                            if (THROW_ASSOCIATE_EXCEPTION) {
                                throw ex;
                            }
                        }
                    }
                }
            }
            {
                String str = SQLContainer.getAddProtocolloSanitario();
                str = Replace(str, "d.cod_pro_san IN (?)", "d.cod_pro_san IN (?)");

                PreparedStatement ps = bmp.prepareStatement(str);
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lProtocolloSanitaro);
                ps.setLong(3, lProtocolloSanitaro);
                ps.setLong(4, lCOD_RSO);
                ps.setLong(5, lProtocolloSanitaro);
                ps.setLong(6, lProtocolloSanitaro);

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
            }
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
            return iCalls;
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------
    // multiple for extended Mode

    public void removeProtocolloSanitario(long lProtocolloSanitaro, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps;
            String sSQL1 = "", sSQL2 = "", sSQL3 = "";

            sSQL1 = SQLContainer.getRemoveProtocolloSanitarioQUERY_STEP1();
            sSQL2 = SQLContainer.getRemoveProtocolloSanitarioQUERY_STEP2();
            sSQL3 = SQLContainer.getRemoveProtocolloSanitarioQUERY_STEP3();
            //
            ps = bmp.prepareStatement(sSQL1);
            ps.setLong(1, lProtocolloSanitaro);
            ps.setLong(2, lProtocolloSanitaro);
            ps.setLong(3, lCOD_RSO);
            ps.setLong(4, lCOD_AZL);
            ps.setLong(5, lProtocolloSanitaro);
            ps.setLong(6, lCOD_RSO);
            ps.setLong(7, lCOD_AZL);
            ps.executeUpdate();
            ps.close();
            //
            ps = bmp.prepareStatement(sSQL2);
            ps.setLong(1, lProtocolloSanitaro);
            ps.setLong(2, lProtocolloSanitaro);
            ps.setLong(3, lCOD_RSO);
            ps.setLong(4, lCOD_AZL);
            ps.setLong(5, lProtocolloSanitaro);
            ps.setLong(6, lCOD_RSO);
            ps.setLong(7, lCOD_AZL);
            ps.executeUpdate();
            ps.close();
            //
            ps = bmp.prepareStatement(sSQL3);
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lProtocolloSanitaro);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
            ps.close();
            //
            if (alAziende != null) {
                ResultSet rs2 = getExtendedObjectsEx(bmp, "ana_pro_san_tab", lProtocolloSanitaro, lCOD_AZL, alAziende);
                while (rs2.next()) {
                    long cod_azl = rs2.getLong(1);
                    long lProtSan = rs2.getLong(2);

                    ps = bmp.prepareStatement(sSQL1);
                    ps.setLong(1, lProtSan);
                    ps.setLong(2, lProtSan);
                    ps.setLong(3, cod_azl);
                    ps.setLong(4, cod_azl);
                    ps.setLong(5, lProtSan);
                    ps.setLong(6, cod_azl);
                    ps.setLong(7, cod_azl);
                    ps.executeUpdate();
                    ps.close();
                    //
                    ps = bmp.prepareStatement(sSQL2);
                    ps.setLong(1, lProtSan);
                    ps.setLong(2, lProtSan);
                    ps.setLong(3, lCOD_RSO);
                    ps.setLong(4, cod_azl);
                    ps.setLong(5, lProtSan);
                    ps.setLong(6, lCOD_RSO);
                    ps.setLong(7, cod_azl);
                    ps.executeUpdate();
                    ps.close();
                    //
                    ps = bmp.prepareStatement(sSQL3);
                    ps.setLong(1, lCOD_RSO);
                    ps.setLong(2, lProtSan);
                    ps.setLong(3, cod_azl);
                    ps.executeUpdate();
                    ps.close();
                }
                rs2.close();
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            ex.printStackTrace();
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //==================================================================================================

    public int addMisuraPp(long lMisurePp, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        int iCalls = 0;
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            {
                PreparedStatement ps = bmp.prepareStatement("INSERT INTO rso_mis_pet_tab (cod_rso,cod_azl, cod_mis_pet) VALUES(?,?,?)");
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, lMisurePp);
                ps.executeUpdate();

                if (alAziende != null) {

                    logger.info("Propagazione: \"ASSOCIAZIONE - RISCHIO - MISURA PREVENZIONE E PROTEZIONE\"");
                    ResultSet rs2 = getExtendedObjectsEx2(bmp, "ana_mis_pet_tab", lMisurePp, lCOD_AZL, alAziende);

                    logger.info("Lista Aziende su cui propagare: INIZIO CICLO");
                    while (rs2.next()) {

                        logger.info("Codice Azienda: " + rs2.getLong(1));
                        logger.info("Chiave Secondaria: " + rs2.getLong(2));

                        ps.setLong(2, rs2.getLong(1));
                        ps.setLong(3, rs2.getLong(2));

                        try {
                            ps.executeUpdate();
                        } catch (Exception ex) {
                            if (THROW_ASSOCIATE_EXCEPTION) {
                                throw ex;
                            }
                        }

                    }
                    logger.info("Lista Aziende su cui propagare: FINE CICLO");
                }
            }
            {
                String str = SQLContainer.getAddMisuraPp();
                str = Replace(str, "d.cod_mis_pet IN(?)", "d.cod_mis_pet IN (?)");
                PreparedStatement ps = bmp.prepareStatement(str);
                ps.setLong(1, lCOD_RSO);
                ps.setLong(2, lMisurePp);
                ps.setLong(3, lMisurePp);
                ps.setLong(4, lCOD_RSO);
                ps.setLong(5, lMisurePp);
                ps.setLong(6, lMisurePp);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
                if (rs.next()) {
                    if (rs.getLong(1) != 0) {
                        iCalls++;
                    }
                }
            }
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
            return iCalls;
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

    }

    private void _removeMisuraPp(long lMisurePp, long lCodAzl, BMPConnection bmp) throws Exception {
        PreparedStatement ps;

        String sSQL1 = SQLContainer.getRemoveMisuraPpQUERY_STEP1();
        String sSQL2 = SQLContainer.getRemoveMisuraPpQUERY_STEP2();
        String sSQL3 = SQLContainer.getRemoveMisuraPpQUERY_STEP3();

        ps = bmp.prepareStatement(sSQL1);
        ps.setLong(1, lMisurePp);
        ps.setLong(2, lMisurePp);
        ps.setLong(3, lCOD_RSO);
        ps.setLong(4, lCodAzl);
        ps.setLong(5, lMisurePp);
        ps.setLong(6, lCOD_RSO);
        ps.setLong(7, lCodAzl);
        ps.executeUpdate();
        ps.close();

        ps = bmp.prepareStatement(sSQL2);
        ps.setLong(1, lMisurePp);
        ps.setLong(2, lMisurePp);
        ps.setLong(3, lCOD_RSO);
        ps.setLong(4, lCodAzl);
        ps.setLong(5, lMisurePp);
        ps.setLong(6, lCOD_RSO);
        ps.setLong(7, lCodAzl);
        ps.executeUpdate();
        ps.close();

        ps = bmp.prepareStatement(sSQL3);
        ps.setLong(1, lCOD_RSO);
        ps.setLong(2, lMisurePp);
        ps.setLong(3, lCodAzl);
        ps.executeUpdate();
        ps.close();
    }

    //----------------------------------------------------
    public void removeMisuraPp(long lMisurePp, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();

        bmp.beginTrans();
        try {
            _removeMisuraPp(lMisurePp, lCOD_AZL, bmp);
            if (alAziende != null) {
                ResultSet rs2 = getExtendedObjectsEx2(bmp, "ana_mis_pet_tab", lMisurePp, lCOD_AZL, alAziende);
                while (rs2.next()) {
                    long cod_azl = rs2.getLong(1);
                    long lMisPet = rs2.getLong(2);
                    _removeMisuraPp(lMisPet, cod_azl, bmp);
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeMisuraPp_Old(long lMisurePp) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_mis_pet_tab WHERE cod_rso=? AND cod_mis_pet=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lMisurePp);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Misura with ID=" + lMisurePp + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //==================================================================================================
    public void addDocumento(long lDoc) {
        BMPConnection bmp = getConnection();
        if (THROW_ASSOCIATE_EXCEPTION) {
            bmp.beginTrans();
        }
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_rso_tab (cod_rso,cod_azl, cod_doc) VALUES(?,?,?)");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lDoc);
            ps.executeUpdate();

            PreparedStatement ps2 = bmp.prepareStatement("SELECT 1 FROM  ana_doc_tab WHERE cod_doc =? AND (cod_azl NOT IN(0) AND cod_azl IS NULL )");
            ps2.setLong(1, lDoc);
            ResultSet rs2 = ps2.executeQuery();

            if (rs2.next()) {
                PreparedStatement ps1 = bmp.prepareStatement("SELECT cod_azl FROM  ana_rso_tab WHERE cod_azl NOT IN (?) AND cod_rso=? ");
                ps1.setLong(1, lCOD_AZL);
                ps1.setLong(2, lCOD_RSO);

                ResultSet rs = ps1.executeQuery();

                while (rs.next()) {
                    ps.setLong(2, rs.getLong(1));
                    try {
                        ps.executeUpdate();
                    } catch (Exception ex) {
                        if (THROW_ASSOCIATE_EXCEPTION) {
                            throw ex;
                        }
                    }
                }
            }
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.commitTrans();
            }
        } catch (Exception ex) {
            if (THROW_ASSOCIATE_EXCEPTION) {
                bmp.rollbackTrans();
            }
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------

    public void removeDocumento(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_rso_tab WHERE cod_rso=? AND cod_doc=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, l);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento with ID=" + l + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</object-methods>
    //<extended-methods>
    public Collection ejbGetRischio_Nome_Fattore_View(long lAzienda) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT ana_rso_tab.cod_rso, ana_rso_tab.nom_rso, ana_fat_rso_tab.nom_fat_rso" + " FROM ana_rso_tab, ana_fat_rso_tab " + " WHERE ana_rso_tab.cod_fat_rso=ana_fat_rso_tab.cod_fat_rso AND " + " ana_rso_tab.cod_azl=? ORDER BY ana_fat_rso_tab.nom_fat_rso, ana_rso_tab.nom_rso");
            ps.setLong(1, lAzienda);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Nome_Fattore_View v = new Rischio_Nome_Fattore_View();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strNOM_FAT_RSO = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetRischio4CAG_FAT_RSO_View(long lCOD_AZL, long lCOD_CAG_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "rso.cod_rso, "
                    + "rso.nom_rso, "
                    + "rso.des_rso, "
                    + "fat_rso.nom_fat_rso "
                    + "FROM "
                    + "ana_rso_tab rso, "
                    + "ana_fat_rso_tab fat_rso "
                    + "WHERE "
                    + "rso.cod_fat_rso = fat_rso.cod_fat_rso "
                    + "AND fat_rso.cod_cag_fat_rso = ? "
                    + "AND rso.cod_azl = ? "
                    + "ORDER BY "
                    + "fat_rso.nom_fat_rso, "
                    + "rso.nom_rso");
            ps.setLong(1, lCOD_CAG_FAT_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Nome_Fattore_View v = new Rischio_Nome_Fattore_View();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strDES_RSO = rs.getString(3);
                v.strNOM_FAT_RSO = rs.getString(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //====================================================================================
    public Collection getCorsiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_cor_tab.cod_cor," + " ana_cor_tab.dur_cor_gor," + " ana_cor_tab.nom_cor," + " tpl_cor_tab.nom_tpl_cor" + " FROM ana_cor_tab, tpl_cor_tab, cor_rso_tab" + " WHERE " + " tpl_cor_tab.cod_tpl_cor=ana_cor_tab.cod_tpl_cor AND " + " cor_rso_tab.cod_cor=ana_cor_tab.cod_cor AND" + " cor_rso_tab.cod_rso=? and cor_rso_tab.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioCorso_Durata_Nome_Tipologia_View v = new RischioCorso_Durata_Nome_Tipologia_View();
                v.lCOD_COR = rs.getLong(1);
                v.lDUR_COR_GOR = rs.getLong(2);
                v.strNOM_COR = rs.getString(3);
                v.strNOM_TPL_COR = rs.getString(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getNormativeSentenzeView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_nor_sen_tab.cod_nor_sen," + " ana_nor_sen_tab.tit_nor_sen," + " ana_nor_sen_tab.num_doc_nor_sen," + " ana_nor_sen_tab.dat_nor_sen" + " FROM ana_nor_sen_tab, nor_sen_rso_tab" + " WHERE " + " nor_sen_rso_tab.cod_nor_sen=ana_nor_sen_tab.cod_nor_sen AND" + " nor_sen_rso_tab.cod_rso=? and nor_sen_rso_tab.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioNormativeSentenze_Titolo_Numero_Data_View v = new RischioNormativeSentenze_Titolo_Numero_Data_View();
                v.lCOD_NOR_SEN = rs.getLong(1);
                v.strTIT_NOR_SEN = rs.getString(2);
                v.strNUM_DOC_NOR_SEN = rs.getString(3);
                v.dtDAT_NOR_SEN = rs.getDate(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------------------------------------------------------------------------

    public Collection getDpiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " tpl_dpi_tab.cod_tpl_dpi, " + " tpl_dpi_tab.nom_tpl_dpi," + " tpl_dpi_tab.per_mes_sst," + " tpl_dpi_tab.per_mes_mnt    " + " FROM dpi_rso_tab,  tpl_dpi_tab" + " WHERE " + " dpi_rso_tab.cod_tpl_dpi=tpl_dpi_tab.cod_tpl_dpi " + " AND dpi_rso_tab.cod_rso=? and dpi_rso_tab.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioDpi_Tipologia_Sostuzione_Manutenzione_View v = new RischioDpi_Tipologia_Sostuzione_Manutenzione_View();
                v.lCOD_TPL_DPI = rs.getLong(1);
                v.strNOM_TPL_DPI = rs.getString(2);
                v.lPER_MES_SST = rs.getLong(3);
                v.lPER_MES_MNT = rs.getLong(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //----------------------------------------------------------------------------------------------------------------------
    public Collection getProtocolliSanitariView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT" + " ana_pro_san_tab.cod_pro_san," + " ana_pro_san_tab.nom_pro_san " + " FROM ana_pro_san_tab, pro_san_rso_tab" + " WHERE " + " ana_pro_san_tab.cod_pro_san=pro_san_rso_tab.cod_pro_san" + " AND pro_san_rso_tab.cod_rso=? and pro_san_rso_tab.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioProtocolliSanitari_Nome_View v = new RischioProtocolliSanitari_Nome_View();
                v.lCOD_PRO_SAN = rs.getLong(1);
                v.strNOM_PRO_SAN = rs.getString(2);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------------------------------------------------------------------------

    public Collection getMisurePpView(long lCOD_RSO, long lCOD_AZL) {
        return this.ejbGetMisurePpView(lCOD_RSO, lCOD_AZL);
    }

    public Collection getMisurePpView() {
        return ((IRischioHome) getEJBLocalHome()).getMisurePpView(lCOD_RSO, lCOD_AZL);
    }

    public Collection ejbGetMisurePpView(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "ana_mis.cod_mis_pet, "
                    + "ana_mis.nom_mis_pet, "
                    + "ana_mis.des_mis_pet "
                    + "FROM "
                    + "ana_mis_pet_tab ana_mis, "
                    + "rso_mis_pet_tab rso_mis "
                    + "WHERE "
                    + "ana_mis.cod_mis_pet = rso_mis.cod_mis_pet "
                    + "AND rso_mis.cod_rso=? "
                    + "and rso_mis.cod_azl=? "
                    + "ORDER BY "
                    + "ana_mis.nom_mis_pet");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioMisurePp_Nome_Descrizione_View v = new RischioMisurePp_Nome_Descrizione_View();
                v.lCOD_MIS_PET = rs.getLong(1);
                v.strNOM_MIS_PET = rs.getString(2);
                v.strDES_MIS_PET = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


      // bug 2015.02.20 MSR
    public Collection getMisurePpView(long lCOD_RSO, long lCOD_AZL, long lCOD_RSO_LUO_FSC) {
        return this.ejbGetMisurePpView(lCOD_RSO, lCOD_AZL, lCOD_RSO_LUO_FSC);
    }

    public Collection ejbGetMisurePpView(long lCOD_RSO, long lCOD_AZL, long lCOD_RSO_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "ana_mis.cod_mis_pet, "
                    + "ana_mis.nom_mis_pet, "
                    + "ana_mis.des_mis_pet "
                    + "FROM "
                    + "ana_mis_pet_tab ana_mis, "
                    + "rso_mis_pet_tab rso_mis "
                    // 2015.02.20 MSR//
                    + "  , mis_pet_luo_fsc_tab mplft "
                    // 2015.02.20 MSR//
                    + "WHERE "
                    + "ana_mis.cod_mis_pet = rso_mis.cod_mis_pet "
                    + "AND rso_mis.cod_rso=? "
                    + "and rso_mis.cod_azl=? "
                    // 2015.02.20 MSR//    
                    + " AND  mplft.cod_mis_pet=ana_mis.cod_mis_pet   "
                    + "  AND mplft.cod_luo_fsc= ?     "//4791

                    // 2015.02.20 MSR//     
                    + "ORDER BY "
                    + "ana_mis.nom_mis_pet");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);

            ps.setLong(3, lCOD_RSO_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioMisurePp_Nome_Descrizione_View v = new RischioMisurePp_Nome_Descrizione_View();
                v.lCOD_MIS_PET = rs.getLong(1);
                v.strNOM_MIS_PET = rs.getString(2);
                v.strDES_MIS_PET = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
  // bug 2015.02.20 MSR
  

    //-30324134234
    //----------------------------------------------------------------------------------------------------------------------
    public Collection getDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_doc_tab.cod_doc," + " ana_doc_tab.tit_doc," + " ana_doc_tab.rsp_doc," + " ana_doc_tab.dat_rev_doc" + " FROM doc_rso_tab, ana_doc_tab"
                    + " WHERE"
                    + " doc_rso_tab.cod_doc=ana_doc_tab.cod_doc" + " AND doc_rso_tab.cod_rso=? AND doc_rso_tab.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioDocumenti_View v = new RischioDocumenti_View();
                v.lCOD_DOC = rs.getLong(1);
                v.strTIT_DOC = rs.getString(2);
                v.strRSP_DOC = rs.getString(3);
                v.dtDAT_REV_DOC = rs.getDate(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getArt_Legge_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT ANA_ARL_TAB.COD_ARL,ANA_ARL_TAB.NOM_ARL,ANA_ARL_TAB.DES_ARL FROM ANA_ARL_TAB, RSO_ARL_TAB WHERE RSO_ARL_TAB.COD_ARL=ana_arl_tab.cod_arl AND RSO_ARL_TAB.cod_rso=? AND RSO_ARL_TAB.cod_azl=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Art_Legge_View obj = new Rischio_Art_Legge_View();
                obj.COD_ARL = rs.getLong("COD_ARL");
                obj.NOM_ARL = rs.getString("NOM_ARL");
                obj.DES_ARL = rs.getString("DES_ARL");
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</extended-methods>
    //<setter-getters>
    public long getCOD_AZL() {
        return lCOD_AZL;
    }

    public void setCOD_AZL(long lCOD_AZL) {
        if (this.lCOD_AZL == lCOD_AZL) {
            return;
        }
        this.lCOD_AZL = lCOD_AZL;
        setModified();
    }

    public long getCOD_RSO() {
        return lCOD_RSO;
    }

    public String getNOM_RSO() {
        return strNOM_RSO;
    }

    public void setNOM_RSO(String strNOM_RSO) {
        if ((this.strNOM_RSO != null) && (this.strNOM_RSO.equals(strNOM_RSO))) {
            return;
        }
        this.strNOM_RSO = strNOM_RSO;
        setModified();
    }

    public String getDES_RSO() {
        return strDES_RSO;
    }

    public void setDES_RSO(String strDES_RSO) {
        if ((this.strDES_RSO != null) && (this.strDES_RSO.equals(strDES_RSO))) {
            return;
        }
        this.strDES_RSO = strDES_RSO;
        setModified();
    }

    public java.sql.Date getDAT_RIL() {
        return dtDAT_RIL;
    }

    public void setDAT_RIL(java.sql.Date dtDAT_RIL) {
        if (this.dtDAT_RIL == dtDAT_RIL) {
            return;
        }
        this.dtDAT_RIL = dtDAT_RIL;
        setModified();
    }

    public String getNOM_RIL_RSO() {
        return strNOM_RIL_RSO;
    }

    public void setNOM_RIL_RSO(String strNOM_RIL_RSO) {
        if ((this.strNOM_RIL_RSO != null) && (this.strNOM_RIL_RSO.equals(strNOM_RIL_RSO))) {
            return;
        }
        this.strNOM_RIL_RSO = strNOM_RIL_RSO;
        setModified();
    }

    public String getCLF_RSO() {
        return strCLF_RSO;
    }

    public void setCLF_RSO(String strCLF_RSO) {
        if ((this.strCLF_RSO != null) && (this.strCLF_RSO.equals(strCLF_RSO))) {
            return;
        }
        this.strCLF_RSO = strCLF_RSO;
        setModified();
    }

    public long getPRB_EVE_LES() {
        return lPRB_EVE_LES;
    }

    public void setPRB_EVE_LES(long lPRB_EVE_LES) {
        if (this.lPRB_EVE_LES == lPRB_EVE_LES) {
            return;
        }
        this.lPRB_EVE_LES = lPRB_EVE_LES;
        setModified();
    }

    public long getENT_DAN() {
        return lENT_DAN;
    }

    public void setENT_DAN(long lENT_DAN) {
        if (this.lENT_DAN == lENT_DAN) {
            return;
        }
        this.lENT_DAN = lENT_DAN;
        setModified();
    }

    public long getFRQ_RIP_ATT_DAN() {
        return lFRQ_RIP_ATT_DAN;
    }

    public void setFRQ_RIP_ATT_DAN(long lFRQ_RIP_ATT_DAN) {
        if (this.lFRQ_RIP_ATT_DAN == lFRQ_RIP_ATT_DAN) {
            return;
        }
        this.lFRQ_RIP_ATT_DAN = lFRQ_RIP_ATT_DAN;
        setModified();
    }

    public long getNUM_INC_INF() {
        return lNUM_INC_INF;
    }

    public void setNUM_INC_INF(long lNUM_INC_INF) {
        if (this.lNUM_INC_INF == lNUM_INC_INF) {
            return;
        }
        this.lNUM_INC_INF = lNUM_INC_INF;
        setModified();
    }

    public float getSTM_NUM_RSO() {
        return lSTM_NUM_RSO;
    }

    public void setSTM_NUM_RSO(float lSTM_NUM_RSO) {
        if (this.lSTM_NUM_RSO == lSTM_NUM_RSO) {
            return;
        }
        this.lSTM_NUM_RSO = lSTM_NUM_RSO;
        setModified();
    }

    public long getRFC_VLU_RSO_MES() {
        return lRFC_VLU_RSO_MES;
    }

    public void setRFC_VLU_RSO_MES(long lRFC_VLU_RSO_MES) {
        if (this.lRFC_VLU_RSO_MES == lRFC_VLU_RSO_MES) {
            return;
        }
        this.lRFC_VLU_RSO_MES = lRFC_VLU_RSO_MES;
        setModified();
    }

    public long getCOD_FAT_RSO() {
        return lCOD_FAT_RSO;
    }

    public void setCOD_FAT_RSO(long lCOD_FAT_RSO) {
        if (this.lCOD_FAT_RSO == lCOD_FAT_RSO) {
            return;
        }
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;
        //if(true) throw new EJBException(lCOD_FAT_RSO+"");
        setModified();
    }

    public long getCOD_RSO_RPO() {
        return lCOD_RSO_RPO;
    }

    public void setCOD_RSO_RPO(long lCOD_RSO_RPO) {
        if (this.lCOD_RSO_RPO == lCOD_RSO_RPO) {
            return;
        }
        this.lCOD_RSO_RPO = lCOD_RSO_RPO;
        setModified();
    }

    //</setter-getters>

    /*<comment date="17/02/2004" author="Roman Chumachenko">
     External get method for getting of Fattore Rischio Name
     </comment>*/
    public String getFattoreRischio() {
        String str = "";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT nom_fat_rso FROM ana_fat_rso_tab WHERE cod_fat_rso=?");
            ps.setLong(1, lCOD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                str = rs.getString(1);
            }
            return str;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------------

    public Collection ejbGetRischio_Nome_Fattore_ComboBox(long lAzienda) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                    + "fat_rso.cod_fat_rso, "
                    + "fat_rso.nom_fat_rso, "
                    + "fat_rso.des_fat_rso "
                    + "FROM "
                    + "ana_fat_rso_tab fat_rso, "
                    + "ana_rso_tab rso "
                    + "WHERE "
                    + "fat_rso.cod_fat_rso = rso.cod_fat_rso "
                    + "AND rso.cod_azl=? "
                    + "ORDER BY "
                    + "fat_rso.nom_fat_rso");
            ps.setLong(1, lAzienda);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Nome_Fattore_ComboBox v = new Rischio_Nome_Fattore_ComboBox();
                v.lCOD_FAT_RSO = rs.getLong(1);
                v.strNOM_FAT_RSO = rs.getString(2);
                v.strDES_FAT_RSO = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetRischio_ComboBox(long lAzienda, long lCOD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            String sqlText
                    = "SELECT "
                    + "ana_rso_tab.cod_rso, "
                    + "ana_rso_tab.nom_rso, "
                    + "ana_fat_rso_tab.nom_fat_rso, "
                    + "ana_rso_tab.nom_ril_rso, "
                    + "ana_rso_tab.clf_rso, "
                    + "ana_rso_tab.dat_ril, "
                    + "ana_rso_tab.ent_dan, "
                    + "ana_rso_tab.prb_eve_les, "
                    + "ana_rso_tab.stm_num_rso, "
                    + "ana_rso_tab.cod_fat_rso, "
                    + "ana_rso_tab.des_rso, "
                    + "ana_rso_tab.frq_rip_att_dan, "
                    + "ana_rso_tab.num_inc_inf "
                    + "FROM "
                    + "ana_rso_tab, "
                    + "ana_fat_rso_tab "
                    + "WHERE "
                    + "ana_rso_tab.cod_fat_rso = ana_fat_rso_tab.cod_fat_rso "
                    + "AND ana_rso_tab.cod_azl=? "
                    + (lCOD_FAT_RSO > 0 ? "AND ana_rso_tab.cod_fat_rso = ? " : " ")
                    + "ORDER BY "
                    + "ana_rso_tab.nom_rso";
            PreparedStatement ps = bmp.prepareStatement(sqlText);
            ps.setLong(1, lAzienda);
            if (lCOD_FAT_RSO > 0) {
                ps.setLong(2, lCOD_FAT_RSO);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_ComboBox v = new Rischio_ComboBox();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strNOM_FAT_RSO = rs.getString(3);
                v.strNOM_RIL_RSO = rs.getString(4);
                v.strCLF_RSO = rs.getString(5);
                v.dtDAT_RFC_VLU_RSO = rs.getDate(6);
                v.lENT_DAN = rs.getLong(7);
                v.lPRB_EVE_LES = rs.getLong(8);
                v.lSTM_NUM_RSO = rs.getFloat(9);
                v.lCOD_FAT_RSO = rs.getLong(10);
                v.strDES_RSO = rs.getString(11);
                v.lFRQ_RIP_ATT_DAN = rs.getLong(12);
                v.lNUM_INC_INF = rs.getLong(13);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<report>
    public Collection getReportRischioByMAN_Name_View(long lCOD_AZL, long lCOD_MAN) {
        return this.ejbGetReportRischioByMAN_Name_View(lCOD_AZL, lCOD_MAN);
    }

    public Collection ejbGetReportRischioByMAN_Name_View(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    " SELECT DISTINCT "
                    + " B.COD_RSO_MAN, "
                    + " A.NOM_RSO, "
                    + " A.STM_NUM_RSO "
                    + " FROM   ANA_RSO_TAB A, RSO_MAN_TAB B "
                    + " WHERE  A.COD_RSO = B.COD_RSO "
                    + " AND B.COD_MAN = ? "
                    + " AND A.COD_AZL = ? "
                    + " ORDER BY 2");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischio_Name_View view = new ReportRischio_Name_View();
                view.lCOD_RSO_MAN = rs.getLong(1);
                view.strNOM_RSO = rs.getString(2);
                view.lSTM_NUM_RSO = rs.getFloat(3);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4LuoghiFisici_View(long lCOD_RSO, long lCOD_AZL) {
        return this.ejbGetReportRischio4LuoghiFisici_View(lCOD_RSO, lCOD_AZL);
    }

    public Collection ejbGetReportRischio4LuoghiFisici_View(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4LuoghiFisici_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4LuoghiFisici_View view = new Rischio4LuoghiFisici_View();
                view.COD_IMM = rs.getLong(1);
                view.NOM_IMM = rs.getString(2);
                view.COD_LUO_FSC = rs.getLong(3);
                view.NOM_LUO_FSC = rs.getString(4);
                view.COD_AZL = rs.getLong(5);
                view.lCOD_RSO = rs.getLong(6);
                view.strNOM_RSO = rs.getString(7);
                view.COD_MIS_PET = rs.getLong(8);
                view.NOM_MIS_PET = rs.getString(9);
                view.lPRB_EVE_LES = rs.getLong(10);
                view.lENT_DAN = rs.getLong(11);
                view.lFRQ_RIP_ATT_DAN = rs.getLong(12);
                view.lNUM_INC_INF = rs.getLong(13);
                view.lSTM_NUM_RSO = rs.getFloat(14);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4LuoghiFisici_IMMOBILI_View(long lCOD_RSO, long lCOD_AZL) {
        return this.ejbGetReportRischio4LuoghiFisici_IMMOBILI_View(lCOD_RSO, lCOD_AZL);
    }

    public Collection ejbGetReportRischio4LuoghiFisici_IMMOBILI_View(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4LuoghiFisici_IMMOBILI_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4LuoghiFisici_View view = new Rischio4LuoghiFisici_View();
                view.COD_IMM = rs.getLong(1);
                view.NOM_IMM = rs.getString(2);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4LuoghiFisici_LUOGHI_FISICI_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM) {
        return this.ejbGetReportRischio4LuoghiFisici_LUOGHI_FISICI_View(lCOD_RSO, lCOD_AZL, lCOD_IMM);
    }

    public Collection ejbGetReportRischio4LuoghiFisici_LUOGHI_FISICI_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4LuoghiFisici_LUOGHI_FISICI_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_IMM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4LuoghiFisici_View view = new Rischio4LuoghiFisici_View();
                view.COD_LUO_FSC = rs.getLong(1);
                view.NOM_LUO_FSC = rs.getString(2);
                view.COD_AZL = rs.getLong(3);
                view.lCOD_RSO = rs.getLong(4);
                view.strNOM_RSO = rs.getString(5);
                view.lPRB_EVE_LES = rs.getLong(6);
                view.lENT_DAN = rs.getLong(7);
                view.lFRQ_RIP_ATT_DAN = rs.getLong(8);
                view.lNUM_INC_INF = rs.getLong(9);
                view.lSTM_NUM_RSO = rs.getFloat(10);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4LuoghiFisici_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM, long lCOD_LUO_FSC) {
        return this.ejbGetReportRischio4LuoghiFisici_MISURE_View(lCOD_RSO, lCOD_AZL, lCOD_IMM, lCOD_LUO_FSC);
    }

    public Collection ejbGetReportRischio4LuoghiFisici_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM, long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4LuoghiFisici_MISURE_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_IMM);
            ps.setLong(4, lCOD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4LuoghiFisici_View view = new Rischio4LuoghiFisici_View();
                view.COD_MIS_PET = rs.getLong(1);
                view.NOM_MIS_PET = rs.getString(2);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4AttivitaLavorative_View(long lCOD_RSO, long lCOD_AZL) {
        return this.ejbGetReportRischio4AttivitaLavorative_View(lCOD_RSO, lCOD_AZL);
    }

    public Collection ejbGetReportRischio4AttivitaLavorative_View(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4AttivitaLavorative_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4AttivitaLavorative_View view = new Rischio4AttivitaLavorative_View();
                view.COD_MAN = rs.getLong(1);
                view.NOM_MAN = rs.getString(2);
                view.COD_AZL = rs.getLong(3);
                view.lCOD_RSO = rs.getLong(4);
                view.strNOM_RSO = rs.getString(5);
                view.COD_MIS_PET = rs.getLong(6);
                view.NOM_MIS_PET = rs.getString(7);
                view.lPRB_EVE_LES = rs.getLong(8);
                view.lENT_DAN = rs.getLong(9);
                view.lFRQ_RIP_ATT_DAN = rs.getLong(10);
                view.lNUM_INC_INF = rs.getLong(11);
                view.lSTM_NUM_RSO = rs.getFloat(12);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4AttivitaLavorative_ATTIVITA_View(long lCOD_RSO, long lCOD_AZL) {
        return this.ejbGetReportRischio4AttivitaLavorative_ATTIVITA_View(lCOD_RSO, lCOD_AZL);
    }

    public Collection ejbGetReportRischio4AttivitaLavorative_ATTIVITA_View(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4AttivitaLavorative_ATTIVITA_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4AttivitaLavorative_View view = new Rischio4AttivitaLavorative_View();
                view.COD_MAN = rs.getLong(1);
                view.NOM_MAN = rs.getString(2);
                view.COD_AZL = rs.getLong(3);
                view.lCOD_RSO = rs.getLong(4);
                view.strNOM_RSO = rs.getString(5);
                view.lPRB_EVE_LES = rs.getLong(6);
                view.lENT_DAN = rs.getLong(7);
                view.lFRQ_RIP_ATT_DAN = rs.getLong(8);
                view.lNUM_INC_INF = rs.getLong(9);
                view.lSTM_NUM_RSO = rs.getFloat(10);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportRischio4AttivitaLavorative_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_MAN) {
        return this.ejbGetReportRischio4AttivitaLavorative_MISURE_View(lCOD_RSO, lCOD_AZL, lCOD_MAN);
    }

    public Collection ejbGetReportRischio4AttivitaLavorative_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getReportRischio4AttivitaLavorative_MISURE_View());
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio4AttivitaLavorative_View view = new Rischio4AttivitaLavorative_View();
                view.COD_MIS_PET = rs.getLong(1);
                view.NOM_MIS_PET = rs.getString(2);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</report>
    //====================================================================================
    public Collection ejbGetRischio_MAN_ComboBox(long lAzienda, String strNOM, String strCLF) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_rso, c.cod_man, a.nom_rso, a.clf_rso, c.nom_man " + " FROM ana_rso_tab a, rso_man_tab b, ana_man_tab c " + " WHERE a.cod_rso = b.cod_rso AND a.cod_azl = b.cod_azl  AND c.cod_man=b.cod_man AND a.cod_azl=? " + " AND a.nom_rso LIKE ?||'%' AND a.clf_rso LIKE ?||'%' ");
            ps.setLong(1, lAzienda);
            ps.setString(2, strNOM);
            ps.setString(3, strCLF);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_MAN_LUO_FSC_ComboBox v = new Rischio_MAN_LUO_FSC_ComboBox();
                v.lCOD_RSO = rs.getLong(1);
                v.lCOD_LUO_FSC_MAN = rs.getLong(2);
                v.strNOM_RSO = rs.getString(3);
                v.strCLF_RSO = rs.getString(4);
                v.strNOM_LUO_FSC_MAN = rs.getString(5);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------------------------

    public Collection ejbGetRischio_MAN_LUO_FSC_ComboBox(long lAzienda) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "a.cod_rso, "
                    + "c.cod_man, "
                    + "a.nom_rso, "
                    + "a.clf_rso, "
                    + "c.nom_man "
                    + "FROM "
                    + "ana_rso_tab a, "
                    + "rso_man_tab b, "
                    + "ana_man_tab c "
                    + "WHERE "
                    + "a.cod_azl = b.cod_azl "
                    + "AND a.cod_rso = b.cod_rso "
                    + "AND c.cod_man = b.cod_man "
                    + "AND a.cod_azl=? "
                    + "UNION ALL "
                    + "SELECT "
                    + "a.cod_rso, "
                    + "c.cod_luo_fsc, "
                    + "a.nom_rso, "
                    + "a.clf_rso, "
                    + "c.nom_luo_fsc "
                    + "FROM "
                    + "ana_rso_tab a, "
                    + "rso_luo_fsc_tab b, "
                    + "ana_luo_fsc_tab c "
                    + "WHERE "
                    + "a.cod_azl = b.cod_azl "
                    + "AND a.cod_rso = b.cod_rso "
                    + "AND c.cod_luo_fsc = b.cod_luo_fsc "
                    + "AND a.cod_azl=? ");
            ps.setLong(1, lAzienda);
            ps.setLong(2, lAzienda);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_MAN_LUO_FSC_ComboBox v = new Rischio_MAN_LUO_FSC_ComboBox();
                v.lCOD_RSO = rs.getLong(1);
                v.lCOD_LUO_FSC_MAN = rs.getLong(2);
                v.strNOM_RSO = rs.getString(3);
                v.strCLF_RSO = rs.getString(4);
                v.strNOM_LUO_FSC_MAN = rs.getString(5);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //-------------------------------
    public Collection ejbGetRischio_LUO_FSC_ComboBox(long lAzienda, String strNOM, String strCLF) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "a.cod_rso, "
                    + "c.cod_luo_fsc, "
                    + "a.nom_rso, "
                    + "a.clf_rso, "
                    + "c.nom_luo_fsc "
                    + "FROM "
                    + "ana_rso_tab a, "
                    + "rso_luo_fsc_tab b, "
                    + "ana_luo_fsc_tab c "
                    + "WHERE "
                    + "a.cod_rso = b.cod_rso "
                    + "AND a.cod_azl = b.cod_azl "
                    + "AND c.cod_luo_fsc = b.cod_luo_fsc "
                    + "AND a.cod_azl=? "
                    + "AND a.nom_rso LIKE ?||'%' "
                    + "AND a.clf_rso LIKE ?||'%' ");
            ps.setLong(1, lAzienda);
            ps.setString(2, strNOM);
            ps.setString(3, strCLF);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_MAN_LUO_FSC_ComboBox v = new Rischio_MAN_LUO_FSC_ComboBox();
                v.lCOD_RSO = rs.getLong(1);
                v.lCOD_LUO_FSC_MAN = rs.getLong(2);
                v.strNOM_RSO = rs.getString(3);
                v.strCLF_RSO = rs.getString(4);
                v.strNOM_LUO_FSC_MAN = rs.getString(5);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //------------------------------------------

    public Collection ejbGetRischio_Elenco_View(long lCOD_AZL, String strAPL_A, long lCOD_MIS_PET_LUO_MAN) {
        String query = "SELECT a.cod_rso,a.nom_rso,b.nom_mis_pet FROM ana_rso_tab a ";
        if (strAPL_A.equals("L")) {
            query += ",ana_mis_pet_azl_tab b,rso_luo_fsc_tab c  WHERE a.cod_azl = ? AND a.cod_azl=c.cod_azl AND a.cod_rso=c.cod_rso AND b.cod_rso_luo_fsc=c.cod_rso_luo_fsc AND c.cod_luo_fsc=c.cod_luo_fsc ";
            if (lCOD_MIS_PET_LUO_MAN != 0) {
                query += " AND b.cod_luo_fsc = ?";
            }
        } else {
            query += ",ana_mis_pet_azl_tab b,rso_man_tab c WHERE a.cod_azl = ? AND a.cod_azl=c.cod_azl AND a.cod_rso=c.cod_rso AND b.cod_rso_man=c.cod_rso_man AND c.cod_man=c.cod_man ";
            if (lCOD_MIS_PET_LUO_MAN != 0) {
                query += " AND b.cod_man = ?";
            }
        }//
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            if (lCOD_MIS_PET_LUO_MAN != 0) {
                ps.setLong(2, lCOD_MIS_PET_LUO_MAN);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Elenco_View v = new Rischio_Elenco_View();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strNOM_RIL_RSO = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//------------------------------------------

    public Collection ejbGetRischio_foo_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV) {
        int icounterWhere = 2;
        int iCOUNT_COD_RSO = 0, iCOUNT_COD_FAT_RSO = 0, iCOUNT_STA_RSO = 0, iCOUNT_DAT_RFC_VLU_RSO_DAL = 0, iCOUNT_DAT_RFC_VLU_RSO_AL = 0;
        String strSELECT = "", strFROM = "", strWHERE = "", strGROUP = "";
        strSELECT = "SELECT a.cod_rso, b.dat_rfc_vlu_rso, a.nom_rso, c.nom_fat_rso, d.rag_scl_azl, d.cod_azl";
        String strORDER = "";
        String strSort = ", b.dat_rfc_vlu_rso ";
        {
            if ("M".equals(strTIP_RSO)) {
                strSELECT = strSELECT + ", b.cod_rso_man, b.cod_man ";
                strFROM = " FROM ana_rso_tab a,rso_man_tab b,ana_fat_rso_tab c, ana_azl_tab d ";
            } else if ("L".equals(strTIP_RSO)) {
                strSELECT = strSELECT + ", b.cod_rso_luo_fsc,b.cod_luo_fsc ";
                strFROM = " FROM ana_rso_tab a,rso_luo_fsc_tab b,ana_fat_rso_tab c,ana_azl_tab d ";

            }
            strWHERE = " WHERE a.cod_rso=b.cod_rso AND a.cod_fat_rso=c.cod_fat_rso AND a.cod_azl=d.cod_azl ";
            strWHERE = strWHERE + " AND a.cod_azl= ? ";
        }

        if ((dtDAT_RFC_VLU_RSO_DAL != null) && (dtDAT_RFC_VLU_RSO_AL != null)) {
            iCOUNT_DAT_RFC_VLU_RSO_DAL = icounterWhere;
            iCOUNT_DAT_RFC_VLU_RSO_AL = ++icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND b.dat_rfc_vlu_rso BETWEEN ? AND ? ";
        }
        if ((dtDAT_RFC_VLU_RSO_DAL != null) && (dtDAT_RFC_VLU_RSO_AL == null)) {
            iCOUNT_DAT_RFC_VLU_RSO_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND b.dat_rfc_vlu_rso >= ? ";
        }
        if ((dtDAT_RFC_VLU_RSO_DAL == null) && (dtDAT_RFC_VLU_RSO_AL != null)) {
            iCOUNT_DAT_RFC_VLU_RSO_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND b.dat_rfc_vlu_rso <= ? ";
        }
        if (lCOD_RSO != 0) {
            iCOUNT_COD_RSO = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.cod_rso= ?";
        }
        if (lCOD_FAT_RSO != 0) {
            iCOUNT_COD_FAT_RSO = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND c.cod_fat_rso= ?";
        }
        if (!("".equals(strSTA_RSO))) {
            iCOUNT_STA_RSO = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND b.sta_rso= ?";
        }
        if ("PIFup".equals(strVAR_RIV)) {
            strORDER = " ORDER BY b.dat_rfc_vlu_rso ";
            strSort = ", b.dat_rfc_vlu_rso ";
        } else if ("PIFdw".equals(strVAR_RIV)) {
            strORDER = " ORDER BY b.dat_rfc_vlu_rso DESC";
            strSort = ", b.dat_rfc_vlu_rso DESC ";
        }
        if ("N".equals(strRG_GROUP)) {
            strGROUP = strORDER;
        }
        if ("F".equals(strRG_GROUP)) {
            strGROUP = " ORDER BY c.nom_fat_rso " + strSort;
        }
        if ("A".equals(strRG_GROUP)) {
            strGROUP = " ORDER BY d.rag_scl_azl " + strSort;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSELECT + strFROM + strWHERE + strGROUP);
            ps.setLong(1, lCOD_AZL);
            if (iCOUNT_DAT_RFC_VLU_RSO_DAL != 0) {
                ps.setDate(iCOUNT_DAT_RFC_VLU_RSO_DAL, dtDAT_RFC_VLU_RSO_DAL);
            }
            if (iCOUNT_DAT_RFC_VLU_RSO_AL != 0) {
                ps.setDate(iCOUNT_DAT_RFC_VLU_RSO_AL, dtDAT_RFC_VLU_RSO_AL);
            }
            if (iCOUNT_COD_RSO != 0) {
                ps.setLong(iCOUNT_COD_RSO, lCOD_RSO);
            }
            if (iCOUNT_COD_FAT_RSO != 0) {
                ps.setLong(iCOUNT_COD_FAT_RSO, lCOD_FAT_RSO);
            }
            if (iCOUNT_STA_RSO != 0) {
                ps.setString(iCOUNT_STA_RSO, strSTA_RSO);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_foo_SCHRIVRSO_View obj = new Rischio_foo_SCHRIVRSO_View();
                obj.lCOD_RSO = rs.getLong(1);
                obj.dtDAT_RFS_VLU_RSO = rs.getDate(2);
                obj.strNOM_RSO = rs.getString(3);
                obj.strNOM_FAT_RSO = rs.getString(4);
                obj.strNOM_AZL = rs.getString(5);
                obj.lCOD_AZL = rs.getLong(6);
                if ("M".equals(strTIP_RSO)) {
                    obj.lCOD_RSO_MAN = rs.getLong(7);
                    obj.lCOD_MAN = rs.getLong(8);
                } else {
                    obj.lCOD_RSO_LUO_FSC = rs.getLong(7);
                    obj.lCOD_LUO_FSC = rs.getLong(8);
                }
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetRischio_collection_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV) {
        java.util.Collection col = null;
        col = this.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDAT_RFC_VLU_RSO_DAL, dtDAT_RFC_VLU_RSO_AL, "M", strRG_GROUP, strVAR_RIV);
        col.addAll(
                this.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDAT_RFC_VLU_RSO_DAL, dtDAT_RFC_VLU_RSO_AL, "L", strRG_GROUP, strVAR_RIV));

        if ("PIFup".equals(strVAR_RIV)) {
            Collections.sort((ArrayList) col, new Rischio_foo_SCHRIVRSO_Comparator_UP());
        } else if ("PIFdw".equals(strVAR_RIV)) {
            Collections.sort((ArrayList) col, new Rischio_foo_SCHRIVRSO_Comparator_DW());
        }

        return col;
    }

    //------------------------------------------
    //--- by Juli
    public Collection ejbGetRischio_CRM_RSO_View(String strNOM, long lCOD_AZL) {
        String query = "SELECT a.cod_rso,a.nom_rso, a.des_rso, (SELECT COUNT(*) FROM ana_rso_tab b WHERE (a.nom_rso=b.nom_rso OR a.cod_rso=b.cod_rso_rpo) AND b.cod_azl = ?) FROM ana_rso_tab_r a WHERE a.nom_rso LIKE ? ";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strNOM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_CRM_RSO_View v = new Rischio_CRM_RSO_View();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strDES_RSO = rs.getString(3);
                v.lIS_RED = (rs.getLong(4) == 0) ? 0 : 1;
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public boolean ejbCheckRischio_ByName(String strNOM, long lCOD_AZL) {
        String query
                = "select "
                + "count(cod_rso) as count "
                + "from "
                + "ana_rso_tab "
                + "where "
                + "cod_azl = ? and "
                + "nom_rso = ?";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strNOM);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getByte("count") > 0;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //--- by Mike
//===========================================================
    public boolean ejbCaricaDbRischi(long P_COD_AZL, long P_COD_RSO) {
        boolean result = true;
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++
            long conta;
            long V_COD_RSO = NEW_ID();
            long flag_esistenza;
            ps = bmp.prepareStatement("select count(*) from ana_rso_tab where cod_azl=? and cod_rso_rpo = ?");
            ps.setLong(1, P_COD_AZL);
            ps.setLong(2, P_COD_RSO);
            rs = ps.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps.close();
            }
            if (flag_esistenza == 0) {
                ps = bmp.prepareStatement(
                        "INSERT INTO ana_rso_tab(cod_azl, cod_rso, nom_rso, des_rso, dat_ril, "
                        + "nom_ril_rso, clf_rso, prb_eve_les, ent_dan, stm_num_rso, "
                        + "rfc_vlu_rso_mes, cod_fat_rso, cod_rso_rpo) "
                        + "SELECT ?, ?, nom_rso, des_rso, dat_ril, "
                        + "nom_ril_rso, clf_rso, prb_eve_les, ent_dan, stm_num_rso, "
                        + "rfc_vlu_rso_mes, 2, cod_rso "
                        + "FROM ana_rso_tab_r WHERE cod_rso =? ;");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, V_COD_RSO);
                ps.setLong(3, P_COD_RSO);
//			ps.setLong(4, P_COD_AZL);
                ps.executeUpdate();
                ps.close();
                ps = bmp.prepareStatement(
                        "SELECT a.cod_mis_pet FROM ana_mis_pet_tab_r a, rso_mis_pet_tab_r b "
                        + "WHERE b.cod_rso = ? AND b.cod_mis_pet = a.cod_mis_pet");
                ps.setLong(1, P_COD_RSO);
                ResultSet i = ps.executeQuery();
//----inserisco anche nella anagarfica misure preventive
                PreparedStatement ps_mis_pet = null;
                PreparedStatement ps_nor_sen_mis_pet = null;
                long cod_mis_pet = 0;
                ps_mis_pet = bmp.prepareStatement(
                        "INSERT INTO ana_mis_pet_tab(cod_mis_pet, nom_mis_pet, dat_cmp, ver_mis_pet, "
                        + "adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, "
                        + "tpl_dsi_mis_pet,  dsi_azl_mis_pet, cod_tpl_mis_pet, cod_azl, cod_mis_pet_rpo) "
                        + "SELECT ?, nom_mis_pet, dat_cmp, ver_mis_pet, "
                        + "adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, "
                        + "tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet, ?, ? "
                        + "FROM ana_mis_pet_tab_r a, rso_mis_pet_tab_r b "
                        + "WHERE b.cod_rso=? AND a.cod_mis_pet = ? AND a.cod_mis_pet = b.cod_mis_pet;");
                ps_nor_sen_mis_pet = bmp.prepareStatement(
                        "INSERT INTO nor_sen_mis_pet_tab (cod_mis_pet, cod_nor_sen) "
                        + "SELECT v_cod_mis_pet, cod_nor_sen "
                        + "FROM nor_sen_mis_pet_tab_r "
                        + "WHERE cod_mis_pet = i.cod_mis_pet;");
                while (i.next()) {
                    long V_COD_MIS_PET = NEW_ID() + (cod_mis_pet++);
                    ps_mis_pet.setLong(1, V_COD_MIS_PET);
                    ps_mis_pet.setLong(2, P_COD_AZL);
                    ps_mis_pet.setLong(3, V_COD_RSO);
                    ps_mis_pet.setLong(4, P_COD_RSO);
                    ps_mis_pet.setLong(5, i.getLong(1));
                    ps_nor_sen_mis_pet.setLong(1, V_COD_MIS_PET);
                    ps_nor_sen_mis_pet.setLong(2, i.getLong(1));
                    ps_mis_pet.executeUpdate();
                    ps_nor_sen_mis_pet.executeUpdate();
                    ps_mis_pet.clearParameters();
                    ps_nor_sen_mis_pet.clearParameters();
                }
                i.close();
                ps.close();
//------ prendo tutti i dpi associati con il rischio
//------ nel repository e li inserico nell associativa
                ps = bmp.prepareStatement("SELECT cod_tpl_dpi FROM dpi_rso_tab_r WHERE cod_rso = ?");
                ps.setLong(1, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_dpi_rso = bmp.prepareStatement("INSERT INTO dpi_rso_tab VALUES(?,?,?)");
                while (i.next()) {
                    ps_dpi_rso.setLong(1, i.getLong(1));
                    ps_dpi_rso.setLong(2, V_COD_RSO);
                    ps_dpi_rso.setLong(3, P_COD_AZL);
                    ps_dpi_rso.executeUpdate();
                    ps_dpi_rso.clearParameters();
                }
                i.close();
                ps.close();
//------ prendo tutte le normative associate con il rischio
//------ nel repository e le inserico nell associativa
                ps = bmp.prepareStatement("SELECT cod_nor_sen FROM nor_sen_rso_tab_r WHERE cod_rso = ?");
                ps.setLong(1, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_nor_sen_rso = bmp.prepareStatement("INSERT INTO nor_sen_rso_tab VALUES(?,?,?)");
                while (i.next()) {
                    ps_nor_sen_rso.setLong(1, i.getLong(1));
                    ps_nor_sen_rso.setLong(2, V_COD_RSO);
                    ps_nor_sen_rso.setLong(3, P_COD_AZL);
                    ps_nor_sen_rso.executeUpdate();
                    ps_nor_sen_rso.clearParameters();
                }
                i.close();
                ps.close();
//------ prendo tutti icorsi associati con il rischio
//------ nel repository e le inserico nell associativa
                ps = bmp.prepareStatement("SELECT cod_cor FROM cor_rso_tab_r WHERE cod_rso = ?");
                ps.setLong(1, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_cor_rso = bmp.prepareStatement("INSERT INTO cor_rso_tab VALUES(?,?,?)");
                while (i.next()) {
                    ps_cor_rso.setLong(1, i.getLong(1));
                    ps_cor_rso.setLong(2, V_COD_RSO);
                    ps_cor_rso.setLong(3, P_COD_AZL);
                    ps_cor_rso.executeUpdate();
                    ps_cor_rso.clearParameters();
                }
                i.close();
                ps.close();
//-------------------------------------------------------------
//-----prendo tutti i protocolli sanitari associati al rischio
                ps = bmp.prepareStatement("SELECT cod_pro_san from pro_san_rso_tab_r WHERE cod_rso = ?");
                ps.setLong(1, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_pro_san_rso_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_pro_san_tab WHERE cod_pro_san_rpo = ?");
                PreparedStatement ps_pro_san_rso_0 = bmp.prepareStatement("INSERT INTO ana_pro_san_tab(cod_pro_san, nom_pro_san, des_pro_san, cod_azl, cod_pro_san_rpo) SELECT ?, nom_pro_san, des_pro_san, ?, cod_pro_san FROM ana_pro_san_tab_r WHERE cod_pro_san = ?");
                PreparedStatement ps_pro_san_rso_1 = bmp.prepareStatement("INSERT INTO pro_san_rso_tab VALUES(?,?,?)");
                long cod_pro_san = 0;
                while (i.next()) {
                    ps_pro_san_rso_cnt.setLong(1, i.getLong(1));
                    ResultSet rs_pro_san_rso_cnt = ps_pro_san_rso_cnt.executeQuery();
                    rs_pro_san_rso_cnt.next();
                    long V_COD_PRO_SAN = NEW_ID() + (cod_pro_san++);
                    if (rs_pro_san_rso_cnt.getLong(1) == 0) {
                        ps_pro_san_rso_0.setLong(1, V_COD_PRO_SAN);
                        ps_pro_san_rso_0.setLong(2, P_COD_AZL);
                        ps_pro_san_rso_0.setLong(3, i.getLong(1));
                        ps_pro_san_rso_1.setLong(1, V_COD_PRO_SAN);
                        ps_pro_san_rso_1.setLong(2, V_COD_RSO);
                        ps_pro_san_rso_1.setLong(3, P_COD_AZL);
                        ps_pro_san_rso_0.executeUpdate();
                        ps_pro_san_rso_1.executeUpdate();
                        ps_pro_san_rso_0.clearParameters();
                        ps_pro_san_rso_1.clearParameters();
                    } else {
                        ps_pro_san_rso_1.setLong(1, i.getLong(1));
                        ps_pro_san_rso_1.setLong(2, V_COD_RSO);
                        ps_pro_san_rso_1.setLong(3, P_COD_AZL);

                        ps_pro_san_rso_1.executeUpdate();
                        ps_pro_san_rso_1.clearParameters();
                    }
                    rs_pro_san_rso_cnt.close();
//----seleziono tutte le visite di idoneita
//----associate al protocollo sanitario
                    PreparedStatement ps_vst_ido = bmp.prepareStatement("SELECT cod_vst_ido FROM vst_ido_pro_san_tab_r WHERE cod_pro_san = ?");
                    ps_vst_ido.setLong(1, i.getLong(1));
                    ResultSet x = ps.executeQuery();
                    PreparedStatement ps_vst_ido_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_rpo = ?");
                    PreparedStatement ps_vst_ido_0 = bmp.prepareStatement("INSERT INTO ana_vst_ido_tab SELECT ?, fat_per, per_vst, nom_vst_ido, des_vst_ido, ?, cod_vst_ido FROM ana_vst_ido_tab_r WHERE cod_vst_ido = ?");
                    PreparedStatement ps_vst_ido_1 = bmp.prepareStatement("INSERT INTO vst_ido_pro_san_tab VALUES(?,?)");
                    PreparedStatement ps_vst_ido_2 = bmp.prepareStatement("SELECT cod_vst_ido FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_rpo = ?");
                    long cod_vst_ido = 0;
                    while (x.next()) {
                        ps_vst_ido_cnt.setLong(1, P_COD_AZL);
                        ps_vst_ido_cnt.setLong(2, x.getLong(1));
                        ResultSet rs_vst_ido_cnt = ps_vst_ido_cnt.executeQuery();
                        rs_vst_ido_cnt.next();
                        long V_COD_VST_IDO = NEW_ID() + (cod_vst_ido++);
                        if (rs_vst_ido_cnt.getLong(1) == 0) {
                            ps_vst_ido_0.setLong(1, V_COD_VST_IDO);
                            ps_vst_ido_0.setLong(2, P_COD_AZL);
                            ps_vst_ido_0.setLong(3, x.getLong(1));
                            ps_vst_ido_1.setLong(1, i.getLong(1));
                            ps_vst_ido_1.setLong(2, V_COD_VST_IDO);
                            ps_vst_ido_0.executeUpdate();
                            ps_vst_ido_1.executeUpdate();
                            ps_vst_ido_0.clearParameters();
                            ps_vst_ido_1.clearParameters();
                        } else {
                            ps_vst_ido_2.setLong(1, P_COD_AZL);
                            ps_vst_ido_2.setLong(2, x.getLong(1));
                            ResultSet rs_vst_ido_2 = ps_vst_ido_2.executeQuery();
                            rs_vst_ido_2.next();
                            ps_vst_ido_1.setLong(1, rs_vst_ido_2.getLong(1));
                            ps_vst_ido_1.setLong(2, V_COD_VST_IDO);
                            ps_vst_ido_1.executeUpdate();
                            ps_vst_ido_1.clearParameters();
                            ps_vst_ido_2.clearParameters();
                        }
                        rs_vst_ido_cnt.close();
                    }

//----seleziono tutte le visite mediche
//----associate al protocollo sanitario
                    PreparedStatement ps_vst_med = bmp.prepareStatement("SELECT cod_vst_med FROM vst_med_pro_san_tab_r WHERE cod_pro_san = ?");
                    ps_vst_med.setLong(1, i.getLong(1));
                    ResultSet y = ps.executeQuery();
                    PreparedStatement ps_vst_med_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_vst_med_tab WHERE cod_azl = ? AND cod_vst_med_rpo = ?");
                    PreparedStatement ps_vst_med_0 = bmp.prepareStatement("INSERT INTO ana_vst_med_tab SELECT ?, fat_per, per_vst, nom_vst_med, des_vst_med, ?, cod_vst_med FROM ana_vst_med_tab_r WHERE cod_vst_med = ?");
                    PreparedStatement ps_vst_med_1 = bmp.prepareStatement("INSERT INTO vst_med_pro_san_tab VALUES(?,?)");
                    PreparedStatement ps_vst_med_2 = bmp.prepareStatement("SELECT cod_vst_med FROM ana_vst_med_tab WHERE cod_azl = ? AND cod_vst_med_rpo = ?");
                    long cod_vst_med = 0;
                    while (y.next()) {
                        ps_vst_med_cnt.setLong(1, P_COD_AZL);
                        ps_vst_med_cnt.setLong(2, y.getLong(1));
                        ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                        rs_vst_med_cnt.next();
                        long V_COD_VST_MED = NEW_ID() + (cod_vst_med++);
                        if (rs_vst_med_cnt.getLong(1) == 0) {
                            ps_vst_med_0.setLong(1, V_COD_VST_MED);
                            ps_vst_med_0.setLong(2, P_COD_AZL);
                            ps_vst_med_0.setLong(3, y.getLong(1));
                            ps_vst_med_1.setLong(1, i.getLong(1));
                            ps_vst_med_1.setLong(2, V_COD_VST_MED);
                            ps_vst_med_0.executeUpdate();
                            ps_vst_med_1.executeUpdate();
                            ps_vst_med_0.clearParameters();
                            ps_vst_med_1.clearParameters();
                        } else {
                            ps_vst_med_2.setLong(1, P_COD_AZL);
                            ps_vst_med_2.setLong(2, y.getLong(1));
                            ResultSet rs_vst_med_2 = ps_vst_med_2.executeQuery();
                            rs_vst_med_2.next();
                            ps_vst_med_1.setLong(1, rs_vst_med_2.getLong(1));
                            ps_vst_med_1.setLong(2, V_COD_VST_MED);
                            ps_vst_med_1.executeUpdate();
                            ps_vst_med_1.clearParameters();
                            ps_vst_med_2.clearParameters();
                        }
                        rs_vst_med_cnt.close();
                    }
                }
                i.close();
                ps.close();
            } else {
                result = false;
            }
            //++++++++++++++++++++++++++++++++++++++++++++++
            conn.commit();
        } catch (Exception ex) {
            result = false;
            try {
                conn.rollback();
            } catch (Exception ex1) {
                ex.printStackTrace();
            }
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return result;
    }

    public boolean ejbCaricaRpRischi(long P_COD_AZL, String P_NOM_RSO) {
        boolean result = true;
        ResultSet rs = null;

        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++

            long conta;
            long V_COD_RSO = NEW_ID();
            long P_COD_RSO = 0;
            long flag_esistenza;
            ps = bmp.prepareStatement(SQLContainer.getCarica_rp_rischi_cnt());
            ps.setString(1, P_NOM_RSO);
            rs = ps.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps.close();
            }
            if (flag_esistenza == 0) {
                PreparedStatement ps_cod_rso = bmp.prepareStatement("SELECT cod_rso FROM ana_rso_tab "
                        + "WHERE nom_rso=? AND cod_azl= ?");
                ps_cod_rso.setString(1, P_NOM_RSO);
                ps_cod_rso.setLong(2, P_COD_AZL);
                ResultSet rs_cod_rso = ps_cod_rso.executeQuery();
                rs_cod_rso.next();
                P_COD_RSO = rs_cod_rso.getLong(1);
                ps = bmp.prepareStatement(
                        "INSERT INTO ana_rso_tab_r(cod_rso, nom_rso, des_rso, dat_ril, nom_ril_rso, clf_rso, "
                        + "prb_eve_les, ent_dan, stm_num_rso, rfc_vlu_rso_mes, cod_fat_rso) "
                        + "SELECT ?, nom_rso, des_rso, dat_ril, nom_ril_rso, clf_rso, "
                        + "prb_eve_les, ent_dan, stm_num_rso, rfc_vlu_rso_mes, cod_fat_rso "
                        + "FROM ana_rso_tab WHERE nom_rso =? AND cod_azl=?");
                ps.setLong(1, V_COD_RSO);
                ps.setString(2, P_NOM_RSO);
                ps.setLong(3, P_COD_AZL);
                ps.executeUpdate();
                ps.close();
                ps = bmp.prepareStatement("update ana_rso_tab set cod_rso_rpo=? where nom_rso = ? and cod_azl = ?");
                ps.setLong(1, V_COD_RSO);
                ps.setString(2, P_NOM_RSO);
                ps.setLong(3, P_COD_AZL);
                ps.executeUpdate();
                ps.close();
                ps = bmp.prepareStatement(
                        "SELECT ana_mis_pet_tab.cod_mis_pet "
                        + "FROM ana_mis_pet_tab,rso_mis_pet_tab_r "
                        + "WHERE rso_mis_pet_tab_r.cod_mis_pet=ana_mis_pet_tab.cod_mis_pet "
                        + "AND rso_mis_pet_tab_r.cod_rso = ? "
                        + "AND cod_azl =?");
                ps.setLong(1, P_COD_RSO);
                ps.setLong(2, P_COD_AZL);
                ResultSet i = ps.executeQuery();

                long v_cod_mis_pet, cod_mis_pet = 0;

                PreparedStatement ps_mis_pet_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_mis_pet_tab_r WHERE cod_mis_pet = ?");
                PreparedStatement ps_mis_pet_0 = bmp.prepareStatement(
                        "INSERT INTO ana_mis_pet_tab_r (cod_mis_pet,nom_mis_pet, dat_cmp, ver_mis_pet, adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet) "
                        + "SELECT ?, nom_mis_pet, dat_cmp, ver_mis_pet, adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet FROM ana_mis_pet_tab WHERE cod_azl=? AND cod_mis_pet = ?");
                PreparedStatement ps_mis_pet_1 = bmp.prepareStatement("INSERT INTO rso_mis_pet_tab_r (cod_mis_pet, cod_rso) VALUES (?, ?)");
                PreparedStatement ps_mis_pet_2 = bmp.prepareStatement("UPDATE ana_mis_pet_tab SET cod_mis_pet_rpo = ? WHERE cod_mis_pet=?");
//			try
                PreparedStatement ps_mis_pet_3 = bmp.prepareStatement("SELECT cod_mis_pet FROM ana_mis_pet_tab_r WHERE cod_mis_pet = ?");
                PreparedStatement ps_mis_pet_4 = bmp.prepareStatement("SELECT cod_nor_sen FROM nor_sen_mis_pet_tab WHERE cod_mis_pet = ?");
                PreparedStatement ps_mis_pet_5 = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_tab_r VALUES(?, ?)");
//          catch
                while (i.next()) {
                    ps_mis_pet_cnt.setLong(1, i.getLong(1));
                    ResultSet rs_mis_pet_cnt = ps_mis_pet_cnt.executeQuery();
                    rs_mis_pet_cnt.next();
                    if (rs_mis_pet_cnt.getLong(1) == 0) {
                        v_cod_mis_pet = NEW_ID() + (cod_mis_pet++);
                        ps_mis_pet_0.setLong(1, v_cod_mis_pet);
                        ps_mis_pet_0.setLong(2, P_COD_AZL);
                        ps_mis_pet_0.setLong(3, i.getLong(1));
                        ps_mis_pet_1.setLong(1, v_cod_mis_pet);
                        ps_mis_pet_1.setLong(2, V_COD_RSO);
                        ps_mis_pet_2.setLong(1, v_cod_mis_pet);
                        ps_mis_pet_2.setLong(2, i.getLong(1));
                        ps_mis_pet_0.executeUpdate();
                        ps_mis_pet_1.executeUpdate();
                        ps_mis_pet_2.executeUpdate();
                        ps_mis_pet_0.clearParameters();
                        ps_mis_pet_1.clearParameters();
                        ps_mis_pet_2.clearParameters();
                    }
                    try {
                        ps_mis_pet_3.setLong(1, i.getLong(1));
                        ResultSet rs_mis_pet_3 = ps_mis_pet_3.executeQuery();
                        ps_mis_pet_4.setLong(1, i.getLong(1));
                        ResultSet rs_mis_pet_4 = ps_mis_pet_4.executeQuery();
                        rs_mis_pet_3.next();
                        rs_mis_pet_4.next();
                        ps_mis_pet_5.setLong(1, rs_mis_pet_3.getLong(1));
                        ps_mis_pet_5.setLong(2, rs_mis_pet_4.getLong(1));
                        ps_mis_pet_5.executeUpdate();
                        ps_mis_pet_3.clearParameters();
                        ps_mis_pet_4.clearParameters();
                        ps_mis_pet_5.clearParameters();
                        rs_mis_pet_3.close();
                        rs_mis_pet_4.close();
                    } catch (Exception ex1) {
                    }
                    rs_mis_pet_cnt.close();
                }
                i.close();
                ps.close();
                ps = bmp.prepareStatement("select cod_tpl_dpi from dpi_rso_tab where cod_azl=? and cod_rso = ?");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_dpi_rso_tab = bmp.prepareStatement("insert into dpi_rso_tab_r values(?, ?)");
                while (i.next()) {
                    ps_dpi_rso_tab.setLong(1, V_COD_RSO);
                    ps_dpi_rso_tab.setLong(2, i.getLong(1));
                    try {
                        ps_dpi_rso_tab.executeUpdate();
                    } catch (Exception ex) {
                    }
                    ps_dpi_rso_tab.clearParameters();
                }
                i.close();
                ps.close();
                ps = bmp.prepareStatement("select cod_nor_sen from nor_sen_rso_tab where cod_azl = ? and cod_rso= ?");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_nor_sen_rso_tab = bmp.prepareStatement("insert into nor_sen_rso_tab_r values(?, ?)");
                while (i.next()) {
                    ps_nor_sen_rso_tab.setLong(1, V_COD_RSO);
                    ps_nor_sen_rso_tab.setLong(2, i.getLong(1));
                    try {
                        ps_nor_sen_rso_tab.executeUpdate();
                    } catch (Exception ex) {
                    }
                    ps_nor_sen_rso_tab.clearParameters();
                }
                i.close();
                ps.close();
                ps = bmp.prepareStatement("select cod_cor from cor_rso_tab where cod_azl = ? and cod_rso= ?");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, P_COD_RSO);
                i = ps.executeQuery();
                PreparedStatement ps_cor_rso_tab = bmp.prepareStatement("insert into cor_rso_tab_r values(?, ?)");
                while (i.next()) {
                    ps_cor_rso_tab.setLong(1, V_COD_RSO);
                    ps_cor_rso_tab.setLong(2, i.getLong(1));
                    try {
                        ps_cor_rso_tab.executeUpdate();
                    } catch (Exception ex) {
                    }
                    ps_cor_rso_tab.clearParameters();
                }
                i.close();
                ps.close();
                ps = bmp.prepareStatement("select cod_pro_san from pro_san_rso_tab where cod_azl = ? and cod_rso= ?");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, P_COD_RSO);
                i = ps.executeQuery();
                long cod_pro_san = 0;
                PreparedStatement ps_pro_san_cnt = bmp.prepareStatement("SELECT COUNT(*) FROM ana_pro_san_tab_r WHERE nom_pro_san=(SELECT nom_pro_san FROM ana_pro_san_tab WHERE cod_pro_san = ?)");
                PreparedStatement ps_pro_san_0 = bmp.prepareStatement("SELECT cod_pro_san FROM ana_pro_san_tab_r WHERE nom_pro_san=(SELECT nom_pro_san FROM ana_pro_san_tab WHERE cod_pro_san = ?)");
                PreparedStatement ps_pro_san_1 = bmp.prepareStatement("INSERT INTO pro_san_rso_tab_r VALUES(?, ?)");
                PreparedStatement ps_pro_san_2 = bmp.prepareStatement("INSERT INTO ana_pro_san_tab_r (cod_pro_san, nom_pro_san, des_pro_san) SELECT ?, nom_pro_san, des_pro_san FROM ana_pro_san_tab WHERE cod_pro_san = ? AND cod_azl = ?");
                PreparedStatement ps_pro_san_3 = bmp.prepareStatement("UPDATE ana_pro_san_tab SET cod_pro_san_rpo = ? WHERE cod_pro_san = ?");
                PreparedStatement ps_vst_ido = bmp.prepareStatement("SELECT cod_vst_ido FROM vst_ido_pro_san_tab WHERE cod_pro_san = ?");
                PreparedStatement ps_vst_ido_cnt = bmp.prepareStatement("SELECT COUNT(*) FROM ana_vst_ido_tab_r WHERE nom_vst_ido = (SELECT nom_vst_ido FROM ana_vst_ido_tab WHERE cod_vst_ido = ?)");
                PreparedStatement ps_vst_ido_0 = bmp.prepareStatement("INSERT INTO vst_ido_pro_san_tab_r VALUES(?, ?)");
                PreparedStatement ps_vst_ido_1 = bmp.prepareStatement("SELECT cod_vst_ido FROM ana_vst_ido_tab_r WHERE nom_vst_ido = (SELECT nom_vst_ido FROM ana_vst_ido_tab WHERE cod_vst_ido =?)");
                PreparedStatement ps_vst_ido_2 = bmp.prepareStatement("INSERT INTO ana_vst_ido_tab_r SELECT ?, fat_per, per_vst, nom_vst_ido, des_vst_ido FROM ana_vst_ido_tab WHERE cod_vst_ido = ? and cod_azl = ?");
                PreparedStatement ps_vst_ido_3 = bmp.prepareStatement("UPDATE ana_vst_ido_tab SET cod_vst_ido_rpo = ? WHERE cod_vst_ido = ?");
                PreparedStatement ps_vst_med = bmp.prepareStatement("SELECT cod_vst_med FROM vst_med_pro_san_tab WHERE cod_pro_san = ?");
                PreparedStatement ps_vst_med_cnt = bmp.prepareStatement("SELECT COUNT(*) FROM ana_vst_med_tab_r WHERE nom_vst_med = (SELECT nom_vst_med FROM ana_vst_med_tab WHERE cod_vst_med = ?)");
                PreparedStatement ps_vst_med_0 = bmp.prepareStatement("INSERT INTO vst_med_pro_san_tab_r VALUES(?, ?)");
                PreparedStatement ps_vst_med_1 = bmp.prepareStatement("SELECT cod_vst_med FROM ana_vst_med_tab_r WHERE nom_vst_med = (SELECT nom_vst_med FROM ana_vst_med_tab WHERE cod_vst_med =?)");
                PreparedStatement ps_vst_med_2 = bmp.prepareStatement("INSERT INTO ana_vst_med_tab_r SELECT ?, fat_per, per_vst, nom_vst_med, des_vst_med FROM ana_vst_med_tab WHERE cod_vst_med = ? and cod_azl = ?");
                PreparedStatement ps_vst_med_3 = bmp.prepareStatement("UPDATE ana_vst_med_tab SET cod_vst_med_rpo = ? WHERE cod_vst_med = ?");
                while (i.next()) {
                    long v_pro_san;
                    ps_pro_san_cnt.setLong(1, i.getLong(1));
                    ResultSet rs_pro_san_cnt = ps_pro_san_cnt.executeQuery();
                    rs_pro_san_cnt.next();
                    if (rs_pro_san_cnt.getLong(1) == 0) {
                        v_pro_san = NEW_ID() + (cod_pro_san++);
                        ps_pro_san_2.setLong(1, v_pro_san);
                        ps_pro_san_2.setLong(2, i.getLong(1));
                        ps_pro_san_2.setLong(3, P_COD_AZL);
                        ps_pro_san_2.executeUpdate();
                        ps_pro_san_3.setLong(1, v_pro_san);
                        ps_pro_san_3.setLong(2, i.getLong(1));
                        ps_pro_san_3.executeUpdate();
                        ps_pro_san_1.setLong(1, V_COD_RSO);
                        ps_pro_san_1.setLong(2, v_pro_san);
                        ps_pro_san_1.executeUpdate();
                    } else {
                        ps_pro_san_cnt.setLong(1, i.getLong(1));
                        ResultSet rs_pro_san_0 = ps_pro_san_0.executeQuery();
                        rs_pro_san_0.next();
                        v_pro_san = rs_pro_san_0.getLong(1);
                        ps_pro_san_1.setLong(1, V_COD_RSO);
                        ps_pro_san_1.setLong(2, v_pro_san);
                        try {
                            ps_pro_san_1.executeUpdate();
                        } catch (Exception ex) {
                        }
                    }
                    ps_pro_san_cnt.clearParameters();
                    ps_pro_san_0.clearParameters();
                    ps_pro_san_1.clearParameters();
                    ps_pro_san_2.clearParameters();
                    ps_pro_san_3.clearParameters();
                    ps_vst_ido.setLong(1, i.getLong(1));
                    ResultSet x = ps_vst_ido.executeQuery();
                    while (x.next()) {
                        ps_vst_ido_cnt.setLong(1, x.getLong(1));
                        ResultSet rs_vst_ido_cnt = ps_vst_ido_cnt.executeQuery();
                        rs_vst_ido_cnt.next();
                        if (rs_vst_ido_cnt.getLong(1) == 0) {
                            long v_cod_vst_ido = NEW_ID();
                            ps_vst_ido_2.setLong(1, v_cod_vst_ido);
                            ps_vst_ido_2.setLong(2, x.getLong(1));
                            ps_vst_ido_2.setLong(3, P_COD_AZL);
                            ps_vst_ido_3.setLong(1, v_cod_vst_ido);
                            ps_vst_ido_3.setLong(2, x.getLong(1));
                            ps_vst_ido_0.setLong(1, v_pro_san);
                            ps_vst_ido_0.setLong(2, v_cod_vst_ido);
                            ps_vst_ido_2.executeUpdate();
                            ps_vst_ido_3.executeUpdate();
                            ps_vst_ido_0.executeUpdate();
                        } else {
                            ps_vst_ido_1.setLong(1, x.getLong(1));
                            ResultSet rs_vst_ido_1 = ps_vst_ido_1.executeQuery();
                            rs_vst_ido_1.next();
                            long v_cod_vst_ido = rs_vst_ido_1.getLong(1);
                            ps_vst_ido_0.setLong(1, v_pro_san);
                            ps_vst_ido_0.setLong(2, v_cod_vst_ido);
                            try {
                                ps_vst_ido_0.executeUpdate();
                            } catch (Exception ex) {
                            }
                        }
                    }
                    ps_vst_med.setLong(1, i.getLong(1));
                    ResultSet y = ps_vst_med.executeQuery();
                    while (y.next()) {
                        ps_vst_med_cnt.setLong(1, y.getLong(1));
                        ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                        rs_vst_med_cnt.next();
                        if (rs_vst_med_cnt.getLong(1) == 0) {
                            long v_cod_vst_med = NEW_ID();
                            ps_vst_med_2.setLong(1, v_cod_vst_med);
                            ps_vst_med_2.setLong(2, y.getLong(1));
                            ps_vst_med_2.setLong(3, P_COD_AZL);
                            ps_vst_med_3.setLong(1, v_cod_vst_med);
                            ps_vst_med_3.setLong(2, y.getLong(1));
                            ps_vst_med_0.setLong(1, v_pro_san);
                            ps_vst_med_0.setLong(2, v_cod_vst_med);
                            ps_vst_med_2.executeUpdate();
                            ps_vst_med_3.executeUpdate();
                            ps_vst_med_0.executeUpdate();
                        } else {
                            ps_vst_med_1.setLong(1, y.getLong(1));
                            ResultSet rs_vst_med_1 = ps_vst_med_1.executeQuery();
                            rs_vst_med_1.next();
                            long v_cod_vst_med = rs_vst_med_1.getLong(1);
                            ps_vst_med_0.setLong(1, v_pro_san);
                            ps_vst_med_0.setLong(2, v_cod_vst_med);
                            try {
                                ps_vst_med_0.executeUpdate();
                            } catch (Exception ex) {
                            }
                        }
                    }
                }
                i.close();
                ps.close();
            } else {
                result = false;
            }
            //++++++++++++++++++++++++++++++++++++++++++++++
            conn.commit();
        } catch (Exception ex) {
            result = false;
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return result;
    }
//===========================================================
    //<report alex lst_rso>

    public Collection ejbGetRischiRepositoryView(long lCOD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select nom_rso, des_rso,cod_fat_rso, prb_eve_les, ent_dan, stm_num_rso from ana_rso_tab where cod_fat_rso=? order by nom_rso");
            ps.setLong(1, lCOD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_ComboBox view = new Rischio_ComboBox();
                view.strNOM_RSO = rs.getString(1);
                view.strDES_RSO = rs.getString(2);
                view.lPRB_EVE_LES = rs.getLong(4);
                view.lENT_DAN = rs.getLong(5);
                view.lSTM_NUM_RSO = rs.getFloat(6);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</report>

    public Collection findEx(long lCOD_AZL,
            String strNOM_RSO,
            String strDES_RSO,
            java.sql.Date dtDAT_RIL,
            String strNOM_RIL_RSO,
            String strCLF_RSO,
            Long lPRB_EVE_LES,
            Long lENT_DAN,
            Long lFRQ_RIP_ATT_DAN,
            Long lNUM_INC_INF,
            Float lSTM_NUM_RSO,
            Long lRFC_VLU_RSO_MES,
            Long lCOD_FAT_RSO,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(
                lCOD_AZL,
                strNOM_RSO,
                strDES_RSO,
                dtDAT_RIL,
                strNOM_RIL_RSO,
                strCLF_RSO,
                lPRB_EVE_LES,
                lENT_DAN,
                lFRQ_RIP_ATT_DAN,
                lNUM_INC_INF,
                lSTM_NUM_RSO,
                lRFC_VLU_RSO_MES,
                lCOD_FAT_RSO,
                iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strNOM_RSO,
            String strDES_RSO,
            java.sql.Date dtDAT_RIL,
            String strNOM_RIL_RSO,
            String strCLF_RSO,
            Long lPRB_EVE_LES,
            Long lENT_DAN,
            Long lFRQ_RIP_ATT_DAN,
            Long lNUM_INC_INF,
            Float lSTM_NUM_RSO,
            Long lRFC_VLU_RSO_MES,
            Long lCOD_FAT_RSO,
            int iOrderParameter /*not used for now*/) {
        String strSql
                = "SELECT "
                + "A.COD_RSO, "
                + "UPPER(A.NOM_RSO) AS NOM_RSO, "
                + "UPPER(B.NOM_FAT_RSO) AS NOM_FAT_RSO, "
                + "A.PRB_EVE_LES, "
                + "A.ENT_DAN, "
                + "A.FRQ_RIP_ATT_DAN, "
                + "A.NUM_INC_INF, "
                + "A.STM_NUM_RSO "
                + "FROM "
                + "ANA_RSO_TAB A, "
                + "ANA_FAT_RSO_TAB B "
                + "WHERE "
                + "A.COD_FAT_RSO = B.COD_FAT_RSO "
                + "AND A.COD_AZL = ? ";
        if (dtDAT_RIL != null) {
            strSql += " AND A.DAT_RIL=? ";
        }
        if (strCLF_RSO != null) {
            strSql += " AND UPPER(A.CLF_RSO) LIKE ? ";
        }
        if (lPRB_EVE_LES != null) {
            strSql += " AND A.PRB_EVE_LES=? ";
        }
        if (lSTM_NUM_RSO != null) {
            strSql += " AND A.STM_NUM_RSO=? ";
        }
        if (lENT_DAN != null) {
            strSql += " AND A.ENT_DAN=? ";
        }
        if (lFRQ_RIP_ATT_DAN != null) {
            strSql += " AND A.FRQ_RIP_ATT_DAN=? ";
        }
        if (lNUM_INC_INF != null) {
            strSql += " AND A.NUM_INC_INF=? ";
        }
        if (lCOD_FAT_RSO != null) {
            strSql += " AND A.COD_FAT_RSO=? ";
        }
        if (strNOM_RSO != null) {
            strSql += " AND UPPER(A.NOM_RSO) LIKE ?";
        }
        if (strDES_RSO != null) {
            strSql += " AND UPPER(A.DES_RSO) LIKE ?";
        }
        if (strNOM_RIL_RSO != null) {
            strSql += " AND UPPER(A.NOM_RIL_RSO) LIKE ?";
        }
        if (lRFC_VLU_RSO_MES != null) {
            strSql += " AND RFC_VLU_RSO_MES = ? ";
        }

        strSql += " ORDER BY 3, 2";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (dtDAT_RIL != null) {
                ps.setDate(i++, dtDAT_RIL);
            }
            if (strCLF_RSO != null) {
                ps.setString(i++, strCLF_RSO.toUpperCase());
            }
            if (lPRB_EVE_LES != null) {
                ps.setLong(i++, lPRB_EVE_LES.longValue());
            }
            if (lSTM_NUM_RSO != null) {
                ps.setFloat(i++, lSTM_NUM_RSO.floatValue());
            }
            if (lENT_DAN != null) {
                ps.setLong(i++, lENT_DAN.longValue());
            }
            if (lFRQ_RIP_ATT_DAN != null) {
                ps.setLong(i++, lFRQ_RIP_ATT_DAN.longValue());
            }
            if (lNUM_INC_INF != null) {
                ps.setLong(i++, lNUM_INC_INF.longValue());
            }
            if (lCOD_FAT_RSO != null) {
                ps.setLong(i++, lCOD_FAT_RSO.longValue());
            }
            if (strNOM_RSO != null) {
                ps.setString(i++, strNOM_RSO.toUpperCase());
            }
            if (strDES_RSO != null) {
                ps.setString(i++, strDES_RSO.toUpperCase());
            }
            if (strNOM_RIL_RSO != null) {
                ps.setString(i++, strNOM_RIL_RSO.toUpperCase());
            }
            if (lRFC_VLU_RSO_MES != null) {
                ps.setLong(i++, lRFC_VLU_RSO_MES.longValue());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Rischio_Nome_Fattore_View v = new Rischio_Nome_Fattore_View();
                v.lCOD_RSO = rs.getLong(1);
                v.strNOM_RSO = rs.getString(2);
                v.strNOM_FAT_RSO = rs.getString(3);
                v.PRB_EVE_LES = rs.getLong(4);
                v.ENT_DAN = rs.getLong(5);
                v.FRQ_RIP_ATT_DAN = rs.getLong(6);
                v.NUM_INC_INF = rs.getLong(7);
                v.STM_NUM_RSO = rs.getLong(8);
                ar.add(v);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addART_LEG(long COD_ARL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO rso_arl_tab (cod_arl, cod_rso, cod_azl) VALUES(?,?,?)");
            ps.setLong(1, COD_ARL);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Articolo di legge associato non e' inserito");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

    }

    public void removeART_LEG(long lCOD_ARL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_arl_tab  WHERE  (cod_arl=? AND cod_rso=?)");
            ps.setLong(1, lCOD_ARL);
            ps.setLong(2, lCOD_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  annulata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------------------------------
}
