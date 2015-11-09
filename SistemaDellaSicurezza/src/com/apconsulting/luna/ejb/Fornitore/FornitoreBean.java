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
package com.apconsulting.luna.ejb.Fornitore;

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
//public class FornitoreBean extends BMPEntityBean implements IFornitoreRemote
public class FornitoreBean extends BMPEntityBean implements IFornitore, IFornitoreHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    //   *require Fields*
    String RAG_SOC_FOR_AZL;
    String CAG_FOR;
    String IDZ_FOR;
    String CIT_FOR;
    String QLF_RSP_FOR;
    String NOM_RSP_FOR;
    long COD_FOR_AZL;
    long COD_AZL;
    long COD_STA;
    //   *Not require Fields*
    String NUM_CIC_FOR;
    String PRV_FOR;
    String CAP_FOR;
    String IDZ_PSA_ELT_RSP;
    String SIT_INT_FOR;
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static FornitoreBean ys = null;

    private FornitoreBean() {
        //
    }

    public static FornitoreBean getInstance() {
        if (ys == null) {
            ys = new FornitoreBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IFornitore create(String strRAG_SOC_FOR_AZL, String strCAG_FOR, String strIDZ_FOR, String strCIT_FOR, String strQLF_RSP_FOR, String strNOM_RSP_FOR, long lCOD_AZL, long lCOD_STA) throws RemoteException, CreateException {
        FornitoreBean bean = new FornitoreBean();
        try {
            Object primaryKey = bean.ejbCreate(strRAG_SOC_FOR_AZL, strCAG_FOR, strIDZ_FOR, strCIT_FOR, strQLF_RSP_FOR, strNOM_RSP_FOR, lCOD_AZL, lCOD_STA);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strRAG_SOC_FOR_AZL, strCAG_FOR, strIDZ_FOR, strCIT_FOR, strQLF_RSP_FOR, strNOM_RSP_FOR, lCOD_AZL, lCOD_STA);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());

        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        FornitoreBean iFornitoreBean = new FornitoreBean();
        try {
            Object obj = iFornitoreBean.ejbFindByPrimaryKey((Long) primaryKey);
            iFornitoreBean.setEntityContext(new EntityContextWrapper(obj));
            iFornitoreBean.ejbActivate();
            iFornitoreBean.ejbLoad();
            iFornitoreBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IFornitore findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        FornitoreBean bean = new FornitoreBean();
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

    // (Home Intrface) VIEWS  getFornitore_Categoria_RagSoc_View()
    public Collection getFornitore_Categoria_RagSoc_View(long AZL_ID) {
        return (new FornitoreBean()).ejbGetFornitore_Categoria_RagSoc_View(AZL_ID);
    }
//--- view Chimical Agento

    public Collection getChimicalAgentoByFORAZLID_View(long FOR_AZL_ID) {
        return (new FornitoreBean()).ejbGetChimicalAgentoByFORAZLID_View(FOR_AZL_ID);
    }
//--- view Macchina

    public Collection getMacchinaByFORAZLID_View(long FOR_AZL_ID) {
        return (new FornitoreBean()).ejbGetMacchinaByFORAZLID_View(FOR_AZL_ID);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IFornitoreHome-implementation>
    public Long ejbCreate(String strRAG_SOC_FOR_AZL, String strCAG_FOR, String strIDZ_FOR, String strCIT_FOR, String strQLF_RSP_FOR, String strNOM_RSP_FOR, long lCOD_AZL, long lCOD_STA) {
        this.RAG_SOC_FOR_AZL = strRAG_SOC_FOR_AZL;
        this.CAG_FOR = strCAG_FOR;
        this.IDZ_FOR = strIDZ_FOR;
        this.CIT_FOR = strCIT_FOR;
        this.QLF_RSP_FOR = strQLF_RSP_FOR;
        this.NOM_RSP_FOR = strNOM_RSP_FOR;
        this.COD_AZL = lCOD_AZL;
        this.COD_STA = lCOD_STA;
        this.COD_FOR_AZL = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_for_azl_tab (cod_for_azl,rag_soc_for_azl,cag_for,idz_for,cit_for,qlf_rsp_for,nom_rsp_for,cod_azl,cod_sta) VALUES(?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_FOR_AZL);
            ps.setString(2, RAG_SOC_FOR_AZL);
            ps.setString(3, CAG_FOR);
            ps.setString(4, IDZ_FOR);
            ps.setString(5, CIT_FOR);
            ps.setString(6, QLF_RSP_FOR);
            ps.setString(7, NOM_RSP_FOR);
            ps.setLong(8, COD_AZL);
            ps.setLong(9, COD_STA);

            ps.executeUpdate();
            return new Long(COD_FOR_AZL);
        } catch (Exception ex) {
            throw new EJBException(ex);
            //throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strRAG_SOC_FOR_AZL, String strCAG_FOR, String strIDZ_FOR, String strCIT_FOR, String strQLF_RSP_FOR, String strNOM_RSP_FOR, long lCOD_AZL, long lCOD_STA) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_for_azl FROM ana_for_azl_tab ");
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
        this.COD_FOR_AZL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_FOR_AZL = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_for_azl_tab  WHERE cod_for_azl=?");
            ps.setLong(1, COD_FOR_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.RAG_SOC_FOR_AZL = rs.getString("RAG_SOC_FOR_AZL");
                this.CAG_FOR = rs.getString("CAG_FOR");
                this.IDZ_FOR = rs.getString("IDZ_FOR");
                this.NUM_CIC_FOR = rs.getString("NUM_CIC_FOR");
                this.CIT_FOR = rs.getString("CIT_FOR");
                this.PRV_FOR = rs.getString("PRV_FOR");
                this.CAP_FOR = rs.getString("CAP_FOR");
                this.QLF_RSP_FOR = rs.getString("QLF_RSP_FOR");
                this.NOM_RSP_FOR = rs.getString("NOM_RSP_FOR");
                this.IDZ_PSA_ELT_RSP = rs.getString("IDZ_PSA_ELT_RSP");
                this.SIT_INT_FOR = rs.getString("SIT_INT_FOR");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_STA = rs.getLong("COD_STA");
            } else {
                throw new NoSuchEntityException("Fornitore con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_for_azl_tab  WHERE cod_for_azl=?");
            ps.setLong(1, COD_FOR_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Fornitore con ID=" + COD_FOR_AZL + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_for_azl_tab  SET rag_soc_for_azl=?, cag_for=?, idz_for=?, num_cic_for=?, cit_for=?, prv_for=?, cap_for=?, qlf_rsp_for=?, nom_rsp_for=?, idz_psa_elt_rsp=?, sit_int_for=?, cod_azl=?, cod_sta=? WHERE cod_for_azl=?");

            ps.setString(1, RAG_SOC_FOR_AZL);
            ps.setString(2, CAG_FOR);
            ps.setString(3, IDZ_FOR);
            ps.setString(4, NUM_CIC_FOR);
            ps.setString(5, CIT_FOR);
            ps.setString(6, PRV_FOR);
            ps.setString(7, CAP_FOR);
            ps.setString(8, QLF_RSP_FOR);
            ps.setString(9, NOM_RSP_FOR);
            ps.setString(10, IDZ_PSA_ELT_RSP);
            ps.setString(11, SIT_INT_FOR);
            ps.setLong(12, COD_AZL);
            ps.setLong(13, COD_STA);
            ps.setLong(14, COD_FOR_AZL);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Fornitore with ID= not found");
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
    public String getRAG_SOC_FOR_AZL() {
        return RAG_SOC_FOR_AZL;
    }
    //----2

    public String getCAG_FOR() {
        return CAG_FOR;
    }

    public void setRAG_SOC_FOR_AZL__CAG_FOR(String newRAG_SOC_FOR_AZL, String newCAG_FOR) {
        if ((CAG_FOR.equals(newCAG_FOR)) && (RAG_SOC_FOR_AZL.equals(newRAG_SOC_FOR_AZL))) {
            return;
        }

        RAG_SOC_FOR_AZL = newRAG_SOC_FOR_AZL;
        CAG_FOR = newCAG_FOR;
        setModified();
    }

    //----3
    public void setIDZ_FOR(String newIDZ_FOR) {
        if (IDZ_FOR.equals(newIDZ_FOR)) {
            return;
        }
        IDZ_FOR = newIDZ_FOR;
        setModified();
    }

    public String getIDZ_FOR() {
        return IDZ_FOR;
    }
    //----4

    public void setNUM_CIC_FOR(String newNUM_CIC_FOR) {
        if (NUM_CIC_FOR != null) {
            if (NUM_CIC_FOR.equals(newNUM_CIC_FOR)) {
                return;
            }
        }
        NUM_CIC_FOR = newNUM_CIC_FOR;
        setModified();
    }

    public String getNUM_CIC_FOR() {
        if (NUM_CIC_FOR == null) {
            return "";
        }
        return NUM_CIC_FOR;
    }
    //----5

    public void setCIT_FOR(String newCIT_FOR) {
        if (CIT_FOR.equals(newCIT_FOR)) {
            return;
        }
        CIT_FOR = newCIT_FOR;
        setModified();
    }

    public String getCIT_FOR() {
        return CIT_FOR;
    }
    //----6

    public void setPRV_FOR(String newPRV_FOR) {
        if (PRV_FOR != null) {
            if (PRV_FOR.equals(newPRV_FOR)) {
                return;
            }
        }
        PRV_FOR = newPRV_FOR;
        setModified();
    }

    public String getPRV_FOR() {
        if (PRV_FOR == null) {
            return "";
        }
        return PRV_FOR;
    }
    //----7

    public void setCAP_FOR(String newCAP_FOR) {
        if (CAP_FOR != null) {
            if (CAP_FOR.equals(newCAP_FOR)) {
                return;
            }
        }
        CAP_FOR = newCAP_FOR;
        setModified();
    }

    public String getCAP_FOR() {
        if (CAP_FOR == null) {
            return "";
        }
        return CAP_FOR;
    }
    //----8

    public void setQLF_RSP_FOR(String newQLF_RSP_FOR) {
        if (QLF_RSP_FOR.equals(newQLF_RSP_FOR)) {
            return;
        }
        QLF_RSP_FOR = newQLF_RSP_FOR;
        setModified();
    }

    public String getQLF_RSP_FOR() {
        return QLF_RSP_FOR;
    }
    //----9

    public void setNOM_RSP_FOR(String newNOM_RSP_FOR) {
        if (NOM_RSP_FOR.equals(newNOM_RSP_FOR)) {
            return;
        }
        NOM_RSP_FOR = newNOM_RSP_FOR;
        setModified();
    }

    public String getNOM_RSP_FOR() {
        return NOM_RSP_FOR;
    }
    //----10

    public void setIDZ_PSA_ELT_RSP(String newIDZ_PSA_ELT_RSP) {
        if (IDZ_PSA_ELT_RSP != null) {
            if (IDZ_PSA_ELT_RSP.equals(newIDZ_PSA_ELT_RSP)) {
                return;
            }
        }
        IDZ_PSA_ELT_RSP = newIDZ_PSA_ELT_RSP;
        setModified();
    }

    public String getIDZ_PSA_ELT_RSP() {
        if (IDZ_PSA_ELT_RSP == null) {
            return "";
        }
        return IDZ_PSA_ELT_RSP;
    }
    //----11

    public void setSIT_INT_FOR(String newSIT_INT_FOR) {
        if (SIT_INT_FOR != null) {
            if (SIT_INT_FOR.equals(newSIT_INT_FOR)) {
                return;
            }
        }
        SIT_INT_FOR = newSIT_INT_FOR;
        setModified();
    }

    public String getSIT_INT_FOR() {
        if (SIT_INT_FOR == null) {
            return "";
        }
        return SIT_INT_FOR;
    }
    //----------------12

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

    public String getsCOD_AZL() {
        return new Long(COD_AZL).toString();
    }
    //----------------13

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
    //----------------14

    public long getCOD_FOR_AZL() {
        return COD_FOR_AZL;
    }
    //-------------------

//-----------------------------#############################################
// %%%Link%%% Table SOS_CHI_FOR_AZL_TAB
    public void addCOD_SOS_CHI(long newCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO sos_chi_for_azl_tab (cod_sos_chi,cod_for_azl) VALUES(?,?)");
            ps.setLong(1, newCOD_SOS_CHI);
            ps.setLong(2, COD_FOR_AZL);
            ps.executeUpdate();
            //return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// %%%UNLink%%% Table SOS_CHI_FOR_AZL_TAB

    public void removeCOD_SOS_CHI(long newCOD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM sos_chi_for_azl_tab  WHERE cod_for_azl=? AND cod_sos_chi=?");
            ps.setLong(1, COD_FOR_AZL);
            ps.setLong(2, newCOD_SOS_CHI);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Agente Chimice con ID=" + newCOD_SOS_CHI + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-----------------------------#############################################
// %%%Link%%% Table mac_for_azl_tab

    public void addCOD_MAC(long newCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mac_for_azl_tab (cod_mac,cod_for_azl) VALUES(?,?)");
            ps.setLong(1, newCOD_MAC);
            ps.setLong(2, COD_FOR_AZL);
            ps.executeUpdate();
            //return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// %%%UNLink%%% Table mac_for_azl_tab

    public void removeCOD_MAC(long newCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mac_for_azl_tab  WHERE cod_for_azl=? AND cod_mac=?");
            ps.setLong(1, COD_FOR_AZL);
            ps.setLong(2, newCOD_MAC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Macchina con ID=" + newCOD_MAC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetFornitore_Categoria_RagSoc_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  cod_for_azl,rag_soc_for_azl, cag_for FROM ana_for_azl_tab WHERE cod_azl=? ORDER BY rag_soc_for_azl, cag_for ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Fornitore_Categoria_RagSoc_View obj = new Fornitore_Categoria_RagSoc_View();
                obj.COD_FOR_AZL = rs.getLong(1);
                obj.RAG_SOC_FOR_AZL = rs.getString(2);
                obj.CAG_FOR = rs.getString(3);
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

//--- select from chimical agento
    public Collection ejbGetChimicalAgentoByFORAZLID_View(long FOR_AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT sc.cod_sos_chi, sc.des_sos, sc.nom_com_sos  FROM sos_chi_for_azl_tab  scfa,  ana_sos_chi_tab sc  WHERE sc.cod_sos_chi=scfa.cod_sos_chi AND  scfa.cod_for_azl=?  ORDER  BY sc.des_sos, sc.nom_com_sos ");

            ps.setLong(1, FOR_AZL_ID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ChimicalAgentoByFORAZLID_View obj = new ChimicalAgentoByFORAZLID_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.DES_SOS = rs.getString(2);
                obj.NOM_COM_SOS = rs.getString(3);
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
//--- select from maccina

    public Collection ejbGetMacchinaByFORAZLID_View(long FOR_AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "SELECT m.cod_mac, "
                    + "m.ide_mac, "
                    + "m.des_mac "
                    + "FROM mac_for_azl_tab mfa, ana_mac_tab m "
                    + "WHERE mfa.cod_mac=m.cod_mac "
                    + "AND mfa.cod_for_azl=? ORDER BY m.ide_mac, m.des_mac ");

            ps.setLong(1, FOR_AZL_ID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchinaByFORAZLID_View obj = new MacchinaByFORAZLID_View();
                obj.COD_MAC = rs.getLong(1);
                obj.IDE_MAC = rs.getString(2);
                obj.DES_MAC = rs.getString(3);
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
    //---- for search ---//
    public Collection findEx(
            long lCOD_AZL,
            String strRAG_SOC_FOR_AZL,
            String strCAG_FOR,
            String strIDZ_FOR,
            String strNUM_CIC_FOR,
            String strCIT_FOR,
            String strPRV_FOR,
            String strCAP_FOR,
            String strQLF_RSP_FOR,
            String strNOM_RSP_FOR,
            String strIDZ_PSA_ELT_RSP,
            String strSIT_INT_FOR,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(lCOD_AZL, strRAG_SOC_FOR_AZL, strCAG_FOR, strIDZ_FOR, strNUM_CIC_FOR, strCIT_FOR, strPRV_FOR, strCAP_FOR, strQLF_RSP_FOR, strNOM_RSP_FOR, strIDZ_PSA_ELT_RSP, strSIT_INT_FOR, iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strRAG_SOC_FOR_AZL,
            String strCAG_FOR,
            String strIDZ_FOR,
            String strNUM_CIC_FOR,
            String strCIT_FOR,
            String strPRV_FOR,
            String strCAP_FOR,
            String strQLF_RSP_FOR,
            String strNOM_RSP_FOR,
            String strIDZ_PSA_ELT_RSP,
            String strSIT_INT_FOR,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT cod_for_azl, rag_soc_for_azl, cag_for, cod_azl, cod_sta "
                + "FROM ana_for_azl_tab  WHERE cod_azl = ? ";

        if (strRAG_SOC_FOR_AZL != null) {
            strSql += " AND UPPER(rag_soc_for_azl) LIKE ? ";
        }
        if (strCAG_FOR != null) {
            strSql += " AND UPPER(cag_for) LIKE ? ";
        }
        if (strIDZ_FOR != null) {
            strSql += " AND UPPER(idz_for) LIKE ? ";
        }
        if (strNUM_CIC_FOR != null) {
            strSql += " AND UPPER(num_cic_for) LIKE ? ";
        }
        if (strCIT_FOR != null) {
            strSql += " AND UPPER(cit_for) LIKE ? ";
        }
        if (strPRV_FOR != null) {
            strSql += " AND UPPER(prv_for) LIKE ? ";
        }
        if (strCAP_FOR != null) {
            strSql += " AND UPPER(cap_for) LIKE ? ";
        }
        if (strQLF_RSP_FOR != null) {
            strSql += " AND UPPER(qlf_rsp_for) LIKE ? ";
        }
        if (strNOM_RSP_FOR != null) {
            strSql += " AND UPPER(nom_rsp_for) LIKE ? ";
        }
        if (strIDZ_PSA_ELT_RSP != null) {
            strSql += " AND UPPER(idz_psa_elt_rsp) LIKE ? ";
        }
        if (strSIT_INT_FOR != null) {
            strSql += " AND UPPER(sit_int_for) LIKE ? ";
        }

        strSql += " ORDER BY rag_soc_for_azl, cag_for";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strRAG_SOC_FOR_AZL != null) {
                ps.setString(i++, strRAG_SOC_FOR_AZL.toUpperCase());
            }
            if (strCAG_FOR != null) {
                ps.setString(i++, strCAG_FOR.toUpperCase());
            }
            if (strIDZ_FOR != null) {
                ps.setString(i++, strIDZ_FOR.toUpperCase());
            }
            if (strNUM_CIC_FOR != null) {
                ps.setString(i++, strNUM_CIC_FOR.toUpperCase());
            }
            if (strCIT_FOR != null) {
                ps.setString(i++, strCIT_FOR.toUpperCase());
            }
            if (strPRV_FOR != null) {
                ps.setString(i++, strPRV_FOR.toUpperCase());
            }
            if (strCAP_FOR != null) {
                ps.setString(i++, strCAP_FOR.toUpperCase());
            }
            if (strQLF_RSP_FOR != null) {
                ps.setString(i++, strQLF_RSP_FOR.toUpperCase());
            }
            if (strNOM_RSP_FOR != null) {
                ps.setString(i++, strNOM_RSP_FOR.toUpperCase());
            }
            if (strIDZ_PSA_ELT_RSP != null) {
                ps.setString(i++, strIDZ_PSA_ELT_RSP.toUpperCase());
            }
            if (strSIT_INT_FOR != null) {
                ps.setString(i++, strSIT_INT_FOR.toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Fornitore_Categoria_RagSoc_View obj = new Fornitore_Categoria_RagSoc_View();
                obj.COD_FOR_AZL = rs.getLong(1);
                obj.RAG_SOC_FOR_AZL = rs.getString(2);
                obj.CAG_FOR = rs.getString(3);
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
}//<comment description="end of implementation  FornitoreBean"/>
