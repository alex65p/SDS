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
package com.apconsulting.luna.ejb.DittaEsterna;

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
public class DittaEsternaBean extends BMPEntityBean implements IDittaEsternaHome, IDittaEsterna {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    long COD_DTE;				//1
    long COD_AZL;				//2
    String RAG_SCL_DTE;			//3
    String CAG_DTE;				//4
    String IDZ_DTE;				//5
    String NUM_CIC_DTE;			//6
    String CIT_DTE;				//7
    String QLF_RSP_DTE;			//8
    String NOM_RSP_DTE;			//9
    String NOM_RSP_SPP_DTE;		//10
    java.sql.Date DAT_CAT_DTE;	//11
    long COD_STA;				//12
    //------------------------------
    String PRV_DTE;
    String CAP_DTE;
    String IDZ_PSA_ELT_RSP;
    java.sql.Date DAT_INZ_LAV;
    java.sql.Date DAT_FIE_LAV;
    //---external fields
    String RAG_SCL_AZL; //----from ana_azl_tab
    String NOM_STA;     //----from ana_sta_tab;
    //</comment>

    ////////////////////// CONSTRUCTOR///////////////////
    private static DittaEsternaBean ys = null;

    private DittaEsternaBean() {
    }

    public static DittaEsternaBean getInstance() {
        if (ys == null) {
            ys = new DittaEsternaBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IDittaEsterna create(long lCOD_AZL, String strRAG_SCL_DTE, String strCAG_DTE, String strIDZ_DTE, String strCIT_DTE, String strQLF_RSP_DTE, String strNOM_RSP_DTE, String strNOM_RSP_SPP_DTE, java.sql.Date dtDAT_CAT_DTE, long lCOD_STA) throws CreateException {
        DittaEsternaBean bean = new DittaEsternaBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, strRAG_SCL_DTE, strCAG_DTE, strIDZ_DTE, strCIT_DTE, strQLF_RSP_DTE, strNOM_RSP_DTE, strNOM_RSP_SPP_DTE, dtDAT_CAT_DTE, lCOD_STA);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, strRAG_SCL_DTE, strCAG_DTE, strIDZ_DTE, strCIT_DTE, strQLF_RSP_DTE, strNOM_RSP_DTE, strNOM_RSP_SPP_DTE, dtDAT_CAT_DTE, lCOD_STA);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        DittaEsternaBean iDittaEsternaBean = new DittaEsternaBean();
        try {
            Object obj = iDittaEsternaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iDittaEsternaBean.setEntityContext(new EntityContextWrapper(obj));
            iDittaEsternaBean.ejbActivate();
            iDittaEsternaBean.ejbLoad();
            iDittaEsternaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IDittaEsterna findByPrimaryKey(Long primaryKey) throws FinderException {
        DittaEsternaBean bean = new DittaEsternaBean();
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
    public Collection getDittaEsterneByAZLID_View(long AZL_ID) {
        return (new DittaEsternaBean()).ejbGetDittaEsterneByAZLID_View(AZL_ID);
    }

    public Collection getRagSclDteByCodDte(long AZL_ID) {
        return (new DittaEsternaBean()).ejbGetRagSclDteByCodDte(AZL_ID);
    }

    public Collection getIdzDteOnRagSclDte(long AZL_ID) {
        return (new DittaEsternaBean()).ejbGetIdzDteOnRagSclDte(AZL_ID);
    }

    public Collection findEx(
            long AZL_ID,
            String strRAG_SCL_DTE,
            String strCAG_DTE,
            String strIDZ_DTE,
            String strNUM_CIC_DTE,
            String strCIT_DTE,
            String strPRV_DTE,
            Long lCOD_STA,
            String strCAP_DTE,
            String strQLF_RSP_DTE,
            String strNOM_RSP_DTE,
            String strNOM_RSP_SPP_DTE,
            java.sql.Date dtDAT_INZ_LAV,
            java.sql.Date dtDAT_FIE_LAV,
            int iOrderParameter) {
        return (new DittaEsternaBean()).ejbFindEx(
                AZL_ID,
                strRAG_SCL_DTE,
                strCAG_DTE,
                strIDZ_DTE,
                strNUM_CIC_DTE,
                strCIT_DTE,
                strPRV_DTE,
                lCOD_STA,
                strCAP_DTE,
                strQLF_RSP_DTE,
                strNOM_RSP_DTE,
                strNOM_RSP_SPP_DTE,
                dtDAT_INZ_LAV,
                dtDAT_FIE_LAV,
                iOrderParameter);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IDittaEsternaHome-implementation>
    public Long ejbCreate(long lCOD_AZL, String strRAG_SCL_DTE, String strCAG_DTE, String strIDZ_DTE, String strCIT_DTE, String strQLF_RSP_DTE, String strNOM_RSP_DTE, String strNOM_RSP_SPP_DTE, java.sql.Date dtDAT_CAT_DTE, long lCOD_STA) {
        this.COD_AZL = lCOD_AZL;
        this.RAG_SCL_DTE = strRAG_SCL_DTE;
        this.CAG_DTE = strCAG_DTE;
        this.IDZ_DTE = strIDZ_DTE;
        this.CIT_DTE = strCIT_DTE;
        this.QLF_RSP_DTE = strQLF_RSP_DTE;
        this.NOM_RSP_DTE = strNOM_RSP_DTE;
        this.NOM_RSP_SPP_DTE = strNOM_RSP_SPP_DTE;
        this.DAT_CAT_DTE = dtDAT_CAT_DTE;
        this.COD_STA = lCOD_STA;

        this.COD_DTE = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_dte_tab (cod_dte,cod_azl, rag_scl_dte, cag_dte, idz_dte, cit_dte, qlf_rsp_dte, nom_rsp_dte, nom_rsp_spp_dte, dat_cat_dte, cod_sta) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DTE);
            ps.setLong(2, COD_AZL);
            ps.setString(3, RAG_SCL_DTE);
            ps.setString(4, CAG_DTE);
            ps.setString(5, IDZ_DTE);
            ps.setString(6, CIT_DTE);
            ps.setString(7, QLF_RSP_DTE);
            ps.setString(8, NOM_RSP_DTE);
            ps.setString(9, NOM_RSP_SPP_DTE);
            ps.setDate(10, DAT_CAT_DTE);
            ps.setLong(11, COD_STA);
            ps.executeUpdate();
            return new Long(COD_DTE);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_AZL, String strRAG_SCL_DTE, String strCAG_DTE, String strIDZ_DTE, String strCIT_DTE, String strQLF_RSP_DTE, String strNOM_RSP_DTE, String strNOM_RSP_SPP_DTE, java.sql.Date dtDAT_CAT_DTE, long lCOD_STA) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dte FROM ana_dte_tab ");
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
        this.COD_DTE = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_DTE = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_dte_tab  WHERE cod_dte=?");
            ps.setLong(1, COD_DTE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_AZL = rs.getLong("COD_AZL");
                this.RAG_SCL_DTE = rs.getString("RAG_SCL_DTE");
                this.CAG_DTE = rs.getString("CAG_DTE");
                this.IDZ_DTE = rs.getString("IDZ_DTE");
                this.NUM_CIC_DTE = rs.getString("NUM_CIC_DTE");
                this.CIT_DTE = rs.getString("CIT_DTE");
                this.QLF_RSP_DTE = rs.getString("QLF_RSP_DTE");
                this.NOM_RSP_DTE = rs.getString("NOM_RSP_DTE");
                this.NOM_RSP_SPP_DTE = rs.getString("NOM_RSP_SPP_DTE");
                this.DAT_CAT_DTE = rs.getDate("DAT_CAT_DTE");
                this.COD_STA = rs.getLong("COD_STA");
                this.COD_DTE = rs.getLong("COD_DTE"); // unic ID
                this.NUM_CIC_DTE = rs.getString("NUM_CIC_DTE");
                this.PRV_DTE = rs.getString("PRV_DTE");
                this.CAP_DTE = rs.getString("CAP_DTE");
                this.IDZ_PSA_ELT_RSP = rs.getString("IDZ_PSA_ELT_RSP");
                this.DAT_INZ_LAV = rs.getDate("DAT_INZ_LAV");
                this.DAT_FIE_LAV = rs.getDate("DAT_FIE_LAV");
            } else {
                throw new NoSuchEntityException("DittaEsterna con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_dte_tab  WHERE cod_dte=?");
            ps.setLong(1, COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DittaEsterna con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_dte_tab  SET cod_azl=?, rag_scl_dte=?,cag_dte=?,idz_dte=?,num_cic_dte=?,cit_dte=?,prv_dte=?, cap_dte=?,qlf_rsp_dte=?,nom_rsp_dte=?,idz_psa_elt_rsp=?, nom_rsp_spp_dte=?,dat_cat_dte=?,dat_inz_lav=?,dat_fie_lav=?,cod_sta=? WHERE cod_dte=?");
            ps.setLong(1, COD_AZL);
            ps.setString(2, RAG_SCL_DTE);
            ps.setString(3, CAG_DTE);
            ps.setString(4, IDZ_DTE);
            ps.setString(5, NUM_CIC_DTE);
            ps.setString(6, CIT_DTE);
            ps.setString(7, PRV_DTE);
            ps.setString(8, CAP_DTE);
            ps.setString(9, QLF_RSP_DTE);
            ps.setString(10, NOM_RSP_DTE);
            ps.setString(11, IDZ_PSA_ELT_RSP);
            ps.setString(12, NOM_RSP_SPP_DTE);
            ps.setDate(13, DAT_CAT_DTE);
            ps.setDate(14, DAT_INZ_LAV);
            ps.setDate(15, DAT_FIE_LAV);
            ps.setLong(16, COD_STA);
            ps.setLong(17, COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DittaEsterna con ID= non è trovata");
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
    public void setCOD_AZL__RAG_SCL_DTE(long newCOD_AZL, String newRAG_SCL_DTE) {
        if ((COD_AZL == newCOD_AZL) && (RAG_SCL_DTE.equals(newRAG_SCL_DTE))) {
            return;
        }
        COD_AZL = newCOD_AZL;
        RAG_SCL_DTE = newRAG_SCL_DTE;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }
    //2

    public void setRAG_SCL_DTE(String newRAG_SCL_DTE) {
        if ((this.RAG_SCL_DTE != null) && (RAG_SCL_DTE.equals(newRAG_SCL_DTE))) {
            return;
        }
        RAG_SCL_DTE = newRAG_SCL_DTE;
        setModified();
    }

    public String getRAG_SCL_DTE() {
        if (RAG_SCL_DTE == null) {
            return "";
        } else {
            return RAG_SCL_DTE;
        }
    }
    //3

    public void setCAG_DTE(String newCAG_DTE) {
        if ((this.CAG_DTE != null) && (CAG_DTE.equals(newCAG_DTE))) {
            return;
        }
        CAG_DTE = newCAG_DTE;
        setModified();
    }

    public String getCAG_DTE() {
        if (CAG_DTE == null) {
            return "";
        } else {
            return CAG_DTE;
        }
    }
    //4

    public void setIDZ_DTE(String newIDZ_DTE) {
        if ((this.IDZ_DTE != null) && (IDZ_DTE.equals(newIDZ_DTE))) {
            return;
        }
        IDZ_DTE = newIDZ_DTE;
        setModified();
    }

    public String getIDZ_DTE() {
        if (IDZ_DTE == null) {
            return "";
        } else {
            return IDZ_DTE;
        }
    }
    //5

    public void setNUM_CIC_DTE(String newNUM_CIC_DTE) {
        if ((this.NUM_CIC_DTE != null) && (NUM_CIC_DTE.equals(newNUM_CIC_DTE))) {
            return;
        }
        NUM_CIC_DTE = newNUM_CIC_DTE;
        setModified();
    }

    public String getNUM_CIC_DTE() {
        if (NUM_CIC_DTE == null) {
            return "";
        } else {
            return NUM_CIC_DTE;
        }
    }
    //6

    public void setCIT_DTE(String newCIT_DTE) {
        if ((this.CIT_DTE != null) && (CIT_DTE.equals(newCIT_DTE))) {
            return;
        }
        CIT_DTE = newCIT_DTE;
        setModified();
    }

    public String getCIT_DTE() {
        if (CIT_DTE == null) {
            return "";
        } else {
            return CIT_DTE;
        }
    }
    //7

    public void setQLF_RSP_DTE(String newQLF_RSP_DTE) {
        if ((this.QLF_RSP_DTE != null) && (QLF_RSP_DTE.equals(newQLF_RSP_DTE))) {
            return;
        }
        QLF_RSP_DTE = newQLF_RSP_DTE;
        setModified();
    }

    public String getQLF_RSP_DTE() {
        if (QLF_RSP_DTE == null) {
            return "";
        } else {
            return QLF_RSP_DTE;
        }
    }
    //8

    public void setNOM_RSP_DTE(String newNOM_RSP_DTE) {
        if ((this.NOM_RSP_DTE != null) && (NOM_RSP_DTE.equals(newNOM_RSP_DTE))) {
            return;
        }
        NOM_RSP_DTE = newNOM_RSP_DTE;
        setModified();
    }

    public String getNOM_RSP_DTE() {
        if (NOM_RSP_DTE == null) {
            return "";
        } else {
            return NOM_RSP_DTE;
        }
    }
    //9

    public void setNOM_RSP_SPP_DTE(String newNOM_RSP_SPP_DTE) {
        if ((this.NOM_RSP_SPP_DTE != null) && (NOM_RSP_SPP_DTE.equals(newNOM_RSP_SPP_DTE))) {
            return;
        }
        NOM_RSP_SPP_DTE = newNOM_RSP_SPP_DTE;
        setModified();
    }

    public String getNOM_RSP_SPP_DTE() {
        if (NOM_RSP_SPP_DTE == null) {
            return "";
        } else {
            return NOM_RSP_SPP_DTE;
        }
    }
    //10

    public void setDAT_CAT_DTE(java.sql.Date newDAT_CAT_DTE) {
        if ((this.DAT_CAT_DTE != null) && (DAT_CAT_DTE.equals(newDAT_CAT_DTE))) {
            return;
        }
        DAT_CAT_DTE = newDAT_CAT_DTE;
        setModified();
    }

    public java.sql.Date getDAT_CAT_DTE() {
        return DAT_CAT_DTE;
    }
    //11

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
    //12

    public long getCOD_DTE() {
        return COD_DTE;
    }

    //============================================
    // not required field
    //13
    public void setPRV_DTE(String newPRV_DTE) {
        if ((this.PRV_DTE != null) && (PRV_DTE.equals(newPRV_DTE))) {
            return;
        }
        PRV_DTE = newPRV_DTE;
        setModified();
    }

    public String getPRV_DTE() {
        if (PRV_DTE == null) {
            return "";
        } else {
            return PRV_DTE;
        }
    }
    //14

    public void setCAP_DTE(String newCAP_DTE) {
        if ((this.CAP_DTE != null) && (CAP_DTE.equals(newCAP_DTE))) {
            return;
        }
        CAP_DTE = newCAP_DTE;
        setModified();
    }

    public String getCAP_DTE() {
        if (CAP_DTE == null) {
            return "";
        } else {
            return CAP_DTE;
        }
    }
    //15

    public void setIDZ_PSA_ELT_RSP(String newIDZ_PSA_ELT_RSP) {
        if ((this.IDZ_PSA_ELT_RSP != null) && (IDZ_PSA_ELT_RSP.equals(newIDZ_PSA_ELT_RSP))) {
            return;
        }
        IDZ_PSA_ELT_RSP = newIDZ_PSA_ELT_RSP;
        setModified();
    }

    public String getIDZ_PSA_ELT_RSP() {
        if (IDZ_PSA_ELT_RSP == null) {
            return "";
        } else {
            return IDZ_PSA_ELT_RSP;
        }
    }
    //16

    public void setDAT_INZ_LAV(java.sql.Date newDAT_INZ_LAV) {
        if ((this.DAT_INZ_LAV != null) && (DAT_INZ_LAV.equals(newDAT_INZ_LAV))) {
            return;
        }
        DAT_INZ_LAV = newDAT_INZ_LAV;
        setModified();
    }

    public java.sql.Date getDAT_INZ_LAV() {
        return DAT_INZ_LAV;
    }
    //17

    public void setDAT_FIE_LAV(java.sql.Date newDAT_FIE_LAV) {
        if ((this.DAT_FIE_LAV != null) && (DAT_FIE_LAV.equals(newDAT_FIE_LAV))) {
            return;
        }
        DAT_FIE_LAV = newDAT_FIE_LAV;
        setModified();
    }

    public java.sql.Date getDAT_FIE_LAV() {
        return DAT_FIE_LAV;
    }
    //</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    // external setters/getters

    public void setDOC_CSG_RCR(long COD_DOC, String newDOC_CSG_RCR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE doc_csg_dte_tab SET doc_csg_rcr=? WHERE cod_doc=? AND cod_dte=?");
            ps.setString(1, newDOC_CSG_RCR);
            ps.setLong(2, COD_DOC);
            ps.setLong(3, this.COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------

    public String getDOC_CSG_RCR(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT doc_csg_rcr FROM doc_csg_dte_tab  WHERE cod_doc=? AND cod_dte=?");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_DTE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("DOC_CSG_RCR");
            } else {
                throw new NoSuchEntityException("Documento associato non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------

    public void addDocument(long COD_DOC, String newDOC_CSG_RCR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_csg_dte_tab (cod_doc, cod_dte ,doc_csg_rcr) VALUES(?,?,?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_DTE);
            ps.setString(3, newDOC_CSG_RCR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------

    public void removeDocument(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_csg_dte_tab  WHERE  (cod_doc=? AND cod_dte=?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è annulata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------

    public void addLuogoFisico(long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO dte_luo_fsc_tab (cod_luo_fsc,  cod_dte) VALUES(?,?)");
            ps.setLong(1, lCOD_LUO_FSC);
            ps.setLong(2, this.COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Luogo Fisico non è inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //---

    public void removeLuogoFisico(long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM dte_luo_fsc_tab WHERE  (cod_luo_fsc=? AND cod_dte=?)");
            ps.setLong(1, lCOD_LUO_FSC);
            ps.setLong(2, this.COD_DTE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Luogo Fisico non è annulata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetDittaEsterneByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dte, rag_scl_dte, nom_rsp_dte, idz_dte, num_cic_dte, cit_dte,cag_dte FROM ana_dte_tab WHERE cod_azl=? ORDER  BY rag_scl_dte ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterneByAZLID_View obj = new DittaEsterneByAZLID_View();
                obj.COD_DTE = rs.getLong(1);
                obj.RAG_SCL_DTE = rs.getString(2);
                obj.NOM_RSP_DTE = rs.getString(3);
                obj.IDZ_DTE = rs.getString(4);
                obj.NUM_CIC_DTE = rs.getString(5);
                obj.CIT_DTE = rs.getString(6);
                obj.CAG_DTE = rs.getString(7);
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

    public Collection ejbGetRagSclDteByCodDte(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "cod_dte, " +
                    "rag_scl_dte " +
                    "FROM " +
                    "ana_dte_tab " +
                    "WHERE " +
                    "cod_azl=? " +
                    "ORDER BY " +
                    "rag_scl_dte");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RagSclDteByCodDte obj = new RagSclDteByCodDte();
                obj.COD_DTE = rs.getLong(1);
                obj.RAG_SCL_DTE = rs.getString(2);
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

    public Collection ejbGetIdzDteOnRagSclDte(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "cod_dte, " +
                    "idz_dte, " +
                    "rag_scl_dte " +
                    "FROM " +
                    "ana_dte_tab " +
                    "WHERE " +
                    "cod_azl=?");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterna_IdzDteOnRagSclDte obj = new DittaEsterna_IdzDteOnRagSclDte();
                obj.COD_DTE = rs.getLong(1);
                obj.IDZ_DTE = rs.getString(2);
                obj.RAG_SCL_DTE = rs.getString(3);
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

    public Collection ejbFindEx(
            long AZL_ID,
            String strRAG_SCL_DTE,
            String strCAG_DTE,
            String strIDZ_DTE,
            String strNUM_CIC_DTE,
            String strCIT_DTE,
            String strPRV_DTE,
            Long lCOD_STA,
            String strCAP_DTE,
            String strQLF_RSP_DTE,
            String strNOM_RSP_DTE,
            String strNOM_RSP_SPP_DTE,
            java.sql.Date dtDAT_INZ_LAV,
            java.sql.Date dtDAT_FIE_LAV,
            int iOrderParameter) {
        String strSQL = "SELECT cod_dte, rag_scl_dte, nom_rsp_dte, idz_dte, num_cic_dte, cit_dte,cag_dte FROM ana_dte_tab WHERE cod_azl=? ";
        if (strRAG_SCL_DTE != null) {
            strSQL += " AND UPPER(rag_scl_dte) LIKE ? ";
        }
        if (strCAG_DTE != null) {
            strSQL += " AND UPPER(cag_dte) LIKE ? ";
        }
        if (strIDZ_DTE != null) {
            strSQL += " AND UPPER(idz_dte) LIKE ? ";
        }
        if (strNUM_CIC_DTE != null) {
            strSQL += " AND UPPER(num_cic_dte) LIKE ? ";
        }
        if (strCIT_DTE != null) {
            strSQL += " AND UPPER(cit_dte) LIKE ? ";
        }
        if (strPRV_DTE != null) {
            strSQL += " AND UPPER(prv_dte) LIKE ? ";
        }
        if (lCOD_STA != null) {
            strSQL += " AND cod_sta LIKE ? ";
        }
        if (strCAP_DTE != null) {
            strSQL += " AND UPPER(cap_dte) LIKE ? ";
        }
        if (strQLF_RSP_DTE != null) {
            strSQL += " AND UPPER(qlf_rsp_dte) LIKE ? ";
        }
        if (strNOM_RSP_DTE != null) {
            strSQL += " AND UPPER(nom_rsp_dte) LIKE ? ";
        }
        if (strNOM_RSP_SPP_DTE != null) {
            strSQL += " AND UPPER(nom_rsp_spp_dte) LIKE ? ";
        }
        if (dtDAT_INZ_LAV != null) {
            strSQL += " AND dat_inz_lav=? ";
        }
        if (dtDAT_FIE_LAV != null) {
            strSQL += " AND dat_fie_lav=? ";
        }
        strSQL += " ORDER  BY UPPER(rag_scl_dte) ";

        BMPConnection bmp = getConnection();
        int i = 1;
        try {
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(i++, AZL_ID);
            if (strRAG_SCL_DTE != null) {
                ps.setString(i++, strRAG_SCL_DTE.toUpperCase());
            }
            if (strCAG_DTE != null) {
                ps.setString(i++, strCAG_DTE.toUpperCase());
            }
            if (strIDZ_DTE != null) {
                ps.setString(i++, strIDZ_DTE.toUpperCase());
            }
            if (strNUM_CIC_DTE != null) {
                ps.setString(i++, strNUM_CIC_DTE.toUpperCase());
            }
            if (strCIT_DTE != null) {
                ps.setString(i++, strCIT_DTE.toUpperCase());
            }
            if (strPRV_DTE != null) {
                ps.setString(i++, strPRV_DTE.toUpperCase());
            }
            if (lCOD_STA != null) {

                ps.setLong(i++, lCOD_STA.longValue());
            }
            if (strCAP_DTE != null) {
                ps.setString(i++, strCAP_DTE.toUpperCase());
            }
            if (strQLF_RSP_DTE != null) {
                ps.setString(i++, strQLF_RSP_DTE.toUpperCase());
            }
            if (strNOM_RSP_DTE != null) {
                ps.setString(i++, strNOM_RSP_DTE.toUpperCase());
            }
            if (strNOM_RSP_SPP_DTE != null) {
                ps.setString(i++, strNOM_RSP_SPP_DTE.toUpperCase());
            }
            if (dtDAT_INZ_LAV != null) {
                ps.setDate(i++, dtDAT_INZ_LAV);
            }
            if (dtDAT_FIE_LAV != null) {
                ps.setDate(i++, dtDAT_FIE_LAV);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterneByAZLID_View obj = new DittaEsterneByAZLID_View();
                obj.COD_DTE = rs.getLong(1);
                obj.RAG_SCL_DTE = rs.getString(2);
                obj.NOM_RSP_DTE = rs.getString(3);
                obj.IDZ_DTE = rs.getString(4);
                obj.NUM_CIC_DTE = rs.getString(5);
                obj.CIT_DTE = rs.getString(6);
                obj.CAG_DTE = rs.getString(7);
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
    //</comment>
    //-----------------------------------------------------------------------------------------------------

    public Collection getDocumentiAssociatiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dcd.cod_doc, dcd.cod_dte, dcd.doc_csg_rcr,  ad.rsp_doc, ad.tit_doc, ad.dat_rev_doc FROM doc_csg_dte_tab dcd, ana_doc_tab ad  WHERE dcd.cod_dte = ? and dcd.cod_doc = ad.cod_doc order by ad.tit_doc");
            ps.setLong(1, this.COD_DTE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterna_DocAssociati_View obj = new DittaEsterna_DocAssociati_View();
                obj.COD_DOC = rs.getLong(1);
                obj.COD_DTE = rs.getLong(2);
                obj.DOC_CSG_RCR = rs.getString(3);
                obj.RSP_DOC = rs.getString(4);
                obj.TIT_DOC = rs.getString(5);
                obj.DAT_REV_DOC = rs.getDate(6);
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
    //-----------------------------------------------------------------------------------------------------

    public Collection getLuoghiFisiciView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "dlf.cod_dte, "
                        + "dlf.cod_luo_fsc, "
                        + "alf.nom_luo_fsc, "
                        + "alf.des_luo_fsc "
                    + "FROM "
                        + "dte_luo_fsc_tab dlf, "
                        + "ana_luo_fsc_tab alf "
                    + "WHERE "
                        + "dlf.cod_dte = ? "
                        + "and dlf.cod_luo_fsc = alf.cod_luo_fsc "
                    + "order by "
                        + "alf.nom_luo_fsc");
            ps.setLong(1, this.COD_DTE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterna_LuoghiFisici_View obj = new DittaEsterna_LuoghiFisici_View();
                obj.COD_DTE = rs.getLong(1);
                obj.COD_LUO_FSC = rs.getLong(2);
                obj.NOM_LUO_FSC = rs.getString(3);
                obj.DES_LUO_FSC = rs.getString(4);
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
    //-----------------------------------------------------------------------------------------------------

    public Collection getDTETelefoniView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_num_tel_dte, tpl_num_tel,  num_tel FROM num_tel_dte_tab WHERE cod_dte = ? order by tpl_num_tel");
            ps.setLong(1, this.COD_DTE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DittaEsterna_DTETelefoni_View obj = new DittaEsterna_DTETelefoni_View();
                obj.COD_NUM_TEL_DTE = rs.getLong(1);
                obj.TPL_NUM_TEL = rs.getString(2);
                obj.NUM_TEL = rs.getString(3);
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
    }//<comment description="end of implementation  DittaEsternaBean"/>
