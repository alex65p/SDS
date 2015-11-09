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

package com.apconsulting.luna.ejb.ArtLegge;

import com.apconsulting.luna.ejb.Articoli.findEx_arl;
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
public class ArtLeggeBean extends BMPEntityBean implements IArtLeggeHome, IArtLegge{
    long COD_ARL;
    String IDEN;
    String NOM_ARL;
    String DES_ARL;

    private static ArtLeggeBean ys = null;

    private ArtLeggeBean() {
    }

    public static ArtLeggeBean getInstance() {
        if (ys == null) {
            ys = new ArtLeggeBean();
        }
        return ys;
    }

    public Collection getArt_Legge_View() {
        return (new ArtLeggeBean()).ejbGetArt_Legge_View();
    }

    // (Home Intrface) create()
    public IArtLegge create(String sIDEN,String sNOM_ARL, String sDES_ARL) throws CreateException {
        ArtLeggeBean bean = new ArtLeggeBean();
        try {
            Object primaryKey = bean.ejbCreate(sIDEN,sNOM_ARL,sDES_ARL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(sIDEN,sNOM_ARL,sDES_ARL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        ArtLeggeBean iArtLeggeBean = new ArtLeggeBean();
        try {
            Object obj = iArtLeggeBean.ejbFindByPrimaryKey((Long) primaryKey);
            iArtLeggeBean.setEntityContext(new EntityContextWrapper(obj));
            iArtLeggeBean.ejbActivate();
            iArtLeggeBean.ejbLoad();
            iArtLeggeBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public IArtLegge findByPrimaryKey(Long primaryKey) throws FinderException {
        ArtLeggeBean iArtLeggeBean = new ArtLeggeBean();
        try {
            iArtLeggeBean.setEntityContext(new EntityContextWrapper(primaryKey));
            iArtLeggeBean.ejbActivate();
            iArtLeggeBean.ejbLoad();
            return iArtLeggeBean;
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

    public void deleteArticolo(Long COD_ARL) {
        ArtLeggeBean bean = new ArtLeggeBean();
        bean.ejbHomeDeleteArticolo(COD_ARL);
    }
///////////////////////////////////////////////////

    public void ejbHomeDeleteArticolo(Long lCOD_ARL) {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            {
                PreparedStatement psa = bmp.prepareStatement("DELETE FROM ana_arl_tab WHERE cod_arl=?");
                psa.setLong(1, lCOD_ARL);
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

    public Collection findEx(Long lCOD_ARL, String sIDEN, String sNOM_ARL, String sDES_ARL) {
        return (new ArtLeggeBean()).ejbfindEx(lCOD_ARL,sIDEN,sNOM_ARL,sDES_ARL);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAziendaHome-implementation>
    public Long ejbCreate(String sIDEN,String sNOM_ARL, String sDES_ARL) {
        this.COD_ARL = NEW_ID(); // unic ID
        this.IDEN = sIDEN;
        this.NOM_ARL = sNOM_ARL;
        this.DES_ARL = sDES_ARL; // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_arl_tab (cod_arl,iden,nom_arl,des_arl) VALUES(?,?,?,?)");
            ps.setLong(1, this.COD_ARL);
            ps.setString(2, this.IDEN);
            ps.setString(3, this.NOM_ARL);
            ps.setString(4, this.DES_ARL);
            ps.executeUpdate();

            bmp.commitTrans();
            return new Long(this.COD_ARL);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String sIDEN,String sNOM_ARL, String sDES_ARL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_arl,iden,nom_arl,des_arl FROM ana_arl_tab");
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
        this.COD_ARL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_ARL = -1l;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select nom_arl,des_arl "
                    + " from ana_arl_tab where "
                    + "cod_arl=?");
            ps.setLong(1, COD_ARL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_ARL = rs.getString("NOM_ARL");
                this.DES_ARL = rs.getString("DES_ARL");
            } else {
                throw new NoSuchEntityException("Articolo con ID=" + COD_ARL + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_arl_tab WHERE cod_rap=?");
            ps.setLong(1, COD_ARL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Articolo con ID=" + COD_ARL + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_arl_tab SET iden=?,nom_arl=?,des_arl=? WHERE cod_arl=?");
            ps.setString(1, IDEN);
            ps.setString(2, NOM_ARL);
            ps.setString(2, DES_ARL);
            ps.setLong(3, COD_ARL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Articolo con ID=" + COD_ARL + " non trovato");
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

    public Long getCOD_ARL() {
        return COD_ARL;
    }

    public String getIDEN() {
        return IDEN;
    }

    public String getNOM_ARL() {
        return NOM_ARL;
    }

    public String getDES_ARL() {
        return DES_ARL;
    }

    public void setIDEN(String iden) {
        if (IDEN.equals(iden)) {
            return;
        }
        IDEN = iden;
        setModified();
    }

    public void setNOM_ARL(String nom_rso) {
        if (NOM_ARL.equals(nom_rso)) {
            return;
        }
        NOM_ARL = nom_rso;
        setModified();
    }

    public void setDES_ARL(String des_rso) {
        if (DES_ARL.equals(des_rso)) {
            return;
        }
        DES_ARL = des_rso;
        setModified();
    }
 public Collection ejbGetArt_Legge_View(){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "SELECT "
                    + "COD_ARL, "
                    + "NOM_ARL, "
                    + "DES_ARL "
                + "FROM "
                    + "ANA_ARL_TAB "
                + "ORDER BY "
                    + "COD_ARL");
            ResultSet rs=ps.executeQuery();
            java.util.ArrayList al=new java.util.ArrayList();
            while(rs.next()){
                Art_Legge_View obj=new Art_Legge_View();
                obj.COD_ARL=rs.getLong("COD_ARL");
                obj.NOM_ARL=rs.getString("NOM_ARL");
                obj.DES_ARL=rs.getString("DES_ARL");
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch(Exception ex){
            throw new EJBException(ex);
        } finally{bmp.close();}
    }

 public Collection ejbfindEx(Long lCOD_ARL, String sIDEN, String sNOM_ARL, String sDES_ARL) {
        BMPConnection bmp = getConnection();
        String Sql =
        "select cod_arl,iden,nom_arl,des_arl from ana_arl_tab ";
        String SqlA = "";
        if (sNOM_ARL != null || sDES_ARL != null) {
        SqlA += " where ";
        }
        int i = 1;
        int indexIden = 0;
        if (sIDEN != null) {
        SqlA += " iden like '%?%'";
        indexIden = i++;
        }
        int indexNom = 0;
        if (sNOM_ARL != null) {
        SqlA += " nom_arl like '%?%'";
        indexNom = i++;
        }
        int indexDes = 0;
        if (sDES_ARL != null && sNOM_ARL != null) {
        SqlA += " AND ";
        }
        if (sDES_ARL != null) {
        SqlA += " des_arl like '%?%' ";
        indexDes = i++;
        }
        Sql = Sql + SqlA + " ORDER BY iden,nom_arl,des_arl";
        java.util.ArrayList al = new java.util.ArrayList();
        try {
        PreparedStatement ps = bmp.prepareStatement(Sql);

        if (indexIden != 0) {
        ps.setString(indexNom, sIDEN);
        }
        if (indexNom != 0) {
        ps.setString(indexNom, sNOM_ARL);
        }
        if (indexDes != 0) {
        ps.setString(indexDes, sDES_ARL);
        }

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
        findEx_arl obj = new findEx_arl();
        obj.COD_ARL = rs.getLong(1);
        obj.IDEN = rs.getString(2);
        obj.NOM_ARL = rs.getString(3);
        obj.DES_ARL = rs.getString(4);
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
