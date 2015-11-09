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
// BASE TABLE: TPL_DOC_TAB
//     Remote Intrface EJB obiekta 
public interface ITipologiaDocumenti extends EJBObject{
  //   *Require Fields*
  public long getCOD_TPL_DOC();
  public String getNOM_TPL_DOC();
  public void setNOM_TPL_DOC(String newNOM_TPL_DOC);
  //   *Not require Fields*
  public String getDES_TPL_DOC();
  public void setDES_TPL_DOC (String newDES_TPL_DOC);
}

//     Home Intrface EJB obiekta 
public interface ITipologiaDocumentiHome extends EJBHome
{
   public ITipologiaDocumenti create(String strNOM_TPL_DOC) throws CreateException;
   public void remove(Object primaryKey);
   public ITipologiaDocumenti findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public Collection getComboView();
   public Collection findEx(String NOM_TPL_DOC, String DES_TPL_DOC, int iOrderBy);
}
//
public class TipologiaDocumenti_ComboView implements java.io.Serializable{
	public long lCOD_TPL_DOC;
	public String strNOM_TPL_DOC;
	public String strDES_TPL_DOC;
}
%>
