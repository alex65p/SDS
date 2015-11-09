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

public class SottosettoriBean extends BMPEntityBean implements ISottosettori, ISottosettoriHome
{
  //<comment description="Member Variables">
	long   COD_SOT_SET;        //1
	String NOM_SOT_SET;        //2
 	//----------------------------
  	String DES_SOT_SET;        //3
  	//</comment>

////////////////////// CONSTRUCTOR///////////////////
 private SottosettoriBean(){}
/////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ISottosettori create(String strNOM_SOT_SET) throws CreateException
  {
 	 SottosettoriBean bean =  new  SottosettoriBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_SOT_SET);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_SOT_SET);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	SottosettoriBean iSottosettoriBean=new  SottosettoriBean();
    try{
    	Object obj=iSottosettoriBean.ejbFindByPrimaryKey((Long)primaryKey);
        iSottosettoriBean.setEntityContext(new EntityContextWrapper(obj));
        iSottosettoriBean.ejbActivate();
        iSottosettoriBean.ejbLoad();
        iSottosettoriBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ISottosettori findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	SottosettoriBean bean =  new  SottosettoriBean();
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
  public Collection getSottosettori_View()
  {
  	return (new SottosettoriBean()).ejbGetSottosettori_View();
  }


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ISottosettoriHome-implementation>
  public Long ejbCreate(String strNOM_SOT_SET)
  {
    this.NOM_SOT_SET=strNOM_SOT_SET;
		this.COD_SOT_SET=NEW_ID(); // unic ID
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_sot_set_tab (cod_sot_set,nom_sot_set) VALUES(?,?)");
         ps.setLong   (1, COD_SOT_SET);
         ps.setString (2, NOM_SOT_SET);
         ps.executeUpdate();
         return new Long(COD_SOT_SET);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_SOT_SET) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sot_set FROM ana_sot_set_tab ");
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
    this.COD_SOT_SET=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_SOT_SET=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_sot_set_tab  WHERE cod_sot_set=?");
           ps.setLong (1, COD_SOT_SET);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NOM_SOT_SET=rs.getString("NOM_SOT_SET");
  			   this.DES_SOT_SET=rs.getString("DES_SOT_SET");
           }else{
              throw new NoSuchEntityException("Sottosettori con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_sot_set_tab  WHERE cod_sot_set=?");
          ps.setLong (1, COD_SOT_SET);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Sottosettori con ID= non è trovata");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_sot_set_tab  SET nom_sot_set=?, des_sot_set=? WHERE cod_sot_set=?");
          ps.setString(1, NOM_SOT_SET);
          ps.setString(2, DES_SOT_SET);
		      ps.setLong  (3, COD_SOT_SET);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Sottosettori con ID= non è trovata");
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
  	public void setNOM_SOT_SET(String newNOM_SOT_SET){
      if( NOM_SOT_SET.equals(newNOM_SOT_SET) ) return;
      NOM_SOT_SET = newNOM_SOT_SET;
      setModified();
    }
    public String getNOM_SOT_SET(){
      return NOM_SOT_SET;
    }
	//2
    public long getCOD_SOT_SET(){
      return COD_SOT_SET;
    }
	//============================================
	// not required field
	//3
  	public void setDES_SOT_SET(String newDES_SOT_SET){
      if(DES_SOT_SET!=null){
	  	if( DES_SOT_SET.equals(newDES_SOT_SET) ) return;
	  }
	  DES_SOT_SET = newDES_SOT_SET;
	  setModified();
    }
    public String getDES_SOT_SET(){
      if(DES_SOT_SET==null){return "";}
			return DES_SOT_SET;
    }

   //</comment>

  public Collection ejbGetSottosettori_View(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sot_set, nom_sot_set, des_sot_set FROM ana_sot_set_tab ORDER BY nom_sot_set ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Sottosettori_View obj=new Sottosettori_View();
            obj.COD_SOT_SET=rs.getLong(1);
            obj.NOM_SOT_SET=rs.getString(2);
            obj.DES_SOT_SET=rs.getString(3);
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
  
  public  Collection findEx(String NOM_SOT_SET, int iOrderBy){
  		return  ejbFindEx(NOM_SOT_SET, iOrderBy);
  }
  
  public Collection ejbFindEx(String NOM_SOT_SET, int iOrderBy){
	SearchHelper hlp= new SearchHelper("SELECT cod_sot_set, nom_sot_set, des_sot_set FROM ana_sot_set_tab ");
	if(NOM_SOT_SET!=null) hlp.m_strSql.append(" WHERE UPPER(NOM_SOT_SET) LIKE ? ");
	hlp.orderBy(iOrderBy);
	  BMPConnection bmp=getConnection();
	  try{
	          PreparedStatement ps=bmp.prepareStatement(hlp.toString());
			  hlp.startBind(ps, 1);
			  {
			  	hlp.bind(NOM_SOT_SET != null?NOM_SOT_SET.toUpperCase():NOM_SOT_SET);
			  }
			  ResultSet rs=ps.executeQuery();
	          java.util.ArrayList al=new java.util.ArrayList();
	          while(rs.next()){
	            Sottosettori_View obj=new Sottosettori_View();
	            obj.COD_SOT_SET=rs.getLong(1);
	            obj.NOM_SOT_SET=rs.getString(2);
	            obj.DES_SOT_SET=rs.getString(3);
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
}//<comment description="end of implementation  SottosettoriBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////
PseudoContext.bind("SottosettoriBean", new SottosettoriBean());
////////////////////////////////////////// </BINDING> ///////// 
%>
