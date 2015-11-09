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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="24/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class FraseSBean extends BMPEntityBean implements IFraseS, IFraseSHome
{
  //<comment description="Member Variables">
  long   COD_FRS_S;            //1
  String NUM_FRS_S;            //2
  String DES_FRS_S;            //3
  //------------------------------
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private FraseSBean(){}
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IFraseS create(String strNUM_FRS_S, String strDES_FRS_S) throws CreateException
  {
 	 FraseSBean bean =  new  FraseSBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strNUM_FRS_S, strDES_FRS_S);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strNUM_FRS_S, strDES_FRS_S);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	FraseSBean iFraseSBean=new  FraseSBean();
    try
	{
    	Object obj=iFraseSBean.ejbFindByPrimaryKey((Long)primaryKey);
        iFraseSBean.setEntityContext(new EntityContextWrapper(obj));
        iFraseSBean.ejbActivate();
        iFraseSBean.ejbLoad();
        iFraseSBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex); 
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IFraseS findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	FraseSBean bean =  new  FraseSBean();
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
 
 
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IFraseSHome-implementation>
  public Long ejbCreate(String strNUM_FRS_S, String strDES_FRS_S)
  {
    this.NUM_FRS_S=strNUM_FRS_S;
    this.DES_FRS_S=strDES_FRS_S;
		this.COD_FRS_S=NEW_ID(); // unic ID
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_frs_s_tab (cod_frs_s,num_frs_s,des_frs_s) VALUES(?,?,?)");
         ps.setLong   (1, COD_FRS_S);
         ps.setString (2, NUM_FRS_S);
         ps.setString (3, DES_FRS_S);
         ps.executeUpdate();
         return new Long(COD_FRS_S);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strNUM_FRS_S, String strDES_FRS_S) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_frs_s FROM ana_frs_s_tab ");
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
    this.COD_FRS_S=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_FRS_S=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_frs_s_tab  WHERE cod_frs_s=?");
           ps.setLong (1, COD_FRS_S);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
           this.NUM_FRS_S=rs.getString("NUM_FRS_S");
  			   this.DES_FRS_S=rs.getString("DES_FRS_S");
           }
           else{
              throw new NoSuchEntityException("FraseS con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_frs_s_tab  WHERE cod_frs_s=?");
          ps.setLong (1, COD_FRS_S);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("FraseS con ID= non è trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_frs_s_tab  SET num_frs_s=?, des_frs_s=? WHERE cod_frs_s=?");
          ps.setString(1, NUM_FRS_S);
          ps.setString(2, DES_FRS_S);
		      ps.setLong  (3, COD_FRS_S);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("FraseS con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------
   //<report>
  	 public Collection getFraseS_View(){
	 	return this.ejbGetFraseS_View();
	 }
	 
	 public Collection ejbGetFraseS_View(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT s.cod_frs_s, s.num_frs_s, s.des_frs_s FROM ana_frs_s_tab s ORDER BY s.num_frs_s");
           ResultSet rs=ps.executeQuery();
		   ArrayList al= new ArrayList();
           while(rs.next()){
           		FraseS_View w= new FraseS_View();
				w.lCOD_FRS_S=rs.getLong(1);
				w.strNUM_FRS_S=rs.getString(2);
				w.strDES_FRS_S=rs.getString(3);
				
				al.add(w);
           }
			return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
	 }
   //</report>
	
//=============by Juli======
   	public Collection findEx(Long lCOD_FRS_S, String strNUM_FRS_S, String strDES_FRS_S, int iOrderBy)
   	{
    	return ejbFindEx(lCOD_FRS_S, strNUM_FRS_S, strDES_FRS_S, iOrderBy);
    }
	//
	public Collection ejbFindEx(Long lCOD_FRS_S, String strNUM_FRS_S, String strDES_FRS_S, int iOrderBy)
	{
            String strSql="SELECT cod_frs_s, num_frs_s, des_frs_s FROM ana_frs_s_tab WHERE cod_frs_s<>0 ";
            if(lCOD_FRS_S!=null){
                strSql+=" AND cod_frs_s=? ";
            }
            if(strNUM_FRS_S!=null){
                strSql+=" AND UPPER(num_frs_s) LIKE ? ";
            }
            if(strDES_FRS_S!=null){
                strSql+=" AND UPPER(des_frs_s) LIKE ? ";
            }
            //strSql=strSql.substring(1,strSql.length()- 6);
            strSql+=" ORDER BY cod_frs_s "+ (iOrderBy>0?" ASC": " DESC");
            int i=1;
            BMPConnection bmp=getConnection();
             try{
                    
					PreparedStatement ps=bmp.prepareStatement(strSql);
                   
					if(lCOD_FRS_S!=null){
                        ps.setLong(i++, lCOD_FRS_S.longValue());
                    }
                    if(strNUM_FRS_S!=null){
                        ps.setString(i++, strNUM_FRS_S);
                    } 
                    if(strDES_FRS_S!=null){
                        ps.setString(i++, strDES_FRS_S);
                    }
					/**/
				   //----------------------------------------------------------------------
                   ResultSet rs=ps.executeQuery();
                   java.util.ArrayList ar= new java.util.ArrayList();
                   while(rs.next()){
                        FraseS_View v=new FraseS_View();
                        v.lCOD_FRS_S=rs.getLong(1);
                        v.strNUM_FRS_S=rs.getString(2);
                        v.strDES_FRS_S=rs.getString(3);
                        ar.add(v);
                   }
                    return ar;
                   //----------------------------------------------------------------------
          }
          catch(Exception ex){
              throw new EJBException(ex);
          }
          finally{bmp.close();}
    }


/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">  
	//1
  	 public void setNUM_FRS_S(String newNUM_FRS_S){
      if( NUM_FRS_S.equals(newNUM_FRS_S) ) return;
      NUM_FRS_S = newNUM_FRS_S;
      setModified();
    }
    public String getNUM_FRS_S(){
      return NUM_FRS_S;
    }
	//2
  	 public void setDES_FRS_S(String newDES_FRS_S){
      if( DES_FRS_S.equals(newDES_FRS_S) ) return;
      DES_FRS_S = newDES_FRS_S;
      setModified();
    }
    public String getDES_FRS_S(){
      return DES_FRS_S;
    }
	//3
    public long getCOD_FRS_S(){
      return COD_FRS_S;
    }
	//============================================
	// not required field

   //</comment>
  
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  FraseSBean"/>
%>
<%
//////////////////// <BINDING> ////////////////////
PseudoContext.bind("FraseSBean", new FraseSBean());
//////////////////// </BINDING> ///////////////////
%>
