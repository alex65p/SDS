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
					<comment date="27/03/2004" author="Treskina Maria">
				   <description>Search</description>
				  </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%> 

<%!
// BASE TABLE: CLF_SOS_TAB
//     Remote Intrface EJB obiekta 
public interface IClassificazioneAgentiChimici extends EJBObject{
  //   *Require Fields*
  public long getCOD_CLF_SOS();
  public String getDES_CLF_SOS();
  public void setDES_CLF_SOS (String newDES_CLF_SOS);
}

//     Home Intrface EJB obiekta 
public interface IClassificazioneAgentiChimiciHome extends EJBHome
{
   public IClassificazioneAgentiChimici create(String strDES_CLF_SOS) throws CreateException;
   public void remove(Object primaryKey);
   public IClassificazioneAgentiChimici findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   //
   public Collection getClassificazione_View();
   public Collection findEx(  
	 		String strDES_CLF_SOS, 
			int iOrderParameter //not used for now
   );
}

// Views classes
class Classificazione_View implements java.io.Serializable{
	long lCOD_CLF_SOS;
	String strDES_CLF_SOS;
}

%>
