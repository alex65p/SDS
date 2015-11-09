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
package com.apconsulting.luna.ejb.ValutazioneRischi;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPConnection.ConnectionType;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class ValutazioneRischiBean extends BMPEntityBean implements IValutazioneRischi, IValutazioneRischiHome {
    //<member-varibles description="Member Variables">

    long lCOD_DOC_VLU;
    java.sql.Date dtDAT_DOC_VLU;
    String strNOM_RSP_DOC;
    String strVER_DOC;
    long lCOD_AZL;
    long lCOD_UNI_ORG;
    //</member-varibles>
    //<IValutazioneRischiHome-implementation>
    public static final String BEAN_NAME = "ValutazioneRischiBean";
    private static ValutazioneRischiBean ys = null;

    private ValutazioneRischiBean() {
    }

    public static ValutazioneRischiBean getInstance() {
        if (ys == null) {
            ys = new ValutazioneRischiBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        ValutazioneRischiBean bean = new ValutazioneRischiBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public IValutazioneRischi create(java.sql.Date dtDAT_DOC_VLU, String strVER_DOC, long lCOD_AZL) throws javax.ejb.CreateException {
        ValutazioneRischiBean bean = new ValutazioneRischiBean();
        try {
            Object primaryKey = bean.ejbCreate(dtDAT_DOC_VLU, strVER_DOC, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(dtDAT_DOC_VLU, strVER_DOC, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IValutazioneRischi findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        ValutazioneRischiBean bean = new ValutazioneRischiBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //
    // (Home Intrface) VIEWS  getValutazioneRischiSezioniByID_View()

    public Collection getValutazioneRischiSezioniByID_View(long lCOD_DOC_VLU) {
        return (new ValutazioneRischiBean()).ejbGetValutazioneRischiSezioniByID_View(lCOD_DOC_VLU);
    }
    //

    public Collection getValutazioneRischiAllegati(long lCOD_DOC_VLU) {
        return (new ValutazioneRischiBean()).ejbGetValutazioneRischiAllegati(lCOD_DOC_VLU);
    }
    
    public long getAllegatiCount(long lCOD_DOC_VLU) {
        return (new ValutazioneRischiBean()).ejbGetAllegatiCount(lCOD_DOC_VLU);
    }

    public Collection getValutazioneRischiArchivio(long lCOD_DOC_VLU, long lCOD_AZL) {
        return (new ValutazioneRischiBean()).ejbGetValutazioneRischiArchivio(lCOD_DOC_VLU, lCOD_AZL);
    }
    //

    public Collection getValutazioneRischiSezioniNames_View(long lCOD_AZL) {
        return (new ValutazioneRischiBean()).ejbGetValutazioneRischiSezioniNames_View(lCOD_AZL);
    }

    public Collection findEx(long lCOD_AZL, java.sql.Date dtDAT_DOC_VLU, String strNOM_RSP_DOC, String strVER_DOC, long lCOD_UNI_ORG,
            int iOrderParameter /*not used for now*/) {
        return (new ValutazioneRischiBean()).ejbFindEx(lCOD_AZL, dtDAT_DOC_VLU, strNOM_RSP_DOC, strVER_DOC, lCOD_UNI_ORG, iOrderParameter);
    }

    public Long ejbCreate(java.sql.Date dtDAT_DOC_VLU, String strVER_DOC, long lCOD_AZL) {
        this.lCOD_DOC_VLU = NEW_ID();
        this.dtDAT_DOC_VLU = dtDAT_DOC_VLU;
        this.strVER_DOC = strVER_DOC;
        this.lCOD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_doc_vlu_tab (cod_doc_vlu,dat_doc_vlu,ver_doc,cod_azl) VALUES(?,?,?,?)");
            ps.setLong(1, lCOD_DOC_VLU);
            ps.setDate(2, dtDAT_DOC_VLU);
            ps.setString(3, strVER_DOC);
            ps.setLong(4, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_DOC_VLU);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(java.sql.Date dtDAT_DOC_VLU, String strVER_DOC, long lCOD_AZL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc_vlu FROM ana_doc_vlu_tab");
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

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_DOC_VLU = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_DOC_VLU = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc_vlu,dat_doc_vlu,nom_rsp_doc,ver_doc,cod_azl, cod_uni_org FROM ana_doc_vlu_tab WHERE cod_doc_vlu=?");
            ps.setLong(1, lCOD_DOC_VLU);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_DOC_VLU = rs.getLong(1);
                dtDAT_DOC_VLU = rs.getDate(2);
                strNOM_RSP_DOC = rs.getString(3);
                strVER_DOC = rs.getString(4);
                lCOD_AZL = rs.getLong(5);
                lCOD_UNI_ORG = rs.getLong(6);
            } else {
                throw new NoSuchEntityException("ValutazioneRischi with ID=" + lCOD_DOC_VLU + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_doc_vlu_tab WHERE cod_doc_vlu=?");
            ps.setLong(1, lCOD_DOC_VLU);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ValutazioneRischi with ID=" + lCOD_DOC_VLU + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_doc_vlu_tab SET cod_doc_vlu=?, dat_doc_vlu=?, nom_rsp_doc=?, ver_doc=?, cod_azl=?, cod_uni_org=? WHERE cod_doc_vlu=?");
            ps.setLong(1, lCOD_DOC_VLU);
            ps.setDate(2, dtDAT_DOC_VLU);
            ps.setString(3, strNOM_RSP_DOC);
            ps.setString(4, strVER_DOC);
            ps.setLong(5, lCOD_AZL);
            ps.setLong(6, lCOD_UNI_ORG);
            ps.setLong(7, lCOD_DOC_VLU);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ValutazioneRischi with ID=" + lCOD_DOC_VLU + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<setter-getters>
    public long getCOD_DOC_VLU() {
        return lCOD_DOC_VLU;
    }

    public java.sql.Date getDAT_DOC_VLU() {
        return dtDAT_DOC_VLU;
    }

    public void setDAT_DOC_VLU(java.sql.Date dtDAT_DOC_VLU) {
        if (this.dtDAT_DOC_VLU == dtDAT_DOC_VLU) {
            return;
        }
        this.dtDAT_DOC_VLU = dtDAT_DOC_VLU;
        setModified();
    }

    public String getNOM_RSP_DOC() {
        return strNOM_RSP_DOC;
    }

    public void setNOM_RSP_DOC(String strNOM_RSP_DOC) {
        if ((this.strNOM_RSP_DOC != null) && (this.strNOM_RSP_DOC.equals(strNOM_RSP_DOC))) {
            return;
        }
        this.strNOM_RSP_DOC = strNOM_RSP_DOC;
        setModified();
    }

    public String getVER_DOC() {
        return strVER_DOC;
    }

    public void setVER_DOC(String strVER_DOC) {
        if ((this.strVER_DOC != null) && (this.strVER_DOC.equals(strVER_DOC))) {
            return;
        }
        this.strVER_DOC = strVER_DOC;
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

    public long getCOD_UNI_ORG() {
        return lCOD_UNI_ORG;
    }

    public void setCOD_UNI_ORG(long lCOD_UNI_ORG) {
        if (this.lCOD_UNI_ORG == lCOD_UNI_ORG) {
            return;
        }
        this.lCOD_UNI_ORG = lCOD_UNI_ORG;
        setModified();
    }

    //-----------------------------#############################################
    // %%%Link%%% Table ARE_DOC_VLU_TAB
    public void addCOD_ARE(long newCOD_ARE, long lPRT) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO are_doc_vlu_tab (cod_are,cod_doc_vlu,cod_azl,priority) VALUES(?,?,?,?)");
            ps.setLong(1, newCOD_ARE);
            ps.setLong(2, lCOD_DOC_VLU);
            ps.setLong(3, lCOD_AZL);
            ps.setLong(4, lPRT);
            ps.executeUpdate();
            //return new Long(COD_DOC_VLU);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table ARE_DOC_VLU_TAB

    public void removeCOD_ARE(long newCOD_ARE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM are_doc_vlu_tab  WHERE cod_doc_vlu=? AND cod_are=?");
            ps.setLong(1, lCOD_DOC_VLU);
            ps.setLong(2, newCOD_ARE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_ARE + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------#############################################
    // %%%Link%%% Table DOC_ANA_DOC_VLU_TAB

    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_ana_doc_vlu_tab (cod_doc,cod_doc_vlu) VALUES(?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_DOC_VLU);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ana_doc_vlu_tab  WHERE cod_doc=? AND cod_doc_vlu=?");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_DOC_VLU);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void addCOD_ARC(String NOM_ARC, java.sql.Date DAT_ARC, byte[] PDF_GEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO arc_doc_vlu_tab "
                        + "(cod_arc,cod_doc_vlu,cod_azl,nom_arc,dat_arc,pdf_gen) "
                    + "VALUES"
                        + "(?,?,?,?,?,?)");
            ps.setLong(1, NEW_ID());
            ps.setLong(2, lCOD_DOC_VLU);
            ps.setLong(3, lCOD_AZL);
            ps.setString(4, NOM_ARC);
            ps.setDate(5, DAT_ARC);
            ps.setBytes(6, PDF_GEN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void removeCOD_ARC(long newCOD_ARC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "arc_doc_vlu_tab "
                    + "WHERE "
                        + "cod_arc=? "
                        + "AND cod_doc_vlu=? "
                        + "AND cod_azl=?");
            ps.setLong(1, newCOD_ARC);
            ps.setLong(2, lCOD_DOC_VLU);
            ps.setLong(3, lCOD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Il DVR archiviato con ID=" + newCOD_ARC + " non è stato trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</comment>

    public long ejbGetAllegatiCount(long lCOD_DOC_VLU){
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "count(cod_doc) "
                    + "FROM "
                        + "doc_ana_doc_vlu_tab "
                    + "WHERE "
                        + "doc_ana_doc_vlu_tab.cod_doc_vlu = ?");
            ps.setLong(1, lCOD_DOC_VLU);

            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getLong(1);
            
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
            
    public Collection ejbGetValutazioneRischiAllegati(long lCOD_DOC_VLU) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana_doc_tab.cod_doc,"
                    + " tit_doc  FROM  ana_doc_tab, doc_ana_doc_vlu_tab WHERE  "
                    + "ana_doc_tab.cod_doc = doc_ana_doc_vlu_tab.cod_doc "
                    + "AND doc_ana_doc_vlu_tab.cod_doc_vlu=? order by tit_doc");
            ps.setLong(1, lCOD_DOC_VLU);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ValutazioneRischiAllegati obj = new ValutazioneRischiAllegati();
                obj.COD_DOC_VLU = lCOD_DOC_VLU;
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
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

    public Collection ejbGetValutazioneRischiArchivio(long lCOD_DOC_VLU, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_arc, "
                        + "nom_arc "
                    + "FROM  "
                        + "arc_doc_vlu_tab "
                    + "WHERE "
                        + "cod_doc_vlu = ? "
                        + "and cod_azl = ? "
                    + "ORDER BY "
                        + "nom_arc desc");
            ps.setLong(1, lCOD_DOC_VLU);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ValutazioneRischiArchivio obj = new ValutazioneRischiArchivio();
                obj.COD_ARC = rs.getLong(1);
                obj.NOM_ARC = rs.getString(2);
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

    //</setter-getters>
    public Collection ejbGetValutazioneRischiSezioniByID_View(long COD_DOC_VLU) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "ana_are_tab.cod_are, "
                    + "nom_are "
                    + "FROM  "
                    + "ana_are_tab, "
                    + "are_doc_vlu_tab "
                    + "WHERE  "
                    + "ana_are_tab.cod_are = are_doc_vlu_tab.cod_are "
                    + "AND are_doc_vlu_tab.cod_doc_vlu=? "
                    + "order by "
                    + "are_doc_vlu_tab.priority");
            ps.setLong(1, COD_DOC_VLU);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ValutazioneRischiSezioniByID_View obj = new ValutazioneRischiSezioniByID_View();
                obj.COD_DOC_VLU = COD_DOC_VLU;
                obj.COD_ARE = rs.getLong(1);
                obj.NOM_RSP_DOC = rs.getString(2);
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
//}

    public byte[] downloadFileArchivio(long lCOD_ARC) {
        BMPConnection bmp = getConnection();
        try {
            byte[] bt = null;
            Blob bb;
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "pdf_gen "
                    + "FROM "
                        + "arc_doc_vlu_tab "
                    + "WHERE "
                        + "cod_arc=?");
            ps.setLong(1, lCOD_ARC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (bmp.getType() == ConnectionType.POSTGRE) {
                    bt = rs.getBytes(1);
                } else if (bmp.getType() == ConnectionType.ORACLE) {
                    bb = rs.getBlob(1);
                    if (rs.wasNull()) {
                        bt = null;
                    } else {
                        bt = bb.getBytes(1, (int) bb.length());
                    }
                } else if (bmp.getType() == ConnectionType.DB2) {
                    bt = rs.getBytes(1);
                }
            } else {
                bt = null;
            }
            rs.close();
            ps.close();
            return bt;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public Collection ejbFindEx(
            long lCOD_AZL,
            java.sql.Date dtDAT_DOC_VLU,
            String strNOM_RSP_DOC,
            String strVER_DOC,
            long lCOD_UNI_ORG,
            int iOrderParameter) {
        String strSQL = "SELECT a.cod_doc_vlu, a.dat_doc_vlu, a.nom_rsp_doc, a.ver_doc, b.rag_scl_azl FROM  ana_doc_vlu_tab a, ana_azl_tab b WHERE  a.cod_azl = b.cod_azl AND a.cod_azl=? ";
        if (dtDAT_DOC_VLU != null) {
            strSQL += " AND a.dat_doc_vlu=? ";
        }
        if (strNOM_RSP_DOC != null) {
            strSQL += " AND UPPER(a.nom_rsp_doc) LIKE ? ";
        }
        if (strVER_DOC != null) {
            strSQL += " AND UPPER(a.ver_doc) LIKE ? ";
        }
        if (lCOD_UNI_ORG > 0) {
            strSQL += " AND a.cod_uni_org = ? ";
        }
        strSQL += " order by UPPER(a.nom_rsp_doc)";
        BMPConnection bmp = getConnection();
        int i = 1;
        try {
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(i++, lCOD_AZL);
            if (dtDAT_DOC_VLU != null) {
                ps.setDate(i++, dtDAT_DOC_VLU);
            }
            if (strNOM_RSP_DOC != null) {
                ps.setString(i++, strNOM_RSP_DOC.toUpperCase());
            }
            if (strVER_DOC != null) {
                ps.setString(i++, strVER_DOC.toUpperCase());
            }
            if (lCOD_UNI_ORG > 0) {
                ps.setLong(i++, lCOD_UNI_ORG);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ValutazioneRischiSezioniNames_View obj = new ValutazioneRischiSezioniNames_View();
                obj.COD_DOC_VLU = rs.getLong(1);
                obj.DAT_DOC_VLU = rs.getDate(2);
                obj.NOM_RSP_DOC = rs.getString(3);
                obj.VER_DOC = rs.getString(4);
                obj.RAG_SCL_AZL = rs.getString(5);
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

    public Collection ejbGetValutazioneRischiSezioniNames_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_doc_vlu, a.dat_doc_vlu, a.nom_rsp_doc, a.ver_doc, b.rag_scl_azl FROM  ana_doc_vlu_tab a, ana_azl_tab b WHERE  a.cod_azl = b.cod_azl AND a.cod_azl=? order by a.nom_rsp_doc");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ValutazioneRischiSezioniNames_View obj = new ValutazioneRischiSezioniNames_View();
                obj.COD_DOC_VLU = rs.getLong(1);
                obj.DAT_DOC_VLU = rs.getDate(2);
                obj.NOM_RSP_DOC = rs.getString(3);
                obj.VER_DOC = rs.getString(4);
                obj.RAG_SCL_AZL = rs.getString(5);
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
}
