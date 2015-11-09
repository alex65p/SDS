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
<%@ page import="java.util.*"%>

<%!
public class PercorsiFormativiBean extends BMPEntityBean implements IPercorsiFormativi, IPercorsiFormativiHome
{
  //<member-varibles description="Member Variables">
	long lCOD_PCS_FRM;
	String strNOM_PCS_FRM;
	String strDES_PCS_FRM;
	long lCOD_AZL;
  //</member-varibles>

 //<IPercorsiFormativiHome-implementation>

      public static final String BEAN_NAME="PercorsiFormativiBean";

      public PercorsiFormativiBean(){}

      public void remove(Object primaryKey){
            PercorsiFormativiBean bean=new PercorsiFormativiBean();
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

      public IPercorsiFormativi create(String strNOM_PCS_FRM, long lCOD_AZL) throws javax.ejb.CreateException {
         PercorsiFormativiBean bean=new PercorsiFormativiBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_PCS_FRM, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate( strNOM_PCS_FRM, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IPercorsiFormativi findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      PercorsiFormativiBean bean=new PercorsiFormativiBean();
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
 	 //---podmaster for search
	public Collection findEx(  
		long lCOD_AZL,
		String strNOM_PCS_FRM,  
		int iOrderParameter //not used for now
	){
		return ejbFindEx(lCOD_AZL, strNOM_PCS_FRM, iOrderParameter);
	}
	
	public Collection ejbFindEx(  
		long lCOD_AZL,
		String strNOM_PCS_FRM, 
		int iOrderParameter //not used for now
	){
		String strSql="SELECT cod_pcs_frm, nom_pcs_frm, des_pcs_frm  FROM  ana_pcs_frm_tab WHERE cod_azl=? ";
		if(strNOM_PCS_FRM!=null){
				strSql+=" AND UPPER(nom_pcs_frm) LIKE ?";
		}
		strSql+=" ORDER BY UPPER(nom_pcs_frm)";
		int i=1;
		BMPConnection bmp=getConnection();
		try{
				PreparedStatement ps=bmp.prepareStatement(strSql);
				ps.setLong(i++, lCOD_AZL);
				if(strNOM_PCS_FRM!=null) ps.setString(i++, strNOM_PCS_FRM.toUpperCase());
				ResultSet rs=ps.executeQuery();
	      java.util.ArrayList ar= new java.util.ArrayList();
	      while(rs.next()){
	      	  	PercorsiFormativi_View obj=new PercorsiFormativi_View();
            	obj.COD_PCS_FRM=rs.getLong(1);
            	obj.NOM_PCS_FRM=rs.getString(2);
				obj.DES_PCS_FRM=rs.getString(3);
	        	ar.add(obj);
	      }
		  return ar;
		}catch(Exception ex){
					throw new EJBException(strSql+"/n"+ex);
      }
		  finally{bmp.close();}
	}

   // (Home Intrface) VIEWS  getPercorsiFormativiCorsiByID_View()
  	  public Collection getPercorsiFormativiCorsiByID_View(long lCOD_PCS_FRM)
	  {
	  	return (new  PercorsiFormativiBean()).ejbGetPercorsiFormativiCorsiByID_View(lCOD_PCS_FRM);
	  }
  	  public Collection getPercorsiFormativi_View(long lCOD_AZL)
	  {
	  	return (new  PercorsiFormativiBean()).ejbGetPercorsiFormativi_View(lCOD_AZL);
	  }
      public Collection getDipendentePercorsi_View(long lCOD_DPD){
		return (new  PercorsiFormativiBean()).ejbGetDipendentePercorsi_View(lCOD_DPD);
	  }

  public Long ejbCreate(String strNOM_PCS_FRM, long lCOD_AZL)
  {
	this.lCOD_PCS_FRM= NEW_ID();
	this.strNOM_PCS_FRM=strNOM_PCS_FRM;
	this.lCOD_AZL=lCOD_AZL;
	this.unsetModified();
	BMPConnection bmp=getConnection();
	try{
		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_pcs_frm_tab (cod_pcs_frm,nom_pcs_frm,cod_azl) VALUES(?,?,?)");
			ps.setLong(1, lCOD_PCS_FRM);
			ps.setString(2, strNOM_PCS_FRM);
			ps.setLong(3, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_PCS_FRM);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_PCS_FRM, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_pcs_frm FROM ana_pcs_frm_tab");
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

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_PCS_FRM=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_PCS_FRM=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_pcs_frm,nom_pcs_frm,des_pcs_frm,cod_azl FROM ana_pcs_frm_tab WHERE cod_pcs_frm=?");
           ps.setLong(1, lCOD_PCS_FRM);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_PCS_FRM=rs.getLong(1);
			strNOM_PCS_FRM=rs.getString(2);
			strDES_PCS_FRM=rs.getString(3);
			lCOD_AZL=rs.getLong(4);
           }
           else{
              throw new NoSuchEntityException("PercorsiFormativi with ID="+lCOD_PCS_FRM+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_pcs_frm_tab WHERE cod_pcs_frm=?");
         ps.setLong(1, lCOD_PCS_FRM);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("PercorsiFormativi with ID="+lCOD_PCS_FRM+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_pcs_frm_tab SET cod_pcs_frm=?, nom_pcs_frm=?, des_pcs_frm=?, cod_azl=? WHERE cod_pcs_frm=?");
			ps.setLong(1, lCOD_PCS_FRM);
			ps.setString(2, strNOM_PCS_FRM);
			ps.setString(3, strDES_PCS_FRM);
			ps.setLong(4, lCOD_AZL);
			ps.setLong(5, lCOD_PCS_FRM);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("PercorsiFormativi with ID="+lCOD_PCS_FRM+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>

	public long getCOD_PCS_FRM(){
		return lCOD_PCS_FRM;
	}

	public String getNOM_PCS_FRM(){
		return strNOM_PCS_FRM;
	}

	public void setNOM_PCS_FRM(String strNOM_PCS_FRM){
		if(  (this.strNOM_PCS_FRM!=null) && (this.strNOM_PCS_FRM.equals(strNOM_PCS_FRM))  ) return;
		this.strNOM_PCS_FRM=strNOM_PCS_FRM;
		setModified();
	}

	public String getDES_PCS_FRM(){
		return strDES_PCS_FRM;
	}

	public void setDES_PCS_FRM(String strDES_PCS_FRM){
		if(  (this.strDES_PCS_FRM!=null) && (this.strDES_PCS_FRM.equals(strDES_PCS_FRM))  ) return;
		this.strDES_PCS_FRM=strDES_PCS_FRM;
		setModified();
	}

	public long getCOD_AZL(){
		return lCOD_AZL;
	}

	public void setCOD_AZL(long lCOD_AZL){
		if(this.lCOD_AZL==lCOD_AZL) return;
		this.lCOD_AZL=lCOD_AZL;
	}
  //</setter-getters>

	    // %%%Link%%% Table COR_PCS_FRM_TAB
	public void addCOD_COR(long newCOD_COR){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO cor_pcs_frm_tab (cod_cor,cod_pcs_frm) VALUES(?,?)");
           ps.setLong   (1, newCOD_COR);
           ps.setLong		(2, lCOD_PCS_FRM);
           ps.executeUpdate();
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	}
    // %%%UNLink%%% Table COR_PCS_FRM_TAB
    public void removeCOD_COR(long newCOD_COR){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM cor_pcs_frm_tab  WHERE cod_pcs_frm=? AND cod_cor=?");
         ps.setLong (1, lCOD_PCS_FRM);
         ps.setLong (2, newCOD_COR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Corsi con ID="+newCOD_COR+" non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
	}


   //<comment description="Zdes opredeliayutsia metody-views"/>

    public Collection ejbGetPercorsiFormativiCorsiByID_View(long COD_PCS_FRM){
       BMPConnection bmp=getConnection();
      try{//
          PreparedStatement ps=bmp.prepareStatement("SELECT ana_cor_tab.cod_cor, ana_cor_tab.nom_cor, ana_cor_tab.des_cor FROM  ana_cor_tab, cor_pcs_frm_tab WHERE  ana_cor_tab.cod_cor = cor_pcs_frm_tab.cod_cor AND cor_pcs_frm_tab.cod_pcs_frm=?  ORDER BY ana_cor_tab.nom_cor ");
		  ps.setLong(1, COD_PCS_FRM);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            PercorsiFormativiCorsiByID_View obj=new PercorsiFormativiCorsiByID_View();
            obj.COD_PCS_FRM=COD_PCS_FRM;
            obj.COD_COR=rs.getLong(1);
            obj.NOM_COR=rs.getString(2);
			obj.DES_COR=rs.getString(3);
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

    public Collection ejbGetPercorsiFormativi_View(long lCOD_AZL){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_pcs_frm, nom_pcs_frm, des_pcs_frm  FROM  ana_pcs_frm_tab WHERE cod_azl=? ORDER BY nom_pcs_frm");
          ps.setLong(1, lCOD_AZL);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            PercorsiFormativi_View obj=new PercorsiFormativi_View();
            obj.COD_PCS_FRM=rs.getLong(1);
            obj.NOM_PCS_FRM=rs.getString(2);
						obj.DES_PCS_FRM=rs.getString(3);
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
   public Collection ejbGetDipendentePercorsi_View(long lCOD_DPD){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select a.nom_pcs_frm , a.des_pcs_frm ,b.cod_dpd  from   ana_pcs_frm_tab a, pcs_frm_dpd_tab b where  a.cod_pcs_frm = b.cod_pcs_frm   and b.cod_dpd = ? ");
          ps.setLong(1, lCOD_DPD);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendentePercorsi_View obj=new DipendentePercorsi_View();
            obj.strNOM_PCS=rs.getString(1);
            obj.strDES_PCS=rs.getString(2);
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
}
%>
<%
/////////////////////////////////////////////////////////////////////////////////
PseudoContext.bind(PercorsiFormativiBean.BEAN_NAME, new PercorsiFormativiBean());
/////////////////////////////////////////////////////////////////////////////////
%>
