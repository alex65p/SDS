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
package com.apconsulting.luna.ejb.SchedeInterventoPSD;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class SchedeInterventoPSDBean extends BMPEntityBean implements ISchedeInterventoPSD, ISchedeInterventoPSDHome {
    //----------------------------------------

    long COD_SCH_INR_PSD;        //1
    long COD_PSD_ACD;            //2
    String TPL_INR_PSD;            //3
    String ATI_SVO;                //4
    java.sql.Date DAT_PIF_INR;            //5
    //----------------------------------------
    java.sql.Date DAT_INR;                //6
    String ESI_INR;                //7
    String PBM_RSC;                //8
    String NOM_RSP_INR;            //9
    //
    private static SchedeInterventoPSDBean ys = null;

    private SchedeInterventoPSDBean() {
    }

    public static SchedeInterventoPSDBean getInstance() {
        if (ys == null) {
            ys = new SchedeInterventoPSDBean();
        }
        return ys;
    }

    // (Home Interface) create()
    public ISchedeInterventoPSD create(long lCOD_PSD_ACD, String strTPL_INR_PSD, java.sql.Date dtDAT_PIF_INR) throws CreateException {
        SchedeInterventoPSDBean bean = new SchedeInterventoPSDBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_PSD_ACD, strTPL_INR_PSD, dtDAT_PIF_INR);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_PSD_ACD, strTPL_INR_PSD, dtDAT_PIF_INR);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        SchedeInterventoPSDBean iSchedeInterventoPSDBean = new SchedeInterventoPSDBean();
        try {
            Object obj = iSchedeInterventoPSDBean.ejbFindByPrimaryKey((Long) primaryKey);
            iSchedeInterventoPSDBean.setEntityContext(new EntityContextWrapper(obj));
            iSchedeInterventoPSDBean.ejbActivate();
            iSchedeInterventoPSDBean.ejbLoad();
            iSchedeInterventoPSDBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()

    public ISchedeInterventoPSD findByPrimaryKey(Long primaryKey) throws FinderException {
        SchedeInterventoPSDBean bean = new SchedeInterventoPSDBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) findAll()

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    //---------- view ---------
    public Collection getSchedeInterventoPSD_SelectData_View() {
        return (new SchedeInterventoPSDBean()).ejbGetSchedeInterventoPSD_SelectData_View();
    }

    public Collection getSchedeInterventoPSD_ForTab_View(long SCH_PSD_ID) {
        return (new SchedeInterventoPSDBean()).ejbGetSchedeInterventoPSD_ForTab_View(SCH_PSD_ID);
    }

    public Collection getSchedeInterventoPSD_ForPresidi_View(long SCH_PSD_ID) {
        return (new SchedeInterventoPSDBean()).ejbGetSchedeInterventoPSD_ForPresidi_View(SCH_PSD_ID);
    }

    public Collection getSchedeInterventoPSD_ForView_View() {
        return (new SchedeInterventoPSDBean()).ejbGetSchedeInterventoPSD_ForView_View();
    }

    public Collection getSchedeInterventoPSD_Responsabile_View(long COD_PSD_ACD, String WHE_IN_AZL) {
        return (new SchedeInterventoPSDBean()).ejbGetSchedeInterventoPSD_Responsabile_View(COD_PSD_ACD, WHE_IN_AZL);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</ISchedeInterventoPSDHome-implementation>
    public Long ejbCreate(long lCOD_PSD_ACD, String strTPL_INR_PSD, java.sql.Date dtDAT_PIF_INR) {
        this.COD_PSD_ACD = lCOD_PSD_ACD;
        this.TPL_INR_PSD = strTPL_INR_PSD;
        this.DAT_PIF_INR = dtDAT_PIF_INR;
        this.COD_SCH_INR_PSD = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO sch_inr_psd_tab (cod_sch_inr_psd,cod_psd_acd,tpl_inr_psd,dat_pif_inr) VALUES(?,?,?,?)");
            ps.setLong(1, COD_SCH_INR_PSD);
            ps.setLong(2, COD_PSD_ACD);
            ps.setString(3, TPL_INR_PSD);
            ps.setDate(4, DAT_PIF_INR);
            ps.executeUpdate();
            return new Long(COD_SCH_INR_PSD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------   
    public void ejbPostCreate(long lCOD_PSD_ACD, String strTPL_INR_PSD, java.sql.Date dtDAT_PIF_INR) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_inr_psd FROM sch_inr_psd_tab ");
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

//-----------------------------------------------------------
    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.COD_SCH_INR_PSD = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_SCH_INR_PSD = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM sch_inr_psd_tab  WHERE cod_sch_inr_psd=?");
            ps.setLong(1, COD_SCH_INR_PSD);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_SCH_INR_PSD = rs.getLong("COD_SCH_INR_PSD");
                this.DAT_PIF_INR = rs.getDate("DAT_PIF_INR");
                this.DAT_INR = rs.getDate("DAT_INR");
                this.COD_PSD_ACD = rs.getLong("COD_PSD_ACD");
                this.ESI_INR = rs.getString("ESI_INR");
                this.ATI_SVO = rs.getString("ATI_SVO");
                this.NOM_RSP_INR = rs.getString("NOM_RSP_INR");
                this.PBM_RSC = rs.getString("PBM_RSC");
                this.TPL_INR_PSD = rs.getString("TPL_INR_PSD");
            } else {
                throw new NoSuchEntityException("COD_SCH_INR_PSD con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM sch_inr_psd_tab  WHERE cod_sch_inr_psd=?");
            ps.setLong(1, COD_SCH_INR_PSD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE sch_inr_psd_tab  SET cod_sch_inr_psd=?, dat_pif_inr=?, dat_inr=?, esi_inr=?, ati_svo=?, nom_rsp_inr=?, pbm_rsc=?, tpl_inr_psd=?, cod_psd_acd=? WHERE cod_sch_inr_psd=?");
            ps.setLong(1, COD_SCH_INR_PSD);
            ps.setDate(2, DAT_PIF_INR);
            ps.setDate(3, DAT_INR);
            ps.setString(4, ESI_INR);
            ps.setString(5, ATI_SVO);
            ps.setString(6, NOM_RSP_INR);
            ps.setString(7, PBM_RSC);
            ps.setString(8, TPL_INR_PSD);
            ps.setLong(9, COD_PSD_ACD);
            ps.setLong(10, COD_SCH_INR_PSD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
    //1
    public long getCOD_SCH_INR_PSD() {
        return COD_SCH_INR_PSD;
    }
    //2
    //3

    public void setCOD_PSD_ACD(long newCOD_PSD_ACD) {
        if (COD_PSD_ACD == newCOD_PSD_ACD) {
            return;
        }
        COD_PSD_ACD = newCOD_PSD_ACD;
        setModified();
    }

    public long getCOD_PSD_ACD() {
        return COD_PSD_ACD;
    }
    //4

    public void setTPL_INR_PSD(String newTPL_INR_PSD) {
        if (TPL_INR_PSD.equals(newTPL_INR_PSD)) {
            return;
        }
        TPL_INR_PSD = newTPL_INR_PSD;
        setModified();
    }

    public String getTPL_INR_PSD() {
        return TPL_INR_PSD;
    }
    //6

    public void setDAT_PIF_INR(java.sql.Date newDAT_PIF_INR) {
        if (DAT_PIF_INR.equals(newDAT_PIF_INR)) {
            return;
        }
        DAT_PIF_INR = newDAT_PIF_INR;
        setModified();
    }

    public java.sql.Date getDAT_PIF_INR() {
        return DAT_PIF_INR;
    }
    //============================================
    // not required field
    //5

    public void setATI_SVO(String newATI_SVO) {
        if ((ATI_SVO != null) && (ATI_SVO.equals(newATI_SVO))) {
            return;
        }
        ATI_SVO = newATI_SVO;
        setModified();
    }

    public String getATI_SVO() {
        return ATI_SVO;
    }
    //7

    public void setDAT_INR(java.sql.Date newDAT_INR) {
        if ((DAT_INR != null) && (DAT_INR.equals(newDAT_INR))) {
            return;
        }
        DAT_INR = newDAT_INR;
        setModified();
    }

    public java.sql.Date getDAT_INR() {
        return DAT_INR;
    }
    //8

    public void setESI_INR(String newESI_INR) {
        if ((ESI_INR != null) && (ESI_INR.equals(newESI_INR))) {
            return;
        }
        ESI_INR = newESI_INR;
        setModified();
    }

    public String getESI_INR() {
        if (ESI_INR == null) {
            ESI_INR = "";
        }
        return ESI_INR;
    }//9

    public void setPBM_RSC(String newPBM_RSC) {
        if ((PBM_RSC != null) && (PBM_RSC.equals(newPBM_RSC))) {
            return;
        }
        PBM_RSC = newPBM_RSC;
        setModified();
    }

    public String getPBM_RSC() {
        if (PBM_RSC == null) {
            PBM_RSC = "";
        }
        return PBM_RSC;
    }//10

    public void setNOM_RSP_INR(String newNOM_RSP_INR) {
        if ((NOM_RSP_INR != null) && (NOM_RSP_INR.equals(newNOM_RSP_INR))) {
            return;
        }
        NOM_RSP_INR = newNOM_RSP_INR;
        setModified();
    }

    public String getNOM_RSP_INR() {
        if (NOM_RSP_INR == null) {
            NOM_RSP_INR = "";
        }
        return NOM_RSP_INR;
    }
    //</comment>

//----------------------------------------------------------------
    public Collection ejbGetSchedeInterventoPSD_SelectData_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_psd_acd, "
                        + "a.ide_psd_acd, "
                        + "b.nom_cag_psd_acd, "
                        + "c.nom_luo_fsc "
                    + "FROM "
                        + "ana_psd_acd_tab a, "
                        + "cag_psd_acd_tab b, "
                        + "ana_luo_fsc_tab c "
                    + "WHERE "
                        + "a.cod_cag_psd_acd = b.cod_cag_psd_acd "
                        + "AND a.cod_luo_fsc = c.cod_luo_fsc ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_SelectData_View obj = new SchedeInterventoPSD_SelectData_View();
                obj.COD_PSD_ACD = rs.getLong(1);
                obj.IDE_PSD_ACD = rs.getString(2);
                obj.NOM_CAG_PSD_ACD = rs.getString(3);
                obj.NOM_LUO_FSC = rs.getString(4);
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

    public Collection ejbGetSchedeInterventoPSD_ForTab_View(long SCH_PSD_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.rsp_doc, a.tit_doc, a.dat_rev_doc, b.cod_doc FROM ana_doc_tab a, doc_sch_psd_tab b WHERE  a.cod_doc=b.cod_doc AND b.cod_sch_inr_psd=? ORDER BY a.rsp_doc ");
            ps.setLong(1, SCH_PSD_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_ForTab_View obj = new SchedeInterventoPSD_ForTab_View();
                obj.RSP_DOC = rs.getString(1);
                obj.TIT_DOC = rs.getString(2);
                obj.DAT_REV_DOC = rs.getDate(3);
                obj.COD_DOC = rs.getLong(4);
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

    public Collection ejbGetSchedeInterventoPSD_Responsabile_View(long COD_PSD_ACD, String WHE_IN_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query = 
                    "SELECT "
                        + "a.cod_sch_inr_psd, "
                        + "a.nom_rsp_inr "
                    + "FROM "
                        + "sch_inr_psd_tab a, "
                        + "ana_psd_acd_tab b, "
                        + "ana_luo_fsc_tab c "
                    + "WHERE "
                        + "a.cod_psd_acd = b.cod_psd_acd "
                        + (COD_PSD_ACD != 0?"AND b.cod_psd_acd = ? ":"")
                        + "AND b.cod_luo_fsc = c.cod_luo_fsc "
                        + "AND a.nom_rsp_inr is not null "
                        + "AND c.cod_azl IN (" + WHE_IN_AZL + ")";
            
            PreparedStatement ps = bmp.prepareStatement(query);
            if (COD_PSD_ACD != 0) {
                ps.setLong(1, COD_PSD_ACD);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_Responsabile_View obj = new SchedeInterventoPSD_Responsabile_View();
                obj.lCOD_PSD_ACD = rs.getLong(1);
                obj.strNOM_RSP_INR = rs.getString(2);
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

//   Create View dlya Presidi
    public Collection ejbGetSchedeInterventoPSD_ForPresidi_View(long SCH_PSD_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_inr_psd, a.nom_rsp_inr, a.dat_pif_inr, a.dat_inr, a.esi_inr FROM sch_inr_psd_tab a WHERE  a.cod_psd_acd=? ORDER BY a.nom_rsp_inr ");
            ps.setLong(1, SCH_PSD_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_ForPresidi_View obj = new SchedeInterventoPSD_ForPresidi_View();
                obj.COD_SCH_INR_PSD = rs.getLong(1);
                obj.NOM_RSP_INR = rs.getString(2);
                obj.DAT_PIF_INR = rs.getDate(3);
                obj.DAT_INR = rs.getDate(4);
                obj.ESI_INR = rs.getString(5);
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

    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_sch_psd_tab (cod_doc,cod_sch_inr_psd) VALUES(?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, COD_SCH_INR_PSD);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%UNLink%%% Table DOC_PSD_ACD_TAB
    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_sch_psd_tab  WHERE cod_doc=? AND cod_sch_inr_psd=?");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, COD_SCH_INR_PSD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetSchedeInterventoPSD_ForView_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_psd_acd, "
                        + "a.ide_psd_acd, "
                        + "d.nom_cag_psd_acd, "
                        + "e.nom_luo_fsc, "
                        + "b.cod_sch_inr_psd, "
                        + "b.ati_svo, "
                        + "b.dat_inr, "
                        + "b.pbm_rsc, "
                        + "b.dat_pif_inr, "
                        + "b.nom_rsp_inr, "
                        + "b.tpl_inr_psd, "
                        + "b.esi_inr "
                    + "FROM "
                        + "ana_psd_acd_tab a, "
                        + "sch_inr_psd_tab b, "
                        + "cag_psd_acd_tab d, "
                        + "ana_luo_fsc_tab e "
                    + "WHERE "
                        + "a.cod_psd_acd = b.cod_psd_acd "
                        + "AND a.cod_cag_psd_acd = d.cod_cag_psd_acd "
                        + "AND a.cod_luo_fsc = e.cod_luo_fsc "
                        + "AND a.sta_psd_acd='A' "
                    + "ORDER BY "
                        + "a.ide_psd_acd ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_ForView_View obj = new SchedeInterventoPSD_ForView_View();
                obj.COD_PSD_ACD = rs.getLong(1);
                obj.IDE_PSD_ACD = rs.getString(2);
                obj.NOM_CAG_PSD_ACD = rs.getString(3);
                obj.NOM_LUO_FSC = rs.getString(4);
                obj.COD_SCH_INR_PSD = rs.getLong(5);
                obj.ATI_SVO = rs.getString(6);
                obj.DAT_INR = rs.getDate(7);
                obj.PBM_RSC = rs.getString(8);
                obj.DAT_PIF_INR = rs.getDate(9);
                obj.NOM_RSP_INR = rs.getString(10);
                obj.TPL_INR_PSD = rs.getString(11);
                obj.ESI_INR = rs.getString(12);
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

    //--- mary for search
    public Collection findEx(
            String strTPL_INR_PSD,
            Long lCOD_PSD_ACD,
            String strATI_SVO,
            java.sql.Date dtDAT_INR,
            java.sql.Date dtDAT_PIF_INR,
            String strNOM_RSP_INR,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(strTPL_INR_PSD, lCOD_PSD_ACD, strATI_SVO, dtDAT_INR, dtDAT_PIF_INR, strNOM_RSP_INR, iOrderParameter);
    }
    //

    public Collection ejbFindEx(
            String strTPL_INR_PSD,
            Long lCOD_PSD_ACD,
            String strATI_SVO,
            java.sql.Date dtDAT_INR,
            java.sql.Date dtDAT_PIF_INR,
            String strNOM_RSP_INR,
            int iOrderParameter //not used for now
            ) {
        String strSql = 
                "SELECT "
                    + "a.cod_psd_acd, "
                    + "a.ide_psd_acd, "
                    + "d.nom_cag_psd_acd, "
                    + "e.nom_luo_fsc, "
                    + "b.cod_sch_inr_psd, "
                    + "b.ati_svo, "
                    + "b.dat_inr, "
                    + "b.pbm_rsc, "
                    + "b.dat_pif_inr, "
                    + "b.nom_rsp_inr, "
                    + "b.tpl_inr_psd, "
                    + "b.esi_inr "
                + "FROM "
                    + "ana_psd_acd_tab a, "
                    + "sch_inr_psd_tab b, "
                    + "cag_psd_acd_tab d, "
                    + "ana_luo_fsc_tab e "
                + "WHERE "
                    + "a.cod_psd_acd = b.cod_psd_acd "
                    + "AND a.cod_cag_psd_acd = d.cod_cag_psd_acd "
                    + "AND a.cod_luo_fsc = e.cod_luo_fsc "
                    + "AND a.sta_psd_acd='A' ";

        if (strTPL_INR_PSD != null) {
            strSql += " AND UPPER(b.tpl_inr_psd) LIKE ? ";
        }
        if (lCOD_PSD_ACD != null) {
            strSql += " AND a.cod_psd_acd=? ";
        }
        if (strATI_SVO != null) {
            strSql += " AND UPPER(b.ati_svo) LIKE ? ";
        }
        if (dtDAT_INR != null) {
            strSql += " AND b.dat_inr=? ";
        }
        if (dtDAT_PIF_INR != null) {
            strSql += " AND b.dat_pif_inr=? ";
        }
        if (strNOM_RSP_INR != null) {
            strSql += " AND UPPER(b.nom_rsp_inr) LIKE ? ";
        }
        strSql += " ORDER BY UPPER(a.ide_psd_acd) ";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strTPL_INR_PSD != null) {
                ps.setString(i++, strTPL_INR_PSD.toUpperCase());
            }
            if (lCOD_PSD_ACD != null) {
                ps.setLong(i++, lCOD_PSD_ACD.longValue());
            }
            if (strATI_SVO != null) {
                ps.setString(i++, strATI_SVO.toUpperCase());
            }
            if (dtDAT_INR != null) {
                ps.setDate(i++, dtDAT_INR);
            }
            if (dtDAT_PIF_INR != null) {
                ps.setDate(i++, dtDAT_PIF_INR);
            }
            if (strNOM_RSP_INR != null) {
                ps.setString(i++, strNOM_RSP_INR.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                SchedeInterventoPSD_ForView_View obj = new SchedeInterventoPSD_ForView_View();
                obj.COD_PSD_ACD = rs.getLong(1);
                obj.IDE_PSD_ACD = rs.getString(2);
                obj.NOM_CAG_PSD_ACD = rs.getString(3);
                obj.NOM_LUO_FSC = rs.getString(4);
                obj.COD_SCH_INR_PSD = rs.getLong(5);
                obj.ATI_SVO = rs.getString(6);
                obj.DAT_INR = rs.getDate(7);
                obj.PBM_RSC = rs.getString(8);
                obj.DAT_PIF_INR = rs.getDate(9);
                obj.NOM_RSP_INR = rs.getString(10);
                obj.TPL_INR_PSD = rs.getString(11);
                obj.ESI_INR = rs.getString(12);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////////////////
}//<comment description="end of implementation  SchedeInterventoPSDBean"/>
