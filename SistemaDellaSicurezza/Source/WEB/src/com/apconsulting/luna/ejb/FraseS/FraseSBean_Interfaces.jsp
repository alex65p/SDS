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
// BASE TABLE: ANA_FRS_S_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IFraseS extends EJBObject
{
  //   *Require Fields*
  //1 COD_FRS_S (FraseS ID)
  public  long getCOD_FRS_S();
  //2 NUM_FRS_S (name)
  public  String getNUM_FRS_S();
  public  void setNUM_FRS_S(String newNUM_FRS_S);
  //3 DES_FRS_S (Description)
  public  String getDES_FRS_S();
  public  void setDES_FRS_S(String newDES_FRS_S);
  //   *Not require Fields*
}

//     Home Intrface EJB obiekta 
public interface IFraseSHome extends EJBHome
{
   public  IFraseS create(
  String strNUM_FRS_S,
  String strDES_FRS_S

   ) throws CreateException;
   public void remove(Object primaryKey);
   public  IFraseS findByPrimaryKey(Long primaryKey) throws FinderException;
   public  Collection findAll() throws FinderException;
   //<report>
   public Collection getFraseS_View();
   public Collection findEx(  
       Long lCOD_FRS_S,
       String strNUM_FRS_S,
       String strDES_FRS_S,
       int iOrderBy
	);
   //</report>
}
 //<report>
	class FraseS_View implements java.io.Serializable{
		public long lCOD_FRS_S;
		public String strNUM_FRS_S, strDES_FRS_S;
	}
//</report>

%>
