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

public class TipologiaDocumentiBean extends BMPEntityBean implements ITipologiaDocumenti,  ITipologiaDocumentiHome{
  //----------------------------
  long COD_TPL_DOC;          //1
  String NOM_TPL_DOC;        //2
  //----------------------------
  String DES_TPL_DOC;        //3

 private TipologiaDocumentiBean() {}

  // (Home Interface) create()
  public ITipologiaDocumenti create(String strNOM_TPL_DOC) throws CreateException
  {
  	 TipologiaDocumentiBean bean =  new  TipologiaDocumentiBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strNOM_TPL_DOC);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_TPL_DOC);
         return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	TipologiaDocumentiBean iTipologiaDocumentiBean=new  TipologiaDocumentiBean();
    try	{
    	Object obj=iTipologiaDocumentiBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologiaDocumentiBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologiaDocumentiBean.ejbActivate();
        iTipologiaDocumentiBean.ejbLoad();
        iTipologiaDocumentiBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public ITipologiaDocumenti findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologiaDocumentiBean bean =  new  TipologiaDocumentiBean();
  	try	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
  	}catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  
 //-----------------------------------------------------------

  public Collection getComboView(){
		return (new  TipologiaDocumentiBean()).ejbGetComboView();
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

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITipologiaDocumentiHome-implementation>
  public Long ejbCreate(String strNOM_TPL_DOC){
    this.NOM_TPL_DOC=strNOM_TPL_DOC;
    this.COD_TPL_DOC=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement(
	   "INSERT INTO tpl_doc_tab (cod_tpl_doc,nom_tpl_doc) VALUES(?,?)");
         ps.setLong   (1, COD_TPL_DOC);
         ps.setString (2, NOM_TPL_DOC);
         ps.executeUpdate();
         return new Long(COD_TPL_DOC);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }
//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_TPL_DOC) { }	
//--------------------------------------------------
  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_doc FROM tpl_doc_tab ");
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
    this.COD_TPL_DOC=((Long)this.getEntityKey()).longValue();
}
//----------------------------------------------------------
public void ejbPassivate(){
      this.COD_TPL_DOC=-1;
}
//----------------------------------------------------------
public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_doc_tab  WHERE cod_tpl_doc=?");
           ps.setLong (1, COD_TPL_DOC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           	this.NOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
  			    this.DES_TPL_DOC=rs.getString("DES_TPL_DOC");
           }
           else{
              throw new NoSuchEntityException("TipologiaDocumenti con ID= non è trovata");
           }
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//----------------------------------------------------------
public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_doc_tab  WHERE cod_tpl_doc=?");
         ps.setLong (1, COD_TPL_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologiaDocumenti con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_doc_tab  SET cod_tpl_doc=?, nom_tpl_doc=?, des_tpl_doc=?	 WHERE cod_tpl_doc=?");
         ps.setLong(1, COD_TPL_DOC);
         ps.setString(2, NOM_TPL_DOC);
         ps.setString(3, DES_TPL_DOC);
         ps.setLong(4, COD_TPL_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologiaDocumenti con ID= non è trovata");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//-------------------------------------------------------------
 public Collection ejbGetComboView(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_doc, nom_tpl_doc, des_tpl_doc FROM tpl_doc_tab ORDER BY nom_tpl_doc");
           ResultSet rs=ps.executeQuery();
		   java.util.ArrayList ar=new java.util.ArrayList();
           while(rs.next()){
		   		TipologiaDocumenti_ComboView w= new TipologiaDocumenti_ComboView();
		  	  	w.lCOD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           		w.strNOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
				w.strDES_TPL_DOC=rs.getString("DES_TPL_DOC");
				ar.add(w);
           }
		   return ar;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}		
 }
 	//<search>
  	public Collection findEx(String NOM_TPL_DOC, String DES_TPL_DOC, int iOrderBy){
		return ejbFindEx(NOM_TPL_DOC, DES_TPL_DOC, iOrderBy);
	}
	
	public Collection ejbFindEx(String NOM_TPL_DOC, String DES_TPL_DOC, int iOrderBy){
	 String strSql="SELECT cod_tpl_doc, nom_tpl_doc, des_tpl_doc FROM tpl_doc_tab ";
	 if (NOM_TPL_DOC!=null){
	 	strSql+=" WHERE UPPER(NOM_TPL_DOC) LIKE ?";
	 }
	 if (DES_TPL_DOC!=null){
	 	if(NOM_TPL_DOC!=null) strSql+=" AND "; else strSql+=" WHERE ";
	 	strSql+=" UPPER(DES_TPL_DOC) LIKE ?";
	 }
	 
	 strSql+=" ORDER BY "+Math.abs(iOrderBy) + (iOrderBy>0?" ASC": "DESC");
	 int i=1;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(strSql);
		 
		 if (NOM_TPL_DOC!=null){
		 	ps.setString(i++, NOM_TPL_DOC.toUpperCase());
		 }
		 if (DES_TPL_DOC!=null){
		 	ps.setString(i++, DES_TPL_DOC.toUpperCase());
		 }
		 
           ResultSet rs=ps.executeQuery();
		   java.util.ArrayList ar=new java.util.ArrayList();
           while(rs.next()){
		   		TipologiaDocumenti_ComboView w= new TipologiaDocumenti_ComboView();
		  	  	w.lCOD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           		w.strNOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
				w.strDES_TPL_DOC=rs.getString("DES_TPL_DOC");
				ar.add(w);
           }
		   return ar;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}		
	}
	//</search>
	
//-------------------------------------------------------------
/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
	public long getCOD_TPL_DOC(){
      return COD_TPL_DOC;
    }
  	//2
	public void setNOM_TPL_DOC(String newNOM_TPL_DOC){
      if( NOM_TPL_DOC.equals(newNOM_TPL_DOC) ) return;
      NOM_TPL_DOC = newNOM_TPL_DOC;
      setModified();
    }
    public String getNOM_TPL_DOC(){
      return NOM_TPL_DOC;
    }
	//============================================
	// not required field
  	//3
  	public void setDES_TPL_DOC(String newDES_TPL_DOC){
      if(DES_TPL_DOC!=null) {
			 if( DES_TPL_DOC.equals(newDES_TPL_DOC) ) return;
	    }
	    DES_TPL_DOC = newDES_TPL_DOC;
	    setModified();
    }
    public String getDES_TPL_DOC(){
		  if(DES_TPL_DOC==null)return "";
      return DES_TPL_DOC;
    }
   //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologiaDocumentiBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////////////////
PseudoContext.bind("TipologiaDocumentiBean", new TipologiaDocumentiBean());
////////////////////////////////////////// </BINDING> /////////////////////
%>
