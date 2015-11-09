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
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Bean dla tablici TPL_INO</description>
				 </comment>		
				 <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Add view findEx for Search</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

//public class TipologieAccertamentiBean extends BMPEntityBean implements ITipologieAccertamentiRemote
public class TipologieAccertamentiBean extends BMPEntityBean implements ITipologieAccertamenti, ITipologieAccertamentiHome
{
	//<comment description="Member Variables">
  	long COD_TPL_INO;
	String NOM_TPL_INO;
	//</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 	private TipologieAccertamentiBean(){}
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ITipologieAccertamenti create(String strNOM_TPL_INO) throws RemoteException, CreateException
  {
 	 TipologieAccertamentiBean bean =  new  TipologieAccertamentiBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_TPL_INO);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_TPL_INO);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }

 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	TipologieAccertamentiBean iTipologieAccertamentiBean=new  TipologieAccertamentiBean();
    try{
    	Object obj=iTipologieAccertamentiBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologieAccertamentiBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologieAccertamentiBean.ejbActivate();
        iTipologieAccertamentiBean.ejbLoad();
        iTipologieAccertamentiBean.ejbRemove();
    }catch(Exception ex){
          throw new EJBException(ex);
    }
  }

  // (Home Intrface) findByPrimaryKey()
  public ITipologieAccertamenti findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException
  {
   	TipologieAccertamentiBean bean =  new  TipologieAccertamentiBean();
	try{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws RemoteException, FinderException
  {
  	try{
   		return this.ejbFindAll();
	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 

  // (Home Intrface) VIEWS  getTipologieAccertamenti_UserID_View()
  public Collection getTipologieAccertamenti_UserID_View()
  {
  	return (new  TipologieAccertamentiBean()).ejbGetTipologieAccertamenti_UserID_View();
  }

  public Collection findEx(String NOM, long iOrderBy)
  {
  	return (new  TipologieAccertamentiBean()).ejbfindEx(NOM, iOrderBy);
  }
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologieAccertamentiHome-implementation>
  public Long ejbCreate(String strNOM_TPL_INO)
  {
    this.NOM_TPL_INO=strNOM_TPL_INO;
    this.COD_TPL_INO=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement(
	   "INSERT INTO tpl_ino_tab (cod_tpl_ino,nom_tpl_ino) VALUES(?,?)");
         ps.setLong   (1, COD_TPL_INO);
         ps.setString (2, NOM_TPL_INO);
         ps.executeUpdate();
         return new Long(COD_TPL_INO);
    }catch(Exception ex){
        throw new EJBException(ex);
    }finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_TPL_INO) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
		  "SELECT cod_tpl_ino, nom_tpl_ino FROM tpl_ino_tab ");
 		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
						al.add(new String(rs.getString(2)));
          }
          return al;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }

//-----------------------------------------------------------
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------
  public void ejbActivate(){
    this.COD_TPL_INO=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_TPL_INO=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "SELECT * FROM tpl_ino_tab  WHERE cod_tpl_ino=?");
           ps.setLong (1, COD_TPL_INO);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
						this.NOM_TPL_INO=rs.getString("NOM_TPL_INO");
          }
           else{
              throw new NoSuchEntityException("TipologieAccertamenti con ID="+COD_TPL_INO+" non è trovato");
           }
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//----------------------------------------------------------
  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "DELETE FROM tpl_ino_tab  WHERE cod_tpl_ino=?");
         ps.setLong (1, COD_TPL_INO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieAccertamenti con ID="+COD_TPL_INO+" non è trovato");
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
         PreparedStatement ps=bmp.prepareStatement(
		 "UPDATE tpl_ino_tab  SET nom_tpl_ino=? WHERE cod_tpl_ino=?");
          ps.setString 	(1, NOM_TPL_INO);
		  ps.setLong   	(2, COD_TPL_INO);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieAccertamenti con ID="+COD_TPL_INO+" non è trovato");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!////////////////////////////
//<comment description="Zdes opredeliayutsia metody remote interfeisa"/>

//<comment description="setter/getters">  
	//----1
	public long getCOD_TPL_INO(){
      return COD_TPL_INO;
    }
	//----2
    public void setNOM_TPL_INO(String newNOM_TPL_INO){
      if(NOM_TPL_INO.equals(newNOM_TPL_INO)) return;
      NOM_TPL_INO = newNOM_TPL_INO;
      setModified();
    }
    public String getNOM_TPL_INO(){
      return NOM_TPL_INO;
    }
	//-------------------
   //</comment>
///**********************************************************
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
  
   //<comment description="extended setters/getters">
   public Collection ejbGetTipologieAccertamenti_UserID_View(){
       BMPConnection bmp=getConnection();
       try{
         PreparedStatement ps=bmp.prepareStatement("SELECT  cod_tpl_ino,nom_tpl_ino FROM tpl_ino_tab ORDER BY nom_tpl_ino");
         ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TipologieAccertamenti_UserID_View obj=new TipologieAccertamenti_UserID_View();
            obj.COD_TPL_INO=rs.getLong(1);
            obj.NOM_TPL_INO=rs.getString(2);
            al.add(obj);
          }
          bmp.close();
          return al;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
  
  public Collection ejbfindEx(String NOM, long iOrderBy){
       String Sql="SELECT  cod_tpl_ino,nom_tpl_ino FROM tpl_ino_tab ";
			 if (NOM!=null)
			 {
			   Sql+=" WHERE UPPER(nom_tpl_ino) LIKE ? ";
			 }
			 Sql+=" ORDER BY nom_tpl_ino";
			 BMPConnection bmp=getConnection();
       try{
            PreparedStatement ps=bmp.prepareStatement(Sql);
                if(NOM!=null){ps.setString(1, NOM.toUpperCase()+"%");}
            ResultSet rs=ps.executeQuery();
            java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TipologieAccertamenti_UserID_View obj=new TipologieAccertamenti_UserID_View();
            obj.COD_TPL_INO=rs.getLong(1);
            obj.NOM_TPL_INO=rs.getString(2);
            al.add(obj);
          }
          bmp.close();
          return al;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
  //----------
  //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologieAccertamentiBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////////////
PseudoContext.bind("TipologieAccertamentiBean", new TipologieAccertamentiBean());
////////////////////////////////////////// </BINDING> /////////////////////////// 
%>
