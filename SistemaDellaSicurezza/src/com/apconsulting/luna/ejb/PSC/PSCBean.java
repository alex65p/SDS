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
package com.apconsulting.luna.ejb.PSC;

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
public class PSCBean extends BMPEntityBean implements IPSCHome, IPSC {

    long lCOD_PSC;
    long lCOD_PRO;
    long lCOD_AZL;
    String strTIT;
    String strOGG;
    String strCOD;
    java.sql.Date dtDAT_PRM_REG;
    String strCOD_ELA;
    private static PSCBean ys = null;

    private PSCBean() {
    }

    public static PSCBean getInstance() {
        if (ys == null) {
            ys = new PSCBean();
        }
        return ys;
    }

    public IPSC create(long lCOD_PRO, String strTIT, String strOGG, String strCOD, java.sql.Date dtDAT_PRM_REG, String strCOD_ELA, long lCOD_AZL) throws CreateException {
        PSCBean bean = new PSCBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_PRO, strTIT, strOGG, strCOD, dtDAT_PRM_REG, strCOD_ELA, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_PRO, strTIT, strOGG, strCOD, dtDAT_PRM_REG, strCOD_ELA, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        PSCBean bean = new PSCBean();
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

    public IPSC findByPrimaryKey(Long primaryKey) throws FinderException {
        PSCBean bean = new PSCBean();
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

    public Long ejbCreate(long lCOD_PRO, String strTIT, String strOGG, String strCOD, java.sql.Date dtDAT_PRM_REG, String strCOD_ELA, long lCOD_AZL) {
        this.lCOD_PRO = lCOD_PRO;
        this.strTIT = strTIT;
        this.strOGG = strOGG;
        this.strCOD = strCOD;
        this.dtDAT_PRM_REG = dtDAT_PRM_REG;
        this.strCOD_ELA = strCOD_ELA;
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_PSC = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_psc_tab (COD_PSC,COD_PRO,COD_AZL,TIT,OGG,COD,DAT_PRM_REG,COD_ELA) VALUES(?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_PSC);
            ps.setLong(2, lCOD_PRO);
            ps.setLong(3, lCOD_AZL);
            ps.setString(4, strTIT);
            ps.setString(5, strOGG);
            ps.setString(6, strCOD);
            ps.setDate(7, dtDAT_PRM_REG);
            ps.setString(8, strCOD_ELA);

            ps.executeUpdate();
            return new Long(lCOD_PSC);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_PRO, String strTIT, String strOGG, String strCOD, java.sql.Date dDAT_CRE_CTL_SAN, String strCOD_ELA, long lCOD_AZL) {
    }

    public void setdtDAT_PRM_REG(java.sql.Date newdtDAT_PRM_REG) {
        if (dtDAT_PRM_REG != null) {
            if (dtDAT_PRM_REG.equals(newdtDAT_PRM_REG)) {
                return;
            }
        }
        dtDAT_PRM_REG = newdtDAT_PRM_REG;
        setModified();
    }

    public java.sql.Date getdtDAT_PRM_REG() {
        return dtDAT_PRM_REG;
    }

    public long getlCOD_AZL() {
        return lCOD_AZL;
    }

    public void setlCOD_AZL(long newlCOD_AZL) {
        if (lCOD_AZL == newlCOD_AZL) {
            return;
        }
        lCOD_AZL = newlCOD_AZL;
        setModified();
    }

    public long getlCOD_PRO() {
        return lCOD_PRO;
    }

    public void setlCOD_PRO(long newlCOD_PRO) {
        if (lCOD_PRO == newlCOD_PRO) {
            return;
        }
        lCOD_PRO = newlCOD_PRO;
        setModified();
    }

    public long getlCOD_PSC() {
        return lCOD_PSC;
    }

    public void setlCOD_PSC(long newlCOD_PSC) {
        if (lCOD_PSC == newlCOD_PSC) {
            return;
        }
        lCOD_PSC = newlCOD_PSC;
        setModified();
    }

    public String getstrCOD() {
        return strCOD;
    }

    public void setstrCOD(String newstrCOD) {
        if (strCOD != null) {
            if (strCOD.equals(newstrCOD)) {
                return;
            }
        }
        strCOD = newstrCOD;
        setModified();
    }

    public String getstrOGG() {
        return strOGG;
    }

    public void setstrOGG(String newstrOGG) {
        if (strOGG != null) {
            if (strOGG.equals(newstrOGG)) {
                return;
            }
        }
        strOGG = newstrOGG;
        setModified();
    }

    public String getstrTIT() {
        return strTIT;
    }

    public void setstrTIT(String newstrTIT) {
        if (strTIT != null) {
            if (strTIT.equals(newstrTIT)) {
                return;
            }
        }
        strTIT = newstrTIT;
        setModified();
    }

    public String getCOD_ELA() {
        return strCOD_ELA;
    }

    public void setCOD_ELA(String newCOD_ELA) {
        if (strCOD_ELA != null) {
            if (strCOD_ELA.equals(newCOD_ELA)) {
                return;
            }
        }
        strCOD_ELA = newCOD_ELA;
        setModified();
    }

//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_psc FROM ana_psc_tab");
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
        this.lCOD_PSC = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_PSC = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_psc_tab WHERE cod_psc=? ");
            ps.setLong(1, lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_PRO = rs.getLong("COD_PRO");
                this.strTIT = rs.getString("TIT");
                this.strOGG = rs.getString("OGG");
                this.strCOD = rs.getString("COD");
                this.dtDAT_PRM_REG = rs.getDate("DAT_PRM_REG");
                this.strCOD_ELA = rs.getString("COD_ELA");
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_PSC + " non è trovato");
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
                    + "ana_psc_tab "
                    + "WHERE "
                    + "cod_psc = ? ");
            ps.setLong(1, lCOD_PSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_PSC + " non è trovata");
            }
            ps.close();
            //    deleteFile();
            //    deleteFileLink();
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
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE "
                    + "ana_psc_tab "
                    + "SET "
                    + "cod_pro=?, "
                    + "tit=?, "
                    + "ogg=?, "
                    + "cod=?, "
                    + "cod_ela=? "
                    + "WHERE "
                    + "cod_psc=?");
            ps.setLong(1, lCOD_PRO);
            ps.setString(2, strTIT);
            ps.setString(3, strOGG);
            ps.setString(4, strCOD);
            ps.setString(5, strCOD_ELA);
            ps.setLong(6, lCOD_PSC);
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
            long lCOD_AZL,
            Long lCOD_PRO,
            String strCOD,
            String strTIT,
            String strOGG,
            String strCOD_ELA,
            int iOrderParameter) {
        return (new PSCBean()).ejbFindEx(
                lCOD_AZL,
                lCOD_PRO,
                strCOD,
                strTIT,
                strOGG,
                strCOD_ELA,
                iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            Long lCOD_PRO,
            String strCOD,
            String strTIT,
            String strOGG,
            String strCOD_ELA,
            int iOrderParameter) {
        BMPConnection bmp = getConnection();
        try {
            String query =
                    "SELECT "
                    + "a.cod_psc, a.cod_pro, a.cod, b.des, a.tit, a.ogg, a.cod_ela "
                    + "FROM "
                    + "ana_psc_tab a,ana_pro_tab b "
                    + "where "
                    + "a.cod_pro = b.cod_pro "
                    + "and a.cod_azl = b.cod_azl "
                    + "and a.cod_azl = ? ";

            if ((strCOD != null) && (!strCOD.trim().equals(""))) {
                query += " AND  UPPER(a.cod)  LIKE ?";
            }
            if (lCOD_PRO != 0) {
                query += " AND  b.cod_pro = ?";
            }
            if ((strTIT != null) && (!strTIT.trim().equals(""))) {
                query += " AND  UPPER(a.tit) LIKE ?";
            }
            if ((strOGG != null) && (!strOGG.trim().equals(""))) {
                query += " AND  UPPER(a.ogg) LIKE ?";
            }
            if ((strCOD_ELA != null) && (!strCOD_ELA.trim().equals(""))) {
                query += " AND  UPPER(a.cod_ela) LIKE ?";
            }

            int i = 1;
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(i++, lCOD_AZL);

            if (lCOD_PRO != 0) {
                ps.setLong(i++, lCOD_PRO.longValue());
            }

            if ((strCOD != null) && (!strCOD.equals(""))) {
                ps.setString(i++, strCOD.toUpperCase() + "%");
            }
            if ((strTIT != null) && (!strTIT.equals(""))) {
                ps.setString(i++, strTIT.toUpperCase() + "%");
            }
            if ((strOGG != null) && (!strOGG.equals(""))) {
                ps.setString(i++, strOGG.toUpperCase() + "%");
            }
            if ((strCOD_ELA != null) && (!strCOD_ELA.equals(""))) {
                ps.setString(i++, strCOD_ELA.toUpperCase() + "%");
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                PSC_All_View obj = new PSC_All_View();
                obj.COD_PSC = rs.getLong(1);
                obj.COD_PRO = rs.getLong(2);
                obj.COD = rs.getString(3);
                obj.DES = rs.getString(4);
                obj.TIT = rs.getString(5);
                obj.OGG = rs.getString(6);
                obj.COD_ELA = rs.getString(7);
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

    public Collection getSezioneGeneraleView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sez_gen, cod, ogg, rev, dat_emi,dat_pro, doc_col  FROM psc_sez_gen_tab WHERE cod_psc = ? order by rev");
            ps.setLong(1, this.lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Sezione_Generale_All_View obj = new Sezione_Generale_All_View();
                obj.COD_SEZ_GEN = rs.getLong(1);
                obj.COD = rs.getString(2);
                obj.OGG = rs.getString(3);
                obj.REV = rs.getString(4);
                obj.DAT_EMI = rs.getDate(5);
                obj.DAT_PRO = rs.getDate(6);
                obj.DOC_COL = rs.getString(7);
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

    public Collection getSchedediSicurezzaView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_sic, cod, ogg, rev, dat_emi,dat_pro, doc_col  FROM psc_sch_sic_tab WHERE cod_psc = ? order by rev");
            ps.setLong(1, this.lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeSicurezza_All_View obj = new SchedeSicurezza_All_View();
                obj.COD_SCH_SIC = rs.getLong(1);
                obj.COD = rs.getString(2);
                obj.OGG = rs.getString(3);
                obj.REV = rs.getString(4);
                obj.DAT_EMI = rs.getDate(5);
                obj.DAT_PRO = rs.getDate(6);
                obj.DOC_COL = rs.getString(7);
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

    public Collection getFascicoloView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fsc_ope, cod, ogg, rev, dat_emi,dat_pro, doc_col  FROM psc_fsc_ope_tab WHERE cod_psc = ? order by rev");
            ps.setLong(1, this.lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Fascicolo_All_View obj = new Fascicolo_All_View();
                obj.COD_FAS = rs.getLong(1);
                obj.COD = rs.getString(2);
                obj.OGG = rs.getString(3);
                obj.REV = rs.getString(4);
                obj.DAT_EMI = rs.getDate(5);
                obj.DAT_PRO = rs.getDate(6);
                obj.DOC_COL = rs.getString(7);
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

    public Collection getSezioneParticolareView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sez_par, cod,tit, ogg, rev, dat_emi,dat_pro, doc_col  FROM psc_sez_par_tab WHERE cod_psc = ? order by cod,rev");
            ps.setLong(1, this.lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneParticolare_All_View obj = new SezioneParticolare_All_View();
                obj.COD_SEZ_PAR = rs.getLong(1);
                obj.COD = rs.getString(2);
                obj.TIT = rs.getString(3);
                obj.OGG = rs.getString(4);
                obj.REV = rs.getString(5);
                obj.DAT_EMI = rs.getDate(6);
                obj.DAT_PRO = rs.getDate(7);
                obj.DOC_COL = rs.getString(8);
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
    
    public boolean areAssociations() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "count (cod_psc) "
                    + "from ( "
                        + "select cod_psc from psc_sez_gen_tab where cod_psc = ? "
                        + "union all "
                        + "select cod_psc from psc_sch_sic_tab where cod_psc = ? "
                        + "union all "
                        + "select cod_psc from psc_sez_par_tab where cod_psc = ? "
                        + "union all "
                        + "select cod_psc from psc_fsc_ope_tab where cod_psc = ? "
                    + ") a");                    
            ps.setLong(1, this.lCOD_PSC);
            ps.setLong(2, this.lCOD_PSC);
            ps.setLong(3, this.lCOD_PSC);
            ps.setLong(4, this.lCOD_PSC);
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getLong(1) > 0;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
}
