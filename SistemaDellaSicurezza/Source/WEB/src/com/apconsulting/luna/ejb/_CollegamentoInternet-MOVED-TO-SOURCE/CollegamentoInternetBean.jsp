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
    <version number="1.0" date="29/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="29/01/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta CollegamentoInternet
				 <comment date="29/01/2004" author="Pogrebnoy Yura">
				   <description>Popolzovalsya EJBun
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
public class CollegamentoInternetBean extends BMPEntityBean implements ICollegamentoInternet, ICollegamentoInternetHome

{
  //< member-varibles description="Member Variables">
	long lCOD_COL_INT;
	String strIDZ_COL_INT;
	String strDES_COL_INT;
	long lCOD_FAT_RSO;
  //< /member-varibles>

 //< ICollegamentoInternetHome-implementation>
      public static final String BEAN_NAME="CollegamentoInternetBean";
      public CollegamentoInternetBean(){}

      public void remove(Object primaryKey){
            CollegamentoInternetBean bean=new CollegamentoInternetBean();
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

      public ICollegamentoInternet create(String strIDZ_COL_INT, long lCOD_FAT_RSO) throws javax.ejb.CreateException {
         CollegamentoInternetBean bean=new CollegamentoInternetBean();
             try{
              Object primaryKey=bean.ejbCreate(  strIDZ_COL_INT, lCOD_FAT_RSO);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strIDZ_COL_INT, lCOD_FAT_RSO);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public ICollegamentoInternet findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      CollegamentoInternetBean bean=new CollegamentoInternetBean();
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
  // (Home Intrface) VIEWS
   public Collection getCollegamentoInternet_View(String strCOD_FAT_RSO){
  	return (new CollegamentoInternetBean()).ejbGetCollegamentoInternet_View(strCOD_FAT_RSO);
 }

  public Long ejbCreate(String strIDZ_COL_INT, long lCOD_FAT_RSO)
  {
	this.lCOD_COL_INT= NEW_ID();
	this.strIDZ_COL_INT=strIDZ_COL_INT;
	this.lCOD_FAT_RSO=lCOD_FAT_RSO;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO col_int_tab (cod_col_int,idz_col_int,cod_fat_rso) VALUES(?,?,?)");
			ps.setLong(1, lCOD_COL_INT);
			ps.setString(2, strIDZ_COL_INT);
			ps.setLong(3, lCOD_FAT_RSO);
			ps.executeUpdate();
		return new Long(lCOD_COL_INT);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strIDZ_COL_INT, long lCOD_FAT_RSO) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_col_int FROM col_int_tab");
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
    this.lCOD_COL_INT=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_COL_INT=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_col_int,idz_col_int,des_col_int,cod_fat_rso FROM col_int_tab WHERE cod_col_int=?");
           ps.setLong(1, lCOD_COL_INT);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_COL_INT=rs.getLong(1);
			strIDZ_COL_INT=rs.getString(2);
			strDES_COL_INT=rs.getString(3);
			lCOD_FAT_RSO=rs.getLong(4);
           }
           else{
              throw new NoSuchEntityException("CollegamentoInternet with ID="+lCOD_COL_INT+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM col_int_tab WHERE cod_col_int=?");
         ps.setLong(1, lCOD_COL_INT);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("CollegamentoInternet with ID="+lCOD_COL_INT+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE col_int_tab SET cod_col_int=?, idz_col_int=?, des_col_int=?, cod_fat_rso=? WHERE cod_col_int=?");
			ps.setLong(1, lCOD_COL_INT);
			ps.setString(2, strIDZ_COL_INT);
			ps.setString(3, strDES_COL_INT);
			ps.setLong(4, lCOD_FAT_RSO);
			ps.setLong(5, lCOD_COL_INT);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("CollegamentoInternet with ID="+lCOD_COL_INT+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //< setter-getters>
  
	public long getCOD_COL_INT(){
		return lCOD_COL_INT;
	}

	public String getIDZ_COL_INT(){
		return strIDZ_COL_INT;
	}

	public void setIDZ_COL_INT(String strIDZ_COL_INT){
		if(  (this.strIDZ_COL_INT!=null) && (this.strIDZ_COL_INT.equals(strIDZ_COL_INT))  ) return;
		this.strIDZ_COL_INT=strIDZ_COL_INT;
		setModified();
	}

	public String getDES_COL_INT(){
		return strDES_COL_INT;
	}

	public void setDES_COL_INT(String strDES_COL_INT){
		if(  (this.strDES_COL_INT!=null) && (this.strDES_COL_INT.equals(strDES_COL_INT))  ) return;
		this.strDES_COL_INT=strDES_COL_INT;
		setModified();
	}

	public long getCOD_FAT_RSO(){
		return lCOD_FAT_RSO;
	}

	public void setCOD_FAT_RSO(long lCOD_FAT_RSO){
		if(this.lCOD_FAT_RSO==lCOD_FAT_RSO) return;
		this.lCOD_FAT_RSO=lCOD_FAT_RSO;
		setModified();
	}
  //< /setter-getters>
	
	public Collection ejbGetCollegamentoInternet_View(String strCOD_FAT_RSO){
       BMPConnection bmp=getConnection();
      try{
        PreparedStatement ps=bmp.prepareStatement("SELECT *  FROM col_int_tab WHERE cod_fat_rso=? order by IDZ_COL_INT");
  		  ps.setString(1, strCOD_FAT_RSO);
        ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          CollegamentoInternet_View obj=new CollegamentoInternet_View();
            obj.COD_COL_INT=rs.getLong(1);  
            obj.IDZ_COL_INT=rs.getString(2);
            obj.DES_COL_INT=rs.getString(3);
						obj.COD_FAT_RSO=rs.getString(4);
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
}//end of bean
%>

<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(CollegamentoInternetBean.BEAN_NAME, new CollegamentoInternetBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
