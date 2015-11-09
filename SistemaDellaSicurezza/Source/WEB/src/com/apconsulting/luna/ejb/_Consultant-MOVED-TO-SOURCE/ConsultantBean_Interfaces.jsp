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
    <version number="1.0" date="14/01/2004" author="Roman Chumachenko">
	      <comments>
			  <comment date="14/01/2004" author="Roman Chumachenko">
				  <description>ConsultantBean_Interfaces.jsp</description>
			 </comment>
			 <comment date="03/02/2004" author="Pogrebnoy Yura">
                  <description>getAziendeAssociateByCOUID, class AziendeAssociateByCOUID, addCOD_AZL, removeCOD_AZL</description>
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
// BASE TABLE: ANA_COU_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IConsultant extends EJBObject
{
  //   *Require Fields*
  //1 COD_COU (Consultant ID)
  public long getCOD_COU();
  //2 USD_COU ()
  public String getUSD_COU();
  public void setUSD_COU(String newUSD_COU);
  //3 PSW_COU ()
  public String getPSW_COU();
  public void setPSW_COU (String newPSW_COU);
  //4 STA_COU ()
  public String getSTA_COU();
  public void setSTA_COU (String newSTA_COU);
  //5 NOM_COU ()
  public String getNOM_COU();
  public void setNOM_COU (String newNOM_COU);
  //   *Not require Fields*
  //6 RUO_COU ()
  public String getRUO_COU();
  public void setRUO_COU(String newRUO_COU);
  //7 DAT_ATT ()
  public java.sql.Date getDAT_ATT();
  public void setDAT_ATT(java.sql.Date newDAT_ATT);
  //8 DAT_STA ()
  public java.sql.Date getDAT_DIS();
  public void setDAT_DIS(java.sql.Date newDAT_DIS);
  
  public Collection getAziende();
  public Collection getAziendeMOD_CLC_RSO(short sMOD_CLC_RSO);

 // Link Table ANA_AZL_TAB
 //4 COD_AZL
  public void addCOD_AZL(long newCOD_AZL);
  public void removeCOD_AZL(String newCOD_COU,String newCOD_AZL);
}

//     Home Intrface EJB obiekta 
public interface IConsultantHome extends EJBHome
{
   public  IConsultant create(
    String strUSD_COU,
	String strPSW_COU,
	String strSTA_COU, 
	String strNOM_COU
	) throws CreateException;
   public  void remove(Object primaryKey);
   public  IConsultant findByPrimaryKey(Long primaryKey) throws FinderException;
   public  IConsultant findByPrimaryKey(String strConsultant) throws FinderException;
   
   public  Collection findAll() throws FinderException;
   // opredelenie view metodov
   public  Collection getConsultantiByAZLID_View(long AZL_ID);
   // --
   public Collection getAziendeAssociateByCOUID_View(String COD_COU);
    
   public Collection getConsultant_View();
   public long getAZL_COU_TABCount();
   public void removeCOD_AZL(String newCOD_COU,String newCOD_AZL);
   public Collection getConsultantUTN_View();
   public Collection findEx(String strNOM_COU, String strUSD_COU, String strRUO_COU, String strSTA_COU, java.sql.Date dDAT_ATT, java.sql.Date dDAT_DIS, int iOrderParameter);
}  

/*public*/
// view metodi   
class ConsultantiByAZLID_View implements java.io.Serializable{
	public long COD_COU;
	public String NOM_COU,RUO_COU; 
	public java.sql.Date DAT_ATT, DAT_DIS;
}
class ConsultantAzienda_Id_Name_View implements java.io.Serializable{
	public long COD_AZL;
	public String RAG_SCL_AZL;
}
// -- Pogrebnoj Jura 
class AziendeAssociateByCOUID_View implements java.io.Serializable{
  public long COD_AZL;
        public String RAG_SCL_AZL;
        public String NOM_RSP_AZL;
        public String NOM_RSP_SPP_AZL;
}

class ConsultantiUSD_UTN_View implements java.io.Serializable{
	public String USD_COU;
}
//
%>
