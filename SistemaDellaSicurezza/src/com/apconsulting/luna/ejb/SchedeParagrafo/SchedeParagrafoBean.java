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
package com.apconsulting.luna.ejb.SchedeParagrafo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
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
public class SchedeParagrafoBean extends BMPEntityBean implements ISchedeParagrafo, ISchedeParagrafoHome {
    //---------------

    long COD_SCH_PRG;
    long COD_PRG;
    String TPL_SCH;
    //---------------
    long COD_MAC;
    long COD_UNI_ORG;
    long COD_UNI_SIC;
    long COD_SOS_CHI;
    long COD_MAN;
    long COD_LUO_FSC;
    long COD_FAT_RSO;
    long COD_IMM_3LV;
    long COD_PNO;
    long COD_MIS_PET;
    long COD_RSO;
    long COD_AZL;
    long COD_UNI_ORG_FK;
    //---------------
    byte STL_IND;

    private static SchedeParagrafoBean ys = null;

    private SchedeParagrafoBean() {
    }

    public static SchedeParagrafoBean getInstance(){
        if (ys==null) ys = new SchedeParagrafoBean();
        return ys;
    }

    // (Home Interface) create()
    public ISchedeParagrafo create(long lCOD_PRG, String strTPL_SCH) throws CreateException {
        SchedeParagrafoBean bean = new SchedeParagrafoBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_PRG, strTPL_SCH);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_PRG, strTPL_SCH);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        SchedeParagrafoBean iSchedeParagrafoBean = new SchedeParagrafoBean();
        try {
            Object obj = iSchedeParagrafoBean.ejbFindByPrimaryKey((Long) primaryKey);
            iSchedeParagrafoBean.setEntityContext(new EntityContextWrapper(obj));
            iSchedeParagrafoBean.ejbActivate();
            iSchedeParagrafoBean.ejbLoad();
            iSchedeParagrafoBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()

    public ISchedeParagrafo findByPrimaryKey(Long primaryKey) throws FinderException {
        SchedeParagrafoBean bean = new SchedeParagrafoBean();
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

    //---------- view
    public Collection getSchedeParagrafo_MAC_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_MAC_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_UNI_ORG_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_UNI_ORG_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_UNI_SIC_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_UNI_SIC_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_SOS_CHI_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_SOS_CHI_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_MAN_ViewU(long AZL_ID, long lCOD_UNI_ORG) {
        return ejbGetSchedeParagrafo_MAN_ViewU(AZL_ID, lCOD_UNI_ORG);
    }

    public Collection getSchedeParagrafo_LUO_FSC_ViewU(long AZL_ID, long lCOD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_LUO_FSC_ViewU(AZL_ID, lCOD_UNI_ORG);
    }

    public Collection getSchedeParagrafo_FAT_RSO_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_FAT_RSO_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_IMM_3LV_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_IMM_3LV_View(AZL_ID);
    }
    
    public Collection getSchedeParagrafo_PNO_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_PNO_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_MIS_PET_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_MIS_PET_View(AZL_ID);
    }

    public Collection getSchedeParagrafo_RSO_View(long AZL_ID) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_RSO_View(AZL_ID);
    }
    
    public Collection getSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_ByPRG_View(PRG_ID, strTYPE);
    }
    
    public boolean existSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE) {
        return (new SchedeParagrafoBean()).ejbExistSchedeParagrafo_ByPRG_View(PRG_ID, strTYPE);
    }

    public Collection getSchedeParagrafo_GetType_View_BASE(long PRG_ID, long lCOD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_GetType_View_BASE(PRG_ID, lCOD_UNI_ORG);
    }
    
    public Collection getSchedeParagrafo_GetType_View_DESC(long PRG_ID, long lCOD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_GetType_View_DESC(PRG_ID, lCOD_UNI_ORG);
    }

    //---by Juli---
    public Collection getSchedeParagrafo_GetType_View_ALL(long PRG_ID, long lCOD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_GetType_View_ALL(PRG_ID, lCOD_UNI_ORG);
    }

    public Collection getSchedeParagrafo_MAC_View(long AZL_ID, long COD_MAC) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_MAC_View(AZL_ID, COD_MAC);
    }

    public Collection getSchedeParagrafo_UNI_ORG_View(long AZL_ID, long COD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_UNI_ORG_View(AZL_ID, COD_UNI_ORG);
    }

    public Collection getSchedeParagrafo_UNI_SIC_View(long AZL_ID, long COD_UNI_SIC) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_UNI_SIC_View(AZL_ID, COD_UNI_SIC);
    }

    public Collection getSchedeParagrafo_SOS_CHI_View(long AZL_ID, long COD_SOS_CHI) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_SOS_CHI_View(AZL_ID, COD_SOS_CHI);
    }

    public Collection getSchedeParagrafo_MAN_View(long AZL_ID, long COD_MAN) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_MAN_View(AZL_ID, COD_MAN);
    }

    public Collection getSchedeParagrafo_LUO_FSC_View(long AZL_ID, long COD_LUO_FSC) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_LUO_FSC_View(AZL_ID, COD_LUO_FSC);
    }

    public Collection getSchedeParagrafo_FAT_RSO_View(long AZL_ID, long COD_FAT_RSO) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_FAT_RSO_View(AZL_ID, COD_FAT_RSO);
    }
    
    public Collection getSchedeParagrafo_IMM_3LV_View(long AZL_ID, long COD_IMM) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_IMM_3LV_View(AZL_ID, COD_IMM);
    }
    
    public Collection getSchedeParagrafo_PNO_View(long AZL_ID, long COD_PNO) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_PNO_View(AZL_ID, COD_PNO);
    }

    public Collection getSchedeParagrafo_MIS_PET_View(long AZL_ID, long COD_MIS_PET) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_MIS_PET_View(AZL_ID, COD_MIS_PET);
    }
    
    public Collection getSchedeParagrafo_RSO_View(long AZL_ID, long COD_RSO) {
        return (new SchedeParagrafoBean()).ejbGetSchedeParagrafo_RSO_View(AZL_ID, COD_RSO);
    }

    //<report>
    public Collection getReportSchedeParagrafo_GetType_View(long PRG_ID, String strType, long lCOD_UNI_ORG) {
        return (new SchedeParagrafoBean()).ejbGetReportSchedeParagrafo_GetType_View(PRG_ID, strType, lCOD_UNI_ORG);
    }
    //</report>

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</ISchedeParagrafoHome-implementation>
    public Long ejbCreate(long lCOD_PRG, String strTPL_SCH) {
        this.COD_PRG = lCOD_PRG;
        this.TPL_SCH = strTPL_SCH;
        this.COD_SCH_PRG = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_sch_prg_tab (cod_sch_prg,cod_prg,tpl_sch) VALUES(?,?,?)");
            ps.setLong(1, COD_SCH_PRG);
            ps.setLong(2, COD_PRG);
            ps.setString(3, TPL_SCH);
            ps.executeUpdate();
            return new Long(COD_SCH_PRG);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_PRG, String strTPL_SCH) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_prg FROM ana_sch_prg_tab ");
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
        this.COD_SCH_PRG = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_SCH_PRG = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT * FROM ana_sch_prg_tab WHERE cod_sch_prg=?");
            ps.setLong(1, COD_SCH_PRG);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_SCH_PRG = rs.getLong("COD_SCH_PRG");
                this.COD_PRG = rs.getLong("COD_PRG");
                this.TPL_SCH = rs.getString("TPL_SCH");
                this.COD_MAC = rs.getLong("COD_MAC");
                this.COD_UNI_ORG = rs.getLong("COD_UNI_ORG");
                this.COD_UNI_SIC = rs.getLong("COD_UNI_SIC");
                this.COD_SOS_CHI = rs.getLong("COD_SOS_CHI");
                this.COD_LUO_FSC = rs.getLong("COD_LUO_FSC");
                this.COD_FAT_RSO = rs.getLong("COD_FAT_RSO");
                this.COD_IMM_3LV = rs.getLong("COD_IMM_3LV");
                this.COD_PNO = rs.getLong("COD_PNO");
                this.COD_MIS_PET = rs.getLong("COD_MIS_PET");
                this.COD_RSO = rs.getLong("COD_RSO");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.COD_MAN = rs.getLong("COD_MAN");
                this.COD_UNI_ORG_FK = rs.getLong("COD_UNI_ORG_FK");
                this.STL_IND = rs.getByte("STL_IND");
            } else {
                throw new NoSuchEntityException("COD_SCH_PRG con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sch_prg_tab  WHERE cod_sch_prg=?");
            ps.setLong(1, COD_SCH_PRG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
                    "UPDATE "
                        + "ana_sch_prg_tab "
                    + "SET "
                        + "cod_sch_prg=?, "
                        + "cod_prg=?, "
                        + "tpl_sch=?, "
                        + "cod_mac=?, "
                        + "cod_uni_org=?, "
                        + "cod_uni_sic=?, "
                        + "cod_sos_chi=?, "
                        + "cod_man=?, "
                        + "cod_luo_fsc=?, "
                        + "cod_fat_rso=?, "
                        + "cod_imm_3lv=?, "
                        + "cod_pno=?, "
                        + "cod_mis_pet=?, "
                        + "cod_rso=?, "
                        + "cod_azl=?, "
                        + "cod_uni_org_fk=?, "
                        + "stl_ind=? "
                    + "WHERE "
                        + "cod_sch_prg=?");
            ps.setLong(1, COD_SCH_PRG);
            ps.setLong(2, COD_PRG);
            ps.setString(3, TPL_SCH);
            if (COD_MAC == 0) {
                ps.setNull(4, java.sql.Types.BIGINT);
            } else {
                ps.setLong(4, COD_MAC);
            }
            if (COD_UNI_ORG == 0) {
                ps.setNull(5, java.sql.Types.BIGINT);
            } else {
                ps.setLong(5, COD_UNI_ORG);
            }
            if (COD_UNI_SIC == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, COD_UNI_SIC);
            }
            if (COD_SOS_CHI == 0) {
                ps.setNull(7, java.sql.Types.BIGINT);
            } else {
                ps.setLong(7, COD_SOS_CHI);
            }
            if (COD_MAN == 0) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setLong(8, COD_MAN);
            }
            if (COD_LUO_FSC == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, COD_LUO_FSC);
            }
            if (COD_FAT_RSO == 0) {
                ps.setNull(10, java.sql.Types.BIGINT);
            } else {
                ps.setLong(10, COD_FAT_RSO);
            }
            if (COD_IMM_3LV == 0) {
                ps.setNull(11, java.sql.Types.BIGINT);
            } else {
                ps.setLong(11, COD_IMM_3LV);
            }
            if (COD_PNO == 0) {
                ps.setNull(12, java.sql.Types.BIGINT);
            } else {
                ps.setLong(12, COD_PNO);
            }
            if (COD_MIS_PET == 0) {
                ps.setNull(13, java.sql.Types.BIGINT);
            } else {
                ps.setLong(13, COD_MIS_PET);
            }
            if (COD_RSO == 0) {
                ps.setNull(14, java.sql.Types.BIGINT);
            } else {
                ps.setLong(14, COD_RSO);
            }
            if (COD_AZL == 0) {
                ps.setNull(15, java.sql.Types.BIGINT);
            } else {
                ps.setLong(15, COD_AZL);
            }
            ps.setLong(16, COD_UNI_ORG_FK);
            
            // Elementi di formattazione - Inizio
            if (STL_IND == 0) {
                ps.setNull(17, java.sql.Types.SMALLINT);
            } else {
                ps.setByte(17, STL_IND);
            }
            // Elementi di formattazione - Fine
            
            ps.setLong(18, COD_SCH_PRG);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ID= non è trovata");
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
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
    public long getCOD_SCH_PRG() {
        return COD_SCH_PRG;
    }
    //2
    //3

    public void setCOD_PRG(long newCOD_PRG) {
        if (COD_PRG == newCOD_PRG) {
            return;
        }
        COD_PRG = newCOD_PRG;
        setModified();
    }

    public long getCOD_PRG() {
        return COD_PRG;
    }
    //4

    public void setTPL_SCH(String newTPL_SCH) {
        if (TPL_SCH.equals(newTPL_SCH)) {
            return;
        }
        TPL_SCH = newTPL_SCH;
        setModified();
    }

    public String getTPL_SCH() {
        return TPL_SCH;
    }
    //============================================
    // not required field
    //5

    public void setCOD_MAC(long newCOD_MAC) {
        if ((COD_MAC != 0) && (COD_MAC == (newCOD_MAC))) {
            return;
        }
        COD_MAC = newCOD_MAC;
        setModified();
    }

    public long getCOD_MAC() {
        return COD_MAC;
    }

    public void setCOD_UNI_ORG(long newCOD_UNI_ORG) {
        if ((COD_UNI_ORG != 0) && (COD_UNI_ORG == (newCOD_UNI_ORG))) {
            return;
        }
        COD_UNI_ORG = newCOD_UNI_ORG;
        setModified();
    }

    public long getCOD_UNI_ORG() {
        return COD_UNI_ORG;
    }

    public void setCOD_UNI_SIC(long newCOD_UNI_SIC) {
        if ((COD_UNI_SIC != 0) && (COD_UNI_SIC == (newCOD_UNI_SIC))) {
            return;
        }
        COD_UNI_SIC = newCOD_UNI_SIC;
        setModified();
    }

    public long getCOD_UNI_SIC() {
        return COD_UNI_SIC;
    }

    public void setCOD_SOS_CHI(long newCOD_SOS_CHI) {
        if ((COD_SOS_CHI != 0) && (COD_SOS_CHI == (newCOD_SOS_CHI))) {
            return;
        }
        COD_SOS_CHI = newCOD_SOS_CHI;
        setModified();
    }

    public long getCOD_SOS_CHI() {
        return COD_SOS_CHI;
    }

    public void setCOD_MAN(long newCOD_MAN) {
        if ((COD_MAN != 0) && (COD_MAN == (newCOD_MAN))) {
            return;
        }
        COD_MAN = newCOD_MAN;
        setModified();
    }

    public long getCOD_MAN() {
        return COD_MAN;
    }

    public void setCOD_LUO_FSC(long newCOD_LUO_FSC) {
        if ((COD_LUO_FSC != 0) && (COD_LUO_FSC == (newCOD_LUO_FSC))) {
            return;
        }
        COD_LUO_FSC = newCOD_LUO_FSC;
        setModified();
    }

    public long getCOD_LUO_FSC() {
        return COD_LUO_FSC;
    }

    public void setCOD_FAT_RSO(long newCOD_FAT_RSO) {
        if ((COD_FAT_RSO != 0) && (COD_FAT_RSO == (newCOD_FAT_RSO))) {
            return;
        }
        COD_FAT_RSO = newCOD_FAT_RSO;
        setModified();
    }

    public long getCOD_FAT_RSO() {
        return COD_FAT_RSO;
    }

    public void setCOD_IMM_3LV(long newCOD_IMM_3LV) {
        if ((COD_IMM_3LV != 0) && (COD_IMM_3LV == (newCOD_IMM_3LV))) {
            return;
        }
        COD_IMM_3LV = newCOD_IMM_3LV;
        setModified();
    }

    public long getCOD_IMM_3LV() {
        return COD_IMM_3LV;
    }

    public void setCOD_PNO(long newCOD_PNO) {
        if ((COD_PNO != 0) && (COD_PNO == (newCOD_PNO))) {
            return;
        }
        COD_PNO = newCOD_PNO;
        setModified();
    }

    public long getCOD_PNO() {
        return COD_PNO;
    }

    public void setCOD_MIS_PET(long newCOD_MIS_PET) {
        if ((COD_MIS_PET != 0) && (COD_MIS_PET == (newCOD_MIS_PET))) {
            return;
        }
        COD_MIS_PET = newCOD_MIS_PET;
        setModified();
    }

    public long getCOD_MIS_PET() {
        return COD_MIS_PET;
    }

    public void setCOD_RSO(long newCOD_RSO) {
        if ((COD_RSO != 0) && (COD_RSO == (newCOD_RSO))) {
            return;
        }
        COD_RSO = newCOD_RSO;
        setModified();
    }

    public long getCOD_RSO() {
        return COD_RSO;
    }

    public void setCOD_AZL(long newCOD_AZL) {
        if ((COD_AZL != 0) && (COD_AZL == (newCOD_AZL))) {
            return;
        }
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }
    
    public void setCOD_UNI_ORG_FK(long newCOD_UNI_ORG_FK) {
        if (COD_UNI_ORG_FK == newCOD_UNI_ORG_FK) {
            return;
        }
        COD_UNI_ORG_FK = newCOD_UNI_ORG_FK;
        setModified();
    }
    
    public void setSTL_IND(byte newSTL_IND) {
        if ((STL_IND != 0) && (STL_IND == (newSTL_IND))) {
            return;
        }
        STL_IND = newSTL_IND;
        setModified();
    }

    public byte getSTL_IND() {
        return STL_IND;
    }
    //</comment>

    public Collection ejbGetSchedeParagrafo_MAC_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT "
                        + "cod_mac, "
                        + "des_mac "
                    + "FROM "
                        + "ana_mac_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "des_mac");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MAC_View obj = new SchedeParagrafo_MAC_View();
                obj.COD_MAC = rs.getLong(1);
                obj.DES_MAC = rs.getString(2);
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
    //

    public Collection ejbGetSchedeParagrafo_UNI_ORG_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_uni_org, "
                        + "nom_uni_org "
                    + "FROM "
                        + "ana_uni_org_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "nom_uni_org");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_UNI_ORG_View obj = new SchedeParagrafo_UNI_ORG_View();
                obj.COD_UNI_ORG = rs.getLong(1);
                obj.NOM_UNI_ORG = rs.getString(2);
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
    //Create View dlya Presidi

    public Collection ejbGetSchedeParagrafo_UNI_SIC_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_uni_sic, "
                        + "nom_uni_sic "
                    + "FROM "
                        + "ana_uni_sic_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "nom_uni_sic");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_UNI_SIC_View obj = new SchedeParagrafo_UNI_SIC_View();
                obj.COD_UNI_SIC = rs.getLong(1);
                obj.NOM_UNI_SIC = rs.getString(2);
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
    //

    public Collection ejbGetSchedeParagrafo_SOS_CHI_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT "
                        + "a.cod_sos_chi, "
                        + "a.nom_com_sos "
                    + "FROM "
                        + "ana_sos_chi_tab a, "
                        + "rso_sos_chi_tab b "
                    + "WHERE "
                        + "b.cod_azl=? "
                        + "AND a.cod_sos_chi=b.cod_sos_chi "
                    + "ORDER BY "
                        + "nom_com_sos");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_SOS_CHI_View obj = new SchedeParagrafo_SOS_CHI_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_MAN_ViewU(long AZL_ID, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = null;
            if (lCOD_UNI_ORG == 0) {
                ps = bmp.prepareStatement(
                        "SELECT "
                            + "cod_man, "
                            + "nom_man "
                        + "FROM "
                            + "ana_man_tab "
                        + "WHERE "
                            + "cod_azl=? "
                        + "ORDER BY "
                            + "nom_man");
                ps.setLong(1, AZL_ID);
            } else {
                ps = bmp.prepareStatement(
                        "select "
                            + "am.cod_man, "
                            + "am.nom_man "
                        + "from "
                            + "ana_man_tab am, "
                            + "man_uni_org_tab mu "
                        + "where "
                            + "mu.cod_uni_org = ? "
                            + "and mu.cod_man=am.cod_man "
                        + "ORDER BY "
                            + "nom_man");
                ps.setLong(1, lCOD_UNI_ORG);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MAN_View obj = new SchedeParagrafo_MAN_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_LUO_FSC_ViewU(long AZL_ID, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            ResultSet rs = null;
            if (lCOD_UNI_ORG == 0) {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT "
                            + "cod_luo_fsc, "
                            + "nom_luo_fsc "
                        + "FROM "
                            + "ana_luo_fsc_tab "
                        + "WHERE "
                            + "cod_azl=? "
                        + "ORDER BY "
                            + "nom_luo_fsc");
                ps.setLong(1, AZL_ID);
                rs = ps.executeQuery();
            } else {
                PreparedStatement ps = bmp.prepareStatement(
                        "select "
                            + "lf.cod_luo_fsc, "
                            + "lf.nom_luo_fsc "
                        + "from "
                            + "ana_luo_fsc_tab lf, "
                            + "uni_org_luo_fsc_tab uo "
                        + "where "
                            + "uo.cod_luo_fsc = lf.cod_luo_fsc "
                            + "and uo.cod_uni_org=? "
                        + "ORDER BY "
                            + "nom_luo_fsc");
                ps.setLong(1, lCOD_UNI_ORG);
                rs = ps.executeQuery();
            }

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_LUO_FSC_View obj = new SchedeParagrafo_LUO_FSC_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_FAT_RSO_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "distinct(a.cod_fat_rso), " +
                        "a.nom_fat_rso " +
                    "FROM " +
                        "ana_fat_rso_tab a, " +
                        "ana_rso_tab b " +
                    "WHERE " +
                        "a.cod_fat_rso=b.cod_fat_rso " +
                        "AND b.cod_azl=? " +
                    "ORDER BY " +
                        "a.nom_fat_rso");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_FAT_RSO_View obj = new SchedeParagrafo_FAT_RSO_View();
                obj.COD_FAT_RSO = rs.getLong(1);
                obj.NOM_FAT_RSO = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_IMM_3LV_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_imm, "
                        + "nom_imm "
                    + "FROM "
                        + "ana_imm_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "nom_imm");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_IMM_3LV_View obj = new SchedeParagrafo_IMM_3LV_View();
                obj.COD_IMM = rs.getLong(1);
                obj.NOM_IMM = rs.getString(2);
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
    
    public Collection ejbGetSchedeParagrafo_PNO_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_pno, "
                        + "nom_pno "
                    + "FROM "
                        + "ana_pno_tab "
                    + "ORDER BY "
                        + "nom_pno");
            /*
             * Parte commentata in quanto la tabella dei piani è comune 
             * a tutte le aziende.
             * Sarebbe stato possibile utilizzare il metodo "findAll" del bean
             * "Piano".
             * E' stato scelto di utilizzare questo metodo per omogeneità
             * con le modalità di realizzazione delle altre tipologie
             * di schede paragrafo, per una migliore lettura e manutenzione
             * del codice.
             */
            // + "WHERE cod_azl=?"
            // ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_PNO_View obj = new SchedeParagrafo_PNO_View();
                obj.COD_PNO = rs.getLong(1);
                obj.NOM_PNO = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_MIS_PET_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_mis_pet, "
                        + "nom_mis_pet "
                    + "FROM "
                        + "ana_mis_pet_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "nom_mis_pet");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MIS_PET_View obj = new SchedeParagrafo_MIS_PET_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
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
    
    public Collection ejbGetSchedeParagrafo_RSO_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "fat_rso.nom_fat_rso "
                    + "FROM "
                        + "ana_rso_tab rso, "
                        + "ana_fat_rso_tab fat_rso "
                    + "WHERE "
                        + "rso.cod_fat_rso=fat_rso.cod_fat_rso "
                        + "and rso.cod_azl=? "
                    + "ORDER BY "
                        + "fat_rso.nom_fat_rso, "
                        + "rso.nom_rso");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_RSO_View obj = new SchedeParagrafo_RSO_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
                obj.NOM_FAT_RSO = rs.getString(3);
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
    //
    
    public Collection ejbGetSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_sch_prg, "
                        + "cod_mac, "
                        + "cod_uni_org, "
                        + "cod_uni_sic, "
                        + "cod_sos_chi, "
                        + "cod_man, "
                        + "cod_luo_fsc, "
                        + "cod_fat_rso, "
                        + "cod_imm_3lv, "
                        + "cod_pno, "
                        + "cod_mis_pet, "
                        + "cod_rso, "
                        + "cod_azl, "
                        + "stl_ind "
                    + "FROM "
                        + "ana_sch_prg_tab "
                    + "WHERE "
                        + "cod_prg=? "
                        + "and tpl_sch=?");
            ps.setLong(1, PRG_ID);
            ps.setString(2, strTYPE);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_ByPRG_View obj = new SchedeParagrafo_ByPRG_View();
                obj.COD_SCH_PRG = rs.getLong(1);
                obj.COD_MAC = rs.getLong(2);
                obj.COD_UNI_ORG = rs.getLong(3);
                obj.COD_UNI_SIC = rs.getLong(4);
                obj.COD_SOS_CHI = rs.getLong(5);
                obj.COD_MAN = rs.getLong(6);
                obj.COD_LUO_FSC = rs.getLong(7);
                obj.COD_FAT_RSO = rs.getLong(8);
                obj.COD_IMM_3LV = rs.getLong(9);
                obj.COD_PNO = rs.getLong(10);
                obj.COD_MIS_PET = rs.getLong(11);
                obj.COD_RSO = rs.getLong(12);
                obj.COD_AZL = rs.getLong(13);
                obj.STL_IND = rs.getByte(14);
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

    //<report>
    public Collection ejbGetReportSchedeParagrafo_GetType_View(long PRG_ID, String strType, long lCOD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = null;
            if (TipoParagrafo.ATTIVITA_LAVORATIVA.getType().equals(strType) || 
                TipoParagrafo.LUOGO_FISICO.getType().equals(strType)) {
                ps = bmp.prepareStatement(
                        "SELECT "
                            + "cod_sch_prg, "
                            + "tpl_sch, "
                            + "cod_mac, "
                            + "cod_uni_org, "
                            + "cod_uni_sic, "
                            + "cod_sos_chi, "
                            + "cod_man, "
                            + "cod_luo_fsc, "
                            + "cod_fat_rso "
                        + "FROM "
                            + "ana_sch_prg_tab "
                        + "WHERE "
                            + "cod_prg=? "
                            + "AND tpl_sch=? "
                            + "AND cod_uni_org_fk=? ");
                ps.setLong(1, PRG_ID);
                ps.setString(2, strType);
                ps.setLong(3, lCOD_UNI_ORG);
            } else {
                ps = bmp.prepareStatement(
                        "SELECT "
                            + "cod_sch_prg, "
                            + "tpl_sch, "
                            + "cod_mac, "
                            + "cod_uni_org, "
                            + "cod_uni_sic, "
                            + "cod_sos_chi, "
                            + "cod_man, "
                            + "cod_luo_fsc, "
                            + "cod_fat_rso "
                        + "FROM "
                            + "ana_sch_prg_tab "
                        + "WHERE "
                            + "cod_prg=? "
                            + "AND tpl_sch=? ");
                ps.setLong(1, PRG_ID);
                ps.setString(2, strType);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_GetType_View obj = new SchedeParagrafo_GetType_View();
                obj.COD_SCH_PRG = rs.getLong(1);
                obj.TPL_SCH = rs.getString(2);
                obj.COD_MAC = rs.getLong(3);
                obj.COD_UNI_ORG = rs.getLong(4);
                obj.COD_UNI_SIC = rs.getLong(5);
                obj.COD_SOS_CHI = rs.getLong(6);
                obj.COD_MAN = rs.getLong(7);
                obj.COD_LUO_FSC = rs.getLong(8);
                obj.COD_FAT_RSO = rs.getLong(9);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</report>

    public Collection ejbGetSchedeParagrafo_GetType_View_BASE(long PRG_ID, long lCOD_UNI_ORG) {

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_sch_prg, " +
                        "tpl_sch, " +
                        "cod_mac, " +
                        "cod_uni_org, " +
                        "cod_uni_sic, " +
                        "cod_sos_chi, " +
                        "cod_man, " +
                        "cod_luo_fsc, " +
                        "cod_fat_rso, " +
                        "cod_uni_org_fk " +
                    "FROM " +
                        "ana_sch_prg_tab " +
                    "WHERE " +
                        "cod_prg=? " +
                        "and tpl_sch not in (" + TipoParagrafo.valuesType_DESC_4sql() + ") " +
                    "order by " +
                        "tpl_sch");
            ps.setLong(1, PRG_ID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_GetType_View obj = new SchedeParagrafo_GetType_View();
                obj.COD_SCH_PRG = rs.getLong(1);
                obj.TPL_SCH = rs.getString(2);
                obj.COD_MAC = rs.getLong(3);
                obj.COD_UNI_ORG = rs.getLong(4);
                obj.COD_UNI_SIC = rs.getLong(5);
                obj.COD_SOS_CHI = rs.getLong(6);
                obj.COD_MAN = rs.getLong(7);
                obj.COD_LUO_FSC = rs.getLong(8);
                obj.COD_FAT_RSO = rs.getLong(9);
                if (    TipoParagrafo.ATTIVITA_LAVORATIVA.getType().equals(obj.TPL_SCH) || 
                        TipoParagrafo.LUOGO_FISICO.getType().equals(obj.TPL_SCH)) {
                    if (lCOD_UNI_ORG != rs.getLong(10)) {
                        continue;
                    }
                }
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
    
    public Collection ejbGetSchedeParagrafo_GetType_View_DESC(long PRG_ID, long lCOD_UNI_ORG) {

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_sch_prg, " +
                        "tpl_sch, " +
                        "cod_mac, " +
                        "cod_uni_org, " +
                        "cod_uni_sic, " +
                        "cod_man, " +
                        "cod_luo_fsc, " +
                        "cod_imm_3lv, " +
                        "cod_pno, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "cod_mis_pet, " +
                        "cod_uni_org_fk, " +
                        "stl_ind " +
                    "FROM " +
                        "ana_sch_prg_tab " +
                    "WHERE " +
                        "cod_prg=? " +
                        "and tpl_sch in (" + TipoParagrafo.valuesType_DESC_4sql() + ") " +
                    "order by " +
                        "cod_sch_prg");
            ps.setLong(1, PRG_ID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_GetType_View obj = new SchedeParagrafo_GetType_View();
                obj.COD_SCH_PRG = rs.getLong(1);
                obj.TPL_SCH = rs.getString(2);
                obj.COD_MAC = rs.getLong(3);
                obj.COD_UNI_ORG = rs.getLong(4);
                obj.COD_UNI_SIC = rs.getLong(5);
                obj.COD_MAN = rs.getLong(6);
                obj.COD_LUO_FSC = rs.getLong(7);
                obj.COD_IMM_3LV = rs.getLong(8);
                obj.COD_PNO = rs.getLong(9);
                obj.COD_RSO = rs.getLong(10);
                obj.COD_AZL = rs.getLong(11);
                obj.COD_MIS_PET = rs.getLong(12);
                if (    TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType().equals(obj.TPL_SCH) || 
                        TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType().equals(obj.TPL_SCH)) {
                    if (lCOD_UNI_ORG != rs.getLong(13)) {
                        continue;
                    }
                }
                obj.STL_IND = rs.getByte(14);
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
    
//Create by Juli
    public Collection ejbGetSchedeParagrafo_GetType_View_ALL(long PRG_ID, long lCOD_UNI_ORG) {
        ArrayList returnCollection = new ArrayList();
        Collections.addAll(returnCollection, this.getSchedeParagrafo_GetType_View_BASE(PRG_ID, lCOD_UNI_ORG).toArray());
        Collections.addAll(returnCollection, this.getSchedeParagrafo_GetType_View_DESC(PRG_ID, lCOD_UNI_ORG).toArray());
        return returnCollection;
    }

    public Collection ejbGetSchedeParagrafo_MAC_View(long AZL_ID, long COD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mac, des_mac FROM ana_mac_tab  WHERE cod_azl=? AND cod_mac=? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MAC_View obj = new SchedeParagrafo_MAC_View();
                obj.COD_MAC = rs.getLong(1);
                obj.DES_MAC = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_UNI_ORG_View(long AZL_ID, long COD_UNI_ORG) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_org, nom_uni_org FROM ana_uni_org_tab  WHERE  cod_azl=? AND cod_uni_org=? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_UNI_ORG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_UNI_ORG_View obj = new SchedeParagrafo_UNI_ORG_View();
                obj.COD_UNI_ORG = rs.getLong(1);
                obj.NOM_UNI_ORG = rs.getString(2);
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
//   Create View dlya Presidi

    public Collection ejbGetSchedeParagrafo_UNI_SIC_View(long AZL_ID, long COD_UNI_SIC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_uni_sic, nom_uni_sic FROM ana_uni_sic_tab WHERE cod_azl=? AND cod_uni_sic=? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_UNI_SIC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_UNI_SIC_View obj = new SchedeParagrafo_UNI_SIC_View();
                obj.COD_UNI_SIC = rs.getLong(1);
                obj.NOM_UNI_SIC = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_SOS_CHI_View(long AZL_ID, long COD_SOS_CHI) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT a.cod_sos_chi, a.nom_com_sos FROM ana_sos_chi_tab a, rso_sos_chi_tab b WHERE b.cod_azl=? AND a.cod_sos_chi=b.cod_sos_chi AND a.cod_sos_chi=?  ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_SOS_CHI);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_SOS_CHI_View obj = new SchedeParagrafo_SOS_CHI_View();
                obj.COD_SOS_CHI = rs.getLong(1);
                obj.NOM_COM_SOS = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_MAN_View(long AZL_ID, long COD_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_man, nom_man FROM ana_man_tab WHERE cod_azl=? AND cod_man=? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_MAN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MAN_View obj = new SchedeParagrafo_MAN_View();
                obj.COD_MAN = rs.getLong(1);
                obj.NOM_MAN = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_LUO_FSC_View(long AZL_ID, long COD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_luo_fsc, "
                        + "nom_luo_fsc "
                    + "FROM "
                        + "ana_luo_fsc_tab "
                    + "WHERE "
                        + "cod_azl=? "
                        + "AND cod_luo_fsc=? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_LUO_FSC_View obj = new SchedeParagrafo_LUO_FSC_View();
                obj.COD_LUO_FSC = rs.getLong(1);
                obj.NOM_LUO_FSC = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_FAT_RSO_View(long AZL_ID, long COD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "distinct(a.cod_fat_rso), " +
                        "a.nom_fat_rso " +
                    "FROM " +
                        "ana_fat_rso_tab a, " +
                        "ana_rso_tab b " +
                    "WHERE " +
                        "a.cod_fat_rso=b.cod_fat_rso " +
                        "AND a.cod_fat_rso=? " +
                        "AND b.cod_azl=?");
            ps.setLong(1, COD_FAT_RSO);
            ps.setLong(2, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_FAT_RSO_View obj = new SchedeParagrafo_FAT_RSO_View();
                obj.COD_FAT_RSO = rs.getLong(1);
                obj.NOM_FAT_RSO = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_IMM_3LV_View(long AZL_ID, long COD_IMM) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT "
                        + "cod_imm, "
                        + "nom_imm "
                    + "FROM "
                        + "ana_imm_tab "
                    + "WHERE "
                        + "cod_azl=? "
                        + "AND cod_imm=?");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_IMM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_IMM_3LV_View obj = new SchedeParagrafo_IMM_3LV_View();
                obj.COD_IMM = rs.getLong(1);
                obj.NOM_IMM = rs.getString(2);
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
    
    public Collection ejbGetSchedeParagrafo_PNO_View(long AZL_ID, long COD_PNO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_pno, "
                        + "nom_pno "
                    + "FROM "
                        + "ana_pno_tab "
                    + "WHERE "
            /*
             * Parte commentata in quanto la tabella dei piani è comune 
             * a tutte le aziende.
             * Sarebbe stato possibile utilizzare il metodo "findByPrimaryKey" 
             * del bean "Piano".
             * E' stato scelto di utilizzare questo metodo per omogeneità
             * con le modalità di realizzazione delle altre tipologie
             * di schede paragrafo, per una migliore lettura e manutenzione
             * del codice.
             */
                        // + "cod_azl=? AND "
                        + "cod_pno=?");
            // ps.setLong(1, AZL_ID);
            ps.setLong(1, COD_PNO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_PNO_View obj = new SchedeParagrafo_PNO_View();
                obj.COD_PNO = rs.getLong(1);
                obj.NOM_PNO = rs.getString(2);
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
    
    public Collection ejbGetSchedeParagrafo_MIS_PET_View(long AZL_ID, long COD_MIS_PET) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_mis_pet, "
                        + "nom_mis_pet "
                    + "FROM "
                        + "ana_mis_pet_tab "
                    + "WHERE "
                        + "cod_azl=? AND "
                        + "cod_mis_pet=?");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_MIS_PET);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_MIS_PET_View obj = new SchedeParagrafo_MIS_PET_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
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

    public Collection ejbGetSchedeParagrafo_RSO_View(long AZL_ID, long COD_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_rso, "
                        + "nom_rso "
                    + "FROM "
                        + "ana_rso_tab "
                    + "WHERE "
                        + "cod_azl=? AND "
                        + "cod_rso=?");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, COD_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SchedeParagrafo_RSO_View obj = new SchedeParagrafo_RSO_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
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
    
    public boolean ejbExistSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_sch_prg "
                    + "FROM "
                        + "ana_sch_prg_tab a "
                    + "WHERE "
                        + "a.cod_prg=? "
                        + "AND a.tpl_sch=? ");
            ps.setLong(1, PRG_ID);
            ps.setString(2, strTYPE);
            ResultSet rs = ps.executeQuery();
            boolean res = false;
            if (rs.next()) {
                res = true;
            }
            bmp.close();
            return res;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //------------- For Tabi Gestione Schede dei Paragrafi-----------
    public String BuildSchedeParagrafoTab(long lCOD_PRG, long lCOD_AZL, long lCOD_UNI_ORG1111) {
        return new SchedeParagrafoUtil().BuildSchedeParagrafoTab(this, lCOD_PRG, lCOD_AZL, lCOD_UNI_ORG1111);
    }
    //------------- For Tabi Gestione Schede dei Paragrafi-----------
    
    public boolean checkBloccoDescrizioni(String tipoScheda){
        return
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_ATTIVITA_LAVORATIVA.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_IMMOBILI.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_LUOGO_FISICO.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_MACCHINA_ATTREZZATURA.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_MISURA_PP.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_PIANI.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_RISCHI.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_UNITA_ORGANIZZATIVA.getType()) ||
                tipoScheda.equals(TipoParagrafo.DESCRIZIONI_UNITA_SICUREZZA.getType());
    }
}
