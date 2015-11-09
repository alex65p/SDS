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
    <version number="1.0" date="27/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="27/01/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta AnagCorso
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
public class AnagCorsoBean extends BMPEntityBean implements IAnagCorso, IAnagCorsoHome

{
  //<member-varibles description="Member Variables">
	long lCOD_COR;
	long lDUR_COR_GOR;
	String strNOM_COR;
	String strDES_COR;
	String strUSO_ATE_FRE_COR;
	String strUSO_PTG_COR;
	long lCOD_TPL_COR;
  //</member-varibles>

 //<IAnagCorsoHome-implementation>

      public static final String BEAN_NAME="AnagCorsoBean";
      
      public AnagCorsoBean(){}

      public void remove(Object primaryKey){
            AnagCorsoBean bean=new AnagCorsoBean();
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

      public IAnagCorso create(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) throws javax.ejb.CreateException {
         AnagCorsoBean bean=new AnagCorsoBean();
             try{
              Object primaryKey=bean.ejbCreate(  lDUR_COR_GOR, strNOM_COR, lCOD_TPL_COR);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  lDUR_COR_GOR, strNOM_COR, lCOD_TPL_COR);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IAnagCorso findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      AnagCorsoBean bean=new AnagCorsoBean();
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

  public Long ejbCreate(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR)
  {
	this.lCOD_COR= NEW_ID();
	this.lDUR_COR_GOR=lDUR_COR_GOR;
	this.strNOM_COR=strNOM_COR;
	this.lCOD_TPL_COR=lCOD_TPL_COR;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_cor_tab (cod_cor,dur_cor_gor,nom_cor,cod_tpl_cor) VALUES(?,?,?,?)");
			ps.setLong(1, lCOD_COR);
			ps.setLong(2, lDUR_COR_GOR);
			ps.setString(3, strNOM_COR);
			ps.setLong(7, lCOD_TPL_COR);
			ps.executeUpdate();
		return new Long(lCOD_COR);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cor FROM ana_cor_tab");
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
    this.lCOD_COR=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_COR=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_cor,dur_cor_gor,nom_cor,des_cor,uso_ate_fre_cor,uso_ptg_cor,cod_tpl_cor FROM ana_cor_tab WHERE cod_cor=?");
           ps.setLong(1, lCOD_COR);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_COR=rs.getLong(1);
			lDUR_COR_GOR=rs.getLong(2);
			strNOM_COR=rs.getString(3);
			strDES_COR=rs.getString(4);
			strUSO_ATE_FRE_COR=rs.getString(5);
			strUSO_PTG_COR=rs.getString(6);
			lCOD_TPL_COR=rs.getLong(7);
           }
           else{
              throw new NoSuchEntityException("AnagCorso with ID="+lCOD_COR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_cor_tab WHERE cod_cor=?");
         ps.setLong(1, lCOD_COR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("AnagCorso with ID="+lCOD_COR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_cor_tab SET cod_cor=?, dur_cor_gor=?, nom_cor=?, des_cor=?, uso_ate_fre_cor=?, uso_ptg_cor=?, cod_tpl_cor=? WHERE cod_cor=?");
			ps.setLong(1, lCOD_COR);
			ps.setLong(2, lDUR_COR_GOR);
			ps.setString(3, strNOM_COR);
			ps.setString(4, strDES_COR);
			ps.setString(5, strUSO_ATE_FRE_COR);
			ps.setString(6, strUSO_PTG_COR);
			ps.setLong(7, lCOD_TPL_COR);
			ps.setLong(8, lCOD_COR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("AnagCorso with ID="+lCOD_COR+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_COR(){
		return lCOD_COR;
	}

	public long getDUR_COR_GOR(){
		return lDUR_COR_GOR;
	}

	public void setDUR_COR_GOR(long lDUR_COR_GOR){
		if(this.lDUR_COR_GOR==lDUR_COR_GOR) return;
		this.lDUR_COR_GOR=lDUR_COR_GOR;
	}

	public String getNOM_COR(){
		return strNOM_COR;
	}

	public void setNOM_COR(String strNOM_COR){
		if(  (this.strNOM_COR!=null) && (this.strNOM_COR.equals(strNOM_COR))  ) return;
		this.strNOM_COR=strNOM_COR;
		setModified();
	}

	public String getDES_COR(){
		return strDES_COR;
	}

	public void setDES_COR(String strDES_COR){
		if(  (this.strDES_COR!=null) && (this.strDES_COR.equals(strDES_COR))  ) return;
		this.strDES_COR=strDES_COR;
		setModified();
	}

	public String getUSO_ATE_FRE_COR(){
		return strUSO_ATE_FRE_COR;
	}

	public void setUSO_ATE_FRE_COR(String strUSO_ATE_FRE_COR){
		if(  (this.strUSO_ATE_FRE_COR!=null) && (this.strUSO_ATE_FRE_COR.equals(strUSO_ATE_FRE_COR))  ) return;
		this.strUSO_ATE_FRE_COR=strUSO_ATE_FRE_COR;
		setModified();
	}

	public String getUSO_PTG_COR(){
		return strUSO_PTG_COR;
	}

	public void setUSO_PTG_COR(String strUSO_PTG_COR){
		if(  (this.strUSO_PTG_COR!=null) && (this.strUSO_PTG_COR.equals(strUSO_PTG_COR))  ) return;
		this.strUSO_PTG_COR=strUSO_PTG_COR;
		setModified();
	}

	public long getCOD_TPL_COR(){
		return lCOD_TPL_COR;
	}

	public void setCOD_TPL_COR(long lCOD_TPL_COR){
		if(this.lCOD_TPL_COR==lCOD_TPL_COR) return;
		this.lCOD_TPL_COR=lCOD_TPL_COR;
	}


  //</setter-getters>
}
%>
<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(AnagCorsoBean.BEAN_NAME, new AnagCorsoBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>

