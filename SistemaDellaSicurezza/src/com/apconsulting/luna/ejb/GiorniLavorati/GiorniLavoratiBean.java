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
package com.apconsulting.luna.ejb.GiorniLavorati;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
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
public class GiorniLavoratiBean extends BMPEntityBean implements IGiorniLavorati, IGiorniLavoratiHome {

    long COD_AZL;
    long ANNO;
    long GRN_LAV;
    long ANNOID;
    GiorniLavoratiPK primaryKEY = null;
    public static final String BEAN_NAME = "GiorniLavorati";
    private static GiorniLavoratiBean ys = null;

    private GiorniLavoratiBean() {
        //
    }

    public static GiorniLavoratiBean getInstance() {
        if (ys == null) {
            ys = new GiorniLavoratiBean();
        }
        return ys;
    }

    public IGiorniLavorati create(
            long lCOD_AZL, long lANNO, long lGRN_LAV) throws javax.ejb.CreateException {
        GiorniLavoratiBean bean = new GiorniLavoratiBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, lANNO, lGRN_LAV);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lGRN_LAV, lANNO, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IGiorniLavorati findByPrimaryKey(GiorniLavoratiPK primaryKey) throws javax.ejb.FinderException {
        GiorniLavoratiBean bean = new GiorniLavoratiBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //==========================================================================================

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getGiorniLavoratiByAZLID_View(long AZL_ID) {
        return (new GiorniLavoratiBean()).ejbGetGiorniLavoratiByAZLID_View(AZL_ID);
    }

    public GiorniLavoratiPK ejbCreate(
            long lANNO,
            long lGRN_LAV,
            long lCOD_AZL) {

        this.ANNO = lANNO;
        this.GRN_LAV = lGRN_LAV;
        this.COD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_grn_lav_tab ( ann_rif, grn_lav, cod_azl) VALUES (?, ?, ?)");
            ps.setLong(1, ANNO);
            ps.setLong(2, GRN_LAV);
            ps.setLong(3, COD_AZL);
            ps.executeUpdate();
            return new GiorniLavoratiPK(this.COD_AZL, this.ANNO);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------

    public void ejbPostCreate(
            long lANNO,
            long lGRN_LAV,
            long lCOD_AZL) {
    }

    public boolean isMultiple() {
        return isExtendedObject("ana_grn_lav_tab", ANNO);
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ann_rif FROM ana_grn_lav ");
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

    public GiorniLavoratiPK ejbFindByPrimaryKey(GiorniLavoratiPK primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

//----------------------------------------------------------
    public void ejbPassivate() {
        this.ANNO = -1;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.primaryKEY = ((GiorniLavoratiPK) this.getEntityKey());
        this.ANNO = primaryKEY.lANNO;
        this.COD_AZL = primaryKEY.lCOD_AZL;
    }

//----------------------------------------------------------
    public void remove(GiorniLavoratiPK primaryKey) {
        GiorniLavoratiBean iGiorniLavorati = new GiorniLavoratiBean();
        try {
            Object obj = iGiorniLavorati.ejbFindByPrimaryKey(primaryKey);
            iGiorniLavorati.setEntityContext(new EntityContextWrapper(obj));
            iGiorniLavorati.ejbActivate();
            iGiorniLavorati.ejbLoad();
            iGiorniLavorati.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_grn_lav_tab  WHERE ann_rif=?");
            ps.setLong(1, ANNO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.ANNO = rs.getLong("ANN_RIF");
                this.GRN_LAV = rs.getLong("GRN_LAV");
                //this.COD_AZL = rs.getLong("COD_AZL");

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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_grn_lav_tab  WHERE ann_rif=? and grn_lav=?");
            ps.setLong(1, ANNO);
            ps.setLong(2, GRN_LAV);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("azienda con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_grn_lav_tab SET ann_rif=?, grn_lav=?  WHERE cod_azl=? and ann_rif=?");
            ps.setLong(1, ANNO);
            ps.setLong(2, GRN_LAV);
            ps.setLong(3, COD_AZL);
            ps.setLong(4, ANNOID);
            if (ps.executeUpdate() == 0) {
            }
        } catch (Exception ex) {
            //throw new EJBException(ex);
            ex.printStackTrace();
        } finally {
            bmp.close();
        }
    }

    public void setANNO(long newANNO) {
        ANNO = newANNO;
        setModified();
    }

    public void setANNOID(long newANNOID) {
        ANNOID = newANNOID;
    }

    public void setGRN_LAV(long newGRN_LAV) {
        GRN_LAV = newGRN_LAV;
        setModified();
    }

    public void setCOD_AZL(long newCOD_AZL) {
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getANNO() {
        return ANNO;
    }

    public long getANNOID() {
        return ANNOID;
    }

    public long getGRN_LAV() {
        return GRN_LAV;
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }

    public Collection ejbGetGiorniLavoratiByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ann_rif,grn_lav FROM ana_grn_lav_tab WHERE cod_azl=? order by ann_rif ");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GiorniLavoratiByAZLID_View obj = new GiorniLavoratiByAZLID_View();
                obj.ANNO = rs.getLong(1);
                obj.GRN_LAV = rs.getLong(2);
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
