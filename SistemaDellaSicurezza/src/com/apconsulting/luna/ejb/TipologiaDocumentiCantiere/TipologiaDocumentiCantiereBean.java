/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.apconsulting.luna.ejb.TipologiaDocumentiCantiere;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Alessandro
 */
public class TipologiaDocumentiCantiereBean extends BMPEntityBean implements ITipologiaDocumentiCantiere,  ITipologiaDocumentiCantiereHome{
  //----------------------------
  long COD_TPL_DOC;          //1
  String NOM_TPL_DOC;        //2
  //----------------------------
  String DES_TPL_DOC;        //3
  String COL_SOP;        //4
  String ALL_STA_SOP;        //5
  String TPL_ACQ_POS;        //6


private static TipologiaDocumentiCantiereBean ys = null;

    private TipologiaDocumentiCantiereBean() {
    }

    public static TipologiaDocumentiCantiereBean getInstance() {
        if (ys == null) {
            ys = new TipologiaDocumentiCantiereBean();
        }
        return ys;
    }
  // (Home Interface) create()
  public ITipologiaDocumentiCantiere create(String strNOM_TPL_DOC) throws CreateException
  {
  	 TipologiaDocumentiCantiereBean bean =  new  TipologiaDocumentiCantiereBean();
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
  	TipologiaDocumentiCantiereBean iTipologiaDocumentiBean=new  TipologiaDocumentiCantiereBean();
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
  public ITipologiaDocumentiCantiere findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TipologiaDocumentiCantiereBean bean =  new  TipologiaDocumentiCantiereBean();
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
		return (new  TipologiaDocumentiCantiereBean()).ejbGetComboView();
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
	   "INSERT INTO tpl_doc_can_tab (cod_tpl_doc,nom_tpl_doc) VALUES(?,?)");
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
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_doc FROM tpl_doc_can_tab ");
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
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_doc_can_tab  WHERE cod_tpl_doc=?");
           ps.setLong (1, COD_TPL_DOC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           	this.NOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
  			    this.DES_TPL_DOC=rs.getString("DES_TPL_DOC");
  			    this.COL_SOP=rs.getString("COL_SOP");
  			    this.ALL_STA_SOP=rs.getString("ALL_STA_SOP");
  			    this.TPL_ACQ_POS=rs.getString("TPL_ACQ_POS");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_doc_can_tab  WHERE cod_tpl_doc=?");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_doc_can_tab  SET cod_tpl_doc=?, nom_tpl_doc=?, des_tpl_doc=?, col_sop=?, all_sta_sop=?, tpl_acq_pos=? WHERE cod_tpl_doc=?");
         ps.setLong(1, COD_TPL_DOC);
         ps.setString(2, NOM_TPL_DOC);
         ps.setString(3, DES_TPL_DOC);
         ps.setString(4, COL_SOP);
         ps.setString(5, ALL_STA_SOP);
         ps.setString(6, TPL_ACQ_POS);
         ps.setLong(7, COD_TPL_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologiaDocumenti con ID= non è trovata");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//-------------------------------------------------------------
 public Collection ejbGetComboView(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_doc, nom_tpl_doc, des_tpl_doc, col_sop, all_sta_sop, tpl_acq_pos FROM tpl_doc_can_tab ORDER BY nom_tpl_doc");
           ResultSet rs=ps.executeQuery();
		   java.util.ArrayList ar=new java.util.ArrayList();
           while(rs.next()){
		   		TipologiaDocumenti_ComboView w= new TipologiaDocumenti_ComboView();
		  	  	w.lCOD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           		        w.strNOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
				w.strDES_TPL_DOC=rs.getString("DES_TPL_DOC");
				w.strCOL_SOP=rs.getString("COL_SOP");
				w.strALL_STA_SOP=rs.getString("ALL_STA_SOP");
				w.strTPL_ACQ_POS=rs.getString("TPL_ACQ_POS");
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
  	public Collection findEx(String NOM_TPL_DOC, String DES_TPL_DOC, String COL_SOP,String ALL_STA_SOP,String TPL_ACQ_POS,int iOrderBy){
		return ejbFindEx(NOM_TPL_DOC, DES_TPL_DOC,COL_SOP,ALL_STA_SOP, TPL_ACQ_POS, iOrderBy);
	}

	public Collection ejbFindEx(String NOM_TPL_DOC, String DES_TPL_DOC, String COL_SOP,String ALL_STA_SOP,String TPL_ACQ_POS,int iOrderBy){
	 String strSql="SELECT cod_tpl_doc, nom_tpl_doc, des_tpl_doc, col_sop, all_sta_sop, tpl_acq_pos  FROM tpl_doc_can_tab ";
	 if (NOM_TPL_DOC!=null){
	 	strSql+=" WHERE UPPER(NOM_TPL_DOC) LIKE ?";
	 }
	 if (DES_TPL_DOC!=null){
	 	if(NOM_TPL_DOC!=null) strSql+=" AND "; else strSql+=" WHERE ";
	 	strSql+=" UPPER(DES_TPL_DOC) LIKE ?";
	 }
	 if (COL_SOP!=null){
	 	if(DES_TPL_DOC!=null) strSql+=" AND "; else strSql+=" WHERE ";
	 	strSql+=" UPPER(COL_SOP) LIKE ?";
	 }
	 if (ALL_STA_SOP!=null){
	 	if(COL_SOP!=null) strSql+=" AND "; else strSql+=" WHERE ";
	 	strSql+=" UPPER(ALL_STA_SOP) LIKE ?";
	 }
	 if (TPL_ACQ_POS!=null){
	 	if(ALL_STA_SOP!=null) strSql+=" AND "; else strSql+=" WHERE ";
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
		 if (COL_SOP!=null){
		 	ps.setString(i++, COL_SOP.toUpperCase());
		 }
		 if (ALL_STA_SOP!=null){
		 	ps.setString(i++, ALL_STA_SOP.toUpperCase());
		 }
		 if (TPL_ACQ_POS!=null){
		 	ps.setString(i++, TPL_ACQ_POS.toUpperCase());
		 }

           ResultSet rs=ps.executeQuery();
		   java.util.ArrayList ar=new java.util.ArrayList();
           while(rs.next()){
		   		TipologiaDocumenti_ComboView w= new TipologiaDocumenti_ComboView();
		  	  	w.lCOD_TPL_DOC=rs.getLong("COD_TPL_DOC");
           		        w.strNOM_TPL_DOC=rs.getString("NOM_TPL_DOC");
				w.strDES_TPL_DOC=rs.getString("DES_TPL_DOC");
				w.strCOL_SOP=rs.getString("COL_SOP");
				w.strALL_STA_SOP=rs.getString("ALL_STA_SOP");
				w.strTPL_ACQ_POS=rs.getString("TPL_ACQ_POS");
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
  	//4
  	public void setCOL_SOP(String newCOL_SOP){
      if(COL_SOP!=null) {
			 if(COL_SOP.equals(newCOL_SOP) ) return;
	    }
	    COL_SOP = newCOL_SOP;
	    setModified();
    }
    public String getCOL_SOP(){
		  if(COL_SOP==null)return "";
      return COL_SOP;
    }
  	//5
  	public void setALL_STA_SOP(String newALL_STA_SOP){
      if(ALL_STA_SOP!=null) {
			 if( ALL_STA_SOP.equals(newALL_STA_SOP) ) return;
	    }
	    ALL_STA_SOP = newALL_STA_SOP;
	    setModified();
    }
    public String getALL_STA_SOP(){
		  if(ALL_STA_SOP==null)return "";
      return ALL_STA_SOP;
    }
  	//6
  	public void setTPL_ACQ_POS(String newTPL_ACQ_POS){
      if(TPL_ACQ_POS!=null) {
			 if( TPL_ACQ_POS.equals(newTPL_ACQ_POS) ) return;
	    }
	    TPL_ACQ_POS = newTPL_ACQ_POS;
	    setModified();
    }
    public String getTPL_ACQ_POS(){
		  if(TPL_ACQ_POS==null)return "";
      return TPL_ACQ_POS;
    }
   //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologiaDocumentiBean"/>


