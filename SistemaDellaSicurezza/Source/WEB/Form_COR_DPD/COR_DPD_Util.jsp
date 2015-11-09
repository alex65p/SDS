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

public Collection ejbGetDipendente_CORCOM_View(){
       BMPConnection bmp=getConnection();
       try{
          PreparedStatement ps=bmp.prepareStatement("SELECT  cod_cor,nom_cor,des_cor FROM ana_cor_tab ");
         ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendente_CORCOM_View obj=new Dipendente_CORCOM_View();
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
	
public Collection ejbGetDipendente_CORDPD_View(long DPD_ID, long COR_ID, long AZL_ID){
       BMPConnection bmp=getConnection();
       try{
          PreparedStatement ps=bmp.prepareStatement("SELECT  mat_csg,dat_csg_mat,esi_tes_vrf,dat_eft_tes_vrf,ptg_ott_dpd,ate_fre_dpd,dat_eft_cor FROM cor_dpd_tab WHERE cod_dpd=?, cod_azl=?, cod_cor=? ");
         ps.setLong(1, DPD_ID);
				 ps.setLong(2, AZL_ID);
				 ps.setLong(3, COR_ID);
				 ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendente_CORCOM_View obj=new Dipendente_CORCOM_View();
            obj.MAT_CSG=rs.getString(1);
            obj.DAT_CSG_MAT=rs.getDate(2);
            obj.ESI_TES_VRF=rs.getString(3);
						obj.DAT_EFT_TES_VRF=rs.getDate(4);	
						obj.PTG_OTT_DPD=rs.getLong(5);
						obj.ATE_FRE_DPD=rs.getString(6);	
						obj.DAT_EFT_COR=rs.getDate(7);
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
	
	
	
	
	
		//Kushkarov for COR_DPD
	/*public String getMAT_CSG(long COR_ID);
	public java.sql.Date getDAT_CSG_MAT(long COR_ID);
	public String getESI_TES_VRF(long COR_ID);
	public java.sql.Date getDAT_EFT_TES_VRF(long COR_ID);
	public long getPTG_OTT_DPD(long COR_ID);
	public String getATE_FRE_DPD(long COR_ID);
  public java.sql.Date getDAT_EFT_COR(long COR_ID);*/
	
	
	
	/*		public String getMAT_CSG(long COR_ID)
	{
		String MAT_CSG = "";
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT mat_csg FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				MAT_CSG = rs.getString(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return MAT_CSG;
	}
	
	public java.sql.Date getDAT_CSG_MAT(long COR_ID)
	{
		java.sql.Date DAT_CSG_MAT = null;
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT dat_csg_mat FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				DAT_CSG_MAT = rs.getDate(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return DAT_CSG_MAT;
	}
	
		public String getESI_TES_VRF(long COR_ID)
	{
		String ESI_TES_VRF = "";
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT esi_tes_vrf FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				ESI_TES_VRF = rs.getString(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return ESI_TES_VRF;
	}
	
	public java.sql.Date getDAT_EFT_TES_VRF(long COR_ID)
	{
		java.sql.Date DAT_EFT_TES_VRF = null;
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT dat_eft_tes_vrf FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				DAT_EFT_TES_VRF = rs.getDate(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return DAT_EFT_TES_VRF;
	}
	
	public long getPTG_OTT_DPD(long COR_ID)
	{
		long PTG_OTT_DPD = 0;
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT ptg_ott_dpd FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				PTG_OTT_DPD = rs.getLong(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return PTG_OTT_DPD;
	}
	
	public String getATE_FRE_DPD(long COR_ID)
	{
		String ATE_FRE_DPD = "";
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT ate_fre_dpd FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				ATE_FRE_DPD = rs.getString(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return ATE_FRE_DPD;
	}

	public java.sql.Date getDAT_EFT_COR(long COR_ID)
	{
		java.sql.Date DAT_EFT_COR = null;
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT dat_eft_cor FROM cor_dpd_tab WHERE cod_azl=? AND cod_dpd=? AND cod_cor=?");
			ps.setLong(1, COD_AZL);
			ps.setLong(2, COD_DPD);
			ps.setLong(3, COR_ID);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{
				DAT_EFT_COR = rs.getDate(1);
			}
			bmp.close();
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
		return DAT_EFT_COR;
	}*/
	
	
	public Collection ejbGetDipendente_CORCOM_View(){
       BMPConnection bmp=getConnection();
       try{
          PreparedStatement ps=bmp.prepareStatement("SELECT  cod_cor,nom_cor,des_cor FROM ana_cor_tab ");
         ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendente_CORCOM_View obj=new Dipendente_CORCOM_View();
            obj.COD_COR=rs.getLong(1);
            obj.NOM_COR=rs.getString(2);
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
	
		
	public Collection getDipendente_CORCOM_View()
  {
  	return (new  DipendenteBean()).ejbGetDipendente_CORCOM_View();
  }
	
		 public  Collection getDipendente_CORCOM_View();
		 
		 
		 
		 
class Dipendente_CORCOM_View implements java.io.Serializable{
	public long COD_COR;
	public String NOM_COR;
}
