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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="06/02/2004" author="Khomenko Juliya">
				   <description></description>
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

  public interface  ICollegamenti extends EJBObject
  {
  	public long getCOD_COL_INT_PRG();

	public String getIDZ_COL_INT();
	public void setIDZ_COL_INT(String strIDZ_COL_INT);

	public String getDES_COL_INT();
	public void setDES_COL_INT(String strDES_COL_INT);

	public long getCOD_PRG();
	public void setCOD_PRG(long lCOD_PRG);


  }

  public interface ICollegamentiHome extends EJBHome
  {
     public ICollegamenti create(String strIDZ_COL_INT, long lCOD_PRG) throws CreateException;
     public ICollegamenti findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
		 // opredelenie view metodov
 	   public Collection getCollegamentoInternet_View(long lCOD_PRG);
 	   public Collection getCollegamento_View();
  }

class	CollegamentoInternet_View implements java.io.Serializable
{
	long	COD_COL_INT_PRG;
	String	IDZ_COL_INT, DES_COL_INT;
}

class	Collegamento_View implements java.io.Serializable
{
	long	COD_COL_INT_PRG;
	String	IDZ_COL_INT, DES_COL_INT;
}

//<ejb-interfaces>
%>
