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
    <version number="1.0" date="11/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="11/02/2004" author="Artur Denysenko">
				   Interfaces dlia objecta Simbolo
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
//<ejb-interfaces description="EJB Interfaces">
public interface  ISimbolo extends EJBObject
{
  	public long getCOD_SIM();
	public String getDES_SIM();
	public void setDES_SIM(String strDES_SIM);
}
//
public interface ISimboloHome extends EJBHome
{
     public ISimbolo create(String strDES_SIM) throws CreateException;
     public ISimbolo findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
     public Collection getSimbolo_View();
  }
//<ejb-interfaces>
class Simbolo_View implements java.io.Serializable
{
	long lCOD_SIM;
	String strDES_SIM;
}
%>
