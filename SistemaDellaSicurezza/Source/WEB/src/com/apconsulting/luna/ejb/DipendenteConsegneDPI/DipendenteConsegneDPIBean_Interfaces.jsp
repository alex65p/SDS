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
    <version number="1.0" date="19/02/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="19/02/2004" author="Mike Kondratyuk">
				   Interfaces dlia objecta DipendenteConsegneDPI
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

  public interface  IDipendenteConsegneDPI extends EJBObject
  {
  	public long getCOD_CSG_DPI();

	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);

	public java.sql.Date getDAT_CSG_DPI();
	public void setDAT_CSG_DPI(java.sql.Date dtDAT_CSG_DPI);

	public String getNOM_RSP_CSG_DPI();
	public void setNOM_RSP_CSG_DPI(String strNOM_RSP_CSG_DPI);

	public String getEFT_CSG_SCH_DPI();
	public void setEFT_CSG_SCH_DPI(String strEFT_CSG_SCH_DPI);

	public long getQTA_CSG();
	public void setQTA_CSG(long lQTA_CSG);

	public String getTPL_CSG();
	public void setTPL_CSG(String strTPL_CSG);

	public long getCOD_LOT_DPI();
	public void setCOD_LOT_DPI(long lCOD_LOT_DPI);

	public long getCOD_TPL_DPI();
	public void setCOD_TPL_DPI(long lCOD_TPL_DPI);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);

  }

  public interface IDipendenteConsegneDPIHome extends EJBHome
  {
     public IDipendenteConsegneDPI create(long lCOD_DPD, java.sql.Date dtDAT_CSG_DPI, String strNOM_RSP_CSG_DPI, String strEFT_CSG_SCH_DPI, long lQTA_CSG, String strTPL_CSG, long lCOD_LOT_DPI, long lCOD_TPL_DPI, long lCOD_AZL) throws CreateException;
     public IDipendenteConsegneDPI findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);

	 public  Collection getDipendenti_DPI_View(long COD_DPD);
//<report>	 
	 public  Collection getResponsabileDPI_View(long lCOD_DPD);
  }
  
//<ejb-interfaces>

class Dipendenti_DPI_View implements java.io.Serializable{
	public long COD_CSG_DPI;
	public String NOM_TPL_DPI;
	public long QTA_CSG;
	public java.sql.Date DAT_CSG_DPI;
	//<report>
	public String NOM_RSP_CSG_DPI;
}
%>

