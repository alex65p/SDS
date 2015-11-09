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
package com.apconsulting.luna.ejb.TipologiaMisurePreventive;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class TipologiaMisurePreventiveBean extends BMPEntityBean implements ITipologiaMisurePreventive, ITipologiaMisurePreventiveHome {
    //< member-varibles description="Member Variables">

    long lCOD_TPL_MIS_PET;
    String strDES_TPL_MIS_PET;
    //< /member-varibles>

    //< ITipologiaMisurePreventiveHome-implementation>
    public static final String BEAN_NAME = "TipologiaMisurePreventiveBean";
    private static TipologiaMisurePreventiveBean ys = null;

    private TipologiaMisurePreventiveBean() {
    }

    public static TipologiaMisurePreventiveBean getInstance() {
        if (ys == null) {
            ys = new TipologiaMisurePreventiveBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        TipologiaMisurePreventiveBean bean = new TipologiaMisurePreventiveBean();
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

    public ITipologiaMisurePreventive create(String strDES_TPL_MIS_PET) throws javax.ejb.CreateException {
        TipologiaMisurePreventiveBean bean = new TipologiaMisurePreventiveBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_TPL_MIS_PET);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_TPL_MIS_PET);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public ITipologiaMisurePreventive findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        TipologiaMisurePreventiveBean bean = new TipologiaMisurePreventiveBean();
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

    public Collection getTipologiaByDescription_View(String strDecription) {
        return (new TipologiaMisurePreventiveBean()).ejbGetTipologiaByDescription_View(strDecription);
    }

    public Collection getTipologia_View() {
        return (new TipologiaMisurePreventiveBean()).ejbGetTipologia_View();
    }
    //---------------------------

    public Long ejbCreate(String strDES_TPL_MIS_PET) {
        this.lCOD_TPL_MIS_PET = NEW_ID();
        this.strDES_TPL_MIS_PET = strDES_TPL_MIS_PET;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO tpl_mis_pet_tab (cod_tpl_mis_pet,des_tpl_mis_pet) VALUES(?,?)");
            ps.setLong(1, lCOD_TPL_MIS_PET);
            ps.setString(2, strDES_TPL_MIS_PET);
            ps.executeUpdate();
            return new Long(lCOD_TPL_MIS_PET);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strDES_TPL_MIS_PET) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_tpl_mis_pet FROM tpl_mis_pet_tab");
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
        this.lCOD_TPL_MIS_PET = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_TPL_MIS_PET = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_tpl_mis_pet,des_tpl_mis_pet FROM tpl_mis_pet_tab WHERE cod_tpl_mis_pet=?");
            ps.setLong(1, lCOD_TPL_MIS_PET);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_TPL_MIS_PET = rs.getLong(1);
                strDES_TPL_MIS_PET = rs.getString(2);
            } else {
                throw new NoSuchEntityException("TipologiaMisurePreventive with ID=" + lCOD_TPL_MIS_PET + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM tpl_mis_pet_tab WHERE cod_tpl_mis_pet=?");
            ps.setLong(1, lCOD_TPL_MIS_PET);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("TipologiaMisurePreventive with ID=" + lCOD_TPL_MIS_PET + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE tpl_mis_pet_tab SET cod_tpl_mis_pet=?, des_tpl_mis_pet=? WHERE cod_tpl_mis_pet=?");
            ps.setLong(1, lCOD_TPL_MIS_PET);
            ps.setString(2, strDES_TPL_MIS_PET);
            ps.setLong(3, lCOD_TPL_MIS_PET);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("TipologiaMisurePreventive with ID=" + lCOD_TPL_MIS_PET + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //< setter-getters>
    public long getCOD_TPL_MIS_PET() {
        return lCOD_TPL_MIS_PET;
    }

    public String getDES_TPL_MIS_PET() {
        return strDES_TPL_MIS_PET;
    }

    public void setDES_TPL_MIS_PET(String strDES_TPL_MIS_PET) {
        if ((this.strDES_TPL_MIS_PET != null) && (this.strDES_TPL_MIS_PET.equals(strDES_TPL_MIS_PET))) {
            return;
        }
        this.strDES_TPL_MIS_PET = strDES_TPL_MIS_PET;
        setModified();
    }

    //< /setter-getters>
    public Collection ejbGetTipologiaByDescription_View(String strDecription) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_tpl_mis_pet, des_tpl_mis_pet from tpl_mis_pet_tab where des_tpl_mis_pet like ? order by  des_tpl_mis_pet ");
            ps.setString(1, strDecription);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaView obj = new TipologiaView();
                obj.lCOD_TPL_MIS_PET = rs.getLong(1);
                obj.strDES_TPL_MIS_PET = rs.getString(2);
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

    public Collection ejbGetTipologia_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_tpl_mis_pet, des_tpl_mis_pet from tpl_mis_pet_tab  order by  des_tpl_mis_pet ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaView obj = new TipologiaView();
                obj.lCOD_TPL_MIS_PET = rs.getLong(1);
                obj.strDES_TPL_MIS_PET = rs.getString(2);
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
