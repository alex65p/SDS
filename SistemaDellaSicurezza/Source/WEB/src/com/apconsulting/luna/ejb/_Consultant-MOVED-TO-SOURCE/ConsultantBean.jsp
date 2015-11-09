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
    <version number="1.0" date="14/01/2004" author="Roman Chumachenko">
	    <comments>
				  <comment date="14/01/2004" author="Roman Chumachenko">
				   <description>ConsultantBean.jsp</description>
				 </comment>
		         <comment date="03/02/2004" author="Pogrebnoy Yura">
                    <description>getAziendeAssociateByCOUID, addCOD_AZL, removeCOD_AZL</description>
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
<%@ page import="java.sql.*"%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class ConsultantBean extends BMPEntityBean implements IConsultantHome, IConsultant
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  String USD_COU;     //1
  String PSW_COU;     //2
  String STA_COU;     //3
  String NOM_COU;     //4
  String RUO_COU;     //5
  long COD_COU;       //6
  //-------------------------
  java.sql.Date DAT_ATT; //7
  java.sql.Date DAT_DIS; //8
  //</comment>
  
  public static final String BEAN_NAME="ConsultantBean";
 
////////////////////// CONSTRUCTOR///////////////////
 private ConsultantBean()
  {
	//System.err.println("ConsultantBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IConsultant create(String strUSD_COU,String strPSW_COU,String strSTA_COU,String strNOM_COU) throws CreateException
  {
 	 ConsultantBean bean =  new  ConsultantBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strUSD_COU, strPSW_COU, strSTA_COU, strNOM_COU);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strUSD_COU, strPSW_COU, strSTA_COU, strNOM_COU);
     return bean;
	 }
	 catch(Exception ex){
	 	ex.printStackTrace();
    throw new javax.ejb.CreateException(ex.getMessage());
  }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	ConsultantBean iConsultantBean=new ConsultantBean();
    try
	{
    	Object obj=iConsultantBean.ejbFindByPrimaryKey((Long)primaryKey);
        iConsultantBean.setEntityContext(new EntityContextWrapper(obj));
        iConsultantBean.ejbActivate();
        iConsultantBean.ejbLoad();
        iConsultantBean.ejbRemove();
    }
    catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex.getMessage());
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public  IConsultant findByPrimaryKey(String strConsultant) throws FinderException
  {
    ConsultantBean bean =  new  ConsultantBean();
	try
	{
   		Object primaryKey=bean.ejbFindByPrimaryKey(strConsultant);
		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
	 	ex.printStackTrace();
        throw new javax.ejb.FinderException(ex.getMessage());
    } 	
  }
  
  public IConsultant findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	ConsultantBean bean =  new  ConsultantBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
	 	ex.printStackTrace();
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
	 	ex.printStackTrace();
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS  getConsultant_Nominativo_Funzione_DAT_DIS_View()
  public Collection getConsultantiByAZLID_View(long AZL_ID){
  	return (new ConsultantBean()).ejbGetConsultantiByAZLID_View(AZL_ID);
  }
 public Collection getConsultant_View(){
  	return (new ConsultantBean()).ejbGetConsultant_View();
 }
 
 public Collection getConsultantUTN_View(){
  	return (new ConsultantBean()).ejbGetConsultantUTN_View();
 }
 
 public Collection getAziendeAssociateByCOUID_View(String COD_COU){
  return (new ConsultantBean()).ejbGetAziendeAssociateByCOUID_View(COD_COU);
 } 
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IAziendaHome-implementation>
  public Long ejbCreate(String strUSD_COU,String strPSW_COU,String strSTA_COU,String strNOM_COU)
  {
    this.USD_COU=strUSD_COU;
    this.PSW_COU=strPSW_COU;
    this.STA_COU=strSTA_COU;
	this.NOM_COU=strNOM_COU;
	this.COD_COU=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_cou_tab (cod_cou,usd_cou, psw_cou, sta_cou, nom_cou) VALUES(?,?,?,?,?)");
         ps.setLong   (1, COD_COU);
         ps.setString (2, USD_COU);
         ps.setString (3, PSW_COU);
         ps.setString (4, STA_COU);
         ps.setString (5, NOM_COU);
         ps.executeUpdate();
         return new Long(COD_COU);
    }
    catch(Exception ex){
	 	ex.printStackTrace();
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strUSD_COU,String strPSW_COU,String strSTA_COU,String strNOM_COU) { }	
//--------------------------------------------------

 public Long ejbFindByPrimaryKey(String strConsultant){
	  BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cou FROM ana_cou_tab WHERE usd_cou=? ");
		  ps.setString(1, strConsultant);
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          if(rs.next()){
            return new Long(rs.getLong(1));
          }else{
		  		throw new NoSuchEntityException("Consultante con nome="+strConsultant+" non è trovata");
		  }
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
      finally{bmp.close();}	
 }
	
  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cou FROM ana_cou_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
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
    this.COD_COU=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_COU=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_cou_tab  WHERE cod_cou=?");
           ps.setLong (1, COD_COU);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.USD_COU=rs.getString("USD_COU"); //1
  			   	this.PSW_COU=rs.getString("PSW_COU"); //2
    		 	this.STA_COU=rs.getString("STA_COU"); //3
	  			this.NOM_COU=rs.getString("NOM_COU"); //4
  				//-------------------------
			  	this.RUO_COU=rs.getString("RUO_COU"); //5
			  	this.DAT_ATT=rs.getDate("DAT_ATT");   //6
				this.DAT_DIS=rs.getDate("DAT_DIS");   //7
				
           }
           else{
              throw new NoSuchEntityException("Consultante con ID="+COD_COU+" non è trovata");
           }
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove()
  {
		BMPConnection bmp=getConnection();
		try
		{
			PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_cou_tab  WHERE cod_cou=?");
			ps.setLong (1, COD_COU);
			if(ps.executeUpdate()==0) throw new NoSuchEntityException("Consultant con ID= non è trovata");
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			throw new EJBException(ex);
		}
		finally{
			bmp.close();
		}
  }  
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_cou_tab  SET usd_cou=?, psw_cou=?, sta_cou=?,dat_att=?,dat_dis=?,nom_cou=?,ruo_cou=?  WHERE cod_cou=?");
          ps.setString(1, USD_COU);
          ps.setString(2, PSW_COU);
          ps.setString(3, STA_COU);
          ps.setDate  (4, DAT_ATT);
		  ps.setDate  (5, DAT_DIS);
		  ps.setString(6, NOM_COU);
		  ps.setString(7, RUO_COU);
		  ps.setLong  (8, COD_COU);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Consultant con ID= non è trovata");
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">  
	//1
  	public void setUSD_COU(String newUSD_COU){
      if( USD_COU.equals(newUSD_COU) ) return;
      USD_COU = newUSD_COU;
	  setModified();
    }
    public String getUSD_COU(){
      if(USD_COU==null)
	  {return "";}else{return USD_COU;}
    }
	//2
	public void setPSW_COU(String newPSW_COU){
      if( PSW_COU.equals(newPSW_COU) ) return;
      PSW_COU = newPSW_COU;
	  setModified();
    }
	public String getPSW_COU(){
      if(PSW_COU==null)
	  {return "";}else{return PSW_COU;}
    }
	//3
	public void setSTA_COU(String newSTA_COU){
      if( STA_COU.equals(newSTA_COU) ) return;
      STA_COU = newSTA_COU;
	  setModified();
    }
	public String getSTA_COU(){
	  if(STA_COU==null)
	  {return "";}else{return STA_COU;}
    }
	//4
	public void setNOM_COU(String newNOM_COU){
      if( NOM_COU.equals(newNOM_COU) ) return;
      NOM_COU = newNOM_COU;
	  setModified();
    }
	public String getNOM_COU(){
	  if(NOM_COU==null)
	  {return "";}else{return NOM_COU;}
    }
	public long getCOD_COU(){
      return COD_COU;
    }
	//============================================
	// not required field
	//5
  	public void setRUO_COU(String newRUO_COU){
      if(RUO_COU!=null){
	  	if( RUO_COU.equals(newRUO_COU) ) return;
	  }
	  RUO_COU = newRUO_COU;
	  setModified();
    }
	public String getRUO_COU(){
	  if(RUO_COU==null)
	  {return "";}else{return RUO_COU;}
    }
	//6
  	public void setDAT_ATT(java.sql.Date newDAT_ATT){
      if(DAT_ATT!=null){
	  	if( DAT_ATT.equals(newDAT_ATT) ) return;
	  }
	  DAT_ATT = newDAT_ATT;
	  setModified();
    }
	public java.sql.Date getDAT_ATT(){
      return DAT_ATT;
    }
	//7
  	public void setDAT_DIS(java.sql.Date newDAT_DIS){
      if(DAT_DIS!=null){
	  	if( DAT_DIS.equals(newDAT_DIS) ) return;
	  }
	  DAT_DIS = newDAT_DIS;
	  setModified();
    }
	public java.sql.Date getDAT_DIS(){
      return DAT_DIS;
    }
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   //-----------------------------#############################################
   // %%%Link%%% Table AZL_COU_TAB
    public void addCOD_AZL(long newCOD_AZL){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO azl_cou_tab (cod_cou,cod_azl) VALUES(?,?)");
           ps.setLong   (1, COD_COU);
           ps.setLong           (2, newCOD_AZL);
           ps.executeUpdate();
           //return new Long(COD_COU);
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
      finally{bmp.close();}
                }
    // %%%UNLink%%% Table AZL_COU_TAB
    public void removeCOD_AZL(String newCOD_COU,String newCOD_AZL){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM azl_cou_tab  WHERE cod_cou=? AND cod_azl=?");
         ps.setString (1, newCOD_COU);
         ps.setString (2, newCOD_AZL);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Azienda con ID="+newCOD_AZL+" non &egrave trovata");
      }
      catch(Exception ex)
      {
	 	ex.printStackTrace();
         throw new EJBException(ex);
      }
      finally{bmp.close();}
   }
    
    public long getAZL_COU_TABCount(){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "select " +
                    "count(b.cod_cou) as cou_count " +
                "from " +
                    "ana_azl_tab a, " +
                    "ana_cou_tab b, " +
                    "azl_cou_tab c " +
                "where " +
                    "a.cod_azl = c.cod_azl " +
                    "and b.cod_cou = c.cod_cou");
            ResultSet rs = ps.executeQuery();
            rs.next();
            return rs.getLong("cou_count");
        }    
        catch(Exception ex){
            ex.printStackTrace();
            throw new EJBException(ex);
        }
        finally{
            bmp.close();
        }
    }
    
   //--- select from aziende
   public Collection ejbGetAziendeAssociateByCOUID_View(String COD_COU){
       BMPConnection bmp=getConnection();
      try{
        PreparedStatement ps=bmp.prepareStatement("SELECT a.rag_scl_azl, a.nom_rsp_azl, a.nom_rsp_spp_azl, a.cod_azl  FROM azl_cou_tab b, ana_azl_tab a WHERE a.cod_azl=b.cod_azl AND b.cod_cou=? ");
        ps.setString(1, COD_COU);
                                ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          AziendeAssociateByCOUID_View obj=new AziendeAssociateByCOUID_View();
          obj.RAG_SCL_AZL=rs.getString(1);
          obj.NOM_RSP_AZL=rs.getString(2);
          obj.NOM_RSP_SPP_AZL=rs.getString(3);
          obj.COD_AZL=rs.getLong(4);
          al.add(obj);
        }
        bmp.close();
        return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //-------------------
   //-----------------------------#############################################
   //<comment description="extended setters/getters">
    public Collection getAziende(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
			"SELECT ana_azl_tab.cod_azl, ana_azl_tab.rag_scl_azl "
			+" FROM ana_azl_tab, azl_cou_tab"
			+" WHERE ana_azl_tab.cod_azl = azl_cou_tab.cod_azl"
			+" AND azl_cou_tab.cod_cou= ? ORDER BY 2"
		  );
		  ps.setLong(1, COD_COU);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            ConsultantAzienda_Id_Name_View obj=new ConsultantAzienda_Id_Name_View();
            obj.COD_AZL=rs.getLong(1);  
            obj.RAG_SCL_AZL=rs.getString(2);
			al.add(obj);
          }
          return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
   
    public Collection getAziendeMOD_CLC_RSO(short sMOD_CLC_RSO){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(
			"SELECT ana_azl_tab.cod_azl, ana_azl_tab.rag_scl_azl "
			+" FROM ana_azl_tab, azl_cou_tab"
			+" WHERE ana_azl_tab.cod_azl = azl_cou_tab.cod_azl"
			+" AND azl_cou_tab.cod_cou= ?" 
                        +" AND mod_clc_rso= ?" 
                        +" ORDER BY 2"
		  );
		  ps.setLong(1, COD_COU);
		  ps.setShort(2, sMOD_CLC_RSO);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            ConsultantAzienda_Id_Name_View obj=new ConsultantAzienda_Id_Name_View();
            obj.COD_AZL=rs.getLong(1);  
            obj.RAG_SCL_AZL=rs.getString(2);
			al.add(obj);
          }
          return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
            
      public Collection ejbGetConsultantiByAZLID_View(long AZL_ID){
       BMPConnection bmp=getConnection();
      try{
			  PreparedStatement ps=bmp.prepareStatement(
			  	"SELECT ana_cou_tab.cod_cou as cod_cou ,ana_cou_tab.nom_cou as nom_cou, "+
					" ana_cou_tab.ruo_cou as ruo_cou,ana_cou_tab.dat_att as dat_att, "+
					" ana_cou_tab.dat_dis as dat_dis "+
					"FROM ana_cou_tab, azl_cou_tab "+
					"WHERE ana_cou_tab.cod_cou = azl_cou_tab.cod_cou AND  azl_cou_tab.cod_azl=? "+
					"ORDER BY ana_cou_tab.nom_cou");	
				ps.setLong(1, AZL_ID);

        ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
					ConsultantiByAZLID_View obj=new ConsultantiByAZLID_View();
					obj.COD_COU=rs.getLong(1);  
					obj.NOM_COU=rs.getString(2);
					obj.RUO_COU=rs.getString(3);
					obj.DAT_ATT=rs.getDate(4);  
					obj.DAT_DIS=rs.getDate(5);  
					al.add(obj);
        }
        return al;
      }
      catch(Exception ex){
	 			ex.printStackTrace();
        throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  
	public Collection ejbGetConsultant_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_cou, nom_cou , ruo_cou, dat_att, dat_dis FROM ana_cou_tab ORDER BY nom_cou");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            ConsultantiByAZLID_View obj=new ConsultantiByAZLID_View();
            obj.COD_COU=rs.getLong(1);  
            obj.NOM_COU=rs.getString(2);
            obj.RUO_COU=rs.getString(3);
            obj.DAT_ATT=rs.getDate(4);  
            obj.DAT_DIS=rs.getDate(5);  
      			al.add(obj);
          }
          return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  
	public Collection findEx(String strNOM_COU, String strUSD_COU, String strRUO_COU, String strSTA_COU, java.sql.Date dDAT_ATT, java.sql.Date dDAT_DIS, int iOrderParameter){
		return ejbFindEx(strNOM_COU, strUSD_COU, strRUO_COU, strSTA_COU, dDAT_ATT, dDAT_DIS, iOrderParameter);
	}
 	public Collection ejbFindEx(String strNOM_COU, String strUSD_COU, String strRUO_COU, String strSTA_COU, java.sql.Date dDAT_ATT, java.sql.Date dDAT_DIS, int iOrderParameter){
		String strSql="SELECT cod_cou, UPPER(nom_cou) AS nom_cou, ruo_cou, dat_att, dat_dis FROM ana_cou_tab WHERE sta_cou = ? ";
    if ("".equals(strSTA_COU)){
		  strSql += " OR sta_cou = 'D' ";
			strSTA_COU = "A";
    }
		if (strNOM_COU != null)	strSql += " AND UPPER(nom_cou) LIKE ? ";
		if (strUSD_COU != null)	strSql += " AND UPPER(usd_cou) LIKE ? ";
		if (strRUO_COU != null)	strSql += " AND UPPER(ruo_cou) LIKE ? ";
		if (dDAT_ATT != null) strSql += " AND dat_att = ? ";
		if (dDAT_DIS != null) strSql += " AND dat_dis = ? ";

		strSql += " ORDER BY 2 ";
                int i = 2;
		BMPConnection bmp=getConnection();
	     try{
				PreparedStatement ps=bmp.prepareStatement(strSql);
				ps.setString (1, strSTA_COU);
				if(strNOM_COU != null)ps.setString(i++, strNOM_COU.toUpperCase());
				if(strUSD_COU != null)ps.setString(i++, strUSD_COU.toUpperCase());
				if(strRUO_COU != null)ps.setString(i++, strRUO_COU.toUpperCase());
				if(dDAT_ATT != null)ps.setDate(i++, dDAT_ATT);
				if(dDAT_DIS != null)ps.setDate(i++, dDAT_DIS);
				
			  ResultSet rs=ps.executeQuery();
        java.util.ArrayList ar= new java.util.ArrayList();
        while(rs.next()){
          ConsultantiByAZLID_View obj=new ConsultantiByAZLID_View();
           obj.COD_COU = rs.getLong(1);
           obj.NOM_COU = rs.getString(2);
           obj.RUO_COU = rs.getString(3);
					 obj.DAT_ATT = rs.getDate(4);
					 obj.DAT_DIS = rs.getDate(5);
          ar.add(obj);
        }
			  return ar;
	     }catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException("STA_COU= "+strSTA_COU+"\n"+strSql+"\n"+ex);
       }
	     finally { bmp.close(); }
	}

	
	public Collection ejbGetConsultantUTN_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT usd_cou FROM ana_cou_tab ORDER BY usd_cou");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            ConsultantiUSD_UTN_View obj=new ConsultantiUSD_UTN_View();
            obj.USD_COU=rs.getString(1);  
      			al.add(obj);
          }
          return al;
      }
      catch(Exception ex){
	 	ex.printStackTrace();
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //-------------------
  //</comment>         

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AziendaBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("ConsultantBean", new ConsultantBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
