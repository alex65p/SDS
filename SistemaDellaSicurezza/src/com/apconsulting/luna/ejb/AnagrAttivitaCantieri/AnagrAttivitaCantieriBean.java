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

package com.apconsulting.luna.ejb.AnagrAttivitaCantieri;

import com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo;
import java.io.File;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPConnection.ConnectionType;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.file.io.BynaryFileReader;

/**
 *
 * @author Alessandro
 */
public class AnagrAttivitaCantieriBean extends BMPEntityBean implements IAnagrAttivitaCantieriHome, IAnagrAttivitaCantieri {

    long lCOD_DOC;
    String strDES_ATT;
    String strCOD;
    String strNOM_ATT;
    long lCOD_AZL;
    private static AnagrAttivitaCantieriBean ys = null;

    private AnagrAttivitaCantieriBean() {
    }

    public static AnagrAttivitaCantieriBean getInstance() {
        if (ys == null) {
            ys = new AnagrAttivitaCantieriBean();
        }
        return ys;
    }

    public IAnagrAttivitaCantieri create(String strDES_ATT, String strCOD, String strNOM_ATT, long lCOD_AZL) throws CreateException {
        AnagrAttivitaCantieriBean bean = new AnagrAttivitaCantieriBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_ATT, strCOD, strNOM_ATT, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_ATT);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrAttivitaCantieriBean bean = new AnagrAttivitaCantieriBean();
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

    public IAnagrAttivitaCantieri findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrAttivitaCantieriBean bean = new AnagrAttivitaCantieriBean();
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

    public Long ejbCreate(String strDES_ATT, String strCOD, String strNOM_ATT, long lCOD_AZL) {
        this.lCOD_DOC = NEW_ID(); // unic ID
        this.strNOM_ATT = strNOM_ATT;
        this.strCOD = strCOD;
        this.strDES_ATT = strDES_ATT;

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_att_can_tab "
                    + "(cod_doc, des_att, cod, nom_att, cod_azl) "
                    + "VALUES"
                    + "(?,?,?,?,?)");

            ps.setLong(1, lCOD_DOC);
            ps.setString(2, strDES_ATT);
            ps.setString(3, strCOD);
            ps.setString(4, strNOM_ATT);
            ps.setLong(5, lCOD_AZL);

            ps.executeUpdate();
            return new Long(lCOD_DOC);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strDES_ATT) {
    }

    public long getlCOD_DOC() {
        return lCOD_DOC;
    }

    public void setlCOD_DOC(long newlCOD_DOC) {
        if (lCOD_DOC == newlCOD_DOC) {
            return;
        }
        lCOD_DOC = newlCOD_DOC;
        setModified();
    }

    public String getstrDES_ATT() {
        return strDES_ATT;
    }

    public String getstrCOD() {
        return strCOD;
    }

    public String getstrNOM_ATT() {
        return strNOM_ATT;
    }

    public void setstrDES_ATT(String newstrDES_ATT) {

        if (strDES_ATT.equals(newstrDES_ATT)) {
            return;
        }

        strDES_ATT = newstrDES_ATT;
        setModified();
    }

    public void setstrCOD(String newstrCOD) {

        if (strCOD.equals(newstrCOD)) {
            return;
        }

        strCOD = newstrCOD;
        setModified();
    }

    public void setstrNOM_ATT(String newstrNOM_ATT) {

        if (strNOM_ATT.equals(newstrNOM_ATT)) {
            return;
        }

        strNOM_ATT = newstrNOM_ATT;
        setModified();
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc FROM ana_att_can_tab ");
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

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_DOC = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_DOC = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_att_can_tab  WHERE cod_doc=? ");
            ps.setLong(1, lCOD_DOC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_DOC = rs.getLong("COD_DOC");
                this.strDES_ATT = rs.getString("DES_ATT");
                this.strCOD = rs.getString("COD");
                this.strNOM_ATT = rs.getString("NOM_ATT");
            } else {
                throw new NoSuchEntityException("Anagrafica attivita' con ID=" + lCOD_DOC + " non è trovato");
            }
            rs.close();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            // Elimino l'attività
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "ana_att_can_tab "
                    + "WHERE "
                        + "cod_doc = ?");
            ps.setLong(1, lCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Attivita con ID: " + lCOD_DOC + " non trovata");
            }
            
            // Elimino l'eventuale documento associato all'attività
            ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "documents "
                    + "WHERE "
                        + "cod_doc=? "
                        + "and link_document is null");
            ps.setLong(1, lCOD_DOC);
            ps.executeUpdate();
            
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
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
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_att_can_tab SET des_att=?, cod=?, nom_att=? WHERE cod_doc=?");
            ps.setString(1, strDES_ATT);
            ps.setString(2, strCOD);
            ps.setString(3, strNOM_ATT);
            ps.setLong(4, lCOD_DOC);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID= non è trovata");
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

    // <file-operations>
    public byte[] downloadFile() {
        AnagDocumentoFileInfo info = null;
        BMPConnection bmp = getConnection();

        try {
            byte[] bt = null;
            Blob bb;

            PreparedStatement ps = bmp.prepareStatement("SELECT content  FROM documents WHERE cod_doc=? and link_document is null");
            ps.setLong(1, lCOD_DOC);

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
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Inizio modifica gestione link esterno documenti
    public byte[] downloadFileLink() {
        BMPConnection bmp = getConnection();
        try {
            String fielPath = null;
            byte[] fileContent = null;

            PreparedStatement ps = bmp.prepareStatement("SELECT link_document FROM documents WHERE cod_doc=? and link_document is not null");
            ps.setLong(1, lCOD_DOC);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fielPath = rs.getString("link_document");
            }
            rs.close();
            ps.close();

            if (fielPath != null && !fielPath.trim().equals("")) {
                fileContent = new BynaryFileReader().getBytesFromFile(new File(fielPath));
            }
            return fileContent;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public void uploadFile(String strFileName, String strContentType, byte[] content) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO documents (cod_doc, cod_azl, name,  content_type,  content, doc_size, last_updated) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_DOC);
            ps.setLong(2, lCOD_AZL);
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
    }

// Inizio modifica gestione link esterno documenti
    public void uploadFileLink(String strFileName, String strContentType, byte[] content) {
        BMPConnection bmp = getConnection();

        String strOnlyName = strFileName.substring(strFileName.lastIndexOf('/') + 1, strFileName.length());
        strOnlyName = strOnlyName.substring(strOnlyName.lastIndexOf('\\') + 1, strOnlyName.length());

        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO documents (cod_doc, cod_azl, name,  content_type,  doc_size, last_updated, link_document) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_DOC);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strOnlyName);
            ps.setString(4, strContentType);
            ps.setLong(5, content.length);
            ps.setDate(6, new java.sql.Date(System.currentTimeMillis()));
            ps.setString(7, strFileName);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public void deleteFile() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM documents WHERE cod_doc=? and link_document is null");
            ps.setLong(1, lCOD_DOC);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // Inizio modifica gestione link esterno documenti
    public void deleteFileLink() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM documents WHERE cod_doc=? and link_document is not null");
            ps.setLong(1, lCOD_DOC);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfo() {
        AnagDocumentoFileInfo info = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? and link_document is null");
            ps.setLong(1, lCOD_DOC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                info = new AnagDocumentoFileInfo();
                info.strName = rs.getString(1);
                info.strContentType = rs.getString(2);
                info.lSize = rs.getLong(3);
                info.dtModified = rs.getDate(4);
            }
            rs.close();
            ps.close();
            return info;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Inizio modifica gestione link esterno documenti
    public AnagDocumentoFileInfo getFileInfoLink() {
        AnagDocumentoFileInfo infoLink = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated, link_document FROM documents WHERE cod_doc=? and link_document is not null");
            ps.setLong(1, lCOD_DOC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                infoLink = new AnagDocumentoFileInfo();
                infoLink.strName = rs.getString(1);
                infoLink.strContentType = rs.getString(2);
                infoLink.lSize = rs.getLong(3);
                infoLink.dtModified = rs.getDate(4);
                infoLink.strLinkDocument = rs.getString(5);
            }
            rs.close();
            ps.close();
            return infoLink;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public byte[] downloadFileU(String strNOM_TAB, long lCOD_DOC_TAB) {
        AnagDocumentoFileInfo info = null;
        BMPConnection bmp = getConnection();
        try {
            byte[] bt = null;
            Blob bb;
            PreparedStatement ps = bmp.prepareStatement("SELECT content  FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                if (bmp.getType() == ConnectionType.POSTGRE) {
                    bt = rs.getBytes(1);
                } else if (bmp.getType() == ConnectionType.ORACLE) {
                    bb = (Blob) rs.getBlob(1);
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

    public byte[] downloadFileULink(String strNOM_TAB, long lCOD_DOC_TAB) {
        BMPConnection bmp = getConnection();
        try {
            String fielPath = null;
            byte[] fileContent = null;

            PreparedStatement ps = bmp.prepareStatement("SELECT link_document FROM documents WHERE cod_doc=? and nom_tab = ? and link_document is not null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fielPath = rs.getString("link_document");
            }
            rs.close();
            ps.close();

            if (fielPath != null && !fielPath.trim().equals("")) {
                fileContent = new BynaryFileReader().getBytesFromFile(new File(fielPath));
            }
            return fileContent;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void uploadFileU(String strNOM_TAB, long lCOD_DOC_TAB, String strFileName, String strContentType, byte[] content) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO documents (cod_doc, cod_azl, name,  content_type,  content, doc_size, last_updated, nom_tab) VALUES(?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strFileName);
            ps.setString(4, strContentType);
            ps.setBytes(5, content);
            ps.setLong(6, content.length);
            ps.setDate(7, new java.sql.Date(System.currentTimeMillis()));
            ps.setString(8, strNOM_TAB);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Inizio modifica gestione link esterno documenti
    public void uploadFileULink(String strNOM_TAB, long lCOD_DOC_TAB, String strFileName, String strContentType, byte[] content) {
        BMPConnection bmp = getConnection();
        String strOnlyName = strFileName.substring(strFileName.lastIndexOf('/') + 1, strFileName.length());
        strOnlyName = strOnlyName.substring(strOnlyName.lastIndexOf('\\') + 1, strOnlyName.length());
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO documents (cod_doc, cod_azl, name,  content_type,  doc_size, last_updated, nom_tab, link_document) VALUES(?,?,?,?,?,?,?,?)");

            ps.setLong(1, lCOD_DOC_TAB);
            ps.setLong(2, lCOD_AZL);
            ps.setString(3, strOnlyName);
            ps.setString(4, strContentType);
            ps.setLong(5, content.length);
            ps.setDate(6, new java.sql.Date(System.currentTimeMillis()));
            ps.setString(7, strNOM_TAB);
            ps.setString(8, strFileName);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public void deleteFileU(String strNOM_TAB, long lCOD_DOC_TAB) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Inizio modifica gestione link esterno documenti
    public void deleteFileULink(String strNOM_TAB, long lCOD_DOC_TAB) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is not null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ps.executeUpdate();
            ps.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// Fine modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoU(String strNOM_TAB, long lCOD_DOC_TAB) {
        AnagDocumentoFileInfo info = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                info = new AnagDocumentoFileInfo();
                info.strName = rs.getString(1);
                info.strContentType = rs.getString(2);
                info.lSize = rs.getLong(3);
                info.dtModified = rs.getDate(4);
            }
            rs.close();
            ps.close();
            return info;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

// Inizio modifica gestione link esterno documenti
    public AnagDocumentoFileInfo getFileInfoULink(String strNOM_TAB, long lCOD_DOC_TAB) {
        AnagDocumentoFileInfo infoLink = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated, link_document FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is not null ");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                infoLink = new AnagDocumentoFileInfo();
                infoLink.strName = rs.getString(1);
                infoLink.strContentType = rs.getString(2);
                infoLink.lSize = rs.getLong(3);
                infoLink.dtModified = rs.getDate(4);
                infoLink.strLinkDocument = rs.getString(5);

            }
            rs.close();
            ps.close();
            return infoLink;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
// </file-operationd>

    public Collection findEx(
            String strDES_ATT, String strCOD, String strNOM_ATT, long lCOD_AZL) {
        return (new AnagrAttivitaCantieriBean()).ejbFindEx(
                strDES_ATT, strCOD, strNOM_ATT, lCOD_AZL);
    }

    public Collection ejbFindEx(
            String strDES_ATT, String strCOD, String strNOM_ATT, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query =
                    "SELECT "
                    + "a.cod_doc, "
                    + "a.des_att, "
                    + "a.cod, "
                    + "a.nom_att, "
                    + "b.name, "
                    + "b.link_document "
                    + "FROM "
                    + "ana_att_can_tab a "
                    + "left outer join documents b "
                    + "on (a.cod_doc = b.cod_doc) "
                    + "where "
                    + "a.cod_azl=?";

            if ((strDES_ATT != null) && (!strDES_ATT.trim().equals(""))) {
                query += " AND UPPER(a.des_att) LIKE ? ";
            }
            if ((strCOD != null) && (!strCOD.trim().equals(""))) {
                query += " AND UPPER(a.cod) LIKE ? ";
            }
            if ((strNOM_ATT != null) && (!strNOM_ATT.trim().equals(""))) {
                query += " AND UPPER(a.nom_att) LIKE ?";
            }

            query += " ORDER BY UPPER(a.nom_att)";

            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            int i = 2;

            if ((strDES_ATT != null) && (!strDES_ATT.trim().equals(""))) {
                ps.setString(i++, strDES_ATT.toUpperCase() + "%");
            }

            if ((strCOD != null) && (!strCOD.trim().equals(""))) {
                ps.setString(i++, strCOD.toUpperCase() + "%");
            }

            if ((strNOM_ATT != null) && (!strNOM_ATT.trim().equals(""))) {
                ps.setString(i++, strNOM_ATT.toUpperCase() + "%");
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrAttivitaCantieri_All_View obj = new AnagrAttivitaCantieri_All_View();
                obj.COD_DOC = rs.getLong(1);
                obj.DES_ATT = rs.getString(2);
                obj.COD = rs.getString(3);
                obj.NOM_ATT = rs.getString(4);
                obj.FILE = rs.getString(5);
                obj.FILE_LINK = rs.getString(6);

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
