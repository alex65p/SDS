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
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

//public class StruttAnagraficaImmobiliBean extends BMPEntityBean implements IStruttAnagraficaImmobiliRemote
class StruttAnagraficaImmobiliBean extends IStruttAnagraficaImmobiliHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  String RAG_SCL_DIT_PRC;
  String DES_ATI_SVO_DIT_PRC;
  long COD_DPD;
  long COD_AZL;
  long COD_DIT_PRC_DPD;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private StruttAnagraficaImmobiliBean(){}

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IStruttAnagraficaImmobili create(String strRAG_SCL_DIT_PRC,String strDES_ATI_SVO_DIT_PRC,long lCOD_DPD,long lCOD_AZL) throws CreateException
  {
 	 StruttAnagraficaImmobiliBean bean =  new  StruttAnagraficaImmobiliBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strRAG_SCL_DIT_PRC,strDES_ATI_SVO_DIT_PRC,lCOD_DPD,lCOD_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strRAG_SCL_DIT_PRC,strDES_ATI_SVO_DIT_PRC,lCOD_DPD,lCOD_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey) throws FinderException
  {
  	StruttAnagraficaImmobiliBean iStruttAnagraficaImmobiliBean=new  StruttAnagraficaImmobiliBean();
    try
	{
    	Object obj=iStruttAnagraficaImmobiliBean.ejbFindByPrimaryKey((Long)primaryKey);
        iStruttAnagraficaImmobiliBean.setEntityContext(new EntityContextWrapper(obj));
        iStruttAnagraficaImmobiliBean.ejbActivate();
        iStruttAnagraficaImmobiliBean.ejbLoad();
        iStruttAnagraficaImmobiliBean.ejbRemove();
    }
    catch(Exception ex){
          throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IStruttAnagraficaImmobili findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	StruttAnagraficaImmobiliBean bean =  new  StruttAnagraficaImmobiliBean();
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
  	try{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS  getStruttAnagraficaImmobili_Tipology_Number_View()
  public Collection getStruttAnagraficaImmobili_Tipology_Number_View()
  {
  	return (new  StruttAnagraficaImmobiliBean()).ejbGetStruttAnagraficaImmobili_Tipology_Number_View();
 }
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IStruttAnagraficaImmobiliHome-implementation>
  public Long ejbCreate(String strRAG_SCL_DIT_PRC,String strDES_ATI_SVO_DIT_PRC,long lCOD_DPD,long lCOD_AZL)
  {
    this.RAG_SCL_DIT_PRC=strRAG_SCL_DIT_PRC;
    this.DES_ATI_SVO_DIT_PRC=strDES_ATI_SVO_DIT_PRC;
    this.COD_DPD=lCOD_DPD;
		this.COD_AZL=lCOD_AZL;
    this.COD_DIT_PRC_DPD=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO dit_prc_dpd_tab (cod_dit_prc_dpd,rag_scl_dit_prc, des_ati_svo_dit_prc, cod_dpd, cod_azl) VALUES(?,?,?,?,?)");
         ps.setLong   (1, COD_DIT_PRC_DPD);
         ps.setString (2, RAG_SCL_DIT_PRC);
         ps.setString (3, DES_ATI_SVO_DIT_PRC);
         ps.setLong (4, COD_DPD);
         ps.setLong (5, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_DIT_PRC_DPD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strRAG_SCL_DIT_PRC,String strDES_ATI_SVO_DIT_PRC,long lCOD_DPD,long lCOD_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dit_prc_dpd FROM dit_prc_dpd_tab ");
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
    this.COD_DIT_PRC_DPD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_DIT_PRC_DPD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM dit_prc_dpd_tab  WHERE cod_dit_prc_dpd=?");
           ps.setLong (1, COD_DIT_PRC_DPD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            this.RAG_SCL_DIT_PRC=rs.getString("RAG_SCL_DIT_PRC");
  			   	this.DES_ATI_SVO_DIT_PRC=rs.getString("DES_ATI_SVO_DIT_PRC");
    		 		this.COD_DPD=rs.getLong("COD_DPD");
	  				this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("StruttAnagraficaImmobili con ID="+COD_DIT_PRC_DPD+" non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM dit_prc_dpd_tab  WHERE cod_dit_prc_dpd=?");
          ps.setLong (1, COD_DIT_PRC_DPD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("StruttAnagraficaImmobili con ID="+COD_DIT_PRC_DPD+" non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE dit_prc_dpd_tab  SET rag_scl_dit_prc=?, des_ati_svo_dit_prc=?, cod_dpd=?,cod_azl=? WHERE cod_dit_prc_dpd=?");
          ps.setString(1, RAG_SCL_DIT_PRC);
          ps.setString(2, DES_ATI_SVO_DIT_PRC);
          ps.setLong  (3, COD_DPD);
          ps.setLong  (4, COD_AZL);	
		  		ps.setLong  (5, COD_DIT_PRC_DPD);

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("StruttAnagraficaImmobili con ID="+COD_DIT_PRC_DPD+" non &egrave trovata");
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
  	 public void setRAG_SCL_DIT_PRC(String newRAG_SCL_DIT_PRC){
      if( RAG_SCL_DIT_PRC.equals(newRAG_SCL_DIT_PRC) ) return;
      RAG_SCL_DIT_PRC = newRAG_SCL_DIT_PRC;
      setModified();
    }
    public String getRAG_SCL_DIT_PRC(){
      return RAG_SCL_DIT_PRC;
    }
	//2
	  public void setDES_ATI_SVO_DIT_PRC(String newDES_ATI_SVO_DIT_PRC){
      if( DES_ATI_SVO_DIT_PRC.equals(newDES_ATI_SVO_DIT_PRC) ) return;
      DES_ATI_SVO_DIT_PRC = newDES_ATI_SVO_DIT_PRC;
      setModified();
    }
    public String getDES_ATI_SVO_DIT_PRC(){
      return DES_ATI_SVO_DIT_PRC;
    }
	//3
    public void setCOD_DPD(long newCOD_DPD){
      if( COD_DPD == newCOD_DPD ) return;
      COD_DPD = newCOD_DPD;
	  	setModified();
    }
    public long getCOD_DPD(){
      return COD_DPD;
    }
	//4
	  public void setCOD_AZL(long newCOD_AZL){
      if( COD_AZL == newCOD_AZL ) return;
      COD_AZL = newCOD_AZL;
      setModified();
    }
    public long getCOD_AZL(){
      return COD_AZL;
    }
	//6
	public long getCOD_DIT_PRC_DPD(){
      return COD_DIT_PRC_DPD;
    }
	
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetStruttAnagraficaImmobili_Tipology_Number_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dit_prc_dpd,rag_scl_dit_prc,des_ati_svo_dit_prc,cod_dpd,cod_azl FROM dit_prc_dpd_tab ");

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            StruttAnagraficaImmobili_Tipology_Number_View obj=new StruttAnagraficaImmobili_Tipology_Number_View();
            obj.COD_DIT_PRC_DPD=rs.getLong(1);
            obj.RAG_SCL_DIT_PRC=rs.getString(2);
            obj.DES_ATI_SVO_DIT_PRC=rs.getString(3);
            obj.COD_DPD=rs.getLong(4);
            obj.COD_AZL=rs.getLong(5);
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

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  StruttAnagraficaImmobiliBean"/>

////////////////////////////////////////// <BINDING> //////////////////////////////////
PseudoContext.bind("StruttAnagraficaImmobiliBean", new StruttAnagraficaImmobiliBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////
%>
