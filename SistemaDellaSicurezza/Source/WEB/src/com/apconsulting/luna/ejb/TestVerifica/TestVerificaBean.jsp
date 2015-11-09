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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>
				 <comment date="09/03/2004" author="Roman Chumachenko">
				   <description>Views for Reports</description>
				 </comment>
				  <comment date="29/01/2004" author="Mike Kondratyuk">
				   <description>Peredelal na FindEX()</description>
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

//public class TestVerificaBean extends BMPEntityBean implements ITestVerificaRemote
public class TestVerificaBean extends BMPEntityBean  implements ITestVerifica,ITestVerificaHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  String NOM_TES_VRF;   //1
  long COD_TES_VRF;     //2
  //-----------------------
  String DES_TES_VRF;   //3
  long NUM_MIN_PTG; 	//4
  long NUM_MAX_PTG;		//5

////////////////////// CONSTRUCTOR///////////////////
 private TestVerificaBean() { }
/////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
  // (Home Intrface) create()
  public ITestVerifica create(String strNOM_TES_VRF) throws CreateException
  {
 	 	TestVerificaBean bean =  new  TestVerificaBean();
	 	try{
	 		Object primaryKey=bean.ejbCreate(strNOM_TES_VRF);
	 		bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 		bean.ejbPostCreate(strNOM_TES_VRF);
    	return bean;
	 	}
	 	catch(Exception ex){
	 		ex.printStackTrace(System.err);
			throw new javax.ejb.CreateException(ex.getMessage());
  	}
	}
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	TestVerificaBean iTestVerificaBean=new  TestVerificaBean();
    try
	{
    	Object obj=iTestVerificaBean.ejbFindByPrimaryKey((Long)primaryKey);
        iTestVerificaBean.setEntityContext(new EntityContextWrapper(obj));
        iTestVerificaBean.ejbActivate();
        iTestVerificaBean.ejbLoad();
        iTestVerificaBean.ejbRemove();
    }
    catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public ITestVerifica findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	TestVerificaBean bean =  new  TestVerificaBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
	 		ex.printStackTrace(System.err);
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
	 		ex.printStackTrace(System.err);
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }


  // (Home Intrface) VIEWS  getTestVerifica_Name_Address_View()
  public Collection getTestVerifica_Name_Address_View()
  {
  	return (new  TestVerificaBean()).ejbGetTestVerifica_Name_Address_View();
 }

  public Collection getTestVerificaNames_View()
  {
  	return (new  TestVerificaBean()).ejbGetTestVerificaNames_View();
 }
  // (Home Intrface) VIEWS  getDomandeByTESVRFID_View()

 	public Collection getDomandeByTESVRFID_View(long TES_VRF_ID)
  {
  	return (new  TestVerificaBean()).ejbGetDomandeByTESVRFID_View(TES_VRF_ID);
 }





/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ITestVerificaHome-implementation>
  public Long ejbCreate(String strNOM_TES_VRF)
  {
    this.NOM_TES_VRF=strNOM_TES_VRF;
    this.COD_TES_VRF=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_tes_vrf_tab (cod_tes_vrf,nom_tes_vrf) VALUES(?,?)");
         ps.setLong   (1, COD_TES_VRF);
         ps.setString (2, NOM_TES_VRF);
         ps.executeUpdate();
         return new Long(COD_TES_VRF);
    }
    catch(Exception ex){
	 		ex.printStackTrace(System.err);
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String strNOM_TES_VRF) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tes_vrf FROM ana_tes_vrf_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
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
    this.COD_TES_VRF=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_TES_VRF=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_tes_vrf_tab  WHERE cod_tes_vrf=?");
           ps.setLong (1, COD_TES_VRF);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.NOM_TES_VRF=rs.getString("NOM_TES_VRF");
  			   			this.DES_TES_VRF=rs.getString("DES_TES_VRF");
								this.NUM_MIN_PTG=rs.getLong("NUM_MIN_PTG");
								this.NUM_MAX_PTG=rs.getLong("NUM_MAX_PTG");
           }
           else{
              throw new NoSuchEntityException("TestVerifica con ID= non è trovata");
           }
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_tes_vrf_tab  WHERE cod_tes_vrf=?");
          ps.setLong (1, COD_TES_VRF);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TestVerifica con ID= non è trovata");
      }
      catch(Exception ex)
	  	{
	 			ex.printStackTrace(System.err);
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_tes_vrf_tab  SET nom_tes_vrf=?, des_tes_vrf=?, num_min_ptg=?, num_max_ptg=? WHERE cod_tes_vrf=?");
          ps.setString(1, NOM_TES_VRF);
          ps.setString(2, DES_TES_VRF);
					ps.setLong(3, NUM_MIN_PTG);
					ps.setLong(4, NUM_MAX_PTG);
					ps.setLong  (5, COD_TES_VRF);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("TestVerifica con ID= non è trovata");
      }
      catch(Exception ex){
	 			ex.printStackTrace(System.err);
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

//<comment description="setter/getters">
	//1
  	 public void setNOM_TES_VRF(String newNOM_TES_VRF){
      if( NOM_TES_VRF.equals(newNOM_TES_VRF) ) return;
      NOM_TES_VRF = newNOM_TES_VRF;
      setModified();
    }
    public String getNOM_TES_VRF(){
      return NOM_TES_VRF;
    }
	//2
	public long getCOD_TES_VRF(){
      return COD_TES_VRF;
    }
	//============================================
	// not required field
	//3
	  public void setDES_TES_VRF(String newDES_TES_VRF){
      if(DES_TES_VRF!=null){
	      if( DES_TES_VRF.equals(newDES_TES_VRF) ) return;
      }
	  DES_TES_VRF = newDES_TES_VRF;
	  setModified();
    }
    public String getDES_TES_VRF(){
      return DES_TES_VRF;
    }

		//4
	  public void setNUM_MIN_PTG(long newNUM_MIN_PTG){
					 NUM_MIN_PTG = newNUM_MIN_PTG;
					 setModified();
    }
    public long getNUM_MIN_PTG(){
      return NUM_MIN_PTG;
    }

  	//5
	  public void setNUM_MAX_PTG(long newNUM_MAX_PTG){
					 NUM_MAX_PTG = newNUM_MAX_PTG;
					 setModified();
    }
    public long getNUM_MAX_PTG(){
      return NUM_MAX_PTG;
    }

    //-----------------------------#############################################
    // %%%Link%%% Table DMD_TES_VRF_TAB
    public void addCOD_DMD(long newCOD_DMD, long newNUM_PTG_DMD){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO dmd_tes_vrf_tab (cod_tes_vrf,cod_dmd,num_ptg_dmd) VALUES(?,?,?)");
           ps.setLong   (1, COD_TES_VRF);
           ps.setLong		(2, newCOD_DMD);
					 ps.setLong (3, newNUM_PTG_DMD);
           ps.executeUpdate();
           //return new Long(COD_DMD);
		      }
      catch(Exception ex){
	 			ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
    // %%%UNLink%%% Table DMD_TES_VRF_TAB
    public void removeCOD_DMD(long newCOD_DMD)
		{
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM dmd_tes_vrf_tab  WHERE cod_tes_vrf=? AND cod_dmd=?");
         ps.setLong (1, COD_TES_VRF);
         ps.setLong (2, newCOD_DMD);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Risposte con ID="+newCOD_DMD+" non &egrave trovata");
      }
      catch(Exception ex)
      {
	 			ex.printStackTrace(System.err);
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}

	public long sumNUM_PTG_DMD ()
	{
		long Sum=0;
		BMPConnection bmp=getConnection();
		try{
			PreparedStatement ps=bmp.prepareStatement("SELECT dmd_tes_vrf_tab.num_ptg_dmd FROM dmd_tes_vrf_tab WHERE dmd_tes_vrf_tab.cod_tes_vrf=?");
			ps.setLong(1, COD_TES_VRF);
			ResultSet rs=ps.executeQuery();
			java.util.ArrayList al=new java.util.ArrayList();
			while(rs.next()){
				Sum=Sum+rs.getLong(1);
			}
			bmp.close();
			return Sum;
		}
		catch(Exception ex){
	 		ex.printStackTrace(System.err);
			throw new EJBException(ex);
		}
		finally{
			bmp.close();
		}
	}

    //-----------------------------#############################################

   //</comment>

   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetTestVerifica_Name_Address_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tes_vrf,nom_tes_vrf,des_tes_Vrf FROM ANA_TES_VRF_tab ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TestVerifica_Name_Address_View obj=new TestVerifica_Name_Address_View();
            obj.COD_TES_VRF=rs.getLong(1);
						obj.NOM_TES_VRF=rs.getString(2);
						obj.DES_TES_VRF=rs.getString(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
	 			ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

	public Collection ejbGetTestVerificaNames_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_tes_vrf,nom_tes_vrf,des_tes_vrf,num_min_ptg,num_max_ptg FROM ana_tes_vrf_tab ORDER BY nom_tes_vrf");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TestVerificaNames_View obj=new TestVerificaNames_View();
            obj.COD_TES_VRF=rs.getLong(1);
						obj.NOM_TES_VRF=rs.getString(2);
						obj.DES_TES_VRF=rs.getString(3);
						obj.NUM_MIN_PTG=rs.getLong(4);
						obj.NUM_MAX_PTG=rs.getLong(5);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
	 			ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

//--- select from domande
  public Collection ejbGetDomandeByTESVRFID_View(long COD_TES_VRF_ID){
      BMPConnection bmp=getConnection();
      try{
					PreparedStatement ps=bmp.prepareStatement("SELECT dmd_tes_vrf_tab.cod_dmd, ana_dmd_tab.nom_dmd, dmd_tes_vrf_tab.num_ptg_dmd FROM ana_dmd_tab, dmd_tes_vrf_tab WHERE ana_dmd_tab.cod_dmd = dmd_tes_vrf_tab.cod_dmd AND  dmd_tes_vrf_tab.cod_tes_vrf=? ORDER BY ana_dmd_tab.nom_dmd ");
          ps.setLong(1, COD_TES_VRF_ID);

					ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DomandeByTESVRFID_View obj=new DomandeByTESVRFID_View();
            obj.COD_DMD=rs.getLong(1);
            obj.NOM_DMD=rs.getString(2);
            obj.NUM_PTG_DMD=rs.getLong(3);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //----------
  //</comment>

  // --- Report ---
  public long getTotaleDomande(){
      BMPConnection bmp=getConnection();
      long result=0;
	  try{
		PreparedStatement ps=bmp.prepareStatement(
		"SELECT COUNT(cod_dmd) FROM dmd_tes_vrf_tab "+
        "WHERE cod_tes_vrf = ? "
		);
        ps.setLong(1, COD_TES_VRF);
		ResultSet rs=ps.executeQuery();
        while(rs.next()){
        	result=rs.getLong(1);
        }
        bmp.close();
        return result;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
        throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //------------------------------
  public Collection getTestDomandi_List_View(){
  BMPConnection bmp=getConnection();
      try{
		PreparedStatement ps=bmp.prepareStatement(
		"SELECT a.COD_DMD, a.nom_dmd "+
		"FROM ana_dmd_tab a, dmd_tes_vrf_tab b WHERE (a.cod_dmd = b.cod_dmd AND b.cod_tes_vrf=? )"
		);
        ps.setLong(1, COD_TES_VRF);
		ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          TES_TestDR_List_View obj=new TES_TestDR_List_View();
          obj.COD_DMD=rs.getLong(1);
          obj.NOM_DMD=rs.getString(2);
          obj.NOM_RST="";
          al.add(obj);
        }
        bmp.close();
        return al;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //---------------------------------------------------
  public Collection getTestDomandeRisposti_List_View(long lCOD_DMD){
  BMPConnection bmp=getConnection();
      try{
		PreparedStatement ps=bmp.prepareStatement(
		"SELECT a.nom_rst "+
		"FROM ana_rst_tab a, rst_dmd_tab b WHERE (a.cod_rst = b.cod_rst AND b.cod_dmd = ? )"
		);
        ps.setLong(1, lCOD_DMD);
		ResultSet rs=ps.executeQuery();
        java.util.ArrayList al=new java.util.ArrayList();
        while(rs.next()){
          TES_TestDR_List_View obj=new TES_TestDR_List_View();
          obj.COD_DMD=lCOD_DMD;
          obj.NOM_DMD="";
          obj.NOM_RST=rs.getString(1);
          al.add(obj);
        }
        bmp.close();
        return al;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //---------------------------------------------------

	public Collection findEx(	String strNOM_TES_VRF,
   								String strDES_TES_VRF,
   								Long lNUM_MIN_PTG,
   								Long lNUM_MAX_PTG,
								int 	iOrderParameter /*not used for now*/
										){
		return (new TestVerificaBean()).ejbFindEx(strNOM_TES_VRF,
   								strDES_TES_VRF,
   								lNUM_MIN_PTG,
   								lNUM_MAX_PTG,
								iOrderParameter);
	}

	public Collection ejbFindEx(String strNOM_TES_VRF,
   								String strDES_TES_VRF,
   								Long lNUM_MIN_PTG,
   								Long lNUM_MAX_PTG,
								int 	iOrderParameter /*not used for now*/
								){
	  String strSql = "SELECT cod_tes_vrf,nom_tes_vrf,des_tes_vrf,num_min_ptg,num_max_ptg FROM ana_tes_vrf_tab WHERE ";
	  if (strNOM_TES_VRF != null){
	  	strSql += "UPPER(nom_tes_vrf) LIKE ? AND   ";
	  }
	  if (strDES_TES_VRF != null){
	  	strSql += "UPPER(des_tes_vrf) LIKE ? AND   ";
	  }
	  if (lNUM_MIN_PTG != null){
	  	strSql += "num_min_ptg = ? AND   ";
	  }
	  if (lNUM_MAX_PTG != null){
	  	strSql += "num_max_ptg = ? AND   ";
	  }
	  strSql=strSql.substring(0,strSql.length()- 6);
	  strSql += " ORDER BY UPPER(nom_tes_vrf)";

	  int i = 1;

      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement(strSql);
		  if (strNOM_TES_VRF != null){
		  	ps.setString(i++, strNOM_TES_VRF.toUpperCase());
		  }
		  if (strDES_TES_VRF != null){
		  	ps.setString(i++, strDES_TES_VRF.toUpperCase());
		  }
		  if (lNUM_MIN_PTG != null){
		  	ps.setLong(i++, lNUM_MIN_PTG.longValue());
		  }
		  if (lNUM_MAX_PTG != null){
		  	ps.setLong(i++, lNUM_MAX_PTG.longValue());
		  }
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            TestVerificaNames_View obj=new TestVerificaNames_View();
            obj.COD_TES_VRF=rs.getLong(1);
			obj.NOM_TES_VRF=rs.getString(2);
			obj.DES_TES_VRF=rs.getString(3);
			obj.NUM_MIN_PTG=rs.getLong(4);
			obj.NUM_MAX_PTG=rs.getLong(5);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
	 		ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
	  finally{bmp.close();}
	}

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  TestVerificaBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////
PseudoContext.bind("TestVerificaBean", new TestVerificaBean());//////////
////////////////////////////////////////// </BINDING> ///////////////////
%>
