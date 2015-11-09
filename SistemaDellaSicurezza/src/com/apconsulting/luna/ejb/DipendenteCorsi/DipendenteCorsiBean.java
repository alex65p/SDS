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
package com.apconsulting.luna.ejb.DipendenteCorsi;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class DipendenteCorsiBean extends BMPEntityBean implements IDipendenteCorsi, IDipendenteCorsiHome {

    long COD_COR;			  //1
    String NOM_COR;			//2
    //------ not require
    String DES_COR;			//3
    java.sql.Date DAT_EFT_COR; //4
    String MAT_CSG;            //5
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static DipendenteCorsiBean ys = null;

    private DipendenteCorsiBean() {
    }

    public static DipendenteCorsiBean getInstance() {
        if (ys == null) {
            ys = new DipendenteCorsiBean();
        }
        return ys;
    }

    // (Home Intrface) create()
    public IDipendenteCorsi create(String strNOM_COR) throws CreateException {
        DipendenteCorsiBean bean = new DipendenteCorsiBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_COR);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_COR);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        DipendenteCorsiBean iDipendenteCorsiBean = new DipendenteCorsiBean();
        try {
            Object obj = iDipendenteCorsiBean.ejbFindByPrimaryKey((Long) primaryKey);
            iDipendenteCorsiBean.setEntityContext(new EntityContextWrapper(obj));
            iDipendenteCorsiBean.ejbActivate();
            iDipendenteCorsiBean.ejbLoad();
            iDipendenteCorsiBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IDipendenteCorsi findByPrimaryKey(Long primaryKey) throws FinderException {
        DipendenteCorsiBean bean = new DipendenteCorsiBean();
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

    public Collection getDipendenteCorsi_View(long lCOD_DPD) {
        return (new DipendenteCorsiBean()).ejbGetDipendenteCorsi_View(lCOD_DPD, null, null);
    }

    public Collection getDipendenteCorsi_View(long lCOD_DPD, String columnOrdered, String orderType) {
        return (new DipendenteCorsiBean()).ejbGetDipendenteCorsi_View(lCOD_DPD, columnOrdered, orderType);
    }

    public Collection getDipendentiCorsi(long COR_ID, long COD_AZL, long COD_DPD, java.sql.Date DAT_EFT_COR) {
        DipendenteCorsiBean bean = new DipendenteCorsiBean();
        return (bean.ejbDipendentiCorsi(COR_ID, COD_AZL, COD_DPD, DAT_EFT_COR));
    }

//</Views>
    public Collection getDipendente_View(long lCOD_AZL, long lCOD_COR, java.sql.Date dDATE, long lCOD_SCH_EGZ_COR) {
        return (new DipendenteCorsiBean()).ejbGetDipendente_View(lCOD_AZL, lCOD_COR, dDATE, lCOD_SCH_EGZ_COR);
    }
    //</IDipendenteCorsiHome-implementation>

    public Long ejbCreate(String strNOM_COR) {
        this.NOM_COR = strNOM_COR;
        this.COD_COR = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        BMPConnection bmp1 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_cor_tab (cod_cor,nom_cor,dur_cor_gor,cod_tpl_cor) VALUES(?,?,1,1)");
            ps.setLong(1, COD_COR);
            ps.setString(2, NOM_COR);
            PreparedStatement ps1 = bmp1.prepareStatement("INSERT INTO cor_dpd_tab (cod_cor,mat_csg,esi_tes_vrf,ate_fre_dpd,cod_dpd,cod_azl) VALUES(?,'a','a','a',1,1073907267812)");
            ps1.setLong(1, COD_COR);
            ps.executeUpdate();
            ps1.executeUpdate();
            return new Long(COD_COR);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp1.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_COR) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cor FROM cor_dpd_tab ");
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
        this.COD_COR = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_COR = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        BMPConnection bmp1 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_cor_tab  WHERE cod_cor=?");
            ps.setLong(1, COD_COR);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_COR = rs.getString("NOM_COR");
                this.DES_COR = rs.getString("DES_COR");
            } else {
                throw new NoSuchEntityException("DipendenteCorsi con ID= non è trovata");
            }
            ps = bmp1.prepareStatement("SELECT * FROM cor_dpd_tab  WHERE cod_cor=?");
            ps.setLong(1, COD_COR);
            ResultSet rs1 = ps.executeQuery();
            if (rs1.next()) {
                this.DAT_EFT_COR = rs1.getDate("DAT_EFT_COR");
            } else {
                throw new NoSuchEntityException("DipendenteCorsi con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp1.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        BMPConnection bmp1 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_cor_tab  WHERE cod_cor=?");
            ps.setLong(1, COD_COR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DipendenteCorsi con ID= non è trovata");
            }
            ps = bmp1.prepareStatement("DELETE FROM cor_dpd_tab  WHERE cod_cor=?");
            ps.setLong(1, COD_COR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DipendenteCorsi con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp1.close();
        }
    }
//----------------------------------------------------------

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        BMPConnection bmp1 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_cor_tab  SET nom_cor=?, des_cor=? WHERE cod_cor=?");
            ps.setString(1, NOM_COR);
            ps.setString(2, DES_COR);
            ps.setLong(3, COD_COR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DipendenteCorsi con ID= non è trovata");
            }
            ps = bmp1.prepareStatement("UPDATE cor_dpd_tab  SET dat_eft_cor=? WHERE cod_cor=?");
            ps.setDate(1, DAT_EFT_COR);
            ps.setLong(2, COD_COR);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp1.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="Update Method">
    public void Update() {
        setModified();
    }
//<comment

//<comment description="setter/getters">
    //1
    public long getCOD_COR() {
        return COD_COR;
    }
    //2

    public void setNOM_COR(String newNOM_COR) {
        if (NOM_COR.equals(newNOM_COR)) {
            return;
        }
        NOM_COR = newNOM_COR;
        setModified();
    }

    public String getNOM_COR() {
        return NOM_COR;
    }
    //============================================
    // not required field
    //3

    public void setDES_COR(String newDES_COR) {
        if (DES_COR.equals(newDES_COR)) {
            return;
        }
        DES_COR = newDES_COR;
        setModified();
    }

    public String getDES_COR() {
        return DES_COR;
    }
    //4

    public void setDAT_EFT_COR(java.sql.Date newDAT_EFT_COR) {
        if (DAT_EFT_COR != null) {
            if (DAT_EFT_COR.equals(newDAT_EFT_COR)) {
                return;
            }
        }
        DAT_EFT_COR = newDAT_EFT_COR;
        setModified();
    }

    public java.sql.Date getDAT_EFT_COR() {
        return DAT_EFT_COR;
    }

    public Collection ejbGetDipendenteCorsi_View(long lCOD_DPD, String columnOrdered, String orderType) {

        BMPConnection bmp = getConnection();
        try {

            String sql = 
                    "SELECT "
                        + "a.cod_cor, "
                        + "a.nom_cor, "
                        + "a.des_cor, "
                        + "b.dat_eft_cor "
                    + "FROM "
                        + "ana_cor_tab a, "
                        + "cor_dpd_tab b "
                    + "WHERE "
                        + "a.cod_cor = b.cod_cor "
                        + "AND b.cod_dpd=? "
                    + "ORDER BY "
                    + (StringManager.isNotEmpty(columnOrdered) && StringManager.isNotEmpty(orderType)
                            ?Integer.parseInt(columnOrdered)+1+" " + orderType + ", b.dat_eft_cor desc"
                            :"b.dat_eft_cor desc");

            PreparedStatement ps = bmp.prepareStatement(sql);
            ps.setLong(1, lCOD_DPD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();

            while (rs.next()) {

                DipendenteCorsi_View obj = new DipendenteCorsi_View();

                obj.lCOD_COR = rs.getLong(1);
                obj.strNOM_COR = rs.getString(2);
                obj.strDES_COR = rs.getString(3);
                obj.dtDAT_EFT_COR = rs.getDate(4);
                obj.dtDAT_EFT_COR = rs.getDate(4);
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

    public Collection ejbDipendentiCorsi(long COR_ID, long COD_AZL, long COD_DPD, java.sql.Date DAT_EFT_COR) {


        BMPConnection bmp = getConnection();
        try {

            String sql = "SELECT mat_csg,dat_csg_mat,esi_tes_vrf,dat_eft_tes_vrf,ptg_ott_dpd,ate_fre_dpd " +
                    "FROM cor_dpd_tab " +
                    "WHERE cod_azl=? AND cod_dpd=? " +
                    "AND cod_cor=? AND dat_eft_cor=?";

            PreparedStatement ps = bmp.prepareStatement(sql);
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_DPD);
            ps.setLong(3, COR_ID);
            ps.setDate(4, DAT_EFT_COR);

            ResultSet rs = ps.executeQuery();
            ArrayList al = new ArrayList();
            if (rs.next()) {
                DipendentiCorsi sel = new DipendentiCorsi();

                sel.MAT_CSG = rs.getString(1);
                sel.DAT_CSG_MAT = rs.getDate(2);
                sel.ESI_TES_VRF = rs.getString(3);
                sel.DAT_EFT_TES_VRF = rs.getDate(4);
                sel.PTG_OTT_DPD = rs.getLong(5);
                sel.ATE_FRE_DPD = rs.getString(6);
                al.add(sel);
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

    public Collection ejbGetDipendente_View(long lCOD_AZL, long lCOD_COR, java.sql.Date dDATE, long lCOD_SCH_EGZ_COR) {
        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement(" SELECT DISTINCT  a.nom_dpd,a.cog_dpd,a.cod_dpd,b.nom_cor, b.cod_cor,f.cod_sch_egz_cor,f.dat_pif_egz_cor,e.dat_eft_cor" +
                    " FROM view_ana_dpd_tab a, ana_cor_tab b, cor_dpd_tab c, sch_egz_cor_tab f,cor_dpd_tab e " +
                    " WHERE b.cod_cor =? " +
                    " AND b.cod_cor = c.cod_cor " +
                    " AND e.cod_cor = c.cod_cor " +
                    " AND e.cod_cor = b.cod_cor " +
                    " AND a.cod_dpd = c.cod_dpd " +
                    " AND e.cod_dpd = a.cod_dpd " +
                    " AND e.cod_dpd = c.cod_dpd " +
                    " AND a.cod_azl = ? " +
                    " AND c.cod_azl = ? " +
                    " AND e.cod_azl = ? " +
                    " AND (f.dat_pif_egz_cor= e.dat_eft_cor) " +
                    " AND f.cod_sch_egz_cor=? " +
                    " AND (c.cod_cor, f.cod_sch_egz_cor) " +
                    " IN (SELECT h.cod_cor, h.cod_sch_egz_cor FROM sch_egz_cor_tab h  WHERE h.cod_azl = ? AND h.cod_sch_egz_cor " +
                    " NOT IN (SELECT n.cod_sch_egz_cor FROM isc_cor_tab n  WHERE n.cod_dpd = a.cod_dpd AND n.cod_azl =? ))");

            ps.setLong(1, lCOD_COR);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_AZL);
            ps.setLong(4, lCOD_AZL);
            ps.setLong(5, lCOD_SCH_EGZ_COR);
            ps.setLong(6, lCOD_AZL);
            ps.setLong(7, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendente_View obj = new Dipendente_View();
                obj.NOM_DPD = rs.getString("NOM_DPD");
                obj.COG_DPD = rs.getString("COG_DPD");
                obj.COD_DPD = rs.getLong("COD_DPD");
                obj.NOM_COR = rs.getString("NOM_COR");
                obj.COD_COR = rs.getLong("COD_COR");
                obj.COD_SCH_EGZ_COR = rs.getLong("COD_SCH_EGZ_COR");
                obj.DAT_PIF_EGZ_COR = rs.getDate("DAT_PIF_EGZ_COR");
                obj.DAT_EFT_COR = rs.getDate("DAT_EFT_COR");
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

    public void addCOR_DPD_ISC(long lCOD_DPD, long lCOD_SCH_EGZ_COR, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO isc_cor_tab (cod_sch_egz_cor,cod_dpd,cod_azl) VALUES(?,?,?) ");
            ps.setLong(1, lCOD_SCH_EGZ_COR);
            ps.setLong(2, lCOD_DPD);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
    }//<comment description="end of implementation  DipendenteCorsiBean"/>

