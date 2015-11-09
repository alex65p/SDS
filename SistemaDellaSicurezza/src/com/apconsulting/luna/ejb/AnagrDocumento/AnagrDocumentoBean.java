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
package com.apconsulting.luna.ejb.AnagrDocumento;

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
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class AnagrDocumentoBean extends BMPEntityBean implements IAnagrDocumentoHome, IAnagrDocumento {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    long COD_DOC;				 //1
    String RSP_DOC;			 //2
    String APV_DOC;			 //3
    String EMS_DOC;			 //4
    String NUM_DOC;			 //5
    long EDI_DOC;				 //6
    String REV_DOC;			 //7
    java.sql.Date DAT_REV_DOC; //8
    long MES_REV_DOC;			 //9
    String TIT_DOC;			//10
    long COD_CAG_DOC;			//11
    long COD_TPL_DOC;			//12
//----------------------------
    java.sql.Date DAT_FUT_REV_DOC;//13
    String DES_REV_DOC;	    	//14
    String PRG_RIF_DOC;        	//15
    String PGN_RIF_DOC;          	//16
    long COD_LUO_FSC;            	//17
    String NOT_LUO_CON;	       	//18
    long PER_CON_YEA;	        	//19
    long COD_AZL;			    	//20
//</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static AnagrDocumentoBean ys = null;

    private AnagrDocumentoBean() {
        //
    }

    public static AnagrDocumentoBean getInstance() {
        if (ys == null) {
            ys = new AnagrDocumentoBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public IAnagrDocumento create(String strRSP_DOC, String strAPV_DOC, String strEMS_DOC, String strNUM_DOC, long lEDI_DOC, String strREV_DOC, java.sql.Date dtDAT_REV_DOC, long lMES_REV_DOC, String strTIT_DOC, long lCOD_CAG_DOC, long lCOD_TPL_DOC) throws CreateException {
        AnagrDocumentoBean bean = new AnagrDocumentoBean();
        try {
            Object primaryKey = bean.ejbCreate(strRSP_DOC, strAPV_DOC, strEMS_DOC, strNUM_DOC, lEDI_DOC, strREV_DOC, dtDAT_REV_DOC, lMES_REV_DOC, strTIT_DOC, lCOD_CAG_DOC, lCOD_TPL_DOC);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strRSP_DOC, strAPV_DOC, strEMS_DOC, strNUM_DOC, lEDI_DOC, strREV_DOC, dtDAT_REV_DOC, lMES_REV_DOC, strTIT_DOC, lCOD_CAG_DOC, lCOD_TPL_DOC);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AnagrDocumentoBean iAnagrDocumentoBean = new AnagrDocumentoBean();
        try {
            Object obj = iAnagrDocumentoBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAnagrDocumentoBean.setEntityContext(new EntityContextWrapper(obj));
            iAnagrDocumentoBean.ejbActivate();
            iAnagrDocumentoBean.ejbLoad();
            iAnagrDocumentoBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
// (Home Intrface) findByPrimaryKey()

    public IAnagrDocumento findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrDocumentoBean bean = new AnagrDocumentoBean();
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
    public Collection getAnagrDocumento_TIT_DOC_ByAZLID_View(long AZL_ID) {
        return this.ejbGetAnagrDocumento_TIT_DOC_ByAZLID_View(AZL_ID);
    }

    public Collection getView(long AZL_ID) {
        return this.ejbGetView(AZL_ID);
    }

    public Collection getAnagraficaDocumente_View(String COD_FAT_RSO) {//by Pogrebnoy Yura
        return this.ejbGetAnagraficaDocumente_View(COD_FAT_RSO);
    }
//by Juli

    public Collection getAnagrDocumento_to_SCH_DOC_View(long lCOD_AZL, String strTPL_DOC, String strCAG_DOC, String strTIT_DOC, String strRSP_DOC, String strREV_DOC, java.sql.Date dDAT_REV_D, java.sql.Date dDAT_REV_A, String strRAGGRUPPATI, String strSORT_DAT_REV, String strSORT_TPL_DOC) {
        return this.ejbGetAnagrDocumento_to_SCH_DOC_View(lCOD_AZL, strTPL_DOC, strCAG_DOC, strTIT_DOC, strRSP_DOC, strREV_DOC, dDAT_REV_D, dDAT_REV_A, strRAGGRUPPATI, strSORT_DAT_REV, strSORT_TPL_DOC);
    }
//

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAnagrDocumentoHome-implementation>
    public Long ejbCreate(String strRSP_DOC, String strAPV_DOC, String strEMS_DOC, String strNUM_DOC, long lEDI_DOC, String strREV_DOC, java.sql.Date dtDAT_REV_DOC, long lMES_REV_DOC, String strTIT_DOC, long lCOD_CAG_DOC, long lCOD_TPL_DOC) {
        this.RSP_DOC = strRSP_DOC;		//2
        this.APV_DOC = strAPV_DOC;		//3
        this.EMS_DOC = strEMS_DOC;		//4
        this.NUM_DOC = strNUM_DOC;		//5
        this.REV_DOC = strREV_DOC;		//6
        this.DAT_REV_DOC = dtDAT_REV_DOC;	//7
        this.MES_REV_DOC = lMES_REV_DOC;	//8
        this.TIT_DOC = strTIT_DOC;		//10
        this.COD_CAG_DOC = lCOD_CAG_DOC;	//11
        this.COD_TPL_DOC = lCOD_TPL_DOC;	//12
        this.COD_DOC = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_doc_tab (cod_doc,rsp_doc, apv_doc, ems_doc, num_doc, edi_doc, rev_doc, dat_rev_doc, mes_rev_doc, tit_doc, cod_cag_doc, cod_tpl_doc) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_DOC);
            ps.setString(2, RSP_DOC);
            ps.setString(3, APV_DOC);
            ps.setString(4, EMS_DOC);
            ps.setString(5, NUM_DOC);
            ps.setLong(6, EDI_DOC);
            ps.setString(7, REV_DOC);
            ps.setDate(8, DAT_REV_DOC);
            ps.setLong(9, MES_REV_DOC);
            ps.setString(10, TIT_DOC);
            ps.setLong(11, COD_CAG_DOC);
            ps.setLong(12, COD_TPL_DOC);
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
    public void ejbPostCreate(String strRSP_DOC, String strAPV_DOC, String strEMS_DOC, String strNUM_DOC, long lEDI_DOC, String strREV_DOC, java.sql.Date dtDAT_REV_DOC, long lMES_REV_DOC, String strTIT_DOC, long lCOD_CAG_DOC, long lCOD_TPL_DOC) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc FROM ana_doc_tab ");
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
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_doc_tab  WHERE cod_doc=?");
            ps.setLong(1, COD_DOC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.RSP_DOC = rs.getString("RSP_DOC");				//2
                this.APV_DOC = rs.getString("APV_DOC");				//3
                this.EMS_DOC = rs.getString("EMS_DOC");				//4
                this.NUM_DOC = rs.getString("NUM_DOC");				//5
                this.EDI_DOC = rs.getLong("EDI_DOC");					//6
                this.REV_DOC = rs.getString("REV_DOC");				//7
                this.DAT_REV_DOC = rs.getDate("DAT_REV_DOC");			//8
                this.MES_REV_DOC = rs.getLong("MES_REV_DOC");			//9
                this.TIT_DOC = rs.getString("TIT_DOC");				//10
                this.COD_CAG_DOC = rs.getLong("COD_CAG_DOC");			//11
                this.COD_TPL_DOC = rs.getLong("COD_TPL_DOC");			//12
//----------------------------
                this.DAT_FUT_REV_DOC = rs.getDate("DAT_FUT_REV_DOC");	//13
                this.DES_REV_DOC = rs.getString("DES_REV_DOC");		//14
                this.PRG_RIF_DOC = rs.getString("PRG_RIF_DOC");		//15
                this.PGN_RIF_DOC = rs.getString("PGN_RIF_DOC");		//16
                this.COD_LUO_FSC = rs.getLong("COD_LUO_FSC");			//17
                this.NOT_LUO_CON = rs.getString("NOT_LUO_CON");			//18
                this.PER_CON_YEA = rs.getLong("PER_CON_YEA");			//19
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
    }
//----------------------------------------------------------

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_doc_tab  SET rsp_doc=?, apv_doc=?,ems_doc=?,num_doc=?,edi_doc=?,rev_doc=?,dat_rev_doc=?,mes_rev_doc=?,dat_fut_rev_doc=?,des_rev_doc=?,prg_rif_doc=?,pgn_rif_doc=?,tit_doc=?,cod_cag_doc=?,cod_tpl_doc=?,cod_luo_fsc=?,not_luo_con=?,per_con_yea=?,cod_azl=?	 WHERE cod_doc=?");
            ps.setString(1, RSP_DOC);
            ps.setString(2, APV_DOC);
            ps.setString(3, EMS_DOC);
            ps.setString(4, NUM_DOC);
            ps.setLong(5, EDI_DOC);
            ps.setString(6, REV_DOC);
            ps.setDate(7, DAT_REV_DOC);
            ps.setLong(8, MES_REV_DOC);
            ps.setDate(9, DAT_FUT_REV_DOC);
            ps.setString(10, DES_REV_DOC);
            ps.setString(11, PRG_RIF_DOC);
            ps.setString(12, PGN_RIF_DOC);
            ps.setString(13, TIT_DOC);
            ps.setLong(14, COD_CAG_DOC);
            ps.setLong(15, COD_TPL_DOC);
            if (COD_LUO_FSC == 0) {
                ps.setNull(16, java.sql.Types.BIGINT);
            } else {
                ps.setLong(16, COD_LUO_FSC);
            }
            ps.setString(17, NOT_LUO_CON);
            if (PER_CON_YEA == 0) {
                ps.setNull(18, java.sql.Types.BIGINT);
            } else {
                ps.setLong(18, PER_CON_YEA);
            }
            if (COD_AZL == 0) {
                ps.setNull(19, java.sql.Types.BIGINT);
            } else {
                ps.setLong(19, COD_AZL);
            }
            ps.setLong(20, COD_DOC);
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
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
//1
    public long getCOD_DOC() {
        return COD_DOC;
    }
//2

    public void setRSP_DOC(String newRSP_DOC) {
        if (RSP_DOC != null) {
            if (RSP_DOC.equals(newRSP_DOC)) {
                return;
            }
        }
        RSP_DOC = newRSP_DOC;
        setModified();
    }

    public String getRSP_DOC() {
        return (RSP_DOC != null) ? RSP_DOC : "";
    }
//3

    public void setAPV_DOC(String newAPV_DOC) {
        if (APV_DOC != null) {
            if (APV_DOC.equals(newAPV_DOC)) {
                return;
            }
        }
        APV_DOC = newAPV_DOC;
        setModified();
    }

    public String getAPV_DOC() {
        return (APV_DOC != null) ? APV_DOC : "";
    }
//4

    public void setEMS_DOC(String newEMS_DOC) {
        if (EMS_DOC != null) {
            if (EMS_DOC.equals(newEMS_DOC)) {
                return;
            }
        }
        EMS_DOC = newEMS_DOC;
        setModified();
    }

    public String getEMS_DOC() {
        return (EMS_DOC != null) ? EMS_DOC : "";
    }
//5

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
//6

    public void setEDI_DOC__TIT_DOC(long newEDI_DOC, String newTIT_DOC) {
        if ((EDI_DOC == newEDI_DOC) && (TIT_DOC.equals(newTIT_DOC))) {
            return;
        }
        EDI_DOC = newEDI_DOC;
        if (TIT_DOC != null) {
            TIT_DOC = newTIT_DOC;
        }
        setModified();
    }

    public long getEDI_DOC() {
        return EDI_DOC;
    }
//7

    public void setREV_DOC(String newREV_DOC) {
        if (REV_DOC != null) {
            if (REV_DOC.equals(newREV_DOC)) {
                return;
            }
        }
        REV_DOC = newREV_DOC;
        setModified();
    }

    public String getREV_DOC() {
        return (REV_DOC != null) ? REV_DOC : "";
    }
//8

    public void setDAT_REV_DOC(java.sql.Date newDAT_REV_DOC) {
        if (DAT_REV_DOC != null) {
            if (DAT_REV_DOC.equals(newDAT_REV_DOC)) {
                return;
            }
        }
        DAT_REV_DOC = newDAT_REV_DOC;
        setModified();
    }

    public java.sql.Date getDAT_REV_DOC() {
        return DAT_REV_DOC;
    }
//9

    public void setMES_REV_DOC(long newMES_REV_DOC) {
        if (EDI_DOC == newMES_REV_DOC) {
            return;
        }
        MES_REV_DOC = newMES_REV_DOC;
        setModified();
    }

    public long getMES_REV_DOC() {
        return MES_REV_DOC;
    }
//10 unic with edi_doc

    public String getTIT_DOC() {
        return (TIT_DOC != null) ? TIT_DOC : "";
    }
//11

    public void setCOD_CAG_DOC(long newCOD_CAG_DOC) {
        if (COD_CAG_DOC == newCOD_CAG_DOC) {
            return;
        }
        COD_CAG_DOC = newCOD_CAG_DOC;
        setModified();
    }

    public long getCOD_CAG_DOC() {
        return COD_CAG_DOC;
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
//============================================
// not required field

//13
    public void setDAT_FUT_REV_DOC(java.sql.Date newDAT_FUT_REV_DOC) {
        if (DAT_FUT_REV_DOC != null) {
            if (DAT_FUT_REV_DOC.equals(newDAT_FUT_REV_DOC)) {
                return;
            }
        }
        DAT_FUT_REV_DOC = newDAT_FUT_REV_DOC;
        setModified();
    }

    public java.sql.Date getDAT_FUT_REV_DOC() {
        return DAT_FUT_REV_DOC;
    }
//14

    public void setDES_REV_DOC(String strDES_REV_DOC) {
        if ((this.DES_REV_DOC != null) && (this.DES_REV_DOC.equals(strDES_REV_DOC))) {
            return;
        }
        this.DES_REV_DOC = strDES_REV_DOC;
        setModified();
    }

    public String getDES_REV_DOC() {
        return (DES_REV_DOC != null) ? DES_REV_DOC : "";
    }
//15

    public void setPRG_RIF_DOC(String newPRG_RIF_DOC) {
        if (PRG_RIF_DOC != null) {
            if (PRG_RIF_DOC.equals(newPRG_RIF_DOC)) {
                return;
            }
        }
        PRG_RIF_DOC = newPRG_RIF_DOC;
        setModified();
    }

    public String getPRG_RIF_DOC() {
        return (PRG_RIF_DOC != null) ? PRG_RIF_DOC : "";
    }
//16

    public void setPGN_RIF_DOC(String newPGN_RIF_DOC) {
        if (PGN_RIF_DOC != null) {
            if (PGN_RIF_DOC.equals(newPGN_RIF_DOC)) {
                return;
            }
        }
        PGN_RIF_DOC = newPGN_RIF_DOC;
        setModified();
    }

    public String getPGN_RIF_DOC() {
        return (PGN_RIF_DOC != null) ? PGN_RIF_DOC : "";
    }
//17

    public void setCOD_LUO_FSC(long newCOD_LUO_FSC) {
        if (COD_LUO_FSC == newCOD_LUO_FSC) {
            return;
        }
        COD_LUO_FSC = newCOD_LUO_FSC;
        setModified();
    }

    public long getCOD_LUO_FSC() {
        return COD_LUO_FSC;
    }
//18

    public void setNOT_LUO_CON(String newNOT_LUO_CON) {
        if (NOT_LUO_CON != null) {
            if (NOT_LUO_CON.equals(newNOT_LUO_CON)) {
                return;
            }
        }
        NOT_LUO_CON = newNOT_LUO_CON;
        setModified();
    }

    public String getNOT_LUO_CON() {
        return (NOT_LUO_CON != null) ? NOT_LUO_CON : "";
    }
//19

    public void setPER_CON_YEA(long newPER_CON_YEA) {
        if (PER_CON_YEA == newPER_CON_YEA) {
            return;
        }
        PER_CON_YEA = newPER_CON_YEA;
        setModified();
    }

    public long getPER_CON_YEA() {
        return PER_CON_YEA;
    }
//20

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
            PreparedStatement ps;
            if(strNOM_TAB.equals("")){
            ps = bmp.prepareStatement("SELECT content  FROM documents WHERE cod_doc=? AND nom_tab is null and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);}
 else{
            ps = bmp.prepareStatement("SELECT content  FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);}
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
            PreparedStatement ps;
            if(strNOM_TAB.equals("")){
            ps = bmp.prepareStatement("SELECT link_document FROM documents WHERE cod_doc=? and nom_tab is null and link_document is not null");
            ps.setLong(1, lCOD_DOC_TAB);}
 else{
            ps = bmp.prepareStatement("SELECT link_document FROM documents WHERE cod_doc=? and nom_tab = ? and link_document is not null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);
 }
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
            PreparedStatement ps;
            if(strNOM_TAB.equals("")){
            ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? AND nom_tab is null and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            }else{
            ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is null");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);}
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
            PreparedStatement ps;
            if(strNOM_TAB.equals("")){
            ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated, link_document FROM documents WHERE cod_doc=? AND nom_tab is null and link_document is not null ");
            ps.setLong(1, lCOD_DOC_TAB);}
                else{
            ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated, link_document FROM documents WHERE cod_doc=? AND nom_tab=? and link_document is not null ");
            ps.setLong(1, lCOD_DOC_TAB);
            ps.setString(2, strNOM_TAB);}
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
    public Collection ejbGetView(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "ana_doc_tab.cod_doc,  "
                    + "ana_doc_tab.tit_doc, "
                    + "ana_doc_tab.num_doc, "
                    + "cag_doc_tab.nom_cag_doc "
                    + "FROM "
                    + "ana_doc_tab, "
                    + "cag_doc_tab "
                    + "WHERE "
                    + "cag_doc_tab.cod_cag_doc = ana_doc_tab.cod_cag_doc "
                    + "AND "
                    + "ana_doc_tab.cod_azl = ? "
                    + "ORDER BY 2");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumento_View obj = new AnagrDocumento_View();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strTIT_DOC = rs.getString(2);
                obj.strNUM_DOC = rs.getString(3);
                obj.strNOM_CAG_DOC = rs.getString(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//<search>
    public Collection findEx(long AZL_ID,
            String RSP_DOC, String EMS_DOC, String NUM_DOC,
            Long EDI_DOC, java.sql.Date DAT_REV_DOC, Long MES_REV_DOC,
            String TIT_DOC, Long COD_CAG_DOC,
            Long COD_TPL_DOC, java.sql.Date DAT_FUT_REV_DOC,
            String PRG_RIF_DOC, String PGN_RIF_DOC,
            Long COD_LUO_FSC, String NOT_LUO_CON,
            Long PER_CON_YEA,
            int iOrderBy) {
        return ejbFindEx(AZL_ID,
                RSP_DOC, EMS_DOC, NUM_DOC,
                EDI_DOC, DAT_REV_DOC, MES_REV_DOC,
                TIT_DOC, COD_CAG_DOC,
                COD_TPL_DOC, DAT_FUT_REV_DOC,
                PRG_RIF_DOC, PGN_RIF_DOC,
                COD_LUO_FSC, NOT_LUO_CON,
                PER_CON_YEA, iOrderBy);
    }

    public Collection ejbFindEx(long AZL_ID,
            String RSP_DOC, String EMS_DOC, String NUM_DOC,
            Long EDI_DOC, java.sql.Date DAT_REV_DOC, Long MES_REV_DOC,
            String TIT_DOC, Long COD_CAG_DOC,
            Long COD_TPL_DOC, java.sql.Date DAT_FUT_REV_DOC,
            String PRG_RIF_DOC, String PGN_RIF_DOC,
            Long COD_LUO_FSC, String NOT_LUO_CON,
            Long PER_CON_YEA,
            int iOrderBy) {

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

        if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_MSR)){
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
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumento_View obj = new AnagrDocumento_View();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strTIT_DOC = rs.getString(2);
                obj.strNUM_DOC = rs.getString(3);
                obj.strNOM_CAG_DOC = rs.getString(4);
                obj.dtDAT_REV_DOC = rs.getDate(5);
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
//</search>

    public Collection ejbGetAnagrDocumento_TIT_DOC_ByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_doc, tit_doc FROM ana_doc_tab WHERE cod_azl=? ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumento_TIT_DOC_ByAZLID_View obj = new AnagrDocumento_TIT_DOC_ByAZLID_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getDestinatarioDocumentoView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_lst_dsi_doc, nom_dsi_esr, dat_csg_doc_dsi FROM lst_dsi_doc_tab WHERE cod_doc=? ");
            ps.setLong(1, COD_DOC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DestinatarioDocumento_Destinatario_Consegna_View w = new DestinatarioDocumento_Destinatario_Consegna_View();
                w.lCOD_LST_DSI_DOC = rs.getLong(1);
                w.strNOM_DSI_ESR = rs.getString(2);
                w.dtDAT_CSG_DOC_DSI = rs.getDate(3);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetAnagraficaDocumente_View(String COD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.rsp_doc,a.dat_rev_doc,a.tit_doc,a.cod_doc FROM ana_doc_tab a, doc_fat_rso_tab b WHERE a.cod_doc=b.cod_doc AND b.cod_fat_rso=? ");
            ps.setString(1, COD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Documente_View obj = new Documente_View();
                obj.COD_DOC = rs.getLong(4);
                obj.RSP_DOC = rs.getString(1);
                obj.DAT_REV_DOC = rs.getDate(2);
                obj.TIT_DOC = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    /*    REPORT      */

    public Collection getDocDestinatari_List_View() {
        BMPConnection bmp = getConnection();
        try {
// @TODO Sistemare la query per db2
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getAnagraficaDocumentoQUERY());
            ps.setLong(1, this.COD_DOC);
            ps.setLong(2, this.COD_DOC);
            ps.setLong(3, this.COD_DOC);
            ps.setLong(4, this.COD_DOC);
            ps.setLong(5, this.COD_DOC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DOC_Destinatari_View obj = new DOC_Destinatari_View();
                obj.COD_DOC = rs.getLong(1);
                obj.DESTINATARI_A = rs.getString(2);
                obj.DESTINATARI_B = rs.getString(3);
                obj.DESTINATARI_C = rs.getString(4);
                obj.DESTINATARI_D = rs.getString(5);
                obj.DESTINATARI_E = rs.getString(6);
                obj.DAT_CONSEGNA = rs.getDate(7);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//--- Juli
    public Collection ejbGetAnagrDocumento_to_SCH_DOC_View(long lCOD_AZL, String strTPL_DOC, String strCAG_DOC, String strTIT_DOC, String strRSP_DOC, String strREV_DOC, java.sql.Date dDAT_REV_D, java.sql.Date dDAT_REV_A, String strRAGGRUPPATI, String strSORT_DAT_REV, String strSORT_TPL_DOC) {
        int icounterWhere = 2;
        int iCOUNT_COD_DOC = 0;
        int iCOUNT_TPL_DOC = 0;
        int iCOUNT_CAG_DOC = 0;
        int iCOUNT_TIT_DOC = 0;
        int iCOUNT_RSP_DOC = 0;
        int iCOUNT_REV_DOC = 0;
        int iCOUNT_DAT_REV_D = 0;
        int iCOUNT_DAT_REV_A = 0;
        int iSORT_BY = 0;
        String strSELECT = "", strFROM = "", strWHERE = "", strGROUP = "";
//--- Tipologia
        if (!strTPL_DOC.equals("")) {
            iCOUNT_TPL_DOC = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND UPPER(b.nom_tpl_doc)  like ? ";
        }
//--- Categoria
        if (!strCAG_DOC.equals("")) {
            iCOUNT_CAG_DOC = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND UPPER(c.nom_cag_doc)  like ? ";
        }
//--- Titolo
        if (!strTIT_DOC.equals("")) {
            iCOUNT_TIT_DOC = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND UPPER(a.tit_doc)  like ? ";
        }
//--- Responsabile
        if (!strRSP_DOC.equals("")) {
            iCOUNT_RSP_DOC = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND UPPER(a.rsp_doc)  like ? ";
        }
//--- Revisione
        if (!strREV_DOC.equals("")) {
            iCOUNT_REV_DOC = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND UPPER(a.rev_doc)  like ? ";
        }
//--- DATA
        if ((dDAT_REV_D != null) && (dDAT_REV_A != null)) {
            iCOUNT_DAT_REV_D = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_REV_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_rev_doc BETWEEN ? AND ? ";
        }
        if ((dDAT_REV_D != null) && (dDAT_REV_A == null)) {
            iCOUNT_DAT_REV_D = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_rev_doc >= ? ";
        }
        if ((dDAT_REV_D == null) && (dDAT_REV_A != null)) {
            iCOUNT_DAT_REV_A = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_rev_doc <= ? ";
        }
//*** ORDER ***//
//--- Raggruppati = N
        strSORT_DAT_REV = strSORT_DAT_REV.replaceAll("\'", "\\\"");
        strSORT_TPL_DOC = strSORT_TPL_DOC.replaceAll("\'", "\\\"");
        if (strRAGGRUPPATI.equals("N")) {
            String strVAL_SORT_DAT_REV = "";
            String strVAL_SORT_TPL_DOC = "";

            if (strSORT_DAT_REV == "") {
                strVAL_SORT_DAT_REV = "X";
            } else {
                strVAL_SORT_DAT_REV = strSORT_DAT_REV;
            }
            if (strSORT_TPL_DOC == "") {
                strVAL_SORT_TPL_DOC = "X";
            } else {
                strVAL_SORT_TPL_DOC = strSORT_TPL_DOC;
            }

            if ((strVAL_SORT_DAT_REV.equals("X")) && (strVAL_SORT_TPL_DOC.equals("X"))) {
                strSORT_DAT_REV = strSORT_DAT_REV.replaceAll(",", " ");
                strGROUP = "ORDER BY DAT_REV_DOC";
                ;
            } else if ((!strVAL_SORT_DAT_REV.equals("X")) && (strVAL_SORT_TPL_DOC.equals("X"))) {
                strSORT_DAT_REV = strSORT_DAT_REV.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_DAT_REV;
            } else if ((strVAL_SORT_DAT_REV.equals("X")) && (!strVAL_SORT_TPL_DOC.equals("X"))) {
                strSORT_TPL_DOC = strSORT_TPL_DOC.replaceAll(",", " ");
                strGROUP = "ORDER BY " + strSORT_TPL_DOC;
            }
        }
//--- Raggruppati = A
        if (strRAGGRUPPATI.equals("A")) {
            strGROUP = " ORDER BY d.rag_scl_azl ";
            if (strSORT_DAT_REV.equals("X")) {
                strSORT_DAT_REV = "";
            }
            if (strSORT_TPL_DOC.equals("X")) {
                strSORT_TPL_DOC = "";
            }
            strGROUP = strGROUP + strSORT_DAT_REV + strSORT_TPL_DOC;
        }
//--- Raggruppati = C
        if (strRAGGRUPPATI.equals("C")) {
            strGROUP = " ORDER BY c.nom_cag_doc ";
            if (strSORT_DAT_REV.equals("X")) {
                strSORT_DAT_REV = "";
            }
            if (strSORT_TPL_DOC.equals("X")) {
                strSORT_TPL_DOC = "";
            }
            strGROUP = strGROUP + strSORT_DAT_REV + strSORT_TPL_DOC;
        }

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_doc, a.cod_tpl_doc, a.cod_cag_doc ,a.dat_rev_doc, b.nom_tpl_doc ,c.nom_cag_doc ,d.rag_scl_azl FROM ana_doc_tab a, tpl_doc_tab b ,cag_doc_tab c, ana_azl_tab d " + strFROM + " WHERE a.cod_tpl_doc = b.cod_tpl_doc AND a.cod_cag_doc = c.cod_cag_doc AND a.cod_azl = d.cod_azl AND d.cod_azl=? " + strWHERE + " " + strGROUP);
            ps.setLong(1, lCOD_AZL);
//if (iCOUNT_COD_DOC!=0) ps.setLong(iCOUNT_COD_DOC, iCOUNT_COD_DOC);
            if (iCOUNT_TPL_DOC != 0) {
                ps.setString(iCOUNT_TPL_DOC, strTPL_DOC.toUpperCase() + '%');
            }
            if (iCOUNT_CAG_DOC != 0) {
                ps.setString(iCOUNT_CAG_DOC, strCAG_DOC.toUpperCase() + '%');
            }
            if (iCOUNT_TIT_DOC != 0) {
                ps.setString(iCOUNT_TIT_DOC, strTIT_DOC.toUpperCase() + '%');
            }
            if (iCOUNT_RSP_DOC != 0) {
                ps.setString(iCOUNT_RSP_DOC, strRSP_DOC.toUpperCase() + '%');
            }
            if (iCOUNT_REV_DOC != 0) {
                ps.setString(iCOUNT_REV_DOC, strREV_DOC.toUpperCase() + '%');
            }
            if (iCOUNT_DAT_REV_D != 0) {
                ps.setDate(iCOUNT_DAT_REV_D, dDAT_REV_D);
            }
            if (iCOUNT_DAT_REV_A != 0) {
                ps.setDate(iCOUNT_DAT_REV_A, dDAT_REV_A);
            }

            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDocumento_to_SCH_DOC_View obj = new AnagrDocumento_to_SCH_DOC_View();
                obj.COD_DOC = rs.getLong(1);
                obj.COD_TPL_DOC = rs.getLong(2);
                obj.COD_CAG_DOC = rs.getLong(3);
                obj.DAT_REV_DOC = rs.getDate(4);
                obj.NOM_TPL_DOC = rs.getString(5);
                obj.NOM_CAG_DOC = rs.getString(6);
                obj.RAG_SCL_AZL = rs.getString(7);
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

    public void updateMtrCogNom_DOC(String strMTR_DPD_old, String strCOG_DPD_old, String strNOM_DPD_old, String strMTR_DPD, String strCOG_DPD, String strNOM_DPD) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps1 = bmp.prepareStatement(
                    "UPDATE "
                    + "ana_doc_tab "
                    + "SET "
                    + "rsp_doc = ? "
                    + "WHERE "
                    + "UPPER(rsp_doc) = ?");

            PreparedStatement ps2 = bmp.prepareStatement(
                    "UPDATE "
                    + "ana_doc_tab "
                    + "SET "
                    + "apv_doc = ? "
                    + "WHERE "
                    + "UPPER(apv_doc) = ?");

            PreparedStatement ps3 = bmp.prepareStatement(
                    "UPDATE "
                    + "ana_doc_tab "
                    + "SET "
                    + "ems_doc = ? "
                    + "WHERE "
                    + "UPPER(ems_doc) = ?");

            String oldValue = strMTR_DPD_old.concat(" ").concat(strCOG_DPD_old).concat(" ").concat(strNOM_DPD_old).toUpperCase();
            String newValue = strMTR_DPD.concat(" ").concat(strCOG_DPD).concat(" ").concat(strNOM_DPD).toUpperCase();

            ps1.setString(1, newValue);
            ps1.setString(2, oldValue);
            ps2.setString(1, newValue);
            ps2.setString(2, oldValue);
            ps3.setString(1, newValue);
            ps3.setString(2, oldValue);

            ps1.executeUpdate();
            ps2.executeUpdate();
            ps3.executeUpdate();

            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//
///////////ATTENTION!!///////////////////////////////////////////////
}
