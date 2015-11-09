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
package com.apconsulting.luna.ejb.GestioniSezioni;

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
public class GestioniSezioniBean extends BMPEntityBean implements IGestioniSezioni, IGestioniSezioniHome //class GestioniSezioniBean extends IGestioniSezioniHome
{
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    long COD_ARE;            //1
    long COD_AZL;            //2
    String NOM_ARE;            //3
    //----------------------------
    long COD_ARE_R;             //4
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static GestioniSezioniBean ys = null;

    private GestioniSezioniBean() {
        //
    }

    public static GestioniSezioniBean getInstance() {
        if (ys == null) {
            ys = new GestioniSezioniBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IGestioniSezioni create(String strNOM_ARE, long lCOD_AZL) throws CreateException {
        GestioniSezioniBean bean = new GestioniSezioniBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_ARE, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_ARE, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        GestioniSezioniBean iGestioniSezioniBean = new GestioniSezioniBean();
        try {
            Object obj = iGestioniSezioniBean.ejbFindByPrimaryKey((Long) primaryKey);
            iGestioniSezioniBean.setEntityContext(new EntityContextWrapper(obj));
            iGestioniSezioniBean.ejbActivate();
            iGestioniSezioniBean.ejbLoad();
            iGestioniSezioniBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IGestioniSezioni findByPrimaryKey(Long primaryKey) throws FinderException {
        GestioniSezioniBean bean = new GestioniSezioniBean();
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

    public Collection getGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL) {
        return (new GestioniSezioniBean()).ejbGetGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL);
    }

    public Collection getGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        return (new GestioniSezioniBean()).ejbGetGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL, lCOD_CPL);
    }

    public Collection getGestioniSezioni_Paragrafo_View(long lCOD_AZL) {
        return (new GestioniSezioniBean()).ejbGetGestioniSezioni_Paragrafo_View(lCOD_AZL);
    }

    public Collection caricaFromRpAre() {
        return (new GestioniSezioniBean()).ejbcaricaFromRpAre();
    }

    public Collection getNameFromRep(long COD_ARE_R) {
        return (new GestioniSezioniBean()).ejbGetNameFromRep(COD_ARE_R);
    }

    //<report>
    public Collection getReportGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL) {
        return this.ejbGetReportGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL);
    }
    //</report>


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IGestioniSezioniHome-implementation>
    public Long ejbCreate(String strNOM_ARE, long lCOD_AZL) {
        this.NOM_ARE = strNOM_ARE;
        this.COD_AZL = lCOD_AZL;
        this.COD_ARE = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_are_tab (cod_are,nom_are,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, COD_ARE);
            ps.setString(2, NOM_ARE);
            ps.setLong(3, COD_AZL);
            ps.executeUpdate();
            return new Long(COD_ARE);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_ARE, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_are FROM ana_are_tab ");
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
        this.COD_ARE = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_ARE = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_are_tab  WHERE cod_are=?");
            ps.setLong(1, COD_ARE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_ARE = rs.getString("NOM_ARE");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_ARE_R = rs.getLong("COD_ARE_R");
            } else {
                throw new NoSuchEntityException("GestioniSezioni con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_are_tab  WHERE cod_are=?");
            ps.setLong(1, COD_ARE);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("GestioniSezioni con ID= non è trovata");
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
            if (COD_ARE_R == 0) {
                PreparedStatement ps = bmp.prepareStatement("UPDATE ana_are_tab  SET nom_are=?, cod_azl=? WHERE cod_are=?");
                ps.setString(1, NOM_ARE);
                ps.setLong(2, COD_AZL);
                ps.setLong(3, COD_ARE);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("GestioniSezioni COD_ARE con ID= non è trovata");
                }
            } else {
                PreparedStatement ps = bmp.prepareStatement("UPDATE ana_are_tab  SET nom_are=?, cod_azl=?, cod_are_r=? WHERE cod_are=?");
                ps.setString(1, NOM_ARE);
                ps.setLong(2, COD_AZL);
                ps.setLong(4, COD_ARE);
                ps.setLong(3, COD_ARE_R);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("GestioniSezioni COD_ARE_R con ID= non è trovata");
                }
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
    // COD_ARE
    public long getCOD_ARE() {
        return COD_ARE;
    }

    // COD_AZL
    public long getCOD_AZL() {
        return COD_AZL;
    }

    // NOM_ARE
    public void setNOM_ARE__COD_AZL(String newNOM_ARE, long newCOD_AZL) {
        if (NOM_ARE != null) {
            if (NOM_ARE.equals(newNOM_ARE)) {
                return;
            }
        }
        NOM_ARE = newNOM_ARE;
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public String getNOM_ARE() {
        return NOM_ARE;
    }

    // COD_ARE_R
    public void setCOD_ARE_R(long newCOD_ARE_R) {
        if (COD_ARE_R == newCOD_ARE_R) {
            return;
        }
        COD_ARE_R = newCOD_ARE_R;
        setModified();
    }

    public long getCOD_ARE_R() {
        return COD_ARE_R;
    }

    // setPriority_ANA_DOC_VLU
    public void setPriority_ANA_DOC_VLU(long lCOD_ARE, long lCOD_DOC_VLU, long lCOD_AZL, long newPriority) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select count(*) from are_doc_vlu_tab where cod_are=? and cod_doc_vlu=?");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_DOC_VLU);
            long CNT = 0;
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CNT = rs.getLong(1);
            }
            if (CNT == 0) {
                /*            PreparedStatement ps1=bmp.prepareStatement("INSERT INTO are_doc_vlu_tab (cod_are,cod_doc_vlu, cod_azl,priority) VALUES(?,?,?,?)");
                ps1.setLong(1, lCOD_ARE);
                ps1.setLong(2, lCOD_DOC_VLU);
                ps1.setLong(3, lCOD_AZL);
                ps1.setLong(4, newPriority);
                ps1.executeUpdate();
                 */
            } else if (CNT == 1) {
                PreparedStatement ps2 = bmp.prepareStatement("UPDATE are_doc_vlu_tab SET priority=? WHERE cod_are = ? AND cod_doc_vlu = ? AND cod_azl = ? ");
                ps2.setLong(1, newPriority);
                ps2.setLong(2, lCOD_ARE);
                ps2.setLong(3, lCOD_DOC_VLU);
                ps2.setLong(4, lCOD_AZL);
                ps2.executeUpdate();
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//</comment>
    public Collection ejbGetGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_cpl, a.des_cpl_are, a.priority, b.nom_cpl FROM cpl_are_tab a ,ana_cpl_tab b  WHERE a.cod_cpl=b.cod_cpl and a.cod_are=? and a.cod_azl=? order by a.priority");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioniSezioni_CplAre_View obj = new GestioniSezioni_CplAre_View();
                obj.COD_ARE = lCOD_ARE;
                obj.COD_AZL = lCOD_AZL;
                obj.COD_CPL = rs.getLong(1);
                obj.DES_CPL_ARE = rs.getString(2);
                obj.PRIORITY = rs.getLong(3);
                obj.strNOM_CPL = rs.getString(4);
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

    public Collection ejbGetReportGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "a.cod_cpl, " +
                    "a.nom_cpl, " +
                    "b.des_cpl_are " +
                    "FROM " +
                    "ana_cpl_tab a, " +
                    "cpl_are_tab b " +
                    "WHERE " +
                    "a.cod_cpl = b.cod_cpl " +
                    "AND  b.cod_are=? and b.cod_azl=? " +
                    "ORDER BY " +
                    "b.priority");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportGestioniSezioni_CplAre_View obj = new ReportGestioniSezioni_CplAre_View();
                obj.COD_CPL = rs.getLong(1);
                obj.NOM_CPL = rs.getString(2);
                obj.DES_CPL_ARE = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


//<!-- create by Juli -->
    public Collection ejbGetGestioniSezioni_Paragrafo_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_are, nom_are FROM ana_are_tab WHERE cod_azl=? order by nom_are");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioniSezioni_Paragrafo_View obj = new GestioniSezioni_Paragrafo_View();
                obj.COD_ARE = rs.getLong(1);
                obj.NOM_ARE = rs.getString(2);
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

    // %%%Link%%% Table COR_PCS_FRM_TAB
    public void addCOD_CPL(long newCOD_CPL, String newDES_CPL_ARE, long lPRIORITY) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cpl_are_tab (cod_are,cod_cpl,des_cpl_are,cod_azl,priority) VALUES(?,?,?,?,?)");
            ps.setLong(1, COD_ARE);
            ps.setLong(2, newCOD_CPL);
            ps.setString(3, newDES_CPL_ARE);
            ps.setLong(4, COD_AZL);
            ps.setLong(5, lPRIORITY);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void editCOD_CPL(long newCOD_CPL, String newDES_CPL_ARE, long lPRIORITY) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE cpl_are_tab SET des_cpl_are=?, priority=? WHERE cod_are = ? AND cod_cpl = ? AND cod_azl = ?");
            ps.setString(1, newDES_CPL_ARE);
            ps.setLong(2, lPRIORITY);
            ps.setLong(3, COD_ARE);
            ps.setLong(4, newCOD_CPL);
            ps.setLong(5, COD_AZL);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //by Juli
    // %%%GET PRIORITY%%% Table ARE_DOC_VLU_TAB
    public long getARE_DOC_VLU_Priority(long COD_DOC_VLU, long COD_ARE) {
        BMPConnection bmp = getConnection();
        try {
            long res = 0;
            PreparedStatement ps = bmp.prepareStatement("SELECT priority FROM are_doc_vlu_tab WHERE  cod_doc_vlu = ? AND cod_are = ? ");
            ps.setLong(1, COD_DOC_VLU);
            ps.setLong(2, COD_ARE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                res = rs.getLong(1);
            }
            bmp.close();
            return res;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%UNLink%%% Table COR_PCS_FRM_TAB
    public void removeCOD_CPL(long newCOD_CPL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cpl_are_tab  WHERE cod_are=? AND cod_cpl=? AND cod_azl=?");
            ps.setLong(1, COD_ARE);
            ps.setLong(2, newCOD_CPL);
            ps.setLong(3, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi con ID=" + newCOD_CPL + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetGestioniSezioni_CplAre_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT des_cpl_are, priority FROM cpl_are_tab WHERE cod_are=? and cod_azl=? and cod_cpl=? order by priority ");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_CPL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioniSezioni_CplAre_View obj = new GestioniSezioni_CplAre_View();
                obj.COD_ARE = lCOD_ARE;
                obj.COD_AZL = lCOD_AZL;
                obj.COD_CPL = lCOD_CPL;
                obj.DES_CPL_ARE = rs.getString(1);
                obj.PRIORITY = rs.getLong(2);
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

    public Collection findEx(long lCOD_AZL, String NOM_ARE,
            int iOrderParameter /*not used for now*/) {
        return (new GestioniSezioniBean()).ejbFindEx(lCOD_AZL, NOM_ARE, iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL, String NOM_ARE,
            int iOrderParameter /*not used for now*/) {
        String strSql = "SELECT  cod_are, UPPER(nom_are) AS nom_are FROM ana_are_tab WHERE cod_azl=? ";
        if (NOM_ARE != null) {
            strSql += "AND UPPER(nom_are) LIKE ?";
        }
        strSql += " ORDER BY 2";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, lCOD_AZL);
            if (NOM_ARE != null) {
                ps.setString(2, NOM_ARE.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioniSezioni_Paragrafo_View obj = new GestioniSezioni_Paragrafo_View();
                obj.COD_ARE = rs.getLong(1);
                obj.NOM_ARE = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbcaricaFromRpAre() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_are_r, UPPER(nom_are_r) FROM ana_are_tab_r " +
                    " WHERE cod_are_r NOT IN " +
                    " (SELECT cod_are_r FROM ana_are_tab WHERE cod_are_r IS NOT NULL)");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                caricaFromRpAre obj = new caricaFromRpAre();
                obj.COD_ARE_R = rs.getLong(1);
                obj.NOM_ARE = rs.getString(2);
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

    public Collection ejbGetNameFromRep(long COD_ARE_R) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT UPPER(nom_are_r) FROM ana_are_tab_r " +
                    " WHERE cod_are_r = ? ");
            ps.setLong(1, COD_ARE_R);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NameFromRep obj = new NameFromRep();
                obj.NOM_ARE = rs.getString(1);
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
