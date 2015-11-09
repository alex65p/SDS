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
    <version number="1.0" date="14/01/2004" author="Alexandr Kyba">
	      		<comments>
				  <comment date="14/01/2004" author="Alexandr Kyba">
				   <description>NazionalitaBean.jsp</description>
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
<%!
//  Zdes opredeliaetsia realizatzija EJB obiekta

public class NazionalitaBean extends BMPEntityBean implements INazionalitaHome, INazionalita
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
	String NOM_STA;
	long COD_STA;
	long COD_LNG;
  //</comment>
////////////////////////// CONSTRUCTOR//////////////////////////////////////////
 private NazionalitaBean()
  {
  }
////////////////////////////////////////////////////////////////////////////////

//  Zdes opredeliayutsia metody EJB objecta
 public void remove(Object primaryKey)
  {
        NazionalitaBean iNazionalitaBean=new  NazionalitaBean();
        try{
          Object obj=iNazionalitaBean.ejbFindByPrimaryKey((Long)primaryKey);
          iNazionalitaBean.setEntityContext(new EntityContextWrapper(obj));
          iNazionalitaBean.ejbActivate();
          iNazionalitaBean.ejbLoad();
          iNazionalitaBean.ejbRemove();
        }
        catch(Exception ex){
          throw new EJBException(ex.getMessage());
        }
  }
  public INazionalita create(String strNOM_STA, long lCOD_LNG)
  {
 	 NazionalitaBean bean =  new  NazionalitaBean();
	 Object primaryKey=bean.ejbCreate(strNOM_STA, lCOD_LNG);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_STA, lCOD_LNG);
   return bean;
  }
  
  public INazionalita findByPrimaryKey(Long primaryKey)
  {
   NazionalitaBean bean =  new  NazionalitaBean();
   bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbActivate();
	 bean.ejbLoad();
   return bean;
  }
  
  public Collection findAll()
  {
  		return this.ejbFindAll();
  }
  //------------------------------------------------------------
   public Collection getNazionalita_View()
   {
   		return (new  NazionalitaBean()).ejbGetNazionalita_View();
   }
   public Collection getNazionalita_Names_View(long COD_LNG)
   {
   		return (new  NazionalitaBean()).ejbGetNazionalita_Names_View(COD_LNG);
   }	 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
  //</IAziendaHome-implementation>
  public Long ejbCreate(String strNOM_STA, long lCOD_LNG)
  {
	this.NOM_STA=strNOM_STA;
	this.COD_LNG=lCOD_LNG;
    this.COD_STA=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       	 PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_sta_tab (cod_sta, nom_sta, cod_lng) VALUES(?,?,?)");
         ps.setLong  (1, COD_STA);
         ps.setString(2, NOM_STA);
         ps.setLong  (3, COD_LNG);
         ps.executeUpdate();
       return (new Long(COD_STA));
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_STA, long lCOD_LNG) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sta FROM ana_sta_tab ");
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

//-----------------------------------------------------------
  	
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_STA=((Long)this.getEntityKey()).longValue();
  
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_STA=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_sta_tab  WHERE cod_sta=?");
           ps.setLong(1, COD_STA);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
  			   	this.COD_LNG=rs.getLong("COD_LNG");
    		 	this.NOM_STA=rs.getString("NOM_STA");
			  	this.COD_STA=rs.getLong("COD_STA");
           }
           else{
              throw new NoSuchEntityException("Nazionalita con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_sta_tab  WHERE cod_sta=?");
          ps.setLong(1, COD_STA);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Nazionalita con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_sta_tab  SET  nom_sta=?, cod_lng=? WHERE cod_sta=?");
          
          ps.setString(1, NOM_STA);
          ps.setLong  (2, COD_LNG);	
		  ps.setLong  (3, COD_STA);	  
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Nazionalita with ID= not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
  
  
//-------------------------------------------------------------
//<comment description="setter/getters">  
	//----1
  	public void setNOM_STA_COD_LNG(String newNOM_STA, long newCOD_LNG){
      if( (NOM_STA.equals(newNOM_STA))&(COD_LNG==newCOD_LNG) ) return;
       NOM_STA = newNOM_STA;
       COD_LNG = newCOD_LNG;
      setModified();
    }
    public String getNOM_STA(){
      if(NOM_STA==null)
	  {return "";}else{return NOM_STA;}
    }
	//2
    public long getCOD_LNG(){
      return COD_LNG;
    }
	//3
	public long getCOD_STA(){
      return COD_STA;
    }
	//-------------------
  //</comment>
   //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetNazionalita_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ast.cod_sta,ast.nom_sta, ast.img_naz, alt.cod_lng, alt.nom_lng FROM ana_sta_tab ast,ana_lng_tab alt where ast.cod_lng = alt.cod_lng ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Nazionalita_View obj=new Nazionalita_View();
            obj.COD_STA=rs.getLong(1);
            obj.NOM_STA=rs.getString(2);
			obj.COD_LNG=rs.getLong(3);
			obj.NOM_LNG=rs.getString(4);
			//obj.IMG_NAZ=rs.getString(5);
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
  //-----------------------------------------------------------
  public Collection ejbGetNazionalita_Names_View(long COD_LNG){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sta,nom_sta FROM ana_sta_tab WHERE cod_lng= ? ORDER BY nom_sta asc");
					ps.setLong  (1, COD_LNG);	
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Nazionalita_Names_View obj=new Nazionalita_Names_View();
            obj.COD_STA=rs.getLong(1);
            obj.NOM_STA=rs.getString(2);
            //obj.IMG_NAZ=rs.getString(3);
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
  
  
  //</comment>
  //-------------------
}// end of implementation  
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
PseudoContext.bind("NazionalitaBean", new NazionalitaBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
