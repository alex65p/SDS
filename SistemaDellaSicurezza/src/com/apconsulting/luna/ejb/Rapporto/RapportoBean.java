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
package com.apconsulting.luna.ejb.Rapporto;

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
import s2s.ejb.pseudoejb.PseudoContext;

import com.apconsulting.luna.ejb.AnagrConstatazioni.*;

/**
 *
 * @author Dario
 */
public class RapportoBean extends BMPEntityBean implements IRapportoHome, IRapporto {

    Long COD_RAP = null;
    String NOM_RAP;
    String DES_RAP;
    Collection CONSTATAZIONI = null;
    ////////////////////// CONSTRUCTOR///////////////////
    private static RapportoBean ys = null;

    private RapportoBean() {
    }

    public static RapportoBean getInstance() {
        if (ys == null) {
            ys = new RapportoBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public IRapporto create(String sNOM_RAP, String sDES_RAP) throws CreateException {
        RapportoBean bean = new RapportoBean();
        try {
            Object primaryKey = bean.ejbCreate(sNOM_RAP, sDES_RAP);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(sNOM_RAP, sDES_RAP);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        RapportoBean iRapportoBean = new RapportoBean();
        try {
            Object obj = iRapportoBean.ejbFindByPrimaryKey((Long) primaryKey);
            iRapportoBean.setEntityContext(new EntityContextWrapper(obj));
            iRapportoBean.ejbActivate();
            iRapportoBean.ejbLoad();
            iRapportoBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public IRapporto findByPrimaryKey(Long primaryKey) throws FinderException {
        RapportoBean iRapportoBean = new RapportoBean();
        try {
            iRapportoBean.setEntityContext(new EntityContextWrapper(primaryKey));
            iRapportoBean.ejbActivate();
            iRapportoBean.ejbLoad();
            return iRapportoBean;
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
/////////////////////////////////////////////////

    public void deleteRapporto(Long COD_RAP) {
        RapportoBean bean = new RapportoBean();
        bean.ejbHomeDeleteRapporto(COD_RAP);
    }
///////////////////////////////////////////////////

    public void ejbHomeDeleteRapporto(Long lCOD_RAP) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            {
                PreparedStatement psa = bmp.prepareStatement("DELETE FROM ana_rap_tab WHERE cod_rap=?");
                psa.setLong(1, lCOD_RAP);
                psa.executeUpdate();
            }
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx(Long lCOD_RAP, String sNOM_RAP, String sDES_RAP) {
        return (new RapportoBean()).ejbfindEx(lCOD_RAP, sNOM_RAP, sDES_RAP);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAziendaHome-implementation>
    public Long ejbCreate(String sNOM_RAP, String sDES_RAP) {
        this.COD_RAP = NEW_ID(); // unic ID        
        this.NOM_RAP = sNOM_RAP;
        this.DES_RAP = sDES_RAP; // unic ID        
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_rap_tab (cod_rap,nom_rap,des_rap) VALUES(?,?,?)");
            ps.setLong(1, this.COD_RAP);
            ps.setString(2, this.NOM_RAP);
            ps.setString(3, this.DES_RAP);
            ps.executeUpdate();

            bmp.commitTrans();
            return new Long(this.COD_RAP);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String sNOM_RAP, String sDES_RAP) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_rap,nom_rap,des_rap FROM ana_rap_tab");
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
        this.COD_RAP = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_RAP = -1l;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select nom_rap,des_rap"
                    + "from ana_rap_tab where "
                    + "cod_rap=?");
            ps.setLong(1, COD_RAP);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_RAP = rs.getString("NOM_RAP");
                this.DES_RAP = rs.getString("DES_RAP");
                IAnagrConstatazioniHome bean_con = (IAnagrConstatazioniHome) PseudoContext.lookup("AnagrConstatazioniBean");
                this.CONSTATAZIONI = bean_con.findAll();
            } else {
                throw new NoSuchEntityException("Rapporto con ID=" + COD_RAP + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_rap_tab WHERE cod_rap=?");
            ps.setLong(1, COD_RAP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rapporto con ID=" + COD_RAP + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_rap_tab SET nom_rap=?,des_rap=? WHERE cod_rap=?");
            ps.setString(1, NOM_RAP);
            ps.setString(2, DES_RAP);
            ps.setLong(3, COD_RAP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rapporto con ID=" + COD_RAP + " non trovato");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
    public void Update() {
        setModified();
    }

    public Long getCOD_RAP() {
        return COD_RAP;
    }

    public String getNOM_RAP() {
        return NOM_RAP;
    }

    public String getDES_RAP() {
        return DES_RAP;
    }

    public void setNOM_RAP(String nom_rso) {
        if (NOM_RAP.equals(nom_rso)) {
            return;
        }
        NOM_RAP = nom_rso;
        setModified();
    }

    public void setDES_RAP(String des_rso) {
        if (DES_RAP.equals(des_rso)) {
            return;
        }
        DES_RAP = des_rso;
        setModified();
    }

    public Collection getConstatazioni() {
        return CONSTATAZIONI;
    }

//////////////////////////////<findEx>/////////////////////////////////////////
    public Collection ejbfindEx(Long lCOD_RAP, String sNOM_RAP, String sDES_RAP) {
        BMPConnection bmp = getConnection();
        String Sql =
        "select cod_rap,nom_rap,des_rap from ana_rap_tab ";
        String SqlA = "";
        if (sNOM_RAP != null || sDES_RAP != null) {
        SqlA += " where ";
        }
        int i = 1;
        int indexNom = 0;
        if (sNOM_RAP != null) {
        SqlA += " nom_rap like '%?%'";
        indexNom = i++;
        }
        int indexDes = 0;
        if (sDES_RAP != null && sNOM_RAP != null) {
        SqlA += " AND ";
        }
        if (sDES_RAP != null) {
        SqlA += " des_rap like '%?%' ";
        indexDes = i++;
        }
        Sql = Sql + SqlA + " ORDER BY nom_rap,des_rap";
        java.util.ArrayList al = new java.util.ArrayList();
        try {
        PreparedStatement ps = bmp.prepareStatement(Sql);
        
        if (indexNom != 0) {
        ps.setString(indexNom, sNOM_RAP);
        }
        if (indexDes != 0) {
        ps.setString(indexDes, sDES_RAP);
        }
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
        findEx_rap obj = new findEx_rap();
        obj.COD_RAP = rs.getLong(1);
        obj.NOM_RAP = rs.getString(2);
        obj.DES_RAP = rs.getString(3);
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
}
