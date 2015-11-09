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

public class TipologieNomativeSentenzeBean extends BMPEntityBean implements ITipologieNomativeSentenze, ITipologieNomativeSentenzeHome
{
  long COD_TPL_NOR_SEN;              //1
  String NOM_TPL_NOR_SEN;            //2
  //----------------------------
  String DES_TPL_NOR_SEN;            //3
  //
  private TipologieNomativeSentenzeBean() {}
  //
  // (Home Interface) create()
  public ITipologieNomativeSentenze create(String strNOM_TPL_NOR_SEN) throws CreateException
  {
  	 TipologieNomativeSentenzeBean bean =  new  TipologieNomativeSentenzeBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strNOM_TPL_NOR_SEN);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_TPL_NOR_SEN);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	TipologieNomativeSentenzeBean iTipologieNomativeSentenzeBean=new  TipologieNomativeSentenzeBean();
    try	{
    	Object obj=iTipologieNomativeSentenzeBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologieNomativeSentenzeBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologieNomativeSentenzeBean.ejbActivate();
        iTipologieNomativeSentenzeBean.ejbLoad();
        iTipologieNomativeSentenzeBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public ITipologieNomativeSentenze findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologieNomativeSentenzeBean bean =  new  TipologieNomativeSentenzeBean();
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

    // (Home Intrface) VIEWS
  public Collection getTipologieNomativeSentenze_View()
  {
  	return (new TipologieNomativeSentenzeBean()).ejbGetTipologieNomativeSentenze_View();
  }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologieNomativeSentenzeHome-implementation>
  public Long ejbCreate(String strNOM_TPL_NOR_SEN){
    this.NOM_TPL_NOR_SEN=strNOM_TPL_NOR_SEN;
    this.COD_TPL_NOR_SEN=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO tpl_nor_sen_tab (cod_tpl_nor_sen,nom_tpl_nor_sen) VALUES(?,?)");
         ps.setLong   (1, COD_TPL_NOR_SEN);
         ps.setString (2, NOM_TPL_NOR_SEN);
         ps.executeUpdate();
         return new Long(COD_TPL_NOR_SEN);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_TPL_NOR_SEN) { }
//--------------------------------------------------

  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_nor_sen FROM tpl_nor_sen_tab ");
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
    this.COD_TPL_NOR_SEN=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_TPL_NOR_SEN=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "SELECT * FROM tpl_nor_sen_tab  WHERE cod_tpl_nor_sen=?");
           ps.setLong (1, COD_TPL_NOR_SEN);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	this.COD_TPL_NOR_SEN=rs.getLong("COD_TPL_NOR_SEN");
           	this.NOM_TPL_NOR_SEN=rs.getString("NOM_TPL_NOR_SEN");
  			this.DES_TPL_NOR_SEN=rs.getString("DES_TPL_NOR_SEN");
           }
           else{
              throw new NoSuchEntityException("TipologieNomativeSentenze con ID= " + COD_TPL_NOR_SEN + " non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_nor_sen_tab  WHERE cod_tpl_nor_sen=?");
         ps.setLong (1, COD_TPL_NOR_SEN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieNomativeSentenze con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_nor_sen_tab  SET cod_tpl_nor_sen=?, nom_tpl_nor_sen=?, des_tpl_nor_sen=?	 WHERE cod_tpl_nor_sen=?");
         ps.setLong(1, COD_TPL_NOR_SEN);
         ps.setString(2, NOM_TPL_NOR_SEN);
         ps.setString(3, DES_TPL_NOR_SEN);
         ps.setLong(4, COD_TPL_NOR_SEN);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieNomativeSentenze con ID= non è trovata");
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
    public long getCOD_TPL_NOR_SEN(){
      return COD_TPL_NOR_SEN;
    }
  	//2
	public void setNOM_TPL_NOR_SEN(String newNOM_TPL_NOR_SEN){
      if( NOM_TPL_NOR_SEN.equals(newNOM_TPL_NOR_SEN) ) return;
      NOM_TPL_NOR_SEN = newNOM_TPL_NOR_SEN;
      setModified();
    }
    public String getNOM_TPL_NOR_SEN(){
      return NOM_TPL_NOR_SEN;
    }
	//============================================
	// not required field
  	//3
  	public void setDES_TPL_NOR_SEN(String newDES_TPL_NOR_SEN){
      if(DES_TPL_NOR_SEN!=null) {
			 if( DES_TPL_NOR_SEN.equals(newDES_TPL_NOR_SEN) ) return;
	    }
	    DES_TPL_NOR_SEN = newDES_TPL_NOR_SEN;
	    setModified();
    }
    public String getDES_TPL_NOR_SEN(){
		  if(DES_TPL_NOR_SEN==null)return "";
      return DES_TPL_NOR_SEN;
    }
   //</comment>


   //<comment description="extended setters/getters">
   public Collection ejbGetTipologieNomativeSentenze_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_nor_sen, nom_tpl_nor_sen, des_tpl_nor_sen FROM tpl_nor_sen_tab ORDER BY nom_tpl_nor_sen ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TipologieNomativeSentenze_View obj=new TipologieNomativeSentenze_View();
            obj.COD_TPL_NOR_SEN=rs.getLong(1);
            obj.NOM_TPL_NOR_SEN=rs.getString(2);
            obj.DES_TPL_NOR_SEN=rs.getString(3);
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
  
  public  Collection findEx(String NOM_TPL_NOR_SEN, int iOrderBy){
  		return  ejbFindEx(NOM_TPL_NOR_SEN, iOrderBy);
  }
  
  public Collection ejbFindEx(String NOM_TPL_NOR_SEN, int iOrderBy){
	SearchHelper hlp= new SearchHelper("SELECT cod_tpl_nor_sen, nom_tpl_nor_sen, des_tpl_nor_sen FROM tpl_nor_sen_tab ");
	if(NOM_TPL_NOR_SEN!=null) hlp.m_strSql.append(" WHERE UPPER(NOM_TPL_NOR_SEN) LIKE ? ");
	hlp.orderBy(iOrderBy);
	  BMPConnection bmp=getConnection();
	  try{
	          PreparedStatement ps=bmp.prepareStatement(hlp.toString());
			  hlp.startBind(ps, 1);
			  {
			  	hlp.bind(NOM_TPL_NOR_SEN != null?NOM_TPL_NOR_SEN.toUpperCase():NOM_TPL_NOR_SEN);
			  }
			  ResultSet rs=ps.executeQuery();
	          java.util.ArrayList al=new java.util.ArrayList();
	          while(rs.next()){
		            TipologieNomativeSentenze_View obj=new TipologieNomativeSentenze_View();
		            obj.COD_TPL_NOR_SEN=rs.getLong(1);
		            obj.NOM_TPL_NOR_SEN=rs.getString(2);
		            obj.DES_TPL_NOR_SEN=rs.getString(3);
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
}//<comment description="end of implementation  TipologieNomativeSentenzeBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////////////////////
PseudoContext.bind("TipologieNomativeSentenzeBean", new TipologieNomativeSentenzeBean());
////////////////////////////////////////// </BINDING> ///////////////////////////////////
%>
