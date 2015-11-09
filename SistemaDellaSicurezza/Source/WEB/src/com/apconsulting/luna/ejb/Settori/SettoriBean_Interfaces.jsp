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
    <version number="1.0" date="23/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="23/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%!
// BASE TABLE: ANA_SET_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  ISettori extends EJBObject
{
  //1 COD_SET (Settori ID)
  public  long getCOD_SET();
  //2 NOM_SET (name)
  public  String getNOM_SET();
  public  void setNOM_SET(String newNOM_SET);
  //3 DES_SET (Description)
  public  String getDES_SET();
  public  void setDES_SET(String newDES_SET);
}

//     Home Intrface EJB obiekta
public interface ISettoriHome extends EJBHome
{
   public  ISettori create(
  String strNOM_SET
   ) throws CreateException;
   public void remove(Object primaryKey);
   public  ISettori findByPrimaryKey(Long primaryKey) throws FinderException;
   public  Collection findAll() throws FinderException;
   public Collection getSettori_View();
   //<search>
   public  Collection findEx(String NOM_SET, int uOrderBy);
   //</search>
}

// view metodi
class Settori_View implements java.io.Serializable{
	public long COD_SET;
	public String NOM_SET;
	public String DES_SET;
}
%>
