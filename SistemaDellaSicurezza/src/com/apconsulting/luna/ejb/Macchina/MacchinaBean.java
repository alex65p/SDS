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
package com.apconsulting.luna.ejb.Macchina;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class MacchinaBean extends BMPEntityBean implements IMacchina, IMacchinaHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    String IDE_MAC;     	//1
    String DES_MAC; 		//2
    String MDL_MAC;       //3
    String DIT_CST_MAC;   //4
    String FBR_MAC;       //5
    long COD_TPL_MAC;     //6
    long COD_AZL;   	    //7
    long COD_MAC;    		//8
    //-----------------------
    long YEA_CST_MAC; 	//9
    String TAR_MAC;		//10
    String PPO_MAC;		//11
    String MRC_MAC;		//12
    long PRT_MAC;		//13
    String CAT_MAC;		//14
    String PRE_MAC;		//15
    long COD_LUO_FSC;   //16
    MacchinaPK primaryKEY = null;
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static MacchinaBean ys = null;

    private MacchinaBean() {
        //
    }

    public static MacchinaBean getInstance() {
        if (ys == null) {
            ys = new MacchinaBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IMacchina create(long lCOD_AZL, String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC, String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende) throws javax.ejb.CreateException {
        MacchinaBean bean = new MacchinaBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC, strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, alAziende);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC, strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, alAziende);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Interface) remove()
    @Override
    public void remove(Object primaryKey) {
        MacchinaBean iMacchinaBean = new MacchinaBean();
        try {
            Object obj = iMacchinaBean.ejbFindByPrimaryKey((MacchinaPK) primaryKey);
            iMacchinaBean.setEntityContext(new EntityContextWrapper(obj));
            iMacchinaBean.ejbActivate();
            iMacchinaBean.ejbLoad();
            iMacchinaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public void remove(Object primaryKey, java.util.ArrayList alAziende) {
        MacchinaBean bean = new MacchinaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((MacchinaPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove(alAziende);
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IMacchina findByPrimaryKey(MacchinaPK primaryKey) throws FinderException {
        MacchinaBean bean = new MacchinaBean();
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

    // (Home Intrface) VIEWS  getMacchina_Name_Desc_View()
    public Collection getMacchina_Name_Desc_View(long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetMacchina_Name_Desc_View(lCOD_AZL);
    }

    public Collection getRischioMacchina_View(String strCOD_MAC) {
        return (new MacchinaBean()).ejbGetRischioMacchina_View(strCOD_MAC);
    }

    public Collection getMacchineAttrezzature_View(String strCOD_LUO_FSC) {
        return (new MacchinaBean()).ejbGetMacchineAttrezzature_View(strCOD_LUO_FSC);
    }

    public Collection getMacchineAttrezzatureAll_View(long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetMacchineAttrezzatureAll_View(lCOD_AZL);
    }

    public long getOPE_SVO_MAN_View(String strCOD_OPE_SVO) {
        return (new MacchinaBean()).ejbGetOPE_SVO_MAN_View(strCOD_OPE_SVO);
    }
//

    public Collection getMacchina_LOV_View(long AZL_ID, String strNOM, String strDES) {
        return (new MacchinaBean()).ejbGetMacchina_LOV_View(AZL_ID, strNOM, strDES);
    }

    public Collection getMacchineAtt_View(long lCOD_AZL, long lCOD_TPL_MAC, String strDES_MAC, String strMDL_MAC, String strIDE_MAC, String NomeParent, long lID_PARENT) {
        return (new MacchinaBean()).ejbGetMacchineAtt_View(lCOD_AZL, lCOD_TPL_MAC, strDES_MAC, strMDL_MAC, strIDE_MAC, NomeParent, lID_PARENT);
    }

    public void addRSO_OPE_SVO(long ID_PARENT, long COD_AZL, long newCOD_MAC) {
        ejbaddRSO_OPE_SVO(ID_PARENT, COD_AZL, newCOD_MAC);
    }

    public void addRischioAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_MAC) {
        ejbaddRischioAssociations(lID_PARENT, lCOD_AZL, lCOD_MAC);
    }
    //<alex date="31/03/2004">

    public Collection getCARICA_LUOGHI_FISICI_View(long lCOD_MAC, long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetCARICA_LUOGHI_FISICI_View(lCOD_MAC, lCOD_AZL);
    }

    public Collection getCARICA_ATTIVITA_View(long lCOD_MAC, long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetCARICA_ATTIVITA_View(lCOD_MAC, lCOD_AZL);
    }

    public int getCountAttivitaForMacchina(long lCOD_MAC, long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetCountAttivitaForMacchina(lCOD_MAC, lCOD_AZL);
    }

    public int getCountLuoghiForMacchina(long lCOD_MAC, long lCOD_AZL) {
        return (new MacchinaBean()).ejbGetCountLuoghiForMacchina(lCOD_MAC, lCOD_AZL);
    }
    //</alex>

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IMacchinaHome-implementation>
    public MacchinaPK ejbCreate(long lCOD_AZL, String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC, String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende) {
        long lFirstKey = NEW_ID();
        this.COD_MAC = NEW_ID();
        this.IDE_MAC = strIDE_MAC;
        this.DES_MAC = strDES_MAC;
        this.MDL_MAC = strMDL_MAC;
        this.DIT_CST_MAC = strDIT_CST_MAC;
        this.FBR_MAC = strFBR_MAC;
        this.YEA_CST_MAC = lYEA_CST_MAC;
        this.TAR_MAC = strTAR_MAC;
        this.PPO_MAC = strPPO_MAC;
        this.MRC_MAC = strMRC_MAC;
        this.PRT_MAC = lPRT_MAC;
        this.CAT_MAC = strCAT_MAC;
        this.PRE_MAC = strPRE_MAC;
        this.COD_TPL_MAC = lCOD_TPL_MAC;
        this.COD_AZL = lCOD_AZL;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_mac_tab (cod_mac,ide_mac,des_mac,mdl_mac,dit_cst_mac,fbr_mac,yea_cst_mac,tar_mac,ppo_mac,mrc_mac,prt_mac,cat_mac,pre_mac,cod_tpl_mac,cod_azl) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, COD_MAC);
            ps.setString(2, strIDE_MAC);
            ps.setString(3, strDES_MAC);
            ps.setString(4, strMDL_MAC);
            ps.setString(5, strDIT_CST_MAC);
            ps.setString(6, strFBR_MAC);
            ps.setLong(7, lYEA_CST_MAC);
            ps.setString(8, strTAR_MAC);
            ps.setString(9, strPPO_MAC);
            ps.setString(10, strMRC_MAC);
            ps.setLong(11, lPRT_MAC);
            ps.setString(12, strCAT_MAC);
            ps.setString(13, strPRE_MAC);
            ps.setLong(14, lCOD_TPL_MAC);
            ps.setLong(15, lCOD_AZL); // AZL
            ps.executeUpdate();

            setExtendedObject(bmp, "ana_mac_tab", lFirstKey, COD_MAC, COD_AZL);

            Iterator it = alAziende.iterator();
            while (it.hasNext()) {
                long cod_azl = ((Long) it.next()).longValue();
                if (cod_azl == lCOD_AZL) {
                    continue;
                }
                long lSecondKey = NEW_ID();
                ps.setLong(1, lSecondKey);
                ps.setLong(15, cod_azl);
                ps.executeUpdate();
                setExtendedObject(bmp, "ana_mac_tab", lFirstKey, lSecondKey, cod_azl);
            }
            bmp.commitTrans();
            return new MacchinaPK(lCOD_AZL, COD_MAC);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------

    public void ejbPostCreate(long lCOD_AZ, String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC, String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende) {
    }

//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mac FROM ana_mac_tab ");
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
    public MacchinaPK ejbFindByPrimaryKey(MacchinaPK primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        primaryKEY = (MacchinaPK) this.getEntityKey();
        this.COD_MAC = primaryKEY.lCOD_MAC;
        this.COD_AZL = primaryKEY.lCOD_AZL;
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        primaryKEY = null;
        this.COD_MAC = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_mac_tab  WHERE cod_mac=? and cod_azl=? ");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, COD_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.IDE_MAC = rs.getString("IDE_MAC");
                this.DES_MAC = rs.getString("DES_MAC");
                this.MDL_MAC = rs.getString("MDL_MAC");
                this.DIT_CST_MAC = rs.getString("DIT_CST_MAC");
                this.FBR_MAC = rs.getString("FBR_MAC");
                this.YEA_CST_MAC = rs.getLong("YEA_CST_MAC");
                this.TAR_MAC = rs.getString("TAR_MAC");
                this.PPO_MAC = rs.getString("PPO_MAC");
                this.MRC_MAC = rs.getString("MRC_MAC");
                this.PRT_MAC = rs.getLong("PRT_MAC");
                this.CAT_MAC = rs.getString("CAT_MAC");
                this.PRE_MAC = rs.getString("PRE_MAC");
                this.COD_TPL_MAC = rs.getLong("COD_TPL_MAC");
                this.COD_AZL = rs.getLong("COD_AZL");
            } else {
                throw new NoSuchEntityException("Macchina con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbRemove() {
        ejbRemove(null);
    }

    public void ejbRemove(java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_mac_tab  WHERE ( cod_mac=? OR cod_mac IN (" + getExtendedObjects("ana_mac_tab", alAziende) + ")) AND ( cod_azl=? OR cod_azl IN (" + toString(alAziende) + ") ) ");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, COD_MAC); //getExtendedObjectCodes
            ps.setLong(3, COD_AZL);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Macchina con ID= non è trovata");
            }
            removeExtendedObject(bmp, "ana_mac_tab", COD_MAC, COD_AZL, alAziende);
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//----------------------------------------------------------
    public boolean isMultiple() {
        return isExtendedObject("ana_mac_tab", COD_MAC);
    }

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        store(IDE_MAC, DES_MAC, MDL_MAC, DIT_CST_MAC, FBR_MAC, YEA_CST_MAC, TAR_MAC, PPO_MAC, MRC_MAC, PRT_MAC, CAT_MAC, PRE_MAC, COD_TPL_MAC, null);
    }

    public void store(String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC,
            String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_mac_tab  SET ide_mac=?, des_mac=?, mdl_mac=?,dit_cst_mac=?,fbr_mac=?,yea_cst_mac=?,tar_mac=?,ppo_mac=?,mrc_mac=?,prt_mac=?,cat_mac=?,pre_mac=?,cod_tpl_mac=? WHERE ( cod_mac=? or cod_mac IN (" + getExtendedObjects("ana_mac_tab", alAziende) + ") ) AND ( cod_azl=? OR cod_azl IN (" + toString(alAziende) + ")) ");
            ps.setString(1, strIDE_MAC);
            ps.setString(2, strDES_MAC);
            ps.setString(3, strMDL_MAC);
            ps.setString(4, strDIT_CST_MAC);
            ps.setString(5, strFBR_MAC);
            ps.setLong(6, lYEA_CST_MAC);
            ps.setString(7, strTAR_MAC);
            ps.setString(8, strPPO_MAC);
            ps.setString(9, strMRC_MAC);
            ps.setLong(10, lPRT_MAC);
            ps.setString(11, strCAT_MAC);
            ps.setString(12, strPRE_MAC);
            ps.setLong(13, lCOD_TPL_MAC);
            //ps.setLong  (14,COD_AZL);
            ps.setLong(14, COD_MAC);

            ps.setLong(15, COD_MAC); // getExtendedObjectCodes
            ps.setLong(16, COD_AZL);


            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio with ID=" + COD_MAC + " not found");
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
    //1
    public long getCOD_MAC() {
        return COD_MAC;
    }
    //2

    public void setIDE_MAC__DES_MAC(String newIDE_MAC, String newDES_MAC) {
        if ((IDE_MAC != null) && (DES_MAC != null)) {
            if ((IDE_MAC.equals(newIDE_MAC)) && (DES_MAC.equals(newDES_MAC))) {
                return;
            }
        }
        IDE_MAC = newIDE_MAC;
        DES_MAC = newDES_MAC;
        setModified();
    }

    public String getIDE_MAC() {
        return IDE_MAC;
    }
    //3
	  /*
    public void setDES_MAC(String newDES_MAC){
    if( DES_MAC.equals(newDES_MAC) ) return;
    DES_MAC = newDES_MAC;
    setModified();
    }
     */

    public String getDES_MAC() {
        return DES_MAC;
    }
    //4

    public void setMDL_MAC(String newMDL_MAC) {
        if (MDL_MAC != null) {
            if (MDL_MAC.equals(newMDL_MAC)) {
                return;
            }
        }
        MDL_MAC = newMDL_MAC;
        setModified();
    }

    public String getMDL_MAC() {
        return MDL_MAC;
    }
    //5

    public void setDIT_CST_MAC(String newDIT_CST_MAC) {
        if (DIT_CST_MAC.equals(newDIT_CST_MAC)) {
            return;
        }
        DIT_CST_MAC = newDIT_CST_MAC;
        setModified();
    }

    public String getDIT_CST_MAC() {
        return DIT_CST_MAC;
    }
    //6

    public void setFBR_MAC(String newFBR_MAC) {
        if (FBR_MAC.equals(newFBR_MAC)) {
            return;
        }
        FBR_MAC = newFBR_MAC;
        setModified();
    }

    public String getFBR_MAC() {
        return FBR_MAC;
    }
    //7

    public void setCOD_TPL_MAC(long newCOD_TPL_MAC) {
        if (COD_TPL_MAC == newCOD_TPL_MAC) {
            return;
        }
        COD_TPL_MAC = newCOD_TPL_MAC;
        setModified();
    }

    public long getCOD_TPL_MAC() {
        return COD_TPL_MAC;
    }
    //8

    public void setCOD_AZL(long newCOD_AZL) {
        if (COD_AZL == newCOD_AZL) {
            return;
        }
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }
    //============================================
    // not required field
    //9

    public void setYEA_CST_MAC(long newYEA_CST_MAC) {
        if (YEA_CST_MAC == newYEA_CST_MAC) {
            return;
        }
        YEA_CST_MAC = newYEA_CST_MAC;
        setModified();
    }

    public long getYEA_CST_MAC() {
        return YEA_CST_MAC;
    }
    //10

    public void setTAR_MAC(String newTAR_MAC) {
        if (TAR_MAC != null) {
            if (TAR_MAC.equals(newTAR_MAC)) {
                return;
            }
        }
        TAR_MAC = newTAR_MAC;
        setModified();
    }

    public String getTAR_MAC() {
        return TAR_MAC;
    }
    //11

    public void setPPO_MAC(String newPPO_MAC) {
        if (PPO_MAC != null) {
            if (PPO_MAC.equals(newPPO_MAC)) {
                return;
            }
        }
        PPO_MAC = newPPO_MAC;
        setModified();
    }

    public String getPPO_MAC() {
        return PPO_MAC;
    }
    //12

    public void setMRC_MAC(String newMRC_MAC) {
        if (MRC_MAC != null) {
            if (MRC_MAC.equals(newMRC_MAC)) {
                return;
            }
        }
        MRC_MAC = newMRC_MAC;
        setModified();
    }

    public String getMRC_MAC() {
        return MRC_MAC;
    }
    //13

    public void setPRT_MAC(long newPRT_MAC) {
        if (PRT_MAC == newPRT_MAC) {
            return;
        }
        PRT_MAC = newPRT_MAC;
        setModified();
    }

    public long getPRT_MAC() {
        return PRT_MAC;
    }
    //14

    public void setCAT_MAC(String newCAT_MAC) {
        if (CAT_MAC != null) {
            if (CAT_MAC.equals(newCAT_MAC)) {
                return;
            }
        }
        CAT_MAC = newCAT_MAC;
        setModified();
    }

    public String getCAT_MAC() {
        return CAT_MAC;
    }
    //15

    public void setPRE_MAC(String newPRE_MAC) {
        if (PRE_MAC != null) {
            if (PRE_MAC.equals(newPRE_MAC)) {
                return;
            }
        }
        PRE_MAC = newPRE_MAC;
        setModified();
    }

    public String getPRE_MAC() {
        return PRE_MAC;
    }

    //</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetMacchina_Name_Desc_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mac,ide_mac,des_mac,mdl_mac FROM ana_mac_tab WHERE cod_azl=? ORDER BY des_mac ");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Macchina_Name_Desc_View obj = new Macchina_Name_Desc_View();
                obj.COD_MAC = rs.getLong(1);
                obj.IDE_MAC = rs.getString(2);
                obj.DES_MAC = rs.getString(3);
                obj.MDL_MAC = rs.getString(4);
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

    //-------------------
    //</comment>
    public Collection ejbGetRischioMacchina_View(String strCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.nom_rso, a.ent_dan, a.rfc_vlu_rso_mes, a.cod_rso, b.tpl_clf_rso FROM rso_mac_tab b, ana_rso_tab a WHERE a.cod_azl=b.cod_azl AND a.cod_rso=b.cod_rso AND b.cod_mac=? ");
            ps.setString(1, strCOD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioMacchina_View obj = new RischioMacchina_View();
                obj.NOM_RSO = rs.getString(1);
                obj.ENT_DAN = rs.getString(2);
                obj.RFC_VLU_RSO_MES = rs.getLong(3);
                obj.COD_RSO = rs.getLong(4);
                obj.TPL_CLF_RSO = rs.getString(5);
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
    //---------------------------------------------------------------------------

    public long ejbGetOPE_SVO_MAN_View(String strCOD_OPE_SVO) {
        BMPConnection bmp = getConnection();
        try {
            long result = 0;
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COUNT(b.cod_man) "
                    + "FROM ana_man_tab b, ope_svo_man_tab a "
                    + "WHERE a.cod_man=b.cod_man AND a.cod_ope_svo=? ");
            ps.setString(1, strCOD_OPE_SVO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getLong(1);
            }
            bmp.close();
            return result;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //---------------------------------------------------------------------------

    public Collection ejbGetMacchineAttrezzature_View(String strCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_mac, b.ide_mac, b.des_mac " + " FROM ana_mac_tab b, mac_luo_fsc_tab a " + " WHERE a.cod_mac=b.cod_mac " + " AND a.cod_luo_fsc=? order by b.ide_mac ");
            ps.setString(1, strCOD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchineAttrezzature_View obj = new MacchineAttrezzature_View();
                obj.COD_MAC = rs.getLong(1);
                obj.IDE_MAC = rs.getString(2);
                obj.DES_MAC = rs.getString(3);
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
//----------------------------------------------------------------------------------

    public void addMAC_LUO_FSC(java.sql.Date Today, String strCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mac_luo_fsc_tab (dat_mac_luo,cod_mac,cod_luo_fsc) VALUES(?,?,?)");
            ps.setDate(1, Today);
            ps.setLong(2, COD_MAC);
            ps.setString(3, strCOD_LUO_FSC);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-----------------------------------------------------------------------------------

    public void removeMAC_LUO_FSC(String newCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mac_luo_fsc_tab  WHERE cod_mac=? AND cod_luo_fsc=?");
            ps.setLong(1, COD_MAC);
            ps.setString(2, newCOD_LUO_FSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Macchina con ID=" + COD_MAC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /*  <comment date="12/02/2004" author="Alex Kyba">
    <description> ejbGetMacchineAttrezzatureAll_View </description>*/
    public Collection ejbGetMacchineAttrezzatureAll_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select ide_mac, des_mac, mdl_mac, dit_cst_mac, fbr_mac, cod_tpl_mac, cod_azl, cod_mac, yea_cst_mac, tar_mac, ppo_mac, mrc_mac,  prt_mac ,cat_mac,pre_mac from ana_mac_tab where cod_azl=?  order by des_mac");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchineAttrezzatureAll_View obj = new MacchineAttrezzatureAll_View();
                obj.strIDE_MAC = rs.getString(1);     //1
                obj.strDES_MAC = rs.getString(2); 	//2
                obj.strMDL_MAC = rs.getString(3);     //3
                obj.strDIT_CST_MAC = rs.getString(4); //4
                obj.strFBR_MAC = rs.getString(5);     //5
                obj.lCOD_TPL_MAC = rs.getLong(6);     //6
                obj.lCOD_AZL = rs.getLong(7);   	    //7
                obj.lCOD_MAC = rs.getLong(8);    		//8
                //----------------------//
                obj.lYEA_CST_MAC = rs.getLong(9); 	//9
                obj.strTAR_MAC = rs.getString(10);	//10
                obj.strPPO_MAC = rs.getString(11);	//11
                obj.strMRC_MAC = rs.getString(12);	//12
                obj.lPRT_MAC = rs.getLong(13);		//13
                obj.strCAT_MAC = rs.getString(14);	//14
                obj.strPRE_MAC = rs.getString(15);	//15
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
    //----------

    public Collection getTipClassView(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(" select tpl_clf_rso from rso_mac_tab where cod_rso = ?  and cod_mac = ? and cod_azl = ?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, COD_MAC);
            ps.setLong(3, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioMacchinaView obj = new RischioMacchinaView();
                obj.strTPL_CLF_RSO = rs.getString(1);
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
    //-------references-----------------------------------------

    public Collection getAnagraficaDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  doc.cod_doc, doc.tit_doc, doc.rsp_doc, doc.dat_rev_doc from ana_doc_tab doc,  ana_mac_tab mac, doc_mac_tab doc_mac    where   doc.cod_doc=doc_mac.cod_doc and mac.cod_mac=doc_mac.cod_mac and mac.cod_mac=? order by doc.tit_doc");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagraficaDocumentiView obj = new AnagraficaDocumentiView();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strTIT_DOC = rs.getString(2);
                obj.strRSP_DOC = rs.getString(3);
                obj.dtDAT_REV_DOC = rs.getDate(4);
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

    public Collection getNormativeSentenzeView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  sen.cod_nor_sen, sen.tit_nor_sen, sen.dat_nor_sen from   ana_nor_sen_tab sen, ana_mac_tab mac, nor_sen_mac_tab sen_mac where   sen.cod_nor_sen = sen_mac.cod_nor_sen and  mac.cod_mac=sen_mac.cod_mac and mac.cod_mac=? order by sen.tit_nor_sen");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NormativeSentenzeView obj = new NormativeSentenzeView();
                obj.lCOD_NOR_SEN = rs.getLong(1);
                obj.strTIT_NOR_SEN = rs.getString(2);
                obj.dtDAT_NOR_SEN = rs.getDate(3);
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

    public Collection getNormativeSentenzeViewEx() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  sen.cod_nor_sen, sen.tit_nor_sen, sen.dat_nor_sen, sen.NUM_DOC_NOR_SEN from   ana_nor_sen_tab sen, ana_mac_tab mac, nor_sen_mac_tab sen_mac where   sen.cod_nor_sen = sen_mac.cod_nor_sen and  mac.cod_mac=sen_mac.cod_mac and mac.cod_mac=?");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NormativeSentenzeViewEx obj = new NormativeSentenzeViewEx();
                obj.lCOD_NOR_SEN = rs.getLong(1);
                obj.strTIT_NOR_SEN = rs.getString(2);
                obj.dtDAT_NOR_SEN = rs.getDate(3);
                obj.strNUM_DOC_NOR_SEN = rs.getString(4);
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

    public Collection getLuoghiFisiciView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "lf.cod_luo_fsc, "
                        + "lf.nom_luo_fsc, "
                        + "lf.nom_rsp_luo_fsc, "
                        + "lf.qlf_rsp_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab lf, "
                        + "mac_luo_fsc_tab mlf, "
                        + "ana_mac_tab m "
                    + "where "
                        + "lf.cod_luo_fsc = mlf.cod_luo_fsc "
                        + "and mlf.cod_mac = m.cod_mac "
                        + "and m.cod_mac=?");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Macchina_LuoghiFisiciView obj = new Macchina_LuoghiFisiciView();
                obj.lCOD_LUO_FSC = rs.getLong(1);
                obj.strNOM_LUO_FSC = rs.getString(2);
                obj.strNOM_RSP_LUO_FSC = rs.getString(3);
                obj.strQLF_RSP_LUO_FSC = rs.getString(4);
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

    public Collection getRischioMacchinaView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select rm.cod_rso, rm.cod_mac, rm.cod_azl,rso.nom_rso, rso.stm_num_rso, rm.tpl_clf_rso from ana_rso_tab rso, rso_mac_tab rm, ana_mac_tab m where rso.cod_azl = rm.cod_azl and rso.cod_rso = rm.cod_rso	   and rso.cod_azl = ? and rm.cod_mac=m.cod_mac and m.cod_mac=? order by rso.nom_rso");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, COD_MAC);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioMacchinaView obj = new RischioMacchinaView();

                obj.lCOD_RSO = rs.getLong(1);
                obj.lCOD_MAC = rs.getLong(2);
                obj.lCOD_AZL = rs.getLong(3);
                obj.strNOM_RSO = rs.getString(4);
                obj.strSTM_NUM_RSO = rs.getString(5);
                obj.strTPL_CLF_RSO = rs.getString(6);
                obj.strRFC_VLU_RSO = "";
                if (obj.strTPL_CLF_RSO.equals("O")) {
                    obj.strRFC_VLU_RSO = "Operatore";
                }
                if (obj.strTPL_CLF_RSO.equals("T")) {
                    obj.strRFC_VLU_RSO = "Tutti";
                }
                if (obj.strTPL_CLF_RSO.equals("O/T")) {
                    obj.strRFC_VLU_RSO = "Operatore/Tutti";
                }
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

    public Collection getReportRischioMacchinaView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select rm.cod_rso,  rso.ent_dan, rso.clf_rso, rso.dat_ril from ana_rso_tab rso, rso_mac_tab rm, ana_mac_tab m where rso.cod_rso = rm.cod_rso	   and rso.cod_azl = ? and rm.cod_mac=m.cod_mac and m.cod_mac=? ");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_MAC);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportRischioMacchinaView obj = new ReportRischioMacchinaView();
                obj.lCOD_RSO = rs.getLong(1);
                obj.lENT_DAN = rs.getLong(2);
                obj.strCLF_RSO = rs.getString(3);
                obj.dtDAT_RIL = rs.getDate(4);
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

    public Collection getAttivitaMntView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select mnt_mac.cod_mnt_mac, mnt_mac.des_ati_mnt_mac,mnt_mac.per_ati_mnt_mes, mnt_mac.dat_par_mnt_mac from ana_ati_mnt_mac_tab mnt_mac  where mnt_mac.cod_mac = ?  order by mnt_mac.des_ati_mnt_mac");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivitaMntView obj = new AttivitaMntView();
                obj.lCOD_MNT_MAC = rs.getLong(1);
                obj.strDES_ATI_MNT_MAC = rs.getString(2);
                obj.lPER_ATI_MNT_MES = rs.getLong(3);
                obj.dtDAT_PAR_MNT_MAC = rs.getDate(4);
                obj.strNB_PER_ATI_MNT_MES = "";
                if (obj.lPER_ATI_MNT_MES == 1) {
                    obj.strNB_PER_ATI_MNT_MES = "MENSILE";
                } else if (obj.lPER_ATI_MNT_MES > 1) {
                    obj.strNB_PER_ATI_MNT_MES = "OGNI " + obj.lPER_ATI_MNT_MES + " MESI";
                }
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

    public Collection getFornitoriMacView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select f.cod_for_azl, f.rag_soc_for_azl, f.cag_for, f.cit_for, f.nom_rsp_for from mac_for_azl_tab mf, ana_mac_tab  m, ana_for_azl_tab f where mf.cod_mac = m.cod_mac and f.cod_for_azl=mf.cod_for_azl and m.cod_mac=? order by f.rag_soc_for_azl");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FornitoriMacView obj = new FornitoriMacView();

                obj.lCOD_FOR_AZL = rs.getLong(1);
                obj.strRAG_SOZ_FOR_AZL = rs.getString(2);
                obj.strCAG_FOR = rs.getString(3);
                obj.strCIT_FOR = rs.getString(4);
                obj.strNOM_RSP_FOR = rs.getString(5);
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

    public Collection getAttivitaLavorativeMacchineView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select f.cod_man, f.nom_man from mac_man_tab mm, ana_mac_tab m, ana_man_tab f where mm.cod_mac = m.cod_mac and f.cod_man = mm.cod_man and m.cod_mac=? order by f.nom_man");
            ps.setLong(1, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                UtilizzatoriView obj = new UtilizzatoriView();

                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);

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
    //-------------------------------------------------------------
    //-----------methods for dependences --------------------------
    //-------------------------------------------------------------

    //-------Rischio macchine ----------------------------------
    public void addRischio(long lCOD_RSO, String strTPL_CLF_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("insert into rso_mac_tab(cod_mac,cod_rso,cod_azl,tpl_clf_rso)   values (?,?,?,?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, COD_AZL);
            ps.setString(4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteRischio(long lCOD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_mac_tab WHERE cod_mac=? and cod_rso=? and cod_azl=?");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio con ID=" + lCOD_RSO + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //------------Attivita Manutenziuone--------------
    public void addAttManutenzione(long lCOD_MNT_MAC) {
    }

    public void deleteAttManutenzione(long lCOD_MNT_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ati_mnt_mac_tab WHERE cod_mac=? and cod_mnt_mac=? ");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_MNT_MAC);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Attivita Manutenzione con ID=" + lCOD_MNT_MAC + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //---------- Documentazione ----------------------

    public void addDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_mac_tab (cod_mac, cod_doc) VALUES(?,?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_DOC);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_mac_tab WHERE cod_mac=? AND cod_doc=?");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento con ID=" + lCOD_DOC + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //---------------Normativa sentenze------------------------
    public void addNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_mac_tab (cod_mac, cod_nor_sen) VALUES(?,?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_NOR_SEN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM nor_sen_mac_tab WHERE cod_mac=? AND cod_nor_sen=?");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_NOR_SEN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Normativa sentenza con ID=" + lCOD_NOR_SEN + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addFornitore(long lCOD_FOR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mac_for_azl_tab (cod_mac, cod_for_azl) VALUES(?,?)");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_FOR);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----

    public void deleteFornitore(long lCOD_FOR) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mac_for_azl_tab WHERE cod_mac=? AND cod_for_azl=?");
            ps.setLong(1, COD_MAC);
            ps.setLong(2, lCOD_FOR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Fornitore con ID=" + lCOD_FOR + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    /*</comment>*/
//
///-------------Yuriy Kushkarov for SCH_MAC_Lovs-------------------

    public Collection ejbGetMacchina_LOV_View(long AZL_ID, String strNOM, String strDES) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mac,ide_mac,des_mac FROM ana_mac_tab WHERE ide_mac LIKE ?||'%' AND des_mac LIKE ?||'%' AND cod_azl =?");
            ps.setString(1, strNOM);
            ps.setString(2, strDES);
            ps.setLong(3, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Macchina_LOV_View obj = new Macchina_LOV_View();
                obj.lCOD_MAC = rs.getLong(1);
                obj.strIDE_MAC = rs.getString(2);
                obj.strDES_MAC = rs.getString(3);
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
    //-----------------------

    public Collection ejbGetMacchineAtt_View(long lCOD_AZL, long lCOD_TPL_MAC, String strDES_MAC, String strMDL_MAC, String strIDE_MAC, String NomeParent, long lID_PARENT) {

        String vWhere = "";
        String vOrder = " ORDER BY des_mac ";
        int index = 2;
        int ifCOD_TPL_MAC = 0;
        int ifDES_MAC = 0;
        int ifMDL_MAC = 0;
        int ifIDE_MAC = 0;
        int ifID_PARENT = 0;

        if (lCOD_TPL_MAC != 0) {
            vWhere += " AND a.cod_tpl_mac=? ";
            ifCOD_TPL_MAC = index++;
        }
        if (!"".equals(strDES_MAC)) {
            vWhere += " AND UPPER(a.des_mac) LIKE ?||'%' ";
            ifDES_MAC = index++;
        }
        if (!"".equals(strMDL_MAC)) {
            vWhere += " AND UPPER(a.mdl_mac) LIKE ?||'%' ";
            ifMDL_MAC = index++;
        }
        if (!"".equals(strIDE_MAC)) {
            vWhere += " AND UPPER(a.ide_mac) LIKE ?||'%' ";
            ifIDE_MAC = index++;
        }
        if ("MACCHINA".equals(NomeParent)) {
            vWhere += " AND a.cod_mac NOT IN (SELECT cod_mac FROM mac_ope_svo_tab WHERE  cod_ope_svo=? ) ";
            ifID_PARENT = index++;
        } else if (!"".equals(NomeParent)) {
            vWhere += " AND a.cod_mac NOT IN (SELECT cod_mac FROM mac_luo_fsc_tab WHERE  cod_luo_fsc=? ) ";
            ifID_PARENT = index++;
        }

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select a.ide_mac, a.des_mac, a.mdl_mac, a.cod_tpl_mac, a.cod_mac, b.des_tpl_mac from ana_mac_tab a, tpl_mac_tab b WHERE a.cod_azl=? AND a.cod_tpl_mac=b.cod_tpl_mac " + vWhere + vOrder);
            ps.setLong(1, lCOD_AZL);
            if (ifCOD_TPL_MAC != 0) {
                ps.setLong(ifCOD_TPL_MAC, lCOD_TPL_MAC);
            }
            if (ifDES_MAC != 0) {
                ps.setString(ifDES_MAC, strDES_MAC.toUpperCase());
            }
            if (ifMDL_MAC != 0) {
                ps.setString(ifMDL_MAC, strMDL_MAC.toUpperCase());
            }
            if (ifIDE_MAC != 0) {
                ps.setString(ifIDE_MAC, strIDE_MAC.toUpperCase());
            }
            if (ifID_PARENT != 0) {
                ps.setLong(ifID_PARENT, lID_PARENT);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchineAttrezzatureAll_View obj = new MacchineAttrezzatureAll_View();
                obj.strIDE_MAC = rs.getString(1);
                obj.strDES_MAC = rs.getString(2);
                obj.strMDL_MAC = rs.getString(3);
                obj.lCOD_TPL_MAC = rs.getLong(4);
                obj.lCOD_MAC = rs.getLong(5);
                obj.strDIT_CST_MAC = rs.getString(6);
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

//-----------------------------
    public void ejbaddRSO_OPE_SVO(long ID_PARENT, long COD_AZL, long newCOD_MAC) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_TPL;
        try {
            conn.setAutoCommit(false);
            //------------------------
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO mac_ope_svo_tab  (cod_mac, cod_ope_svo) VALUES(?,?)");
            ps.setLong(1, newCOD_MAC);
            ps.setLong(2, ID_PARENT);
            ps.executeUpdate();
            ps.clearParameters();
            //------------------------
            // associated risks ---
            ps = bmp.prepareStatement(
                    "SELECT a.cod_rso, b.tpl_clf_rso "
                    + "FROM   rso_mac_tab b, ana_rso_tab a "
                    + "WHERE  a.cod_rso=b.cod_rso AND a.cod_azl=b.cod_azl AND b.cod_mac = ? "
                    + " AND (b.tpl_clf_rso=\'O\' OR  b.tpl_clf_rso=\'O/T\')");
            ps.setLong(1, newCOD_MAC);
            REC_TPL = ps.executeQuery();
            while (REC_TPL.next()) {
                //--proverka na cod_rso, uzhe suschestvuyuschiy v rso_ope_svo_tab
                //--esli est' - idem na sleduyuschiy shag zikla
                ps = bmp.prepareStatement("select * from rso_ope_svo_tab where cod_azl=? and cod_rso=? and cod_ope_svo=?");
                ps.setLong(1, COD_AZL);
                ps.setLong(2, REC_TPL.getLong(1));
                ps.setLong(3, ID_PARENT);
                ResultSet rs1 = ps.executeQuery();
                if (rs1.next()) {
                    continue;
                }
                //--------------------------------------------------------------
                ps = bmp.prepareStatement(
                        "INSERT INTO rso_ope_svo_tab (cod_ope_svo, cod_rso, cod_azl) VALUES (?,?,?) ");
                ps.setLong(1, ID_PARENT);
                ps.setLong(2, REC_TPL.getLong(1));
                ps.setLong(3, COD_AZL);
                ps.executeUpdate();
                ps.clearParameters();
            }
            REC_TPL.close();
            conn.commit();
        } catch (Exception ex) {
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
            }
        }
    }
//-----

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    public void ejbaddRischioAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO mac_luo_fsc_tab (dat_mac_luo, cod_mac, cod_luo_fsc) "
                    + "VALUES(current_date ,?,?)");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lID_PARENT);
            if (ps.executeUpdate() != 0) {
                // -- adding of associations --
                addLuogoFisiciAssociations(lID_PARENT, lCOD_AZL, lCOD_MAC);
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//

    private void addLuogoFisiciAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_MAC) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_DPI, REC_COR, REC_PRO_SAN;
        long CODICE = NEW_ID();
        //---
        String NOM_RIL_RSO = "";
        long PRB_EVE_LES = 0;
        long ENT_DAN = 0;
        long STM_NUM_RSO = 0;
        java.sql.Date DAT_RIL = null;
        int RFC_VLU_RSO_MES = 0;
        long lCOD_RSO = 0;
        long CODICE_DELTA = 1;
        //---
        java.util.Date dt = new java.util.Date();
        java.sql.Date DATE = new java.sql.Date(dt.getTime());
        long lCUR_DATE = DATE.getTime();
        java.sql.Date SUM_DAT = new java.sql.Date(0L);
        //---
        try {
            conn.setAutoCommit(false);
            //---------------REC_DPI-----------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_tpl_dpi FROM dpi_rso_tab a, rso_mac_tab b "
                    + "WHERE a.cod_rso = b.cod_rso AND b.cod_mac = ? ");
            ps.setLong(1, lCOD_MAC);
            REC_DPI = ps.executeQuery();
            ps.clearParameters();

            //---------------REC_COR------------------
            ps = bmp.prepareStatement(
                    "SELECT a.cod_cor FROM cor_rso_tab a, rso_mac_tab b "
                    + "WHERE a.cod_rso = b.cod_rso AND b.cod_mac = ? ");
            ps.setLong(1, lCOD_MAC);
            REC_COR = ps.executeQuery();
            ps.clearParameters();

            //---------------REC_PRO_SAN------------------
            ps = bmp.prepareStatement(
                    "SELECT a.cod_pro_san FROM pro_san_rso_tab a, rso_mac_tab b "
                    + "WHERE a.cod_rso = b.cod_rso AND b.cod_mac = ? ");
            ps.setLong(1, lCOD_MAC);
            REC_PRO_SAN = ps.executeQuery();
            ps.clearParameters();

            //----------------RS (rischi)--------------
            ps = bmp.prepareStatement(
                    "SELECT a.nom_ril_rso, a.prb_eve_les, a.ent_dan, "
                    + "a.stm_num_rso, a.dat_ril, a.rfc_vlu_rso_mes, a.cod_rso "
                    + "FROM ana_rso_tab a, rso_mac_tab b "
                    + "WHERE (a.cod_rso = b.cod_rso AND b.cod_mac = ?) ");
            ps.setLong(1, lCOD_MAC);
            ResultSet rs = ps.executeQuery();
            ps.clearParameters();
            //----------------------------------
            long DT;
            while (rs.next()) {
                //----------------------------
                ps = bmp.prepareStatement("select * from rso_luo_fsc_tab where cod_rso=? and cod_luo_fsc=?");
                ps.setLong(1, rs.getLong(7));
                ps.setLong(2, lID_PARENT);
                ResultSet rs_test = ps.executeQuery();
                ps.clearParameters();
                if (rs_test.next()) {
                    continue;
                }
                //------------------------------
                NOM_RIL_RSO = rs.getString(1);
                PRB_EVE_LES = rs.getLong(2);
                ENT_DAN = rs.getLong(3);
                STM_NUM_RSO = rs.getLong(4);
                DAT_RIL = rs.getDate(5);
                RFC_VLU_RSO_MES = rs.getInt(6);
                lCOD_RSO = rs.getLong(7);
                //---------------------------------------------
                ps = bmp.prepareStatement(
                        "INSERT INTO rso_luo_fsc_tab "
                        + "(cod_rso_luo_fsc, "
                        + "cod_luo_fsc, "
                        + "cod_rso, "
                        + "cod_azl, "
                        + "prs_rso, "
                        + "dat_inz, "
                        + "dat_fie, "
                        + "nom_ril_rso, "
                        + "clf_rso, "
                        + "prb_eve_les, "
                        + "ent_dan, "
                        + "stm_num_rso, "
                        + "dat_rfc_vlu_rso, "
                        + "sta_rso) "
                        + "VALUES( ?, ?, ?, ?, 'S', ?, NULL, ?, 'PER TUTTI', ?, ?, ?, ?, 'V')");
                ps.setLong(1, CODICE + CODICE_DELTA);
                ps.setLong(2, lID_PARENT);
                ps.setLong(3, lCOD_RSO);
                ps.setLong(4, lCOD_AZL);
                ps.setDate(5, DATE);
                ps.setString(6, NOM_RIL_RSO);
                ps.setLong(7, PRB_EVE_LES);
                ps.setLong(8, ENT_DAN);
                ps.setLong(9, STM_NUM_RSO);
                //
                java.sql.Date S_DAT = new java.sql.Date(lCUR_DATE);
                S_DAT.setMonth(DATE.getMonth() + RFC_VLU_RSO_MES);
                ps.setDate(10, S_DAT);
                //
                ps.executeUpdate();
                ps.clearParameters();
                //---
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false)) {
                    while (REC_DPI.next()) {
                        //-----------------------------------------------
                        ps = bmp.prepareStatement("select * from dpi_luo_fsc_tab where cod_tpl_dpi=? and cod_luo_fsc=?");
                        ps.setLong(1, REC_DPI.getLong(1));
                        ps.setLong(2, lID_PARENT);
                        ResultSet rs_test2 = ps.executeQuery();
                        ps.clearParameters();
                        if (rs_test2.next()) {
                            continue;
                        }
                        //------------------------------------------------
                        ps = bmp.prepareStatement(
                                "INSERT INTO dpi_luo_fsc_tab (cod_luo_fsc, cod_tpl_dpi, prs_dpi, dat_inz, "
                                + "dat_fie) VALUES( ?, ?, 'S', ?, NULL) ");
                        ps.setLong(1, lID_PARENT);
                        ps.setLong(2, REC_DPI.getLong(1));
                        ps.setDate(3, DATE);
                        ps.executeUpdate();
                        ps.clearParameters();
                    }
                }
                //---
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false)) {
                    while (REC_COR.next()) {
                        //-----------------------------------------------
                        ps = bmp.prepareStatement("select * from cor_luo_fsc_tab where cod_cor=? and cod_luo_fsc=?");
                        ps.setLong(1, REC_COR.getLong(1));
                        ps.setLong(2, lID_PARENT);
                        ResultSet rs_test2 = ps.executeQuery();
                        ps.clearParameters();
                        if (rs_test2.next()) {
                            continue;
                        }
                        //------------------------------------------------
                        ps = bmp.prepareStatement(
                                "INSERT INTO cor_luo_fsc_tab "
                                + "(cod_luo_fsc, cod_cor, prs_cor, dat_inz, dat_fie) "
                                + "VALUES( ?, ?, 'S', ?, NULL) ");
                        ps.setLong(1, lID_PARENT);
                        ps.setLong(2, REC_COR.getLong(1));
                        ps.setDate(3, DATE);
                        ps.executeUpdate();
                        ps.clearParameters();
                    }
                }
                //---
                if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false)) {
                    while (REC_PRO_SAN.next()) {
                        //-----------------------------------------------
                        ps = bmp.prepareStatement("select * from pro_san_luo_fsc_tab where cod_pro_san=? and cod_luo_fsc=?");
                        ps.setLong(1, REC_PRO_SAN.getLong(1));
                        ps.setLong(2, lID_PARENT);
                        ResultSet rs_test2 = ps.executeQuery();
                        ps.clearParameters();
                        if (rs_test2.next()) {
                            continue;
                        }
                        //------------------------------------------------
                        ps = bmp.prepareStatement(
                                "INSERT INTO pro_san_luo_fsc_tab "
                                + "(cod_luo_fsc, cod_pro_san, prs_pro_san, dat_inz, dat_fie) "
                                + "VALUES( ?, ?, 'S', ?, NULL) ");
                        ps.setLong(1, lID_PARENT);
                        ps.setLong(2, REC_PRO_SAN.getLong(1));
                        ps.setDate(3, DATE);
                        ps.executeUpdate();
                        ps.clearParameters();
                    }
                }
                CODICE_DELTA++;
            }
            //---------------------------------
            rs.close();
            conn.commit();
        } catch (Exception ex) {
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
            }
        }

    }//------- end of ejbaddRischioAssociations(..)
//++++++++++++++++++++++++++++++++++++++++++++++++++++
    //--- mary for search

    public Collection findEx(
            long lCOD_AZL,
            String strIDE_MAC,
            String strDES_MAC,
            String strMDL_MAC,
            String strDIT_CST_MAC,
            String strFBR_MAC,
            Long lYEA_CST_MAC,
            String strTAR_MAC,
            String strPPO_MAC,
            String strMRC_MAC,
            Long lPRT_MAC,
            String strCAT_MAC,
            String strPRE_MAC,
            Long lCOD_TPL_MAC,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(lCOD_AZL, strIDE_MAC, strDES_MAC, strMDL_MAC, strDIT_CST_MAC, strFBR_MAC, lYEA_CST_MAC, strTAR_MAC, strPPO_MAC, strMRC_MAC, lPRT_MAC, strCAT_MAC, strPRE_MAC, lCOD_TPL_MAC, iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strIDE_MAC,
            String strDES_MAC,
            String strMDL_MAC,
            String strDIT_CST_MAC,
            String strFBR_MAC,
            Long lYEA_CST_MAC,
            String strTAR_MAC,
            String strPPO_MAC,
            String strMRC_MAC,
            Long lPRT_MAC,
            String strCAT_MAC,
            String strPRE_MAC,
            Long lCOD_TPL_MAC,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT ide_mac, des_mac, mdl_mac, dit_cst_mac, fbr_mac, cod_tpl_mac, cod_azl, cod_mac, yea_cst_mac, tar_mac, ppo_mac, mrc_mac,  prt_mac ,cat_mac,pre_mac FROM ana_mac_tab WHERE cod_azl=?   ";
        if (strIDE_MAC != null) {
            strSql += " AND UPPER(ide_mac) LIKE ? ";
        }
        if (strDES_MAC != null) {
            strSql += " AND UPPER(des_mac) LIKE ? ";
        }
        if (strMDL_MAC != null) {
            strSql += " AND UPPER(mdl_mac) LIKE ? ";
        }
        if (strDIT_CST_MAC != null) {
            strSql += " AND UPPER(dit_cst_mac) LIKE ? ";
        }
        if (strFBR_MAC != null) {
            strSql += " AND UPPER(fbr_mac) LIKE ? ";
        }
        if (lYEA_CST_MAC != null) {
            strSql += " AND yea_cst_mac = ? ";
        }
        if (strTAR_MAC != null) {
            strSql += " AND UPPER(tar_mac) LIKE ? ";
        }
        if (strPPO_MAC != null) {
            strSql += " AND UPPER(ppo_mac) LIKE ? ";
        }
        if (strMRC_MAC != null) {
            strSql += " AND UPPER(mrc_mac) LIKE ? ";
        }
        if (lPRT_MAC != null) {
            strSql += " AND prt_mac = ? ";
        }
        if (strCAT_MAC != null) {
            strSql += " AND UPPER(cat_mac) LIKE ? ";
        }
        if (strPRE_MAC != null) {
            strSql += " AND UPPER(pre_mac) LIKE ? ";
        }
        if (lCOD_TPL_MAC != null) {
            strSql += " AND cod_tpl_mac = ? ";
        }

        strSql += " ORDER BY UPPER(des_mac)";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strIDE_MAC != null) {
                ps.setString(i++, strIDE_MAC.toUpperCase());
            }
            if (strDES_MAC != null) {
                ps.setString(i++, strDES_MAC.toUpperCase());
            }
            if (strMDL_MAC != null) {
                ps.setString(i++, strMDL_MAC.toUpperCase());
            }
            if (strDIT_CST_MAC != null) {
                ps.setString(i++, strDIT_CST_MAC.toUpperCase());
            }
            if (strFBR_MAC != null) {
                ps.setString(i++, strFBR_MAC.toUpperCase());
            }
            if (lYEA_CST_MAC != null) {
                ps.setLong(i++, lYEA_CST_MAC.longValue());
            }
            if (strTAR_MAC != null) {
                ps.setString(i++, strTAR_MAC.toUpperCase());
            }
            if (strPPO_MAC != null) {
                ps.setString(i++, strPPO_MAC.toUpperCase());
            }
            if (strMRC_MAC != null) {
                ps.setString(i++, strMRC_MAC.toUpperCase());
            }
            if (lPRT_MAC != null) {
                ps.setLong(i++, lPRT_MAC.longValue());
            }
            if (strCAT_MAC != null) {
                ps.setString(i++, strCAT_MAC.toUpperCase());
            }
            if (strPRE_MAC != null) {
                ps.setString(i++, strPRE_MAC.toUpperCase());
            }
            if (lCOD_TPL_MAC != null) {
                ps.setLong(i++, lCOD_TPL_MAC.longValue());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                MacchineAttrezzatureAll_View obj = new MacchineAttrezzatureAll_View();
                obj.strIDE_MAC = rs.getString(1);     	//1
                obj.strDES_MAC = rs.getString(2); 		//2
                obj.strMDL_MAC = rs.getString(3);       //3
                obj.strDIT_CST_MAC = rs.getString(4);   //4
                obj.strFBR_MAC = rs.getString(5);       //5
                obj.lCOD_TPL_MAC = rs.getLong(6);     //6
                obj.lCOD_AZL = rs.getLong(7);   	    //7
                obj.lCOD_MAC = rs.getLong(8);    		//8
                //----------------------//
                obj.lYEA_CST_MAC = rs.getLong(9); 	//9
                obj.strTAR_MAC = rs.getString(10);		//10
                obj.strPPO_MAC = rs.getString(11);		//11
                obj.strMRC_MAC = rs.getString(12);		//12
                obj.lPRT_MAC = rs.getLong(13);		//13
                obj.strCAT_MAC = rs.getString(14);		//14
                obj.strPRE_MAC = rs.getString(15);		//15
                ar.add(obj);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }

    //<alex date="31/03/2004">
    public Collection ejbGetCARICA_LUOGHI_FISICI_View(long lCOD_MAC, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "a.cod_luo_fsc, "
                        + "a.nom_luo_fsc "
                    + "from "
                        + "ana_luo_fsc_tab a, "
                        + "mac_luo_fsc_tab b "
                    + "where "
                        + "b.cod_mac=? "
                        + "and a.cod_luo_fsc = b.cod_luo_fsc "
                        + "and a.cod_azl=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Macchina_LuoghiFisiciView obj = new Macchina_LuoghiFisiciView();
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

    public Collection ejbGetCARICA_ATTIVITA_View(long lCOD_MAC, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_man, nom_man from  ana_man_tab where cod_man in (select distinct a.cod_man from ope_svo_man_tab a, mac_ope_svo_tab b, ana_mac_tab c where a.cod_ope_svo=b.cod_ope_svo and b.cod_mac=c.cod_mac and c.cod_mac=?) and cod_azl=?");
            ps.setLong(1, lCOD_MAC);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MacchinaAttivitaLavorative_View obj = new MacchinaAttivitaLavorative_View();
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

    public int ejbGetCountAttivitaForMacchina(long lCOD_MAC, long lCOD_AZL) {
        return ejbGetCARICA_ATTIVITA_View(lCOD_MAC, lCOD_AZL).size();
    }

    public int ejbGetCountLuoghiForMacchina(long lCOD_MAC, long lCOD_AZL) {
        return ejbGetCARICA_LUOGHI_FISICI_View(lCOD_MAC, lCOD_AZL).size();
    }
    //</alex>
}
