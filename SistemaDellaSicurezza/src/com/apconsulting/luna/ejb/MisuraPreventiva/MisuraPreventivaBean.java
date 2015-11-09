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
package com.apconsulting.luna.ejb.MisuraPreventiva;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
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
public class MisuraPreventivaBean extends BMPEntityBean implements IMisuraPreventiva, IMisuraPreventivaHome {
    //< member-varibles description="Member Variables">

    MisuraPreventivaPK primaryKey;
    long lCOD_MIS_PET;
    String strNOM_MIS_PET;
    java.sql.Date dtDAT_CMP;
    long lVER_MIS_PET;
    String strIST_OPE_COR;
    String strADT_MIS_PET;
    java.sql.Date dtDAT_PAR_ADT;
    String strPER_MIS_PET;
    long lPNZ_MIS_PET_MES;
    java.sql.Date dtDAT_PNZ_MIS_PET;
    String strDES_MIS_PET;
    String strTPL_DSI_MIS_PET;
    String strDSI_AZL_MIS_PET;
    long lCOD_TPL_MIS_PET;
    long lCOD_MIS_PET_RPO;
    long lCOD_AZL;
    //< /member-varibles>

    //< IMisuraPreventivaHome-implementation>
    public static final String BEAN_NAME = "MisuraPreventivaBean";
    // CONSTRUCTOR

    private static MisuraPreventivaBean ys = null;
    private MisuraPreventivaBean() {
    }
    public static MisuraPreventivaBean getInstance(){
        if (ys==null) ys = new MisuraPreventivaBean();
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        MisuraPreventivaBean bean = new MisuraPreventivaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((MisuraPreventivaPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    //-----

    public void remove(Object primaryKey, java.util.ArrayList alAziende) {
        MisuraPreventivaBean bean = new MisuraPreventivaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((MisuraPreventivaPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove(alAziende);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    //---------------------------------------------------------------

    public IMisuraPreventiva create(
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            long lVER_MIS_PET,
            String strIST_OPE_COR,
            String strADT_MIS_PET,
            java.sql.Date dtDAT_PAR_ADT,
            String strPER_MIS_PET,
            long lPNZ_MIS_PET_MES,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            long lCOD_TPL_MIS_PET,
            long lCOD_MIS_PET_RPO,
            long lCOD_AZL,
            java.util.ArrayList alAziende) throws javax.ejb.CreateException {
        MisuraPreventivaBean bean = new MisuraPreventivaBean();
        try {
            Object pKey = bean.ejbCreate(
                    strNOM_MIS_PET,
                    dtDAT_CMP,
                    lVER_MIS_PET,
                    strIST_OPE_COR,
                    strADT_MIS_PET,
                    dtDAT_PAR_ADT,
                    strPER_MIS_PET,
                    lPNZ_MIS_PET_MES,
                    dtDAT_PNZ_MIS_PET,
                    strDES_MIS_PET,
                    strTPL_DSI_MIS_PET,
                    strDSI_AZL_MIS_PET,
                    lCOD_TPL_MIS_PET,
                    lCOD_MIS_PET_RPO,
                    lCOD_AZL,
                    alAziende);
            bean.setEntityContext(new EntityContextWrapper(pKey));
            bean.ejbPostCreate(
                    strNOM_MIS_PET,
                    dtDAT_CMP,
                    lVER_MIS_PET,
                    strIST_OPE_COR,
                    strADT_MIS_PET,
                    dtDAT_PAR_ADT,
                    strPER_MIS_PET,
                    lPNZ_MIS_PET_MES,
                    dtDAT_PNZ_MIS_PET,
                    strDES_MIS_PET,
                    strTPL_DSI_MIS_PET,
                    strDSI_AZL_MIS_PET,
                    lCOD_TPL_MIS_PET,
                    lCOD_MIS_PET_RPO,
                    lCOD_AZL,
                    alAziende);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    //--------------------
    public IMisuraPreventiva findByPrimaryKey(MisuraPreventivaPK primaryKey) throws javax.ejb.FinderException {
        MisuraPreventivaBean bean = new MisuraPreventivaBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //==========================================================================================

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
//

    public Collection getMisure_Preventive_ByAzienda_View(long lCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbMisure_Preventive_ByAzienda_View(lCOD_AZL);
    }
//

    public Collection getMisure_Preventive_LUO_ByAzienda_View(long lCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbMisure_Preventive_LUO_ByAzienda_View(lCOD_AZL);
    }
//

    public Collection getMisure_Preventive_MAN_ByAzienda_View(long lCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbMisure_Preventive_MAN_ByAzienda_View(lCOD_AZL);
    }
//

    public Collection getMisureComboView(long lCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbGetMisureComboView(lCOD_AZL);
    }
//

    public Collection getMisureLuoManComboView(String strTYPE, String strCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbGetMisureLuoManComboView(strTYPE, strCOD_AZL);
    }
//

    public Collection getRischiComboView(String strTYPE, String strCOD_AZL) {
        return (new MisuraPreventivaBean()).ejbGetRischiComboView(strTYPE, strCOD_AZL);
    }
//

    public Collection getMisuraPreventiva_to_SCH_MIS_PET_View(long lCOD_AZL, String strNB_APL_A, String strNB_NOM_RSO, long lNB_COD_MIS_PET_LUO_MAN, String strNB_NOM_MIS_PET, String strNB_DES_TPL_MIS_PET, java.sql.Date dNB_DAT_CMP_DAL, java.sql.Date dNB_DAT_CMP_AL, java.sql.Date dNB_DAT_PNZ_MIS_PET_DAL, java.sql.Date dNB_DAT_PNZ_MIS_PET_AL, String strRAGGRUPPATI, String strNB_DAT_PAR_ADT) {
        return (new MisuraPreventivaBean()).ejbGetMisuraPreventiva_to_SCH_MIS_PET_View(lCOD_AZL, strNB_APL_A, strNB_NOM_RSO, lNB_COD_MIS_PET_LUO_MAN, strNB_NOM_MIS_PET, strNB_DES_TPL_MIS_PET, dNB_DAT_CMP_DAL, dNB_DAT_CMP_AL, dNB_DAT_PNZ_MIS_PET_DAL, dNB_DAT_PNZ_MIS_PET_AL, strRAGGRUPPATI, strNB_DAT_PAR_ADT);
    }
    //

    public Collection findEx(long lCOD_AZL,
            String strPER_MIS_PET,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            Long lVER_MIS_PET,
            String strIST_OPE_COR,
            java.sql.Date dtDAT_PAR_ADT,
            Long lPNZ_MIS_PET_MES,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter) {
        return (new MisuraPreventivaBean()).ejbFindEx(
                lCOD_AZL, strPER_MIS_PET, dtDAT_PNZ_MIS_PET,
                strNOM_MIS_PET, dtDAT_CMP,
                lVER_MIS_PET,strIST_OPE_COR, dtDAT_PAR_ADT,
                lPNZ_MIS_PET_MES, strDES_MIS_PET,
                strTPL_DSI_MIS_PET, iOrderParameter);
    }
//

//---------------------------------------------------------------------------------------------------------
    public MisuraPreventivaPK ejbCreate(
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            long lVER_MIS_PET,
            String strIST_OPE_COR,
            String strADT_MIS_PET,
            java.sql.Date dtDAT_PAR_ADT,
            String strPER_MIS_PET,
            long lPNZ_MIS_PET_MES,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            long lCOD_TPL_MIS_PET,
            long lCOD_MIS_PET_RPO,
            long lCOD_AZL,
            java.util.ArrayList alAziende) {
        long lFirstKey = NEW_ID();
        this.lCOD_MIS_PET = NEW_ID();
        this.strNOM_MIS_PET = strNOM_MIS_PET;
        this.dtDAT_CMP = dtDAT_CMP;
        this.lVER_MIS_PET = lVER_MIS_PET;
        this.strIST_OPE_COR = strIST_OPE_COR;
        this.strADT_MIS_PET = strADT_MIS_PET;
        this.strPER_MIS_PET = strPER_MIS_PET;
        this.lPNZ_MIS_PET_MES = lPNZ_MIS_PET_MES;
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        this.strDES_MIS_PET = strDES_MIS_PET;
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;
        this.lCOD_MIS_PET_RPO = lCOD_MIS_PET_RPO;
        this.lCOD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_mis_pet_tab " +
                    "(cod_mis_pet, " +
                    " nom_mis_pet, " +
                    " dat_cmp, " +
                    " ver_mis_pet, " +
                    " IST_OPE_COR, " +
                    " adt_mis_pet," +
                    " per_mis_pet, " +
                    " pnz_mis_pet_mes, " +
                    " dat_pnz_mis_pet, " +
                    " des_mis_pet, " +
                    " tpl_dsi_mis_pet, " +
                    " dsi_azl_mis_pet, " +
                    " cod_tpl_mis_pet, " +
                    " cod_mis_pet_rpo, " +
                    " cod_azl) " +
                    " VALUES(?, ?, ?, ?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setString(2, strNOM_MIS_PET);
            ps.setDate(3, dtDAT_CMP);
            ps.setLong(4, lVER_MIS_PET);
            ps.setString(5, strIST_OPE_COR);
            ps.setString(6, strADT_MIS_PET);
            ps.setString(7, strPER_MIS_PET);
            ps.setLong(8, lPNZ_MIS_PET_MES);
            ps.setDate(9, dtDAT_PNZ_MIS_PET);
            ps.setString(10, strDES_MIS_PET);
            ps.setString(11, strTPL_DSI_MIS_PET);
            ps.setString(12, strDSI_AZL_MIS_PET);
            ps.setLong(13, lCOD_TPL_MIS_PET);
            ps.setLong(14, lCOD_MIS_PET_RPO);
            ps.setLong(15, lCOD_AZL);
            ps.executeUpdate();

            logger.info("Propagazione: \"ANAGRAFICA - MISURA PREVENZIONE E PROTEZIONE\"");
            setExtendedObject(bmp, "ana_mis_pet_tab", lFirstKey, lCOD_MIS_PET, lCOD_AZL);

            logger.info("Lista Aziende su cui propagare: " + alAziende.toString() + " INIZIO CICLO");
            Iterator it = alAziende.iterator();
            while (it.hasNext()) {
                long cod_azl = ((Long) it.next()).longValue();
                if (cod_azl == lCOD_AZL) {
                    continue;
                }
                long lSecondKey = NEW_ID();
                ps.setLong(1, lSecondKey);
                ps.setLong(15, cod_azl);
                ps.executeUpdate();
                setExtendedObject(bmp, "ana_mis_pet_tab", lFirstKey, lSecondKey, cod_azl);
            }
            logger.info("Lista Aziende su cui propagare: FINE CICLO");

            bmp.commitTrans();
            return new MisuraPreventivaPK(lCOD_AZL, lCOD_MIS_PET);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------------------------------------------------------------

    public void ejbPostCreate(
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            long lVER_MIS_PET,
            String strIST_OPE_COR,
            String strADT_MIS_PET,
            java.sql.Date dtDAT_PAR_ADT,
            String strPER_MIS_PET,
            long lPNZ_MIS_PET_MES,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            long lCOD_TPL_MIS_PET,
            long lCOD_MIS_PET_RPO,
            long lCOD_AZL,
            java.util.ArrayList alAziende) {
    }
//---------------------------------------------------------------------------------------------------------

    public boolean isMultiple() {
        return isExtendedObject("ana_mis_pet_tab", lCOD_MIS_PET);
    }
//--------------------------------------------------
//

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet FROM ana_mis_pet_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public MisuraPreventivaPK ejbFindByPrimaryKey(MisuraPreventivaPK primaryKey) {
        return primaryKey;
    }
//

    public void ejbActivate() {
        //this.lCOD_MIS_PET=((Long)this.getEntityKey()).longValue();
        this.primaryKey = ((MisuraPreventivaPK) this.getEntityKey());
        this.lCOD_MIS_PET = primaryKey.lCOD_MIS_PET;
        this.lCOD_AZL = primaryKey.lCOD_AZL;

    }
//

    public void ejbPassivate() {
        this.lCOD_MIS_PET = -1;
        this.primaryKey = null;
    }
//

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet,nom_mis_pet,dat_cmp,ver_mis_pet,IST_OPE_COR,adt_mis_pet,dat_par_adt,per_mis_pet,pnz_mis_pet_mes,dat_pnz_mis_pet,des_mis_pet,tpl_dsi_mis_pet,dsi_azl_mis_pet,cod_tpl_mis_pet,cod_mis_pet_rpo,cod_azl FROM ana_mis_pet_tab WHERE cod_mis_pet=? AND cod_azl=? ");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_MIS_PET = rs.getLong(1);
                strNOM_MIS_PET = rs.getString(2);
                dtDAT_CMP = rs.getDate(3);
                lVER_MIS_PET = rs.getLong(4);
                strIST_OPE_COR = rs.getString(5);
                strADT_MIS_PET = rs.getString(6);
                dtDAT_PAR_ADT = rs.getDate(7);
                strPER_MIS_PET = rs.getString(8);
                lPNZ_MIS_PET_MES = rs.getLong(9);
                dtDAT_PNZ_MIS_PET = rs.getDate(10);
                strDES_MIS_PET = rs.getString(11);
                strTPL_DSI_MIS_PET = rs.getString(12);
                strDSI_AZL_MIS_PET = rs.getString(13);
                lCOD_TPL_MIS_PET = rs.getLong(14);
                lCOD_MIS_PET_RPO = rs.getLong(15);
                lCOD_AZL = rs.getLong(16);
            } else {
                throw new NoSuchEntityException("MisuraPreventivaBean with ID=" + lCOD_MIS_PET + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------

    public void ejbRemove() {
        ejbRemove(null);
    }
    //

    public void ejbRemove(java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            bmp.beginTrans();
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM " +
                        "ana_mis_pet_tab " +
                    "WHERE " +
                        "(  cod_mis_pet=? " +
                            "OR cod_mis_pet IN " +
                                "(" + getExtendedObjects("ana_mis_pet_tab", alAziende) + ") ) " +
                        "AND (  cod_azl=? " +
                                "OR cod_azl IN  " +
                                    "(" + toString(alAziende) + "))");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_MIS_PET);
            ps.setLong(3, lCOD_AZL);
            
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Misura Preventiva con ID=" + lCOD_MIS_PET + " non trovata");
            }

            removeExtendedObject(bmp, "ana_mis_pet_tab", lCOD_MIS_PET, lCOD_AZL, alAziende);

            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //---------------------------
    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        store(
                strNOM_MIS_PET,
                dtDAT_CMP,
                lVER_MIS_PET,
                strIST_OPE_COR,
                strADT_MIS_PET,
                dtDAT_PAR_ADT,
                strPER_MIS_PET,
                lPNZ_MIS_PET_MES,
                dtDAT_PNZ_MIS_PET,
                strDES_MIS_PET,
                strTPL_DSI_MIS_PET,
                strDSI_AZL_MIS_PET,
                lCOD_TPL_MIS_PET,
                lCOD_MIS_PET_RPO,
                lCOD_AZL,
                null);
    }
    //

    public void store(
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            long lVER_MIS_PET,
            String strIST_OPE_COR,
            String strADT_MIS_PET,
            java.sql.Date dtDAT_PAR_ADT,
            String strPER_MIS_PET,
            long lPNZ_MIS_PET_MES,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            long lCOD_TPL_MIS_PET,
            long lCOD_MIS_PET_RPO,
            long lCOD_AZL,
            java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE ana_mis_pet_tab SET nom_mis_pet=?, dat_cmp=?, ver_mis_pet=?,IST_OPE_COR=?, adt_mis_pet=?, dat_par_adt=?, per_mis_pet=?, pnz_mis_pet_mes=?, dat_pnz_mis_pet=?, des_mis_pet=?, tpl_dsi_mis_pet=?, dsi_azl_mis_pet=?, cod_tpl_mis_pet=?, cod_mis_pet_rpo=?  WHERE ( cod_mis_pet=? or cod_mis_pet IN (" + getExtendedObjects("ana_mis_pet_tab", alAziende) + ") )  AND (cod_azl=? OR cod_azl IN (" + toString(alAziende) + ") ) ");
            //ps.setLong(1, lCOD_MIS_PET);
            ps.setString(1, strNOM_MIS_PET);
            ps.setDate(2, dtDAT_CMP);
            ps.setLong(3, lVER_MIS_PET);
            ps.setString(4, strIST_OPE_COR);
            ps.setString(5, strADT_MIS_PET);
            ps.setDate(6, dtDAT_PAR_ADT);
            ps.setString(7, strPER_MIS_PET);
            if (lPNZ_MIS_PET_MES == 0) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setLong(8, lPNZ_MIS_PET_MES);
            }
            ps.setDate(9, dtDAT_PNZ_MIS_PET);
            ps.setString(10, strDES_MIS_PET);
            ps.setString(11, strTPL_DSI_MIS_PET);
            ps.setString(12, strDSI_AZL_MIS_PET);
            ps.setLong(13, lCOD_TPL_MIS_PET);
            if (lCOD_MIS_PET_RPO == 0) {
                ps.setNull(14, java.sql.Types.BIGINT);
            } else {
                ps.setLong(14, lCOD_MIS_PET_RPO);
            }
            ps.setLong(15, lCOD_MIS_PET);
            ps.setLong(16, lCOD_MIS_PET);
            ps.setLong(17, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("MisuraPreventivaBean with ID=" + lCOD_MIS_PET + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


//< setter-getters>
    public long getCOD_MIS_PET() {
        return lCOD_MIS_PET;
    }
//

    public String getNOM_MIS_PET() {
        return strNOM_MIS_PET;
    }

    public void setNOM_MIS_PET(String strNOM_MIS_PET) {
        if ((this.strNOM_MIS_PET != null) && (this.strNOM_MIS_PET.equals(strNOM_MIS_PET))) {
            return;
        }
        this.strNOM_MIS_PET = strNOM_MIS_PET;
        setModified();
    }
//

    public java.sql.Date getDAT_CMP() {
        return dtDAT_CMP;
    }

    public void setDAT_CMP(java.sql.Date dtDAT_CMP) {
        if (this.dtDAT_CMP == dtDAT_CMP) {
            return;
        }
        this.dtDAT_CMP = dtDAT_CMP;
        setModified();
    }
//

    public long getVER_MIS_PET() {
        return lVER_MIS_PET;
    }

    public void setVER_MIS_PET(long lVER_MIS_PET) {
        if (this.lVER_MIS_PET == lVER_MIS_PET) {
            return;
        }
        this.lVER_MIS_PET = lVER_MIS_PET;
        setModified();
    }
//

    public String getIST_OPE_COR() {
        return strIST_OPE_COR;
    }

    public void setIST_OPE_COR(String strIST_OPE_COR) {
        if ((this.strIST_OPE_COR != null) && (this.strIST_OPE_COR.equals(strIST_OPE_COR))) {
            return;
        }
        this.strIST_OPE_COR = strIST_OPE_COR;
        setModified();
    }
//

    public String getADT_MIS_PET() {
        return strADT_MIS_PET;
    }

    public void setADT_MIS_PET(String strADT_MIS_PET) {
        if ((this.strADT_MIS_PET != null) && (this.strADT_MIS_PET.equals(strADT_MIS_PET))) {
            return;
        }
        this.strADT_MIS_PET = strADT_MIS_PET;
        setModified();
    }
//

    public java.sql.Date getDAT_PAR_ADT() {
        return dtDAT_PAR_ADT;
    }

    public void setDAT_PAR_ADT(java.sql.Date dtDAT_PAR_ADT) {
        if (this.dtDAT_PAR_ADT == dtDAT_PAR_ADT) {
            return;
        }
        this.dtDAT_PAR_ADT = dtDAT_PAR_ADT;
        setModified();
    }
//

    public String getPER_MIS_PET() {
        return strPER_MIS_PET;
    }

    public void setPER_MIS_PET(String strPER_MIS_PET) {
        if ((this.strPER_MIS_PET != null) && (this.strPER_MIS_PET.equals(strPER_MIS_PET))) {
            return;
        }
        this.strPER_MIS_PET = strPER_MIS_PET;
        setModified();
    }
//

    public long getPNZ_MIS_PET_MES() {
        return lPNZ_MIS_PET_MES;
    }

    public void setPNZ_MIS_PET_MES(long lPNZ_MIS_PET_MES) {
        if (this.lPNZ_MIS_PET_MES == lPNZ_MIS_PET_MES) {
            return;
        }
        this.lPNZ_MIS_PET_MES = lPNZ_MIS_PET_MES;
        setModified();
    }
//

    public java.sql.Date getDAT_PNZ_MIS_PET() {
        return dtDAT_PNZ_MIS_PET;
    }

    public void setDAT_PNZ_MIS_PET(java.sql.Date dtDAT_PNZ_MIS_PET) {
        if (this.dtDAT_PNZ_MIS_PET == dtDAT_PNZ_MIS_PET) {
            return;
        }
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        setModified();
    }
//

    public String getDES_MIS_PET() {
        return strDES_MIS_PET;
    }

    public void setDES_MIS_PET(String strDES_MIS_PET) {
        if ((this.strDES_MIS_PET != null) && (this.strDES_MIS_PET.equals(strDES_MIS_PET))) {
            return;
        }
        this.strDES_MIS_PET = strDES_MIS_PET;
        setModified();
    }
//

    public String getTPL_DSI_MIS_PET() {
        return strTPL_DSI_MIS_PET;
    }

    public void setTPL_DSI_MIS_PET(String strTPL_DSI_MIS_PET) {
        if ((this.strTPL_DSI_MIS_PET != null) && (this.strTPL_DSI_MIS_PET.equals(strTPL_DSI_MIS_PET))) {
            return;
        }
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        setModified();
    }
//

    public String getDSI_AZL_MIS_PET() {
        return strDSI_AZL_MIS_PET;
    }

    public void setDSI_AZL_MIS_PET(String strDSI_AZL_MIS_PET) {
        if ((this.strDSI_AZL_MIS_PET != null) && (this.strDSI_AZL_MIS_PET.equals(strDSI_AZL_MIS_PET))) {
            return;
        }
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        setModified();
    }
//

    public long getCOD_TPL_MIS_PET() {
        return lCOD_TPL_MIS_PET;
    }

    public void setCOD_TPL_MIS_PET(long lCOD_TPL_MIS_PET) {
        if (this.lCOD_TPL_MIS_PET == lCOD_TPL_MIS_PET) {
            return;
        }
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;
        setModified();
    }
//

    public long getCOD_MIS_PET_RPO() {
        return lCOD_MIS_PET_RPO;
    }

    public void setCOD_MIS_PET_RPO(long lCOD_MIS_PET_RPO) {
        if (this.lCOD_MIS_PET_RPO == lCOD_MIS_PET_RPO) {
            return;
        }
        this.lCOD_MIS_PET_RPO = lCOD_MIS_PET_RPO;
        setModified();
    }
//

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
//

    public void setNOM_MIS_PET_COD_AZL_VER_MIS_PET(String strNOM_MIS_PET, long lCOD_AZL, long lVER_MIS_PET) {
        if (this.strNOM_MIS_PET.equals(strNOM_MIS_PET) && this.lCOD_AZL != lCOD_AZL && this.lVER_MIS_PET != lVER_MIS_PET) {
            return;
        }
        this.lCOD_AZL = lCOD_AZL;
        this.strNOM_MIS_PET = strNOM_MIS_PET;
        this.lVER_MIS_PET = lVER_MIS_PET;
        setModified();
    }
//

    public long getCOD_RSO() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT c.cod_rso " + " FROM ana_rso_tab c, rso_mis_pet_tab d " + " WHERE d.cod_rso = c.cod_rso and d.cod_azl = c.cod_azl" + " AND d.cod_mis_pet = ?");
            ps.setLong(1, lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return 0;
    }

    //< /setter-getters>
    public Collection ejbMisure_Preventive_ByAzienda_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_mis_pet_tab WHERE cod_azl=? order by nom_mis_pet");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Misure_Preventive_ByAzienda_View obj = new Misure_Preventive_ByAzienda_View();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.dtDAT_CMP = rs.getDate(3);
                obj.lVER_MIS_PET = rs.getLong(4);
                obj.strADT_MIS_PET = rs.getString(5);
                obj.dtDAT_PAR_ADT = rs.getDate(6);
                obj.strPER_MIS_PET = rs.getString(7);
                obj.lPNZ_MIS_PET_MES = rs.getLong(8);
                obj.dtDAT_PNZ_MIS_PET = rs.getDate(9);
                obj.strDES_MIS_PET = rs.getString(10);
                obj.strTPL_DSI_MIS_PET = rs.getString(11);
                obj.strDSI_AZL_MIS_PET = rs.getString(12);
                obj.lCOD_TPL_MIS_PET = rs.getLong(13);
                obj.lCOD_MIS_PET_RPO = rs.getLong(14);
                obj.lCOD_AZL = rs.getLong(15);
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
//

    public Collection ejbFindEx(long lCOD_AZL,
            String strPER_MIS_PET,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            Long lVER_MIS_PET,
            String strIST_OPE_COR,
            java.sql.Date dtDAT_PAR_ADT,
            Long lPNZ_MIS_PET_MES,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter) {
        String strSQL = "SELECT * FROM ana_mis_pet_tab WHERE cod_azl=? ";
        if (strPER_MIS_PET != null) {
            strSQL += " AND UPPER(per_mis_pet) LIKE ? ";
        }
        if (dtDAT_PNZ_MIS_PET != null) {
            strSQL += " AND dat_pnz_mis_pet=? ";
        }
        if (strNOM_MIS_PET != null) {
            strSQL += " AND UPPER(nom_mis_pet) LIKE ? ";
        }
        if (dtDAT_CMP != null) {
            strSQL += " AND dat_cmp=? ";
        }
        if (lVER_MIS_PET != null) {
            strSQL += " AND ver_mis_pet = ? ";
        }
        if (strIST_OPE_COR != null) {
            strSQL += " AND UPPER(ist_ope_cor) LIKE ? ";
        }
        if (dtDAT_PAR_ADT != null) {
            strSQL += " AND dat_par_adt=? ";
        }
        if (lPNZ_MIS_PET_MES != null) {
            strSQL += " AND pnz_mis_pet_mes  = ? ";
        }
        if (strDES_MIS_PET != null) {
            strSQL += " AND UPPER(des_mis_pet) LIKE ? ";
        }
        if (strTPL_DSI_MIS_PET != null) {
            strSQL += " AND UPPER(tpl_dsi_mis_pet) LIKE ? ";
        }
        strSQL += " order by UPPER(nom_mis_pet)";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(i++, lCOD_AZL);
            if (strPER_MIS_PET != null) {
                ps.setString(i++, strPER_MIS_PET.toUpperCase());
            }
            if (dtDAT_PNZ_MIS_PET != null) {
                ps.setDate(i++, dtDAT_PNZ_MIS_PET);
            }
            if (strNOM_MIS_PET != null) {
                ps.setString(i++, strNOM_MIS_PET.toUpperCase());
            }
            if (dtDAT_CMP != null) {
                ps.setDate(i++, dtDAT_CMP);
            }
            if (lVER_MIS_PET != null) {
                ps.setLong(i++, lVER_MIS_PET.longValue());
            }
            if (strIST_OPE_COR != null) {
                ps.setString(i++, strIST_OPE_COR.toUpperCase());
            }
            if (dtDAT_PAR_ADT != null) {
                ps.setDate(i++, dtDAT_PAR_ADT);
            }
            if (lPNZ_MIS_PET_MES != null) {
                ps.setLong(i++, lPNZ_MIS_PET_MES.longValue());
            }
            if (strDES_MIS_PET != null) {
                ps.setString(i++, strDES_MIS_PET.toUpperCase());
            }
            if (strTPL_DSI_MIS_PET != null) {
                ps.setString(i++, strTPL_DSI_MIS_PET.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Misure_Preventive_ByAzienda_View obj = new Misure_Preventive_ByAzienda_View();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.dtDAT_CMP = rs.getDate(3);
                obj.lVER_MIS_PET = rs.getLong(4);
                obj.strADT_MIS_PET = rs.getString(5);
                obj.dtDAT_PAR_ADT = rs.getDate(6);
                obj.strPER_MIS_PET = rs.getString(7);
                obj.lPNZ_MIS_PET_MES = rs.getLong(8);
                obj.dtDAT_PNZ_MIS_PET = rs.getDate(9);
                obj.strDES_MIS_PET = rs.getString(10);
                obj.strTPL_DSI_MIS_PET = rs.getString(11);
                obj.strDSI_AZL_MIS_PET = rs.getString(12);
                obj.lCOD_TPL_MIS_PET = rs.getLong(13);
                obj.lCOD_MIS_PET_RPO = rs.getLong(14);
                obj.lCOD_AZL = rs.getLong(15);
                obj.strIST_OPE_COR = rs.getString(16);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public Collection ejbMisure_Preventive_LUO_ByAzienda_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT b.cod_mis_pet,b.nom_mis_pet FROM mis_pet_luo_fsc_tab a,ana_mis_pet_tab b WHERE a.cod_mis_pet = b.cod_mis_pet AND b.cod_azl=?");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Misure_Preventive_LUO_ByAzienda_View obj = new Misure_Preventive_LUO_ByAzienda_View();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
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
//

    public Collection ejbMisure_Preventive_MAN_ByAzienda_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT b.cod_mis_pet,b.nom_mis_pet FROM mis_pet_man_tab a,ana_mis_pet_tab b WHERE a.cod_mis_pet = b.cod_mis_pet AND b.cod_azl=?");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Misure_Preventive_MAN_ByAzienda_View obj = new Misure_Preventive_MAN_ByAzienda_View();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
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
//

    public Collection getAnagraficaDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  doc.cod_doc, doc.tit_doc, doc.rsp_doc, doc.dat_rev_doc from ana_doc_tab doc,  ana_mis_pet_tab mis, doc_mis_pet_tab doc_mis    where   doc.cod_doc=doc_mis.cod_doc and mis.cod_mis_pet=doc_mis.cod_mis_pet and mis.cod_mis_pet=?");
            ps.setLong(1, lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagraficaDocumentiView obj = new AnagraficaDocumentiView();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strTIT_DOC = rs.getString(2);
                obj.strRSP_DOC = rs.getString(3);
                obj.dtDAT_REV_DOC = rs.getDate(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//

    public Collection getNormativeSentenzeView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  sen.cod_nor_sen, sen.tit_nor_sen, sen.dat_nor_sen from   ana_nor_sen_tab sen, ana_mis_pet_tab mis, nor_sen_mis_pet_tab sen_mis where   sen.cod_nor_sen = sen_mis.cod_nor_sen and  mis.cod_mis_pet=sen_mis.cod_mis_pet and mis.cod_mis_pet=? order by sen.tit_nor_sen");
            ps.setLong(1, lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NormativeSentenzeView obj = new NormativeSentenzeView();
                obj.lCOD_NOR_SEN = rs.getLong(1);
                obj.strTIT_NOR_SEN = rs.getString(2);
                obj.dtDAT_NOR_SEN = rs.getDate(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//-----------methods for dependences --------------------------

    public void addDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_mis_pet_tab (cod_mis_pet, cod_doc) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_DOC);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public void deleteDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_mis_pet_tab WHERE cod_mis_pet=? AND cod_doc=?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento with ID=" + lCOD_DOC + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public void addNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_tab (cod_mis_pet, cod_nor_sen) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_NOR_SEN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public void deleteNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM nor_sen_mis_pet_tab WHERE cod_mis_pet=? AND cod_nor_sen=?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, lCOD_NOR_SEN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Normativa sentenza con ID=" + lCOD_NOR_SEN + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public void removeLUO_FSC_MIS_PET() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mis_pet_luo_fsc_tab WHERE cod_mis_pet = ?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void removeGEST_MAN_MIS_PET() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mis_pet_man_tab WHERE cod_mis_pet = ?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public Collection ejbGetMisureComboView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT a.cod_mis_pet, a.nom_mis_pet, " + " a.cod_tpl_mis_pet, c.cod_rso, c.nom_rso, a.ver_mis_pet " + " FROM ana_mis_pet_tab a, tpl_mis_pet_tab b, ana_rso_tab c, rso_mis_pet_tab d " + " WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet " + " AND d.cod_rso = c.cod_rso " + " AND a.cod_mis_pet = d.cod_mis_pet " + " AND a.cod_azl = ? ");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisureComboView obj = new MisureComboView();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.lCOD_TPL_MIS_PET = rs.getLong(3);
                obj.lCOD_RSO = rs.getLong(4);
                obj.strNOM_RSO = rs.getString(5);
                obj.lVER_MIS_PET = rs.getLong(6);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//

    public Collection ejbGetMisureLuoManComboView(String strTYPE, String strCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String sqlText = "";
            if ("L".equals(strTYPE)) {
                sqlText = 
                        "SELECT "
                            + "a.cod_mis_rso_luo, "
                            + "c.nom_luo_fsc "
                        + "FROM "
                            + "mis_pet_luo_fsc_tab a, "
                            + "ana_mis_pet_tab b, "
                            + "ana_luo_fsc_tab c "
                        + "WHERE "
                            + "a.cod_mis_pet = b.cod_mis_pet "
                            + "AND a.cod_luo_fsc = c.cod_luo_fsc";
            } else {
                sqlText = "SELECT DISTINCT a.cod_mis_pet_man, b.nom_mis_pet, c.nom_man " + " FROM mis_pet_man_tab a,ana_mis_pet_tab b,ana_man_tab c " + " WHERE a.cod_mis_pet = b.cod_mis_pet AND a.cod_man=c.cod_man";
            }
            if (strCOD_AZL != null && !strCOD_AZL.equals("")) {
                sqlText += " AND b.cod_azl = " + strCOD_AZL;
            }
            PreparedStatement ps = bmp.prepareStatement(sqlText);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisureLuoManComboView obj = new MisureLuoManComboView();
                obj.lCOD_MIS = rs.getLong(1);
                obj.strNOM_MIS = rs.getString(2);
                if (!"L".equals(strTYPE)) {
                    obj.strNOM_MAN = rs.getString(3);
                }
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//

    public Collection ejbGetRischiComboView(String strTYPE, String strCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String sqlText = "SELECT DISTINCT a.cod_rso, a.nom_rso, b.nom_mis_pet " + " FROM ana_rso_tab a";
            if ("L".equals(strTYPE)) {
                sqlText += ", ana_mis_pet_tab b, mis_pet_luo_fsc_tab c, rso_mis_pet_tab d " + " WHERE d.cod_rso=a.cod_rso and d.cod_azl=a.cod_azl" + " AND b.cod_mis_pet=c.cod_mis_pet " + " AND b.cod_azl=a.cod_azl " + " AND d.cod_mis_pet = b.cod_mis_pet";
            } else {
                sqlText += ", ana_mis_pet_tab b, mis_pet_man_tab c, rso_mis_pet_tab d " + " WHERE d.cod_rso=a.cod_rso and d.cod_azl=a.cod_azl" + " AND b.cod_mis_pet=c.cod_mis_pet " + " AND b.cod_azl=a.cod_azl " + " AND d.cod_mis_pet = b.cod_mis_pet";
            }
            if (strCOD_AZL != null && !strCOD_AZL.equals("")) {
                sqlText += " AND a.cod_azl = " + strCOD_AZL;
            }
            sqlText += " ORDER BY a.nom_rso";
            PreparedStatement ps = bmp.prepareStatement(sqlText);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischiComboView obj = new RischiComboView();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.strNOM_MIS_PET = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

/////////////////////////--- View for SCH_MIS_PET-----------by Juli

//--- Juli
    public Collection ejbGetMisuraPreventiva_to_SCH_MIS_PET_View(long lCOD_AZL, String strNB_APL_A, String strNB_NOM_RSO, long lNB_COD_MIS_PET_LUO_MAN, String strNB_NOM_MIS_PET, String strNB_DES_TPL_MIS_PET, java.sql.Date dNB_DAT_CMP_DAL, java.sql.Date dNB_DAT_CMP_AL, java.sql.Date dNB_DAT_PNZ_MIS_PET_DAL, java.sql.Date dNB_DAT_PNZ_MIS_PET_AL, String strRAGGRUPPATI, String strNB_DAT_PAR_ADT) {
        int icounterWhere = 2;
        int iCOUNT_NB_APL_L = 0;
        int iCOUNT_NB_APL_M = 0;
        int iCOUNT_NB_NOM_RSO = 0;
        int iCOUNT_NB_NOM_MIS_PET = 0;
        int iCOUNT_NB_DES_TPL_MIS_PET = 0;
        int iCOUNT_NB_DAT_CMP_DAL = 0;
        int iCOUNT_NB_DAT_CMP_AL = 0;
        int iCOUNT_NB_DAT_PNZ_MIS_PET_DAL = 0;
        int iCOUNT_NB_DAT_PNZ_MIS_PET_AL = 0;
        String strSORT_NB_DAT_CMP = "";
        String strSORT_NB_DAT_PAR_ADT = "";
        String strSELECT = "", strFROM = "", strWHERE = "", strGROUP = "";
        if (strNB_DAT_PAR_ADT.equals("X")) {
            strSORT_NB_DAT_CMP = ", a.dat_cmp asc ";
            strSORT_NB_DAT_PAR_ADT = "X";
        } else {
            strSORT_NB_DAT_CMP = "X";
            strSORT_NB_DAT_PAR_ADT = strNB_DAT_PAR_ADT;
        }
        if (strNB_APL_A.equals("L")) {
            strSELECT = strSELECT + ", e.cod_mis_rso_luo,e.cod_rso_luo_fsc,e.cod_luo_fsc ";
            strFROM = strFROM + ", mis_pet_luo_fsc_tab e ";
            strWHERE = strWHERE + " AND a.cod_mis_pet = e.cod_mis_pet ";
            if (lNB_COD_MIS_PET_LUO_MAN != 0) {
                strWHERE = strWHERE + " AND e.cod_mis_rso_luo = ? ";
                iCOUNT_NB_APL_L = icounterWhere;
                icounterWhere++;
            }
        } else if (strNB_APL_A.equals("M")) {
            strSELECT = strSELECT + ", e.cod_mis_pet_man, e.cod_rso_man, e.cod_man ";
            strFROM = strFROM + ", mis_pet_man_tab e ";
            strWHERE = strWHERE + " AND a.cod_mis_pet = e.cod_mis_pet ";
            if (lNB_COD_MIS_PET_LUO_MAN != 0) {
                strWHERE = strWHERE + " AND e.cod_mis_pet_man = ? ";
                iCOUNT_NB_APL_M = icounterWhere;
                icounterWhere++;
            }
        }
        //--- NB_NOM_RSO
        if (!strNB_NOM_RSO.equals("")) {
            iCOUNT_NB_NOM_RSO = icounterWhere;
            icounterWhere++;
            strFROM = strFROM + ", ana_rso_tab f, rso_mis_pet_tab w ";
            strWHERE = strWHERE + " AND w.cod_mis_pet = a.cod_mis_pet AND w.cod_rso = f.cod_rso AND w.cod_azl = a.cod_azl AND f.cod_azl = a.cod_azl AND f.nom_rso  like ? ";//NB_NOM_RSO
        }
        //--- NB_NOM_MIS_PET
        if (!strNB_NOM_MIS_PET.equals("")) {
            iCOUNT_NB_NOM_MIS_PET = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.nom_mis_pet like ? "; //NB_NOM_MIS_PET
        }
        //--- NB_DES_TPL_MIS_PET
        if (!strNB_DES_TPL_MIS_PET.equals("")) {
            iCOUNT_NB_DES_TPL_MIS_PET = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND b.des_tpl_mis_pet  like ? ";
        }
        //--- DATA
        if ((dNB_DAT_CMP_DAL != null) && (dNB_DAT_CMP_AL != null)) {
            iCOUNT_NB_DAT_CMP_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_NB_DAT_CMP_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_cmp BETWEEN ? AND ? ";
        }
        if ((dNB_DAT_CMP_DAL != null) && (dNB_DAT_CMP_AL == null)) {
            iCOUNT_NB_DAT_CMP_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_cmp >= ? ";
        }
        if ((dNB_DAT_CMP_DAL == null) && (dNB_DAT_CMP_AL != null)) {
            iCOUNT_NB_DAT_CMP_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_cmp <= ? ";
        }
        if ((dNB_DAT_PNZ_MIS_PET_DAL != null) && (dNB_DAT_PNZ_MIS_PET_AL != null)) {
            iCOUNT_NB_DAT_PNZ_MIS_PET_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_NB_DAT_PNZ_MIS_PET_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pnz_mis_pet BETWEEN ? AND ? ";
        }
        if ((dNB_DAT_PNZ_MIS_PET_DAL != null) && (dNB_DAT_PNZ_MIS_PET_AL == null)) {
            iCOUNT_NB_DAT_PNZ_MIS_PET_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pnz_mis_pet >= ? ";
        }
        if ((dNB_DAT_PNZ_MIS_PET_DAL == null) && (dNB_DAT_PNZ_MIS_PET_AL != null)) {
            iCOUNT_NB_DAT_PNZ_MIS_PET_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pnz_mis_pet <= ? ";
        }

        //*** ORDER ***//
        //--- Raggruppati = N
        strSORT_NB_DAT_CMP = strSORT_NB_DAT_CMP.replaceAll("'", "");
        strSORT_NB_DAT_PAR_ADT = strSORT_NB_DAT_PAR_ADT.replaceAll("'", "");

        if (strRAGGRUPPATI.equals("N")) {
            String strVAL_SORT_NB_DAT_CMP = "";
            String strVAL_SORT_NB_DAT_PAR_ADT = "";
            strVAL_SORT_NB_DAT_CMP = strSORT_NB_DAT_CMP;
            strVAL_SORT_NB_DAT_PAR_ADT = strSORT_NB_DAT_PAR_ADT;
            if ((strVAL_SORT_NB_DAT_CMP.equals("X")) && (strVAL_SORT_NB_DAT_PAR_ADT.equals("X"))) {
                strSORT_NB_DAT_CMP = strSORT_NB_DAT_CMP.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_NB_DAT_CMP;
            } else if ((!strVAL_SORT_NB_DAT_CMP.equals("X")) && (strVAL_SORT_NB_DAT_PAR_ADT.equals("X"))) {
                strSORT_NB_DAT_CMP = strSORT_NB_DAT_CMP.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_NB_DAT_CMP;
            } else if ((strVAL_SORT_NB_DAT_CMP.equals("X")) && (!strVAL_SORT_NB_DAT_PAR_ADT.equals("X"))) {
                strSORT_NB_DAT_PAR_ADT = strSORT_NB_DAT_PAR_ADT.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_NB_DAT_PAR_ADT;
            }
        }
        //--- Raggruppati = T
        if (strRAGGRUPPATI.equals("T")) {
            strGROUP = " ORDER BY b.des_tpl_mis_pet ";
            if (strSORT_NB_DAT_CMP.equals("X")) {
                strSORT_NB_DAT_CMP = "";
            }
            if (strSORT_NB_DAT_PAR_ADT.equals("X")) {
                strSORT_NB_DAT_PAR_ADT = "";
            }
            strGROUP = strGROUP + strSORT_NB_DAT_CMP + strSORT_NB_DAT_PAR_ADT;
        }
        //--- Raggruppati = A
        if (strRAGGRUPPATI.equals("A")) {
            strGROUP = " ORDER BY c.rag_scl_azl ";
            if (strSORT_NB_DAT_CMP.equals("X")) {
                strSORT_NB_DAT_CMP = "";
            }
            if (strSORT_NB_DAT_PAR_ADT.equals("X")) {
                strSORT_NB_DAT_PAR_ADT = "";
            }
            strGROUP = strGROUP + strSORT_NB_DAT_CMP + strSORT_NB_DAT_PAR_ADT;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT a.cod_mis_pet,a.cod_azl,a.nom_mis_pet" + ",a.dat_cmp,a.dat_pnz_mis_pet,b.des_tpl_mis_pet," + "c.rag_scl_azl " + strSELECT + " " + " FROM ana_mis_pet_tab a,tpl_mis_pet_tab b" + ", ana_azl_tab c " + strFROM + " " + " WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet " + " AND a.cod_azl = c.cod_azl " + " AND c.cod_azl=? " + strWHERE + " " + strGROUP);
            ps.setLong(1, lCOD_AZL);
            if (iCOUNT_NB_APL_L != 0) {
                ps.setLong(iCOUNT_NB_APL_L, lNB_COD_MIS_PET_LUO_MAN);
            }
            if (iCOUNT_NB_APL_M != 0) {
                ps.setLong(iCOUNT_NB_APL_M, lNB_COD_MIS_PET_LUO_MAN);
            }
            if (iCOUNT_NB_NOM_RSO != 0) {
                ps.setString(iCOUNT_NB_NOM_RSO, strNB_NOM_RSO + '%');
            }
            if (iCOUNT_NB_NOM_MIS_PET != 0) {
                ps.setString(iCOUNT_NB_NOM_MIS_PET, strNB_NOM_MIS_PET + '%');
            }
            if (iCOUNT_NB_DES_TPL_MIS_PET != 0) {
                ps.setString(iCOUNT_NB_DES_TPL_MIS_PET, strNB_DES_TPL_MIS_PET + '%');
            }
            if (iCOUNT_NB_DAT_CMP_DAL != 0) {
                ps.setDate(iCOUNT_NB_DAT_CMP_DAL, dNB_DAT_CMP_DAL);
            }
            if (iCOUNT_NB_DAT_CMP_AL != 0) {
                ps.setDate(iCOUNT_NB_DAT_CMP_AL, dNB_DAT_CMP_AL);
            }
            if (iCOUNT_NB_DAT_PNZ_MIS_PET_DAL != 0) {
                ps.setDate(iCOUNT_NB_DAT_PNZ_MIS_PET_DAL, dNB_DAT_PNZ_MIS_PET_DAL);
            }
            if (iCOUNT_NB_DAT_PNZ_MIS_PET_AL != 0) {
                ps.setDate(iCOUNT_NB_DAT_PNZ_MIS_PET_AL, dNB_DAT_PNZ_MIS_PET_AL);
            }
            ResultSet rs = ps.executeQuery();
            //long i = 0;
            java.util.ArrayList al = new java.util.ArrayList();
            //while(rs.next() && i < 20){
            while (rs.next()) {
                //i++;
                MisuraPreventiva_to_SCH_MIS_PET_View obj = new MisuraPreventiva_to_SCH_MIS_PET_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.COD_AZL = rs.getLong(2);
                obj.NOM_MIS_PET = rs.getString(3);
                obj.DAT_CMP = rs.getDate(4);
                obj.DAT_PNZ_MIS_PET = rs.getDate(5);
                obj.DES_TPL_MIS_PET = rs.getString(6);
                obj.RAG_SCL_AZL = rs.getString(7);
                if (strNB_APL_A.equals("L")) {
                    obj.COD_MIS_RSO_LUO = rs.getLong(8);
                    obj.COD_RSO_LUO_FSC = rs.getLong(9);
                    obj.COD_LUO_FSC = rs.getLong(10);
                }
                if (strNB_APL_A.equals("M")) {
                    obj.COD_MIS_PET_MAN = rs.getLong(8);
                    obj.COD_RSO_MAN = rs.getLong(9);
                    obj.COD_MAN = rs.getLong(10);
                }
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        //throw new EJBException("|"+iCOUNT_NB_APL_L+"| -- SELECT DISTINCT a.cod_mis_pet,a.cod_azl,a.nom_mis_pet,a.dat_cmp,a.dat_pnz_mis_pet,b.des_tpl_mis_pet,c.rag_scl_azl "+strSELECT+" FROM ana_mis_pet_tab a,tpl_mis_pet_tab b, ana_azl_tab c " + strFROM + " WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet AND a.cod_azl = c.cod_azl AND c.cod_azl=? " + strWHERE + " " + strGROUP);
        } finally {
            bmp.close();
        }
    }
///////////////////////////////////////////////////////////////////
}
