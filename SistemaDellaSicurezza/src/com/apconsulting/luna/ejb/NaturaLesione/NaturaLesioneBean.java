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

package com.apconsulting.luna.ejb.NaturaLesione;

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
public class NaturaLesioneBean extends BMPEntityBean implements INaturaLesione, INaturaLesioneHome
{
  long COD_NAT_LES;              //1
  String NOM_NAT_LES;            //2

private static NaturaLesioneBean ys = null;

    private NaturaLesioneBean() {
        //
    }

    public static NaturaLesioneBean getInstance() {
        if (ys == null) {
            ys = new NaturaLesioneBean();
        }
        return ys;
    }
  // (Home Interface) create()
  public INaturaLesione create(String strNOM_NAT_LES) throws CreateException
  {
  	 NaturaLesioneBean bean =  new  NaturaLesioneBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strNOM_NAT_LES);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_NAT_LES);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	NaturaLesioneBean iNaturaLesioneBean=new  NaturaLesioneBean();
    try	{
    	Object obj=iNaturaLesioneBean.ejbFindByPrimaryKey((Long)primaryKey);
        iNaturaLesioneBean.setEntityContext(new EntityContextWrapper(obj));
        iNaturaLesioneBean.ejbActivate();
        iNaturaLesioneBean.ejbLoad();
        iNaturaLesioneBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public INaturaLesione findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	NaturaLesioneBean bean =  new  NaturaLesioneBean();
  	try	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
  	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try	{
   		return this.ejbFindAll();
  	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</INaturaLesioneHome-implementation>
  public Long ejbCreate(String strNOM_NAT_LES){
    this.NOM_NAT_LES=strNOM_NAT_LES;
    this.COD_NAT_LES=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_nat_les_tab (cod_nat_les,nom_nat_les) VALUES(?,?)");
         ps.setLong   (1, COD_NAT_LES);
         ps.setString (2, NOM_NAT_LES);
         ps.executeUpdate();
         return new Long(COD_NAT_LES);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_NAT_LES) { }
//--------------------------------------------------

  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_nat_les FROM ana_nat_les_tab ");
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

//-----------------------------------------------------------

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_NAT_LES=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NAT_LES=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_nat_les_tab  WHERE cod_nat_les=?");
           ps.setLong (1, COD_NAT_LES);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_NAT_LES=rs.getLong("COD_NAT_LES");
           	this.NOM_NAT_LES=rs.getString("NOM_NAT_LES");
           }
           else{
              throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_nat_les_tab  WHERE cod_nat_les=?");
         ps.setLong (1, COD_NAT_LES);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
      }
      catch(Exception ex)
	    {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_nat_les_tab  SET cod_nat_les=?, nom_nat_les=? WHERE cod_nat_les=?");
         ps.setLong(1, COD_NAT_LES);
         ps.setString(2, NOM_NAT_LES);
         ps.setLong(3, COD_NAT_LES);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">
    //1
	  public long getCOD_NAT_LES(){
      return COD_NAT_LES;
    }
  	//2
	  public void setNOM_NAT_LES(String newNOM_NAT_LES){
      if( NOM_NAT_LES.equals(newNOM_NAT_LES) ) return;
      NOM_NAT_LES = newNOM_NAT_LES;
      setModified();
    }
    public String getNOM_NAT_LES(){
      return NOM_NAT_LES;
    }
	//============================================
	// not required field
  	//3
   //</comment>

// Views by Pogrebnoy Yura
	public	Collection getANA_NAT_LES_TAB_ByNOM_View(){
		return (new NaturaLesioneBean()).ejbGetANA_NAT_LES_TAB_ByNOM_View();
  }
	public Collection ejbGetANA_NAT_LES_TAB_ByNOM_View(){
		BMPConnection bmp=getConnection();
		try	{
			PreparedStatement ps=bmp.prepareStatement("SELECT cod_nat_les, nom_nat_les FROM ana_nat_les_tab ORDER BY nom_nat_les");
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next()){
				ANA_NAT_LES_TAB_ByNOM_View obj=new ANA_NAT_LES_TAB_ByNOM_View();
				obj.COD_NAT_LES = rs.getLong(1);
				obj.NOM_NAT_LES = rs.getString(2);
				al.add(obj);
			}
			bmp.close();
			return al;
		}catch(Exception ex){
			throw new EJBException(ex);
		}
		finally{bmp.close();}
	}

	public	Collection findEx(String NOM, long iOrderBy){
		return (new NaturaLesioneBean()).ejbfindEx(NOM, iOrderBy);
  }
	public Collection ejbfindEx(String NOM, long iOrderBy){
		String Sql="SELECT cod_nat_les, nom_nat_les FROM ana_nat_les_tab ";
		if (NOM!=null)
		{
		  Sql+=" WHERE UPPER(nom_nat_les) LIKE ?";
		}

		Sql+=" ORDER BY nom_nat_les ";
		BMPConnection bmp=getConnection();
		try	{
			PreparedStatement ps=bmp.prepareStatement(Sql);
			if(NOM!=null){ps.setString(1, NOM+"%".toUpperCase());}
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next()){
				ANA_NAT_LES_TAB_ByNOM_View obj=new ANA_NAT_LES_TAB_ByNOM_View();
				obj.COD_NAT_LES = rs.getLong(1);
				obj.NOM_NAT_LES = rs.getString(2);
				al.add(obj);
			}
			bmp.close();
			return al;
		}catch(Exception ex){
			throw new EJBException(ex);
		}
		finally{bmp.close();}
	}

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  NaturaLesioneBean"/>

