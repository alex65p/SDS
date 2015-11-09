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
package com.apconsulting.luna.ejb.CategoriePreside;

import java.rmi.RemoteException;
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
//public class CategoriePresideBean extends BMPEntityBean implements ICategoriePresideRemote
public class CategoriePresideBean extends BMPEntityBean implements ICategoriePreside, ICategoriePresideHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">
    // "cod_cag_psd_acd" int8 NOT NULL, 
    // "nom_cag_psd_acd" varchar(30) NOT NULL, 
    // "des_cag_psd_acd" text, 
    // "per_mes_sst" int8, 
    // "per_mes_mnt" int8, 

    //   *require Fields*
    String NOM_CAG_PSD_ACD; //nom_cag_psd_acd
    long COD_CAG_PSD_ACD;   //cod_cag_psd_acd
    //   *Not require Fields*
    String DES_CAG_PSD_ACD;   //des_cag_psd_acd
    long PER_MES_SST;       //per_mes_sst
    long PER_MES_MNT;       //per_mes_mnt
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static CategoriePresideBean ys = null;

    private CategoriePresideBean() {
        //
    }

    public static CategoriePresideBean getInstance() {
        if (ys == null) {
            ys = new CategoriePresideBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ICategoriePreside create(String strNOM_CAG_PSD_ACD) throws RemoteException, CreateException {
        CategoriePresideBean bean = new CategoriePresideBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_CAG_PSD_ACD);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_CAG_PSD_ACD);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CategoriePresideBean iCategoriePresideBean = new CategoriePresideBean();
        try {
            Object obj = iCategoriePresideBean.ejbFindByPrimaryKey((Long) primaryKey);
            iCategoriePresideBean.setEntityContext(new EntityContextWrapper(obj));
            iCategoriePresideBean.ejbActivate();
            iCategoriePresideBean.ejbLoad();
            iCategoriePresideBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ICategoriePreside findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        CategoriePresideBean bean = new CategoriePresideBean();
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

    public Collection findAll() throws RemoteException, FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    // (Home Intrface) VIEWS  getCategoriePreside_Categoria_RagSoc_View()
    public Collection getCategoriePreside_Categoria_RagSoc_View() {
        return (new CategoriePresideBean()).ejbGetCategoriePreside_Categoria_RagSoc_View();
    }
    //<report>

    public Collection getCategoriePresidiView(long lCOD_CAG_PSD_ACD) {
        return (new CategoriePresideBean()).ejbGetCategoriePresidiView(lCOD_CAG_PSD_ACD);
    }

    public Collection getPresidiByCategoriaView(long lCOD_CAG_PSD_ACD, long lCOD_PSD_ACD) {
        return (new CategoriePresideBean()).ejbGetPresidiByCategoriaView(lCOD_CAG_PSD_ACD, lCOD_PSD_ACD);
    }

    public Collection getInterventoByPresidiView(long lCOD_PSD_ACD) {
        return (new CategoriePresideBean()).ejbGetInterventoByPresidiView(lCOD_PSD_ACD);
    }
    //</report>
//--- view Chimical Agento
//	public Collection getChimicalAgentoByFORAZLID_View(long FOR_AZL_ID)
//  {
//  	return (new  CategoriePresideBean()).ejbGetChimicalAgentoByFORAZLID_View(FOR_AZL_ID);
//  }

//--- view Resronsabiliti
    public Collection getResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD) {
        return (new CategoriePresideBean()).ejbGetResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(FOR_AZL_ID, FOR_COD_CAG_PSD_ACD);
    }

    public Collection getResronsabiliti__View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD, long FOR_COD_DPD) {
        return (new CategoriePresideBean()).ejbGetResronsabiliti__View(FOR_AZL_ID, FOR_COD_CAG_PSD_ACD, FOR_COD_DPD);
    }
    //

    public Collection getCAG_Lov(long lCOD_AZL, String strNOM_CAG_PSD_ACD) {
        return (new CategoriePresideBean()).ejbGetCAG_Lov(lCOD_AZL, strNOM_CAG_PSD_ACD);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</ICategoriePresideHome-implementation>
    public Long ejbCreate(String strNOM_CAG_PSD_ACD) {
        this.NOM_CAG_PSD_ACD = strNOM_CAG_PSD_ACD;
        this.COD_CAG_PSD_ACD = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cag_psd_acd_tab  (cod_cag_psd_acd,nom_cag_psd_acd) VALUES(?,?)");
            ps.setLong(1, COD_CAG_PSD_ACD);
            ps.setString(2, NOM_CAG_PSD_ACD);
            ps.executeUpdate();
            return new Long(COD_CAG_PSD_ACD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------   
    public void ejbPostCreate(String strNOM_CAG_PSD_ACD) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cag_psd_acd FROM cag_psd_acd_tab ");
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
        this.COD_CAG_PSD_ACD = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CAG_PSD_ACD = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM cag_psd_acd_tab  WHERE cod_cag_psd_acd=?");
            ps.setLong(1, COD_CAG_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_CAG_PSD_ACD = rs.getString("NOM_CAG_PSD_ACD");
                this.DES_CAG_PSD_ACD = rs.getString("DES_CAG_PSD_ACD");
                this.PER_MES_SST = rs.getLong("PER_MES_SST");
                this.PER_MES_MNT = rs.getLong("PER_MES_MNT");
            } else {
                throw new NoSuchEntityException("CategoriePreside con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cag_psd_acd_tab  WHERE cod_cag_psd_acd=?");
            ps.setLong(1, COD_CAG_PSD_ACD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CategoriePreside con ID=" + COD_CAG_PSD_ACD + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE cag_psd_acd_tab  SET nom_cag_psd_acd=?, des_cag_psd_acd=?, per_mes_sst=?, per_mes_mnt=?  WHERE cod_cag_psd_acd=?");

            ps.setString(1, NOM_CAG_PSD_ACD);
            ps.setString(2, DES_CAG_PSD_ACD);
            ps.setLong(3, PER_MES_SST);
            ps.setLong(4, PER_MES_MNT);
            ps.setLong(5, COD_CAG_PSD_ACD);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("This CategoriePreside not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!////////////////////////////
//<comment description="Zdes opredeliayutsia metody remote interfeisa"/>
//<comment description="setter/getters">  
    //----1
    public String getNOM_CAG_PSD_ACD() {
        return NOM_CAG_PSD_ACD;
    }

    public void setNOM_CAG_PSD_ACD(String newNOM_CAG_PSD_ACD) {
        if (NOM_CAG_PSD_ACD.equals(newNOM_CAG_PSD_ACD)) {
            return;
        }
        NOM_CAG_PSD_ACD = newNOM_CAG_PSD_ACD;
        setModified();
    }
    //----2

    public void setDES_CAG_PSD_ACD(String newDES_CAG_PSD_ACD) {
        if (DES_CAG_PSD_ACD != null) {
            if (DES_CAG_PSD_ACD.equals(newDES_CAG_PSD_ACD)) {
                return;
            }
        }
        DES_CAG_PSD_ACD = newDES_CAG_PSD_ACD;
        setModified();
    }

    public String getDES_CAG_PSD_ACD() {
        if (DES_CAG_PSD_ACD == null) {
            return "";
        }
        return DES_CAG_PSD_ACD;
    }
    //----3

    public void setPER_MES_SST(long newPER_MES_SST) {
        if (PER_MES_SST == newPER_MES_SST) {
            return;
        }
        PER_MES_SST = newPER_MES_SST;
        setModified();
    }

    public long getPER_MES_SST() {
        return PER_MES_SST;
    }
    //----4

    public void setPER_MES_MNT(long newPER_MES_MNT) {
        if (PER_MES_MNT == newPER_MES_MNT) {
            return;
        }
        PER_MES_MNT = newPER_MES_MNT;
        setModified();
    }

    public long getPER_MES_MNT() {
        return PER_MES_MNT;
    }
    //---5

    public long getCOD_CAG_PSD_ACD() {
        return COD_CAG_PSD_ACD;
    }
    //-------------------
    //</comment>

    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetCategoriePreside_Categoria_RagSoc_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  cod_cag_psd_acd,nom_cag_psd_acd FROM cag_psd_acd_tab ORDER BY nom_cag_psd_acd ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategoriePreside_Categoria_RagSoc_View obj = new CategoriePreside_Categoria_RagSoc_View();
                obj.COD_CAG_PSD_ACD = rs.getLong(1);
                obj.NOM_CAG_PSD_ACD = rs.getString(2);
                //obj.CAG_FOR=rs.getString(3);
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
    //-----------------------------#############################################
    // %%%Link%%% Table RSP_CAG_PSD_ACD_TAB

    public void addCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO rsp_cag_psd_acd_tab (cod_dpd,cod_azl,cod_cag_psd_acd) VALUES(?,?,?)");
            ps.setLong(1, newCOD_DPD);
            ps.setLong(2, newCOD_AZL);
            ps.setLong(3, newCOD_CAG_PSD_ACD);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%UNLink%%% Table RSP_CAG_PSD_ACD_TAB
    public void removeCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rsp_cag_psd_acd_tab  WHERE cod_dpd=? AND cod_azl=? AND cod_cag_psd_acd=?");
            ps.setLong(1, newCOD_DPD);
            ps.setLong(2, newCOD_AZL);
            ps.setLong(3, newCOD_CAG_PSD_ACD);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------#############################################

//--- select from Resronsabiliti
//cog_dpd
//nom_dpd
//mtr_dpd
    public Collection ejbGetResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dpd.cog_dpd, dpd.nom_dpd, dpd.mtr_dpd, dpd.cod_dpd  FROM view_ana_dpd_tab dpd, rsp_cag_psd_acd_tab rcpa WHERE dpd.cod_dpd=rcpa.cod_dpd  AND  rcpa.cod_azl=? AND rcpa.cod_cag_psd_acd=? ORDER BY dpd.cog_dpd ");
            ps.setLong(1, FOR_AZL_ID);
            ps.setLong(2, FOR_COD_CAG_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View obj = new ResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View();
                obj.COG_DPD = rs.getString(1);
                obj.NOM_DPD = rs.getString(2);
                obj.MTR_DPD = rs.getString(3);
                obj.COD_DPD = rs.getLong(4);
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

    //-------------------
    public Collection ejbGetResronsabiliti__View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD, long FOR_COD_DPD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dpd.cog_dpd, dpd.nom_dpd, dpd.mtr_dpd, dpd.cod_dpd  FROM view_ana_dpd_tab dpd, rsp_cag_psd_acd_tab rcpa WHERE dpd.cod_dpd=rcpa.cod_dpd  AND  rcpa.cod_azl=? AND rcpa.cod_cag_psd_acd=? AND rcpa.cod_dpd=? ");
            ps.setLong(1, FOR_AZL_ID);
            ps.setLong(2, FOR_COD_CAG_PSD_ACD);
            ps.setLong(3, FOR_COD_DPD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Resronsabiliti__View obj = new Resronsabiliti__View();
                obj.COG_DPD = rs.getString(1);
                obj.NOM_DPD = rs.getString(2);
                obj.MTR_DPD = rs.getString(3);
                obj.COD_DPD = rs.getLong(4);
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
//<report>

    public Collection ejbGetCategoriePresidiView(long lCOD_CAG_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_cag_psd_acd, "
                        + "a.nom_cag_psd_acd, "
                        + "a.des_cag_psd_acd, "
                        + "a.per_mes_sst, "
                        + "a.per_mes_mnt, "
                        + "c.nom_luo_fsc, "
                        + "b.cod_psd_acd "
                    + "from "
                        + "cag_psd_acd_tab a, "
                        + "ana_psd_acd_tab b, "
                        + "ana_luo_fsc_tab c "
                    + "where "
                        + "a.cod_cag_psd_acd in (?) "
                        + "and a.cod_cag_psd_acd = b.cod_cag_psd_acd "
                        + "and b.cod_luo_fsc = c.cod_luo_fsc ");
            ps.setLong(1, lCOD_CAG_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategoriePresidiView obj = new CategoriePresidiView();
                obj.lCOD_CAG_PSD_ACD = rs.getLong(1);
                obj.strNOM_CAG_PSD_ACD = rs.getString(2);
                obj.strDES_CAG_PSD_ACD = rs.getString(3);
                obj.lPER_MES_SST = rs.getLong(4);
                obj.lPER_MES_MNT = rs.getLong(5);
                obj.strNOM_LUO_FSC = rs.getString(6);
                obj.lCOD_PSD_ACD = rs.getLong(7);
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

    public Collection ejbGetPresidiByCategoriaView(long lCOD_CAG_PSD_ACD, long lCOD_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select a.cod_psd_acd , a.cod_luo_fsc   , a.ide_psd_acd  ,  a.dat_ult_ctl ,  a.esi_ult_ctl from    ana_psd_acd_tab a, cag_psd_acd_tab b where a.cod_cag_psd_acd=b.cod_cag_psd_acd and b.cod_cag_psd_acd=? and a.cod_psd_acd=?");
            ps.setLong(1, lCOD_CAG_PSD_ACD);
            ps.setLong(2, lCOD_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                PresidiByCategoriaView obj = new PresidiByCategoriaView();
                obj.lCOD_PSD_ACD = rs.getLong(1);
                obj.lCOD_LUO_FSC = rs.getLong(2);
                obj.strIDE_PSD_ACD = rs.getString(3);
                obj.dtDAT_ULT_CTL = rs.getDate(4);
                obj.strESI_ULT_CTL = rs.getString(5);
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

    public Collection ejbGetInterventoByPresidiView(long lCOD_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select dat_pif_inr   ,dat_inr, nom_rsp_inr   ,           upper(esi_inr) from    sch_inr_psd_tab where cod_psd_acd=?");

            ps.setLong(1, lCOD_PSD_ACD);
            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                InterventoByPresidiView obj = new InterventoByPresidiView();
                obj.dtDAT_PIF_INR = rs.getDate(1);
                obj.dtDAT_INR = rs.getDate(2);
                obj.strNOM_RSP_INR = rs.getString(3);
                String esi = rs.getString(4);
                if (esi == null) {
                    obj.strESI_INR = "-";
                } else if (esi.equals("S")) {
                    obj.strESI_INR = "Positivo";
                } else if (esi.equals("N")) {
                    obj.strESI_INR = "Negativo";
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
    //

    public Collection ejbGetCAG_Lov(long lCOD_AZL, String strNOM_CAG_PSD_ACD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                        + "a.cod_cag_psd_acd, "
                        + "a.nom_cag_psd_acd, "
                        + "a.per_mes_sst, "
                        + "a.per_mes_mnt "
                    + "FROM "
                        + "cag_psd_acd_tab a, "
                        + "ana_psd_acd_tab b, "
                        + "ana_luo_fsc_tab c "
                    + "WHERE "
                        + "a.cod_cag_psd_acd = b.cod_cag_psd_acd "
                        + "AND b.cod_luo_fsc = c.cod_luo_fsc "
                        + "AND c.cod_azl=? "
                        + "AND a.nom_cag_psd_acd LIKE ?||'%' "
                    + "ORDER BY "
                        + "a.nom_cag_psd_acd ");
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strNOM_CAG_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                CAG_Lov v = new CAG_Lov();
                v.COD_CAG_PSD_ACD = rs.getLong(1);
                v.NOM_CAG_PSD_ACD = rs.getString(2);
                v.PER_MES_SST = rs.getLong(3);
                v.PER_MES_MNT = rs.getLong(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //--- mary for search
    public Collection findEx(
            String strNOM_CAG_PSD_ACD,
            String strDES_CAG_PSD_ACD,
            Long lPER_MES_SST,
            Long lPER_MES_MNT,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(strNOM_CAG_PSD_ACD, strDES_CAG_PSD_ACD, lPER_MES_SST, lPER_MES_MNT, iOrderParameter);
    }

    public Collection ejbFindEx(String strNOM_CAG_PSD_ACD,
            String strDES_CAG_PSD_ACD,
            Long lPER_MES_SST,
            Long lPER_MES_MNT,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT cod_cag_psd_acd , nom_cag_psd_acd, des_cag_psd_acd, per_mes_sst, per_mes_mnt FROM   cag_psd_acd_tab ";

        String strWhere = "";

        if (strNOM_CAG_PSD_ACD != null) {
            strWhere += " AND UPPER(nom_cag_psd_acd) LIKE ? ";
        }
        if (strDES_CAG_PSD_ACD != null) {
            strWhere += " AND UPPER(des_cag_psd_acd) LIKE ? ";
        }
        if (lPER_MES_SST != null) {
            strWhere += " AND per_mes_sst=? ";
        }
        if (lPER_MES_MNT != null) {
            strWhere += " AND per_mes_mnt=? ";
        }

        if (!strWhere.equals("")) {
            strWhere = " WHERE " + strWhere.substring(5, strWhere.length());
        }

        strSql = strSql + strWhere + " ORDER BY UPPER(nom_cag_psd_acd)";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);

            if (strNOM_CAG_PSD_ACD != null) {
                ps.setString(i++, strNOM_CAG_PSD_ACD.toUpperCase());
            }
            if (strDES_CAG_PSD_ACD != null) {
                ps.setString(i++, strDES_CAG_PSD_ACD.toUpperCase());
            }
            if (lPER_MES_SST != null) {
                ps.setLong(i++, lPER_MES_SST.longValue());
            }
            if (lPER_MES_MNT != null) {
                ps.setLong(i++, lPER_MES_MNT.longValue());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                CategoriePreside_Categoria_RagSoc_View obj = new CategoriePreside_Categoria_RagSoc_View();
                obj.COD_CAG_PSD_ACD = rs.getLong(1);
                obj.NOM_CAG_PSD_ACD = rs.getString(2);
                ar.add(obj);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  CategoriePresideBean"/>
