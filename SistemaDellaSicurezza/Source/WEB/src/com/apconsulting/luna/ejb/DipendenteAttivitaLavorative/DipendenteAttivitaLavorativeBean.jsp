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

public class DipendenteAttivitaLavorativeBean extends BMPEntityBean implements IDipendenteAttivitaLavorative, IDipendenteAttivitaLavorativeHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
	java.sql.Date	dat_inz;
	java.sql.Date	dat_fie;
	long	cod_uni_org; 
	long	cod_man;
	long	cod_dpd;
	long	cod_azl;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private DipendenteAttivitaLavorativeBean()
  {
	//System.err.println("DipendenteAttivitaLavorativeBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDipendenteAttivitaLavorative create(
	java.sql.Date	dat_inz,
	java.sql.Date	dat_fie,
	long	cod_uni_org, 
	long	cod_man,
	long	cod_dpd,
	long	cod_az) throws CreateException
  {
 	 DipendenteAttivitaLavorativeBean bean =  new  DipendenteAttivitaLavorativeBean();
	 try{
	 Object primaryKey=bean.ejbCreate(dat_inz, dat_fie, cod_uni_org, cod_man, cod_dpd, cod_az);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(dat_inz, dat_fie, cod_uni_org, cod_man, cod_dpd, cod_az);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
  // (Home Intrface) remove()
  public void remove(Object primaryKey)
  {
  	DipendenteAttivitaLavorativeBean iDipendenteAttivitaLavorativeBean=new  DipendenteAttivitaLavorativeBean();
    try
	{
    	Object obj=iDipendenteAttivitaLavorativeBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDipendenteAttivitaLavorativeBean.setEntityContext(new EntityContextWrapper(obj));
        iDipendenteAttivitaLavorativeBean.ejbActivate();
        iDipendenteAttivitaLavorativeBean.ejbLoad();
        iDipendenteAttivitaLavorativeBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDipendenteAttivitaLavorative findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DipendenteAttivitaLavorativeBean bean =  new  DipendenteAttivitaLavorativeBean();
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
 
 
  // (Home Intrface) VIEWS  getDipendenteAttivitaLavorative_Name_Address_View()
/*  public Collection getDipendenteAttivitaLavorative_Name_Address_View()
  {
  	return (new  DipendenteAttivitaLavorativeBean()).ejbGetDipendenteAttivitaLavorative_Name_Address_View();
 }*/
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IDipendenteAttivitaLavorativeHome-implementation>
  public Long ejbCreate(long COD_AZL, long COD_DTE, long COD_FUZ_AZL, String STA_DPD, String MTR_DPD, String COG_DPD, String NOM_DPD, java.sql.Date DAT_NAS_DPD, String RAP_LAV_AZL, long COD_STA)
  {
	this.COD_DPD = NEW_ID(); // unic ID 
	this.COD_AZL = COD_AZL; 
	this.COD_DTE = COD_DTE; 
	this.COD_FUZ_AZL = COD_FUZ_AZL; 
	this.STA_DPD = STA_DPD; 
	this.MTR_DPD = MTR_DPD; 
	this.COG_DPD = COG_DPD; 
	this.NOM_DPD = NOM_DPD; 
	this.DAT_NAS_DPD = DAT_NAS_DPD; 
	this.RAP_LAV_AZL = RAP_LAV_AZL;
	this.COD_STA = COD_STA;

    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_dpd_tab (cod_dpd,cod_azl, cod_dte, cod_fuz_azl, sta_dpd, mtr_dpd, cog_dpd, nom_dpd, dat_nas_dpd, rap_lav_azl, cod_sta) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
         ps.setLong   (1, COD_DPD);
         ps.setLong   (2, COD_AZL);
         ps.setLong   (3, COD_DTE);
         ps.setLong   (4, COD_FUZ_AZL);
         ps.setString (5, STA_DPD);
         ps.setString (6, MTR_DPD);
         ps.setString (7, COG_DPD);
         ps.setString (8, NOM_DPD);
         ps.setDate   (9, DAT_NAS_DPD);
         ps.setString (10, RAP_LAV_AZL);
         ps.setLong   (11, COD_STA);
         ps.executeUpdate();
         return new Long(COD_DPD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(long COD_AZL, long COD_DTE, long COD_FUZ_AZL, String STA_DPD, String MTR_DPD, String COG_DPD, String NOM_DPD, java.sql.Date DAT_NAS_DPD, String RAP_LAV_AZL, long COD_STA) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dpd FROM view_ana_dpd_tab ORDER BY cog_dpd ");
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
    this.COD_DPD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_DPD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM view_ana_dpd_tab  WHERE cod_dpd=?");
           ps.setLong (1, COD_DPD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              	this.COD_DPD=rs.getLong("COD_DPD");
              	this.COD_AZL=rs.getLong("COD_AZL");
              	this.COD_DTE=rs.getLong("COD_DTE");
              	this.COD_FUZ_AZL=rs.getLong("COD_FUZ_AZL");
              	this.STA_DPD=rs.getString("STA_DPD");
              	this.MTR_DPD=rs.getString("MTR_DPD");
              	this.COG_DPD=rs.getString("COG_DPD");
              	this.NOM_DPD=rs.getString("NOM_DPD");
              	this.COD_FIS_DPD=rs.getString("COD_FIS_DPD");
              	this.COD_STA=rs.getLong("COD_STA");
              	this.LUO_NAS_DPD=rs.getString("LUO_NAS_DPD");
              	this.DAT_NAS_DPD=rs.getDate("DAT_NAS_DPD");
              	this.IDZ_DPD=rs.getString("IDZ_DPD");
              	this.NUM_CIC_DPD=rs.getString("NUM_CIC_DPD");
              	this.CAP_DPD=rs.getString("CAP_DPD");
              	this.CIT_DPD=rs.getString("CIT_DPD");
              	this.PRV_DPD=rs.getString("PRV_DPD");
              	this.IDZ_PSA_ELT_DPD=rs.getString("IDZ_PSA_ELT_DPD");
              	this.RAP_LAV_AZL=rs.getString("RAP_LAV_AZL");
           }
           else{
              throw new NoSuchEntityException("DipendenteAttivitaLavorative con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_dpd_tab  WHERE cod_dpd=?");
          ps.setLong (1, COD_DPD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteAttivitaLavorative con ID="+COD_DPD+" non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_dpd_tab  SET cod_azl=?, cod_dte=?, cod_fuz_azl=?,sta_dpd=?,mtr_dpd=?,cog_dpd=?,nom_dpd=?,cod_fis_dpd=?,cod_sta=?,luo_nas_dpd=?,dat_nas_dpd=?,idz_dpd=?,num_cic_dpd=?,cap_dpd=?,cit_dpd=?,prv_dpd=?,idz_psa_elt_dpd=?,rap_lav_azl=?	 WHERE cod_dpd=?");
         ps.setLong(1, COD_AZL);
         ps.setLong(2, COD_DTE);
         ps.setLong(3, COD_FUZ_AZL);
         ps.setString(4, STA_DPD);
         ps.setString(5, MTR_DPD);
         ps.setString(6, COG_DPD);
         ps.setString(7, NOM_DPD);
         ps.setString(8, COD_FIS_DPD);
         ps.setLong(9, COD_STA);
         ps.setString(10, LUO_NAS_DPD);
         ps.setDate(11, DAT_NAS_DPD);
         ps.setString(12, IDZ_DPD);
         ps.setString(13, NUM_CIC_DPD);
         ps.setString(14, CAP_DPD);
         ps.setString(15, CIT_DPD);
         ps.setString(16, PRV_DPD);
         ps.setString(17, IDZ_PSA_ELT_DPD);
         ps.setString(18, RAP_LAV_AZL);
         ps.setLong(19, COD_DPD);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteAttivitaLavorative with ID= not found");
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
	// dat_inz
	public void setdat_inz(java.sql.Date newdat_inz)
	{
		if(dat_inz!=null) if( dat_inz.equals(newdat_inz)) return;
		dat_inz = newdat_inz;
		setModified();
	}
	public java.sql.Date getdat_inz()
	{
		return dat_inz;
	}

	// dat_fie
	public void setdat_fie(java.sql.Date newdat_fie)
	{
		if(dat_fie!=null) if( dat_fie.equals(newdat_fie)) return;
		dat_fie = newdat_fie;
		setModified();
	}
	public java.sql.Date getdat_fie()
	{
		return dat_fie;
	}

	// cod_uni_org
	public void setcod_uni_org(long newcod_uni_org)
	{
		cod_uni_org = newcod_uni_org;
		setModified();
	}
	public long getcod_uni_org()
	{
		return cod_uni_org;
	}

	// cod_man
	public void setcod_man(long newcod_man)
	{
		cod_man = newcod_man;
		setModified();
	}
	public long getcod_man()
	{
		return cod_man;
	}

	// cod_dpd
	public void setcod_dpd(long newcod_dpd)
	{
		cod_dpd = newcod_dpd;
		setModified();
	}
	public long getcod_dpd()
	{
		return cod_dpd;
	}

	// cod_azl
	public void setcod_azl(long newcod_azl)
	{
		cod_azl = newcod_azl;
		setModified();
	}
	public long getcod_azl()
	{
		return cod_azl;
	}

//</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
/*
   public Collection ejbGetDipendenteAttivitaLavorative_Name_Address_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_azl,rag_scl_azl,idz_azl FROM view_ana_dpd_tab ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendenteAttivitaLavorative_Name_Address_View obj=new DipendenteAttivitaLavorative_Name_Address_View();
            obj.COD_AZL=rs.getLong(1);
            obj.RAG_SCL_ACL=rs.getString(2);
            obj.IDZ_AZL=rs.getString(3);
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
*/  
  //-------------------
  //</comment>         

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  DipendenteAttivitaLavorativeBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DipendenteAttivitaLavorativeBean", new DipendenteAttivitaLavorativeBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
