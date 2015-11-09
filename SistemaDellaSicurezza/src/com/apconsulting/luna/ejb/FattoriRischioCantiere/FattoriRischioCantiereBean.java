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
package com.apconsulting.luna.ejb.FattoriRischioCantiere;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

public class FattoriRischioCantiereBean extends BMPEntityBean implements IFattoriRischioCantiere, IFattoriRischioCantiereHome {
    //<member-varibles description="Member Variables">

    long lCOD_FAT_RSO;
    String strNOM_FAT_RSO;
    String strDES_FAT_RSO;
    long lNUM_FAT_RSO;
    long lCOD_CAG_FAT_RSO;
    long lCOD_NOR_SEN;
    //</member-varibles>
    //<IRischioFattoreHome-implementation>
    public static final String BEAN_NAME = "RischioFattoreBean";
    private static FattoriRischioCantiereBean ys = null;

    private FattoriRischioCantiereBean() {
    }

    public static FattoriRischioCantiereBean getInstance() {
        if (ys == null) {
            ys = new FattoriRischioCantiereBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        FattoriRischioCantiereBean bean = new FattoriRischioCantiereBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex.getMessage());
        }
    }

    public IFattoriRischioCantiere create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws javax.ejb.CreateException {
        FattoriRischioCantiereBean bean = new FattoriRischioCantiereBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IFattoriRischioCantiere findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        FattoriRischioCantiereBean bean = new FattoriRischioCantiereBean();
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

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Long ejbCreate(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) {
        this.lCOD_FAT_RSO = NEW_ID();
        this.strNOM_FAT_RSO = strNOM_FAT_RSO;
        this.lNUM_FAT_RSO = lNUM_FAT_RSO;
        this.lCOD_CAG_FAT_RSO = lCOD_CAG_FAT_RSO;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_fat_rso_can_tab (cod_fat_rso,nom_fat_rso) VALUES(?,?)");
            ps.setLong(1, lCOD_FAT_RSO);
            ps.setString(2, strNOM_FAT_RSO);
            ps.executeUpdate();
            return new Long(lCOD_FAT_RSO);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fat_rso FROM ana_fat_rso_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_FAT_RSO = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_FAT_RSO = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fat_rso,nom_fat_rso,des_fat_rso FROM ana_fat_rso_can_tab WHERE cod_fat_rso=?");
            ps.setLong(1, lCOD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_FAT_RSO = rs.getLong(1);
                strNOM_FAT_RSO = rs.getString(2);
                strDES_FAT_RSO = rs.getString(3);
            } else {
                throw new NoSuchEntityException("RischioFattore with ID=" + lCOD_FAT_RSO + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_fat_rso_can_tab WHERE cod_fat_rso=?");
            ps.setLong(1, lCOD_FAT_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("RischioFattore with ID=" + lCOD_FAT_RSO + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_fat_rso_can_tab SET cod_fat_rso=?, nom_fat_rso=?, des_fat_rso=? WHERE cod_fat_rso=?");
            ps.setLong(1, lCOD_FAT_RSO);
            ps.setString(2, strNOM_FAT_RSO);
            ps.setString(3, strDES_FAT_RSO);
            ps.setLong(4, lCOD_FAT_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("RischioFattore with ID=" + lCOD_FAT_RSO + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //<alex "19/03/2004">

    public void deleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN) {
        ejbDeleteFattoriRischiByAttivita(lCOD_AZL, lCOD_MAN);
    }

    public void addFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO) {
        ejbAddFattoreRischioPerAttivita(lCOD_AZL, lCOD_MAN, lCOD_FAT_RSO);
    }

    public void deleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG) {
        ejbDeleteFattoriRischiByUnita(lCOD_AZL, lCOD_UNI_ORG);
    }

    public void addFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_FAT_RSO) {
        ejbAddFattoreRischioPerUnita(lCOD_AZL, lCOD_UNI_ORG, lCOD_FAT_RSO);
    }

    //<views>
    public Collection getFattoreRischio_View() {
        return (new FattoriRischioCantiereBean()).ejbGetFattoreRischio_View();
    }

    /*  public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_OPE_SVO, long lCOD_FAT_RSO) {
    return this.ejbGetReport_RischioFattore_RischioView(lCOD_AZL, lCOD_MAN, lCOD_OPE_SVO, lCOD_FAT_RSO);
    }*/

    /* public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO) {
    return this.ejbGetReport_RischioFattore_RischioView(lCOD_AZL, lCOD_MAN, lCOD_FAT_RSO);
    }
    
    public Collection getReport_RischioFattore_RischioView_UO(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_FAT_RSO) {
    return this.ejbGetReport_RischioFattore_RischioView_UO(lCOD_AZL, lCOD_LUO_FSC, lCOD_FAT_RSO);
    }
    
    public Collection getReport_RischioFattore_ComboView(long lCOD_AZL, long lCOD_MAN, long lCOD_OPE_SVO) {
    return this.ejbGetReport_RischioFattore_ComboView(lCOD_AZL, lCOD_MAN, lCOD_OPE_SVO);
    }
    
    public Collection getReport_RischioFattore_ComboView_CAG_FAT_RSO(long lCOD_AZL, long lCOD_MAN, long lCOD_CAG_FAT_RSO) {
    return this.ejbGetReport_RischioFattore_ComboView_CAG_FAT_RSO(lCOD_AZL, lCOD_MAN, lCOD_CAG_FAT_RSO);
    }*/
    public Collection getFattoriWithoutRischiView(long lCOD_AZL, long lCOD_MAN) {
        return (new FattoriRischioCantiereBean()).ejbGetFattoriWithoutRischi(lCOD_AZL, lCOD_MAN);
    }

    public Collection getFattoriWithRischi4Categoria(long lCOD_CAG_FAT_RSO, long lCOD_AZL) {
        return (new FattoriRischioCantiereBean()).ejbGetFattoriWithRischi4Categoria(lCOD_CAG_FAT_RSO, lCOD_AZL);
    }

    public Collection getFattoriUWithoutRischiView(long lCOD_AZL, long lCOD_UNI_ORG) {
        return (new FattoriRischioCantiereBean()).ejbGetFattoriUWithoutRischi(lCOD_AZL, lCOD_UNI_ORG);
    }

    public Collection getAnagrFattoriRischioCantiere_All_View() {
        return (new FattoriRischioCantiereBean()).ejbGetANA_FAT_RSO_CAN_TAB_View();
    }

    public Collection ejbGetANA_FAT_RSO_CAN_TAB_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fat_rso, nom_fat_rso  FROM ana_fat_rso_can_tab ORDER BY 2");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioFattore_ComboView view = new RischioFattore_ComboView();
                view.lCOD_FAT_RSO = rs.getLong(1);
                view.strNOM_FAT_RSO = rs.getString(2);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getComboView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fat_rso, nom_fat_rso  FROM ana_fat_rso_can_tab ORDER BY 2");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RischioFattore_ComboView view = new RischioFattore_ComboView();
                view.lCOD_FAT_RSO = rs.getLong(1);
                view.strNOM_FAT_RSO = rs.getString(2);
                al.add(view);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</views>
    //<setter-getters>

    public long getCOD_FAT_RSO() {
        return lCOD_FAT_RSO;
    }

    public String getNOM_FAT_RSO() {
        return strNOM_FAT_RSO;
    }

    public void setNOM_FAT_RSO(String strNOM_FAT_RSO) {
        if ((this.strNOM_FAT_RSO != null) && (this.strNOM_FAT_RSO.equals(strNOM_FAT_RSO))) {
            return;
        }
        this.strNOM_FAT_RSO = strNOM_FAT_RSO;
        setModified();
    }

    public String getDES_FAT_RSO() {
        return strDES_FAT_RSO;
    }

    public void setDES_FAT_RSO(String strDES_FAT_RSO) {
        if ((this.strDES_FAT_RSO != null) && (this.strDES_FAT_RSO.equals(strDES_FAT_RSO))) {
            return;
        }
        this.strDES_FAT_RSO = strDES_FAT_RSO;
        setModified();
    }

    public long getNUM_FAT_RSO() {
        return lNUM_FAT_RSO;
    }

    public void setNUM_FAT_RSO(long lNUM_FAT_RSO) {
        if (this.lNUM_FAT_RSO == lNUM_FAT_RSO) {
            return;
        }
        this.lNUM_FAT_RSO = lNUM_FAT_RSO;
        setModified();
    }

    public long getCOD_CAG_FAT_RSO() {
        return lCOD_CAG_FAT_RSO;
    }

    public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO) {
        if (this.lCOD_CAG_FAT_RSO == lCOD_CAG_FAT_RSO) {
            return;
        }
        this.lCOD_CAG_FAT_RSO = lCOD_CAG_FAT_RSO;
        setModified();
    }

    public long getCOD_NOR_SEN() {
        return lCOD_NOR_SEN;
    }

    public void setCOD_NOR_SEN(long lCOD_NOR_SEN) {
        if (this.lCOD_NOR_SEN == lCOD_NOR_SEN) {
            return;
        }
        this.lCOD_NOR_SEN = lCOD_NOR_SEN;
        setModified();
    }
    //</setter-getters>
// %%%Link%%% Table DOC_FAT_RSO_TAB

    public void addDOC_FAT_RSO(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_fat_rso_tab (cod_doc,cod_fat_rso) VALUES(?,?)");
            ps.setLong(1, lCOD_DOC);
            ps.setLong(2, lCOD_FAT_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table DOC_FAT_RSO_TAB

    public void removeDOC_FAT_RSO(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_fat_rso_tab  WHERE cod_doc=? AND cod_fat_rso=? ");
            ps.setLong(1, lCOD_DOC);
            ps.setLong(2, lCOD_FAT_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento con ID=" + lCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetFattoreRischio_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fat_rso, nom_fat_rso, num_fat_rso, des_fat_rso FROM ana_fat_rso_tab ORDER BY 2");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                FattoreRischio_View obj = new FattoreRischio_View();
                obj.COD_FAT_RSO = rs.getLong("COD_FAT_RSO");
                obj.NOM_FAT_RSO = rs.getString("NOM_FAT_RSO");
                obj.NUM_FAT_RSO = rs.getLong("NUM_FAT_RSO");
                obj.DES_FAT_RSO = rs.getString("DES_FAT_RSO");
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //<artur>

    public Collection ejbGetFattoriUWithoutRischi(long lCOD_AZL, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            String SQL = "";
            SQL += "SELECT F.cod_fat_rso, F.NOM_fat_rso, 0 ";
            SQL += "FROM 	ANA_FAT_RSO_TAB F ";
            SQL += "WHERE F.cod_fat_rso NOT IN ( ";
            SQL += "	SELECT DISTINCT D.cod_fat_rso ";
            SQL += "	FROM RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A, ANA_FAT_RSO_TAB D, ANA_RSO_TAB R ";
            SQL += "	WHERE  ";
            SQL += "	 C.PRS_RSO = 'S' ";
            SQL += "	 AND C.COD_LUO_FSC = B.COD_LUO_FSC ";
            SQL += "	 AND A.COD_LUO_FSC = B.COD_LUO_FSC ";
            SQL += "	 AND R.COD_RSO = C.COD_RSO ";
            SQL += "	 AND R.COD_AZL = C.COD_AZL ";
            SQL += "	 AND C.COD_AZL =? ";
            SQL += "	 AND cod_uni_org= ? ) ";
            SQL += "	AND F.COD_FAT_RSO NOT IN ( ";
            SQL += "    SELECT G.cod_fat_rso FROM ana_uni_org_fat_rso_tab G ";
            SQL += "    WHERE 	G.COD_AZL = ? AND G.cod_uni_org = ?) ";
            SQL += "UNION ";
            SQL += "SELECT 	A.cod_fat_rso, A.nom_fat_rso, 1 ";
            SQL += "FROM ana_fat_rso_tab A, ana_uni_org_fat_rso_tab G ";
            SQL += "WHERE A.COD_FAT_RSO = g.COD_FAT_RSO ";
            SQL += "	AND G.COD_AZL = ? AND G.cod_uni_org = ? ";
            SQL += "	AND A.COD_FAT_RSO NOT IN ( ";
            SQL += "		 SELECT DISTINCT D.cod_fat_rso ";
            SQL += "		 FROM RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A, ANA_FAT_RSO_TAB D, ANA_RSO_TAB R ";
            SQL += "		 WHERE  ";
            SQL += "			 C.PRS_RSO = 'S' ";
            SQL += "			 AND C.COD_LUO_FSC = B.COD_LUO_FSC ";
            SQL += "			 AND A.COD_LUO_FSC = B.COD_LUO_FSC ";
            SQL += "			 AND R.COD_RSO = C.COD_RSO ";
            SQL += "			 AND R.COD_AZL = C.COD_AZL ";
            SQL += "			 AND C.COD_AZL =? ";
            SQL += "			 AND cod_uni_org=?) ";
            SQL += "ORDER BY 2";

            PreparedStatement ps = bmp.prepareStatement(SQL);
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.setLong(3, lCOD_AZL);
            ps.setLong(4, lCOD_UNI_ORG);
            ps.setLong(5, lCOD_AZL);
            ps.setLong(6, lCOD_UNI_ORG);
            ps.setLong(7, lCOD_AZL);
            ps.setLong(8, lCOD_UNI_ORG);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FattoreRischio_View obj = new FattoreRischio_View();
                obj.COD_FAT_RSO = rs.getLong(1);
                obj.NOM_FAT_RSO = rs.getString(2);
                obj.lFlag = rs.getLong(3);
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

    public void ejbDeleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("delete from ana_uni_org_fat_rso_tab where cod_azl=? and cod_uni_org=?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbAddFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long COD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_uni_org_fat_rso_tab (cod_azl,cod_uni_org,cod_fat_rso) VALUES(?,?,?)");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.setLong(3, COD_FAT_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //</artur>
    //<alex "19/03/2004">
    public Collection ejbGetFattoriWithoutRischi(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select a.cod_fat_rso, a.nom_fat_rso, 0 from ana_fat_rso_tab a where 	a.cod_fat_rso not in (select distinct a.cod_fat_rso	from   ana_rso_tab a, rso_man_tab b where  a.cod_azl = b.cod_azl and a.cod_rso = b.cod_rso and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) and a.cod_fat_rso not in (select g.cod_fat_rso from ana_man_fat_rso_tab g where g.cod_man = ? and g.cod_azl = ?) union all select a.cod_fat_rso, a.nom_fat_rso, 1 from ana_fat_rso_tab a, ana_man_fat_rso_tab g where a.cod_fat_rso = g.cod_fat_rso and g.cod_man = ?	and g.cod_azl = ? and a.cod_fat_rso not in (select distinct a.cod_fat_rso from   ana_rso_tab a, rso_man_tab b where  a.cod_azl = b.cod_azl	and a.cod_rso = b.cod_rso	and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) order by 2");
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_MAN);
            ps.setLong(4, lCOD_AZL);
            ps.setLong(5, lCOD_MAN);
            ps.setLong(6, lCOD_AZL);
            ps.setLong(7, lCOD_MAN);
            ps.setLong(8, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FattoreRischio_View obj = new FattoreRischio_View();
                obj.COD_FAT_RSO = rs.getLong(1);
                obj.NOM_FAT_RSO = rs.getString(2);
                obj.lFlag = rs.getLong(3);
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

    public Collection ejbGetFattoriWithRischi4Categoria(long lCOD_CAG_FAT_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                    + "fat_rso.cod_fat_rso, "
                    + "fat_rso.nom_fat_rso, "
                    + "fat_rso.des_fat_rso "
                    + "FROM "
                    + "ana_fat_rso_tab fat_rso, "
                    + "ana_rso_tab rso "
                    + "WHERE "
                    + "fat_rso.cod_fat_rso = rso.cod_fat_rso "
                    + "AND fat_rso.cod_cag_fat_rso=? "
                    + "AND rso.cod_azl=? "
                    + "ORDER BY "
                    + "fat_rso.nom_fat_rso");
            ps.setLong(1, lCOD_CAG_FAT_RSO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                FattoreRischio_View v = new FattoreRischio_View();
                v.COD_FAT_RSO = rs.getLong(1);
                v.NOM_FAT_RSO = rs.getString(2);
                v.DES_FAT_RSO = rs.getString(3);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbDeleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("delete from ana_man_fat_rso_tab where cod_azl=? and cod_man=?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);
            ps.executeUpdate();
            bmp.close();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbAddFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_man_fat_rso_tab (cod_azl,cod_man,cod_fat_rso) VALUES(?,?,?)");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MAN);
            ps.setLong(3, lCOD_FAT_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</alex>

    public Collection findEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter) {
        return ejbFindEx(strNOM_FAT_RSO, strDES_FAT_RSO, lNUM_FAT_RSO, lCOD_CAG_FAT_RSO, lCOD_NOR_SEN, iOrderParameter);
    }

    public Collection ejbFindEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter) {
        String strSql = "SELECT cod_fat_rso, UPPER(nom_fat_rso) AS nom_fat_rso,des_fat_rso FROM ana_fat_rso_can_tab ";
        boolean ifWhere = false;
        if (strNOM_FAT_RSO != null) {
            strSql += " WHERE UPPER(nom_fat_rso) LIKE ? ";
            ifWhere = true;
        }
        if (strDES_FAT_RSO != null) {
            strSql += (ifWhere) ? " AND " : " WHERE ";
            strSql += "UPPER (des_fat_rso) LIKE ? ";
            ifWhere = true;
        }


        strSql += " ORDER BY 2 ";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strNOM_FAT_RSO != null) {
                ps.setString(i++, strNOM_FAT_RSO.toUpperCase());
            }
            if (strDES_FAT_RSO != null) {
                ps.setString(i++, strDES_FAT_RSO.toUpperCase());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                FattoreRischio_View obj = new FattoreRischio_View();
                obj.COD_FAT_RSO = rs.getLong(1);
                obj.NOM_FAT_RSO = rs.getString(2);
                obj.DES_FAT_RSO = rs.getString(3);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException("NUM_FAT_RSO= " + lNUM_FAT_RSO + "\nCOD_CAG= " + lCOD_CAG_FAT_RSO + "\nlCOD_NOR_SEN= " + lCOD_NOR_SEN + "\nSql= " + strSql + ex);
        } finally {
            bmp.close();
        }
    }
}//========================================================================

