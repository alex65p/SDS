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
    <version number="1.0" date="27/01/2004" author="Valentina Ruggieri">
	      <comments>
				  <comment date="27/01/2004" author="Valentina Ruggieri">
				   <description>AnagrParagrafo_Interfaces.jsp</description>
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
public interface IAnagrParagrafo extends EJBObject
{
  //   *Require Fields*

  public long getCOD_PRG();
  
  public String getNOM_PRG();
  public void setNOM_PRG(String newNOM_PRG);
  
  public String getDES_PRG();
  public void setDES_PRG(String newDES_PRG);
 
  public long getCOD_ARE();
  public void setCOD_ARE (long newCOD_ARE);
  
  public long getCOD_CPL();
  public void setCOD_CPL (long newCOD_CPL);
  
  public long getCOD_AZL();
  public void setCOD_AZL (long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
public interface IAnagrParagrafoHome extends EJBHome
{
   public IAnagrParagrafo create(
	String strNOM_PRG,
	String strDES_PRG,
	long lCOD_ARE,
	long lCOD_CPL,
	long lCOD_AZL
   ) throws CreateException;
   public void remove(Object primaryKey);
   public IAnagrParagrafo findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov classa
   public Collection getAnagr_Paragrafi_View();
}

/*public*/
//classes for view metods   
class Anagr_Paragrafi_View implements java.io.Serializable{
	public long COD_PGR;
	public String NOM_PGR;
	public String DES_PGR;
	public long COD_ARE;
	public long COD_CPL;
	public long COD_AZL;
	//public String NOM_CAG_AGE_MAT;
}
//
%>

