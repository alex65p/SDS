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
    <version number="1.0" date="--/01/2004" author="Kushkarov Yura">
	  <comments>
      	<comment date="13/02/2004" author="Alex Kyba">
		   <description>method getTipologieMacchineView() class TipologiaMacchinaView</description>
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
// BASE TABLE: TPL_MAC_TAB
// Remote Intrface EJB obiekta 
public interface ITipologieMacchine extends EJBObject
{
  //*Require Fields*
  public long getCOD_TPL_MAC();
  public String getDES_TPL_MAC();
  public void setDES_TPL_MAC (String newDES_TPL_MAC);
}

//     Home Intrface EJB obiekta 
public interface ITipologieMacchineHome extends EJBHome
{
   public ITipologieMacchine create(String strDES_TPL_MAC) throws CreateException;
   public void remove(Object primaryKey);
   public ITipologieMacchine findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getTipologieMacchineView();
   public Collection findEx(String DES, long iOrderBy);
}
//------views---------------------
class TipologiaMacchinaView implements java.io.Serializable
{
	public long lCOD_TPL_MAC;
	public String strDES_TPL_MAC;
}
class findEx_tpl_mac implements java.io.Serializable
{
	public long lCOD_TPL_MAC;
	public String strDES_TPL_MAC;
}
%>
