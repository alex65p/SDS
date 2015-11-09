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
    <version number="1.0" date="22/01/2004" author="Valentina Ruggieri">
	      <comments>
				  <comment date="22/01/2004" author="Valentina Ruggieri">
				   <description>AgenteMateriale_Interfaces.jsp</description>
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
// BASE TABLE: ANA_AGE_MAT_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface IAgenteMateriale extends EJBObject
{
  //   *Require Fields*
  //1 
  public long getCOD_AGE_MAT();
  //2 
  public String getNOM_AGE_MAT();
  public void setNOM_AGE_MAT(String newNOM_AGE_MAT);
  //3 
  public long getCOD_CAG_AGE_MAT();
  public void setCOD_CAG_AGE_MAT (long newCOD_CAG_AGE_MAT);
}

//     Home Intrface EJB obiekta 
public interface IAgenteMaterialeHome extends EJBHome
{
   public IAgenteMateriale create(
	String strNOM_AGE_MAT,
	long lCOD_CAG_AGE_MAT
   ) throws CreateException;
   public void remove(Object primaryKey);
   public IAgenteMateriale findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov classa
   public Collection getAgenti_Materiali_View();
   public Collection findEx(long COD_CAG, String NOM, long iOrderBy);
}

/*public*/
//classes for view metods   
class Agenti_Materiali_View implements java.io.Serializable{
	public long COD_AGE_MAT;
	public String NOM_AGE_MAT;
	public long COD_CAG_AGE_MAT;
	public String NOM_CAG_AGE_MAT;
}
class findEx_age_mat implements java.io.Serializable{
	public long COD_AGE_MAT;
	public String NOM_AGE_MAT;
}
//
%>

