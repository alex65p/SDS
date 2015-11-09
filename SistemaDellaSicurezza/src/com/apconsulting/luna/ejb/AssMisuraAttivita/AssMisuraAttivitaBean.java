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
package com.apconsulting.luna.ejb.AssMisuraAttivita;

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
public class AssMisuraAttivitaBean extends BMPEntityBean implements IAssMisuraAttivita, IAssMisuraAttivitaHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    long lCOD_MIS_PET_MAN;				//1
    long lCOD_MIS_PET;					//2
    java.sql.Date dtDAT_INZ;			//3
    java.sql.Date dtDAT_FIE;			//4
    String strPRS_MIS_PET;				//5
    long lVER_MIS_PET;					//6
    String strADT_MIS_PET;				//7
    java.sql.Date dtDAT_PAR_ADT;		//8
    String strPER_MIS_PET;				//9
    long lPNZ_MIS_PET_MES;				//10
    java.sql.Date dtDAT_PNZ_MIS_PET;	//11
    String strTPL_DSI_MIS_PET;			//12
    String strDSI_AZL_MIS_PET;			//13
    String strSTA_MIS_PET;				//14
    long lCOD_RSO_MAN;					//15
    long lCOD_MAN;						//16
    long lCOD_TPL_MIS_PET;				//17
////////////////////// CONSTRUCTOR///////////////////
    private static AssMisuraAttivitaBean ys = null;
    
    private AssMisuraAttivitaBean() {
    }
    
    public static AssMisuraAttivitaBean getInstance(){
        if (ys==null) ys = new AssMisuraAttivitaBean();
        return ys;
    }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IAssMisuraAttivita create(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_MAN, long lCOD_MAN, long lCOD_TPL_MIS_PET) throws javax.ejb.CreateException {
        AssMisuraAttivitaBean bean = new AssMisuraAttivitaBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_MIS_PET, strPRS_MIS_PET, lVER_MIS_PET, strADT_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strDSI_AZL_MIS_PET, strSTA_MIS_PET, lCOD_RSO_MAN, lCOD_MAN, lCOD_TPL_MIS_PET);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_MIS_PET, strPRS_MIS_PET, lVER_MIS_PET, strADT_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strDSI_AZL_MIS_PET, strSTA_MIS_PET, lCOD_RSO_MAN, lCOD_MAN, lCOD_TPL_MIS_PET);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    
    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AssMisuraAttivitaBean bean = new AssMisuraAttivitaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    
    // (Home Intrface) findByPrimaryKey()
    public IAssMisuraAttivita findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        AssMisuraAttivitaBean bean = new AssMisuraAttivitaBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    
    // (Home Intrface) findAll()
    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
/////////////////////ATTENTION!!//////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

//</IAziendaHome-implementation>
//---------------------------------------------------------
    public Long ejbCreate(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_MAN, long lCOD_MAN, long lCOD_TPL_MIS_PET) {
        this.lCOD_MIS_PET_MAN = NEW_ID();
        this.lCOD_MIS_PET = lCOD_MIS_PET;
        this.strPRS_MIS_PET = strPRS_MIS_PET;
        this.lVER_MIS_PET = lVER_MIS_PET;
        this.strADT_MIS_PET = strADT_MIS_PET;
        this.strPER_MIS_PET = strPER_MIS_PET;
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        this.strSTA_MIS_PET = strSTA_MIS_PET;
        this.lCOD_RSO_MAN = lCOD_RSO_MAN;
        this.lCOD_MAN = lCOD_MAN;
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mis_pet_man_tab (cod_mis_pet_man,cod_mis_pet,prs_mis_pet,ver_mis_pet,adt_mis_pet,per_mis_pet,dat_pnz_mis_pet,tpl_dsi_mis_pet,dsi_azl_mis_pet,sta_mis_pet,cod_rso_man,cod_man,cod_tpl_mis_pet) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_MIS_PET_MAN);
            ps.setLong(2, lCOD_MIS_PET);
            ps.setString(3, strPRS_MIS_PET);
            ps.setLong(4, lVER_MIS_PET);
            ps.setString(5, strADT_MIS_PET);
            ps.setString(6, strPER_MIS_PET);
            ps.setDate(7, dtDAT_PNZ_MIS_PET);
            ps.setString(8, strTPL_DSI_MIS_PET);
            ps.setString(9, strDSI_AZL_MIS_PET);
            ps.setString(10, strSTA_MIS_PET);
            ps.setLong(11, lCOD_RSO_MAN);
            ps.setLong(12, lCOD_MAN);
            ps.setLong(13, lCOD_TPL_MIS_PET);
            ps.executeUpdate();
            return new Long(lCOD_MIS_PET_MAN);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------------
    public void ejbPostCreate(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_MAN, long lCOD_MAN, long lCOD_TPL_MIS_PET) {
    }
//---------------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet_man FROM mis_pet_man_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); //
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
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
        this.lCOD_MIS_PET_MAN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------
    public void ejbPassivate() {
        this.lCOD_MIS_PET_MAN = -1;
    }
//----------------------------------------------------------
    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet_man,cod_mis_pet,dat_inz,dat_fie,prs_mis_pet,ver_mis_pet,adt_mis_pet,dat_par_adt,per_mis_pet,pnz_mis_pet_mes,dat_pnz_mis_pet,tpl_dsi_mis_pet,dsi_azl_mis_pet,sta_mis_pet,cod_rso_man,cod_man,cod_tpl_mis_pet FROM mis_pet_man_tab WHERE cod_mis_pet_man=?");
            ps.setLong(1, lCOD_MIS_PET_MAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_MIS_PET_MAN = rs.getLong(1);
                lCOD_MIS_PET = rs.getLong(2);
                dtDAT_INZ = rs.getDate(3);
                dtDAT_FIE = rs.getDate(4);
                strPRS_MIS_PET = rs.getString(5);
                lVER_MIS_PET = rs.getLong(6);
                strADT_MIS_PET = rs.getString(7);
                dtDAT_PAR_ADT = rs.getDate(8);
                strPER_MIS_PET = rs.getString(9);
                lPNZ_MIS_PET_MES = rs.getLong(10);
                dtDAT_PNZ_MIS_PET = rs.getDate(11);
                strTPL_DSI_MIS_PET = rs.getString(12);
                strDSI_AZL_MIS_PET = rs.getString(13);
                strSTA_MIS_PET = rs.getString(14);
                lCOD_RSO_MAN = rs.getLong(15);
                lCOD_MAN = rs.getLong(16);
                lCOD_TPL_MIS_PET = rs.getLong(17);
            } else {
                throw new NoSuchEntityException("AssMisureAttivita with ID=" + lCOD_MIS_PET_MAN + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------
    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mis_pet_man_tab WHERE cod_mis_pet_man=?");
            ps.setLong(1, lCOD_MIS_PET_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssMisureAttivita with ID=" + lCOD_MIS_PET_MAN + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------
    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE mis_pet_man_tab SET cod_mis_pet=?, dat_inz=?, dat_fie=?, prs_mis_pet=?, ver_mis_pet=?, adt_mis_pet=?, dat_par_adt=?, per_mis_pet=?, pnz_mis_pet_mes=?, dat_pnz_mis_pet=?, tpl_dsi_mis_pet=?, dsi_azl_mis_pet=?, sta_mis_pet=?, cod_rso_man=?, cod_man=?, cod_tpl_mis_pet=? WHERE cod_mis_pet_man=?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setDate(2, dtDAT_INZ);
            ps.setDate(3, dtDAT_FIE);
            ps.setString(4, strPRS_MIS_PET);
            ps.setLong(5, lVER_MIS_PET);
            ps.setString(6, strADT_MIS_PET);
            ps.setDate(7, dtDAT_PAR_ADT);
            ps.setString(8, strPER_MIS_PET);
            if (lPNZ_MIS_PET_MES == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, lPNZ_MIS_PET_MES);
            }
            ps.setDate(10, dtDAT_PNZ_MIS_PET);
            ps.setString(11, strTPL_DSI_MIS_PET);
            ps.setString(12, strDSI_AZL_MIS_PET);
            ps.setString(13, strSTA_MIS_PET);
            ps.setLong(14, lCOD_RSO_MAN);
            ps.setLong(15, lCOD_MAN);
            ps.setLong(16, lCOD_TPL_MIS_PET);
            ps.setLong(17, lCOD_MIS_PET_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssMisureAttivita with ID=" + lCOD_MIS_PET_MAN + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    public Collection getAssMisuraAttivita_View(long COD_AZL) {
        return (new AssMisuraAttivitaBean()).ejbGetAssMisuraAttivita_View(COD_AZL);
    }
    //
    public Collection getAssMP_Man_View(String WHE_IN_AZL) {
        return (new AssMisuraAttivitaBean()).ejbGetAssMP_Man_View(WHE_IN_AZL);
    }

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
    public long getCOD_MIS_PET_MAN() {
        return lCOD_MIS_PET_MAN;
    }
    //2
    public long getCOD_MIS_PET() {
        return lCOD_MIS_PET;
    }

    public void setCOD_MIS_PET(long lCOD_MIS_PET) {
        if (this.lCOD_MIS_PET == lCOD_MIS_PET) {
            return;
        }
        this.lCOD_MIS_PET = lCOD_MIS_PET;
        setModified();
    }
    //3
    public java.sql.Date getDAT_INZ() {
        return dtDAT_INZ;
    }

    public void setDAT_INZ(java.sql.Date dtDAT_INZ) {
        if (this.dtDAT_INZ == dtDAT_INZ) {
            return;
        }
        this.dtDAT_INZ = dtDAT_INZ;
        setModified();
    }
    //4
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
    //5
    public String getPRS_MIS_PET() {
        return strPRS_MIS_PET;
    }

    public void setPRS_MIS_PET(String strPRS_MIS_PET) {
        if ((this.strPRS_MIS_PET != null) && (this.strPRS_MIS_PET.equals(strPRS_MIS_PET))) {
            return;
        }
        this.strPRS_MIS_PET = strPRS_MIS_PET;
        setModified();
    }
    //6
    public long getVER_MIS_PET() {
        return lVER_MIS_PET;
    }

    public void setVER_MIS_PET(long lVER_MIS_PET) {
        if (this.lVER_MIS_PET == lVER_MIS_PET) {
            return;
        }
        this.lVER_MIS_PET = lVER_MIS_PET;
        setModified();
    }
    //7
    public String getADT_MIS_PET() {
        return strADT_MIS_PET;
    }

    public void setADT_MIS_PET(String strADT_MIS_PET) {
        if ((this.strADT_MIS_PET != null) && (this.strADT_MIS_PET.equals(strADT_MIS_PET))) {
            return;
        }
        this.strADT_MIS_PET = strADT_MIS_PET;
        setModified();
    }
    //8
    public java.sql.Date getDAT_PAR_ADT() {
        return dtDAT_PAR_ADT;
    }

    public void setDAT_PAR_ADT(java.sql.Date dtDAT_PAR_ADT) {
        if (this.dtDAT_PAR_ADT == dtDAT_PAR_ADT) {
            return;
        }
        this.dtDAT_PAR_ADT = dtDAT_PAR_ADT;
        setModified();
    }
    //9
    public String getPER_MIS_PET() {
        return strPER_MIS_PET;
    }

    public void setPER_MIS_PET(String strPER_MIS_PET) {
        if ((this.strPER_MIS_PET != null) && (this.strPER_MIS_PET.equals(strPER_MIS_PET))) {
            return;
        }
        this.strPER_MIS_PET = strPER_MIS_PET;
        setModified();
    }
    //10
    public long getPNZ_MIS_PET_MES() {
        return lPNZ_MIS_PET_MES;
    }

    public void setPNZ_MIS_PET_MES(long lPNZ_MIS_PET_MES) {
        if (this.lPNZ_MIS_PET_MES == lPNZ_MIS_PET_MES) {
            return;
        }
        this.lPNZ_MIS_PET_MES = lPNZ_MIS_PET_MES;
        setModified();
    }
    //11
    public java.sql.Date getDAT_PNZ_MIS_PET() {
        return dtDAT_PNZ_MIS_PET;
    }

    public void setDAT_PNZ_MIS_PET(java.sql.Date dtDAT_PNZ_MIS_PET) {
        if (this.dtDAT_PNZ_MIS_PET == dtDAT_PNZ_MIS_PET) {
            return;
        }
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        setModified();
    }
    //12
    public String getTPL_DSI_MIS_PET() {
        return strTPL_DSI_MIS_PET;
    }

    public void setTPL_DSI_MIS_PET(String strTPL_DSI_MIS_PET) {
        if ((this.strTPL_DSI_MIS_PET != null) && (this.strTPL_DSI_MIS_PET.equals(strTPL_DSI_MIS_PET))) {
            return;
        }
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        setModified();
    }
    //13
    public String getDSI_AZL_MIS_PET() {
        return strDSI_AZL_MIS_PET;
    }

    public void setDSI_AZL_MIS_PET(String strDSI_AZL_MIS_PET) {
        if ((this.strDSI_AZL_MIS_PET != null) && (this.strDSI_AZL_MIS_PET.equals(strDSI_AZL_MIS_PET))) {
            return;
        }
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        setModified();
    }
    //14
    public String getSTA_MIS_PET() {
        return strSTA_MIS_PET;
    }

    public void setSTA_MIS_PET(String strSTA_MIS_PET) {
        if ((this.strSTA_MIS_PET != null) && (this.strSTA_MIS_PET.equals(strSTA_MIS_PET))) {
            return;
        }
        this.strSTA_MIS_PET = strSTA_MIS_PET;
        setModified();
    }
    //15
    public long getCOD_RSO_MAN() {
        return lCOD_RSO_MAN;
    }

    public void setCOD_RSO_MAN(long lCOD_RSO_MAN) {
        if (this.lCOD_RSO_MAN == lCOD_RSO_MAN) {
            return;
        }
        this.lCOD_RSO_MAN = lCOD_RSO_MAN;
        setModified();
    }
    //16
    public long getCOD_MAN() {
        return lCOD_MAN;
    }

    public void setCOD_MAN(long lCOD_MAN) {
        if (this.lCOD_MAN == lCOD_MAN) {
            return;
        }
        this.lCOD_MAN = lCOD_MAN;
        setModified();
    }
    //17
    public long getCOD_TPL_MIS_PET() {
        return lCOD_TPL_MIS_PET;
    }

    public void setCOD_TPL_MIS_PET(long lCOD_TPL_MIS_PET) {
        if (this.lCOD_TPL_MIS_PET == lCOD_TPL_MIS_PET) {
            return;
        }
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;
        setModified();
    }

//</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetAssMisuraAttivita_View(long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    " Select " +
                    " a.nom_mis_pet, " +
                    " a.dat_cmp, " +
                    " b.cod_mis_pet_man, " +
                    " b.cod_mis_pet, " +
                    " b.dat_inz, " +
                    " b.dat_fie,  " +
                    " b.prs_mis_pet, " +
                    " b.cod_rso_man, " +
                    " b.cod_man, " +
                    " b.ver_mis_pet, " +
                    " b.dat_par_adt, " +
                    " b.pnz_mis_pet_mes, " +
                    " b.dat_pnz_mis_pet, " +
                    " b.sta_mis_pet " +
                    " from ana_mis_pet_tab a, mis_pet_man_tab b " +
                    " where a.cod_mis_pet = b.cod_mis_pet " +
                    " and a.cod_azl =?  " +
                    " and b.cod_rso_man = ?  " +
                    " and b.cod_man = ? ");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, this.lCOD_RSO_MAN);
            ps.setLong(3, this.lCOD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            String stato = "";
            while (rs.next()) {
                AssMisuraAttivita_View obj = new AssMisuraAttivita_View();
                obj.NOM_MIS_PET = rs.getString(1);
                obj.DAT_CMP = rs.getDate(2);
                obj.COD_MIS_PET_MAN = rs.getLong(3);
                obj.DAT_PNZ_MIS_PET = rs.getDate(5);
                obj.VER_MIS_PET = rs.getLong(10);
                stato = rs.getString(14);
                if (rs.getString(14).equals("A")) {
                    stato = "Applicata";
                }
                if (rs.getString(14).equals("D")) {
                    stato = "Da Applicare";
                }
                obj.STA_MIS_PET = stato;
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------------------------------------
    public Collection getAudit_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_inr_adt, des_inr_adt FROM ana_inr_adt_tab WHERE cod_mis_pet_man= ? ");
            ps.setLong(1, this.lCOD_MIS_PET_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssMP_Audit_View obj = new AssMP_Audit_View();
                obj.COD_INR_ADT = rs.getLong(1);
                obj.DES_INR_ADT = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------
    public Collection getDocumenti_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT doc_mis_pet_tab.cod_mis_pet, ana_doc_tab.cod_doc, ana_doc_tab.tit_doc, ana_doc_tab.rsp_doc, ana_doc_tab.dat_rev_doc FROM ana_mis_pet_tab, doc_mis_pet_tab, ana_doc_tab WHERE (doc_mis_pet_tab.cod_mis_pet = ? AND doc_mis_pet_tab.cod_doc = ana_doc_tab.cod_doc AND ana_mis_pet_tab.cod_mis_pet = doc_mis_pet_tab.cod_mis_pet )");
            ps.setLong(1, this.lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssMP_Documenti_View obj = new AssMP_Documenti_View();
                obj.COD_DOC = rs.getLong(2);
                obj.TIT_DOC = rs.getString(3);
                obj.RSP_DOC = rs.getString(4);
                obj.DAT_REV_DOC = rs.getDate(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------
    public Collection getNormativeSentenze_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT nor_sen_mis_pet_tab.cod_mis_pet, ana_nor_sen_tab.cod_nor_sen, ana_nor_sen_tab.tit_nor_sen, ana_nor_sen_tab.dat_nor_sen FROM ana_mis_pet_tab, nor_sen_mis_pet_tab, ana_nor_sen_tab WHERE (nor_sen_mis_pet_tab.cod_mis_pet = ? AND nor_sen_mis_pet_tab.cod_nor_sen = ana_nor_sen_tab.cod_nor_sen AND ana_mis_pet_tab.cod_mis_pet = nor_sen_mis_pet_tab.cod_mis_pet )");
            ps.setLong(1, this.lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssMP_NormativeSentenze_View obj = new AssMP_NormativeSentenze_View();
                obj.COD_NOR_SEN = rs.getLong(2);
                obj.TIT_NOR_SEN = rs.getString(3);
                obj.DAT_NOR_SEN = rs.getDate(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------
    public Collection getAttivitaSegnalazione_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT sgz_mis_pet_tab.cod_mis_pet, ana_ati_sgz_tab.cod_ati_sgz, ana_ati_sgz_tab.des_ati_sgz, ana_ati_sgz_tab.dat_sca FROM  ana_mis_pet_tab, sgz_mis_pet_tab, ana_ati_sgz_tab WHERE (sgz_mis_pet_tab.cod_mis_pet = ? AND sgz_mis_pet_tab.cod_ati_sgz = ana_ati_sgz_tab.cod_ati_sgz AND ana_mis_pet_tab.cod_mis_pet = sgz_mis_pet_tab.cod_mis_pet )");
            ps.setLong(1, this.lCOD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssMP_AttivitaSegnalazione_View obj = new AssMP_AttivitaSegnalazione_View();
                obj.COD_ATI_SGZ = rs.getLong(2);
                obj.DES_ATI_SGZ = rs.getString(3);
                obj.DAT_SCA = rs.getDate(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------
    public Collection ejbGetAssMP_Man_View(String WHE_IN_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_man, a.nom_mis_pet, b.nom_man ";
            query += "FROM ana_mis_pet_azl_tab a,ana_man_tab b ";
            query += "WHERE a.cod_man = b.cod_man AND a.cod_azl in (" + WHE_IN_AZL + ")";
            PreparedStatement ps = bmp.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssMP_Man_View obj = new AssMP_Man_View();
                obj.COD_MIS_PET_MAN = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
                obj.NOM_MAN = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AziendaBean"/>

