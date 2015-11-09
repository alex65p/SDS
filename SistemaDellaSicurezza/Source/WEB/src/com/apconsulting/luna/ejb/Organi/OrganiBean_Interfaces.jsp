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
// BASE TABLE: ANA_ORN_TAB
// Remote Intrface EJB obiekta
public interface IOrgani extends EJBObject{
  public long getCOD_ORN();
  public String getNOM_ORN();
  public void setNOM_ORN(String newNOM_ORN);
  public String getDES_ORN();
  public void setDES_ORN (String newDES_ORN);
}

// Home Intrface EJB obiekta
public interface IOrganiHome extends EJBHome
{
   public IOrgani create(String strNOM_ORN) throws CreateException;
   public void remove(Object primaryKey);
   public IOrgani findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getOrgani_View();
   public  Collection findEx(String strNOM_ORN, int iOrderBy);
}

// view metodi
class Organi_View implements java.io.Serializable{
	public long COD_ORN;
	public String NOM_ORN;
	public String DES_ORN;
}
%>
