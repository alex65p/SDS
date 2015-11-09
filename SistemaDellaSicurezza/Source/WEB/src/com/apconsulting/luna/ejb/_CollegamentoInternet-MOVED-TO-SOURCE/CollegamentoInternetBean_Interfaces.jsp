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
				   Interfaces dlia objecta CollegamentoInternet
				 <comment date="29/01/2004" author="Pogrebnoy Yura">
				   Popolzovalsya EJBun
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

public interface  ICollegamentoInternet extends EJBObject {
 	public long getCOD_COL_INT();
	public String getIDZ_COL_INT();
	public void setIDZ_COL_INT(String strIDZ_COL_INT);
	public String getDES_COL_INT();
	public void setDES_COL_INT(String strDES_COL_INT);
	public long getCOD_FAT_RSO();
	public void setCOD_FAT_RSO(long lCOD_FAT_RSO);
}

public interface ICollegamentoInternetHome extends EJBHome  {
  public ICollegamentoInternet create(String strIDZ_COL_INT, long lCOD_FAT_RSO) throws CreateException;
  public ICollegamentoInternet findByPrimaryKey(Long primaryKey) throws  FinderException;
  public Collection findAll() throws FinderException;
  public void remove(Object primaryKey);
  public Collection getCollegamentoInternet_View(String strCOD_FAT_RSO);
}
//< ejb-interfaces>
// view metodi   
class CollegamentoInternet_View implements java.io.Serializable{
	public long COD_COL_INT;
	public String IDZ_COL_INT,DES_COL_INT,COD_FAT_RSO; 
}
%>
