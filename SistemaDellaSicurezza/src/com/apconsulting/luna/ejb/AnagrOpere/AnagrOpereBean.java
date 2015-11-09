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
package com.apconsulting.luna.ejb.AnagrOpere;

import com.apconsulting.luna.ejb.Cantiere.Cantiere_View;
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
 * @author Alessandro
 */
public class AnagrOpereBean extends BMPEntityBean implements IAnagrOpereHome, IAnagrOpere {

    long lCOD_OPE;
    String strDES_OPE;
    String strNOM_OPE;
    private static AnagrOpereBean ys = null;

    private AnagrOpereBean() {
    }

    public static AnagrOpereBean getInstance() {
        if (ys == null) {
            ys = new AnagrOpereBean();
        }
        return ys;
    }

    public IAnagrOpere create(String strDES_OPE, String strNOM_OPE, long lCOD_AZL) throws CreateException {
        AnagrOpereBean bean = new AnagrOpereBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_OPE, strNOM_OPE, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_OPE);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrOpereBean bean = new AnagrOpereBean();
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

    public IAnagrOpere findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrOpereBean bean = new AnagrOpereBean();
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

    public Long ejbCreate(String strDES_OPE, String strNOM_OPE, long lCOD_AZL) {
        this.strNOM_OPE = strNOM_OPE;
        this.strDES_OPE = strDES_OPE;
        this.lCOD_OPE = NEW_ID(); // unic ID

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_ope_tab (cod_ope,des_ope,nom_ope,cod_azl) VALUES(?,?,?,?)");

            ps.setLong(1, lCOD_OPE);
            ps.setString(2, strDES_OPE);
            ps.setString(3, strNOM_OPE);
            ps.setLong(4, lCOD_AZL);

            ps.executeUpdate();
            return new Long(lCOD_OPE);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES_OPE) {
    }

    public long getlCOD_OPE() {
        return lCOD_OPE;
    }

    public void setlCOD_OPE(long newlCOD_PRO) {
        if (lCOD_OPE == newlCOD_PRO) {
            return;
        }
        lCOD_OPE = newlCOD_PRO;
        setModified();
    }

    public String getstrDES_OPE() {
        return strDES_OPE;
    }

    public String getstrNOM_OPE() {
        return strNOM_OPE;
    }

    public void setstrDES_OPE(String newstrDES_OPE) {
        if (strDES_OPE != null) {
            if (strDES_OPE.equals(newstrDES_OPE)) {
                return;
            }
        }
        strDES_OPE = newstrDES_OPE;
        setModified();
    }

    public void setstrNOM_OPE(String newstrNOM_OPE) {
        if (strNOM_OPE != null) {
            if (strNOM_OPE.equals(newstrNOM_OPE)) {
                return;
            }
        }
        strNOM_OPE = newstrNOM_OPE;
        setModified();
    }

//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ope FROM ana_ope_tab ");
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
        this.lCOD_OPE = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_OPE = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ope_tab  WHERE cod_ope=? ");
            ps.setLong(1, lCOD_OPE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_OPE = rs.getLong("COD_OPE");
                this.strDES_OPE = rs.getString("DES_OPE");
                this.strNOM_OPE = rs.getString("NOM_OPE");


//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_OPE + " non è trovato");
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
                    + "ana_ope_tab "
                    + "WHERE "
                    + "cod_ope = ? ");
            ps.setLong(1, lCOD_OPE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_OPE + " non è trovata");
            }
            ps.close();
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ope_tab  SET des_ope=?, nom_ope=? WHERE cod_ope=?");
            ps.setString(1, strDES_OPE);
            ps.setString(2, strNOM_OPE);
            ps.setLong(3, lCOD_OPE);

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
//-------------------------------------------------------------

    public Collection findEx(
            String strDES, String strNOM, long lCOD_AZL) {
        return (new AnagrOpereBean()).ejbFindEx(
                strDES, strNOM, lCOD_AZL);
    }

    public Collection ejbFindEx(
            String strDES_OPE, String strNOM_OPE, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query =
                    "SELECT "
                    + "a.cod_ope, "
                    + "a.des_ope, "
                    + "a.nom_ope "
                    + "FROM "
                    + "ana_ope_tab a "
                    + "where "
                    + "cod_azl=?";

            if ((strDES_OPE != null) && (!strDES_OPE.trim().equals(""))) {
                query += " AND UPPER(a.des_ope) LIKE ? ";
            }
            if ((strNOM_OPE != null) && (!strNOM_OPE.trim().equals(""))) {
                query += " AND UPPER(a.nom_ope) LIKE ?";
            }

            query += " ORDER BY UPPER(a.nom_ope)";

            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            int i = 2;

            if ((strDES_OPE != null) && (!strDES_OPE.trim().equals(""))) {
                ps.setString(i++, strDES_OPE.toUpperCase() + "%");
            }

            if ((strNOM_OPE != null) && (!strNOM_OPE.trim().equals(""))) {
                ps.setString(i++, strNOM_OPE.toUpperCase() + "%");
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrOpere_All_View obj = new AnagrOpere_All_View();
                obj.COD_OPE = rs.getLong(1);
                obj.DES_OPE = rs.getString(2);
                obj.NOM_OPE = rs.getString(3);

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

    public Collection getOpera_View(Long lCOD_CAN, Long lCOD_AZL) {
	return (new AnagrOpereBean()).ejbGetOpera_View(lCOD_CAN,lCOD_AZL);
    }

    public Collection ejbGetOpera_View(Long lCOD_CAN, Long lCOD_AZL) {
	java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
	try {
	    String sq = 
                    "SELECT "
                        + "ana_ope.cod_ope, "
                        + "ana_ope.nom_ope, "
                        + "ana_ope.des_ope "
                    + "FROM "
                        + "can_ope_tab can_ope, "
                        + "ana_ope_tab ana_ope "
                    + "WHERE "
                        + "can_ope.cod_ope = ana_ope.cod_ope "
                        + "and can_ope.cod_can = ? "
                        + "and ana_ope.cod_azl = ? "
                    + "ORDER BY "
                        + "UPPER(nom_ope) ASC";

	    PreparedStatement ps = bmp.prepareStatement(sq);
            ps.setLong(1, lCOD_CAN);
            ps.setLong(2, lCOD_AZL);
                    
	    ResultSet rs = ps.executeQuery();
	    while (rs.next()) {
		Opere_View obj = new Opere_View();
		obj.COD_OPE = rs.getLong(1);
		obj.NOM_OPE = rs.getString(2);
		obj.DES_OPE = rs.getString(3);
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

    public Collection getAnagrProcedimento_All_View() {
        return (new AnagrOpereBean()).ejbGetANA_PRO_TAB_DES_View();
    }

    public void deleteRischio(long lCOD_RSO, long lCOD_OPE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cst_rso_tab WHERE cod_rso=? AND cod_cst=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_OPE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio con ID=" + lCOD_RSO + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetANA_PRO_TAB_DES_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pro, des FROM ana_pro_tab ORDER BY des");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrOpere_All_View obj = new AnagrOpere_All_View();
                obj.COD_OPE = rs.getLong(1);
                obj.DES_OPE = rs.getString(2);
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

    public Collection getAnagr_All_View() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public Collection getCantieri_View(long lCOD_OPE, long lCOD_AZL) {
        return (new AnagrOpereBean()).ejbGetCantieri_View(lCOD_OPE, lCOD_AZL);
    }

    public Collection ejbGetCantieri_View(long lCOD_OPE, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT can.cod_can, can.nom_can FROM ana_can_tab can, ope_can_tab opecan WHERE can.cod_can = opecan.cod_can AND opecan.cod_ope = ? ORDER BY nom_can");
            ps.setLong(1, lCOD_OPE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Cantiere_View obj = new Cantiere_View();
                obj.COD_CAN = rs.getLong(1);
                obj.NOM_CAN = rs.getString(2);

                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_CAN(long lCOD_CAN, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ope_can_tab(cod_ope,cod_can) VALUES(?,?)");
            ps.setLong(1, lCOD_OPE);
            ps.setLong(2, lCOD_CAN);
            //ps.setString (4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteCantiere(long lCOD_CAN, long lCOD_OPE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ope_can_tab WHERE cod_can=? AND cod_ope=?");
            ps.setLong(1, lCOD_CAN);
            ps.setLong(2, lCOD_OPE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Cantiere con ID=" + lCOD_CAN + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
}
