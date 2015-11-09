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
    <version number="1.0" date="14/01/2004" author="Alexandr Kyba">
	      		<comments>
				  <comment date="14/01/2004" author="Alexandr Kyba">
				   <description>LinguaBean_Interfaces.jsp</description>
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
// Zdes opredeliajutsia Interfeisi dlia EJB obiekta Remote Intrface EJB obiekta 
//--------------------------------
public interface ILingua extends EJBObject
{
  public long getCOD_LNG();
 // public  void setCOD_STA(int newCOD_STA);
  public String getNOM_LNG();
  public void setNOM_LNG(String newNOM_LNG);
}

//         Home Intrface EJB obiekta 
public interface ILinguaHome extends EJBHome
{
   public ILingua create(String strNOM_LNG) throws CreateException;
   public ILingua findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public void remove(Object primaryKey);
   
   // opredelenie view metodov
   public Collection getLingua_View();
}

/*public*/
// view metodi   
class Lingua_View implements java.io.Serializable{
	public long COD_LNG;
	public String NOM_LNG;
}

%>
