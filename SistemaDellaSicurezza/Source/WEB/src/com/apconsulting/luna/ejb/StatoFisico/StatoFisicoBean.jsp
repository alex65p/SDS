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
    <version number="1.0" date="10/02/2004" author="Mike Kondratyuk">		
      <comments>
			 <comment date="10/02/2004" author="Mike Kondratyuk">
				<description>Realizazija EJB dlia objecta StatoFisico</description>
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
public class StatoFisicoBean extends BMPEntityBean implements IStatoFisico, IStatoFisicoHome
{
  //<member-varibles description="Member Variables">
	long lCOD_STA_FSC;
	String strDES_STA_FSC;
  //</member-varibles>

 //<IStatoFisicoHome-implementation>
      public static final String BEAN_NAME="StatoFisicoBean";
      //
      public StatoFisicoBean(){}
	  //
      public void remove(Object primaryKey){
            StatoFisicoBean bean=new StatoFisicoBean();
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

      public IStatoFisico create(String strDES_STA_FSC) throws javax.ejb.CreateException {
         StatoFisicoBean bean=new StatoFisicoBean();
             try{
              Object primaryKey=bean.ejbCreate(  strDES_STA_FSC);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strDES_STA_FSC);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

      public IStatoFisico findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      StatoFisicoBean bean=new StatoFisicoBean();
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
     public Collection getStatoFisico_View()
	 {
		return (new StatoFisicoBean()).ejbGetStatoFisico_View();
	 }

  public Long ejbCreate(String strDES_STA_FSC)
  {
	this.lCOD_STA_FSC= NEW_ID();
	this.strDES_STA_FSC=strDES_STA_FSC;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{
		PreparedStatement ps=bmp.prepareStatement(
		"INSERT INTO ana_sta_fsc_tab (cod_sta_fsc,des_sta_fsc) VALUES(?,?)");
		ps.setLong(1, lCOD_STA_FSC);
		ps.setString(2, strDES_STA_FSC);
		ps.executeUpdate();
		return new Long(lCOD_STA_FSC);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strDES_STA_FSC) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sta_fsc FROM ana_sta_fsc_tab");
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
    this.lCOD_STA_FSC=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_STA_FSC=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "SELECT cod_sta_fsc,des_sta_fsc FROM ana_sta_fsc_tab WHERE cod_sta_fsc=?");
         ps.setLong(1, lCOD_STA_FSC);
         ResultSet rs=ps.executeQuery();
         if(rs.next()){
         	lCOD_STA_FSC=rs.getLong(1);
			strDES_STA_FSC=rs.getString(2);
         }else{
              throw new NoSuchEntityException("StatoFisico with ID="+lCOD_STA_FSC+" not found");
         }
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_sta_fsc_tab WHERE cod_sta_fsc=?");
         ps.setLong(1, lCOD_STA_FSC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("StatoFisico with ID="+lCOD_STA_FSC+" not found");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "UPDATE ana_sta_fsc_tab SET des_sta_fsc=? WHERE cod_sta_fsc=?");
       	 ps.setString(1, strDES_STA_FSC);
		 ps.setLong(2, lCOD_STA_FSC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("StatoFisico with ID="+lCOD_STA_FSC+" not found");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }


  //<setter-getters>
  
	public long getCOD_STA_FSC(){
		return lCOD_STA_FSC;
	}

	public String getDES_STA_FSC(){
		return strDES_STA_FSC;
	}

	public void setDES_STA_FSC(String strDES_STA_FSC){
		if(  (this.strDES_STA_FSC!=null) && (this.strDES_STA_FSC.equals(strDES_STA_FSC))  ) return;
		this.strDES_STA_FSC=strDES_STA_FSC;
		setModified();
	}


  //</setter-getters>
     public Collection ejbGetStatoFisico_View()
	 {
		BMPConnection bmp=getConnection();
		try{
        	PreparedStatement ps=bmp.prepareStatement("SELECT cod_sta_fsc,des_sta_fsc FROM ana_sta_fsc_tab");
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				StatoFisico_View obj=new StatoFisico_View();
				obj.lCOD_STA_FSC = rs.getLong(1);
				obj.strDES_STA_FSC = rs.getString(2);
				al.add(obj);
			}
			bmp.close();
			return al;
		}catch(Exception ex){
			throw new EJBException(ex);
		}finally{bmp.close();}
	 }
}
%>
<%
/////////////////////////////////////////////////////////////////////
PseudoContext.bind(StatoFisicoBean.BEAN_NAME, new StatoFisicoBean());
/////////////////////////////////////////////////////////////////////
%>

