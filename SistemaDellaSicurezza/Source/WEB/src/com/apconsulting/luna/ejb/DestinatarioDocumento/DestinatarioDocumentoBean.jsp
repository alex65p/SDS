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
    <version number="1.0" date="06/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="06/02/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta DestinatarioDocumento
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
public class DestinatarioDocumentoBean extends BMPEntityBean implements IDestinatarioDocumento, IDestinatarioDocumentoHome

{
  //<member-varibles description="Member Variables">
	long lCOD_LST_DSI_DOC;
	String strNOM_DSI_ESR;
	String strDES_DSI_ESR;
	String strIDZ_PSA_ELT_DSI_ESR;
	java.sql.Date dtDAT_CSG_DOC_DSI;
	long lCOD_DOC;
	long lCOD_DTE;
	long lCOD_DPD;
	long lCOD_AZL;
	long lCOD_UNI_ORG;
  //</member-varibles>

 //<IDestinatarioDocumentoHome-implementation>

      public static final String BEAN_NAME="DestinatarioDocumentoBean";
      
      public DestinatarioDocumentoBean(){}

      public void remove(Object primaryKey){
            DestinatarioDocumentoBean bean=new DestinatarioDocumentoBean();
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

      public IDestinatarioDocumento create(long lCOD_DOC, long lCOD_AZL) throws javax.ejb.CreateException {
         DestinatarioDocumentoBean bean=new DestinatarioDocumentoBean();
             try{
              Object primaryKey=bean.ejbCreate(  lCOD_DOC, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate( lCOD_DOC, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IDestinatarioDocumento findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      DestinatarioDocumentoBean bean=new DestinatarioDocumentoBean();
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

  public Long ejbCreate(long lCOD_DOC, long lCOD_AZL)
  {
	this.lCOD_LST_DSI_DOC= NEW_ID();
	this.lCOD_DOC=lCOD_DOC;
	this.lCOD_AZL=lCOD_AZL;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO lst_dsi_doc_tab (cod_lst_dsi_doc,cod_doc,cod_azl) VALUES(?,?,?)");
			ps.setLong(1, lCOD_LST_DSI_DOC);
			ps.setLong(2, lCOD_DOC);
			ps.setLong(3, lCOD_AZL);
			ps.executeUpdate();
		return new Long(lCOD_LST_DSI_DOC);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lCOD_DOC, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lst_dsi_doc FROM lst_dsi_doc_tab");
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
    this.lCOD_LST_DSI_DOC=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_LST_DSI_DOC=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_lst_dsi_doc,nom_dsi_esr,des_dsi_esr,idz_psa_elt_dsi_esr,dat_csg_doc_dsi,cod_doc,cod_dte,cod_dpd,cod_azl,cod_uni_org FROM lst_dsi_doc_tab WHERE cod_lst_dsi_doc=?");
           ps.setLong(1, lCOD_LST_DSI_DOC);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            lCOD_LST_DSI_DOC=rs.getLong(1);
			strNOM_DSI_ESR=rs.getString(2);
			strDES_DSI_ESR=rs.getString(3);
			strIDZ_PSA_ELT_DSI_ESR=rs.getString(4);
			dtDAT_CSG_DOC_DSI=rs.getDate(5);
			lCOD_DOC=rs.getLong(6);
			lCOD_DTE=rs.getLong(7);
			lCOD_DPD=rs.getLong(8);
			lCOD_AZL=rs.getLong(9);
			//if (true) throw new Exception("X:"+lCOD_AZL);
			lCOD_UNI_ORG=rs.getLong(10);
           }
           else{
              throw new NoSuchEntityException("DestinatarioDocumento with ID="+lCOD_LST_DSI_DOC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM lst_dsi_doc_tab WHERE cod_lst_dsi_doc=?");
         ps.setLong(1, lCOD_LST_DSI_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DestinatarioDocumento with ID="+lCOD_LST_DSI_DOC+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE lst_dsi_doc_tab SET cod_lst_dsi_doc=?, nom_dsi_esr=?, des_dsi_esr=?, idz_psa_elt_dsi_esr=?, dat_csg_doc_dsi=?, cod_doc=?, cod_dte=?, cod_dpd=?, cod_azl=?, cod_uni_org=? WHERE cod_lst_dsi_doc=?");
			ps.setLong(1, lCOD_LST_DSI_DOC);
			ps.setString(2, strNOM_DSI_ESR);
			ps.setString(3, strDES_DSI_ESR);
			ps.setString(4, strIDZ_PSA_ELT_DSI_ESR);
			ps.setDate(5, dtDAT_CSG_DOC_DSI);
			ps.setLong(6, lCOD_DOC);
			if(lCOD_DTE==0) ps.setNull(7,java.sql.Types.BIGINT); else ps.setLong(7, lCOD_DTE);
			if(lCOD_DPD==0) ps.setNull(8,java.sql.Types.BIGINT); else ps.setLong(8, lCOD_DPD);
			ps.setLong(9, lCOD_AZL);
			//if (true) throw new Exception(""+lCOD_AZL);
			if(lCOD_UNI_ORG==0) ps.setNull(10,java.sql.Types.BIGINT); else ps.setLong(10, lCOD_UNI_ORG);
			ps.setLong(11, lCOD_LST_DSI_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DestinatarioDocumento with ID="+lCOD_LST_DSI_DOC+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_LST_DSI_DOC(){
		return lCOD_LST_DSI_DOC;
	}

	public String getNOM_DSI_ESR(){
		return strNOM_DSI_ESR;
	}

	public void setNOM_DSI_ESR(String strNOM_DSI_ESR){
		if(  (this.strNOM_DSI_ESR!=null) && (this.strNOM_DSI_ESR.equals(strNOM_DSI_ESR))  ) return;
		this.strNOM_DSI_ESR=strNOM_DSI_ESR;
		setModified();
	}

	public String getDES_DSI_ESR(){
		return strDES_DSI_ESR;
	}

	public void setDES_DSI_ESR(String strDES_DSI_ESR){
		if(  (this.strDES_DSI_ESR!=null) && (this.strDES_DSI_ESR.equals(strDES_DSI_ESR))  ) return;
		this.strDES_DSI_ESR=strDES_DSI_ESR;
		setModified();
	}

	public String getIDZ_PSA_ELT_DSI_ESR(){
		return strIDZ_PSA_ELT_DSI_ESR;
	}

	public void setIDZ_PSA_ELT_DSI_ESR(String strIDZ_PSA_ELT_DSI_ESR){
		if(  (this.strIDZ_PSA_ELT_DSI_ESR!=null) && (this.strIDZ_PSA_ELT_DSI_ESR.equals(strIDZ_PSA_ELT_DSI_ESR))  ) return;
		this.strIDZ_PSA_ELT_DSI_ESR=strIDZ_PSA_ELT_DSI_ESR;
		setModified();
	}

	public java.sql.Date getDAT_CSG_DOC_DSI(){
		return dtDAT_CSG_DOC_DSI;
	}

	public void setDAT_CSG_DOC_DSI(java.sql.Date dtDAT_CSG_DOC_DSI){
		if(this.dtDAT_CSG_DOC_DSI==dtDAT_CSG_DOC_DSI) return;
		this.dtDAT_CSG_DOC_DSI=dtDAT_CSG_DOC_DSI;
		setModified();
	}

	public long getCOD_DOC(){
		return lCOD_DOC;
	}

	public void setCOD_DOC(long lCOD_DOC){
		if(this.lCOD_DOC==lCOD_DOC) return;
		this.lCOD_DOC=lCOD_DOC;
		setModified();
	}

	public long getCOD_DTE(){
		return lCOD_DTE;
	}

	public void setCOD_DTE(long lCOD_DTE){
		if(this.lCOD_DTE==lCOD_DTE) return;
		this.lCOD_DTE=lCOD_DTE;
		setModified();
	}

	public long getCOD_DPD(){
		return lCOD_DPD;
	}

	public long getCOD_AZL(){
		return lCOD_AZL;
	}

	public void setCOD_AZL(long lCOD_AZL){
		if(this.lCOD_AZL==lCOD_AZL) return;
		this.lCOD_AZL=lCOD_AZL;
		setModified();
	}
	
	public void setCOD_DPD__DPD_AZL(long lCOD_AZL, long lCOD_DPD){

		this.lCOD_AZL=lCOD_AZL;
		this.lCOD_DPD=lCOD_DPD;
		setModified();
	}
	
	public void setCOD_DPD(long lCOD_DPD){
		this.lCOD_DPD=lCOD_DPD;
		setModified();
	}

	public long getCOD_UNI_ORG(){
		return lCOD_UNI_ORG;
	}

	public void setCOD_UNI_ORG(long lCOD_UNI_ORG){
		if(this.lCOD_UNI_ORG==lCOD_UNI_ORG) return;
		this.lCOD_UNI_ORG=lCOD_UNI_ORG;
		setModified();
	}


  //</setter-getters>
}
%>
<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(DestinatarioDocumentoBean.BEAN_NAME, new DestinatarioDocumentoBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
