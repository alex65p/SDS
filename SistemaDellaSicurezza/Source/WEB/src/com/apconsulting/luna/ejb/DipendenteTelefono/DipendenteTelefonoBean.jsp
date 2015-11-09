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

public class DipendenteTelefonoBean extends BMPEntityBean implements IDipendenteTelefono, IDipendenteTelefonoHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  String TPL_NUM_TEL;
  String NUM_TEL;
  long COD_DPD;
  long COD_AZL;
  long COD_NUM_TEL_DPD;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private DipendenteTelefonoBean()
  {
	//System.err.println("DipendenteTelefonoBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDipendenteTelefono create(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DPD,long lCOD_AZL) throws CreateException
  {
 	 DipendenteTelefonoBean bean =  new  DipendenteTelefonoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_DPD,lCOD_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strTPL_NUM_TEL,strNUM_TEL,lCOD_DPD,lCOD_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	DipendenteTelefonoBean iDipendenteTelefonoBean=new  DipendenteTelefonoBean();
    try
	{
    	Object obj=iDipendenteTelefonoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDipendenteTelefonoBean.setEntityContext(new EntityContextWrapper(obj));
        iDipendenteTelefonoBean.ejbActivate();
        iDipendenteTelefonoBean.ejbLoad();
        iDipendenteTelefonoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDipendenteTelefono findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DipendenteTelefonoBean bean =  new  DipendenteTelefonoBean();
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
 
 
  // (Home Intrface) VIEWS  getDipendenteTelefono_Tipology_Number_View()
  public Collection getDipendenteTelefono_Tipology_Number_View(long lCOD_DPD)
  {
  	return (new  DipendenteTelefonoBean()).ejbGetDipendenteTelefono_Tipology_Number_View(lCOD_DPD);
  }
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IDipendenteTelefonoHome-implementation>
  public Long ejbCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DPD,long lCOD_AZL)
  {
    this.TPL_NUM_TEL=strTPL_NUM_TEL;
    this.NUM_TEL=strNUM_TEL;
    this.COD_DPD=lCOD_DPD;
		this.COD_AZL=lCOD_AZL;
    this.COD_NUM_TEL_DPD=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO num_tel_dpd_tab (cod_num_tel_dpd,tpl_num_tel, num_tel, cod_dpd, cod_azl) VALUES(?,?,?,?,?)");
         ps.setLong   (1, COD_NUM_TEL_DPD);
         ps.setString (2, TPL_NUM_TEL);
         ps.setString (3, NUM_TEL);
         ps.setLong (4, COD_DPD);
         ps.setLong (5, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_NUM_TEL_DPD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strTPL_NUM_TEL,String strNUM_TEL,long lCOD_DPD,long lCOD_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_dpd FROM num_tel_dpd_tab ");
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
    this.COD_NUM_TEL_DPD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NUM_TEL_DPD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM num_tel_dpd_tab  WHERE cod_num_tel_dpd=?");
           ps.setLong (1, COD_NUM_TEL_DPD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            this.TPL_NUM_TEL=rs.getString("TPL_NUM_TEL");
  			   	this.NUM_TEL=rs.getString("NUM_TEL");
    		 		this.COD_DPD=rs.getLong("COD_DPD");
	  				this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("DipendenteTelefono con ID="+COD_NUM_TEL_DPD+" non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM num_tel_dpd_tab  WHERE cod_num_tel_dpd=?");
          ps.setLong (1, COD_NUM_TEL_DPD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteTelefono con ID="+COD_NUM_TEL_DPD+" non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE num_tel_dpd_tab  SET tpl_num_tel=?, num_tel=?, cod_dpd=?,cod_azl=? WHERE cod_num_tel_dpd=?");
          ps.setString(1, TPL_NUM_TEL);
          ps.setString(2, NUM_TEL);
          ps.setLong  (3, COD_DPD);
          ps.setLong  (4, COD_AZL);	
		  		ps.setLong  (5, COD_NUM_TEL_DPD);

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteTelefono con ID="+COD_NUM_TEL_DPD+" non &egrave trovata");
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
	public void setTPL_NUM_TEL__NUM_TEL__COD_DPD(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_DPD){
      if( TPL_NUM_TEL.equals(newTPL_NUM_TEL) ) return;
      TPL_NUM_TEL = newTPL_NUM_TEL;
      if( NUM_TEL.equals(newNUM_TEL) ) return;
      NUM_TEL = newNUM_TEL;
      if( COD_DPD == newCOD_DPD ) return;
      COD_DPD = newCOD_DPD;
      setModified();
    }
    public String getTPL_NUM_TEL(){
      return TPL_NUM_TEL;
    }
	//2
    public String getNUM_TEL(){
      return NUM_TEL;
    }
	//3
    public long getCOD_DPD(){
      return COD_DPD;
    }
	//4
	  public void setCOD_AZL(long newCOD_AZL){
      if( COD_AZL == newCOD_AZL ) return;
      COD_AZL = newCOD_AZL;
      setModified();
    }
    public long getCOD_AZL(){
      return COD_AZL;
    }
	//6
	public long getCOD_NUM_TEL_DPD(){
      return COD_NUM_TEL_DPD;
    }
	
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetDipendenteTelefono_Tipology_Number_View(long lCOD_DPD){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_num_tel_dpd,tpl_num_tel,num_tel,cod_dpd,cod_azl FROM num_tel_dpd_tab WHERE cod_dpd=? order by tpl_num_tel");
		  ps.setLong(1, lCOD_DPD);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendenteTelefono_Tipology_Number_View obj=new DipendenteTelefono_Tipology_Number_View();
            obj.COD_NUM_TEL_DPD=rs.getLong(1);
            obj.TPL_NUM_TEL=rs.getString(2);
            obj.NUM_TEL=rs.getString(3);
            obj.COD_DPD=rs.getLong(4);
            obj.COD_AZL=rs.getLong(5);
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
}//<comment description="end of implementation  DipendenteTelefonoBean"/>
%>

<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DipendenteTelefonoBean", new DipendenteTelefonoBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
