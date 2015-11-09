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
package com.apconsulting.luna.ejb.UnitaOrganizzativa;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class UnitaOrganizzativaBean extends BMPEntityBean implements IUnitaOrganizzativa, IUnitaOrganizzativaHome {
//<member-varibles description="Member Variables">

    long lCOD_UNI_ORG;
    String strNOM_UNI_ORG;
    String strDES_UNI_ORG;
    String strEMAIL;
    long lCOD_TPL_UNI_ORG;
    long lCOD_UNI_ORG_ASC;
    long lCOD_DPD;
    long lCOD_AZL;
    String strDVR;
      boolean isError = false;
    String strError = "";
//</member-varibles>

//<IUnitaOrganizzativaHome-implementation>
    public static final String BEAN_NAME = "UnitaOrganizzativaBean";
    private static UnitaOrganizzativaBean ys = null;

    private UnitaOrganizzativaBean() {
    }

    public static UnitaOrganizzativaBean getInstance() {
        if (ys == null) {
            ys = new UnitaOrganizzativaBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        UnitaOrganizzativaBean bean = new UnitaOrganizzativaBean();
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
//

    public IUnitaOrganizzativa create(String strNOM_UNI_ORG, long lCOD_TPL_UNI_ORG, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
        UnitaOrganizzativaBean bean = new UnitaOrganizzativaBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_UNI_ORG, lCOD_TPL_UNI_ORG, lCOD_DPD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_UNI_ORG, lCOD_TPL_UNI_ORG, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
//

    public IUnitaOrganizzativa findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        UnitaOrganizzativaBean bean = new UnitaOrganizzativaBean();
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

    public Long ejbCreate(String strNOM_UNI_ORG, long lCOD_TPL_UNI_ORG, long lCOD_DPD, long lCOD_AZL) {
        this.lCOD_UNI_ORG = NEW_ID();
        this.strNOM_UNI_ORG = strNOM_UNI_ORG;
        this.lCOD_TPL_UNI_ORG = lCOD_TPL_UNI_ORG;
        this.lCOD_DPD = lCOD_DPD;
        this.lCOD_AZL = lCOD_AZL;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_uni_org_tab (cod_uni_org,nom_uni_org,cod_tpl_uni_org,cod_dpd,cod_azl) VALUES(?,?,?,?,?)");
            ps.setLong(1, lCOD_UNI_ORG);
            ps.setString(2, strNOM_UNI_ORG);
            ps.setLong(3, lCOD_TPL_UNI_ORG);
            ps.setLong(4, lCOD_DPD);
            ps.setLong(5, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_UNI_ORG);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strNOM_UNI_ORG, long lCOD_TPL_UNI_ORG, long lCOD_DPD, long lCOD_AZL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org FROM ana_uni_org_tab");
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
        this.lCOD_UNI_ORG = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_UNI_ORG = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org,nom_uni_org,des_uni_org,cod_tpl_uni_org,cod_uni_org_asc,cod_dpd,cod_azl,dvr,email FROM ana_uni_org_tab WHERE cod_uni_org=?");
            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_UNI_ORG = rs.getLong(1);
                strNOM_UNI_ORG = rs.getString(2);
                strDES_UNI_ORG = rs.getString(3);
                lCOD_TPL_UNI_ORG = rs.getLong(4);
                lCOD_UNI_ORG_ASC = rs.getLong(5);
                lCOD_DPD = rs.getLong(6);
                lCOD_AZL = rs.getLong(7);
                strDVR = rs.getString(8);
                strEMAIL = rs.getString(9);
            } else {
                throw new NoSuchEntityException("UnitaOrganizzativa with ID=" + lCOD_UNI_ORG + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_uni_org_tab WHERE cod_uni_org=?");
            ps.setLong(1, lCOD_UNI_ORG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("UnitaOrganizzativa with ID=" + lCOD_UNI_ORG + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_uni_org_tab SET nom_uni_org=?, des_uni_org=?, cod_tpl_uni_org=?, cod_uni_org_asc=?, cod_dpd=?, cod_azl=?, dvr='" + (strDVR == null ? "N" : strDVR) + "', email=? WHERE cod_uni_org=?");
            ps.setString(1, strNOM_UNI_ORG);
            ps.setString(2, strDES_UNI_ORG);
            ps.setLong(3, lCOD_TPL_UNI_ORG);
            if (lCOD_UNI_ORG_ASC == 0) {
                ps.setNull(4, java.sql.Types.BIGINT);
            } else {
                ps.setLong(4, lCOD_UNI_ORG_ASC);
            }
            ps.setLong(5, lCOD_DPD);
            ps.setLong(6, lCOD_AZL);
            ps.setString(7, strEMAIL);
            ps.setLong(8, lCOD_UNI_ORG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("UnitaOrganizzativa with ID=" + lCOD_UNI_ORG + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getFirstUOWithEmail(long lCOD_UNI_ORG) {
        return (new UnitaOrganizzativaBean()).ejbGetFirstUOWithEmail(lCOD_UNI_ORG);
    }

    public Collection ejbGetFirstUOWithEmail(long lCOD_UNI_ORG) {
        String _strEMAIL = null;
        String _strNOM_UNI_ORG = null;

        BMPConnection bmp = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        java.util.ArrayList al = null;
        UOEmail_View _UOEmail_View = null;

        try {
            bmp = getConnection();
            while ((_strEMAIL == null || _strEMAIL.trim().equals("")) && lCOD_UNI_ORG > 0) {
                ps = bmp.prepareStatement("select cod_uni_org_asc, nom_uni_org, email from ana_uni_org_tab where cod_uni_org = ?");
                ps.setLong(1, lCOD_UNI_ORG);
                rs = ps.executeQuery();
                rs.next();
                lCOD_UNI_ORG = rs.getLong("COD_UNI_ORG_ASC");
                _strNOM_UNI_ORG = rs.getString("NOM_UNI_ORG");
                _strEMAIL = rs.getString("EMAIL");
                rs.close();
                ps.close();
            }
            if (_strEMAIL != null && !_strEMAIL.trim().equals("")) {
                al = new java.util.ArrayList();
                UOEmail_View obj = new UOEmail_View();
                obj.lCOD_UNI_ORG = lCOD_UNI_ORG;
                obj.strNOM_UNI_ORG = _strNOM_UNI_ORG;
                obj.strEMAIL = _strEMAIL;
                al.add(obj);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
            return al;
        }
    }

    public Collection getComboView(long lCOD_AZL) {
        return this.ejbGetComboView(lCOD_AZL);
    }

    public Collection getDvrComboView(long lCOD_AZL) {
        return this.ejbGetDvrComboView(lCOD_AZL);
    }

    public Collection getUnitaOrganizzativaView(long lCOD_AZL) {
        return (new UnitaOrganizzativaBean()).ejbGetUnitaOrganizzativaView(lCOD_AZL);
    }

    public Collection getTopOfTree(long lCOD_AZL) {
        return (new UnitaOrganizzativaBean()).ejbGetTopOfTree(lCOD_AZL);
    }
   
    public Collection findEx(String NOM, String DES, long iOrderBy) {
        return (new UnitaOrganizzativaBean()).ejbfindEx(NOM, DES, iOrderBy);
    }

    /* public Collection getAllAttivitaLavorativaView(long lCOD_AZL){
    return (new UnitaOrganizzativaBean()).ejbGetAllAttivitaLavorativaView(lCOD_AZL);
    }*/
//----------------------
    public Collection ejbGetComboView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org  FROM ana_uni_org_tab WHERE cod_azl=? ORDER BY nom_uni_org");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UnitaOrganizzativa_ComboView w = new UnitaOrganizzativa_ComboView();
                w.lCOD_UNI_ORG = rs.getLong(1);
                w.strNOM_UNI_ORG = rs.getString(2);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetDvrComboView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org  FROM ana_uni_org_tab WHERE cod_azl=? AND dvr='S' ORDER BY nom_uni_org");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UnitaOrganizzativa_ComboView w = new UnitaOrganizzativa_ComboView();
                w.lCOD_UNI_ORG = rs.getLong(1);
                w.strNOM_UNI_ORG = rs.getString(2);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetUnitaOrganizzativaView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org, des_uni_org, cod_tpl_uni_org, cod_uni_org_asc, cod_dpd FROM ana_uni_org_tab WHERE cod_azl=? ORDER BY 1");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UnitaOrganizzativaView w = new UnitaOrganizzativaView();
                w.lCOD_UNI_ORG = rs.getLong(1);
                w.strNOM_UNI_ORG = rs.getString(2);
                w.strDES_UNI_ORG = rs.getString(3);
                w.lCOD_TPL_UNI_ORG = rs.getLong(4);
                w.lCOD_UNI_ORG_ASC = rs.getLong(5);
                w.lCOD_DPD = rs.getLong(6);
                al.add(w);

            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetTopOfTree(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org, des_uni_org, cod_tpl_uni_org, cod_uni_org_asc, cod_dpd, dvr FROM ana_uni_org_tab WHERE cod_uni_org_asc is null and cod_azl=? ");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
        while (rs.next()) {
                UnitaOrganizzativaView w = new UnitaOrganizzativaView();

                w.lCOD_UNI_ORG = rs.getLong(1);
                w.strNOM_UNI_ORG = rs.getString(2);
                w.strDES_UNI_ORG = rs.getString(3);
                w.lCOD_TPL_UNI_ORG = rs.getLong(4);
                w.lCOD_UNI_ORG_ASC = rs.getLong(5);
                w.lCOD_DPD = rs.getLong(6);
                w.DVR=rs.getString(7);
                al.add(w);


            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getChildren(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org, des_uni_org, cod_tpl_uni_org, cod_uni_org_asc, cod_dpd, dvr  FROM ana_uni_org_tab WHERE cod_uni_org_asc=? and cod_azl=?");
            ps.setLong(1, lCOD_UNI_ORG);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UnitaOrganizzativaView w = new UnitaOrganizzativaView();
                w.lCOD_UNI_ORG = rs.getLong(1);
                w.strNOM_UNI_ORG = rs.getString(2);
                w.strDES_UNI_ORG = rs.getString(3);
                w.lCOD_TPL_UNI_ORG = rs.getLong(4);
                w.lCOD_UNI_ORG_ASC = rs.getLong(5);
                w.lCOD_DPD = rs.getLong(6);
                w.DVR=rs.getString(7);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    } 

    public ResponsabileView getResponsabile(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select mtr_dpd, cog_dpd, nom_dpd  from view_ana_dpd_tab   where cod_dpd = ?     and cod_azl = ? ");
            ps.setLong(1, lCOD_DPD);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            ResponsabileView w = new ResponsabileView();
            if (rs.next()) {
                w.strMTR_DPD = rs.getString(1);
                w.strCOG_DPD = rs.getString(2);
                w.strNOM_DPD = rs.getString(3);
                w.lCOD_DPD = lCOD_DPD;
            }
            return w;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------TABS--------------------------

    public Collection getLuoghiFisiciView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "lf.cod_luo_fsc, "
                        + "lf.nom_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab lf, "
                        + "uni_org_luo_fsc_tab uo "
                    + "where "
                        + "uo.cod_luo_fsc = lf.cod_luo_fsc "
                        + "and uo.cod_uni_org=?");
            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                LuoghiFisiciView obj = new LuoghiFisiciView();
                obj.lCOD_LUO_FSC = rs.getLong(1);
                obj.strNOM_LUO_FSC = rs.getString(2);
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


//
    public Collection getAttivitaLavorativaView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(" select am.cod_man,am.nom_man  from ana_man_tab am, man_uni_org_tab mu	 where mu.cod_uni_org = ? and mu.cod_man=am.cod_man");
            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();

            while (rs.next()) {
                AttivitaLavorativaView w = new AttivitaLavorativaView();
                w.lCOD_MAN = rs.getLong(1);
                w.strNOM_MAN = rs.getString(2);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    public Collection getAllAttivitaLavorativaView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_man, nom_man from ana_man_tab where cod_azl = ? and nom_man like '%' and cod_man not in (select v.cod_man from man_uni_org_tab v where v.cod_uni_org = ?) order by nom_man");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaLavorativaView obj = new AttivitaLavorativaView();
                obj.lCOD_MAN = rs.getLong(1);
                obj.strNOM_MAN = rs.getString(2);
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
//

    public void addLuogoFisico(long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("insert into uni_org_luo_fsc_tab(cod_luo_fsc, cod_uni_org)  values(?, ?)");
            ps.setLong(1, lCOD_LUO_FSC);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getLuogoFisico(long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_uni_org, cod_luo_fsc from uni_org_luo_fsc_tab where cod_uni_org = ? and cod_luo_fsc = ?");
            ps.setLong(1, lCOD_UNI_ORG);
            ps.setLong(2, lCOD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UnitaOrganizzativa_LuogoFisico_View obj = new UnitaOrganizzativa_LuogoFisico_View();
                obj.lCOD_UNI_ORG = rs.getLong(1);
                obj.lCOD_LUO_FSC = rs.getLong(2);
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

    public void deleteLuogoFisico(long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM uni_org_luo_fsc_tab WHERE cod_luo_fsc=? AND cod_uni_org=?");
            ps.setLong(1, lCOD_LUO_FSC);
            ps.setLong(2, lCOD_UNI_ORG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Luogo fisico con ID=" + lCOD_LUO_FSC + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addAttivitaLavorativa(long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(" insert into man_uni_org_tab(cod_man, cod_uni_org)  values(?, ?)");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteAttivitaLavorativa(long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM man_uni_org_tab WHERE cod_man=? AND cod_uni_org=?");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_UNI_ORG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Luogo fisico con ID=" + lCOD_MAN + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//<report>
    public Collection getReportUnitaOrganizzativa_LuogoFisico_DPI_View() {
        BMPConnection bmp = getConnection();
        try {
            /* Nella stampa della scheda di reparto (Unità organizzativa), vengono
               stampati i luoghi fisici ad essa associati, solo se questi ultimi
               hanno a loro volta dei dpi associati (ereditati dai rischi ad essi
               collegati)
             */
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "a.cod_luo_fsc, " +
                        "d.nom_luo_fsc, " +
                        "c.nom_tpl_dpi " +
                    "FROM " +
                        "uni_org_luo_fsc_tab a, " +
                        "dpi_luo_fsc_tab b, " +
                        "tpl_dpi_tab c, " +
                        "ana_luo_fsc_tab d " +
                    "WHERE " +
                        "a.cod_luo_fsc = b.cod_luo_fsc " +
                        "AND b.cod_tpl_dpi = c.cod_tpl_dpi " +
                        "AND a.cod_luo_fsc = d.cod_luo_fsc " +
                        "AND a.cod_uni_org = ? " +
                    "ORDER BY " +
                        "d.nom_luo_fsc ");

            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportUnitaOrganizzativa_LuogoFisico_DPI_View w = new ReportUnitaOrganizzativa_LuogoFisico_DPI_View();
                w.lCOD_LUO_FSC = rs.getLong(1);
                w.strNOM_LUO_FSC = rs.getString(2);
                w.strNOM_TPL_DPI = rs.getString(3);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportUnitaOrganizzativa_RefSicurezza_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    " A.cod_dpd, " +
                    " A.nom_dpd, " +
                    " A.cog_dpd, " +
                    " A.IDZ_PSA_ELT_DPD " +
                    " FROM   VIEW_ANA_DPD_TAB A, UO_UNI_SIC_TAB B, ANA_UNI_SIC_TAB C " +
                    " WHERE   " +
                    " a.cod_dpd = b.cod_dpd " +
                    " AND b.cod_uni_sic  = c.cod_uni_sic " +
                    " AND B.COD_UNI_ORG =? " +
                    " ORDER BY 3");


            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportUnitaOrganizzativa_RefSicurezza_View w = new ReportUnitaOrganizzativa_RefSicurezza_View();
                w.lCOD_DPD = rs.getLong(1);
                w.strNOM_DPD = rs.getString(3);
                w.strCOG_DPD = rs.getString(2);
                w.strIDZ_PSA_ELT_DPD = rs.getString(4);

                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    public Collection getReportUnitaOrganizzativa_Resp_UnitàSicurezza_View()  {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                (" SELECT Distinct UPPER(a.nom_dpd),UPPER(a.cog_dpd),b.EMAIL "+
                 " FROM   view_ana_dpd_tab a,ana_uni_org_tab b"+
                 " WHERE  a.cod_dpd=b.cod_dpd "+
                 " AND    a.cod_azl=b.cod_azl "+
                 " AND    b.COD_UNI_ORG=?");
            ps.setLong(1, lCOD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
            ResponsabileView w = new ResponsabileView();
            w.strNOM_DPD = rs.getString(1);
            w.strCOG_DPD = rs.getString(2);
            w.strEMAIL=rs.getString(3);
            al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    //  Dario 09-05-2007
                    // Bug N° 1.26 nel file di correzione anomalie.
                    /*  Questa query viene effettuata nel report delle unità organizzative,
                    non estrae però quelle unità organizzative a cui non è associato
                    un dipendente ed inoltre associa, in maniera errata, tutte le
                    attività lavorative ad ogni dipendente aziendale.

                    "SELECT "+
                    " a.cod_man, "+
                    " a.nom_man, "+
                    " bb.nom_dpd||' '||bb.cog_dpd "+
                    " FROM    "+
                    " VIEW_ANA_DPD_TAB bb, MAN_DPD_UNI_ORG_TAB c, ANA_MAN_TAB a, MAN_UNI_ORG_TAB b "+
                    " WHERE  bb.cod_dpd = c.cod_dpd and  "+
                    " a.cod_man = b.cod_man "+
                    " and a.cod_azl =? "+
                    " and b.cod_uni_org=c.cod_uni_org  "+
                    " and bb.cod_azl = ? "+
                    " and b.cod_uni_org = ? "+
                    " ORDER BY 2, 3 "
                     */
                    "SELECT  " +
                    "d.cod_man, " +
                    "d.nom_man, " +
                    "c.cog_dpd||' '||c.nom_dpd AS NOMINATIVO " +
                    "FROM " +
                    "MAN_UNI_ORG_TAB a " +
                    "LEFT OUTER JOIN MAN_DPD_UNI_ORG_TAB b " +
                    "ON (a.cod_man = b.cod_man and a.cod_uni_org = b.cod_uni_org) " +
                    "LEFT OUTER JOIN VIEW_ANA_DPD_TAB c " +
                    "ON (b.cod_dpd = c.cod_dpd) " +
                    "LEFT OUTER JOIN ANA_MAN_TAB d " +
                    "ON (b.cod_man = d.cod_man or a.cod_man = d.cod_man) " +
                    "WHERE " +
                        "CURRENT_DATE BETWEEN b.DAT_INZ AND b.DAT_FIE " +
                        "AND a.cod_uni_org = ? " +
                        "OR b.DAT_FIE IS NULL " +
                        "AND a.cod_uni_org = ? " +
                        "AND b.cod_azl = ? " +
                        "ORDER BY " +
                        "2, 3 ");

            ps.setLong(1, lCOD_UNI_ORG);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.setLong(3, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View w = new ReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View();
                w.lCOD_MAN = rs.getLong(1);
                w.strNOM_MAN = rs.getString(2);
                w.strNOM_COG_DPD = rs.getString(3);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//</report>

//////////////////////<Kushkarov for new Search>///////////////////////////
    public Collection ejbfindEx(String NOM, String DES, long iOrderBy) {
        String Sql = "SELECT cod_tpl_uni_org, nom_tpl_uni_org, des_tpl_uni_org FROM tpl_uni_org_tab ";
        int i = 1;
        int desIndex = 0;
        int nomIndex = 0;
        if (NOM != null) {
            Sql += " WHERE ";
            Sql += " UPPER(nom_tpl_uni_org) LIKE ?";
            nomIndex = i++;
        }
        if (DES != null) {
            if (nomIndex != 0) {
                Sql += " AND ";
            } else {
                Sql += " WHERE ";
            }
            Sql += " UPPER(des_tpl_uni_org) LIKE ? ";
            desIndex = i++;
        }
        Sql += " ORDER BY nom_tpl_uni_org ";//+ (iOrderBy>0?" ASC": "DESC");
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (nomIndex != 0) {
                ps.setString(nomIndex, NOM.toUpperCase() + "%");
            }
            if (desIndex != 0) {
                ps.setString(desIndex, DES.toUpperCase() + "%");
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_tpl_uni_org obj = new findEx_tpl_uni_org();
                obj.COD_TPL_UNI_ORG = rs.getLong(1);
                obj.NOM_TPL_UNI_ORG = rs.getString(2);
                obj.DES_TPL_UNI_ORG = rs.getString(3);
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
public String buildTreeNodes(IUnitaOrganizzativa bean, IUnitaOrganizzativaHome home, long n, long COD_UNI_ORG,long lCOD_AZL,boolean build )
{
  Collection c;
        Iterator i;
        String selected;
        long azienda = lCOD_AZL;
        String strNodes = "";
        
        try {
            if (n == 0) {

                c = home.getTopOfTree(azienda);
                i = c.iterator();
                n++;

                if (i != null) {
                    while (i.hasNext()) {

                        UnitaOrganizzativaView view = (UnitaOrganizzativaView) i.next();

                         strNOM_UNI_ORG = view.strNOM_UNI_ORG;
                         lCOD_UNI_ORG = view.lCOD_UNI_ORG;
                         strDVR=view.DVR;

                     
                       if (COD_UNI_ORG == lCOD_UNI_ORG) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                         if(build==false)
                           {
                             strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">" + strNOM_UNI_ORG + "</option>";
                           }
                         else
                         {
                           if(strDVR.equals("S"))
                              strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">" + strNOM_UNI_ORG + "</option>";
                           else
                              {
                                strNodes+="<optgroup  id='"+lCOD_UNI_ORG+"' label='"+strNOM_UNI_ORG+"'>";
                                strNodes+="</optgroup>";
                              }
                         }
                        bean = home.findByPrimaryKey(new Long(lCOD_UNI_ORG));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_ORG,lCOD_AZL,build);
                        if (isError) {
                            return "";
                        }
                    }
                }
            } else {


                c = bean.getChildren(azienda);
                i = c.iterator();
                n++;
                if (i != null) {
                    while (i.hasNext()) {
                        UnitaOrganizzativaView view = (UnitaOrganizzativaView) i.next();
                        strNOM_UNI_ORG = view.strNOM_UNI_ORG;
                        lCOD_UNI_ORG = view.lCOD_UNI_ORG;
                        String stDVR=view.DVR;
                        if (COD_UNI_ORG == lCOD_UNI_ORG) {
                            selected = "selected";
                        } else {
                            selected = "";
                        }
                        if(build==false)
                          {
                             strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">";
                                for (long y = 0; y < n; y++) strNodes += "&nbsp;&nbsp;&nbsp;";
                                strNodes += strNOM_UNI_ORG + "</option>";

                          }
                        else
                        {
                          if(stDVR.equals("S"))
                            {
                              strNodes += "<option value='" + lCOD_UNI_ORG + "' " + selected + ">";
                              for (long y = 0; y < n; y++) strNodes += "&nbsp;&nbsp;&nbsp;";
                              strNodes += strNOM_UNI_ORG + "</option>";
                            }
                          else
                           {
                             String strSpace="";
                             for (long y = 0; y < n; y++) strSpace += "&nbsp;&nbsp;&nbsp;";
                             strNodes+="<optgroup  id='"+lCOD_UNI_ORG+"' label='"+strSpace+strNOM_UNI_ORG+"' disabled>";
                             strNodes+="</optgroup>";

                           }
                        }
                        bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_ORG));
                        strNodes += buildTreeNodes(bean, home, n, COD_UNI_ORG,lCOD_AZL,build);
                        if (isError) {
                            return "";
                        }
                    }
                }
            }
        } catch (Exception ex) {
            strError += ex.getMessage();
            return "";
        }
        return strNodes;

}
  

//////////////////////</Kushkarov for new Search>//////////////////////////


//<setter-getters>
    public long getCOD_UNI_ORG() {
        return lCOD_UNI_ORG;
    }

    public String getNOM_UNI_ORG() {
        return strNOM_UNI_ORG;
    }

    public void setNOM_UNI_ORG(String strNOM_UNI_ORG) {
        if ((this.strNOM_UNI_ORG != null) && (this.strNOM_UNI_ORG.equals(strNOM_UNI_ORG))) {
            return;
        }
        this.strNOM_UNI_ORG = strNOM_UNI_ORG;
        setModified();
    }

    public String getDES_UNI_ORG() {
        return strDES_UNI_ORG;
    }

    public void setDES_UNI_ORG(String strDES_UNI_ORG) {
        if ((this.strDES_UNI_ORG != null) && (this.strDES_UNI_ORG.equals(strDES_UNI_ORG))) {
            return;
        }
        this.strDES_UNI_ORG = strDES_UNI_ORG;
        setModified();
    }

    public String getEMAIL() {
        return strEMAIL;
    }

    public void setEMAIL(String strEMAIL) {
        if ((this.strEMAIL != null) && (this.strEMAIL.equals(strEMAIL))) {
            return;
        }
        this.strEMAIL = strEMAIL;
        setModified();
    }

    public String getDVR() {
        return strDVR;
    }

    public void setDVR(String strDVR) {
        if ((this.strDVR != null) && (this.strDVR.equals(strDVR))) {
            return;
        }
        this.strDVR = strDVR;
        setModified();
    }

    public long getCOD_TPL_UNI_ORG() {
        return lCOD_TPL_UNI_ORG;
    }

    public void setCOD_TPL_UNI_ORG(long lCOD_TPL_UNI_ORG) {
        if (this.lCOD_TPL_UNI_ORG == lCOD_TPL_UNI_ORG) {
            return;
        }
        this.lCOD_TPL_UNI_ORG = lCOD_TPL_UNI_ORG;
        setModified();
    }

    public long getCOD_UNI_ORG_ASC() {
        return lCOD_UNI_ORG_ASC;
    }

    public void setCOD_UNI_ORG_ASC(long lCOD_UNI_ORG_ASC) {
        if (this.lCOD_UNI_ORG_ASC == lCOD_UNI_ORG_ASC) {
            return;
        }
        this.lCOD_UNI_ORG_ASC = lCOD_UNI_ORG_ASC;
        setModified();
    }

    public long getCOD_DPD() {
        return lCOD_DPD;
    }

    public void setCOD_DPD(long lCOD_DPD) {
        if (this.lCOD_DPD == lCOD_DPD) {
            return;
        }
        this.lCOD_DPD = lCOD_DPD;
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

    public void setCOD_DPD__COD_AZL(long lCOD_DPD, long lCOD_AZL) {
        if (this.lCOD_AZL == lCOD_AZL && this.lCOD_DPD == lCOD_DPD) {
            return;
        }
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_DPD = lCOD_DPD;
        setModified();
    }

//</setter-getters>
}
