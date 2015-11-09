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

public class FornitoreTelefonoBean extends BMPEntityBean implements IFornitoreTelefono, IFornitoreTelefonoHome
//class FornitoreTelefonoBean extends IFornitoreTelefonoHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
	long COD_NUM_TEL_FOR_AZL;	//1
	String TPL_NUM_TEL;				//2
	String NUM_TEL;						//3
	long COD_FOR_AZL;					//4

  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private FornitoreTelefonoBean()
  {
	//System.err.println("FornitoreTelefonoBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IFornitoreTelefono create(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_FOR_AZL) throws CreateException
  {
 	 FornitoreTelefonoBean bean =  new  FornitoreTelefonoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strTPL_NUM_TEL, strNUM_TEL, lCOD_FOR_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strTPL_NUM_TEL, strNUM_TEL, lCOD_FOR_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	FornitoreTelefonoBean iFornitoreTelefonoBean=new  FornitoreTelefonoBean();
    try
	{
    	Object obj=iFornitoreTelefonoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iFornitoreTelefonoBean.setEntityContext(new EntityContextWrapper(obj));
        iFornitoreTelefonoBean.ejbActivate();
        iFornitoreTelefonoBean.ejbLoad();
        iFornitoreTelefonoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IFornitoreTelefono findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	FornitoreTelefonoBean bean =  new  FornitoreTelefonoBean();
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
 
  // (Home Intrface) 
  public Collection getFornitoreTelefonoByFORAZLID_View(long FOR_AZL_ID)
  {
  	return (new  FornitoreTelefonoBean()).ejbGetFornitoreTelefonoByFORAZLID_View(FOR_AZL_ID);
 }
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IFornitoreTelefonoHome-implementation>
  public Long ejbCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_FOR_AZL)
  {
    this.TPL_NUM_TEL=strTPL_NUM_TEL;
    this.NUM_TEL=strNUM_TEL;
		this.COD_FOR_AZL=lCOD_FOR_AZL;
    this.COD_NUM_TEL_FOR_AZL=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO num_tel_for_azl_tab (cod_num_tel_for_azl, tpl_num_tel,num_tel, cod_for_azl) VALUES(?,?,?,?)");
         ps.setLong   (1, COD_NUM_TEL_FOR_AZL);
         ps.setString (2, TPL_NUM_TEL);
         ps.setString (3, NUM_TEL);
         ps.setLong (4, COD_FOR_AZL);
         ps.executeUpdate();
         return new Long(COD_NUM_TEL_FOR_AZL);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_FOR_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_for_azl FROM num_tel_for_azl_tab ");
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
    this.COD_NUM_TEL_FOR_AZL=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NUM_TEL_FOR_AZL=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM num_tel_for_azl_tab  WHERE cod_num_tel_for_azl=?");
           ps.setLong (1, COD_NUM_TEL_FOR_AZL);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.TPL_NUM_TEL=rs.getString("TPL_NUM_TEL");
  			   			this.NUM_TEL=rs.getString("NUM_TEL");
    		 				this.COD_FOR_AZL=rs.getLong("COD_FOR_AZL");
	           }
           else{
              throw new NoSuchEntityException("Telefono con ID= non è trovato");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM num_tel_for_azl_tab  WHERE cod_num_tel_for_azl=?");
          ps.setLong (1, COD_NUM_TEL_FOR_AZL);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Telefono con ID="+COD_NUM_TEL_FOR_AZL+" non è trovato");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE num_tel_for_azl_tab  SET tpl_num_tel=?, num_tel=?,cod_for_azl=?	 WHERE cod_num_tel_for_azl=?");
          ps.setString(1, TPL_NUM_TEL);
          ps.setString(2, NUM_TEL);
          ps.setLong(3, COD_FOR_AZL);
          ps.setLong(4, COD_NUM_TEL_FOR_AZL);	

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Telefono with ID= non &egrave trovato");
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
		public long getCOD_NUM_TEL_FOR_AZL(){
      return COD_NUM_TEL_FOR_AZL;
    }
	//2
	  public void setTPL_NUM_TEL__NUM_TEL__COD_FOR_AZL(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_FOR_AZL){
      if((TPL_NUM_TEL.equals(newTPL_NUM_TEL)) && (NUM_TEL.equals(newNUM_TEL)) && (COD_FOR_AZL==newCOD_FOR_AZL)) return;
      TPL_NUM_TEL = newTPL_NUM_TEL;
			NUM_TEL = newNUM_TEL;
			COD_FOR_AZL = newCOD_FOR_AZL;
      setModified();
    }
    public String getTPL_NUM_TEL(){
      return TPL_NUM_TEL;
    }
	//3
    public String getNUM_TEL(){
      return NUM_TEL;
    }
	//4
    public long getCOD_FOR_AZL(){
      return COD_FOR_AZL;
    }
   //</comment>
 
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetFornitoreTelefonoByFORAZLID_View(long FOR_AZL_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_for_azl,tpl_num_tel,num_tel FROM num_tel_for_azl_tab WHERE cod_for_azl=?  ");
          ps.setLong(1, FOR_AZL_ID);
					
					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            FornitoreTelefonoByFORAZLID_View obj=new FornitoreTelefonoByFORAZLID_View();
            obj.COD_NUM_TEL_FOR_AZL=rs.getLong(1);
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

  //-------------------
  //</comment>       
 
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  FornitoreTelefonoBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("FornitoreTelefonoBean", new FornitoreTelefonoBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
