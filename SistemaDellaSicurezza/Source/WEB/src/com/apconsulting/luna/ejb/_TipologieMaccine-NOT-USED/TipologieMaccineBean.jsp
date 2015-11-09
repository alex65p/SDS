<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class TipologieMaccineBean extends BMPEntityBean implements ITipologieMaccine, ITipologieMaccineHome
{
  long COD_TPL_MAC;    //1
  String DES_TPL_MAC;  //2
  
  private TipologieMaccineBean() {}
  
  // (Home Interface) create()
  public ITipologieMaccine create(String strDES_TPL_MAC) throws CreateException
  {
  	 TipologieMaccineBean bean =  new  TipologieMaccineBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strDES_TPL_MAC);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strDES_TPL_MAC);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
 {
  	TipologieMaccineBean iTipologieMaccineBean=new  TipologieMaccineBean();
    try	{
    	Object obj=iTipologieMaccineBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologieMaccineBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologieMaccineBean.ejbActivate();
        iTipologieMaccineBean.ejbLoad();
        iTipologieMaccineBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public ITipologieMaccine findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologieMaccineBean bean =  new  TipologieMaccineBean();
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

  //</ITipologieMaccineHome-implementation>
  public Long ejbCreate(String strDES_TPL_MAC){
    this.DES_TPL_MAC=strDES_TPL_MAC;
    this.COD_TPL_MAC=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO tpl_mac_tab (cod_tpl_mac,des_tpl_mac) VALUES(?,?)");
         ps.setLong   (1, COD_TPL_MAC);
         ps.setString (2, DES_TPL_MAC);
         ps.executeUpdate();
         return new Long(COD_TPL_MAC);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }
//-------------------------------------------------------   
  public void ejbPostCreate(String strDES_TPL_MAC) { }	
//--------------------------------------------------
  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_mac FROM tpl_mac_tab ");
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
    this.COD_TPL_MAC=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_TPL_MAC=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_mac_tab  WHERE cod_tpl_mac=?");
           ps.setLong (1, COD_TPL_MAC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_TPL_MAC=rs.getLong("COD_TPL_MAC");
           	this.DES_TPL_MAC=rs.getString("DES_TPL_MAC");
           }
           else{
              throw new NoSuchEntityException("Tipologie Maccine con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_mac_tab  WHERE cod_tpl_mac=?");
         ps.setLong (1, COD_TPL_MAC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Maccine con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_mac_tab  SET cod_tpl_mac=?, des_tpl_mac=? WHERE cod_tpl_mac=?");
         ps.setLong(1, COD_TPL_MAC);
         ps.setString(2, DES_TPL_MAC);
         ps.setLong(3, COD_TPL_MAC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Maccine con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
	  public long getCOD_TPL_MAC(){
      return COD_TPL_MAC;
    }
  	//2
	  public void setDES_TPL_MAC(String newDES_TPL_MAC){
      if( DES_TPL_MAC.equals(newDES_TPL_MAC) ) return;
      DES_TPL_MAC = newDES_TPL_MAC;
      setModified();
    }
    public String getDES_TPL_MAC(){
      return DES_TPL_MAC;
    }
   //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologieMaccineBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////////////
PseudoContext.bind("TipologieMaccineBean", new TipologieMaccineBean());
////////////////////////////////////////// </BINDING> /////////////////
%>
