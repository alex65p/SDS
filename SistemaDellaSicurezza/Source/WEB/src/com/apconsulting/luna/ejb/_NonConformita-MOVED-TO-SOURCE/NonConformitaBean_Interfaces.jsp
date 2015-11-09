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
				  <comment date="03/03/2004" author="Alex Kyba">
				 	  <description>
					  	1. dobavlenny view i metody ih vyvodiaschie
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
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%!
// BASE TABLE: ANA_OPE_SVO_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  INonConformita extends EJBObject
//public interface INonConformita extends EJBObject
{
  //   *Require Fields*
      //1
	  public abstract long getCOD_NON_CFO ();
		
  	//2
	  public abstract void setDES_NON_CFO (String newDES_NON_CFO);
    public abstract String getDES_NON_CFO ();
		
		//3
		public abstract void setDAT_RIL_NON_CFO (java.sql.Date newDAT_RIL_NON_CFO);
    public abstract java.sql.Date getDAT_RIL_NON_CFO ();
		
		//4
		public abstract void setNOM_RIL_NON_CFO (String newNOM_RIL_NON_CFO);
    public abstract String getNOM_RIL_NON_CFO ();
		
		//5
		public abstract void setCOD_AZL (long newCOD_AZL);
    public abstract long getCOD_AZL ();
		
	//============================================
	// not required field
	
	//6
	  public abstract void setOSS_NON_CFO (String newOSS_NON_CFO);
     public abstract String getOSS_NON_CFO ();
		
		//7
	  public abstract void setCOD_INR_ADT (long newCOD_INR_ADT);
    public abstract long getCOD_INR_ADT ();

}

//     Home Intrface EJB obiekta 
public interface INonConformitaHome extends EJBHome
//public interface INonConformitaHome extends  INonConformita
{
   public INonConformita create(
	 String strDES_NOM_CFO,
	 java.sql.Date dtDATI_RIL_NON_CFO,
	 String strNOM_RIL_NON_CFO,
	 long lCOD_AZL
	 ) throws CreateException;
   public void remove(Object primaryKey);
   public INonConformita findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
 //  <ALEX>
   public Collection getNonConformita(long lCOD_AZL);
   public Collection getNonConformitaByInterventoAudit(long lCOD_INR_ADT);
 // </ALEX>  
   // opredelenie view metodov
   //public Collection getNonConformita_All_Plus_Description_View() throws FinderException;
	 //--- mary for search
	 public Collection findEx(
	 				String strDES_NON_CFO, 
					String strOSS_NON_CFO, 
					java.sql.Date	dtDAT_RIL_NON_CFO, 
					String strNOM_RIL_NON_CFO, 
					Long lCOD_INR_ADT, 
					int iOrderParameter //not used for now
				);
}

/*public*/
// view metodi   
class NonConformitaAllView implements java.io.Serializable{
	public long lCOD_NON_CFO;
	public String strDES_NON_CFO;
	public java.sql.Date dtDAT_RIL_NON_CFO;
	public String strNOM_RIL_NON_CFO;
	public long lCOD_INR_ADT;
	public String strDES_INR_ADT;
	public String strOSS_NON_CFO;
	public long lCOD_MIS_PET;
}

%>
