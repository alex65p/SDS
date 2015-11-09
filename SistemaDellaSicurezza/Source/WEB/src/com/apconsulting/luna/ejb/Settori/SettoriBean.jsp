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

<%
/*
<file>
  <versions>
    <version number="1.0" date="23/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="23/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
public class SettoriBean extends BMPEntityBean implements ISettori, ISettoriHome
{
  //<comment description="Member Variables">
  long   COD_SET;            //1
  String NOM_SET;            //2
  //----------------------------
  String DES_SET;            //3
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
 private SettoriBean() { }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ISettori create(String strNOM_SET) throws CreateException
  {
 	 SettoriBean bean =  new  SettoriBean();
	 try{
		 Object primaryKey=bean.ejbCreate(strNOM_SET);
		 bean.setEntityContext(new EntityContextWrapper(primaryKey));
		 bean.ejbPostCreate(strNOM_SET);
	     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }

 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	SettoriBean iSettoriBean=new  SettoriBean();
    try{
    	Object obj=iSettoriBean.ejbFindByPrimaryKey((Long)primaryKey);
        iSettoriBean.setEntityContext(new EntityContextWrapper(obj));
        iSettoriBean.ejbActivate();
        iSettoriBean.ejbLoad();
        iSettoriBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ISettori findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	SettoriBean bean =  new  SettoriBean();
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
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }

  // (Home Intrface) VIEWS
  public Collection getSettori_View()
  {
  	return (new SettoriBean()).ejbGetSettori_View();
  }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ISettoriHome-implementation>
  public Long ejbCreate(String strNOM_SET)
  {
    this.NOM_SET=strNOM_SET;
		this.COD_SET=NEW_ID(); // unic ID
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_set_tab (cod_set,nom_set) VALUES(?,?)");
         ps.setLong   (1, COD_SET);
         ps.setString (2, NOM_SET);
         ps.executeUpdate();
         return new Long(COD_SET);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_SET) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_set FROM ana_set_tab ");
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
    this.COD_SET=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_SET=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_set_tab  WHERE cod_set=?");
           ps.setLong (1, COD_SET);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NOM_SET=rs.getString("NOM_SET");
  			   this.DES_SET=rs.getString("DES_SET");
           }
           else{
              throw new NoSuchEntityException("Settori con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_set_tab  WHERE cod_set=?");
         ps.setLong (1, COD_SET);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Settori con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_set_tab  SET nom_set=?, des_set=? WHERE cod_set=?");
          ps.setString(1, NOM_SET);
          ps.setString(2, DES_SET);
		  ps.setLong  (3, COD_SET);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Settori con ID= non è trovata");
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
  	public void setNOM_SET(String newNOM_SET){
      if( NOM_SET.equals(newNOM_SET) ) return;
      NOM_SET = newNOM_SET;
      setModified();
    }
    public String getNOM_SET(){
      return NOM_SET;
    }
	//2
    public long getCOD_SET(){
      return COD_SET;
    }
	//============================================
	//3
  	public void setDES_SET(String newDES_SET){
      if(DES_SET!=null){
	  	if( DES_SET.equals(newDES_SET) ) return;
	  }
	  DES_SET = newDES_SET;
	  setModified();
    }
    public String getDES_SET(){
      if(DES_SET==null){return "";}
			return DES_SET;
    }

   //</comment>

  public Collection ejbGetSettori_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
		  "SELECT cod_set, nom_set, des_set FROM ana_set_tab ORDER BY nom_set ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Settori_View obj=new Settori_View();
            obj.COD_SET=rs.getLong(1);
            obj.NOM_SET=rs.getString(2);
			obj.DES_SET=rs.getString(3);
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
  
  public  Collection findEx(String NOM_SET, int iOrderBy){
  		return  ejbFindEx(NOM_SET, iOrderBy);
  }
  
  public Collection ejbFindEx(String NOM_SET, int iOrderBy){
	SearchHelper hlp= new SearchHelper("SELECT cod_set, nom_set, des_set FROM ana_set_tab ");
	if(NOM_SET!=null) hlp.m_strSql.append(" WHERE UPPER(NOM_SET) LIKE ? ");
	hlp.orderBy(iOrderBy);
	  BMPConnection bmp=getConnection();
	  try{
	          PreparedStatement ps=bmp.prepareStatement(hlp.toString());
			  hlp.startBind(ps, 1);
			  {
			  	hlp.bind(NOM_SET != null?NOM_SET.toUpperCase():NOM_SET);
			  }
			  ResultSet rs=ps.executeQuery();
	          java.util.ArrayList al=new java.util.ArrayList();
	          while(rs.next()){
	            Settori_View obj=new Settori_View();
	            obj.COD_SET=rs.getLong(1);
	            obj.NOM_SET=rs.getString(2);
				obj.DES_SET=rs.getString(3);
				al.add(obj);
	          }
			  return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
//-------------------
//</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  SettoriBean"/>
%>
<%
////////////////////////////////////////// <BINDING> 
PseudoContext.bind("SettoriBean", new SettoriBean());
////////////////////////////////////////// </BINDING>
%>
