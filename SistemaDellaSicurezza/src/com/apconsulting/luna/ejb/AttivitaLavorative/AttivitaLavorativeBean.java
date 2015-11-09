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
package com.apconsulting.luna.ejb.AttivitaLavorative;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class AttivitaLavorativeBean extends BMPEntityBean implements IAttivitaLavorative, IAttivitaLavorativeHome {

    AttivitaLavorativePK primaryKey;
    long COD_MAN;           	//1
    long COD_AZL;           	//2
    String NOM_MAN;         	//3
    //---------------------------
    String DES_MAN;         	//4
    String DES_RSP_COM;     	//5
    long COD_MAN_RPO;       	//6
    double IDX_RSO_CHI;				//7
    long RSO_VAL = 0;	//8
    String NOTE;     	//5
    //---------------------------
    public static final String BEAN_NAME = "AttivitaLavorativeBean";
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static AttivitaLavorativeBean ys = null;
    private AttivitaLavorativeBean_private private_method = null;

    private AttivitaLavorativeBean() {
        this.private_method = new AttivitaLavorativeBean_private();
    }

    public static AttivitaLavorativeBean getInstance() {
        if (ys == null) {
            ys = new AttivitaLavorativeBean();
        }
        return ys;
    }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IAttivitaLavorative create(long lCOD_AZL, String strNOM_MAN, String strDES_MAN, String strDES_RSP_COM, String strNOTE, long lCOD_MAN_RPO, long lRSO_VAL, java.util.ArrayList alAziende) throws CreateException {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        try {
            Object primaryKey_temp = bean.ejbCreate(lCOD_AZL, strNOM_MAN, strDES_MAN, strDES_RSP_COM, strNOTE, lCOD_MAN_RPO, lRSO_VAL, alAziende);
            bean.setEntityContext(new EntityContextWrapper(primaryKey_temp));
            bean.ejbPostCreate(lCOD_AZL, strNOM_MAN, strDES_MAN, strDES_RSP_COM, strNOTE, lCOD_MAN_RPO, alAziende);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        AttivitaLavorativeBean iAttivitaLavorativeBean = new AttivitaLavorativeBean();
        try {
            Object obj = iAttivitaLavorativeBean.ejbFindByPrimaryKey((AttivitaLavorativePK) primaryKey);
            iAttivitaLavorativeBean.setEntityContext(new EntityContextWrapper(obj));
            iAttivitaLavorativeBean.ejbActivate();
            iAttivitaLavorativeBean.ejbLoad();
            iAttivitaLavorativeBean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    //-----------------------------------

    public void remove(Object primaryKey, java.util.ArrayList alAziende) {
        AttivitaLavorativeBean iAttivitaLavorativeBean = new AttivitaLavorativeBean();
        try {
            Object obj = iAttivitaLavorativeBean.ejbFindByPrimaryKey((AttivitaLavorativePK) primaryKey);
            iAttivitaLavorativeBean.setEntityContext(new EntityContextWrapper(obj));
            iAttivitaLavorativeBean.ejbActivate();
            iAttivitaLavorativeBean.ejbLoad();
            iAttivitaLavorativeBean.ejbRemove(alAziende);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    //------------------------------------
    // (Home Intrface) findByPrimaryKey()

    public IAttivitaLavorative findByPrimaryKey(AttivitaLavorativePK primaryKey) throws FinderException {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) findAll()

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) VIEWS  getAttivitaLavorative_Name_View()

    public Collection getAttivitaLavorative_Name_View(long AZL_ID) {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorative_Name_View(AZL_ID);
    }

    public Collection getAttivitaLavorative_Name_View() {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorative_Name_View();
    }

    public Collection getAllAttivitaLavorative_Name_View() {
        return (new AttivitaLavorativeBean()).ejbGetAllAttivitaLavorative_Name_View();
    }

    public Collection getAttivitaLavorative_AZL_Name_View(long AZL_ID, long UNI_ORG_ID) {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorative_AZL_Name_View(AZL_ID, UNI_ORG_ID);
    }

    public Collection getAGGIORNA_MANSIONE_COR_View(String strCOD_RSO, String strCOD_COR, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAGGIORNA_MANSIONE_COR_View(strCOD_RSO, strCOD_COR, lCOD_AZL);
    }

    public Collection getAGGIORNA_MANSIONE_DPI_View(String strCOD_RSO, String strCOD_TPL_DPI, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAGGIORNA_MANSIONE_DPI_View(strCOD_RSO, strCOD_TPL_DPI, lCOD_AZL);
    }

    public Collection getAGGIORNA_MANSIONE_PRO_SAN_View(String strCOD_RSO, String strCOD_PRO_SAN, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAGGIORNA_MANSIONE_PRO_SAN_View(strCOD_RSO, strCOD_PRO_SAN, lCOD_AZL);
    }

    public Collection getAGGIORNA_MANSIONE_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAGGIORNA_MANSIONE_MIS_PET_View(strCOD_RSO, strCOD_MIS_PET, lCOD_AZL);
    }

    public Collection getAGGIORNA_LUOGO_FISICO_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAGGIORNA_LUOGO_FISICO_MIS_PET_View(strCOD_RSO, strCOD_MIS_PET, lCOD_AZL);
    }

    public Collection getCARICA_MANSIONI_View(String strCOD_OPE_SVO, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetCARICA_MANSIONI_View(strCOD_OPE_SVO, lCOD_AZL);
    }

    public Collection getGEST_MAN_LUO_View(String strCOD_RSO, String strCOD, String FuncType, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetGEST_MAN_LUO_View(strCOD_RSO, strCOD, FuncType, lCOD_AZL);
    }

    public Collection getAttivitaLavorative_Name_ViewBySito(long COD_SIT_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorative_Name_ViewBySito(COD_SIT_AZL);
    }
    //

    public Collection getAttivitaLavorativaByDipendente_View(long lCOD_DPD) {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorativaByDipendente_View(lCOD_DPD);
    }
    // -- FORM GEST ATTIVITA --

    public Collection getAttLavListToOperSvolta_View(long lCOD_OPE_SVO, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAttLavListToOperSvolta_View(lCOD_OPE_SVO, lCOD_AZL);
    }

    public long getCountAttivitaLavorativeByCOD_OPE_SVO(long COD_OPE_SVO, long lCOD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetCountAttivitaLavorativeByCOD_OPE_SVO(COD_OPE_SVO, lCOD_AZL);
    }

    public Collection getAttivitaLavorativa_CRM_MAN_View(String strNOM, long COD_AZL) {
        return (new AttivitaLavorativeBean()).ejbGetAttivitaLavorativa_CRM_MAN_View(strNOM, COD_AZL);
    }
    //

    public boolean caricaRpMansioni(long P_COD_AZL, String P_NOM_MAN) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbcaricaRpMansioni(P_COD_AZL, P_NOM_MAN);
    }

    public boolean Carica_db_mansioni(long P_COD_AZL, long P_COD_MAN, java.sql.Date dtDAT) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbCarica_db_mansioni(P_COD_AZL, P_COD_MAN, dtDAT);
    }
    //<alex date="07/04/2004">

    public String addRischioToSostanzeChimiche(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbAddRischioToSostanzeChimiche(lCOD_AZL, lCOD_SOS_CHI, lCOD_RSO, strTPL_CLF_RSO, ID_AZIENDE, ID_MAN, ID_LUO);
    }

    public String addRischioToMacchina(long lCOD_AZL, long lCOD_MAC, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbAddRischioToMacchina(lCOD_AZL, lCOD_MAC, lCOD_RSO, strTPL_CLF_RSO, ID_AZIENDE, ID_MAN, ID_LUO);
    }

    public String addMacchinaToOperazioneSvolta(long lCOD_AZL, long lCOD_MAC, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList ID_MAN) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbAddMacchinaToOperazioneSvolta(lCOD_AZL, lCOD_MAC, lCOD_OPE_SVO, AZIENDA_ID, ID_MAN);
    }

    public String addSostanzaToOperazioneSvolta(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList ID_MAN) {
        AttivitaLavorativeBean bean = new AttivitaLavorativeBean();
        return bean.ejbAddSostanzaToOperazioneSvolta(lCOD_AZL, lCOD_SOS_CHI, lCOD_OPE_SVO, AZIENDA_ID, ID_MAN);
    }
    //</alex>
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IAttivitaLavorativeHome-implementation>
    public AttivitaLavorativePK ejbCreate(
            long lCOD_AZL,
            String strNOM_MAN,
            String strDES_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            long lCOD_MAN_RPO,
            long lRSO_VAL,
            java.util.ArrayList alAziende) {
        long lFirstKey = NEW_ID();
        this.COD_MAN = NEW_ID(); 	// unic ID
        this.COD_AZL = lCOD_AZL;
        this.NOM_MAN = strNOM_MAN;
        this.DES_MAN = strDES_MAN;
        this.DES_RSP_COM = strDES_RSP_COM;
        this.NOTE = strNOTE;
        this.COD_MAN_RPO = lCOD_MAN_RPO;
        this.RSO_VAL = lRSO_VAL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_man_tab (cod_man,cod_azl, nom_man, des_man, des_rsp_com, note, cod_man_rpo, idx_rso_chi, rso_val) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, COD_AZL);
            ps.setString(3, NOM_MAN);
            ps.setString(4, DES_MAN);
            ps.setString(5, DES_RSP_COM);
            ps.setString(6, NOTE);
            ps.setLong(7, COD_MAN_RPO);
            ps.setDouble(8, IDX_RSO_CHI);
            ps.setLong(9, RSO_VAL);
            ps.executeUpdate();
            //
            setExtendedObject(bmp, "ana_man_tab", lFirstKey, COD_MAN, COD_AZL);
            //
            Iterator it = alAziende.iterator();
            while (it.hasNext()) {
                long cod_azl = ((Long) it.next()).longValue();
                if (cod_azl == lCOD_AZL) {
                    continue;
                }
                long lSecondKey = NEW_ID();
                ps.setLong(1, lSecondKey);
                ps.setLong(2, cod_azl);
                ps.executeUpdate();
                setExtendedObject(bmp, "ana_man_tab", lFirstKey, lSecondKey, cod_azl);
            }
            bmp.commitTrans();
            return new AttivitaLavorativePK(this.COD_AZL, this.COD_MAN);
        } catch (Exception ex) {
            ex.printStackTrace();
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------   
    public void ejbPostCreate(long lCOD_AZL, String strNOM_MAN, String strDES_MAN, String strDES_RSP_COM, String strNOTE, long lCOD_MAN_RPO, java.util.ArrayList alAziende) {
    }
//--------------------------------------------------

    public boolean isMultiple() {
        return isExtendedObject("ana_man_tab", COD_MAN);
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_man FROM ana_man_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-----------------------------------------------------------
    public AttivitaLavorativePK ejbFindByPrimaryKey(AttivitaLavorativePK primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        //this.COD_MAN=((Long)this.getEntityKey()).longValue();
        this.primaryKey = ((AttivitaLavorativePK) this.getEntityKey());
        this.COD_MAN = primaryKey.lCOD_MAN;
        this.COD_AZL = primaryKey.lCOD_AZL;
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_MAN = -1;
        this.primaryKey = null;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_man_tab  WHERE cod_man=?");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_AZL = rs.getLong("COD_AZL");
                this.NOM_MAN = rs.getString("NOM_MAN");
                this.DES_MAN = rs.getString("DES_MAN");
                this.DES_RSP_COM = rs.getString("DES_RSP_COM");
                this.NOTE = rs.getString("NOTE");
                this.COD_MAN_RPO = rs.getLong("COD_MAN_RPO");
                this.IDX_RSO_CHI = rs.getDouble("IDX_RSO_CHI");
                this.RSO_VAL = rs.getLong("RSO_VAL");
            } else {
                throw new NoSuchEntityException("AttivitaLavorative con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        ejbRemove(null);
    }
    //----

    public void ejbRemove(java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_man_tab WHERE ( cod_man=? OR cod_man IN (" + getExtendedObjects("ana_man_tab", alAziende) + ")) AND (cod_azl=? OR cod_azl IN (" + toString(alAziende) + ") )");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, COD_MAN);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivitaLavorative con ID= non è trovata");
            }
            removeExtendedObject(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);
            bmp.commitTrans();
        } catch (Exception ex) {
            ex.printStackTrace();
            bmp.rollbackTrans();
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
        store(NOM_MAN, DES_MAN, DES_RSP_COM, NOTE, COD_MAN_RPO, RSO_VAL, null);
    }
    //

    public void store(String strNOM_MAN, String strDES_MAN, String strDES_RSP_COM, String strNOTE, long lCOD_MAN_RPO, long lRSO_VAL, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE ana_man_tab  SET nom_man=?,  des_man=?, des_rsp_com=?, note=?, cod_man_rpo=?, rso_val=? WHERE ( cod_man=? OR cod_man IN (" + getExtendedObjects("ana_man_tab", alAziende) + ")) AND (cod_azl=? OR cod_azl IN  (" + toString(alAziende) + "))");
            ps.setString(1, strNOM_MAN);
            ps.setString(2, strDES_MAN);
            ps.setString(3, strDES_RSP_COM);
            ps.setString(4, strNOTE);
            ps.setLong(5, lCOD_MAN_RPO);
            ps.setLong(6, lRSO_VAL);
            ps.setLong(7, COD_MAN);
            ps.setLong(8, COD_MAN);
            ps.setLong(9, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivitaLavorative con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
    public long getCOD_MAN() {
        return COD_MAN;
    }
    //2

    public long getCOD_AZL() {
        return COD_AZL;
    }
    //3

    public String getNOM_MAN() {
        if (NOM_MAN == null) {
            return "";
        }
        return NOM_MAN;
    }

    public void setCOD_AZL__NOM_MAN(long newCOD_AZL, String newNOM_MAN) {
        if ((COD_AZL == newCOD_AZL) && (NOM_MAN.equals(newNOM_MAN))) {
            return;
        }
        COD_AZL = newCOD_AZL;
        NOM_MAN = newNOM_MAN;
        setModified();
    }
//============================================
    // not required field
    //4

    public void setDES_MAN(String newDES_MAN) {
        if (DES_MAN != null) {
            if (DES_MAN.equals(newDES_MAN)) {
                return;
            }
        }
        DES_MAN = newDES_MAN;
        setModified();
    }

    public String getDES_MAN() {
        if (DES_MAN == null) {
            return "";
        }
        return DES_MAN;
    }
    //5

    public void setDES_RSP_COM(String newDES_RSP_COM) {
        if (DES_RSP_COM != null) {
            if (DES_RSP_COM.equals(newDES_RSP_COM)) {
                return;
            }
        }
        DES_RSP_COM = newDES_RSP_COM;
        setModified();
    }

    public String getDES_RSP_COM() {
        if (DES_RSP_COM == null) {
            return "";
        }
        return DES_RSP_COM;
    }
    //6

    public void setCOD_MAN_RPO(long newCOD_MAN_RPO) {
        if (COD_MAN_RPO == newCOD_MAN_RPO) {
            return;
        }
        COD_MAN_RPO = newCOD_MAN_RPO;
        setModified();
    }

    //5

    public void setNOTE(String newNOTE) {
        if (NOTE != null) {
            if (NOTE.equals(newNOTE)) {
                return;
            }
        }
        NOTE = newNOTE;
        setModified();
    }

    public String getNOTE() {
        if (NOTE == null) {
            return "";
        }
        return NOTE;
    }

    public long getCOD_MAN_RPO() {
        return COD_MAN_RPO;
    }

    public void setIDX_RSO_CHI(double newIDX_RSO_CHI) {
        if (IDX_RSO_CHI == newIDX_RSO_CHI) {
            return;
        }
        IDX_RSO_CHI = newIDX_RSO_CHI;
        setModified();
    }

    public double getIDX_RSO_CHI() {
        return IDX_RSO_CHI;
    }

    public long getRSO_VAL() {
        return this.RSO_VAL;
    }

    public void setRSO_VAL(long newRSO_VAL) {
        if (RSO_VAL == newRSO_VAL) {
            return;
        }
        this.RSO_VAL = newRSO_VAL;
    }

    public String getDescRischio(double idx) {
        String sRes = "";
        if (idx < 0.1) {
            sRes = "Rischio Nullo";
        }
        if (idx >= 0.1 && idx < 15) {
            sRes = "Rischio Moderato";
        }
        if (idx >= 15 && idx < 21) {
            sRes = "Intervallo di incertezza";
        }
        if (idx >= 21 && idx <= 40) {
            sRes = "Rischio Superiore al Moderato";
        }
        if (idx > 40 && idx <= 80) {
            sRes = "Zona di rischio elevato";
        }
        if (idx > 80) {
            sRes = "Zona di grave rischio";
        }

        return sRes;
    }
    //</comment>

    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetAttivitaLavorative_Name_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_man,nom_man FROM ana_man_tab order by nom_man  ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetAttivitaLavorative_Name_View(long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_man,nom_man FROM ana_man_tab WHERE  cod_azl= ? ORDER BY nom_man ");
            ps.setLong(1, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbAllGetAttivitaLavorative_Name_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_man,nom_man FROM ana_man_tab order by nom_man ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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
    //---

    public Collection ejbGetAttivitaLavorative_AZL_Name_View(long AZL_ID, long UNI_ORG_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_man,a.nom_man FROM ana_man_tab a, man_uni_org_tab b "
                    + " WHERE a.cod_man=b.cod_man AND a.cod_azl=? AND b.cod_uni_org=? "
                    + "order by nom_man ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, UNI_ORG_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_AZL_Name_View obj = new AttivitaLavorative_AZL_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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
    //---

    public Collection getRischiByAttivataLavorativaView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select a.cod_rso, a.nom_rso, b.cod_rso_man,  b.stm_num_rso, d.nom_man from ana_rso_tab a, rso_man_tab b, ana_man_tab d where a.cod_rso = b.cod_rso and a.cod_azl = b.cod_azl and b.cod_man = d.cod_man and d.cod_man = ? and a.cod_azl = ? order by  a.nom_rso");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischiByAttivataLavorativaView obj = new RischiByAttivataLavorativaView();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.lCOD_RSO_MAN = rs.getLong(3);
                obj.strSTM_NUM_RSO = rs.getString(4);
                obj.strNOM_MAN = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //-------------------
    //</comment>         

    public Collection ejbGetAGGIORNA_MANSIONE_COR_View(String strCOD_RSO, String strCOD_COR, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_man,a.nom_man FROM ana_man_tab a,rso_man_tab b WHERE a.cod_man=b.cod_man AND b.cod_rso=? and b.cod_azl=? AND a.cod_man NOT IN (SELECT c.cod_man FROM ana_man_tab c,cor_man_tab d WHERE  c.cod_man=d.cod_man AND d.cod_cor=?) ");
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strCOD_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AGGIORNA_MANSIONE_View obj = new AGGIORNA_MANSIONE_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetAGGIORNA_MANSIONE_DPI_View(String strCOD_RSO, String strCOD_TPL_DPI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_man,a.nom_man FROM ana_man_tab a,rso_man_tab b WHERE a.cod_man=b.cod_man AND b.cod_rso=? and a.cod_azl=? AND a.cod_man NOT IN (SELECT c.cod_man FROM ana_man_tab c,dpi_man_tab d WHERE c.cod_man=d.cod_man AND d.cod_tpl_dpi=? ) ");
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strCOD_TPL_DPI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AGGIORNA_MANSIONE_View obj = new AGGIORNA_MANSIONE_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetAGGIORNA_MANSIONE_PRO_SAN_View(String strCOD_RSO, String strCOD_PRO_SAN, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_man,a.nom_man FROM ana_man_tab a,rso_man_tab b WHERE a.cod_man=b.cod_man AND b.cod_rso=? and a.cod_azl=? AND a.cod_man NOT IN (SELECT c.cod_man FROM ana_man_tab c,pro_san_man_tab d WHERE c.cod_man=d.cod_man AND d.cod_pro_san=? ) ");
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strCOD_PRO_SAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AGGIORNA_MANSIONE_View obj = new AGGIORNA_MANSIONE_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetAGGIORNA_MANSIONE_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL) {

        /* Seleziono tutte le attività lavorative che hanno associato uno specifico rischio 
        ma che non hanno ancora associata una specifica misura di prevenzione e protezione */

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    // Seleziono tutte le attività lavorative...
                    "SELECT a.cod_man, a.nom_man " +
                      "FROM ana_man_tab a, rso_man_tab b " +
                     // che hanno associato uno specifico rischio...
                     "WHERE     a.cod_man = b.cod_man " +
                           "AND a.cod_azl = b.cod_azl " +
                           "AND b.cod_rso = ? " +
                           "AND a.cod_azl = ? " +
                           // tranne...
                           "AND a.cod_man NOT IN " + // Seleziona tutte le attività lavorative (in maniera distinta)...
                                  "(SELECT DISTINCT c.cod_man " +
                                     "FROM rso_man_tab c, mis_pet_man_tab d " +
                                    "WHERE     c.cod_rso_man = d.cod_rso_man " +
                                          "AND c.cod_man = d.cod_man " +
                                          "AND d.cod_mis_pet = ? " + // che hanno associata una specifica misura di prevenzione e protezione...
                                          "AND c.cod_rso = ? " + // attraverso uno specifico rischio, di una specifica azienda.
                                          "AND c.cod_azl = ?)");                    
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strCOD_MIS_PET);
            ps.setString(4, strCOD_RSO);
            ps.setLong(5, lCOD_AZL);            
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AGGIORNA_MANSIONE_View obj = new AGGIORNA_MANSIONE_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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
    
    public Collection ejbGetAGGIORNA_LUOGO_FISICO_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL) {

        /* Seleziono tutti i luoghi fisici che hanno associato uno specifico rischio 
        ma che non hanno ancora associata una specifica misura di prevenzione e protezione */

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    // Seleziono tutti i luoghi fisici...
                    "SELECT a.cod_luo_fsc, a.nom_luo_fsc " +
                      "FROM ana_luo_fsc_tab a, rso_luo_fsc_tab b " +
                     // che hanno associato uno specifico rischio...
                     "WHERE     a.cod_luo_fsc = b.cod_luo_fsc " +
                           "AND a.cod_azl = b.cod_azl " +
                           "AND b.cod_rso = ? " +
                           "AND a.cod_azl = ? " +
                           // tranne...
                           "AND a.cod_luo_fsc NOT IN " + // Seleziona tutti i luoghi fisici (in maniera distinta)...
                                  "(SELECT DISTINCT c.cod_luo_fsc " +
                                     "FROM rso_luo_fsc_tab c, mis_pet_luo_fsc_tab d " +
                                    "WHERE     c.cod_rso_luo_fsc = d.cod_rso_luo_fsc " +
                                          "AND c.cod_luo_fsc = d.cod_luo_fsc " +
                                          "AND d.cod_mis_pet = ? " + // che hanno associata una specifica misura di prevenzione e protezione...
                                          "AND c.cod_rso = ? " + // attraverso uno specifico rischio, di una specifica azienda.
                                          "AND c.cod_azl = ?) ");                    
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strCOD_MIS_PET);
            ps.setString(4, strCOD_RSO);
            ps.setLong(5, lCOD_AZL);            
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GEST_MAN_LUO_View obj = new GEST_MAN_LUO_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetCARICA_MANSIONI_View(String strCOD_OPE_SVO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_man,a.nom_man FROM ana_man_tab a,ope_svo_man_tab b WHERE a.cod_man=b.cod_man AND b.cod_ope_svo=? and a.cod_azl=?");
            ps.setString(1, strCOD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AGGIORNA_MANSIONE_View obj = new AGGIORNA_MANSIONE_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetGEST_MAN_LUO_View(String strCOD_RSO, String strCOD, String FuncType, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String inselect = "AND a.cod_luo_fsc NOT IN (SELECT c.cod_luo_fsc FROM ana_luo_fsc_tab c,";
            if (FuncType.equals("cor")) {
                inselect += "cor_luo_fsc_tab d WHERE c.cod_luo_fsc=d.cod_luo_fsc AND d.cod_cor=" + strCOD + ")";
            } else if (FuncType.equals("dpi")) {
                inselect += "dpi_luo_fsc_tab d WHERE c.cod_luo_fsc=d.cod_luo_fsc AND d.cod_tpl_dpi=" + strCOD + ")";
            } else if (FuncType.equals("pro_san")) {
                inselect += "pro_san_luo_fsc_tab d WHERE c.cod_luo_fsc=d.cod_luo_fsc AND d.cod_pro_san=" + strCOD + ")";
            } else {
                inselect = "";
            }
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_luo_fsc, "
                        + "a.nom_luo_fsc "
                    + "FROM "
                        + "ana_luo_fsc_tab a, "
                        + "rso_luo_fsc_tab b "
                    + "WHERE "
                        + "a.cod_luo_fsc = b.cod_luo_fsc "
                        + "AND b.cod_rso=? "
                        + "and a.cod_azl=? " + inselect);
            ps.setString(1, strCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (!FuncType.equals("")) {
                while (rs.next()) {
                    GEST_MAN_LUO_View obj = new GEST_MAN_LUO_View();
                    obj.COD_LUO_FSC = rs.getLong(1);
                    obj.NOM_LUO_FSC = rs.getString(2);
                    al.add(obj);
                }
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

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //------------------*********ADD/REMOVE Block for GEST_MAN_Set.jsp*********----
    //------------------***COR_BLOCK***----
    public void addGEST_MAN_COR(long lCOD_COR, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cor_man_tab (cod_cor,cod_man,prs_cor,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //------------------***DPI_BLOCK***----

    public void addGEST_MAN_DPI(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO dpi_man_tab (cod_tpl_dpi,cod_man,prs_dpi,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_TPL_DPI);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //------------------***PRO_SAN_BLOCK***----

    public void addGEST_MAN_PRO_SAN(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO pro_san_man_tab (cod_pro_san,cod_man,prs_pro_san,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_PRO_SAN);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //------------------***OPE_SVO_BLOCK***----

    public void addGEST_MAN_OPE_SVO(long lCOD_OPE_SVO, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ope_svo_man_tab (cod_ope_svo,cod_man) VALUES(?,?)");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, COD_MAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* Metodi per la gestione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * INIZIO
     */
    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "CORSI / ATTIVITA' LAVORATIVA"
    public void addCOR_MAN_Ex(long lCOD_COR, java.sql.Date dDAT_INZ, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // Inserisco l'associazione corso/attività lavorativa corrente.
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO cor_man_tab "
                    + "(cod_cor, cod_man, prs_cor, dat_inz) "
                    + "VALUES "
                    + "(?,?,'S',?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Inserisco l'associazione corso/attività lavorativa
            // per le altre aziende
            while (attivitaPropagate.next()) {
                ps.setLong(2, attivitaPropagate.getLong(2));
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "PROTOCOLLI SANITARI / ATTIVITA' LAVORATIVA"
    public void addPRO_SAN_MAN_Ex(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // Inserisco l'associazione protocollo sanitario/attività lavorativa corrente.
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO pro_san_man_tab "
                    + "(cod_pro_san, cod_man, prs_pro_san, dat_inz) "
                    + "VALUES "
                    + "(?,?,'S',?)");
            ps.setLong(1, lCOD_PRO_SAN);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Determino la eventuale propagazione del protocollo sanitario
            // alle altre aziende.
            ResultSet protocolliPropagati = getExtendedObjectsEx2(bmp, "ana_pro_san_tab", lCOD_PRO_SAN, COD_AZL, alAziende);

            // Trasformo i resultset in liste indicizzate.
            HashMap attivitaPropagateHM = new HashMap();
            HashMap protocolliPropagatiHM = new HashMap();
            while (attivitaPropagate.next()) {
                attivitaPropagateHM.put(attivitaPropagate.getLong(1), attivitaPropagate.getLong(2));
            }
            while (protocolliPropagati.next()) {
                protocolliPropagatiHM.put(protocolliPropagati.getLong(1), protocolliPropagati.getLong(2));
            }

            // Eseguo il merge tra i due array
            ArrayList<AttLavProSanManEX_View> attivitaProtocolli =
                    new ArrayList<AttLavProSanManEX_View>();

            for (Object codAzl_Attivita : attivitaPropagateHM.keySet()) {
                if (protocolliPropagatiHM.get(codAzl_Attivita) != null) {
                    AttLavProSanManEX_View row = new AttLavProSanManEX_View();
                    row.COD_AZL = (Long) codAzl_Attivita;
                    row.COD_MAN = (Long) attivitaPropagateHM.get(codAzl_Attivita);
                    row.COD_PRO_SAN = (Long) protocolliPropagatiHM.get(codAzl_Attivita);
                    attivitaProtocolli.add(row);
                }
            }

            // Inserisco l'associazione protocollo sanitario/attività lavorativa
            // per le altre aziende.
            for (AttLavProSanManEX_View row : attivitaProtocolli) {
                ps.setLong(1, row.COD_PRO_SAN);
                ps.setLong(2, row.COD_MAN);
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "DPI / ATTIVITA' LAVORATIVA"
    public void addDPI_MAN_Ex(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // Inserisco l'associazione dpi/attività lavorativa corrente.
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO dpi_man_tab "
                    + "(cod_tpl_dpi, cod_man, prs_dpi, dat_inz) "
                    + "VALUES "
                    + "(?,?,'S',?)");
            ps.setLong(1, lCOD_TPL_DPI);
            ps.setLong(2, COD_MAN);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Inserisco l'associazione dpi/attività lavorativa
            // per le altre aziende
            while (attivitaPropagate.next()) {
                ps.setLong(2, attivitaPropagate.getLong(2));
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* Metodi per la gestione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * FINE
     */

    /* Metodi per la cancellazione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * INIZIO
     */
    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "CORSI / ATTIVITA' LAVORATIVA"
    public void deleteCOR_MAN_Ex(long lCOD_COR, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM cor_man_tab WHERE (cod_cor=? AND  cod_man=?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, this.COD_MAN);

            // Cancello l'associazione corso/attività lavorativa corrente.
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Cancello l'associazione corso/attività lavorativa per le altre aziende
            while (attivitaPropagate.next()) {
                ps.setLong(2, attivitaPropagate.getLong(2));
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "PROTOCOLLI SANITARI / ATTIVITA' LAVORATIVA"
    public void deletePRO_SAN_MAN_Ex(long lCOD_PRO_SAN, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // Inserisco l'associazione protocollo sanitario/attività lavorativa corrente.
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM pro_san_man_tab WHERE (cod_pro_san=? AND  cod_man=?)");
            ps.setLong(1, lCOD_PRO_SAN);
            ps.setLong(2, COD_MAN);
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Determino la eventuale propagazione del protocollo sanitario
            // alle altre aziende.
            ResultSet protocolliPropagati = getExtendedObjectsEx2(bmp, "ana_pro_san_tab", lCOD_PRO_SAN, COD_AZL, alAziende);

            // Trasformo i resultset in liste indicizzate.
            HashMap attivitaPropagateHM = new HashMap();
            HashMap protocolliPropagatiHM = new HashMap();
            while (attivitaPropagate.next()) {
                attivitaPropagateHM.put(attivitaPropagate.getLong(1), attivitaPropagate.getLong(2));
            }
            while (protocolliPropagati.next()) {
                protocolliPropagatiHM.put(protocolliPropagati.getLong(1), protocolliPropagati.getLong(2));
            }

            // Eseguo il merge tra i due array
            ArrayList<AttLavProSanManEX_View> attivitaProtocolli =
                    new ArrayList<AttLavProSanManEX_View>();

            for (Object codAzl_Attivita : attivitaPropagateHM.keySet()) {
                if (protocolliPropagatiHM.get(codAzl_Attivita) != null) {
                    AttLavProSanManEX_View row = new AttLavProSanManEX_View();
                    row.COD_AZL = (Long) codAzl_Attivita;
                    row.COD_MAN = (Long) attivitaPropagateHM.get(codAzl_Attivita);
                    row.COD_PRO_SAN = (Long) protocolliPropagatiHM.get(codAzl_Attivita);
                    attivitaProtocolli.add(row);
                }
            }

            // Elimino l'associazione protocollo sanitario/attività lavorativa
            // per le altre aziende.
            for (AttLavProSanManEX_View row : attivitaProtocolli) {
                ps.setLong(1, row.COD_PRO_SAN);
                ps.setLong(2, row.COD_MAN);
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "DPI / ATTIVITA' LAVORATIVA"
    public void deleteDPI_MAN_Ex(long lCOD_TPL_DPI, ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM dpi_man_tab WHERE (cod_tpl_dpi=? AND  cod_man=?)");
            ps.setLong(1, lCOD_TPL_DPI);
            ps.setLong(2, this.COD_MAN);

            // Cancello l'associazione dpi/attività lavorativa corrente.
            ps.executeUpdate();

            // Determino la eventuale propagazione dell'attività lavorativa
            // alle altre aziende.
            ResultSet attivitaPropagate = getExtendedObjectsEx2(bmp, "ana_man_tab", COD_MAN, COD_AZL, alAziende);

            // Cancello l'associazione dpi/attività lavorativa per le altre aziende
            while (attivitaPropagate.next()) {
                ps.setLong(2, attivitaPropagate.getLong(2));
                ps.executeUpdate();
            }
            bmp.commitTrans();

        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* Metodi per la cancellazione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * FINE
     */
    public Collection ejbGetAttivitaLavorative_Name_ViewBySito(long COD_SIT_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    " SELECT a.COD_LUO_FSC, "
                    + " a.NOM_LUO_FSC "
                    + " FROM ANA_LUO_FSC_TAB a "
                    + " WHERE    "
                    + " EXISTS (SELECT 1 FROM rso_luo_fsc_tab b  WHERE  b.cod_luo_fsc = a.cod_luo_fsc) "
                    + " AND a.COD_SIT_AZL=? "
                    + " ORDER BY 2");
            ps.setLong(1, COD_SIT_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getVisteMediche_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "c.nom_vst_ido as nom_vst, "
                    + "c.per_vst, "
                    + "c.fat_per "
                    + "FROM "
                    + "pro_san_man_tab a, "
                    + "vst_ido_pro_san_tab b, "
                    + "ana_vst_ido_tab c "
                    + "WHERE "
                    + "a.cod_pro_san = b.cod_pro_san "
                    + "AND a.prs_pro_san = 'S' "
                    + "AND b.cod_vst_ido = c.cod_vst_ido "
                    + "AND cod_man = ? "
                    + "UNION "
                    + "SELECT "
                    + "c.nom_vst_med as nom_vst, "
                    + "c.per_vst, "
                    + "c.fat_per "
                    + "FROM "
                    + "pro_san_man_tab a, "
                    + "vst_med_pro_san_tab b, "
                    + "ana_vst_med_tab c "
                    + "WHERE "
                    + "a.cod_pro_san = b.cod_pro_san "
                    + "and a.prs_pro_san = 'S' "
                    + "AND b.cod_vst_med = c.cod_vst_med "
                    + "AND cod_man = ? "
                    + "ORDER BY "
                    + "nom_vst");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_VisteMediche_View obj = new AttLav_VisteMediche_View();
                obj.NOM_VST_IDO = rs.getString(1);
                obj.PER_VSTL = rs.getLong(2);
                obj.FAT_PER = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    public Collection getOperazioniSvolte_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "op.cod_ope_svo, "
                    + "op.nom_ope_svo, "
                    + "op.des_ope_svo "
                    + "FROM "
                    + "ana_ope_svo_tab op, ope_svo_man_tab op_man "
                    + "WHERE "
                    + "op.cod_ope_svo = op_man.cod_ope_svo "
                    + "AND op_man.cod_man= ? "
                    + "ORDER BY "
                    + "op.nom_ope_svo");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_OperazioniSvolte_View obj = new AttLav_OperazioniSvolte_View();
                obj.COD_OPE_SVO = rs.getLong(1);
                obj.NOM_OPE_SVO = rs.getString(2);
                obj.DES_OPE_SVO = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getRischi_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "ana_fat_rso_tab.nom_fat_rso, "
                    + "ana_rso_tab.nom_rso, "
                    + "ana_man_tab.cod_man, "
                    + "rso_man_tab.cod_rso, "
                    + "rso_man_tab.cod_rso_man "
                    + "FROM ana_man_tab, rso_man_tab, ana_rso_tab, ana_fat_rso_tab "
                    + "WHERE "
                    + "ana_man_tab.cod_man = rso_man_tab.cod_man "
                    + "AND rso_man_tab.cod_rso = ana_rso_tab.cod_rso "
                    + "AND rso_man_tab.cod_azl = ana_rso_tab.cod_azl "
                    + "AND ana_rso_tab.cod_fat_rso = ana_fat_rso_tab.cod_fat_rso "
                    + "AND ana_man_tab.cod_man=? and rso_man_tab.cod_azl=?");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_Rischi_View obj = new AttLav_Rischi_View();
                obj.COD_RSO = rs.getLong(4);
                obj.NOM_RSO = rs.getString(2);
                obj.NOM_FAT_RSO = rs.getString(1);
                obj.COD_RSO_MAN = rs.getLong(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getCorsi_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "A.cod_cor, "
                    + "B.nom_cor, "
                    + "C.nom_tpl_cor "
                    + "FROM "
                    + "cor_man_tab A, "
                    + "ana_cor_tab B, "
                    + "tpl_cor_tab C "
                    + "WHERE "
                    + "A.cod_cor = B.cod_cor "
                    + "AND B.cod_tpl_cor = C.cod_tpl_cor "
                    + "AND A.cod_man=? "
                    + "ORDER BY "
                    + "B.nom_cor");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_Corsi_View obj = new AttLav_Corsi_View();
                obj.COD_COR = rs.getLong(1);
                obj.NOM_COR = rs.getString(2);
                obj.NOM_TPL_COR = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getProtocoliSanitari_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "pro_san_man_tab.cod_pro_san, "
                    + "ana_pro_san_tab.nom_pro_san "
                    + "FROM pro_san_man_tab, ana_pro_san_tab "
                    + "WHERE "
                    + "pro_san_man_tab.cod_pro_san = ana_pro_san_tab.cod_pro_san "
                    + "AND pro_san_man_tab.cod_man=?");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_ProtocoliSanitari_View obj = new AttLav_ProtocoliSanitari_View();
                obj.COD_PRO_SAN = rs.getLong(1);
                obj.NOM_PRO_SAN = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getDPI_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "dpi_man_tab.cod_tpl_dpi, "
                    + "tpl_dpi_tab.nom_tpl_dpi "
                    + "FROM dpi_man_tab, tpl_dpi_tab "
                    + "WHERE "
                    + "dpi_man_tab.cod_tpl_dpi = tpl_dpi_tab.cod_tpl_dpi "
                    + "AND dpi_man_tab.cod_man= ? ");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_DPI_View obj = new AttLav_DPI_View();
                obj.COD_TPL_DPI = rs.getLong(1);
                obj.NOM_TPL_DPI = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getDPI_ViewEx() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "A.cod_tpl_dpi, "
                    + "B.nom_tpl_dpi, "
                    + "B.des_car_dpi "
                    + "FROM "
                    + "dpi_man_tab A, "
                    + "tpl_dpi_tab B "
                    + "WHERE "
                    + "A.cod_tpl_dpi = B.cod_tpl_dpi "
                    + "AND A.cod_man=? "
                    + "ORDER BY "
                    + "B.nom_tpl_dpi");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_DPI_ViewEx obj = new AttLav_DPI_ViewEx();
                obj.COD_TPL_DPI = rs.getLong(1);
                obj.NOM_TPL_DPI = rs.getString(2);
                obj.DES_CAR_DPI = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //----

    public Collection getMisurePreventiveView(long lCOD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "C.cod_mis_pet, "
                    + "C.nom_mis_pet, "
                    + "C.des_mis_pet, "
                    + "C.IST_OPE_COR "
                    + "FROM "
                    + "rso_man_tab A, "
                    + "mis_pet_man_tab B, "
                    + "ana_mis_pet_tab C "
                    + "WHERE "
                    + "A.cod_rso_man = B.cod_rso_man "
                    + "AND B.cod_mis_pet = C.cod_mis_pet "
                    + "AND A.cod_rso = ? "
                    + "AND A.cod_man = ? "
                    + "ORDER BY "
                    + "C.nom_mis_pet");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, COD_MAN);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportAttLav_MisurePreventive_View obj = new ReportAttLav_MisurePreventive_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
                obj.DES_MIS_PET = rs.getString(3);
                obj.IST_OPE_COR = rs.getString(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

    //----
    public Collection getReportDocumenti_View() {
        BMPConnection bmp = getConnection();
        try {
            if (!ApplicationConfigurator.isModuleEnabled(MODULES.ATT_LAV_DOC)) {
                PreparedStatement ps = bmp.prepareStatement(
                        /*
                         * Estrae la lista dei documenti da stampare nella scheda di
                         * attività lavorativa, da tre punti diversi, nel dettaglio:
                         */
                        // DOCUMENTI LEGATI AI RISCHI, LEGATI ALL'ATTIVITA'
                        "SELECT "
                        + "a.tit_doc, "
                        + "a.cod_doc "
                        + "FROM "
                        + "ana_doc_tab a, "
                        + "doc_rso_tab b, "
                        + "rso_man_tab c "
                        + "WHERE "
                        + "a.cod_doc = b.cod_doc "
                        + "and c.prs_rso = 'S' "
                        + "and c.cod_rso = b.cod_rso "
                        + "and c.cod_man = ? "
                        + // DOCUMENTI LEGATI ALLE OPERAZIONI SVOLTE, LEGATE ALL'ATTIVITA'
                        "UNION "
                        + "SELECT "
                        + "a.tit_doc,  "
                        + "a.cod_doc "
                        + "FROM "
                        + "ana_doc_tab a, "
                        + "ope_svo_man_tab b, "
                        + "doc_ope_svo_tab c "
                        + "WHERE "
                        + "a.cod_doc = c.cod_doc "
                        + "AND b.cod_ope_svo = c.cod_ope_svo "
                        + "AND b.cod_man = ? "
                        + // DOCUMENTI LEGATI ALLE MISURE DI PREVENZIONE,
                        // LEGATE AI RISCHI, LEGATI ALL'ATTIVITA'
                        "UNION "
                        + "SELECT "
                        + "a.tit_doc, "
                        + "a.cod_doc "
                        + "FROM "
                        + "ana_doc_tab a, "
                        + "doc_mis_pet_tab b, "
                        + "rso_mis_pet_tab c, "
                        + "rso_man_tab d "
                        + "WHERE "
                        + "a.cod_doc = b.cod_doc "
                        + "and c.cod_mis_pet = b.cod_mis_pet "
                        + "and d.cod_man = ? "
                        + "and c.cod_rso = d.cod_rso "
                        + "ORDER BY "
                        + "tit_doc");
                ps.setLong(1, COD_MAN);
                ps.setLong(2, COD_MAN);
                ps.setLong(3, COD_MAN);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ReportAttLav_Documenti_View obj = new ReportAttLav_Documenti_View();
                    obj.COD_DOC = rs.getLong(2);
                    obj.TIT_DOC = rs.getString(1);
                    al.add(obj);
                }
                return al;
            } else {
                PreparedStatement ps = bmp.prepareStatement(
                        /*
                         * Estrae la lista dei documenti da stampare nella scheda di
                         * attività lavorativa.
                         */
                        "SELECT "
                        + "a.cod_doc, "
                        + "b.tit_doc "
                        + "FROM "
                        + "doc_man_tab a, "
                        + "ana_doc_tab b "
                        + "WHERE "
                        + "a.cod_doc = b.cod_doc "
                        + "and a.cod_azl = b.cod_azl "
                        + "and a.cod_man = ? "
                        + "and a.cod_azl = ? "
                        + "ORDER BY "
                        + "b.tit_doc");
                ps.setLong(1, COD_MAN);
                ps.setLong(2, COD_AZL);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList al = new java.util.ArrayList();
                while (rs.next()) {
                    ReportAttLav_Documenti_View obj = new ReportAttLav_Documenti_View();
                    obj.COD_DOC = rs.getLong(1);
                    obj.TIT_DOC = rs.getString(2);
                    al.add(obj);
                }
                return al;
            }
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

    public Collection getRischioChimico_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                    + "ope.cod_ope_svo, "
                    + "ope.nom_ope_svo, "
                    + "sos.cod_sos_chi, "
                    + "sos.nom_com_sos, "
                    + "sos.des_sos, "
                    + "(Select "
                    + "r.idx_rso_chi "
                    + "from "
                    + "rso_chi_tab r "
                    + "where "
                    + "man.cod_man = r.cod_man "
                    + "and man.cod_ope_svo = r.cod_ope_svo "
                    + "and sos.cod_sos_chi = r.cod_sos_chi) as idx "
                    + "from "
                    + "ope_svo_man_tab man, "
                    + "ana_ope_svo_tab ope, "
                    + "sos_chi_ope_svo_tab opesos, "
                    + "ana_sos_chi_tab sos "
                    + "where "
                    + "man.cod_ope_svo = ope.cod_ope_svo "
                    + "and opesos.cod_ope_svo = ope.cod_ope_svo "
                    + "and opesos.cod_sos_chi = sos.cod_sos_chi "
                    + "and man.cod_man = ?");
            ps.setLong(1, COD_MAN);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_RischioChimico_View obj = new AttLav_RischioChimico_View();

                obj.COD_OPE_SVO = rs.getLong(1);
                obj.NOM_OPE_SVO = rs.getString(2);
                obj.COD_SOS_CHI = rs.getLong(3);
                obj.NOM_COM_SOS = rs.getString(4);
                obj.DES_SOS = rs.getString(5);
                obj.IDX_RSO_CHI = rs.getDouble(6);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace(System.err);
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

    public Collection getDocumenti_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                    + "doc.cod_doc, "
                    + "doc.tit_doc, "
                    + "doc.rsp_doc, "
                    + "doc.dat_rev_doc "
                    + "from "
                    + "doc_man_tab doc_man, "
                    + "ana_doc_tab doc "
                    + "where "
                    + "doc_man.cod_doc = doc.cod_doc "
                    + "and doc_man.cod_azl = doc.cod_azl "
                    + "and doc_man.cod_man = ?"
                    + "and doc_man.cod_azl = ?");
            ps.setLong(1, COD_MAN);
            ps.setLong(2, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_Documenti_View obj = new AttLav_Documenti_View();
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

    public Collection getMacchina_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT m.cod_mac, "
                    + "m.ide_mac, "
                    + "m.des_mac "
                    + "FROM mac_man_tab mm, ana_mac_tab m "
                    + "WHERE mm.cod_mac=m.cod_mac "
                    + "AND mm.cod_man=? "
                    + "ORDER BY m.ide_mac, m.des_mac ");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchinaByAttivitaLavorative_View obj = new MacchinaByAttivitaLavorative_View();
                obj.COD_MAC = rs.getLong(1);
                obj.IDE_MAC = rs.getString(2);
                obj.DES_MAC = rs.getString(3);
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

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    public void addOperazioneSvolte(long COD_OPE_SVO, long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            if (private_method.addOperazioneSvolteAssociations(COD_OPE_SVO, 0, COD_AZL, this.COD_MAN) == 1) {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO ope_svo_man_tab (cod_ope_svo, cod_man) VALUES(?,?)");
                ps.setLong(1, COD_OPE_SVO);
                ps.setLong(2, this.COD_MAN);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Operazione Svolte non è inserita");
                }
            }//if
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----

    public void removeOperazioneSvolte(long COD_OPE_SVO, long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            if (private_method.delOperazioneSvolteAssociations(COD_OPE_SVO, COD_AZL, this.COD_MAN) == 1) {
                PreparedStatement ps = bmp.prepareStatement(
                        "DELETE FROM ope_svo_man_tab WHERE (cod_ope_svo=? AND cod_man=?)");
                ps.setLong(1, COD_OPE_SVO);
                ps.setLong(2, this.COD_MAN);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Operazione Svolte non è annulata");
                }
            }//if
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //------------------------------------
    public void removeCorso(long lCOD_COR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM cor_man_tab WHERE (cod_cor=? AND  cod_man=?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, this.COD_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corso non è annulata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----

    public void removeProtocoloSanitario(long lCOD_PRO_SAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM pro_san_man_tab WHERE (cod_pro_san=? AND  cod_man=?)");
            ps.setLong(1, lCOD_PRO_SAN);
            ps.setLong(2, this.COD_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Protocolo Sanitario non è annulata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //---

    public void removeDPI(long lCOD_TPL_DPI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM dpi_man_tab WHERE (cod_tpl_dpi=? AND  cod_man=?)");
            ps.setLong(1, lCOD_TPL_DPI);
            ps.setLong(2, this.COD_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("D.P.I. non è annulata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeDocumenti(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM doc_man_tab WHERE (cod_doc=? AND cod_man=? AND cod_azl=?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_MAN);
            ps.setLong(3, this.COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Il documento non è stato trovato");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeAGENTECHIMICO(long COD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM sos_chi_man_tab WHERE (cod_sos_chi=? AND cod_man=? AND cod_azl=?)");
            ps.setLong(1, COD_SOS_CHI);
            ps.setLong(2, this.COD_MAN);
            ps.setLong(3, this.COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("L'agente chimico non è stato trovato");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeMacchina(long COD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM mac_man_tab WHERE (cod_mac=? AND cod_man=?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, this.COD_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Il documento non è stato trovato");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //----
    public String addExRischi(String[] CODS_OF_RSO, long lCOD_AZL) {
        String result = "";
        try {
            for (int i = 0; i < CODS_OF_RSO.length; i++) {
                long id = Long.parseLong(CODS_OF_RSO[i]);
                result += "<br>" + id;

                this.addXRischioAssociations(id, lCOD_AZL);
            }
        } catch (Exception ex1) {
            result = ex1.toString();
        }
        return result;
    }
    //----

    public String addExCorsi(String[] CODS_OF_COR, long lCOD_AZL) {
        String result = "";
        BMPConnection bmp = getConnection();
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        try {
            for (int i = 0; i < CODS_OF_COR.length; i++) {
                long id = Long.parseLong(CODS_OF_COR[i]);
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO COR_MAN_TAB (COD_COR, COD_MAN, PRS_COR, DAT_INZ) "
                        + "VALUES( ?, ?, 'S', ?)");
                ps.setLong(1, id);
                ps.setLong(2, this.COD_MAN);
                ps.setDate(3, CUR_DAT);
                ps.executeUpdate();
            }
        } catch (Exception ex1) {
            result = ex1.toString();
        } finally {
            bmp.close();
        }
        return result;
    }
    //---

    public String addExProtocoli(String[] CODS_OF_PSA, long lCOD_AZL) {
        String result = "";
        BMPConnection bmp = getConnection();
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        try {
            for (int i = 0; i < CODS_OF_PSA.length; i++) {
                long id = Long.parseLong(CODS_OF_PSA[i]);
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO PRO_SAN_MAN_TAB (COD_PRO_SAN, COD_MAN, PRS_PRO_SAN, DAT_INZ) "
                        + "VALUES( ?, ?, 'S', ?)");
                ps.setLong(1, id);
                ps.setLong(2, this.COD_MAN);
                ps.setDate(3, CUR_DAT);
                ps.executeUpdate();
            }
        } catch (Exception ex1) {
            result = ex1.toString();
        } finally {
            bmp.close();
        }
        return result;
    }
    //---

    public String addExDPI(String[] CODS_OF_DPI, long lCOD_AZL) {
        String result = "";
        BMPConnection bmp = getConnection();
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        try {
            for (int i = 0; i < CODS_OF_DPI.length; i++) {
                long id = Long.parseLong(CODS_OF_DPI[i]);
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO DPI_MAN_TAB (COD_TPL_DPI, COD_MAN, PRS_DPI, DAT_INZ) "
                        + "VALUES( ?, ?, 'S', ?)");
                ps.setLong(1, id);
                ps.setLong(2, this.COD_MAN);
                ps.setDate(3, CUR_DAT);
                if (ps.executeUpdate() == 0) {
                    result += CODS_OF_DPI[i] + ";";
                }
            }
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
        return result;
    }

    public void addDocumenti(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO doc_man_tab (cod_doc, cod_man, cod_azl) VALUES(?,?,?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_MAN);
            ps.setLong(3, this.COD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    public void addAGENTECHIMICO(long COD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO sos_chi_man_tab (cod_sos_chi, cod_man, cod_azl) VALUES(?,?,?)");
            ps.setLong(1, COD_SOS_CHI);
            ps.setLong(2, this.COD_MAN);
            ps.setLong(3, this.COD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%Link%%% Table mac_for_azl_tab
    public void addCOD_MAC(long newCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mac_man_tab (cod_mac,cod_man) VALUES(?,?)");
            ps.setLong(1, newCOD_MAC);
            ps.setLong(2, COD_MAN);
            ps.executeUpdate();

        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    public Collection getNotAssRischi_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    SQLContainer.getNotAssRischi_ViewQUERY());
            ps.setLong(1, this.COD_MAN);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_AZL);
            ps.setLong(4, this.COD_MAN);
            ps.setLong(5, lCOD_AZL);
            ps.setLong(6, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_NotAssRischi_View obj = new AttLav_NotAssRischi_View();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.lCOD_FAT_RSO = rs.getLong(3);
                obj.strNOM_FAT_RSO = rs.getString(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //--------------------------------------

    public Collection getNotAssCorsi_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps =
                    bmp.prepareStatement(SQLContainer.getNotAssCorsi_View());
            ps.setLong(1, this.COD_MAN);
            ps.setLong(2, this.COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_NotAssCorsi_View obj = new AttLav_NotAssCorsi_View();
                obj.lCOD_COR = rs.getLong(1);
                obj.lDUR_COR_GOR = rs.getLong(2);
                obj.strNOM_COR = rs.getString(3);
                obj.strNOM_TPL_COR = rs.getString(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //------------------------------------------------------

    public Collection getNotAssProtocoli_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps =
                    bmp.prepareStatement(SQLContainer.getNotAssProtocoli_View());
            ps.setLong(1, this.COD_MAN);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, this.COD_MAN);
            ps.setLong(4, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_NotAssProtocoli_View obj = new AttLav_NotAssProtocoli_View();
                obj.lCOD_PRO_SAN = rs.getLong(1);
                obj.strNOM_PRO_SAN = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //------------------------------------------------
public Collection getAgentiChimici_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "SELECT "
                        + "sos_chi_man_tab.cod_sos_chi, "
                        + "ana_clf_sos_tab.des_clf_sos, "
                        + "ana_sos_chi_tab.nom_com_sos  "
                    + "FROM "
                        + "sos_chi_man_tab, "
                        + "ana_sos_chi_tab, "
                        + "ana_clf_sos_tab "
                    + "WHERE "
                        + "sos_chi_man_tab.cod_man =? "
                    + "AND "
                        + "sos_chi_man_tab.cod_sos_chi = ana_sos_chi_tab.cod_sos_chi "
                    + "AND "
                        + "ana_sos_chi_tab.cod_clf_sos =  ana_clf_sos_tab.cod_clf_sos  "
                        + "order by ana_sos_chi_tab.nom_com_sos");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Attivitalavorativa_AgentiChimici_View obj = new Attivitalavorativa_AgentiChimici_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.DES_CLF_SOS = rs.getString(2);
                obj.NOM_COM_SOS = rs.getString(3);
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

public Collection getAgentiChimici_View_Report() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "SELECT (CASE WHEN rso_val = '0' THEN ''"
                    + " WHEN rso_val = '1' THEN 'Moderato' "
                    + "WHEN rso_val = '2' THEN 'Non moderato' END),note "
                    + "FROM "
                    + "ana_man_tab "
                    + "WHERE "
                    + "ana_man_tab.cod_man =?");
            ps.setLong(1, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLavAGE_CHI_View obj = new AttLavAGE_CHI_View();
                obj.RSO_VAL = rs.getString(1);
                System.out.println(obj.RSO_VAL);
                obj.NOTE = rs.getString(2);
                System.out.println(obj.NOTE);
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

//------------------------------------------------
    public Collection getNotAssDPI_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps =
                    bmp.prepareStatement(SQLContainer.getNotAssDPI_View());
            ps.setLong(1, this.COD_MAN);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, this.COD_MAN);
            ps.setLong(4, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttLav_NotAssDPI_View obj = new AttLav_NotAssDPI_View();
                obj.lCOD_TPL_DPI = rs.getLong(1);
                obj.lPER_MES_SST = rs.getLong(2);
                obj.lPER_MES_MNT = rs.getLong(3);
                obj.strNOM_TPL_DPI = rs.getString(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //-------------------------------------------------------

    public Collection ejbGetAttivitaLavorativa_CRM_MAN_View(String strNOM, long COD_AZL) {
        String query = "SELECT a.cod_man,a.nom_man, a.des_man, a.des_rsp_com FROM ana_man_tab_r a WHERE a.nom_man LIKE ? ";
        String query2 = "SELECT cod_man FROM ana_man_tab WHERE nom_man = ? AND cod_azl= ? ";
        BMPConnection bmp = getConnection();
        BMPConnection bmp2 = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(query);
            PreparedStatement ps2 = bmp2.prepareStatement(query2);
            ps.setString(1, strNOM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorativa_CRM_MAN_View v = new AttivitaLavorativa_CRM_MAN_View();
                v.lCOD_MAN = rs.getLong(1);
                v.strNOM_MAN = rs.getString(2);
                v.strDES_MAN = rs.getString(3);
                v.strDES_RSP_COM = rs.getString(4);
                ps2.setString(1, v.strNOM_MAN);
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
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
            bmp2.close();
        }
    }
    //-------------------------------------------------------

    public Collection ejbGetAllAttivitaLavorative_Name_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_man, nom_man FROM ana_man_tab ORDER BY nom_man ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

// -- FORM GEST ATTIVITA --
    public long ejbGetCountAttivitaLavorativeByCOD_OPE_SVO(long lCOD_OPE_SVO, long lCOD_AZL) {
        long result = 0;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COUNT(A.COD_MAN) "
                    + "FROM  ANA_MAN_TAB A, OPE_SVO_MAN_TAB B "
                    + "WHERE A.COD_MAN=B.COD_MAN "
                    + "AND B.COD_OPE_SVO = ? "
                    + "AND A.COD_AZL = ? ");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getLong(1);
            }
            bmp.close();
            return result;
        } catch (Exception ex1) {
            ex1.printStackTrace();
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//--------------------------------------------------------------------------

    public Collection ejbGetAttLavListToOperSvolta_View(long lCOD_OPE_SVO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT A.COD_MAN , A.NOM_MAN  FROM  ANA_MAN_TAB A , OPE_SVO_MAN_TAB B WHERE (A.COD_MAN=B.COD_MAN AND B.COD_OPE_SVO=? AND A.COD_AZL=?)");
            ps.setLong(1, lCOD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View obj = new AttivitaLavorative_Name_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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
    //-------------------------------------------------------------
    //<alex_romas date="05/04/2004">

    public void addXRischioAssociations(long COD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            bmp.beginTrans();
            String res = private_method.addExtendedRischioAssociations(COD_RSO, lCOD_AZL, bmp, this.COD_MAN);
            bmp.commitTrans();
        } catch (Exception ex) {
            ex.printStackTrace();
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            try {
                bmp.close();
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
        }
    }
    //---

    public void deleteXRischioAssociations(long COD_RSO, long COD_AZL) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_PRO_SAN, REC_DPI, REC_COR;
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
            //---------------REC_CUR------------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_rso "
                    + "FROM rso_man_tab a WHERE a.cod_azl = ? "
                    + "AND a.cod_man = ? "
                    + "AND a.cod_rso = ? ");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, this.COD_MAN);
            ps.setLong(3, COD_RSO);
            REC_CUR = ps.executeQuery();

            int DEBUG = 1;
            while (REC_CUR.next()) {
                //======================PRO_SAN_MAN=================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false)) {
                    PreparedStatement ps_pro_san;
                    ps_pro_san = bmp.prepareStatement(
                            "SELECT a.cod_pro_san FROM pro_san_man_tab a "
                            + "WHERE a.cod_man = ?  "
                            + "AND a.cod_pro_san IN "
                            + "(SELECT b.cod_pro_san FROM pro_san_rso_tab b "
                            + "WHERE b.cod_rso = ? AND b.cod_azl =?) "
                            + "AND a.cod_pro_san NOT IN "
                            + "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_man_tab d "
                            + "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ?)");
                    ps_pro_san.setLong(1, this.COD_MAN);
                    ps_pro_san.setLong(2, REC_CUR.getLong(1));
                    ps_pro_san.setLong(3, COD_AZL);
                    ps_pro_san.setLong(4, REC_CUR.getLong(1));
                    ps_pro_san.setLong(5, COD_AZL);
                    ps_pro_san.setLong(6, this.COD_MAN);

                    REC_PRO_SAN = ps_pro_san.executeQuery();
                    while (REC_PRO_SAN.next()) {
                        PreparedStatement ps_pro_san_del = bmp.prepareStatement(
                                "DELETE FROM pro_san_man_tab WHERE cod_pro_san = ? AND cod_man = ? ");
                        ps_pro_san_del.setLong(1, REC_PRO_SAN.getLong(1));
                        ps_pro_san_del.setLong(2, this.COD_MAN);
                        ps_pro_san_del.executeUpdate();
                        ps_pro_san_del.clearParameters();
                    }
                    REC_PRO_SAN.close();
                }
                //======================DPI_MAN=====================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false)) {
                    PreparedStatement ps_dpi = bmp.prepareStatement(
                            "SELECT a.cod_tpl_dpi FROM dpi_man_tab a  "
                            + "WHERE a.cod_man =?	AND a.cod_tpl_dpi IN  "
                            + "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b "
                            + "WHERE b.cod_azl = ?  AND b.cod_rso=? )   "
                            + "AND a.cod_tpl_dpi NOT IN "
                            + "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_man_tab d "
                            + "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
                    ps_dpi.setLong(1, this.COD_MAN);
                    ps_dpi.setLong(2, COD_AZL);
                    ps_dpi.setLong(3, REC_CUR.getLong(1));
                    ps_dpi.setLong(4, REC_CUR.getLong(1));
                    ps_dpi.setLong(5, COD_AZL);
                    ps_dpi.setLong(6, this.COD_MAN);

                    REC_DPI = ps_dpi.executeQuery();
                    while (REC_DPI.next()) {
                        PreparedStatement ps_dpi_del = bmp.prepareStatement(
                                "DELETE FROM dpi_man_tab WHERE cod_tpl_dpi = ? AND cod_man = ? ");
                        ps_dpi_del.setLong(1, REC_DPI.getLong(1));
                        ps_dpi_del.setLong(2, this.COD_MAN);
                        ps_dpi_del.executeUpdate();
                        ps_dpi_del.clearParameters();
                    }
                    REC_DPI.close();
                }
                //======================COR_MAN=====================================
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false)) {
                    PreparedStatement ps_cor = bmp.prepareStatement(
                            "SELECT a.cod_cor  FROM cor_man_tab a  "
                            + "WHERE a.cod_man = ? AND a.cod_cor IN  "
                            + "(SELECT b.cod_cor FROM cor_rso_tab b  "
                            + "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  "
                            + "(SELECT c.cod_cor FROM cor_rso_tab c, rso_man_tab d  "
                            + "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND c.cod_azl=? AND d.cod_man = ? )");
                    ps_cor.setLong(1, this.COD_MAN);
                    ps_cor.setLong(2, COD_AZL);
                    ps_cor.setLong(3, REC_CUR.getLong(1));
                    ps_cor.setLong(4, REC_CUR.getLong(1));
                    ps_cor.setLong(5, COD_AZL);
                    ps_cor.setLong(6, this.COD_MAN);

                    REC_COR = ps_cor.executeQuery();
                    while (REC_COR.next()) {
                        PreparedStatement ps_cor_del = bmp.prepareStatement(
                                "DELETE FROM cor_man_tab WHERE cod_cor = ? AND cod_man = ? ");
                        ps_cor_del.setLong(1, REC_COR.getLong(1));
                        ps_cor_del.setLong(2, this.COD_MAN);
                        ps_cor_del.executeUpdate();
                        ps_cor_del.clearParameters();
                    }
                    REC_COR.close();
                }
                //======== MIS_PET_MAN =================
                PreparedStatement ps_mis_pet_del = bmp.prepareStatement(
                        "DELETE FROM mis_pet_man_tab "
                        + " WHERE cod_rso_man IN "
                        + "(SELECT h.cod_rso_man FROM rso_man_tab h WHERE h.cod_azl = ? "
                        + "AND h.cod_man = ? AND h.cod_rso = ?)");
                ps_mis_pet_del.setLong(1, COD_AZL);
                ps_mis_pet_del.setLong(2, this.COD_MAN);
                ps_mis_pet_del.setLong(3, REC_CUR.getLong(1));
                ps_mis_pet_del.executeUpdate();
                //======== RSO_MAN =====================
                PreparedStatement ps_rso_man_del = bmp.prepareStatement(
                        "DELETE FROM rso_man_tab WHERE cod_azl = ? AND cod_man = ? AND cod_rso = ? ");
                ps_rso_man_del.setLong(1, COD_AZL);
                ps_rso_man_del.setLong(2, this.COD_MAN);
                ps_rso_man_del.setLong(3, REC_CUR.getLong(1));
                ps_rso_man_del.executeUpdate();
                //======================================
            }// /main loop
            conn.commit();
            REC_CUR.close();
            //-------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
            }
        }
    }//----
    //===========================================================================

    public Collection ejbGetAttivitaLavorativaByDipendente_View(long lCOD_DPD) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                    + "a.nom_man, "
                    + "c.nom_uni_org, "
                    + "b.dat_inz, "
                    + "b.dat_fie, "
                    + "d.nom_tpl_con "
                    + "from "
                    + "ana_man_tab a, "
                    + "man_dpd_uni_org_tab b LEFT OUTER JOIN tpl_con_tab d "
                    + "ON (b.cod_tpl_con = d.cod_tpl_con), "
                    + "ana_uni_org_tab c "
                    + "where "
                    + "a.cod_man = b.cod_man "
                    + "and b.cod_uni_org = c.cod_uni_org "
                    + "and b.cod_dpd=?");
            ps.setLong(1, lCOD_DPD);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorativaByDipendente_View obj = new AttivitaLavorativaByDipendente_View();
                obj.strNOM_MAN = rs.getString(1);
                obj.strNOM_UNI_ORG = rs.getString(2);
                obj.dtDAT_INZ = rs.getDate(3);
                obj.dtDAT_FIE = rs.getDate(4);
                obj.strNOM_TPL_CON = rs.getString(5);
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
///////////////######### REPOSITORY BY KUSHKAROV FEAT PODMASTER ############/////////////////////////

    public boolean ejbcaricaRpMansioni(long P_COD_AZL, String P_NOM_MAN) {
        boolean result = true;
        ResultSet rs = null;
        long v_pro_san = 0;
        long cod_rso = 0;
        long cod_vst_med = 0;
        long cod_vst_ido = 0;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++
            long conta;
            long V_COD_MAN = NEW_ID();
            long P_COD_RSO = 0;
            long flag_esistenza;
            ps = bmp.prepareStatement("select count(*) from ana_man_tab_r where nom_man = ?");
            ps.setString(1, P_NOM_MAN);
            rs = ps.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps.close();
            }
            //--------------------
            if (flag_esistenza == 0) {
                ps = bmp.prepareStatement(
                        "INSERT INTO ana_man_tab_r(cod_man, nom_man, des_man, des_rsp_com) "
                        + "SELECT ?, nom_man, des_man, des_rsp_com FROM ana_man_tab "
                        + "WHERE nom_man = ? AND cod_azl = ?");
                ps.setLong(1, V_COD_MAN);
                ps.setString(2, P_NOM_MAN);
                ps.setLong(3, P_COD_AZL);
                ps.executeUpdate();
                ps.close();
                ps = bmp.prepareStatement("update ana_man_tab set cod_man_rpo=?  where nom_man =? and cod_azl =?");
                ps.setLong(1, V_COD_MAN);
                ps.setString(2, P_NOM_MAN);
                ps.setLong(3, P_COD_AZL);
                ps.executeUpdate();
                ps.close();
                ps = bmp.prepareStatement(
                        "SELECT cod_ope_svo FROM ope_svo_man_tab "
                        + "WHERE cod_man = (SELECT cod_man FROM ana_man_tab WHERE nom_man =? AND cod_azl =?)");
                ps.setString(1, P_NOM_MAN);
                ps.setLong(2, P_COD_AZL);
                ResultSet i = ps.executeQuery();
//////////////////////////### OPE_SVO ###//////////////////////////////////
                long v_cod_ope_svo, cod_ope_svo = 0;
                PreparedStatement ps_ope_svo_0 = bmp.prepareStatement(
                        "INSERT INTO ope_svo_man_tab_r (cod_man,cod_ope_svo) VALUES (?,?)");
                while (i.next()) {
                    try {
                        ps_ope_svo_0.setLong(1, V_COD_MAN);
                        ps_ope_svo_0.setLong(2, i.getLong(1));
                        ps_ope_svo_0.executeUpdate();
                        ps_ope_svo_0.clearParameters();
                    } catch (Exception ex1) {
                        ex1.printStackTrace();
                    }
                }
                i.close();
                ps.close();
///////////////////////////### COR ##////////////////////////////////////////////////////
                ps = bmp.prepareStatement(
                        "SELECT cod_cor FROM cor_man_tab_r  WHERE cod_man = (SELECT cod_man  FROM ana_man_tab WHERE nom_man = ? AND cod_azl = ?)");
                ps.setString(1, P_NOM_MAN);
                ps.setLong(2, P_COD_AZL);
                i = ps.executeQuery();
                PreparedStatement ps_cor_tab = bmp.prepareStatement(
                        "INSERT INTO cor_man_tab_r VALUES(?,?)");
                while (i.next()) {
                    ps_cor_tab.setLong(1, V_COD_MAN);
                    ps_cor_tab.setLong(2, i.getLong(1));
                    try {
                        ps_cor_tab.executeUpdate();
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                    ps_cor_tab.clearParameters();
                }
                i.close();
                ps.close();
////////////////////////////////######## RSO ##############/////////////////////////////////////////////////////
                ps = bmp.prepareStatement("SELECT rso_man_tab.cod_rso, ana_rso_tab.nom_rso "
                        + " FROM rso_man_tab,ana_rso_tab "
                        + " WHERE ana_rso_tab.cod_azl =? AND ana_rso_tab.cod_rso=rso_man_tab.cod_rso AND rso_man_tab.cod_man=(SELECT cod_man "
                        + " FROM ana_man_tab WHERE nom_man = ? AND cod_azl = ?) ");
                ps.setLong(1, P_COD_AZL);
                ps.setString(2, P_NOM_MAN);
                ps.setLong(3, P_COD_AZL);
                i = ps.executeQuery();
                long V_COD_RSO = 0;
                String P_NOM_RSO = "";
                //long P_COD_RSO=0;
                P_COD_RSO = 0;
                while (i.next()) {
                    P_NOM_RSO = i.getString(2);
                    P_COD_RSO = i.getLong(1);
                    PreparedStatement ps_rso_cnt = bmp.prepareStatement("select count(*) from ana_rso_tab_r where nom_rso = ?");
                    PreparedStatement ps_cod_rso = bmp.prepareStatement(
                            "SELECT cod_rso FROM ana_rso_tab_r WHERE nom_rso=? ");
                    ps_rso_cnt.setString(1, P_NOM_RSO);
                    ps_cod_rso.setString(1, P_NOM_RSO);
                    ResultSet rs_rso_cnt = ps_rso_cnt.executeQuery();
                    ResultSet rs_cod_rso = ps_cod_rso.executeQuery();
                    if (!rs_rso_cnt.next()) {
                        throw new EJBException("DB error");
                    } else {
                        flag_esistenza = rs_rso_cnt.getLong(1);
                        rs_rso_cnt.close();
                        ps_rso_cnt.close();
                    }
                    if (flag_esistenza == 0) {
                        V_COD_RSO = NEW_ID() + (cod_rso++);
                        ps = bmp.prepareStatement(
                                "INSERT INTO ana_rso_tab_r(cod_rso, nom_rso, des_rso, dat_ril, nom_ril_rso, clf_rso, "
                                + "prb_eve_les, ent_dan, stm_num_rso, rfc_vlu_rso_mes, cod_fat_rso) "
                                + "SELECT ?, nom_rso, des_rso, dat_ril, nom_ril_rso, clf_rso, "
                                + "prb_eve_les, ent_dan, stm_num_rso, rfc_vlu_rso_mes, cod_fat_rso "
                                + "FROM ana_rso_tab WHERE nom_rso =?");
                        ps.setLong(1, V_COD_RSO);
                        ps.setString(2, P_NOM_RSO);
                        ps.executeUpdate();
                        ps.close();
                        ps = bmp.prepareStatement("update ana_rso_tab set cod_rso_rpo=? where nom_rso = ? and cod_azl = ?");
                        ps.setLong(1, V_COD_RSO);
                        ps.setString(2, P_NOM_RSO);
                        ps.setLong(3, P_COD_AZL);
                        ps.executeUpdate();
                        ps.close();
                    } else {
                        //result=false;
                        rs_cod_rso.next();
                        V_COD_RSO = rs_cod_rso.getLong(1);
                    }
                    ps = bmp.prepareStatement("insert into rso_man_tab_r(cod_man, cod_rso) values(?,?)");
                    ps.setLong(1, V_COD_MAN);
                    ps.setLong(2, V_COD_RSO);
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
                    ResultSet k = ps.executeQuery();
                    long v_cod_mis_pet, cod_mis_pet = 0;
                    PreparedStatement ps_mis_pet_cnt = bmp.prepareStatement("SELECT count(*)  FROM ana_mis_pet_tab_r WHERE cod_mis_pet = ?");
                    PreparedStatement ps_mis_pet_0 = bmp.prepareStatement(
                            "INSERT INTO ana_mis_pet_tab_r (cod_mis_pet,nom_mis_pet, dat_cmp, ver_mis_pet, adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet) "
                            + "SELECT ?, nom_mis_pet, dat_cmp, ver_mis_pet, adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet FROM ana_mis_pet_tab WHERE cod_azl=? AND cod_mis_pet = ?");
                    PreparedStatement ps_mis_pet_1 = bmp.prepareStatement("INSERT INTO rso_mis_pet_tab_r (cod_mis_pet, cod_rso) VALUES (?, ?)");
                    PreparedStatement ps_mis_pet_2 = bmp.prepareStatement("UPDATE ana_mis_pet_tab SET cod_mis_pet_rpo = ? WHERE cod_mis_pet=?");
                    PreparedStatement ps_mis_pet_3 = bmp.prepareStatement("SELECT cod_mis_pet FROM ana_mis_pet_tab_r WHERE cod_mis_pet = ?");
                    PreparedStatement ps_mis_pet_4 = bmp.prepareStatement("SELECT cod_nor_sen FROM nor_sen_mis_pet_tab WHERE cod_mis_pet = ?");
                    PreparedStatement ps_mis_pet_5 = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_tab_r VALUES(?, ?)");
                    while (k.next()) {
                        ps_mis_pet_cnt.setLong(1, k.getLong(1));
                        ResultSet rs_mis_pet_cnt = ps_mis_pet_cnt.executeQuery();
                        rs_mis_pet_cnt.next();
                        if (rs_mis_pet_cnt.getLong(1) == 0) {
                            v_cod_mis_pet = NEW_ID() + (cod_mis_pet++);
                            ps_mis_pet_0.setLong(1, v_cod_mis_pet);
                            ps_mis_pet_0.setLong(2, P_COD_AZL);
                            ps_mis_pet_0.setLong(3, k.getLong(1));
                            ps_mis_pet_1.setLong(1, v_cod_mis_pet);
                            ps_mis_pet_1.setLong(2, V_COD_RSO);
                            ps_mis_pet_2.setLong(1, v_cod_mis_pet);
                            ps_mis_pet_2.setLong(2, k.getLong(1));
                            ps_mis_pet_0.executeUpdate();
                            ps_mis_pet_1.executeUpdate();
                            ps_mis_pet_2.executeUpdate();
                            ps_mis_pet_0.clearParameters();
                            ps_mis_pet_1.clearParameters();
                            ps_mis_pet_2.clearParameters();
                        }
                        try {
                            ps_mis_pet_3.setLong(1, k.getLong(1));
                            ResultSet rs_mis_pet_3 = ps_mis_pet_3.executeQuery();
                            ps_mis_pet_4.setLong(1, k.getLong(1));
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
                            ex1.printStackTrace();
                        }
                        rs_mis_pet_cnt.close();
                    }
                    k.close();
                    ps.close();
                    ps = bmp.prepareStatement("select cod_tpl_dpi from dpi_rso_tab where cod_azl=? and cod_rso = ?");
                    ps.setLong(1, P_COD_AZL);
                    ps.setLong(2, P_COD_RSO);
                    k = ps.executeQuery();

                    PreparedStatement ps_dpi_rso_tab = bmp.prepareStatement("insert into dpi_rso_tab_r values(?, ?)");
                    while (k.next()) {
                        ps_dpi_rso_tab.setLong(1, V_COD_RSO);
                        ps_dpi_rso_tab.setLong(2, k.getLong(1));
                        try {
                            ps_dpi_rso_tab.executeUpdate();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                        ps_dpi_rso_tab.clearParameters();
                    }
                    k.close();
                    ps.close();

                    ps = bmp.prepareStatement("select cod_nor_sen from nor_sen_rso_tab where cod_azl = ? and cod_rso= ?");
                    ps.setLong(1, P_COD_AZL);
                    ps.setLong(2, P_COD_RSO);
                    k = ps.executeQuery();

                    PreparedStatement ps_nor_sen_rso_tab = bmp.prepareStatement("insert into nor_sen_rso_tab_r values(?, ?)");
                    while (k.next()) {
                        ps_nor_sen_rso_tab.setLong(1, V_COD_RSO);
                        ps_nor_sen_rso_tab.setLong(2, k.getLong(1));
                        try {
                            ps_nor_sen_rso_tab.executeUpdate();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                        ps_nor_sen_rso_tab.clearParameters();
                    }
                    k.close();
                    ps.close();

                    ps = bmp.prepareStatement("select cod_cor from cor_rso_tab where cod_azl = ? and cod_rso= ?");
                    ps.setLong(1, P_COD_AZL);
                    ps.setLong(2, P_COD_RSO);
                    k = ps.executeQuery();

                    PreparedStatement ps_cor_rso_tab = bmp.prepareStatement("insert into cor_rso_tab_r values(?, ?)");
                    while (k.next()) {
                        ps_cor_rso_tab.setLong(1, V_COD_RSO);
                        ps_cor_rso_tab.setLong(2, k.getLong(1));
                        try {
                            ps_cor_rso_tab.executeUpdate();
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                        ps_cor_rso_tab.clearParameters();
                    }
                    k.close();
                    ps.close();

                    ps = bmp.prepareStatement("select cod_pro_san from pro_san_rso_tab where cod_azl = ? and cod_rso= ?");
                    ps.setLong(1, P_COD_AZL);
                    ps.setLong(2, P_COD_RSO);
                    ResultSet p = ps.executeQuery();

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
                    while (p.next()) {
                        ps_pro_san_cnt.setLong(1, p.getLong(1));
                        ResultSet rs_pro_san_cnt = ps_pro_san_cnt.executeQuery();
                        rs_pro_san_cnt.next();
                        if (rs_pro_san_cnt.getLong(1) == 0) {
                            v_pro_san = NEW_ID() + (cod_pro_san++);

                            ps_pro_san_2.setLong(1, v_pro_san);
                            ps_pro_san_2.setLong(2, p.getLong(1));
                            ps_pro_san_2.setLong(3, P_COD_AZL);
                            ps_pro_san_2.executeUpdate();

                            ps_pro_san_3.setLong(1, v_pro_san);
                            ps_pro_san_3.setLong(2, p.getLong(1));
                            ps_pro_san_3.executeUpdate();

                            ps_pro_san_1.setLong(1, V_COD_RSO);
                            ps_pro_san_1.setLong(2, v_pro_san);
                            ps_pro_san_1.executeUpdate();
                        } else {
                            ps_pro_san_cnt.setLong(1, p.getLong(1));
                            ResultSet rs_pro_san_0 = ps_pro_san_0.executeQuery();
                            rs_pro_san_0.next();
                            v_pro_san = rs_pro_san_0.getLong(1);

                            ps_pro_san_1.setLong(1, V_COD_RSO);
                            ps_pro_san_1.setLong(2, v_pro_san);
                            try {
                                ps_pro_san_1.executeUpdate();
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        }
                        ps_pro_san_cnt.clearParameters();
                        ps_pro_san_0.clearParameters();
                        ps_pro_san_1.clearParameters();
                        ps_pro_san_2.clearParameters();
                        ps_pro_san_3.clearParameters();

                        ps_vst_ido.setLong(1, p.getLong(1));
                        ResultSet x = ps_vst_ido.executeQuery();
                        while (x.next()) {
                            ps_vst_ido_cnt.setLong(1, x.getLong(1));
                            ResultSet rs_vst_ido_cnt = ps_vst_ido_cnt.executeQuery();
                            rs_vst_ido_cnt.next();
                            if (rs_vst_ido_cnt.getLong(1) == 0) {
                                long v_cod_vst_ido = NEW_ID() + (cod_vst_ido++);

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
                                    ex.printStackTrace();
                                }
                            }

                        }

                        ps_vst_med.setLong(1, i.getLong(1));
                        ResultSet y = ps_vst_med.executeQuery();
                        while (y.next()) {
                            ps_vst_med_cnt.setLong(1, y.getLong(1));
                            ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                            if (rs_vst_med_cnt.next()) {
                                if (rs_vst_med_cnt.getLong(1) == 0) {
                                    long v_cod_vst_med = NEW_ID() + (cod_vst_med++);

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
                                    if (rs_vst_med_1.next()) {
                                        long v_cod_vst_med = rs_vst_med_1.getLong(1);
                                        ps_vst_med_0.setLong(1, v_pro_san);
                                        ps_vst_med_0.setLong(2, v_cod_vst_med);
                                        try {
                                            ps_vst_med_0.executeUpdate();
                                        } catch (Exception ex) {
                                            ex.printStackTrace();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                i.close();
                ps.close();
/////###################### PRO_SAN ############################/////////////////////////////////////////////
                ps = bmp.prepareStatement("select cod_pro_san	from pro_san_man_tab "
                        + " where cod_man=(select cod_man from ana_man_tab "
                        + " where nom_man= ? and cod_azl = ?)");
                ps.setString(1, P_NOM_MAN);
                ps.setLong(2, P_COD_AZL);
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
                    ps_pro_san_cnt.setLong(1, i.getLong(1));
                    ResultSet rs_pro_san_cnt = ps_pro_san_cnt.executeQuery();
                    if (rs_pro_san_cnt.next()) {
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
                            if (rs_pro_san_0.next()) {
                                v_pro_san = rs_pro_san_0.getLong(1);
                                ps_pro_san_1.setLong(1, V_COD_RSO);
                                ps_pro_san_1.setLong(2, v_pro_san);
                                try {
                                    ps_pro_san_1.executeUpdate();
                                } catch (Exception ex) {
                                    ex.printStackTrace();
                                }
                            }
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
                        if (rs_vst_ido_cnt.next()) {
                            if (rs_vst_ido_cnt.getLong(1) == 0) {
                                long v_cod_vst_ido = NEW_ID() + (cod_vst_ido++);
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
                                if (rs_vst_ido_1.next()) {
                                    long v_cod_vst_ido = rs_vst_ido_1.getLong(1);
                                    ps_vst_ido_0.setLong(1, v_pro_san);
                                    ps_vst_ido_0.setLong(2, v_cod_vst_ido);
                                    try {
                                        ps_vst_ido_0.executeUpdate();
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    }
                                }
                            }
                        }
                    }
                    ps_vst_med.setLong(1, i.getLong(1));
                    ResultSet y = ps_vst_med.executeQuery();
                    while (y.next()) {
                        ps_vst_med_cnt.setLong(1, y.getLong(1));
                        ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                        long v_cod_vst_med = NEW_ID() + (cod_vst_med++);
                        if (rs_vst_med_cnt.next()) {
                            if (rs_vst_med_cnt.getLong(1) == 0) {
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
                                if (rs_vst_med_1.next()) {
                                    v_cod_vst_med = rs_vst_med_1.getLong(1);
                                }
                                ps_vst_med_0.setLong(1, v_pro_san);
                                ps_vst_med_0.setLong(2, v_cod_vst_med);
                                try {
                                    ps_vst_med_0.executeUpdate();
                                } catch (Exception ex) {
                                    ex.printStackTrace();
                                }
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
            ex.printStackTrace();
            result = false;
            try {
                conn.rollback();
            } catch (Exception ex1) {
                ex1.printStackTrace();
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
        }
        return result;
    }
///////////////##############################/////////////////////////////
//----podmaster-----------
//============================================================================================

    public boolean ejbCarica_db_mansioni(long P_COD_AZL, long P_COD_MAN, java.sql.Date dtDAT) {
        boolean result = true;
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++
            long conta;
            long conta1;
            long V_COD_MAN = NEW_ID();
            long V_COD_VST_IDO;
            long V_COD_VST_MED;
            long V_COD_RSO;
            long V_COD_MIS_PET;
            long flag_esistenza;
            long counter = 0;
            ps = bmp.prepareStatement("select count(*) from ana_man_tab where cod_azl=? and cod_man_rpo = ?");
            ps.setLong(1, P_COD_AZL);
            ps.setLong(2, P_COD_MAN);
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
                        " INSERT INTO ana_man_tab(cod_azl, cod_man, nom_man, des_man, des_rsp_com, cod_man_rpo) "
                        + " SELECT ?, ?, nom_man, des_man, des_rsp_com,cod_man "
                        + " FROM ana_man_tab_r WHERE cod_man = ?");
                ps.setLong(1, P_COD_AZL);
                ps.setLong(2, V_COD_MAN);
                ps.setLong(3, P_COD_MAN);
                ps.executeUpdate();
                ps.close();
                //----alla mansione che voglio caricare
                ps = bmp.prepareStatement(
                        " SELECT cod_ope_svo FROM ope_svo_man_tab_r"
                        + " WHERE cod_man = ? ");
                ps.setLong(1, P_COD_MAN);
                ResultSet i = ps.executeQuery();
                PreparedStatement ps_ope_svo = null;
                ps_ope_svo = bmp.prepareStatement(
                        "INSERT INTO ope_svo_man_tab(cod_man,cod_ope_svo) VALUES(?,?) ");
                while (i.next()) {
                    ps_ope_svo.setLong(1, V_COD_MAN);
                    ps_ope_svo.setLong(2, i.getLong(1));
                    ps_ope_svo.executeUpdate();
                    ps_ope_svo.clearParameters();
                }
                i.close();
                ps.close();
//----inserisco tutti i corsi svolti associati
//----alla mansione che voglio caricare
                ps = bmp.prepareStatement("SELECT cod_cor FROM cor_man_tab_r WHERE cod_man = ?");
                ps.setLong(1, P_COD_MAN);
                i = ps.executeQuery();
                PreparedStatement ps_cor_man = bmp.prepareStatement("INSERT INTO cor_man_tab VALUES(?,?,?,?,?)");
                while (i.next()) {
                    ps_cor_man.setLong(1, V_COD_MAN);
                    ps_cor_man.setLong(2, i.getLong(1));
                    ps_cor_man.setString(3, "S");
                    ps_cor_man.setDate(4, dtDAT);
                    ps_cor_man.setNull(5, java.sql.Types.BIGINT);
                    ps_cor_man.executeUpdate();
                    ps_cor_man.clearParameters();
                }
                i.close();
                ps.close();
//----seleziono tutti i rischi associati
//---- alla mansione che voglio caricare
                ps = bmp.prepareStatement("SELECT cod_rso FROM rso_man_tab_r WHERE cod_man = ?");
                ps.setLong(1, P_COD_MAN);
                i = ps.executeQuery();
                PreparedStatement ps_ana_rso = bmp.prepareStatement("select count(*) from ana_rso_tab where cod_azl=? and cod_rso_rpo = ?");
                ResultSet rs_ana_rso = null;
                ResultSet a = null;
                ResultSet b = null;
                ResultSet c = null;
                ResultSet e = null;
                ResultSet x = null;
                PreparedStatement ps_ana_rso_INSERT = null;
                ps_ana_rso_INSERT = bmp.prepareStatement(
                        "INSERT INTO ana_rso_tab(cod_azl, cod_rso, nom_rso, des_rso, dat_ril, "
                        + "nom_ril_rso, clf_rso, prb_eve_les, ent_dan, stm_num_rso, "
                        + "rfc_vlu_rso_mes,cod_fat_rso, cod_rso_rpo) "
                        + "SELECT ?, ?, nom_rso, des_rso, dat_ril, "
                        + "nom_ril_rso, clf_rso, prb_eve_les, ent_dan, stm_num_rso, "
                        + "rfc_vlu_rso_mes, cod_fat_rso ,cod_rso "
                        + "FROM ana_rso_tab_r WHERE cod_rso =? ");

                PreparedStatement ps_mis_pet = bmp.prepareStatement(
                        "INSERT INTO ana_mis_pet_tab(cod_mis_pet, nom_mis_pet, dat_cmp, ver_mis_pet, "
                        + "adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, "
                        + "tpl_dsi_mis_pet,  dsi_azl_mis_pet, cod_tpl_mis_pet, cod_azl, cod_mis_pet_rpo) "
                        + "SELECT    ?, nom_mis_pet, dat_cmp, ver_mis_pet, "
                        + "adt_mis_pet, dat_par_adt, per_mis_pet, pnz_mis_pet_mes, des_mis_pet, "
                        + "tpl_dsi_mis_pet, dsi_azl_mis_pet, cod_tpl_mis_pet, ?, ? "
                        + "FROM ana_mis_pet_tab_r a, rso_mis_pet_tab_r b "
                        + "WHERE b.cod_rso=? AND a.cod_mis_pet = ? AND a.cod_mis_pet = b.cod_mis_pet");
                PreparedStatement ps_mis_pet_r = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_tab (cod_mis_pet, cod_nor_sen) "
                        + "SELECT ?, cod_nor_sen "
                        + "FROM nor_sen_mis_pet_tab_r "
                        + "WHERE cod_mis_pet = ? ");
                PreparedStatement ps_dpi = bmp.prepareStatement("SELECT cod_tpl_dpi FROM dpi_rso_tab_r WHERE cod_rso = ?");
                PreparedStatement ps_dpi_rso = bmp.prepareStatement("INSERT INTO dpi_rso_tab VALUES(?,?,?) ");
                PreparedStatement ps_sen = bmp.prepareStatement("SELECT cod_nor_sen FROM nor_sen_rso_tab_r WHERE cod_rso = ?");
                PreparedStatement ps_cor_rso = bmp.prepareStatement("INSERT INTO cor_rso_tab VALUES(?,?,?)");
                PreparedStatement ps_nor_sen_rso = bmp.prepareStatement("INSERT INTO nor_sen_rso_tab VALUES(?,?,?)");
                PreparedStatement ps_cor = bmp.prepareStatement("SELECT cod_cor FROM cor_rso_tab_r WHERE cod_rso = ?");

                PreparedStatement ps_pro_san_rso_r = bmp.prepareStatement("SELECT cod_pro_san FROM pro_san_rso_tab_r WHERE cod_rso = ?");
                PreparedStatement ps_pro_san_rso_INSERT = bmp.prepareStatement("INSERT INTO pro_san_rso_tab VALUES(?,?,?)");
                PreparedStatement ps_vst_ido_pro_san_r = bmp.prepareStatement("SELECT cod_vst_ido FROM vst_ido_pro_san_tab_r WHERE cod_pro_san = ?");
                PreparedStatement ps_vst_ido_count = bmp.prepareStatement("SELECT count(*) FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_pro = ?");
                PreparedStatement ps_vst_ido_pro_san_count = bmp.prepareStatement("SELECT count(*) FROM vst_ido_pro_san_tab WHERE cod_vst_ido IN (SELECT cod_vst_ido FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_pro = ?) AND cod_pro_san= ?");
                PreparedStatement ps_vst_med_pro_san_count = bmp.prepareStatement("SELECT count(*) FROM vst_med_pro_san_tab WHERE cod_vst_med IN (SELECT cod_vst_med FROM ana_vst_med_tab WHERE cod_azl = ? AND cod_med_ido_pro = ?) AND cod_pro_san= ?");
                PreparedStatement ps_vst_ido_pro_san_INSERT = bmp.prepareStatement("INSERT INTO vst_ido_pro_san_tab VALUES (?,?)");
                PreparedStatement ps_vst_ido_INSERT = bmp.prepareStatement("INSERT INTO ana_vst_ido_tab SELECT ? ,fat_per, per_vst, nom_vst_ido, des_vst_ido, ?, cod_vst_ido FROM ana_vst_ido_tab_r WHERE cod_vst_ido= ?");
                PreparedStatement ps_vst_med_INSERT = bmp.prepareStatement("INSERT INTO ana_vst_med_tab SELECT ?, fat_per , per_vst , nom_vst_med, des_vst_med , ? ,cod_vst_med FROM ana_vst_med_tab_r WHERE cod_vst_med = ? ");
                PreparedStatement ps_vst_med_count = bmp.prepareStatement("SELECT count(*) FROM ana_vst_med_tab WHERE cod_azl=? AND cod_vst_med_pro = ?");
                PreparedStatement ps_vst_med_pro_san_r = bmp.prepareStatement("SELECT cod_vst_med FROM vst_med_pro_san_tab_r WHERE cod_pro_san= ?");
                PreparedStatement ps_ana_rso_COD = bmp.prepareStatement("SELECT a.cod_mis_pet FROM ana_mis_pet_tab_r a, rso_mis_pet_tab_r b WHERE b.cod_rso = ? AND b.cod_mis_pet = a.cod_mis_pet");
                while (i.next()) {
                    //RSO
                    ps_ana_rso.setLong(1, P_COD_AZL);
                    ps_ana_rso.setLong(2, i.getLong(1));
                    rs_ana_rso = ps_ana_rso.executeQuery();
                    if (!rs_ana_rso.next()) {
                        throw new EJBException("DB error");
                    } else {
                        flag_esistenza = rs_ana_rso.getLong(1);
                        rs_ana_rso.close();
                    }
                    V_COD_RSO = NEW_ID() + (counter++);
                    if (flag_esistenza == 0) {
                        ps_ana_rso_INSERT.setLong(1, P_COD_AZL);
                        ps_ana_rso_INSERT.setLong(2, V_COD_RSO);
                        ps_ana_rso_INSERT.setLong(3, i.getLong(1));
                        ps_ana_rso_INSERT.executeUpdate();
                        ps_ana_rso_COD.setLong(1, i.getLong(1));
                        a = ps_ana_rso_COD.executeQuery();
                        while (a.next()) {
                            V_COD_MIS_PET = NEW_ID() + (counter++);
                            ps_mis_pet.setLong(1, V_COD_MIS_PET);
                            ps_mis_pet.setLong(2, P_COD_AZL);
                            ps_mis_pet.setLong(3, V_COD_RSO);
                            ps_mis_pet.setLong(4, i.getLong(1));
                            ps_mis_pet.setLong(5, a.getLong(1));
                            ps_mis_pet.executeUpdate();
                            ps_mis_pet.clearParameters();
                            ps_mis_pet_r.setLong(1, V_COD_MIS_PET);
                            ps_mis_pet_r.setLong(2, a.getLong(1));
                            ps_mis_pet_r.executeUpdate();
                            ps_mis_pet_r.clearParameters();
                        }
                        ps_ana_rso_COD.clearParameters();
                        a.close();
                        ps_dpi.setLong(1, i.getLong(1));
                        b = ps_dpi.executeQuery();
                        while (b.next()) {
                            ps_dpi_rso.setLong(1, b.getLong(1));
                            ps_dpi_rso.setLong(2, V_COD_RSO);
                            ps_dpi_rso.setLong(3, P_COD_AZL);
                            ps_dpi_rso.executeUpdate();
                            ps_dpi_rso.clearParameters();
                        }
                        b.close();
                        ps_dpi.clearParameters();
                        ps_sen.setLong(1, i.getLong(1));
                        c = ps_sen.executeQuery();
                        while (c.next()) {
                            ps_nor_sen_rso.setLong(1, c.getLong(1));
                            ps_nor_sen_rso.setLong(2, V_COD_RSO);
                            ps_nor_sen_rso.setLong(3, P_COD_AZL);
                            ps_nor_sen_rso.executeUpdate();
                            ps_nor_sen_rso.clearParameters();
                        }
                        ps_sen.clearParameters();
                        c.close();
                        ps_cor.setLong(1, i.getLong(1));
                        c = ps_cor.executeQuery();
                        while (c.next()) {
                            ps_cor_rso.setLong(1, c.getLong(1));
                            ps_cor_rso.setLong(2, V_COD_RSO);
                            ps_cor_rso.setLong(3, P_COD_AZL);
                            ps_cor_rso.executeUpdate();
                            ps_cor_rso.clearParameters();
                        }
                        c.close();
                        ps_cor.clearParameters();
                    }
                    ps_pro_san_rso_r.setLong(1, i.getLong(1));
                    e = ps_pro_san_rso_r.executeQuery();
                    while (e.next()) {
                        ps_pro_san_rso_INSERT.setLong(1, e.getLong(1));
                        ps_pro_san_rso_INSERT.setLong(2, V_COD_RSO);
                        ps_pro_san_rso_INSERT.setLong(3, P_COD_AZL);
                        ps_pro_san_rso_INSERT.executeUpdate();
                        ps_pro_san_rso_INSERT.clearParameters();
                        ps_vst_ido_pro_san_r.setLong(1, e.getLong(1));
                        x = ps_vst_ido_pro_san_r.executeQuery();
                        while (x.next()) {
                            ps_vst_ido_count.setLong(1, P_COD_AZL);
                            ps_vst_ido_count.setLong(2, x.getLong(1));
                            rs = ps_vst_ido_count.executeQuery();
                            if (!rs.next()) {
                                throw new EJBException("DB error");
                            } else {
                                conta = rs.getLong(1);
                                rs.close();
                            }
                            if (conta == 0) {
                                V_COD_VST_IDO = NEW_ID() + (counter++);
                                ps_vst_ido_INSERT.setLong(1, V_COD_VST_IDO);
                                ps_vst_ido_INSERT.setLong(2, P_COD_AZL);
                                ps_vst_ido_INSERT.setLong(3, x.getLong(1));
                                ps_vst_ido_INSERT.executeQuery();
                                ps_vst_ido_pro_san_INSERT.setLong(1, e.getLong(1));
                                ps_vst_ido_pro_san_INSERT.setLong(2, x.getLong(1));
                                ps_vst_ido_pro_san_INSERT.executeQuery();
                                ps_vst_ido_pro_san_INSERT.clearParameters();
                                ps_vst_ido_INSERT.clearParameters();
                            } else {
                                ps_vst_ido_pro_san_count.setLong(1, P_COD_AZL);
                                ps_vst_ido_pro_san_count.setLong(2, x.getLong(1));
                                ps_vst_ido_pro_san_count.setLong(3, e.getLong(1));
                                rs = ps_vst_ido_pro_san_count.executeQuery();
                                if (!rs.next()) {
                                    throw new EJBException("DB error");
                                } else {
                                    conta = rs.getLong(1);
                                    rs.close();
                                    if (conta == 0) {
                                        ps_vst_ido_pro_san_INSERT.setLong(1, e.getLong(1));
                                        ps_vst_ido_pro_san_INSERT.setLong(2, x.getLong(1));
                                        ps_vst_ido_pro_san_INSERT.executeQuery();
                                        ps_vst_ido_pro_san_INSERT.clearParameters();
                                    }
                                }
                                ps_vst_ido_pro_san_count.clearParameters();
                            }
                        }
                        x.close();
                        ps_vst_ido_pro_san_r.clearParameters();
                        ps_vst_med_pro_san_r.setLong(1, e.getLong(1));
                        x = ps_vst_med_pro_san_r.executeQuery();
                        while (x.next()) {
                            ps_vst_med_count.setLong(1, P_COD_AZL);
                            ps_vst_med_count.setLong(2, x.getLong(1));
                            rs = ps_vst_med_count.executeQuery();
                            if (!rs.next()) {
                                throw new EJBException("DB error");
                            } else {
                                conta = rs.getLong(1);
                                rs.close();
                            }
                            if (conta == 0) {
                                V_COD_VST_MED = NEW_ID() + (counter++);
                                ps_vst_med_INSERT.setLong(1, V_COD_VST_MED);
                                ps_vst_med_INSERT.setLong(2, P_COD_AZL);
                                ps_vst_med_INSERT.setLong(3, x.getLong(1));
                                ps_vst_med_INSERT.executeQuery();
                                ps_vst_ido_pro_san_INSERT.setLong(1, e.getLong(1));
                                ps_vst_ido_pro_san_INSERT.setLong(2, x.getLong(1));
                                ps_vst_ido_pro_san_INSERT.executeQuery();
                                ps_vst_ido_pro_san_INSERT.clearParameters();
                                ps_vst_ido_INSERT.clearParameters();
                            } else {
                                ps_vst_med_pro_san_count.setLong(1, P_COD_AZL);
                                ps_vst_med_pro_san_count.setLong(2, x.getLong(1));
                                ps_vst_med_pro_san_count.setLong(3, e.getLong(1));
                                rs = ps_vst_med_pro_san_count.executeQuery();
                                if (!rs.next()) {
                                    throw new EJBException("DB error");
                                } else {
                                    conta = rs.getLong(1);
                                    rs.close();
                                    if (conta == 0) {
                                        ps_vst_ido_pro_san_INSERT.setLong(1, e.getLong(1));
                                        ps_vst_ido_pro_san_INSERT.setLong(2, x.getLong(1));
                                        ps_vst_ido_pro_san_INSERT.executeQuery();
                                        ps_vst_ido_pro_san_INSERT.clearParameters();
                                    }
                                }
                                ps_vst_med_pro_san_count.clearParameters();
                            }
                        }
                        x.close();
                        ps_vst_med_pro_san_r.clearParameters();
                    }
                    e.close();
                    ps_pro_san_rso_r.clearParameters();
                    //RSO
                }
                i.close();
                ps.close();
///=================================================================================================================
                ps = bmp.prepareStatement(
                        "SELECT cod_pro_san FROM pro_san_man_tab_r  "
                        + "WHERE cod_man = ? ");
                ps.setLong(1, P_COD_MAN);
                i = ps.executeQuery();
                PreparedStatement ps_vst_ido_pro_san = null;
                PreparedStatement ps_ana_vst_ido = null;
                PreparedStatement ps_vst_ido_tab_1 = null;
                PreparedStatement ps_vst_ido_pro_san_tab = null;
                ps_vst_ido_pro_san = bmp.prepareStatement(
                        "SELECT cod_vst_ido FROM vst_ido_pro_san_tab_r WHERE cod_pro_san = ? ");
                ps_ana_vst_ido = bmp.prepareStatement(
                        "SELECT count(*) FROM ana_vst_ido_tab WHERE cod_azl=? AND cod_vst_ido_rpo = ?");
                ps_vst_ido_tab_1 = bmp.prepareStatement(
                        "INSERT INTO ana_vst_ido_tab (cod_vst_ido,fat_per,per_vst, "
                        + " nom_vst_ido,des_vst_ido, cod_azl, cod_vst_ido_rpo) "
                        + " SELECT  ?, fat_per, per_vst, nom_vst_ido, des_vst_ido, cod_vst_ido"
                        + " FROM  ana_vst_ido_tab_r "
                        + " WHERE  cod_vst_ido = ? ");
                ps_vst_ido_pro_san_tab = bmp.prepareStatement("INSERT INTO vst_ido_pro_san_tab VALUES (? , ? )");
                PreparedStatement ps_vst_med_pro_san = null;
                PreparedStatement ps_ana_vst_med = null;
                PreparedStatement ps_vst_med_tab_1 = null;
                PreparedStatement ps_vst_med_pro_san_tab = null;
                ps_vst_med_pro_san = bmp.prepareStatement("SELECT cod_vst_med FROM vst_med_pro_san_tab_r WHERE cod_pro_san = ?");
                ps_ana_vst_med = bmp.prepareStatement("SELECT count(*) FROM ana_vst_med_tab WHERE cod_azl=? AND cod_vst_med_rpo = ?");
                ps_vst_med_tab_1 = bmp.prepareStatement("INSERT INTO ana_vst_med_tab (cod_vst_med,fat_per,per_vst, "
                        + " nom_vst_med,des_vst_med, cod_azl, cod_vst_med_rpo) "
                        + " SELECT  ?, fat_per, per_vst, nom_vst_med, des_vst_med, cod_vst_med"
                        + " FROM  ana_vst_med_tab_r "
                        + " WHERE  cod_vst_med =?");
                ps_vst_med_pro_san_tab = bmp.prepareStatement("INSERT INTO vst_med_pro_san_tab VALUES (?,? )");
                ResultSet vst = null;
                while (i.next()) {
                    ps_vst_ido_pro_san.setLong(1, i.getLong(1));
                    ResultSet z = ps_vst_ido_pro_san.executeQuery();
                    while (z.next()) {
                        ps_ana_vst_ido.setLong(1, P_COD_AZL);
                        ps_ana_vst_ido.setLong(2, z.getLong(1));
                        vst = ps_ana_vst_ido.executeQuery();
                        if (vst.next()) {
                            conta1 = vst.getLong(1);
                            if (conta1 == 0) {
                                V_COD_VST_IDO = NEW_ID() + (counter++);
                                ps_vst_ido_tab_1.setLong(1, V_COD_VST_IDO);
                                ps_vst_ido_tab_1.setLong(2, P_COD_AZL);
                                ps_vst_ido_tab_1.setLong(3, z.getLong(1));
                                ResultSet vst_1 = ps_vst_ido_tab_1.executeQuery();
                                ps_vst_ido_pro_san_tab.setLong(1, i.getLong(1));
                                ps_vst_ido_pro_san_tab.setLong(2, z.getLong(1));
                                ResultSet vst_ido_pro_san = ps_vst_ido_pro_san_tab.executeQuery();
                                ps_vst_ido_pro_san_tab.clearParameters();
                                ps_vst_ido_tab_1.clearParameters();
                            }
                        }
                        ps_ana_vst_ido.clearParameters();
                        vst.close();
                    }
                    ps_vst_ido_pro_san.clearParameters();
                    z.close();
                    ps_vst_med_pro_san.setLong(1, i.getLong(1));
                    ResultSet h = ps_vst_med_pro_san.executeQuery();
                    while (h.next()) {
                        ps_ana_vst_med.setLong(1, P_COD_AZL);
                        ps_ana_vst_med.setLong(2, h.getLong(1));
                        vst = ps_ana_vst_med.executeQuery();
                        if (vst.next()) {
                            conta1 = vst.getLong(1);
                            if (conta1 == 0) {
                                V_COD_VST_MED = NEW_ID() + (counter++);
                                ps_vst_med_tab_1.setLong(1, V_COD_VST_MED);
                                ps_vst_med_tab_1.setLong(2, P_COD_AZL);
                                ps_vst_med_tab_1.setLong(3, h.getLong(1));
                                ResultSet vst_1 = ps_vst_med_tab_1.executeQuery();
                                ps_vst_med_pro_san_tab.setLong(1, i.getLong(1));
                                ps_vst_med_pro_san_tab.setLong(2, h.getLong(1));
                                ResultSet vst_med_pro_san = ps_vst_med_pro_san_tab.executeQuery();
                                ps_vst_med_pro_san_tab.clearParameters();
                                ps_vst_med_tab_1.clearParameters();
                            }
                        }
                        ps_ana_vst_med.clearParameters();
                        vst.close();
                    }
                }
                i.close();
                ps.close();
///=================================================================================================================
            } else {
                result = false;
            }
            conn.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            result = false;
            try {
                conn.rollback();
            } catch (Exception ex1) {
                ex1.printStackTrace();
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
                ex2.printStackTrace();
            }
        }
        return result;
    }
    //  =====================================================================================

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            String strDES_MAN,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(lCOD_AZL, strNOM_MAN, strDES_RSP_COM, strNOTE, strDES_MAN, iOrderParameter);
    }
    //

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strNOM_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            String strDES_MAN,
            int iOrderParameter /*not used for now*/) {
        String strSql = " SELECT  cod_man, nom_man, des_man, des_rsp_com, note FROM ana_man_tab WHERE cod_azl = ? AND   ";

        if (strNOM_MAN != null) {
            strSql += " UPPER(nom_man) LIKE ? AND   ";
        }
        if (strDES_RSP_COM != null) {
            strSql += " UPPER(des_rsp_com) LIKE ? AND   ";
        }
        if (strNOTE != null) {
            strSql += " UPPER(note) LIKE ? AND   ";
        }
        if (strDES_MAN != null) {
            strSql += " UPPER(des_man) LIKE ?  AND   ";
        }
        strSql = strSql.substring(1, strSql.length() - 6);
        // sorting by name
        strSql += " ORDER BY UPPER(nom_man)";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strNOM_MAN != null) {
                ps.setString(i++, strNOM_MAN.toUpperCase());
            }
            if (strDES_RSP_COM != null) {
                ps.setString(i++, strDES_RSP_COM.toUpperCase());
            }
            if (strNOTE != null) {
                ps.setString(i++, strNOTE.toUpperCase());
            }
            if (strDES_MAN != null) {
                ps.setString(i++, strDES_MAN.toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorative_Name_View v = new AttivitaLavorative_Name_View();
                v.COD_MAN = rs.getLong(1);
                v.NOM_MAN = rs.getString(2);
                ar.add(v);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }

    //=====================================================
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//  MULTIAZIENDA BY Alex
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//<alex date="13/04/2004">
    //--------------------------
    //-----------------------------
    public String ejbAddMacchinaToOperazioneSvolta(long lCOD_AZL, long lCOD_MAC, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList ID_MAN) {
        BMPConnection bmp = getConnection();
        String g_res = "";
        String res = "";
        java.util.ArrayList cCOD_RSO;
        Iterator it, it_rso;

        try {
            bmp.beginTrans();
            g_res += "add macchina to ope svo ...<br>";
            res = private_method.addMacchinaAssocToOperazione(lCOD_MAC, lCOD_OPE_SVO, bmp);
            if (res.indexOf("FAILED") != -1) {
                bmp.rollbackTrans();
                throw new Exception(g_res + "&nbsp;Non e' possibile aggiungere Macchina a ope svo;\nCOD_MAC=" + lCOD_MAC + ";\n" + "COD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
            } else {
                g_res += "add macchina to ope svo ... OK<br>";
            }
            g_res += res;
            //----get rischi of macchina ---
            g_res += "getting rischi of macchina...";
            cCOD_RSO = private_method.getMacchinaRischi(lCOD_MAC, lCOD_AZL, bmp);
            g_res += "getting rischi of macchina...OK";
            it_rso = cCOD_RSO.iterator();
            if (it_rso != null) {
                g_res += "adding rischi of macchina to ope svo and attivita lavorative";
                while (it_rso.hasNext()) {
                    long lCOD_RSO = ((Long) it_rso.next()).longValue();
                    g_res += "&nbsp;&nbsp;add risc to ope svo<br>";
                    res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);
                    if (res.indexOf("FAILED") != -1) {
                        bmp.rollbackTrans();
                        throw new Exception(g_res + "&nbsp;&nbsp;Non e' possibile aggiungere Rischio a ope svo;\nCOD_RSO=" + lCOD_RSO + ";\nCOD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
                    } else {
                        g_res += res + "&nbsp;&nbsp;add risc to ope svo ... OK<br>";
                    }
                    g_res += "&nbsp;&nbsp;add risc to attivita lav list <br>";
                    res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lCOD_AZL, ID_MAN, bmp);

                    if (res.indexOf("FAILED") != -1) {
                        bmp.rollbackTrans();
                        //throw new Exception(g_res);
                        throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                    } else {
                        g_res += "&nbsp;&nbsp;add risc to attivita lav list ...OK<br>";
                    }
                }
                g_res += "adding rischi of macchina to ope svo and attivita lavorative...OK";

            }
            //------multiazienda -----------
            if (AZIENDA_ID != null) {
                it = AZIENDA_ID.iterator();
                long lNEW_COD_AZL = 0;
                g_res += "<br>Begin multiazienda<br>";
                if (it != null) {
                    while (it.hasNext()) {
                        lNEW_COD_AZL = ((Long) it.next()).longValue();
                        g_res += "<br>Azienda -" + lNEW_COD_AZL;
                        //---- if macchina exists in azienda ---
                        long newCOD_MAC = private_method.isIncludedMacchinaToAzienda(lCOD_MAC, lCOD_AZL, lNEW_COD_AZL, AZIENDA_ID, bmp);
                        g_res += "<br>isIncludedMacchinaToAzienda( lCOD_MAC -" + lCOD_MAC + ",  lCOD_AZL - " + lCOD_AZL + ", lNEW_COD_AZL - " + lNEW_COD_AZL + ", ID_AZIENDE - " + AZIENDA_ID + ", bmp);";
                        g_res += "new cod_mac - " + newCOD_MAC;
                        if (newCOD_MAC != 0) {
                            //----- ADD MACCHINA TO OPE SVO IN CURRENT AZIENDA ----
                            g_res += "add macchina to ope svo ...<br>";
                            res = private_method.addMacchinaAssocToOperazione(newCOD_MAC, lCOD_OPE_SVO, bmp);
                            if (res.indexOf("FAILED") != -1) {
                                bmp.rollbackTrans();
                                throw new Exception(g_res + "&nbsp;Non e' possibile aggiungere Macchina a ope svo;\nCOD_MAC=" + lCOD_MAC + ";\n" + "COD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
                            } else {
                                g_res += "add macchina to ope svo ... OK<br>";
                            }
                            g_res += res;
                            // get attivita lavorative exists in current azienda
                            Iterator it_man = ID_MAN.iterator();
                            java.util.ArrayList IDS_MAN = new java.util.ArrayList();
                            g_res += "<br>&nbsp;&nbsp;getting list of attivita lav for azienda" + lNEW_COD_AZL;
                            while (it_man.hasNext()) {
                                long lCOD_MAN_ = ((Long) it_man.next()).longValue();
                                g_res += "<br>&nbsp;&nbsp;check for attivita lav " + lCOD_MAN_;
                                long newCOD_MAN = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, lNEW_COD_AZL, lCOD_MAN_, AZIENDA_ID, bmp);
                                if (newCOD_MAN != 0) {
                                    IDS_MAN.add(new Long(newCOD_MAN));
                                    g_res += "<br>&nbsp;&nbsp;...lCOD_MAN" + lCOD_MAN_ + " included as " + newCOD_MAN + " in azl " + lNEW_COD_AZL;
                                }
                            }
                            it_rso = cCOD_RSO.iterator();
                            if (it_rso != null) {
                                g_res += "<br>adding rischi to ope svo and attivita lav";
                                while (it_rso.hasNext()) {
                                    long newCOD_RSO = ((Long) it_rso.next()).longValue();
                                    //----if risk is included in new azienda
                                    if (!private_method.isIncludedRiskToAzienda(lNEW_COD_AZL, newCOD_RSO, bmp)) {
                                        g_res += "...not included risc -" + newCOD_RSO + "to azienda";
                                        continue;
                                    }
                                    g_res += "<br>... included risc -" + newCOD_RSO + "to azienda";
                                    g_res += "<br>&nbsp;&nbsp;add risc to ope svo";


                                    res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, newCOD_RSO, lNEW_COD_AZL, bmp);
                                    if (res.indexOf("FAILED") != -1) {
                                        bmp.rollbackTrans();
                                        throw new Exception(g_res + "&nbsp;&nbsp;Non e' possibile aggiungere Rischio a ope svo;\nCOD_RSO=" + newCOD_RSO + ";\nCOD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
                                    } else {
                                        g_res += res + "&nbsp;&nbsp;add risc to ope svo ... OK<br>";
                                    }
                                    g_res += "&nbsp;&nbsp;add risc to attivita lav list <br>";
                                    res = private_method.addRiscToAttivitaLavorativeList(newCOD_RSO, lNEW_COD_AZL, IDS_MAN, bmp);

                                    if (res.indexOf("FAILED") != -1) {
                                        bmp.rollbackTrans();
                                        //throw new Exception(g_res);
                                        throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + newCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                                    } else {
                                        g_res += "&nbsp;&nbsp;add risc to attivita lav list ...OK<br>";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            g_res += "<hr>";
            for (int i = 0; i < trace.length; i++) {
                g_res += "<br>" + trace[i].toString();
            }
            g_res += "<br>" + ex.toString() + "...FAILED";
            //throw new EJBException(ex);
        } finally {
            try {
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return g_res;
    }

    //---------add Sostanza chimica to operazione svolta
    public String ejbAddSostanzaToOperazioneSvolta(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList ID_MAN) {
        BMPConnection bmp = getConnection();
        String g_res = "";
        String res = "";
        java.util.ArrayList cCOD_RSO;
        Iterator it, it_rso;

        try {
            bmp.beginTrans();
            //---------monoazienda ------------
            g_res += "add sostanza to ope svo ...<br>";
            res = private_method.addSostanzaAssocToOperazione(lCOD_SOS_CHI, lCOD_OPE_SVO, bmp);
            if (res.indexOf("FAILED") != -1) {
                bmp.rollbackTrans();
                throw new Exception(g_res + "&nbsp;Non e' possibile aggiungere sostanza a ope svo;\nCOD_MAC=" + lCOD_SOS_CHI + ";\n" + "COD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
            } else {
                g_res += "add sostanza to ope svo ... OK<br>";
            }
            g_res += res;
            //----get rischi of macchina ---
            g_res += "getting rischi of sostanza...";
            cCOD_RSO = private_method.getSostanzaRischi(lCOD_SOS_CHI, lCOD_AZL, bmp);
            g_res += "getting rischi of sostanza...OK";
            it_rso = cCOD_RSO.iterator();
            if (it_rso != null) {
                g_res += "adding rischi of sostanza to ope svo and attivita lavorative";
                while (it_rso.hasNext()) {
                    long lCOD_RSO = ((Long) it_rso.next()).longValue();
                    g_res += "&nbsp;&nbsp;add risc to ope svo<br>";
                    res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);
                    if (res.indexOf("FAILED") != -1) {
                        bmp.rollbackTrans();
                        throw new Exception(g_res + "&nbsp;&nbsp;Non e' possibile aggiungere Rischio a ope svo;\nCOD_RSO=" + lCOD_RSO + ";\nCOD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
                    } else {
                        g_res += res + "&nbsp;&nbsp;add risc to ope svo ... OK<br>";
                    }
                    g_res += "&nbsp;&nbsp;add risc to attivita lav list <br>";
                    res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lCOD_AZL, ID_MAN, bmp);

                    if (res.indexOf("FAILED") != -1) {
                        bmp.rollbackTrans();
                        throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                    } else {
                        g_res += "&nbsp;&nbsp;add risc to attivita lav list ...OK<br>";
                    }
                }
                g_res += "adding rischi of sostanza to ope svo and attivita lavorative...OK";

            }
            //------multiazienda
            if (AZIENDA_ID != null) {
                it = AZIENDA_ID.iterator();
                long lNEW_COD_AZL = 0;
                g_res += "<br>Begin multiazienda<br>";
                if (it != null) {
                    while (it.hasNext()) {
                        lNEW_COD_AZL = ((Long) it.next()).longValue();
                        g_res += "<br>Azienda -" + lNEW_COD_AZL;
                        // get attivita lavorative exists in current azienda
                        Iterator it_man = ID_MAN.iterator();
                        java.util.ArrayList IDS_MAN = new java.util.ArrayList();
                        g_res += "<br>&nbsp;&nbsp;getting list of attivita lav for azienda" + lNEW_COD_AZL;
                        while (it_man.hasNext()) {
                            long lCOD_MAN_ = ((Long) it_man.next()).longValue();
                            g_res += "<br>&nbsp;&nbsp;check for attivita lav " + lCOD_MAN_;
                            long newCOD_MAN = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, lNEW_COD_AZL, lCOD_MAN_, AZIENDA_ID, bmp);
                            if (newCOD_MAN != 0) {
                                IDS_MAN.add(new Long(newCOD_MAN));
                                g_res += "<br>&nbsp;&nbsp;...lCOD_MAN" + lCOD_MAN_ + " included as " + newCOD_MAN + " in azl " + lNEW_COD_AZL;
                            }
                        }
                        it_rso = cCOD_RSO.iterator();
                        if (it_rso != null) {
                            g_res += "<br>adding rischi to ope svo and attivita lav";
                            while (it_rso.hasNext()) {
                                long newCOD_RSO = ((Long) it_rso.next()).longValue();
                                //----if risk is included in new azienda
                                if (!private_method.isIncludedRiskToAzienda(lNEW_COD_AZL, newCOD_RSO, bmp)) {
                                    g_res += "...not included risc -" + newCOD_RSO + "to azienda";
                                    continue;
                                }
                                g_res += "<br>... included risc -" + newCOD_RSO + "to azienda";
                                g_res += "<br>&nbsp;&nbsp;add risc to ope svo";

                                res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, newCOD_RSO, lNEW_COD_AZL, bmp);
                                if (res.indexOf("FAILED") != -1) {
                                    bmp.rollbackTrans();
                                    throw new Exception(g_res + "&nbsp;&nbsp;Non e' possibile aggiungere Rischio a ope svo;\nCOD_RSO=" + newCOD_RSO + ";\nCOD_OPE_SVO=" + lCOD_OPE_SVO + ";\n Original exception:\n" + res);
                                } else {
                                    g_res += res + "&nbsp;&nbsp;add risc to ope svo ... OK<br>";
                                }
                                g_res += "&nbsp;&nbsp;add risc to attivita lav list <br>";
                                res = private_method.addRiscToAttivitaLavorativeList(newCOD_RSO, lNEW_COD_AZL, IDS_MAN, bmp);

                                if (res.indexOf("FAILED") != -1) {
                                    bmp.rollbackTrans();
                                    //throw new Exception(g_res);
                                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + newCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                                } else {
                                    g_res += "&nbsp;&nbsp;add risc to attivita lav list ...OK<br>";
                                }
                            }
                        }
                    }
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            g_res += "<hr>";
            for (int i = 0; i < trace.length; i++) {
                g_res += "<br>" + trace[i].toString();
            }
            g_res += "<br>" + ex.toString() + "...FAILED";
        } finally {
            try {
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return g_res;
    }

    //</alex>
    //=====================================================
    //<alex date="06/04/2004" last_update="07/04/2004" descr="main function to add rischio in sos_chi">
    public String ejbAddRischioToSostanzeChimiche(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO) {
        BMPConnection bmp = getConnection();
        String g_res = "";
        String res = "";
        java.util.ArrayList cCOD_OPE_SVO = null;
        java.util.ArrayList cCOD_LUO_FSC = null;
        //java.util.ArrayList cCOD_MAN=null;
        Iterator it;
        try {

            bmp.beginTrans();
            g_res += "begin trans<br>";
            // azienda corrente -----------------------------------------

            // add rischio to sostanza chimica
            res = private_method.addRischioToSostanza(lCOD_SOS_CHI, lCOD_RSO, lCOD_AZL, strTPL_CLF_RSO, bmp);
            g_res += "addRischioToSostanza<br>";
            if (res.indexOf("FAILED") != -1) {
                bmp.rollbackTrans();
                throw new Exception(g_res + "&nbsp;Non e' possibile aggiungere rischio sostanza chimica;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n Original exception:\n" + res);
            }
            g_res += res;
            if (strTPL_CLF_RSO.equals("O") || strTPL_CLF_RSO.equals("O/T")) {
                g_res += "rischio classification: O; O/T<br>";
                // get ope svo where exists sos_chi
                cCOD_OPE_SVO = private_method.getOperazioneSvoltaBySostanza(lCOD_SOS_CHI, ID_MAN, bmp);
                g_res += "getOperazioneSvoltaBySostanza<br>";
                it = cCOD_OPE_SVO.iterator();
                g_res += "start adding rischi to ope svo<br>";
                if (it != null) {
                    while (it.hasNext()) {
                        long lCOD_OPE_SVO = ((Long) it.next()).longValue();

                        // add rischio to ope svo, where uses sostanza chimica
                        res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);
                        g_res += "add rischio to ope svo " + lCOD_OPE_SVO + "<br>";
                        if (res.indexOf("FAILED") != -1) {
                            bmp.rollbackTrans();
                            throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad operazione svolta;\n COD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n COD_OPE_SVO=" + lCOD_OPE_SVO + ";\n<br>Original exception:\n" + res);
                        }
                    }
                } else {
                    return g_res;
                }

                // add rischio to attivita' lavorative from list selected
                res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lCOD_AZL, ID_MAN, bmp);
                g_res += "add rischio to attivita lav list <br>";
                g_res += res;
                if (res.indexOf("FAILED") != -1) {
                    bmp.rollbackTrans();
                    //throw new Exception(g_res);
                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                }
            }
            if (strTPL_CLF_RSO.equals("T") || strTPL_CLF_RSO.equals("O/T")) {
                g_res += "rischio classification: T; O/T<br>";
                // add rischio to luogo fisico from list selected
                g_res += "add rischio to luo fsc list <br>";

                res = private_method.addRiscToLuoghiList(lCOD_RSO, lCOD_AZL, ID_LUO, bmp);

                g_res += res;
                if (res.indexOf("FAILED") != -1) {
                    bmp.rollbackTrans();
                    //throw new Exception(g_res);
                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                }
                g_res += "add rischio to luo fsc list ..OK<br>";
            }
            // multiazienda -----------------

            if (ID_AZIENDE != null) {
                it = ID_AZIENDE.iterator();
                long lNEW_COD_AZL = 0;
                g_res += "<br>Begin multiazienda<br>";
                if (it != null) {
                    while (it.hasNext()) {
                        lNEW_COD_AZL = ((Long) it.next()).longValue();
                        // control of existence of risk in another azienda from list selected

                        if (private_method.isIncludedRiskToAzienda(lNEW_COD_AZL, lCOD_RSO, bmp)) {
                            g_res += "<br>&nbsp;&nbsp;<br>rischio is included to - azienda" + lNEW_COD_AZL;
                            // add rischio to sostanza for current azienda
                            g_res += "<br>addRischioToSostanza( " + lCOD_SOS_CHI + ", " + lCOD_RSO + ",  " + lNEW_COD_AZL + ",  " + strTPL_CLF_RSO + "," + bmp + ");";
                            g_res += "<br>&nbsp;&nbsp;adding rischio to sostanza in azienda - " + lNEW_COD_AZL;
                            res = private_method.addRischioToSostanza(lCOD_SOS_CHI, lCOD_RSO, lNEW_COD_AZL, strTPL_CLF_RSO, bmp);
                            g_res += "<br>&nbsp;" + res;
                            g_res += "<br>" + res.indexOf("FAILED");
                            if (res.indexOf("FAILED") != -1) {
                                bmp.rollbackTrans();
                                throw new Exception(g_res + "<br>..........Non e' possibile aggiungere rischio sostanza chimica;\nCOD_RSO=" + lCOD_RSO + ";\n COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                            }
                            //g_res+=res;
                            if (strTPL_CLF_RSO.equals("O") || strTPL_CLF_RSO.equals("O/T")) {
                                // get attivita lavorative exists in current azienda
                                Iterator it_man = ID_MAN.iterator();
                                java.util.ArrayList IDS_MAN = new java.util.ArrayList();
                                g_res += "<br>&nbsp;&nbsp;getting list of attivita lav for azienda" + lNEW_COD_AZL;

                                while (it_man.hasNext()) {
                                    long lCOD_MAN_ = ((Long) it_man.next()).longValue();
                                    g_res += "<br>&nbsp;&nbsp;check for attivita lav " + lCOD_MAN_;
                                    long newCOD_MAN = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, lNEW_COD_AZL, lCOD_MAN_, ID_AZIENDE, bmp);
                                    if (newCOD_MAN != 0) {
                                        IDS_MAN.add(new Long(newCOD_MAN));
                                        g_res += "<br>&nbsp;&nbsp;...lcod_man" + lCOD_MAN_ + " included as " + newCOD_MAN + " in azl " + lNEW_COD_AZL;
                                    }
                                }
                                // add rischio to ope svo, where uses sostanza chimica
                                g_res += "<br>&nbsp;&nbsp;getting ope svo by sostanza " + lCOD_SOS_CHI + " for azl - " + lNEW_COD_AZL;
                                cCOD_OPE_SVO = private_method.getOperazioneSvoltaBySostanza(lCOD_SOS_CHI, IDS_MAN, bmp);
                                g_res += "<br>&nbsp;&nbsp;get ope svo by sostanza " + lCOD_SOS_CHI + " for azl - " + lNEW_COD_AZL;
                                Iterator it_ope = cCOD_OPE_SVO.iterator();
                                if (it_ope != null) {
                                    g_res += "<br>&nbsp;&nbsp;&nbsp;start adding rischi to ope svo for azl - " + lNEW_COD_AZL;
                                    while (it_ope.hasNext()) {
                                        long lCOD_OPE_SVO = ((Long) it_ope.next()).longValue();
                                        res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lNEW_COD_AZL, bmp);
                                        g_res += "<br>&nbsp;&nbsp;&nbsp;...rischio added  to ope svo -" + lCOD_OPE_SVO + "  for azl - " + lNEW_COD_AZL;
                                        if (res.indexOf("FAILED") != -1) {
                                            bmp.rollbackTrans();
                                            throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad operazione svolta;\n COD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                                        }
                                    }
                                }
                                // add rischio to attivita' lavorative from list selected
                                res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lNEW_COD_AZL, IDS_MAN, bmp);
                                g_res += "<br> add rischi to attivita lav for azl - " + lNEW_COD_AZL;

                                if (res.indexOf("FAILED") != -1) {
                                    bmp.rollbackTrans();
                                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                                }
                            }
                            if (strTPL_CLF_RSO.equals("T") || strTPL_CLF_RSO.equals("O/T")) {
                                //- get list of luoghi fisici in current azienda which uses sostanza
                                g_res += "get luo_fsc list";
                                cCOD_LUO_FSC = private_method.getLuoghiFisichiBySostanza(lCOD_SOS_CHI, lNEW_COD_AZL, bmp);
                                Iterator it_luo = cCOD_LUO_FSC.iterator();
                                if (it_luo != null) {
                                    // add rischio to luogo fisico from list selected
                                    g_res += "get luo_fsc list ...OK, != null";
                                    res = private_method.addRiscToLuoghiList(lCOD_RSO, lNEW_COD_AZL, cCOD_LUO_FSC, bmp);
                                    g_res += res;
                                    if (res.indexOf("FAILED") != -1) {
                                        bmp.rollbackTrans();
                                        //throw new Exception(g_res);
                                        throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                                    }
                                    g_res += "add rischio to luo_fsc list ..OK<br>";
                                }
                            }
                            g_res += res;
                        } else {
                            continue;
                        }
                    }
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            g_res += "<hr>";
            for (int i = 0; i < trace.length; i++) {
                g_res += "<br>" + trace[i].toString();
            }
            g_res += "<br>" + ex.toString() + "..FAILED";
            //throw new EJBException(ex);
        } finally {
            try {
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return g_res;
    }
    //<alex date="13/04/2004">

    public String ejbAddRischioToMacchina(long lCOD_AZL, long lCOD_MAC, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO) {
        BMPConnection bmp = getConnection();
        String g_res = "";
        String res = "";
        java.util.ArrayList cCOD_OPE_SVO = null;
        java.util.ArrayList cCOD_RSO = null;
        java.util.ArrayList cCOD_LUO_FSC = null;
        Iterator it;
        try {
            bmp.beginTrans();
            //-----* current azienda ------------------//

            //-----* add rischio to sostanza chimica --//
            res = private_method.addRischioToMacchina(lCOD_MAC, lCOD_RSO, lCOD_AZL, strTPL_CLF_RSO, bmp);
            g_res += "addRischioTo Macchina<br>";
            if (res.indexOf("FAILED") != -1) {
                bmp.rollbackTrans();
                throw new Exception(g_res + "&nbsp;Non e' possibile aggiungere rischio alla macchina;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n Original exception:\n" + res);
            }
            g_res += res;
            if (strTPL_CLF_RSO.equals("O") || strTPL_CLF_RSO.equals("O/T")) {
                g_res += "risc to O; O/T<br>";
                //-----* get ope svo where uses macchina ---//
                g_res += "getting operazione svolta by macchina<br>";
                cCOD_OPE_SVO = private_method.getOperazioneSvoltaByMacchina(lCOD_MAC, ID_MAN, bmp);
                g_res += "<br>getting operazione svolta by macchina ...OK";
                it = cCOD_OPE_SVO.iterator();
                g_res += "start adding rischi to ope svo<br>";
                if (it != null) {
                    while (it.hasNext()) {
                        long lCOD_OPE_SVO = ((Long) it.next()).longValue();
                        // add rischio to ope svo, where uses macchina
                        res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);
                        g_res += "add rischio to ope svo " + lCOD_OPE_SVO + "<br>" + res;

                        if (res.indexOf("FAILED") != -1) {
                            bmp.rollbackTrans();
                            throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad operazione svolta;\n COD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n COD_OPE_SVO=" + lCOD_OPE_SVO + ";\n<br>Original exception:\n" + res);
                        }
                    }
                } else {
                    return g_res;
                }
                // add rischio to attivita' lavorative from list selected
                g_res += "add rischio to attivita lav list <br>";
                res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lCOD_AZL, ID_MAN, bmp);
                g_res += res;
                if (res.indexOf("FAILED") != -1) {
                    bmp.rollbackTrans();
                    //throw new Exception(g_res);
                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                }
            }
            if (strTPL_CLF_RSO.equals("T") || strTPL_CLF_RSO.equals("O/T")) {
                g_res += "risc to T; O/T<br>";
                // add rischio to luogo fisico from list selected
                res = private_method.addRiscToLuoghiList(lCOD_RSO, lCOD_AZL, ID_LUO, bmp);
                g_res += "add rischio to attivita lav list <br>";
                g_res += res;
                if (res.indexOf("FAILED") != -1) {
                    bmp.rollbackTrans();
                    //throw new Exception(g_res);
                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                }
            }
            // ---- multiazienda -----
            if (ID_AZIENDE != null) {
                it = ID_AZIENDE.iterator();
                long lNEW_COD_AZL = 0;
                g_res += "<br>Begin multiazienda<br>";
                if (it != null) {
                    while (it.hasNext()) {

                        lNEW_COD_AZL = ((Long) it.next()).longValue();
                        g_res += "<br>Azienda -" + lNEW_COD_AZL;
                        // --- check for risk in azienda -----
                        if (!private_method.isIncludedRiskToAzienda(lNEW_COD_AZL, lCOD_RSO, bmp)) {
                            g_res += "...not included to risc -" + lCOD_RSO + "to azienda";
                            continue;
                        } else {
                            g_res += "...included to risc -" + lCOD_RSO + "to azienda";
                        }
                        //---- if macchina exists in azienda ---

                        long newCOD_MAC = private_method.isIncludedMacchinaToAzienda(lCOD_MAC, lCOD_AZL, lNEW_COD_AZL, ID_AZIENDE, bmp);
                        g_res += "isIncludedMacchinaToAzienda( lCOD_MAC -" + lCOD_MAC + ",  lCOD_AZL - " + lCOD_AZL + ", lNEW_COD_AZL - " + lNEW_COD_AZL + ", ID_AZIENDE - " + ID_AZIENDE + ", bmp);";

                        if (newCOD_MAC != 0) {
                            g_res += "<br>&nbsp;&nbsp;adding rischio to macchina in azienda - " + lNEW_COD_AZL;
                            res = private_method.addRischioToMacchina(newCOD_MAC, lCOD_RSO, lNEW_COD_AZL, strTPL_CLF_RSO, bmp);
                            g_res += "<br>&nbsp;" + res;
                            if (res.indexOf("FAILED") != -1) {
                                bmp.rollbackTrans();
                                throw new Exception(g_res + "<br>..........Non e' possibile aggiungere rischio a macchina;\nCOD_RSO=" + lCOD_RSO + ";\n COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                            }
                            if (strTPL_CLF_RSO.equals("O") || strTPL_CLF_RSO.equals("O/T")) {
                                // get attivita lavorative exists in current azienda
                                Iterator it_man = ID_MAN.iterator();
                                java.util.ArrayList IDS_MAN = new java.util.ArrayList();
                                g_res += "<br>&nbsp;&nbsp;getting list of attivita lav for azienda" + lNEW_COD_AZL;
                                while (it_man.hasNext()) {
                                    long lCOD_MAN_ = ((Long) it_man.next()).longValue();
                                    g_res += "<br>&nbsp;&nbsp;check for attivita lav " + lCOD_MAN_;
                                    long newCOD_MAN = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, lNEW_COD_AZL, lCOD_MAN_, ID_AZIENDE, bmp);
                                    if (newCOD_MAN != 0) {
                                        IDS_MAN.add(new Long(newCOD_MAN));
                                        g_res += "<br>&nbsp;&nbsp;...lCOD_MAN" + lCOD_MAN_ + " included as " + newCOD_MAN + " in azl " + lNEW_COD_AZL;
                                    }
                                }
                                // add rischio to ope svo, where uses sostanza chimica
                                g_res += "<br>&nbsp;&nbsp;getting ope svo by macchina " + lCOD_MAC + " for azl - " + lNEW_COD_AZL;
                                cCOD_OPE_SVO = private_method.getOperazioneSvoltaByMacchina(lCOD_MAC, IDS_MAN, bmp);
                                g_res += "<br>&nbsp;&nbsp;get ope svo by macchina " + lCOD_MAC + " for azl - " + lNEW_COD_AZL;
                                Iterator it_ope = cCOD_OPE_SVO.iterator();
                                if (it_ope != null) {
                                    g_res += "<br>&nbsp;&nbsp;&nbsp;start adding rischi to ope svo for azl - " + lNEW_COD_AZL;
                                    while (it_ope.hasNext()) {
                                        long lCOD_OPE_SVO = ((Long) it_ope.next()).longValue();
                                        res = private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lNEW_COD_AZL, bmp);
                                        g_res += "<br>&nbsp;&nbsp;&nbsp;...rischio added  to ope svo -" + lCOD_OPE_SVO + "  for azl - " + lNEW_COD_AZL;
                                        if (res.indexOf("FAILED") != -1) {
                                            bmp.rollbackTrans();
                                            throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad operazione svolta;\n COD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                                        }
                                    }
                                }
                                //-----------
                                // add rischio to attivita' lavorative from list selected
                                res = private_method.addRiscToAttivitaLavorativeList(lCOD_RSO, lNEW_COD_AZL, IDS_MAN, bmp);
                                g_res += "<br> add rischi to attivita lav for azl - " + lNEW_COD_AZL;

                                if (res.indexOf("FAILED") != -1) {
                                    bmp.rollbackTrans();
                                    throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lNEW_COD_AZL + ";\n Original exception:\n" + res);
                                }
                            }
                            if (strTPL_CLF_RSO.equals("T") || strTPL_CLF_RSO.equals("O/T")) {
                                //- get list of luoghi fisici in current azienda which uses macchina
                                g_res += "get luo_fsc list";
                                cCOD_LUO_FSC = private_method.getLuoghiFisichiByMacchina(newCOD_MAC, lNEW_COD_AZL, bmp);
                                Iterator it_luo = cCOD_LUO_FSC.iterator();
                                if (it_luo != null) {
                                    // add rischio to luogo fisico from list selected
                                    g_res += "get luo_fsc list ...OK, != null";
                                    res = private_method.addRiscToLuoghiList(lCOD_RSO, lNEW_COD_AZL, cCOD_LUO_FSC, bmp);
                                    g_res += res;
                                    if (res.indexOf("FAILED") != -1) {
                                        bmp.rollbackTrans();
                                        //throw new Exception(g_res);
                                        throw new Exception(g_res + "<br>Non e' possibile aggiungere rischio ad attivita lavorativa;\nCOD_RSO=" + lCOD_RSO + ";\n" + "COD_AZL=" + lCOD_AZL + ";\n <br>Original exception:\n" + res);
                                    }
                                    g_res += "add rischio to luo_fsc list ..OK<br>";
                                }
                            }
                            g_res += res;
                        } else {
                            g_res += "<br>Macchina not included to risk";
                        }
                    }

                } else {
                    g_res += "no aziende";
                }
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            StackTraceElement[] trace = ex.getStackTrace();
            g_res += "<hr>";
            for (int i = 0; i < trace.length; i++) {
                g_res += "<br>" + trace[i].toString();
            }
            g_res += "<br>" + ex.toString() + "...FAILED";
            //throw new EJBException(ex);
        } finally {
            try {
                bmp.close();
            } catch (Exception ex2) {
            }
        }
        return g_res;
    }
    //---------------
    //----------------------------------------------------
    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    /*	*date:06/04/2004 *author:Roman Chumachenko
    Adding of Risc Association to Operaziona Svolta with parameters (EX-ed mode)
    (supporting one transaction)
     */

    public String EXaddAssociationOfRiscToOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAN,
            long lCOD_AZL,
            long lCOD_RSO,
            java.util.ArrayList COD_MAN_LIST,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXaddAssociationOfRiscToOperazionaSvolta(
                lCOD_OPE_SVO, lCOD_MAN, lCOD_AZL, lCOD_RSO, COD_MAN_LIST, COD_AZL_LIST);
    }
    //

    public String ejbEXaddAssociationOfRiscToOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAN,
            long lCOD_AZL,
            long lCOD_RSO,
            java.util.ArrayList COD_MAN_LIST,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 adding of Risc assotiation to Operaziona Svolta
            result = "Risk 1 " + private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);

            //2 adding of Risc assotiation to Attivita Lavorative List (if exists) loop()
            if (COD_MAN_LIST != null) {
                result += "COD_MAN_LIST";
                // -
                //3 adding of Risc assotiation to current Attivita Lavorativa (if exists)
                //if(lCOD_MAN!=0){result=this.addExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, bmp, lCOD_MAN);}
                // -
                Iterator it_att = COD_MAN_LIST.iterator();
                while (it_att.hasNext()) {
                    long cod_man = ((Long) it_att.next()).longValue();
                    //result+=" <br>"+new Long(cod_man).toString();
                    result = private_method.addExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, bmp, cod_man);
                }// while
            }// if COD_MAN_LIST
            //
            if (lCOD_MAN != 0) {
                if (COD_MAN_LIST != null) {
                    COD_MAN_LIST.add(new Long(lCOD_MAN));
                }
            }
            // MULTI_AZIENDA
            //---------------------------------------------------------------------------------------
            //4 sequence of Aziende List (COD_AZL List)		loop()
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    //result+=" <br>"+new Long(cod_azl).toString();
                    //5 if Risc exists in this Azienda
                    if (private_method.isIncludedRiskToAzienda(cod_azl, lCOD_RSO, bmp)) {
                        result += "<br>Risc exists in Azienda: " + new Long(cod_azl).toString();
                        // adding of Risc assotiation to Operaziona Svolta under this COD_AZL
                        result += private_method.addRiscToOperazioneSvolta(lCOD_OPE_SVO, lCOD_RSO, cod_azl, bmp);
                        // and current Operazione Svolte is included to Attivita Lavorativa
                        // which Attivita Lavorativa exists in Attivite Lavorative List
                        if (COD_MAN_LIST != null) {
                            Iterator it_att2 = COD_MAN_LIST.iterator();
                            while (it_att2.hasNext()) {
                                long cod_man = ((Long) (it_att2.next())).longValue();
                                long new_cod_man = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, cod_azl, cod_man, COD_AZL_LIST, bmp);
                                if (new_cod_man != 0) {
                                    // if consists that Attivita current Operazione Svolta
                                    if (private_method.isIncludedOpSvoltaToAttLavorativa(new_cod_man, lCOD_OPE_SVO, bmp)) {
                                        result += "<br>new_cod_man: " + new Long(new_cod_man).toString();
                                        result += private_method.addExtendedRischioAssociations(lCOD_RSO, cod_azl, bmp, new_cod_man);
                                    }//
                                }
                            }// while COD_MAN_LIST
                        }// if COD_MAN_LIST

                    }// if isIncludedRiskToAzienda
                }// while COD_AZL_LIST
            }// if COD_AZL_LIST
            //---------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    /*	*date:07/04/2004 *author:Roman Chumachenko
    Adding of Operaziona Svolta to Attivita Lavorativa with parameters (EX-ed mode)
    (supporting one transaction)
     */

    public String EXaddAssociationOfOpSvoltaToAttLavorativa(
            long lCOD_MAN,
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXaddAssociationOfOpSvoltaToAttLavorativa(
                lCOD_MAN, lCOD_OPE_SVO, lCOD_AZL, COD_AZL_LIST);
    }
    //

    public String ejbEXaddAssociationOfOpSvoltaToAttLavorativa(
            long lCOD_MAN,
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 adding of Operaziona Svolta to Attivita Lavorativa
            result = private_method.addOpSvolteToAttLavorativa(lCOD_OPE_SVO, lCOD_MAN, bmp);
            //Se L'attività Lavorativa è già stata collegata alla Mansione si interrompe il metodo e si da notifica 
            // all'utente di associazione  già esistente.
            if(result.indexOf("...ATTIVITA ESISTENTE") != -1){
                return result;
            }
             
                
            //2 adding of Operaziona Svolta Riscs to Attivita Lavorativa
            result = private_method.addRiscsAssocByOpSvolta(lCOD_OPE_SVO, lCOD_AZL, lCOD_MAN, bmp);

            // MULTI_AZIENDA
            //---------------------------------------------------------------------------------------
            //4 sequence of Aziende List (COD_AZL List)		loop()
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    //5 if Risc exists in this Azienda
                    result += " <br>" + new Long(cod_azl).toString();
                    // IsIncluded Attivita Lavorativa to Azienda
                    long new_cod_man = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, cod_azl, lCOD_MAN, COD_AZL_LIST, bmp);
                    if (new_cod_man != 0) {
                        result += " <br>&nbsp;new_cod_man:" + new Long(new_cod_man).toString();
                        //6 adding of Operaziona Svolta to Attivita Lavorativa under new Azienda
                        result += " <br>&nbsp;addOpSvolte:" + private_method.addOpSvolteToAttLavorativa(lCOD_OPE_SVO, new_cod_man, bmp);
                        //7 adding of Operaziona Svolta Riscs to Attivita Lavorativa under new Azienda
                        result += " <br>&nbsp;addAssRisks:" + private_method.addRiscsAssocByOpSvolta(lCOD_OPE_SVO, cod_azl, new_cod_man, bmp);
                    }// if
                }// while
            }// if Aziende List
            //---------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    /*	*date:08/04/2004 *author:Roman Chumachenko
    Deleting of Risk from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfRiscFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_RSO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfRiscFromOperazionaSvolta(
                lCOD_OPE_SVO,
                lCOD_RSO,
                lCOD_AZL,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfRiscFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_RSO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 getting list of AttLavorativa for OpSvolta
            java.util.ArrayList COD_ATT_LIST = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, lCOD_AZL, bmp);
            if (COD_ATT_LIST != null) {
                Iterator it_att = COD_ATT_LIST.iterator();
                while (it_att.hasNext()) {
                    long id_att = ((Long) it_att.next()).longValue();
                    result += "<br>id_att: " + id_att;
                    //2 if Risc idDeletable	
                    if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, lCOD_AZL, id_att, lCOD_OPE_SVO, bmp)) {
                        result += " isDeletable";
                        //3 deleting of Risc with its associations
                        result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, id_att, bmp);
                    }
                }
            }// if COD_ATT_LIST
            //4 deleting of Risc association from Op Svolta
            result += private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, lCOD_RSO, lCOD_AZL, bmp);
            //
            // MULTI_AZIENDA
            //---------------------------------------------------------------------------------------
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                java.util.ArrayList COD_ATT_LIST2 = null;
                Iterator it_att_azl = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    //5 getting list of AttLavorativa for OpSvolta under this Azienda
                    COD_ATT_LIST2 = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, cod_azl, bmp);
                    it_att_azl = COD_ATT_LIST2.iterator();
                    if (COD_ATT_LIST2 != null) {
                        while (it_att_azl.hasNext()) {
                            long id_att_azl = ((Long) it_att_azl.next()).longValue();
                            result += "<br>id_att: " + id_att_azl;
                            //6 if Risc idDeletable	
                            if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, cod_azl, id_att_azl, lCOD_OPE_SVO, bmp)) {
                                result += " isDeletable";
                                //7 deleting of Risc with its associations under this Azienda
                                result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, cod_azl, id_att_azl, bmp);
                            }
                            //8 deleting of Risc association from Op Svolta under this Azienda
                            result += private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, lCOD_RSO, cod_azl, bmp);

                        }//while
                    }// if COD_ATT_LIST2

                }// while
            }// if Aziende List
            //---------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################

    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Operaziona Svolta from Attivita Lavorativa with parameters (EX-ed mode)
     */
    public String EXdeleteAssociationOfOpSvoltaFromAttLavorativa(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            long lCOD_MAN,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfOpSvoltaFromAttLavorativa(
                lCOD_OPE_SVO,
                lCOD_AZL,
                lCOD_MAN,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfOpSvoltaFromAttLavorativa(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            long lCOD_MAN,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 getting list of Riscs of AttLavorativa throught OpSvolta
            java.util.ArrayList COD_RSO_LIST = private_method.getRiscsListByOpSvolta(lCOD_OPE_SVO, lCOD_AZL, bmp);
            if (COD_RSO_LIST != null) {
                Iterator it_rso = COD_RSO_LIST.iterator();
                while (it_rso.hasNext()) {
                    long id_rso = ((Long) it_rso.next()).longValue();
                    result += "<br>id_rso: " + id_rso;
                    //2 if Risc idDeletable	
                    if (private_method.isDeletableRiscFromAttLavorativa(id_rso, lCOD_AZL, lCOD_MAN, lCOD_OPE_SVO, bmp)) {
                        result += " isDeletable";
                        //3 deleting of Risc with its associations
                        result += private_method.deleteExtendedRischioAssociations(id_rso, lCOD_AZL, lCOD_MAN, bmp);
                    }
                }//while
            }//if COD_RSO_LIST

            //4 deleting of Op Svolta associatiation from Att Lavorativa
            result += private_method.deleteOpSvoFromAttLavorativa(lCOD_MAN, lCOD_OPE_SVO, bmp);

            // MULTI_AZIENDA
            //---------------------------------------------------------------------------------------
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                java.util.ArrayList COD_RSO_LIST2 = null;
                Iterator it_rso2 = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    //5 isIncludedAttLavorativaToAzienda
                    long new_cod_man = private_method.isIncludedAttLavorativaToAzienda(lCOD_AZL, cod_azl, lCOD_MAN, COD_AZL_LIST, bmp);
                    if (new_cod_man != 0) {
                        result += " <br>&nbsp;new_cod_man:" + new Long(new_cod_man).toString();
                        //6 isIncludedOpSvoltaToAttLavorativa
                        if (private_method.isIncludedOpSvoltaToAttLavorativa(new_cod_man, lCOD_OPE_SVO, bmp)) {
                            result += " <br>&nbsp;&nbsp;is included:";
                            //7 getting of Riscs List for tis Azienda
                            COD_RSO_LIST2 = private_method.getRiscsListByOpSvolta(lCOD_OPE_SVO, cod_azl, bmp);
                            if (COD_RSO_LIST2 != null) {
                                it_rso2 = COD_RSO_LIST2.iterator();
                                while (it_rso2.hasNext()) {
                                    long cod_rso2 = ((Long) (it_rso2.next())).longValue();
                                    result += " <br>&nbsp;&nbsp;&nbsp;id_rso2:" + new Long(cod_rso2).toString();
                                    //8 isDeletableRiscFromAttLavorativa for tis Azienda
                                    if (private_method.isDeletableRiscFromAttLavorativa(cod_rso2, cod_azl, new_cod_man, lCOD_OPE_SVO, bmp)) {
                                        result += " isDeletable";
                                        //9 deleting of Risc with its associations for tis Azienda
                                        result += private_method.deleteExtendedRischioAssociations(cod_rso2, cod_azl, new_cod_man, bmp);
                                    }
                                }// while it_rso2
                            }//if COD_RSO_LIST2

                            //10 deleting of Op Svolta associatiation from Att Lavorativa for tis Azienda
                            result += private_method.deleteOpSvoFromAttLavorativa(new_cod_man, lCOD_OPE_SVO, bmp);

                        }//if isIncludedOpSvoltaToAttLavorativa

                    }// if isIncludedAttLavorativaToAzienda

                }// while it_azl
            }// if COD_AZL_LIST

            //----------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Macchina Attr from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfMacchinaFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAC,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfMacchinaFromOperazionaSvolta(
                lCOD_OPE_SVO,
                lCOD_MAC,
                lCOD_AZL,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfMacchinaFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAC,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 getting list of Riscs of Macchina Attr
            java.util.ArrayList COD_RSO_LIST = private_method.getRiscsListByMacchina(lCOD_MAC, lCOD_AZL, bmp);
            Iterator it_rso = null;
            if (COD_RSO_LIST != null) {
                it_rso = COD_RSO_LIST.iterator();
                while (it_rso.hasNext()) {
                    long id_rso = ((Long) it_rso.next()).longValue();
                    result += "<br>id_rso: " + id_rso;
                    //2 deleting Riscs from Op Svolta 
                    result += " deleting " + private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, id_rso, lCOD_AZL, bmp);
                }//while it_rso
            }// if COD_RSO_LIST
            //---------------------------------------------------------------------------------------
            //3 getting Att Lavorative for this Op Svolta
            java.util.ArrayList COD_ATT_LIST = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, lCOD_AZL, bmp);
            result += "<br>-------------------------";
            if (COD_ATT_LIST != null) {
                Iterator it_att = COD_ATT_LIST.iterator();
                while (it_att.hasNext()) {
                    long id_att = ((Long) it_att.next()).longValue();
                    result += "<br>&nbsp;&nbsp;id_att: " + id_att;
                    //4 checking for isDeletable Riscs and deleting it
                    if (COD_RSO_LIST != null) {
                        it_rso = COD_RSO_LIST.iterator();
                        while (it_rso.hasNext()) {
                            long cod_rso = ((Long) (it_rso.next())).longValue();
                            result += " <br>&nbsp;&nbsp;&nbsp;id_rso+:" + new Long(cod_rso).toString();
                            if (private_method.isDeletableRiscFromAttLavorativa(cod_rso, lCOD_AZL, id_att, lCOD_OPE_SVO, bmp)) {
                                result += " isDeletable";
                                //5 deleting of Risc with its associations for tis Azienda
                                result += private_method.deleteExtendedRischioAssociations(cod_rso, lCOD_AZL, id_att, bmp);
                            }
                        }// while it_rso
                    }//if COD_RSO_LIST

                }//while it_att
            }//if COD_ATT_LIST
            //6 deleting of Maccina Attr associacion from Op Svolta
            result += "<br>OK deleteMacchina: " + private_method.deleteMacchinaFromOpSvolta(lCOD_MAC, lCOD_OPE_SVO, bmp);

            //---------------------------------------------------------------------------------------
            // MULTI_AZIENDA
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                Iterator it_att = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    //7 isExists Macchina Attr in this Azienda
                    long new_cod_mac = private_method.isIncludedMacchinaToAzienda(lCOD_MAC, lCOD_AZL, cod_azl, COD_AZL_LIST, bmp);
                    result += " <br>&nbsp;new_cod_mac: " + new Long(new_cod_mac).toString();
                    if (new_cod_mac != 0) {
                        //8 isIncluded Ope Svolta this Macchina
                        if (private_method.isIncludedMacchinaToOpSvolta(new_cod_mac, lCOD_OPE_SVO, bmp)) {
                            result += " <br>&nbsp;&nbsp;Included";
                            //9 getting Riscs List for this Macchina
                            COD_RSO_LIST = private_method.getRiscsListByMacchina(new_cod_mac, cod_azl, bmp);
                            it_rso = null;
                            if (COD_RSO_LIST != null) {
                                it_rso = COD_RSO_LIST.iterator();
                                while (it_rso.hasNext()) {
                                    long id_rso = ((Long) it_rso.next()).longValue();
                                    result += "<br>&nbsp;&nbsp;&nbsp;id_rso+: " + id_rso;
                                    //10 deleting Riscs from Op Svolta under this Azienda
                                    result += "deleting+" + private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, id_rso, cod_azl, bmp);
                                }//while
                            }// COD_RSO_LIST

                            //11 getting of Att Lavorative List for this Macchina under this Azienda
                            COD_ATT_LIST = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, cod_azl, bmp);
                            if (COD_ATT_LIST != null) {
                                it_att = COD_ATT_LIST.iterator();
                                while (it_att.hasNext()) {
                                    long id_att = ((Long) it_att.next()).longValue();
                                    result += "<br>&nbsp;&nbsp;id_att+: " + id_att;
                                    //12 checking for isDeletable Riscs and deleting it
                                    if (COD_RSO_LIST != null) {
                                        it_rso = COD_RSO_LIST.iterator();
                                        while (it_rso.hasNext()) {
                                            long cod_rso = ((Long) (it_rso.next())).longValue();
                                            result += " <br>&nbsp;&nbsp;&nbsp;id_rso++:" + new Long(cod_rso).toString();
                                            if (private_method.isDeletableRiscFromAttLavorativa(cod_rso, cod_azl, id_att, lCOD_OPE_SVO, bmp)) {
                                                result += " isDeletable";
                                                //13 deleting of Risc with its associations under this Azienda
                                                result += private_method.deleteExtendedRischioAssociations(cod_rso, cod_azl, id_att, bmp);
                                            }// if isDeletable
                                        }// while it_rso
                                    }//if COD_RSO_LIST

                                }//while it_att
                            }//if COD_ATT_LIST

                            //14 deleting of Maccina Attr associacion from Op Svolta under this Azienda
                            result += "<br>OK deleteMacchina: " + private_method.deleteMacchinaFromOpSvolta(new_cod_mac, lCOD_OPE_SVO, bmp);
                        }//if isIncludedMacchinaToOpSvolta

                    }//if new_cod_mac
                }// while
            }// if COD_AZL_LIST
            //----------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Agente Chimico from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfAgenteFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfAgenteFromOperazionaSvolta(
                lCOD_OPE_SVO,
                lCOD_SOS_CHI,
                lCOD_AZL,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfAgenteFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //---------------------------------------------------------------------------------------
            //1 getting list of Riscs of Macchina Attr
            java.util.ArrayList COD_RSO_LIST = private_method.getRiscsListByAgente(lCOD_SOS_CHI, lCOD_AZL, bmp);
            Iterator it_rso = null;
            if (COD_RSO_LIST != null) {
                it_rso = COD_RSO_LIST.iterator();
                while (it_rso.hasNext()) {
                    long id_rso = ((Long) it_rso.next()).longValue();
                    result += "<br>id_rso: " + id_rso;
                    //2 deleting Riscs from Op Svolta 
                    result += " deleting " + private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, id_rso, lCOD_AZL, bmp);
                }//while it_rso
            }// if COD_RSO_LIST
            //---------------------------------------------------------------------------------------
            //3 getting Att Lavorative for this Op Svolta
            java.util.ArrayList COD_ATT_LIST = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, lCOD_AZL, bmp);
            result += "<br>-------------------------";
            if (COD_ATT_LIST != null) {
                Iterator it_att = COD_ATT_LIST.iterator();
                while (it_att.hasNext()) {
                    long id_att = ((Long) it_att.next()).longValue();
                    result += "<br>&nbsp;&nbsp;id_att: " + id_att;
                    //4 checking for isDeletable Riscs and deleting it
                    if (COD_RSO_LIST != null) {
                        it_rso = COD_RSO_LIST.iterator();
                        while (it_rso.hasNext()) {
                            long cod_rso = ((Long) (it_rso.next())).longValue();
                            result += " <br>&nbsp;&nbsp;&nbsp;id_rso+:" + new Long(cod_rso).toString();
                            if (private_method.isDeletableRiscFromAttLavorativa(cod_rso, lCOD_AZL, id_att, lCOD_OPE_SVO, bmp)) {
                                result += " isDeletable";
                                //5 deleting of Risc with its associations for tis Azienda
                                result += private_method.deleteExtendedRischioAssociations(cod_rso, lCOD_AZL, id_att, bmp);
                            }
                        }// while it_rso
                    }//if COD_RSO_LIST

                }//while it_att
            }//if COD_ATT_LIST
            //6 deleting of Maccina Attr associacion from Op Svolta
            result += "<br>OK deleteAgente: " + private_method.deleteAgenteFromOpSvolta(lCOD_SOS_CHI, lCOD_OPE_SVO, bmp);

            // MULTI_AZIENDA
            //---------------------------------------------------------------------------------------
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                Iterator it_att = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    //7 getting Riscs List for this Agente under this Azienda
                    COD_RSO_LIST = private_method.getRiscsListByAgente(lCOD_SOS_CHI, cod_azl, bmp);
                    it_rso = null;
                    if (COD_RSO_LIST != null) {
                        it_rso = COD_RSO_LIST.iterator();
                        while (it_rso.hasNext()) {
                            long id_rso = ((Long) it_rso.next()).longValue();
                            result += "<br>&nbsp;&nbsp;&nbsp;id_rso+: " + id_rso;
                            //8 deleting Riscs from Op Svolta under this Azienda
                            result += "deleting+" + private_method.deleteRiscFromOpSvolta(lCOD_OPE_SVO, id_rso, cod_azl, bmp);
                        }//while
                    }// COD_RSO_LIST

                    //9 getting of Att Lavorative List for this Macchina under this Azienda
                    COD_ATT_LIST = private_method.getAttLavListByOpSvolta(lCOD_OPE_SVO, cod_azl, bmp);
                    if (COD_ATT_LIST != null) {
                        it_att = COD_ATT_LIST.iterator();
                        while (it_att.hasNext()) {
                            long id_att = ((Long) it_att.next()).longValue();
                            result += "<br>&nbsp;&nbsp;id_att+: " + id_att;
                            //10 checking for isDeletable Riscs and deleting it
                            if (COD_RSO_LIST != null) {
                                it_rso = COD_RSO_LIST.iterator();
                                while (it_rso.hasNext()) {
                                    long cod_rso = ((Long) (it_rso.next())).longValue();
                                    result += " <br>&nbsp;&nbsp;&nbsp;id_rso++:" + new Long(cod_rso).toString();
                                    if (private_method.isDeletableRiscFromAttLavorativa(cod_rso, cod_azl, id_att, lCOD_OPE_SVO, bmp)) {
                                        result += " isDeletable";
                                        //11 deleting of Risc with its associations under this Azienda
                                        result += private_method.deleteExtendedRischioAssociations(cod_rso, cod_azl, id_att, bmp);
                                    }// if isDeletable
                                }// while it_rso
                            }//if COD_RSO_LIST

                        }//while it_att
                    }//if COD_ATT_LIST

                }// while it_azl
            }// if COD_AZL_LIST
            //----------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    public String EXdeleteAssociationOfRiscFromMacchina(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_MAC,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfRiscFromMacchina(
                lCOD_RSO,
                lCOD_AZL,
                lCOD_MAC,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfRiscFromMacchina(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_MAC,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //------------------------------------------------------------------------------------
            //1 getting list of Op Svolte for Macchina Attr
            java.util.ArrayList COD_OPE_SVO_LIST = private_method.getOpSvoltaListByMacchina(lCOD_MAC, bmp);
            Iterator it_ope_svo = null;
            //
            java.util.ArrayList COD_MAN_LIST = null;
            Iterator it_man = null;
            //
            if (COD_OPE_SVO_LIST != null) {
                it_ope_svo = COD_OPE_SVO_LIST.iterator();
                while (it_ope_svo.hasNext()) {
                    long id_ope_svo = ((Long) it_ope_svo.next()).longValue();
                    result += "<br>id_ope_svo: " + id_ope_svo;
                    //2 deleting Risc from Op Svolta 
                    result += " deleting risc : " + private_method.deleteRiscFromOpSvolta(id_ope_svo, lCOD_RSO, lCOD_AZL, bmp);
                    //3 getting list of Attivita Lavorative for this Op Svolta
                    COD_MAN_LIST = private_method.getAttLavListByOpSvolta(id_ope_svo, lCOD_AZL, bmp);
                    if (COD_MAN_LIST != null) {
                        it_man = COD_MAN_LIST.iterator();
                        while (it_man.hasNext()) {
                            long id_man = ((Long) it_man.next()).longValue();
                            result += "<br>&nbsp;&nbsp;id_man: " + id_man;
                            if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, lCOD_AZL, id_man, id_ope_svo, bmp)) {
                                result += " isDeletable";
                                //4 deleting of Risc with its associations under this Azienda
                                result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, id_man, bmp);
                            }// if isDeletable
                        }//while it_man
                    }// if COD_MAN_LIST
                } //while it_ope_svo
            }// if COD_OPE_SVO_LIST
            //5 deleting Risc association from Macchina Attr.
            result += "<br>OK deleteRisc: " + private_method.deleteRiscFromMacchina(lCOD_RSO, lCOD_MAC, lCOD_AZL, bmp);

            //6 go to Luoghi Fisici area
            // get list all Luoghi Fisici for this Macchina
            java.util.ArrayList COD_LUO_FSC_LIST = private_method.getLuoFisiciListByMacchina(lCOD_MAC, lCOD_AZL, bmp);
            Iterator it_luo_fsc = null;
            //
            if (COD_LUO_FSC_LIST != null) {
                it_luo_fsc = COD_LUO_FSC_LIST.iterator();
                while (it_luo_fsc.hasNext()) {
                    long id_luo_fsc = ((Long) it_luo_fsc.next()).longValue();
                    result += "<br>id_luo_fsc: " + id_luo_fsc;
                    // deleting Risc Association from Luogo Fisico with its associations
                    result += "<br> del risc and assoc: " + private_method.deleteEXRischioAssFromLuoFsc(lCOD_RSO, lCOD_AZL, id_luo_fsc, bmp);
                }// while id_luo_fsc
            }//if COD_LUO_FSC_LIST

            // MULTI_AZIENDA
            //------------------------------------------------------------------------------------
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                Iterator it_att = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    if (private_method.isIncludedRiskToAzienda(cod_azl, lCOD_RSO, bmp)) {
                        result += " <br> Risc Exists!";
                        long new_cod_mac = private_method.isIncludedMacchinaToAzienda(lCOD_MAC, lCOD_AZL, cod_azl, COD_AZL_LIST, bmp);
                        if (new_cod_mac != 0) {
                            result += " <br> Macchina Exists! " + new_cod_mac;
                            // deleting Risc from Macchina under this Azienda
                            result += "<br>OK deleteRisc: " + private_method.deleteRiscFromMacchina(lCOD_RSO, new_cod_mac, cod_azl, bmp);

                            // getting of Op Svolta list for this Macchina
                            COD_OPE_SVO_LIST = private_method.getOpSvoltaListByMacchina(new_cod_mac, bmp);
                            if (COD_OPE_SVO_LIST != null) {
                                it_ope_svo = COD_OPE_SVO_LIST.iterator();
                                while (it_ope_svo.hasNext()) {
                                    long id_ope_svo = ((Long) it_ope_svo.next()).longValue();
                                    result += "<br>&nbsp;&nbsp;id_ope_svo: " + id_ope_svo;
                                    // deleting Risk
                                    result += " deleting risc : " + private_method.deleteRiscFromOpSvolta(id_ope_svo, lCOD_RSO, cod_azl, bmp);

                                    // getting of Att Lavorativa list for Op Svolta
                                    COD_MAN_LIST = private_method.getAttLavListByOpSvolta(id_ope_svo, cod_azl, bmp);
                                    if (COD_MAN_LIST != null) {
                                        it_man = COD_MAN_LIST.iterator();
                                        while (it_man.hasNext()) {
                                            long id_man = ((Long) it_man.next()).longValue();
                                            result += "<br>&nbsp;&nbsp;id_man: " + id_man;
                                            if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, cod_azl, id_man, id_ope_svo, bmp)) {
                                                result += " isDeletable";
                                                //4 deleting of Risc with its associations under this Azienda
                                                result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, cod_azl, id_man, bmp);
                                            }// if isDeletable
                                        }//while it_man
                                    }// if COD_MAN_LIST

                                }// while it_ope_svo
                            }//if  COD_OPE_SVO_LIST

                            // getting Luogo Fisico list for this Macchina
                            // get list all Luoghi Fisici for this Macchina
                            COD_LUO_FSC_LIST = private_method.getLuoFisiciListByMacchina(new_cod_mac, cod_azl, bmp);
                            //
                            if (COD_LUO_FSC_LIST != null) {
                                it_luo_fsc = COD_LUO_FSC_LIST.iterator();
                                while (it_luo_fsc.hasNext()) {
                                    long id_luo_fsc = ((Long) it_luo_fsc.next()).longValue();
                                    result += "<br>id_luo_fsc: " + id_luo_fsc;
                                    // deleting Risc Association from Luogo Fisico with its associations
                                    result += "<br> del risc and assoc: " + private_method.deleteEXRischioAssFromLuoFsc(lCOD_RSO, cod_azl, id_luo_fsc, bmp);
                                }// while id_luo_fsc
                            }//if COD_LUO_FSC_LIST

                        }//if new_cod_mac
                    }//if isIncludedRiskToAzienda

                }// while it_azl
            }//if COD_AZL_LIST
            //----------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################

    public String EXdeleteAssociationOfRiscFromAgente(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_SOS_CHI,
            java.util.ArrayList COD_AZL_LIST) {
        return (new AttivitaLavorativeBean()).ejbEXdeleteAssociationOfRiscFromAgente(
                lCOD_RSO,
                lCOD_AZL,
                lCOD_SOS_CHI,
                COD_AZL_LIST);
    }
    //

    public String ejbEXdeleteAssociationOfRiscFromAgente(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_SOS_CHI,
            java.util.ArrayList COD_AZL_LIST) {
        String result = "";
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // MONO_AZIENDA
            //-----------------------------------------------------------------------------
            //1 getting list of Op Svolte for Macchina Attr
            java.util.ArrayList COD_OPE_SVO_LIST = private_method.getOpSvoltaListByAgente(lCOD_SOS_CHI, bmp);
            Iterator it_ope_svo = null;
            //
            java.util.ArrayList COD_MAN_LIST = null;
            Iterator it_man = null;
            //
            if (COD_OPE_SVO_LIST != null) {
                it_ope_svo = COD_OPE_SVO_LIST.iterator();
                while (it_ope_svo.hasNext()) {
                    long id_ope_svo = ((Long) it_ope_svo.next()).longValue();
                    result += "<br>id_ope_svo: " + id_ope_svo;
                    //2 deleting Risc from Op Svolta 
                    result += " deleting risc : " + private_method.deleteRiscFromOpSvolta(id_ope_svo, lCOD_RSO, lCOD_AZL, bmp);
                    //3 getting list of Attivita Lavorative for this Op Svolta
                    COD_MAN_LIST = private_method.getAttLavListByOpSvolta(id_ope_svo, lCOD_AZL, bmp);
                    if (COD_MAN_LIST != null) {
                        it_man = COD_MAN_LIST.iterator();
                        while (it_man.hasNext()) {
                            long id_man = ((Long) it_man.next()).longValue();
                            result += "<br>&nbsp;&nbsp;id_man: " + id_man;
                            if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, lCOD_AZL, id_man, id_ope_svo, bmp)) {
                                result += " isDeletable";
                                //4 deleting of Risc with its associations under this Azienda
                                result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, lCOD_AZL, id_man, bmp);
                            }// if isDeletable
                        }//while it_man
                    }// if COD_MAN_LIST
                } //while it_ope_svo
            }// if COD_OPE_SVO_LIST
            //5 deleting Risc association from Ahente Chimico
            result += "<br>OK deleteRisc: " + private_method.deleteRiscFromAgente(lCOD_RSO, lCOD_SOS_CHI, lCOD_AZL, bmp);

            //6 go to Luoghi Fisici area
            // get list all Luoghi Fisici for this Ahente Chimico
            java.util.ArrayList COD_LUO_FSC_LIST = private_method.getLuoFisiciListByAgente(lCOD_SOS_CHI, lCOD_AZL, bmp);
            Iterator it_luo_fsc = null;
            //
            if (COD_LUO_FSC_LIST != null) {
                it_luo_fsc = COD_LUO_FSC_LIST.iterator();
                while (it_luo_fsc.hasNext()) {
                    long id_luo_fsc = ((Long) it_luo_fsc.next()).longValue();
                    result += "<br>id_luo_fsc: " + id_luo_fsc;
                    // deleting Risc Association from Luogo Fisico with its associations
                    result += "<br> del risc and assoc: " + private_method.deleteEXRischioAssFromLuoFsc(lCOD_RSO, lCOD_AZL, id_luo_fsc, bmp);
                }// while id_luo_fsc
            }//if COD_LUO_FSC_LIST

            // MULTI_AZIENDA
            //-----------------------------------------------------------------------------
            if (COD_AZL_LIST != null) {
                Iterator it_azl = COD_AZL_LIST.iterator();
                result += "<br>-------------------------";
                Iterator it_att = null;
                while (it_azl.hasNext()) {
                    long cod_azl = ((Long) (it_azl.next())).longValue();
                    result += " <br>" + new Long(cod_azl).toString();
                    if (private_method.isIncludedRiskToAzienda(cod_azl, lCOD_RSO, bmp)) {
                        result += " <br> Risc Exists!";
                        // deleting Risc from Macchina under this Azienda
                        result += "<br>OK deleteRisc: " + private_method.deleteRiscFromAgente(lCOD_RSO, lCOD_SOS_CHI, cod_azl, bmp);

                        // getting of Op Svolta list for this Macchina
                        COD_OPE_SVO_LIST = private_method.getOpSvoltaListByAgente(lCOD_SOS_CHI, bmp);
                        if (COD_OPE_SVO_LIST != null) {
                            it_ope_svo = COD_OPE_SVO_LIST.iterator();
                            while (it_ope_svo.hasNext()) {
                                long id_ope_svo = ((Long) it_ope_svo.next()).longValue();
                                result += "<br>&nbsp;&nbsp;id_ope_svo: " + id_ope_svo;
                                // deleting Risk
                                result += " deleting risc : " + private_method.deleteRiscFromOpSvolta(id_ope_svo, lCOD_RSO, cod_azl, bmp);

                                // getting of Att Lavorativa list for Op Svolta
                                COD_MAN_LIST = private_method.getAttLavListByOpSvolta(id_ope_svo, cod_azl, bmp);
                                if (COD_MAN_LIST != null) {
                                    it_man = COD_MAN_LIST.iterator();
                                    while (it_man.hasNext()) {
                                        long id_man = ((Long) it_man.next()).longValue();
                                        result += "<br>&nbsp;&nbsp;id_man: " + id_man;
                                        if (private_method.isDeletableRiscFromAttLavorativa(lCOD_RSO, cod_azl, id_man, id_ope_svo, bmp)) {
                                            result += " isDeletable";
                                            //4 deleting of Risc with its associations under this Azienda
                                            result += private_method.deleteExtendedRischioAssociations(lCOD_RSO, cod_azl, id_man, bmp);
                                        }// if isDeletable
                                    }//while it_man
                                }// if COD_MAN_LIST

                            }// while it_ope_svo
                        }//if  COD_OPE_SVO_LIST

                        // getting Luogo Fisico list for this Agente Chimico
                        // get list all Luoghi Fisici for this Agente Chimico
                        COD_LUO_FSC_LIST = private_method.getLuoFisiciListByAgente(lCOD_SOS_CHI, cod_azl, bmp);
                        //
                        if (COD_LUO_FSC_LIST != null) {
                            it_luo_fsc = COD_LUO_FSC_LIST.iterator();
                            while (it_luo_fsc.hasNext()) {
                                long id_luo_fsc = ((Long) it_luo_fsc.next()).longValue();
                                result += "<br>id_luo_fsc: " + id_luo_fsc;
                                // deleting Risc Association from Luogo Fisico with its associations
                                result += "<br> del risc and assoc: " + private_method.deleteEXRischioAssFromLuoFsc(lCOD_RSO, cod_azl, id_luo_fsc, bmp);
                            }// while id_luo_fsc
                        }//if COD_LUO_FSC_LIST

                    }//if isIncludedRiskToAzienda

                }// while it_azl
            }//if COD_AZL_LIST
            //----------------
            bmp.commitTrans();
        } catch (Exception ex) {
            result += "\n" + ex.toString() + "...FAILED";
            bmp.rollbackTrans();
            //throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }// ######################################
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
}
