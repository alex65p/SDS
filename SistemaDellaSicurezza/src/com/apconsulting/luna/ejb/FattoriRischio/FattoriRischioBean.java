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

package com.apconsulting.luna.ejb.FattoriRischio;

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
public class FattoriRischioBean extends BMPEntityBean implements IFattoriRischio, IFattoriRischioHome {
  //< member-varibles description="Member Variables">
	long lCOD_FAT_RSO;
	String strNOM_FAT_RSO;
	String strDES_FAT_RSO;
	long lNUM_FAT_RSO;
	long lCOD_CAG_FAT_RSO;
	long lCOD_NOR_SEN;
    //< /member-varibles>
    //< IFattoriRischioHome-implementation>
    public static final String BEAN_NAME = "FattoriRischio";
    private static FattoriRischioBean ys = null;

    private FattoriRischioBean() {
        //
    }

    public static FattoriRischioBean getInstance() {
        if (ys == null) {
            ys = new FattoriRischioBean();
        }
        return ys;
    }

      public void remove(Object primaryKey){
            FattoriRischioBean bean=new FattoriRischioBean();
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

      public IFattoriRischio create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws javax.ejb.CreateException {
         FattoriRischioBean bean=new FattoriRischioBean();
            try{
              Object primaryKey=bean.ejbCreate(strNOM_FAT_RSO,lNUM_FAT_RSO,lCOD_CAG_FAT_RSO);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(strNOM_FAT_RSO,lNUM_FAT_RSO,lCOD_CAG_FAT_RSO);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IFattoriRischio findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      FattoriRischioBean bean=new FattoriRischioBean();
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
	  //<alex "19/03/2004">
	 public Collection getFattoriWithoutRischi(long lCOD_AZL, long lCOD_MAN){
  	 	return (new  FattoriRischioBean()).ejbGetFattoriWithoutRischi(lCOD_AZL, lCOD_MAN);
	 }
  	 //<report>
	/* public Collection getFattoriRischioView(){
  	 	return (new  FattoriRischioBean()).ejbGetFattoriRischioBean();
	 }*/
 ///////////////////////////////////////////////////////////////////////////////

public Long ejbCreate(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) {
	this.lCOD_FAT_RSO= NEW_ID();
	this.strNOM_FAT_RSO=strNOM_FAT_RSO;
	this.lNUM_FAT_RSO=lNUM_FAT_RSO;
	this.lCOD_CAG_FAT_RSO=lCOD_CAG_FAT_RSO;
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_fat_rso_tab (cod_fat_rso,nom_fat_rso,num_fat_rso,cod_cag_fat_rso) VALUES(?,?,?,?)");
			ps.setLong(1, lCOD_FAT_RSO);
			ps.setString(2, strNOM_FAT_RSO);
			ps.setLong(4, lNUM_FAT_RSO);
			ps.setLong(5, lCOD_CAG_FAT_RSO);
			ps.executeUpdate();
		return new Long(lCOD_FAT_RSO);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_FAT_RSO,long lNUM_FAT_RSO,long lCOD_CAG_FAT_RSO) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso FROM ana_fat_rso_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
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
    this.lCOD_FAT_RSO=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_FAT_RSO=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_fat_rso,nom_fat_rso,des_fat_rso,num_fat_rso,cod_cag_fat_rso,cod_nor_sen FROM ana_fat_rso_tab WHERE cod_fat_rso=?");
           ps.setLong(1, lCOD_FAT_RSO);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           		lCOD_FAT_RSO=rs.getLong(1);
	         		strNOM_FAT_RSO=rs.getString(2);
           		strDES_FAT_RSO=rs.getString(3);
           		lNUM_FAT_RSO=rs.getLong(4);
           		lCOD_CAG_FAT_RSO=rs.getLong(5);
           		lCOD_NOR_SEN=rs.getLong(6);
           }
           else{
              throw new NoSuchEntityException("FattoriRischio with ID="+lCOD_FAT_RSO+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_fat_rso_tab WHERE cod_fat_rso=?");
         ps.setLong(1, lCOD_FAT_RSO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("FattoriRischio with ID="+lCOD_FAT_RSO+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_fat_rso_tab SET cod_fat_rso=?, nom_fat_rso=?, des_fat_rso=?, num_fat_rso=?, cod_cag_fat_rso=?, cod_nor_sen=? WHERE cod_fat_rso=?");
			ps.setLong(1, lCOD_FAT_RSO);
			ps.setString(2, strNOM_FAT_RSO);
			ps.setString(3, strDES_FAT_RSO);
			ps.setLong(4, lNUM_FAT_RSO);
			ps.setLong(5, lCOD_CAG_FAT_RSO);
			if(lCOD_NOR_SEN==0) ps.setNull(6,java.sql.Types.BIGINT); else ps.setLong(6, lCOD_NOR_SEN);
			ps.setLong(7, lCOD_FAT_RSO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("FattoriRischio with ID="+lCOD_FAT_RSO+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //< setter-getters>
	public long getCOD_FAT_RSO(){
		return lCOD_FAT_RSO;
	}

	public String getNOM_FAT_RSO(){
		return strNOM_FAT_RSO;
	}
	public void setNOM_FAT_RSO(String strNOM_FAT_RSO){
		if(strNOM_FAT_RSO==null) return;
		if(this.strNOM_FAT_RSO.equals(strNOM_FAT_RSO)) return;
		this.strNOM_FAT_RSO=strNOM_FAT_RSO;
	}

	public String getDES_FAT_RSO(){
		return strDES_FAT_RSO;
	}
	public void setDES_FAT_RSO(String strDES_FAT_RSO){
		if(strDES_FAT_RSO==null) return;
		if(this.strDES_FAT_RSO.equals(strDES_FAT_RSO)) return;
		this.strDES_FAT_RSO=strDES_FAT_RSO;
	}

	public long getNUM_FAT_RSO(){
		return lNUM_FAT_RSO;
	}
	public void setNUM_FAT_RSO(long lNUM_FAT_RSO){
		if(this.lNUM_FAT_RSO==lNUM_FAT_RSO) return;
		this.lNUM_FAT_RSO=lNUM_FAT_RSO;
	}

	public long getCOD_CAG_FAT_RSO(){
		return lCOD_CAG_FAT_RSO;
	}
	public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO){
		if(this.lCOD_CAG_FAT_RSO==lCOD_CAG_FAT_RSO) return;
		this.lCOD_CAG_FAT_RSO=lCOD_CAG_FAT_RSO;
	}

	public long getCOD_NOR_SEN(){
		return lCOD_NOR_SEN;
	}
	public void setCOD_NOR_SEN(long lCOD_NOR_SEN){
		if(this.lCOD_NOR_SEN==lCOD_NOR_SEN) return;
		this.lCOD_NOR_SEN=lCOD_NOR_SEN;
	}
  //< /setter-getters>
  /* public Collection ejbGetFattoriRischioBean(){
  	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select cod_fat_rso,  nom_fat_rso,  des_fat_rso,  num_fat_rso,  cod_cag_fat_rso ,  cod_nor_sen from ana_fat_rso_tab order by nom_fat_rso");
		  ps.setLong(1, lCOD_DPD);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendenteTelefono_Tipology_Number_View obj=new DipendenteTelefono_Tipology_Number_View();
            obj.lCOD_FAT_RSO=rs.getLong(1);
            obj.strNOM_FAT_RSO=rs.getString(2);
            obj.strDES_FAT_RSO=rs.getString(3);
            obj.lNUM_FAT_RSO=rs.getLong(4);
            obj.lCOD_CAG_FAT_RSO=rs.getLong(5);
            obj.lCOD_NOR_SEN=rs.getLong(6);
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
	  //<alex "19/03/2004">

	public Collection ejbGetFattoriWithoutRischi(long lCOD_AZL, long lCOD_MAN){
  	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select 	a.cod_fat_rso, a.nom_fat_rso, 0 from ana_fat_rso_tab a where 	a.cod_fat_rso not in (select distinct a.cod_fat_rso	from   ana_rso_tab a, rso_man_tab b where a.cod_azl = b.cod_azl and a.cod_rso = b.cod_rso and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) and a.cod_fat_rso not in (select g.cod_fat_rso from ana_man_fat_rso_tab g where g.cod_man = ? and g.cod_azl = ?) union all select a.cod_fat_rso, a.nom_fat_rso, 1 from ana_fat_rso_tab a, ana_man_fat_rso_tab g where a.cod_fat_rso = g.cod_fat_rso and g.cod_man = ?	and g.cod_azl = ? and a.cod_fat_rso not in (select distinct a.cod_fat_rso from   ana_rso_tab a, rso_man_tab b where  a.cod_azl = b.cod_azl	and a.cod_rso = b.cod_rso	and b.prs_rso = 'S' and b.cod_man = ? and a.cod_azl = ?) order by 2");
          //PreparedStatement ps=bmp.prepareStatement("select 	a.cod_fat_rso, a.nom_fat_rso, 0 from ana_fat_rso_tab a where 	a.cod_fat_rso not in (select distinct a.cod_fat_rso	from   ana_rso_tab a, rso_man_tab b where  a.cod_rso = b.cod_rso  and b.cod_man = ? and a.cod_azl = ?) and a.cod_fat_rso not in (select g.cod_fat_rso from ana_man_fat_rso_tab g where g.cod_man = ? and g.cod_azl = ?) union all select a.cod_fat_rso, a.nom_fat_rso, 1 from ana_fat_rso_tab a, ana_man_fat_rso_tab g where a.cod_fat_rso = g.cod_fat_rso and g.cod_man = ?	and g.cod_azl = ? and a.cod_fat_rso not in (select distinct a.cod_fat_rso from   ana_rso_tab a, rso_man_tab b where  a.cod_rso = b.cod_rso and b.cod_man = ? and a.cod_azl = ?) order by 2");
		  ps.setLong(1, lCOD_MAN);
		  ps.setLong(2, lCOD_AZL);
		  ps.setLong(3, lCOD_MAN);
		  ps.setLong(4, lCOD_AZL);
		  ps.setLong(5, lCOD_MAN);
		  ps.setLong(6, lCOD_AZL);
		  ps.setLong(7, lCOD_MAN);
		  ps.setLong(8, lCOD_AZL);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            FattoriRischioView obj=new FattoriRischioView();
            obj.lCOD_FAT_RSO=rs.getLong(1);
            obj.strNOM_FAT_RSO=rs.getString(2);
            obj.lIndex=rs.getLong(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
	}
}
