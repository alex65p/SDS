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
public class DipendenteConsegneDPIBean extends BMPEntityBean implements IDipendenteConsegneDPI, IDipendenteConsegneDPIHome

{
  //<member-varibles description="Member Variables">
	long lCOD_CSG_DPI;
	long lCOD_DPD;
	java.sql.Date dtDAT_CSG_DPI;
	String strNOM_RSP_CSG_DPI;
	String strEFT_CSG_SCH_DPI;
	long lQTA_CSG;
	String strTPL_CSG;
	long lCOD_LOT_DPI;
	long lCOD_TPL_DPI;
	long lCOD_AZL;
  //</member-varibles>

 //<IDipendenteConsegneDPIHome-implementation>

      public static final String BEAN_NAME="DipendenteConsegneDPIBean";
      
      public DipendenteConsegneDPIBean(){}

      public void remove(Object primaryKey){
            DipendenteConsegneDPIBean bean=new DipendenteConsegneDPIBean();
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

      public IDipendenteConsegneDPI create(long lCOD_DPD, java.sql.Date dtDAT_CSG_DPI, String strNOM_RSP_CSG_DPI, String strEFT_CSG_SCH_DPI, long lQTA_CSG, String strTPL_CSG, long lCOD_LOT_DPI, long lCOD_TPL_DPI, long lCOD_AZL) throws javax.ejb.CreateException {
         DipendenteConsegneDPIBean bean=new DipendenteConsegneDPIBean();
             try{
              Object primaryKey=bean.ejbCreate(  lCOD_DPD, dtDAT_CSG_DPI, strNOM_RSP_CSG_DPI, strEFT_CSG_SCH_DPI, lQTA_CSG, strTPL_CSG, lCOD_LOT_DPI, lCOD_TPL_DPI, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  lCOD_DPD, dtDAT_CSG_DPI, strNOM_RSP_CSG_DPI, strEFT_CSG_SCH_DPI, lQTA_CSG, strTPL_CSG, lCOD_LOT_DPI, lCOD_TPL_DPI, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IDipendenteConsegneDPI findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      DipendenteConsegneDPIBean bean=new DipendenteConsegneDPIBean();
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
	  public Collection getDipendenti_DPI_View(long COD_DPD)
	  {
	  	return (new DipendenteConsegneDPIBean()).ejbGetDipendenti_DPI_View(COD_DPD);
	  }
	  
	  public  Collection getResponsabileDPI_View(long lCOD_DPD){
	  	return (new DipendenteConsegneDPIBean()).ejbGetResponsabileDPI_View(lCOD_DPD);
	  }
 //

  public Long ejbCreate(long lCOD_DPD, java.sql.Date dtDAT_CSG_DPI, String strNOM_RSP_CSG_DPI, String strEFT_CSG_SCH_DPI, long lQTA_CSG, String strTPL_CSG, long lCOD_LOT_DPI, long lCOD_TPL_DPI, long lCOD_AZL)
  {
	this.lCOD_CSG_DPI= NEW_ID();
	this.lCOD_DPD=lCOD_DPD;
	this.dtDAT_CSG_DPI=dtDAT_CSG_DPI;
	this.strNOM_RSP_CSG_DPI=strNOM_RSP_CSG_DPI;
	this.strEFT_CSG_SCH_DPI=strEFT_CSG_SCH_DPI;
	this.lQTA_CSG=lQTA_CSG;
	this.strTPL_CSG=strTPL_CSG;
	this.lCOD_LOT_DPI=lCOD_LOT_DPI;
	this.lCOD_TPL_DPI=lCOD_TPL_DPI;
	this.lCOD_AZL=lCOD_AZL;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO dpi_dpd_tab (cod_csg_dpi,cod_dpd,dat_csg_dpi,nom_rsp_csg_dpi,eft_csg_sch_dpi,qta_csg,tpl_csg,cod_lot_dpi,cod_tpl_dpi,cod_azl) VALUES(?,?,?,?,?,?,?,?,?,?)");
			ps.setLong(1, lCOD_CSG_DPI);
			ps.setLong(2, lCOD_DPD);
			ps.setDate(3, dtDAT_CSG_DPI);
			ps.setString(4, strNOM_RSP_CSG_DPI);
			ps.setString(5, strEFT_CSG_SCH_DPI);
			ps.setLong(6, lQTA_CSG);
			ps.setString(7, strTPL_CSG);
			ps.setLong(8, lCOD_LOT_DPI);
			ps.setLong(9, lCOD_TPL_DPI);
			ps.setLong(10, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_CSG_DPI);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lCOD_DPD, java.sql.Date dtDAT_CSG_DPI, String strNOM_RSP_CSG_DPI, String strEFT_CSG_SCH_DPI, long lQTA_CSG, String strTPL_CSG, long lCOD_LOT_DPI, long lCOD_TPL_DPI, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_csg_dpi FROM dpi_dpd_tab");
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
    this.lCOD_CSG_DPI=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_CSG_DPI=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_csg_dpi,cod_dpd,dat_csg_dpi,nom_rsp_csg_dpi,eft_csg_sch_dpi,qta_csg,tpl_csg,cod_lot_dpi,cod_tpl_dpi,cod_azl FROM dpi_dpd_tab WHERE cod_csg_dpi=?");
           ps.setLong(1, lCOD_CSG_DPI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
       		lCOD_CSG_DPI=rs.getLong(1);
			lCOD_DPD=rs.getLong(2);
			dtDAT_CSG_DPI=rs.getDate(3);
			strNOM_RSP_CSG_DPI=rs.getString(4);
			strEFT_CSG_SCH_DPI=rs.getString(5);
			lQTA_CSG=rs.getLong(6);
			strTPL_CSG=rs.getString(7);
			lCOD_LOT_DPI=rs.getLong(8);
			lCOD_TPL_DPI=rs.getLong(9);
			lCOD_AZL=rs.getLong(10);
           }
           else{
              throw new NoSuchEntityException("DipendenteConsegneDPI with ID="+lCOD_CSG_DPI+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM dpi_dpd_tab WHERE cod_csg_dpi=?");
         ps.setLong(1, lCOD_CSG_DPI);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteConsegneDPI with ID="+lCOD_CSG_DPI+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE dpi_dpd_tab SET cod_dpd=?, dat_csg_dpi=?, nom_rsp_csg_dpi=?, eft_csg_sch_dpi=?, qta_csg=?, tpl_csg=?, cod_lot_dpi=?, cod_tpl_dpi=?, cod_azl=? WHERE cod_csg_dpi=?");
			ps.setLong(1, lCOD_DPD);
			ps.setDate(2, dtDAT_CSG_DPI);
			ps.setString(3, strNOM_RSP_CSG_DPI);
			ps.setString(4, strEFT_CSG_SCH_DPI);
			ps.setLong(5, lQTA_CSG);
			ps.setString(6, strTPL_CSG);
			ps.setLong(7, lCOD_LOT_DPI);
			ps.setLong(8, lCOD_TPL_DPI);
			ps.setLong(9, lCOD_AZL);
			ps.setLong(10, lCOD_CSG_DPI);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteConsegneDPI with ID="+lCOD_CSG_DPI+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_CSG_DPI(){
		return lCOD_CSG_DPI;
	}

	public long getCOD_DPD(){
		return lCOD_DPD;
	}

	public void setCOD_DPD(long lCOD_DPD){
		if(this.lCOD_DPD==lCOD_DPD) return;
		this.lCOD_DPD=lCOD_DPD;
		setModified();
	}

	public java.sql.Date getDAT_CSG_DPI(){
		return dtDAT_CSG_DPI;
	}

	public void setDAT_CSG_DPI(java.sql.Date dtDAT_CSG_DPI){
		if(this.dtDAT_CSG_DPI==dtDAT_CSG_DPI) return;
		this.dtDAT_CSG_DPI=dtDAT_CSG_DPI;
		setModified();
	}

	public String getNOM_RSP_CSG_DPI(){
		return strNOM_RSP_CSG_DPI;
	}

	public void setNOM_RSP_CSG_DPI(String strNOM_RSP_CSG_DPI){
		if(  (this.strNOM_RSP_CSG_DPI!=null) && (this.strNOM_RSP_CSG_DPI.equals(strNOM_RSP_CSG_DPI))  ) return;
		this.strNOM_RSP_CSG_DPI=strNOM_RSP_CSG_DPI;
		setModified();
	}

	public String getEFT_CSG_SCH_DPI(){
		return strEFT_CSG_SCH_DPI;
	}

	public void setEFT_CSG_SCH_DPI(String strEFT_CSG_SCH_DPI){
		if(  (this.strEFT_CSG_SCH_DPI!=null) && (this.strEFT_CSG_SCH_DPI.equals(strEFT_CSG_SCH_DPI))  ) return;
		this.strEFT_CSG_SCH_DPI=strEFT_CSG_SCH_DPI;
		setModified();
	}

	public long getQTA_CSG(){
		return lQTA_CSG;
	}

	public void setQTA_CSG(long lQTA_CSG){
		if(this.lQTA_CSG==lQTA_CSG) return;
		this.lQTA_CSG=lQTA_CSG;
		setModified();
	}

	public String getTPL_CSG(){
		return strTPL_CSG;
	}

	public void setTPL_CSG(String strTPL_CSG){
		if(  (this.strTPL_CSG!=null) && (this.strTPL_CSG.equals(strTPL_CSG))  ) return;
		this.strTPL_CSG=strTPL_CSG;
		setModified();
	}

	public long getCOD_LOT_DPI(){
		return lCOD_LOT_DPI;
	}

	public void setCOD_LOT_DPI(long lCOD_LOT_DPI){
		if(this.lCOD_LOT_DPI==lCOD_LOT_DPI) return;
		this.lCOD_LOT_DPI=lCOD_LOT_DPI;
		setModified();
	}

	public long getCOD_TPL_DPI(){
		return lCOD_TPL_DPI;
	}

	public void setCOD_TPL_DPI(long lCOD_TPL_DPI){
		if(this.lCOD_TPL_DPI==lCOD_TPL_DPI) return;
		this.lCOD_TPL_DPI=lCOD_TPL_DPI;
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


  //</setter-getters>

  public Collection ejbGetDipendenti_DPI_View(long COD_DPD){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT dpi_dpd_tab.cod_csg_dpi, tpl_dpi_tab.nom_tpl_dpi, dpi_dpd_tab.qta_csg, dpi_dpd_tab.dat_csg_dpi FROM tpl_dpi_tab, dpi_dpd_tab WHERE tpl_dpi_tab.cod_tpl_dpi=dpi_dpd_tab.cod_tpl_dpi AND dpi_dpd_tab.cod_dpd=? order by tpl_dpi_tab.nom_tpl_dpi");
          ps.setLong(1, COD_DPD);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendenti_DPI_View obj=new Dipendenti_DPI_View();
			obj.COD_CSG_DPI=rs.getLong(1);
			obj.NOM_TPL_DPI=rs.getString(2);
			obj.QTA_CSG=rs.getLong(3);
			obj.DAT_CSG_DPI=rs.getDate(4);
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
  
  public  Collection ejbGetResponsabileDPI_View(long lCOD_DPD){
	 BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("select a.nom_rsp_csg_dpi, a.dat_csg_dpi ,  c.nom_tpl_dpi from dpi_dpd_tab a, ana_lot_dpi_tab b, tpl_dpi_tab c where  a.cod_dpd = ? and     a.cod_lot_dpi = b.cod_lot_dpi and  b.cod_tpl_dpi = c.cod_tpl_dpi");
          ps.setLong(1, lCOD_DPD);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendenti_DPI_View obj=new Dipendenti_DPI_View();
			obj.NOM_RSP_CSG_DPI = rs.getString(1);
			obj.DAT_CSG_DPI=rs.getDate(2);
			obj.NOM_TPL_DPI=rs.getString(3);
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
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(DipendenteConsegneDPIBean.BEAN_NAME, new DipendenteConsegneDPIBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
