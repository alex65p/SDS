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
    <version number="1.0" date="23/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="23/02/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta MansioneDittePrecedente
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
public class MansioneDittePrecedenteBean extends BMPEntityBean implements IMansioneDittePrecedente, IMansioneDittePrecedenteHome
{
  //<member-varibles description="Member Variables">
	long lCOD_MAN_DIT_PRC;
	String strNOM_MAN_DIT_PRC;
	String strDES_MAN_DIT_PRC;
	long lCOD_DIT_PRC_DPD;
	long lCOD_DPD;
	long lCOD_AZL;
  //</member-varibles>

 //<IMansioneDittePrecedenteHome-implementation>

      public static final String BEAN_NAME="MansioneDittePrecedenteBean";
      
      public MansioneDittePrecedenteBean(){}

      public void remove(Object primaryKey){
            MansioneDittePrecedenteBean bean=new MansioneDittePrecedenteBean();
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

      public IMansioneDittePrecedente create(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD, long lCOD_AZL) throws javax.ejb.CreateException {
         MansioneDittePrecedenteBean bean=new MansioneDittePrecedenteBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_MAN_DIT_PRC, lCOD_DIT_PRC_DPD, lCOD_DPD, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strNOM_MAN_DIT_PRC, lCOD_DIT_PRC_DPD, lCOD_DPD, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IMansioneDittePrecedente findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      MansioneDittePrecedenteBean bean=new MansioneDittePrecedenteBean();
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
 // (Home Intrface) 
  public Collection getMansioneDittePrecedenteByDIT_PRC_DPDID_View(long DIT_PRC_DPD_ID)
  {
  	return (new  MansioneDittePrecedenteBean()).ejbGetMansioneDittePrecedenteByDIT_PRC_DPDID_View(DIT_PRC_DPD_ID);
 }
 //

  public Long ejbCreate(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD, long lCOD_AZL)
  {
	this.lCOD_MAN_DIT_PRC= NEW_ID();
	this.strNOM_MAN_DIT_PRC=strNOM_MAN_DIT_PRC;
	this.lCOD_DIT_PRC_DPD=lCOD_DIT_PRC_DPD;
	this.lCOD_DPD=lCOD_DPD;
	this.lCOD_AZL=lCOD_AZL;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO man_dit_prc_tab (cod_man_dit_prc,nom_man_dit_prc,cod_dit_prc_dpd,cod_dpd,cod_azl) VALUES(?,?,?,?,?)");
			ps.setLong(1, lCOD_MAN_DIT_PRC);
			ps.setString(2, strNOM_MAN_DIT_PRC);
			ps.setLong(3, lCOD_DIT_PRC_DPD);
			ps.setLong(4, lCOD_DPD);
			ps.setLong(5, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_MAN_DIT_PRC);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_man_dit_prc FROM man_dit_prc_tab");
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
    this.lCOD_MAN_DIT_PRC=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_MAN_DIT_PRC=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_man_dit_prc,nom_man_dit_prc,des_man_dit_prc,cod_dit_prc_dpd,cod_dpd,cod_azl FROM man_dit_prc_tab WHERE cod_man_dit_prc=?");
           ps.setLong(1, lCOD_MAN_DIT_PRC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_MAN_DIT_PRC=rs.getLong(1);
			strNOM_MAN_DIT_PRC=rs.getString(2);
			strDES_MAN_DIT_PRC=rs.getString(3);
			lCOD_DIT_PRC_DPD=rs.getLong(4);
			lCOD_DPD=rs.getLong(5);
			lCOD_AZL=rs.getLong(6);
           }
           else{
              throw new NoSuchEntityException("MansioneDittePrecedente with ID="+lCOD_MAN_DIT_PRC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM man_dit_prc_tab WHERE cod_man_dit_prc=?");
         ps.setLong(1, lCOD_MAN_DIT_PRC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("MansioneDittePrecedente with ID="+lCOD_MAN_DIT_PRC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE man_dit_prc_tab SET nom_man_dit_prc=?, des_man_dit_prc=?, cod_dit_prc_dpd=?, cod_dpd=?, cod_azl=? WHERE cod_man_dit_prc=?");
			ps.setString(1, strNOM_MAN_DIT_PRC);
			ps.setString(2, strDES_MAN_DIT_PRC);
			ps.setLong(3, lCOD_DIT_PRC_DPD);
			ps.setLong(4, lCOD_DPD);
			ps.setLong(5, lCOD_AZL);
			ps.setLong(6, lCOD_MAN_DIT_PRC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("MansioneDittePrecedente with ID="+lCOD_MAN_DIT_PRC+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_MAN_DIT_PRC(){
		return lCOD_MAN_DIT_PRC;
	}

	public String getNOM_MAN_DIT_PRC(){
		return strNOM_MAN_DIT_PRC;
	}
	/*public void setNOM_MAN_DIT_PRC(String strNOM_MAN_DIT_PRC){
		if(  (this.strNOM_MAN_DIT_PRC!=null) && (this.strNOM_MAN_DIT_PRC.equals(strNOM_MAN_DIT_PRC))  ) return;
		this.strNOM_MAN_DIT_PRC=strNOM_MAN_DIT_PRC;
		setModified();
	}*/

	public long getCOD_DIT_PRC_DPD(){
		return lCOD_DIT_PRC_DPD;
	}
	/*public void setCOD_DIT_PRC_DPD(long lCOD_DIT_PRC_DPD){
		if(this.lCOD_DIT_PRC_DPD==lCOD_DIT_PRC_DPD) return;
		this.lCOD_DIT_PRC_DPD=lCOD_DIT_PRC_DPD;
		setModified();
	}*/

	public long getCOD_DPD(){
		return lCOD_DPD;
	}
	/*public void setCOD_DPD(long lCOD_DPD){
		if(this.lCOD_DPD==lCOD_DPD) return;
		this.lCOD_DPD=lCOD_DPD;
		setModified();
	}*/
	
	public void setNOM_MAN_DIT_PRC__COD_DIT_PRC_DPD__COD_DPD(String strNOM_MAN_DIT_PRC, long lCOD_DIT_PRC_DPD, long lCOD_DPD){
	if((this.strNOM_MAN_DIT_PRC!=null) && (this.strNOM_MAN_DIT_PRC.equals(strNOM_MAN_DIT_PRC))  && (this.lCOD_DIT_PRC_DPD==lCOD_DIT_PRC_DPD) && (this.lCOD_DPD==lCOD_DPD)) return;
		
		this.strNOM_MAN_DIT_PRC=strNOM_MAN_DIT_PRC;
		this.lCOD_DIT_PRC_DPD=lCOD_DIT_PRC_DPD;
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
	
	
	public void setDES_MAN_DIT_PRC(String strDES_MAN_DIT_PRC){
		if(  (this.strDES_MAN_DIT_PRC!=null) && (this.strDES_MAN_DIT_PRC.equals(strDES_MAN_DIT_PRC))  ) return;
		this.strDES_MAN_DIT_PRC=strDES_MAN_DIT_PRC;
		setModified();
	}

	public String getDES_MAN_DIT_PRC(){
		return strDES_MAN_DIT_PRC;
	}

  //</setter-getters>
	
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetMansioneDittePrecedenteByDIT_PRC_DPDID_View(long DIT_PRC_DPD_ID){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_man_dit_prc,nom_man_dit_prc,des_man_dit_prc FROM man_dit_prc_tab WHERE cod_dit_prc_dpd=?  ");
          ps.setLong(1, DIT_PRC_DPD_ID);
					
					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            MansioneDittePrecedenteByDIT_PRC_DPDID_View obj=new MansioneDittePrecedenteByDIT_PRC_DPDID_View();
            obj.COD_MAN_DIT_PRC=rs.getLong(1);
            obj.NOM_MAN_DIT_PRC=rs.getString(2);
            obj.DESC_MAN_DIT_PRC=rs.getString(3);
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
PseudoContext.bind(MansioneDittePrecedenteBean.BEAN_NAME, new MansioneDittePrecedenteBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>

