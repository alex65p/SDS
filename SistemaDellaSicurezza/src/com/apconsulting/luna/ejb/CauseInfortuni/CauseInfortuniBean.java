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

package com.apconsulting.luna.ejb.CauseInfortuni;

import java.rmi.RemoteException;
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


public class CauseInfortuniBean extends BMPEntityBean implements ICauseInfortuni, ICauseInfortuniHome
{
  //<comment description="Member Variables">
	long COD_TPL_FRM_INO;
	String NOM_TPL_FRM_INO;
  	String TIP_TPL_FRM_INO;
  //</comment>

////////////////////// CONSTRUCTOR///////////////////

private static CauseInfortuniBean ys = null;

    private CauseInfortuniBean() {
        //
    }

    public static CauseInfortuniBean getInstance() {
        if (ys == null) {
            ys = new CauseInfortuniBean();
        }
        return ys;
    }
  // (Home Intrface) create()
  public ICauseInfortuni create(String strTIP_TPL_FRM_INO, String strNOM_TPL_FRM_INO) throws RemoteException, CreateException
  {
 	 CauseInfortuniBean bean =  new  CauseInfortuniBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strTIP_TPL_FRM_INO, strNOM_TPL_FRM_INO);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strTIP_TPL_FRM_INO, strNOM_TPL_FRM_INO);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	CauseInfortuniBean iTipologieFormeDinfortunioBean=new  CauseInfortuniBean();
    try
	{
    	Object obj=iTipologieFormeDinfortunioBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologieFormeDinfortunioBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologieFormeDinfortunioBean.ejbActivate();
        iTipologieFormeDinfortunioBean.ejbLoad();
        iTipologieFormeDinfortunioBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ICauseInfortuni findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException
  {
   	CauseInfortuniBean bean =  new  CauseInfortuniBean();
	try
	{
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
  public Collection findAll() throws RemoteException, FinderException
  {
  	try{
   		return this.ejbFindAll();
	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }


  // (Home Intrface) VIEWS  getTipologieFormeDinfortunio_UserID_View()
  public Collection getTipologieFormeDinfortunio_UserID_View()
  {
  	return (new  CauseInfortuniBean()).ejbGetTipologieFormeDinfortunio_UserID_View();
  }
  //
  public Collection findEx(String NOM, String DES, long iOrderBy)
  {
  	return (new  CauseInfortuniBean()).ejbfindEx(NOM, DES, iOrderBy);
  }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologieFormeDinfortunioHome-implementation>
  public Long ejbCreate(String strTIP_TPL_FRM_INO,String strNOM_TPL_FRM_INO)
  {
	this.TIP_TPL_FRM_INO=strTIP_TPL_FRM_INO;
    this.NOM_TPL_FRM_INO=strNOM_TPL_FRM_INO;
    this.COD_TPL_FRM_INO=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement(
	   "INSERT INTO cau_inf_can_tab (cod_tpl_frm_ino,nom_tpl_frm_ino,tip_tpl_frm_ino) VALUES(?,?,?)");
         ps.setLong   (1, COD_TPL_FRM_INO);
         ps.setString (2, NOM_TPL_FRM_INO);
         ps.setString (3, TIP_TPL_FRM_INO);
         ps.executeUpdate();
         return new Long(COD_TPL_FRM_INO);
    }catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }
//-------------------------------------------------------
  public void ejbPostCreate(String strTIP_TPL_FRM_INO,String strNOM_TPL_FRM_INO) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_frm_ino FROM cau_inf_can_tab ");
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
    this.COD_TPL_FRM_INO=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_TPL_FRM_INO=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "SELECT * FROM cau_inf_can_tab  WHERE cod_tpl_frm_ino=?");
           ps.setLong (1, COD_TPL_FRM_INO);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
			 this.NOM_TPL_FRM_INO=rs.getString("NOM_TPL_FRM_INO");
   			 this.TIP_TPL_FRM_INO=rs.getString("TIP_TPL_FRM_INO");
           }
           else{
              throw new NoSuchEntityException("TipologieFormeDinfortunio con ID="+COD_TPL_FRM_INO+" non è trovato");
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
      try
	  {
         PreparedStatement ps=bmp.prepareStatement(
		 "DELETE FROM cau_inf_can_tab  WHERE cod_tpl_frm_ino=?");
          ps.setLong (1, COD_TPL_FRM_INO);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieFormeDinfortunio con ID="+COD_TPL_FRM_INO+" non è trovato");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE cau_inf_can_tab  SET tip_tpl_frm_ino=?, nom_tpl_frm_ino=? WHERE cod_tpl_frm_ino=?");
          ps.setString 	(1, TIP_TPL_FRM_INO);
		  ps.setString 	(2, NOM_TPL_FRM_INO);
		  ps.setLong   	(3, COD_TPL_FRM_INO);
		  if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieFormeDinfortunio con ID="+COD_TPL_FRM_INO+" non è trovato");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!////////////////////////////
//<comment description="Zdes opredeliayutsia metody remote interfeisa"/>

//<comment description="setter/getters">
	//----1
	public long getCOD_TPL_FRM_INO(){
      return COD_TPL_FRM_INO;
    }
	//----2
    public void setTIP_TPL_FRM_INO(String newTIP_TPL_FRM_INO){
      if(TIP_TPL_FRM_INO.equals(newTIP_TPL_FRM_INO)) return;
      TIP_TPL_FRM_INO = newTIP_TPL_FRM_INO;
      setModified();
    }
    public String getTIP_TPL_FRM_INO(){
      return TIP_TPL_FRM_INO;
    }
	//----3
    public void setNOM_TPL_FRM_INO(String newNOM_TPL_FRM_INO){
      if(NOM_TPL_FRM_INO.equals(newNOM_TPL_FRM_INO)) return;
      NOM_TPL_FRM_INO = newNOM_TPL_FRM_INO;
      setModified();
    }
    public String getNOM_TPL_FRM_INO(){
      return NOM_TPL_FRM_INO;
    }
	//-------------------
   //</comment>
///**********************************************************
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetTipologieFormeDinfortunio_UserID_View(){
       BMPConnection bmp=getConnection();
       try{
          PreparedStatement ps=bmp.prepareStatement("SELECT  cod_tpl_frm_ino,tip_tpl_frm_ino,nom_tpl_frm_ino FROM cau_inf_can_tab ORDER BY tip_tpl_frm_ino,nom_tpl_frm_ino ");
         ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            CauseInfortuni_UserID_View obj=new CauseInfortuni_UserID_View();
            obj.COD_TPL_FRM_INO=rs.getLong(1);
            obj.TIP_TPL_FRM_INO=rs.getString(2);
            obj.NOM_TPL_FRM_INO=rs.getString(3);
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


	public Collection ejbfindEx(String NOM, String DES, long iOrderBy){
      String Sql="SELECT cod_tpl_frm_ino, nom_tpl_frm_ino, tip_tpl_frm_ino FROM cau_inf_can_tab ";
			int i=1;
			int desIndex=0;
			int nomIndex=0;
			if(!"".equals(NOM))
			{
			  Sql+=" WHERE ";
			  Sql+=" UPPER(nom_tpl_frm_ino) LIKE ? ";
			  nomIndex=i++;
			}
			if(!"".equals(DES))
			{
			  if (nomIndex!=0)
				{
				  Sql+=" AND ";
				}
				else
				{
				  Sql+=" WHERE ";
				}
			  Sql+=" UPPER(tip_tpl_frm_ino) LIKE ? ";
			  desIndex=i++;
			}
			Sql+=" ORDER BY nom_tpl_frm_ino ";//+ (iOrderBy>0?" ASC": "DESC");
			BMPConnection bmp=getConnection();
      try{
        PreparedStatement ps=bmp.prepareStatement(Sql);
        if(nomIndex!=0){
		  ps.setString(nomIndex, NOM.toUpperCase()+"%");
		}
		if(desIndex!=0){
		  ps.setString(desIndex, DES.toUpperCase()+"%");
		}
		ResultSet rs=ps.executeQuery();
       	java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            findEx_cau_inf  obj=new findEx_cau_inf();
            obj.COD_TPL_FRM_INO=rs.getLong(1);
            obj.TIP_TPL_FRM_INO=rs.getString(2);
            obj.NOM_TPL_FRM_INO=rs.getString(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
  //-------------------
  //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologieFormeDinfortunioBean"/>


