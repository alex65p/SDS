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
<%!
// BASE TABLE: NAT_LES_TAB
//     Remote Intrface EJB obiekta 
public interface ISchedeInterventoDPI extends EJBObject
{
  //   *Require Fields*
  	//1
  	public long getCOD_SCH_INR_DPI();
  	//2
	public void setCOD_LOT_DPI(long newCOD_LOT_DPI);
    public long getCOD_LOT_DPI();
  	//3
	public void setCOD_TPL_DPI(long newCOD_TPL_DPI);
    public long getCOD_TPL_DPI();
	//4
	public void setTPL_INR_DPI(String newTPL_INR_DPI);
    public String getTPL_INR_DPI();
	//5
	public void setATI_INR(String newATI_INR);
    public String getATI_INR();
	//6
	public void setDAT_PIF_INR(java.sql.Date newDAT_PIF_INR);
    public java.sql.Date getDAT_PIF_INR();
	//============================================
	// not required field
  	//7
	public void setDAT_INR(java.sql.Date newDAT_INR);
    public java.sql.Date getDAT_INR();
	//8
	public void setESI_INR(String newESI_INR);
    public String getESI_INR();
	//9
	public void setPBM_RSC(String newPBM_RSC);
    public String getPBM_RSC();
	//10
	public void setNOM_RSP_INR(String newNOM_RSP_INR);
    public String getNOM_RSP_INR();
}

//     Home Intrface EJB obiekta 
public interface ISchedeInterventoDPIHome extends EJBHome
{
   public ISchedeInterventoDPI create(long lCOD_LOT_DPI, long lCOD_TPL_DPI, String strTPL_INR_DPI, String strATI_INR, java.sql.Date dtDAT_PIF_INR) throws CreateException;
   public void remove(Object primaryKey);
   public ISchedeInterventoDPI findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   //--- view
   //--- <comment date="25/01/2004" author="Treskina Maria">
   public Collection getSchedeInterventoDPIByLOTDPIID_View(long LOT_DPI_ID);
   //--//--- <comment date="13/03/2004" author="Podmasteriev Alexander">
   public Collection getSchedeInterventoLOV_View(long COD_AZL);
   public Collection getfindEx(
  	long COD_AZL, 
	long COD_LOT_DPI, 
	java.sql.Date DAT_PIF_INR, 
	java.sql.Date DAT_INR,
	String ATI_INR, 
	String NOM_RSP_INR, 
	String PBM_RSC, 
	long iOrderBy);
  //<report>
  public ReportSchedeInterventoDPIView getReportSchedeInterventoDPIView(long lCOD_SCH_INR_DPI);
  //</report>
}
//--- <comment date="25/01/2004" author="Treskina Maria">
class SchedeInterventoDPIByLOTDPIID_View implements java.io.Serializable{
	public long COD_SCH_INR_DPI;
	public String ANI_INR, NOM_RSP_INR, NOM_TPL_DPI;
	public java.sql.Date DAT_INR, DAT_PIF_INR;
}
//--//--- <comment date="13/03/2004" author="Podmasteriev Alexander">
class SchedeInterventoLOV_View implements java.io.Serializable{
	public long COD_SCH_INR_DPI, COD_LOT_DPI,COD_TPL_DPI;
	public String IDE_LOT_DPI,TPL_INR_DPI,ESI_INR;
	public java.sql.Date DAT_INR, DAT_PIF_INR;
}
class findEx_inr_dpi implements java.io.Serializable{
	public long COD_SCH_INR_DPI, COD_LOT_DPI,COD_TPL_DPI;
	public String IDE_LOT_DPI,TPL_INR_DPI,ESI_INR;
	public java.sql.Date DAT_INR, DAT_PIF_INR;
}//-------------------------------------------------------------------

//<report>
class ReportSchedeInterventoDPIView implements java.io.Serializable{
	public long lCOD_SCH_INR_DPI;
	public String strATI_INR;
	public java.sql.Date dtDAT_INR;
	public String strESI_INR;
	public String strPBM_RSC;
	public String strIDE_LOT_DPI;
	public String strNOM_TPL_DPI;
}
//</report>

%>
