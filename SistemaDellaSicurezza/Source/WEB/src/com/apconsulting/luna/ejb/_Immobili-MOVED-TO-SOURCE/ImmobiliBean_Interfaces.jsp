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
    <version number="1.0" date="" author="">
	      <comments>
				  <comment date="05/02/2004" author="Alexey Kolesnik">
				   <description> Added view for comboboxes </description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%!
// BASE TABLE: ANA_IMO_TAB
//     Remote Intrface EJB obiekta
public interface IImmobili extends EJBObject{
  public long getCOD_IMO();
  public String getNOM_IMO();
  public void setNOM_IMO(String newNOM_IMO);
  public String getDES_IMO();
  public void setDES_IMO (String newDES_IMO);
}

//     Home Intrface EJB obiekta
public interface IImmobiliHome extends EJBHome
{
   public IImmobili create(String strNOM_IMO) throws CreateException;
   public void remove(Object primaryKey);
   public IImmobili findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getImmobili_View();
   public Collection findEx(String strNOM_IMO, String strDES_IMO, int iOrderParameter);
}

// view metodi
class Immobili_View implements java.io.Serializable{
	public long COD_IMO;
	public String NOM_IMO;
	public String DES_IMO;
}
%>
