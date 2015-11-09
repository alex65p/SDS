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
// BASE TABLE: TPL_COR_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  ITipologiaCorsi extends EJBObject
public interface ITipologiaCorsi extends EJBObject
{
  //   *Require Fields*
  //1 COD_TPL_COR (TipologiaCorsi ID)
  public long getCOD_TPL_COR();

  //2 NOM_TPL_COR (name)
  public String getNOM_TPL_COR();
  public void setNOM_TPL_COR(String newNOM_TPL_COR);

  //   *Not require Fields*

	  //3 DES_TPL_COR (descr)
  public String getDES_TPL_COR();
  public void setDES_TPL_COR (String newDES_TPL_COR);

}

//     Home Intrface EJB obiekta 
//public interface ITipologiaCorsiHome extends EJBHome
public interface ITipologiaCorsiHome extends  ITipologiaCorsi
{
   public ITipologiaCorsi create(String strNOM_TPL_COR) throws CreateException;
   public void remove(Object primaryKey);
   public ITipologiaCorsi findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection findEx(  
		String strNOM_TPL_COR,
		int iOrderParameter 
   );
   // opredelenie view metodov
   public Collection getTipologiaCorsi_Name_Address_View();
}

/*public*/
// view metodi   
class TipologiaCorsi_Name_Address_View implements java.io.Serializable{
	public long COD_TPL_COR;
	public String NOM_TPL_COR;
	public String DES_TPL_COR;
}
%>
