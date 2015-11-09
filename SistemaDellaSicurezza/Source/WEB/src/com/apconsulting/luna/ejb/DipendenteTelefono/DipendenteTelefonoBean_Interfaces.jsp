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
// BASE TABLE: ANA_DPD
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IDipendenteTelefono extends EJBObject
{
  //   *Require Fields*
  //1 COD_NUM_TEL_DPD (DipendenteTelefono ID)
  public long getCOD_NUM_TEL_DPD();
  //2 TPL_NUM_TEL (tipologia)
  public String getTPL_NUM_TEL();
  public void setTPL_NUM_TEL__NUM_TEL__COD_DPD(String newTPL_NUM_TEL, String newNUM_TEL, long newCOD_DPD);
  //3 NUM_TEL (tel number)
  public String getNUM_TEL();
  //4 COD_DPD (dipendente)
  public long getCOD_DPD();
  //5 COD_AZL ()
  public long getCOD_AZL();
  public void setCOD_AZL (long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
public interface IDipendenteTelefonoHome extends EJBHome
{
   public IDipendenteTelefono create(
    String strTPL_NUM_TEL,
		String strNUM_TEL,
		long lCOD_DPD,
		long lCOD_AZL
   ) throws CreateException;
   
	 public void remove(Object primaryKey);
   
	 public IDipendenteTelefono findByPrimaryKey(Long primaryKey) throws FinderException;
   
	 public Collection findAll() throws FinderException;
   
	 // opredelenie view metodov
	 public Collection getDipendenteTelefono_Tipology_Number_View(long lCOD_DPD);
}

/*public*/
// view metodi   
class DipendenteTelefono_Tipology_Number_View implements java.io.Serializable{
	public long COD_DPD;
	public long COD_AZL;
	public String TPL_NUM_TEL,NUM_TEL;
	public long COD_NUM_TEL_DPD;
}
%>
