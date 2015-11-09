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
    <version number="1.0" date="" author="">
	      <comments>
					<comment date="27/03/2004" author="Treskina Maria">
				   <description>Search</description>
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

public class ClassificazioneAgentiChimiciBean extends BMPEntityBean implements IClassificazioneAgentiChimici, IClassificazioneAgentiChimiciHome{
  long COD_CLF_SOS;              //1
  String DES_CLF_SOS;            //2

 private ClassificazioneAgentiChimiciBean() { //System.err.println("ClassificazioneAgentiChimiciBean constructor<br>");
   }

  // (Home Interface) create()
  public IClassificazioneAgentiChimici create(String strDES_CLF_SOS) throws CreateException
  {
  	 ClassificazioneAgentiChimiciBean bean =  new  ClassificazioneAgentiChimiciBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strDES_CLF_SOS);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strDES_CLF_SOS);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	ClassificazioneAgentiChimiciBean iClassificazioneAgentiChimiciBean=new  ClassificazioneAgentiChimiciBean();
    try	{
    	Object obj=iClassificazioneAgentiChimiciBean.ejbFindByPrimaryKey((Long)primaryKey);
        iClassificazioneAgentiChimiciBean.setEntityContext(new EntityContextWrapper(obj));
        iClassificazioneAgentiChimiciBean.ejbActivate();
        iClassificazioneAgentiChimiciBean.ejbLoad();
        iClassificazioneAgentiChimiciBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public IClassificazioneAgentiChimici findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	ClassificazioneAgentiChimiciBean bean =  new  ClassificazioneAgentiChimiciBean();
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

  //</IClassificazioneAgentiChimiciHome-implementation>
  public Long ejbCreate(String strDES_CLF_SOS){
    this.DES_CLF_SOS=strDES_CLF_SOS;
    this.COD_CLF_SOS=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_clf_sos_tab (cod_clf_sos,des_clf_sos) VALUES(?,?)");
         ps.setLong   (1, COD_CLF_SOS);
         ps.setString (2, DES_CLF_SOS);
         ps.executeUpdate();
         return new Long(COD_CLF_SOS);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strDES_CLF_SOS) { }	
//--------------------------------------------------

  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_clf_sos FROM ana_clf_sos_tab ");
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
    this.COD_CLF_SOS=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_CLF_SOS=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_clf_sos_tab  WHERE cod_clf_sos=?");
           ps.setLong (1, COD_CLF_SOS);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_CLF_SOS=rs.getLong("COD_CLF_SOS");
           	this.DES_CLF_SOS=rs.getString("DES_CLF_SOS");
           }
           else{
              throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_clf_sos_tab  WHERE cod_clf_sos=?");
         ps.setLong (1, COD_CLF_SOS);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_clf_sos_tab  SET cod_clf_sos=?, des_clf_sos=? WHERE cod_clf_sos=?");
         ps.setLong(1, COD_CLF_SOS);
         ps.setString(2, DES_CLF_SOS);
         ps.setLong(3, COD_CLF_SOS);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
  //
     public Collection getClassificazione_View()
	 {
		return (new ClassificazioneAgentiChimiciBean()).ejbGetClassificazione_View();
	 }

//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
	  public long getCOD_CLF_SOS(){
      return COD_CLF_SOS;
    }
  	//2
	  public void setDES_CLF_SOS(String newDES_CLF_SOS){
      if( DES_CLF_SOS.equals(newDES_CLF_SOS) ) return;
      DES_CLF_SOS = newDES_CLF_SOS;
      setModified();
    }
    public String getDES_CLF_SOS(){
      return DES_CLF_SOS;
    }
	//============================================
	//</comment>
	
	//</setter-getters>
     public Collection ejbGetClassificazione_View()
	 {
		BMPConnection bmp=getConnection();
		try
		{
        	PreparedStatement ps=bmp.prepareStatement("SELECT cod_clf_sos,des_clf_sos FROM ana_clf_sos_tab ORDER BY des_clf_sos");
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				Classificazione_View obj=new Classificazione_View();
				obj.lCOD_CLF_SOS = rs.getLong(1);
				obj.strDES_CLF_SOS = rs.getString(2);
				al.add(obj);
			}
			bmp.close();
			return al;
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	 }

	//---- mary for search
	 public Collection findEx(  
	 												String strDES_CLF_SOS, 
													int iOrderParameter //not used for now
												){
		return ejbFindEx(strDES_CLF_SOS, iOrderParameter);
	}
	
	public Collection ejbFindEx(  
													String strDES_CLF_SOS, 
													int iOrderParameter //not used for now
												){
		String strSql="SELECT cod_clf_sos, des_clf_sos FROM ana_clf_sos_tab ";
		
		if(strDES_CLF_SOS!=null){
				strSql+=" WHERE UPPER(des_clf_sos) LIKE ? ";
		}
		
		strSql+=" ORDER BY UPPER(des_clf_sos)";

		int i=1;
		BMPConnection bmp=getConnection();
			try{
				PreparedStatement ps=bmp.prepareStatement(strSql);
				
				if(strDES_CLF_SOS!=null) ps.setString(i++, strDES_CLF_SOS.toUpperCase());
				ResultSet rs=ps.executeQuery();
	      java.util.ArrayList ar= new java.util.ArrayList();
	      while(rs.next()){
	      	Classificazione_View obj=new Classificazione_View();
					obj.lCOD_CLF_SOS = rs.getLong(1);
					obj.strDES_CLF_SOS = rs.getString(2);
	        ar.add(obj);
	      }
				return ar;
				//----------------------------------------------------------------------
		  }
        catch(Exception ex){
					throw new EJBException(strSql+"/n"+ex);
      }
		  finally{bmp.close();}
	} 
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  ClassificazioneAgentiChimiciBean"/>
%>
<%
////////////////////////////////////////// <BINDING> 
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("ClassificazioneAgentiChimiciBean", new ClassificazioneAgentiChimiciBean());
////////////////////////////////////////// </BINDING> 
%>
