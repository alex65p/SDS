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
    <version number="1.0" date="28/01/2004" author="Khomenko Juliya">
	      <comments>
			<comment date="28/01/2004" author="Khomenko Juliya">
			   <description>Create PercorsiFormativiBean_Interfaces.jsp</description>
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
public interface  IPercorsiFormativi extends EJBObject
{
  	public long getCOD_PCS_FRM();
	public String getNOM_PCS_FRM();
	public void setNOM_PCS_FRM(String strNOM_PCS_FRM);
	public String getDES_PCS_FRM();
	public void setDES_PCS_FRM(String strDES_PCS_FRM);
	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);
	//-----------------------------
  	// Link Table COR_PCS_FRM_TAB
	public void addCOD_COR(long newCOD_COR);
  	public void removeCOD_COR(long newCOD_COR);
}
//
public interface IPercorsiFormativiHome extends EJBHome
{
     public IPercorsiFormativi create(String strNOM_PCS_FRM, long lCOD_AZL) throws CreateException;
     public IPercorsiFormativi findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	 // opredelenie view metodov
 	 public Collection getPercorsiFormativiCorsiByID_View(long lCOD_PCS_FRM);
 	 public Collection getPercorsiFormativi_View(long lCOD_AZL);
	 // findEx by podmasteriev 
   	public Collection findEx(  
		long lCOD_AZL,
		String strNOM_PCS_FRM, 
		int iOrderParameter
	);
	//<report>
   	public Collection getDipendentePercorsi_View(long lCOD_DPD);
  }

/*public*/
// view metodi
class PercorsiFormativiCorsiByID_View implements java.io.Serializable
{
	public long COD_PCS_FRM;
	public long COD_COR;
	public String NOM_COR;
	public String DES_COR;
}
class PercorsiFormativi_View implements java.io.Serializable
{
	public long COD_PCS_FRM;
	public String NOM_PCS_FRM;
	public String DES_PCS_FRM;
}
//<report>
class DipendentePercorsi_View implements java.io.Serializable
{
	public String	strNOM_PCS;
	public String  	strDES_PCS;
}
//<ejb-interfaces>
%>
