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
<file>
  <versions>
    <version number="1.0" date="21/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="215/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>

<%!
public class TitoliStudioBean extends BMPEntityBean implements ITitoliStudio, ITitoliStudioHome
{
  //<member-varibles description="Member Variables">
	long lCOD_TIT_STU_SPC;
	String strNOM_TIT_STU_SPC;
	String strDES_TIT_STU_SPC;
	String strTLP_TIT_STU_SPC;
	long lCOD_DPD;
	long lCOD_AZL;
  //</member-varibles>

 //<ITitoliStudioHome-implementation>
    public static final String BEAN_NAME="TitoliStudioBean";
	//
    public TitoliStudioBean(){}
	//
    public void remove(Object primaryKey){
            TitoliStudioBean bean=new TitoliStudioBean();
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
	//
    public ITitoliStudio create(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
         TitoliStudioBean bean=new TitoliStudioBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_TIT_STU_SPC, strDES_TIT_STU_SPC, strTLP_TIT_STU_SPC, lCOD_DPD, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strNOM_TIT_STU_SPC, strDES_TIT_STU_SPC, strTLP_TIT_STU_SPC, lCOD_DPD, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }
	//
    public ITitoliStudio findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      TitoliStudioBean bean=new TitoliStudioBean();
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
	//
    public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
	//
	public Collection getDipendente_TitoliStudio_View(long lCOD_DPD){
		return (new TitoliStudioBean()).ejbGetDipendente_TitoliStudio_View(lCOD_DPD);
	  }
	  public Collection getTitoliStudio_View(long lCOD_AZL){
		return (new TitoliStudioBean()).ejbGetTitoliStudio_View(lCOD_AZL);
	  }
 //

  public Long ejbCreate(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL)
  {
	this.lCOD_TIT_STU_SPC= NEW_ID();
	this.strNOM_TIT_STU_SPC=strNOM_TIT_STU_SPC;
	this.strDES_TIT_STU_SPC=strDES_TIT_STU_SPC;
	this.strTLP_TIT_STU_SPC=strTLP_TIT_STU_SPC;
	this.lCOD_DPD=lCOD_DPD;
	this.lCOD_AZL=lCOD_AZL;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{
		PreparedStatement ps=bmp.prepareStatement("INSERT INTO tit_stu_spc_tab (cod_tit_stu_spc,nom_tit_stu_spc,des_tit_stu_spc,tlp_tit_stu_spc,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?)");
			ps.setLong(1, lCOD_TIT_STU_SPC);
			ps.setString(2, strNOM_TIT_STU_SPC);
			ps.setString(3, strDES_TIT_STU_SPC);
			ps.setString(4, strTLP_TIT_STU_SPC);
			ps.setLong(5, lCOD_DPD);
			ps.setLong(6, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_TIT_STU_SPC);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL) { }
  //
  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tit_stu_spc FROM tit_stu_spc_tab");
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
//
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_TIT_STU_SPC=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_TIT_STU_SPC=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_tit_stu_spc,nom_tit_stu_spc,des_tit_stu_spc,tlp_tit_stu_spc,cod_dpd,cod_azl FROM tit_stu_spc_tab WHERE cod_tit_stu_spc=?");
           ps.setLong(1, lCOD_TIT_STU_SPC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
       		lCOD_TIT_STU_SPC=rs.getLong(1);
			strNOM_TIT_STU_SPC=rs.getString(2);
			strDES_TIT_STU_SPC=rs.getString(3);
			strTLP_TIT_STU_SPC=rs.getString(4);
			lCOD_DPD=rs.getLong(5);
			lCOD_AZL=rs.getLong(6);
           }
           else{
              throw new NoSuchEntityException("TitoliStudio with ID="+lCOD_TIT_STU_SPC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM tit_stu_spc_tab WHERE cod_tit_stu_spc=?");
         ps.setLong(1, lCOD_TIT_STU_SPC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TitoliStudio with ID="+lCOD_TIT_STU_SPC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE tit_stu_spc_tab SET nom_tit_stu_spc=?, des_tit_stu_spc=?, tlp_tit_stu_spc=?, cod_dpd=?, cod_azl=? WHERE cod_tit_stu_spc=?");
			ps.setString(1, strNOM_TIT_STU_SPC);
			ps.setString(2, strDES_TIT_STU_SPC);
			ps.setString(3, strTLP_TIT_STU_SPC);
			ps.setLong(4, lCOD_DPD);
			ps.setLong(5, lCOD_AZL);
			ps.setLong(6, lCOD_TIT_STU_SPC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("TitoliStudio with ID="+lCOD_TIT_STU_SPC+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>

	public long getCOD_TIT_STU_SPC(){
		return lCOD_TIT_STU_SPC;
	}

	public String getNOM_TIT_STU_SPC(){
		return strNOM_TIT_STU_SPC;
	}

	public void setNOM_TIT_STU_SPC(String strNOM_TIT_STU_SPC){
		if(  (this.strNOM_TIT_STU_SPC!=null) && (this.strNOM_TIT_STU_SPC.equals(strNOM_TIT_STU_SPC))  ) return;
		this.strNOM_TIT_STU_SPC=strNOM_TIT_STU_SPC;
		setModified();
	}

	public String getDES_TIT_STU_SPC(){
		return strDES_TIT_STU_SPC;
	}

	public void setDES_TIT_STU_SPC(String strDES_TIT_STU_SPC){
		if(  (this.strDES_TIT_STU_SPC!=null) && (this.strDES_TIT_STU_SPC.equals(strDES_TIT_STU_SPC))  ) return;
		this.strDES_TIT_STU_SPC=strDES_TIT_STU_SPC;
		setModified();
	}

	public String getTLP_TIT_STU_SPC(){
		return strTLP_TIT_STU_SPC;
	}

	public void setTLP_TIT_STU_SPC(String strTLP_TIT_STU_SPC){
		if(  (this.strTLP_TIT_STU_SPC!=null) && (this.strTLP_TIT_STU_SPC.equals(strTLP_TIT_STU_SPC))  ) return;
		this.strTLP_TIT_STU_SPC=strTLP_TIT_STU_SPC;
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

   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetDipendente_TitoliStudio_View(long lCOD_DPD){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tit_stu_spc,nom_tit_stu_spc,tlp_tit_stu_spc,cod_dpd,cod_azl FROM tit_stu_spc_tab WHERE cod_dpd=? order by nom_tit_stu_spc");
		  ps.setLong(1, lCOD_DPD);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Dipendente_TitoliStudio_View obj=new Dipendente_TitoliStudio_View();
            obj.COD_TIT_STU_SPC=rs.getLong(1);
            obj.NOM_TIT_STU_SPC=rs.getString(2);
            obj.TLP_TIT_STU_SPC=rs.getString(3);
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
  //--------------------------------------------------------
   public Collection ejbGetTitoliStudio_View(long lCOD_AZL){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tit_stu_spc,nom_tit_stu_spc, des_tit_stu_spc FROM tit_stu_spc_tab WHERE cod_azl=? ORDER BY nom_tit_stu_spc");
		  ps.setLong(1, lCOD_AZL);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TitoliStudio_View obj=new TitoliStudio_View();
            obj.COD_TIT_STU_SPC=rs.getLong(1);
            obj.NOM_TIT_STU_SPC=rs.getString(2);
            obj.DES_TIT_STU_SPC=rs.getString(3);
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
}//--------------------------------------------------------------------
%>
<%
//////////////////////////////////////////  ///////////////////////////
PseudoContext.bind(TitoliStudioBean.BEAN_NAME, new TitoliStudioBean());
//////////////////////////////////////////  ///////////////////////////
%>
