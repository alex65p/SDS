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

package com.apconsulting.luna.ejb.AnagrDisposizioni;

import com.apconsulting.luna.ejb.AssociativaAgentoChimico.Rischi_View;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Alessandro
 */
public class AnagrDisposizioniBean extends BMPEntityBean implements IAnagrDisposizioniHome, IAnagrDisposizioni{

    long lCOD_DSP;
    String strDES;
    String strNOM_DSP;


    private static AnagrDisposizioniBean ys = null;

    private AnagrDisposizioniBean() {
    }

    public static AnagrDisposizioniBean getInstance() {
        if (ys == null) {
            ys = new AnagrDisposizioniBean();
        }
        return ys;
    }
    
         public Collection getRischi_View(long lCOD_DSP, long lCOD_AZL) {
        return (new AnagrDisposizioniBean()).ejbGetRischi_View(lCOD_DSP, lCOD_AZL);
    }
         
         public Collection ejbGetRischi_View(long lCOD_DSP, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT rso.cod_rso, rso.nom_rso, fat.nom_fat_rso FROM ana_rso_can_tab rso, rso_dsp_tab dsprso, ana_fat_rso_can_tab fat WHERE rso.cod_rso = dsprso.cod_rso AND dsprso.cod_azl = rso.cod_azl AND dsprso.cod_azl = ? AND dsprso.cod_dsp = ? AND rso.cod_fat_rso = fat.cod_fat_rso ORDER BY nom_rso");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_DSP);            
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Rischi_View obj = new Rischi_View();
                obj.COD_RSO = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
                obj.NOM_FAT_RSO = rs.getString(3);

                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
         
         
         
            public void deleteRischio(long lCOD_RSO, long lCOD_DSP) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_dsp_tab WHERE cod_rso=? AND cod_dsp=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_DSP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio con ID=" + lCOD_RSO + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
         
    public IAnagrDisposizioni create(String strDES, String strNOM_DSP) throws CreateException {
        AnagrDisposizioniBean bean = new AnagrDisposizioniBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES, strNOM_DSP);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES,strNOM_DSP);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

       public String getstrNOM_DSP() {
        return strNOM_DSP;
    }
       
        public void setstrNOM_DSP(String newstrNOM_DSP) {
        if (strNOM_DSP != null) {
            if (strNOM_DSP.equals(newstrNOM_DSP)) {
                return;
            }
        }
        
          strNOM_DSP = newstrNOM_DSP;
            setModified();
        }
       
    
        
        public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO rso_dsp_tab(cod_dsp,cod_rso,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lCOD_DSP);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            //ps.setString (4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
        
        
     @Override
    public void remove(Object primaryKey) {
        AnagrDisposizioniBean bean = new AnagrDisposizioniBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

     public IAnagrDisposizioni findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrDisposizioniBean bean = new AnagrDisposizioniBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
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

public Long ejbCreate(String strDES, String strNOM_DSP) {
        this.strDES = strDES;
        this.strNOM_DSP = strNOM_DSP;
        this.lCOD_DSP = NEW_ID(); // unic ID
        
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_dsp_tab (cod_dsp,des,nom_dsp) VALUES(?,?,?)");

            ps.setLong(1, lCOD_DSP);
            ps.setString(2, strDES);
            ps.setString(3, strNOM_DSP);
            
            ps.executeUpdate();
            return new Long(lCOD_DSP);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES, String strNOM_DSP) {
        
    }




    public long getlCOD_DSP() {
        return lCOD_DSP;
    }

    public void setlCOD_DSP(long newlCOD_DSP) {
        if (lCOD_DSP == newlCOD_DSP) {
            return;
        }
        lCOD_DSP = newlCOD_DSP;
        setModified();
    }


    public String getstrDES() {
        return strDES;
    }

    public void setstrDES(String newstrDES) {
        if (strDES != null) {
            if (strDES.equals(newstrDES)) {
                return;
            }
        }
        strDES = newstrDES;
        setModified();
    }

//--------------------------------------------------

 public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_dsp FROM ana_dsp_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            rs.close();
            ps.close();
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
        this.lCOD_DSP = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_DSP = -1;
    }
//----------------------------------------------------------

     public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_dsp_tab WHERE cod_dsp=? ");
            ps.setLong(1, lCOD_DSP);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_DSP = rs.getLong("COD_DSP");				//3
                this.strDES = rs.getString("DES");
                this.strNOM_DSP = rs.getString("NOM_DSP");//4

//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_DSP + " non è trovato");
            }
            rs.close();
            ps.close();
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
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE "
                    + "FROM "
                    + "ana_dsp_tab "
                    + "WHERE "
                    + "cod_dsp = ? ");
            ps.setLong(1, lCOD_DSP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_DSP + " non è trovata");
            }
            ps.close();
        //    deleteFile();
        //    deleteFileLink();
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
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_dsp_tab  SET des=?, nom_dsp=? WHERE cod_dsp=?");
            ps.setString(1, strDES);
            ps.setString(2, strNOM_DSP);
            ps.setLong(3, lCOD_DSP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID= non è trovata");
            }
            ps.close();
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

     public Collection findEx(
            
            String strDES, String strNOM_DSP) {
        return (new AnagrDisposizioniBean()).ejbFindEx(
                strDES, strNOM_DSP);
    }

   
     public Collection ejbFindEx(
            String strDES, String strNOM_DSP) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_dsp, a.des, a.nom_dsp FROM ana_dsp_tab a where 0 = 0";


             if ((strDES != null)&&(!strDES.trim().equals(""))) {
                query += " AND UPPER(a.des) LIKE ? ";
              }  
             if ((strNOM_DSP != null)&&(!strNOM_DSP.trim().equals(""))) {
                query += " AND UPPER(a.nom_dsp) LIKE ?";
             }
             query += " ORDER BY UPPER(a.nom_dsp)";
             
                /*if (lCOD_DPD != null) {
                query += " AND  a.cod_dpd = ?";
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
                query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
                query += " AND  a.dat_cre_ctl_san = ?";
            }*/
            

            int i = 1;

            PreparedStatement ps = bmp.prepareStatement(query);
            
            if ((strDES != null)&&(!strDES.trim().equals(""))) {
                ps.setString(i++, strDES.toUpperCase()+"%");
            }
            
            if ((strNOM_DSP != null)&&(!strNOM_DSP.trim().equals(""))) {
                ps.setString(i++, strNOM_DSP.toUpperCase()+"%");
            }
            
            
            
            /*if (lCOD_DPD != null) {
                ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
                ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
                ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }*/

            System.out.println("Ecco la query" +query);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrDisposizioni_All_View obj = new AnagrDisposizioni_All_View();
                obj.COD_DSP = rs.getLong(1);
                obj.DES = rs.getString(2);
                obj.NOM_DSP = rs.getString(3);

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
     
     

    	public	Collection getAnagrDisposizioni_All_View(){
		return (new AnagrDisposizioniBean()).ejbGetANA_DSP_TAB_DES_View();
  }
	public Collection ejbGetANA_DSP_TAB_DES_View(){
		BMPConnection bmp=getConnection();
		try	{
			PreparedStatement ps=bmp.prepareStatement("SELECT cod_dsp, des, nom_dsp FROM ana_dsp_tab ORDER BY des");
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next()){
				AnagrDisposizioni_All_View obj=new AnagrDisposizioni_All_View();
				obj.COD_DSP = rs.getLong(1);
				obj.DES = rs.getString(2);
                                obj.NOM_DSP = rs.getString(3);
				al.add(obj);
			}
			bmp.close();
			return al;
		}catch(Exception ex){
			throw new EJBException(ex);
		}
		finally{bmp.close();}
	}

    public Collection getAnagr_All_View() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
