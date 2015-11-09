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
    <version number="1.0" date="28/01/2004" author="Alexey Kolesnik">
      <comments>
		   <comment date="28/01/2004" author="Alexey Kolesnik">
				   Interfaces dlia objecta RapportiniSegnalazione
		   </comment>
		   <comment date="02/03/2004" author="Pogrebnoy Yura">
				   Rapportini_View dlya SCH_ADT_Form.jsp
		   </comment>
		   <comment date="29/03/2004" author="Treskina Maria">
				   	<description>Search</description>
		   </comment>
		   <comment date="20/04/2004" author="Alex Kyba">
				   	<description>change search to search by azienda</description>
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
public interface  IRapportiniSegnalazione extends EJBObject
{
  	public long getCOD_SGZ();

	public String getDES_SGZ();
	public void setDES_SGZ(String strDES_SGZ);

	public java.sql.Date getDAT_SGZ();
	public void setDAT_SGZ(java.sql.Date dtDAT_SGZ);

	public long getNUM_SGZ();
	public void setNUM_SGZ(long lNUM_SGZ);

	public long getVER_SGZ();
	public void setVER_SGZ(long lVER_SGZ);

	public String getTIT_SGZ();
	public void setTIT_SGZ(String strTIT_SGZ);

	public String getSTA_SGZ();
	public void setSTA_SGZ(String strSTA_SGZ);

	public String getURG_SGZ();
	public void setURG_SGZ(String strURG_SGZ);

	public String getDES_ATI_SGZ();
	public void setDES_ATI_SGZ(String strDES_ATI_SGZ);

	public String getSTA_FIE_SGZ();
	public void setSTA_FIE_SGZ(String strSTA_FIE_SGZ);

	public java.sql.Date getDAT_FIE();
	public void setDAT_FIE(java.sql.Date dtDAT_FIE);

	public String getNOM_RIL_SGZ();
	public void setNOM_RIL_SGZ(String strNOM_RIL_SGZ);

	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);

	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);

	public void setVER_SGZ__TIT_SGZ(long lVER_SGZ, String strTIT_SGZ);
  }
//
public interface IRapportiniSegnalazioneHome extends EJBHome
{
    public IRapportiniSegnalazione create(String strDES_SGZ, java.sql.Date dtDAT_SGZ, long lNUM_SGZ, long lVER_SGZ, String strTIT_SGZ, String strSTA_SGZ, String strURG_SGZ, String strNOM_RIL_SGZ, long lCOD_DPD, long lCOD_AZL) throws CreateException;
    public IRapportiniSegnalazione findByPrimaryKey(Long primaryKey) throws  FinderException;
    public Collection findAll() throws FinderException;
    public void remove(Object primaryKey);
   	// opredelenie view metodov
    public Collection getRapportiniSegnalazione_List_View();
	public Collection getRapportiniSegnalazione_List_ID_View(long lCOD_SGZ);
    public Collection getMax_Numero_View();
	public Collection getRapportini_View(
	     long lCOD_AZL, long lCOD_DPD, String strTIT_SGZ, String strNOM_RIL_SGZ,
		 java.sql.Date dDAT_SGZ_DAL, java.sql.Date dDAT_SGZ_AL,
		 java.sql.Date dDAT_SCA_DAL, java.sql.Date dDAT_SCA_AL,
		 String strRG_GROUP, String strSTA_INT, String strVAR_SGZ, String strVAR_SCA
	);
	public Collection findEx(
		 Long lCOD_DPD, 
		 String strDES_SGZ, 
		 java.sql.Date dtDAT_SGZ, 
		 Long lNUM_SGZ, 
		 Long lVER_SGZ, 
		 String strTIT_SGZ, 
		 String strSTA_SGZ, 
		 String strURG_SGZ, 
		 String strDES_ATI_SGZ, 
		 String strSTA_FIE_SGZ, 
		 java.sql.Date dtDAT_FIE, 
		 String strNOM_RIL_SGZ, 
		 long lCOD_AZL,
		 int iOrderParameter //not used for now
	);
  }

// view metodi
class Rapportini_View implements java.io.Serializable{
  	public long COD_SGZ;
	public long COD_ATI_SGZ;
	public java.sql.Date DAT_SGZ;
	public java.sql.Date DAT_SCA;
	public String COG_DPD;
	public String NOM_DPD;
	public String RAG_SCL_AZL;
	public long COD_AZL;
}
//
class RapportiniSegnalazione_List_View implements java.io.Serializable{
	public long COD_SGZ;
	public String TIT_SGZ;
	public String COG_DPD,NOM_DPD;
	public java.sql.Date DAT_SGZ;
}
//
class RapportiniSegnalazione_List_ID_View implements java.io.Serializable{
	public long COD_ATI_SGZ;
	public String DES_ATI_SGZ;
	public java.sql.Date DAT_SCA;
}
//
class Max_Numero_View implements java.io.Serializable{
	public long NUM_SGZ;
}
//<ejb-interfaces>
%>
