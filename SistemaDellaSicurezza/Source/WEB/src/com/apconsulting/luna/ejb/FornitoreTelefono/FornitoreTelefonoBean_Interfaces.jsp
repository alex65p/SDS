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
// BASE TABLE: ANA_AZL_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IFornitoreTelefono extends EJBObject
//abstract class IFornitoreTelefono extends BMPEntityBean
{
  //   *Require Fields*
  //1 COD_NUM_TEL_FOR_AZL (FornitoreTelefono ID)
  public long getCOD_NUM_TEL_FOR_AZL();
  //2 TPL_NUM_TEL (tipologia)
	public void setTPL_NUM_TEL__NUM_TEL__COD_FOR_AZL(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_FOR_AZL);
	
  public String getTPL_NUM_TEL();
  //3 NUM_TEL (number)
  public String getNUM_TEL();
  //4 COD_FOR_AZL (cod of fornitore)
  public long getCOD_FOR_AZL();
}

//     Home Intrface EJB obiekta 
public interface IFornitoreTelefonoHome extends EJBHome
//abstract class IFornitoreTelefonoHome extends  IFornitoreTelefono
{
   public IFornitoreTelefono create(
		String strTPL_NUM_TEL,
		String strNUM_TEL, 
		long lCOD_FOR_AZL
   ) throws CreateException;
   public void remove(Object primaryKey);
   public IFornitoreTelefono findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getFornitoreTelefonoByFORAZLID_View(long FOR_AZL_ID);
}

	/*public*/

// view metodi  
class FornitoreTelefonoByFORAZLID_View implements java.io.Serializable{
	public long COD_NUM_TEL_FOR_AZL;
	public String TPL_NUM_TEL,NUM_TEL;
}

%>
