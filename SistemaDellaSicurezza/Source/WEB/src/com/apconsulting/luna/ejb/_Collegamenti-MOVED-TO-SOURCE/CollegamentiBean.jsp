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
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%
/*
<file>
  <versions>
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="15/01/2004" author="Khomenko Juliya">
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
public class CollegamentiBean extends BMPEntityBean implements ICollegamenti, ICollegamentiHome

{
  //<member-varibles description="Member Variables">
	long lCOD_COL_INT_PRG;
	String strIDZ_COL_INT;
	String strDES_COL_INT;
	long lCOD_PRG;
  //</member-varibles>

 //<ICollegamentiHome-implementation>

      public static final String BEAN_NAME="CollegamentiBean";

      public CollegamentiBean(){}

      public void remove(Object primaryKey){
            CollegamentiBean bean=new CollegamentiBean();
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

      public ICollegamenti create(String strIDZ_COL_INT, long lCOD_PRG) throws javax.ejb.CreateException {
         CollegamentiBean bean=new CollegamentiBean();
             try{
              Object primaryKey=bean.ejbCreate(  strIDZ_COL_INT, lCOD_PRG);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strIDZ_COL_INT, lCOD_PRG);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public ICollegamenti findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      CollegamentiBean bean=new CollegamentiBean();
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
  // (Home Intrface) VIEWS
   public Collection getCollegamentoInternet_View(long lCOD_PRG){
  	return (new CollegamentiBean()).ejbGetCollegamentoInternet_View(lCOD_PRG);
 }
   public Collection getCollegamento_View(){
  	return (new CollegamentiBean()).ejbGetCollegamento_View();
 }
  public Long ejbCreate(String strIDZ_COL_INT, long lCOD_PRG)
  {
	this.lCOD_COL_INT_PRG= NEW_ID();
	this.strIDZ_COL_INT=strIDZ_COL_INT;
	this.lCOD_PRG=lCOD_PRG;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO col_int_prg_tab (cod_col_int_prg,idz_col_int,cod_prg) VALUES(?,?,?)");
			ps.setLong(1, lCOD_COL_INT_PRG);
			ps.setString(2, strIDZ_COL_INT);
			ps.setLong(3, lCOD_PRG);
			ps.executeUpdate();
		return new Long(lCOD_COL_INT_PRG);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strIDZ_COL_INT, long lCOD_PRG) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_col_int_prg FROM col_int_prg_tab");
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
    this.lCOD_COL_INT_PRG=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_COL_INT_PRG=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_col_int_prg,idz_col_int,des_col_int,cod_prg FROM col_int_prg_tab WHERE cod_col_int_prg=?");
           ps.setLong(1, lCOD_COL_INT_PRG);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_COL_INT_PRG=rs.getLong(1);
			strIDZ_COL_INT=rs.getString(2);
			strDES_COL_INT=rs.getString(3);
			lCOD_PRG=rs.getLong(4);
           }
           else{
              throw new NoSuchEntityException("Collegamenti with ID="+lCOD_COL_INT_PRG+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM col_int_prg_tab WHERE cod_col_int_prg=?");
         ps.setLong(1, lCOD_COL_INT_PRG);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Collegamenti with ID="+lCOD_COL_INT_PRG+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE col_int_prg_tab SET cod_col_int_prg=?, idz_col_int=?, des_col_int=?, cod_prg=? WHERE cod_col_int_prg=?");
			ps.setLong(1, lCOD_COL_INT_PRG);
			ps.setString(2, strIDZ_COL_INT);
			ps.setString(3, strDES_COL_INT);
			ps.setLong(4, lCOD_PRG);
			ps.setLong(5, lCOD_COL_INT_PRG);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Collegamenti with ID="+lCOD_COL_INT_PRG+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>

	public long getCOD_COL_INT_PRG(){
		return lCOD_COL_INT_PRG;
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

	public long getCOD_PRG(){
		return lCOD_PRG;
	}

	public void setCOD_PRG(long lCOD_PRG){
		if(this.lCOD_PRG==lCOD_PRG) return;
		this.lCOD_PRG=lCOD_PRG;
		setModified();
	}

  //</setter-getters>

	public Collection ejbGetCollegamentoInternet_View(long lCOD_PRG){
       BMPConnection bmp=getConnection();
			 String strCOD_PRG=Long.toString(lCOD_PRG);
      try{
        PreparedStatement ps=bmp.prepareStatement("SELECT *  FROM col_int_prg_tab WHERE cod_prg=? order by IDZ_COL_INT");
  		  ps.setString(1, strCOD_PRG);
        ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          CollegamentoInternet_View obj=new CollegamentoInternet_View();
            obj.COD_COL_INT_PRG=rs.getLong(1);
            obj.IDZ_COL_INT=rs.getString(2);
            obj.DES_COL_INT=rs.getString(3);
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

	public Collection ejbGetCollegamento_View(){
       BMPConnection bmp=getConnection();
      try{
        PreparedStatement ps=bmp.prepareStatement("SELECT cod_col_int, idz_col_int, des_col_int FROM col_int_tab ORDER BY idz_col_int ");

        ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          Collegamento_View obj=new Collegamento_View();
            obj.COD_COL_INT_PRG=rs.getLong(1);
            obj.IDZ_COL_INT=rs.getString(2);
            obj.DES_COL_INT=rs.getString(3);
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
PseudoContext.bind(CollegamentiBean.BEAN_NAME, new CollegamentiBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>

