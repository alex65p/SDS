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
// BASE TABLE: ANA_FRS_R_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  IFraseR extends EJBObject
//abstract class IFraseR extends BMPEntityBean
{
  //   *Require Fields*
  //1 COD_FRS_R (FraseR ID)
  public  long getCOD_FRS_R();
  //2 NUM_FRS_R (name)
  public  String getNUM_FRS_R();
  public  void setNUM_FRS_R(String newNUM_FRS_R);
  //3 DES_FRS_R (Description)
  public  String getDES_FRS_R();
  public  void setDES_FRS_R(String newDES_FRS_R);
  //   *Not require Fields*
  //4 VAL_INA ()
  public double getVAL_INA();
  public void setVAL_INA(double newVAL_INA);
  //5 VAL_CCP ()
  public double getVAL_CCP();
  public void setVAL_CCP(double newVAL_CCP);
  //6 VAL_ING ()
  public double getVAL_ING();
  public void setVAL_ING(double newVAL_ING);
  //7 VAL_IRR ()
  public double getVAL_IRR();
  public void setVAL_IRR(double newVAL_IRR);
  //8 VAL_ESP ()
  public double getVAL_ESP();
  public void setVAL_ESP(double newVAL_ESP);
  //9 VAL_UNI ()
  public double getVAL_UNI();
  public void setVAL_UNI(double newVAL_UNI);
}

//     Home Intrface EJB obiekta
public interface IFraseRHome extends EJBHome
//abstract class IFraseRHome extends  IFraseR
{
   public  IFraseR create(
  String strNUM_FRS_R,
  String strDES_FRS_R

   ) throws CreateException;
   public void remove(Object primaryKey);
   public  IFraseR findByPrimaryKey(Long primaryKey) throws FinderException;
   public  Collection findAll() throws FinderException;
	 public Collection findEx(  
											  String strNUM_FRS_R,
										    String strDES_FRS_R,
										    double lVAL_INA,
										    double lVAL_CCP,
										    double lVAL_ING,
										    double lVAL_IRR,
										    double lVAL_ESP,
										    double lVAL_UNI,
												int iOrderBy /*not used for now*/
										);
										

    //<report>
  	 public Collection getFraseR_View();
   //</report>

}

 //<report>
	class FraseR_View implements java.io.Serializable{
		public long lCOD_FRS_R;
		public String strNUM_FRS_R, strDES_FRS_R, strVAL_INA, strVAL_CCP, strVAL_ING, strVAL_IRR, strVAL_ESP, strVAL_UNI;
	}
//</report>

%>
