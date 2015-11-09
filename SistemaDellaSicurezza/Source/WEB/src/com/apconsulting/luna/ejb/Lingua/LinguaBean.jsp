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
				   <description>LinguaBean.jsp</description>
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

public class LinguaBean extends BMPEntityBean implements ILinguaHome, ILingua
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
	String NOM_LNG;
	long COD_LNG;

////////////////////////// CONSTRUCTOR//////////////////////////////////////////
 private LinguaBean() { }
////////////////////////////////////////////////////////////////////////////////

//  Zdes opredeliayutsia metody EJB objecta
 public void remove(Object primaryKey)
  {
        LinguaBean iLinguaBean=new  LinguaBean();
        try{
          Object obj=iLinguaBean.ejbFindByPrimaryKey((Long)primaryKey);
          iLinguaBean.setEntityContext(new EntityContextWrapper(obj));
          iLinguaBean.ejbActivate();
          iLinguaBean.ejbLoad();
          iLinguaBean.ejbRemove();
        }
        catch(Exception ex){
          throw new EJBException(ex.getMessage());
        }
  }
  public ILingua create(String strNOM_LNG)
  {
 	 LinguaBean bean =  new  LinguaBean();
	 Object primaryKey=bean.ejbCreate(strNOM_LNG);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_LNG);
   return bean;
  }
  
  public ILingua findByPrimaryKey(Long primaryKey)
  {
   LinguaBean bean =  new  LinguaBean();
   bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbActivate();
	 bean.ejbLoad();
   return bean;
  }
  
  public Collection findAll()
  {
  		return this.ejbFindAll();
  }
  
  // (Home Intrface) VIEWS  getAzienda_Name_Address_View()
  public Collection getLingua_View()
  {
  	return (new  LinguaBean()).ejbGetLingua_View();
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
  //</IAziendaHome-implementation>
  public Long ejbCreate(String strNOM_LNG)
  {
   
	this.NOM_LNG=strNOM_LNG;
    this.COD_LNG=NEW_ID(); 	// unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       	 PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_lng_tab (cod_lng, nom_lng) VALUES(?,?)");
         ps.setLong(1,COD_LNG);
         ps.setString(2, NOM_LNG);
         ps.executeUpdate();
       return (new Long(COD_LNG));
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_LNG) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lng FROM ana_lng_tab ");
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
    this.COD_LNG=((Long)this.getEntityKey()).longValue();
  
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_LNG=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_lng_tab  WHERE cod_lng=?");
           ps.setLong(1, COD_LNG);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
  			   	this.COD_LNG=rs.getLong("COD_LNG");
    		 	this.NOM_LNG=rs.getString("NOM_LNG");
           }
           else{
              throw new NoSuchEntityException("Lingua con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_lng_tab  WHERE cod_lng=?");
          ps.setLong(1, COD_LNG);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Lingua con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_lng_tab  SET  nom_lng=? WHERE cod_lng=?");
          
          ps.setString(1, NOM_LNG);
          ps.setLong(2, COD_LNG);	
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Lingua with ID= not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

//<comment description="extended setters/getters">

//</comment>

//<comment description="setter/getters">  
	//----1
  public void setNOM_LNG(String newNOM_LNG){
      if(NOM_LNG == newNOM_LNG) return;
       NOM_LNG= newNOM_LNG;
      setModified();
    }
    public String getNOM_LNG(){
      if(NOM_LNG==null)
	  {return "";}else{return NOM_LNG;}
    }
	
	//----------2
    public long getCOD_LNG(){
      return COD_LNG;
    }
	//-------------------
  //</comment>
  
  //<comment description="Zdes opredeliayutsia metody-views"/>
   
    public Collection ejbGetLingua_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lng,nom_lng FROM ana_lng_tab ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Lingua_View obj=new Lingua_View();
            obj.COD_LNG=rs.getLong(1);
            obj.NOM_LNG=rs.getString(2);
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
}// end of implementation  
%>
<%
////////////////////////////////////////// <BINDING>  
PseudoContext.bind("LinguaBean", new LinguaBean());   
////////////////////////////////////////// </BINDING> 
%>
