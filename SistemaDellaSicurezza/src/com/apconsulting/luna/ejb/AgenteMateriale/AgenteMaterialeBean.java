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
package com.apconsulting.luna.ejb.AgenteMateriale;

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
public class AgenteMaterialeBean extends BMPEntityBean implements IAgenteMaterialeHome, IAgenteMateriale {

    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">
    long COD_AGE_MAT;           //1
    String NOM_AGE_MAT;         //2
    long COD_CAG_AGE_MAT;       //3
    //----------------------------

    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static AgenteMaterialeBean ys = null;

    private AgenteMaterialeBean() {
        //System.err.println("AgenteMaterialeBean constructor<br>");
    }

    public static AgenteMaterialeBean getInstance() {
        if (ys == null) {
            ys = new AgenteMaterialeBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IAgenteMateriale create(String strNOM_AGE_MAT, long lCOD_CAG_AGE_MAT) throws CreateException {
        AgenteMaterialeBean bean = new AgenteMaterialeBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_AGE_MAT, lCOD_CAG_AGE_MAT);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_AGE_MAT, lCOD_CAG_AGE_MAT);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    public void remove(Object primaryKey) {
        AgenteMaterialeBean iAgenteMaterialeBean = new AgenteMaterialeBean();
        try {
            Object obj = iAgenteMaterialeBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAgenteMaterialeBean.setEntityContext(new EntityContextWrapper(obj));
            iAgenteMaterialeBean.ejbActivate();
            iAgenteMaterialeBean.ejbLoad();
            iAgenteMaterialeBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IAgenteMateriale findByPrimaryKey(Long primaryKey) throws FinderException {
        AgenteMaterialeBean bean = new AgenteMaterialeBean();
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

    // (Home Intrface) VIEWS
    public Collection getAgenti_Materiali_View() {
        return (new AgenteMaterialeBean()).ejbGetAgenti_Materiali_View();
    }
    //

    public Collection findEx(long COD_CAG, String NOM, long iOrderBy) {
        return (new AgenteMaterialeBean()).ejbfindEx(COD_CAG, NOM, iOrderBy);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IAgenteMaterialeHome-implementation>
    public Long ejbCreate(String strNOM_AGE_MAT, long lCOD_CAG_AGE_MAT) {
        this.COD_AGE_MAT = NEW_ID();
        this.NOM_AGE_MAT = strNOM_AGE_MAT;
        this.COD_CAG_AGE_MAT = lCOD_CAG_AGE_MAT;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_age_mat_tab (cod_age_mat,nom_age_mat, cod_cag_age_mat) VALUES(?,?,?)");
            ps.setLong(1, COD_AGE_MAT);
            ps.setString(2, NOM_AGE_MAT);
            ps.setLong(3, COD_CAG_AGE_MAT);
            ps.executeUpdate();
            return new Long(COD_AGE_MAT);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_AGE_MAT, long lCOD_CAG_AGE_MAT) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_age_mat FROM ana_age_mat_tab ");
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
        this.COD_AGE_MAT = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_AGE_MAT = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_age_mat_tab  WHERE cod_age_mat=?");
            ps.setLong(1, COD_AGE_MAT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_AGE_MAT = rs.getLong("COD_AGE_MAT");
                this.NOM_AGE_MAT = rs.getString("NOM_AGE_MAT");
                this.COD_CAG_AGE_MAT = rs.getLong("COD_CAG_AGE_MAT");
            } else {
                throw new NoSuchEntityException("AgenteMateriale con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_age_mat_tab  WHERE cod_age_mat=?");
            ps.setLong(1, COD_AGE_MAT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AgenteMateriale con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_age_mat_tab  SET nom_age_mat=?, cod_cag_age_mat=?	 WHERE cod_age_mat=?");

            ps.setString(1, NOM_AGE_MAT);
            ps.setLong(2, COD_CAG_AGE_MAT);
            ps.setLong(3, COD_AGE_MAT);
            // ultima modifica
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AgenteMateriale con ID= non è trovata");
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
    public void setNOM_AGE_MAT(String newNOM_AGE_MAT) {
        if (NOM_AGE_MAT.equals(newNOM_AGE_MAT)) {
            return;
        }
        NOM_AGE_MAT = newNOM_AGE_MAT;
        setModified();
    }

    public String getNOM_AGE_MAT() {
        if (NOM_AGE_MAT == null) {
            return "";
        } else {
            return NOM_AGE_MAT;
        }
    }

    //2
    public void setCOD_CAG_AGE_MAT(long newCOD_CAG_AGE_MAT) {
        if (COD_CAG_AGE_MAT == newCOD_CAG_AGE_MAT) {
            return;
        }
        COD_CAG_AGE_MAT = newCOD_CAG_AGE_MAT;
        setModified();
    }

    public long getCOD_CAG_AGE_MAT() {
        return COD_CAG_AGE_MAT;
    }

    //3
    public long getCOD_AGE_MAT() {
        return COD_AGE_MAT;
    }
   //</comment>

    //=====================================================================<br>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetAgenti_Materiali_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana_age_mat_tab.cod_age_mat,ana_age_mat_tab.nom_age_mat,ana_age_mat_tab.cod_cag_age_mat,cag_age_mat_tab.nom_cag_age_mat FROM ana_age_mat_tab ,cag_age_mat_tab   WHERE ana_age_mat_tab.cod_cag_age_mat=cag_age_mat_tab.cod_cag_age_mat ORDER BY ana_age_mat_tab.nom_age_mat ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Agenti_Materiali_View obj = new Agenti_Materiali_View();
                obj.COD_AGE_MAT = rs.getLong(1);
                obj.NOM_AGE_MAT = rs.getString(2);
                obj.COD_CAG_AGE_MAT = rs.getLong(3);
                obj.NOM_CAG_AGE_MAT = rs.getString(4);
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

    // ---
    public Collection ejbfindEx(long COD_CAG, String NOM, long iOrderBy) {
        String Sql = "SELECT cod_age_mat ,nom_age_mat FROM ana_age_mat_tab ";
        String SqlA = "";
        int indexNom = 0;
        int indexCag = 0;
        int i = 1;
        if (COD_CAG != 0) {
            SqlA = " WHERE cod_cag_age_mat=? ";
            indexCag = i++;
        }
        if (NOM != null) {
            if (SqlA.equals("")) {
                SqlA += " WHERE UPPER(nom_age_mat) LIKE ? ";
            } else {
                SqlA += " AND UPPER(nom_age_mat) LIKE ? ";
            }
            indexNom = i++;
        }
        Sql += SqlA + " ORDER BY nom_age_mat ";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (indexCag != 0) {
                ps.setLong(indexCag, COD_CAG);
            }
            if (indexNom != 0) {
                ps.setString(indexNom, NOM.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_age_mat obj = new findEx_age_mat();
                obj.COD_AGE_MAT = rs.getLong(1);
                obj.NOM_AGE_MAT = rs.getString(2);
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
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AgenteMaterialeBean"/>
