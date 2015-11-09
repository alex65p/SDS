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
    <version number="1.0" date="27/01/2004" author="Valentina Ruggieri">
	      <comments>
				  <comment date="27/01/2004" author="Valentina Ruggieri">
				   <description>AnagrParagrafoBean.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

//public class AgenteMaterialeBean extends BMPEntityBean implements IAgenteMaterialeRemote
public class AnagrParagrafoBean extends BMPEntityBean implements IAnagrParagrafoHome, IAnagrParagrafo 
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long COD_PRG;           //1
  String NOM_PRG;
  String DES_PRG;         //2
  long COD_ARE;
  long COD_CPL;
  long COD_AZL;       //3
  //----------------------------

  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private AnagrParagrafoBean()
  {
	//System.err.println("AgenteMaterialeBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IAnagrParagrafo create(String strNOM_PRG,String strDES_PRG,long lCOD_ARE,long lCOD_CPL,long lCOD_AZL ) throws CreateException
  {
 	 AnagrParagrafoBean bean =  new  AnagrParagrafoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNOM_AGE_MAT, lCOD_CAG_AGE_MAT);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNOM_AGE_MAT, lCOD_CAG_AGE_MAT);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	AgenteMaterialeBean iAgenteMaterialeBean=new  AgenteMaterialeBean();
    try
	{
    	Object obj=iAgenteMaterialeBean.ejbFindByPrimaryKey((Long)primaryKey);
        iAgenteMaterialeBean.setEntityContext(new EntityContextWrapper(obj));
        iAgenteMaterialeBean.ejbActivate();
        iAgenteMaterialeBean.ejbLoad();
        iAgenteMaterialeBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex.getMessage());
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IAgenteMateriale findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	AgenteMaterialeBean bean =  new  AgenteMaterialeBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }

 // (Home Intrface) VIEWS
 public Collection getAgenti_Materiali_View()
  {
  	return (new  AgenteMaterialeBean()).ejbGetAgenti_Materiali_View();
 }
 //

 
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IAgenteMaterialeHome-implementation>
  public Long ejbCreate(String strNOM_PRG,String strDES_PRG,long lCOD_ARE,long lCOD_CPL,long lCOD_AZL)
  {
    this.COD_PRG=NEW_ID();
    this.NOM_PRG=strNOM_PRG;
	this.DES_PRG=strDES_PRG;
    this.COD_ARE=lCOD_ARE;
	this.COD_CPL=lCOD_CPL;
	this.COD_AZL=lCOD_AZL;
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_pgr (cod_prg,nom_prg, des_prg, cod_are,cod_cpl, cod_azl) VALUES(?,?,?)");
         ps.setLong   (1, COD_PRG);
         ps.setString (2, NOM_PRG);
		 ps.setString (3, DES_PRG);
         ps.setLong (4, COD_ARE);
		 ps.setLong (5, COD_CPL);
		 ps.setLong (6, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_PRG);
    }
    catch(Exception ex){
        throw new EJBException(ex.getMessage());
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate((String strNOM_PRG,String strDES_PRG,long lCOD_ARE,long lCOD_CPL,long lCOD_AZL)) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_prg FROM ana_prg ");
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
  
//-----------------------------------------------------------
  	  
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_PRG=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_PRG=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_prg  WHERE cod_prg=?");
           ps.setLong (1, COD_PRG);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.COD_PRG=rs.getLong("COD_PRG");
			  	this.NOM_PRG=rs.getString("NOM_PRG");
				this.DES_PRG=rs.getString("DES_PRG");
			  	this.COD_ARE=rs.getLong("COD_ARE");
				this.COD_CPL=rs.getLong("COD_CPL");
				this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("AnagraficaParagrafo con ID= non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_prg  WHERE cod_prg=?");
          ps.setLong (1, COD_PRG);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("AnagraficaParagrafo con ID= non è trovata");
      }
      catch(Exception ex)
	  {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }  
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
				PreparedStatement ps=bmp.prepareStatement("UPDATE ana_prg  SET nom_prg=?, des_prg=?, cod_are=?, cod_cpl=?, cod_azl=? WHERE cod_prg=?");
          
				ps.setString(1, NOM_PRG);
				ps.setString(2, DES_PRG);
				ps.setLong(3, COD_ARE);
				ps.setLong(4, COD_CPL);
				ps.setLong(5, COD_AZL);
				ps.setLong(6, COD_PRG );
				if(ps.executeUpdate()==0) throw new NoSuchEntityException("AnagraficaParagrafo con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">  
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">  ---------sono arrivata qui
	//1
  	 public void setNOM_AGE_MAT(String newNOM_AGE_MAT){
      if( NOM_AGE_MAT.equals(newNOM_AGE_MAT) ) return;
      NOM_AGE_MAT = newNOM_AGE_MAT;
      setModified();
    }
    public String getNOM_AGE_MAT(){
	  if(NOM_AGE_MAT==null)
	  {return "";}else{return NOM_AGE_MAT;}
	}
	//2
	  public void setCOD_CAG_AGE_MAT(long newCOD_CAG_AGE_MAT){
      if( COD_CAG_AGE_MAT==newCOD_CAG_AGE_MAT) return;
      COD_CAG_AGE_MAT = newCOD_CAG_AGE_MAT;
      setModified();
    }
    public long getCOD_CAG_AGE_MAT(){
		return COD_CAG_AGE_MAT;
    }
	//3    
    public long getCOD_AGE_MAT(){
  		return COD_AGE_MAT;
    }
   //</comment>


  //=====================================================================<br>
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetAgenti_Materiali_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT ana_age_mat_tab.cod_age_mat,ana_age_mat_tab.nom_age_mat,ana_age_mat_tab.cod_cag_age_mat,cag_age_mat_tab.nom_cag_age_mat FROM ana_age_mat_tab ,cag_age_mat_tab   WHERE ana_age_mat_tab.cod_cag_age_mat=cag_age_mat_tab.cod_cag_age_mat ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Agenti_Materiali_View obj=new Agenti_Materiali_View();
            obj.COD_AGE_MAT=rs.getLong(1);
            obj.NOM_AGE_MAT=rs.getString(2);
            obj.COD_CAG_AGE_MAT=rs.getLong(3);
			obj.NOM_CAG_AGE_MAT=rs.getString(4);
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
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AgenteMaterialeBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ///////////////////
PseudoContext.bind("AgenteMaterialeBean", new AgenteMaterialeBean());
////////////////////////////////////////// </BINDING> 
%>
