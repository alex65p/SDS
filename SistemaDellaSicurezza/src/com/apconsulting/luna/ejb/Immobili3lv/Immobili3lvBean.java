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
package com.apconsulting.luna.ejb.Immobili3lv;

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
 * @author Dario
 */
public class Immobili3lvBean extends BMPEntityBean implements IImmobili3lv, IImmobili3lvHome {

    long COD_IMM;
    long COD_SIT_AZL;
    String NOM_IMM;
    //------------------------
    String DES_IMM;
    String IND_IMM;
    String NUM_CIV_IMM;
    String CIT_IMM;
    String PRO_IMM;
    String CAP_IMM;

    private static Immobili3lvBean ys = null;

    private Immobili3lvBean() {
        //
    }

    public static Immobili3lvBean getInstance() {
        if (ys == null) {
            ys = new Immobili3lvBean();
        }
        return ys;
    }

    // (Home Interface) create()
    public IImmobili3lv create(long lCOD_AZL, long lCOD_SIT_AZ, String strNOM_IMM) throws CreateException {
        Immobili3lvBean bean = new Immobili3lvBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, lCOD_SIT_AZ, strNOM_IMM);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, lCOD_SIT_AZ, strNOM_IMM);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        Immobili3lvBean iImmobiliBean = new Immobili3lvBean();
        try {
            Object obj = iImmobiliBean.ejbFindByPrimaryKey((Long) primaryKey);
            iImmobiliBean.setEntityContext(new EntityContextWrapper(obj));
            iImmobiliBean.ejbActivate();
            iImmobiliBean.ejbLoad();
            iImmobiliBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()

    public IImmobili3lv findByPrimaryKey(Long primaryKey) throws FinderException {
        Immobili3lvBean bean = new Immobili3lvBean();
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

    public Long ejbCreate(long lCOD_AZL, long lCOD_SIT_AZ, String strNOM_IMM) {
        this.COD_IMM = NEW_ID();
        this.COD_SIT_AZL = lCOD_SIT_AZ;
        this.NOM_IMM = strNOM_IMM;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_imm_tab "
                        + "(cod_imm, "
                        + "cod_sit_azl, "
                        + "nom_imm, "
                        + "cod_azl) "
                    + "VALUES"
                        + "(?,?,?,?)");
            ps.setLong(1, COD_IMM);
            ps.setLong(2, COD_SIT_AZL);
            ps.setString(3, NOM_IMM);
            ps.setLong(4, lCOD_AZL);
            ps.executeUpdate();
            return new Long(COD_IMM);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_AZL, long lCOD_SIT_AZ, String strNOM_IMM) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_imm FROM ana_imm_tab ");
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
        this.COD_IMM = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_IMM = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_imm_tab  WHERE cod_imm=?");
            ps.setLong(1, COD_IMM);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_IMM = rs.getLong("COD_IMM");
                this.NOM_IMM = rs.getString("NOM_IMM");
                this.DES_IMM = rs.getString("DES_IMM");
                this.COD_SIT_AZL = rs.getLong("COD_SIT_AZL");
                this.IND_IMM = rs.getString("IND_IMM");
                this.NUM_CIV_IMM = rs.getString("NUM_CIV_IMM");
                this.CIT_IMM = rs.getString("CIT_IMM");
                this.PRO_IMM = rs.getString("PRO_IMM");
                this.CAP_IMM = rs.getString("CAP_IMM");
            } else {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_imm_tab WHERE cod_imm=?");
            ps.setLong(1, COD_IMM);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE ana_imm_tab SET "
                        + "cod_imm=?, "
                        + "nom_imm=?, "
                        + "des_imm=?, "
                        + "cod_sit_azl=?, "
                        + "ind_imm=?, "
                        + "num_civ_imm=?, "
                        + "cit_imm=?, "
                        + "pro_imm=?, "
                        + "cap_imm=? "
                    + "WHERE "
                        + "cod_imm=?");
            ps.setLong(1, COD_IMM);
            ps.setString(2, NOM_IMM);
            ps.setString(3, DES_IMM);
            ps.setLong(4, COD_SIT_AZL);
            ps.setString(5, IND_IMM);
            ps.setString(6, NUM_CIV_IMM);
            ps.setString(7, CIT_IMM);
            ps.setString(8, PRO_IMM);
            ps.setString(9, CAP_IMM);
            ps.setLong(10, COD_IMM);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
//<comment description="Update Method">
    public void Update() {
        setModified();
    }
//<comment

//<comment description="setter/getters">
    //1
    public long getCOD_IMM() {
        return COD_IMM;
    }
    //2

    public void setNOM_IMM(String newNOM_IMM) {
        if (NOM_IMM.equals(newNOM_IMM)) {
            return;
        }
        NOM_IMM = newNOM_IMM;
        setModified();
    }

    public String getNOM_IMM() {
        return NOM_IMM;
    }
    //============================================
    // not required field
    //3

    public void setDES_IMM(String newDES_IMM) {
        if (DES_IMM != null) {
            if (DES_IMM.equals(newDES_IMM)) {
                return;
            }
        }
        DES_IMM = newDES_IMM;
        setModified();
    }

    public String getDES_IMM() {
        if (DES_IMM == null) {
            return "";
        }
        return DES_IMM;
    }

    public long getCOD_SIT_AZL() {
        return COD_SIT_AZL;
    }

    public void setCOD_SIT_AZL(long newCOD_SIT_AZL) {
        if (COD_SIT_AZL == newCOD_SIT_AZL) {
            return;
        }
        COD_SIT_AZL = newCOD_SIT_AZL;
        setModified();
    }
    
    public String getIND_IMM(){
        if (IND_IMM == null) {
            return "";
        }
        return IND_IMM;
    }

    public void setIND_IMM(String newIND_IMM){
        if (IND_IMM != null) {
            if (IND_IMM.equals(newIND_IMM)) {
                return;
            }
        }
        IND_IMM = newIND_IMM;
        setModified();
    }
    
    public String getNUM_CIV_IMM(){
        if (NUM_CIV_IMM == null) {
            return "";
        }
        return NUM_CIV_IMM;
    }

    public void setNUM_CIV_IMM(String newNUM_CIV_IMM){
        if (NUM_CIV_IMM != null) {
            if (NUM_CIV_IMM.equals(newNUM_CIV_IMM)) {
                return;
            }
        }
        NUM_CIV_IMM = newNUM_CIV_IMM;
        setModified();
    }
    
    public String getCIT_IMM(){
        if (CIT_IMM == null) {
            return "";
        }
        return CIT_IMM;
    }

    public void setCIT_IMM(String newCIT_IMM){
        if (CIT_IMM != null) {
            if (CIT_IMM.equals(newCIT_IMM)) {
                return;
            }
        }
        CIT_IMM = newCIT_IMM;
        setModified();
    }
    
    public String getPRO_IMM(){
        if (PRO_IMM == null) {
            return "";
        }
        return PRO_IMM;
    }

    public void setPRO_IMM(String newPRO_IMM){
        if (PRO_IMM != null) {
            if (PRO_IMM.equals(newPRO_IMM)) {
                return;
            }
        }
        PRO_IMM = newPRO_IMM;
        setModified();
    }
    
    public String getCAP_IMM(){
        if (CAP_IMM == null) {
            return "";
        }
        return CAP_IMM;
    }

    public void setCAP_IMM(String newCAP_IMM){
        if (CAP_IMM != null) {
            if (CAP_IMM.equals(newCAP_IMM)) {
                return;
            }
        }
        CAP_IMM = newCAP_IMM;
        setModified();
    }
    
    //</comment>

    //-------------------

    public Collection findEx
            (long lCOD_AZL, Long lCOD_SIT_AZL, String strNOM_IMM, 
            String strDES_IMM, String strIND_IMM, String strNUM_CIV_IMM, 
            String strCIT_IMM, String strPRO_IMM, String strCAP_IMM,
            int iOrderParameter) {
        return ejbFindEx
                (lCOD_AZL, lCOD_SIT_AZL, strNOM_IMM, strDES_IMM, 
                strIND_IMM, strNUM_CIV_IMM, strCIT_IMM, strPRO_IMM, strCAP_IMM,
                iOrderParameter);
    }

    public Collection ejbFindEx
            (long lCOD_AZL, Long lCOD_SIT_AZL, String strNOM_IMM, 
            String strDES_IMM, String strIND_IMM, String strNUM_CIV_IMM, 
            String strCIT_IMM, String strPRO_IMM, String strCAP_IMM,
            int iOrderParameter) {
        String strSql =
                "SELECT "
                    + "imm.cod_imm, "
                    + "UPPER(imm.nom_imm) AS nom_imm, "
                    + "imm.des_imm, "
                    + "sit_azl.nom_sit_azl, "
                    + "UPPER(imm.ind_imm) AS ind_imm, "
                    + "UPPER(imm.num_civ_imm) AS num_civ_imm, "
                    + "UPPER(imm.cit_imm) AS cit_imm, "
                    + "UPPER(imm.pro_imm) AS pro_imm, "
                    + "UPPER(imm.cap_imm) AS cap_imm "
                + "FROM "
                    + "ana_imm_tab imm, "
                    + "ana_sit_azl_tab sit_azl "
                + "WHERE "
                    + "imm.cod_azl = sit_azl.cod_azl "
                    + "and imm.cod_sit_azl = sit_azl.cod_sit_azl "
                    + "and imm.cod_azl = ? ";

        if (strNOM_IMM != null) {
            strSql += " and UPPER(imm.nom_imm) LIKE ? ";
        }
        if (strDES_IMM != null) {
            strSql += " and UPPER (imm.des_imm) LIKE ? ";
        }
        if (lCOD_SIT_AZL != null) {
            strSql += " and imm.cod_sit_azl = ? ";
        }
        if (strIND_IMM != null) {
            strSql += " and UPPER(imm.ind_imm) LIKE ? ";
        }
        if (strNUM_CIV_IMM != null) {
            strSql += " and UPPER(imm.num_civ_imm) LIKE ? ";
        }
        if (strCIT_IMM != null) {
            strSql += " and UPPER(imm.cit_imm) LIKE ? ";
        }
        if (strPRO_IMM != null) {
            strSql += " and UPPER(imm.pro_imm) LIKE ? ";
        }
        if (strCAP_IMM != null) {
            strSql += " and UPPER(imm.cap_imm) LIKE ? ";
        }
        strSql += " ORDER BY 4,2 ";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);
            if (strNOM_IMM != null) {
                ps.setString(i++, strNOM_IMM.toUpperCase());
            }
            if (strDES_IMM != null) {
                ps.setString(i++, strDES_IMM.toUpperCase());
            }
            if (lCOD_SIT_AZL != null) {
                ps.setLong(i++, lCOD_SIT_AZL);
            }
            if (strIND_IMM != null) {
                ps.setString(i++, strIND_IMM.toUpperCase());
            }
            if (strNUM_CIV_IMM != null) {
                ps.setString(i++, strNUM_CIV_IMM.toUpperCase());
            }
            if (strCIT_IMM != null) {
                ps.setString(i++, strCIT_IMM.toUpperCase());
            }
            if (strPRO_IMM != null) {
                ps.setString(i++, strPRO_IMM.toUpperCase());
            }
            if (strCAP_IMM != null) {
                ps.setString(i++, strCAP_IMM.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Immobili3liv_View obj = new Immobili3liv_View();
                obj.COD_IMM = rs.getLong(1);
                obj.NOM_IMM = rs.getString(2);
                obj.DES_IMM = rs.getString(3);
                obj.NOM_SIT_AZL = rs.getString(4);
                obj.IND_IMM = rs.getString(5);
                obj.NUM_CIV_IMM = rs.getString(6);
                obj.CIT_IMM = rs.getString(7);
                obj.PRO_IMM = rs.getString(8);
                obj.CAP_IMM = rs.getString(9);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}
