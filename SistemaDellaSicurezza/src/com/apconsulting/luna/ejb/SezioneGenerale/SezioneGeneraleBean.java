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

package com.apconsulting.luna.ejb.SezioneGenerale;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Alessandro
 */
public class SezioneGeneraleBean extends BMPEntityBean implements ISezioneGenerale, IsezioneGeneraleHome{

//< member-varibles description="Member Variables">
    long lCOD_SEZ_GEN;
    long lCOD_PRO;
    long lCOD_AZL;
    String strOGG;
    String strCOD;
    String strREV;
    String strDOC_COL;
    java.sql.Date dtDAT_EMI;
    java.sql.Date dtDAT_PRO;
    long lCOD_PSC;
//< /member-varibles>

    //< ITestimoneHome-implementation>

      public static final String BEAN_NAME="SezioneGeneraleBean";


      ////////////////////// CONSTRUCTOR///////////////////


    private SezioneGeneraleBean() {
        //
    }

    private static SezioneGeneraleBean ys = null;

    public static SezioneGeneraleBean getInstance() {
        if (ys == null) {
            ys = new SezioneGeneraleBean();
        }
        return ys;
    }

    public void remove(Object primaryKey){
            SezioneGeneraleBean bean=new SezioneGeneraleBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
              throw new EJBException(ex.getMessage());
            }
      }

    public ISezioneGenerale create(String strOGG, String strCOD, String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL, long lCOD_PSC,long lCOD_PRO, long lCOD_AZL) throws javax.ejb.CreateException {
         SezioneGeneraleBean bean=new SezioneGeneraleBean();
             try{
              Object primaryKey=bean.ejbCreate(strOGG, strCOD, strREV, dtDAT_EMI, dtDAT_PRO, strDOC_COL, lCOD_PSC, lCOD_PRO, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(strOGG, strCOD, strREV, dtDAT_EMI, dtDAT_PRO, strDOC_COL, lCOD_PSC, lCOD_PRO, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

    public ISezioneGenerale findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      SezioneGeneraleBean bean=new SezioneGeneraleBean();
			try{
					bean.setEntityContext(new EntityContextWrapper(primaryKey));
					bean.ejbActivate();
					bean.ejbLoad();
					return bean;
			}
           catch(Exception ex){
              throw new javax.ejb.FinderException(ex.getMessage());
            }
      }

      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }

      public String getUltimaRevisione(long lCOD_PRO) {
        return (new SezioneGeneraleBean()).ejbUltimaRevisione(lCOD_PRO);
    }

      public String getDataProtocollo(long lCOD_PRO) {
        return (new SezioneGeneraleBean()).ejbDataProtocollo(lCOD_PRO);
    }

      public String getDataProtocolloPREC(long lCOD_PRO) {
        return (new SezioneGeneraleBean()).ejbDataProtocolloPREC(lCOD_PRO);
    }

      public String getUltimo_Doc_Sez(long lCOD_PRO) {
        return (new SezioneGeneraleBean()).ejbUltimo_doc_Sez(lCOD_PRO);
    }
      
      public Collection getSezioneGeneralePSCByID_View(long lCOD_PSC,long lCOD_PRO,long lCOD_AZL) {
        return (new SezioneGeneraleBean()).ejbGetSezioneGeneraleByID_View(lCOD_PSC,lCOD_PRO,lCOD_AZL);
    }
      
      public Collection getSezioneGeneralePSCByID_View_SINTETICA(long lCOD_PSC, long lCOD_PRO) {
        return (new SezioneGeneraleBean()).ejbGetSezioneGeneraleByID_View_SINTETICA(lCOD_PSC,lCOD_PRO);
    }

       public Long ejbCreate(String strOGG, String strCOD, String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL, long lCOD_PSC,long lCOD_PRO, long lCOD_AZL)
  {
	this.lCOD_SEZ_GEN= NEW_ID();
        this.lCOD_PSC=lCOD_PSC;
        this.lCOD_PRO=lCOD_PRO;
        this.lCOD_AZL=lCOD_AZL;
        this.strCOD=strCOD;
        this.strCOD=strCOD;
	this.strCOD=strCOD;
	this.strOGG=strOGG;
	this.strREV=strREV;
	this.dtDAT_EMI=dtDAT_EMI;
	this.dtDAT_PRO=dtDAT_PRO;
        this.strDOC_COL=strDOC_COL;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO psc_sez_gen_tab (cod_sez_gen,cod_psc,cod_pro,cod_azl,rev,cod,ogg,dat_emi,dat_pro,doc_col) VALUES(?,?,?,?,?,?,?,?,?,?)");
			ps.setLong(1, lCOD_SEZ_GEN);
			ps.setLong(2, lCOD_PSC);
			ps.setLong(3, lCOD_PRO);
			ps.setLong(4, lCOD_AZL);
			ps.setString(5, strREV);
			ps.setString(6, strCOD);
			ps.setString(7, strOGG);
			ps.setDate(8, dtDAT_EMI);
			ps.setDate(9, dtDAT_PRO);
			ps.setString(10, strDOC_COL);
			ps.executeUpdate();
		return new Long(lCOD_SEZ_GEN);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strOGG, String strCOD, String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL, long lCOD_PSC,long lCOD_PRO, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sez_gen FROM ana_sez_gen_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_SEZ_GEN=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_SEZ_GEN=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_sez_gen,cod,ogg,rev,dat_emi,dat_pro,doc_col,cod_psc FROM psc_sez_gen_tab WHERE cod_sez_gen=?");
           ps.setLong(1, lCOD_SEZ_GEN);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
       		lCOD_SEZ_GEN=rs.getLong(1);
			strCOD=rs.getString(2);
			strOGG=rs.getString(3);
			strREV=rs.getString(4);
                        dtDAT_EMI=rs.getDate(5);
                        dtDAT_PRO=rs.getDate(6);
                        strDOC_COL=rs.getString(7);
			lCOD_PSC=rs.getLong(8);
           }
           else{
              throw new NoSuchEntityException("Testimone with ID="+lCOD_SEZ_GEN+" not found");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM psc_sez_gen_tab WHERE cod_sez_gen=?");
         ps.setLong(1, lCOD_SEZ_GEN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Sezione generale with ID="+lCOD_SEZ_GEN+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE psc_sez_gen_tab SET cod=?, ogg=?, rev=?, dat_emi=?, dat_pro=?, doc_col=? WHERE cod_sez_gen=?");
			
                        ps.setString(1, strCOD);
			ps.setString(2, strOGG);
			ps.setString(3, strREV);
			ps.setDate(4, dtDAT_EMI);
			ps.setDate(5, dtDAT_PRO);
			ps.setString(6, strDOC_COL);
                        ps.setLong(7, lCOD_SEZ_GEN);

         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Testimone with ID="+lCOD_SEZ_GEN+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

    public java.sql.Date getdtDAT_EMI() {
        return dtDAT_EMI;
    }

    public void setdtDAT_EMI(java.sql.Date newdtDAT_EMI) {
        if (dtDAT_EMI != null) {
            if (dtDAT_EMI.equals(newdtDAT_EMI)) {
                return;
            }
        }
        dtDAT_EMI = newdtDAT_EMI;
        setModified();
    }


    public java.sql.Date getdtDAT_PRO() {
        return dtDAT_PRO;
    }

     public void setdtDAT_PRO(java.sql.Date newdtDAT_PRO) {
        if (dtDAT_PRO != null) {
            if (dtDAT_PRO.equals(newdtDAT_PRO)) {
                return;
            }
        }
        dtDAT_PRO = newdtDAT_PRO;
        setModified();
    }

     public long getlCOD_AZL() {
        return lCOD_AZL;
    }

    public void setlCOD_AZL(long newlCOD_AZL) {
        if (lCOD_AZL == newlCOD_AZL) {
            return;
        }
        lCOD_AZL = newlCOD_AZL;
        setModified();
    }

    public long getlCOD_PRO() {
        return lCOD_PRO;
    }

    public void setlCOD_PRO(long newlCOD_PRO) {
        if (lCOD_PRO == newlCOD_PRO) {
            return;
        }
        lCOD_PRO = newlCOD_PRO;
        setModified();
    }

    public long getlCOD_PSC() {
        return lCOD_PSC;
    }

    public void setlCOD_PSC(long newlCOD_PSC) {
        if (lCOD_PSC == newlCOD_PSC) {
            return;
        }
        lCOD_PSC = newlCOD_PSC;
        setModified();
    }

    public long getlCOD_SEZ_GEN() {
        return lCOD_SEZ_GEN;
    }

    public void setlCOD_SEZ_GEN(long newlCOD_SEZ_GEN) {
        if (lCOD_SEZ_GEN == newlCOD_SEZ_GEN) {
            return;
        }
        lCOD_SEZ_GEN = newlCOD_SEZ_GEN;
        setModified();
    }

     public String getstrCOD() {
        return strCOD;
    }

    public void setstrCOD(String newstrCOD) {
         if (strCOD != null) {
            if (strCOD.equals(newstrCOD)) {
                return;
            }
        }
        strCOD = newstrCOD;
        setModified();
    }

    public String getstrOGG() {
        return strOGG;
    }

    public void setstrOGG(String newstrOGG) {
        if (strOGG != null) {
            if (strOGG.equals(newstrOGG)) {
                return;
            }
        }
        strOGG = newstrOGG;
        setModified();
    }

    public String getstrREV() {
        return strREV;
    }

    public void setstrREV(String newstrREV) {
        if (strREV != null) {
            if (strREV.equals(newstrREV)) {
                return;
            }
        }
        strREV = newstrREV;
        setModified();
    }

    public String getstrDOC_COL() {
        return strDOC_COL;
    }

    public void setstrDOC_COL(String newstrDOC_COL) {
        if (strDOC_COL != null) {
            if (strDOC_COL.equals(newstrDOC_COL)) {
                return;
            }
        }
        strDOC_COL = newstrDOC_COL;
        setModified();
    }

    public Collection findEx(
            Long lCOD_PSC,
            Long lCOD_PRO,
            String strCOD,
            String strREV,
            String strDAT_EMI,
            String strDAT_PRO,
            String strOGG,
            String strDOC_COL,
            int iOrderParameter)  {
        return (new SezioneGeneraleBean()).ejbFindEx(
                lCOD_PSC,
                lCOD_PRO,
                strCOD,
                strREV,
                strDAT_EMI,
                strDAT_PRO,
                strOGG,
                strDOC_COL,
                iOrderParameter);
    }

    public Collection ejbFindEx(
            Long lCOD_PSC,
            Long lCOD_PRO,
            String strCOD,
            String strREV,
            String strDAT_EMI,
            String strDAT_PRO,
            String strOGG,
            String strDOC_COL,
            int iOrderParameter) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod,a.rev,a.dat_emi,a.dat_pro,a.doc_col FROM psc_sez_gen_tab a,ana_psc_tab b where a.cod_pro=b.cod_pro and a.cod_psc=b.cod_psc";
            if (lCOD_PRO != null) {
                query += " AND  a.cod_pro = ?";
            }
            /*
            if (strNOM_MED_RSP_CTL_SAN != null) {
                query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
                query += " AND  a.dat_cre_ctl_san = ?";
            }*/
            //query += "ORDER BY UPPER(cog_dpd)";

            int i = 1;

            PreparedStatement ps = bmp.prepareStatement(query);


            if (lCOD_PRO != null) {
                ps.setLong(i++, lCOD_PRO.longValue());
            }
            /*
            if (strNOM_MED_RSP_CTL_SAN != null) {
                ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
                ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }*/

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneGenerale_View obj = new SezioneGenerale_View();
                obj.COD = rs.getString(1);
                obj.REV = rs.getString(2);
                obj.DAT_EMI = rs.getDate(3);
                obj.DAT_PRO = rs.getDate(4);
                obj.DOC_COL = rs.getString(5);
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

    public String ejbUltimaRevisione (long lCOD_PRO) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "MAX(REV) "
                    + "FROM "
                        + "psc_sez_gen_tab "
                    + "WHERE "
                        + "cod_pro=? ");
            ps.setLong(1, lCOD_PRO);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
            rs.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    public String ejbUltimo_doc_Sez (long lCOD_PRO) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "doc_col as cod "
                    + "from "
                        + "psc_sez_gen_tab "
                    + "WHERE "
                        + "cod_pro=? "
                        + "and rev = "
                            + "(SELECT "
                                + "MAX(REV) "
                            + "FROM "
                                + "psc_sez_gen_tab "
                            + "WHERE "
                                + "cod_pro=?)");
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_PRO);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
            rs.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    public String ejbDataProtocollo (long lCOD_PRO) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select dat_pro from psc_sez_gen_tab where rev=(SELECT MAX(rev) FROM psc_sez_gen_tab WHERE cod_pro=?)AND COD_PRO=?");
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_PRO);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
            rs.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    public String ejbDataProtocolloPREC (long lCOD_PRO) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "select dat_pro from psc_sez_gen_tab "
                    + "where rev=(SELECT MAX(rev) FROM psc_sez_gen_tab "
                    + "WHERE cod_pro=? and dat_pro=(select MAX (dat_pro)"
                    + " from psc_sez_gen_tab where cod_pro=?))AND COD_PRO=?");
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_PRO);
            ps.setLong(3, lCOD_PRO);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
            rs.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    public Collection ejbGetSezioneGeneraleByID_View(long lCOD_PSC,long lCOD_PRO,long lCOD_AZL) {
         BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT 'Sezione Generale', a.ogg, (CASE WHEN a.rev = '0' THEN 'In Lav.' WHEN a.rev = '1' THEN 'Emiss.' ELSE a.rev END) AS rev, a.dat_emi, a.dat_pro, a.doc_col FROM psc_sez_gen_tab a, (SELECT cod_psc, cod_pro, cod_azl, cod, MAX(rev) as rev FROM psc_sez_gen_tab group by cod_psc, cod_pro, cod_azl, cod) b WHERE a.cod_psc=b.cod_psc and a.cod_pro=b.cod_pro and a.cod_azl=b.cod_azl and a.cod=b.cod and a.cod_psc = ? and a.cod_pro = ? and a.cod_azl = ? and not(a.rev = 0 and b.rev > 0) order by  a.cod, a.rev ");
                    
              /*      + "SELECT psc_sez_gen_tab.ogg, "
                    + "psc_sez_gen_tab.rev, "
                    + "psc_sez_gen_tab.dat_emi, "
                    + "psc_sez_gen_tab.dat_pro, "
                    + "psc_sez_gen_tab.doc_col "
                    + "FROM  psc_sez_gen_tab "
                    + "WHERE cod_psc=? "
                    + "order by psc_sez_gen_tab.dat_emi,psc_sez_gen_tab.rev");*/
            ps.setLong(1, lCOD_PSC);
            ps.setLong(2, lCOD_PRO);
            ps.setLong(3, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneGenerale_View obj = new SezioneGenerale_View();
                obj.COD_PSC = lCOD_PSC;
                obj.TIT = rs.getString(1);
                obj.OGG = rs.getString(2);
                obj.REV = rs.getString(3);
                obj.DAT_EMI = rs.getDate(4);
                obj.DAT_PRO = rs.getDate(5);
                obj.DOC_COL = rs.getString(6);
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
    
    public Collection ejbGetSezioneGeneraleByID_View_SINTETICA(long lCOD_PSC, long lCOD_PRO) {
         BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT psc_sez_gen_tab.ogg, "
                    + "psc_sez_gen_tab.rev, "
                    + "psc_sez_gen_tab.dat_emi, "
                    + "psc_sez_gen_tab.dat_pro, "
                    + "psc_sez_gen_tab.doc_col "
                    + "FROM  psc_sez_gen_tab "
                    + "WHERE cod_psc=? "
                    + "and rev=(SELECT MAX(rev) FROM psc_sez_gen_tab "
                    + "WHERE cod_pro=? )"
                    + "order by psc_sez_gen_tab.dat_emi,psc_sez_gen_tab.rev");
            ps.setLong(1, lCOD_PSC);
            ps.setLong(2, lCOD_PRO);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneGenerale_View obj = new SezioneGenerale_View();
                obj.COD_PSC = lCOD_PSC;
                obj.OGG = rs.getString(1);
                obj.REV = rs.getString(2);
                obj.DAT_EMI = rs.getDate(3);
                obj.DAT_PRO = rs.getDate(4);
                obj.DOC_COL = rs.getString(5);
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
