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
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
          <comments>
                  <comment date="15/01/2004" author="Khomenko Juliya">
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

public class TipologieUnitaOrganizzativaBean extends BMPEntityBean implements ITipologieUnitaOrganizzativa, ITipologieUnitaOrganizzativaHome
//class TipologieUnitaOrganizzativaBean extends ITipologieUnitaOrganizzativaHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long   COD_TPL_UNI_ORG;	//1
  String NOM_TPL_UNI_ORG;   //2
  //------------------------
  String DES_TPL_UNI_ORG;   //3
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
  private TipologieUnitaOrganizzativaBean(){}
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public ITipologieUnitaOrganizzativa create(String strNOM_TPL_UNI_ORG) throws CreateException
  {
     TipologieUnitaOrganizzativaBean bean =  new  TipologieUnitaOrganizzativaBean();
     try{
	     Object primaryKey=bean.ejbCreate(strNOM_TPL_UNI_ORG);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_TPL_UNI_ORG);
	     return bean;
     }catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
     }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
    TipologieUnitaOrganizzativaBean iTipologieUnitaOrganizzativaBean=new  TipologieUnitaOrganizzativaBean();
    try{
        Object obj=iTipologieUnitaOrganizzativaBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTipologieUnitaOrganizzativaBean.setEntityContext(new EntityContextWrapper(obj));
        iTipologieUnitaOrganizzativaBean.ejbActivate();
        iTipologieUnitaOrganizzativaBean.ejbLoad();
        iTipologieUnitaOrganizzativaBean.ejbRemove();
    }catch(Exception ex){
       throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ITipologieUnitaOrganizzativa findByPrimaryKey(Long primaryKey) throws FinderException
  {
    TipologieUnitaOrganizzativaBean bean =  new  TipologieUnitaOrganizzativaBean();
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

  //</ITipologieUnitaOrganizzativaHome-implementation>
  public Long ejbCreate(String strNOM_TPL_UNI_ORG)
  {
    this.NOM_TPL_UNI_ORG=strNOM_TPL_UNI_ORG;
        this.COD_TPL_UNI_ORG=NEW_ID(); // unic ID
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement(
	   "INSERT INTO tpl_uni_org_tab (cod_tpl_uni_org,nom_tpl_uni_org) VALUES(?,?)");
       ps.setLong   (1, COD_TPL_UNI_ORG);
       ps.setString (2, NOM_TPL_UNI_ORG);
       ps.executeUpdate();
       return new Long(COD_TPL_UNI_ORG);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_TPL_UNI_ORG) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tpl_uni_org FROM tpl_uni_org_tab ");
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
    this.COD_TPL_UNI_ORG=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_TPL_UNI_ORG=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM tpl_uni_org_tab  WHERE cod_tpl_uni_org=?");
           ps.setLong (1, COD_TPL_UNI_ORG);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NOM_TPL_UNI_ORG=rs.getString("NOM_TPL_UNI_ORG");
                 this.DES_TPL_UNI_ORG=rs.getString("DES_TPL_UNI_ORG");
           }
           else{
              throw new NoSuchEntityException("TipologieUnitaOrganizzativa con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tpl_uni_org_tab  WHERE cod_tpl_uni_org=?");
          ps.setLong (1, COD_TPL_UNI_ORG);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieUnitaOrganizzativa con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tpl_uni_org_tab  SET nom_tpl_uni_org=?, des_tpl_uni_org=? WHERE cod_tpl_uni_org=?");
          ps.setString(1, NOM_TPL_UNI_ORG);
          ps.setString(2, DES_TPL_UNI_ORG);
              ps.setLong  (3, COD_TPL_UNI_ORG);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TipologieUnitaOrganizzativa con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
  public Collection getTipologiaUnitaView(){
      TipologieUnitaOrganizzativaBean bean=new TipologieUnitaOrganizzativaBean();
      return bean.ejbGetTipologiaUnitaView();
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
   //1
   public void setNOM_TPL_UNI_ORG(String newNOM_TPL_UNI_ORG){
      if( NOM_TPL_UNI_ORG.equals(newNOM_TPL_UNI_ORG) ) return;
      NOM_TPL_UNI_ORG = newNOM_TPL_UNI_ORG;
      setModified();
   }
   public String getNOM_TPL_UNI_ORG(){
      return NOM_TPL_UNI_ORG;
   }
   //2
   public long getCOD_TPL_UNI_ORG(){
      return COD_TPL_UNI_ORG;
   }
   //============================================
   // not required field
   //3
   public void setDES_TPL_UNI_ORG(String newDES_TPL_UNI_ORG){
      if(DES_TPL_UNI_ORG!=null){
          if( DES_TPL_UNI_ORG.equals(newDES_TPL_UNI_ORG) ) return;
      }
      DES_TPL_UNI_ORG = newDES_TPL_UNI_ORG;
      setModified();
   }
   public String getDES_TPL_UNI_ORG(){
      if(DES_TPL_UNI_ORG==null){return "";}
      return DES_TPL_UNI_ORG;
   }
   //</comment>

  public Collection ejbGetTipologiaUnitaView(){
      BMPConnection bmp=getConnection();
          try{
             PreparedStatement ps=bmp.prepareStatement(
             "select cod_tpl_uni_org, nom_tpl_uni_org,des_tpl_uni_org from tpl_uni_org_tab order by nom_tpl_uni_org"
             );
             ResultSet rs=ps.executeQuery();
             java.util.ArrayList ar= new java.util.ArrayList();
             while(rs.next()){
                    TipologiaUnitaView v=new TipologiaUnitaView();
                    v.lCOD_TPL_UNI_ORG=rs.getLong(1);
                    v.strNOM_TPL_UNI_ORG=rs.getString(2);
                    v.strDES_TPL_UNI_ORG=rs.getString(3);
                    ar.add(v);
             }
             return ar;
          }
          catch(Exception ex){
              throw new EJBException(ex);
          }
          finally{bmp.close();}
  }
  //-------------------
  //</comment>

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TipologieUnitaOrganizzativaBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////////////////////////
PseudoContext.bind("TipologieUnitaOrganizzativaBean", new TipologieUnitaOrganizzativaBean());
////////////////////////////////////////// </BINDING> ///////////////////////////////////////
%>
