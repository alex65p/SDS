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
	<version number="1.0" date="25/01/2004" author="Mike Kondratyuk">
		<comments>
				<comment date="25/01/2004" author="Mike Kondratyuk">
					<description></description>
				</comment>
	 			<comment date="26/02/2004" author="Malyuk Sergey">
					<description>Dinamicheskie tabi i ih reaalizaciia</description>
				</comment>
				  <comment date="29/01/2004" author="Mike Kondratyuk">
				   <description>Peredelal na FindEX()</description>
				  </comment>
	  </comments>
	</version>
  </versions>
</file>
*/
%>

<%!
// BASE TABLE: ANA_CTL_SAN_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//	 Remote Intrface EJB obiekta
public interface  ICartelleSanitarie extends EJBObject
//abstract class ICartelleSanitarie extends BMPEntityBean
{
  // COD_CTL_SAN
  public long getCOD_CTL_SAN();
  public void setCOD_CTL_SAN(long newCOD_CTL_SAN);

  // DAT_CRE_CTL_SAN
  public java.sql.Date getDAT_CRE_CTL_SAN();
  public void setDAT_CRE_CTL_SAN(java.sql.Date newDAT_CRE_CTL_SAN);

  // NOM_MED_RSP_CTL_SAN
  public String getNOM_MED_RSP_CTL_SAN();
  public void setNOM_MED_RSP_CTL_SAN(String newNOM_MED_RSP_CTL_SAN);

  // COD_DPD
  public long getCOD_DPD();
  public void setCOD_DPD(long newCOD_DPD);

  // COD_AZL
  public long getCOD_AZL();
  public void setCOD_AZL(long newCOD_AZL);

  public void addCOD_DOC(long newCOD_DOC);
  public void addCOD_PRO_SAN(long newCOD_PRO_SAN);

	public void addCOD_VST_IDO(long newCOD_VST_IDO,java.sql.Date newDAT_PIF_VST,java.sql.Date newDAT_EFT_VST,String newTPL_ACR_VLU_RSO,String newTPL_ACR_VLU_MED,String newTPL_ACR_EFT,String newIDO_VST,String newNOT_VST_IDO);
	public void editCOD_VST_IDO(long oldCOD_VST_IDO, long newCOD_VST_IDO,java.sql.Date newDAT_PIF_VST,java.sql.Date newDAT_EFT_VST,String newTPL_ACR_VLU_RSO,String newTPL_ACR_VLU_MED,String newTPL_ACR_EFT,String newIDO_VST,String newNOT_VST_IDO,java.sql.Date oldDAT_PIF_VST);
	public void addCOD_VST_MED(long newCOD_VST_MED,java.sql.Date newDAT_PIF_VST,java.sql.Date newDAT_EFT_VST,String newTPL_ACR_VLU_RSO,String newTPL_ACR_VLU_MED,String newTPL_ACR_EFT,String newNOT_VST_MED);
	public void editCOD_VST_MED(long oldCOD_VST_MED, long newCOD_VST_MED,java.sql.Date newDAT_PIF_VST,java.sql.Date newDAT_EFT_VST,String newTPL_ACR_VLU_RSO,String newTPL_ACR_VLU_MED,String newTPL_ACR_EFT,String newNOT_VST_MED, java.sql.Date oldDAT_PIF_VST);

	public void removeCOD_DOC(long newCOD_DOC);
	public void removeCOD_PRO_SAN(long newCOD_PRO_SAN);
	public void removeCOD_VST_IDO(long newCOD_VST_IDO,long COD_DPD, long COD_CTL_SAN,long COD_AZL,java.sql.Date DATA_PIF_VST_IDO);
	public void removeCOD_VST_MED(long newCOD_VST_MED,long COD_DPD, long COD_CTL_SAN,long COD_AZL,java.sql.Date DATA_PIF_VST_MED);
}

//	 Home Intrface EJB obiekta
public interface ICartelleSanitarieHome extends EJBHome
//abstract class ICartelleSanitarieHome extends  ICartelleSanitarie
{
	public  ICartelleSanitarie create(
		java.sql.Date dDAT_CRE_CTL_SAN, 
		String strNOM_MED_RSP_CTL_SAN, 
		long lCOD_DPD, 
		long lCOD_AZL
	) throws CreateException;
	public void remove(Object primaryKey);
	public  ICartelleSanitarie findByPrimaryKey(Long primaryKey) throws FinderException;
	public  Collection findAll() throws FinderException;
	public  Collection getDocumentiCartelle_View(long FilterID);
	public  Collection getProtocolliSanitari_View(long FilterID);
	public  Collection getVisiteIdoneita_View(long FilterID);
	public  Collection getVisiteMediche_View(long FilterID);
	public  Collection getCTL_VST_IDO_View();
	public  Collection getCTL_VST_MED_View();
	public Collection getCTL_VST_IDO_All_View(long lCOD_VST_IDO,long lCOD_AZL,long lCOD_DPD,long lCOD_CTL_SAN,java.sql.Date  dtDATE_PIF_VST);
	public Collection getCTL_VST_MED_All_View(long lCOD_VST_MED,long lCOD_AZL,long lCOD_DPD,long lCOD_CTL_SAN,java.sql.Date  dtDATE_PIF_VST);
	public Collection getCTL_SAN_All_View(long lCOD_AZL);
   //<report>
	public  Collection getReportVisiteIdoneita_View(long FilterID);
	public  Collection getReportVisiteMediche_View(long FilterID);
   //</report>
   public Collection findEx(
   	long	lCOD_AZL,
   	java.sql.Date	datDAT_CRE_CTL_SAN,
   	String	strNOM_MED_RSP_CTL_SAN,
   	Long	lCOD_DPD,
	int	iOrderParameter /*not used for now*/
   );
}

//-----------------------------------------------------------
class DocumentiCartelle_View implements java.io.Serializable{
	public long COD_DOC;
	public String NB_TIT_DOC;
	public String NB_RSP_DOC;
	public java.sql.Date NB_DAT_REV_DOC;
}
//
class ProtocolliSanitari_View implements java.io.Serializable{
	public long COD_PRO_SAN;
	public String NOM_PRO_SAN;
}
//
class VisiteIdoneita_View implements java.io.Serializable{
	public long COD_VST_IDO;
	public String NOM_VST_IDO;
    public java.sql.Date DAT_PIF_VST_IDO;
 }
//
class VisiteMediche_View implements java.io.Serializable{
	public long COD_VST_MED;
	public String NOM_VST_MED;
    public java.sql.Date DAT_PIF_VST_MED;
}
//
class CTL_VST_IDO_View implements java.io.Serializable{
	public long COD_VST_IDO;
	public String NOM_VST_IDO;
	public java.sql.Date DAT_PIF_VST;
	public java.sql.Date DAT_EFT_VST;
	public long COD_CTL_SAN;
}
//
class CTL_VST_MED_View implements java.io.Serializable{
	public long COD_VST_MED;
	public String NOM_VST_MED;
	public java.sql.Date DAT_PIF_VST;
	public java.sql.Date DAT_EFT_VST;
	public long COD_CTL_SAN;
}
//
class CTL_VST_IDO_All_View implements java.io.Serializable{
	public long COD_VST_IDO;
	public String NOM_VST_IDO;
	public java.sql.Date DAT_PIF_VST;
	public java.sql.Date DAT_EFT_VST;
	public String TPL_ACR_VLU_RSO;
	public String TPL_ACR_VLU_MED;
	public String TPL_ACR_EFT;
	public String IDO_VST;
	public String NOT_VST_IDO;
}
//
class CTL_VST_MED_All_View implements java.io.Serializable{
	public long COD_VST_MED;
	public String NOM_VST_MED;
	public java.sql.Date DAT_PIF_VST;
	public java.sql.Date DAT_EFT_VST;
	public String TPL_ACR_VLU_RSO;
	public String TPL_ACR_VLU_MED;
	public String TPL_ACR_EFT;
	public String NOT_VST_MED;
}
//
class CTL_SAN_All_View implements java.io.Serializable{
	public long COD_CTL_SAN;
	public String MTR_DPD;
	public String NOM_DPD;
	public String COG_DPD;
	public java.sql.Date DAT_CRE_CTL_SAN;
	public String NOM_MED_RSP_CTL_SAN;
}
//<report>
class ReportVisiteIdoneita_View implements java.io.Serializable{
	public long COD_VST_IDO;
	public String NOM_VST_IDO;
	public java.sql.Date DAT_EFT_VST_IDO;
}
//
class ReportVisiteMediche_View implements java.io.Serializable{
	public long COD_VST_MED;
	public String NOM_VST_MED;
	public java.sql.Date DAT_EFT_VST_MED;
}
//</report>
%>
