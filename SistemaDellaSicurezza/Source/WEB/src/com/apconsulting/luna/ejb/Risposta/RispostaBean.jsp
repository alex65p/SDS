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

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
public class RispostaBean extends BMPEntityBean implements IRisposta, IRispostaHome{
  long COD_RST;              //1
  String NOM_RST;            //2
  //----------------------------
  String DES_RST;            //3

 private RispostaBean() {}

  // (Home Interface) create()
  public IRisposta create(String strNOM_RST) throws CreateException
  {
  	 RispostaBean bean =  new  RispostaBean();
	   try{
	     Object primaryKey=bean.ejbCreate(strNOM_RST);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(strNOM_RST);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	RispostaBean iRispostaBean=new  RispostaBean();
    try	{
    	Object obj=iRispostaBean.ejbFindByPrimaryKey((Long)primaryKey);
        iRispostaBean.setEntityContext(new EntityContextWrapper(obj));
        iRispostaBean.ejbActivate();
        iRispostaBean.ejbLoad();
        iRispostaBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public IRisposta findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	RispostaBean bean =  new  RispostaBean();
  	try	{
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
  	try	{
   		return this.ejbFindAll();
  	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
	 public Collection getRisposta_View()
  {
  	return (new  RispostaBean()).ejbGetRisposta_View();
  }

public Collection findEx(String NOM, String DES, long iOrderBy)
  {
  	return (new  RispostaBean()).ejbfindEx(NOM, DES, iOrderBy);
  }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IRispostaHome-implementation>
  public Long ejbCreate(String strNOM_RST){
    this.NOM_RST=strNOM_RST;
    this.COD_RST=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_rst_tab (cod_rst,nom_rst) VALUES(?,?)");
         ps.setLong   (1, COD_RST);
         ps.setString (2, NOM_RST);
         ps.executeUpdate();
         return new Long(COD_RST);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNOM_RST) { }	
//--------------------------------------------------

  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_rst FROM ana_rst_tab ");
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
    this.COD_RST=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_RST=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_rst_tab  WHERE cod_rst=?");
           ps.setLong (1, COD_RST);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
		  	  	this.COD_RST=rs.getLong("COD_RST");
           	this.NOM_RST=rs.getString("NOM_RST");
  			    this.DES_RST=rs.getString("DES_RST");
           }
           else{
              throw new NoSuchEntityException("Risposta con ID= non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------


/*==========================================================*/
	
	 public Collection ejbGetRisposta_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_rst, nom_rst, des_rst  FROM ana_rst_tab ORDER BY nom_rst ");
					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Risposta_View obj=new Risposta_View();
            	obj.COD_RST=rs.getLong(1);
							obj.NOM_RST=rs.getString(2);
              obj.DES_RST=rs.getString(3);
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
 //////////### Kushkarov ### for Search ANA_RST ###///////////
 public Collection ejbfindEx(String NOM, String DES, long iOrderBy){
      String Sql="SELECT cod_rst, nom_rst, des_rst FROM ana_rst_tab  ";
			int i=1;
			int desIndex=0;
			int nomIndex=0;
			if(!"".equals(NOM))
			{
			  Sql+=" WHERE ";
			  Sql+=" UPPER(nom_rst) LIKE ? ";
			  nomIndex=i++;
			}
			if(!"".equals(DES))
			{
			  if (nomIndex!=0)
				{
				  Sql+=" AND ";
				}
				else
				{
				  Sql+=" WHERE ";
				}
			  Sql+=" UPPER(des_rst) LIKE ? ";
			  desIndex=i++;
			}
			Sql+=" ORDER BY nom_rst ";//+ (iOrderBy>0?" ASC": "DESC");
			BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(Sql);
          if(nomIndex!=0)
					{
					  ps.setString(nomIndex, NOM.toUpperCase()+"%");
					}
					if(desIndex!=0)
					{
					  ps.setString(desIndex, DES.toUpperCase()+"%");
					}
					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Risposta_View  obj=new Risposta_View();
            obj.COD_RST=rs.getLong(1);
						obj.NOM_RST=rs.getString(2);
            obj.DES_RST=rs.getString(3);
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


/*===========================================================*/
  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_rst_tab  WHERE cod_rst=?");
         ps.setLong (1, COD_RST);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Risposta con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_rst_tab  SET cod_rst=?, nom_rst=?, des_rst=?	 WHERE cod_rst=?");
         ps.setLong(1, COD_RST);
         ps.setString(2, NOM_RST);
         ps.setString(3, DES_RST);
         ps.setLong(4, COD_RST);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Risposta con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
	  public long getCOD_RST(){
      return COD_RST;
    }
  	//2
	  public void setNOM_RST(String newNOM_RST){
      if( NOM_RST.equals(newNOM_RST) ) return;
      NOM_RST = newNOM_RST;
      setModified();
    }
    public String getNOM_RST(){
      return NOM_RST;
    }
	//============================================
	// not required field
  	//3
  	public void setDES_RST(String newDES_RST){
      if(DES_RST!=null) {
			 if( DES_RST.equals(newDES_RST) ) return;
	    }
	    DES_RST = newDES_RST;
	    setModified();
    }
    public String getDES_RST(){
		  if(DES_RST==null)return "";
      return DES_RST;
    }
   //</comment>
	 


///////////ATTENTION!!/////////////////////////////////////////
}//<comment description="end of implementation  RispostaBean"/>
%>
<%
/////////////////////////// <BINDING> /////////////////
PseudoContext.bind("RispostaBean", new RispostaBean());
////////////////////////// </BINDING> /////////////////
%>
