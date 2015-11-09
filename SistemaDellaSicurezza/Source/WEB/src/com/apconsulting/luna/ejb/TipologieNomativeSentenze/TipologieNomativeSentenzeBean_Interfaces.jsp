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
// BASE TABLE: TPL_NOR_SEN_TAB
//     Remote Intrface EJB obiekta
public interface ITipologieNomativeSentenze extends EJBObject
{
  //   *Require Fields*
  public long getCOD_TPL_NOR_SEN();
  public String getNOM_TPL_NOR_SEN();
  public void setNOM_TPL_NOR_SEN(String newNOM_TPL_NOR_SEN);
  //   *Not require Fields*
  public String getDES_TPL_NOR_SEN();
  public void setDES_TPL_NOR_SEN (String newDES_TPL_NOR_SEN);
}

//     Home Intrface EJB obiekta
public interface ITipologieNomativeSentenzeHome extends EJBHome
{
   public ITipologieNomativeSentenze create(String strNOM_TPL_NOR_SEN) throws CreateException;
   public void remove(Object primaryKey);
   public ITipologieNomativeSentenze findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getTipologieNomativeSentenze_View();
   //<search>
   public  Collection findEx(String strNOM_TPL_NOR_SEN, int iOrderBy);
   //</search>
}

// view metodi
class TipologieNomativeSentenze_View implements java.io.Serializable{
	public long COD_TPL_NOR_SEN;
	public String NOM_TPL_NOR_SEN;
	public String DES_TPL_NOR_SEN;
}

%>
