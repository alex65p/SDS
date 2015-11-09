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
package com.apconsulting.luna.ejb.AttivitaSegnalazione;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import java.sql.Date;

/**
 *
 * @author Alessandro
 */
public class AttivitaSegnalazioneBean extends BMPEntityBean implements IAttivitaSegnalazione, IAttivitaSegnalazioneHome {
    //< member-varibles description="Member Variables">

    long lCOD_ATI_SGZ;
    String strDES_ATI_SGZ;
    Date dtDAT_SCA;
    Date dtDAT_VER;
    float fRIS;
    Date dtDAT_ATT;
    String strVER_DA;
    long lCOD_SGZ;
    long lCOD_DPD;
    long lCOD_AZL;
    
    //< /member-varibles>
    //< IAttivitaSegnalazioneHome-implementation>
    public static final String BEAN_NAME = "AttivitaSegnalazioneBean";
    private static AttivitaSegnalazioneBean ys = null;

    private AttivitaSegnalazioneBean() {
        //System.err.println("AgenteMaterialeBean constructor<br>");
    }

    public static AttivitaSegnalazioneBean getInstance() {
        if (ys == null) {
            ys = new AttivitaSegnalazioneBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        AttivitaSegnalazioneBean bean = new AttivitaSegnalazioneBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }
    //

    public IAttivitaSegnalazione create(String strDES_ATI_SGZ, Date dtDAT_SCA, long lCOD_SGZ, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
        AttivitaSegnalazioneBean bean = new AttivitaSegnalazioneBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_ATI_SGZ, dtDAT_SCA, lCOD_SGZ, lCOD_DPD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_ATI_SGZ, dtDAT_SCA, lCOD_SGZ, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    //

    public IAttivitaSegnalazione findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        AttivitaSegnalazioneBean bean = new AttivitaSegnalazioneBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //

    public Long ejbCreate(String strDES_ATI_SGZ, Date dtDAT_SCA, long lCOD_SGZ, long lCOD_DPD, long lCOD_AZL) {
        this.lCOD_ATI_SGZ = NEW_ID();
        this.strDES_ATI_SGZ = strDES_ATI_SGZ;
        this.dtDAT_SCA = dtDAT_SCA;
        this.lCOD_SGZ = lCOD_SGZ;
        this.lCOD_DPD = lCOD_DPD;
        this.lCOD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_ati_sgz_tab (cod_ati_sgz,des_ati_sgz,dat_sca,cod_sgz,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?)");
            ps.setLong(1, lCOD_ATI_SGZ);
            ps.setString(2, strDES_ATI_SGZ);
            ps.setDate(3, dtDAT_SCA);
            ps.setLong(4, lCOD_SGZ);
            ps.setLong(5, lCOD_DPD);
            ps.setLong(6, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_ATI_SGZ);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strDES_ATI_SGZ, Date dtDAT_SCA, long lCOD_SGZ, long lCOD_DPD, long lCOD_AZL) {
    }
    /////<VIEWS>
    //----------add by Podmasteriev

    public Collection getAnagraficaDocumenti_List_ID_View(long lCOD_SGZ) {
        return (new AttivitaSegnalazioneBean()).ejbGetAnagraficaDocumenti_List_ID_View(lCOD_SGZ);
    }
    
    public Collection getMisure_View(long COD_ATI_SGZ) {
        return (new AttivitaSegnalazioneBean()).ejbGetMisure_View(COD_ATI_SGZ);
    }
    
    //------------------
    /////<VIEWS>

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ati_sgz FROM ana_ati_sgz_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_ATI_SGZ = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_ATI_SGZ = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT "
                        + "cod_ati_sgz, "
                        + "des_ati_sgz, "
                        + "dat_sca, "
                        + "dat_ver, "
                        + "ris, "
                        + "dat_att, "
                        + "ver_da, "
                        + "cod_sgz, "
                        + "cod_dpd, "
                        + "cod_azl "
                    + "FROM "
                        + "ana_ati_sgz_tab "
                    + "WHERE "
                        + "cod_ati_sgz=?");
            ps.setLong(1, lCOD_ATI_SGZ);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_ATI_SGZ = rs.getLong(1);
                strDES_ATI_SGZ = rs.getString(2);
                dtDAT_SCA = rs.getDate(3);
                dtDAT_VER = rs.getDate(4);
                fRIS = rs.getFloat(5);
                dtDAT_ATT = rs.getDate(6);
                strVER_DA = rs.getString(7);
                lCOD_SGZ = rs.getLong(8);
                lCOD_DPD = rs.getLong(9);
                lCOD_AZL = rs.getLong(10);
            } else {
                throw new NoSuchEntityException("AttivitaSegnalazione with ID=" + lCOD_ATI_SGZ + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ati_sgz_tab WHERE cod_ati_sgz=?");
            ps.setLong(1, lCOD_ATI_SGZ);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivitaSegnalazione with ID=" + lCOD_ATI_SGZ + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE "
                        + "ana_ati_sgz_tab "
                    + "SET "
                        + "des_ati_sgz=?, "
                        + "dat_sca=?, "
                        + "dat_ver=?, "
                        + "ris=?, "
                        + "dat_att=?, "
                        + "ver_da=?, "
                        + "cod_sgz=?, "
                        + "cod_dpd=?, "
                        + "cod_azl=? "
                    + "WHERE "
                        + "cod_ati_sgz=?");
            ps.setString(1, strDES_ATI_SGZ);
            ps.setDate(2, dtDAT_SCA);
            ps.setDate(3, dtDAT_VER);
            ps.setFloat(4, fRIS);
            ps.setDate(5, dtDAT_ATT);
            ps.setString(6, strVER_DA);
            ps.setLong(7, lCOD_SGZ);
            ps.setLong(8, lCOD_DPD);
            ps.setLong(9, lCOD_AZL);
            ps.setLong(10, lCOD_ATI_SGZ);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivitaSegnalazione with ID=" + lCOD_ATI_SGZ + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //< setter-getters>
    public long getCOD_ATI_SGZ() {
        return lCOD_ATI_SGZ;
    }

    public String getDES_ATI_SGZ() {
        return strDES_ATI_SGZ;
    }

    public void setDES_ATI_SGZ(String strDES_ATI_SGZ) {
        if ((this.strDES_ATI_SGZ != null) && (this.strDES_ATI_SGZ.equals(strDES_ATI_SGZ))) {
            return;
        }
        this.strDES_ATI_SGZ = strDES_ATI_SGZ;
        setModified();
    }

    public Date getDAT_SCA() {
        return dtDAT_SCA;
    }

    public void setDAT_SCA(Date dtDAT_SCA) {
        if ((this.dtDAT_SCA != null) && (this.dtDAT_SCA.equals(dtDAT_SCA))) {
            return;
        }
        this.dtDAT_SCA = dtDAT_SCA;
        setModified();
    }

    public Date getDAT_VER() {
        return dtDAT_VER;
    }

    public void setDAT_VER(Date dtDAT_VER) {
        if ((this.dtDAT_VER != null) && (this.dtDAT_VER.equals(dtDAT_VER))) {
            return;
        }
        this.dtDAT_VER = dtDAT_VER;
        setModified();
    }

    public float getRIS() {
        return fRIS;
    }

    public void setRIS(float fRIS) {
        if (this.fRIS == fRIS) {
            return;
        }
        this.fRIS = fRIS;
        setModified();
    }

    public Date getDAT_ATT() {
        return dtDAT_ATT;
    }

    public void setDAT_ATT(Date dtDAT_ATT) {
        if ((this.dtDAT_ATT != null) && (this.dtDAT_ATT.equals(dtDAT_ATT))) {
            return;
        }
        this.dtDAT_ATT = dtDAT_ATT;
        setModified();
    }

    public String getVER_DA() {
        return strVER_DA;
    }

    public void setVER_DA(String strVER_DA) {
        if ((this.strVER_DA != null) && (this.strVER_DA.equals(strVER_DA))) {
            return;
        }
        this.strVER_DA = strVER_DA;
        setModified();
    }
    
    public long getCOD_SGZ() {
        return lCOD_SGZ;
    }

    public void setCOD_SGZ(long lCOD_SGZ) {
        if (this.lCOD_SGZ == lCOD_SGZ) {
            return;
        }
        this.lCOD_SGZ = lCOD_SGZ;
        setModified();
    }

    public long getCOD_DPD() {
        return lCOD_DPD;
    }

    public void setCOD_DPD(long lCOD_DPD) {
        if (this.lCOD_DPD == lCOD_DPD) {
            return;
        }
        this.lCOD_DPD = lCOD_DPD;
        setModified();
    }

    public long getCOD_AZL() {
        return lCOD_AZL;
    }

    public void setCOD_AZL(long lCOD_AZL) {
        if (this.lCOD_AZL == lCOD_AZL) {
            return;
        }
        this.lCOD_AZL = lCOD_AZL;
        setModified();
    }

//-----------------------------#############################################---------
    // %%%Link%%% Table DOC_ATI_SGZ_TAB
    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_ati_sgz_tab (cod_doc,cod_ati_sgz) VALUES(?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_ATI_SGZ);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table DOC_ATI_SGZ_TAB

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ati_sgz_tab  WHERE cod_doc=? AND cod_ati_sgz=?");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_ATI_SGZ);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void addMisura(long COD_MIS_PET) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ati_sgz_mis_pet_tab "
                        + "(cod_ati_sgz,cod_mis_pet) "
                    + "VALUES "
                        + "(?,?)");
            ps.setLong(1, this.getCOD_ATI_SGZ());
            ps.setLong(2, COD_MIS_PET);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void removeMisura(long COD_MIS_PET) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "ati_sgz_mis_pet_tab "
                    + "WHERE "
                        + "cod_ati_sgz=? "
                        + "AND cod_mis_pet=?");
            ps.setLong(1, this.getCOD_ATI_SGZ());
            ps.setLong(2, COD_MIS_PET);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Impossibile eliminare la misura con ID " + COD_MIS_PET);
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
//-----------------------------#############################################--------

//---------------------------------added by Podmasteriev------------------------
    public Collection ejbGetAnagraficaDocumenti_List_ID_View(long lCOD_SGZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT doc.cod_doc, doc.rsp_doc, doc.dat_rev_doc, doc.tit_doc FROM ana_doc_tab doc,doc_ati_sgz_tab sgz WHERE  doc.cod_doc=sgz.cod_doc AND sgz.cod_ati_sgz=?");
            ps.setLong(1, lCOD_SGZ);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagraficaDocumenti_List_ID_View obj = new AnagraficaDocumenti_List_ID_View();
                obj.COD_DOC = rs.getLong(1);
                obj.RSP_DOC = rs.getString(2);
                obj.DAT_REV_DOC = rs.getDate(3);
                obj.TIT_DOC = rs.getString(4);
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
    
    public Collection ejbGetMisure_View(long COD_ATI_SGZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "mis_pet.cod_mis_pet, "
                        + "mis_pet.nom_mis_pet, "
                        + "mis_pet.des_mis_pet "
                    + "FROM "
                        + "ana_mis_pet_tab mis_pet, "
                        + "ati_sgz_mis_pet_tab ati_sgz_mis_pet "
                    + "WHERE "
                        + "mis_pet.cod_mis_pet=ati_sgz_mis_pet.cod_mis_pet "
                        + "AND ati_sgz_mis_pet.cod_ati_sgz=? "
                    + "order by "
                        + "mis_pet.nom_mis_pet");
            ps.setLong(1, COD_ATI_SGZ);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Misure_View obj = new Misure_View();
                obj.lCOD_MIS_PET = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.strDES_MIS_PET = rs.getString(3);
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
    
}
