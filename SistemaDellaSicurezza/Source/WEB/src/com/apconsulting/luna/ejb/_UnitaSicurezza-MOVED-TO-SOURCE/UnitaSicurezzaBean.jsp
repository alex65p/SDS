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
< file>
  < versions>
    < version number="1.0" date="20/02/2004" author="Malyuk Sergey">
      < comments>
			   < comment date="20/02/2004" author="Malyuk Sergey">
				   < description>Realizazija EJB dlia objecta UnitaSicurezza
				 < /comment>
			   <comment date="24/02/2004" author="Alexey Kolesnik">
				   View for DPD_UNI_SIC (OrganizzativaByAZLID_View)
				   View for DPD_UNI_SIC (OrganizzativaByUNI_SICID_View)
			   </comment>
			   <comment date="25/02/2004" author="Alexey Kolesnik">
				   Canged addCOD_UNI_ORG (Organizzativa link)
			   </comment>
      < /comments>
    < /version>
  < /versions>
< /file>
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>

<%!
public class UnitaSicurezzaBean extends BMPEntityBean implements IUnitaSicurezza, IUnitaSicurezzaHome
{
  //< member-varibles description="Member Variables">
	long lCOD_UNI_SIC;
	String strNOM_UNI_SIC;
	String strDES_UNI_SIC;
	long lCOD_AZL;
	long lCOD_DPD;
	long lCOD_UNI_SIC_ASC;
	long lCOD_UNI_ORG;
  //< /member-varibles>

 //< IUnitaSicurezzaHome-implementation>

      public static final String BEAN_NAME="UnitaSicurezzaBean";

      public UnitaSicurezzaBean(){}

      public void remove(Object primaryKey){
            UnitaSicurezzaBean bean=new UnitaSicurezzaBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
              throw new EJBException(ex.getMessage());
            }
      }

      public IUnitaSicurezza create(String strNOM_UNI_SIC, long lCOD_AZL) throws javax.ejb.CreateException {
         UnitaSicurezzaBean bean=new UnitaSicurezzaBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_UNI_SIC, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strNOM_UNI_SIC, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IUnitaSicurezza findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      UnitaSicurezzaBean bean=new UnitaSicurezzaBean();
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

      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
 //
  // (Home Intrface) VIEWS  getDomandeByTESVRFID_View()

 	public Collection getOrganizativaByUNISICID_View(long UNI_SIC_ID)
    {
  	    return (new  UnitaSicurezzaBean()).ejbGetOrganizativaByUNISICID_View(UNI_SIC_ID);
    }

//------------------<ALEX>-------------------------------------------  
  public Collection getTopOfTree(long lCOD_AZL){
  		return (new UnitaSicurezzaBean()).ejbGetTopOfTree(lCOD_AZL);
  } 
//------------------</ALEX>------------------------------------------  

    public Collection getOrganizzativaByAZLID_View(long lCOD_AZL)
    {
     	return (new  UnitaSicurezzaBean()).ejbGetOrganizzativaByAZLID_View(lCOD_AZL);
    }

    public Collection findOrganizzativaByCOD_UNI_SIC(long COD_UNI_SIC, long COD_UNI_ORG)
    {
     	return (new  UnitaSicurezzaBean()).ejbGetOrganizzativaByCOD_UNI_SIC(COD_UNI_SIC, COD_UNI_ORG);
    }
    public Collection getUnitaSicurezza_View(long lCOD_AZL){
     	return (new  UnitaSicurezzaBean()).ejbGetUnitaSicurezza_View(lCOD_AZL);
    }
		
//----------------------------------------------------------

	public Long ejbCreate(String strNOM_UNI_SIC, long lCOD_AZL)
  {
	this.lCOD_UNI_SIC= NEW_ID();
	this.strNOM_UNI_SIC=strNOM_UNI_SIC;
	this.lCOD_AZL=lCOD_AZL;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_uni_sic_tab (cod_uni_sic,nom_uni_sic,cod_azl) VALUES(?,?,?)");
			ps.setLong(1, lCOD_UNI_SIC);
			ps.setString(2, strNOM_UNI_SIC);
			ps.setLong(3, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_UNI_SIC);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_UNI_SIC, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_uni_sic FROM ana_uni_sic_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_UNI_SIC=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_UNI_SIC=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_uni_sic,nom_uni_sic,des_uni_sic,cod_azl,cod_uni_sic_asc FROM ana_uni_sic_tab WHERE cod_uni_sic=?");
           ps.setLong(1, lCOD_UNI_SIC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_UNI_SIC=rs.getLong(1);
			strNOM_UNI_SIC=rs.getString(2);
			strDES_UNI_SIC=rs.getString(3);
			lCOD_AZL=rs.getLong(4);
			lCOD_UNI_SIC_ASC=rs.getLong(5);
           }
           else{
              throw new NoSuchEntityException("UnitaSicurezza with ID="+lCOD_UNI_SIC+" not found");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_uni_sic_tab WHERE cod_uni_sic=?");
         ps.setLong(1, lCOD_UNI_SIC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("UnitaSicurezza with ID="+lCOD_UNI_SIC+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_uni_sic_tab SET nom_uni_sic=?, des_uni_sic=?, cod_azl=?, cod_uni_sic_asc=? WHERE cod_uni_sic=?");
			ps.setString(1, strNOM_UNI_SIC);
			ps.setString(2, strDES_UNI_SIC);
			ps.setLong(3, lCOD_AZL);
			if(lCOD_UNI_SIC_ASC==0) ps.setNull(4,java.sql.Types.BIGINT); else ps.setLong(4, lCOD_UNI_SIC_ASC);
			ps.setLong(5, lCOD_UNI_SIC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("UnitaSicurezza with ID="+lCOD_UNI_SIC+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


	 //-----------------------------#############################################
    // %%%Link%%% Table DPD_UNI_SIC_TAB
  	public void addOrganizzativa(long lC_U_S, long lC_D, long lC_U_O, long lC_A){
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement(
                              "INSERT INTO dpd_uni_sic_tab "
                              +" (cod_uni_sic,cod_uni_org,cod_azl,cod_dpd) "
                              +" VALUES (?,?,?,?) ");
				ps.setLong(1, lC_U_S);
				ps.setLong(2, lC_U_O);
				ps.setLong(3, lC_A);
				ps.setLong(4, lC_D);
				ps.executeUpdate();
		}
	    catch(Exception ex){
          throw new EJBException(ex);
        }
        finally{bmp.close();}
	}


    // %%%UNLink%%% Table DPD_UNI_SIC_TAB
    public void removeOrganizzativa(long lC_U_S, long lC_D, long lC_U_O, long lC_A){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement(
                           "DELETE FROM dpd_uni_sic_tab "
                           +" WHERE cod_uni_sic=? "
                           +" AND cod_uni_org=?"
                           +" AND cod_azl=?"
                           +" AND cod_dpd=?"
         );
				ps.setLong(1, lC_U_S);
				ps.setLong(2, lC_U_O);
				ps.setLong(3, lC_A);
				ps.setLong(4, lC_D);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Organizzativa  non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
	}

    //-----------------------------#############################################

  //< setter-getters>

	public long getCOD_UNI_SIC(){
		return lCOD_UNI_SIC;
	}

	public String getNOM_UNI_SIC(){
		return strNOM_UNI_SIC;
	}

	public void setNOM_UNI_SIC(String strNOM_UNI_SIC){
		if(  (this.strNOM_UNI_SIC!=null) && (this.strNOM_UNI_SIC.equals(strNOM_UNI_SIC))  ) return;
		this.strNOM_UNI_SIC=strNOM_UNI_SIC;
		setModified();
	}

	public String getDES_UNI_SIC(){
		return strDES_UNI_SIC;
	}

	public void setDES_UNI_SIC(String strDES_UNI_SIC){
		if(  (this.strDES_UNI_SIC!=null) && (this.strDES_UNI_SIC.equals(strDES_UNI_SIC))  ) return;
		this.strDES_UNI_SIC=strDES_UNI_SIC;
		setModified();
	}

	public long getCOD_AZL(){
		return lCOD_AZL;
	}

	public void setCOD_AZL(long lCOD_AZL){
		if(this.lCOD_AZL==lCOD_AZL) return;
		this.lCOD_AZL=lCOD_AZL;
		setModified();
	}

	public long getCOD_UNI_SIC_ASC(){
		return lCOD_UNI_SIC_ASC;
	}

	public void setCOD_UNI_SIC_ASC(long lCOD_UNI_SIC_ASC){
		if(this.lCOD_UNI_SIC_ASC==lCOD_UNI_SIC_ASC) return;
		this.lCOD_UNI_SIC_ASC=lCOD_UNI_SIC_ASC;
		setModified();
	}

//---------------------<ALEX>-----------------------------------------
	public void setNOM_UNI_SIC__COD_AZL(String strNOM_UNI_SIC, long lCOD_AZL){
		if(this.strDES_UNI_SIC.equals(strNOM_UNI_SIC) && this.lCOD_AZL==lCOD_AZL ) return;
		this.strNOM_UNI_SIC=strNOM_UNI_SIC;
		this.lCOD_AZL=lCOD_AZL;
		setModified();
	}
//--------------------</ALEX>----------------------------------------

  public Collection ejbGetOrganizativaByUNISICID_View(long COD_UNI_SIC_ID){
       BMPConnection bmp=getConnection();
      try{
		  PreparedStatement ps=bmp.prepareStatement(
                            "SELECT dpd_uni_sic_tab.cod_uni_org, "
                            +" ana_uni_org_tab.nom_uni_org, "
                            +" dpd_uni_sic_tab.cod_dpd "
                            +" FROM dpd_uni_sic_tab, ana_uni_org_tab "
                            +" WHERE ana_uni_org_tab.cod_uni_org = dpd_uni_sic_tab.cod_uni_org "
                            +" AND  dpd_uni_sic_tab.cod_uni_sic=? ");
          ps.setLong(1, COD_UNI_SIC_ID);

					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Organizativa_View obj=new Organizativa_View();
            obj.COD_UNI_ORG=rs.getLong(1);
            obj.NOM_UNI_ORG=rs.getString(2);
            obj.COD_DPD=rs.getLong(3);
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


 //-------------------<ALEX> --------------------------------------------------- 
    public Collection ejbGetTopOfTree(long lCOD_AZL){
  	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select cod_uni_sic ,  nom_uni_sic , des_uni_sic ,  cod_azl , cod_uni_sic_asc from ana_uni_sic_tab where cod_uni_sic_asc is null and  cod_azl = ? ");
		  ps.setLong(1, lCOD_AZL);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
		  	UnitaSicurezzaView w= new UnitaSicurezzaView();
				w.lCOD_UNI_SIC=rs.getLong(1);
				w.strNOM_UNI_SIC=rs.getString(2);
				w.strDES_UNI_SIC = rs.getString(3);
				w.lCOD_AZL = rs.getLong(4);
				w.lCOD_UNI_SIC_ASC = rs.getLong(5);
            al.add(w);
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	}
  
  public Collection getChildren(long lCOD_AZL){
  	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select cod_uni_sic ,  nom_uni_sic , des_uni_sic ,  cod_azl , cod_uni_sic_asc from ana_uni_sic_tab where cod_uni_sic_asc=? and  cod_azl = ?");
		  ps.setLong(1, lCOD_UNI_SIC);
		  ps.setLong(2, lCOD_AZL);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
		  	UnitaSicurezzaView w= new UnitaSicurezzaView();
				w.lCOD_UNI_SIC=rs.getLong(1);
				w.strNOM_UNI_SIC=rs.getString(2);
				w.strDES_UNI_SIC = rs.getString(3);
				w.lCOD_AZL = rs.getLong(4);
				w.lCOD_UNI_SIC_ASC = rs.getLong(5);
            al.add(w);
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	}
//<report>
  
  public Collection getResponsabile(){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
		  "  SELECT "+
		  " 		C.COD_DPD, "+
		  " 	NOM_DPD, "+
		  " 	COG_DPD "+
		  " FROM   DPD_UNI_SIC_TAB B, VIEW_ANA_DPD_TAB C "+
		  " WHERE  B.COD_DPD = C.COD_DPD "+
		  "  		AND b.COD_UNI_SIC=?"
		  );
		  ps.setLong(1, lCOD_UNI_SIC);
          ResultSet rs=ps.executeQuery();
         java.util.ArrayList al=new java.util.ArrayList();
		  while(rs.next()){
		  		USResponsabileView w=new USResponsabileView();
				w.lCOD_DPD =rs.getLong(1);
				w.strNOM_DPD = rs.getString(2);
				w.strCOG_DPD= rs.getString(3);
			 al.add(w);
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
 //</report>

//---------------------</ALEX>-----------------------------------------------------

  public Collection ejbGetOrganizzativaByAZLID_View(long lCOD_AZL)
  {
       BMPConnection bmp=getConnection();
      try{
		  PreparedStatement ps=bmp.prepareStatement(
                            "SELECT cod_uni_org, nom_uni_org "
                            +" FROM ana_uni_org_tab "
                            +" WHERE cod_azl=? ");
          ps.setLong(1, lCOD_AZL);

		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            OrganizzativaByAZLID_View obj=new OrganizzativaByAZLID_View();
            obj.COD_UNI_ORG=rs.getLong(1);
            obj.NOM_UNI_ORG=rs.getString(2);
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

  public Collection ejbGetOrganizzativaByCOD_UNI_SIC(long COD_UNI_SIC, long COD_UNI_ORG)
  {
       BMPConnection bmp=getConnection();
      try{
		  PreparedStatement ps=bmp.prepareStatement(
                           "SELECT cod_uni_sic, cod_azl, cod_dpd, cod_uni_org "
                           +" FROM dpd_uni_sic_tab WHERE cod_uni_sic=? "
                           +" AND cod_uni_org=?"
            );
          ps.setLong(1, COD_UNI_SIC);
          ps.setLong(2, COD_UNI_ORG);

		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            OrganizzativaByCOD_UNI_SIC obj=new OrganizzativaByCOD_UNI_SIC();
            obj.lCOD_UNI_SIC=rs.getLong(1);
			obj.lCOD_AZL=rs.getLong(2);
			obj.lCOD_DPD=rs.getLong(3);
			obj.lCOD_UNI_ORG=rs.getLong(4);
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

 //---------------------- <ALEX> --------------------------  
  public AssociativaView getAssociativa(long  lCOD_UNI_ORG, long lCOD_DPD){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select a.nom_dpd, a.cog_dpd, a.mtr_dpd, a.cod_dpd from   view_ana_dpd_tab a, dpd_uni_sic_tab b,    ana_uni_org_tab c where  a.cod_dpd = b.cod_dpd and    b.cod_uni_org = c.cod_uni_org  and    b.cod_uni_sic = ? and b.cod_uni_org = ? and b.cod_dpd = ? ");
		  ps.setLong(1, lCOD_UNI_SIC);
		  ps.setLong(2, lCOD_UNI_ORG);
		  ps.setLong(3, lCOD_DPD);
          ResultSet rs=ps.executeQuery();
          AssociativaView w= new AssociativaView();
		  if(rs.next()){
				w.strNOM_DPD = rs.getString(1);
				w.strCOG_DPD=rs.getString(2);
				w.strMTR_DPD=rs.getString(3);				
				w.lCOD_DPD =rs.getLong(4);
				w.lCOD_UNI_ORG =lCOD_UNI_ORG;
          }
          return w;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
  //------------------- </ALEX> -------------------------------

public Collection ejbGetUnitaSicurezza_View(long lCOD_AZL){
       BMPConnection bmp=getConnection();
      try{
		  PreparedStatement ps=bmp.prepareStatement(
                            "SELECT cod_uni_sic, nom_uni_sic, des_uni_sic "
                            +" FROM ana_uni_sic_tab "
                            +" WHERE cod_azl=? ORDER BY nom_uni_sic ");
          ps.setLong(1, lCOD_AZL);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            UnitaSicurezzaView obj=new UnitaSicurezzaView();
            obj.lCOD_UNI_SIC=rs.getLong(1);
            obj.strNOM_UNI_SIC=rs.getString(2);
						obj.strDES_UNI_SIC=rs.getString(3);
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

  //< /setter-getters>
}
%>
<%
//////////////////////////////////////////  ///////////////////////////////
PseudoContext.bind(UnitaSicurezzaBean.BEAN_NAME, new UnitaSicurezzaBean());
//////////////////////////////////////////  ///////////////////////////////
%>
