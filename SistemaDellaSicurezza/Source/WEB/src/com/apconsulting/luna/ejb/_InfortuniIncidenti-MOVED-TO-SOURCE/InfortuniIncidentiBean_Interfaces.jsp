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
    <version number="1.0" date="27/02/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="27/02/2004" author="Mike Kondratyuk">
				   Interfaces dlia objecta InfortuniIncidenti
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

  public interface  IInfortuniIncidenti extends EJBObject
  {
  	public long getCOD_INO();

	public String getNOM_COM_INO();
	public void setNOM_COM_INO(String strNOM_COM_INO);

	public java.sql.Date getDAT_COM_INO();
	public void setDAT_COM_INO(java.sql.Date dtDAT_COM_INO);

	public java.sql.Date getDAT_EVE_INO();
	public void setDAT_EVE_INO(java.sql.Date dtDAT_EVE_INO);

	public String getORA_EVE_INO();
	public void setORA_EVE_INO(String strORA_EVE_INO);

	public String getGOR_LAV_INO();
	public void setGOR_LAV_INO(String strGOR_LAV_INO);

	public String getORA_LAV_INO();
	public void setORA_LAV_INO(String strORA_LAV_INO);

	public String getORA_LAV_TUN_INO();
	public void setORA_LAV_TUN_INO(String strORA_LAV_TUN_INO);

	public String getTPL_TRA_EVE_INO();
	public void setTPL_TRA_EVE_INO(String strTPL_TRA_EVE_INO);

	public String getIDZ_TRA_EVE_INO();
	public void setIDZ_TRA_EVE_INO(String strIDZ_TRA_EVE_INO);

	public java.sql.Date getDAT_TRA_EVE_INO();
	public void setDAT_TRA_EVE_INO(java.sql.Date dtDAT_TRA_EVE_INO);

	public java.sql.Date getDAT_INZ_ASZ_LAV();
	public void setDAT_INZ_ASZ_LAV(java.sql.Date dtDAT_INZ_ASZ_LAV);

	public java.sql.Date getDAT_FIE_ASZ_LAV();
	public void setDAT_FIE_ASZ_LAV(java.sql.Date dtDAT_FIE_ASZ_LAV);

	public long getGOR_ASZ();
	public void setGOR_ASZ(long lGOR_ASZ);

	public String getDES_EVE_INO();
	public void setDES_EVE_INO(String strDES_EVE_INO);

	public String getDES_ANL_INO();
	public void setDES_ANL_INO(String strDES_ANL_INO);

	public String getDES_CRZ_INO();
	public void setDES_CRZ_INO(String strDES_CRZ_INO);

	public String getDES_RAC_INO();
	public void setDES_RAC_INO(String strDES_RAC_INO);

	public String getDES_DVU_INO();
	public void setDES_DVU_INO(String strDES_DVU_INO);

	public long getCOD_AGE_MAT();
	public void setCOD_AGE_MAT(long lCOD_AGE_MAT);

	public long getCOD_TPL_FRM_INO();
	public void setCOD_TPL_FRM_INO(long lCOD_TPL_FRM_INO);

	public long getCOD_NAT_LES();
	public void setCOD_NAT_LES(long lCOD_NAT_LES);

	public long getCOD_SED_LES();
	public void setCOD_SED_LES(long lCOD_SED_LES);

	public long getCOD_LUO_FSC();
	public void setCOD_LUO_FSC(long lCOD_LUO_FSC);

	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);


  }

  public interface IInfortuniIncidentiHome extends EJBHome
  {
     public IInfortuniIncidenti create(long lCOD_AGE_MAT, long lCOD_TPL_FRM_INO, long lCOD_NAT_LES, long lCOD_SED_LES, long lCOD_LUO_FSC, long lCOD_DPD, long lCOD_AZL) throws CreateException;
     public IInfortuniIncidenti findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	 public	Collection getInfortuniIncidenti_View(long lCOD_AZL);
	 //<report>
	 public SchedaInfortunioIncidenteView getSchedaInfortunioIncidenteView(long lCOD_AZL, long lCOD_INO);
	 public Collection getElencoInfortuniIncidentiView(long lCOD_AZL, String strDAT_DAL, String strDAT_AL);
   	 public	Collection findEx(long lCOD_AZL, long COD_LUO_FSC, long COD_DPD, long COD_NAT_LES,long COD_AGE_MAT,long COD_TPL_FRM_INO,long COD_SED_LES);
  }
  
class InfortuniIncidenti_View implements java.io.Serializable{
	long			COD_INO;
	String			NOM_COM_INO;
	java.sql.Date	DAT_COM_INO;
	java.sql.Date	DAT_EVE_INO;
	String			COG_DPD;
	String			NOM_DPD;
}
//<report>
class SchedaInfortunioIncidenteView implements java.io.Serializable{
   	long   lCOD_DPD;
    String strNOM_SED_LES;
    String strNOM_NAT_LES;
    String strNOM_LUO_FSC;
    String strNOM_TPL_FRM_INO;
    String strNOM_AGE_MAT;
	java.sql.Date dtDAT_EVE_INO;
}

//<ejb-interfaces>
%>

