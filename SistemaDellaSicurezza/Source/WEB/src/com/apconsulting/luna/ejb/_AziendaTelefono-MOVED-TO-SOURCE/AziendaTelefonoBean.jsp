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

<%
/*
<file>
  <versions>	
    <version number="1.0" date="14/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="14/01/2004" author="Roman Chumachenko">
				   <description>AziendaTelefonoBean.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class AziendaTelefonoBean extends BMPEntityBean implements IAziendaTelefonoHome, IAziendaTelefono
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long COD_NUM_TEL_AZL;  //1
  long COD_AZL;          //2
  String TPL_NUM_TEL;    //3
  String NUM_TEL;        //4
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private AziendaTelefonoBean()
  {
	//System.err.println("AziendaTelefonoBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IAziendaTelefono create(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_AZL) throws CreateException
  {
 	 AziendaTelefonoBean bean =  new  AziendaTelefonoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	AziendaTelefonoBean iAziendaTelefonoBean=new AziendaTelefonoBean();
    try
	{
    	Object obj=iAziendaTelefonoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iAziendaTelefonoBean.setEntityContext(new EntityContextWrapper(obj));
        iAziendaTelefonoBean.ejbActivate();
        iAziendaTelefonoBean.ejbLoad();
        iAziendaTelefonoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex.getMessage());
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IAziendaTelefono findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	AziendaTelefonoBean bean =  new  AziendaTelefonoBean();
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
  public Collection findAll() throws FinderException
  {
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS
  public Collection getAziendaTelefoniByAZLID_View(long AZL_ID)
  {
  	return (new AziendaTelefonoBean()).ejbGetAziendaTelefoniByAZLID_View(AZL_ID);
  }
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IAziendaHome-implementation>
  public Long ejbCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_AZL)
  {
    this.COD_AZL=lCOD_AZL;
    this.TPL_NUM_TEL=strTPL_NUM_TEL;
    this.NUM_TEL=strNUM_TEL;
	this.COD_NUM_TEL_AZL=NEW_ID();  // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO num_tel_azl_tab (cod_num_tel_azl,tpl_num_tel, num_tel, cod_azl) VALUES(?,?,?,?)");
         ps.setLong   (1, COD_NUM_TEL_AZL);
         ps.setString (2, TPL_NUM_TEL);
         ps.setString (3, NUM_TEL);
         ps.setLong   (4, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_NUM_TEL_AZL);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_azl FROM num_tel_azl_tab ");
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
    this.COD_NUM_TEL_AZL=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NUM_TEL_AZL=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM num_tel_azl_tab  WHERE cod_num_tel_azl=?");
           ps.setLong (1, COD_NUM_TEL_AZL);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.TPL_NUM_TEL=rs.getString("TPL_NUM_TEL"); 	//1
  			   	this.NUM_TEL=rs.getString("NUM_TEL"); 	  		//2
    		 	this.COD_AZL=rs.getLong("COD_AZL"); 	  		//3
           }
           else{
              throw new NoSuchEntityException("AziendaTelefono con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM num_tel_azl_tab  WHERE cod_num_tel_azl=?");
          ps.setLong (1, COD_NUM_TEL_AZL);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("AziendaTelefono con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE num_tel_azl_tab SET tpl_num_tel=?, num_tel=?, cod_azl=?  WHERE cod_num_tel_azl=?");
          ps.setString (1, TPL_NUM_TEL);
          ps.setString (2, NUM_TEL);
          ps.setLong   (3, COD_AZL);
		  ps.setLong   (4, COD_NUM_TEL_AZL);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("AziendaTelefono con ID= non è trovata");
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
	public void setTPL_NUM_TEL__NUM_TEL__COD_AZL(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_AZL){
      if( (TPL_NUM_TEL.equals(newTPL_NUM_TEL))&(NUM_TEL.equals(newNUM_TEL))&(COD_AZL==newCOD_AZL) ) return;
      TPL_NUM_TEL = newTPL_NUM_TEL;
	  NUM_TEL = newNUM_TEL;
	  COD_AZL = newCOD_AZL;
	  setModified();
    }
	public String getTPL_NUM_TEL(){
      if(TPL_NUM_TEL==null)
	  {return "";}else{return TPL_NUM_TEL;}
    }
	//2
	public String getNUM_TEL(){
	  if(NUM_TEL==null)
	  {return "";}else{return NUM_TEL;}
	}  
	//3
    public long getCOD_AZL(){
	  return COD_AZL;
    }
    //4
    public long getCOD_NUM_TEL_AZL(){
      return COD_NUM_TEL_AZL;
    }
	//</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
	public Collection ejbGetAziendaTelefoniByAZLID_View(long AZL_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_azl,tpl_num_tel,num_tel FROM num_tel_azl_tab WHERE cod_azl=? ");
		  ps.setLong(1, AZL_ID);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            AziendaTelefoniByAZLID_View obj=new AziendaTelefoniByAZLID_View();
            obj.COD_NUM_TEL_AZL=rs.getLong(1);
            obj.TPL_NUM_TEL=rs.getString(2);
            obj.NUM_TEL=rs.getString(3);
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
        
        public Collection getAziendaTelefoniCellulariFax_View(long AZL_ID, String strTPL_NUM_TEL){
            return (new AziendaTelefonoBean()).ejbGetAziendaTelefoniCellulariFax_View(AZL_ID, strTPL_NUM_TEL);
        }
        
	public Collection ejbGetAziendaTelefoniCellulariFax_View(long AZL_ID, String strTPL_NUM_TEL){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
                  "SELECT " +
                    "num_tel " +
                  "FROM " +
                    "num_tel_azl_tab " +
                  "WHERE " +
                    "cod_azl = ? " +
                  "AND " +
                    "tpl_num_tel = ? ");
		  ps.setLong(1, AZL_ID);
                  ps.setString(2, strTPL_NUM_TEL);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
          AziendaTelefoniCellulariFax_View obj=new AziendaTelefoniCellulariFax_View();
                obj.NUM_TEL=rs.getString(1);
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

///////////ATTENTION!!////////////////////////////////////////////////
}//<comment description="end of implementation  AziendaTelefonoBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////
PseudoContext.bind("AziendaTelefonoBean", new AziendaTelefonoBean());////
/////////////////////////////////////////////////////////////////////////
%>
