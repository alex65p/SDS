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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
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
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

//public class TipologiaCorsiBean extends BMPEntityBean implements ITipologiaCorsiRemote
public class TipologiaCorsiBean extends BMPEntityBean  implements ITipologiaCorsi,ITipologiaCorsiHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  String NOM_TPL_COR;     //1
  long COD_TPL_COR;       //2
  //-------------------------
  String DES_TPL_COR;     //3
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private TipologiaCorsiBean(){}
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ITipologiaCorsi create(String strNOM_TPL_COR) throws CreateException
  {
 	 TipologiaCorsiBean bean =  new  TipologiaCorsiBean();
	 try{
	 	Object primaryKey=bean.ejbCreate(strNOM_TPL_COR);
	 	bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 	bean.ejbPostCreate(strNOM_TPL_COR);
     	return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	TipologiaCorsiBean iTipologiaCorsiBean=new  TipologiaCorsiBean();
    try{
    	Object obj=iTipologiaCorsiBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologiaCorsiBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologiaCorsiBean.ejbActivate();
        iTipologiaCorsiBean.ejbLoad();
        iTipologiaCorsiBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex); 
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ITipologiaCorsi findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologiaCorsiBean bean =  new  TipologiaCorsiBean();
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
	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }

  // (Home Intrface) VIEWS  getTipologiaCorsi_Name_Address_View()
  public Collection getTipologiaCorsi_Name_Address_View()
  {
  	return (new  TipologiaCorsiBean()).ejbGetTipologiaCorsi_Name_Address_View();
 }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologiaCorsiHome-implementation>
  public Long ejbCreate(String strNOM_TPL_COR)
  {
    this.NOM_TPL_COR=strNOM_TPL_COR;
    this.COD_TPL_COR=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO tpl_cor_tab (cod_tpl_cor,nom_tpl_cor) VALUES(?,?)");
         ps.setLong   (1, COD_TPL_COR);
         ps.setString (2, NOM_TPL_COR);
         ps.executeUpdate();
         return new Long(COD_TPL_COR);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_TPL_COR) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_cor FROM tpl_cor_tab ");
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
    this.COD_TPL_COR=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_TPL_COR=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_cor_tab  WHERE cod_tpl_cor=?");
           ps.setLong (1, COD_TPL_COR);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.NOM_TPL_COR=rs.getString("NOM_TPL_COR");
  			   			this.DES_TPL_COR=rs.getString("DES_TPL_COR");
           }
           else{
              throw new NoSuchEntityException("TipologiaCorsi con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_cor_tab  WHERE cod_tpl_cor=?");
          ps.setLong (1, COD_TPL_COR);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologiaCorsi con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_cor_tab  SET nom_tpl_cor=?, des_tpl_cor=? WHERE cod_tpl_cor=?");
          ps.setString(1, NOM_TPL_COR);
          ps.setString(2, DES_TPL_COR);
					ps.setLong  (3, COD_TPL_COR);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologiaCorsi con ID= non è trovata");
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
  	 public void setNOM_TPL_COR(String newNOM_TPL_COR){
      if( NOM_TPL_COR.equals(newNOM_TPL_COR) ) return;
      NOM_TPL_COR = newNOM_TPL_COR;
      setModified();
    }
    public String getNOM_TPL_COR(){
      return NOM_TPL_COR;
    }
	//2
	public long getCOD_TPL_COR(){
      return COD_TPL_COR;
    }
	//============================================
	// not required field
	//3
	  public void setDES_TPL_COR(String newDES_TPL_COR){
      if(DES_TPL_COR!=null){
	      if( DES_TPL_COR.equals(newDES_TPL_COR) ) return;
      }
	  DES_TPL_COR = newDES_TPL_COR;
	  setModified();
    }
    public String getDES_TPL_COR(){
      return DES_TPL_COR;
    }
		
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetTipologiaCorsi_Name_Address_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_cor,nom_tpl_cor,des_tpl_cor FROM tpl_cor_tab ORDER BY nom_tpl_cor");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TipologiaCorsi_Name_Address_View obj=new TipologiaCorsi_Name_Address_View();
            obj.COD_TPL_COR=rs.getLong(1);
			obj.NOM_TPL_COR=rs.getString(2);
			obj.DES_TPL_COR=rs.getString(3);
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
// ============= by Juli==== SEARCH==

   public Collection findEx(String strNOM_TPL_COR, int iOrderParameter)
	{
		return ejbFindEx( strNOM_TPL_COR, iOrderParameter);
	}
 	public Collection ejbFindEx(String strNOM_TPL_COR, int iOrderBy )
	{
		String strSql=" SELECT cod_tpl_cor,	nom_tpl_cor,	des_tpl_cor FROM tpl_cor_tab WHERE ";
			if(strNOM_TPL_COR!=null){
				strSql+=" upper(nom_tpl_cor) LIKE ?  AND   ";
			}
			strSql=strSql.substring(1,strSql.length()- 6);
			strSql+=" ORDER BY cod_tpl_cor " + (iOrderBy>0?" ASC": "DESC");
			int i=1;
			BMPConnection bmp=getConnection();
		     try{
					PreparedStatement ps=bmp.prepareStatement(strSql);
					if(strNOM_TPL_COR!=null){
						ps.setString(i++, strNOM_TPL_COR.toUpperCase()+"%");
					}
				   //----------------------------------------------------------------------
				   ResultSet rs=ps.executeQuery();
	               java.util.ArrayList ar= new java.util.ArrayList();
	               while(rs.next()){
	                    TipologiaCorsi_Name_Address_View v=new TipologiaCorsi_Name_Address_View();
	                    v.COD_TPL_COR=rs.getLong(1);
	                    v.NOM_TPL_COR=rs.getString(2);
	                    v.DES_TPL_COR=rs.getString(3);
	                    ar.add(v);
	               }
				    return ar;
				   //----------------------------------------------------------------------
		  }
          catch(Exception ex){
              throw new EJBException(ex);
          }
		  finally{bmp.close();}
	}

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologiaCorsiBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////////
PseudoContext.bind("TipologiaCorsiBean", new TipologiaCorsiBean());
////////////////////////////////////////// </BINDING> /////////////
%>
