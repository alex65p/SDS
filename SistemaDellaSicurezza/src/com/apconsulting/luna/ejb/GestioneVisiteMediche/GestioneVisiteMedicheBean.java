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
package com.apconsulting.luna.ejb.GestioneVisiteMediche;

import java.sql.Connection;
import java.sql.Date;
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
public class GestioneVisiteMedicheBean extends BMPEntityBean implements IGestioneVisiteMedicheHome, IGestioneVisiteMediche {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    long COD_VST_MED;
    String FAT_PER;
    long PER_VST;
    String NOM_VST_MED;
    String DES_VST_MED;
    long COD_AZL;
    long COD_VST_MED_RPO;
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static GestioneVisiteMedicheBean ys = null;

    private GestioneVisiteMedicheBean() {
        //System.err.println("GestioneVisiteMedicheBean constructor<br>");
    }

    public static GestioneVisiteMedicheBean getInstance() {
        if (ys == null) {
            ys = new GestioneVisiteMedicheBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IGestioneVisiteMediche create(String strFAT_PER, String strNOM_VST_MED, long lCOD_AZL) throws CreateException {
        GestioneVisiteMedicheBean bean = new GestioneVisiteMedicheBean();
        try {
            Object primaryKey = bean.ejbCreate(strFAT_PER, strNOM_VST_MED, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strFAT_PER, strNOM_VST_MED, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        GestioneVisiteMedicheBean iGestioneVisiteMedicheBean = new GestioneVisiteMedicheBean();
        try {
            Object obj = iGestioneVisiteMedicheBean.ejbFindByPrimaryKey((Long) primaryKey);
            iGestioneVisiteMedicheBean.setEntityContext(new EntityContextWrapper(obj));
            iGestioneVisiteMedicheBean.ejbActivate();
            iGestioneVisiteMedicheBean.ejbLoad();
            iGestioneVisiteMedicheBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IGestioneVisiteMediche findByPrimaryKey(Long primaryKey) throws FinderException {
        GestioneVisiteMedicheBean bean = new GestioneVisiteMedicheBean();
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

    // (Home Intrface) VIEWS
    public Collection getVisiteMediche_All_View(long lCOD_AZL) {
        return (new GestioneVisiteMedicheBean()).ejbGetVisiteMediche_All_View(lCOD_AZL);
    }
//<report>

    public VisitaMedicaDipendenteView getVisitaMedicaDipendenteView(long lCOD_DPD, long lCOD_CTL_SAN, long lCOD_VST_MED,Date dtDAT_PIF_VST) {
        return (new GestioneVisiteMedicheBean()).ejbGetVisitaMedicaDipendenteView(lCOD_DPD, lCOD_CTL_SAN, lCOD_VST_MED,dtDAT_PIF_VST);
    }
//--- mary

    public Collection getVisiteMediche_foo_SCHVST_View(long lCOD_AZL, long lCOD_UNI_ORG, String strTPL_ACR_VLU_RSO, String strSTATO, java.sql.Date dDAT_PIF_VST_D, java.sql.Date dDAT_PIF_VST_A, String strSTA_INT, java.sql.Date dDAT_EFT_VST_D, java.sql.Date dDAT_EFT_VST_A, String strRAGGRUPPATI, String strSORT_DAT_PIF, String strSORT_DAT_EFT, String strSORT_TPL_ACC) {
        return (new GestioneVisiteMedicheBean()).ejbGetVisiteMediche_foo_SCHVST_View(lCOD_AZL, lCOD_UNI_ORG, strTPL_ACR_VLU_RSO, strSTATO, dDAT_PIF_VST_D, dDAT_PIF_VST_A, strSTA_INT, dDAT_EFT_VST_D, dDAT_EFT_VST_A, strRAGGRUPPATI, strSORT_DAT_PIF, strSORT_DAT_EFT, strSORT_TPL_ACC);
    }

    public Collection getGestione_CRM_VST_MED_View(String strNOM, long COD_AZL) {

        return (new GestioneVisiteMedicheBean()).ejbGetGestione_CRM_VST_MED_View(strNOM, COD_AZL);

    }

    public boolean caricaRpVisMed(long P_COD_AZL, String P_NOM_VST_MED) {
        GestioneVisiteMedicheBean bean = new GestioneVisiteMedicheBean();
        return bean.ejbcaricaRpVisMed(P_COD_AZL, P_NOM_VST_MED);
    }

    public boolean caricaDbVisMed(long P_COD_AZL, long P_COD_VST_MED) {
        GestioneVisiteMedicheBean bean = new GestioneVisiteMedicheBean();
        return bean.ejbcaricaDbVisMed(P_COD_AZL, P_COD_VST_MED);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IGestioneVisiteMedicheHome-implementation>
    public Long ejbCreate(String strFAT_PER, String strNOM_VST_MED, long lCOD_AZL) {
        this.FAT_PER = strFAT_PER;
        this.NOM_VST_MED = strNOM_VST_MED;
        this.COD_AZL = lCOD_AZL;
        this.COD_VST_MED = NEW_ID(); // unic ID

        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_vst_med_tab (cod_vst_med,fat_per, nom_vst_med, cod_azl) VALUES(?,?,?,?)");
            ps.setLong(1, COD_VST_MED);
            ps.setString(2, FAT_PER);
            ps.setString(3, NOM_VST_MED);
            ps.setLong(4, COD_AZL);

            ps.executeUpdate();
            return new Long(COD_VST_MED);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strFAT_PER, String strNOM_VST_MED, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_vst_med FROM ana_vst_med_tab ");
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
        this.COD_VST_MED = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_VST_MED = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_vst_med_tab  WHERE cod_vst_med=?");
            ps.setLong(1, COD_VST_MED);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_VST_MED = rs.getLong("COD_VST_MED");
                this.FAT_PER = rs.getString("FAT_PER");
                this.PER_VST = rs.getLong("PER_VST");
                this.NOM_VST_MED = rs.getString("NOM_VST_MED");
                this.DES_VST_MED = rs.getString("DES_VST_MED");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_VST_MED_RPO = rs.getLong("COD_VST_MED_RPO");
            } else {
                throw new NoSuchEntityException("GestioneVisiteMediche con ID=" + COD_VST_MED + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_vst_med_tab  WHERE cod_vst_med=?");
            ps.setLong(1, COD_VST_MED);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("GestioneVisiteMediche con ID=" + COD_VST_MED + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_vst_med_tab  SET fat_per=?, per_vst=?, nom_vst_med=?,des_vst_med=?,cod_azl=?,cod_vst_med_rpo=? WHERE cod_vst_med=?");
            ps.setLong(7, COD_VST_MED);
            ps.setString(1, FAT_PER);
            if (PER_VST == 0) {
                ps.setNull(2, java.sql.Types.BIGINT);
            } else {
                ps.setLong(2, PER_VST);
            }
            ps.setString(3, NOM_VST_MED);
            ps.setString(4, DES_VST_MED);
            ps.setLong(5, COD_AZL);
            if (COD_VST_MED_RPO == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, COD_VST_MED_RPO);
            }
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("GestioneVisiteMediche con ID=" + COD_VST_MED + " non è trovata");
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

//<comment description="Update Method">
    public void Update() {
        setModified();
    }
//<comment

//<comment description="setter/getters">
    // COD_VST_MED
    public void setCOD_VST_MED(long newCOD_VST_MED) {
        COD_VST_MED = newCOD_VST_MED;
        setModified();
    }

    public long getCOD_VST_MED() {
        return COD_VST_MED;
    }

    // FAT_PER
    public void setFAT_PER(String newFAT_PER) {
        if (FAT_PER != null) {
            if (FAT_PER.equals(newFAT_PER)) {
                return;
            }
        }
        FAT_PER = newFAT_PER;
        setModified();
    }

    public String getFAT_PER() {
        return FAT_PER;
    }

    // PER_VST
    public void setPER_VST(long newPER_VST) {
        PER_VST = newPER_VST;
        setModified();
    }

    public long getPER_VST() {
        return PER_VST;
    }

    // NOM_VST_MED
    public void setNOM_VST_MED__COD_AZL(String newNOM_VST_MED, long newCOD_AZL) {
        if (NOM_VST_MED != null) {
            if (NOM_VST_MED.equals(newNOM_VST_MED) && (COD_AZL == newCOD_AZL)) {
                return;
            }
        }
        NOM_VST_MED = newNOM_VST_MED;
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public String getNOM_VST_MED() {
        return NOM_VST_MED;
    }

    // DES_VST_MED
    public void setDES_VST_MED(String newDES_VST_MED) {
        if (DES_VST_MED != null) {
            if (DES_VST_MED.equals(newDES_VST_MED)) {
                return;
            }
        }
        DES_VST_MED = newDES_VST_MED;
        setModified();
    }

    public String getDES_VST_MED() {
        return DES_VST_MED;
    }

    // COD_AZL
    public long getCOD_AZL() {
        return COD_AZL;
    }

    // COD_VST_MED_RPO
    public void setCOD_VST_MED_RPO(long newCOD_VST_MED_RPO) {
        COD_VST_MED_RPO = newCOD_VST_MED_RPO;
        setModified();
    }

    public long getCOD_VST_MED_RPO() {
        return COD_VST_MED_RPO;
    }

    //</comment>
    //=====================================================================<br>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetVisiteMediche_All_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_vst_med,nom_vst_med,des_vst_med,fat_per,per_vst  FROM ana_vst_med_tab WHERE cod_azl = ? ORDER BY nom_vst_med");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteMediche_All_View obj = new VisiteMediche_All_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DES_VST_MED = rs.getString(3);
                obj.FAT_PER = rs.getString(4);
                obj.PER_VST = rs.getString(5);
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

//--- mary
    public Collection ejbGetVisiteMediche_foo_SCHVST_View(long lCOD_AZL, long lCOD_UNI_ORG, 
                                                          String strTPL_ACR_VLU_RSO, String strSTATO,
                                                          java.sql.Date dDAT_PIF_VST_D,
                                                          java.sql.Date dDAT_PIF_VST_A, String strSTA_INT,
                                                          java.sql.Date dDAT_EFT_VST_D,
                                                          java.sql.Date dDAT_EFT_VST_A,
                                                          String strRAGGRUPPATI, String strSORT_DAT_PIF,
                                                          String strSORT_DAT_EFT,
                                                          String strSORT_TPL_ACC) {
        int icounterWhere = 2;
        int iCOUNT_COD_UNI_ORG = 0, iCOUNT_TPL_ACR_VLU_RSO = 0, 
            iCOUNT_DAT_PIF_VST_D = 0, iCOUNT_DAT_PIF_VST_A = 0,
            iCOUNT_DAT_EFT_VST_D = 0, iCOUNT_DAT_EFT_VST_A = 0;
        String strFROM = "", strWHERE = "", strGROUP = "";

        //--- Unita organizativa
        if (lCOD_UNI_ORG != 0) {
            iCOUNT_COD_UNI_ORG = icounterWhere;
            icounterWhere++;
            strFROM = strFROM + " ,MAN_DPD_UNI_ORG_TAB d ";
            strWHERE = strWHERE + " AND d.cod_dpd = b.cod_dpd AND d.cod_azl = b.cod_azl AND d.cod_uni_org = ? ";
        }
        //--- Tipologia Accertamento Medico
        if (!strTPL_ACR_VLU_RSO.equals("")) {
            iCOUNT_TPL_ACR_VLU_RSO = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.tpl_acr_vlu_rso  like ? ";
        }
        //--- STATUS (P = PIANIFICATA e E = EFFETTUATA)
        if (strSTATO.equals("P")) {
            strWHERE = strWHERE + " AND a.dat_pif_vst_med IS NOT NULL";
        }
        if (strSTATO.equals("E")) {
            strWHERE = strWHERE + " AND a.dat_eft_vst_med IS NOT NULL";
        }
        //--- DATA PIANIFICAZIONE VISITA MEDICA
        if ((dDAT_PIF_VST_D != null) && (dDAT_PIF_VST_A != null)) {
            iCOUNT_DAT_PIF_VST_D = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_PIF_VST_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_vst_med BETWEEN ? AND ? ";
        }
        if ((dDAT_PIF_VST_D != null) && (dDAT_PIF_VST_A == null)) {
            iCOUNT_DAT_PIF_VST_D = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_vst_med >= ? ";
        }
        if ((dDAT_PIF_VST_D == null) && (dDAT_PIF_VST_A != null)) {
            iCOUNT_DAT_PIF_VST_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_vst_med <= ? ";
        }
        //--- Stato misura
        if (strSTA_INT.equals("G")) {
            strWHERE = strWHERE + " AND a.dat_eft_vst_med IS NOT NULL ";
        }
        if (strSTA_INT.equals("D")) {
            strWHERE = strWHERE + " AND a.dat_eft_vst_med IS NULL  ";
            dDAT_EFT_VST_D = null;
            dDAT_EFT_VST_A = null;

        }
        //--- DATA EFFETTUAZIONE VISITA MEDICA
        if ((dDAT_EFT_VST_D != null) && (dDAT_EFT_VST_A != null)) {
            iCOUNT_DAT_EFT_VST_D = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_EFT_VST_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_eft_vst_med BETWEEN ? AND ? ";
        }
        if ((dDAT_EFT_VST_D != null) && (dDAT_EFT_VST_A == null)) {
            iCOUNT_DAT_EFT_VST_D = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_eft_vst_med >= ? ";
        }
        if ((dDAT_EFT_VST_D == null) && (dDAT_EFT_VST_A != null)) {
            iCOUNT_DAT_EFT_VST_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_eft_vst_med <= ? ";
        }

        //*** ORDER ***//
        //--- Raggruppati = N
			/*
        strSORT_DAT_PIF=strSORT_DAT_PIF.replaceAll("\'","\\");
        strSORT_DAT_EFT=strSORT_DAT_EFT.replaceAll("\'","\\");
        strSORT_TPL_ACC=strSORT_TPL_ACC.replaceAll("\'","\\");
         */
        strSORT_DAT_PIF = strSORT_DAT_PIF.replaceAll("\'", "");
        strSORT_DAT_EFT = strSORT_DAT_EFT.replaceAll("\'", "");
        strSORT_TPL_ACC = strSORT_TPL_ACC.replaceAll("\'", "");
        if (strRAGGRUPPATI.equals("N")) {
            String strVAL_SORT_DAT_PIF = "", strVAL_SORT_DAT_EFT = "", strVAL_SORT_TPL_ACC = "";
            if (strSORT_DAT_PIF == null) {
                strVAL_SORT_DAT_PIF = "X";
            } else {
                strVAL_SORT_DAT_PIF = strSORT_DAT_PIF;
            }
            if (strSORT_DAT_EFT == null) {
                strVAL_SORT_DAT_EFT = "X";
            } else {
                strVAL_SORT_DAT_EFT = strSORT_DAT_EFT;
            }
            if (strSORT_TPL_ACC == null) {
                strVAL_SORT_TPL_ACC = "X";
            } else {
                strVAL_SORT_TPL_ACC = strSORT_TPL_ACC;
            }

            if ((strVAL_SORT_DAT_PIF.equals("X")) && (strVAL_SORT_DAT_EFT.equals("X")) && (strVAL_SORT_TPL_ACC.equals("X"))) {
                strSORT_DAT_PIF = strSORT_DAT_PIF.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_DAT_PIF;
            } else if ((!strVAL_SORT_DAT_PIF.equals("X")) && (strVAL_SORT_DAT_EFT.equals("X")) && (strVAL_SORT_TPL_ACC.equals("X"))) {
                strSORT_DAT_PIF = strSORT_DAT_PIF.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_DAT_PIF;
            } else if ((strVAL_SORT_DAT_PIF.equals("X")) && (!strVAL_SORT_DAT_EFT.equals("X")) && (strVAL_SORT_TPL_ACC.equals("X"))) {
                strSORT_DAT_EFT = strSORT_DAT_EFT.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_DAT_EFT;
            } else if ((strVAL_SORT_DAT_PIF.equals("X")) && (strVAL_SORT_DAT_EFT.equals("X")) && (!strVAL_SORT_TPL_ACC.equals("X"))) {
                strSORT_TPL_ACC = strSORT_TPL_ACC.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_TPL_ACC;
            }
        }
        //--- Raggruppati = N
        if (strRAGGRUPPATI.equals("D")) {
            strGROUP = " ORDER BY b.cog_dpd || ' ' || b.nom_dpd ";
            if (strSORT_DAT_PIF.equals("X")) {
                strSORT_DAT_PIF = "";
            }
            if (strSORT_DAT_EFT.equals("X")) {
                strSORT_DAT_EFT = "";
            }
            if (strSORT_TPL_ACC.equals("X")) {
                strSORT_TPL_ACC = "";
            }
            strGROUP = strGROUP + strSORT_DAT_PIF + strSORT_DAT_EFT + strSORT_TPL_ACC;
        }
        //--- Raggruppati = A
        if (strRAGGRUPPATI.equals("A")) {
            strGROUP = " ORDER BY c.rag_scl_azl ";
            if (strSORT_DAT_PIF.equals("X")) {
                strSORT_DAT_PIF = "";
            }
            if (strSORT_DAT_EFT.equals("X")) {
                strSORT_DAT_EFT = "";
            }
            if (strSORT_TPL_ACC.equals("X")) {
                strSORT_TPL_ACC = "";
            }
            strGROUP = strGROUP + strSORT_DAT_PIF + strSORT_DAT_EFT + strSORT_TPL_ACC;
        }


        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_ctl_san, a.cod_vst_med," +
                                                        " a.dat_pif_vst_med, a.dat_eft_vst_med, " +
                                                        " a.tpl_acr_vlu_rso , b.cog_dpd || ' ' || b.nom_dpd," +
                                                        " b.cod_dpd, c.rag_scl_azl ,c.cod_azl " +
                                                        " FROM vst_med_ctl_san_tab a, view_ana_dpd_tab b ," +
                                                        " ana_azl_tab c " + strFROM + " " +
                                                        " WHERE a.cod_dpd = b.cod_dpd" +
                                                        " AND a.cod_azl= b.cod_azl AND b.cod_azl= c.cod_azl " +
                                                        " AND c.cod_azl=? " + strWHERE + " " + strGROUP);



            ps.setLong(1, lCOD_AZL);
            
            if (iCOUNT_COD_UNI_ORG != 0) {
                ps.setLong(iCOUNT_COD_UNI_ORG, lCOD_UNI_ORG);
         
            }
            if (iCOUNT_TPL_ACR_VLU_RSO != 0) {
                ps.setString(iCOUNT_TPL_ACR_VLU_RSO, strTPL_ACR_VLU_RSO + '%');
            }
            if (iCOUNT_DAT_PIF_VST_D != 0) {
                ps.setDate(iCOUNT_DAT_PIF_VST_D, dDAT_PIF_VST_D);
            }
            if (iCOUNT_DAT_PIF_VST_A != 0) {
                ps.setDate(iCOUNT_DAT_PIF_VST_A, dDAT_PIF_VST_A);
            }
            if (iCOUNT_DAT_EFT_VST_D != 0) {
                ps.setDate(iCOUNT_DAT_EFT_VST_D, dDAT_EFT_VST_D);
            }
            if (iCOUNT_DAT_EFT_VST_A != 0) {
                ps.setDate(iCOUNT_DAT_EFT_VST_A, dDAT_EFT_VST_A);
            }

            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteMediche_foo_SCHVST_View obj = new VisiteMediche_foo_SCHVST_View();
                obj.COD_CTL_SAN = rs.getLong(1);
                obj.COD_VST = rs.getLong(2);
                obj.DAT_PIF_VST_MED = rs.getDate(3);
                obj.DAT_EFT_VST_MED = rs.getDate(4);
                obj.TPL_ACR_VLU_RSO = rs.getString(5);
                obj.DPD = rs.getString(6);
                obj.COD_DPD = rs.getLong(7);
                obj.RAG_SCL_AZL = rs.getString(8);
                obj.COD_AZL = rs.getLong(9);
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

    public VisitaMedicaDipendenteView ejbGetVisitaMedicaDipendenteView(long lCOD_DPD, long lCOD_CTL_SAN, long lCOD_VST_MED,Date dtDAT_PIF_VST) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT c.nom_vst_med,a.nom_med_rsp_ctl_san," +
                                                        " b.dat_pif_vst_med ,b.tpl_acr_vlu_rso ," +
                                                        " b.not_vst_med  " +
                                                        " FROM ana_ctl_san_tab a,vst_med_ctl_san_tab b," +
                                                        " ana_vst_med_tab c " +
                                                        " WHERE  a.cod_ctl_san = ? " +
                                                        " AND a.cod_dpd= ? " +
                                                        " AND b.cod_vst_med =? " +
                                                        " AND b.dat_pif_vst_med= ? "+
                                                        " AND a.cod_ctl_san = b.cod_ctl_san " +
                                                        " AND a.cod_dpd = b.cod_dpd " +
                                                        " AND b.cod_vst_med = c.cod_vst_med");
            ps.setLong(1, lCOD_CTL_SAN);
            ps.setLong(2, lCOD_DPD);
            ps.setLong(3, lCOD_VST_MED);
            ps.setDate(4, dtDAT_PIF_VST);
            ResultSet rs = ps.executeQuery();
            VisitaMedicaDipendenteView obj = new VisitaMedicaDipendenteView();
            if (rs.next()) {
                obj.strNOM_VST_MED = rs.getString(1);
                obj.strNOM_MED_RSP_CTL_SAN = rs.getString(2);
                obj.dtDAT_PIF_VST_MED = rs.getDate(3);
                obj.strTPL_ACR_VLU_RSO = rs.getString(4);
                obj.strNOT_VST_MED = rs.getString(5);
            }
            bmp.close();
            return obj;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //////////////////<repositori>/////////////////////////////////////
    public Collection ejbGetGestione_CRM_VST_MED_View(String strNOM, long COD_AZL) {
        String query = "SELECT a.cod_vst_med,a.nom_vst_med, a.des_vst_med FROM ana_vst_med_tab_r a WHERE a.nom_vst_med LIKE ? ";
        String query2 = "SELECT cod_vst_med FROM ana_vst_med_tab WHERE nom_vst_med = ? AND cod_azl= ? ";
        BMPConnection bmp = getConnection();
        BMPConnection bmp2 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(query);
            PreparedStatement ps2 = bmp2.prepareStatement(query2);
            ps.setString(1, strNOM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Gestione_CRM_VST_MED_View v = new Gestione_CRM_VST_MED_View();
                v.lCOD_VST_MED = rs.getLong(1);
                v.strNOM_VST_MED = rs.getString(2);
                v.strDES_VST_MED = rs.getString(3);
                ps2.setString(1, v.strNOM_VST_MED);
                ps2.setLong(2, COD_AZL);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    v.lFLAG = rs2.getLong(1);
                } else {
                    v.lFLAG = 0;
                }
                rs2.close();
                ps2.clearParameters();
                ar.add(v);

            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp2.close();
        }
    }

    public boolean ejbcaricaRpVisMed(long P_COD_AZL, String P_NOM_VST_MED) {
        boolean result = true;
        ResultSet rs = null;

        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++

            long conta;
            long V_COD_VST_MED = NEW_ID();
            long flag_esistenza;

            ps = bmp.prepareStatement(SQLContainer.getCarica_rp_vis_med_cnt());
            ps.setString(1, P_NOM_VST_MED);

            rs = ps.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps.close();
            }
            if (flag_esistenza == 0) {
                ps = bmp.prepareStatement("INSERT INTO ana_vst_med_tab_r ( cod_vst_med, fat_per, per_vst, nom_vst_med, des_vst_med)  SELECT ?, fat_per, per_vst, nom_vst_med, des_vst_med FROM  ana_vst_med_tab WHERE cod_azl = ? AND   nom_vst_med = ?");
                ps.setLong(1, V_COD_VST_MED);
                ps.setLong(2, P_COD_AZL);
                ps.setString(3, P_NOM_VST_MED);
                ps.executeUpdate();
                ps.close();

                ps = bmp.prepareStatement("UPDATE ana_vst_med_tab SET cod_vst_med_rpo=? WHERE nom_vst_med =? AND cod_azl = ?");
                ps.setLong(1, V_COD_VST_MED);
                ps.setString(2, P_NOM_VST_MED);
                ps.setLong(3, P_COD_AZL);
                ps.executeUpdate();
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
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return result;
    }

    public boolean ejbcaricaDbVisMed(long P_COD_AZL, long P_COD_VST_MED) {
        boolean result = true;
        ResultSet rs = null;

        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        PreparedStatement ps1 = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++

            long conta;
            long V_COD_VST_MED = NEW_ID();
            long flag_esistenza;
            ps = bmp.prepareStatement("SELECT COUNT(*) FROM ana_vst_med_tab  WHERE cod_vst_med_rpo = ? AND cod_azl= ?");
            ps.setLong(1, P_COD_VST_MED);
            ps.setLong(2, P_COD_AZL);
            rs = ps.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB ERROR");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps.close();
            }
            if (flag_esistenza == 0) {
                ps1 = bmp.prepareStatement("INSERT INTO ANA_VST_MED_TAB (COD_VST_MED ,FAT_PER, PER_VST, NOM_VST_MED, DES_VST_MED, COD_AZL, COD_VST_MED_RPO) " +
                        "SELECT ?, FAT_PER, PER_VST, NOM_VST_MED, DES_VST_MED, ?, COD_VST_MED " +
                        "FROM ANA_VST_MED_TAB_R WHERE COD_VST_MED = ? ");
                ps1.setLong(1, V_COD_VST_MED);
                ps1.setLong(2, P_COD_AZL);
                ps1.setLong(3, P_COD_VST_MED);
                ps1.executeUpdate();
                ps1.close();
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
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return result;
    }

    //<comment description="extended setters/getters">
    public Collection findEx(long lCOD_AZL,
            String strNOM_VST_MED,
            String strDES_VST_MED,
            Long lPER_VST,
            int iOrderParameter /*not used for now*/) {
        return (new GestioneVisiteMedicheBean()).ejbFindEx(lCOD_AZL,
                strNOM_VST_MED,
                strDES_VST_MED,
                lPER_VST,
                iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL,
            String strNOM_VST_MED,
            String strDES_VST_MED,
            Long lPER_VST,
            int iOrderParameter /*not used for now*/) {
        String strSql = "SELECT cod_vst_med, nom_vst_med, des_vst_med, fat_per, per_vst  FROM ana_vst_med_tab WHERE cod_azl = ?";
        if (strNOM_VST_MED != null) {
            strSql += " AND UPPER(nom_vst_med) LIKE ?";
        }
        if (lPER_VST != null) {
            strSql += " AND per_vst = ?";
        }
        if (strDES_VST_MED != null) {
            strSql += " AND UPPER(des_vst_med) LIKE ?";
        }
        strSql += " ORDER BY UPPER(nom_vst_med)";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            int i = 1;
            ps.setLong(i++, lCOD_AZL);
            if (strNOM_VST_MED != null) {
                ps.setString(i++, strNOM_VST_MED.toUpperCase());
            }
            if (lPER_VST != null) {
                ps.setLong(i++, lPER_VST.longValue());
            }
            if (strDES_VST_MED != null) {
                ps.setString(i++, strDES_VST_MED.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteMediche_All_View obj = new VisiteMediche_All_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DES_VST_MED = rs.getString(3);
                obj.FAT_PER = rs.getString(4);
                obj.PER_VST = rs.getString(5);
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
///////////ATTENTION!!////////////////////////////////////////
}
