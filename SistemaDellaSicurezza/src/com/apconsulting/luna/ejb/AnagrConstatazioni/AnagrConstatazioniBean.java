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
package com.apconsulting.luna.ejb.AnagrConstatazioni;

import com.apconsulting.luna.ejb.AssociativaAgentoChimico.Rischi_View;
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
public class AnagrConstatazioniBean extends BMPEntityBean implements IAnagrConstatazioniHome, IAnagrConstatazioni {

    long lCOD_CST;
    String strDES;
    String strNOM;
    long lCOD_FAT_RSO;
    private static AnagrConstatazioniBean ys = null;

    private AnagrConstatazioniBean() {
    }

    public static AnagrConstatazioniBean getInstance() {
        if (ys == null) {
            ys = new AnagrConstatazioniBean();
        }
        return ys;
    }

    public Collection getRischi_View(long lCOD_CST, long lCOD_AZL) {
        return (new AnagrConstatazioniBean()).ejbGetRischi_View(lCOD_CST, lCOD_AZL);
    }

    public IAnagrConstatazioni create(String strDES, String strNOM, long lCOD_FAT_RSO) throws CreateException {
        AnagrConstatazioniBean bean = new AnagrConstatazioniBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES, strNOM, lCOD_FAT_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrConstatazioniBean bean = new AnagrConstatazioniBean();
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

    public IAnagrConstatazioni findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrConstatazioniBean bean = new AnagrConstatazioniBean();
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

    public Long ejbCreate(String strDES, String strNOM, long lCOD_FAT_RSO) {
        this.strNOM = strNOM;
        this.strDES = strDES;
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;
        this.lCOD_CST = NEW_ID();

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_cst_tab (cod_cst,des,nom,COD_FAT_RSO) VALUES(?,?,?,?)");

            ps.setLong(1, lCOD_CST);
            ps.setString(2, strDES);
            ps.setString(3, strNOM);
            ps.setLong(4, lCOD_FAT_RSO);

            ps.executeUpdate();
            return new Long(lCOD_CST);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES) {
    }

    public long getlCOD_CST() {
        return lCOD_CST;
    }

    public void setlCOD_CST(long newlCOD_PRO) {
        if (lCOD_CST == newlCOD_PRO) {
            return;
        }
        lCOD_CST = newlCOD_PRO;
        setModified();
    }

    public String getstrDES() {
        return strDES;
    }

    public String getstrNOM() {
        return strNOM;
    }

    public void setstrDES(String newstrDES) {
        if (strDES != null) {
            if (strDES.equals(newstrDES)) {
                return;
            }
        }
        strDES = newstrDES;
        setModified();
    }

    public void setstrNOM(String newstrNOM) {
        if (strNOM != null) {
            if (strNOM.equals(newstrNOM)) {
                return;
            }
        }
        strNOM = newstrNOM;
        setModified();
    }

    public long getCOD_FAT_RSO() {
        return lCOD_FAT_RSO;
    }

    public void setCOD_FAT_RSO(long lCOD_FAT_RSO) {
        if (this.lCOD_FAT_RSO == lCOD_FAT_RSO) {
            return;
        }
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;
        setModified();
    }

//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cst FROM ana_cst_tab ");
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

    public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cst_rso_tab(cod_cst,cod_rso,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lCOD_CST);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetRischi_View(long lCOD_CST, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT rso.cod_rso, rso.nom_rso, fat.nom_fat_rso FROM ana_rso_can_tab rso, cst_rso_tab cstrso, ana_fat_rso_can_tab fat WHERE rso.cod_rso = cstrso.cod_rso AND cstrso.cod_azl = rso.cod_azl AND cstrso.cod_azl = ? AND cstrso.cod_cst = ? AND rso.cod_fat_rso = fat.cod_fat_rso ORDER BY nom_rso");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_CST);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischi_View obj = new Rischi_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
                obj.NOM_FAT_RSO = rs.getString(3);

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

//-----------------------------------------------------------
    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.lCOD_CST = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_CST = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_cst_tab  WHERE cod_cst=? ");
            ps.setLong(1, lCOD_CST);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_CST = rs.getLong("COD_CST");
                this.strDES = rs.getString("DES");
                this.strNOM = rs.getString("NOM");
                this.lCOD_FAT_RSO = rs.getLong("COD_FAT_RSO");
//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_CST + " non è trovato");
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
                    + "ana_cst_tab "
                    + "WHERE "
                    + "cod_cst = ? ");
            ps.setLong(1, lCOD_CST);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_CST + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_cst_tab  SET des=?, nom=?, cod_fat_rso=? WHERE cod_cst=?");
            ps.setString(1, strDES);
            ps.setString(2, strNOM);
            ps.setLong(3, lCOD_FAT_RSO);
            ps.setLong(4, lCOD_CST);

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
            String strDES, String strNOM,
            Long lCOD_FAT_RSO) {
        return (new AnagrConstatazioniBean()).ejbFindEx(
                strDES, strNOM, lCOD_FAT_RSO);
    }

    public Collection ejbFindEx(
            String strDES, String strNOM, Long lCOD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            String query = 
                    "SELECT "
                        + "cst.cod_cst, "
                        + "cst.des, "
                        + "cst.nom, "
                        + "cst.cod_fat_rso, "
                        + "fat_rso.nom_fat_rso "
                    + "FROM "
                        + "ana_cst_tab cst, "
                        + "ana_fat_rso_can_tab fat_rso "
                    + "where "
                        + "cst.cod_fat_rso = fat_rso.cod_fat_rso";

            if ((strDES != null) && (!strDES.trim().equals(""))) {
                query += " AND UPPER(cst.des) LIKE ?";
            }
            if ((strNOM != null) && (!strNOM.trim().equals(""))) {
                query += " AND UPPER(cst.nom) LIKE ?";
            }
            if (lCOD_FAT_RSO != null) {
                query += " AND cst.COD_FAT_RSO=?";
            }
            query += " ORDER BY UPPER(fat_rso.nom_fat_rso), UPPER(cst.nom)";

            PreparedStatement ps = bmp.prepareStatement(query);
            int i = 1;

            if ((strDES != null) && (!strDES.trim().equals(""))) {
                ps.setString(i++, strDES.toUpperCase() + "%");
            }

            if ((strNOM != null) && (!strNOM.trim().equals(""))) {
                ps.setString(i++, strNOM.toUpperCase() + "%");
            }

            if (lCOD_FAT_RSO != null) {
                ps.setLong(i++, lCOD_FAT_RSO.longValue());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrConstatazioni_All_View obj = new AnagrConstatazioni_All_View();
                obj.COD_CST = rs.getLong(1);
                obj.DES = rs.getString(2);
                obj.NOM = rs.getString(3);
                obj.COD_FAT_RSO = rs.getLong(4);
                obj.NOM_FAT_RSO = rs.getString(5);
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
        return (new AnagrConstatazioniBean()).ejbGetANA_PRO_TAB_DES_View();
    }

    public void deleteRischio(long lCOD_RSO, long lCOD_CST) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cst_rso_tab WHERE cod_rso=? AND cod_cst=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_CST);
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
                AnagrConstatazioni_All_View obj = new AnagrConstatazioni_All_View();
                obj.COD_CST = rs.getLong(1);
                obj.DES = rs.getString(2);
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
}
