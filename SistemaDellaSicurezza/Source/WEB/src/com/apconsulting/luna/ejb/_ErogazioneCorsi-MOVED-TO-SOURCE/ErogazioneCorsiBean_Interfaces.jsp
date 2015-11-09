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
    <version number="1.0" date="?" author="Kushkarov Yura">
	      <comments>
			<comment date="?" author="Kushkarov Yura">
			  <description>ErogazioneCorsiBean_Interfaces.jsp</description>
			</comment>
			<comment date="08/03/2004" author="Roman Chumachenko">
			   <description>Views for Reports</description>
			</comment>
			<comment date="13/05/2004" author="Treskina Maria">
				   <description>izmenenie FindEx dobavlen COD_AZL</description>
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
// BASE TABLE: SCH_EGZ_COR_TAB
//     Remote Intrface EJB obiekta 
public interface IErogazioneCorsi extends EJBObject{
  	//*Require Fields*
	//1
	public long getCOD_SCH_EGZ_COR();		
	//2
	public void setCOD_COR(long newCOD_COR);
    public long getCOD_COR();
	//4
	public void setSTA_EGZ_COR(String newSTA_EGZ_COR);
    public String getSTA_EGZ_COR();
	//6
	public void setDAT_PIF_EGZ_COR(java.sql.Date newDAT_PIF_EGZ_COR);
    public java.sql.Date getDAT_PIF_EGZ_COR();
	//5
	public void setCOD_AZL(long newCOD_AZL);
    public long getCOD_AZL();
	//============================================
	// not required field
  	//7
	public void setDAT_EFT_EGZ_COR(java.sql.Date newDAT_EFT_EGZ_COR);
    public java.sql.Date getDAT_EFT_EGZ_COR();
	//////////////////////////////////////
	public void removeCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL,java.sql.Date newDAT_EFT_COR);
	public void removeISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL);
	public void addCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL,java.sql.Date newDAT_EFT_COR);
	public void addISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL);
	
	// -- Reports ---
	//---------------------------
 	public Collection getErogazioneForCorso_View();	
	
}
//     Home Intrface EJB obiekta 
public interface IErogazioneCorsiHome extends EJBHome
{
   	public IErogazioneCorsi create(
		long lCOD_COR, 
		long lCOD_AZL, 
		String strSTA_EGZ_COR, 
		java.sql.Date dtDAT_PIF_EGZ_COR
	) throws CreateException;
   	public void remove(Object primaryKey);
   	public IErogazioneCorsi findByPrimaryKey(Long primaryKey) throws FinderException;
   	public Collection findAll() throws FinderException;
	//--- view
  	public Collection getErogazioneCorsiNames_View(long lCOD_AZL);
	public Collection getErogazioneCorsi_SelectData_View();
	public Collection getErogazioneCorsi_ForTabDPD_View(long SCH_EGZ_COR_ID);
	public Collection getErogazioneCorsi_ForAssocia_View(long COR_ID, long AZL_ID);
	public String getErogazioneCorsi_ForTabByAZL_View(long AZL_ID);
	public String getErogazioneCorsi_ForTabByDTE_View(long DTE_ID);
   	public Collection getErogazioneCorsi_DTEGet_View();
	public Collection getScadenzario_Corsi_View(
		long lCOD_AZL,
		long lNOM_COR, 
		String lNOM_DCT,
		java.sql.Date dDAT_PIF_EGZ_COR_DAL,
		java.sql.Date dDAT_PIF_EGZ_COR_AL,
		String strSTA_INT,
		java.sql.Date dEFF_DAT_DAL,
		java.sql.Date dEFF_DAT_AL,
		String strRAGGRUPPATI,
		String strTYPE);
	public Collection findEx(  
		Long lCOD_AZL,
		Long lCOD_COR,
		java.sql.Date dtDAT_PIF_EGZ_COR,
		java.sql.Date dtDAT_EFT_EGZ_COR,
		String strNB_DUR_COR_GOR,
		String strSTA_EGZ_COR,
		String strNB_NOM_TPL_COR,
		int iOrderBy);
}

//--------------------------------------------------------------------
class ErogazioneCorsiNames_View implements java.io.Serializable{
	public long COD_TPL_COR, COD_COR, DUR_COR_GOR, COD_SCH_EGZ_COR;
	public String NOM_COR, NOM_TPL_COR, DES_COR, STA_EGZ_COR;
	public java.sql.Date DAT_PIF_EGZ_COR, DAT_EFT_EGZ_COR;
}

class ErogazioneCorsi_SelectData_View implements java.io.Serializable{
	public long COD_TPL_COR, COD_COR, DUR_COR_GOR;
	public String NOM_COR, NOM_TPL_COR;
}
class ErogazioneCorsi_ForTabDPD_View implements java.io.Serializable{
	public long COD_DPD, COD_AZL, COD_DTE;
	public String COG_DPD, NOM_DPD, MTR_DPD;
}
class ErogazioneCorsi_ForAssocia_View implements java.io.Serializable{
	public long COD_DPD, COD_COR, COD_SCH_EGZ_COR;
	public String COG_DPD, NOM_DPD, NOM_COR;
	public java.sql.Date DAT_PIF_EGZ_COR;
}
class ErogazioneCorsi_DTEGet_View implements java.io.Serializable{
	public String RAG_SCL_DTE;
	public long COD_DTE;
}
//--- for SCH_VST
class Scadenzario_Corsi_View implements java.io.Serializable
{
	long	COD_SCH_EGZ_COR, COD_COR, COD_AZL;
	java.sql.Date DAT_PIF_EGZ_COR, DAT_EFT_EGZ_COR;
	String	NOM_COR, NOM_DCT, RAG_SCL_AZL;
}
// --- Report ---
public class ErogazioneForCorso_View implements java.io.Serializable{
	long DUR_COR;
	String NOM_COR, DES_COR, STA_EGZ_COR, USO_PTG_COR, USO_ATE_FRE_COR, STE_EGZ_COR;
	java.sql.Date DAT_PIF_EGZ_COR, DAT_EFT_EGZ_COR;
  }
%>
