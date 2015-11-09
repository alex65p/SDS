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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.NonConformita;

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
public class NonConformitaBean extends BMPEntityBean implements INonConformita, INonConformitaHome {

    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">
    String DES_NON_CFO;    	//1
    java.sql.Date DAT_RIL_NON_CFO; 			//2
    String NOM_RIL_NON_CFO;	//3
    long COD_AZL;     	//4
    long COD_NON_CFO;    //5
    //----------------------------
    String OSS_NON_CFO;     			 		//6
    long COD_INR_ADT;     	         	//7
    public static final String BEAN_NAME = "NonConformitaBean";
    //long 	 COD_MIS_PET;            		//5
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static NonConformitaBean ys = null;

    private NonConformitaBean() {
        //
    }

    public static NonConformitaBean getInstance() {
        if (ys == null) {
            ys = new NonConformitaBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public INonConformita create(String strDES_NON_CFO, java.sql.Date dtDAT_RIL_NON_CFO, String strNOM_RIL_NON_CFO, long lCOD_AZL) throws CreateException {
        NonConformitaBean bean = new NonConformitaBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_NON_CFO, dtDAT_RIL_NON_CFO, strNOM_RIL_NON_CFO, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_NON_CFO, dtDAT_RIL_NON_CFO, strNOM_RIL_NON_CFO, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        NonConformitaBean iNonConformitaBean = new NonConformitaBean();
        try {
            Object obj = iNonConformitaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iNonConformitaBean.setEntityContext(new EntityContextWrapper(obj));
            iNonConformitaBean.ejbActivate();
            iNonConformitaBean.ejbLoad();
            iNonConformitaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public INonConformita findByPrimaryKey(Long primaryKey) throws FinderException {
        NonConformitaBean bean = new NonConformitaBean();
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

    // (Home Intrface) VIEWS  getNonConformita_All_Plus_Description_View()
    //public Collection getNonConformita_Name_Address_View()
    //{
    //	return (new  NonConformitaBean()).ejbGetNonConformita_Name_Address_View();
    //}
    public Collection getNonConformita(long lCOD_AZL) {
        return (new NonConformitaBean()).ejbGetNonConformita(lCOD_AZL);
    }

    public Collection getNonConformitaByInterventoAudit(long lCOD_INR_ADT) {
        return (new NonConformitaBean()).ejbGetNonConformitaByInterventoAudit(lCOD_INR_ADT);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</INonConformitaHome-implementation>
    public Long ejbCreate(String strDES_NON_CFO, java.sql.Date dtDAT_RIL_NON_CFO, String strNOM_RIL_NON_CFO, long lCOD_AZL) {
        this.DES_NON_CFO = strDES_NON_CFO;
        this.DAT_RIL_NON_CFO = dtDAT_RIL_NON_CFO;
        this.NOM_RIL_NON_CFO = strNOM_RIL_NON_CFO;
        this.COD_AZL = lCOD_AZL;
        this.COD_NON_CFO = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_non_cfo_tab (cod_non_cfo,des_non_cfo,dat_ril_non_cfo,nom_ril_non_cfo,cod_azl ) VALUES(?,?,?,?,?)");
            ps.setLong(1, COD_NON_CFO);
            ps.setString(2, DES_NON_CFO);
            ps.setDate(3, DAT_RIL_NON_CFO);
            ps.setString(4, NOM_RIL_NON_CFO);
            ps.setLong(5, COD_AZL);
            ps.executeUpdate();
            return new Long(COD_NON_CFO);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------   
    public void ejbPostCreate(String strDES_NON_CFO, java.sql.Date dtDAT_RIL_NON_CFO, String strNOM_RIL_NON_CFO, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_non_cfo FROM ana_non_cfo_tab ");
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
        this.COD_NON_CFO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_NON_CFO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_non_cfo_tab  WHERE cod_non_cfo=?");
            ps.setLong(1, COD_NON_CFO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_NON_CFO = rs.getLong("COD_NON_CFO");
                this.DES_NON_CFO = rs.getString("DES_NON_CFO");
                this.DAT_RIL_NON_CFO = rs.getDate("DAT_RIL_NON_CFO");
                this.NOM_RIL_NON_CFO = rs.getString("NOM_RIL_NON_CFO");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.OSS_NON_CFO = rs.getString("OSS_NON_CFO");
                this.COD_INR_ADT = rs.getLong("COD_INR_ADT");
            } else {
                throw new NoSuchEntityException("NonConformita con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_non_cfo_tab  WHERE cod_non_cfo=?");
            ps.setLong(1, COD_NON_CFO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("NonConformita con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_non_cfo_tab  SET des_non_cfo=?, dat_ril_non_cfo=?, nom_ril_non_cfo=?, oss_non_cfo=?, cod_inr_adt=?, cod_azl=? WHERE cod_non_cfo=?");
            ps.setString(1, DES_NON_CFO);
            ps.setDate(2, DAT_RIL_NON_CFO);
            ps.setString(3, NOM_RIL_NON_CFO);
            ps.setString(4, OSS_NON_CFO);
            if (COD_INR_ADT == 0) {
                ps.setNull(5, java.sql.Types.BIGINT);
            } else {
                ps.setLong(5, COD_INR_ADT);
            }
            ps.setLong(6, COD_AZL);
            ps.setLong(7, COD_NON_CFO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("NonConformita con ID= non è trovata");
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
    public long getCOD_NON_CFO() {
        return COD_NON_CFO;
    }

    //2
    public void setDES_NON_CFO(String newDES_NON_CFO) {
        if (DES_NON_CFO.equals(newDES_NON_CFO)) {
            return;
        }
        DES_NON_CFO = newDES_NON_CFO;
        setModified();
    }

    public String getDES_NON_CFO() {
        return DES_NON_CFO;
    }

    //3
    public void setDAT_RIL_NON_CFO(java.sql.Date newDAT_RIL_NON_CFO) {
        if (DAT_RIL_NON_CFO.equals(newDAT_RIL_NON_CFO)) {
            return;
        }
        DAT_RIL_NON_CFO = newDAT_RIL_NON_CFO;
        setModified();
    }

    public java.sql.Date getDAT_RIL_NON_CFO() {
        return DAT_RIL_NON_CFO;
    }

    //4
    public void setNOM_RIL_NON_CFO(String newNOM_RIL_NON_CFO) {
        if (NOM_RIL_NON_CFO.equals(newNOM_RIL_NON_CFO)) {
            return;
        }
        NOM_RIL_NON_CFO = newNOM_RIL_NON_CFO;
        setModified();
    }

    public String getNOM_RIL_NON_CFO() {
        return NOM_RIL_NON_CFO;
    }

    //5
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
    //6
    public void setOSS_NON_CFO(String newOSS_NON_CFO) {
        if (OSS_NON_CFO != null) {
            if (OSS_NON_CFO.equals(newOSS_NON_CFO)) {
                return;
            }
        }
        OSS_NON_CFO = newOSS_NON_CFO;
        setModified();
    }

    public String getOSS_NON_CFO() {
        if (OSS_NON_CFO == null) {
            return "";
        }
        return OSS_NON_CFO;
    }

    //7
    public void setCOD_INR_ADT(long newCOD_INR_ADT) {
        // if(COD_INR_ADT<*>=null){
        //if( COD_INR_ADT.equals(newCOD_INR_ADT) ) return;
        // }
        COD_INR_ADT = newCOD_INR_ADT;
        setModified();
    }

    public long getCOD_INR_ADT() {
        //if (COD_INR_ADT==null) return "";
        return COD_INR_ADT;
    }

    public Collection ejbGetNonConformitaByInterventoAudit(long lCOD_INR_ADT) {
        BMPConnection bmp = getConnection();
        try {
//          PreparedStatement ps=bmp.prepareStatement("select a.cod_non_cfo, a.des_non_cfo,a.cod_mis_pet, dat_ril_non_cfo,a.nom_ril_non_cfo,a.cod_inr_adt, a.oss_non_cfo, b.des_inr_adt from ana_non_cfo_tab a left outer join ana_inr_adt_tab b on a.cod_inr_adt = b.cod_inr_adt where   a.cod_inr_adt = ?  ");
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getEjbGetNonConformitaByInterventoAudit());
            ps.setLong(1, lCOD_INR_ADT);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NonConformitaAllView obj = new NonConformitaAllView();
                obj.lCOD_NON_CFO = rs.getLong(1);
                obj.strDES_NON_CFO = rs.getString(2);
                obj.lCOD_MIS_PET = rs.getLong(3);
                obj.dtDAT_RIL_NON_CFO = rs.getDate(4);
                obj.strNOM_RIL_NON_CFO = rs.getString(5);
                obj.lCOD_INR_ADT = rs.getLong(6);
                obj.strOSS_NON_CFO = rs.getString(7);
                obj.strDES_INR_ADT = rs.getString(8);
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

    public Collection ejbGetNonConformita(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
//          PreparedStatement ps=bmp.prepareStatement("select a.cod_non_cfo, a.des_non_cfo,a.cod_mis_pet, dat_ril_non_cfo,a.nom_ril_non_cfo,a.cod_inr_adt, a.oss_non_cfo, b.des_inr_adt from ana_non_cfo_tab a left outer join ana_inr_adt_tab b on a.cod_inr_adt = b.cod_inr_adt where   a.cod_azl = ?  ");
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getEjbGetNonConformita());
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NonConformitaAllView obj = new NonConformitaAllView();
                obj.lCOD_NON_CFO = rs.getLong(1);
                obj.strDES_NON_CFO = rs.getString(2);
                obj.lCOD_MIS_PET = rs.getLong(3);
                obj.dtDAT_RIL_NON_CFO = rs.getDate(4);
                obj.strNOM_RIL_NON_CFO = rs.getString(5);
                obj.lCOD_INR_ADT = rs.getLong(6);
                obj.strOSS_NON_CFO = rs.getString(7);
                obj.strDES_INR_ADT = rs.getString(8);
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

   //<comment description="extended setters/getters">
  /* public Collection ejbGetNonConformita_All_Plus_Description_View(){
     BMPConnection bmp=getConnection();
     try{
     PreparedStatement ps=bmp.prepareStatement("SELECT cod_ope_svo,non_ope_svo,des_ope_svo FROM ana_ope_svo_tab ");
     ResultSet rs=ps.executeQuery();
     java.util.ArrayList al=new java.util.ArrayList();
     while(rs.next()){
     NonConformita_All_Plus_Description_View obj=new NNonConformita_All_Plus_Description_View();
     obj.COD_OPE_SVO=rs.getLong(1);
     obj.NON_OPE_SVO=rs.getString(2);
     obj.DES_OPE_SVO=rs.getString(3);
     al.add(obj);
     }
     bmp.close();
     return al;
     }
     catch(Exception ex){
     throw new EJBException(ex);
     }
     finally{bmp.close();}
     }*/
    //-------------------
    //</comment>         
    //--- mary for search
    public Collection findEx(
            String strDES_NON_CFO,
            String strOSS_NON_CFO,
            java.sql.Date dtDAT_RIL_NON_CFO,
            String strNOM_RIL_NON_CFO,
            Long lCOD_INR_ADT,
            int iOrderParameter //not used for now
    ) {
        return ejbFindEx(strDES_NON_CFO, strOSS_NON_CFO, dtDAT_RIL_NON_CFO, strNOM_RIL_NON_CFO, lCOD_INR_ADT, iOrderParameter);
    }

    public Collection ejbFindEx(
            String strDES_NON_CFO,
            String strOSS_NON_CFO,
            java.sql.Date dtDAT_RIL_NON_CFO,
            String strNOM_RIL_NON_CFO,
            Long lCOD_INR_ADT,
            int iOrderParameter //not used for now
    ) {
        String strSql = "SELECT cod_non_cfo, des_non_cfo, dat_ril_non_cfo, cod_mis_pet, nom_ril_non_cfo, cod_inr_adt,  oss_non_cfo FROM ana_non_cfo_tab ";

        String strWhere = "";

        if (strDES_NON_CFO != null) {
            strWhere += " AND UPPER(des_non_cfo) LIKE ?";
        }
        if (strOSS_NON_CFO != null) {
            strWhere += " AND UPPER(oss_non_cfo) LIKE ?";
        }
        if (dtDAT_RIL_NON_CFO != null) {
            strWhere += " AND dat_ril_non_cfo=? ";
        }
        if (strNOM_RIL_NON_CFO != null) {
            strWhere += " AND UPPER(nom_ril_non_cfo) LIKE ?";
        }
        if (lCOD_INR_ADT != null) {
            strWhere += " AND cod_inr_adt=? ";
        }

        if (!strWhere.equals("")) {
            strWhere = " WHERE " + strWhere.substring(5, strWhere.length());
        }

        strSql = strSql + strWhere + " ORDER BY UPPER(des_non_cfo)";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);

            if (strDES_NON_CFO != null) {
                ps.setString(i++, strDES_NON_CFO.toUpperCase());
            }
            if (strOSS_NON_CFO != null) {
                ps.setString(i++, strOSS_NON_CFO.toUpperCase());
            }
            if (dtDAT_RIL_NON_CFO != null) {
                ps.setDate(i++, dtDAT_RIL_NON_CFO);
            }
            if (strNOM_RIL_NON_CFO != null) {
                ps.setString(i++, strNOM_RIL_NON_CFO.toUpperCase());
            }
            if (lCOD_INR_ADT != null) {
                ps.setLong(i++, lCOD_INR_ADT.longValue());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                NonConformitaAllView obj = new NonConformitaAllView();
                obj.lCOD_NON_CFO = rs.getLong(1);
                obj.strDES_NON_CFO = rs.getString(2);
                obj.dtDAT_RIL_NON_CFO = rs.getDate(3);
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
///////////ATTENTION!!////////////////////////////////////////
}
