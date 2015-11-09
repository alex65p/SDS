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
package com.apconsulting.luna.ejb.AssociativaAgentoChimico;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class AssociativaAgentoChimicoBean extends BMPEntityBean implements IAssociativaAgentoChimicoHome, IAssociativaAgentoChimico {
    // Zdes opredeliajutsia peremennie EJB obiekta

    long lCOD_SOS_CHI;		//1
    String strDES_SOS;		//2
    String strNOM_COM_SOS;	//3
    String strFRS_R;		//4
    String strFRS_S;		//5
    String strSIM_RIS;		//6
    long lCOD_SIM;			//7
    long lCOD_STA_FSC;		//8
    long lCOD_CLF_SOS;		//9
    long lCOD_PTA_FSC;		//10
    String sTIP_RSO;		//11
    public static final String BEAN_NAME = "AssociativaAgentoChimicoBean";
////////////////////////// CONSTRUCTOR//////////////////////////////////////////
    private static AssociativaAgentoChimicoBean ys = null;

    private AssociativaAgentoChimicoBean() {
    }

    public static AssociativaAgentoChimicoBean getInstance() {
        if (ys == null) {
            ys = new AssociativaAgentoChimicoBean();
        }
        return ys;
    }
////////////////////////////////////////////////////////////////////////////////

//  Zdes opredeliayutsia metody EJB objecta
//------------------------------------
    public IAssociativaAgentoChimico create(String strDES_SOS, String strNOM_COM_SOS, long lCOD_STA_FSC, long lCOD_CLF_SOS, long lCOD_PTA_FSC, String sTIP_RSO) throws javax.ejb.CreateException {
        AssociativaAgentoChimicoBean bean = new AssociativaAgentoChimicoBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
//------------------------------------

    @Override
    public void remove(Object primaryKey) {
        AssociativaAgentoChimicoBean bean = new AssociativaAgentoChimicoBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        }
    }
//------------------------------------

    public IAssociativaAgentoChimico findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        AssociativaAgentoChimicoBean bean = new AssociativaAgentoChimicoBean();
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
//------------------------------------

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
//------------------------------------
    // (Home Intrface) VIEWS

    public Collection getSOS_CHI_LUO_FSC_View(long COD_SOS_CHI, long COD_LUO_FSC) {
        return (new AssociativaAgentoChimicoBean()).ejbGetSOS_CHI_LUO_FSC_View(COD_SOS_CHI, COD_LUO_FSC);
    }

    public Collection getSOS_CHI_LUO_FSC_TPL_QTA_View() {
        return (new AssociativaAgentoChimicoBean()).ejbGetSOS_CHI_LUO_FSC_TPL_QTA_View();
    }

    public Collection getSOS_CHI_LUO_FSC_View() {
        return (new AssociativaAgentoChimicoBean()).ejbGetSOS_CHI_LUO_FSC_View();
    }

    public Collection getAssAgentiChimichi_View() {
        return (new AssociativaAgentoChimicoBean()).ejbGetAssAgentiChimichi_View();
    }

    public Collection findEx(String NOM_COM_SOS, String DES_SOS, long COD_STA_FSC, long COD_CLF_SOS, int iOrder) {
        return (new AssociativaAgentoChimicoBean()).ejbfindEx(NOM_COM_SOS, DES_SOS, COD_STA_FSC, COD_CLF_SOS, iOrder);
    }

    public Collection getRischi_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetRischi_View(lCOD_SOS_CHI, lCOD_AZL);
    }

    public Collection getLuoghiFisici_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetLuoghiFisici_View(lCOD_SOS_CHI, lCOD_AZL);
    }

    public Collection getFrasiR_View(long lCOD_SOS_CHI) {
        return (new AssociativaAgentoChimicoBean()).ejbGetFrasiR_View(lCOD_SOS_CHI);
    }

    public Collection getFrasiS_View(long lCOD_SOS_CHI) {
        return (new AssociativaAgentoChimicoBean()).ejbGetFrasiS_View(lCOD_SOS_CHI);
    }

    public Collection getDocumenti_View(long lCOD_SOS_CHI) {
        return (new AssociativaAgentoChimicoBean()).ejbGetDocumenti_View(lCOD_SOS_CHI);
    }

    public Collection getNormSent_View(long lCOD_SOS_CHI) {
        return (new AssociativaAgentoChimicoBean()).ejbGetNormSent_View(lCOD_SOS_CHI);
    }
    //<report>

    public Collection getReportRischi_View(long lCOD_AZL, long lCOD_SOS_CHI) {
        return this.ejbGetReportRirchi_View(lCOD_AZL, lCOD_SOS_CHI);
    }
    //</report>

    public Collection getSOS_CHI_View() {
        return (new AssociativaAgentoChimicoBean()).ejbGetSOS_CHI_View();
    }
    //<alex>

    public void addSostanzeRischiToOperazione(long lCOD_OPE_SVO, long lCOD_SOS_CHI, long lCOD_AZL) {
        ejbAddSostanzeRischiToOperazione(lCOD_OPE_SVO, lCOD_SOS_CHI, lCOD_AZL);
    }

    public Collection getRischioSostanza_View(long lCOD_SOS_CHI) {
        return (new AssociativaAgentoChimicoBean()).ejbGetRischioSostanza_View(lCOD_SOS_CHI);
    }
    //</alex>

    //<alex date="01/04/2004">
    public Collection getCARICA_LUOGHI_FISICI_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetCARICA_LUOGHI_FISICI_View(lCOD_SOS_CHI, lCOD_AZL);
    }

    public Collection getCARICA_ATTIVITA_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetCARICA_ATTIVITA_View(lCOD_SOS_CHI, lCOD_AZL);
    }

    public int getCountAttivitaForSostanza(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetCountAttivitaForSostanza(lCOD_SOS_CHI, lCOD_AZL);
    }

    public int getCountLuoghiForSostanza(long lCOD_SOS_CHI, long lCOD_AZL) {
        return (new AssociativaAgentoChimicoBean()).ejbGetCountLuoghiForSostanza(lCOD_SOS_CHI, lCOD_AZL);
    }
    //</alex>
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    //</IXXXHome-implementation>
    public Long ejbCreate(String strDES_SOS, String strNOM_COM_SOS, long lCOD_STA_FSC, long lCOD_CLF_SOS, long lCOD_PTA_FSC, String spTIP_RSO) {
        this.lCOD_SOS_CHI = NEW_ID();
        this.strDES_SOS = strDES_SOS;
        this.strNOM_COM_SOS = strNOM_COM_SOS;
        this.lCOD_STA_FSC = lCOD_STA_FSC;
        this.lCOD_CLF_SOS = lCOD_CLF_SOS;
        this.lCOD_PTA_FSC = lCOD_PTA_FSC;
        this.sTIP_RSO = spTIP_RSO;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_sos_chi_tab (cod_sos_chi,des_sos,nom_com_sos,cod_sta_fsc,cod_clf_sos,cod_pta_fsc, tip_rso) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setString(2, strDES_SOS);
            ps.setString(3, strNOM_COM_SOS);
            ps.setLong(4, lCOD_STA_FSC);
            ps.setLong(5, lCOD_CLF_SOS);
            ps.setLong(6, lCOD_PTA_FSC);
            ps.setString(7, this.sTIP_RSO);
            ps.executeUpdate();
            return new Long(lCOD_SOS_CHI);
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------------

    public void ejbPostCreate(String strDES_SOS, String strNOM_COM_SOS, long lCOD_STA_FSC, long lCOD_CLF_SOS, long lCOD_PTA_FSC, String spTIP_RSO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sos_chi FROM ana_sos_chi_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------------------------

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//--------------------------------------------------

    public void ejbActivate() {
        this.lCOD_SOS_CHI = ((Long) this.getEntityKey()).longValue();
    }
//--------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_SOS_CHI = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sos_chi,des_sos,nom_com_sos,frs_r,frs_s,sim_ris,cod_sim,cod_sta_fsc,cod_clf_sos,cod_pta_fsc,tip_rso FROM ana_sos_chi_tab WHERE cod_sos_chi=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_SOS_CHI = rs.getLong(1);
                strDES_SOS = rs.getString(2);
                strNOM_COM_SOS = rs.getString(3);
                strFRS_R = rs.getString(4);
                strFRS_S = rs.getString(5);
                strSIM_RIS = rs.getString(6);
                lCOD_SIM = rs.getLong(7);
                lCOD_STA_FSC = rs.getLong(8);
                lCOD_CLF_SOS = rs.getLong(9);
                lCOD_PTA_FSC = rs.getLong(10);
                if (rs.wasNull()) {
                    lCOD_PTA_FSC = 0;
                }
                sTIP_RSO = rs.getString(11);
                if (rs.wasNull()) {
                    sTIP_RSO = "N";
                }
            } else {
                throw new NoSuchEntityException("AssociativaAgentoChimico with ID=" + lCOD_SOS_CHI + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sos_chi_tab WHERE cod_sos_chi=?");
            ps.setLong(1, lCOD_SOS_CHI);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssociativaAgentoChimico with ID=" + lCOD_SOS_CHI + " not found");
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

            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_sos_chi_tab " +
                    "SET des_sos=?, nom_com_sos=?, frs_r=?, frs_s=?, " +
                    "sim_ris=?, cod_sim=?, cod_sta_fsc=?, cod_clf_sos=?, cod_pta_fsc=?, tip_rso=? " +
                    "WHERE cod_sos_chi=?");
            ps.setString(1, strDES_SOS);
            ps.setString(2, strNOM_COM_SOS);
            ps.setString(3, strFRS_R);
            ps.setString(4, strFRS_S);
            ps.setString(5, strSIM_RIS);
            if (lCOD_SIM == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, lCOD_SIM);
            }
            ps.setLong(7, lCOD_STA_FSC);
            ps.setLong(8, lCOD_CLF_SOS);
            ps.setLong(9, lCOD_PTA_FSC);
            ps.setString(10, sTIP_RSO);
            ps.setLong(11, lCOD_SOS_CHI);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssociativaAgentoChimico with ID=" + lCOD_SOS_CHI + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

//----------------------------------------------------------
    //<comment description="setter/getters">
    //----1
    public long getCOD_SOS_CHI() {
        return lCOD_SOS_CHI;
    }
    //----2

    public String getDES_SOS() {
        return strDES_SOS;
    }

    public void setDES_SOS(String strDES_SOS) {
        if ((this.strDES_SOS != null) && (this.strDES_SOS.equals(strDES_SOS))) {
            return;
        }
        this.strDES_SOS = strDES_SOS;
        setModified();
    }
    //----3

    public String getNOM_COM_SOS() {
        return strNOM_COM_SOS;
    }

    public void setNOM_COM_SOS(String strNOM_COM_SOS) {
        if ((this.strNOM_COM_SOS != null) && (this.strNOM_COM_SOS.equals(strNOM_COM_SOS))) {
            return;
        }
        this.strNOM_COM_SOS = strNOM_COM_SOS;
        setModified();
    }
    //----4

    public String getFRS_R() {
        return strFRS_R;
    }

    public void setFRS_R(String strFRS_R) {
        if ((this.strFRS_R != null) && (this.strFRS_R.equals(strFRS_R))) {
            return;
        }
        this.strFRS_R = strFRS_R;
        setModified();
    }
    //----5

    public String getFRS_S() {
        return strFRS_S;
    }

    public void setFRS_S(String strFRS_S) {
        if ((this.strFRS_S != null) && (this.strFRS_S.equals(strFRS_S))) {
            return;
        }
        this.strFRS_S = strFRS_S;
        setModified();
    }
    //----6

    public String getSIM_RIS() {
        return strSIM_RIS;
    }

    public void setSIM_RIS(String strSIM_RIS) {
        if ((this.strSIM_RIS != null) && (this.strSIM_RIS.equals(strSIM_RIS))) {
            return;
        }
        this.strSIM_RIS = strSIM_RIS;
        setModified();
    }
    //----7

    public long getCOD_SIM() {
        return lCOD_SIM;
    }

    public void setCOD_SIM(long lCOD_SIM) {
        if (this.lCOD_SIM == lCOD_SIM) {
            return;
        }
        this.lCOD_SIM = lCOD_SIM;
        setModified();
    }
    //----8

    public long getCOD_STA_FSC() {
        return lCOD_STA_FSC;
    }

    public void setCOD_STA_FSC(long lCOD_STA_FSC) {
        if (this.lCOD_STA_FSC == lCOD_STA_FSC) {
            return;
        }
        this.lCOD_STA_FSC = lCOD_STA_FSC;
        setModified();
    }
    //----9

    public long getCOD_CLF_SOS() {
        return lCOD_CLF_SOS;
    }

    public void setCOD_CLF_SOS(long lCOD_CLF_SOS) {
        if (this.lCOD_CLF_SOS == lCOD_CLF_SOS) {
            return;
        }
        this.lCOD_CLF_SOS = lCOD_CLF_SOS;
        setModified();
    }
    //----10

    public long getCOD_PTA_FSC() {
        return lCOD_PTA_FSC;
    }

    public void setCOD_PTA_FSC(long lCOD_PTA_FSC) {
        if (this.lCOD_PTA_FSC == lCOD_PTA_FSC) {
            return;
        }
        this.lCOD_PTA_FSC = lCOD_PTA_FSC;
        setModified();
        return;
    }

    public String getTIP_RSO() {
        return sTIP_RSO;
    }

    public void setTIP_RSO(String spTIP_RSO) {
        if (this.sTIP_RSO.equalsIgnoreCase(spTIP_RSO)) {
            return;
        }
        this.sTIP_RSO = spTIP_RSO;
        setModified();
        return;
    }

    //</comment>

    //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetAssAgentiChimichi_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sos_chi, nom_com_sos FROM ana_sos_chi_tab ORDER BY nom_com_sos ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssAgentiChimichi_View obj = new AssAgentiChimichi_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
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

    public Collection ejbfindEx(String NOM_COM_SOS, String DES_SOS, long COD_STA_FSC, long COD_CLF_SOS, int iOrder) {
        String Sql = "SELECT a.cod_sos_chi, a.nom_com_sos, a.sim_ris " +
                "FROM ana_sos_chi_tab a, ana_sta_fsc_tab b, ana_clf_sos_tab d " +
                "WHERE a.cod_sta_fsc = b.cod_sta_fsc AND a.cod_clf_sos = d.cod_clf_sos ";
        //"AND NOT EXISTS ( SELECT 1 FROM sos_chi_ope_svo_tab e WHERE a.cod_sos_chi=e.cod_sos_chi) ";
        int i = 1;
        int indexNom = 0;
        if (NOM_COM_SOS != null) {
            Sql += " AND UPPER(a.nom_com_sos) LIKE ? ";
            indexNom = i++;
        }
        int indexDes = 0;
        if (DES_SOS != null) {
            Sql += " AND UPPER(A.DES_SOS) LIKE ? ";
            indexDes = i++;
        }
        int indexSta = 0;
        if (COD_STA_FSC != 0) {
            Sql += " AND B.COD_STA_FSC = ? ";
            indexSta = i++;
        }
        int indexClf = 0;
        if (COD_CLF_SOS != 0) {
            Sql += " AND D.COD_CLF_SOS = ? ";
            indexClf = i++;
        }
        Sql += " ORDER BY UPPER(nom_com_sos)";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (indexNom != 0) {
                ps.setString(indexNom, NOM_COM_SOS.toUpperCase());
            }
            if (indexDes != 0) {
                ps.setString(indexDes, DES_SOS.toUpperCase());
            }
            if (indexSta != 0) {
                ps.setLong(indexSta, COD_STA_FSC);
            }
            if (indexClf != 0) {
                ps.setLong(indexClf, COD_CLF_SOS);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_AssAgentiChimichi obj = new findEx_AssAgentiChimichi();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
                obj.SIM_RIS = rs.getString(3);
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

    public Collection ejbGetRischi_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_rso, ana.cod_azl, ana.nom_rso, ana.ent_dan, ana.rfc_vlu_rso_mes FROM ana_rso_tab ana, rso_sos_chi_tab rso WHERE ana.cod_rso = rso.cod_rso AND ana.cod_azl = rso.cod_azl AND rso.cod_sos_chi = ? and rso.cod_azl=? ORDER BY nom_rso ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischi_View obj = new Rischi_View();
                obj.COD_RSO = rs.getLong(1);
                obj.COD_AZL = rs.getLong(2);
                obj.NOM_RSO = rs.getString(3);
                obj.ENT_DAN = rs.getString(4);
                obj.NB_RFC_VLU_RSO_MES = rs.getString(5);
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

    public Collection ejbGetLuoghiFisici_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "ana.cod_luo_fsc, "
                        + "ana.nom_luo_fsc, "
                        + "sos.qta_uso, "
                        + "sos.qta_gia "
                    + "FROM "
                        + "ana_luo_fsc_tab ana, "
                        + "sos_chi_luo_fsc_tab sos "
                    + "WHERE "
                        + "ana.cod_luo_fsc = sos.cod_luo_fsc "
                        + "AND sos.cod_sos_chi = ? "
                        + "and ana.cod_azl=? "
                    + "ORDER BY "
                        + "nom_luo_fsc ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                LuoghiFisici_View obj = new LuoghiFisici_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
                obj.QTA_USO = rs.getString(3);
                obj.QTA_GIA = rs.getString(4);
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

    public Collection ejbGetFrasiR_View(long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_frs_r, ana.num_frs_r, ana.des_frs_r FROM ana_frs_r_tab ana, frs_r_sos_chi_tab frs WHERE ana.cod_frs_r = frs.cod_frs_r AND frs.cod_sos_chi = ? ORDER BY num_frs_r ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FrasiR_View obj = new FrasiR_View();
                obj.COD_FRS_R = rs.getLong(1);
                obj.NUM_FRS_R = rs.getString(2);
                obj.DES_FRS_R = rs.getString(3);
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

    public Collection ejbGetFrasiS_View(long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_frs_s, ana.num_frs_s, ana.des_frs_s FROM ana_frs_s_tab ana, frs_s_sos_chi_tab frs WHERE ana.cod_frs_s = frs.cod_frs_s AND frs.cod_sos_chi = ? ORDER BY num_frs_s ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FrasiS_View obj = new FrasiS_View();
                obj.COD_FRS_S = rs.getLong(1);
                obj.NUM_FRS_S = rs.getString(2);
                obj.DES_FRS_S = rs.getString(3);
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

    public Collection ejbGetDocumenti_View(long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_doc, ana.tit_doc, ana.rsp_doc, ana.dat_rev_doc FROM ana_doc_tab ana, doc_sos_chi_tab sos WHERE ana.cod_doc = sos.cod_doc AND sos.cod_sos_chi = ? ORDER BY tit_doc ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Documenti_View obj = new Documenti_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                obj.RSP_DOC = rs.getString(3);
                obj.DAT_REV_DOC = rs.getDate(4);
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

    public Collection ejbGetNormSent_View(long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_nor_sen, ana.tit_nor_sen, ana.num_doc_nor_sen, ana.dat_nor_sen FROM ana_nor_sen_tab ana, nor_sen_sos_chi_tab sos WHERE ana.cod_nor_sen = sos.cod_nor_sen AND sos.cod_sos_chi = ? ORDER BY tit_nor_sen ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NormSent_View obj = new NormSent_View();
                obj.COD_NOR_SEN = rs.getLong(1);
                obj.TIT_NOR_SEN = rs.getString(2);
                obj.NUM_DOC_NOR_SEN = rs.getString(3);
                obj.DAT_NOR_SEN = rs.getDate(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //<report>

    public Collection ejbGetReportRirchi_View(long lCOD_AZL, long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "        A.COD_RSO, a.CLF_RSO, a.ENT_DAN, a.RFC_VLU_RSO_mes " +
                    " FROM   ANA_RSO_TAB a, RSO_SOS_CHI_TAB b " +
                    " WHERE  a.cod_rso = b.cod_rso " +
                    " AND b.cod_sos_chI=? AND a.COD_AZL=?" +
                    " ORDER BY a.CLF_RSO");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischi_View obj = new ReportRischi_View();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strCLF_RSO = rs.getString(2);
                obj.lENT_DAN = rs.getLong(3);
                obj.lRFC_VLU_RSO_MES = rs.getLong(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</report>

//-----------------------------#############################################
    // %%%Link%%% Table SOS_CHI_LUO_FSC_TAB
    public void addSOS_CHI_LUO_FSC(long lCOD_LUO_FSC, long lQTA_GIA, long lQTA_USO, String strTPL_QTA) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO sos_chi_luo_fsc_tab (qta_gia,qta_uso,cod_sos_chi,cod_luo_fsc,tpl_qta) VALUES(?,?,?,?,?)");
            ps.setLong(1, lQTA_GIA);
            ps.setLong(2, lQTA_USO);
            ps.setLong(3, lCOD_SOS_CHI);
            ps.setLong(4, lCOD_LUO_FSC);
            ps.setString(5, strTPL_QTA);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void editSOS_CHI_LUO_FSC(long lCOD_LUO_FSC, long lQTA_GIA, long lQTA_USO, String strTPL_QTA) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE sos_chi_luo_fsc_tab SET qta_gia=?,qta_uso=?,tpl_qta=? WHERE cod_sos_chi=? AND cod_luo_fsc=? ");
            ps.setLong(1, lQTA_GIA);
            ps.setLong(2, lQTA_USO);
            ps.setString(3, strTPL_QTA);
            ps.setLong(4, lCOD_SOS_CHI);
            ps.setLong(5, lCOD_LUO_FSC);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table SOS_CHI_LUO_FSC_TAB

    public void removeSOS_CHI_LUO_FSC(long newCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM sos_chi_luo_fsc_tab  WHERE cod_sos_chi=? AND cod_luo_fsc=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, newCOD_LUO_FSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetSOS_CHI_LUO_FSC_View(long lCOD_SOS_CHI, long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT qta_gia,qta_uso,tpl_qta FROM sos_chi_luo_fsc_tab WHERE cod_sos_chi=? and cod_luo_fsc=? ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SOS_CHI_LUO_FSC_View obj = new SOS_CHI_LUO_FSC_View();
                obj.COD_SOS_CHI = lCOD_SOS_CHI;
                obj.COD_LUO_FSC = lCOD_LUO_FSC;
                obj.QTA_GIA = rs.getLong(1);
                obj.QTA_USO = rs.getLong(2);
                obj.TPL_QTA = rs.getString(3);
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
    }//--------------------------------------------------

    public Collection ejbGetSOS_CHI_LUO_FSC_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM sos_chi_luo_fsc_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SOS_CHI_LUO_FSC_View obj = new SOS_CHI_LUO_FSC_View();
                obj.QTA_GIA = rs.getLong(1);
                obj.QTA_USO = rs.getLong(2);
                obj.COD_SOS_CHI = rs.getLong(3);
                obj.COD_LUO_FSC = rs.getLong(4);
                obj.TPL_QTA = rs.getString(5);
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

    public Collection ejbGetSOS_CHI_View() {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_sos_chi, a.nom_com_sos, a.sim_ris, b.des_sta_fsc, d.des_clf_sos ";
            query += "FROM   ana_sos_chi_tab a, ana_sta_fsc_tab b, ana_clf_sos_tab d ";
            query += "WHERE  a.cod_sta_fsc = b.cod_sta_fsc AND a.cod_clf_sos = d.cod_clf_sos ORDER BY a.nom_com_sos";
            PreparedStatement ps = bmp.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SOS_CHI_View obj = new SOS_CHI_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
                obj.SIM_RIS = rs.getString(3);
                obj.DES_STA_FSC = rs.getString(4);
                obj.DES_CLF_SOS = rs.getString(5);
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

    public Collection ejbGetSOS_CHI_LUO_FSC_TPL_QTA_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT tpl_qta FROM sos_chi_luo_fsc_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SOS_CHI_LUO_FSC_View obj = new SOS_CHI_LUO_FSC_View();
                obj.TPL_QTA = rs.getString(1);
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
    //-------------#############################################
    //-------------------

    //</comment>
    public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL, String strTPL_CLF_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO rso_sos_chi_tab(cod_sos_chi,cod_rso,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            //ps.setString (4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_RSO(long lCOD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_sos_chi_tab  WHERE cod_sos_chi=? AND cod_rso=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_FRS_R(long lCOD_FRS_R) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO frs_r_sos_chi_tab(cod_sos_chi,cod_frs_r) VALUES(?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_FRS_R);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_FRS_R(long lCOD_FRS_R) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM frs_r_sos_chi_tab  WHERE cod_sos_chi=? AND cod_frs_r=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_FRS_R);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_FRS_S(long lCOD_FRS_S) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO frs_s_sos_chi_tab(cod_sos_chi,cod_frs_s) VALUES(?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_FRS_S);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_FRS_S(long lCOD_FRS_S) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM frs_s_sos_chi_tab  WHERE cod_sos_chi=? AND cod_frs_s=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_FRS_S);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_DOC(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_sos_chi_tab(cod_sos_chi,cod_doc) VALUES(?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_DOC);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_DOC(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_sos_chi_tab  WHERE cod_sos_chi=? AND cod_doc=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_NOR_SEN(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_sos_chi_tab(cod_sos_chi,cod_nor_sen) VALUES(?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_NOR_SEN);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_NOR_SEN(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM nor_sen_sos_chi_tab  WHERE cod_sos_chi=? AND cod_nor_sen=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_NOR_SEN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agento con ID=" + lCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //----
    public Collection getRischiAgente_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT rso_sos_chi_tab.cod_rso, ana_rso_tab.nom_rso, ana_rso_tab.ent_dan, ana_rso_tab.rfc_vlu_rso_mes FROM rso_sos_chi_tab, ana_rso_tab WHERE  rso_sos_chi_tab.cod_azl=ana_rso_tab.cod_azl AND rso_sos_chi_tab.cod_sos_chi = ? AND rso_sos_chi_tab.cod_rso =  ana_rso_tab.cod_rso and rso_sos_chi_tab.cod_azl=?  ");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischiAgente_View obj = new RischiAgente_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
                obj.ENT_DAN = rs.getLong(3);
                obj.RFC_VLU_RSO_MES = rs.getLong(4);
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
//<alex>

    public void ejbAddSostanzeRischiToOperazione(long lCOD_OPE_SVO, long lCOD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        try {
            conn.setAutoCommit(false);
            ResultSet rs;
            PreparedStatement ps;
            ps = bmp.prepareStatement("INSERT INTO sos_chi_ope_svo_tab  (cod_sos_chi, cod_ope_svo) VALUES(?,?)");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sostanza chimica associata non è  inserita");
            }

            ps = bmp.prepareStatement("select a.cod_rso from rso_sos_chi_tab a, ana_sos_chi_tab b " +
                    "where a.cod_sos_chi=b.cod_sos_chi and a.cod_azl=? and a.cod_sos_chi=? " +
                    //"AND (a.tpl_clf_rso=?  OR  a.tpl_clf_rso=? )  "+ TENTATA IMPLEMENTAZIONE
                    "and a.cod_rso not in (select cod_rso from rso_ope_svo_tab where cod_ope_svo=? and cod_azl=?)");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_SOS_CHI);
            //ps.setString(3, "O");
            //ps.setString(4, "O/T");
            ps.setLong(3, lCOD_OPE_SVO);
            ps.setLong(4, lCOD_AZL);
            rs = ps.executeQuery();
            while (rs.next()) {
                long COD_RSO = rs.getLong(1);
                PreparedStatement ps_ins = bmp.prepareStatement("insert into rso_ope_svo_tab values (?,?,?)");
                ps_ins.setLong(1, lCOD_OPE_SVO);
                ps_ins.setLong(2, COD_RSO);
                ps_ins.setLong(3, lCOD_AZL);
                ps_ins.executeUpdate();
            }

            conn.commit();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            try {
                conn.rollback();
            } catch (Exception ex1) {
                ex1.printStackTrace(System.err);
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
                ex1.printStackTrace(System.err);
            }
        }
    }

    public Collection ejbGetRischioSostanza_View(long lCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select a.cod_sos_chi, a.cod_rso, a.cod_azl from rso_sos_chi_tab a where a.cod_sos_chi=?  ");
            ps.setLong(1, lCOD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioSostanza_View obj = new RischioSostanza_View();
                obj.lCOD_SOS_CHI = rs.getLong(1);
                obj.lCOD_RSO = rs.getLong(2);
                obj.lCOD_AZL = rs.getLong(3);
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
    /*public Collection ejbGetRischiSostanza_View(long lCOD_SOS_CHI){
    BMPConnection bmp=getConnection();
    try{
    PreparedStatement ps=bmp.prepareStatement("SELECT  a.cod_rso FROM rso_sos_chi_tab b, ana_rso_tab a WHERE a.cod_rso=b.cod_rso AND b.cod_sos_chi=? ");
    ps.setLong(1, lCOD_SOS_CHI);
    ResultSet rs=ps.executeQuery();
    java.util.ArrayList al=new java.util.ArrayList();
    while(rs.next()){
    Rischi_View obj=new Rischi_View();
    obj.COD_RSO=rs.getLong(1);
    al.add(obj);
    }
    bmp.close();
    return al;
    }
    catch(Exception ex1){
    ex1.printStackTrace(System.err);
    throw new EJBException(ex1);
    }
    finally{bmp.close();}
    }*/
//</alex>

    public Collection findEx(
            String strNOM_COM_SOS,
            String strDES_SOS,
            String strSIM_RIS,
            Long lCOD_STA_FSC,
            Long lCOD_SIM,
            Long lCOD_CLF_SOS,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(strNOM_COM_SOS, strDES_SOS, strSIM_RIS, lCOD_STA_FSC, lCOD_SIM, lCOD_CLF_SOS, iOrderParameter);
    }

    public Collection ejbFindEx(
            String strNOM_COM_SOS,
            String strDES_SOS,
            String strSIM_RIS,
            Long lCOD_STA_FSC,
            Long lCOD_SIM,
            Long lCOD_CLF_SOS,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT a.cod_sos_chi, a.nom_com_sos, a.sim_ris, b.des_sta_fsc, d.des_clf_sos FROM   ana_sos_chi_tab a, ana_sta_fsc_tab b, ana_clf_sos_tab d  WHERE  a.cod_sta_fsc = b.cod_sta_fsc AND a.cod_clf_sos = d.cod_clf_sos ";

        if (strNOM_COM_SOS != null) {
            strSql += " AND UPPER(a.nom_com_sos) LIKE ? ";
        }
        if (strDES_SOS != null) {
            strSql += " AND UPPER(a.des_sos) LIKE ? ";
        }
        if (strSIM_RIS != null) {
            strSql += " AND UPPER(a.sim_ris) LIKE ? ";
        }
        if (lCOD_STA_FSC != null) {
            strSql += " AND a.cod_sta_fsc=? ";
        }
        if (lCOD_SIM != null) {
            strSql += " AND a.cod_sim=? ";
        }
        if (lCOD_CLF_SOS != null) {
            strSql += " AND a.cod_clf_sos=? ";
        }

        strSql += " ORDER BY a.nom_com_sos ";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);

            if (strNOM_COM_SOS != null) {
                ps.setString(i++, strNOM_COM_SOS.toUpperCase());
            }
            if (strDES_SOS != null) {
                ps.setString(i++, strDES_SOS.toUpperCase());
            }
            if (strSIM_RIS != null) {
                ps.setString(i++, strSIM_RIS.toUpperCase());
            }
            if (lCOD_STA_FSC != null) {
                ps.setLong(i++, lCOD_STA_FSC.longValue());
            }
            if (lCOD_SIM != null) {
                ps.setLong(i++, lCOD_SIM.longValue());
            }
            if (lCOD_CLF_SOS != null) {
                ps.setLong(i++, lCOD_CLF_SOS.longValue());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                SOS_CHI_View obj = new SOS_CHI_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
                obj.SIM_RIS = rs.getString(3);
                obj.DES_STA_FSC = rs.getString(4);
                obj.DES_CLF_SOS = rs.getString(5);
                ar.add(obj);
            }
            return ar;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }


    //<alex date="01/04/2004">
    public String getTipClassView(long lCOD_RSO, long lCOD_AZL) {
        String obj = "";
        BMPConnection bmp = getConnection();
        try {
            /*
            PreparedStatement ps=bmp.prepareStatement(" select tpl_clf_rso from rso_sos_chi_tab where cod_rso = ?  and cod_sos_chi = ? and cod_azl = ?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_SOS_CHI);
            ps.setLong(3, lCOD_AZL);
            ResultSet rs=ps.executeQuery();
            if (rs.next()){
            obj=rs.getString(1);
            }
            bmp.close();
             */
            return obj;
        } catch (Exception ex1) {
            ex1.printStackTrace(System.err);
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetCARICA_LUOGHI_FISICI_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_luo_fsc, "
                        + "a.nom_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab a, "
                        + "sos_chi_luo_fsc_tab b "
                    + "where "
                        + "b.cod_sos_chi=? "
                        + "and a.cod_luo_fsc = b.cod_luo_fsc "
                        + "and a.cod_azl=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Sostanza_LuoghiFisiciView obj = new Sostanza_LuoghiFisiciView();
                obj.lCOD_LUO_FSC = rs.getLong(1);
                obj.strNOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetCARICA_ATTIVITA_View(long lCOD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_man, nom_man from  ana_man_tab where cod_man in (select distinct a.cod_man from ope_svo_man_tab a, sos_chi_ope_svo_tab b, ana_sos_chi_tab c where a.cod_ope_svo=b.cod_ope_svo and b.cod_sos_chi=c.cod_sos_chi and c.cod_sos_chi=?) and cod_azl=?");
            ps.setLong(1, lCOD_SOS_CHI);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SostanzaAttivitaLavorative_View obj = new SostanzaAttivitaLavorative_View();
                obj.lCOD_MAN = rs.getLong(1);
                obj.strNOM_MAN = rs.getString(2);
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

    public int ejbGetCountAttivitaForSostanza(long lCOD_SOS_CHI, long lCOD_AZL) {
        return ejbGetCARICA_ATTIVITA_View(lCOD_SOS_CHI, lCOD_AZL).size();
    }

    public int ejbGetCountLuoghiForSostanza(long lCOD_SOS_CHI, long lCOD_AZL) {
        return ejbGetCARICA_LUOGHI_FISICI_View(lCOD_SOS_CHI, lCOD_AZL).size();
    }
    //</alex>

    public Collection getProprietaChimicoFisiche_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pta, des_pta FROM vw_rso_chi_cbx where cod_cbx = 'PTA'");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ProprietaChimicoFisiche_View obj = new ProprietaChimicoFisiche_View();
                obj.lCOD_PTA_FSC = rs.getLong(1);
                obj.strDES_PTA_FSC = rs.getString(2);
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
}// end of implementation
