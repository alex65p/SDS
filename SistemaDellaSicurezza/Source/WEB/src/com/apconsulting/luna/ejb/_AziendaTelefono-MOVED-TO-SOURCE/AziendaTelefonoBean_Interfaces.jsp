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
				   <description>AziendaTelefonoBean_Interfaces.jsp</description>
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
// BASE TABLE: ANA_COU_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IAziendaTelefono extends EJBObject
{
  //   *Require Fields* 
  //1 COD_NUM_TEL_ID (AziendaTelefono ID)
  public long getCOD_NUM_TEL_AZL();
  //2 TPL_NUM_TEL ()
  public String getTPL_NUM_TEL();
  public void setTPL_NUM_TEL__NUM_TEL__COD_AZL(String newTPL_NUM_TEL, String newNUM_TEL, long lCOD_AZL);
  //3 NUM_TEL (phone number)
  public String getNUM_TEL();
  //public  void setNUM_TEL (String newNUM_TEL);
  //4 COD_AZL (reference to ANA_AZL_TAB)
  public long getCOD_AZL();
  //public  void setCOD_AZL (long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
public interface IAziendaTelefonoHome extends EJBHome
{
   public  IAziendaTelefono create(
	String strTPL_NUM_TEL,
	String strNUM_TEL, 
	long lCOD_AZL
	) throws CreateException;
   public void remove(Object primaryKey);
   public IAziendaTelefono findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public  Collection getAziendaTelefoniByAZLID_View(long AZL_ID);
   
   //Metodi implementati per il DUVRI.pdf (per estrarre il Num_Tel e il Fax)
   public Collection getAziendaTelefoniCellulariFax_View(long AZL_ID, String strTPL_NUM_TEL);
}  

/*public*/
// view metodi
class AziendaTelefoniByAZLID_View implements java.io.Serializable{
	public long COD_NUM_TEL_AZL;
	public String TPL_NUM_TEL, NUM_TEL; 
}

class AziendaTelefoniCellulariFax_View implements java.io.Serializable{
	public String NUM_TEL; 
}

%>
