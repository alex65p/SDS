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
package com.apconsulting.luna.ejb.Sopraluogo;

import com.apconsulting.luna.ejb.Media.jbMedia;
import java.sql.Blob;
import java.sql.Date;
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
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class SopraluogoBean extends BMPEntityBean implements ISopraluogoHome, ISopraluogo {

    long COD_SOP;
    long COD_AZL;
    String NUM_SOP;
    long COD_PRO;
    long COD_OPE;
    long COD_CAN;
    java.sql.Date DAT_SOP;
    java.sql.Time ORA_INI;
    java.sql.Time ORA_FIN;
    short ESITO;
    java.sql.Date DAT_FER_LAV;
    java.sql.Date DAT_RIP_LAV;
    String DIS_GEN;
    ////////////////////// CONSTRUCTOR///////////////////
    private static SopraluogoBean ys = null;

    private SopraluogoBean() {
    }

    public static SopraluogoBean getInstance() {
	if (ys == null) {
	    ys = new SopraluogoBean();
	}
	return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public ISopraluogo create(long lCOD_AZL, long lCOD_PRO, long lCOD_OPE, long lCOD_CAN, java.sql.Date dtDAT_SOP, String sNUM_SOP, java.sql.Time tORA_INI, java.sql.Time tORA_FIN) throws CreateException {
	SopraluogoBean bean = new SopraluogoBean();
	try {
	    Object primaryKey = bean.ejbCreate(lCOD_AZL, lCOD_PRO, lCOD_OPE, lCOD_CAN, dtDAT_SOP, sNUM_SOP, tORA_INI, tORA_FIN);
	    bean.setEntityContext(new EntityContextWrapper(primaryKey));
	    bean.ejbPostCreate(lCOD_AZL, lCOD_CAN, dtDAT_SOP, sNUM_SOP);
	    return bean;
	} catch (Exception ex) {
	    throw new javax.ejb.CreateException(ex.getMessage());
	}
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
	SopraluogoBean sopraluogo = new SopraluogoBean();
	try {
	    Object obj = sopraluogo.ejbFindByPrimaryKey((Long) primaryKey);
	    sopraluogo.setEntityContext(new EntityContextWrapper(obj));
	    sopraluogo.ejbActivate();
	    sopraluogo.ejbLoad();
	    sopraluogo.ejbRemove();
	} catch (Exception ex) {
	    throw new EJBException(ex.getMessage());
	}
    }

    public void removeDPD(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveDPD(lCOD_SOP, lCOD_DPD, lCOD_AZL);
    }

    public void removeDPDImp(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveDPDImp(lCOD_SOP, lCOD_DPD, lCOD_AZL);
    }

    public void removeCONDIS(Long lCOD_SOP_CST) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveCONDIS(lCOD_SOP_CST);
    }

    public void removeDOC_GES_CAN_SOP(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveDOC_GES_CAN_SOP(lCOD_SOP, lCOD_DPD, lCOD_AZL);
    }

    public void removeCOLLEGAMENTO(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveCOLLEGAMENTO(lCOD_SOP, lCOD_DPD, lCOD_AZL);
    }

    public void ejbRemoveCOLLEGAMENTO(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM sop_col_tab WHERE (cod_sop=? AND cod_ogg_col=?)");
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_DPD);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Errore cancellazione collegamento");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }
    
    public void ejbRemoveDOC_GES_CAN_SOP(Long lCOD_SOP, Long lCOD_DOC, Long lCOD_AZL) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ges_can_sop_tab  WHERE  (cod_doc=? AND cod_sop=? AND cod_azl=?)");
	    ps.setLong(1, lCOD_DOC);
	    ps.setLong(2, lCOD_SOP);
	    ps.setLong(3, lCOD_AZL);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Documento associato non è  annulata");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public void removeMEDIA(Long lCOD_MED) {
	SopraluogoBean bean = new SopraluogoBean();
	bean.ejbRemoveMEDIA(lCOD_MED);
    }

    public void ejbRemoveMEDIA(Long lCOD_MED) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_med_tab WHERE cod_med=?");
	    ps.setLong(1, lCOD_MED);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Errore cancellazione media");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public ISopraluogo findByPrimaryKey(Long primaryKey) throws FinderException {
	SopraluogoBean bean = new SopraluogoBean();
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

//    public void deleteSopraluogo(long newCOD_SOP, long newCOD_COU) {
//        SopraluogoBean bean = new SopraluogoBean();
//        bean.ejbHomeDeleteSopraluogo(newCOD_SOP, newCOD_COU);
//    }
///////////////////////////////////////////////////
    public Collection findEx(Long COD_AZL,
	    Long COD_PRO, Long COD_OPE, Long COD_CAN,
	    String NUM_SOP, Date dDAT_SOP, Short ESITO) {
	return (new SopraluogoBean()).ejbfindEx(
		COD_AZL,
		COD_PRO, COD_OPE, COD_CAN,
		NUM_SOP, dDAT_SOP, ESITO);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAziendaHome-implementation>
    public Long ejbCreate(long lCOD_AZL, long lCOD_PRO, long lCOD_OPE, long lCOD_CAN, java.sql.Date dtDAT_SOP, String sNUM_SOP, java.sql.Time tORA_INI, java.sql.Time tORA_FIN) {
	this.COD_AZL = lCOD_AZL;
	this.COD_PRO = lCOD_PRO;
	this.COD_OPE = lCOD_OPE;
	this.COD_CAN = lCOD_CAN;
	this.DAT_SOP = dtDAT_SOP;
	this.NUM_SOP = sNUM_SOP;
	this.ORA_INI = tORA_INI;
	this.ORA_FIN = tORA_FIN;
	this.COD_SOP = NEW_ID(); // unic ID        
	this.unsetModified();
	BMPConnection bmp = getConnection();
	bmp.beginTrans();
	try {
	    PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO "
                        + "ana_sop_tab "
                        + "(cod_azl,cod_sop, cod_can,dat_sop, num_sop,ora_ini, "
                        + "ora_fin,cod_pro,cod_ope) "
                    + "VALUES"
                        + "(?,?,?,?,?,?,?,?,?)");
	    ps.setLong(1, COD_AZL);
	    ps.setLong(2, COD_SOP);
	    ps.setLong(3, COD_CAN);
	    ps.setDate(4, DAT_SOP);
	    ps.setString(5, NUM_SOP);
	    ps.setTime(6, ORA_INI);
	    ps.setTime(7, ORA_FIN);
	    ps.setLong(8, COD_PRO);
	    if (COD_OPE != 0){
                ps.setLong(9, COD_OPE);
            } else {
                ps.setNull(9, java.sql.Types.BIGINT);
            }
	    ps.executeUpdate();

	    registerSecurityObject(bmp, COD_SOP, COD_AZL, COD_AZL != 0);
	    bmp.commitTrans();
	    return new Long(COD_SOP);
	} catch (Exception ex) {
            ex.printStackTrace();
	    bmp.rollbackTrans();
	    throw new EJBException(ex.getMessage());
	} finally {
	    bmp.close();
	}
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_AZL, long lCOD_CAN, java.sql.Date dtDAT_SOP, String sNUM_SOP) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("SELECT cod_sop FROM ana_sop_tab ");

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
	this.COD_SOP = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
	this.COD_SOP = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
	BMPConnection bmp = getConnection();
	try {
	    String str =
		    "select "
                        + "sop.num_sop, "
                        + "pro.cod_pro, "
                        + "ope.cod_ope, "
                        + "sop.cod_azl, "
                        + "sop.cod_can, "
                        + "sop.dat_sop, "
                        + "sop.ora_ini, "
                        + "sop.ora_fin, "
                        + "sop.esito, "
                        + "sop.dat_fer_lav, "
                        + "sop.dat_rip_lav, "
                        + "sop.cod_sop, "
                        + "can.nom_can, "
                        + "ope.nom_ope "
		    + "from "
                        + "ana_sop_tab sop "
                            + "left outer join "
                                + "ana_ope_tab ope "
                            + "on "
                                + "sop.cod_ope=ope.cod_ope "
                                + "and sop.cod_azl=ope.cod_azl, "
                        + "ana_pro_tab pro, "
                        + "ana_can_tab can "
		    + "where "
                        + "sop.cod_sop = ? "
                        + "and sop.cod_pro=pro.cod_pro "
                        + "and sop.cod_azl=pro.cod_azl "
                        + "and sop.cod_can=can.cod_can "
                        + "and sop.cod_azl=can.cod_azl";

	    PreparedStatement ps = bmp.prepareStatement(str);

	    ps.setLong(1, COD_SOP);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		this.COD_AZL = rs.getLong("COD_AZL");
		this.COD_SOP = rs.getLong("COD_SOP");
		this.NUM_SOP = rs.getString("NUM_SOP");
		this.COD_PRO = rs.getLong("COD_PRO");
		this.COD_OPE = rs.getLong("COD_OPE");
		this.COD_CAN = rs.getLong("COD_CAN");
		this.DAT_SOP = rs.getDate("DAT_SOP");

		this.ORA_INI = rs.getTime("ORA_INI");
		this.ORA_FIN = rs.getTime("ORA_FIN");
		this.ESITO = rs.getShort("ESITO");
		this.DAT_FER_LAV = rs.getDate("DAT_FER_LAV");
		this.DAT_RIP_LAV = rs.getDate("DAT_RIP_LAV");
	    } else {
		throw new NoSuchEntityException("Sopralluogo con ID=" + COD_SOP + " non è trovato");
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
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sop_tab WHERE cod_sop=?");
	    ps.setLong(1, COD_SOP);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Sopralluogo con ID=" + COD_SOP + " non è trovato");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public void ejbRemoveDPD(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM sop_dpd_tab WHERE cod_sop=? and cod_dpd=? and cod_azl=?");
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_DPD);
	    ps.setLong(3, lCOD_AZL);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Errore cancellazione connessione Sopralluogo Dipendente");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public void ejbRemoveDPDImp(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM sop_dpd_imp_tab WHERE cod_sop=? and cod_dpd=? and cod_azl=?");
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_DPD);
	    ps.setLong(3, lCOD_AZL);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Errore cancellazione connessione Sopralluogo Dipendente");
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public void ejbRemoveCONDIS(Long lCOD_SOP_CST) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM sop_cst_tab WHERE cod_sop_cst=?");
	    ps.setLong(1, lCOD_SOP_CST);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Errore cancellazione connessione Sopralluogo Constatazione");
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
	    PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE "
                        + "ana_sop_tab "
                    + "SET "
                        + "cod_can=?, "
                        + "dat_sop=?, "
                        + "num_sop=?, "
                        + "ora_ini=?, "
                        + "ora_fin=?, "
                        + "esito=?, "
                        + "dat_fer_lav=?, "
                        + "dat_rip_lav=?, "
                        + "cod_pro=?, "
                        + "cod_ope=? "
                    + "where "
                        + "cod_sop=?");
	    ps.setLong(1, COD_CAN);
	    ps.setDate(2, DAT_SOP);
	    ps.setString(3, NUM_SOP);
	    ps.setTime(4, ORA_INI);
	    ps.setTime(5, ORA_FIN);
	    ps.setShort(6, ESITO);
	    ps.setDate(7, DAT_FER_LAV);
	    ps.setDate(8, DAT_RIP_LAV);
	    ps.setLong(9, COD_PRO);
	    if (COD_OPE != 0){
                ps.setLong(10, COD_OPE);
            } else {
                ps.setNull(10, java.sql.Types.BIGINT);
            }
	    ps.setLong(11, COD_SOP);
            
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Sopralluogo con ID=" + COD_SOP + " non è trovato");
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

    public long getCOD_SOP() {
	return COD_SOP;
    }

    public long getCOD_AZL() {
	return COD_SOP;
    }

    public String getNUM_SOP() {
	return NUM_SOP;
    }

    public void setNUM_SOP(String num) {
	if (NUM_SOP != null && NUM_SOP.equals(num)) {
	    return;
	}
	NUM_SOP = num;
	setModified();
    }

    public long getCOD_PRO() {
	return COD_PRO;
    }

    public long getCOD_OPE() {
	return COD_OPE;
    }

    public long getCOD_CAN() {
	return COD_CAN;
    }

    public void setCOD_PRO(long cod_pro) {
	if (COD_PRO == cod_pro) {
	    return;
	}
	COD_PRO = cod_pro;
	setModified();
    }

    public void setCOD_OPE(long cod_ope) {
	if (COD_OPE == cod_ope) {
	    return;
	}
	COD_OPE = cod_ope;
	setModified();
    }

    public void setCOD_CAN(long cod_can) {
	if (COD_CAN == cod_can) {
	    return;
	}
	COD_CAN = cod_can;
	setModified();
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

    public java.sql.Date getDAT_SOP() {
	return DAT_SOP;
    }

    public void setDAT_SOP(java.sql.Date data) {
	if (this.DAT_SOP == data) {
	    return;
	}
	this.DAT_SOP = data;
	setModified();
    }

    public java.sql.Time getORA_INI() {
	return ORA_INI;
    }

    public void setORA_INI(java.sql.Time time) {
	if (this.ORA_INI == time) {
	    return;
	}
	this.ORA_INI = time;
	setModified();
    }

    public java.sql.Time getORA_FIN() {
	return ORA_FIN;
    }

    public void setORA_FIN(java.sql.Time time) {
	if (this.ORA_FIN == time) {
	    return;
	}
	this.ORA_FIN = time;
	setModified();
    }

    public short getESITO() {
	return ESITO;
    }

    public void setESITO(short esito) {
	if (ESITO == esito) {
	    return;
	}
	ESITO = esito;
	setModified();
    }

    public java.sql.Date getDAT_FER_LAV() {
	return DAT_FER_LAV;
    }

    public void setDAT_FER_LAV(java.sql.Date data) {
	if (this.DAT_FER_LAV == data) {
	    return;
	}
	this.DAT_FER_LAV = data;
	setModified();
    }

    public java.sql.Date getDAT_RIP_LAV() {
	return DAT_RIP_LAV;
    }

    public void setDAT_RIP_LAV(java.sql.Date data) {
	if (this.DAT_RIP_LAV == data) {
	    return;
	}
	this.DAT_RIP_LAV = data;
	setModified();
    }

    public long getSopraluoghiCount() {
	String strSql = "select count(COD_SOL) from ana_sol_tab";

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

    public String getDIS_GEN() {
	return DIS_GEN;
    }

    public void setDIS_GEN(String sDisGen) {
	if (this.DIS_GEN != null && this.DIS_GEN.equals(sDisGen)) {
	    return;
	}
	this.DIS_GEN = sDisGen;
	setModified();
    }

//////////////////////////////<findEx>/////////////////////////////////////////
    public Collection ejbfindEx(
	    Long lCOD_AZL,
	    Long lCOD_PRO, Long lCOD_OPE, Long lCOD_CAN,
	    String sNUM_SOP, Date dDAT_SOP, Short sESITO) {

	BMPConnection bmp = getConnection();
	String Sql =
		"select "
                    + "sop.cod_sop, "
                    + "pro.des, "
                    + "can.nom_can, "
                    + "ope.nom_ope, "
                    + "sop.num_sop, "
                    + "sop.dat_sop "
		+ " from "
                    + "ana_sop_tab sop "
                        + "left outer join "
                            + "ana_ope_tab ope "
                        + "on "
                            + "sop.cod_ope = ope.cod_ope "
                            + "and sop.cod_azl = ope.cod_azl, "
                    + "ana_pro_tab pro, "
                    + "ana_can_tab can "
		+ "where "
                    + "sop.cod_pro = pro.cod_pro "
                    + "and sop.cod_azl = pro.cod_azl "
                    + "and sop.cod_can = can.cod_can "
                    + "and sop.cod_azl = can.cod_azl "
                    + "and sop.cod_azl=? ";
	if (lCOD_PRO != null) {
	    Sql += " and pro.cod_pro = ? ";
	}
	if (lCOD_CAN != null) {
	    Sql += " and can.cod_can = ? ";
	}
	if (lCOD_OPE != null) {
	    Sql += " and ope.cod_ope = ? ";
	}
	if (sNUM_SOP != null) {
	    Sql += " and UPPER(sop.num_sop) like ? ";
	}
	if (dDAT_SOP != null) {
	    Sql += " and sop.dat_sop = ? ";
	}
	Sql += " order by sop.cod_sop";

	try {
	    PreparedStatement ps = bmp.prepareStatement(Sql);

            int i = 1;
            ps.setLong(1, i++);
            
	    if (lCOD_PRO != null) {
		ps.setLong(i++, lCOD_PRO);
	    }
	    if (lCOD_CAN != null) {
		ps.setLong(i++, lCOD_CAN);
	    }
	    if (lCOD_OPE != null) {
		ps.setLong(i++, lCOD_OPE);
	    }
            if (sNUM_SOP != null) {
                ps.setString(i++, sNUM_SOP.toUpperCase());
            }
            if (dDAT_SOP != null) {
                ps.setDate(i++, dDAT_SOP);
            }

	    ResultSet rs = ps.executeQuery();
	    java.util.ArrayList al = new java.util.ArrayList();

	    while (rs.next()) {
		findEx_sop obj = new findEx_sop();
		obj.COD_AZL = lCOD_AZL;
		obj.COD_SOP = rs.getLong(1);
		obj.NOME_PRO = rs.getString(2);
		obj.NOME_CAN = rs.getString(3);
		obj.NOME_OPE = rs.getString(4);
		obj.NUM_SOP = rs.getString(5);
                obj.DAT_SOP = rs.getDate(6);
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

    public int addCOD_SOP_DPD(long lCOD_DPD, String alt_nominativo) {
	BMPConnection bmp = getConnection();
	ResultSet rs = null;
	PreparedStatement ps_select = null;
	try {
	    PreparedStatement ps_insert = bmp.prepareStatement(
		    "INSERT INTO sop_dpd_tab (cod_sop,cod_dpd,cod_azl,alt_nominativo) "
		    + "select ana_sop_tab.cod_sop,ana_dpd_tab.cod_dpd,ana_sop_tab.cod_azl,? from "
		    + "ana_sop_tab,ana_dpd_tab "
		    + "where ana_sop_tab.cod_sop=? "
		    + "and ana_dpd_tab.cod_dpd=? "
		    + "and ana_sop_tab.cod_azl=? "
		    + "and ana_dpd_tab.cod_dte is null");
	    ps_insert.setString(1, alt_nominativo);
	    ps_insert.setLong(2, COD_SOP);
	    ps_insert.setLong(3, lCOD_DPD);
	    ps_insert.setLong(4, COD_AZL);

	    return ps_insert.executeUpdate();
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	    throw new EJBException(ex);
	} finally {
	    if (bmp != null) {
		bmp.close();
	    }
	}
    }

    public int addCOD_SOP_DPD_est(long lCOD_DPD, String alt_nominativo) {
	BMPConnection bmp = getConnection();
	ResultSet rs = null;
	PreparedStatement ps_select = null;
	try {
	    PreparedStatement ps_insert = bmp.prepareStatement(
		    "INSERT INTO sop_dpd_imp_tab (cod_sop,cod_dpd,cod_azl,cod_dte,alt_nominativo) "
		    + "select ana_sop_tab.cod_sop,ana_dpd_tab.cod_dpd,ana_sop_tab.cod_azl,ana_dpd_tab.cod_dte,? as alt_nominativo "
		    + "   from ana_sop_tab,ana_dpd_tab "
		    + "   where ana_sop_tab.cod_sop=? "
		    + "   and ana_sop_tab.cod_azl=? "
		    + "   and ana_dpd_tab.cod_dpd=? "
		    + "   and ana_dpd_tab.cod_dte is not null;");

	    ps_insert.setString(1, alt_nominativo);
	    ps_insert.setLong(2, COD_SOP);
	    ps_insert.setLong(3, COD_AZL);
	    ps_insert.setLong(4, lCOD_DPD);
	    return ps_insert.executeUpdate();
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	    throw new EJBException(ex);
	} finally {
	    if (bmp != null) {
		bmp.close();
	    }
	}
    }

    public void addDOC_GES_CAN_SOP(long COD_DOC) {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement(
		    "INSERT INTO doc_ges_can_sop_tab (cod_doc, cod_sop, cod_azl) VALUES(?,?,?)");
	    ps.setLong(1, COD_DOC);
	    ps.setLong(2, COD_SOP);
	    ps.setLong(3, COD_AZL);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Documento associato non è inserito");
	    }
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}

    }

    public Collection getDocumentiAssociatiView() {
	BMPConnection bmp = getConnection();
	java.util.ArrayList al = new java.util.ArrayList();
	return al;
    }

    public AnagDocumentoSopFileInfo getFileInfo() {
	AnagDocumentoSopFileInfo info = null;
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("SELECT name, content_type, doc_size, last_updated FROM documents WHERE cod_doc=? and link_document is null");
	    ps.setLong(1, COD_SOP);
	    ResultSet rs = ps.executeQuery();
	    java.util.ArrayList al = new java.util.ArrayList();
	    if (rs.next()) {
		info = new AnagDocumentoSopFileInfo();
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

    public Collection getFattoriRischio(Long lCOD_AZL) {
	// Estrae i soli fattori di rischio cantiere, ai quali sono legate
        // delle constatazioni
        java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement(
                    "select distinct "
			+"fat_rso.cod_fat_rso, "
			+"fat_rso.nom_fat_rso "
                    +"from "
                        +"ana_cst_tab cst, "
			+"ana_fat_rso_can_tab fat_rso "
                    +"where "
			+"cst.cod_fat_rso = fat_rso.cod_fat_rso "
                    +"order by "
                        +"fat_rso.nom_fat_rso ");
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbFattoreRischio rec = new jbFattoreRischio();
		rec.lCOD_FAT_RSO = rs.getLong(1);
		rec.sNOM_FAT_RSO = rs.getString(2);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }
            
    public Collection getConstatazioni(Long lCOD_FAT_RSO, Long lCOD_AZL) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "cod_cst, "
                        + "nom, "
                        + "des "
                    + "from "
                        + "ana_cst_tab "
                    + "where "
                        + "cod_fat_rso = ? "
                    + "order by "
                        + "nom");
	    ps.setLong(1, lCOD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbConstatazione rec = new jbConstatazione();
		rec.lCOD_CST = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public Collection getRischi(Long lCOD_AZL, Long lCOD_CST) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    if (lCOD_CST == null) {
		ps = bmp.prepareStatement(
                        "select "
                            + "cod_rso, "
                            + "nom_rso, "
                            + "des_rso "
                        + "from "
                            + "ana_rso_can_tab "
                        + "where "
                            + "cod_azl = ?");
		ps.setLong(1, lCOD_AZL);
	    } else {
		String str =
                        "select distinct "
                                + "rso.cod_rso, "
                                + "rso.nom_rso, "
                                + "rso.des_rso "
                        + "from "
                                + "cst_rso_tab cst_rso, "
                                + "rso_dsp_tab rso_dsp, "
                                + "ana_rso_can_tab rso "
                        + "where "
                                + "cst_rso.cod_cst=? "
                                + "and cst_rso.cod_azl=? "
                                + "and cst_rso.cod_rso=rso_dsp.cod_rso "
                                + "and cst_rso.cod_azl=rso_dsp.cod_azl "
                                + "and rso_dsp.cod_rso = rso.cod_rso "
                                + "and rso_dsp.cod_azl = rso.cod_azl "
                        + "order by "
                                + "rso.nom_rso";
		ps = bmp.prepareStatement(str);
		ps.setLong(1, lCOD_CST);
		ps.setLong(2, lCOD_AZL);
	    }
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbRischio rec = new jbRischio();
		rec.lCOD = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }
    public Collection getArticoli_GEN(Long lCOD_AZL, Long lCOD_CST) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    if (lCOD_CST == null) {
		ps = bmp.prepareStatement(
                        "select "
                            + "cod_rso, "
                            + "nom_rso, "
                            + "des_rso "
                        + "from "
                            + "ana_rso_can_tab "
                        + "where "
                            + "cod_azl = ?");
		ps.setLong(1, lCOD_AZL);
	    } else {
		String str = "select distinct "
                        + "arl.cod_arl, "
                        + "arl.nom_arl, "
                        + "arl.des_arl "
                        + "from "
                        + "cst_rso_tab cst_rso, "
                        + "rso_dsp_tab rso_dsp, "
                        + "ana_rso_can_tab rso, "
                        + "rso_arl_tab rso_arl, "
                        + "ana_arl_tab arl "
                        + "where cst_rso.cod_cst=? "
                        + "and cst_rso.cod_azl=? "
                        + "and cst_rso.cod_rso=rso_dsp.cod_rso "
                        + "and cst_rso.cod_azl=rso_dsp.cod_azl "
                        + "and rso_dsp.cod_rso = rso.cod_rso "
                        + "and rso_dsp.cod_azl = rso.cod_azl "
                        + "and rso.cod_rso = rso_arl.cod_rso "
                        + "and rso.cod_azl = rso_arl.cod_azl "
                        + "and rso_arl.cod_arl = arl.cod_arl "
                        + "order by arl.nom_arl";
		ps = bmp.prepareStatement(str);
		ps.setLong(1, lCOD_CST);
		ps.setLong(2, lCOD_AZL);
	    }
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbArticolo rec = new jbArticolo();
		rec.lCOD = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public Collection getDisposizioni(Long lCOD_AZL, Long lCOD_CST) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    if (lCOD_CST == null) {
		ps = bmp.prepareStatement(
                        "select "
                            + "cod_dsp, "
                            + "nom_dsp, "
                            + "des "
                        + "from "
                            + "ana_dsp_tab");
		ps.setLong(1, lCOD_AZL);
	    } else {
		String str = 
                        "select distinct "
                            + "dsp.cod_dsp, "
                            + "dsp.nom_dsp, "
                            + "dsp.des "
                        + "from "
                            + "cst_rso_tab cst_rso, "
                            + "rso_dsp_tab rso_dsp, "
                            + "ana_dsp_tab dsp "
                        + "where "
                            + "cst_rso.cod_azl=? "
                            + "and cst_rso.cod_cst=? "
                            + "and cst_rso.cod_rso=rso_dsp.cod_rso "
                            + "and cst_rso.cod_azl=rso_dsp.cod_azl "
                            + "and rso_dsp.cod_dsp=dsp.cod_dsp "
                        + "order by "
                            + "dsp.nom_dsp";
		ps = bmp.prepareStatement(str);
		ps.setLong(1, lCOD_AZL);
		ps.setLong(2, lCOD_CST);
	    }
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbDisposizione rec = new jbDisposizione();
		rec.lCOD = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public Collection getArticoli(Long lCOD_AZL) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    String str = 
                    "select "
                        + "cod_arl, "
                        + "iden, "
                        + "nom_arl, "
                        + "des_arl "
                    + "from "
                        + "ana_arl_tab";
	    ps = bmp.prepareStatement(str);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbArticolo rec = new jbArticolo();
		rec.lCOD = rs.getLong(1);
		rec.sIden = rs.getString(2);
		rec.sNOME = rs.getString(3);
		rec.sDESC = rs.getString(4);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public Collection getArticoliDaDisp(Long lCOD_AZL, Long lCOD_DSP, Long lCOD_CST) {
	java.util.ArrayList al = new java.util.ArrayList();
	if (lCOD_DSP == null || lCOD_DSP == 0) {
	    return al;
	}
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    String str = null;

	    str = "select distinct ana_arl_tab.cod_arl,ana_arl_tab.nom_arl,ana_arl_tab.des_arl ";
	    str += "from rso_dsp_tab,rso_arl_tab,ana_arl_tab,cst_rso_tab ";
	    str += "where rso_dsp_tab.cod_dsp = ? ";
	    str += "and rso_dsp_tab.cod_azl = ? ";
	    str += "and cst_rso_tab.cod_cst = ? ";
	    str += "and rso_dsp_tab.cod_rso=rso_arl_tab.cod_rso ";
	    str += "and cst_rso_tab.cod_rso=rso_arl_tab.cod_rso ";
	    str += "and ana_arl_tab.cod_arl=rso_arl_tab.cod_arl ";
            
	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_DSP);
	    ps.setLong(2, lCOD_AZL);
	    ps.setLong(3, lCOD_CST);
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbArticolo rec = new jbArticolo();
		rec.lCOD = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    private boolean checkDuplicateSOP_CST(
            Long lCOD_SOP_CST, Long lCOD_SOP, Long lCOD_CST, 
            Long lCON_DIS_COD_DTE, Long lCON_DIS_COD_DOC, Long lCOD_AZL){
        
        BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;
	    String str =
                    "select "
                        + "count(*) as cst_count "
                    + "from "
                        + "sop_cst_tab "
                    + "where "
                        + "cod_sop=? "
                        + "and cod_cst=? ";
            
            if (lCOD_SOP_CST != null && lCOD_SOP_CST.longValue() > 0){
                str += "and cod_sop_cst <> ? ";
            }
            
            int case_selector = 0;
            // Verifico il caso in cui esistano due constatazioni unguali
            // per lo stesso sopralluogo...
            // ...SENZA DITTA E SENZA ATTIVITA'
            if ((lCON_DIS_COD_DTE == null || lCON_DIS_COD_DTE.longValue()==0) && 
                (lCON_DIS_COD_DOC == null || lCON_DIS_COD_DOC.longValue()==0)){
                    str += "and cod_dte is null "
                            + "and cod_doc is null "
                            + "and cod_azl is null";
                    case_selector = 1;
            } else
            // ...CON DITTA UGUALE E SENZA ATTIVITA'
            if ((lCON_DIS_COD_DTE != null && lCON_DIS_COD_DTE.longValue()>0) && 
                (lCON_DIS_COD_DOC == null || lCON_DIS_COD_DOC.longValue()==0)){
                    str += "and cod_dte = ? "
                            + "and cod_doc is null "
                            + "and cod_azl is null";
                    case_selector = 2;
            } else
            // ...SENZA DITTA E CON ATTIVITA' UGUALE
            if ((lCON_DIS_COD_DTE == null || lCON_DIS_COD_DTE.longValue()==0) && 
                (lCON_DIS_COD_DOC != null && lCON_DIS_COD_DOC.longValue()>0)){
                    str += "and cod_dte is null "
                            + "and cod_doc = ? "
                            + "and cod_azl = ?";
                    case_selector = 3;
            }
            // ...CON DITTA E ATTIVITA' UGUALI.
            // Questo caso è controllato da un indice univoco sul DB.
            if (case_selector == 0) return false;
            
            ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_CST);
            
            int index = 3;
            if (lCOD_SOP_CST != null && lCOD_SOP_CST.longValue() > 0){
                str += "and cod_sop_cst <> ? ";
                ps.setLong(index++, lCOD_SOP_CST);
            }
            
            switch (case_selector){
                case 2:  ps.setLong(index, lCON_DIS_COD_DTE);
                         break;
                case 3:  ps.setLong(index++, lCON_DIS_COD_DOC);
                         ps.setLong(index, lCOD_AZL);
                         break;
            }
            ResultSet rs = ps.executeQuery();
	    rs.next();
            return rs.getLong(1) > 0;
	} catch (Exception ex) {
            ex.printStackTrace();
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public Long addSOP_CST(
            Long lCOD_SOP_CST, Long lCOD_SOP, Long lCOD_CST, 
            Long lCON_DIS_COD_DTE, Long lCON_DIS_COD_DOC, Long lCOD_AZL, 
            String sCON_DIS_DES_LIB, String sDIS_GEN){
	BMPConnection bmp = getConnection();
	PreparedStatement ps = null;
	String str;
	try {
	    if (checkDuplicateSOP_CST
                    (lCOD_SOP_CST, lCOD_SOP, lCOD_CST,
                    lCON_DIS_COD_DTE, lCON_DIS_COD_DOC, lCOD_AZL)){
                throw new EJBException("Il record già esiste");
            }
            
            if (lCOD_SOP_CST == null) {
		str = 
                        "INSERT INTO sop_cst_tab "
                            + "(cod_sop_cst, cod_sop, cod_cst, "
                            + "cod_dte, cod_doc, cod_azl, "
                            + "des_lib, dis_gen) "
                        + "values "
                            + "(?,?,?,?,?,?,?,?)";
		ps = bmp.prepareStatement(str);
		lCOD_SOP_CST = NEW_ID();
		ps.setLong(1, lCOD_SOP_CST);
		ps.setLong(2, lCOD_SOP);
		ps.setLong(3, lCOD_CST);
		if (lCON_DIS_COD_DTE > 0){
                    ps.setLong(4, lCON_DIS_COD_DTE);
                } else {
                    ps.setNull(4, java.sql.Types.BIGINT);
                }
                if (lCON_DIS_COD_DOC > 0){
                    ps.setLong(5, lCON_DIS_COD_DOC);
                    ps.setLong(6, lCOD_AZL);                    
                } else {
                    ps.setNull(5, java.sql.Types.BIGINT);
                    ps.setNull(6, java.sql.Types.BIGINT);
                }
                ps.setString(7, sCON_DIS_DES_LIB);
		ps.setString(8, sDIS_GEN);
	    } else {
		str = "UPDATE sop_cst_tab SET "
                        + "cod_dte=?, "
                        + "cod_doc=?, "
                        + "cod_azl=?, "
                        + "des_lib=?, "
                        + "dis_gen=? "                        
                    + "where "
                        + "cod_sop_cst=?";
		ps = bmp.prepareStatement(str);
		if (lCON_DIS_COD_DTE > 0){
                    ps.setLong(1, lCON_DIS_COD_DTE);
                } else {
                    ps.setNull(1, java.sql.Types.BIGINT);
                }
                if (lCON_DIS_COD_DOC > 0){
                    ps.setLong(2, lCON_DIS_COD_DOC);
                    ps.setLong(3, lCOD_AZL);
                } else {
                    ps.setNull(2, java.sql.Types.BIGINT);
                    ps.setNull(3, java.sql.Types.BIGINT);
                }
                ps.setString(4, sCON_DIS_DES_LIB);
                ps.setString(5, sDIS_GEN);
		ps.setLong(6, lCOD_SOP_CST);
	    }
	    ps.executeUpdate();
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	    throw new EJBException(ex);
	} finally {
	    if (bmp != null) {
		bmp.close();
	    }
	}
	return lCOD_SOP_CST;
    }

    public Collection getConstatazioniSop(Long lCOD_SOP) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;

	    String str = 
                    "select "
                        + "sop_cst.cod_sop_cst, "
                        + "cst.nom, "
                        + "cst.des, "
			+ "dte.rag_scl_dte, "
			+ "att.nom_att, "
			+ "sop_cst.des_lib, "
                        + "sop_cst.dis_gen "
                    + "from "
                        + "ana_cst_tab cst, "
                        + "sop_cst_tab sop_cst "
                            + "left outer join "
                                + "ana_dte_tab dte "
                            + "on "
                                + "(sop_cst.cod_dte = dte.cod_dte) "
                            + "left outer join "
                                + "ana_att_can_tab att "
                            + "on "
                                + "(sop_cst.cod_doc = att.cod_doc "
                                + "and sop_cst.cod_azl = att.cod_azl) "
                    + "where "
                        + "sop_cst.cod_sop = ? "
                        + "and cst.cod_cst = sop_cst.cod_cst "
                    + "order by "
                        + "sop_cst.cod_sop_cst";

	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);

	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		jbConstatazione rec = new jbConstatazione();
		rec.lCOD_SOP_CST = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
                rec.sRAG_SCL_DTE = rs.getString(4);
                rec.sNOM_ATT = rs.getString(5);
                rec.sDES_LIB = rs.getString(6);
                rec.sDIS_GEN = rs.getString(7);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public jbConstatazione getConstatazione(Long lCOD_CST) {
	BMPConnection bmp = getConnection();
	jbConstatazione rec = null;
	try {
	    PreparedStatement ps = null;
	    String str = "";

	    str = "select ana_cst_tab.cod_cst,ana_cst_tab.nom,ana_cst_tab.des ";
	    str += "from ana_cst_tab ";
	    str += "where ana_cst_tab.cod_cst=? ";

	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_CST);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		rec = new jbConstatazione();
		rec.lCOD_CST = rs.getLong(1);
		rec.sNOME = rs.getString(2);
		rec.sDESC = rs.getString(3);
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return rec;
    }

    public jbConstatazione getConstatazioneSOP(Long lCOD_SOP_CST) {
	BMPConnection bmp = getConnection();
	jbConstatazione rec = null;
	try {
	    PreparedStatement ps = null;
	    String str = "";

	    str = 
                "select "
                    + "cst.cod_cst, "
                    + "cst.cod_fat_rso, "
                    + "cst.nom, "
                    + "cst.des, "
                    + "sop_cst.cod_dte, "
                    + "sop_cst.cod_doc, "
                    + "sop_cst.cod_azl, "
                    + "sop_cst.des_lib, "
                    + "sop_cst.dis_gen "
                + "from "
                    + "sop_cst_tab sop_cst, "
                    + "ana_cst_tab cst "
                + "where "
                    + "sop_cst.cod_sop_cst=? "
                    + "and sop_cst.cod_cst=cst.cod_cst";

	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP_CST);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		rec = new jbConstatazione();
		rec.lCOD_CST = rs.getLong(1);
                rec.lCOD_FAT_RSO = rs.getLong(2);
		rec.sNOME = rs.getString(3);
		rec.sDESC = rs.getString(4);
                rec.lCOD_DTE = rs.getLong(5);
                rec.lCOD_DOC = rs.getLong(6);
                rec.lCOD_AZL = rs.getLong(7);
                rec.sDES_LIB = rs.getString(8);
		rec.sDIS_GEN = rs.getString(9);
		rec.lCOD_SOP_CST = lCOD_SOP_CST;
	    }
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return rec;
    }

    public Long addSOP_COL(Long lCOD_SOP, Long lCOD_OGGETTO, Integer iTipo) {
	if (lCOD_SOP == lCOD_OGGETTO) {
	    return 0L;
	}

	BMPConnection bmp = getConnection();
	ResultSet rs = null;
	PreparedStatement ps = null;
	String str;
	Long lCOD_SOP_COL = null;
	try {
	    str = "INSERT INTO sop_col_tab (cod_sop_col,cod_sop,tipo,cod_ogg_col) values (?,?,?,?)";
	    ps = bmp.prepareStatement(str);
	    lCOD_SOP_COL = NEW_ID();
	    ps.setLong(1, lCOD_SOP_COL);
	    ps.setLong(2, lCOD_SOP);
	    ps.setInt(3, iTipo);
	    ps.setLong(4, lCOD_OGGETTO);
	    ps.executeUpdate();
	} catch (Exception ex) {
	    ex.printStackTrace(System.err);
	    throw new EJBException(ex);
	} finally {
	    if (bmp != null) {
		bmp.close();
	    }
	}

	return lCOD_SOP_COL;
    }
    
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

    public Collection getMediaSOP(Long lCOD_SOP) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;

	    String str = "";

	    str = "select "
                        + "cod_med, "
                        + "cod_sop, "
                        + "nom_med, "
                        + "des_med, "
                        + "tipo, "
                        + "file, "
                        + "blob, "
                        + "note, "
                        + "data, "
                        + "ora "
		    + "from "
                        + "ana_med_tab "
		    + "where "
                        + "cod_sop = ? "
		    + "order "
                        + "by cod_sop";

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

		byte[] bt = null;
		Blob bb;

		if (bmp.getType() == ConnectionType.POSTGRE) {
		    bt = rs.getBytes(7);
		} else if (bmp.getType() == ConnectionType.ORACLE) {
		    bb = rs.getBlob(7);
		    if (rs.wasNull()) {
			bt = null;
		    } else {
			bt = bb.getBytes(7, (int) bb.length());
		    }
		}
		rec.mediaData = bt;
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

    public Collection getDocumentiCantiereSOP(Long lCOD_SOP) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;

	    String str = "";
	    str = "select a.cod_doc, a.des, a.cod_tpl_doc, a.num_doc, a.dat_doc, a.tit_doc, c.nom_tpl_doc "
		    + "from ana_doc_ges_can_tab a , doc_ges_can_sop_tab b, tpl_doc_can_tab c "
		    + "where a.cod_doc=b.cod_doc and a.cod_tpl_doc=c.cod_tpl_doc and b.cod_sop = ? "
		    + "order by dat_doc";

	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);

	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		DocumentiAssociati_Sopralluogo_View rec = new DocumentiAssociati_Sopralluogo_View();
		rec.lCOD_DOC = rs.getLong(1);
		rec.DES = rs.getString(2);
		rec.lCOD_TPL_DOC = rs.getLong(3);
		rec.NUM_DOC = rs.getString(4);
		rec.DAT_DOC = rs.getDate(5);
		rec.TIT_DOC = rs.getString(6);
		rec.NOM_TPL_DOC = rs.getString(7);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }

    public Collection getDocumentiCantiereSOP_STAMPA(Long lCOD_SOP) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = null;

	    String str = "";
	    str = "select a.cod_doc, a.des, a.cod_tpl_doc, a.num_doc, a.dat_doc, a.tit_doc, c.nom_tpl_doc "
		    + "from ana_doc_ges_can_tab a , doc_ges_can_sop_tab b, tpl_doc_can_tab c "
		    + "where a.cod_doc=b.cod_doc and a.cod_tpl_doc=c.cod_tpl_doc and b.cod_sop = ? and c.all_sta_sop = 'S'"
		    + "order by dat_doc";

	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_SOP);

	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		DocumentiAssociati_Sopralluogo_View rec = new DocumentiAssociati_Sopralluogo_View();
		rec.lCOD_DOC = rs.getLong(1);
		rec.DES = rs.getString(2);
		rec.lCOD_TPL_DOC = rs.getLong(3);
		rec.NUM_DOC = rs.getString(4);
		rec.DAT_DOC = rs.getDate(5);
		rec.TIT_DOC = rs.getString(6);
		rec.NOM_TPL_DOC = rs.getString(7);
		al.add(rec);
	    }
	} catch (Exception ex) {
	    ex.printStackTrace();
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return al;
    }


    public Integer chkPOC_SOP(Long lCOD_PRO, Long lCOD_OPE, Long lCOD_CAN) {
	/*
        BMPConnection bmp = getConnection();
	Integer irc = 0;
	try {
	    PreparedStatement ps = null;
	    String str =
		    "select pro_can_tab.cod_pro "
		    + "from pro_can_tab,can_ope_tab "
		    + "where pro_can_tab.cod_can=can_ope_tab.cod_can "
		    + "and can_ope_tab.cod_ope = ? "
		    + "and can_ope_tab.cod_can = ? "
		    + "and pro_can_tab.cod_pro = ? ";
	    ps = bmp.prepareStatement(str);
	    ps.setLong(1, lCOD_OPE);
	    ps.setLong(2, lCOD_CAN);
	    ps.setLong(3, lCOD_PRO);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		irc = 1;
	    }
	} catch (Exception ex) {
            ex.printStackTrace();
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
	return irc;
         * 
         */
        
        /*
         * Il metodo viene commentato in quanto non piu necessario.
         * Il valore di ritorno '1' stà ad indicare che è terminato correttamente.
         */
        return 1;
    }

    public Boolean chkNUM_SOP(String sNSOP, java.sql.Date data) {
	BMPConnection bmp = getConnection();
	Boolean bol = true;
	try {
	    PreparedStatement ps = null;
	    String str =
		    "select num_sop, dat_sop from ana_sop_tab where num_sop = ? and dat_sop <> ? ";
	    ps = bmp.prepareStatement(str);
	    ps.setString(1, sNSOP);
	    ps.setDate(2, data);
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

    public Collection buildCollegamentiTab(Long lCOD_SOP) {
	BMPConnection bmp = getConnection();
	String Sql =
                "select * from("
		+"select b.cod_ogg_col,"
                + "c.nom_tpl_doc, "
                + "a.dat_doc, "
                + "a.num_doc, "
                + "a.tit_doc "
                + "from "
                + "ana_doc_ges_can_tab a,"
                + "sop_col_tab b, "
                + "tpl_doc_can_tab c "
                + "where "
                + "b.cod_ogg_col = a.cod_doc "
                + "and c.cod_tpl_doc=a.cod_tpl_doc "
                + "and b.cod_sop = ? "
                + "union "
                + "select "
                +"b.cod_ogg_col, "
                + "'RS' as nom_tpl_doc,  "
                + "a.dat_SOP as dat_doc, "
                + "a.num_sop as num_doc, "
                + "'' as tit_doc "
                + "from "
                + "ana_sop_tab a ,"
                + "sop_col_tab b "
                + "where "
                + "b.cod_ogg_col = a.cod_sop "
                + "and b.cod_sop = ? ) as collegamenti "
                + "order by collegamenti.nom_tpl_doc ASC,collegamenti.dat_doc DESC,collegamenti.num_doc DESC";
      /*  String Sql= "select b.cod_sop_col, b.cod_ogg_col, a.cod_tpl_doc, a.num_doc, a.dat_doc, a.tit_doc, c.nom_tpl_doc "
		    + "from ana_doc_ges_can_tab a , sop_col_tab b, tpl_doc_can_tab c,ana_sop_tab d "
		    + "where a.cod_doc=b.cod_doc and b.cod_sop=ana_sop_tab.cod_sop and a.cod_tpl_doc=c.cod_tpl_doc and b.cod_sop = ? "
		    + "order by dat_doc";*/
	try {
	    PreparedStatement ps = bmp.prepareStatement(Sql);
	    ps.setLong(1, lCOD_SOP);
	    ps.setLong(2, lCOD_SOP);

	    ResultSet rs = ps.executeQuery();
	    java.util.ArrayList al = new java.util.ArrayList();

	    while (rs.next()) {
		jbCollegamento rec = new jbCollegamento();
                rec.lCOD_OGG_COL = rs.getLong(1);
		rec.NOM_TPL_DOC = rs.getString(2);
		rec.dDAT_DOC = rs.getDate(3);
		rec.sNUM_DOC = rs.getString(4);
		rec.sTIT_DOC = rs.getString(5);
		al.add(rec);
	    }
	    bmp.close();
	    return al;
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

    public Collection buildCollegamentiForm(Long lCOD_AZL, Long lCOD_SOP) {
	BMPConnection bmp = getConnection();
	String Sql =
                "select * from ("
                    + "select "
                        + "a.cod_doc, "
                        + "e.nom_tpl_doc,"
                        + "a.num_doc, "
                        + "a.dat_doc, "
                        + "a.tit_doc, "
                        + "b.des as nom_pro, "
                        + "c.nom_ope,"
                        + "d.nom_can "
                    + "from "
                        + "ana_doc_ges_can_tab a "
                            + "left outer join "
                                + "ana_ope_tab c "
                            + "on "
                                + "a.cod_ope=c.cod_ope, "
                        + "ana_pro_tab b,"
                        + "ana_can_tab d,"
                        + "tpl_doc_can_tab e "
                    + "where "
                        + "a.cod_pro=b.cod_pro "
                        + "and a.cod_can=d.cod_can "
                        + "and e.cod_tpl_doc=a.cod_tpl_doc "
                        + "and e.col_sop = 'S' "
                + "UNION "
                    + "select "
                        + "ana_sop_tab.cod_sop as cod_doc,"
                        + "'RS' as nom_tpl_doc,"
                        + "ana_sop_tab.num_sop as num_doc,"
                        + "ana_sop_tab.dat_sop as dat_doc,"
                        + "'' as tit_doc,"
                        + "ana_pro_tab.des as nom_pro,"
                        + "ana_ope_tab.nom_ope,"
                        + "ana_can_tab.nom_can "
                    + "from "
                        + "ana_sop_tab "
                            + "left outer join "
                                + "ana_ope_tab "
                            + "on "
                                + "ana_sop_tab.cod_ope = ana_ope_tab.cod_ope, "
                        + "ana_pro_tab, "
                        + "ana_can_tab"
                    + " where "
                        + "ana_sop_tab.cod_can = ana_can_tab.cod_can "
                        + "and ana_sop_tab.cod_pro = ana_pro_tab.cod_pro "
                        + "and ana_sop_tab.cod_azl=1) as collegamenti "
                + "order by "
                    + "collegamenti.nom_tpl_doc ASC, "
                    + "collegamenti.dat_doc DESC, "
                    + "collegamenti.num_doc DESC";
	try {
	    PreparedStatement ps = bmp.prepareStatement(Sql);
            ResultSet rs = ps.executeQuery();
	    java.util.ArrayList al = new java.util.ArrayList();

	    while (rs.next()) {
		jbCollegamento rec = new jbCollegamento();
		rec.lCOD_SOP_COL = rs.getLong(1);
		rec.NOM_TPL_DOC = rs.getString(2);
		rec.sNUM_DOC = rs.getString(3);
		rec.dDAT_DOC = rs.getDate(4);
		rec.sTIT_DOC = rs.getString(6);
		rec.sProcedimento = rs.getString(6);
		rec.sOpera = rs.getString(7);
		rec.sCantiere = rs.getString(8);
		al.add(rec);
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
