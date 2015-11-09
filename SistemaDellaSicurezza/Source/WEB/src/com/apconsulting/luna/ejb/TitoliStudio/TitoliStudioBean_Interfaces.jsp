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
    <version number="1.0" date="21/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="21/01/2004" author="Khomenko Juliya">
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
public interface  ITitoliStudio extends EJBObject
{
  	public long getCOD_TIT_STU_SPC();
	//
	public String getNOM_TIT_STU_SPC();
	public void setNOM_TIT_STU_SPC(String strNOM_TIT_STU_SPC);
	//
	public String getDES_TIT_STU_SPC();
	public void setDES_TIT_STU_SPC(String strDES_TIT_STU_SPC);
	//
	public String getTLP_TIT_STU_SPC();
	public void setTLP_TIT_STU_SPC(String strTLP_TIT_STU_SPC);
	//
	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);
	//
	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);
}
//------------------------------------------------
public interface ITitoliStudioHome extends EJBHome
{
     public ITitoliStudio create(String strNOM_TIT_STU_SPC, String strDES_TIT_STU_SPC, String strTLP_TIT_STU_SPC, long lCOD_DPD, long lCOD_AZL) throws CreateException;
     public ITitoliStudio findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	 // opredelenie view metodov
	 public Collection getDipendente_TitoliStudio_View(long lCOD_DPD);
	 public Collection getTitoliStudio_View(long lCOD_AZL);
}
//-----------------------------------------------------------------
class Dipendente_TitoliStudio_View implements java.io.Serializable{
	public long COD_DPD;
	public long COD_AZL;
	public String NOM_TIT_STU_SPC;
	public String TLP_TIT_STU_SPC;
	public long COD_TIT_STU_SPC;
}
class TitoliStudio_View implements java.io.Serializable{
	public String NOM_TIT_STU_SPC;
	public String DES_TIT_STU_SPC;
	public long COD_TIT_STU_SPC;
}
//<ejb-interfaces>
%>
