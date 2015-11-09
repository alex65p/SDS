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
// BASE TABLE: ANA_TES_VRF_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  ITestVerifica extends EJBObject
public interface ITestVerifica extends EJBObject
{
  //   *Require Fields*
  //1 COD_TES_VRF (TestVerifica ID)
  public long getCOD_TES_VRF();

  //2 NOM_TES_VRF (name)
  public String getNOM_TES_VRF();
  public void setNOM_TES_VRF(String newNOM_TES_VRF);

  //   *Not require Fields*
  //3 DES_TES_VRF (descr)
  public String getDES_TES_VRF();
  public void setDES_TES_VRF (String newDES_TES_VRF);
  //4 NUM_MIN_PTG
  public long getNUM_MIN_PTG();
  public void setNUM_MIN_PTG (long newNUM_MIN_PTG);
  //4 NUM_MAX_PTG
  public long getNUM_MAX_PTG();
  public void setNUM_MAX_PTG (long newNUM_MAX_PTG);
  //
  public void addCOD_DMD(long newCOD_DMD, long newNUM_PTG_DMD);
  public void removeCOD_DMD(long newCOD_DMD);
  public long sumNUM_PTG_DMD();

  // --- Report ---
  public long getTotaleDomande();
  public Collection getTestDomandi_List_View();
  public Collection getTestDomandeRisposti_List_View(long lCOD_DMD);
  
}

//     Home Intrface EJB obiekta 
//public interface ITestVerificaHome extends EJBHome
public interface ITestVerificaHome extends  ITestVerifica
{
   public ITestVerifica create(String strNOM_TES_VRF) throws CreateException;
   public void remove(Object primaryKey);
   public ITestVerifica findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getTestVerifica_Name_Address_View() throws FinderException;
   public Collection getDomandeByTESVRFID_View(long TES_VRF_ID);
   public Collection getTestVerificaNames_View();
   public Collection findEx(	
   	String strNOM_TES_VRF,
   	String strDES_TES_VRF,
   	Long lNUM_MIN_PTG,
   	Long lNUM_MAX_PTG,
	int iOrderParameter
   );
}

/*public*/
// view metodi   
class TestVerifica_Name_Address_View implements java.io.Serializable{
	public long COD_TES_VRF;
	public String NOM_TES_VRF;
	public String DES_TES_VRF;
}
//
class TestVerificaNames_View implements java.io.Serializable{
	public long COD_TES_VRF, NUM_MIN_PTG, NUM_MAX_PTG;
	public String NOM_TES_VRF;
	public String DES_TES_VRF;
}
//
class DomandeByTESVRFID_View implements java.io.Serializable{
	public long COD_DMD, NUM_PTG_DMD;
	public String NOM_DMD;
}
//--- Report ---
class TES_TestDR_List_View implements java.io.Serializable{
	public long COD_DMD;
	public String NOM_DMD, NOM_RST;
}
//--------------------------------------------------------------------
%>
