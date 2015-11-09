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
    <version number="1.0" date="24/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="24/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
// BASE TABLE: ANA_SED_LES_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  ISediLesione extends EJBObject
//abstract class ISediLesione extends BMPEntityBean
{
  //1 COD_SED_LES (SediLesione ID)
  public  long getCOD_SED_LES();
  //2 NOM_SED_LES (name)
  public  String getNOM_SED_LES();
  public  void setNOM_SED_LES(String newNOM_SED_LES);
  //3 TPL_SED_LES (Description)
  public  String getTPL_SED_LES();
  public  void setTPL_SED_LES(String newTPL_SED_LES);
}

//     Home Intrface EJB obiekta 
public interface ISediLesioneHome extends EJBHome
{
   	public  ISediLesione create(String strNOM_SED_LES, String strTPL_SED_LES) throws CreateException;
   	public void remove(Object primaryKey);
   	public  ISediLesione findByPrimaryKey(Long primaryKey) throws FinderException;
   	public  Collection findAll() throws FinderException;
	//View by Pogrebnoy Yura for ANA_INO_Combobox
   	public	Collection getANA_SED_LES_TAB_ByNOM_View();
 	public Collection findEx(String NOM, long iOrderBy);
}
//--------------------------------------------------------------
class findEx_sed_les implements java.io.Serializable
{
	long	COD_SED_LES;
	String	NOM_SED_LES;
	String	TPL_SED_LES;
}
class ANA_SED_LES_TAB_ByNOM_View implements java.io.Serializable
{
	long	COD_SED_LES;
	String	NOM_SED_LES;
	String	TPL_SED_LES;
}
//---------------------------------------------------------------
%>
