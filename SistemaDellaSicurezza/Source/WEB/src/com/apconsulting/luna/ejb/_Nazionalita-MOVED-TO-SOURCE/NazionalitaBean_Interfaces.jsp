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
				   <description>NazionalitaBean_Interfaces.jsp</description>
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
// Zdes opredeliajutsia Interfeisi dlia EJB obiekta
//           Remote Intrface EJB obiekta 
//--------------------------------
public interface  INazionalita extends EJBObject
{
  public  long getCOD_STA();
 // public  void setCOD_STA(int newCOD_STA);
  public String getNOM_STA();
  public void setNOM_STA_COD_LNG (String newNOM_STA, long newCOD_LNG);
  public long getCOD_LNG();
  //public  void setCOD_LNG (long newCOD_LNG);
 
}

//         Home Intrface EJB obiekta 
public interface INazionalitaHome extends EJBHome
{
   public INazionalita create(String strNOM_STA, long lCOD_LNG ) throws CreateException;
   public INazionalita findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   public void remove(Object primaryKey);
   // views
   public Collection getNazionalita_View();
   // get Natzionalita Names (List for combobox)
   public Collection getNazionalita_Names_View(long COD_LNG);	 
}

/*public*/
// view metodi   
class Nazionalita_View implements java.io.Serializable{
	public long COD_STA;
	public String NOM_STA;
	public long COD_LNG;
	public String NOM_LNG;
        //public String IMG_NAZ;
}
//
class Nazionalita_Names_View implements java.io.Serializable{
	public long COD_STA;
	public String NOM_STA;
       // public String IMG_NAZ;
}

%>
