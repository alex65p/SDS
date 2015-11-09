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
    <version number="1.0" date="25/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="25/01/2004" author="Roman Chumachenko">
				   <description>DittaEsternaTelefonoBean.jsp</description>
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

public class DittaEsternaTelefonoBean extends BMPEntityBean implements IDittaEsternaTelefonoHome, IDittaEsternaTelefono
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long COD_NUM_TEL_DTE;  //1
  long COD_DTE;          //2
  String TPL_NUM_TEL;    //3
  String NUM_TEL;        //4
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private DittaEsternaTelefonoBean()
  {
	//System.err.println("DittaEsternaTelefonoBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDittaEsternaTelefono create(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DTE) throws CreateException
  {
 	 DittaEsternaTelefonoBean bean =  new  DittaEsternaTelefonoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_DTE);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_DTE);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	DittaEsternaTelefonoBean iDittaEsternaTelefonoBean=new DittaEsternaTelefonoBean();
    try
	{
    	Object obj=iDittaEsternaTelefonoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDittaEsternaTelefonoBean.setEntityContext(new EntityContextWrapper(obj));
        iDittaEsternaTelefonoBean.ejbActivate();
        iDittaEsternaTelefonoBean.ejbLoad();
        iDittaEsternaTelefonoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex.getMessage());
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDittaEsternaTelefono findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DittaEsternaTelefonoBean bean =  new  DittaEsternaTelefonoBean();
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
  public Collection getDittaEsternaTelefoniByDTEID_View(long DTE_ID)
  {
  	return (new DittaEsternaTelefonoBean()).ejbGetDittaEsternaTelefoniByDTEID_View(DTE_ID);
  }
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IAziendaHome-implementation>
  public Long ejbCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DTE)
  {
    this.COD_DTE=lCOD_DTE;
    this.TPL_NUM_TEL=strTPL_NUM_TEL;
    this.NUM_TEL=strNUM_TEL;
	this.COD_NUM_TEL_DTE=NEW_ID();  // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO num_tel_dte_tab (cod_num_tel_dte,tpl_num_tel, num_tel, cod_dte) VALUES(?,?,?,?)");
         ps.setLong   (1, COD_NUM_TEL_DTE);
         ps.setString (2, TPL_NUM_TEL);
         ps.setString (3, NUM_TEL);
         ps.setLong   (4, COD_DTE);
         ps.executeUpdate();
         return new Long(COD_NUM_TEL_DTE);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DTE) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_dte FROM num_tel_dte_tab ");
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
    this.COD_NUM_TEL_DTE=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NUM_TEL_DTE=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM num_tel_dte_tab  WHERE cod_num_tel_dte=?");
           ps.setLong (1, COD_NUM_TEL_DTE);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.TPL_NUM_TEL=rs.getString("TPL_NUM_TEL"); 	//1
  			   	this.NUM_TEL=rs.getString("NUM_TEL"); 	  		//2
    		 	this.COD_DTE=rs.getLong("COD_DTE"); 	  		//3
           }
           else{
              throw new NoSuchEntityException("DittaEsternaTelefono con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM num_tel_dte_tab  WHERE cod_num_tel_dte=?");
          ps.setLong (1, COD_NUM_TEL_DTE);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DittaEsternaTelefono con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE num_tel_dte_tab SET tpl_num_tel=?, num_tel=?, cod_dte=?  WHERE cod_num_tel_dte=?");
          ps.setString (1, TPL_NUM_TEL);
          ps.setString (2, NUM_TEL);
          ps.setLong   (3, COD_DTE);
		  ps.setLong   (4, COD_NUM_TEL_DTE);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DittaEsternaTelefono con ID= non è trovata");
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
	public void setTPL_NUM_TEL__NUM_TEL__COD_DTE(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_DTE){
      if( (TPL_NUM_TEL.equals(newTPL_NUM_TEL))&&(NUM_TEL.equals(newNUM_TEL))&&(COD_DTE==newCOD_DTE) ) return;
      TPL_NUM_TEL = newTPL_NUM_TEL;
	  NUM_TEL = newNUM_TEL;
	  COD_DTE = newCOD_DTE;
	  setModified();
    }
	public String getTPL_NUM_TEL(){
	  return (TPL_NUM_TEL!=null)?TPL_NUM_TEL:"";
    }
	//2
	public String getNUM_TEL(){
	  return (NUM_TEL!=null)?NUM_TEL:"";
	}  
	//3
    public long getCOD_DTE(){
	  return COD_DTE;
    }
    //4
    public long getCOD_NUM_TEL_DTE(){
      return COD_NUM_TEL_DTE;
    }
	//</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
	public Collection ejbGetDittaEsternaTelefoniByDTEID_View(long DTE_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_dte,tpl_num_tel,num_tel FROM num_tel_dte_tab WHERE cod_dte=? ");
		  ps.setLong(1, DTE_ID);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DittaEsternaTelefoniByDTEID_View obj=new DittaEsternaTelefoniByDTEID_View();
            obj.COD_NUM_TEL_DTE=rs.getLong(1);
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

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AziendaBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DittaEsternaTelefonoBean", new DittaEsternaTelefonoBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
