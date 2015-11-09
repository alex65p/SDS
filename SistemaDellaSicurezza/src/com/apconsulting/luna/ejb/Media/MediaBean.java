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
package com.apconsulting.luna.ejb.Media;

import java.io.File;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.Collection;
import java.sql.Date;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPConnection.ConnectionType;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.ejb.pseudoejb.SearchHelper;
import s2s.file.io.BynaryFileReader;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class MediaBean extends BMPEntityBean implements IMediaHome, IMedia {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    Long lCOD_MED;
    Long lCOD_SOP;
    String sNOM_MED;
    String sDES_MED;
    Integer iTIPO;
    String sFILE;
    String sMIME;
    Blob bBLOB;
    String sNOTE;
    java.sql.Date dDATA;
    java.sql.Time tORA;
    Long lLEN;
    byte[] mediadata;

    private MediaBean() {
        //
    }
    private static MediaBean ys = null;

    public static MediaBean getInstance() {
        if (ys == null) {
            ys = new MediaBean();
        }
        return ys;
    }

    public IMedia create(
            String nom_med,
            String des_med,
            String file,
            Integer tipo,
            Long cod_sop,
            java.sql.Blob blob,
            byte[] mediadata,
            java.sql.Date data,
            java.sql.Time ora,
            String mime,
            Long len)
            throws CreateException {
        MediaBean bean = new MediaBean();
        try {
            Object primaryKey = bean.ejbCreate(
                    nom_med,
                    des_med,
                    file,
                    tipo,
                    cod_sop,
                    blob,
                    mediadata,
                    data,
                    ora,
                    mime,
                    len);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        MediaBean iAnagrDocumentoBean = new MediaBean();
        try {
            Object obj = iAnagrDocumentoBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAnagrDocumentoBean.setEntityContext(new EntityContextWrapper(obj));
            iAnagrDocumentoBean.ejbActivate();
            iAnagrDocumentoBean.ejbLoad();
            iAnagrDocumentoBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public IMedia findByPrimaryKey(Long primaryKey) throws FinderException {
        MediaBean bean = new MediaBean();
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

    public Collection getView(Long COD_SOP) {
        return this.ejbGetView(COD_SOP);
    }

    public Long ejbCreate(
            String nom_med,
            String des_med,
            String file,
            Integer tipo,
            Long cod_sop,
            java.sql.Blob blob,
            byte[] mediadata,
            java.sql.Date data,
            java.sql.Time ora,
            String mime,
            Long len) {

        lCOD_MED = NEW_ID();
        lCOD_SOP = cod_sop;
        sNOM_MED = nom_med;
        sDES_MED = des_med;
        iTIPO = tipo;
        sFILE = file;
        bBLOB = blob;
        dDATA = data;
        tORA = ora;
        sMIME = mime;
        lLEN = len;

        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_med_tab "
                    + "           (cod_med, cod_sop, nom_med, des_med, tipo, file, blob, note, data, ora, mime, len) "
                    + "    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

            ps.setLong(1, lCOD_MED);
            ps.setLong(2, lCOD_SOP);
            ps.setString(3, sNOM_MED);
            ps.setString(4, sDES_MED);
            ps.setInt(5, iTIPO);
            ps.setString(6, sFILE);
            ps.setBytes(7, mediadata);
            ps.setString(8, "");
            ps.setDate(9, data);
            ps.setTime(10, ora);
            ps.setString(11, mime);
            ps.setLong(12, len);
            ps.executeUpdate();
            ps.close();

            return new Long(lCOD_MED);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_med FROM ana_med_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            rs.close();
            ps.close();
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
        this.lCOD_MED = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_MED = -1L;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_med_tab  WHERE cod_med=?");
            ps.setLong(1, lCOD_MED);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.sNOM_MED = rs.getString("nom_med");
                this.sDES_MED = rs.getString("des_med");
                this.sFILE = rs.getString("file");
                this.sMIME = rs.getString("mime");
                this.iTIPO = rs.getInt("tipo");
                this.lLEN = rs.getLong("len");

                byte[] bt = null;
                Blob bb;

                if (bmp.getType() == ConnectionType.POSTGRE) {
                    bt = rs.getBytes("blob");
                } else if (bmp.getType() == ConnectionType.ORACLE) {
                    bb = rs.getBlob("blob");
                    if (rs.wasNull()) {
                        bt = null;
                    } else {
                        bt = bb.getBytes(1, (int) bb.length());
                    }
                }

                this.mediadata = bt;
                this.dDATA = rs.getDate("data");
                this.sNOTE = rs.getString("note");
                this.tORA = rs.getTime("ora");
                this.lCOD_SOP = rs.getLong("cod_sop");
            } else {
                throw new NoSuchEntityException("Media con ID=" + lCOD_MED + " non trovato.");
            }
            rs.close();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        /*
        BMPConnection bmp = getConnection();
        try {
        PreparedStatement ps = bmp.prepareStatement(
        "DELETE "
        + "FROM "
        + "ana_doc_tab "
        + "WHERE "
        + "cod_doc = ? ");
        ps.setLong(1, COD_DOC);
        if (ps.executeUpdate() == 0) {
        throw new NoSuchEntityException("AnagrDocumento con ID=" + COD_DOC + " non è trovata");
        }
        ps.close();
        deleteFile();
        deleteFileLink();
        } catch (Exception ex) {
        ex.printStackTrace();
        throw new EJBException(ex);
        
        } finally {
        bmp.close();
        }
         * 
         */
    }
//----------------------------------------------------------

    public void ejbStore() {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE ana_med_tab "
                    + "   SET nom_med=?, des_med=?, tipo=?, file=?, blob=?, "
                    + "       note=?, data=?, ora=?, mime=?, len=? "
                    + " WHERE cod_med = ?;");

            ps.setString(1, sNOM_MED);
            ps.setString(2, sDES_MED);
            ps.setInt(3, iTIPO);
            ps.setString(4, sFILE);
            ps.setBytes(5, mediadata);
            ps.setString(6, sNOTE);
            ps.setDate(7, dDATA);
            ps.setTime(8, tORA);
            ps.setString(9, sMIME);
            ps.setLong(10, lLEN);
            ps.setLong(11, lCOD_MED);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Media con ID = " + lCOD_MED + " non trovato.");
            }
            ps.close();
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public byte[] downloadFile() {
        byte[] bt = null;
        /*
        MediaFileInfo info = null;
        BMPConnection bmp = getConnection();
        
        try {
        Blob bb;
        
        
        PreparedStatement ps = bmp.prepareStatement("SELECT content  FROM documents WHERE cod_doc=? and link_document is null");
        ps.setLong(1, COD_DOC);
        
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
        } catch (Exception ex) {
        ex.printStackTrace(System.err);
        throw new EJBException(ex);
        } finally {
        bmp.close();
        }
         * 
         */
        return bt;
    }

    public void uploadFile(String strFileName, String strContentType, byte[] content) {
        /*
        BMPConnection bmp = getConnection();
        try {
        PreparedStatement ps = bmp.prepareStatement("INSERT INTO adocuments (cod_doc, cod_azl, name,  content_type,  content, doc_size, last_updated) VALUES(?,?,?,?,?,?,?)");
        ps.setLong(1, COD_DOC);
        ps.setLong(2, COD_AZL);
        ps.setString(3, strFileName);
        ps.setString(4, strContentType);
        ps.setBytes(5, content);
        ps.setLong(6, content.length);
        ps.setDate(7, new java.sql.Date(System.currentTimeMillis()));
        ps.executeUpdate();
        ps.close();
        } catch (Exception ex) {
        ex.printStackTrace();
        throw new EJBException(ex);
        } finally {
        bmp.close();
        }
         * 
         */
    }

    public void deleteFile() {
        /*
        BMPConnection bmp = getConnection();
        try {
        PreparedStatement ps = bmp.prepareStatement("DELETE FROM documents WHERE cod_doc=? and link_document is null");
        ps.setLong(1, COD_DOC);
        ps.executeUpdate();
        ps.close();
        } catch (Exception ex) {
        throw new EJBException(ex);
        } finally {
        bmp.close();
        }
         * 
         */
    }

    public MediaFileInfo getFileInfo() {
        MediaFileInfo info = null;
        /*
        BMPConnection bmp = getConnection();
        try {
        PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? and link_document is null");
        ps.setLong(1, COD_DOC);
        ResultSet rs = ps.executeQuery();
        java.util.ArrayList al = new java.util.ArrayList();
        if (rs.next()) {
        info = new MediaFileInfo();
        info.strName = rs.getString(1);
        info.strContentType = rs.getString(2);
        info.lSize = rs.getLong(3);
        info.dtModified = rs.getDate(4);
        }
        rs.close();
        ps.close();
        } catch (Exception ex) {
        throw new EJBException(ex);
        } finally {
        bmp.close();
        }
         * 
         */
        return info;
    }

    public Collection ejbGetView(Long COD_SOP) {
        java.util.ArrayList al = new java.util.ArrayList();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = null;

            String str = "";

            str = "select cod_med, cod_sop, nom_med, des_med, tipo, file, blob, note, data, ora "
                    + "from ana_med_tab "
                    + "where cod_sop = ? "
                    + "order by data";

            ps = bmp.prepareStatement(str);
            ps.setLong(1, lCOD_SOP);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                jbMedia rec = new jbMedia();
                rec.lCOD_MED = rs.getLong(1);
                rec.sNOM_MED = rs.getString(3);
                rec.sDES_MED = rs.getString(4);
                rec.iTipo = rs.getInt(5);
                rec.sFile = rs.getString(6);
                rec.bBlob = rs.getBlob(7);
                rec.dData = rs.getDate(9);
                rec.tOra = rs.getTime(10);
                al.add(rec);
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return al;
    }

//<search>
    public Collection findEx(
            String nom_med,
            String des_med,
            String file,
            Integer tipo,
            Long cod_med,
            Long cod_sop,
            java.sql.Blob blob,
            java.sql.Date data,
            java.sql.Time ora,
            String mime,
            Long len) {
        return ejbFindEx(
                nom_med,
                des_med,
                file,
                tipo,
                cod_med,
                cod_sop,
                blob,
                data,
                ora,
                mime,
                len);
    }

    public Collection ejbFindEx(String nom_med,
            String des_med,
            String file,
            Integer tipo,
            Long cod_med,
            Long cod_sop,
            java.sql.Blob blob,
            java.sql.Date data,
            java.sql.Time ora,
            String mime,
            Long len) {

        java.util.ArrayList al = new java.util.ArrayList();
        /*
        String sSQL =
        "SELECT ana_doc_tab.cod_doc,  ana_doc_tab.tit_doc, ana_doc_tab.num_doc, cag_doc_tab.nom_cag_doc, ana_doc_tab.dat_rev_doc "
        + "FROM ana_doc_tab, cag_doc_tab "
        + "WHERE  cag_doc_tab.cod_cag_doc=ana_doc_tab.cod_cag_doc "
        + "AND  ( ana_doc_tab.cod_azl=? OR  ana_doc_tab.cod_azl IS NULL) ";
        
        SearchHelper hlp = new SearchHelper(sSQL);
        
        hlp.add(RSP_DOC, "RSP_DOC");
        hlp.add(EMS_DOC, "EMS_DOC");
        hlp.add(NUM_DOC, "NUM_DOC");
        hlp.add(EDI_DOC, "EDI_DOC");
        hlp.add(DAT_REV_DOC, "DAT_REV_DOC");
        hlp.add(MES_REV_DOC, "MES_REV_DOC");
        
        hlp.add(TIT_DOC, "TIT_DOC");
        hlp.add(COD_CAG_DOC, "ana_doc_tab.COD_CAG_DOC");
        
        hlp.add(COD_TPL_DOC, "COD_TPL_DOC");
        hlp.add(DAT_FUT_REV_DOC, "DAT_FUT_REV_DOC");
        
        hlp.add(PRG_RIF_DOC, "PRG_RIF_DOC");
        hlp.add(PGN_RIF_DOC, "PGN_RIF_DOC");
        
        hlp.add(COD_LUO_FSC, "COD_LUO_FSC");
        hlp.add(NOT_LUO_CON, "NOT_LUO_CON");
        
        hlp.add(NOT_LUO_CON, "PER_CON_YEA");
        
        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_MSR)) {
        hlp.orderBy("cag_doc_tab.nom_cag_doc, ana_doc_tab.dat_rev_doc DESC");
        } else {
        hlp.orderBy(iOrderBy);
        }
        
        BMPConnection bmp = getConnection();
        int i = 2;
        try {
        PreparedStatement ps = bmp.prepareStatement(hlp.toString());
        ps.setLong(1, AZL_ID);
        hlp.startBind(ps, 2);
        {
        hlp.bind(RSP_DOC);
        hlp.bind(EMS_DOC);
        hlp.bind(NUM_DOC);
        hlp.bind(EDI_DOC);
        hlp.bind(DAT_REV_DOC);
        hlp.bind(MES_REV_DOC);
        
        hlp.bind(TIT_DOC);
        hlp.bind(COD_CAG_DOC);
        
        hlp.bind(COD_TPL_DOC);
        hlp.bind(DAT_FUT_REV_DOC);
        
        hlp.bind(PRG_RIF_DOC);
        hlp.bind(PGN_RIF_DOC);
        
        hlp.bind(COD_LUO_FSC);
        hlp.bind(NOT_LUO_CON);
        
        hlp.bind(NOT_LUO_CON);
        }
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
        AnagrDocumento_View obj = new AnagrDocumento_View();
        obj.lCOD_DOC = rs.getLong(1);
        obj.strTIT_DOC = rs.getString(2);
        obj.strNUM_DOC = rs.getString(3);
        obj.strNOM_CAG_DOC = rs.getString(4);
        obj.dtDAT_REV_DOC = rs.getDate(5);
        al.add(obj);
        }
        } catch (Exception ex) {
        ex.printStackTrace();
        throw new EJBException(ex);
        } finally {
        bmp.close();
        }
         * 
         */
        return al;
    }

    public Long getCOD_MED() {
        return lCOD_MED;
    }

    public void setCOD_MED(Long COD_MED) {
        if (this.lCOD_MED.equals(COD_MED)) {
            return;
        }
        this.lCOD_MED = COD_MED;
        setModified();
    }

    public Long getCOD_SOP() {
        return lCOD_SOP;
    }

    public void setCOD_SOP(Long COD_SOP) {
        if (this.lCOD_SOP.equals(COD_SOP)) {
            return;
        }
        this.lCOD_SOP = COD_SOP;
        setModified();
    }

    public String getNOM_MED() {
        return sNOM_MED;
    }

    public void setNOM_MED(String NOM_MED) {
        if (this.sNOM_MED.equals(NOM_MED)) {
            return;
        }
        this.sNOM_MED = NOM_MED;
        setModified();
    }

    public String getDES_MED() {
        return sDES_MED;
    }

    public void setDES_MED(String DES_MED) {
        if (this.sDES_MED.equals(DES_MED)) {
            return;
        }
        this.sDES_MED = DES_MED;
        setModified();
    }

    public Integer getTIPO() {
        return iTIPO;
    }

    public void setTIPO(Integer TIPO) {
        if (this.iTIPO.equals(TIPO)) {
            return;
        }
        this.iTIPO = TIPO;
        setModified();
    }

    public String getFILE() {
        return sFILE;
    }

    public void setFILE(String FILE) {
        if (this.sFILE.equals(FILE)) {
            return;
        }
        this.sFILE = FILE;
        setModified();
    }

    public Blob getBLOB() {
        return bBLOB;
    }

    public void setBLOB(Blob BLOB) {
        if (this.bBLOB.equals(BLOB)) {
            return;
        }
        this.bBLOB = BLOB;
        setModified();
    }

    public void setMediadata(byte[] mediadata) {
        this.mediadata = mediadata;
        setModified();
    }

    public byte[] getMediadata() {
        return mediadata;
    }

    public String getNOTE() {
        return sNOTE;
    }

    public void setNOTE(String NOTE) {
        if (this.sNOTE.equals(NOTE)) {
            return;
        }
        this.sNOTE = NOTE;
        setModified();
    }

    public Date getDATA() {
        return dDATA;
    }

    public void setDATA(Date DATA) {
        if (this.dDATA.equals(DATA)) {
            return;
        }
        this.dDATA = DATA;
        setModified();
    }

    public Time getORA() {
        return tORA;
    }

    public void setORA(Time ORA) {
        if (this.tORA.equals(ORA)) {
            return;
        }
        this.tORA = ORA;
        setModified();
    }

    public String getMIME() {
        return sMIME;
    }

    public void setMIME(String MIME) {
        if (this.sMIME.equals(MIME)) {
            return;
        }
        this.sMIME = MIME;
        setModified();
    }

    public Long getLEN() {
        return lLEN;
    }

    public void setLEN(Long LEN) {
        if (this.lLEN.equals(LEN)) {
            return;
        }
        this.lLEN = LEN;
        setModified();
    }
}
