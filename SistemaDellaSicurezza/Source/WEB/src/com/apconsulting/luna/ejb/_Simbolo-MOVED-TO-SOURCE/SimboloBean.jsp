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
    <version number="1.0" date="11/02/2004" author="Artur Denysenko">		
      <comments>
			<comment date="11/02/2004" author="Artur Denysenko">
			   <description>Realizazija EJB dlia objecta Simbolo</description>
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
public class SimboloBean extends BMPEntityBean implements ISimbolo, ISimboloHome
{
  //<member-varibles description="Member Variables">
	long lCOD_SIM;
	String strDES_SIM;
  //</member-varibles>

 //<ISimboloHome-implementation>

      public static final String BEAN_NAME="SimboloBean";
      
      public SimboloBean(){}

      public void remove(Object primaryKey){
            SimboloBean bean=new SimboloBean();
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

      public ISimbolo create(String strDES_SIM) throws javax.ejb.CreateException {
         SimboloBean bean=new SimboloBean();
             try{
              Object primaryKey=bean.ejbCreate(  strDES_SIM);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(  strDES_SIM);
              return bean;
            }
            catch(Exception ex){
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }

    public ISimbolo findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      SimboloBean bean=new SimboloBean();
	  try{
		bean.setEntityContext(new EntityContextWrapper(primaryKey));
		bean.ejbActivate();
		bean.ejbLoad();
		return bean;
	  }catch(Exception ex){
              throw new javax.ejb.FinderException(ex.getMessage());
      }
    }
    
    public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}catch(Exception ex){
				throw new javax.ejb.FinderException(ex.getMessage());
			}
    }
 	//
    public Collection getSimbolo_View()
	{
		return (new SimboloBean()).ejbGetSimbolo_View();
	}


  public Long ejbCreate(String strDES_SIM)
  {
	this.lCOD_SIM= NEW_ID();
	this.strDES_SIM=strDES_SIM;
    
	this.unsetModified();

	BMPConnection bmp=getConnection();
	try{
		PreparedStatement ps=bmp.prepareStatement(
		"INSERT INTO ana_sim_tab (cod_sim,des_sim) VALUES(?,?)");
		ps.setLong(1, lCOD_SIM);
		ps.setString(2, strDES_SIM);
		ps.executeUpdate();
		return new Long(lCOD_SIM);
	}
	catch(Exception ex){
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strDES_SIM) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sim FROM ana_sim_tab");
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
    this.lCOD_SIM=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_SIM=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
		 "SELECT cod_sim,des_sim FROM ana_sim_tab WHERE cod_sim=?");
         ps.setLong(1, lCOD_SIM);
         ResultSet rs=ps.executeQuery();
         if(rs.next()){
            	lCOD_SIM=rs.getLong(1);
				strDES_SIM=rs.getString(2);
         }else{
              throw new NoSuchEntityException("Simbolo with ID="+lCOD_SIM+" not found");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_sim_tab WHERE cod_sim=?");
         ps.setLong(1, lCOD_SIM);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Simbolo with ID="+lCOD_SIM+" not found");
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
        PreparedStatement ps=bmp.prepareStatement("UPDATE ana_sim_tab SET des_sim=? WHERE cod_sim=?");
		ps.setString(1, strDES_SIM);
		ps.setLong(2, lCOD_SIM);
        if(ps.executeUpdate()==0) throw new NoSuchEntityException("Simbolo with ID="+lCOD_SIM+" not found");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }


  //<setter-getters>
	public long getCOD_SIM(){
		return lCOD_SIM;
	}
	public String getDES_SIM(){
		return strDES_SIM;
	}
	public void setDES_SIM(String strDES_SIM){
		if(  (this.strDES_SIM!=null) && (this.strDES_SIM.equals(strDES_SIM))  ) return;
		this.strDES_SIM=strDES_SIM;
		setModified();
	}

  //</setter-getters>
     public Collection ejbGetSimbolo_View()
	 {
		BMPConnection bmp=getConnection();
		try{
        	PreparedStatement ps=bmp.prepareStatement("SELECT cod_sim,des_sim FROM ana_sim_tab");
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next())
			{
				Simbolo_View obj=new Simbolo_View();
				obj.lCOD_SIM = rs.getLong(1);
				obj.strDES_SIM = rs.getString(2);
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
/////////////////////////////////////////////////////////////
PseudoContext.bind(SimboloBean.BEAN_NAME, new SimboloBean());
/////////////////////////////////////////////////////////////
%>
