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
package com.apconsulting.luna.ejb.ProtocoleSanitare;

import java.sql.Connection;
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
public class ProtocoleSanitareBean extends BMPEntityBean implements IProtocoleSanitareHome, IProtocoleSanitare {
    //<comment description="Member Variables">

    ProtocoleSanitarePK primaryKey;
    long COD_PRO_SAN;
    long COD_AZL;
    String NOM_PRO_SAN;
    String DES_PRO_SAN;
    long COD_PRO_SAN_RPO;
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static ProtocoleSanitareBean ys = null;

    private ProtocoleSanitareBean() {
        //
    }

    public static ProtocoleSanitareBean getInstance() {
        if (ys == null) {
            ys = new ProtocoleSanitareBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface)
    public IProtocoleSanitare create(
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            long lCOD_AZL,
            java.util.ArrayList alAziende) throws CreateException {
        ProtocoleSanitareBean bean = new ProtocoleSanitareBean();
        try {
            Object oPrimaryKey = bean.ejbCreate(strNOM_PRO_SAN, strDES_PRO_SAN, lCOD_AZL, alAziende);
            bean.setEntityContext(new EntityContextWrapper(oPrimaryKey));
            bean.ejbPostCreate(strNOM_PRO_SAN, strDES_PRO_SAN, lCOD_AZL, alAziende);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        ProtocoleSanitareBean iProtocoleSanitareBean = new ProtocoleSanitareBean();
        try {
            Object obj = iProtocoleSanitareBean.ejbFindByPrimaryKey((ProtocoleSanitarePK) primaryKey);
            iProtocoleSanitareBean.setEntityContext(new EntityContextWrapper(obj));
            iProtocoleSanitareBean.ejbActivate();
            iProtocoleSanitareBean.ejbLoad();
            iProtocoleSanitareBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    //---

    public void remove(Object primaryKey, java.util.ArrayList alAziende) {
        ProtocoleSanitareBean iProtocoleSanitareBean = new ProtocoleSanitareBean();
        try {
            Object obj = iProtocoleSanitareBean.ejbFindByPrimaryKey((ProtocoleSanitarePK) primaryKey);
            iProtocoleSanitareBean.setEntityContext(new EntityContextWrapper(obj));
            iProtocoleSanitareBean.ejbActivate();
            iProtocoleSanitareBean.ejbLoad();
            iProtocoleSanitareBean.ejbRemove(alAziende);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IProtocoleSanitare findByPrimaryKey(ProtocoleSanitarePK primaryKey) throws FinderException {
        ProtocoleSanitareBean bean = new ProtocoleSanitareBean();
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

    // (Home Intrface) VIEWS  getProtocoleSanitare_Name_Address_View(long lCOD_AZL)
    public Collection getProtocoleSanitare_Name_Address_View(long lCOD_AZL) {
        return (new ProtocoleSanitareBean()).ejbGetProtocoleSanitare_Name_Address_View(lCOD_AZL);
    }


    // (Home Intrface) VIEWS  getDomandeByPROSANID_View()
    public Collection getDocumenteSanitareByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID) {
        return (new ProtocoleSanitareBean()).ejbGetDocumenteSanitareByPROSANID_View(lCOD_AZL, PRO_SAN_ID);
    }

    public Collection getVisiteIdoneiteByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID) {
        return (new ProtocoleSanitareBean()).ejbGetVisiteIdoneiteByPROSANID_View(lCOD_AZL, PRO_SAN_ID);
    }

    public Collection getVisiteMedicheByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID) {
        return (new ProtocoleSanitareBean()).ejbGetVisiteMedicheByPROSANID_View(lCOD_AZL, PRO_SAN_ID);
    }

    public Collection getProtocoleSanitare_CRM_PRO_SAN_View(String strNOM, long lCOD_AZL) {
        return (new ProtocoleSanitareBean()).ejbGetProtocoleSanitare_CRM_PRO_SAN_View(strNOM, lCOD_AZL);
    }

    public boolean caricaDbProtocolli(long P_COD_AZL, long P_COD_PRO_SAN) {
        ProtocoleSanitareBean bean = new ProtocoleSanitareBean();
        return bean.ejbCaricaDbProtocolli(P_COD_AZL, P_COD_PRO_SAN);
    }

    public boolean caricaRpProtocolli(long P_COD_AZL, String P_NOM_PRO_SAN) {
        ProtocoleSanitareBean bean = new ProtocoleSanitareBean();
        return bean.ejbCaricaRpProtocolli(P_COD_AZL, P_NOM_PRO_SAN);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IProtocoleSanitareHome-implementation>
    public ProtocoleSanitarePK ejbCreate(
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            long lCOD_AZL,
            java.util.ArrayList alAziende) {
        long lFirstKey = NEW_ID();
        this.COD_PRO_SAN = NEW_ID();		// unic ID
        this.NOM_PRO_SAN = strNOM_PRO_SAN;
        this.DES_PRO_SAN = strDES_PRO_SAN;
        this.COD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            bmp.beginTrans();
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_pro_san_tab (cod_pro_san, nom_pro_san,des_pro_san, cod_azl) VALUES (?, ?, ?, ?)");
            ps.setLong(1, COD_PRO_SAN);
            ps.setString(2, NOM_PRO_SAN);
            ps.setString(3, DES_PRO_SAN);
            ps.setLong(4, COD_AZL);
            ps.executeUpdate();
            setExtendedObject(bmp, "ana_pro_san_tab", lFirstKey, COD_PRO_SAN, COD_AZL);

            Iterator it = alAziende.iterator();
            while (it.hasNext()) {
                long cod_azl = ((Long) it.next()).longValue();
                if (cod_azl == lCOD_AZL) {
                    continue;
                }
                long lSecondKey = NEW_ID();
                ps.setLong(1, lSecondKey);
                ps.setLong(4, cod_azl);
                ps.executeUpdate();
                setExtendedObject(bmp, "ana_pro_san_tab", lFirstKey, lSecondKey, cod_azl);
            }
            bmp.commitTrans();
            return new ProtocoleSanitarePK(this.COD_AZL, this.COD_PRO_SAN);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------

    public void ejbPostCreate(
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            long lCOD_AZL,
            java.util.ArrayList alAziende) {
    }
//--------------------------------------------------

    public boolean isMultiple() {
        return isExtendedObject("ana_pro_san_tab", COD_PRO_SAN);
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pro_san FROM ana_pro_san_tab ");
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

    public ProtocoleSanitarePK ejbFindByPrimaryKey(ProtocoleSanitarePK primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.primaryKey = ((ProtocoleSanitarePK) this.getEntityKey());
        this.COD_PRO_SAN = primaryKey.lCOD_PRO_SAN;
        this.COD_AZL = primaryKey.lCOD_AZL;
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_PRO_SAN = -1;
        this.primaryKey = null;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT * FROM ana_pro_san_tab  WHERE cod_pro_san=? AND cod_azl=?");
            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, COD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_PRO_SAN = rs.getLong("COD_PRO_SAN");
                this.NOM_PRO_SAN = rs.getString("NOM_PRO_SAN");
                this.DES_PRO_SAN = rs.getString("DES_PRO_SAN");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_PRO_SAN_RPO = rs.getLong("COD_PRO_SAN_RPO");
            } else {
                throw new NoSuchEntityException("ProtocoleSanitare con ID=" + COD_PRO_SAN + " non è trovata");
            }
        } catch (Exception ex) {
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
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM ana_pro_san_tab  WHERE (cod_pro_san=? OR cod_pro_san IN (" + getExtendedObjects("ana_pro_san_tab", alAziende) + ") ) AND( cod_azl=? OR cod_azl IN (" + toString(alAziende) + "))");

            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, COD_PRO_SAN);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ProtocoleSanitare con ID=" + COD_PRO_SAN + " non è trovata");
            }

            removeExtendedObject(bmp, "ana_pro_san_tab", COD_PRO_SAN, COD_AZL, alAziende);
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
        store(NOM_PRO_SAN, DES_PRO_SAN, COD_PRO_SAN_RPO, null);
    }

    public void store(String strNOM_PRO_SAN, String strDES_PRO_SAN, long lCOD_PRO_SAN_RPO, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE ana_pro_san_tab  SET nom_pro_san=?, des_pro_san=?, cod_pro_san_rpo=? WHERE (cod_pro_san=? OR cod_pro_san IN (" + getExtendedObjects("ana_pro_san_tab", alAziende) + ") ) AND(cod_azl=? OR cod_azl IN (" + toString(alAziende) + ") )");
            ps.setString(1, strNOM_PRO_SAN);
            ps.setString(2, strDES_PRO_SAN);
            ps.setLong(3, lCOD_PRO_SAN_RPO);
            ps.setLong(4, COD_PRO_SAN);

            ps.setLong(5, COD_PRO_SAN);

            ps.setLong(6, COD_AZL);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ProtocoleSanitare con ID=" + COD_PRO_SAN + " non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="setter/getters">
    // COD_PRO_SAN
    public void setCOD_PRO_SAN(long newCOD_PRO_SAN) {
        COD_PRO_SAN = newCOD_PRO_SAN;
        setModified();
    }

    public long getCOD_PRO_SAN() {
        return COD_PRO_SAN;
    }
    // NOM_PRO_SAN

    public void setNOM_PRO_SAN__COD_AZL(String newNOM_PRO_SAN, long newCOD_AZL) {
        if (NOM_PRO_SAN != null) {
            if (NOM_PRO_SAN.equals(newNOM_PRO_SAN) && (COD_AZL == newCOD_AZL)) {
                return;
            }
        }
        NOM_PRO_SAN = newNOM_PRO_SAN;
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public String getNOM_PRO_SAN() {
        return NOM_PRO_SAN;
    }
    // DES_PRO_SAN

    public void setDES_PRO_SAN(String newDES_PRO_SAN) {
        if (DES_PRO_SAN != null) {
            if (DES_PRO_SAN.equals(newDES_PRO_SAN)) {
                return;
            }
        }
        DES_PRO_SAN = newDES_PRO_SAN;
        setModified();
    }

    public String getDES_PRO_SAN() {
        return DES_PRO_SAN;
    }
    // COD_AZL

    public long getCOD_AZL() {
        return COD_AZL;
    }
    // COD_PRO_SAN_RPO

    public void setCOD_PRO_SAN_RPO(long newCOD_PRO_SAN_RPO) {
        COD_PRO_SAN_RPO = newCOD_PRO_SAN_RPO;
        setModified();
    }

    public long getCOD_PRO_SAN_RPO() {
        return COD_PRO_SAN_RPO;
    }
    //</comment>

    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //--- select from domande
    public Collection ejbGetProtocoleSanitare_Name_Address_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pro_san,nom_pro_san,des_pro_san FROM ana_pro_san_tab WHERE COD_AZL=? ORDER BY nom_pro_san ");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ProtocoleSanitare_Name_Address_View obj = new ProtocoleSanitare_Name_Address_View();
                obj.COD_PRO_SAN = rs.getLong(1);
                obj.NOM_PRO_SAN = rs.getString(2);
                obj.DES_PRO_SAN = rs.getString(3);
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

    public Collection ejbGetDocumenteSanitareByPROSANID_View(long lCOD_AZL, long COD_PRO_SAN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT doc_pro_san_tab.cod_doc, ana_doc_tab.tit_doc, ana_doc_tab.rsp_doc, ana_doc_tab.dat_rev_doc FROM ana_doc_tab, doc_pro_san_tab WHERE ana_doc_tab.cod_doc = doc_pro_san_tab.cod_doc AND  doc_pro_san_tab.cod_pro_san=? AND ana_doc_tab.cod_azl=? ORDER BY tit_doc");
            ps.setLong(1, COD_PRO_SAN_ID);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DocumenteSanitareByPROSANID_View obj = new DocumenteSanitareByPROSANID_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                obj.RSP_DOC = rs.getString(3);
                obj.DAT_REV_DOC = rs.getDate(4);
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
//-----

    public Collection ejbGetVisiteIdoneiteByPROSANID_View(long lCOD_AZL, long COD_PRO_SAN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT vst_ido_pro_san_tab.cod_vst_ido, ana_vst_ido_tab.nom_vst_ido, ana_vst_ido_tab.des_vst_ido, ana_vst_ido_tab.per_vst, ana_vst_ido_tab.fat_per FROM ana_vst_ido_tab, vst_ido_pro_san_tab WHERE ana_vst_ido_tab.cod_vst_ido = vst_ido_pro_san_tab.cod_vst_ido AND  vst_ido_pro_san_tab.cod_pro_san=? AND ana_vst_ido_tab.cod_azl=? ORDER BY nom_vst_ido");
            ps.setLong(1, COD_PRO_SAN_ID);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteIdoneiteByPROSANID_View obj = new VisiteIdoneiteByPROSANID_View();
                obj.COD_VST_IDO = rs.getLong(1);
                obj.NOM_VST_IDO = rs.getString(2);
                obj.DES_VST_IDO = rs.getString(3);
                obj.PER_VST = rs.getLong(4);
                obj.FAT_PER = rs.getString(5);
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

    public Collection ejbGetVisiteMedicheByPROSANID_View(long lCOD_AZL, long COD_PRO_SAN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT vst_med_pro_san_tab.cod_vst_med, " + " ana_vst_med_tab.nom_vst_med, " + " ana_vst_med_tab.des_vst_med, " + " ana_vst_med_tab.per_vst, " + "ana_vst_med_tab.fat_per " + " FROM ana_vst_med_tab, vst_med_pro_san_tab " + " WHERE ana_vst_med_tab.cod_vst_med = vst_med_pro_san_tab.cod_vst_med " + " AND  vst_med_pro_san_tab.cod_pro_san=? AND ana_vst_med_tab.cod_azl=? ORDER BY nom_vst_med");
            ps.setLong(1, COD_PRO_SAN_ID);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteMedicheByPROSANID_View obj = new VisiteMedicheByPROSANID_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DES_VST_MED = rs.getString(3);
                obj.PER_VST = rs.getLong(4);
                obj.FAT_PER = rs.getString(5);
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

    public void removeLUO_FSC_PRO_SAN() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM pro_san_luo_fsc_tab  WHERE cod_pro_san=? ");
            ps.setLong(1, COD_PRO_SAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeGEST_MAN_PRO_SAN() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM pro_san_man_tab WHERE cod_pro_san=? ");
            ps.setLong(1, COD_PRO_SAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //------#############################################
    public void addDocumento(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO doc_pro_san_tab (cod_pro_san, cod_doc) VALUES(?,?)");
            ps.setLong(1, COD_PRO_SAN);
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
                    "DELETE FROM doc_pro_san_tab WHERE cod_pro_san=? AND cod_doc=?");
            ps.setLong(1, COD_PRO_SAN);
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

    public void addIdoneta(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO vst_ido_pro_san_tab (cod_pro_san, cod_vst_ido) " + " VALUES(?,?)");
            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, l);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------

    public void removeIdoneta(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM vst_ido_pro_san_tab " + " WHERE cod_pro_san=? AND cod_vst_ido=?");
            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, l);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Idoneta with ID=" + l + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addMediche(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO vst_med_pro_san_tab (cod_pro_san, cod_vst_med) " + " VALUES(?,?)");
            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, l);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //----------------------------------------------------

    public void removeMediche(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM vst_med_pro_san_tab " + " WHERE cod_pro_san=? AND cod_vst_med=?");
            ps.setLong(1, COD_PRO_SAN);
            ps.setLong(2, l);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Mediche with ID=" + l + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<comment description="extended setters/getters">

    //--- by Juli
    public Collection ejbGetProtocoleSanitare_CRM_PRO_SAN_View(String strNOM, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_pro_san, a.nom_pro_san, a.des_pro_san, (SELECT COUNT(*) FROM ana_pro_san_tab b WHERE (b.cod_pro_san_rpo=a.cod_pro_san or a.nom_pro_san = b.nom_pro_san)) FROM ana_pro_san_tab_r a WHERE a.nom_pro_san LIKE ?  ");
            ps.setString(1, strNOM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ProtocoleSanitare_CRM_PRO_SAN_View v = new ProtocoleSanitare_CRM_PRO_SAN_View();
                v.lCOD_PRO_SAN = rs.getLong(1);
                v.strNOM_PRO_SAN = rs.getString(2);
                v.strDES_PRO_SAN = rs.getString(3);
                v.ISRED = rs.getLong(4);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        //throw new EJBException(query+" '"+strNOM+"'");
        } finally {
            bmp.close();
        }
    }

//--- by Juli
//===========================================================
    public boolean ejbCaricaDbProtocolli(long P_COD_AZL, long P_COD_PRO_SAN) {
        boolean result = true;
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps_pro_san_rso_cnt = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++
            long conta;
            long V_COD_PRO_SAN = NEW_ID();
            long flag_esistenza;
            //----controllo se già esiste il record sulla tabella ana_pro_san_tab del db
            ps_pro_san_rso_cnt = bmp.prepareStatement("select count(*) from ana_pro_san_tab where cod_azl = ? and cod_pro_san_rpo= ?");
            ps_pro_san_rso_cnt.setLong(1, P_COD_AZL);
            ps_pro_san_rso_cnt.setLong(2, P_COD_PRO_SAN);
            rs = ps_pro_san_rso_cnt.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
            }
            //---se non esiste lo inserisco prendendolo dal repository
            if (flag_esistenza == 0) {
                PreparedStatement ps_pro_san_rso_0 = bmp.prepareStatement("INSERT INTO ana_pro_san_tab(cod_pro_san, nom_pro_san, des_pro_san, cod_azl, cod_pro_san_rpo) SELECT ?, nom_pro_san, des_pro_san, ?, cod_pro_san FROM ana_pro_san_tab_r WHERE cod_pro_san = ?");
                long cod_pro_san = 0;
                ps_pro_san_rso_0.setLong(1, V_COD_PRO_SAN);
                ps_pro_san_rso_0.setLong(2, P_COD_AZL);
                ps_pro_san_rso_0.setLong(3, P_COD_PRO_SAN);
                ps_pro_san_rso_0.executeUpdate();
                ps_pro_san_rso_0.clearParameters();
                ps_pro_san_rso_0.close();
                //------verifico se già esistono i record sulla tabella ana_vst_ido_tab del db
                //------andando a controllare sulle associative del repository le visite
                //------associate al protocollo sanitario
                PreparedStatement ps_vst_ido = bmp.prepareStatement("SELECT cod_vst_ido FROM vst_ido_pro_san_tab_r WHERE cod_pro_san = ?");
                ps_vst_ido.setLong(1, P_COD_PRO_SAN);
                ResultSet x = ps_vst_ido.executeQuery();

                PreparedStatement ps_vst_ido_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_rpo = ?");
                PreparedStatement ps_vst_ido_0 = bmp.prepareStatement("INSERT INTO ana_vst_ido_tab SELECT ?, fat_per, per_vst, nom_vst_ido, des_vst_ido, ?, cod_vst_ido FROM ana_vst_ido_tab_r WHERE cod_vst_ido = ?");
                PreparedStatement ps_vst_ido_1 = bmp.prepareStatement("INSERT INTO vst_ido_pro_san_tab(cod_pro_san,cod_vst_ido) VALUES(?,?)");
                PreparedStatement ps_vst_ido_2 = bmp.prepareStatement("SELECT cod_vst_ido FROM ana_vst_ido_tab WHERE cod_azl = ? AND cod_vst_ido_rpo = ?");
                long cod_vst_ido = 0;
                while (x.next()) {
                    ps_vst_ido_cnt.setLong(1, P_COD_AZL);
                    ps_vst_ido_cnt.setLong(2, x.getLong(1));
                    ResultSet rs_vst_ido_cnt = ps_vst_ido_cnt.executeQuery();
                    rs_vst_ido_cnt.next();
                    long V_COD_VST_IDO = NEW_ID() + (cod_vst_ido++);
                    if (rs_vst_ido_cnt.getLong(1) == 0) {
                        ps_vst_ido_0.setLong(1, V_COD_VST_IDO);
                        ps_vst_ido_0.setLong(2, P_COD_AZL);
                        ps_vst_ido_0.setLong(3, x.getLong(1));
                        ps_vst_ido_1.setLong(1, V_COD_PRO_SAN);
                        ps_vst_ido_1.setLong(2, V_COD_VST_IDO);
                        ps_vst_ido_0.executeUpdate();
                        ps_vst_ido_1.executeUpdate();
                        ps_vst_ido_0.clearParameters();
                        ps_vst_ido_1.clearParameters();
                    } else {
                        ps_vst_ido_2.setLong(1, P_COD_AZL);
                        ps_vst_ido_2.setLong(2, x.getLong(1));
                        ResultSet rs_vst_ido_2 = ps_vst_ido_2.executeQuery();
                        rs_vst_ido_2.next();
                        ps_vst_ido_1.setLong(1, V_COD_PRO_SAN);
                        ps_vst_ido_1.setLong(2, rs_vst_ido_2.getLong(1));
                        ps_vst_ido_1.executeUpdate();
                        ps_vst_ido_1.clearParameters();
                        ps_vst_ido_2.clearParameters();
                    }
                    rs_vst_ido_cnt.close();
                }

                //------verifico se già esistono i record sulla tabella ana_vst_med_tab del db
                //------andando a controllare sulle associative del repository le visite mediche
                //------associate al protocollo sanitario

                PreparedStatement ps_vst_med = bmp.prepareStatement("SELECT cod_vst_med FROM vst_med_pro_san_tab_r WHERE cod_pro_san = ?");
                ps_vst_med.setLong(1, P_COD_PRO_SAN);
                ResultSet y = ps_vst_med.executeQuery();
                PreparedStatement ps_vst_med_cnt = bmp.prepareStatement("SELECT count(*) FROM ana_vst_med_tab WHERE cod_azl = ? AND cod_vst_med_rpo = ?");
                PreparedStatement ps_vst_med_0 = bmp.prepareStatement("INSERT INTO ana_vst_med_tab SELECT ?, fat_per, per_vst, nom_vst_med, des_vst_med, ?, cod_vst_med FROM ana_vst_med_tab_r WHERE cod_vst_med = ?");
                PreparedStatement ps_vst_med_1 = bmp.prepareStatement("INSERT INTO vst_med_pro_san_tab VALUES(?,?)");
                PreparedStatement ps_vst_med_2 = bmp.prepareStatement("SELECT cod_vst_med FROM ana_vst_med_tab WHERE cod_azl = ? AND cod_vst_med_rpo = ?");
                long cod_vst_med = 0;
                while (y.next()) {
                    ps_vst_med_cnt.setLong(1, P_COD_AZL);
                    ps_vst_med_cnt.setLong(2, y.getLong(1));
                    ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                    rs_vst_med_cnt.next();
                    long V_COD_VST_MED = NEW_ID() + (cod_vst_med++);
                    if (rs_vst_med_cnt.getLong(1) == 0) {
                        ps_vst_med_0.setLong(1, V_COD_VST_MED);
                        ps_vst_med_0.setLong(2, P_COD_AZL);
                        ps_vst_med_0.setLong(3, y.getLong(1));
                        ps_vst_med_1.setLong(1, V_COD_PRO_SAN);
                        ps_vst_med_1.setLong(2, V_COD_VST_MED);
                        ps_vst_med_0.executeUpdate();
                        ps_vst_med_1.executeUpdate();
                        ps_vst_med_0.clearParameters();
                        ps_vst_med_1.clearParameters();
                    } else {
                        ps_vst_med_2.setLong(1, P_COD_AZL);
                        ps_vst_med_2.setLong(2, y.getLong(1));
                        ResultSet rs_vst_med_2 = ps_vst_med_2.executeQuery();
                        rs_vst_med_2.next();
                        ps_vst_med_1.setLong(1, V_COD_PRO_SAN);
                        ps_vst_med_1.setLong(2, rs_vst_med_2.getLong(1));
                        ps_vst_med_1.executeUpdate();
                        ps_vst_med_1.clearParameters();
                        ps_vst_med_2.clearParameters();
                    }
                    rs_vst_med_cnt.close();
                    ps_pro_san_rso_cnt.close();
                }
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

    public boolean ejbCaricaRpProtocolli(long P_COD_AZL, String P_NOM_PRO_SAN) {
        boolean result = true;
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        PreparedStatement ps_pro_san_rso_cnt = null;
        try {
            conn.setAutoCommit(false);
            //++++++++++++++++++++++++++++++++++++++++++++++
            long conta;
            long v_cod_pro_san = NEW_ID();
            long p_cod_pro_san = 0;
            long flag_esistenza;
            ps_pro_san_rso_cnt = bmp.prepareStatement("select count(*) from ana_pro_san_tab_r where nom_pro_san= ?");
            ps_pro_san_rso_cnt.setString(1, P_NOM_PRO_SAN);
            rs = ps_pro_san_rso_cnt.executeQuery();
            if (!rs.next()) {
                throw new EJBException("DB error");
            } else {
                flag_esistenza = rs.getLong(1);
                rs.close();
                ps_pro_san_rso_cnt.close();
            }
//
            PreparedStatement ps_pro_san_cod = bmp.prepareStatement("SELECT cod_pro_san FROM ana_pro_san_tab WHERE nom_pro_san = ? AND cod_azl = ?");
            ps_pro_san_cod.setString(1, P_NOM_PRO_SAN);
            ps_pro_san_cod.setLong(2, P_COD_AZL);
            ResultSet rs_pro_san_cod = ps_pro_san_cod.executeQuery();
            rs_pro_san_cod.next();
            p_cod_pro_san = rs_pro_san_cod.getLong(1);
            if (flag_esistenza == 0) {
                long cod_pro_san = 0;
                PreparedStatement ps_pro_san_0 = bmp.prepareStatement("INSERT INTO ana_pro_san_tab_r (cod_pro_san, nom_pro_san, des_pro_san) SELECT ?, nom_pro_san, des_pro_san FROM ana_pro_san_tab WHERE cod_pro_san = ? AND cod_azl = ?");
                PreparedStatement ps_pro_san_1 = bmp.prepareStatement("UPDATE ana_pro_san_tab SET cod_pro_san_rpo = ? WHERE cod_pro_san = ?");
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
                ps_pro_san_0.setLong(1, v_cod_pro_san);
                ps_pro_san_0.setLong(2, p_cod_pro_san);
                ps_pro_san_0.setLong(3, P_COD_AZL);
                ps_pro_san_0.executeUpdate();
                ps_pro_san_1.setLong(1, v_cod_pro_san);
                ps_pro_san_1.setLong(2, p_cod_pro_san);
                ps_pro_san_1.executeUpdate();
                ps_pro_san_0.clearParameters();
                ps_pro_san_1.clearParameters();
                ps_vst_ido.setLong(1, p_cod_pro_san);
                ResultSet x = ps_vst_ido.executeQuery();
                while (x.next()) {
                    ps_vst_ido_cnt.setLong(1, x.getLong(1));
                    ResultSet rs_vst_ido_cnt = ps_vst_ido_cnt.executeQuery();
                    rs_vst_ido_cnt.next();
                    if (rs_vst_ido_cnt.getLong(1) == 0) {
                        long v_cod_vst_ido = NEW_ID();
                        ps_vst_ido_2.setLong(1, v_cod_vst_ido);
                        ps_vst_ido_2.setLong(2, x.getLong(1));
                        ps_vst_ido_2.setLong(3, P_COD_AZL);
                        ps_vst_ido_3.setLong(1, v_cod_vst_ido);
                        ps_vst_ido_3.setLong(2, x.getLong(1));
                        ps_vst_ido_0.setLong(1, v_cod_pro_san);
                        ps_vst_ido_0.setLong(2, v_cod_vst_ido);
                        ps_vst_ido_2.executeUpdate();
                        ps_vst_ido_3.executeUpdate();
                        ps_vst_ido_0.executeUpdate();
                    } else {
                        ps_vst_ido_1.setLong(1, x.getLong(1));
                        ResultSet rs_vst_ido_1 = ps_vst_ido_1.executeQuery();
                        rs_vst_ido_1.next();
                        long v_cod_vst_ido = rs_vst_ido_1.getLong(1);
                        ps_vst_ido_0.setLong(1, v_cod_pro_san);
                        ps_vst_ido_0.setLong(2, v_cod_vst_ido);
                        try {
                            ps_vst_ido_0.executeUpdate();
                        } catch (Exception ex) {
                        }
                    }
                }
                ps_vst_med.setLong(1, p_cod_pro_san);
                ResultSet y = ps_vst_med.executeQuery();
                while (y.next()) {
                    ps_vst_med_cnt.setLong(1, y.getLong(1));
                    ResultSet rs_vst_med_cnt = ps_vst_med_cnt.executeQuery();
                    rs_vst_med_cnt.next();
                    if (rs_vst_med_cnt.getLong(1) == 0) {
                        long v_cod_vst_med = NEW_ID();
                        ps_vst_med_2.setLong(1, v_cod_vst_med);
                        ps_vst_med_2.setLong(2, y.getLong(1));
                        ps_vst_med_2.setLong(3, P_COD_AZL);
                        ps_vst_med_3.setLong(1, v_cod_vst_med);
                        ps_vst_med_3.setLong(2, y.getLong(1));
                        ps_vst_med_0.setLong(1, v_cod_pro_san);
                        ps_vst_med_0.setLong(2, v_cod_vst_med);
                        ps_vst_med_2.executeUpdate();
                        ps_vst_med_3.executeUpdate();
                        ps_vst_med_0.executeUpdate();
                    } else {
                        ps_vst_med_1.setLong(1, y.getLong(1));
                        ResultSet rs_vst_med_1 = ps_vst_med_1.executeQuery();
                        rs_vst_med_1.next();
                        long v_cod_vst_med = rs_vst_med_1.getLong(1);
                        ps_vst_med_0.setLong(1, v_cod_pro_san);
                        ps_vst_med_0.setLong(2, v_cod_vst_med);
                        try {
                            ps_vst_med_0.executeUpdate();
                        } catch (Exception ex) {
                        }
                    }
                }
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

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            int iOrderParameter /*not used for now*/) {
        return (new ProtocoleSanitareBean()).ejbFindEx(
                lCOD_AZL,
                strNOM_PRO_SAN,
                strDES_PRO_SAN,
                iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            int iOrderParameter /*not used for now*/) {
        String strSql = "SELECT cod_pro_san, nom_pro_san, des_pro_san FROM ana_pro_san_tab WHERE cod_azl=? ";
        if (strNOM_PRO_SAN != null) {
            strSql += " AND UPPER(nom_pro_san) LIKE ?";
        }
        if (strDES_PRO_SAN != null) {
            strSql += " AND UPPER(des_pro_san) LIKE ?";
        }
        strSql += " ORDER BY UPPER(nom_pro_san)";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);
            if (strNOM_PRO_SAN != null) {
                ps.setString(i++, strNOM_PRO_SAN.toUpperCase());
            }
            if (strDES_PRO_SAN != null) {
                ps.setString(i++, strDES_PRO_SAN.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ProtocoleSanitare_Name_Address_View obj = new ProtocoleSanitare_Name_Address_View();
                obj.COD_PRO_SAN = rs.getLong(1);
                obj.NOM_PRO_SAN = rs.getString(2);
                obj.DES_PRO_SAN = rs.getString(3);
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
