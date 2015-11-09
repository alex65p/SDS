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
package com.apconsulting.luna.ejb.RapportiniSegnalazione;

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
public class RapportiniSegnalazioneBean extends BMPEntityBean implements IRapportiniSegnalazione, IRapportiniSegnalazioneHome {
    //<member-varibles description="Member Variables">

    long lCOD_SGZ;
    String strDES_SGZ;
    java.sql.Date dtDAT_SGZ;
    long lNUM_SGZ;
    long lVER_SGZ;
    String strTIT_SGZ;
    String strSTA_SGZ;
    String strURG_SGZ;
    String strDES_ATI_SGZ;
    String strSTA_FIE_SGZ;
    java.sql.Date dtDAT_FIE;
    String strNOM_RIL_SGZ;
    long lCOD_IMM;
    long lCOD_LUO_FSC;
    long lCOD_DPD;
    long lCOD_AZL;
    //</member-varibles>
    //<IRapportiniSegnalazioneHome-implementation>
    public static final String BEAN_NAME = "RapportiniSegnalazioneBean";
    private static RapportiniSegnalazioneBean ys = null;

    private RapportiniSegnalazioneBean() {
        //
    }

    public static RapportiniSegnalazioneBean getInstance() {
        if (ys == null) {
            ys = new RapportiniSegnalazioneBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        RapportiniSegnalazioneBean bean = new RapportiniSegnalazioneBean();
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

    public IRapportiniSegnalazione create(String strDES_SGZ, java.sql.Date dtDAT_SGZ, long lNUM_SGZ, long lVER_SGZ, String strTIT_SGZ, String strSTA_SGZ, String strURG_SGZ, String strNOM_RIL_SGZ, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
        RapportiniSegnalazioneBean bean = new RapportiniSegnalazioneBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_SGZ, dtDAT_SGZ, lNUM_SGZ, lVER_SGZ, strTIT_SGZ, strSTA_SGZ, strURG_SGZ, strNOM_RIL_SGZ, lCOD_DPD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_SGZ, dtDAT_SGZ, lNUM_SGZ, lVER_SGZ, strTIT_SGZ, strSTA_SGZ, strURG_SGZ, strNOM_RIL_SGZ, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IRapportiniSegnalazione findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        RapportiniSegnalazioneBean bean = new RapportiniSegnalazioneBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //  <VIEWS>

    public Collection getRapportiniSegnalazione_List_View() {
        return (new RapportiniSegnalazioneBean()).ejbGetRapportiniSegnalazione_List_View();
    }
    //----------add by Podmasteriev

    public Collection getRapportiniSegnalazione_List_ID_View(long lCOD_SGZ) {
        return (new RapportiniSegnalazioneBean()).ejbGetRapportiniSegnalazione_List_ID_View(lCOD_SGZ);
    }
    //------------------
    
    public Collection getRischi_View(long lCOD_SGZ, long lCOD_AZL) {
        return (new RapportiniSegnalazioneBean()).ejbGetRischi_View(lCOD_SGZ, lCOD_AZL);
    }

    public Collection getMax_Numero_View() {
        return (new RapportiniSegnalazioneBean()).ejbGetMax_Numero_View();
    }

    public Collection getRapportini_View(
            long lCOD_AZL, long lCOD_DPD, String strTIT_SGZ, String strNOM_RIL_SGZ,
            java.sql.Date dDAT_SGZ_DAL, java.sql.Date dDAT_SGZ_AL,
            java.sql.Date dDAT_SCA_DAL, java.sql.Date dDAT_SCA_AL,
            String strRG_GROUP, String strSTA_INT, String strVAR_SGZ, String strVAR_SCA) {
        return (new RapportiniSegnalazioneBean()).ejbGetRapportini_View(
                lCOD_AZL, lCOD_DPD, strTIT_SGZ, strNOM_RIL_SGZ, dDAT_SGZ_DAL, dDAT_SGZ_AL,
                dDAT_SCA_DAL, dDAT_SCA_AL, strRG_GROUP, strSTA_INT, strVAR_SGZ, strVAR_SCA);
    }

    public Collection findEx(
            Long lCOD_DPD,
            String strDES_SGZ,
            java.sql.Date dtDAT_SGZ,
            Long lNUM_SGZ,
            Long lVER_SGZ,
            String strTIT_SGZ,
            String strSTA_SGZ,
            String strURG_SGZ,
            String strDES_ATI_SGZ,
            String strSTA_FIE_SGZ,
            java.sql.Date dtDAT_FIE,
            String strNOM_RIL_SGZ,
            long lCOD_IMM,
            long lCOD_LUO_FSC,
            long lCOD_AZL,
            int iOrderParameter) {
        return (new RapportiniSegnalazioneBean()).ejbFindEx(
                lCOD_DPD, strDES_SGZ, dtDAT_SGZ, lNUM_SGZ, lVER_SGZ, 
                strTIT_SGZ, strSTA_SGZ, strURG_SGZ, strDES_ATI_SGZ, 
                strSTA_FIE_SGZ, dtDAT_FIE, strNOM_RIL_SGZ, lCOD_IMM, 
                lCOD_LUO_FSC, lCOD_AZL, iOrderParameter);
    }
    //</VIEWS>

    //
    public Long ejbCreate(String strDES_SGZ, java.sql.Date dtDAT_SGZ, long lNUM_SGZ, long lVER_SGZ, String strTIT_SGZ, String strSTA_SGZ, String strURG_SGZ, String strNOM_RIL_SGZ, long lCOD_DPD, long lCOD_AZL) {
        this.lCOD_SGZ = NEW_ID();
        this.strDES_SGZ = strDES_SGZ;
        this.dtDAT_SGZ = dtDAT_SGZ;
        this.lNUM_SGZ = lNUM_SGZ;
        this.lVER_SGZ = lVER_SGZ;
        this.strTIT_SGZ = strTIT_SGZ;
        this.strSTA_SGZ = strSTA_SGZ;
        this.strURG_SGZ = strURG_SGZ;
        this.strNOM_RIL_SGZ = strNOM_RIL_SGZ;
        this.lCOD_DPD = lCOD_DPD;
        this.lCOD_AZL = lCOD_AZL;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_sgz_tab (cod_sgz,des_sgz,dat_sgz,num_sgz,ver_sgz,tit_sgz,sta_sgz,urg_sgz,nom_ril_sgz,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_SGZ);
            ps.setString(2, strDES_SGZ);
            ps.setDate(3, dtDAT_SGZ);
            ps.setLong(4, lNUM_SGZ);
            ps.setLong(5, lVER_SGZ);
            ps.setString(6, strTIT_SGZ);
            ps.setString(7, strSTA_SGZ);
            ps.setString(8, strURG_SGZ);
            ps.setString(9, strNOM_RIL_SGZ);
            ps.setLong(10, lCOD_DPD);
            ps.setLong(11, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_SGZ);
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strDES_SGZ, java.sql.Date dtDAT_SGZ, long lNUM_SGZ, long lVER_SGZ, String strTIT_SGZ, String strSTA_SGZ, String strURG_SGZ, String strNOM_RIL_SGZ, long lCOD_DPD, long lCOD_AZL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sgz FROM ana_sgz_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_SGZ = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_SGZ = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_sgz, "
                        + "des_sgz, "
                        + "dat_sgz, "
                        + "num_sgz, "
                        + "ver_sgz, "
                        + "tit_sgz, "
                        + "sta_sgz, "
                        + "urg_sgz, "
                        + "des_ati_sgz, "
                        + "sta_fie_sgz, "
                        + "dat_fie, "
                        + "nom_ril_sgz, "
                        + "cod_imm, "
                        + "cod_luo_fsc, "
                        + "cod_dpd, "
                        + "cod_azl "
                    + "FROM "
                        + "ana_sgz_tab "
                    + "WHERE "
                        + "cod_sgz=?");
            ps.setLong(1, lCOD_SGZ);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_SGZ = rs.getLong(1);
                strDES_SGZ = rs.getString(2);
                dtDAT_SGZ = rs.getDate(3);
                lNUM_SGZ = rs.getLong(4);
                lVER_SGZ = rs.getLong(5);
                strTIT_SGZ = rs.getString(6);
                strSTA_SGZ = rs.getString(7);
                strURG_SGZ = rs.getString(8);
                strDES_ATI_SGZ = rs.getString(9);
                strSTA_FIE_SGZ = rs.getString(10);
                dtDAT_FIE = rs.getDate(11);
                strNOM_RIL_SGZ = rs.getString(12);
                lCOD_IMM = rs.getLong(13);
                lCOD_LUO_FSC = rs.getLong(14);
                lCOD_DPD = rs.getLong(15);
                lCOD_AZL = rs.getLong(16);
            } else {
                throw new NoSuchEntityException("RapportiniSegnalazione con ID=" + lCOD_SGZ + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sgz_tab WHERE cod_sgz=?");

            ps.setLong(1, lCOD_SGZ);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("RapportiniSegnalazione con ID=" + lCOD_SGZ + " non &egrave trovata");
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
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE "
                        + "ana_sgz_tab "
                    + "SET "
                        + "cod_sgz=?, "
                        + "des_sgz=?, "
                        + "dat_sgz=?, "
                        + "num_sgz=?, "
                        + "ver_sgz=?, "
                        + "tit_sgz=?, "
                        + "sta_sgz=?, "
                        + "urg_sgz=?, "
                        + "des_ati_sgz=?, "
                        + "sta_fie_sgz=?, "
                        + "dat_fie=?, "
                        + "nom_ril_sgz=?, "
                        + "cod_imm=?, "
                        + "cod_luo_fsc=?, "
                        + "cod_dpd=?, "
                        + "cod_azl=? "
                    + "WHERE "
                        + "cod_sgz=?");
            ps.setLong(1, lCOD_SGZ);
            ps.setString(2, strDES_SGZ);
            ps.setDate(3, dtDAT_SGZ);
            ps.setLong(4, lNUM_SGZ);
            ps.setLong(5, lVER_SGZ);
            ps.setString(6, strTIT_SGZ);
            ps.setString(7, strSTA_SGZ);
            ps.setString(8, strURG_SGZ);
            ps.setString(9, strDES_ATI_SGZ);
            ps.setString(10, strSTA_FIE_SGZ);
            ps.setDate(11, dtDAT_FIE);
            ps.setString(12, strNOM_RIL_SGZ);
            if (lCOD_IMM != 0){
                ps.setLong(13, lCOD_IMM);
            } else {
                ps.setNull(13, java.sql.Types.BIGINT);
            }
            if (lCOD_LUO_FSC != 0){
                ps.setLong(14, lCOD_LUO_FSC);
            } else {
                ps.setNull(14, java.sql.Types.BIGINT);
            }
            ps.setLong(15, lCOD_DPD);
            ps.setLong(16, lCOD_AZL);
            ps.setLong(17, lCOD_SGZ);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("RapportiniSegnalazione con ID=" + lCOD_SGZ + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<setter-getters>
    public long getCOD_SGZ() {
        return lCOD_SGZ;
    }

    public String getDES_SGZ() {
        if (strDES_SGZ == null) {
            return "";
        }
        return strDES_SGZ;
    }

    public void setDES_SGZ(String strDES_SGZ) {
        if ((this.strDES_SGZ != null) && (this.strDES_SGZ.equals(strDES_SGZ))) {
            return;
        }
        this.strDES_SGZ = strDES_SGZ;
        setModified();
    }

    public java.sql.Date getDAT_SGZ() {
        return dtDAT_SGZ;
    }

    public void setDAT_SGZ(java.sql.Date dtDAT_SGZ) {
        if (this.dtDAT_SGZ == dtDAT_SGZ) {
            return;
        }
        this.dtDAT_SGZ = dtDAT_SGZ;
        setModified();
    }

    public long getNUM_SGZ() {
        return lNUM_SGZ;
    }

    public void setNUM_SGZ(long lNUM_SGZ) {
        if (this.lNUM_SGZ == lNUM_SGZ) {
            return;
        }
        this.lNUM_SGZ = lNUM_SGZ;
        setModified();
    }

    public long getVER_SGZ() {
        return lVER_SGZ;
    }

    public void setVER_SGZ(long lVER_SGZ) {
        if (this.lVER_SGZ == lVER_SGZ) {
            return;
        }
        this.lVER_SGZ = lVER_SGZ;
        setModified();
    }

    public String getTIT_SGZ() {
        if (strTIT_SGZ == null) {
            return "";
        }
        return strTIT_SGZ;
    }

    public void setTIT_SGZ(String strTIT_SGZ) {
        if ((this.strTIT_SGZ != null) && (this.strTIT_SGZ.equals(strTIT_SGZ))) {
            return;
        }
        this.strTIT_SGZ = strTIT_SGZ;
        setModified();
    }

    public String getSTA_SGZ() {
        if (strSTA_SGZ == null) {
            return "";
        }
        return strSTA_SGZ;
    }

    public void setSTA_SGZ(String strSTA_SGZ) {
        if ((this.strSTA_SGZ != null) && (this.strSTA_SGZ.equals(strSTA_SGZ))) {
            return;
        }
        this.strSTA_SGZ = strSTA_SGZ;
        setModified();
    }

    public String getURG_SGZ() {
        if (strURG_SGZ == null) {
            return "";
        }
        return strURG_SGZ;
    }

    public void setURG_SGZ(String strURG_SGZ) {
        if ((this.strURG_SGZ != null) && (this.strURG_SGZ.equals(strURG_SGZ))) {
            return;
        }
        this.strURG_SGZ = strURG_SGZ;
        setModified();
    }

    public String getDES_ATI_SGZ() {
        if (strDES_ATI_SGZ == null) {
            return "";
        }
        return strDES_ATI_SGZ;
    }

    public void setDES_ATI_SGZ(String strDES_ATI_SGZ) {
        if ((this.strDES_ATI_SGZ != null) && (this.strDES_ATI_SGZ.equals(strDES_ATI_SGZ))) {
            return;
        }
        this.strDES_ATI_SGZ = strDES_ATI_SGZ;
        setModified();
    }

    public String getSTA_FIE_SGZ() {
        if (strSTA_FIE_SGZ == null) {
            return "";
        }
        return strSTA_FIE_SGZ;
    }

    public void setSTA_FIE_SGZ(String strSTA_FIE_SGZ) {
        if ((this.strSTA_FIE_SGZ != null) && (this.strSTA_FIE_SGZ.equals(strSTA_FIE_SGZ))) {
            return;
        }
        this.strSTA_FIE_SGZ = strSTA_FIE_SGZ;
        setModified();
    }

    public java.sql.Date getDAT_FIE() {
        return dtDAT_FIE;
    }

    public void setDAT_FIE(java.sql.Date dtDAT_FIE) {
        if (this.dtDAT_FIE == dtDAT_FIE) {
            return;
        }
        this.dtDAT_FIE = dtDAT_FIE;
        setModified();
    }

    public String getNOM_RIL_SGZ() {
        if (strNOM_RIL_SGZ == null) {
            return "";
        }
        return strNOM_RIL_SGZ;
    }

    public void setNOM_RIL_SGZ(String strNOM_RIL_SGZ) {
        if ((this.strNOM_RIL_SGZ != null) && (this.strNOM_RIL_SGZ.equals(strNOM_RIL_SGZ))) {
            return;
        }
        this.strNOM_RIL_SGZ = strNOM_RIL_SGZ;
        setModified();
    }

    public long getCOD_IMM() {
        return lCOD_IMM;
    }

    public void setCOD_IMM(long lCOD_IMM) {
        if (this.lCOD_IMM == lCOD_IMM) {
            return;
        }
        this.lCOD_IMM = lCOD_IMM;
        setModified();
    }

    public long getCOD_LUO_FSC() {
        return lCOD_LUO_FSC;
    }

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC) {
        if (this.lCOD_LUO_FSC == lCOD_LUO_FSC) {
            return;
        }
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
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

    public void setVER_SGZ__TIT_SGZ(long lVER_SGZ, String strTIT_SGZ) {
        if ((this.lVER_SGZ == lVER_SGZ) && this.strTIT_SGZ.equals(strTIT_SGZ)) {
            return;
        }
        this.lVER_SGZ = lVER_SGZ;
        this.strTIT_SGZ = strTIT_SGZ;
        setModified();
    }

    //</setter-getters>
    //<views>
    public Collection ejbGetRapportiniSegnalazione_List_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sgz,tit_sgz,dat_sgz,cog_dpd,nom_dpd FROM ana_sgz_tab,view_ana_dpd_tab WHERE ana_sgz_tab.cod_dpd =view_ana_dpd_tab.cod_dpd ORDER BY tit_sgz");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RapportiniSegnalazione_List_View obj = new RapportiniSegnalazione_List_View();
                obj.COD_SGZ = rs.getLong(1);
                obj.TIT_SGZ = rs.getString(2);
                obj.DAT_SGZ = rs.getDate(3);
                obj.COG_DPD = rs.getString(4);
                obj.NOM_DPD = rs.getString(5);
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

    public Collection ejbFindEx(
            Long lCOD_DPD,
            String strDES_SGZ,
            java.sql.Date dtDAT_SGZ,
            Long lNUM_SGZ,
            Long lVER_SGZ,
            String strTIT_SGZ,
            String strSTA_SGZ,
            String strURG_SGZ,
            String strDES_ATI_SGZ,
            String strSTA_FIE_SGZ,
            java.sql.Date dtDAT_FIE,
            String strNOM_RIL_SGZ,
            long lCOD_IMM,
            long lCOD_LUO_FSC,
            long lCOD_AZL,
            int iOrderParameter) {
        String strSQL = "SELECT cod_sgz,tit_sgz,dat_sgz,ana_sgz_tab.cod_dpd,nom_dpd FROM ana_sgz_tab,view_ana_dpd_tab WHERE ana_sgz_tab.cod_dpd =view_ana_dpd_tab.cod_dpd and ana_sgz_tab.cod_azl=?";
        if (lCOD_DPD != null) {
            strSQL += " AND ana_sgz_tab.cod_dpd=?";
        }
        if (strDES_SGZ != null) {
            strSQL += " AND UPPER(des_sgz) LIKE ?";
        }
        if (dtDAT_SGZ != null) {
            strSQL += " AND dat_sgz=?";
        }
        if (lNUM_SGZ != null) {
            strSQL += " AND num_sgz = ?";
        }
        if (lVER_SGZ != null) {
            strSQL += " AND ver_sgz = ?";
        }
        if (strTIT_SGZ != null) {
            strSQL += " AND UPPER(tit_sgz) LIKE ?";
        }
        if (strSTA_SGZ != null) {
            strSQL += " AND UPPER(sta_sgz) LIKE ?";
        }
        if (strURG_SGZ != null) {
            strSQL += " AND UPPER(urg_sgz) LIKE ?";
        }
        if (strDES_ATI_SGZ != null) {
            strSQL += " AND UPPER(des_ati_sgz) LIKE ?";
        }
        if (strSTA_FIE_SGZ != null) {
            strSQL += " AND UPPER(sta_fie_sgz) LIKE ?";
        }
        if (dtDAT_FIE != null) {
            strSQL += " AND dat_fie=?";
        }
        if (strNOM_RIL_SGZ != null) {
            strSQL += " AND UPPER(nom_ril_sgz) LIKE ?";
        }
        if (lCOD_IMM != 0) {
            strSQL += " AND ana_sgz_tab.cod_imm=?";
        }
        if (lCOD_LUO_FSC != 0) {
            strSQL += " AND ana_sgz_tab.cod_luo_fsc=?";
        }
        strSQL += " ORDER BY UPPER(tit_sgz)";
        BMPConnection bmp = getConnection();
        int i = 1;
        try {
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(i++, lCOD_AZL);
            if (lCOD_DPD != null) {
                ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strDES_SGZ != null) {
                ps.setString(i++, strDES_SGZ.toUpperCase());
            }
            if (dtDAT_SGZ != null) {
                ps.setDate(i++, dtDAT_SGZ);
            }
            if (lNUM_SGZ != null) {
                ps.setLong(i++, lNUM_SGZ.longValue());
            }
            if (lVER_SGZ != null) {
                ps.setLong(i++, lVER_SGZ.longValue());
            }
            if (strTIT_SGZ != null) {
                ps.setString(i++, strTIT_SGZ.toUpperCase());
            }
            if (strSTA_SGZ != null) {
                ps.setString(i++, strSTA_SGZ.toUpperCase());
            }
            if (strURG_SGZ != null) {
                ps.setString(i++, strURG_SGZ.toUpperCase());
            }
            if (strDES_ATI_SGZ != null) {
                ps.setString(i++, strDES_ATI_SGZ.toUpperCase());
            }
            if (strSTA_FIE_SGZ != null) {
                ps.setString(i++, strSTA_FIE_SGZ.toUpperCase());
            }
            if (dtDAT_FIE != null) {
                ps.setDate(i++, dtDAT_FIE);
            }
            if (strNOM_RIL_SGZ != null) {
                ps.setString(i++, strNOM_RIL_SGZ.toUpperCase());
            }
            if (lCOD_IMM != 0) {
                ps.setLong(i++, lCOD_IMM);
            }
            if (lCOD_LUO_FSC != 0) {
                ps.setLong(i++, lCOD_LUO_FSC);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RapportiniSegnalazione_List_View obj = new RapportiniSegnalazione_List_View();
                obj.COD_SGZ = rs.getLong(1);
                obj.TIT_SGZ = rs.getString(2);
                obj.DAT_SGZ = rs.getDate(3);
                obj.COG_DPD = rs.getString(4);
                obj.NOM_DPD = rs.getString(5);
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

    //added by Podmasteriev-----
    public Collection ejbGetRapportiniSegnalazione_List_ID_View(long lCOD_SGZ) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ati_sgz,des_ati_sgz,dat_sca FROM ana_ati_sgz_tab WHERE cod_sgz=?");
            ps.setLong(1, lCOD_SGZ);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RapportiniSegnalazione_List_ID_View obj = new RapportiniSegnalazione_List_ID_View();
                obj.COD_ATI_SGZ = rs.getLong(1);
                obj.DES_ATI_SGZ = rs.getString(2);
                obj.DAT_SCA = rs.getDate(3);
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
    //--------------------------

    public Collection ejbGetRischi_View(long lCOD_SGZ, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "fat_rso.nom_fat_rso "
                    + "FROM "
                        + "sgz_rso_tab sgz_rso, "
                        + "ana_rso_tab rso, "
                        + "ana_fat_rso_tab fat_rso "
                    + "WHERE "
                        + "sgz_rso.cod_sgz = ? "
                        + "AND sgz_rso.cod_rso = rso.cod_rso "
                        + "AND sgz_rso.cod_azl = rso.cod_azl "
                        + "AND rso.cod_fat_rso = fat_rso.cod_fat_rso "
                        + "AND sgz_rso.cod_azl =? "
                    + "order by "
                        + "fat_rso.nom_fat_rso, "
                        + "rso.nom_rso");
            ps.setLong(1, lCOD_SGZ);
            ps.setLong(2, lCOD_AZL);
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
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    
    public Collection ejbGetMax_Numero_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT max(num_sgz)+1 FROM ana_sgz_tab");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Max_Numero_View obj = new Max_Numero_View();
                obj.NUM_SGZ = rs.getLong(1);
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
    
    public void addRischio(long COD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO sgz_rso_tab "
                        + "(cod_sgz,cod_rso,cod_azl) "
                    + "VALUES "
                        + "(?,?,?)");
            ps.setLong(1, this.getCOD_SGZ());
            ps.setLong(2, COD_RSO);
            ps.setLong(3, this.getCOD_AZL());
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public void removeRischio(long COD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "sgz_rso_tab "
                    + "WHERE "
                        + "cod_sgz=? "
                        + "AND cod_rso=? "
                        + "AND cod_azl=?");
            ps.setLong(1, this.getCOD_SGZ());
            ps.setLong(2, COD_RSO);
            ps.setLong(3, this.getCOD_AZL());
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Impossibile eliminare il rischio con ID " + COD_RSO);
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
//---------Pogrebnoy Yura funka

    public Collection ejbGetRapportini_View(
            long lCOD_AZL, long lCOD_DPD, String strTIT_SGZ, String strNOM_RIL_SGZ,
            java.sql.Date dDAT_SGZ_DAL, java.sql.Date dDAT_SGZ_AL,
            java.sql.Date dDAT_SCA_DAL, java.sql.Date dDAT_SCA_AL,
            String strRG_GROUP, String strSTA_INT, String strVAR_SGZ, String strVAR_SCA) {
        int index = 2;       //eto nesprosta
        int ifDAT_SGZ_DAL = 0;
        int ifDAT_SGZ_AL = 0;
        int ifDAT_SCA_DAL = 0;
        int ifDAT_SCA_AL = 0;
        int ifCOD_DPD = 0;
        int ifTIT_SGZ = 0;
        int ifNOM_RIL_SGZ = 0;

        String vWhere = "";
        String vGroup = "";

        if ((dDAT_SGZ_DAL != null) && (dDAT_SGZ_AL != null)) {
            vWhere += " AND a.dat_sgz BETWEEN ? AND ?";
            ifDAT_SGZ_DAL = index++;
            ifDAT_SGZ_AL = index++;
        }
        if ((dDAT_SGZ_DAL != null) && (dDAT_SGZ_AL == null)) {
            vWhere += " AND a.dat_sgz >= ? ";
            ifDAT_SGZ_DAL = index++;
        }
        if ((dDAT_SGZ_DAL == null) && (dDAT_SGZ_AL != null)) {
            vWhere += " AND a.dat_sgz <= ?";
            ifDAT_SGZ_AL = index++;
        }
        if ("G".equals(strSTA_INT)) {
            if ((dDAT_SCA_DAL != null) && (dDAT_SCA_AL != null)) {
                vWhere += " AND b.dat_sca BETWEEN ? AND ?";
                ifDAT_SCA_DAL = index++;
                ifDAT_SCA_AL = index++;
            }
            if ((dDAT_SCA_DAL != null) && (dDAT_SCA_AL == null)) {
                vWhere += " AND b.dat_sca >= ? ";
                ifDAT_SCA_DAL = index++;
            }
            if ((dDAT_SCA_DAL == null) && (dDAT_SCA_AL != null)) {
                vWhere += " AND b.dat_sca <= ?";
                ifDAT_SCA_AL = index++;
            }
            vWhere += " AND b.dat_sca IS NOT NULL ";
        } else if ("N".equals(strSTA_INT)) {
            vWhere += " AND b.dat_sca IS NULL ";
        }
        if (lCOD_DPD != 0) {
            vWhere += " AND c.cod_dpd = ? ";
            ifCOD_DPD = index++;
        }
        if (!strTIT_SGZ.equals("")) {
            vWhere += " AND a.tit_sgz LIKE ?||'%' ";
            ifTIT_SGZ = index++;
        }
        if (!strNOM_RIL_SGZ.equals("")) {
            vWhere += " AND a.nom_ril_sgz LIKE ?||'%' ";
            ifNOM_RIL_SGZ = index++;
        }

        if (strRG_GROUP.equals("N")) {
            if (!strVAR_SGZ.equals("X")) {
                vGroup = " ORDER BY a.dat_sgz " + strVAR_SGZ;
            }
            if (!strVAR_SCA.equals("X")) {
                vGroup = " ORDER BY b.dat_sca " + strVAR_SCA;
            }
        }
        if (strRG_GROUP.equals("D")) {
            vGroup += " ORDER BY c.cog_dpd|| ||c.nom_dpd ";
        }
        if (strRG_GROUP.equals("A")) {
            vGroup += " ORDER BY d.rag_scl_azl ";
        }

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_sgz,b.cod_ati_sgz,a.dat_sgz,b.dat_sca,c.cog_dpd,c.nom_dpd,d.rag_scl_azl,d.cod_azl FROM ana_sgz_tab a, ana_ati_sgz_tab b, view_ana_dpd_tab c, ana_azl_tab d WHERE a.cod_sgz = b.cod_sgz AND a.cod_dpd = c.cod_dpd AND a.cod_azl = d.cod_azl AND d.cod_azl = ? " + vWhere + vGroup);
            ps.setLong(1, lCOD_AZL);
            if (ifDAT_SGZ_DAL != 0) {
                ps.setDate(ifDAT_SGZ_DAL, dDAT_SGZ_DAL);
            }
            if (ifDAT_SGZ_AL != 0) {
                ps.setDate(ifDAT_SGZ_AL, dDAT_SGZ_AL);
            }
            if (ifDAT_SCA_DAL != 0) {
                ps.setDate(ifDAT_SCA_DAL, dDAT_SCA_DAL);
            }
            if (ifDAT_SCA_AL != 0) {
                ps.setDate(ifDAT_SCA_AL, dDAT_SCA_AL);
            }
            if (ifCOD_DPD != 0) {
                ps.setLong(ifCOD_DPD, lCOD_DPD);
            }
            if (ifTIT_SGZ != 0) {
                ps.setString(ifTIT_SGZ, strTIT_SGZ);
            }
            if (ifNOM_RIL_SGZ != 0) {
                ps.setString(ifNOM_RIL_SGZ, strNOM_RIL_SGZ);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rapportini_View obj = new Rapportini_View();
                obj.COD_SGZ = rs.getLong(1);
                obj.COD_ATI_SGZ = rs.getLong(2);
                obj.DAT_SGZ = rs.getDate(3);
                obj.DAT_SCA = rs.getDate(4);
                obj.COG_DPD = rs.getString(5);
                obj.NOM_DPD = rs.getString(6);
                obj.RAG_SCL_AZL = rs.getString(7);
                obj.COD_AZL = rs.getLong(8);
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
/////-------finish
    }
//</views>
}//--------------------------------------------------------------------------------------
