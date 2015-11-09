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
    <version number="1.0" date="29/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="29/01/2004" author="Artur Denysenko">
				   Interfaces dlia objecta IndirizzoPostaElettronica
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="java.util.*"%>

<%!
//< ejb-interfaces description="EJB Interfaces">

public interface  IIndirizzoPostaElettronica extends EJBObject {
 	public long getCOD_IDZ_PSA_ELT();
	public String getIDZ_PSA_ELT();
	public void setIDZ_PSA_ELT(String strIDZ_PSA_ELT);
	public String getDES_IDZ_PSA_ELT();
	public void setDES_IDZ_PSA_ELT(String strDES_IDZ_PSA_ELT);
	public long getCOD_FAT_RSO();
	public void setCOD_FAT_RSO(long lCOD_FAT_RSO);
}

public interface IIndirizzoPostaElettronicaHome extends EJBHome {
  public IIndirizzoPostaElettronica create(String strIDZ_PSA_ELT, long lCOD_FAT_RSO) throws CreateException;
  public IIndirizzoPostaElettronica findByPrimaryKey(Long primaryKey) throws  FinderException;
  public Collection findAll() throws FinderException;
  public void remove(Object primaryKey);
  public Collection getIndirizzoPostaElettronica_View(String strCOD_FAT_RSO);
}

//< ejb-interfaces>
// view metodi   
class IndirizzoPostaElettronica_View implements java.io.Serializable
{
	public long COD_IDZ_PSA_ELT;
	public String IDZ_PSA_ELT, DES_IDZ_PSA_ELT, COD_FAT_RSO; 
}
%>
