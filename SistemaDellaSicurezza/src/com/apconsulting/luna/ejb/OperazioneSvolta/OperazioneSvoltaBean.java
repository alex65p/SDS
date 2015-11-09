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
package com.apconsulting.luna.ejb.OperazioneSvolta;

import java.sql.Connection;
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
public class OperazioneSvoltaBean extends BMPEntityBean implements IOperazioneSvolta, IOperazioneSvoltaHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta

    String NOM_OPE_SVO;     	//1
    long COD_OPE_SVO;        	//2
    //---------------------------
    String DES_OPE_SVO;     	//3

///////////////////// CONSTRUCTOR///////////////////
    private static OperazioneSvoltaBean ys = null;

    private OperazioneSvoltaBean() {
        //
    }

    public static OperazioneSvoltaBean getInstance() {
        if (ys == null) {
            ys = new OperazioneSvoltaBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IOperazioneSvolta create(String strNOM_OPE_SVO) throws CreateException {
        OperazioneSvoltaBean bean = new OperazioneSvoltaBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_OPE_SVO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_OPE_SVO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        OperazioneSvoltaBean iOperazioneSvoltaBean = new OperazioneSvoltaBean();
        try {
            Object obj = iOperazioneSvoltaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iOperazioneSvoltaBean.setEntityContext(new EntityContextWrapper(obj));
            iOperazioneSvoltaBean.ejbActivate();
            iOperazioneSvoltaBean.ejbLoad();
            iOperazioneSvoltaBean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IOperazioneSvolta findByPrimaryKey(Long primaryKey) throws FinderException {
        OperazioneSvoltaBean bean = new OperazioneSvoltaBean();
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

    // (Home Intrface) VIEWS  getOperazioneSvolta_Name_Address_View()
    public Collection getOperazioneSvolta_Name_View() {
        return (new OperazioneSvoltaBean()).ejbGetOperazioneSvolta_Name_View();
    }
    /*  public void addSostanzeRischiToOperazione(long lCOD_OPE_SVO, long lCOD_SOS_CHI, long lCOD_AZL){
    ejbAddSostanzeRischiToOperazione(lCOD_OPE_SVO, lCOD_SOS_CHI, lCOD_AZL);
    }*/

    public Collection findEx(String NOM, String DES, long iOrderBy) {
        return (new OperazioneSvoltaBean()).ejbfindEx(NOM, DES, iOrderBy);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IOperazioneSvoltaHome-implementation>
    public Long ejbCreate(String strNOM_OPE_SVO) {
        this.NOM_OPE_SVO = strNOM_OPE_SVO;
        this.COD_OPE_SVO = NEW_ID(); 		// unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_ope_svo_tab (cod_ope_svo,nom_ope_svo) VALUES(?,?)");
            ps.setLong(1, COD_OPE_SVO);
            ps.setString(2, NOM_OPE_SVO);
            ps.executeUpdate();
            return new Long(COD_OPE_SVO);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_OPE_SVO) {
    }
//-------------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ope_svo FROM ana_ope_svo_tab ");
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
        this.COD_OPE_SVO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_OPE_SVO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ope_svo_tab  WHERE cod_ope_svo=?");
            ps.setLong(1, COD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_OPE_SVO = rs.getString("NOM_OPE_SVO");
                this.DES_OPE_SVO = rs.getString("DES_OPE_SVO");
            } else {
                throw new NoSuchEntityException("OperazioneSvolta con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ope_svo_tab  WHERE cod_ope_svo=?");
            ps.setLong(1, COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("OperazioneSvolta con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ope_svo_tab  SET nom_ope_svo=?, des_ope_svo=? WHERE cod_ope_svo=?");
            ps.setString(1, NOM_OPE_SVO);
            ps.setString(2, DES_OPE_SVO);
            ps.setLong(3, COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("OperazioneSvolta con ID= non è trovata");
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
    public void setNOM_OPE_SVO(String newNOM_OPE_SVO) {
        if (NOM_OPE_SVO.equals(newNOM_OPE_SVO)) {
            return;
        }
        NOM_OPE_SVO = newNOM_OPE_SVO;
        setModified();
    }

    public String getNOM_OPE_SVO() {
        return NOM_OPE_SVO;
    }
    //2

    public long getCOD_OPE_SVO() {
        return COD_OPE_SVO;
    }
    //============================================
    // not required field
    //3

    public void setDES_OPE_SVO(String newDES_OPE_SVO) {
        if (DES_OPE_SVO != null) {
            if (DES_OPE_SVO.equals(newDES_OPE_SVO)) {
                return;
            }
        }
        DES_OPE_SVO = newDES_OPE_SVO;
        setModified();
    }

    public String getDES_OPE_SVO() {
        return DES_OPE_SVO;
    }

    //</comment>

    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>

    //<comment description="extended setters/getters">
    public Collection ejbGetOperazioneSvolta_Name_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ope_svo, nom_ope_svo, des_ope_svo FROM ana_ope_svo_tab ORDER BY nom_ope_svo ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                OperazioneSvolta_Name_View obj = new OperazioneSvolta_Name_View();
                obj.COD_OPE_SVO = rs.getLong(1);
                obj.NOM_OPE_SVO = rs.getString(2);
                obj.DES_OPE_SVO = rs.getString(3);
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

    /*<comment date="06/02/2004" author="Roman Chumachenko">
    <description>Adding of object views for ANA_OPE_SVO_Form</description>
    </comment>*/
    public Collection getRischi_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana_rso_tab.cod_rso, ana_rso_tab.nom_rso, ana_fat_rso_tab.nom_fat_rso FROM rso_ope_svo_tab, ana_rso_tab, ana_fat_rso_tab  WHERE rso_ope_svo_tab.cod_ope_svo =? AND rso_ope_svo_tab.cod_rso = ana_rso_tab.cod_rso AND rso_ope_svo_tab.cod_azl = ana_rso_tab.cod_azl AND ana_rso_tab.cod_fat_rso = ana_fat_rso_tab.cod_fat_rso AND rso_ope_svo_tab.cod_azl =? order by ana_rso_tab.nom_rso");
            ps.setLong(1, COD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                OpSvolte_Rischi_View obj = new OpSvolte_Rischi_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
                obj.NOM_FAT_RSO = rs.getString(3);
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
    //----

    public Collection getDocumenti_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT doc_ope_svo_tab.cod_doc, ana_doc_tab.tit_doc, ana_doc_tab.rsp_doc, ana_doc_tab.dat_rev_doc FROM doc_ope_svo_tab , ana_doc_tab  WHERE doc_ope_svo_tab.cod_ope_svo =? AND doc_ope_svo_tab.cod_doc = ana_doc_tab.cod_doc AND (ana_doc_tab.cod_azl=? OR ana_doc_tab.cod_azl=0 OR ana_doc_tab.cod_azl IS NULL) order by ana_doc_tab.tit_doc");
            ps.setLong(1, COD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                OpSvolte_Documenti_View obj = new OpSvolte_Documenti_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                obj.RSP_DOC = rs.getString(3);
                obj.DAT_REV_DOC = rs.getDate(4);
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
    //----

    public Collection getMacchine_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT mac_ope_svo_tab.cod_mac, ana_mac_tab.ide_mac, ana_mac_tab.des_mac FROM mac_ope_svo_tab, ana_mac_tab WHERE mac_ope_svo_tab.cod_ope_svo =? AND mac_ope_svo_tab.cod_mac = ana_mac_tab.cod_mac AND ana_mac_tab.cod_azl=? order by ana_mac_tab.ide_mac");
            ps.setLong(1, COD_OPE_SVO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                OpSvolte_Macchine_View obj = new OpSvolte_Macchine_View();
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

    //----
    public Collection getAgentiChimici_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT sos_chi_ope_svo_tab.cod_sos_chi, ana_clf_sos_tab.des_clf_sos, ana_sos_chi_tab.nom_com_sos  FROM sos_chi_ope_svo_tab, ana_sos_chi_tab, ana_clf_sos_tab WHERE sos_chi_ope_svo_tab.cod_ope_svo =? AND sos_chi_ope_svo_tab.cod_sos_chi = ana_sos_chi_tab.cod_sos_chi AND ana_sos_chi_tab.cod_clf_sos =  ana_clf_sos_tab.cod_clf_sos  order by ana_sos_chi_tab.nom_com_sos");
            ps.setLong(1, COD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                OpSvolte_AgentiChimici_View obj = new OpSvolte_AgentiChimici_View();
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
    //----

    /*<comment date="11/02/2004" author="Roman Chumachenko">
    <description>Adding of add/remove Document methods</description>
    </comment>*/
    // --------- Document ----------------
    public void addDocument(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_ope_svo_tab (cod_doc, cod_ope_svo) VALUES(?,?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

    }
    //----

    public void removeDocument(long COD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ope_svo_tab  WHERE  (cod_doc=? AND cod_ope_svo=?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  annulata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------
    // --------- Risc--------------------------

    public void addRisc(long COD_RSO, long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO rso_ope_svo_tab (cod_rso, cod_ope_svo, cod_azl) VALUES(?,?,?) ");
            ps.setLong(1, COD_RSO);
            ps.setLong(2, this.COD_OPE_SVO);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----

    public void removeRisc(long COD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_ope_svo_tab  WHERE  (cod_rso=? AND cod_ope_svo=?) ");
            ps.setLong(1, COD_RSO);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  annulata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------------------------

    public void addAgenteChimico(long COD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO sos_chi_ope_svo_tab  (cod_sos_chi, cod_ope_svo) VALUES(?,?)");
            ps.setLong(1, COD_SOS_CHI);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----

    public void removeAgenteChimico(long COD_SOS_CHI, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        try {
            conn.setAutoCommit(false);
            //---deleting associated rischi from Operazione Svolte---
            PreparedStatement ps_rischi = bmp.prepareStatement(
                    "SELECT cod_rso FROM rso_sos_chi_tab WHERE cod_sos_chi=? and cod_azl=?");
            ps_rischi.setLong(1, COD_SOS_CHI);
            ps_rischi.setLong(2, lCOD_AZL);
            ResultSet rs_rischi = ps_rischi.executeQuery();
            PreparedStatement ps_rischi_delete = null;
            while (rs_rischi.next()) {
                ps_rischi_delete = bmp.prepareStatement(
                        "DELETE FROM rso_ope_svo_tab WHERE (cod_rso=? AND cod_ope_svo=?)");
                ps_rischi_delete.setLong(1, rs_rischi.getLong(1));
                ps_rischi_delete.setLong(2, this.COD_OPE_SVO);
                ps_rischi_delete.executeUpdate();
                ps_rischi_delete.clearParameters();
            }
            //----------
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM sos_chi_ope_svo_tab  WHERE  (cod_sos_chi=? AND cod_ope_svo=?)");
            ps.setLong(1, COD_SOS_CHI);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  annulata");
            }
            conn.commit();
        } catch (Exception ex) {
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
    }

    public Collection getByRischio(String idRischio) {

        String sql = "SELECT A.cod_ope_svo, A.nom_ope_svo ";
        sql += " FROM ana_ope_svo_tab A,rso_ope_svo_tab B ";
        sql += " WHERE B.cod_rso = ?";
        sql += " AND A.cod_ope_svo = B.cod_ope_svo";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(idRischio));
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findBy_rischio obj = new findBy_rischio();
                obj.COD_OPE_SVO = rs.getLong(1);
                obj.NOM_OPE_SVO = rs.getString(2);
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

    //-----------------------------------------

    //-----------------------------------------------
    public void addMacchina(long COD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mac_ope_svo_tab  (cod_mac, cod_ope_svo) VALUES(?,?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, this.COD_OPE_SVO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento associato non è  inserita");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----

    public void removeMacchina(long COD_MAC) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        try {
            conn.setAutoCommit(false);
            //---deleting associated rischi from Operazione Svolte---
            PreparedStatement ps_rischi = bmp.prepareStatement(
                    "SELECT COD_RSO FROM RSO_MAC_TAB WHERE COD_MAC=?");
            ps_rischi.setLong(1, COD_MAC);
            ResultSet rs_rischi = ps_rischi.executeQuery();
            PreparedStatement ps_rischi_delete = null;
            while (rs_rischi.next()) {
                ps_rischi_delete = bmp.prepareStatement(
                        "DELETE FROM RSO_OPE_SVO_TAB WHERE (COD_RSO=? AND COD_OPE_SVO=?)");
                ps_rischi_delete.setLong(1, rs_rischi.getLong(1));
                ps_rischi_delete.setLong(2, this.COD_OPE_SVO);
                ps_rischi_delete.executeUpdate();
                ps_rischi_delete.clearParameters();
            }
            //----------
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM mac_ope_svo_tab  WHERE  (cod_mac=? AND cod_ope_svo=?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, this.COD_OPE_SVO);
            ps.executeUpdate();
            conn.commit();
        } catch (Exception ex) {
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
    }
    //-----------------------------------------

    //-----------------------------------------
    // by Pogrebnoy Yura dlya GEST_MAN
    public void removeGEST_MAN_OPE_SVO() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ope_svo_man_tab WHERE cod_ope_svo=? ");
            ps.setLong(1, COD_OPE_SVO);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------
	/*public void ejbAddSostanzeRischiToOperazione(long lCOD_OPE_SVO, long lCOD_SOS_CHI, long lCOD_AZL){
    BMPConnection bmp=getConnection();
    Connection conn=bmp.getConnection();
    try{
    conn.setAutoCommit(false);
    ResultSet rs;
    PreparedStatement ps=bmp.prepareStatement("select a.cod_rso from rso_sos_chi_tab a, ana_sos_chi_tab b where a.cod_sos_chi=b.cod_sos_chi and a.cod_azl=? and a.cod_sos_chi=? and a.cod_rso not in (select cod_rso from rso_ope_svo_tab where cod_ope_svo=? and cod_azl=?)");
    ps.setLong(1, lCOD_AZL);
    ps.setLong(2, lCOD_SOS_CHI);
    ps.setLong(3, lCOD_OPE_SVO);
    ps.setLong(4, lCOD_AZL);
    rs=ps.executeQuery();
    while (rs.next()){
    long COD_RSO = rs.getLong(1);
    PreparedStatement ps_ins=bmp.prepareStatement("insert into rso_ope_svo_tab values (?,?,?)");
    ps_ins.setLong(1, lCOD_OPE_SVO);
    ps_ins.setLong(2, COD_RSO);
    ps_ins.setLong(3, lCOD_AZL);
    ps_ins.executeUpdate();
    }
    conn.commit();
    }
    catch(Exception ex){
    try{
    conn.rollback();
    }catch(Exception ex1){}
    throw new EJBException(ex);
    }
    finally{
    try{
    conn.close();
    bmp.close();
    }catch(Exception ex1){}
    }
    }*/
    //////////////////////<Kushkarov for new Search>///////////////////////////

    public Collection ejbfindEx(String NOM, String DES, long iOrderBy) {
        String Sql = "SELECT cod_ope_svo, nom_ope_svo, des_ope_svo FROM ana_ope_svo_tab ";
        int i = 1;
        int desIndex = 0;
        int nomIndex = 0;
        if (NOM == null) {
            NOM = "";
        }
        if (DES == null) {
            DES = "";
        }

        if (NOM.length() > 0) {
            Sql += " WHERE ";
            Sql += " UPPER(nom_ope_svo) LIKE ?";
            nomIndex = i++;
        }
        if (DES.length() > 0) {
            if (nomIndex != 0) {
                Sql += " AND ";
            } else {
                Sql += " WHERE ";
            }
            Sql += " UPPER(des_ope_svo) LIKE ?";
            desIndex = i++;
        }
        Sql += " ORDER BY nom_ope_svo ";//+ (iOrderBy>0?" ASC": "DESC");
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (nomIndex != 0) {
                ps.setString(nomIndex, NOM + "%".toUpperCase());
            }
            if (desIndex != 0) {
                ps.setString(desIndex, DES + "%".toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_ope_svo obj = new findEx_ope_svo();
                obj.COD_OPE_SVO = rs.getLong(1);
                obj.NOM_OPE_SVO = rs.getString(2);
                obj.DES_OPE_SVO = rs.getString(3);
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
    //////////////////////</Kushkarov for new Search>//////////////////////////

///////////ATTENTION!!////////////////////////////////////////
}
