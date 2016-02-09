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
package com.apconsulting.luna.ejb.Dipendente;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
public class DipendenteBean extends BMPEntityBean implements IDipendenteHome, IDipendente {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    long COD_DPD;			//0
    long COD_AZL;			//1
    long COD_DTE;			//2 - Nullable
    long COD_FUZ_AZL;		//3
    String STA_DPD;			//4
    String MTR_DPD;			//5
    String COG_DPD;			//6
    String NOM_DPD;			//7
    String COD_FIS_DPD;		//8 - Nullable
    long COD_STA;			//9 - Nullable
    String LUO_NAS_DPD;		//10 - Nullable
    java.sql.Date DAT_NAS_DPD;		//11
    String IDZ_DPD;			//12 - Nullable
    String NUM_CIC_DPD;		//13 - Nullable
    String CAP_DPD;			//14 - Nullable
    String CIT_DPD;			//15 - Nullable
    String PRV_DPD;			//16 - Nullable
    String IDZ_PSA_ELT_DPD;	//17 - Nullable
    String RAP_LAV_AZL;		//18
    java.sql.Date DAT_ASS_DPD;            //19 - Nullable
    String LIV_DPD;                //20 - Nullable
    java.sql.Date DAT_CES_DPD;            //21 - Nullable
    String NOT_DPD;
    String SEX_DPD;


    /*	String			File;				//19 - Computing from COD_AZL
    String			FileDimensione;		//20 - Computing from COD_AZL
    java.sql.Date	FileUltModif;		//21 - Computing from COD_AZL
    String			NOM_AZL;			//22 - Computing from COD_AZL
    String			NOM_DTE;			//23 - Computing from COD_DTE
    String			NOM_FUZ_AZL;		//24 - Computing from COD_FUZ_AZL
     */
//</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static DipendenteBean ys = null;

    private DipendenteBean() {
    }

    public static DipendenteBean getInstance() {
        if (ys == null) {
            ys = new DipendenteBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public IDipendente create(long COD_AZL, long COD_FUZ_AZL, String STA_DPD, String MTR_DPD, String COG_DPD, String NOM_DPD, java.sql.Date DAT_NAS_DPD, String RAP_LAV_AZL) throws CreateException {
        DipendenteBean bean = new DipendenteBean();
        try {
            Object primaryKey = bean.ejbCreate(COD_AZL, COD_FUZ_AZL, STA_DPD, MTR_DPD, COG_DPD, NOM_DPD, DAT_NAS_DPD, RAP_LAV_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(COD_AZL, COD_FUZ_AZL, STA_DPD, MTR_DPD, COG_DPD, NOM_DPD, DAT_NAS_DPD, RAP_LAV_AZL);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        DipendenteBean iDipendenteBean = new DipendenteBean();
        try {
            Object obj = iDipendenteBean.ejbFindByPrimaryKey((Long) primaryKey);
            iDipendenteBean.setEntityContext(new EntityContextWrapper(obj));
            iDipendenteBean.ejbActivate();
            iDipendenteBean.ejbLoad();
            iDipendenteBean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        }
    }
    
    
    public void enable(Object primaryKey) {
        DipendenteBean iDipendenteBean = new DipendenteBean();
        try {
            Object obj = iDipendenteBean.ejbFindByPrimaryKey((Long) primaryKey);
            iDipendenteBean.setEntityContext(new EntityContextWrapper(obj));
            iDipendenteBean.ejbActivate();
            iDipendenteBean.ejbLoad();
            iDipendenteBean.ejbEnable();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        }
    }
// (Home Intrface) findByPrimaryKey()

    public IDipendente findByPrimaryKey(Long primaryKey) throws FinderException {
        DipendenteBean bean = new DipendenteBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

// (Home Intrface) findAll()
    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

// (Home Intrface) VIEWS
    public Collection getDipendentiByAZLID_View(long AZL_ID) {
        return (new DipendenteBean()).ejbGetDipendentiByAZLID_View(AZL_ID);
    }

    public Collection getDipendentiByAZLID_View_CAN(long AZL_ID,long COD_DTE) {
        return (new DipendenteBean()).ejbGetDipendentiByAZLID_View_CAN(AZL_ID,COD_DTE);
    }

    public Collection getDipendentiByAZLID_RLS_View(long AZL_ID) {
        return (new DipendenteBean()).ejbGetDipendentiByAZLID_RLS_View(AZL_ID);
    }

    public Collection getDipendentiBySOP_View(long COD_SOP) {
        return (new DipendenteBean()).ejbgetDipendentiBySOP_View(COD_SOP);
    }

    public Collection getDipendentiEstBySOP_View(long COD_SOP) {
        return (new DipendenteBean()).ejbgetDipendentiEstBySOP_View(COD_SOP);
    }
    
    public Collection getDipendenti_Names_View(long AZL_ID) {
        return (new DipendenteBean()).ejbGetDipendenti_Names_View(AZL_ID);
    }
//<report>

    public DipendenteFunzioneView getDipendenteFunzioneView(long lCOD_DPD) {
        return (new DipendenteBean()).ejbGetDipendenteFunzioneView(lCOD_DPD);
    }

//--- Podmasteriev-------------
    public Collection getScadenzario_DPI_View(long lCOD_AZL, long lNOM_COR, String lNOM_DCT, java.sql.Date dDAT_PIF_EGZ_COR_DAL, java.sql.Date dDAT_PIF_EGZ_COR_AL, String strSTA_INT, java.sql.Date dEFF_DAT_DAL, java.sql.Date dEFF_DAT_AL, String strRAGGRUPPATI, String strTYPE, String strFROM) {
        return (new DipendenteBean()).ejbGetScadenzario_DPI_View(lCOD_AZL, lNOM_COR, lNOM_DCT, dDAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_AL, strSTA_INT, dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE, strFROM);
    }

    public Collection getDipendenti_SCH_DPI_View() {
        return (new DipendenteBean()).ejbGetDipendenti_SCH_DPI_View();
    }

    public Collection getDipendenti_Search_View(long AZL_ID) {
        return (new DipendenteBean()).ejbGetDipendenti_Search_View(AZL_ID);
    }

    public Collection getDipendentePercorsiFormativi_View(long COD_DPD) {
        return (new DipendenteBean()).ejbGetDipendentePercorsiFormativi_View(COD_DPD);
    }

    public Collection getDipendente_CORCOM_View() {
        return (new DipendenteBean()).ejbGetDipendente_CORCOM_View();
    }

    public Collection getDipendenti_Lavoratori_View(long lCOD_DPD) {
        return (new DipendenteBean()).ejbGetDipendenti_Lavoratori_View(lCOD_DPD, null, null);
    }

    public Collection getDipendenti_Lavoratori_View(long lCOD_DPD, String columnOrdered, String orderType) {
        return (new DipendenteBean()).ejbGetDipendenti_Lavoratori_View(lCOD_DPD, columnOrdered, orderType);
    }

    public Collection getDipendenti_FOD_DBT_View(long lAZL_ID, String newNOM_MAN, boolean orderDesc) {
        return (new DipendenteBean()).ejbGetDipendenti_FOD_DBT_View(lAZL_ID, newNOM_MAN, orderDesc);
    }

    public Collection getDipendenteByDitta(long lCOD_AZL, long lCOD_DTE) {
        return (new DipendenteBean()).ejbGetDipendenteByDitta(lCOD_AZL, lCOD_DTE);
    }

    public Collection findUOListToSendMail(long lCOD_AZL, long lCOD_MAN) {
        return (new DipendenteBean()).ejbFindUOListToSendMail(lCOD_AZL, lCOD_MAN);
    }

    public Collection findDipendentiAttivitaLavorativeByCOD_UNI_ORG(long lCOD_AZL, long lCOD_MAN, long lCOD_UNI_ORG) {
        return (new DipendenteBean()).ejbFindDipendentiAttivitaLavorativeByCOD_UNI_ORG(lCOD_AZL, lCOD_MAN, lCOD_UNI_ORG);
    }

    public Collection findDipendenteAttivitaLavorativaByCOD_UNI_ORG(long lCOD_AZL, long lCOD_DPD, long lCOD_MAN, long lCOD_UNI_ORG,java.sql.Date lDAT_INZ,boolean activeATT_LAV) {
        return (new DipendenteBean()).ejbFindDipendenteAttivitaLavorativaByCOD_UNI_ORG(lCOD_AZL, lCOD_DPD, lCOD_MAN, lCOD_UNI_ORG,lDAT_INZ,activeATT_LAV);
    }

    public Collection getDipendenteByMTR(long lCOD_AZL, String strMTR_DIP) {
        return (new DipendenteBean()).ejbGetDipendenteByMTR(lCOD_AZL, strMTR_DIP);
    }
     
    /*public Collection getDipendenteBySEX(long lCOD_AZL, String strSEX_DPD) {
        return (new DipendenteBean()).ejbGetDipendenteBySEX(lCOD_AZL, strSEX_DPD);
    }*/

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

//</IDipendenteHome-implementation>
    public Collection ejbFindUOListToSendMail(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        java.util.ArrayList al = new java.util.ArrayList();

        try {
            PreparedStatement ps = bmp.prepareStatement("select distinct(cod_uni_org) from man_dpd_uni_org_tab where (dat_fie is null or dat_fie >= current_date) and cod_azl = ? and cod_man = ?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);

            ps.executeQuery();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dipendenti_Lavoratori_View obj = new Dipendenti_Lavoratori_View();
                obj.COD_UNI_ORG = rs.getLong(1);
                al.add(obj);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return al;
    }

    public Collection ejbFindDipendentiAttivitaLavorativeByCOD_UNI_ORG(long lCOD_AZL, long lCOD_MAN, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        java.util.ArrayList al = new java.util.ArrayList();

        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select " +
                    "   a.cod_uni_org, " +
                    "   a.cod_dpd, " +
                    "   b.nom_uni_org, " +
                    "   c.mtr_dpd, " +
                    "   c.nom_dpd, " +
                    "   c.cog_dpd " +
                    "from " +
                    "   man_dpd_uni_org_tab a, " +
                    "   ana_uni_org_tab b, " +
                    "   view_ana_dpd_tab c " +
                    "where " +
                    "   a.cod_uni_org = b.cod_uni_org " +
                    "   and a.cod_dpd = c.cod_dpd " +
                    "   and (dat_fie is null or dat_fie >= current_date) " +
                    "   and a.cod_azl = ? " +
                    "   and cod_man = ? " +
                    "   and a.cod_uni_org = ?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);
            ps.setLong(3, lCOD_UNI_ORG);

            ps.executeQuery();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dipendenti_Lavoratori_View obj = new Dipendenti_Lavoratori_View();
                obj.COD_UNI_ORG = rs.getLong(1);
                obj.COD_DPD = rs.getLong(2);
                obj.NOM_UNI_ORG = rs.getString(3);
                obj.MTR_DPD = rs.getString(4);
                obj.NOM_DPD = rs.getString(5);
                obj.COG_DPD = rs.getString(6);
                al.add(obj);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return al;
    }

    public Collection ejbFindDipendenteAttivitaLavorativaByCOD_UNI_ORG(long lCOD_AZL, long lCOD_DPD, long lCOD_MAN, long lCOD_UNI_ORG,java.sql.Date lDAT_INZ,boolean activeATT_LAV) {

        BMPConnection bmp = getConnection();
        java.util.ArrayList al = new java.util.ArrayList();

        try {
           
                   String sql= "select " +
                        "a.cod_uni_org, " +
                        "a.cod_dpd, " +
                        "b.nom_uni_org, " +
                        "c.nom_dpd, " +
                        "c.cog_dpd, " +
                        "a.cod_tpl_con " +
                        "from " +
                        "man_dpd_uni_org_tab a, " +
                        "ana_uni_org_tab b, " +
                        "view_ana_dpd_tab c " +
                    "where " +
                        "a.cod_uni_org = b.cod_uni_org " +
                        "and a.cod_dpd = c.cod_dpd " +
                        (activeATT_LAV==true?"and (dat_fie is null or dat_fie >= current_date) ":"") +
                        "and a.cod_azl = ? " +
                        "and a.cod_dpd = ? " +
                        "and cod_man = ? " +
                        "and a.cod_uni_org = ?";
                   if(lDAT_INZ!=null)
                        sql+=" and a.dat_inz=? ";
                        PreparedStatement ps = bmp.prepareStatement(sql);
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_DPD);
            ps.setLong(3, lCOD_MAN);
            ps.setLong(4, lCOD_UNI_ORG);
            if(lDAT_INZ!=null)
            ps.setDate(5, lDAT_INZ);

            ps.executeQuery();
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Dipendenti_Lavoratori_View obj = new Dipendenti_Lavoratori_View();
                obj.COD_UNI_ORG = rs.getLong(1);
                obj.COD_DPD = rs.getLong(2);
                obj.NOM_UNI_ORG = rs.getString(3);
                obj.NOM_DPD = rs.getString(4);
                obj.COG_DPD = rs.getString(5);
                obj.COD_TPL_CON = rs.getLong(6);
                al.add(obj);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return al;
    }

    public Long ejbCreate(long COD_AZL, long COD_FUZ_AZL, String STA_DPD, String MTR_DPD, String COG_DPD, String NOM_DPD, java.sql.Date DAT_NAS_DPD, String RAP_LAV_AZL) {
        this.COD_DPD = NEW_ID(); // unic ID
        this.COD_AZL = COD_AZL;
        this.COD_FUZ_AZL = COD_FUZ_AZL;
        this.STA_DPD = STA_DPD;
        this.MTR_DPD = MTR_DPD;
        this.COG_DPD = COG_DPD;
        this.NOM_DPD = NOM_DPD;
        this.DAT_NAS_DPD = DAT_NAS_DPD;
        this.RAP_LAV_AZL = RAP_LAV_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_dpd_tab (cod_dpd,cod_azl,  cod_fuz_azl, sta_dpd, mtr_dpd, cog_dpd, nom_dpd, dat_nas_dpd, rap_lav_azl) VALUES(?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, COD_FUZ_AZL);
            ps.setString(4, STA_DPD);
            ps.setString(5, MTR_DPD);
            ps.setString(6, COG_DPD);
            ps.setString(7, NOM_DPD);
            ps.setDate(8, DAT_NAS_DPD);
            ps.setString(9, RAP_LAV_AZL);
            ps.executeUpdate();
            return new Long(COD_DPD);
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long COD_AZL, long COD_FUZ_AZL, String STA_DPD, String MTR_DPD, String COG_DPD, String NOM_DPD, java.sql.Date DAT_NAS_DPD, String RAP_LAV_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd FROM view_ana_dpd_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
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
        this.COD_DPD = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_DPD = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_dpd_tab  WHERE cod_dpd=?");
            ps.setLong(1, COD_DPD);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_DPD = rs.getLong("COD_DPD");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_DTE = rs.getLong("COD_DTE");
                this.COD_FUZ_AZL = rs.getLong("COD_FUZ_AZL");
                this.STA_DPD = rs.getString("STA_DPD");
                this.MTR_DPD = rs.getString("MTR_DPD");
                this.COG_DPD = rs.getString("COG_DPD");
                this.NOM_DPD = rs.getString("NOM_DPD");
                this.COD_FIS_DPD = rs.getString("COD_FIS_DPD");
                this.COD_STA = rs.getLong("COD_STA");
                this.LUO_NAS_DPD = rs.getString("LUO_NAS_DPD");
                this.DAT_NAS_DPD = rs.getDate("DAT_NAS_DPD");
                this.IDZ_DPD = rs.getString("IDZ_DPD");
                this.NUM_CIC_DPD = rs.getString("NUM_CIC_DPD");
                this.CAP_DPD = rs.getString("CAP_DPD");
                this.CIT_DPD = rs.getString("CIT_DPD");
                this.PRV_DPD = rs.getString("PRV_DPD");
                this.IDZ_PSA_ELT_DPD = rs.getString("IDZ_PSA_ELT_DPD");
                this.RAP_LAV_AZL = rs.getString("RAP_LAV_AZL");
                this.DAT_ASS_DPD = rs.getDate("DAT_ASS_DPD");
                this.LIV_DPD = rs.getString("LIV_DPD");
                this.DAT_CES_DPD = rs.getDate("DAT_CES_DPD");
                this.NOT_DPD = rs.getString("NOT_DPD");
                this.SEX_DPD = rs.getString("SEX_DPD");
            } else {
                throw new NoSuchEntityException("Dipendente con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_dpd_tab  WHERE cod_dpd=?");
            ps.setLong(1, COD_DPD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Dipendente con ID=" + COD_DPD + " non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------
    
    public void ejbEnable() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_dpd_tab SET DAT_CES_DPD = NULL  WHERE COD_DPD=?");
            ps.setLong(1, COD_DPD);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Dipendente con ID=" + COD_DPD + " non è stato trovato");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
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
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                        "ana_dpd_tab " +
                    "SET " +
                        "cod_azl=?, " +
                        "cod_dte=?, " +
                        "cod_fuz_azl=?, " +
                        "sta_dpd=?, " +
                        "mtr_dpd=?, " +
                        "cog_dpd=?, " +
                        "nom_dpd=?, " +
                        "cod_fis_dpd=?, " +
                        "cod_sta=?, " +
                        "luo_nas_dpd=?, " +
                        "dat_nas_dpd=?, " +
                        "idz_dpd=?, " +
                        "num_cic_dpd=?, " +
                        "cap_dpd=?, " +
                        "cit_dpd=?, " +
                        "prv_dpd=?, " +
                        "idz_psa_elt_dpd=?, " +
                        "rap_lav_azl=?, " +
                        "dat_ass_dpd=?, " +
                        "liv_dpd=?, " +
                        "dat_ces_dpd=?, " +
                        "not_dpd=?, " +
                        "sex_dpd=? " +
                    "WHERE " +
                        "cod_dpd=?");
            ps.setLong(1, COD_AZL);
            if (COD_DTE == 0) {
                ps.setNull(2, java.sql.Types.BIGINT);
            } else {
                ps.setLong(2, COD_DTE);
            }
            ps.setLong(3, COD_FUZ_AZL);
            ps.setString(4, STA_DPD);
            ps.setString(5, MTR_DPD);
            ps.setString(6, COG_DPD);
            ps.setString(7, NOM_DPD);
            if ("".equals(COD_FIS_DPD)) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setString(8, COD_FIS_DPD);
            }
            if (COD_STA == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, COD_STA);
            }
            ps.setString(10, LUO_NAS_DPD);
            ps.setDate(11, DAT_NAS_DPD);
            ps.setString(12, IDZ_DPD);
            ps.setString(13, NUM_CIC_DPD);
            ps.setString(14, CAP_DPD);
            ps.setString(15, CIT_DPD);
            ps.setString(16, PRV_DPD);
            ps.setString(17, IDZ_PSA_ELT_DPD);
            ps.setString(18, RAP_LAV_AZL);
            ps.setDate(19, DAT_ASS_DPD);
            ps.setString(20, LIV_DPD);
            ps.setDate(21, DAT_CES_DPD);
            ps.setString(22, NOT_DPD);
            ps.setString(23, SEX_DPD);
            ps.setLong(24, COD_DPD);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Dipendente with ID= not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
    public long getCOD_DPD() {
        return COD_DPD;
    }

// COD_AZL
    public void setCOD_AZL(long newCOD_AZL) {
        if (COD_AZL == newCOD_AZL) {
            return;
        }
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }

// COD_DTE
    public void setCOD_DTE(long newCOD_DTE) {
        if (COD_DTE == newCOD_DTE) {
            return;
        }
        COD_DTE = newCOD_DTE;
        setModified();
    }

    public long getCOD_DTE() {
        return COD_DTE;
    }

// COD_FUZ_AZL
    public void setCOD_FUZ_AZL(long newCOD_FUZ_AZL) {
        if (COD_FUZ_AZL == newCOD_FUZ_AZL) {
            return;
        }
        COD_FUZ_AZL = newCOD_FUZ_AZL;
        setModified();
    }

    public long getCOD_FUZ_AZL() {
        return COD_FUZ_AZL;
    }

// STA_DPD
    public void setSTA_DPD(String newSTA_DPD) {
        if (STA_DPD != null) {
            if (STA_DPD.equals(newSTA_DPD)) {
                return;
            }
        }
        STA_DPD = newSTA_DPD;
        setModified();
    }

    public String getSTA_DPD() {
        return (STA_DPD != null) ? STA_DPD : "";
    }

// MTR_DPD
    public void setMTR_DPD(String newMTR_DPD) {
        if (MTR_DPD != null) {
            if (MTR_DPD.equals(newMTR_DPD)) {
                return;
            }
        }
        MTR_DPD = newMTR_DPD;
        setModified();
    }

    public String getMTR_DPD() {
        return (MTR_DPD != null) ? MTR_DPD : "";
    }

// COG_DPD
    public void setCOG_DPD(String newCOG_DPD) {
        if (COG_DPD != null) {
            if (COG_DPD.equals(newCOG_DPD)) {
                return;
            }
        }
        COG_DPD = newCOG_DPD;
        setModified();
    }

    public String getCOG_DPD() {
        return (COG_DPD != null) ? COG_DPD : "";
    }

// NOM_DPD
    public void setNOM_DPD(String newNOM_DPD) {
        if (NOM_DPD != null) {
            if (NOM_DPD.equals(newNOM_DPD)) {
                return;
            }
        }
        NOM_DPD = newNOM_DPD;
        setModified();
    }

    public String getNOM_DPD() {
        return (NOM_DPD != null) ? NOM_DPD : "";
    }

// COD_FIS_DPD
    public void setCOD_FIS_DPD(String newCOD_FIS_DPD) {
        if (COD_FIS_DPD != null) {
            if (COD_FIS_DPD.equals(newCOD_FIS_DPD)) {
                return;
            }
        }
        COD_FIS_DPD = newCOD_FIS_DPD;
        setModified();
    }

    public String getCOD_FIS_DPD() {
        return (COD_FIS_DPD != null) ? COD_FIS_DPD : "";
    }

    
     // SEX_DPD   
        public String getSEX_DPD() {
            if (SEX_DPD == null) {
            
                return SEX_DPD = "";
            }
            
        return SEX_DPD;
    }

    // SEX_DPD
    public void setSEX_DPD(String newSEX_DPD) {
        if (SEX_DPD != null) {
            if (SEX_DPD.equals(newSEX_DPD)) {
                return;
            }
        /*else{
            SEX_DPD ="";   
            }*/
            
        }
        SEX_DPD = newSEX_DPD;
        setModified();
    }
       
        
// COD_STA
    public void setCOD_STA(long newCOD_STA) {
        if (COD_STA == newCOD_STA) {
            return;
        }
        COD_STA = newCOD_STA;
        setModified();
    }

    public long getCOD_STA() {
        return COD_STA;
    }

    public String getsCOD_STA() {
        return new Long(COD_STA).toString();
    }

// LUO_NAS_DPD
    public void setLUO_NAS_DPD(String newLUO_NAS_DPD) {
        if (LUO_NAS_DPD != null) {
            if (LUO_NAS_DPD.equals(newLUO_NAS_DPD)) {
                return;
            }
        }
        LUO_NAS_DPD = newLUO_NAS_DPD;
        setModified();
    }

    public String getLUO_NAS_DPD() {
        return (LUO_NAS_DPD != null) ? LUO_NAS_DPD : "";
    }

// DAT_NAS_DPD
    public void setDAT_NAS_DPD(java.sql.Date newDAT_NAS_DPD) {
        if (DAT_NAS_DPD != null) {
            if (DAT_NAS_DPD.equals(newDAT_NAS_DPD)) {
                return;
            }
        }
        DAT_NAS_DPD = newDAT_NAS_DPD;
        setModified();
    }

    public java.sql.Date getDAT_NAS_DPD() {
        return DAT_NAS_DPD;
    }

    public String getsDAT_NAS_DPD() {
        return (DAT_NAS_DPD != null) ? DAT_NAS_DPD.toString() : "";
    }

// IDZ_DPD
    public void setIDZ_DPD(String newIDZ_DPD) {
        if (IDZ_DPD != null) {
            if (IDZ_DPD.equals(newIDZ_DPD)) {
                return;
            }
        }
        IDZ_DPD = newIDZ_DPD;
        setModified();
    }

    public String getIDZ_DPD() {
        return (IDZ_DPD != null) ? IDZ_DPD : "";
    }

// NUM_CIC_DPD
    public void setNUM_CIC_DPD(String newNUM_CIC_DPD) {
        if (NUM_CIC_DPD != null) {
            if (NUM_CIC_DPD.equals(newNUM_CIC_DPD)) {
                return;
            }
        }
        NUM_CIC_DPD = newNUM_CIC_DPD;
        setModified();
    }

    public String getNUM_CIC_DPD() {
        return (NUM_CIC_DPD != null) ? NUM_CIC_DPD : "";
    }

// CAP_DPD
    public void setCAP_DPD(String newCAP_DPD) {
        if (CAP_DPD != null) {
            if (CAP_DPD.equals(newCAP_DPD)) {
                return;
            }
        }
        CAP_DPD = newCAP_DPD;
        setModified();
    }

    public String getCAP_DPD() {
        return (CAP_DPD != null) ? CAP_DPD : "";
    }

// CIT_DPD
    public void setCIT_DPD(String newCIT_DPD) {
        if (CIT_DPD != null) {
            if (CIT_DPD.equals(newCIT_DPD)) {
                return;
            }
        }
        CIT_DPD = newCIT_DPD;
        setModified();
    }

    public String getCIT_DPD() {
        return (CIT_DPD != null) ? CIT_DPD : "";
    }

// PRV_DPD
    public void setPRV_DPD(String newPRV_DPD) {
        if (PRV_DPD != null) {
            if (PRV_DPD.equals(newPRV_DPD)) {
                return;
            }
        }
        PRV_DPD = newPRV_DPD;
        setModified();
    }

    public String getPRV_DPD() {
        return (PRV_DPD != null) ? PRV_DPD : "";
    }

// IDZ_PSA_ELT_DPD
    public void setIDZ_PSA_ELT_DPD(String newIDZ_PSA_ELT_DPD) {
        if (IDZ_PSA_ELT_DPD != null) {
            if (IDZ_PSA_ELT_DPD.equals(newIDZ_PSA_ELT_DPD)) {
                return;
            }
        }
        IDZ_PSA_ELT_DPD = newIDZ_PSA_ELT_DPD;
        setModified();
    }

    public String getIDZ_PSA_ELT_DPD() {
        return (IDZ_PSA_ELT_DPD != null) ? IDZ_PSA_ELT_DPD : "";
    }

// RAP_LAV_AZL
    public void setRAP_LAV_AZL(String newRAP_LAV_AZL) {
        if (RAP_LAV_AZL != null) {
            if (RAP_LAV_AZL.equals(newRAP_LAV_AZL)) {
                return;
            }
        }
        RAP_LAV_AZL = newRAP_LAV_AZL;
        setModified();
    }

    public String getRAP_LAV_AZL() {
        return (RAP_LAV_AZL != null) ? RAP_LAV_AZL : "";
    }

// DAT_ASS_DPD
    public void setDAT_ASS_DPD(java.sql.Date newDAT_ASS_DPD) {
        if (DAT_ASS_DPD != null) {
            if (DAT_ASS_DPD.equals(newDAT_ASS_DPD)) {
                return;
            }
        }
        DAT_ASS_DPD = newDAT_ASS_DPD;
        setModified();
    }

    public java.sql.Date getDAT_ASS_DPD() {
        return DAT_ASS_DPD;
    }

// LIV_DPD
    public void setLIV_DPD(String newLIV_DPD) {
        if (LIV_DPD != null) {
            if (LIV_DPD.equals(newLIV_DPD)) {
                return;
            }
        }
        LIV_DPD = newLIV_DPD;
        setModified();
    }

    public String getLIV_DPD() {
        return (LIV_DPD != null) ? LIV_DPD : "";
    }

// DAT_CES_DPD
    public void setDAT_CES_DPD(java.sql.Date newDAT_CES_DPD) {
        if (DAT_CES_DPD != null) {
            if (DAT_CES_DPD.equals(newDAT_CES_DPD)) {
                return;
            }
        }
        DAT_CES_DPD = newDAT_CES_DPD;
        setModified();
    }

    public java.sql.Date getDAT_CES_DPD() {
        return DAT_CES_DPD;
    }

// NOT_DPD
    public void setNOT_DPD(String newNOT_DPD) {
        if (NOT_DPD != null) {
            if (NOT_DPD.equals(newNOT_DPD)) {
                return;
            }
        }
        NOT_DPD = newNOT_DPD;
        setModified();
    }

    public String getNOT_DPD() {
        return (NOT_DPD != null) ? NOT_DPD : "";
    }


// NOM_AZL
    public String getNOM_AZL() {
        String NOM_AZL = "";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT rag_scl_azl FROM ana_azl_tab WHERE cod_azl=?");
            ps.setLong(1, COD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NOM_AZL = rs.getString(1);
            }
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

        return NOM_AZL;
    }

// NOM_DTE
    public String getNOM_DTE() {
        String NOM_DTE = "";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT rag_scl_dte FROM ana_dte_tab WHERE cod_dte=?");
            ps.setLong(1, COD_DTE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NOM_DTE = rs.getString(1);
            }
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

        return NOM_DTE;
    }

// NOM_FUZ_AZL
    public String getNOM_FUZ_AZL() {
        String NOM_FUZ_AZL = "";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT nom_fuz_azl FROM ana_fuz_azl_tab WHERE cod_fuz_azl=?");
            ps.setLong(1, COD_FUZ_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NOM_FUZ_AZL = rs.getString(1);
            }
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

        return NOM_FUZ_AZL;
    }

    public java.sql.Date getDAT_INZ(long MAN_ID, long UNI_ORG_ID,java.sql.Date nwDAT_INZ) {
        java.sql.Date DAT_INZ = null;

        BMPConnection bmp = getConnection();
        try {
            String sql="SELECT dat_inz FROM man_dpd_uni_org_tab " +
                       "WHERE cod_azl=? AND cod_dpd=? AND cod_man=? " +
                       "AND cod_uni_org=?";
                       if(nwDAT_INZ!=null)
                       sql+=" AND dat_inz=?";
            PreparedStatement ps = bmp.prepareStatement(sql);
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_DPD);
            ps.setLong(3, MAN_ID);
            ps.setLong(4, UNI_ORG_ID);
            if(nwDAT_INZ!=null)
            ps.setDate(5, nwDAT_INZ);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                DAT_INZ = rs.getDate(1);


            }
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return DAT_INZ;
    }

    public java.sql.Date getDAT_FIE(long MAN_ID, long UNI_ORG_ID,java.sql.Date nwDAT_INZ) {
        java.sql.Date DAT_FIE = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dat_fie FROM man_dpd_uni_org_tab " +
                                                        "WHERE cod_azl=? AND cod_dpd=? AND cod_man=? " +
                                                        "AND cod_uni_org=? AND dat_inz=?");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_DPD);
            ps.setLong(3, MAN_ID);
            ps.setLong(4, UNI_ORG_ID);
            ps.setDate(5, nwDAT_INZ);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                DAT_FIE = rs.getDate(1);
            }
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return DAT_FIE;
    }

    
   
    
//</comment>
///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetDipendentiByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd,nom_dpd,cog_dpd,idz_dpd, mtr_dpd FROM view_ana_dpd_tab WHERE cod_azl=? ORDER BY cog_dpd ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentiByAZLID_View obj = new DipendentiByAZLID_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.IDZ_DPD = rs.getString(4);
                obj.MTR_DPD = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    public Collection ejbGetDipendentiByAZLID_View_CAN(long AZL_ID,long COD_DTE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd,nom_dpd,cog_dpd,idz_dpd, mtr_dpd FROM view_ana_dpd_tab WHERE cod_azl=? AND cod_dte=? ORDER BY cog_dpd ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_DTE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentiByAZLID_View obj = new DipendentiByAZLID_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.IDZ_DPD = rs.getString(4);
                obj.MTR_DPD = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public Collection ejbgetDipendentiBySOP_View(long COD_SOP) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
/*		    
"select ana_dpd_tab.cod_dpd,nom_dpd,cog_dpd,nom_fuz_azl,idz_psa_elt_dpd,ana_dte_tab.rag_scl_dte "+
"from ana_sop_tab,sop_dpd_tab,ana_fuz_azl_tab,ana_dpd_tab "+
"	left join ana_dte_tab on (ana_dte_tab.cod_dte=ana_dpd_tab.cod_dte) "+
"where ana_sop_tab.cod_sop=sop_dpd_tab.cod_sop and "+
"sop_dpd_tab.cod_dpd=ana_dpd_tab.cod_dpd and "+
"sop_dpd_tab.cod_azl=ana_dpd_tab.cod_azl and "+
"ana_dpd_tab.cod_fuz_azl=ana_fuz_azl_tab.cod_fuz_azl and "+
"ana_sop_tab.cod_sop = ? ");
*/		    
		    
"select ana_dpd_tab.cod_dpd,nom_dpd,cog_dpd,nom_fuz_azl,idz_psa_elt_dpd "+
"from ana_sop_tab,sop_dpd_tab,ana_dpd_tab,ana_fuz_azl_tab "+
"where ana_sop_tab.cod_sop=sop_dpd_tab.cod_sop and "+
"sop_dpd_tab.cod_dpd=ana_dpd_tab.cod_dpd and "+
"sop_dpd_tab.cod_azl=ana_dpd_tab.cod_azl and "+
"ana_dpd_tab.cod_fuz_azl=ana_fuz_azl_tab.cod_fuz_azl and "+
"ana_sop_tab.cod_sop = ?");

	    ps.setLong(1, COD_SOP);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentiBySOP_View obj = new DipendentiBySOP_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_FUZ_AZL = rs.getString(4);
                obj.IDZ_PSA_ELT_DPD = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbgetDipendentiEstBySOP_View(long COD_SOP) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
/*
"select ana_dpd_tab.cod_dpd,nom_dpd,cog_dpd,nom_fuz_azl,idz_psa_elt_dpd "+
"    from ana_sop_tab,sop_dpd_imp_tab,ana_dpd_tab,ana_fuz_azl_tab "+
"    where ana_sop_tab.cod_sop=sop_dpd_imp_tab.cod_sop and "+
"    sop_dpd_imp_tab.cod_dpd=ana_dpd_tab.cod_dpd and "+
"    sop_dpd_imp_tab.cod_azl=ana_dpd_tab.cod_azl and "+
"    ana_dpd_tab.cod_fuz_azl=ana_fuz_azl_tab.cod_fuz_azl and "+
"    ana_sop_tab.cod_sop = ?");
*/	    
	    
"select ana_dpd_tab.cod_dpd,nom_dpd,cog_dpd,nom_fuz_azl,idz_psa_elt_dpd,ana_dte_tab.rag_scl_dte "+
"    from ana_sop_tab,sop_dpd_imp_tab,ana_dpd_tab,ana_fuz_azl_tab,ana_dte_tab "+
"   where ana_sop_tab.cod_sop=sop_dpd_imp_tab.cod_sop and "+
"    sop_dpd_imp_tab.cod_dpd=ana_dpd_tab.cod_dpd and "+
"    sop_dpd_imp_tab.cod_azl=ana_dpd_tab.cod_azl and "+
"    ana_dpd_tab.cod_fuz_azl=ana_fuz_azl_tab.cod_fuz_azl and "+
"    ana_dte_tab.cod_dte=ana_dpd_tab.cod_dte and "+
"    ana_sop_tab.cod_sop = ?");
	    
            ps.setLong(1, COD_SOP);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentiBySOP_View obj = new DipendentiBySOP_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_FUZ_AZL = rs.getString(4);
                obj.IDZ_PSA_ELT_DPD = rs.getString(5);
                obj.IMPRESA = rs.getString(6);

                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public Collection ejbGetDipendentiByAZLID_RLS_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_dpd,nom_dpd,cog_dpd,idz_dpd, mtr_dpd " +
                    "FROM view_ana_dpd_tab WHERE cod_azl=? AND rap_lav_azl='S' ORDER BY cog_dpd ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentiByAZLID_View obj = new DipendentiByAZLID_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.IDZ_DPD = rs.getString(4);
                obj.MTR_DPD = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    public Collection ejbGetDipendenti_Names_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd, UPPER(nom_dpd), UPPER(cog_dpd), mtr_dpd FROM view_ana_dpd_tab WHERE cod_azl=? ORDER BY cog_dpd  ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Names_View obj = new Dipendenti_Names_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.MTR_DPD = rs.getString(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
///added by Podmasteriev Alexandr

    public Collection ejbGetDipendenti_SCH_DPI_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   cod_dpd, " +
                    "   nom_dpd, " +
                    "   cog_dpd, " +
                    "   mtr_dpd " +
                    "FROM " +
                    "   view_ana_dpd_tab " +
                    "ORDER BY " +
                    "   cog_dpd ");
// ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Names_View obj = new Dipendenti_Names_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.MTR_DPD = rs.getString(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//===========================================================================

    public Collection ejbGetDipendenti_Search_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   a.cod_dpd, " +
                    "   UPPER(a.nom_dpd), " +
                    "   UPPER(a.cog_dpd), " +
                    "   a.mtr_dpd, " +
                    "   UPPER(b.nom_fuz_azl), " +
                    "   a.dat_nas_dpd, " +
                    "   a.luo_nas_dpd, " +
                    "   a.cit_dpd " +
                    "FROM " +
                    "   view_ana_dpd_tab a, " +
                    "   ana_fuz_azl_tab b " +
                    "WHERE " +
                    "   a.cod_fuz_azl=b.cod_fuz_azl " +
                    "   AND a.cod_azl=? " +
                    "ORDER BY " +
                    "   cog_dpd "
                   
                 //   "SELECT distinct a.cod_dpd, UPPER(a.nom_dpd) AS nom_dpd, UPPER(a.cog_dpd) AS cog_dpd, b.nom_fuz_azl, a.dat_nas_dpd, a.luo_nas_dpd, a.cit_dpd, a.dat_ces_dpd, d.rag_scl_dte FROM ana_dpd_tab a left outer join ana_dte_tab d ON a.cod_dte=d.cod_dte,ana_fuz_azl_tab b,ana_dpd_tab c  WHERE a.cod_fuz_azl = b.cod_fuz_azl AND a.cod_azl = 1  ORDER BY cog_dpd"
                   );
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Search_View obj = new Dipendenti_Search_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.MTR_DPD = rs.getString(4);
                obj.NOM_FUZ_AZL = rs.getString(5);
                obj.DAT_NAS_DPD = rs.getDate(6);
                obj.LUO_NAS_DPD = rs.getString(7);
                obj.CIT_DPD = rs.getString(8);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//=======================================================================

    public Collection ejbGetDipendentePercorsiFormativi_View(long COD_DPD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dpd.cod_pcs_frm, ana.nom_pcs_frm, ana.des_pcs_frm FROM ana_pcs_frm_tab ana, pcs_frm_dpd_tab dpd WHERE dpd.cod_pcs_frm=ana.cod_pcs_frm and dpd.cod_dpd=? order by ana.nom_pcs_frm");
            ps.setLong(1, COD_DPD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DipendentePercorsiFormativi_View obj = new DipendentePercorsiFormativi_View();
                obj.COD_PCS_FRM = rs.getLong(1);
                obj.NOM_PCS_FRM = rs.getString(2);
                obj.DES_PCS_FRM = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//==================================================================

    public Collection ejbGetDipendente_CORCOM_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "cod_cor, " +
                    "nom_cor, " +
                    "des_cor " +
                    "FROM " +
                    "ana_cor_tab " +
                    "ORDER BY " +
                    "nom_cor");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendente_CORCOM_View obj = new Dipendente_CORCOM_View();
                obj.COD_COR = rs.getLong(1);
                obj.NOM_COR = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//====================================================================

    public Collection ejbGetDipendenti_Lavoratori_View(long lCOD_DPD_ID, String columnOrdered, String orderType) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   mduo.cod_dpd, " +
                    "   mduo.cod_uni_org, " +
                    "   mduo.cod_man, " +
                    "   am.nom_man, " +
                    "   auo.nom_uni_org, " +
                    "   mduo.dat_inz, " +
                    "   mduo.dat_fie " +
                    "FROM " +
                    "   man_dpd_uni_org_tab mduo, " +
                    "   ana_uni_org_tab auo, " +
                    "   ana_man_tab am " +
                    "WHERE " +
                    "   mduo.cod_uni_org=auo.cod_uni_org " +
                    "   and am.cod_man=mduo.cod_man " +
                    "   and mduo.cod_dpd=? " +
                    "order by  " +
                    (StringManager.isNotEmpty(columnOrdered) && StringManager.isNotEmpty(orderType)
                        ?Integer.parseInt(columnOrdered)+3+" " + orderType + ", mduo.dat_inz"
                        :"mduo.dat_inz"));
            ps.setLong(1, lCOD_DPD_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Lavoratori_View obj = new Dipendenti_Lavoratori_View();
                obj.COD_DPD = rs.getLong(1);
                obj.COD_UNI_ORG = rs.getLong(2);
                obj.COD_MAN = rs.getLong(3);
                obj.NOM_MAN = rs.getString(4);
                obj.NOM_UNI_ORG = rs.getString(5);
                obj.DAT_INZ = rs.getDate(6);
                obj.DAT_FIE = rs.getDate(7);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
//========================================================
    
//========================================================

    public void addCOD_PCS_FRM(long newCOD_PCS_FRM) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO pcs_frm_dpd_tab (cod_dpd,cod_pcs_frm,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_PCS_FRM);
            ps.setLong(3, COD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//========================================================

    
    
    
    
    
    
    public void removeCOD_PCS_FRM(long newCOD_PCS_FRM) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM pcs_frm_dpd_tab  WHERE cod_dpd=? AND cod_pcs_frm=? AND cod_azl=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_PCS_FRM);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi con ID=" + newCOD_PCS_FRM + " non e' trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//===========================================================

    public void addCOD_MAN(long newCOD_UNI_ORG, long newCOD_MAN, java.sql.Date newDAT_INZ, java.sql.Date newDAT_FIE, long lCOD_TPL_CON) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps2 = bmp.prepareStatement(
                    "SELECT " +
                        "* " +
                    "FROM " +
                        "man_uni_org_tab " +
                    "WHERE " +
                        "cod_uni_org=? " +
                        "AND cod_man=?");
            ps2.setLong(1, newCOD_UNI_ORG);
            ps2.setLong(2, newCOD_MAN);
            ResultSet rs = ps2.executeQuery();
            if (!rs.next()) {
                PreparedStatement ps1 = bmp.prepareStatement(
                        "INSERT INTO " +
                            "man_uni_org_tab " +
                                "(cod_uni_org," +
                                "cod_man) " +
                        "VALUES " +
                            "(?,?)");
                ps1.setLong(1, newCOD_UNI_ORG);
                ps1.setLong(2, newCOD_MAN);
                ps1.executeUpdate();
            }
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO " +
                        "man_dpd_uni_org_tab " +
                            "(cod_dpd," +
                            "cod_azl," +
                            "cod_uni_org," +
                            "cod_man," +
                            "dat_inz," +
                            "dat_fie," +
                            "cod_tpl_con) " +
                        "VALUES" +
                            "(?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, newCOD_UNI_ORG);
            ps.setLong(4, newCOD_MAN);
            ps.setDate(5, newDAT_INZ);
            ps.setDate(6, newDAT_FIE);
            if (lCOD_TPL_CON == 0)
                ps.setNull(7, java.sql.Types.BIGINT);
            else
                ps.setLong(7, lCOD_TPL_CON);

            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//====================================================

    public void removeCOD_MAN(long newCOD_MAN, long newCOD_UNI_ORG,java.sql.Date DAT_INZ) {
      
        BMPConnection bmp = getConnection();

        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM man_dpd_uni_org_tab " +
                                                        "WHERE cod_dpd=? AND cod_man=? AND cod_uni_org=? " +
                                                        "AND cod_azl=? AND dat_inz=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_MAN);
            ps.setLong(3, newCOD_UNI_ORG);
            ps.setLong(4, COD_AZL);
            ps.setDate(5, DAT_INZ);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Riga con ID=" + newCOD_MAN + "|" + newCOD_UNI_ORG + " non e' trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//====================================================

    public void addCOR_DPD(String sATE_FRE_DPD, String sESI_TES_VRF, String sMAT_CSG, long lCOD_COR, java.sql.Date sDAT_EFT_COR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO "
                    + " cor_dpd_tab (cod_dpd,cod_cor,cod_azl,ate_fre_dpd,"
                    + " esi_tes_vrf,mat_csg, dat_eft_cor) "
                    + " VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, lCOD_COR);
            ps.setLong(3, COD_AZL);
            ps.setString(4, sATE_FRE_DPD);
            ps.setString(5, sESI_TES_VRF);
            ps.setString(6, sMAT_CSG);
            ps.setDate(7, sDAT_EFT_COR);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//--- mary 06/04/2004
    public void removeCOR_DPD(long lCOD_COR_DPD, java.sql.Date sDAT_EFT_COR) {
        BMPConnection bmp = getConnection();
        try {
                PreparedStatement ps = bmp.prepareStatement("select cod_dpd FROM sch_egz_cor_tab sessione, isc_cor_tab iscritti "
                        + "WHERE sessione.COD_SCH_EGZ_COR = iscritti.COD_SCH_EGZ_COR "
                        + "and iscritti.cod_dpd = ? "
                        + "and iscritti.cod_azl = ? "
                        + "and sessione.cod_cor = ? "
                        + "and sessione.DAT_PIF_EGZ_COR = ? "
                        + "and sessione.cod_azl = ? ");

                ps.setLong(1, COD_DPD);
                ps.setLong(2, COD_AZL);
                ps.setLong(3, lCOD_COR_DPD);
                ps.setDate(4, sDAT_EFT_COR);
                ps.setLong(5, COD_AZL);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    throw new Exception("Non e' possibile eliminare un corso con sessione aperta.");
                }
                PreparedStatement ps1 = bmp.prepareStatement("DELETE FROM cor_dpd_tab "
                        + " WHERE cod_dpd=? AND cod_azl=? "
                        + " AND cod_cor=? AND dat_eft_cor=?");

                ps1.setLong(1, COD_DPD);
                ps1.setLong(2, COD_AZL);
                ps1.setLong(3, lCOD_COR_DPD);
                ps1.setDate(4, sDAT_EFT_COR);
                if (ps1.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Riga con ID=" + lCOD_COR_DPD + " non e' trovata");
                }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void editCOR_DPD(long COR_ID,String sMAT_CSG, String sESI_TES_VRF, String sATE_FRE_DPD,
                       java.sql.Date dDAT_CSG_MAT,java.sql.Date sDAT_EFT_COR,java.sql.Date dDAT_EFT_TES_VRF,
                       long lPTG_OTT_DPD,java.sql.Date oldDAT_EFT_COR) {


     BMPConnection bmp = getConnection();

        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE cor_dpd_tab " +
                                                        " SET dat_csg_mat=?,dat_eft_tes_vrf=?,ptg_ott_dpd=?," +
                                                        " dat_eft_cor=?, mat_csg=?,esi_tes_vrf=?,ate_fre_dpd=?" +
                                                        " WHERE cod_cor=? AND cod_dpd=? " +
                                                        " AND cod_azl=? AND dat_eft_cor=?");
            ps.setDate(1, dDAT_CSG_MAT);
            ps.setDate(2, dDAT_EFT_TES_VRF);
            ps.setLong(3, lPTG_OTT_DPD);
            ps.setDate(4, sDAT_EFT_COR);
            ps.setString(5, sMAT_CSG);
            ps.setString(6, sESI_TES_VRF);
            ps.setString(7, sATE_FRE_DPD);
            ps.setLong(8, COR_ID);
            ps.setLong(9, COD_DPD);
            ps.setLong(10, COD_AZL);
            ps.setDate(11, oldDAT_EFT_COR);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    public Collection ejbGetDipendenti_FOD_DBT_View(long lAZL_ID, String newNOM_MAN, boolean orderDesc) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
/* Estrae tutti i corsi associati ai dipendenti 
    esclusi quelli conclusi positivamente */
                    "SELECT "
                        + "z.cod_cor, "
                        + "z.nom_cor, "
                        + "a.cog_dpd, "
                        + "a.nom_dpd, "
                        + "a.cod_dpd, "
                        + "b.dat_eft_cor as dat_cor "
                    + "FROM "
                        + "view_ana_dpd_tab a, "
                        + "cor_dpd_tab b, "
                        + "ana_cor_tab z "
                    + "WHERE "
                        + "a.cod_dpd = b.cod_dpd "
                        + "AND b.cod_cor = z.cod_cor "
                        + "AND upper(b.esi_tes_vrf) != 'P' "
                        + "AND a.cod_azl = b.cod_azl "
                        + "AND a.cod_azl = ? "
                    + "UNION "
/* Estrae tutti i corsi associati ai percorsi formativi associati ai dipendenti 
    esclusi quelli conclusi positivamente*/
                    + "SELECT "
                        + "z.cod_cor, "
                        + "z.nom_cor, "
                        + "a.cog_dpd, "
                        + "a.nom_dpd, "
                        + "a.cod_dpd, "
                        + "CAST(NULL AS DATE) AS dat_cor "
                    + "FROM "
                        + "view_ana_dpd_tab a, "
                        + "pcs_frm_dpd_tab f, "
                        + "cor_pcs_frm_tab g, "
                        + "ana_cor_tab z "
                    + "WHERE "
                        + "a.cod_dpd = f.cod_dpd "
                        + "AND f.cod_pcs_frm = g.cod_pcs_frm "
                        + "AND a.cod_azl = ? "
                        + "AND g.cod_cor = z.cod_cor "
                        + "AND g.cod_cor NOT IN ("
                            + "SELECT "
                                + "cod_cor "
                            + "FROM "
                                + "cor_dpd_tab b "
                            + "WHERE "
                                    + "a.cod_dpd = b.cod_dpd "
                                    + "AND upper(b.esi_tes_vrf) = 'P') "
                    + "UNION "
/* Estrae tutti i corsi associati alle mansioni associate ai dipendenti 
    esclusi quelli conclusi positivamente*/
                    + "SELECT "
                        + "z.cod_cor, "
                        + "z.nom_cor, "
                        + "a.cog_dpd, "
                        + "a.nom_dpd, "
                        + "a.cod_dpd, "
                        + "d.dat_inz as dat_cor "
                    + "FROM "
                        + "view_ana_dpd_tab a, "
                        + "man_dpd_uni_org_tab c, "
                        + "cor_man_tab d, "
                        + "ana_cor_tab z, "
                        + "ana_man_tab b, "
                        + "ana_uni_org_tab e "
                    + "WHERE "
                        + "a.cod_dpd = c.cod_dpd "
                        + "AND c.cod_man = d.cod_man "
                        + "AND c.cod_man = b.cod_man "
                        + "AND c.cod_uni_org = e.cod_uni_org "
                        + "AND d.cod_cor = z.cod_cor "
                        + "AND d.cod_cor NOT IN ("
                            + "SELECT "
                                + "cod_cor "
                            + "FROM "
                                + "cor_dpd_tab b "
                            + "WHERE "
                                + "a.cod_dpd = b.cod_dpd "
                                + "AND upper(b.esi_tes_vrf) = 'P') "
                        + "AND a.cod_azl = ? "
                        + "AND b.nom_man=? "
                    + "ORDER BY "
                        + "cog_dpd " + (orderDesc?"desc":"") + ", "
                        + "nom_dpd " + (orderDesc?"desc":"") + ", "
                        + "nom_cor, "
                        + "dat_cor desc");
            ps.setLong(1, lAZL_ID);
            ps.setLong(2, lAZL_ID);
            ps.setLong(3, lAZL_ID);
            ps.setString(4, newNOM_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_FOD_DBT_View obj = new Dipendenti_FOD_DBT_View();
                obj.COD_COR = rs.getLong(1);
                obj.NOM_COR = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_DPD = rs.getString(4);
                obj.COD_DPD = rs.getLong(5);
                obj.DAT_COR = rs.getDate(6);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-----------------------------------------------

/////////////////////VIEW By Podmasteriv in SCH_COR form////////////////////////////////////
    public Collection ejbGetScadenzario_DPI_View(long lCOD_AZL, long lNOM_COR, String lNOM_DCT, java.sql.Date dDAT_PIF_EGZ_COR_DAL, java.sql.Date dDAT_PIF_EGZ_COR_AL, String strSTA_INT, java.sql.Date dEFF_DAT_DAL, java.sql.Date dEFF_DAT_AL, String strRAGGRUPPATI, String strTYPE, String strFR) {
        int icounterWhere = 3;
        int iCOUNT_NOM_COR = 0, iCOUNT_NOM_DCT = 0, iCOUNT_DAT_PIF_EGZ_COR_DAL = 0, iCOUNT_DAT_PIF_EGZ_COR_AL = 0, iCOUNT_EFF_DAT_DAL = 0, iCOUNT_EFF_DAT_AL = 0;
        String strFROM = "", strWHERE = "", strGROUP = "";

//--- Nome Tipologia organizativa
        if (lNOM_COR != 0) {
            iCOUNT_NOM_COR = icounterWhere;
            icounterWhere++;
            strFROM = strFROM + " ,tpl_dpi_tab c ";
            strWHERE = strWHERE + " AND c.cod_tpl_dpi = ? ";
        }

//--- Responsabile organizativa
        if (lNOM_DCT != "") {
//A.NOM_RSP_INR
            iCOUNT_NOM_DCT = icounterWhere;
            icounterWhere++;
            strFROM = strFROM + " ,sch_inr_dpi_tab a ";
            strWHERE = strWHERE + " AND a.nom_rsp_inr LIKE ?  ";
        }

//--- DATA PIANIFICAZIONE VISITA
        if ((dDAT_PIF_EGZ_COR_DAL != null) && (dDAT_PIF_EGZ_COR_AL != null)) {
            iCOUNT_DAT_PIF_EGZ_COR_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_PIF_EGZ_COR_AL = icounterWhere;
            icounterWhere++;
//A.dat_pif_inr
            strWHERE = strWHERE + " AND a.dat_pif_inr BETWEEN ? AND ? ";
        }
        if ((dDAT_PIF_EGZ_COR_DAL != null) && (dDAT_PIF_EGZ_COR_AL == null)) {
            iCOUNT_DAT_PIF_EGZ_COR_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr >= ? ";
        }
        if ((dDAT_PIF_EGZ_COR_DAL == null) && (dDAT_PIF_EGZ_COR_AL != null)) {
            iCOUNT_DAT_PIF_EGZ_COR_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr <= ? ";
        }

//--- Stato misura
        if (strSTA_INT.equals("G")) {
            strWHERE = strWHERE + " AND a.dat_inr IS NOT NULL ";
        }
        if (strSTA_INT.equals("D")) {
            strWHERE = strWHERE + " AND a.dat_inr IS NULL  ";
            dEFF_DAT_DAL = null;
            dEFF_DAT_AL = null;
        }
//--- DATA EFFETTUAZIONE
        if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL != null)) {
            iCOUNT_EFF_DAT_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_EFF_DAT_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_inr BETWEEN ? AND ? ";
        }
        if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL == null)) {
            iCOUNT_EFF_DAT_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_inr >= ? ";
        }
        if ((dEFF_DAT_DAL == null) && (dEFF_DAT_AL != null)) {
            iCOUNT_EFF_DAT_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_inr <= ? ";
        }

//*** ORDER ***//
//--- Raggruppati = N
        String VAR_ORDER = "";
        String strSOR = "";
        if (!"".equals(strTYPE)) {
            if ("INRup".equals(strTYPE)) {
                strSOR = ", a.dat_pif_inr ";
                VAR_ORDER = " ORDER BY a.dat_pif_inr ";
            }
            if ("EFTup".equals(strTYPE)) {
                strSOR = ",a.dat_inr ";
                VAR_ORDER = " ORDER BY a.dat_inr ";
            }
            if ("INRdw".equals(strTYPE)) {
                strSOR = ", a.dat_pif_inr DESC ";
                VAR_ORDER = " ORDER BY a.dat_pif_inr DESC ";
            }
            if ("EFTdw".equals(strTYPE)) {
                strSOR = ", a.dat_inr DESC ";
                VAR_ORDER = " ORDER BY a.dat_inr DESC ";
            }
        }
//strSORT_DAT_PIF=strSORT_DAT_PIF.replaceAll("\'","\\");
//strSORT_DAT_EFT=strSORT_DAT_EFT.replaceAll("\'","\\");
        if (strRAGGRUPPATI.equals("N")) {
            strGROUP = VAR_ORDER;
        }
//--- Raggruppati = T
        if (strRAGGRUPPATI.equals("T")) {
            strGROUP = " ORDER BY c.nom_tpl_dpi " + strSOR;

        }

//--- Raggruppati = L
        if (strRAGGRUPPATI.equals("L")) {
            strGROUP = " ORDER BY b.ide_lot_dpi " + strSOR;

        }

//--- Raggruppati = A
        if (strRAGGRUPPATI.equals("A")) {
            strGROUP = " ORDER BY d.rag_scl_azl " + strSOR;

        }

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_sch_inr_dpi, b.ide_lot_dpi,c.nom_tpl_dpi, a.dat_pif_inr, a.dat_inr, d.rag_scl_azl ,d.cod_azl FROM sch_inr_dpi_tab a, ana_lot_dpi_tab b, tpl_dpi_tab c, ana_azl_tab d  WHERE  a.cod_lot_dpi = b.cod_lot_dpi AND b.cod_tpl_dpi = c.cod_tpl_dpi AND b.cod_azl= d.cod_azl AND d.cod_azl=? AND a.tpl_inr_dpi LIKE ?  " + strWHERE + " " + strGROUP);
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strFR);
            if (iCOUNT_NOM_COR != 0) {
                ps.setLong(iCOUNT_NOM_COR, lNOM_COR);
            }
            if (iCOUNT_NOM_DCT != 0) {
                ps.setString(iCOUNT_NOM_DCT, lNOM_DCT + "%");
            }
            if (iCOUNT_DAT_PIF_EGZ_COR_DAL != 0) {
                ps.setDate(iCOUNT_DAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_DAL);
            }
            if (iCOUNT_DAT_PIF_EGZ_COR_AL != 0) {
                ps.setDate(iCOUNT_DAT_PIF_EGZ_COR_AL, dDAT_PIF_EGZ_COR_AL);
            }
            if (iCOUNT_EFF_DAT_DAL != 0) {
                ps.setDate(iCOUNT_EFF_DAT_DAL, dEFF_DAT_DAL);
            }
            if (iCOUNT_EFF_DAT_AL != 0) {
                ps.setDate(iCOUNT_EFF_DAT_AL, dEFF_DAT_AL);
            }

            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Scadenzario_DPI_View obj = new Scadenzario_DPI_View();
                obj.COD_SCH_INR_DPI = rs.getLong(1);
                obj.IDE_LOT_DPI = rs.getString(2);
                obj.NOM_TPL_DPI = rs.getString(3);
                obj.DAT_PIF_INR = rs.getDate(4);
                obj.DAT_INR = rs.getDate(5);
                obj.RAG_SCL_AZL = rs.getString(6);
                obj.COD_AZL = rs.getLong(7);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------------------
//<report>

    public DipendenteFunzioneView ejbGetDipendenteFunzioneView(long lCOD_DPD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  a.cod_dpd   ,a.nom_dpd   ,a.cog_dpd  ,a.cod_fis_dpd ,a.cod_fuz_azl,  b.nom_fuz_azl ,a.mtr_dpd    from  view_ana_dpd_tab a, ana_fuz_azl_tab b where a.cod_fuz_azl = b.cod_fuz_azl and a.cod_dpd=?");
            ps.setLong(1, lCOD_DPD);
            ResultSet rs = ps.executeQuery();
            DipendenteFunzioneView obj = new DipendenteFunzioneView();
            if (rs.next()) {
                obj.lCOD_DPD = rs.getLong(1);
                obj.strNOM_DPD = rs.getString(2);
                obj.strCOG_DPD = rs.getString(3);
                obj.strCOD_FIS_DPD = rs.getString(4);
                obj.lCOD_FUZ_AZL = rs.getLong(5);
                obj.strNOM_FUZ_AZL = rs.getString(6);
                obj.strMTR_DPD = rs.getString(7);
            }
            bmp.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            int iOrderParameter ) {

        return (new DipendenteBean()).ejbFindEx(lCOD_AZL,
                strNOM_DPD,
                strCOG_DPD,
                strMTR_DPD,
                lCOD_FUZ_AZL,
                dtDAT_NAS_DPD,
                strLUO_NAS_DPD,
                strCIT_DPD,
                strIDZ_DPD,
                strNUM_CIC_DPD,
                strCAP_DPD,
                strPRV_DPD,
                lCOD_DTE,
                dtDAT_ASS_DPD,
                strLIV_DPD,
                dtDAT_CES_DPD,
                strSEX_DPD,
                ViewCessati,
                iOrderParameter);
        //
    }
    ;
    public Collection ejbFindEx(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            int iOrderParameter ) {
        return (new DipendenteBean()).ejbFindExSOP(lCOD_AZL,
                strNOM_DPD,
                strCOG_DPD,
                strMTR_DPD,
                lCOD_FUZ_AZL,
                dtDAT_NAS_DPD,
                strLUO_NAS_DPD,
                strCIT_DPD,
                strIDZ_DPD,
                strNUM_CIC_DPD,
                strCAP_DPD,
                strPRV_DPD,
                lCOD_DTE,
                dtDAT_ASS_DPD,
                strLIV_DPD,
                dtDAT_CES_DPD,
                strSEX_DPD ,
                ViewCessati,null,
                iOrderParameter);
    }
/*
    public Collection ejbFindEx(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            boolean ViewCessati,
            int iOrderParameter ) {

        String Table = ViewCessati ? "ana_dpd_tab" : "view_ana_dpd_tab";
        String strSql = "SELECT a.cod_dpd, UPPER(a.nom_dpd) AS nom_dpd, UPPER(a.cog_dpd) AS cog_dpd, b.nom_fuz_azl, a.dat_nas_dpd, a.luo_nas_dpd, a.cit_dpd, a.dat_ces_dpd " +
                "FROM " + Table + " a,ana_fuz_azl_tab b WHERE a.cod_fuz_azl = b.cod_fuz_azl AND cod_azl = ? ";

        if (strNOM_DPD != null) {
            strSql = strSql + "  AND  UPPER(nom_dpd) LIKE ?";
        }
        ;
        if (lCOD_FUZ_AZL != null) {
            strSql = strSql + "  AND  b.cod_fuz_azl = ?";
        }
        ;
        if (strCOG_DPD != null) {
            strSql = strSql + "  AND  UPPER(cog_dpd) LIKE ?";
        }
        ;
        if (strMTR_DPD != null) {
            strSql = strSql + "  AND  UPPER(mtr_dpd) LIKE ?";
        }
        ;
        if (dtDAT_NAS_DPD != null) {
            strSql = strSql + "  AND  dat_nas_dpd = ?";
        }
        ;
        if (strLUO_NAS_DPD != null) {
            strSql = strSql + "  AND  UPPER(luo_nas_dpd) LIKE ?";
        }
        ;
        if (strCIT_DPD != null) {
            strSql = strSql + "  AND  UPPER(cit_dpd) LIKE ?";
        }
        ;
        if (strIDZ_DPD != null) {
            strSql = strSql + "  AND  UPPER(idz_dpd) LIKE ?";
        }
        ;
        if (strNUM_CIC_DPD != null) {
            strSql = strSql + "  AND  UPPER(num_cic_dpd) LIKE ?";
        }
        ;
        if (strCAP_DPD != null) {
            strSql = strSql + "  AND  UPPER(cap_dpd) LIKE ?";
        }
        ;
        if (strPRV_DPD != null) {
            strSql = strSql + "  AND  UPPER(prv_dpd) LIKE ?";
        }
        ;

        if (lCOD_DTE != null) {
            strSql = strSql + "  AND  cod_dte = ?";
        }
        ;
        if (dtDAT_ASS_DPD != null) {
            strSql = strSql + "  AND  dat_ass_dpd = ?";
        }
        ;
        if (strLIV_DPD != null) {
            strSql = strSql + "  AND  UPPER(liv_dpd) LIKE ?";
        }
        ;
        if (dtDAT_CES_DPD != null) {
            strSql = strSql + "  AND  dat_ces_dpd = ?";
        }
        ;
        strSql += " ORDER BY 3,2";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strNOM_DPD != null) {
                ps.setString(i++, strNOM_DPD.toUpperCase());
            }
            ;
            if (lCOD_FUZ_AZL != null) {
                ps.setLong(i++, lCOD_FUZ_AZL.longValue());
            }
            ;
            if (strCOG_DPD != null) {
                ps.setString(i++, strCOG_DPD.toUpperCase());
            }
            ;
            if (strMTR_DPD != null) {
                ps.setString(i++, strMTR_DPD.toUpperCase());
            }
            ;
            if (dtDAT_NAS_DPD != null) {
                ps.setDate(i++, dtDAT_NAS_DPD);
            }
            ;
            if (strLUO_NAS_DPD != null) {
                ps.setString(i++, strLUO_NAS_DPD.toUpperCase());
            }
            ;
            if (strCIT_DPD != null) {
                ps.setString(i++, strCIT_DPD.toUpperCase());
            }
            ;
            if (strIDZ_DPD != null) {
                ps.setString(i++, strIDZ_DPD.toUpperCase());
            }
            ;
            if (strNUM_CIC_DPD != null) {
                ps.setString(i++, strNUM_CIC_DPD.toUpperCase());
            }
            ;
            if (strCAP_DPD != null) {
                ps.setString(i++, strCAP_DPD.toUpperCase());
            }
            ;
            if (strPRV_DPD != null) {
                ps.setString(i++, strPRV_DPD.toUpperCase());
            }
            ;
            if (lCOD_DTE != null) {
                ps.setLong(i++, lCOD_DTE.longValue());
            }
            ;
            if (dtDAT_ASS_DPD != null) {
                ps.setDate(i++, dtDAT_ASS_DPD);
            }
            ;
            if (strLIV_DPD != null) {
                ps.setString(i++, strLIV_DPD);
            }
            ;
            if (dtDAT_CES_DPD != null) {
                ps.setDate(i++, dtDAT_CES_DPD);
            }
            ;
//----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Search_View obj = new Dipendenti_Search_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_FUZ_AZL = rs.getString(4);
                obj.DAT_NAS_DPD = rs.getDate(5);
                obj.LUO_NAS_DPD = rs.getString(6);
                obj.CIT_DPD = rs.getString(7);
                obj.DAT_CES_DPD = rs.getDate(8);
                al.add(obj);
            }
            return al;
//----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }*/
    
    public Collection findExSOP(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            String strSubject,
            int iOrderParameter /*not used for now*/) {
        return (new DipendenteBean()).ejbFindExSOP(lCOD_AZL,
                strNOM_DPD,
                strCOG_DPD,
                strMTR_DPD,
                lCOD_FUZ_AZL,
                dtDAT_NAS_DPD,
                strLUO_NAS_DPD,
                strCIT_DPD,
                strIDZ_DPD,
                strNUM_CIC_DPD,
                strCAP_DPD,
                strPRV_DPD,
                lCOD_DTE,
                dtDAT_ASS_DPD,
                strLIV_DPD,
                dtDAT_CES_DPD,
                strSEX_DPD,
                ViewCessati,
                strSubject,
                iOrderParameter    );
    }
    ;

    public Collection ejbFindExSOP(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            String strSubject,
            int iOrderParameter /*not used for now*/) {

        String Table = ViewCessati ? "ana_dpd_tab" : "view_ana_dpd_tab";
        String strSql = "SELECT a.cod_dpd, UPPER(a.nom_dpd) AS nom_dpd, UPPER(a.cog_dpd) AS cog_dpd, b.nom_fuz_azl, a.dat_nas_dpd, a.luo_nas_dpd, a.cit_dpd, d.rag_scl_dte, a.dat_ces_dpd, a.mtr_dpd, a.sex_dpd  " +
                "FROM " + Table + " a left outer join ana_dte_tab d ON a.cod_dte=d.cod_dte,ana_fuz_azl_tab b WHERE a.cod_fuz_azl = b.cod_fuz_azl AND a.cod_azl = ? ";

        if (strNOM_DPD != null) {
            strSql = strSql + "  AND  UPPER(nom_dpd) LIKE ?";
        }
        
        if (lCOD_FUZ_AZL != null) {
            strSql = strSql + "  AND  b.cod_fuz_azl = ?";
        }
        
        if (strCOG_DPD != null) {
            strSql = strSql + "  AND  UPPER(cog_dpd) LIKE ?";
        }
        
        if (strMTR_DPD != null) {
            strSql = strSql + "  AND  UPPER(mtr_dpd) LIKE ?";
        }
        
        if (dtDAT_NAS_DPD != null) {
            strSql = strSql + "  AND  dat_nas_dpd = ?";
        }
        
        if (strLUO_NAS_DPD != null) {
            strSql = strSql + "  AND  UPPER(luo_nas_dpd) LIKE ?";
        }
        
        if (strCIT_DPD != null) {
            strSql = strSql + "  AND  UPPER(cit_dpd) LIKE ?";
        }
        
        if (strIDZ_DPD != null) {
            strSql = strSql + "  AND  UPPER(idz_dpd) LIKE ?";
        }
        
        if (strNUM_CIC_DPD != null) {
            strSql = strSql + "  AND  UPPER(num_cic_dpd) LIKE ?";
        }
        
        if (strCAP_DPD != null) {
            strSql = strSql + "  AND  UPPER(cap_dpd) LIKE ?";
        }
        
        if (strPRV_DPD != null) {
            strSql = strSql + "  AND  UPPER(prv_dpd) LIKE ?";
        }
        
        if ((strSubject!=null)&&(strSubject.equals("DPD_INT"))){
        //if (lCOD_DTE == null) {
            strSql = strSql + "  AND  a.cod_dte is null ";
    //    }
    }
 else if((strSubject!=null)&&(strSubject.equals("DPD_EST"))){

        //if (lCOD_DTE == null) {
            strSql = strSql + "  AND  a.cod_dte <> 0";
        //}
    }

        if (lCOD_DTE != null) {
            strSql = strSql + "  AND  a.cod_dte = ?";
        }
        
        if (dtDAT_ASS_DPD != null) {
            strSql = strSql + "  AND  dat_ass_dpd = ?";
        }
        
        if (strLIV_DPD != null) {
            strSql = strSql + "  AND  UPPER(liv_dpd) LIKE ?";
        }
        
        if (dtDAT_CES_DPD != null) {
            strSql = strSql + "  AND  dat_ces_dpd = ?";
        }
        
        if (strSEX_DPD != null) {
            strSql = strSql + "  AND  UPPER(a.sex_dpd) LIKE ?";
            
        }
                
                
        strSql += " ORDER BY 3,2";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strNOM_DPD != null) {
                ps.setString(i++, strNOM_DPD.toUpperCase());
            }
            
            if (lCOD_FUZ_AZL != null) {
                ps.setLong(i++, lCOD_FUZ_AZL.longValue());
            }
            
            if (strCOG_DPD != null) {
                ps.setString(i++, strCOG_DPD.toUpperCase());
            }
            
            if (strMTR_DPD != null) {
                ps.setString(i++, strMTR_DPD.toUpperCase());
            }
            
            if (dtDAT_NAS_DPD != null) {
                ps.setDate(i++, dtDAT_NAS_DPD);
            }
            
            if (strLUO_NAS_DPD != null) {
                ps.setString(i++, strLUO_NAS_DPD.toUpperCase());
            }
            
            if (strCIT_DPD != null) {
                ps.setString(i++, strCIT_DPD.toUpperCase());
            }
            
            if (strIDZ_DPD != null) {
                ps.setString(i++, strIDZ_DPD.toUpperCase());
            }
            
            if (strNUM_CIC_DPD != null) {
                ps.setString(i++, strNUM_CIC_DPD.toUpperCase());
            }
            
            if (strCAP_DPD != null) {
                ps.setString(i++, strCAP_DPD.toUpperCase());
            }
            
            if (strPRV_DPD != null) {
                ps.setString(i++, strPRV_DPD.toUpperCase());
            }
            
            if (lCOD_DTE != null) {
                ps.setLong(i++, lCOD_DTE.longValue());
            }
            
            if (dtDAT_ASS_DPD != null) {
                ps.setDate(i++, dtDAT_ASS_DPD);
            }
            
            if (strLIV_DPD != null) {
                ps.setString(i++, strLIV_DPD);
            }
            
            if (dtDAT_CES_DPD != null) {
                ps.setDate(i++, dtDAT_CES_DPD);
            }
            
            if (strSEX_DPD != null) {
                ps.setString(i++, strSEX_DPD.toUpperCase());
            }
//----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Search_View obj = new Dipendenti_Search_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_FUZ_AZL = rs.getString(4);
                obj.DAT_NAS_DPD = rs.getDate(5);
                obj.LUO_NAS_DPD = rs.getString(6);
                obj.CIT_DPD = rs.getString(7);
                obj.RAG_SCL_DTE=rs.getString(8);
                obj.DAT_CES_DPD = rs.getDate(9);
                obj.MTR_DPD = rs.getString(10);
                obj.SEX_DPD = rs.getString(11);
                al.add(obj);
            }
            return al;
//----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
//<alex date="21/04/2004">

    public Collection ejbGetDipendenteByDitta(long lCOD_AZL, long lCOD_DTE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd,nom_dpd,cog_dpd FROM view_ana_dpd_tab WHERE cod_azl=? and cod_dte=? ORDER BY cog_dpd  ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_DTE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Names_View obj = new Dipendenti_Names_View();
                obj.COD_DPD = rs.getLong(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetDipendenteByMTR(long lCOD_AZL, String strMTR_DIP) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dpd FROM view_ana_dpd_tab WHERE cod_azl=? and mtr_dpd=?");
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strMTR_DIP);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Dipendenti_Names_View obj = new Dipendenti_Names_View();
                obj.COD_DPD = rs.getLong(1);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public boolean CodiceFiscaleExists(String strCOD_FIS_DPD, long lCOD_AZL, String strMTR_DPD, long lCOD_DPD) {
        boolean result = false;
        if (strCOD_FIS_DPD != null && !strCOD_FIS_DPD.trim().equals("")) {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT cod_fis_dpd FROM view_ana_dpd_tab WHERE " +
                        "cod_fis_dpd=? and " +
                        "cod_azl=? and " +
                        "mtr_dpd=? and " +
                        "cod_dpd<>?");
                ps.setString(1, strCOD_FIS_DPD);
                ps.setLong(2, lCOD_AZL);
                ps.setString(3, strMTR_DPD);
                ps.setLong(4, lCOD_DPD);
                ResultSet rs = ps.executeQuery();
                result = rs.next();
            } catch (Exception ex) {
                ex.printStackTrace(System.err);
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }
        return result;
    }

    public boolean dipendenteCessato(java.sql.Date dDAT_CES_DPD) {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        try {
            java.util.Date currentDate = dateFormat.parse(dateFormat.format(new java.util.Date()));
            return dDAT_CES_DPD != null &&
                    !dDAT_CES_DPD.equals("") &&
                    currentDate.compareTo(dDAT_CES_DPD) > 0 == true;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        }
    }
    public  String[] getCountDipendenteAttiviCessati(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            StringBuilder sb= new StringBuilder();
            sb.append(" select counT(*) as cessati from ana_dpd_tab where " );
            sb.append(" dat_ces_dpd is not null ");
            sb.append(" and cod_azl = ?");
            sb.append("union " );
            sb.append("select counT(*) as attivi from ana_dpd_tab where  " );
            sb.append("dat_ces_dpd is  null");
            sb.append(" and cod_azl = ?");
            
            PreparedStatement ps = bmp.prepareStatement(sb.toString());
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                String obj = new String();
                obj = rs.getString(1);
                al.add(obj);
            }
            bmp.close();
             String[] ritorno =new  String[2];
            if(al!=null){
                ritorno[0]=al.get(0).toString();
                ritorno[1]=al.get(1).toString();
            }
                
            return ritorno;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    
//</alex>
///////////ATTENTION!!////////////////////////////////////////
}           
