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

<%!//[1]
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class CategoriaDocumentoBean extends BMPEntityBean implements ICategoriaDocumento, ICategoriaDocumentoHome{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long COD_CAG_DOC;     //1
  String NOM_CAG_DOC; 	//2
  //-----------------------
  String DES_CAG_DOC;   //3
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
 private CategoriaDocumentoBean()
  {
	//System.err.println("CategoriaDocumentoBean constructor<br>");
  }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ICategoriaDocumento create(String strNOM_CAG_DOC) throws CreateException
  {
 	 CategoriaDocumentoBean bean =  new  CategoriaDocumentoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_CAG_DOC);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_CAG_DOC);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	CategoriaDocumentoBean iCategoriaDocumentoBean=new  CategoriaDocumentoBean();
    try{
    	Object obj=iCategoriaDocumentoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iCategoriaDocumentoBean.setEntityContext(new EntityContextWrapper(obj));
        iCategoriaDocumentoBean.ejbActivate();
        iCategoriaDocumentoBean.ejbLoad();
        iCategoriaDocumentoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ICategoriaDocumento findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	CategoriaDocumentoBean bean =  new  CategoriaDocumentoBean();
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

 public Collection getComboView(){
 	return (new  CategoriaDocumentoBean()).ejbGetComboView();
 }

  // (Home Intrface) VIEWS  getCategoriaDocumento_Name_Description_View()
  public Collection getCategoriaDocumento_Name_Description_View()
  {
  	return (new  CategoriaDocumentoBean()).ejbCategoriaDocumento_Name_Description_View();
  }


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IAziendaHome-implementation>
  public Long ejbCreate(String strNOM_CAG_DOC)
  {
    this.NOM_CAG_DOC=strNOM_CAG_DOC;
  //  this.DES_CAG_DOC=strDES_CAG_DOC;
    this.COD_CAG_DOC=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO cag_doc_tab (cod_cag_doc,nom_cag_doc) VALUES(?,?)");
         ps.setLong   (1, COD_CAG_DOC);
         ps.setString (2, NOM_CAG_DOC);
        // ps.setString (3, DES_CAG_DOC);
         ps.executeUpdate();
         return new Long(COD_CAG_DOC);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_CAG_DOC) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cag_doc FROM cag_doc_tab ");
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
    this.COD_CAG_DOC=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_CAG_DOC=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM cag_doc_tab  WHERE cod_cag_doc=?");
           ps.setLong (1, COD_CAG_DOC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
					      this.COD_CAG_DOC=rs.getLong("COD_CAG_DOC");
               	this.NOM_CAG_DOC=rs.getString("NOM_CAG_DOC");
  			   	    this.DES_CAG_DOC=rs.getString("DES_CAG_DOC");
           }
           else{
              throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM cag_doc_tab  WHERE cod_cag_doc=?");
          ps.setLong (1, COD_CAG_DOC);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE cag_doc_tab  SET cod_cag_doc=?, nom_cag_doc=?, des_cag_doc=? WHERE cod_cag_doc=?");
          ps.setLong(1,COD_CAG_DOC);
					ps.setString(2, NOM_CAG_DOC);
          if("".equals(DES_CAG_DOC)){ps.setNull (3,java.sql.Types.BIGINT);}else{ps.setString(3, DES_CAG_DOC);}
					ps.setLong(4,COD_CAG_DOC);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

 	public Collection ejbGetComboView(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT  cod_cag_doc, nom_cag_doc FROM cag_doc_tab ORDER BY nom_cag_doc");
           ResultSet rs=ps.executeQuery();
		   java.util.ArrayList al=new java.util.ArrayList();
           while(rs.next()){
		   		CategoriaDocumento_ComboView w= new CategoriaDocumento_ComboView();
				w.lCOD_CAT_DOC=rs.getLong("COD_CAG_DOC");
               	w.strNOM_CAT_DOC=rs.getString("NOM_CAG_DOC");
				al.add(w);
           }
		   return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 	}

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">
	//1
  	 public void setNOM_CAG_DOC(String newNOM_CAG_DOC){
      if( NOM_CAG_DOC.equals(newNOM_CAG_DOC) ) return;
      NOM_CAG_DOC = newNOM_CAG_DOC;
      setModified();
    }
    public String getNOM_CAG_DOC(){
      return NOM_CAG_DOC;
    }

		public long getCOD_CAG_DOC(){
      return COD_CAG_DOC;
    }
	//2
	  public void setDES_CAG_DOC(String newDES_CAG_DOC){
      if(DES_CAG_DOC!=null) {
			 if( DES_CAG_DOC.equals(newDES_CAG_DOC) ) return;
	    }
	    DES_CAG_DOC = newDES_CAG_DOC;
	    setModified();
    }
    public String getDES_CAG_DOC(){
		  if (DES_CAG_DOC==null) return "";
      return DES_CAG_DOC;
    }
   //</comment>

   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbCategoriaDocumento_Name_Description_View(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cag_doc,nom_cag_doc,des_cag_doc FROM cag_doc_tab ORDER BY nom_cag_doc ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            CategoriaDocumento_Name_Description_View obj=new CategoriaDocumento_Name_Description_View();
            obj.lCOD_CAG_DOC=rs.getLong(1);
            obj.strNOM_CAG_DOC=rs.getString(2);
            obj.strDES_CAG_DOC=rs.getString(3);
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

  //<search>
  	public Collection findEx(String NOM_CAG_DOC, String DES_CAG_DOC, int iOrderBy){
		return ejbFindEx(NOM_CAG_DOC, DES_CAG_DOC, iOrderBy);
	}
	
  	public Collection ejbFindEx(String NOM_CAG_DOC, String DES_CAG_DOC, int iOrderBy){
		 String strSql=" SELECT  cod_cag_doc, nom_cag_doc, des_cag_doc  FROM cag_doc_tab  ";
		 if (NOM_CAG_DOC!=null){
		 	strSql+=" WHERE UPPER(NOM_CAG_DOC) LIKE ?";
		 }
		 if (DES_CAG_DOC!=null){
		 	if(NOM_CAG_DOC!=null) strSql+=" AND "; else strSql+=" WHERE ";
		 	strSql+=" UPPER(DES_CAG_DOC) LIKE ?";
		 }
		 
		 strSql+=" ORDER BY "+Math.abs(iOrderBy) + (iOrderBy>0?" ASC": "DESC");
		 int i=1;
		     BMPConnection bmp=getConnection();
		     try{
		        PreparedStatement ps=bmp.prepareStatement(strSql);
			 
			 if (NOM_CAG_DOC!=null){
			 	ps.setString(i++, NOM_CAG_DOC.toUpperCase());
			 }
			 if (DES_CAG_DOC!=null){
			 	ps.setString(i++, DES_CAG_DOC.toUpperCase());
			 }
		          ResultSet rs=ps.executeQuery();
			   java.util.ArrayList al=new java.util.ArrayList();
		         while(rs.next()){
		           CategoriaDocumento_Name_Description_View obj=new CategoriaDocumento_Name_Description_View();
		           obj.lCOD_CAG_DOC=rs.getLong(1);
		           obj.strNOM_CAG_DOC=rs.getString(2);
		           obj.strDES_CAG_DOC=rs.getString(3);
		           al.add(obj);
		         }
                           return al;
		     }
		     catch(Exception ex){
		         throw new EJBException(ex);
		     }
                     finally {
                         bmp.close();
                     }
	}
  //</search>
  //-------------------
  //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  CategoriaDocumentoBean"/>
%>
<%
////////////////////////////////////////// <BINDING> //////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>//
PseudoContext.bind("CategoriaDocumentoBean", new CategoriaDocumentoBean());
////////////////////////////////////////// </BINDING> ///////////////////// 
%>
