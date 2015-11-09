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

public class OrganiBean extends BMPEntityBean implements IOrgani, IOrganiHome
{
  //-------------------
  long COD_ORN;     //1
  String NOM_ORN;   //2
  //-------------------
  String DES_ORN;   //3

 private OrganiBean() {}

  // (Home Interface) create()
  public IOrgani create(String strNOM_ORN) throws CreateException
  {
  	 OrganiBean bean =  new  OrganiBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strNOM_ORN);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_ORN);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	OrganiBean iOrganiBean=new  OrganiBean();
    try	{
    	Object obj=iOrganiBean.ejbFindByPrimaryKey((Long)primaryKey);
        iOrganiBean.setEntityContext(new EntityContextWrapper(obj));
        iOrganiBean.ejbActivate();
        iOrganiBean.ejbLoad();
        iOrganiBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public IOrgani findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	OrganiBean bean =  new  OrganiBean();
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

     // (Home Intrface) VIEWS
  public Collection getOrgani_View()
  {
  	return (new OrganiBean()).ejbGetOrgani_View();
  }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IOrganiHome-implementation>
  public Long ejbCreate(String strNOM_ORN){
    this.NOM_ORN=strNOM_ORN;
    this.COD_ORN=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_orn_tab (cod_orn,nom_orn) VALUES(?,?)");
         ps.setLong   (1, COD_ORN);
         ps.setString (2, NOM_ORN);
         ps.executeUpdate();
         return new Long(COD_ORN);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//--------------------------------------------------
  public void ejbPostCreate(String strNOM_ORN) { }
//--------------------------------------------------

  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_orn FROM ana_orn_tab ");
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
    this.COD_ORN=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_ORN=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_orn_tab  WHERE cod_orn=?");
           ps.setLong (1, COD_ORN);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_ORN=rs.getLong("COD_ORN");
           	this.NOM_ORN=rs.getString("NOM_ORN");
  			    this.DES_ORN=rs.getString("DES_ORN");
           }
           else{
              throw new NoSuchEntityException("Organi con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_orn_tab  WHERE cod_orn=?");
         ps.setLong (1, COD_ORN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Organi con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_orn_tab  SET cod_orn=?, nom_orn=?, des_orn=?	 WHERE cod_orn=?");
         ps.setLong(1, COD_ORN);
         ps.setString(2, NOM_ORN);
         ps.setString(3, DES_ORN);
         ps.setLong(4, COD_ORN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Organi con ID= non è trovata");
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
	public long getCOD_ORN(){
      return COD_ORN;
    }
  	//2
	  public void setNOM_ORN(String newNOM_ORN){
      if( NOM_ORN.equals(newNOM_ORN) ) return;
      NOM_ORN = newNOM_ORN;
      setModified();
    }
    public String getNOM_ORN(){
      return NOM_ORN;
    }
	//============================================
	// not required field
  	//3
  	public void setDES_ORN(String newDES_ORN){
      if(DES_ORN!=null) {
			 if( DES_ORN.equals(newDES_ORN) ) return;
	    }
	    DES_ORN = newDES_ORN;
	    setModified();
    }
    public String getDES_ORN(){
		  if(DES_ORN==null)return "";
      return DES_ORN;
    }
   //</comment>

  public Collection ejbGetOrgani_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_orn, nom_orn, des_orn FROM ana_orn_tab ORDER BY nom_orn ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Organi_View obj=new Organi_View();
            obj.COD_ORN=rs.getLong(1);
            obj.NOM_ORN=rs.getString(2);
            obj.DES_ORN=rs.getString(3);
            if(obj.DES_ORN==null) obj.DES_ORN="";
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
  
  //-----------------------
  
  public  Collection findEx(String NOM_ORN, int iOrderBy){
  		return  ejbFindEx(NOM_ORN, iOrderBy);
  }
  
  public Collection ejbFindEx(String NOM_ORN, int iOrderBy){
	SearchHelper hlp= new SearchHelper("SELECT cod_orn, nom_orn, des_orn FROM ana_orn_tab ");
	if(NOM_ORN!=null) hlp.m_strSql.append(" WHERE UPPER(NOM_ORN) LIKE ? ");
	hlp.orderBy(iOrderBy);
	  BMPConnection bmp=getConnection();
	  try{
          PreparedStatement ps=bmp.prepareStatement(hlp.toString());
		  hlp.startBind(ps, 1);
		  {
		  	hlp.bind(NOM_ORN != null?NOM_ORN.toUpperCase():NOM_ORN);
		  }
		  ResultSet rs=ps.executeQuery();
      java.util.ArrayList al=new java.util.ArrayList();
      while(rs.next()){
        Organi_View obj=new Organi_View();
        obj.COD_ORN=rs.getLong(1);
        obj.NOM_ORN=rs.getString(2);
        obj.DES_ORN=rs.getString(3);
        if(obj.DES_ORN==null) obj.DES_ORN="";
				al.add(obj);
      }
		  return al;
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
   	finally{
   		bmp.close();
   	}
  }
  //-------------------

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  OrganiBean"/>
%>
<%
////////////////////////////////////////// <BINDING>
 PseudoContext.bind("OrganiBean", new OrganiBean());
////////////////////////////////////////// </BINDING> 
%>
