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
package com.apconsulting.luna.ejb.Azienda;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
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
public class AziendaBean extends BMPEntityBean implements IAziendaHome, IAzienda {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    String RAG_SCL_AZL;     //1
    String DES_ATI_SVO_AZL; //2
    String IDZ_AZL;         //3
    String CIT_AZL;         //4
    long COD_STA;           //5
    long COD_AZL;           //6
//----------------------------
    String CAG_AZL;            //7
    String COD_IST_TAT_AZL;    //8
    String NUM_CIC_AZL;        //9
    String PRV_AZL;            //10
    String CAP_AZL;            //11
    String QLF_RSP_AZL;        //12
    String NOM_RSP_AZL;        //13
    String NOM_RSP_SPP_AZL;    //14
    String NOM_MED_AZL;        //15
    long COD_AZL_ASC;          //16
    String IDZ_PSA_ELT_RSP_AZL;//17
    String SIT_INT_AZL;        //18
    short MOD_CLC_RSO;         //19
    String COD_FIS_AZL;        //20
    String PAR_IVA_AZL;        //21
//</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static AziendaBean ys = null;

    private AziendaBean() {
    }

    public static AziendaBean getInstance() {
        if (ys == null) {
            ys = new AziendaBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public IAzienda create(String strRAG_SCL_AZL, String strDES_ATI_SVO_AZL, String strIDZ_AZL, String strCIT_AZL, long lCOD_STA, short sMOD_CLC_RSO) throws CreateException {
        AziendaBean bean = new AziendaBean();
        try {
            Object primaryKey = bean.ejbCreate(strRAG_SCL_AZL, strDES_ATI_SVO_AZL, strIDZ_AZL, strCIT_AZL, lCOD_STA, sMOD_CLC_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strRAG_SCL_AZL, strDES_ATI_SVO_AZL, strIDZ_AZL, strCIT_AZL, lCOD_STA, sMOD_CLC_RSO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AziendaBean iAziendaBean = new AziendaBean();
        try {
            Object obj = iAziendaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAziendaBean.setEntityContext(new EntityContextWrapper(obj));
            iAziendaBean.ejbActivate();
            iAziendaBean.ejbLoad();
            iAziendaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }
// (Home Intrface) findByPrimaryKey()

    public IAzienda findByPrimaryKey(Long primaryKey) throws FinderException {
        AziendaBean bean = new AziendaBean();
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
/////////////////////////////////////////////////

    public void deleteAzienda(long newCOD_AZL, long newCOD_COU) {
        AziendaBean bean = new AziendaBean();
        bean.ejbHomeDeleteAzienda(newCOD_AZL, newCOD_COU);
    }
///////////////////////////////////////////////////

// (Home Intrface) VIEWS
    public Collection getAzienda_Name_Address_View(java.util.ArrayList WHE_IN_AZL) {
        return (new AziendaBean()).ejbGetAzienda_Name_Address_View(WHE_IN_AZL);
    }

    public Collection getAzienda_Name_Address_View() {
        return (new AziendaBean()).ejbGetAzienda_Name_Address_View();
    }
//

    public Collection getAzienda_Name_BesidesID_View(long BesidesID) {
        return (new AziendaBean()).ejbGetAzienda_Name_BesidesID_View(BesidesID);
    }

    public Collection getAzienda_Name_ByID_View(java.util.ArrayList AZLs) {
        return (new AziendaBean()).ejbGetAzienda_Name_ByID_View(AZLs);
    }

    public Collection findEx(java.util.ArrayList WHE_IN_AZL, String CAG_AZL, String DES_ATI_SVO_AZL, String RAG_SCL_AZL, String IDZ_AZL, String NUM_CIC_AZL, String CIT_AZL, String PRV_AZL, String CAP_AZL, String QLF_RSP_AZL, String NOM_RSP_AZL, String NOM_RSP_SPP_AZL, String NOM_MED_AZL, Short MOD_CLC_RSO, String COD_FIS_AZL,  String PAR_IVA_AZL) {
        return (new AziendaBean()).ejbfindEx(WHE_IN_AZL, CAG_AZL, DES_ATI_SVO_AZL, RAG_SCL_AZL, IDZ_AZL, NUM_CIC_AZL, CIT_AZL, PRV_AZL, CAP_AZL, QLF_RSP_AZL, NOM_RSP_AZL, NOM_RSP_SPP_AZL, NOM_MED_AZL, MOD_CLC_RSO, COD_FIS_AZL, PAR_IVA_AZL);
    }

    public Collection getAzienda_SAP_S2S_View(long C_SOC, String C_ARE) {
        return (new AziendaBean()).ejbGetAzienda_SAP_S2S_View(C_SOC, C_ARE);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAziendaHome-implementation>
    public Long ejbCreate(String strRAG_SCL_AZL, String strDES_ATI_SVO_AZL, String strIDZ_AZL, String strCIT_AZL, long lCOD_STA, short sMOD_CLC_RSO) {
        this.RAG_SCL_AZL = strRAG_SCL_AZL;
        this.DES_ATI_SVO_AZL = strDES_ATI_SVO_AZL;
        this.IDZ_AZL = strIDZ_AZL;
        this.CIT_AZL = strCIT_AZL;
        this.COD_STA = lCOD_STA;
        this.MOD_CLC_RSO = sMOD_CLC_RSO;
        this.COD_AZL = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_azl_tab (cod_azl,des_ati_svo_azl, rag_scl_azl, idz_azl, cit_azl, cod_sta, mod_clc_rso) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, COD_AZL);
            ps.setString(2, DES_ATI_SVO_AZL);
            ps.setString(3, RAG_SCL_AZL);
            ps.setString(4, IDZ_AZL);
            ps.setString(5, CIT_AZL);
            ps.setLong(6, COD_STA);
            ps.setShort(7, MOD_CLC_RSO);
            ps.executeUpdate();

//createSecurityObject(bmp, this.COD_AZL, this.COD_AZL); //### added by Artur for security
            registerSecurityObject(bmp, this.COD_AZL, this.COD_AZL, true);
            bmp.commitTrans();
            return new Long(COD_AZL);
        } catch (Exception ex) {

            bmp.rollbackTrans();
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strRAG_SCL_AZL, String strDES_ATI_SVO_AZL, String strIDZ_AZL, String strCIT_AZL, long lCOD_STA, short sMOD_CLC_RSO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl FROM ana_azl_tab ");

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
        this.COD_AZL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_AZL = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_azl_tab  WHERE cod_azl=?");
            ps.setLong(1, COD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.RAG_SCL_AZL = rs.getString("RAG_SCL_AZL");
                this.DES_ATI_SVO_AZL = rs.getString("DES_ATI_SVO_AZL");
                this.IDZ_AZL = rs.getString("IDZ_AZL");
                this.CIT_AZL = rs.getString("CIT_AZL");
                this.COD_STA = rs.getLong("COD_STA");
                this.CAG_AZL = rs.getString("CAG_AZL");
                this.COD_IST_TAT_AZL = rs.getString("COD_IST_TAT_AZL");
                this.NUM_CIC_AZL = rs.getString("NUM_CIC_AZL");
                this.PRV_AZL = rs.getString("PRV_AZL");
                this.CAP_AZL = rs.getString("CAP_AZL");
                this.QLF_RSP_AZL = rs.getString("QLF_RSP_AZL");
                this.NOM_RSP_AZL = rs.getString("NOM_RSP_AZL");
                this.NOM_RSP_SPP_AZL = rs.getString("NOM_RSP_SPP_AZL");
                this.NOM_MED_AZL = rs.getString("NOM_MED_AZL");
                this.COD_AZL_ASC = rs.getLong("COD_AZL_ASC");
                this.IDZ_PSA_ELT_RSP_AZL = rs.getString("IDZ_PSA_ELT_RSP_AZL");
                this.SIT_INT_AZL = rs.getString("SIT_INT_AZL");
                this.MOD_CLC_RSO = rs.getShort("MOD_CLC_RSO");
                this.COD_FIS_AZL = rs.getString("COD_FIS_AZL");
                this.PAR_IVA_AZL = rs.getString("PAR_IVA_AZL");

            } else {
                throw new NoSuchEntityException("Azienda con ID=" + COD_AZL + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_azl_tab  WHERE cod_azl=?");
            ps.setLong(1, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Azienda con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_azl_tab  SET des_ati_svo_azl=?, rag_scl_azl=?, idz_azl=?,cit_azl=?,cod_sta=?,cag_azl=?,cod_ist_tat_azl=?,num_cic_azl=?,prv_azl=?,cap_azl=?,qlf_rsp_azl=?,nom_rsp_azl=?,nom_rsp_spp_azl=?,nom_med_azl=?,cod_azl_asc=?,idz_psa_elt_rsp_azl=?,sit_int_azl=?,mod_clc_rso=?,cod_fis_azl=?,par_iva_azl=? WHERE cod_azl=?");
            ps.setString(1, DES_ATI_SVO_AZL);
            ps.setString(2, RAG_SCL_AZL);
            ps.setString(3, IDZ_AZL);
            ps.setString(4, CIT_AZL);
            ps.setLong(5, COD_STA);
            ps.setString(6, CAG_AZL);
            ps.setString(7, COD_IST_TAT_AZL);
            ps.setString(8, NUM_CIC_AZL);
            ps.setString(9, PRV_AZL);
            ps.setString(10, CAP_AZL);
            ps.setString(11, QLF_RSP_AZL);
            ps.setString(12, NOM_RSP_AZL);
            ps.setString(13, NOM_RSP_SPP_AZL);
            ps.setString(14, NOM_MED_AZL);
            if (COD_AZL_ASC == 0) {
                ps.setNull(15, java.sql.Types.BIGINT);
            } else {
                ps.setLong(15, COD_AZL_ASC);
            }
            ps.setString(16, IDZ_PSA_ELT_RSP_AZL);
            ps.setString(17, SIT_INT_AZL);
            ps.setLong(18, MOD_CLC_RSO);
            ps.setString(19, COD_FIS_AZL);    //inserire prima dell'ultimo
            ps.setString(20, PAR_IVA_AZL);    //inserire prima dell'ultimo
            ps.setLong(21, COD_AZL);
           

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("L'Azienda con ID= non è stata trovata");
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
//<comment description="Update Method">
    public void Update() {
        setModified();
    }
//<comment

//<comment description="setter/getters">
//1
    public void setRAG_SCL_AZL(String newRAG_SCL_AZL) {
        if ((this.RAG_SCL_AZL != null) && (RAG_SCL_AZL.equals(newRAG_SCL_AZL))) {
            return;
        }
        RAG_SCL_AZL = newRAG_SCL_AZL;
        setModified();
    }

    public String getRAG_SCL_AZL() {
        if (RAG_SCL_AZL == null) {
            return "";
        } else {
            return RAG_SCL_AZL;
        }
    }
//2

    public void setDES_ATI_SVO_AZL(String newDES_ATI_SVO_AZL) {
        if ((this.DES_ATI_SVO_AZL != null) && (DES_ATI_SVO_AZL.equals(newDES_ATI_SVO_AZL))) {
            return;
        }
        DES_ATI_SVO_AZL = newDES_ATI_SVO_AZL;
        setModified();
    }

    public String getDES_ATI_SVO_AZL() {
        if (DES_ATI_SVO_AZL == null) {
            return "";
        } else {
            return DES_ATI_SVO_AZL;
        }
    }
//3

    public void setIDZ_AZL(String newIDZ_AZL) {
        if ((this.IDZ_AZL != null) && (IDZ_AZL.equals(newIDZ_AZL))) {
            return;
        }
        IDZ_AZL = newIDZ_AZL;
        setModified();
    }

    public String getIDZ_AZL() {
        if (IDZ_AZL == null) {
            return "";
        } else {
            return IDZ_AZL;
        }
    }
//4

    public void setCIT_AZL(String newCIT_AZL) {
        if ((this.CIT_AZL != null) && (CIT_AZL.equals(newCIT_AZL))) {
            return;
        }
        CIT_AZL = newCIT_AZL;
        setModified();
    }

    public String getCIT_AZL() {
        if (CIT_AZL == null) {
            return "";
        } else {
            return CIT_AZL;
        }
    }
//5

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
//6

    public long getCOD_AZL() {
        return COD_AZL;
    }
//============================================
// not required field
//7

    public void setCAG_AZL(String newCAG_AZL) {
        if (CAG_AZL != null) {
            if (CAG_AZL.equals(newCAG_AZL)) {
                return;
            }
        }
        CAG_AZL = newCAG_AZL;
        setModified();
    }

    public String getCAG_AZL() {
        if (CAG_AZL == null) {
            return "";
        } else {
            return CAG_AZL;
        }
    }
//8

    public void setCOD_IST_TAT_AZL(String newCOD_IST_TAT_AZL) {
        if (COD_IST_TAT_AZL != null) {
            if (COD_IST_TAT_AZL.equals(newCOD_IST_TAT_AZL)) {
                return;
            }
        }
        COD_IST_TAT_AZL = newCOD_IST_TAT_AZL;
        setModified();
    }

    public String getCOD_IST_TAT_AZL() {
        if (COD_IST_TAT_AZL == null) {
            return "";
        } else {
            return COD_IST_TAT_AZL;
        }
    }
//9

    public void setNUM_CIC_AZL(String newNUM_CIC_AZL) {
        if (NUM_CIC_AZL != null) {
            if (NUM_CIC_AZL.equals(newNUM_CIC_AZL)) {
                return;
            }
        }
        NUM_CIC_AZL = newNUM_CIC_AZL;
        setModified();
    }

    public String getNUM_CIC_AZL() {
        if (NUM_CIC_AZL == null) {
            return "";
        } else {
            return NUM_CIC_AZL;
        }
    }
//10

    public void setPRV_AZL(String newPRV_AZL) {
        if (PRV_AZL != null) {
            if (PRV_AZL.equals(newPRV_AZL)) {
                return;
            }
        }
        PRV_AZL = newPRV_AZL;
        setModified();
    }

    public String getPRV_AZL() {
        if (PRV_AZL == null) {
            return "";
        } else {
            return PRV_AZL;
        }
    }
//11

    public void setCAP_AZL(String newCAP_AZL) {
        if (CAP_AZL != null) {
            if (CAP_AZL.equals(newCAP_AZL)) {
                return;
            }
        }
        CAP_AZL = newCAP_AZL;
        setModified();
    }

    public String getCAP_AZL() {
        if (CAP_AZL == null) {
            return "";
        } else {
            return CAP_AZL;
        }
    }
//12

    public void setQLF_RSP_AZL(String newQLF_RSP_AZL) {
        if (QLF_RSP_AZL != null) {
            if (QLF_RSP_AZL.equals(newQLF_RSP_AZL)) {
                return;
            }
        }
        QLF_RSP_AZL = newQLF_RSP_AZL;
        setModified();
    }

    public String getQLF_RSP_AZL() {
        if (QLF_RSP_AZL == null) {
            return "";
        } else {
            return QLF_RSP_AZL;
        }
    }
//13

    public void setNOM_RSP_AZL(String newNOM_RSP_AZL) {
        if (NOM_RSP_AZL != null) {
            if (NOM_RSP_AZL.equals(newNOM_RSP_AZL)) {
                return;
            }
        }
        NOM_RSP_AZL = newNOM_RSP_AZL;
        setModified();
    }

    public String getNOM_RSP_AZL() {
        if (NOM_RSP_AZL == null) {
            return "";
        } else {
            return NOM_RSP_AZL;
        }
    }
//14

    public void setNOM_RSP_SPP_AZL(String newNOM_RSP_SPP_AZL) {
        if (NOM_RSP_SPP_AZL != null) {
            if (NOM_RSP_SPP_AZL.equals(newNOM_RSP_SPP_AZL)) {
                return;
            }
        }
        NOM_RSP_SPP_AZL = newNOM_RSP_SPP_AZL;
        setModified();
    }

    public String getNOM_RSP_SPP_AZL() {
        if (NOM_RSP_SPP_AZL == null) {
            return "";
        } else {
            return NOM_RSP_SPP_AZL;
        }
    }
//15

    public void setNOM_MED_AZL(String newNOM_MED_AZL) {
        if (NOM_MED_AZL != null) {
            if (NOM_MED_AZL.equals(newNOM_MED_AZL)) {
                return;
            }
        }
        NOM_MED_AZL = newNOM_MED_AZL;
        setModified();
    }

    public String getNOM_MED_AZL() {
        if (NOM_MED_AZL == null) {
            return "";
        } else {
            return NOM_MED_AZL;
        }
    }
//16

    public void setCOD_AZL_ASC(long newCOD_AZL_ASC) {
        if (COD_AZL_ASC == newCOD_AZL_ASC) {
            return;
        }
        COD_AZL_ASC = newCOD_AZL_ASC;
        setModified();
    }

    public long getCOD_AZL_ASC() {
        return COD_AZL_ASC;
    }
//17

    public void setIDZ_PSA_ELT_RSP_AZL(String newIDZ_PSA_ELT_RSP_AZL) {
        if (IDZ_PSA_ELT_RSP_AZL != null) {
            if (IDZ_PSA_ELT_RSP_AZL.equals(newIDZ_PSA_ELT_RSP_AZL)) {
                return;
            }
        }
        IDZ_PSA_ELT_RSP_AZL = newIDZ_PSA_ELT_RSP_AZL;
        setModified();
    }

    public String getIDZ_PSA_ELT_RSP_AZL() {
        if (IDZ_PSA_ELT_RSP_AZL == null) {
            return "";
        } else {
            return IDZ_PSA_ELT_RSP_AZL;
        }
    }
//18

    public void setSIT_INT_AZL(String newSIT_INT_AZL) {
        if (SIT_INT_AZL != null) {
            if (SIT_INT_AZL.equals(newSIT_INT_AZL)) {
                return;
            }
        }
        SIT_INT_AZL = newSIT_INT_AZL;
        setModified();
    }

    public String getSIT_INT_AZL() {
        if (SIT_INT_AZL == null) {
            return "";
        } else {
            return SIT_INT_AZL;
        }
    }
//19

    public void setMOD_CLC_RSO(short newMOD_CLC_RSO) {
        if (MOD_CLC_RSO == newMOD_CLC_RSO) {
            return;
        }
        MOD_CLC_RSO = newMOD_CLC_RSO;
        setModified();
    }

    public short getMOD_CLC_RSO() {
        return MOD_CLC_RSO;
    }
    //20
       public void setCOD_FIS_AZL(String newCOD_FIS_AZL) {
        if (COD_FIS_AZL != null) {
            if (COD_FIS_AZL.equals(newCOD_FIS_AZL)) {
                return;
            }
        }
        COD_FIS_AZL = newCOD_FIS_AZL;
        setModified();
    }

    public String getCOD_FIS_AZL() {
        if (COD_FIS_AZL == null) {
            return "";
        } else {
            return COD_FIS_AZL;
        }
    }
    //21
       public void setPAR_IVA_AZL(String newPAR_IVA_AZL) {
        if (PAR_IVA_AZL != null) {
            if (PAR_IVA_AZL.equals(newPAR_IVA_AZL)) {
                return;
            }
        }
        PAR_IVA_AZL = newPAR_IVA_AZL;
        setModified();
    }

    public String getPAR_IVA_AZL() {
        if (PAR_IVA_AZL == null) {
            return "";
        } else {
            return PAR_IVA_AZL;
        }
    }



//</comment>
// %%%UNLink%%% ydalenie azienda + svaz s consulente
    public void ejbHomeDeleteAzienda(long newCOD_AZL, long newCOD_COU) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM azl_cou_tab WHERE cod_azl=? AND cod_cou=?");
            ps.setLong(1, newCOD_AZL);
            ps.setLong(2, newCOD_COU);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Non puo eliminare Azienda con ID=" + newCOD_AZL);
            } else {//this.remove(new Long(newCOD_AZL));
                PreparedStatement psa = bmp.prepareStatement("DELETE FROM ana_azl_tab WHERE cod_azl=?");
                psa.setLong(1, newCOD_AZL);
                psa.executeUpdate();
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//=====================================================================<br>
///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>
//<comment description="extended setters/getters">
//java.util.ArrayList WHE_IN_AZL WHERE cod_azl=?
    public Collection ejbGetAzienda_Name_Address_View(java.util.ArrayList WHE_IN_AZL) {
        BMPConnection bmp = getConnection();
        String cods = "";
        Iterator azl_ids = WHE_IN_AZL.iterator();
        while (azl_ids.hasNext()) {
            cods += azl_ids.next() + ",";
        }
        cods = cods.substring(0, cods.length() - 1);
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl,rag_scl_azl,idz_azl FROM ana_azl_tab WHERE  cod_azl IN (" + cods + ") ORDER BY rag_scl_azl ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Azienda_Name_Address_View obj = new Azienda_Name_Address_View();
                obj.COD_AZL = rs.getLong(1);
                obj.RAG_SCL_AZL = rs.getString(2);
                obj.IDZ_AZL = rs.getString(3);
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

    public Collection ejbGetAzienda_Name_Address_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl,rag_scl_azl,idz_azl FROM ana_azl_tab ORDER BY rag_scl_azl ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Azienda_Name_Address_View obj = new Azienda_Name_Address_View();
                obj.COD_AZL = rs.getLong(1);
                obj.RAG_SCL_AZL = rs.getString(2);
                obj.IDZ_AZL = rs.getString(3);
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

    public Collection ejbGetAzienda_Name_BesidesID_View(long BesidesID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl,rag_scl_azl,cod_azl_asc FROM ana_azl_tab WHERE cod_azl <> ?");
            ps.setLong(1, BesidesID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Azienda_Name_BesidesID_View obj = new Azienda_Name_BesidesID_View();
                obj.COD_AZL = rs.getLong(1);
                obj.RAG_SCL_AZL = rs.getString(2);
                obj.COD_AZL_ASC = rs.getLong(3);
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

    public Collection ejbGetAzienda_Name_ByID_View(java.util.ArrayList WHE_IN_AZL) {
        BMPConnection bmp = getConnection();
        String cods = "";
        Iterator azl_ids = WHE_IN_AZL.iterator();
        while (azl_ids.hasNext()) {
            cods += azl_ids.next() + ",";
        }
        cods = cods.substring(0, cods.length() - 1);
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_azl,rag_scl_azl FROM ana_azl_tab WHERE cod_azl IN (" + cods + ") ORDER BY rag_scl_azl");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();

            while (rs.next()) {
                Azienda_Name_ByID_View obj = new Azienda_Name_ByID_View();
                obj.COD_AZL = rs.getLong(1);
                obj.RAG_SCL_AZL = rs.getString(2);
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

    public boolean CheckRischiExists(long lCOD_AZL) {
        String strSql = "select count(COD_AZL) from ana_rso_tab where COD_AZL = ?";

        boolean result = false;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            rs.next();
            result = rs.getLong(1) > 0;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            return result;
        }
    }

    public long getAziendeCount() {
        String strSql = "select count(COD_AZL) from ana_azl_tab";

        long result = 0;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ResultSet rs = ps.executeQuery();
            rs.next();
            result = rs.getLong(1);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
            return result;
        }
    }

    public Collection ejbGetAzienda_SAP_S2S_View(long C_SOC, String C_ARE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT" +
                    "   cod_azl, " +
                    "   c_soc, " +
                    "   c_are " +
                    "FROM" +
                    "   ana_azl_tab_s2s_sap " +
                    "WHERE" +
                    "   c_soc = ? " +
                    "   and c_are = ?");

            ps.setLong(1, C_SOC);
            ps.setString(2, C_ARE);
            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Azienda_SAP_S2S_View obj = new Azienda_SAP_S2S_View();
                obj.COD_AZL = rs.getLong(1);
                obj.C_SOC = rs.getLong(2);
                obj.C_ARE = rs.getString(3);
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

    public void updateMtrCogNom_AZL(String strMTR_DPD_old, String strCOG_DPD_old, String strNOM_DPD_old, String strMTR_DPD, String strCOG_DPD, String strNOM_DPD) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps1 = bmp.prepareStatement(
                    "UPDATE " +
                    "ana_azl_tab " +
                    "SET " +
                    "nom_rsp_azl = ? " +
                    "WHERE " +
                    "UPPER(nom_rsp_azl) = ?");
            
            PreparedStatement ps2 = bmp.prepareStatement(
                    "UPDATE " +
                    "ana_azl_tab " +
                    "SET " +
                    "nom_rsp_spp_azl = ? " +
                    "WHERE " +
                    "UPPER(nom_rsp_spp_azl) = ?");

            String oldValue = strMTR_DPD_old.concat(" ").concat(strCOG_DPD_old).concat(" ").concat(strNOM_DPD_old).toUpperCase();
            String newValue = strMTR_DPD.concat(" ").concat(strCOG_DPD).concat(" ").concat(strNOM_DPD).toUpperCase();

            ps1.setString(1, newValue);
            ps1.setString(2, oldValue);
            ps2.setString(1, newValue);
            ps2.setString(2, oldValue);

            ps1.executeUpdate();
            ps2.executeUpdate();

            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//////////////////////////////<findEx>/////////////////////////////////////////
    public Collection ejbfindEx(java.util.ArrayList WHE_IN_AZL, String CAG_AZL, String DES_ATI_SVO_AZL, String RAG_SCL_AZL, String IDZ_AZL, String NUM_CIC_AZL, String CIT_AZL, String PRV_AZL, String CAP_AZL, String QLF_RSP_AZL, String NOM_RSP_AZL, String NOM_RSP_SPP_AZL, String NOM_MED_AZL, Short MOD_CLC_RSO, String COD_FIS_AZL, String PAR_IVA_AZL) {
        String cods = "";
        Iterator azl_ids = WHE_IN_AZL.iterator();
        while (azl_ids.hasNext()) {
            cods += azl_ids.next() + ",";
        }
        cods = cods.substring(0, cods.length() - 1);
        BMPConnection bmp = getConnection();
        String Sql = "SELECT COD_AZL,CAG_AZL,DES_ATI_SVO_AZL,COD_IST_TAT_AZL,RAG_SCL_AZL,IDZ_AZL,NUM_CIC_AZL, " +
                " CIT_AZL,PRV_AZL,CAP_AZL,QLF_RSP_AZL,NOM_RSP_AZL,NOM_RSP_SPP_AZL,NOM_MED_AZL, " +
                " COD_AZL_ASC, MOD_CLC_RSO, " +
                " COD_FIS_AZL, PAR_IVA_AZL   " +
                "FROM ANA_AZL_TAB " +
                " WHERE COD_AZL IN (" + cods + ")";

        int i = 1;
        int indexCag = 0;
        String SqlA = "";
        if (CAG_AZL != null) {
            SqlA += " AND UPPER(cag_azl) LIKE ? ";
            indexCag = i++;
        }
        int indexAtiSvo = 0;
        if (DES_ATI_SVO_AZL != null) {
            SqlA += " AND UPPER(des_ati_svo_azl) LIKE ? ";
            indexAtiSvo = i++;
        }
        int indexRag = 0;
        if (RAG_SCL_AZL != null) {
            SqlA += " AND UPPER(rag_scl_azl) LIKE ? ";
            indexRag = i++;
        }
        int indexIdz = 0;
        if (IDZ_AZL != null) {
            SqlA += " AND UPPER(idz_azl) LIKE ? ";
            indexIdz = i++;
        }
        int indexCic = 0;
        if (NUM_CIC_AZL != null) {
            SqlA += " AND UPPER(num_cic_azl) LIKE ? ";
            indexCic = i++;
        }
        int indexCit = 0;
        if (CIT_AZL != null) {
            SqlA += " AND UPPER(cit_azl) LIKE ? ";
            indexCit = i++;
        }
        int indexPrv = 0;
        if (PRV_AZL != null) {
            SqlA += " AND UPPER(prv_azl) LIKE ? ";
            indexPrv = i++;
        }
        int indexCap = 0;
        if (CAP_AZL != null) {
            SqlA += " AND UPPER(cap_azl) LIKE ? ";
            indexCap = i++;
        }
        int indexQlf = 0;
        if (QLF_RSP_AZL != null) {
            SqlA += " AND UPPER(qlf_rsp_azl) LIKE ? ";
            indexQlf = i++;
        }
        int indexRsp = 0;
        if (NOM_RSP_AZL != null) {
            SqlA += " AND UPPER(nom_rsp_azl) LIKE ? ";
            indexRsp = i++;
        }
        int indexSpp = 0;
        if (NOM_RSP_SPP_AZL != null) {
            SqlA += " AND UPPER(nom_rsp_spp_azl) LIKE ? ";
            indexSpp = i++;
        }
        int indexMed = 0;
        if (NOM_MED_AZL != null) {
            SqlA += " AND UPPER(nom_med_azl) LIKE ? ";
            indexMed = i++;
        }
        int indexMcr = 0;
        if (MOD_CLC_RSO != null && MOD_CLC_RSO.shortValue() > 0) {
            SqlA += " AND mod_clc_rso = ? ";
            indexMcr = i++;
         }

        int indexFis = 0;
        if (COD_FIS_AZL != null) {
            SqlA += " AND UPPER(cod_fis_azl) LIKE ? ";
            indexFis = i++;
        }
          int indexIva = 0;
        if (PAR_IVA_AZL != null) {
            SqlA += " AND UPPER(par_iva_azl) LIKE ? ";
            indexIva = i++;
        }
        
//if (i>1)
//{
//  SqlA=" WHERE "+SqlA.substring(5,SqlA.length());
//}
        Sql = Sql + SqlA + " ORDER BY UPPER(rag_scl_azl)";
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (indexCag != 0) {
                ps.setString(indexCag, CAG_AZL.toUpperCase());
            }
            if (indexAtiSvo != 0) {
                ps.setString(indexAtiSvo, DES_ATI_SVO_AZL.toUpperCase());
            }
            if (indexRag != 0) {
                ps.setString(indexRag, RAG_SCL_AZL.toUpperCase());
            }
            if (indexIdz != 0) {
                ps.setString(indexIdz, IDZ_AZL.toUpperCase());
            }
            if (indexCic != 0) {
                ps.setString(indexCic, NUM_CIC_AZL.toUpperCase());
            }
            if (indexCit != 0) {
                ps.setString(indexCit, CIT_AZL.toUpperCase());
            }
            if (indexPrv != 0) {
                ps.setString(indexPrv, PRV_AZL.toUpperCase());
            }
            if (indexCap != 0) {
                ps.setString(indexCap, CAP_AZL.toUpperCase());
            }
            if (indexQlf != 0) {
                ps.setString(indexQlf, QLF_RSP_AZL.toUpperCase());
            }
            if (indexRsp != 0) {
                ps.setString(indexRsp, NOM_RSP_AZL.toUpperCase());
            }
            if (indexSpp != 0) {
                ps.setString(indexSpp, NOM_RSP_SPP_AZL.toUpperCase());
            }
            if (indexMed != 0) {
                ps.setString(indexMed, NOM_MED_AZL.toUpperCase());
            }
            if (indexMcr != 0) {
                ps.setShort(indexMcr, MOD_CLC_RSO.shortValue());
            }
            if (indexFis != 0) {
                ps.setString(indexFis, COD_FIS_AZL.toUpperCase());
            }
             if (indexIva != 0) {
                ps.setString(indexIva, PAR_IVA_AZL.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();

            while (rs.next()) {
                findEx_azl obj = new findEx_azl();
                obj.COD_AZL = rs.getLong(1);
                obj.CAG_AZL = rs.getString(2);
                obj.DES_ATI_SVO_AZL = rs.getString(3);
                obj.COD_IST_TAT_AZL = rs.getString(4);
                obj.RAG_SCL_AZL = rs.getString(5);
                obj.IDZ_AZL = rs.getString(6);
                obj.NUM_CIC_AZL = rs.getString(7);
                obj.CIT_AZL = rs.getString(8);
                obj.PRV_AZL = rs.getString(9);
                obj.CAP_AZL = rs.getString(10);
                obj.QLF_RSP_AZL = rs.getString(11);
                obj.NOM_RSP_AZL = rs.getString(12);
                obj.NOM_RSP_SPP_AZL = rs.getString(13);
                obj.NOM_MED_AZL = rs.getString(14);
                obj.COD_AZL_ASC = rs.getLong(15);
                obj.MOD_CLC_RSO = rs.getShort(16);
                obj.COD_FIS_AZL = rs.getString(17);
                obj.PAR_IVA_AZL = rs.getString(18);
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
