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
    <version number="1.0" date="29/01/2004" author="Mike Kondratyuk">
      <comments>
			   <comment date="29/01/2004" author="Mike Kondratyuk">
				   <description>Realizazija EJB dlia objecta DocentiCorso
				 </comment>
				 	<comment date="29/02/2004" author="Podmasteriev Alexandr">
				   <description>Added View CorsoDocenti_VIEW
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
public class DocentiCorsoBean extends BMPEntityBean implements IDocentiCorso, IDocentiCorsoHome

{
  //<member-varibles description="Member Variables">
	long lCOD_DCT_COR;
	long lCOD_COR;
	long lCOD_DPD;
	long lCOD_AZL;
	String strNOM_DCT;
	java.sql.Date dtDAT_INZ;
	java.sql.Date dtDAT_FIE;
	String strDES_DCT;
  //</member-varibles>

 //<IDocentiCorsoHome-implementation>

      public static final String BEAN_NAME="DocentiCorsoBean";

      public DocentiCorsoBean(){}

      public void remove(Object primaryKey){
            DocentiCorsoBean bean=new DocentiCorsoBean();
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

      public IDocentiCorso create(long lCOD_COR, long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ) throws javax.ejb.CreateException {
         DocentiCorsoBean bean=new DocentiCorsoBean();
             try{
              Object primaryKey=bean.ejbCreate(  lCOD_COR, lCOD_DPD, lCOD_AZL, strNOM_DCT, dtDAT_INZ);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  lCOD_COR, lCOD_DPD, lCOD_AZL, strNOM_DCT, dtDAT_INZ);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IDocentiCorso findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      DocentiCorsoBean bean=new DocentiCorsoBean();
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

	  public Collection getDocentiCorso_View(long lCOD_COR){
		return (new DocentiCorsoBean()).ejbGetDocentiCorso_View(lCOD_COR);
	  }
	///==================Added by Podmasteriev=========================================\\\
	public Collection getCorsoDocenti_VIEW(long lCOD_AZL) {
		return (new DocentiCorsoBean()).ejbGetCorsoDocenti_VIEW(lCOD_AZL);
	}
	//==================================================================\\\
 //

  public Long ejbCreate(long lCOD_COR, long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ)
  {
	this.lCOD_DCT_COR= NEW_ID();
	this.lCOD_COR=lCOD_COR;
	this.lCOD_DPD=lCOD_DPD;
	this.lCOD_AZL=lCOD_AZL;
	this.strNOM_DCT=strNOM_DCT;
	this.dtDAT_INZ=dtDAT_INZ;

	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{

		PreparedStatement ps=bmp.prepareStatement("INSERT INTO dct_cor_tab (cod_dct_cor,cod_cor,cod_dpd,cod_azl,nom_dct,dat_inz) VALUES(?,?,?,?,?,?)");
			ps.setLong(1, lCOD_DCT_COR);
			ps.setLong(2, lCOD_COR);
			ps.setLong(3, lCOD_DPD);
			ps.setLong(4, lCOD_AZL);
			ps.setString(5, strNOM_DCT);
			ps.setDate(6, dtDAT_INZ);
			ps.executeUpdate();
		return new Long(lCOD_DCT_COR);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(long lCOD_COR, long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dct_cor FROM dct_cor_tab");
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
    this.lCOD_DCT_COR=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_DCT_COR=-1;
  }



  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_dct_cor,cod_cor,cod_dpd,cod_azl,nom_dct,dat_inz,dat_fie,des_dct FROM dct_cor_tab WHERE cod_dct_cor=?");
           ps.setLong(1, lCOD_DCT_COR);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_DCT_COR=rs.getLong(1);
			lCOD_COR=rs.getLong(2);
			lCOD_DPD=rs.getLong(3);
			lCOD_AZL=rs.getLong(4);
			strNOM_DCT=rs.getString(5);
			dtDAT_INZ=rs.getDate(6);
			dtDAT_FIE=rs.getDate(7);
			strDES_DCT=rs.getString(8);
           }
           else{
              throw new NoSuchEntityException("DocentiCorso with ID="+lCOD_DCT_COR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM dct_cor_tab WHERE cod_dct_cor=?");
         ps.setLong(1, lCOD_DCT_COR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DocentiCorso with ID="+lCOD_DCT_COR+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE dct_cor_tab SET cod_dct_cor=?, cod_cor=?, cod_dpd=?, cod_azl=?, nom_dct=?, dat_inz=?, dat_fie=?, des_dct=? WHERE cod_dct_cor=?");
			ps.setLong(1, lCOD_DCT_COR);
			ps.setLong(2, lCOD_COR);
			ps.setLong(3, lCOD_DPD);
			ps.setLong(4, lCOD_AZL);
			ps.setString(5, strNOM_DCT);
			ps.setDate(6, dtDAT_INZ);
			ps.setDate(7, dtDAT_FIE);
			ps.setString(8, strDES_DCT);
			ps.setLong(9, lCOD_DCT_COR);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("DocentiCorso with ID="+lCOD_DCT_COR+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>

	public long getCOD_DCT_COR(){
		return lCOD_DCT_COR;
	}

	public long getCOD_COR(){
		return lCOD_COR;
	}

	public void setCOD_COR(long lCOD_COR){
		if(this.lCOD_COR==lCOD_COR) return;
		this.lCOD_COR=lCOD_COR;
		setModified();
	}

	public long getCOD_DPD(){
		return lCOD_DPD;
	}

	public void setCOD_DPD__COD_AZL__NOM_DCT__DAT_INZ(long lCOD_DPD, long lCOD_AZL, String strNOM_DCT, java.sql.Date dtDAT_INZ){
		boolean isNew = false;
		if(this.lCOD_DPD!=lCOD_DPD) isNew = true;
		this.lCOD_DPD=lCOD_DPD;
		if(this.lCOD_AZL!=lCOD_AZL) isNew = true;
		this.lCOD_AZL=lCOD_AZL;
		if((this.strNOM_DCT!=null) && (!this.strNOM_DCT.equals(strNOM_DCT))) isNew = true;
		this.strNOM_DCT=strNOM_DCT;
		if((this.dtDAT_INZ!=null) && (!this.dtDAT_INZ.equals(dtDAT_INZ))) isNew = true;
		this.dtDAT_INZ=dtDAT_INZ;
		if(isNew) setModified();
	}

	public long getCOD_AZL(){
		return lCOD_AZL;
	}

	public String getNOM_DCT(){
		return strNOM_DCT;
	}

	public java.sql.Date getDAT_INZ(){
		return dtDAT_INZ;
	}

	public java.sql.Date getDAT_FIE(){
		return dtDAT_FIE;
	}

	public void setDAT_FIE(java.sql.Date dtDAT_FIE){
		if(this.dtDAT_FIE==dtDAT_FIE) return;
		this.dtDAT_FIE=dtDAT_FIE;
		setModified();
	}

	public String getDES_DCT(){
		return strDES_DCT;
	}

	public void setDES_DCT(String strDES_DCT){
		if(  (this.strDES_DCT!=null) && (this.strDES_DCT.equals(strDES_DCT))  ) return;
		this.strDES_DCT=strDES_DCT;
		setModified();
	}


  //</setter-getters>
	///=======Added  VIEW by Podmaster==========================================================

	public	Collection ejbGetCorsoDocenti_VIEW(long lCOD_AZL)
	{
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement(
                                "SELECT  a.cod_dct_cor, a.nom_dct " +
                                " FROM dct_cor_tab a, sch_egz_cor_tab b, ana_cor_tab c " +
                                " WHERE a.cod_cor = b.cod_cor " +
                                " AND a.cod_cor = c.cod_cor " +
                                " AND a.cod_azl = ? ORDER BY  a.nom_dct");
			ps.setLong(1, lCOD_AZL);
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
             String a = "";
			while(rs.next())
			{
				CorsoDocenti_VIEW obj=new CorsoDocenti_VIEW();

                 if (!(a.equals(rs.getString(2)))) {

                obj.COD_DCT_COR = rs.getLong(1);
				obj.NOM_DCT = rs.getString(2);
				a=rs.getString(2);
                al.add(obj);
                 }
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

	///==================================================================================





	public Collection ejbGetDocentiCorso_View(long lCOD_COR)
	{
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("SELECT cod_dct_cor,nom_dct,dat_inz,dat_fie FROM dct_cor_tab WHERE cod_cor=? ORDER BY nom_dct ");
			ps.setLong(1, lCOD_COR);

			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				DocentiCorso_View obj=new DocentiCorso_View();
				obj.COD_DCT_COR = rs.getLong(1);
				obj.NOM_DCT = rs.getString(2);
				obj.DAT_FIE = rs.getDate(4);
				obj.DAT_INZ = rs.getDate(3);
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

}
%>
<%
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
PseudoContext.bind(DocentiCorsoBean.BEAN_NAME, new DocentiCorsoBean());
//////////////////////////////////////////  /////////////////////////////////////////////////////////////////
%>
