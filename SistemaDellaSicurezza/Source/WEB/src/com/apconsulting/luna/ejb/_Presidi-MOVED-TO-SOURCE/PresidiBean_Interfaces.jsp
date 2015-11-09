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
    <version number="1.0" date="30/01/2004" author="Khomenko Juliya">
	      <comments>
			  <comment date="30/01/2004" author="Khomenko Juliya">
			   <description></description>
			 </comment>		
			  <comment date="01/03/2004" author="Alex Kyba">
				   <description>
				   		dobavleny methody v home interface
						dobavlen class dlia view
				   </description>
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
<%@ page import="java.util.*"%>

<%!
//<ejb-interfaces description="EJB Interfaces">
public interface  IPresidi extends EJBObject
{
  	public long getCOD_PSD_ACD();
	//
	public long getCOD_CAG_PSD_ACD();
	public void setCOD_CAG_PSD_ACD(long lCOD_CAG_PSD_ACD);
	//
	public String getIDE_PSD_ACD();
	public void setIDE_PSD_ACD(String strIDE_PSD_ACD);
	//
	public java.sql.Date getDAT_ULT_CTL();
	public void setDAT_ULT_CTL(java.sql.Date dtDAT_ULT_CTL);
	//
	public String getESI_ULT_CTL();
	public void setESI_ULT_CTL(String strESI_ULT_CTL);
	//
	public long getCOD_LUO_FSC();
	public void setCOD_LUO_FSC(long lCOD_LUO_FSC);
	//
	public String getSTA_PSD_ACD();
	public void setSTA_PSD_ACD(String strSTA_PSD_ACD);
	//-----------------------------
  	// Link Table DOC_PSD_ACD_TAB
  	public void addCOD_DOC(long newCOD_DOC);
  	public void removeCOD_DOC(long newCOD_DOC);
}

public interface IPresidiHome extends EJBHome
{
     public IPresidi create(long lCOD_CAG_PSD_ACD, String strIDE_PSD_ACD, long lCOD_LUO_FSC, String strSTA_PSD_ACD) throws CreateException;
     public IPresidi findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	// opredelenie view metodov
 	public Collection getPresidiDocumentiByID_View(long lCOD_PSD_ACD);
	// by Juli
    public Collection getPresidi_to_SCH_PSD_ACD_View(String SCH_PSD_ACD, long lCOD_AZL, String strSTA_INT, String strCAG_DOC, String strNOM_RSP_INR, long lCOD_CAG_PSD_ACD, String strNOM_CAG_PSD_ACD,  String strIDE_PSD_ACD, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_INR_DAL, java.sql.Date dDAT_INR_AL,String strRAGGRUPPATI, String strSORT_PIF, String strSORT_INT, String strSORT_RSP);     
	   // <ALEX>
	   public PresidioView getPresidio(long lCOD_PSD_ACD);
	   public Collection getPresidiAll();
	   public Collection getPresidiByLuogo(long lCOD_LUO_FSC);
	   //</ALEX>
	   //<report>
       public Collection getPSD_Lov(long COD_AZL,long COD_CAG_PSD_ACD, long COD_PSD_ACD, String strNOM_CAG_PSD_ACD, String strIDE_PSD_ACD);
		//--- mary for search
		public Collection findEx(
			java.sql.Date dtDAT_ULT_CTL, 
			String strIDE_PSD_ACD, 
			String strESI_ULT_CTL, 
			Long lCOD_CAG_PSD_ACD, 
			Long lCOD_LUO_FSC, 
			int iOrderParameter //not used for now
	);
  }
//-------------------------------------------------------------
class PresidiDocumentiByID_View implements java.io.Serializable
{
	public long COD_PSD_ACD;
	public long COD_DOC;
	public String TIT_DOC;
	public String RSP_DOC;
	public java.sql.Date DAT_REV_DOC;
}	
//--<ALEX>
class PresidioView implements java.io.Serializable
{
	public long lCOD_PSD_ACD ;
	public String strNOM_CAG_PSD_ACD ;
	public String strIDE_PSD_ACD;
	public long lCOD_CAG_PSD_ACD;
	public long lCOD_LUO_FSC;
	public java.sql.Date dtDAT_ULT_CTL;
	public String strESI_ULT_CTL; 
 }
//--</ALEX>
class PSD_Lov implements java.io.Serializable
{
   public long COD_PSD_ACD;
   public long COD_CAG_PSD_ACD;
   public String IDE_PSD_ACD;
   public String ESI_ULT_PSD;
   public java.sql.Date DAT_ULT_PSD;
   public String NOM_CAG_PSD_ACD;
}
//
class Presidi_to_SCH_PSD_ACD_View implements java.io.Serializable
{
    public long COD_SCH_INR_PSD;
    public long COD_PSD_ACD;
    public java.sql.Date DAT_PIF_INR;       
    public java.sql.Date DAT_INR;
    public String NOM_RSP_INR;
    public String IDE_PSD_ACD;
    public String NOM_CAG_PSD_ACD;
    public String RAG_SCL_AZL;
}               
//<ejb-interfaces>
%>
