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
    <version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      <comments>
			<comment date="26/01/2004" author="Artur Denysenko">
				   Interfaces dlia objecta RischioFattore
			<comment date="03/02/2004" author="Pogrebnoy Yura">
			   getAnagraficaDocumente_View(String strCOD_FAT_RSO)
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
public interface  IRischioFattore extends EJBObject
{
  	public long getCOD_FAT_RSO();
	//
	public String getNOM_FAT_RSO();
	public void setNOM_FAT_RSO(String strNOM_FAT_RSO);
	//
	public String getDES_FAT_RSO();
	public void setDES_FAT_RSO(String strDES_FAT_RSO);
	//
	public long getNUM_FAT_RSO();
	public void setNUM_FAT_RSO(long lNUM_FAT_RSO);
	//
	public long getCOD_CAG_FAT_RSO();
	public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO);
	//
	public long getCOD_NOR_SEN();
	public void setCOD_NOR_SEN(long lCOD_NOR_SEN);
	//
  	public void addDOC_FAT_RSO(long lCOD_DOC);
	public void removeDOC_FAT_RSO(long COD_DOC);
}
//
public interface IRischioFattoreHome extends EJBHome
{
     public IRischioFattore create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws CreateException;
     public IRischioFattore findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
     public Collection getComboView();
	 public Collection getFattoreRischio_View();
     //by artur
     public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO);
     public Collection getReport_RischioFattore_ComboView(long lCOD_AZL, long lCOD_MAN, long lCOD_CAG_FAT_RSO);
	 public Collection getComboView(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO);
	 public Collection getReport_RischioFattore_RischioView2(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_FAT_RSO);
 	 //<alex "19/03/2004">
	 public Collection getFattoriWithoutRischiView(long lCOD_AZL, long lCOD_MAN);
	 public void deleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN);
	 public void addFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO);
	 //</alex>
 	 //<artur "19/03/2004">
	 public Collection getFattoriUWithoutRischiView(long lCOD_AZL, long lCOD_UNI_ORG);
	 public void deleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG);
	public void addFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_FAT_RSO);
	 //</artur>	 
	 
	 //<Pogrebnoy Yura "27/03/2004">
	 public Collection findEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter);
  }
  
//<ejb-interfaces>
public class RischioFattore_ComboView implements java.io.Serializable
{
	public	long lCOD_FAT_RSO;
	public	String strNOM_FAT_RSO;
}
//by artur
public class RischioFattore_ComboView2 extends RischioFattore_ComboView
{
	public	long lNUM_FAT_RSO;
}
public class Report_RischioFattore_RischioView implements java.io.Serializable
{
	public long lCOD_RSO;
	public String strNOM_RSO;
	public String strDES_RSO;
	public long lPRB_EVE_LES;
	public long lENT_DAN;
	public float lSTM_NUM_RSO;
        public long lFRQ_RIP_ATT_DAN;
        public long lNUM_INC_INF;
}
public class FattoreRischio_View implements java.io.Serializable
{
	public long   COD_FAT_RSO;
	public String NOM_FAT_RSO;
	public long   NUM_FAT_RSO;
	public String DES_FAT_RSO;
	public long lFlag;
}
%>
