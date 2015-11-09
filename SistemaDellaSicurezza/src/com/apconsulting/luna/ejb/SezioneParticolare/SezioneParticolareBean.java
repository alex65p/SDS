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

package com.apconsulting.luna.ejb.SezioneParticolare;


import com.apconsulting.luna.ejb.PSC.SezioneParticolare_All_View;
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
public class SezioneParticolareBean extends BMPEntityBean implements ISezioneParticolare, ISezioneParticolareHome{

//< member-varibles description="Member Variables">
    long lCOD_SEZ_PAR;
    long lCOD_PRO;
    long lCOD_AZL;
    String strOGG;
    String strCOD;
    String strREV;
    String strDOC_COL;
    String strTIT;
    java.sql.Date dtDAT_EMI;
    java.sql.Date dtDAT_PRO;
    long lCOD_PSC;
//< /member-varibles>

    //< ITestimoneHome-implementation>

      public static final String BEAN_NAME="SezioneParticolareBean";


      ////////////////////// CONSTRUCTOR///////////////////


    private SezioneParticolareBean() {
        //
    }

    private static SezioneParticolareBean ys = null;

    public static SezioneParticolareBean getInstance() {
        if (ys == null) {
            ys = new SezioneParticolareBean();
        }
        return ys;
    }

    public void remove(Object primaryKey){
            SezioneParticolareBean bean=new SezioneParticolareBean();
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

    public ISezioneParticolare create(String strOGG, String strCOD, String strTIT, String strREV, java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL,long lCOD_PSC,long lCOD_PRO, long lCOD_AZL) throws javax.ejb.CreateException {
         SezioneParticolareBean bean=new SezioneParticolareBean();
             try{
              Object primaryKey=bean.ejbCreate(strOGG, strCOD, strTIT, strREV, dtDAT_EMI, dtDAT_PRO, strDOC_COL,lCOD_PSC, lCOD_PRO, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(strOGG, strCOD, strTIT, strREV, dtDAT_EMI, dtDAT_PRO,strDOC_COL, lCOD_PSC, lCOD_PRO, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

    public ISezioneParticolare findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      SezioneParticolareBean bean=new SezioneParticolareBean();
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

      public String getUltimaRevisione(long lCOD_PRO, String newID) {
        return (new SezioneParticolareBean()).ejbUltimaRevisione(lCOD_PRO,newID);
    }

      public String getDataProtocollo(long lCOD_PRO, String newID) {
        return (new SezioneParticolareBean()).ejbDataProtocollo(lCOD_PRO,newID);
    }

      public String getDataProtocolloPREC(long lCOD_PRO, String COD) {
        return (new SezioneParticolareBean()).ejbDataProtocolloPREC(lCOD_PRO,COD);
    }

      public String getUltimoCodice(long lCOD_PRO) {
        return (new SezioneParticolareBean()).ejbUltimoCodice(lCOD_PRO);
    }

      public String getUltimoCodice_Sez(long lCOD_PRO,String newID) {
        return (new SezioneParticolareBean()).ejbUltimoCodice_Sez(lCOD_PRO,newID);
    }
      
      public String getUltimo_Doc_Sez(long lCOD_PRO,String newID) {
        return (new SezioneParticolareBean()).ejbUltimo_doc_Sez(lCOD_PRO,newID);
    }

      public Collection getSezioneParticolarePSCByID_View(long lCOD_PSC,long lCOD_PRO,long lCOD_AZL) {
        return (new SezioneParticolareBean()).ejbGetSezioneParticolarePSCByID_View(lCOD_PSC,lCOD_PRO,lCOD_AZL);
    }
      
      public Collection getSezioneParticolarePSCByID_View_SINTETICA(long lCOD_PSC, long lCOD_PRO,long lCOD_AZL) {
        return (new SezioneParticolareBean()).ejbGetSezioneParticolareByID_View_SINTETICA(lCOD_PSC,lCOD_PRO,lCOD_AZL);
    }

       public Long ejbCreate(String strOGG, String strCOD, String strTIT, String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO,String strDOC_COL,long lCOD_PSC,long lCOD_PRO, long lCOD_AZL)
  {
	this.lCOD_SEZ_PAR= NEW_ID();
        this.lCOD_PSC=lCOD_PSC;
        this.lCOD_PRO=lCOD_PRO;
        this.lCOD_AZL=lCOD_AZL;
        this.strCOD=strCOD;
	this.strCOD=strTIT;
	this.strOGG=strOGG;
	this.strREV=strREV;
	this.dtDAT_EMI=dtDAT_EMI;
	this.dtDAT_PRO=dtDAT_PRO;
	this.strDOC_COL=strDOC_COL;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO psc_sez_par_tab (cod_sez_par,cod_psc,cod_pro,cod_azl,rev,cod,tit,ogg,dat_emi,dat_pro,doc_col) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
			ps.setLong(1, lCOD_SEZ_PAR);
			ps.setLong(2, lCOD_PSC);
			ps.setLong(3, lCOD_PRO);
			ps.setLong(4, lCOD_AZL);
			ps.setString(5, strREV);
			ps.setString(6, strCOD);
			ps.setString(7, strTIT);
			ps.setString(8, strOGG);
			ps.setDate(9, dtDAT_EMI);
			ps.setDate(10, dtDAT_PRO);
			ps.setString(11, strDOC_COL);
			ps.executeUpdate();
		return new Long(lCOD_SEZ_PAR);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strOGG, String strCOD, String strTIT,String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL,long lCOD_PSC,long lCOD_PRO, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sez_par FROM ana_sez_par_tab");
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
    this.lCOD_SEZ_PAR=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_SEZ_PAR=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_sez_par,cod,tit,ogg,rev,dat_emi,dat_pro,doc_col,cod_psc FROM psc_sez_par_tab WHERE cod_sez_par=?");
           ps.setLong(1, lCOD_SEZ_PAR);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
       		lCOD_SEZ_PAR=rs.getLong(1);
			strCOD=rs.getString(2);
			strTIT=rs.getString(3);
			strOGG=rs.getString(4);
			strREV=rs.getString(5);
                        dtDAT_EMI=rs.getDate(6);
                        dtDAT_PRO=rs.getDate(7);
                        strDOC_COL=rs.getString(8);
			lCOD_PSC=rs.getLong(9);
           }
           else{
              throw new NoSuchEntityException("Testimone with ID="+lCOD_SEZ_PAR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM psc_sez_par_tab WHERE cod_sez_par=?");
         ps.setLong(1, lCOD_SEZ_PAR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Sezione generale with ID="+lCOD_SEZ_PAR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE psc_sez_par_tab SET cod=?,tit=?, ogg=?, rev=?, dat_emi=?, dat_pro=?, doc_col=? WHERE cod_sez_par=?");

                        ps.setString(1, strCOD);
                        ps.setString(2, strTIT);
			ps.setString(3, strOGG);
			ps.setString(4, strREV);
			ps.setDate(5, dtDAT_EMI);
			ps.setDate(6, dtDAT_PRO);
			ps.setString(7, strDOC_COL);
                        ps.setLong(8, lCOD_SEZ_PAR);

         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Testimone with ID="+lCOD_SEZ_PAR+" not found");
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

    public long getlCOD_SEZ_PAR() {
        return lCOD_SEZ_PAR;
    }

    public void setlCOD_SEZ_PAR(long newlCOD_SEZ_PAR) {
        if (lCOD_SEZ_PAR == newlCOD_SEZ_PAR) {
            return;
        }
        lCOD_SEZ_PAR = newlCOD_SEZ_PAR;
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
        strREV = newstrDOC_COL;
        setModified();
    }

    public String getstrTIT() {
        return strTIT;
    }

    public void setstrTIT(String newstrTIT) {
        if (strTIT != null) {
            if (strTIT.equals(newstrTIT)) {
                return;
            }
        }
        strTIT = newstrTIT;
        setModified();
    }
public String ejbUltimaRevisione (long lCOD_PRO,String newID) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT MAX(REV) FROM psc_sez_par_tab WHERE cod_pro=? AND cod=?");
            ps.setLong(1, lCOD_PRO);
            ps.setString(2, newID);
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


public String ejbDataProtocollo (long lCOD_PRO,String newID) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "select dat_pro from psc_sez_par_tab "
                    + "where rev=(SELECT distinct MAX(rev) "
                    + "FROM psc_sez_par_tab WHERE cod_pro=? "
                    + "and cod=?) AND cod=? AND COD_PRO=?");
            ps.setLong(1, lCOD_PRO);
            ps.setString(2, newID);
            ps.setString(3, newID);
            ps.setLong(4, lCOD_PRO );
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

public String ejbDataProtocolloPREC(long lCOD_PRO,String COD) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(""
                    + "select dat_pro from psc_sez_par_tab "
                    + "where rev=(SELECT MAX(rev) FROM psc_sez_par_tab "
                    + "WHERE cod_pro=? and dat_pro=(select MAX (dat_pro)"
                    + " from psc_sez_par_tab where cod_pro=? and cod=? ))AND COD_PRO=? and cod=? ");
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_PRO);
            ps.setString(3, COD);
            ps.setLong(4, lCOD_PRO);
            ps.setString(5, COD);
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

public String ejbUltimoCodice (long lCOD_PRO) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select max(CAST(SUBSTR(cod,2) AS INTEGER)) as cod  from psc_sez_par_tab WHERE cod_pro=?");
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

public String ejbUltimo_doc_Sez (long lCOD_PRO,String newID) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select "
                        + "doc_col as cod "
                    + "from "
                        + "psc_sez_par_tab "
                    + "WHERE "
                        + "cod_pro=? "
                        + "and cod=? "
                        + "and rev = "
                            + "(SELECT "
                                + "MAX(REV) "
                            + "FROM "
                                + "psc_sez_par_tab "
                            + "WHERE "
                                + "cod_pro=? "
                                + "and cod=?)");
            ps.setLong(1, lCOD_PRO);
            ps.setString(2, newID);
            ps.setLong(3, lCOD_PRO);
            ps.setString(4, newID);
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
public String ejbUltimoCodice_Sez (long lCOD_PRO,String newID) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select max(CAST(SUBSTR(cod,2) AS INTEGER)) as cod  from psc_sez_par_tab WHERE cod_pro=? and cod=?");
            ps.setLong(1, lCOD_PRO);                     
            ps.setString(2, newID);
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



public Collection ejbGetSezioneParticolarePSCByID_View(long lCOD_PSC,long lCOD_PRO,long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod, a.tit, a.ogg, (CASE WHEN a.rev = '0' THEN 'In Lav.' WHEN a.rev = '1' THEN 'Emiss.' ELSE a.rev END) AS rev, a.dat_emi, a.dat_pro, a.doc_col, b.cod, b.rev FROM  psc_sez_par_tab a, (SELECT cod_psc, cod_pro, cod_azl, cod, MAX(rev) as rev FROM psc_sez_par_tab group by cod_psc, cod_pro, cod_azl, cod) b WHERE a.cod_psc=b.cod_psc and a.cod_pro=b.cod_pro and a.cod_azl=b.cod_azl and a.cod=b.cod and a.cod_psc = ? and a.cod_pro = ? and a.cod_azl = ? and not(a.rev = 0 and b.rev > 0) order by a.cod, a.rev");
            ps.setLong(1, lCOD_PSC);
            ps.setLong(2, lCOD_PRO);
            ps.setLong(3, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneParticolare_All_View obj = new SezioneParticolare_All_View();
                obj.COD_PSC = lCOD_PSC;
                obj.COD = rs.getString(1);
                obj.TIT = rs.getString(2);
                obj.OGG = rs.getString(3);
                obj.REV = rs.getString(4);
                obj.DAT_EMI = rs.getDate(5);
                obj.DAT_PRO = rs.getDate(6);
                obj.DOC_COL = rs.getString(7);
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
    public Collection ejbGetSezioneParticolareByID_View_SINTETICA(long lCOD_PSC, long lCOD_PRO, long lCOD_AZL) {
         BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select"
                    + " a.cod,"
                    + " a.tit,"
                    + "a.ogg,"
                    + "(CASE WHEN a.rev = '0' THEN 'In Lav.' WHEN a.rev = '1' THEN 'Emiss.' ELSE a.rev END) "
                    + "AS rev,a.dat_emi,"
                    + "a.dat_pro,"
                    + "a.doc_col "
                    + "from "
                    + "psc_sez_par_tab a,"
                    + "(SELECT cod_psc, cod_pro, cod_azl, cod, MAX(rev) as rev FROM psc_sez_par_tab group by cod_psc, "
                    + "cod_pro, "
                    + "cod_azl, "
                    + "cod) b "
                    + "where "
                    + "a.cod_psc=b.cod_psc "
                    + "and a.cod_pro=b.cod_pro "
                    + "and a.cod_azl=b.cod_azl "
                    + "and a.cod=b.cod "
                    + "and a.rev=b.rev "
                    + "and a.cod_psc = ? "
                    + "and a.cod_pro = ? "
                    + "and a.cod_azl = ? "
                    + "order by a.cod,dat_emi,rev");
                    /*+ "SELECT "
                    + "psc_sez_par_tab.cod, "
                    + "psc_sez_par_tab.tit, "
                    + "psc_sez_par_tab.ogg, "
                    + "psc_sez_par_tab.rev, "
                    + "psc_sez_par_tab.dat_emi, "
                    + "psc_sez_par_tab.dat_pro, "
                    + "psc_sez_par_tab.doc_col "
                    + "FROM  psc_sez_par_tab "
                    + "WHERE cod_psc=? "
                    + "and rev=(SELECT MAX(rev) FROM psc_sez_par_tab "
                    + "WHERE cod_pro=? )"
                    + "order by psc_sez_par_tab.dat_emi,psc_sez_par_tab.rev*/

            ps.setLong(1, lCOD_PSC);
            ps.setLong(2, lCOD_PRO);
            ps.setLong(3, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SezioneParticolare_All_View obj = new SezioneParticolare_All_View();
                obj.COD_PSC = lCOD_PSC;
                obj.COD = rs.getString(1);
                obj.TIT = rs.getString(2);
                obj.OGG = rs.getString(3);
                obj.REV = rs.getString(4);
                obj.DAT_EMI = rs.getDate(5);
                obj.DAT_PRO = rs.getDate(6);
                obj.DOC_COL = rs.getString(7);
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
