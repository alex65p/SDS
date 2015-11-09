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
// BASE TABLE: ANA_RST_TAB
// Remote Intrface EJB obiekta 
public interface IRisposta extends EJBObject{
  //*Require Fields*
  public long getCOD_RST();
  public String getNOM_RST();
  public void setNOM_RST(String newNOM_RST);
  //*Not require Fields*
  public String getDES_RST();
  public void setDES_RST (String newDES_RST);
}

//     Home Intrface EJB obiekta 
public interface IRispostaHome extends EJBHome
{
   public IRisposta create(String strNOM_RST) throws CreateException;
   public void remove(Object primaryKey);
   public IRisposta findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getRisposta_View();
   public Collection findEx(String NOM, String DES, long iOrderBy);
}
//
class Risposta_View implements java.io.Serializable{
	public long COD_RST;
	public String NOM_RST, DES_RST;
}
%>
