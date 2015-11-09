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
public class InfortuniIncidentiBean extends BMPEntityBean implements IInfortuniIncidenti, IInfortuniIncidentiHome

{
  //<member-varibles description="Member Variables">
	long lCOD_INO;
	String strNOM_COM_INO;
	java.sql.Date dtDAT_COM_INO;
	java.sql.Date dtDAT_EVE_INO;
	String strORA_EVE_INO;
	String strGOR_LAV_INO;
	String strORA_LAV_INO;
	String strORA_LAV_TUN_INO;
	String strTPL_TRA_EVE_INO;
	String strIDZ_TRA_EVE_INO;
	java.sql.Date dtDAT_TRA_EVE_INO;
	java.sql.Date dtDAT_INZ_ASZ_LAV;
	java.sql.Date dtDAT_FIE_ASZ_LAV;
	long lGOR_ASZ;
	String strDES_EVE_INO;
	String strDES_ANL_INO;
	String strDES_CRZ_INO;
	String strDES_RAC_INO;
	String strDES_DVU_INO;
	long lCOD_AGE_MAT;
	long lCOD_TPL_FRM_INO;
	long lCOD_NAT_LES;
	long lCOD_SED_LES;
	long lCOD_LUO_FSC;
	long lCOD_DPD;
	long lCOD_AZL;
  //</member-varibles>

 //<IInfortuniIncidentiHome-implementation>

      public static final String BEAN_NAME="InfortuniIncidentiBean";
      
      public InfortuniIncidentiBean(){}

      public void remove(Object primaryKey){
            InfortuniIncidentiBean bean=new InfortuniIncidentiBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
							ex.printStackTrace(System.err);
              throw new EJBException(ex.getMessage());
            }
      }

      public IInfortuniIncidenti create(long lCOD_AGE_MAT, long lCOD_TPL_FRM_INO, long lCOD_NAT_LES, long lCOD_SED_LES, long lCOD_LUO_FSC, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
         InfortuniIncidentiBean bean=new InfortuniIncidentiBean();
             try{
              Object primaryKey=bean.ejbCreate(  lCOD_AGE_MAT, lCOD_TPL_FRM_INO, lCOD_NAT_LES, lCOD_SED_LES, lCOD_LUO_FSC, lCOD_DPD, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  lCOD_AGE_MAT, lCOD_TPL_FRM_INO, lCOD_NAT_LES, lCOD_SED_LES, lCOD_LUO_FSC, lCOD_DPD, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
							ex.printStackTrace(System.err);
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IInfortuniIncidenti findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      InfortuniIncidentiBean bean=new InfortuniIncidentiBean();
			try{
					bean.setEntityContext(new EntityContextWrapper(primaryKey));
					bean.ejbActivate();
					bean.ejbLoad();
					return bean;
			}
           catch(Exception ex){
						ex.printStackTrace(System.err);
              throw new javax.ejb.FinderException(ex.getMessage());
            }
      }
      
      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				ex.printStackTrace(System.err);
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
	  public	Collection getInfortuniIncidenti_View(long lCOD_AZL){
			return (new InfortuniIncidentiBean()).ejbGetInfortuniIncidenti_View(lCOD_AZL);
	  }
	  
		public	Collection findEx(long lCOD_AZL, long COD_LUO_FSC, long COD_DPD, long COD_NAT_LES,long COD_AGE_MAT,long COD_TPL_FRM_INO,long COD_SED_LES)
		{
		  return (new InfortuniIncidentiBean()).ejbfindEx(lCOD_AZL, COD_LUO_FSC, COD_DPD, COD_NAT_LES,COD_AGE_MAT,COD_TPL_FRM_INO,COD_SED_LES);
		}
  
//<report>
	 public SchedaInfortunioIncidenteView getSchedaInfortunioIncidenteView(long lCOD_AZL, long lCOD_INO){
			return (new InfortuniIncidentiBean()).ejbGetISchedaInfortunioIncidenteView(lCOD_AZL, lCOD_INO);
	 }
	 public Collection getElencoInfortuniIncidentiView(long lCOD_AZL, String strDAT_DAL, String strDAT_AL){
			return (new InfortuniIncidentiBean()).ejbGetElencoInfortuniIncidentiView( lCOD_AZL, strDAT_DAL, strDAT_AL);
	 }
	 
  public Long ejbCreate(long lCOD_AGE_MAT, long lCOD_TPL_FRM_INO, long lCOD_NAT_LES, long lCOD_SED_LES, long lCOD_LUO_FSC, long lCOD_DPD, long lCOD_AZL)
  {
	this.lCOD_INO= NEW_ID();
	this.lCOD_AGE_MAT=lCOD_AGE_MAT;
	this.lCOD_TPL_FRM_INO=lCOD_TPL_FRM_INO;
	this.lCOD_NAT_LES=lCOD_NAT_LES;
	this.lCOD_SED_LES=lCOD_SED_LES;
	this.lCOD_LUO_FSC=lCOD_LUO_FSC;
	this.lCOD_DPD=lCOD_DPD;
	this.lCOD_AZL=lCOD_AZL;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_ino_tab (cod_ino,cod_age_mat,cod_tpl_frm_ino,cod_nat_les,cod_sed_les,cod_luo_fsc,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?,?,?)");
			ps.setLong(1, lCOD_INO);
			ps.setLong(2, lCOD_AGE_MAT);
			ps.setLong(3, lCOD_TPL_FRM_INO);
			ps.setLong(4, lCOD_NAT_LES);
			ps.setLong(5, lCOD_SED_LES);
			ps.setLong(6, lCOD_LUO_FSC);
			ps.setLong(7, lCOD_DPD);
			ps.setLong(8, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_INO);
	}
	catch(Exception ex){
		ex.printStackTrace(System.err);
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lCOD_AGE_MAT, long lCOD_TPL_FRM_INO, long lCOD_NAT_LES, long lCOD_SED_LES, long lCOD_LUO_FSC, long lCOD_DPD, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_ino FROM ana_ino_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
          }
          return al;
      }
      catch(Exception ex){
					ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_INO=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_INO=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_ino,nom_com_ino,dat_com_ino,dat_eve_ino,ora_eve_ino,gor_lav_ino,ora_lav_ino,ora_lav_tun_ino,tpl_tra_eve_ino,idz_tra_eve_ino,dat_tra_eve_ino,dat_inz_asz_lav,dat_fie_asz_lav,gor_asz,des_eve_ino,des_anl_ino,des_crz_ino,des_rac_ino,des_dvu_ino,cod_age_mat,cod_tpl_frm_ino,cod_nat_les,cod_sed_les,cod_luo_fsc,cod_dpd,cod_azl FROM ana_ino_tab WHERE cod_ino=?");
           ps.setLong(1, lCOD_INO);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_INO=rs.getLong(1);
			strNOM_COM_INO=rs.getString(2);
			dtDAT_COM_INO=rs.getDate(3);
			dtDAT_EVE_INO=rs.getDate(4);
			strORA_EVE_INO=rs.getString(5);
			strGOR_LAV_INO=rs.getString(6);
			strORA_LAV_INO=rs.getString(7);
			strORA_LAV_TUN_INO=rs.getString(8);
			strTPL_TRA_EVE_INO=rs.getString(9);
			strIDZ_TRA_EVE_INO=rs.getString(10);
			dtDAT_TRA_EVE_INO=rs.getDate(11);
			dtDAT_INZ_ASZ_LAV=rs.getDate(12);
			dtDAT_FIE_ASZ_LAV=rs.getDate(13);
			lGOR_ASZ=rs.getLong(14);
			strDES_EVE_INO=rs.getString(15);
			strDES_ANL_INO=rs.getString(16);
			strDES_CRZ_INO=rs.getString(17);
			strDES_RAC_INO=rs.getString(18);
			strDES_DVU_INO=rs.getString(19);
			lCOD_AGE_MAT=rs.getLong(20);
			lCOD_TPL_FRM_INO=rs.getLong(21);
			lCOD_NAT_LES=rs.getLong(22);
			lCOD_SED_LES=rs.getLong(23);
			lCOD_LUO_FSC=rs.getLong(24);
			lCOD_DPD=rs.getLong(25);
			lCOD_AZL=rs.getLong(26);
           }
           else{
              throw new NoSuchEntityException("InfortuniIncidenti with ID="+lCOD_INO+" not found");
           }
      }
      catch(Exception ex){
				ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_ino_tab WHERE cod_ino=?");
         ps.setLong(1, lCOD_INO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("InfortuniIncidenti with ID="+lCOD_INO+" not found");
      }
      catch(Exception ex){
				ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_ino_tab SET nom_com_ino=?, dat_com_ino=?, dat_eve_ino=?, ora_eve_ino=?, gor_lav_ino=?, ora_lav_ino=?, ora_lav_tun_ino=?, tpl_tra_eve_ino=?, idz_tra_eve_ino=?, dat_tra_eve_ino=?, dat_inz_asz_lav=?, dat_fie_asz_lav=?, gor_asz=?, des_eve_ino=?, des_anl_ino=?, des_crz_ino=?, des_rac_ino=?, des_dvu_ino=?, cod_age_mat=?, cod_tpl_frm_ino=?, cod_nat_les=?, cod_sed_les=?, cod_luo_fsc=?, cod_dpd=?, cod_azl=? WHERE cod_ino=?");
			ps.setString(1, strNOM_COM_INO);
			ps.setDate(2, dtDAT_COM_INO);
			ps.setDate(3, dtDAT_EVE_INO);
			ps.setString(4, strORA_EVE_INO);
			ps.setString(5, strGOR_LAV_INO);
			ps.setString(6, strORA_LAV_INO);
			ps.setString(7, strORA_LAV_TUN_INO);
			ps.setString(8, strTPL_TRA_EVE_INO);
			ps.setString(9, strIDZ_TRA_EVE_INO);
			ps.setDate(10, dtDAT_TRA_EVE_INO);
			ps.setDate(11, dtDAT_INZ_ASZ_LAV);
			ps.setDate(12, dtDAT_FIE_ASZ_LAV);
			if(lGOR_ASZ==0) ps.setNull(13,java.sql.Types.BIGINT); else ps.setLong(13, lGOR_ASZ);
			ps.setString(14, strDES_EVE_INO);
			ps.setString(15, strDES_ANL_INO);
			ps.setString(16, strDES_CRZ_INO);
			ps.setString(17, strDES_RAC_INO);
			ps.setString(18, strDES_DVU_INO);
			ps.setLong(19, lCOD_AGE_MAT);
			ps.setLong(20, lCOD_TPL_FRM_INO);
			ps.setLong(21, lCOD_NAT_LES);
			ps.setLong(22, lCOD_SED_LES);
			ps.setLong(23, lCOD_LUO_FSC);
			ps.setLong(24, lCOD_DPD);
			ps.setLong(25, lCOD_AZL);
			ps.setLong(26, lCOD_INO);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("InfortuniIncidenti with ID="+lCOD_INO+" not found");
      }
      catch(Exception ex){
				ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_INO(){
		return lCOD_INO;
	}

	public String getNOM_COM_INO(){
		return strNOM_COM_INO;
	}

	public void setNOM_COM_INO(String strNOM_COM_INO){
		if(  (this.strNOM_COM_INO!=null) && (this.strNOM_COM_INO.equals(strNOM_COM_INO))  ) return;
		this.strNOM_COM_INO=strNOM_COM_INO;
		setModified();
	}

	public java.sql.Date getDAT_COM_INO(){
		return dtDAT_COM_INO;
	}

	public void setDAT_COM_INO(java.sql.Date dtDAT_COM_INO){
		if(this.dtDAT_COM_INO==dtDAT_COM_INO) return;
		this.dtDAT_COM_INO=dtDAT_COM_INO;
		setModified();
	}

	public java.sql.Date getDAT_EVE_INO(){
		return dtDAT_EVE_INO;
	}

	public void setDAT_EVE_INO(java.sql.Date dtDAT_EVE_INO){
		if(this.dtDAT_EVE_INO==dtDAT_EVE_INO) return;
		this.dtDAT_EVE_INO=dtDAT_EVE_INO;
		setModified();
	}

	public String getORA_EVE_INO(){
		return strORA_EVE_INO;
	}

	public void setORA_EVE_INO(String strORA_EVE_INO){
		if(  (this.strORA_EVE_INO!=null) && (this.strORA_EVE_INO.equals(strORA_EVE_INO))  ) return;
		this.strORA_EVE_INO=strORA_EVE_INO;
		setModified();
	}

	public String getGOR_LAV_INO(){
		return strGOR_LAV_INO;
	}

	public void setGOR_LAV_INO(String strGOR_LAV_INO){
		if(  (this.strGOR_LAV_INO!=null) && (this.strGOR_LAV_INO.equals(strGOR_LAV_INO))  ) return;
		this.strGOR_LAV_INO=strGOR_LAV_INO;
		setModified();
	}

	public String getORA_LAV_INO(){
		return strORA_LAV_INO;
	}

	public void setORA_LAV_INO(String strORA_LAV_INO){
		if(  (this.strORA_LAV_INO!=null) && (this.strORA_LAV_INO.equals(strORA_LAV_INO))  ) return;
		this.strORA_LAV_INO=strORA_LAV_INO;
		setModified();
	}

	public String getORA_LAV_TUN_INO(){
		return strORA_LAV_TUN_INO;
	}

	public void setORA_LAV_TUN_INO(String strORA_LAV_TUN_INO){
		if(  (this.strORA_LAV_TUN_INO!=null) && (this.strORA_LAV_TUN_INO.equals(strORA_LAV_TUN_INO))  ) return;
		this.strORA_LAV_TUN_INO=strORA_LAV_TUN_INO;
		setModified();
	}

	public String getTPL_TRA_EVE_INO(){
		return strTPL_TRA_EVE_INO;
	}

	public void setTPL_TRA_EVE_INO(String strTPL_TRA_EVE_INO){
		if(  (this.strTPL_TRA_EVE_INO!=null) && (this.strTPL_TRA_EVE_INO.equals(strTPL_TRA_EVE_INO))  ) return;
		this.strTPL_TRA_EVE_INO=strTPL_TRA_EVE_INO;
		setModified();
	}

	public String getIDZ_TRA_EVE_INO(){
		return strIDZ_TRA_EVE_INO;
	}

	public void setIDZ_TRA_EVE_INO(String strIDZ_TRA_EVE_INO){
		if(  (this.strIDZ_TRA_EVE_INO!=null) && (this.strIDZ_TRA_EVE_INO.equals(strIDZ_TRA_EVE_INO))  ) return;
		this.strIDZ_TRA_EVE_INO=strIDZ_TRA_EVE_INO;
		setModified();
	}

	public java.sql.Date getDAT_TRA_EVE_INO(){
		return dtDAT_TRA_EVE_INO;
	}

	public void setDAT_TRA_EVE_INO(java.sql.Date dtDAT_TRA_EVE_INO){
		if(this.dtDAT_TRA_EVE_INO==dtDAT_TRA_EVE_INO) return;
		this.dtDAT_TRA_EVE_INO=dtDAT_TRA_EVE_INO;
		setModified();
	}

	public java.sql.Date getDAT_INZ_ASZ_LAV(){
		return dtDAT_INZ_ASZ_LAV;
	}

	public void setDAT_INZ_ASZ_LAV(java.sql.Date dtDAT_INZ_ASZ_LAV){
		if(this.dtDAT_INZ_ASZ_LAV==dtDAT_INZ_ASZ_LAV) return;
		this.dtDAT_INZ_ASZ_LAV=dtDAT_INZ_ASZ_LAV;
		setModified();
	}

	public java.sql.Date getDAT_FIE_ASZ_LAV(){
		return dtDAT_FIE_ASZ_LAV;
	}

	public void setDAT_FIE_ASZ_LAV(java.sql.Date dtDAT_FIE_ASZ_LAV){
		if(this.dtDAT_FIE_ASZ_LAV==dtDAT_FIE_ASZ_LAV) return;
		this.dtDAT_FIE_ASZ_LAV=dtDAT_FIE_ASZ_LAV;
		setModified();
	}

	public long getGOR_ASZ(){
		return lGOR_ASZ;
	}

	public void setGOR_ASZ(long lGOR_ASZ){
		if(this.lGOR_ASZ==lGOR_ASZ) return;
		this.lGOR_ASZ=lGOR_ASZ;
		setModified();
	}

	public String getDES_EVE_INO(){
		return strDES_EVE_INO;
	}

	public void setDES_EVE_INO(String strDES_EVE_INO){
		if(  (this.strDES_EVE_INO!=null) && (this.strDES_EVE_INO.equals(strDES_EVE_INO))  ) return;
		this.strDES_EVE_INO=strDES_EVE_INO;
		setModified();
	}

	public String getDES_ANL_INO(){
		return strDES_ANL_INO;
	}

	public void setDES_ANL_INO(String strDES_ANL_INO){
		if(  (this.strDES_ANL_INO!=null) && (this.strDES_ANL_INO.equals(strDES_ANL_INO))  ) return;
		this.strDES_ANL_INO=strDES_ANL_INO;
		setModified();
	}

	public String getDES_CRZ_INO(){
		return strDES_CRZ_INO;
	}

	public void setDES_CRZ_INO(String strDES_CRZ_INO){
		if(  (this.strDES_CRZ_INO!=null) && (this.strDES_CRZ_INO.equals(strDES_CRZ_INO))  ) return;
		this.strDES_CRZ_INO=strDES_CRZ_INO;
		setModified();
	}

	public String getDES_RAC_INO(){
		return strDES_RAC_INO;
	}

	public void setDES_RAC_INO(String strDES_RAC_INO){
		if(  (this.strDES_RAC_INO!=null) && (this.strDES_RAC_INO.equals(strDES_RAC_INO))  ) return;
		this.strDES_RAC_INO=strDES_RAC_INO;
		setModified();
	}

	public String getDES_DVU_INO(){
		return strDES_DVU_INO;
	}

	public void setDES_DVU_INO(String strDES_DVU_INO){
		if(  (this.strDES_DVU_INO!=null) && (this.strDES_DVU_INO.equals(strDES_DVU_INO))  ) return;
		this.strDES_DVU_INO=strDES_DVU_INO;
		setModified();
	}

	public long getCOD_AGE_MAT(){
		return lCOD_AGE_MAT;
	}

	public void setCOD_AGE_MAT(long lCOD_AGE_MAT){
		if(this.lCOD_AGE_MAT==lCOD_AGE_MAT) return;
		this.lCOD_AGE_MAT=lCOD_AGE_MAT;
		setModified();
	}

	public long getCOD_TPL_FRM_INO(){
		return lCOD_TPL_FRM_INO;
	}

	public void setCOD_TPL_FRM_INO(long lCOD_TPL_FRM_INO){
		if(this.lCOD_TPL_FRM_INO==lCOD_TPL_FRM_INO) return;
		this.lCOD_TPL_FRM_INO=lCOD_TPL_FRM_INO;
		setModified();
	}

	public long getCOD_NAT_LES(){
		return lCOD_NAT_LES;
	}

	public void setCOD_NAT_LES(long lCOD_NAT_LES){
		if(this.lCOD_NAT_LES==lCOD_NAT_LES) return;
		this.lCOD_NAT_LES=lCOD_NAT_LES;
		setModified();
	}

	public long getCOD_SED_LES(){
		return lCOD_SED_LES;
	}

	public void setCOD_SED_LES(long lCOD_SED_LES){
		if(this.lCOD_SED_LES==lCOD_SED_LES) return;
		this.lCOD_SED_LES=lCOD_SED_LES;
		setModified();
	}

	public long getCOD_LUO_FSC(){
		return lCOD_LUO_FSC;
	}

	public void setCOD_LUO_FSC(long lCOD_LUO_FSC){
		if(this.lCOD_LUO_FSC==lCOD_LUO_FSC) return;
		this.lCOD_LUO_FSC=lCOD_LUO_FSC;
		setModified();
	}

	public long getCOD_DPD(){
		return lCOD_DPD;
	}

	public void setCOD_DPD(long lCOD_DPD){
		if(this.lCOD_DPD==lCOD_DPD) return;
		this.lCOD_DPD=lCOD_DPD;
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
	public	Collection ejbGetInfortuniIncidenti_View(long lCOD_AZL)
	{
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT b.cod_ino, b.nom_com_ino, b.dat_com_ino, b.dat_eve_ino, c.cog_dpd, c.nom_dpd FROM ana_ino_tab b, view_ana_dpd_tab c WHERE b.cod_azl = ? AND b.cod_dpd = c.cod_dpd ORDER BY dat_com_ino,dat_eve_ino ");
			ps.setLong(1, lCOD_AZL);

			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				InfortuniIncidenti_View obj=new InfortuniIncidenti_View();
				obj.COD_INO = rs.getLong(1);
				obj.NOM_COM_INO = rs.getString(2);
				obj.DAT_COM_INO = rs.getDate(3);
				obj.DAT_EVE_INO = rs.getDate(4);
				obj.COG_DPD = rs.getString(5);
				obj.NOM_DPD = rs.getString(6);
				al.add(obj);
			}
			bmp.close();
			return al;
		}
		catch(Exception ex)
		{
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	}
	//<report>
	 public SchedaInfortunioIncidenteView ejbGetISchedaInfortunioIncidenteView(long lCOD_AZL,long lCOD_INO){
	 	BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement
                            ("select " +
                                "b.nom_sed_les " +
                                //",c. nom_nat_les " +
                                ",d.nom_luo_fsc " +
                                ",e.nom_tpl_frm_ino " +
                                //",f.nom_age_mat " +
                                ",a.cod_dpd " +
                             "from " +
                                "ana_ino_tab a " +
                                ",ana_sed_les_tab b " +
                                //",ana_nat_les_tab c " +
                                ",ana_luo_fsc_tab d " +
                                ",tpl_frm_ino_tab e " +
                                //",ana_age_mat_tab f " +
                             "where " +
                                "a.cod_ino =? " +
                                "and a.cod_azl = ? " +
                                "and a.cod_sed_les = b.cod_sed_les " +
                                //"and a.cod_nat_les = c.cod_nat_les " +
                                "and a.cod_luo_fsc = d.cod_luo_fsc " +
                                "and a.cod_tpl_frm_ino = e.cod_tpl_frm_ino " +
                                //"and a.cod_age_mat = f.cod_age_mat"
                                "");
			ps.setLong(2, lCOD_AZL);
			ps.setLong(1, lCOD_INO);
			ResultSet rs=ps.executeQuery();
			SchedaInfortunioIncidenteView obj=new SchedaInfortunioIncidenteView();
			if(rs.next())
			{
				/*
                                obj.strNOM_SED_LES = rs.getString(1);
				obj.strNOM_NAT_LES = rs.getString(2);
				obj.strNOM_LUO_FSC = rs.getString(3);
				obj.strNOM_TPL_FRM_INO = rs.getString(4);
				obj.strNOM_AGE_MAT = rs.getString(5);
				obj.lCOD_DPD = rs.getLong(6);
                                */
                                obj.strNOM_SED_LES = rs.getString(1);
				obj.strNOM_LUO_FSC = rs.getString(2);
				obj.strNOM_TPL_FRM_INO = rs.getString(3);
				obj.lCOD_DPD = rs.getLong(4);
			}
			bmp.close();
			return obj;
		}
		catch(Exception ex)
		{
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	 }
	 public Collection ejbGetElencoInfortuniIncidentiView(long lCOD_AZL, String strDAT_DAL, String strDAT_AL){
	 	BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement
                                ("select " +
                                    "a.nom_sed_les " +
                                    //",b.nom_nat_les " +
                                    ",c.dat_eve_ino " +
                                    ",d.nom_luo_fsc " +
                                 "from " +
                                    "ana_sed_les_tab a " +
                                    //",ana_nat_les_tab b " +
                                    ",ana_ino_tab c " +
                                    ",ana_luo_fsc_tab d " +
                                 "where " +
                                    "a.cod_sed_les = c.cod_sed_les " +
                                    //"and b.cod_nat_les = c.cod_nat_les " +
                                    "and d.cod_luo_fsc = c.cod_luo_fsc " +
                                    "and (to_char(c.dat_eve_ino,'yyyymmdd') between  ? and ? or dat_eve_ino IS NULL) " +
                                    "and c.cod_azl = ?");
			ps.setString(1, strDAT_DAL);
			ps.setString(2, strDAT_AL);
			ps.setLong(3, lCOD_AZL);
			
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				SchedaInfortunioIncidenteView obj=new SchedaInfortunioIncidenteView();
				/*
                                obj.strNOM_SED_LES = rs.getString(1);
				obj.strNOM_NAT_LES = rs.getString(2);
				obj.dtDAT_EVE_INO = rs.getDate(3);
				obj.strNOM_LUO_FSC = rs.getString(4);
                                */
                                obj.strNOM_SED_LES = rs.getString(1);
				obj.dtDAT_EVE_INO = rs.getDate(2);
				obj.strNOM_LUO_FSC = rs.getString(3);
                                al.add(obj);
			}
			bmp.close();
			return al;
		}
		catch(Exception ex)
		{
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	 }
	 
	 public Collection ejbfindEx(
                 long lCOD_AZL,
                 long COD_LUO_FSC,
                 long COD_DPD,
                 long COD_NAT_LES,
                 long COD_AGE_MAT,
                 long COD_TPL_FRM_INO,
                 long COD_SED_LES) {
                    String Sql=
                       "SELECT " +
                           "b.cod_ino, " +
                           "b.dat_com_ino, " +
                           "b.dat_eve_ino, " +
                           "c.cog_dpd, " +
                           "c.nom_dpd " +
                       "FROM " +
                           "ana_ino_tab b, " +
                           "view_ana_dpd_tab c " +
                       "WHERE " +
                           "b.cod_azl = ? " +
                       "AND " +
                           "b.cod_dpd = c.cod_dpd ";
                       
		int i=2;
		int indexLuo=0;
		if(COD_LUO_FSC!=0)
		{
		  Sql+=" AND b.cod_luo_fsc = ? ";
			indexLuo=i++;
		}
		int indexDpd=0;
		if(COD_DPD!=0)
		{
		  Sql+=" AND b.cod_dpd = ? ";
			indexDpd=i++;
		}
		int indexNatLes=0;
		if(COD_NAT_LES!=0)
		{
		  Sql+=" AND b.cod_nat_les = ? ";
			indexNatLes=i++;
		}
		int indexAge=0;
		if(COD_AGE_MAT!=0)
		{
		  Sql+=" AND b.cod_age_mat = ? ";
			indexAge=i++;
		}
		int indexFrm=0;
		if(COD_TPL_FRM_INO!=0)
		{
		  Sql+=" AND b.cod_tpl_frm_ino = ? ";
			indexFrm=i++;
		}
		int indexSed=0;
		if(COD_SED_LES!=0)
		{
		  Sql+=" AND b.cod_sed_les = ? ";
			indexSed=i++;
		}
                
                Sql+="ORDER BY " +
                           "b.dat_eve_ino, " +
                           "c.cog_dpd, " +
                           "c.nom_dpd";
                
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement(Sql);
			ps.setLong(1, lCOD_AZL);
			if(indexLuo!=0){ps.setLong(indexLuo,COD_LUO_FSC);}
			if(indexDpd!=0){ps.setLong(indexDpd,COD_DPD);}
			if(indexNatLes!=0){ps.setLong(indexNatLes,COD_NAT_LES);}
			if(indexAge!=0){ps.setLong(indexAge,COD_AGE_MAT);}
			if(indexFrm!=0){ps.setLong(indexFrm,COD_TPL_FRM_INO);}
			if(indexSed!=0){ps.setLong(indexSed,COD_SED_LES);}
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				InfortuniIncidenti_View obj=new InfortuniIncidenti_View();
				obj.COD_INO = rs.getLong(1);
				obj.DAT_COM_INO = rs.getDate(2);
				obj.DAT_EVE_INO = rs.getDate(3);
				obj.COG_DPD = rs.getString(4);
				obj.NOM_DPD = rs.getString(5);
				al.add(obj);
			}
			bmp.close();
			return al;
		}
		catch(Exception ex)
		{
			ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	 }
}
%>
<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(InfortuniIncidentiBean.BEAN_NAME, new InfortuniIncidentiBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
