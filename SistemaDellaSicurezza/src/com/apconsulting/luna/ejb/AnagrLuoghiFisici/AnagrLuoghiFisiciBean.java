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

import com.apconsulting.luna.ejb.SediAziendali.ISitaAziende;
import com.apconsulting.luna.ejb.SediAziendali.ISitaAziendeHome;
import com.apconsulting.luna.ejb.SediAziendali.SiteAziendaleByAZLID_View;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.ejb.pseudoejb.PseudoContext;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class AnagrLuoghiFisiciBean extends BMPEntityBean implements IAnagrLuoghiFisici, IAnagrLuoghiFisiciHome {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    String NOM_LUO_FSC;
    long COD_LUO_FSC;
    long COD_SIT_AZL;
    long COD_AZL;
//-----------------------------
    long COD_ALA;
    long COD_IMO;
    long COD_IMM_3LV;
    long COD_PNO;
    String DES_LUO_FSC;
    String QLF_RSP_LUO_FSC;
    String NOM_RSP_LUO_FSC;
    String IDZ_PSA_ELT_RSP_LUO_FSC;
    String FLG_IMP;

//</comment>
    public static final String BEAN_NAME = "AnagrLuoghiFisiciBean";
////////////////////// CONSTRUCTOR///////////////////
    private static AnagrLuoghiFisiciBean ys = null;

    private AnagrLuoghiFisiciBean() {
        //
    }

    public static AnagrLuoghiFisiciBean getInstance() {
        if (ys == null) {
            ys = new AnagrLuoghiFisiciBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

// (Home Intrface) create()
    public IAnagrLuoghiFisici create
            (long COD_SIT_AZL, long COD_AZL, String NOM_LUO_FSC, long COD_ALA,
            long COD_IMO, long COD_IMM_3LV, long COD_PNO, String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC, String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC) throws CreateException {

        return createExtended
                (COD_SIT_AZL, COD_AZL, NOM_LUO_FSC, COD_ALA, COD_IMO, COD_IMM_3LV, COD_PNO,
                DES_LUO_FSC, QLF_RSP_LUO_FSC, NOM_RSP_LUO_FSC, IDZ_PSA_ELT_RSP_LUO_FSC, null);
    }

    public IAnagrLuoghiFisici createExtended
            (long COD_SIT_AZL, long COD_AZL, String NOM_LUO_FSC, long COD_ALA,
            long COD_IMO, long COD_IMM_3LV, long COD_PNO, String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC, String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC, ArrayList alAziende) throws CreateException {
        AnagrLuoghiFisiciBean bean = new AnagrLuoghiFisiciBean();
        try {
            Object primaryKey = bean.ejbCreate
                    (COD_SIT_AZL, COD_AZL, NOM_LUO_FSC, COD_ALA, COD_IMO, COD_IMM_3LV,
                    COD_PNO, DES_LUO_FSC, QLF_RSP_LUO_FSC, NOM_RSP_LUO_FSC,
                    IDZ_PSA_ELT_RSP_LUO_FSC, alAziende);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate
                    (COD_SIT_AZL, COD_AZL, NOM_LUO_FSC, COD_ALA, COD_IMO, COD_IMM_3LV,
                    COD_PNO, DES_LUO_FSC, QLF_RSP_LUO_FSC, NOM_RSP_LUO_FSC,
                    IDZ_PSA_ELT_RSP_LUO_FSC, alAziende);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        removeExtended(primaryKey, null);
    }

    public void removeExtended(Object primaryKey, ArrayList alAziende) {
        AnagrLuoghiFisiciBean iAnagrLuoghiFisiciBean = new AnagrLuoghiFisiciBean();
        try {
            Object obj = iAnagrLuoghiFisiciBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAnagrLuoghiFisiciBean.setEntityContext(new EntityContextWrapper(obj));
            iAnagrLuoghiFisiciBean.ejbActivate();
            iAnagrLuoghiFisiciBean.ejbLoad();
            iAnagrLuoghiFisiciBean.ejbRemoveExtended(alAziende);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public IAnagrLuoghiFisici findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrLuoghiFisiciBean bean = new AnagrLuoghiFisiciBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getAnagrLuoghiFisici_4Sede_List_View(long lCOD_AZL, long lCOD_MAN) {
        return this.ejbGetAnagrLuoghiFisici_4Sede_List_View(lCOD_AZL, lCOD_MAN);
    }

    public Collection getAnagrLuoghiFisici_List_View(long lCOD_AZL, long lCOD_MAN) {
        return this.ejbGetAnagrLuoghiFisici_List_View(lCOD_AZL, lCOD_MAN);
    }

    public Collection getAnagrLuoghiFisici_List_View(long lCOD_AZL) {
        return (new AnagrLuoghiFisiciBean()).ejbGetAnagrLuoghiFisici_List_View(lCOD_AZL);
    }

    public Collection getAllAnagrLuoghiFisici_List_View() {
        return (new AnagrLuoghiFisiciBean()).ejbGetAllAnagrLuoghiFisici_List_View();
    }

    public Collection getAnagrLuoghiFisici_Sit_Azl_View(long COD_SIT_AZL) {
        return (new AnagrLuoghiFisiciBean()).ejbGetAnagrLuoghiFisici_Sit_Azl_View(COD_SIT_AZL);
    }

    public Collection getAnagrLuoghiFisici_Imm_3lv_View(long COD_IMM_3LV) {
        return (new AnagrLuoghiFisiciBean()).ejbGetAnagrLuoghiFisici_Imm_3lv_View(COD_IMM_3LV);
    }

// Dario Massaroni - 26-10-2007
    public Collection getAnagrLuoghiFisici_NOM_List_View(String strNOM_LUO_FSC, long lCOD_AZL) {
        return (new AnagrLuoghiFisiciBean()).ejbGetAnagrLuoghiFisici_NOM_List_View(strNOM_LUO_FSC, lCOD_AZL);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

//</IAnagrLuoghiFisiciHome-implementation>
    public Long ejbCreate
            (long COD_SIT_AZL, long COD_AZL, String NOM_LUO_FSC, long COD_ALA,
            long COD_IMO, long COD_IMM_3LV, long COD_PNO, String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC, String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC, ArrayList alAziende) {

        long lFirstKey = NEW_ID();
        this.COD_LUO_FSC = NEW_ID();

        this.COD_SIT_AZL = COD_SIT_AZL;
        this.COD_AZL = COD_AZL;
        this.NOM_LUO_FSC = NOM_LUO_FSC;
        this.COD_ALA = COD_ALA;
        this.COD_IMO = COD_IMO;
        this.COD_IMM_3LV = COD_IMM_3LV;
        this.COD_PNO = COD_PNO;
        this.DES_LUO_FSC = DES_LUO_FSC;
        this.QLF_RSP_LUO_FSC = QLF_RSP_LUO_FSC;
        this.NOM_RSP_LUO_FSC = NOM_RSP_LUO_FSC;
        this.IDZ_PSA_ELT_RSP_LUO_FSC = IDZ_PSA_ELT_RSP_LUO_FSC;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        bmp.beginTrans();

        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO " +
                        "ana_luo_fsc_tab " +
                            "(cod_luo_fsc, " +
                            "nom_luo_fsc, " +
                            "cod_sit_azl, " +
                            "cod_azl, " +
                            "cod_ala, " +
                            "cod_imo, " +
                            "cod_imm_3lv, " +
                            "cod_pno, " +
                            "des_luo_fsc, " +
                            "qlf_rsp_luo_fsc, " +
                            "nom_rsp_luo_fsc, " +
                            "idz_psa_elt_rsp_luo_fsc) " +
                    "VALUES " +
                        "(?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_LUO_FSC);
            ps.setString(2, NOM_LUO_FSC);
            if (COD_SIT_AZL == 0){
                ps.setNull(3, java.sql.Types.BIGINT);
            } else {
                ps.setLong(3, COD_SIT_AZL);
            }
            ps.setLong(4, COD_AZL);
            if (COD_ALA == 0) {
                ps.setNull(5, java.sql.Types.BIGINT);
            } else {
                ps.setLong(5, COD_ALA);
            }
            if (COD_IMO == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, COD_IMO);
            }
            if (COD_IMM_3LV == 0) {
                ps.setNull(7, java.sql.Types.BIGINT);
            } else {
                ps.setLong(7, COD_IMM_3LV);
            }
            if (COD_PNO == 0) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setLong(8, COD_PNO);
            }
            ps.setString(9, DES_LUO_FSC);
            ps.setString(10, QLF_RSP_LUO_FSC);
            ps.setString(11, NOM_RSP_LUO_FSC);
            ps.setString(12, IDZ_PSA_ELT_RSP_LUO_FSC);
            ps.executeUpdate();

            logger.info("Propagazione: \"ANAGRAFICA - LUOGHI FISICI\" - INIZIO");
            setExtendedObject(bmp, "ana_luo_fsc_tab", lFirstKey, COD_LUO_FSC, COD_AZL);

            if (alAziende != null && alAziende.isEmpty() == false){
                logger.info("Lista Aziende su cui propagare: " + alAziende.toString() + " INIZIO CICLO");
                Iterator it = alAziende.iterator();

                // Estraggo la sede del luogo fisico che andrò a propagare.
                ISitaAziendeHome homeSedeIniziale = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                ISitaAziende beanSedeIniziale = homeSedeIniziale.findByPrimaryKey(COD_SIT_AZL);

                while (it.hasNext()) {
                    long cod_azl = ((Long) it.next()).longValue();
                    if (cod_azl == COD_AZL) {
                        continue;
                    }

                    // Verifico, nell'azienda sulla quale sto propagando il luogo fisico,
                    // l'esistenza di una sede con descrizione uguale a quella della sede del
                    // luogo fisico propagato.
                    Collection ListaSedi = homeSedeIniziale.findEx
                            (cod_azl, beanSedeIniziale.getNOM_SIT_AZL(), null, null,
                            null, null, null, 0);
                    if (ListaSedi != null && ListaSedi.isEmpty() == false){
                        // se la trovo...
                        // gli assegno il luogo fisico propagato.
                        ps.setLong(3, ((SiteAziendaleByAZLID_View)ListaSedi.iterator().next()).COD_SIT_AZL);
                    } else {
                        // se non la trovo...
                        // ne creo una ad hoc e gli assegno il luogo fisico.
                        ISitaAziende beanNuovaSede = homeSedeIniziale.create
                                (cod_azl,
                                beanSedeIniziale.getNOM_SIT_AZL(),
                                beanSedeIniziale.getIDZ_SIT_AZL(),
                                beanSedeIniziale.getCIT_SIT_AZL());
                        ps.setLong(3, beanNuovaSede.getCOD_SIT_AZL());
                    }

                    long lSecondKey = NEW_ID();
                    ps.setLong(1, lSecondKey);
                    ps.setLong(4, cod_azl);
                    ps.executeUpdate();
                    setExtendedObject(bmp, "ana_luo_fsc_tab", lFirstKey, lSecondKey, cod_azl);
                }
                logger.info("Lista Aziende su cui propagare: FINE CICLO");
            }
            logger.info("Propagazione: \"ANAGRAFICA - LUOGHI FISICI\" - FINE");

            bmp.commitTrans();
            return new Long(COD_LUO_FSC);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate
            (long COD_SIT_AZL, long COD_AZL, String NOM_LUO_FSC, long COD_ALA,
            long COD_IMO, long COD_IMM_3LV, long COD_PNO, String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC, String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC, ArrayList alAziende) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_luo_fsc "
                    + "FROM "
                        + "ana_luo_fsc_tab ");
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
        this.COD_LUO_FSC = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_LUO_FSC = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "* "
                    + "FROM "
                        + "ana_luo_fsc_tab "
                    + "WHERE "
                        + "cod_luo_fsc=? ");
            ps.setLong(1, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_LUO_FSC = rs.getString("NOM_LUO_FSC");
                this.COD_SIT_AZL = rs.getLong("COD_SIT_AZL");
                this.DES_LUO_FSC = rs.getString("DES_LUO_FSC");
                this.QLF_RSP_LUO_FSC = rs.getString("QLF_RSP_LUO_FSC");
                this.NOM_RSP_LUO_FSC = rs.getString("NOM_RSP_LUO_FSC");
                this.IDZ_PSA_ELT_RSP_LUO_FSC = rs.getString("IDZ_PSA_ELT_RSP_LUO_FSC");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_ALA = rs.getLong("COD_ALA");
                this.COD_IMO = rs.getLong("COD_IMO");
                this.COD_IMM_3LV = rs.getLong("COD_IMM_3LV");
                this.COD_PNO = rs.getLong("COD_PNO");
                this.FLG_IMP= rs.getString("FLG_IMP");
               } else {
                throw new NoSuchEntityException("AnagrLuoghiFisici con ID=" + COD_LUO_FSC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        ejbRemoveExtended(null);
    }

    public void ejbRemoveExtended(ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            bmp.beginTrans();
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM " +
                        "ana_luo_fsc_tab " +
                    "WHERE " +
                        "(  cod_luo_fsc=? " +
                            "OR cod_luo_fsc IN " +
                                "(" + getExtendedObjects("ana_luo_fsc_tab", alAziende) + ") ) " +
                        "AND (  cod_azl=? " +
                                "OR cod_azl IN  " +
                                    "(" + toString(alAziende) + "))");
            ps.setLong(1, COD_LUO_FSC);
            ps.setLong(2, COD_LUO_FSC);
            ps.setLong(3, COD_AZL);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Impossibile eliminare il luogo fisico e/o i luoghi fisici propagati");
            }

            removeExtendedObject(bmp, "ana_luo_fsc_tab", COD_LUO_FSC, COD_AZL, alAziende);

            bmp.commitTrans();
        } catch (Exception ex) {
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
        store(
            COD_SIT_AZL,
            COD_AZL,
            NOM_LUO_FSC,
            COD_IMO,
            COD_IMM_3LV,
            COD_PNO,
            COD_ALA,
            DES_LUO_FSC,
            NOM_RSP_LUO_FSC,
            QLF_RSP_LUO_FSC,
            IDZ_PSA_ELT_RSP_LUO_FSC,
            FLG_IMP,
            null);
    }

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
            ArrayList alAziende) {
        
        String SQL =
                "UPDATE " +
                    "ana_luo_fsc_tab " +
                "SET " +
                    "nom_luo_fsc=?, " +
                    "des_luo_fsc=?, " +
                    "qlf_rsp_luo_fsc=?, " +
                    "nom_rsp_luo_fsc=?, " +
                    "idz_psa_elt_rsp_luo_fsc=?, " +
                    "cod_ala=?, " +
                    "cod_imo=?, " +
                    "cod_imm_3lv=?, " +
                    "cod_pno=?, " +
                    "flg_imp=? ";
        String SQL_WHERE = 
                "WHERE " +
                    "cod_luo_fsc=? " +
                    "AND cod_azl=?";
        String SQL_WHERE_EXTENDED =
                "WHERE " +
                    "cod_luo_fsc IN " +
                        "(" + getExtendedObjects("ana_luo_fsc_tab", alAziende) + ") " +
                    "AND cod_azl IN " +
                        "(" + toString(alAziende) + ") ";

        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        
        try {
            // AGGIORNO IL LUOGO FISICO DA CUI STO PROPAGANDO.
            PreparedStatement ps = bmp.prepareStatement(
                    SQL + ", cod_sit_azl = ? " + SQL_WHERE);
            
            ps.setString(1, strNOM_LUO_FSC);
            ps.setString(2, strDES_LUO_FSC);
            ps.setString(3, strQLF_RSP_LUO_FSC);
            ps.setString(4, strNOM_RSP_LUO_FSC);
            ps.setString(5, strIDZ_PSA_ELT_RSP_LUO_FSC);
            if (lCOD_ALA == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, lCOD_ALA);
            }
            if (lCOD_IMO == 0) {
                ps.setNull(7, java.sql.Types.BIGINT);
            } else {
                ps.setLong(7, lCOD_IMO);
            }
            if (lCOD_IMM_3LV == 0) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setLong(8, lCOD_IMM_3LV);
            }
            if (lCOD_PNO == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, lCOD_PNO);
            }
            ps.setString(10, strFLG_IMP);
            if (lCOD_SIT_AZL == 0){
                ps.setNull(11, java.sql.Types.BIGINT);
            } else {
                ps.setLong(11, lCOD_SIT_AZL);
            }
            
            // Condizioni di where
            ps.setLong(12, COD_LUO_FSC);
            ps.setLong(13, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Il luogo fisico con ID=" + COD_LUO_FSC + " non &egrave stato trovato");
            } else {
                if (alAziende != null && alAziende.isEmpty() == false){
                    // AGGIORNO I LUOGHI FISICI PROPAGATI.
                    ps = bmp.prepareStatement(
                            SQL + SQL_WHERE_EXTENDED);

                    ps.setString(1, strNOM_LUO_FSC);
                    ps.setString(2, strDES_LUO_FSC);
                    ps.setString(3, strQLF_RSP_LUO_FSC);
                    ps.setString(4, strNOM_RSP_LUO_FSC);
                    ps.setString(5, strIDZ_PSA_ELT_RSP_LUO_FSC);
                    if (lCOD_ALA == 0) {
                        ps.setNull(6, java.sql.Types.BIGINT);
                    } else {
                        ps.setLong(6, lCOD_ALA);
                    }
                    if (lCOD_IMO == 0) {
                        ps.setNull(7, java.sql.Types.BIGINT);
                    } else {
                        ps.setLong(7, lCOD_IMO);
                    }
                    if (lCOD_PNO == 0) {
                        ps.setNull(9, java.sql.Types.BIGINT);
                    } else {
                        ps.setLong(9, lCOD_PNO);
                    }
                    ps.setString(10, strFLG_IMP);

                    // Condizioni di where
                    ps.setLong(11, COD_LUO_FSC);
                    if (ps.executeUpdate() == 0) {
                        throw new NoSuchEntityException("Impossibile trovare i luoghi fisici propagati");
                    }
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
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
    public void addDocumento(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO doc_luo_fsc_tab (cod_luo_fsc, cod_doc) " + " VALUES(?,?)");
            ps.setLong(1, COD_LUO_FSC);
            ps.setLong(2, l);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------

    public void removeDocumento(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM doc_luo_fsc_tab " + " WHERE cod_luo_fsc=? AND cod_doc=?");
            ps.setLong(1, COD_LUO_FSC);
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
//---

    public void addMacchine(long l) {
        BMPConnection bmp = getConnection();
        try {
            java.util.Date cdt = new java.util.Date();
            java.sql.Date Today = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO mac_luo_fsc_tab (cod_luo_fsc, cod_mac, dat_mac_luo) " + " VALUES(?,?,?)");
            ps.setLong(1, COD_LUO_FSC);
            ps.setLong(2, l);
            ps.setDate(3, Today);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---
//----------------------------------------------------

    public void removeMacchine(long l, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
//-------remove associated rischi---------
            int res = this.removeMacchinaAssRischi(l, lCOD_AZL);
//----------------------------------------
            if (res == 1) {
                PreparedStatement ps = bmp.prepareStatement(
                        "DELETE FROM mac_luo_fsc_tab " +
                        " WHERE cod_luo_fsc=? AND cod_mac=?");
                ps.setLong(1, this.COD_LUO_FSC);
                ps.setLong(2, l);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Macchina with ID=" + l + " not found");
                }
            } else {
                throw new NoSuchEntityException("Associated Rischi can not be deleted");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//---
    private int removeMacchinaAssRischi(long lCOD_MAC, long lCOD_AZL) {
        int result = 1;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_DPI, REC_COR, REC_MIS_PET, REC_PRO_SAN;
//++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
//---------------REC_CUR---------
/*
            "SELECT A.COD_RSO "+
            "FROM RSO_LUO_FSC_TAB A "+
            "WHERE A.COD_AZL   = ? "+
            "AND A.COD_LUO_FSC = ? "+
            "AND A.COD_RSO NOT IN( "+
            "SELECT B.COD_RSO "+
            "FROM RSO_MAC_TAB B, MAC_LUO_FSC_TAB H "+
            "WHERE B.COD_MAC   = H.COD_MAC "+
            "AND H.COD_LUO_FSC = ? "+
            "AND B.COD_MAC <> ? )"
             */
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT B.COD_RSO " +
                    "FROM RSO_MAC_TAB B, MAC_LUO_FSC_TAB H " +
                    "WHERE (B.COD_MAC   = H.COD_MAC " +
                    "AND H.COD_LUO_FSC = ? " +
                    "AND H.COD_MAC = ? " +
                    "AND B.COD_AZL = ? )");
            ps.setLong(1, this.COD_LUO_FSC);
            ps.setLong(2, lCOD_MAC);
            ps.setLong(3, lCOD_AZL);
            REC_CUR = ps.executeQuery();
            ps.clearParameters();
            while (REC_CUR.next()) {
//======== RSO_LUO_FSC_TAB ====================
                ps = bmp.prepareStatement(
                        " SELECT COD_RSO_LUO_FSC FROM RSO_LUO_FSC_TAB " +
                        " WHERE ( COD_RSO=?  AND  COD_LUO_FSC= ? AND COD_AZL=? )");
                ps.setLong(1, REC_CUR.getLong(1));
                ps.setLong(2, this.COD_LUO_FSC);
                ps.setLong(3, lCOD_AZL);
                REC_MIS_PET = ps.executeQuery();
                ps.clearParameters();

                while (REC_MIS_PET.next()) {
                    ps = bmp.prepareStatement(
                            " DELETE FROM MIS_PET_LUO_FSC_TAB " +
                            " WHERE COD_RSO_LUO_FSC = ? ");
                    ps.setLong(1, REC_MIS_PET.getLong(1));
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                REC_MIS_PET.close();
//------------------
                ps = bmp.prepareStatement(
                        " DELETE FROM RSO_LUO_FSC_TAB WHERE ( COD_RSO=?  AND  COD_LUO_FSC= ? AND COD_AZL=? ) ");
                ps.setLong(1, REC_CUR.getLong(1));
                ps.setLong(2, this.COD_LUO_FSC);
                ps.setLong(3, lCOD_AZL);
                ps.executeUpdate();
                ps.clearParameters();

//======== DPI_LUO_FSC_TAB ==============
if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false)){
                ps = bmp.prepareStatement(
                        "SELECT a.cod_tpl_dpi FROM dpi_luo_fsc_tab a  " +
                        "WHERE a.cod_luo_fsc =?	AND a.cod_tpl_dpi IN  " +
                        "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b " +
                        "WHERE b.cod_azl = ?  AND b.cod_rso=? )   " +
                        "AND a.cod_tpl_dpi NOT IN " +
                        "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_luo_fsc_tab d " +
                        "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
                ps.setLong(1, this.COD_LUO_FSC);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, REC_CUR.getLong(1)); //COD_RSO
                ps.setLong(4, REC_CUR.getLong(1));
                ps.setLong(5, lCOD_AZL);
                ps.setLong(6, this.COD_LUO_FSC);
                REC_DPI = ps.executeQuery();
                ps.clearParameters();
                while (REC_DPI.next()) {
                    ps = bmp.prepareStatement(
                            " DELETE FROM DPI_LUO_FSC_TAB " +
                            " WHERE ( COD_TPL_DPI = ? AND COD_LUO_FSC=? )");
                    ps.setLong(1, REC_DPI.getLong(1));
                    ps.setLong(2, this.COD_LUO_FSC);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                REC_DPI.close();}
//======== COR_LUO_FSC_TAB ==============
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false)){
                ps = bmp.prepareStatement(
                        "SELECT a.cod_cor  FROM cor_luo_fsc_tab a  " +
                        "WHERE a.cod_luo_fsc = ? AND a.cod_cor IN  " +
                        "(SELECT b.cod_cor FROM cor_rso_tab b  " +
                        "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  " +
                        "(SELECT c.cod_cor FROM cor_rso_tab c, rso_luo_fsc_tab d  " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
                ps.setLong(1, this.COD_LUO_FSC);
                ps.setLong(2, lCOD_AZL);
                ps.setLong(3, REC_CUR.getLong(1));
                ps.setLong(4, REC_CUR.getLong(1));
                ps.setLong(5, lCOD_AZL);
                ps.setLong(6, this.COD_LUO_FSC);
                REC_COR = ps.executeQuery();
                ps.clearParameters();
                while (REC_COR.next()) {
                    ps = bmp.prepareStatement(
                            " DELETE FROM COR_LUO_FSC_TAB " +
                            " WHERE ( COD_COR = ? AND COD_LUO_FSC=? )");
                    ps.setLong(1, REC_COR.getLong(1));
                    ps.setLong(2, this.COD_LUO_FSC);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                REC_COR.close();}
//======== PRO_SAN_LUO_FSC_TAB ==============
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false)){
                ps = bmp.prepareStatement(
                        "SELECT a.cod_pro_san FROM pro_san_luo_fsc_tab a " +
                        "WHERE a.cod_luo_fsc = ?  " +
                        "AND a.cod_pro_san IN " +
                        "(SELECT b.cod_pro_san FROM pro_san_rso_tab b " +
                        "WHERE b.cod_rso = ? AND b.cod_azl =?) " +
                        "AND a.cod_pro_san NOT IN " +
                        "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_luo_fsc_tab d " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ?)");
                ps.setLong(1, this.COD_LUO_FSC);
                ps.setLong(2, REC_CUR.getLong(1));
                ps.setLong(3, lCOD_AZL);
                ps.setLong(4, REC_CUR.getLong(1));
                ps.setLong(5, lCOD_AZL);
                ps.setLong(6, this.COD_LUO_FSC);
                REC_PRO_SAN = ps.executeQuery();
                ps.clearParameters();
                while (REC_PRO_SAN.next()) {
                    ps = bmp.prepareStatement(
                            " DELETE FROM PRO_SAN_LUO_FSC_TAB " +
                            " WHERE ( COD_PRO_SAN = ? AND COD_LUO_FSC=? )");
                    ps.setLong(1, REC_PRO_SAN.getLong(1));
                    ps.setLong(2, this.COD_LUO_FSC);
                    ps.executeUpdate();
                    ps.clearParameters();
                }
                REC_PRO_SAN.close();}
//
            }
            REC_CUR.close();
            conn.commit();
//-------------------------------
        } catch (Exception ex) {
            result = 0;
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
        return result;
    }
//+++

//<comment description="setter/getters">
//1
    public void setNOM_LUO_FSC(String newNOM_LUO_FSC) {
        if ((NOM_LUO_FSC != null) && (NOM_LUO_FSC.equals(newNOM_LUO_FSC))) {
            return;
        }
        NOM_LUO_FSC = newNOM_LUO_FSC;
        setModified();
    }

    public String getNOM_LUO_FSC() {
        return (NOM_LUO_FSC != null) ? NOM_LUO_FSC : "";
    }
//2

    public long getCOD_LUO_FSC() {
        return COD_LUO_FSC;
    }

    public String getsCOD_LUO_FSC() {
        return new Long(COD_LUO_FSC).toString();
    }
//3

    public void setCOD_SIT_AZL(long newCOD_SIT_AZL) {
        if (COD_SIT_AZL == newCOD_SIT_AZL) {
            return;
        }
        COD_SIT_AZL = newCOD_SIT_AZL;
        setModified();
    }

    public long getCOD_SIT_AZL() {
        return COD_SIT_AZL;
    }
//4

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
//-----------------------------
//5

    public void setCOD_ALA(long newCOD_ALA) {
        if (COD_ALA == newCOD_ALA) {
            return;
        }
        COD_ALA = newCOD_ALA;
        setModified();
    }

    public long getCOD_ALA() {
        return COD_ALA;
    }
//6

    public void setCOD_IMO(long newCOD_IMO) {
        if (COD_IMO == newCOD_IMO) {
            return;
        }
        COD_IMO = newCOD_IMO;
        setModified();
    }

    public long getCOD_IMO() {
        return COD_IMO;
    }

    
    public void setCOD_IMM_3LV(long newCOD_IMM_3LV) {
        if (COD_IMM_3LV == newCOD_IMM_3LV) {
            return;
        }
        COD_IMM_3LV = newCOD_IMM_3LV;
        setModified();
    }

    public long getCOD_IMM_3LV() {
        return COD_IMM_3LV;
    }

//7

    public void setCOD_PNO(long newCOD_PNO) {
        if (COD_PNO == newCOD_PNO) {
            return;
        }
        COD_PNO = newCOD_PNO;
        setModified();
    }

    public long getCOD_PNO() {
        return COD_PNO;
    }
//8

    public String getDES_LUO_FSC() {
        return (DES_LUO_FSC != null) ? DES_LUO_FSC : "";
    }

    public void setDES_LUO_FSC(String newDES_LUO_FSC) {
        if ((DES_LUO_FSC != null) && (DES_LUO_FSC.equals(newDES_LUO_FSC))) {
            return;
        }
        DES_LUO_FSC = newDES_LUO_FSC;
        setModified();
    }
//9

    public String getQLF_RSP_LUO_FSC() {
        return (QLF_RSP_LUO_FSC != null) ? QLF_RSP_LUO_FSC : "";
    }

    public void setQLF_RSP_LUO_FSC(String newQLF_RSP_LUO_FSC) {
        if ((QLF_RSP_LUO_FSC != null) && (QLF_RSP_LUO_FSC.equals(newQLF_RSP_LUO_FSC))) {
            return;
        }
        QLF_RSP_LUO_FSC = newQLF_RSP_LUO_FSC;
        setModified();
    }
//10

    public String getNOM_RSP_LUO_FSC() {
        return (NOM_RSP_LUO_FSC != null) ? NOM_RSP_LUO_FSC : "";
    }

    public void setNOM_RSP_LUO_FSC(String newNOM_RSP_LUO_FSC) {
        if ((NOM_RSP_LUO_FSC != null) && (NOM_RSP_LUO_FSC.equals(newNOM_RSP_LUO_FSC))) {
            return;
        }
        NOM_RSP_LUO_FSC = newNOM_RSP_LUO_FSC;
        setModified();
    }
//11

    public String getIDZ_PSA_ELT_RSP_LUO_FSC() {
        return (IDZ_PSA_ELT_RSP_LUO_FSC != null) ? IDZ_PSA_ELT_RSP_LUO_FSC : "";
    }

    public void setIDZ_PSA_ELT_RSP_LUO_FSC(String newIDZ_PSA_ELT_RSP_LUO_FSC) {
        if ((IDZ_PSA_ELT_RSP_LUO_FSC != null) && (IDZ_PSA_ELT_RSP_LUO_FSC.equals(newIDZ_PSA_ELT_RSP_LUO_FSC))) {
            return;
        }
        IDZ_PSA_ELT_RSP_LUO_FSC = newIDZ_PSA_ELT_RSP_LUO_FSC;
        setModified();
    }
    //12  inserito flag impianto
       public String getFLG_IMP() {
        return (FLG_IMP != null) ? FLG_IMP : "";
    }

    public void setFLG_IMP(String newFLG_IMP) {
        if ((FLG_IMP != null) && (FLG_IMP.equals(newFLG_IMP))) {
            return;
        }
        FLG_IMP = newFLG_IMP;
        setModified();
    }

///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>

//<comment description="extended setters/getters">

    public Collection ejbGetAnagrLuoghiFisici_4Sede_List_View(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
			+ "f.cod_sit_azl, "
			+ "f.nom_sit_azl, "
			+ "d.cod_imm, "
			+ "d.nom_imm, "
                        + "b.cod_luo_fsc, "
                        + "b.nom_luo_fsc, "
                        + "e.nom_pno "
                    + "FROM "
                        + "MAN_UNI_ORG_TAB a, "
                        + "UNI_ORG_LUO_FSC_TAB c, "
                        + "ANA_LUO_FSC_TAB b "
				+ "LEFT OUTER JOIN ANA_PNO_TAB e "
					+ "ON b.cod_pno = e.cod_pno, "
                        + "ANA_IMM_TAB d, "
                        + "ANA_SIT_AZL_TAB f "
                    + "WHERE "
                        + "a.cod_uni_org = c.cod_uni_org "
                        + "AND c.cod_luo_fsc = b.cod_luo_fsc "
                        + "AND b.cod_imm_3lv = d.cod_imm "
                        + "AND b.cod_azl = d.cod_azl "
                        + "AND d.cod_sit_azl = f.cod_sit_azl "
                        + "AND d.cod_azl = f.cod_azl "
                        + "AND b.cod_azl = ? "
                        + "AND a.cod_man = ? "
                    + "ORDER BY "
			+ "f.nom_sit_azl, "
			+ "d.nom_imm, "
			+ "b.nom_luo_fsc, "
                        + "e.nom_pno"
            );
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_4Sede_List_View obj = new AnagrLuoghiFisici_4Sede_List_View();
                obj.COD_SIT_AZL = rs.getLong(1);
                obj.NOM_SIT_AZL = rs.getString(2);
                obj.COD_IMO = rs.getLong(3);
                obj.NOM_IMO = rs.getString(4);
                obj.COD_LUO_FSC = rs.getLong(5);
                obj.NOM_LUO_FSC = rs.getString(6);
                obj.NOM_PNO = rs.getString(7);
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

    public Collection ejbGetAnagrLuoghiFisici_List_View(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    /*
                    "SELECT " +
                    " distinct b.cod_luo_fsc, " +
                    " b.nom_luo_fsc " +
                    " FROM   MAN_UNI_ORG_TAB a, " +
                    " 	UNI_ORG_LUO_FSC_TAB c, " +
                    " 	ANA_LUO_FSC_TAB b " +
                    " WHERE  a.cod_uni_org = c.cod_uni_org " +
                    " 	AND c.cod_luo_fsc = b.cod_luo_fsc " +
                    " 	AND b.cod_azl     =? " +
                    " 	AND a.cod_man     =? ORDER BY 2");
                     */
                    /*
                     * Correzione su anomalia segnalata da Natalia il 12/2009
                     * Questo metodo estrae i luoghi fisici associati alle
                     * unità organizzative in cui è presente l'attività lavorativa
                     * di cui si sta effettuando la stampa.
                     * Se l'attività è presente in più UO e queste hanno gli stessi
                     * luoghi fisici, lo stesso luogo fisico viene presentato più volte.
                     *
                     * Questo comportamento appare non corretto.
                     * Il metodo è stato modificato affinche presenti una sola volta
                     * un determinato luogo fisico anche se associato a più UO, a
                     * loro volta associate all'attività lavorativa di cui si stà
                     * effettuando la stampa.
                     */
                    "SELECT " +
                        "distinct b.cod_luo_fsc, " +
                        "b.nom_luo_fsc " +
                    "FROM " +
                        "MAN_UNI_ORG_TAB a, " +
                        "UNI_ORG_LUO_FSC_TAB c, " +
                        "ANA_LUO_FSC_TAB b " +
                    "WHERE " +
                        "a.cod_uni_org = c.cod_uni_org " +
                        "AND c.cod_luo_fsc = b.cod_luo_fsc " +
                        "AND b.cod_azl = ? " +
                        "AND a.cod_man = ? " +
                    "ORDER BY 2 ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View obj = new AnagrLuoghiFisici_List_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetAnagrLuoghiFisici_List_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_luo_fsc, " +
                        "nom_luo_fsc, " +
                        "des_luo_fsc " +
                    "FROM " +
                        "ana_luo_fsc_tab " +
                    "WHERE " +
                        "cod_azl=? " +
                    "order by " +
                        "nom_luo_fsc");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View obj = new AnagrLuoghiFisici_List_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
                obj.DES_LUO_FSC = rs.getString(3);
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

    public Collection ejbGetAllAnagrLuoghiFisici_List_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_luo_fsc, "
                        + "nom_luo_fsc "
                    + "FROM "
                        + "ana_luo_fsc_tab "
                    + "order by "
                        + "nom_luo_fsc");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View obj = new AnagrLuoghiFisici_List_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetAnagrLuoghiFisici_Sit_Azl_View(long COD_SIT_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_luo_fsc, "
                        + "nom_luo_fsc, "
                        + "nom_rsp_luo_fsc "
                    + "FROM "
                        + "ana_luo_fsc_tab "
                    + "where "
                        + "cod_sit_azl=? ");
            ps.setLong(1, COD_SIT_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_Sit_Azl_View obj = new AnagrLuoghiFisici_Sit_Azl_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
                obj.NOM_RSP_LUO_FSC = rs.getString(3);
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

    public Collection ejbGetAnagrLuoghiFisici_Imm_3lv_View(long COD_IMM_3LV){
        String strSql =
                "SELECT "
                    + "cod_luo_fsc, "
                    + "nom_luo_fsc "
                + "FROM "
                    + "ana_luo_fsc_tab "
                + "WHERE "
                    + "cod_imm_3lv = ? ";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, COD_IMM_3LV);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View obj = new AnagrLuoghiFisici_List_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Dario Massaroni - 26-10-2007
    public Collection ejbGetAnagrLuoghiFisici_NOM_List_View(String strNOM_LUO_FSC, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   cod_luo_fsc, " +
                    "   nom_luo_fsc " +
                    "FROM " +
                    "   ana_luo_fsc_tab " +
                    "where " +
                    "   UPPER(nom_luo_fsc)=? " +
                    "   and cod_azl=?");
            ps.setString(1, strNOM_LUO_FSC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View obj = new AnagrLuoghiFisici_List_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection getRischiByLuoghiFisiciView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_rso, "
                        + "a.nom_rso, "
                        + "b.cod_rso_luo_fsc as codice, "
                        + "b.stm_num_rso as p_per_d, "
                        + "d.nom_luo_fsc as nome "
                    + "from "
                        + "ana_rso_tab a, "
                        + "rso_luo_fsc_tab b, "
                        + "ana_luo_fsc_tab d "
                    + "where "
                        + "a.cod_rso = b.cod_rso "
                        + "and a.cod_azl = b.cod_azl "
                        + "and b.cod_luo_fsc = d.cod_luo_fsc "
                        + "and d.cod_luo_fsc = ? "
                        + "and a.cod_azl = ? "
                    + "order by "
                        + "a.nom_rso");
            ps.setLong(1, COD_LUO_FSC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischiByLuoghiFisiciView obj = new RischiByLuoghiFisiciView();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.lCOD_RSO_LUO_FSC = rs.getLong(3);
                obj.strSTM_NUM_RSO = rs.getString(4);
                obj.strNOM_LUO_FSC = rs.getString(5);
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
//-------------------

    public Collection getInfortuniIncidentiView() {

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT ait.cod_luo_fsc,adt.nom_dpd,adt.cog_dpd, anlt.nom_nat_les, tfit.nom_tpl_frm_ino FROM view_ana_dpd_tab adt inner join ana_ino_tab ait on (adt.cod_dpd = ait.cod_dpd) inner join tpl_frm_ino_tab tfit on (tfit.cod_tpl_frm_ino = ait.cod_tpl_frm_ino) left join ana_nat_les_tab anlt on (anlt.cod_nat_les = ait.cod_nat_les)  where ait.cod_luo_fsc = ?");

            ps.setLong(1, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiInfortuniIncidenti_View v = new LuogiInfortuniIncidenti_View();
                v.lCOD_LUO_FSC = rs.getLong(1);
                v.strNOM_DPD = rs.getString(2);
                v.strCOG_DPD = rs.getString(3);
                v.strNOM_NAT_LES = rs.getString(4);
                v.strNOM_TPL_FRM_INO = rs.getString(5);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getDpiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " tpl_dpi_tab.cod_tpl_dpi" + ", tpl_dpi_tab.nom_tpl_dpi" + " FROM dpi_luo_fsc_tab,  tpl_dpi_tab" + " WHERE " + " dpi_luo_fsc_tab.cod_tpl_dpi=tpl_dpi_tab.cod_tpl_dpi " + " AND dpi_luo_fsc_tab.cod_luo_fsc=?");

            ps.setLong(1, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                RischioDpi_View v = new RischioDpi_View();
                v.lCOD_TPL_DPI = rs.getLong(1);
                v.strNOM_TPL_DPI = rs.getString(2);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getCorsiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_cor_tab.cod_cor" + ", ana_cor_tab.nom_cor" + " FROM cor_luo_fsc_tab,  ana_cor_tab" + " WHERE " + " cor_luo_fsc_tab.cod_cor=ana_cor_tab.cod_cor " + " AND cor_luo_fsc_tab.cod_luo_fsc=?");

            ps.setLong(1, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiCorsi_View v = new LuogiCorsi_View();
                v.lCOD_COR = rs.getLong(1);
                v.strNOM_COR = rs.getString(2);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_doc_tab.cod_doc," + " ana_doc_tab.tit_doc," + " ana_doc_tab.rsp_doc," + " ana_doc_tab.dat_rev_doc" + " FROM doc_luo_fsc_tab, ana_doc_tab" + " WHERE" + " doc_luo_fsc_tab.cod_doc=ana_doc_tab.cod_doc" + " AND doc_luo_fsc_tab.cod_luo_fsc=?");

            ps.setLong(1, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiDocumenti_View v = new LuogiDocumenti_View();
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

//</comment>
//<report>
    public Collection getReportAnagrLuoghiFisici_Rischi_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_rso, "
                        + "a.nom_rso, "
                        + "a.des_rso, "
                        + " a.PRB_EVE_LES, "
                        + "a.ENT_DAN, "
                        + "a.STM_NUM_RSO, "
                        + "a.FRQ_RIP_ATT_DAN, "
                        + "a.NUM_INC_INF "
                    + "from "
                        + "ana_rso_tab a, "
                        + "rso_luo_fsc_tab b, "
                        + "ana_luo_fsc_tab d "
                    + "where "
                        + "a.cod_rso = b.cod_rso "
                        + "and a.cod_azl = b.cod_azl "
                        + "and b.cod_luo_fsc = d.cod_luo_fsc "
                        + "and d.cod_luo_fsc = ? "
                        + "and a.cod_azl = ? "
                    + "order by "
                        + "a.nom_rso");
            ps.setLong(1, COD_LUO_FSC);
            ps.setLong(2, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportAnagrLuoghiFisici_Rischi_View obj = new ReportAnagrLuoghiFisici_Rischi_View();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.strDES_RSO = rs.getString(3);
                obj.lPRB_EVE_LES = rs.getLong(4);
                obj.lENT_DAN = rs.getLong(5);
                obj.lSTM_NUM_RSO = rs.getFloat(6);
                obj.lFRQ_RIP_ATT_DAN = rs.getLong(7);
                obj.lNUM_INC_INF = rs.getLong(8);
                al.add(obj);
            }
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//</report>

    public void addLUO_FSC_COR(long lCOD_COR, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cor_luo_fsc_tab (cod_cor,cod_luo_fsc,prs_cor,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, COD_LUO_FSC);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addLUO_FSC_DPI(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO dpi_luo_fsc_tab (cod_tpl_dpi,cod_luo_fsc,prs_dpi,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_TPL_DPI);
            ps.setLong(2, COD_LUO_FSC);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addLUO_FSC_PRO_SAN(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO pro_san_luo_fsc_tab (cod_pro_san,cod_luo_fsc,prs_pro_san,dat_inz) VALUES(?,?,'S',?)");
            ps.setLong(1, lCOD_PRO_SAN);
            ps.setLong(2, COD_LUO_FSC);
            ps.setDate(3, dDAT_INZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public boolean isMultiple() {
        return isExtendedObject("ana_luo_fsc_tab", COD_LUO_FSC);
    }

    public Collection findEx(long lCOD_AZL,
            Long lCOD_SIT_AZL,
            Long lCOD_PNO,
            Long lCOD_ALA,
            Long lCOD_IMO,
            Long lCOD_IMM_3LV,
            String strNOM_LUO_FSC,
            String strDES_LUO_FSC,
            String strNOM_RSP_LUO_FSC,
            String strIDZ_PSA_ELT_RSP_LUO_FSC,
            String strQLF_RSP_LUO_FSC,
            String strFLG_IMP,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(
                lCOD_AZL,
                lCOD_SIT_AZL,
                lCOD_PNO,
                lCOD_ALA,
                lCOD_IMO,
                lCOD_IMM_3LV,
                strNOM_LUO_FSC,
                strDES_LUO_FSC,
                strNOM_RSP_LUO_FSC,
                strIDZ_PSA_ELT_RSP_LUO_FSC,
                strQLF_RSP_LUO_FSC,
                strFLG_IMP,
                iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL,
            Long lCOD_SIT_AZL,
            Long lCOD_PNO,
            Long lCOD_ALA,
            Long lCOD_IMO,
            Long lCOD_IMM_3LV,
            String strNOM_LUO_FSC,
            String strDES_LUO_FSC,
            String strNOM_RSP_LUO_FSC,
            String strIDZ_PSA_ELT_RSP_LUO_FSC,
            String strQLF_RSP_LUO_FSC,
            String strFLG_IMP,
            int iOrderParameter /*not used for now*/) {
        String strSql =
                "SELECT "
                    + "a.cod_luo_fsc, "
                    + "a.cod_sit_azl, "
                    + "a.cod_ala, "
                    + "a.cod_imo, "
                    + "a.cod_imm_3lv, "
                    + "b.nom_imm, "
                    + "a.cod_pno, "
                    + "a.nom_luo_fsc, "
                    + "a.des_luo_fsc, "
                    + "a.qlf_rsp_luo_fsc, "
                    + "a.nom_rsp_luo_fsc, "
                    + "a.idz_psa_elt_rsp_luo_fsc, "
                    + "a.cod_azl, "
                    + "a.flg_imp "
                + "FROM "
                    + "ana_luo_fsc_tab a "
                        + "left outer join ana_imm_tab b "
                        + "on (a.cod_imm_3lv = b.cod_imm) "
                + "WHERE "
                    + "a.cod_azl = ?";
        if (lCOD_PNO != null) {
            strSql += " AND a.cod_pno=? ";
        }
        if (lCOD_ALA != null) {
            strSql += " AND a.cod_ala=? ";
        }
        if (lCOD_IMO != null) {
            strSql += " AND a.cod_imo=? ";
        }
        if (lCOD_IMM_3LV != null && lCOD_IMM_3LV.longValue()!=0) {
            strSql += " AND a.cod_imm_3lv=? ";
        }
        if (lCOD_SIT_AZL != null && lCOD_SIT_AZL.longValue()!=0) {
            strSql += " AND a.cod_sit_azl=? ";
        }
        if (strNOM_LUO_FSC != null) {
            strSql += " AND UPPER(a.nom_luo_fsc) LIKE ?";
        }
        if (strDES_LUO_FSC != null) {
            strSql += " AND UPPER(a.des_luo_fsc) LIKE ?";
        }
        if (strNOM_RSP_LUO_FSC != null) {
            strSql += " AND UPPER(a.nom_rsp_luo_fsc) LIKE ?";
        }
        if (strIDZ_PSA_ELT_RSP_LUO_FSC != null) {
            strSql += " AND UPPER(a.idz_psa_elt_rsp_luo_fsc) LIKE ?";
        }
        if (strQLF_RSP_LUO_FSC != null) {
            strSql += " AND UPPER(a.qlf_rsp_luo_fsc) LIKE ?";
        }
         if (strFLG_IMP != null) {
            strSql += " AND UPPER(a.flg_imp) LIKE ?";
        }
        strSql += " ORDER BY UPPER(b.nom_imm), UPPER(a.nom_luo_fsc)";
        int i = 1;
        BMPConnection bmp = getConnection();
       
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);
            if (lCOD_PNO != null) {
                ps.setLong(i++, lCOD_PNO.longValue());
            }
            if (lCOD_ALA != null) {
                ps.setLong(i++, lCOD_ALA.longValue());
            }
            if (lCOD_IMO != null) {
                ps.setLong(i++, lCOD_IMO.longValue());
            }
            if (lCOD_IMM_3LV != null && lCOD_IMM_3LV.longValue()!=0) {
                ps.setLong(i++, lCOD_IMM_3LV.longValue());
            }
            if (lCOD_SIT_AZL != null && lCOD_SIT_AZL.longValue()!=0) {
                ps.setLong(i++, lCOD_SIT_AZL.longValue());
            }
            if (strNOM_LUO_FSC != null) {
                ps.setString(i++, strNOM_LUO_FSC.toUpperCase());
            }
            if (strDES_LUO_FSC != null) {
                ps.setString(i++, strDES_LUO_FSC.toUpperCase());
            }
            if (strNOM_RSP_LUO_FSC != null) {
                ps.setString(i++, strNOM_RSP_LUO_FSC.toUpperCase());
            }
            if (strIDZ_PSA_ELT_RSP_LUO_FSC != null) {
                ps.setString(i++, strIDZ_PSA_ELT_RSP_LUO_FSC.toUpperCase());
            }
            if (strQLF_RSP_LUO_FSC != null) {
                ps.setString(i++, strQLF_RSP_LUO_FSC.toUpperCase());
            }
              if (strFLG_IMP != null) {
                ps.setString(i++, strFLG_IMP.toUpperCase());
            }
//----------------------------------------------------------------------
            
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                AnagrLuoghiFisici_List_View v = new AnagrLuoghiFisici_List_View();
                v.COD_IMM_3LV = rs.getLong(5);
                v.NOM_IMM = rs.getString(6);
                v.COD_LUO_FSC = rs.getLong(1);
                v.NOM_LUO_FSC = rs.getString(8);
                v.DES_LUO_FSC = rs.getString(9);
                v.QLF_RSP_LUO_FSC = rs.getString(10);
                v.NOM_RSP_LUO_FSC = rs.getString(11);
                ar.add(v);
            }
            return ar;
//----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AnagrLuoghiFisiciBean"/>
