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
package com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri;

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
import s2s.ejb.pseudoejb.SearchHelper;
import s2s.file.io.BynaryFileReader;

/**
 *
 * @author Alessandro
 */
public class AnagrDocumentiGestioneCantieriBean extends BMPEntityBean implements IAnagrDocumentiGestioneCantieriHome, IAnagrDocumentiGestioneCantieri {

    long COD_DOC;				 //1
    String TIT_DOC;			 //2
    String NUM_DOC;			 //2
    long COD_TPL_DOC;			 //3
//----------------------------
    String DES;	    	                 //4
    java.sql.Date DAT_DOC;                      //5
    long COD_AZL;			 //6
    long COD_SOP;			 //7
    long COD_PRO;			 //8
    long COD_OPE;			 //9
    long COD_CAN;			 //10
//</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static AnagrDocumentiGestioneCantieriBean ys = null;

    private AnagrDocumentiGestioneCantieriBean() {
        //
    }

    public static AnagrDocumentiGestioneCantieriBean getInstance() {
        if (ys == null) {
            ys = new AnagrDocumentiGestioneCantieriBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public IAnagrDocumentiGestioneCantieri create(String strTIT_DOC, String strNUM_DOC, java.sql.Date dtDAT_DOC, long lCOD_TPL_DOC, long lCOD_SOP, long lCOD_OPE, long lCOD_CAN, long lCOD_PRO, String strDES, long lCOD_AZL) throws CreateException {
        AnagrDocumentiGestioneCantieriBean bean = new AnagrDocumentiGestioneCantieriBean();
        try {
            Object primaryKey = bean.ejbCreate(strTIT_DOC, strNUM_DOC, dtDAT_DOC, lCOD_TPL_DOC, lCOD_SOP, lCOD_OPE, lCOD_CAN, lCOD_PRO, strDES, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strTIT_DOC, strNUM_DOC, dtDAT_DOC, lCOD_TPL_DOC, lCOD_SOP, lCOD_OPE, lCOD_CAN, lCOD_PRO, strDES, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AnagrDocumentiGestioneCantieriBean iAnagrDocumentoBean = new AnagrDocumentiGestioneCantieriBean();
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
// (Home Intrface) findByPrimaryKey()

    public IAnagrDocumentiGestioneCantieri findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrDocumentiGestioneCantieriBean bean = new AnagrDocumentiGestioneCantieriBean();
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
    public Collection getDocumentiGet_View(long lCOD_AZL) {
        return (new AnagrDocumentiGestioneCantieriBean()).ejbGetDocumenti_View(lCOD_AZL);
    }
//

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAnagrDocumentoHome-implementation>
    public Long ejbCreate(String strTIT_DOC, String strNUM_DOC, java.sql.Date dtDAT_DOC, long lCOD_TPL_DOC, long lCOD_SOP, long lCOD_OPE, long lCOD_CAN, long lCOD_PRO, String strDES, long lCOD_AZL) {

        this.TIT_DOC = strTIT_DOC;		//1
        this.NUM_DOC = strNUM_DOC;		//1
        this.DAT_DOC = dtDAT_DOC;		//1
        this.COD_TPL_DOC = lCOD_TPL_DOC;	//2
        this.COD_SOP = lCOD_SOP;	//2
        this.COD_OPE = lCOD_OPE;	//2
        this.COD_CAN = lCOD_CAN;	//2
        this.COD_PRO = lCOD_PRO;	//2
        this.DES = strDES;	//3
        this.COD_AZL = lCOD_AZL;	//3
        this.COD_DOC = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_doc_ges_can_tab (cod_doc,des,tit_doc,num_doc,dat_doc ,cod_tpl_doc,cod_sop,cod_ope,cod_can,cod_pro,cod_azl) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DOC);
            ps.setString(2, DES);
            ps.setString(3, TIT_DOC);
            ps.setString(4, NUM_DOC);
            ps.setDate(5, DAT_DOC);
            ps.setLong(6, COD_TPL_DOC);
            ps.setLong(7, COD_SOP);
	    if (COD_OPE != 0){
                ps.setLong(8, COD_OPE);
            } else {
                ps.setNull(8, java.sql.Types.BIGINT);
            }
            ps.setLong(9, COD_CAN);
            ps.setLong(10, COD_PRO);
            ps.setLong(11, COD_AZL);
            ps.executeUpdate();
            ps.close();

            return new Long(COD_DOC);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strTIT_DOC, String strNUM_DOC, java.sql.Date dtDAT_DOC, long lCOD_TPL_DOC, long lCOD_SOP, long lCOD_OPE, long lCOD_CAN, long lCOD_PRO, String strDES, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc FROM ana_doc_ges_can_tab ");
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
        this.COD_DOC = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_DOC = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_doc_ges_can_tab  WHERE cod_doc=?");
            ps.setLong(1, COD_DOC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.TIT_DOC = rs.getString("TIT_DOC");				//1
                this.NUM_DOC = rs.getString("NUM_DOC");				//1
                this.DAT_DOC = rs.getDate("DAT_DOC");				//1
                this.COD_TPL_DOC = rs.getLong("COD_TPL_DOC");			//2
                this.COD_SOP = rs.getLong("COD_SOP");			//2
                this.COD_OPE = rs.getLong("COD_OPE");			//2
                this.COD_CAN = rs.getLong("COD_CAN");			//2
                this.COD_PRO = rs.getLong("COD_PRO");			//2
//----------------------------
                this.DES = rs.getString("DES");				//3
                this.COD_AZL = rs.getLong("COD_AZL");					//20
            } else {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + COD_DOC + " non è trovata");
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
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE "
                    + "FROM "
                    + "ana_doc_ges_can_tab "
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
    }
//----------------------------------------------------------

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_doc_ges_can_tab  SET tit_doc=?,num_doc=?,dat_doc=?,cod_tpl_doc=?,cod_sop=?, cod_ope=?, cod_can=?, cod_pro=?, des=?,cod_azl=?	 WHERE cod_doc=?");
            ps.setString(1, TIT_DOC);
            ps.setString(2, NUM_DOC);
            ps.setDate(3, DAT_DOC);
            ps.setLong(4, COD_TPL_DOC);
            ps.setLong(5, COD_SOP);
	    if (COD_OPE != 0){
                ps.setLong(6, COD_OPE);
            } else {
                ps.setNull(6, java.sql.Types.BIGINT);
            }
            ps.setLong(7, COD_CAN);
            ps.setLong(8, COD_PRO);
            ps.setString(9, DES);

            if (COD_AZL == 0) {
                ps.setNull(10, java.sql.Types.BIGINT);
            } else {
                ps.setLong(10, COD_AZL);
            }
            ps.setLong(11, COD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID= non è trovata");
            }
            registerSecurityObject(bmp, COD_DOC, COD_AZL, COD_AZL != 0);
            ps.close();
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getPRO_OPE_CAN(long lCOD_DOC) {
        return (new AnagrDocumentiGestioneCantieriBean()).ejbPRO_OPE_CAN(lCOD_DOC);
    }

    public Collection ejbGetDocumenti_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "b.cod_doc, a.nom_tpl_doc, b.num_doc, b.dat_doc, b.tit_doc "
                    + "FROM "
                        + "tpl_doc_can_tab a,ana_doc_ges_can_tab b "
                    + "where "
                        + " b.cod_azl = ? "
                        + " and a.cod_tpl_doc=b.cod_tpl_doc and a.tpl_acq_pos = 'S' "
                    + "ORDER BY "
                        + "a.nom_tpl_doc ASC, b.dat_doc DESC");

            ps.setLong(1,lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumentoGestioneCantieri_View obj = new AnagrDocumentoGestioneCantieri_View();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strNOM_TPL_DOC = rs.getString(2);
                obj.strNUM_DOC = rs.getString(3);
                obj.dtDAT_DOC = rs.getDate(4);
                obj.strTIT_DOC = rs.getString(5);
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
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
//1
    public long getCOD_DOC() {
        return COD_DOC;
    }
//10 unic with edi_doc

    public void setTIT_DOC(String newTIT_DOC) {
        if (TIT_DOC != null) {
            if (TIT_DOC.equals(newTIT_DOC)) {
                return;
            }
        }
        TIT_DOC = newTIT_DOC;
        setModified();
    }

    public String getTIT_DOC() {
        return (TIT_DOC != null) ? TIT_DOC : "";
    }

    public void setNUM_DOC(String newNUM_DOC) {
        if (NUM_DOC != null) {
            if (NUM_DOC.equals(newNUM_DOC)) {
                return;
            }
        }
        NUM_DOC = newNUM_DOC;
        setModified();
    }

    public String getNUM_DOC() {
        return (NUM_DOC != null) ? NUM_DOC : "";
    }

    public void setDAT_DOC(java.sql.Date newDAT_DOC) {
        if (DAT_DOC != null) {
            if (DAT_DOC.equals(newDAT_DOC)) {
                return;
            }
        }
        DAT_DOC = newDAT_DOC;
        setModified();
    }

    public java.sql.Date getDAT_DOC() {
        return DAT_DOC;
    }

    public void setDES(String newDES) {
        if (DES != null) {
            if (DES.equals(newDES)) {
                return;
            }
        }
        DES = newDES;
        setModified();
    }

    public String getDES() {
        return (DES != null) ? DES : "";
    }

//12
    public void setCOD_TPL_DOC(long newCOD_TPL_DOC) {
        if (COD_TPL_DOC == newCOD_TPL_DOC) {
            return;
        }
        COD_TPL_DOC = newCOD_TPL_DOC;
        setModified();
    }

    public long getCOD_TPL_DOC() {
        return COD_TPL_DOC;
    }
//13

    public void setCOD_SOP(long newCOD_SOP) {
        if (COD_SOP == newCOD_SOP) {
            return;
        }
        COD_SOP = newCOD_SOP;
        setModified();
    }

    public long getCOD_SOP() {
        return COD_SOP;
    }
//14

    public void setCOD_OPE(long newCOD_OPE) {
        if (COD_OPE == newCOD_OPE) {
            return;
        }
        COD_OPE = newCOD_OPE;
        setModified();
    }

    public long getCOD_OPE() {
        return COD_OPE;
    }
//15

    public void setCOD_CAN(long newCOD_CAN) {
        if (COD_CAN == newCOD_CAN) {
            return;
        }
        COD_CAN = newCOD_CAN;
        setModified();
    }

    public long getCOD_CAN() {
        return COD_CAN;
    }
//16

    public void setCOD_PRO(long newCOD_PRO) {
        if (COD_PRO == newCOD_PRO) {
            return;
        }
        COD_PRO = newCOD_PRO;
        setModified();
    }

    public long getCOD_PRO() {
        return COD_PRO;
    }
    
    public void setCOD_PRO_CAN_OPE(long COD_PRO, long COD_CAN, long COD_OPE){
	if (this.COD_PRO != COD_PRO || this.COD_CAN != COD_CAN || this.COD_OPE != COD_OPE){
            if (this.COD_PRO != COD_PRO) {
                this.COD_PRO = COD_PRO;
            }
            if (this.COD_CAN != COD_CAN) {
                this.COD_CAN = COD_CAN;
            }
            if (this.COD_OPE != COD_OPE) {
                this.COD_OPE = COD_OPE;
            }
            setModified();
        }
    }
    
//============================================
// not required field

//17
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
//</comment>

// <file-operations>
    public byte[] downloadFile() {
        AnagDocumentoFileInfo info = null;
        BMPConnection bmp = getConnection();

        try {
            byte[] bt = null;
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
            ps.setLong(1, COD_DOC);
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
    }

// Inizio modifica gestione link esterno documenti
    public void uploadFileLink(String strFileName, String strContentType, byte[] content) {
        BMPConnection bmp = getConnection();

        String strOnlyName = strFileName.substring(strFileName.lastIndexOf('/') + 1, strFileName.length());
        strOnlyName = strOnlyName.substring(strOnlyName.lastIndexOf('\\') + 1, strOnlyName.length());

        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO documents (cod_doc, cod_azl, name,  content_type,  doc_size, last_updated, link_document) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DOC);
            ps.setLong(2, COD_AZL);
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
            ps.setLong(1, COD_DOC);
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
            ps.setLong(1, COD_DOC);
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
            ps.setLong(1, COD_DOC);
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
            ps.setLong(1, COD_DOC);
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

/////////////////////////////--- yniversalnie function
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
            ps.setLong(2, COD_AZL);
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
            ps.setLong(2, COD_AZL);
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

// Inizio modifica gestione link esterno documenti
// </file-operationd>
//=====================================================================<br>
///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>
//<comment description="extended setters/getters">
    public Collection ejbPRO_OPE_CAN(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "select "
                        + "b.des, "
                        + "d.nom_ope, "
                        + "c.nom_can, "
                        + "b.cod_pro, "
                        + "d.cod_ope, "
                        + "c.cod_can "
                    + "from "
                        + "ana_doc_ges_can_tab a "
                            + "left outer join "
                                + "ana_ope_tab d "
                            + "on "
                                + "a.cod_ope = d.cod_ope, "
                        + "ana_pro_tab b, "
                        + "ana_can_tab c "
                    + "where "
                        + "a.cod_pro = b.cod_pro "
                        + "and a.cod_can = c.cod_can "
                        + "and a.cod_doc = ?");
            ps.setLong(1, lCOD_DOC);
            // ps.setLong(2, COD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumentoGestioneCantieri_View obj = new AnagrDocumentoGestioneCantieri_View();

                obj.strNOM_PRO = rs.getString(1);
                obj.strNOM_OPE = rs.getString(2);
                obj.strNOM_CAN = rs.getString(3);
                obj.lCOD_PRO = rs.getLong(4);
                obj.lCOD_OPE = rs.getLong(5);
                obj.lCOD_CAN = rs.getLong(6);
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
//<search>

    public Collection findEx(long AZL_ID,
            String TIT_DOC,
            String NUM_DOC,
            java.sql.Date DAT_DOC,
            Long COD_TPL_DOC,
            Long COD_SOP,
            Long COD_OPE,
            Long COD_CAN,
            Long COD_PRO,
            String DES,
            int iOrderBy) {
        return ejbFindEx(AZL_ID,
                TIT_DOC,
                NUM_DOC,
                DAT_DOC,
                COD_TPL_DOC,
                COD_SOP,
                COD_OPE,
                COD_CAN,
                COD_PRO,
                DES,
                iOrderBy);
    }

    public Collection ejbFindEx(long AZL_ID,
            String TIT_DOC,
            String NUM_DOC,
            java.sql.Date DAT_DOC,
            Long COD_TPL_DOC,
            Long COD_SOP,
            Long COD_OPE,
            Long COD_CAN,
            Long COD_PRO,
            String DES,
            int iOrderBy) {

        String sSQL =
                "SELECT "
                    + "doc.cod_doc, "
                    + "tpl.nom_tpl_doc, "
                    + "doc.tit_doc, "
                    + "doc.num_doc, "
                    + "doc.dat_doc, "
                    + "doc.cod_tpl_doc, "
                    + "doc.cod_sop, "
                    + "doc.cod_ope, "
                    + "doc.cod_can, "
                    + "doc.cod_pro, "
                    + "doc.des "
                + "FROM "
                    + "ana_doc_ges_can_tab doc, "
                    + "tpl_doc_can_tab tpl "
                + "WHERE "
                    + "tpl.cod_tpl_doc = doc.cod_tpl_doc "
                    + "AND doc.cod_azl=? ";

        SearchHelper hlp = new SearchHelper(sSQL);

        hlp.add(COD_TPL_DOC, "doc.COD_TPL_DOC");
        hlp.add(TIT_DOC, "doc.TIT_DOC");
        hlp.add(DAT_DOC, "doc.DAT_DOC");
        hlp.add(NUM_DOC, "doc.NUM_DOC");
        hlp.add(DES, "doc.DES");
        hlp.add(COD_PRO, "doc.COD_PRO");
        hlp.add(COD_CAN, "doc.COD_CAN");
        hlp.add(COD_OPE, "doc.COD_OPE");
        
        hlp.add(COD_SOP, "doc.COD_SOP");
        hlp.orderBy(iOrderBy);

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(hlp.toString());
            ps.setLong(1, AZL_ID);
            hlp.startBind(ps, 2);
            {
                hlp.bind(COD_TPL_DOC);
                hlp.bind(TIT_DOC);
                hlp.bind(DAT_DOC);
                hlp.bind(NUM_DOC);
                hlp.bind(DES);
                hlp.bind(COD_PRO);
                hlp.bind(COD_CAN);
                hlp.bind(COD_OPE);
                
                hlp.bind(COD_SOP);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumentoGestioneCantieri_View obj = new AnagrDocumentoGestioneCantieri_View();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strNOM_TPL_DOC = rs.getString(2);
                obj.strTIT_DOC = rs.getString(3);
                obj.strNUM_DOC = rs.getString(4);
                obj.dtDAT_DOC = rs.getDate(5);
                obj.strDES = rs.getString(6);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public Collection getRSCollegati() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "doc_col.cod_ogg_col as cod_doc, "
                        + "doc_col.cod_sop, "
                        + "sop.num_sop, "
                        + "sop.dat_sop, "
                        + "sop.cod_pro, "
                        + "pro.des, "
                        + "sop.cod_can, "
                        + "can.nom_can, "
                        + "sop.cod_ope, "
                        + "ope.nom_ope "
                    + "from "
                        + "sop_col_tab doc_col, "
                        + "ana_sop_tab sop "
                            + "left outer join ana_ope_tab ope "
                                + "on (sop.cod_ope = ope.cod_ope and sop.cod_azl = ope.cod_azl), "
                        + "ana_pro_tab pro, "
                        + "ana_can_tab can "
                    + "where "
                        + "doc_col.cod_sop = sop.cod_sop "
                        + "and sop.cod_pro = pro.cod_pro "
                        + "and sop.cod_azl = pro.cod_azl "
                        + "and sop.cod_can = can.cod_can "
                        + "and sop.cod_azl = can.cod_azl "
                        + "and doc_col.cod_ogg_col = ? "
                        + "and sop.cod_azl = ?");
            
            ps.setLong(1, COD_DOC);
            ps.setLong(2, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RSCollegati_View obj = new RSCollegati_View();
                obj.COD_DOC = rs.getLong(1);
                obj.COD_SOP = rs.getLong(2);
                obj.NUM_SOP = rs.getString(3);
                obj.DAT_SOP = rs.getDate(4);
                obj.COD_PRO = rs.getLong(5);
                obj.NOM_PRO = rs.getString(6);
                obj.COD_CAN = rs.getLong(7);
                obj.NOM_CAN = rs.getString(8);
                obj.COD_OPE = rs.getLong(9);
                obj.NOM_OPE = rs.getString(10);
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

   /* public Boolean chkSTAMPA_DOC(long lCOD_DOC_TAB) {
        BMPConnection bmp = getConnection();
	Boolean bol = true;
	try {
	    PreparedStatement ps = null;
	    String str =
"select cod_sop_col from sop_col_tab where cod_sop=? and cod_ogg_col = ? ";
	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_DOC);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		bol = false;
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return bol;
    }*/

    public Boolean chkCOD_DOC(Long lCOD_DOC,Long lCOD_SOP) {
	BMPConnection bmp = getConnection();
	Boolean bol = true;
	try {
	    PreparedStatement ps = null;
	    String str =
"select cod_sop_col from sop_col_tab where cod_sop=? and cod_ogg_col = ? ";
	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_DOC);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		bol = false;
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return bol;
    }
//</search>
///////////ATTENTION!!///////////////////////////////////////////////
}
