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
    <version number="1.0" date="15/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="15/01/2004" author="Khomenko Juliya">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
// BASE TABLE: TPL_UNI_ORG_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  ITipologieUnitaOrganizzativa extends EJBObject
{
  //   *Require Fields*
  //1 COD_TPL_UNI_ORG (TipologieUnitaOrganizzativa ID)
  public  long getCOD_TPL_UNI_ORG();
  //2 NOM_TPL_UNI_ORG (name)
  public  String getNOM_TPL_UNI_ORG();
  public  void setNOM_TPL_UNI_ORG(String newNOM_TPL_UNI_ORG);
  //   *Not require Fields*
  //3 DES_TPL_UNI_ORG (Description)
  public  String getDES_TPL_UNI_ORG();
  public  void setDES_TPL_UNI_ORG(String newDES_TPL_UNI_ORG);
}

//     Home Intrface EJB obiekta 
public interface ITipologieUnitaOrganizzativaHome extends EJBHome
{
   public  ITipologieUnitaOrganizzativa create(
  String strNOM_TPL_UNI_ORG
   ) throws CreateException;
   public void remove(Object primaryKey);
   public  ITipologieUnitaOrganizzativa findByPrimaryKey(Long primaryKey) throws FinderException;
   public  Collection findAll() throws FinderException;
   public Collection getTipologiaUnitaView();
}
//---------views-------
class TipologiaUnitaView implements java.io.Serializable{
	public long lCOD_TPL_UNI_ORG;
	public String strNOM_TPL_UNI_ORG;
	public String strDES_TPL_UNI_ORG;
}
%>
