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
    <version number="1.0" date="30/01/2004" author="Mike Kondratyuk">
      <comments>
			   <comment date="30/01/2004" author="Mike Kondratyuk">
				   Interfaces dlia objecta AzioniCorrectivePreventive
			   </comment>
				 <comment date="26/02/2004" author="Pogrebnoy Yura">
				   addDOC_GEST_AZN_CRR_PET(id_attachment);removeDOC_GEST_AZN_CRR_PET(String strCOD_DOC)
			   </comment>
			   <comment date="02/03/2004" author="Roman Chumachenko">
				   <description>Remake to new requirements (Home View)</description>
			   </comment>
			   <comment date="10/03/2004" author="Roman Chumachenko">
				   <description>Method for Report</description>
			   </comment>
			   <comment date="29/03/2004" author="Malyuk Sergey">
				   <description> Peredelka view
			   </description>
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

public interface  IAzioniCorrectivePreventive extends EJBObject
{
  	public long getCOD_AZN_CRR_PET();

	public long getCOD_INR_ADT();
	public void setCOD_INR_ADT(long lCOD_INR_ADT);

	public String getDES_AZN_RCH();
	public void setDES_AZN_RCH(String strDES_AZN_RCH);

	public String getRCH_AZN_CRR_PET();
	public void setRCH_AZN_CRR_PET(String strRCH_AZN_CRR_PET);

	public java.sql.Date getDAT_RCH();
	public void setDAT_RCH(java.sql.Date dtDAT_RCH);

	public String getTPL_ATT();
	public void setTPL_ATT(String strTPL_ATT);

	public String getMTZ_ATT();
	public void setMTZ_ATT(String strMTZ_ATT);

	public String getDES_AZN_CRR_PET();
	public void setDES_AZN_CRR_PET(String strDES_AZN_CRR_PET);

	public String getTPL_AZN();
	public void setTPL_AZN(String strTPL_AZN);

	public String getMTZ_AZN();
	public void setMTZ_AZN(String strMTZ_AZN);

	public java.sql.Date getDAT_AZN();
	public void setDAT_AZN(java.sql.Date dtDAT_AZN);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);

	//--------------------------------------------------------
	public String getInterventiAuditDesc();
	//--------------------------------------------------------
  	public void addDOC_GEST_AZN_CRR_PET(long lCOD_DOC);
	public void removeDOC_GEST_AZN_CRR_PET(String strCOD_DOC);
	//--------------------------------------------------------
	// -- Report --
	public Collection getDocumenti_List_View();
}

  public interface IAzioniCorrectivePreventiveHome extends EJBHome
  {
     public IAzioniCorrectivePreventive create(String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, long lCOD_AZL) throws CreateException;
     public IAzioniCorrectivePreventive findByPrimaryKey(Long primaryKey) throws FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
     public Collection getDocumentByAZN_CRR_ID_View(long COD_AZN_CRR_PET);
	 /*<comment date="02/03/2004" author="Roman Chumachenko">
		<description>Remake to new requirements (Home View)</description>
	 </comment>*/
	 public Collection getAzioniCorrectivePreventive_AZL_View(long lCOD_AZL);
	 public Collection getAzioniCorrectivePreventive_View();
	 public Collection findEx_AZL(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH,String strTPL_ATT,String strDES_AZN_CRR_PET,String strTPL_AZN,java.sql.Date dtDAT_AZN, int iOrderParameter /*not used for now*/);
     public Collection findEx(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH, int iOrderParameter /*not used for now*/);
  }
// view metodi
class DocumentByAZN_CRR_ID_View implements java.io.Serializable{
	public long COD_AZN_CRR_PET;
	public long COD_DOC;  
	public String TIT_DOC;
	public String RSP_DOC;
	public java.sql.Date DAT_REV_DOC;
}
	/*<comment date="02/03/2004" author="Roman Chumachenko">
		<description>Remake to new requirements (Home View)</description>
	 </comment>*/
class AzioniCorrectivePreventive_View implements java.io.Serializable{
	public long COD_AZN_CRR_PET;
	public String RCH_AZN_CRR_PET,TPL_ATT,TPL_AZN,DES_INR_ADT;
	public java.sql.Date DAT_RCH,DAT_AZN;
}

// --- Report ---
class AZN_Documenti_List_View implements java.io.Serializable{
	public long COD_DOC;
}
//<ejb-interfaces>
%>

