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
< file>
  < versions>	
    < version number="1.0" date="27/02/2004" author="Yuriy Kushkarov">		
      < comments>
			   < comment date="27/02/2004" author="Yuriy Kushkarov">
				   < description>Realizazija EJB dlia objecta Testimone
				 < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>

<%!
public class TestimoneBean extends BMPEntityBean implements ITestimone, ITestimoneHome
{
  //< member-varibles description="Member Variables">
	long lCOD_TST_EVE;
	String strNOM_TST_EVE;
	String strDES_TST_EVE;
	String strCTO_TST_EVE;
	long lCOD_INO;
  //< /member-varibles>

 //< ITestimoneHome-implementation>

      public static final String BEAN_NAME="TestimoneBean";
      
      public TestimoneBean(){}

      public void remove(Object primaryKey){
            TestimoneBean bean=new TestimoneBean();
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

      public ITestimone create(String strNOM_TST_EVE, String strDES_TST_EVE, long lCOD_INO) throws javax.ejb.CreateException {
         TestimoneBean bean=new TestimoneBean();
             try{
              Object primaryKey=bean.ejbCreate(  strNOM_TST_EVE, strDES_TST_EVE, lCOD_INO);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strNOM_TST_EVE, strDES_TST_EVE, lCOD_INO);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public ITestimone findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      TestimoneBean bean=new TestimoneBean();
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
	  public	Collection getTestimone_View(long lCOD_INO){
		  return (new TestimoneBean()).ejbGetTestimone_View(lCOD_INO);
	  }

  public Long ejbCreate(String strNOM_TST_EVE, String strDES_TST_EVE, long lCOD_INO)
  {
	this.lCOD_TST_EVE= NEW_ID();
	this.strNOM_TST_EVE=strNOM_TST_EVE;
	this.strDES_TST_EVE=strDES_TST_EVE;
	this.lCOD_INO=lCOD_INO;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_tst_eve_tab (cod_tst_eve,nom_tst_eve,des_tst_eve,cod_ino) VALUES(?,?,?,?)");
			ps.setLong(1, lCOD_TST_EVE);
			ps.setString(2, strNOM_TST_EVE);
			ps.setString(3, strDES_TST_EVE);
			ps.setLong(4, lCOD_INO);
			ps.executeUpdate();
		return new Long(lCOD_TST_EVE);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strNOM_TST_EVE, String strDES_TST_EVE, long lCOD_INO) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tst_eve FROM ana_tst_eve_tab");
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
    this.lCOD_TST_EVE=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_TST_EVE=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_tst_eve,nom_tst_eve,des_tst_eve,cto_tst_eve,cod_ino FROM ana_tst_eve_tab WHERE cod_tst_eve=?");
           ps.setLong(1, lCOD_TST_EVE);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
       		lCOD_TST_EVE=rs.getLong(1);
			strNOM_TST_EVE=rs.getString(2);
			strDES_TST_EVE=rs.getString(3);
			strCTO_TST_EVE=rs.getString(4);
			lCOD_INO=rs.getLong(5);
           }
           else{
              throw new NoSuchEntityException("Testimone with ID="+lCOD_TST_EVE+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_tst_eve_tab WHERE cod_tst_eve=?");
         ps.setLong(1, lCOD_TST_EVE);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Testimone with ID="+lCOD_TST_EVE+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_tst_eve_tab SET nom_tst_eve=?, des_tst_eve=?, cto_tst_eve=?, cod_ino=? WHERE cod_tst_eve=?");
			ps.setString(1, strNOM_TST_EVE);
			ps.setString(2, strDES_TST_EVE);
			ps.setString(3, strCTO_TST_EVE);
			ps.setLong(4, lCOD_INO);
			ps.setLong(5, lCOD_TST_EVE);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Testimone with ID="+lCOD_TST_EVE+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //< setter-getters>
  
	public long getCOD_TST_EVE(){
		return lCOD_TST_EVE;
	}

	public String getNOM_TST_EVE(){
		return strNOM_TST_EVE;
	}

	public void setNOM_TST_EVE(String strNOM_TST_EVE){
		if(  (this.strNOM_TST_EVE!=null) && (this.strNOM_TST_EVE.equals(strNOM_TST_EVE))  ) return;
		this.strNOM_TST_EVE=strNOM_TST_EVE;
		setModified();
	}

	public String getDES_TST_EVE(){
		return strDES_TST_EVE;
	}

	public void setDES_TST_EVE(String strDES_TST_EVE){
		if(  (this.strDES_TST_EVE!=null) && (this.strDES_TST_EVE.equals(strDES_TST_EVE))  ) return;
		this.strDES_TST_EVE=strDES_TST_EVE;
		setModified();
	}

	public String getCTO_TST_EVE(){
		return strCTO_TST_EVE;
	}

	public void setCTO_TST_EVE(String strCTO_TST_EVE){
		if(  (this.strCTO_TST_EVE!=null) && (this.strCTO_TST_EVE.equals(strCTO_TST_EVE))  ) return;
		this.strCTO_TST_EVE=strCTO_TST_EVE;
		setModified();
	}

	public long getCOD_INO(){
		return lCOD_INO;
	}

	public void setCOD_INO(long lCOD_INO){
		if(this.lCOD_INO==lCOD_INO) return;
		this.lCOD_INO=lCOD_INO;
		setModified();
	}

	public	Collection ejbGetTestimone_View(long lCOD_INO)
	{
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT cod_tst_eve,nom_tst_eve,des_tst_eve,cto_tst_eve FROM ana_tst_eve_tab WHERE cod_ino=? ORDER BY nom_tst_eve");
			ps.setLong(1, lCOD_INO);
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				Testimone_View obj=new Testimone_View();
				obj.lCOD_TST_EVE = rs.getLong(1);
				obj.strNOM_TST_EVE = rs.getString(2);
				obj.strDES_TST_EVE = rs.getString(3);
				obj.strCTO_TST_EVE = rs.getString(4);
				al.add(obj);
			}
			bmp.close();
			return al;
		}
		catch(Exception ex)
		{
			throw new EJBException(ex);
		}
		finally
		{
			bmp.close();
		}
	}

  //< /setter-getters>
}
%>
<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(TestimoneBean.BEAN_NAME, new TestimoneBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
