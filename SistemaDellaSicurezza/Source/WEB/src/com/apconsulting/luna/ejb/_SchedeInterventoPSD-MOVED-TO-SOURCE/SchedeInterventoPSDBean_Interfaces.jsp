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
    <version number="1.0" date="" author="">		
      <comments>
			  <comment date="09/03/2004" author="Mike Kondratyuk">
				   <description>getSchedeInterventoPSD_Responsabile_View dlya SCH_PSD_ACD</description>
			  </comment>
			  <comment date="29/03/2004" author="Treskina Maria">
				  <description>Search</description>
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
// BASE TABLE: NAT_LES_TAB
//     Remote Intrface EJB obiekta 
public interface ISchedeInterventoPSD extends EJBObject{
  	//*Require Fields*
    //1
	public long getCOD_SCH_INR_PSD();
	//2
	public void setCOD_PSD_ACD(long newCOD_PSD_ACD);
    public long getCOD_PSD_ACD();
  	//3
	public void setTPL_INR_PSD(String newTPL_INR_PSD);
    public String getTPL_INR_PSD();
	//4
	public void setDAT_PIF_INR(java.sql.Date newDAT_PIF_INR);
    public java.sql.Date getDAT_PIF_INR();
	//============================================
	// not required field
  	//5
	public void setATI_SVO(String newATI_SVO);
    public String getATI_SVO();
	//6
	public void setDAT_INR(java.sql.Date newDAT_INR);
    public java.sql.Date getDAT_INR();
	//7
	public void setESI_INR(String newESI_INR);
    public String getESI_INR();
	//8
	public void setPBM_RSC(String newPBM_RSC);
    public String getPBM_RSC();
	//9
	public void setNOM_RSP_INR(String newNOM_RSP_INR);
    public String getNOM_RSP_INR();
	//
	public void addCOD_DOC(long newCOD_DOC);
    public void removeCOD_DOC(long newCOD_DOC);
}

//     Home Intrface EJB obiekta 
public interface ISchedeInterventoPSDHome extends EJBHome
{
   	public ISchedeInterventoPSD create(
		long lCOD_PSD_ACD, 
		String strTPL_INR_PSD, 
		java.sql.Date dtDAT_PIF_INR
	) throws CreateException;
   	public void remove(Object primaryKey);
   	public ISchedeInterventoPSD findByPrimaryKey(Long primaryKey) throws FinderException;
   	public Collection findAll() throws FinderException;
	//--- view
	public Collection getSchedeInterventoPSD_SelectData_View();
	public Collection getSchedeInterventoPSD_ForTab_View(long SCH_PSD_ID);
	public Collection getSchedeInterventoPSD_ForPresidi_View(long SCH_PSD_ID);
	public Collection getSchedeInterventoPSD_ForView_View();
   	public Collection getSchedeInterventoPSD_Responsabile_View(long COD_PSD_ACD, String WHE_IN_AZL);
	public Collection findEx(
		String strTPL_INR_PSD,
		Long lCOD_PSD_ACD,
		String strATI_SVO,
		java.sql.Date dtDAT_INR,
		java.sql.Date dtDAT_PIF_INR,
		String strNOM_RSP_INR,
		int iOrderParameter
	);
}

class SchedeInterventoPSD_SelectData_View implements java.io.Serializable
{
	public long COD_PSD_ACD;
	public String IDE_PSD_ACD, NOM_CAG_PSD_ACD, NOM_LUO_FSC;
}
//
class SchedeInterventoPSD_ForTab_View implements java.io.Serializable
{
	public long COD_DOC;
	public String RSP_DOC, TIT_DOC;
	public java.sql.Date DAT_REV_DOC;
}
//For Presidi
class SchedeInterventoPSD_ForPresidi_View implements java.io.Serializable
{
  	public long COD_SCH_INR_PSD;
	public String NOM_RSP_INR, ESI_INR;
	public java.sql.Date DAT_PIF_INR, DAT_INR;
}
//
class SchedeInterventoPSD_ForView_View implements java.io.Serializable
{
  	public long COD_PSD_ACD, COD_SCH_INR_PSD;
	public String NOM_RSP_INR, ESI_INR, IDE_PSD_ACD, NOM_CAG_PSD_ACD, NOM_LUO_FSC, ATI_SVO, PBM_RSC, TPL_INR_PSD;
	public java.sql.Date DAT_PIF_INR, DAT_INR;
}
//
//--<MIKE>
class SchedeInterventoPSD_Responsabile_View implements java.io.Serializable
{
	public long lCOD_PSD_ACD ;
	public String strNOM_RSP_INR ;
}
//--</MIKE>
%>
