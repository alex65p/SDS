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
    <version number="1.0" date="24/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="24/01/2004" author="Treskina Maria">
				   <description>interfejs objecta LottiDPIBean</description>
				 </comment>		
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
// BASE TABLE: ANA_MAN_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  ILottiDPI extends EJBObject
public interface  ILottiDPI extends EJBObject
{
  //1 COD_LOT_DPI (LottiDPI ID)
  public long getCOD_LOT_DPI();
  //2 COD_TPL_DPI (cod of tipologia)
  public long getCOD_TPL_DPI();
  public void setCOD_TPL_DPI(long newCOD_TPL_DPI);
  //3 IDE_LOT_DPI ()
  public String getIDE_LOT_DPI();
  public void setIDE_LOT_DPI (String newIDE_LOT_DPI );  
  //4
  public java.sql.Date getDAT_CSG_LOT();
  public  void setDAT_CSG_LOT(java.sql.Date newDAT_CSG_LOT);
  //5  ()
  public long getQTA_FRT();
  public void setQTA_FRT(long newQTA_FRT);
  //6  ()
  public long getQTA_AST();
  public void setQTA_AST(long newQTA_AST);
  //7  ()
  public long getQTA_DSP();
  public void setQTA_DSP(long newQTA_DSP);
  //8  ()
  public long getCOD_FOR_AZL();
  public void setCOD_FOR_AZL(long newCOD_FOR_AZL);
  //9  ()
  public long getCOD_AZL();
  public void setCOD_AZL(long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
//public interface ILottiDPIHome extends EJBHome
public interface ILottiDPIHome extends  ILottiDPI
{
   public ILottiDPI create(
			long lCOD_TPL_DPI, 
			String strIDE_LOT_DPI, 
			java.sql.Date  dDAT_CSG_LOT, 
			long lQTA_FRT, 
			long lQTA_AST, 
			long lQTA_DSP,
			long lCOD_FOR_AZL,
			long lCOD_AZL
   ) throws CreateException;
   public void remove(Object primaryKey);
   public ILottiDPI findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getLottiDPI_IDE_DATA_View(long AZL_ID);
   public Collection getLottiDPIByFORAZLID_View(long FOR_AZL_ID, long AZL_ID);
   public Collection getLottiDPIByTPLDPIID_View(long TPL_DPI_ID);
   public Collection findEx(  
		long lCOD_AZL,
		Long lCOD_TPL_DPI, 
		String strIDE_LOT_DPI, 
		java.sql.Date	dDAT_CSG_LOT, 
		Long lQTA_FRT, 
		Long lCOD_FOR_AZL,
		int iOrderParameter //not used for now
  );
}

/*public*/
// view metodi   
class LottiDPI_IDE_DATA_View implements java.io.Serializable{
	public long COD_LOT_DPI;
	public String IDE_LOT_DPI, NOM_TPL_DPI;
	java.sql.Date  DAT_CSG_LOT;
	long QTA_FRT, QTA_AST, QTA_DSP;
}
class LottiDPIByFORAZLID_View implements java.io.Serializable{
	public long COD_LOT_DPI, QTA_FRT, QTA_AST, QTA_DSP;
	public String IDE_LOT_DPI, NOM_TPL_DPI;
}
class LottiDPIByTPLDPIID_View implements java.io.Serializable{
	public long COD_LOT_DPI;
	public String IDE_LOT_DPI, RAG_SOC_FOR_AZL;
	public java.sql.Date DAT_CSG_LOT;
}
%>
