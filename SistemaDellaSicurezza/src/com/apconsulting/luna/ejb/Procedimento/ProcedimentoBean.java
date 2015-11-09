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
package com.apconsulting.luna.ejb.Procedimento;

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

public class ProcedimentoBean extends BMPEntityBean implements IProcedimento, IProcedimentoHome {

    long COD_PRO;
    String DES_PRO;
    private static ProcedimentoBean ys = null;

    private ProcedimentoBean() {
    }

    public static ProcedimentoBean getInstance() {
	if (ys == null) {
	    ys = new ProcedimentoBean();
	}
	return ys;
    }

////////////////////////////ATTENTION!!///////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IProcedimento create(Long lCOD_AZL, String strNOM_PRO) throws CreateException {
	ProcedimentoBean bean = new ProcedimentoBean();
	try {
	    Object primaryKey = bean.ejbCreate(lCOD_AZL, strNOM_PRO);
	    bean.setEntityContext(new EntityContextWrapper(primaryKey));
	    bean.ejbPostCreate(strNOM_PRO);
	    return bean;
	} catch (Exception ex) {
	    throw new javax.ejb.CreateException(ex.getMessage());
	}
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
	ProcedimentoBean iPianoBean = new ProcedimentoBean();
	try {
	    Object obj = iPianoBean.ejbFindByPrimaryKey((Long) primaryKey);
	    iPianoBean.setEntityContext(new EntityContextWrapper(obj));
	    iPianoBean.ejbActivate();
	    iPianoBean.ejbLoad();
	    iPianoBean.ejbRemove();
	} catch (Exception ex) {
	    throw new EJBException(ex);
	}
    }
    // (Home Intrface) findByPrimaryKey()

    public IProcedimento findByPrimaryKey(Long primaryKey) throws FinderException {
	ProcedimentoBean bean = new ProcedimentoBean();
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
    public Collection getProcedimento_View(Long lCOD_AZL) {
	return (new ProcedimentoBean()).ejbGetProcedimento_View(lCOD_AZL);
    }

    public Collection ejbGetProcedimento_View(Long lCOD_AZL) {
	java.util.ArrayList al = new java.util.ArrayList();

	BMPConnection bmp = getConnection();
	try {
	    String sq = "SELECT cod_pro, des FROM ana_pro_tab where cod_azl=?";
	    sq += " ORDER BY cod_pro";
	    PreparedStatement ps = bmp.prepareStatement(sq);
    	    ps.setLong(1, lCOD_AZL);

	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		Procedimento_View obj = new Procedimento_View();
		obj.COD_PRO = rs.getLong(1);
		obj.DES_PRO = rs.getString(2);
		al.add(obj);
	    }
	    bmp.close();
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}

	return al;
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IPianoHome-implementation>
    public Long ejbCreate(Long lCOD_AZL, String strDES_PRO) {
	this.DES_PRO = strDES_PRO;
	this.COD_PRO = NEW_ID(); // unic ID
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_pro_tab (cod_pro,cod_azl) VALUES(?,?)");
	    ps.setLong(1, COD_PRO);
	    ps.setLong(2, lCOD_AZL);
	    ps.executeUpdate();
	    return new Long(COD_PRO);
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_PNO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("SELECT cod_pro FROM ana_pro_tab ");
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
	this.COD_PRO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
	this.COD_PRO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_pro_tab  WHERE cod_pro=?");
	    ps.setLong(1, COD_PRO);
	    ResultSet rs = ps.executeQuery();
	    if (rs.next()) {
		this.DES_PRO = rs.getString("DES");
	    } else {
		throw new NoSuchEntityException("Procedimento con ID=" + COD_PRO + " non trovato");
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
	    PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_pro_tab WHERE cod_pro=?");
	    ps.setLong(1, COD_PRO);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Procedimento con ID=" + COD_PRO + " non trovato");
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
	    PreparedStatement ps = bmp.prepareStatement("UPDATE ana_pro_tab SET des=? WHERE cod_pro=?");
	    ps.setString(1, DES_PRO);
	    ps.setLong(2, COD_PRO);
	    if (ps.executeUpdate() == 0) {
		throw new NoSuchEntityException("Procedimento con ID=" + COD_PRO + " non trovato");
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
    public long getCOD_PRO() {
	return COD_PRO;
    }
    //============================================
    // not required field
    //3

    public void setDES_PRO(String newDES_PRO) {
	if (DES_PRO != null) {
	    if (DES_PRO.equals(newDES_PRO)) {
		return;
	    }
	}
	DES_PRO = newDES_PRO;
	setModified();
    }

    public String getDES_PRO() {
	if (DES_PRO == null) {
	    return "";
	}
	return DES_PRO;
    }

// ============= by Juli==== SEARCH==
    public Collection findEx(
	    Long lCOD_PRO,
	    String strNOM_PRO) {
	return ejbFindEx(lCOD_PRO, strNOM_PRO);
    }

    public Collection ejbFindEx(
	    Long lCOD_PRO,
	    String strNOM_PRO) {
	String strSql = " SELECT cod_pro, des FROM ana_pro_tab WHERE ";
	if (strNOM_PRO != null) {
	    strSql += " upper(des) LIKE ?  AND   ";
	}
	strSql += " ORDER BY UPPER(des) ASC";
	int i = 1;
	BMPConnection bmp = getConnection();
	try {
	    PreparedStatement ps = bmp.prepareStatement(strSql);
	    if (strNOM_PRO != null) {
		ps.setString(i++, strNOM_PRO + "%".toUpperCase());
	    }
	    //----------------------------------------------------------------------
	    ResultSet rs = ps.executeQuery();
	    java.util.ArrayList ar = new java.util.ArrayList();
	    while (rs.next()) {
		Procedimento_View v = new Procedimento_View();
		v.COD_PRO = rs.getLong(1);
		v.DES_PRO = rs.getString(2);
		ar.add(v);
	    }
	    return ar;
	    //----------------------------------------------------------------------
	} catch (Exception ex) {
	    throw new EJBException(ex);
	} finally {
	    bmp.close();
	}
    }
//===================================
///////////ATTENTION!!////////////////////////////////////////
}
