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
<%!

//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  IFornitore extends EJBObject
public interface   IFornitore extends EJBObject
{
	//   *require Fields*
  public String getRAG_SOC_FOR_AZL();
  //public void setRAG_SOC_FOR_AZL(String newRAG_SOC_FOR_AZL);
	public String getCAG_FOR();
  public void setRAG_SOC_FOR_AZL__CAG_FOR(String newRAG_SOC_FOR_AZL, String newCAG_FOR);
	
	public String getIDZ_FOR();
  public void setIDZ_FOR(String newIDZ_FOR);
	public String getCIT_FOR();
  public void setCIT_FOR(String newCIT_FOR);
	public String getQLF_RSP_FOR();
  public void setQLF_RSP_FOR(String newQLF_RSP_FOR);
	public String getNOM_RSP_FOR();
  public void setNOM_RSP_FOR(String newNOM_RSP_FOR);

  public long getCOD_STA();
	public String getsCOD_STA();
  public void setCOD_STA(long newCOD_STA);
  public long getCOD_AZL();
	public String getsCOD_AZL();
	public void setCOD_AZL(long newCOD_AZL);
	public long getCOD_FOR_AZL();
	
	//   *Not require Fields*
	public String getNUM_CIC_FOR();
  public void setNUM_CIC_FOR(String newNUM_CIC_FOR);
	public String getPRV_FOR();
  public void setPRV_FOR(String newPRV_FOR);
	public String getCAP_FOR();
  public void setCAP_FOR(String newCAP_FOR);
	public String getIDZ_PSA_ELT_RSP();
  public void setIDZ_PSA_ELT_RSP(String newIDZ_PSA_ELT_RSP);
	public String getSIT_INT_FOR();
  public void setSIT_INT_FOR(String newSIT_INT_FOR);
	
// Link Table SOS_CHI_FOR_AZL_TAB
  public void addCOD_SOS_CHI(long newCOD_SOS_CHI);
  public void removeCOD_SOS_CHI(long newCOD_SOS_CHI);
// Link Table DOC_DPI_TAB
	public void addCOD_MAC(long newCOD_MAC);
	public void removeCOD_MAC(long newCOD_MAC);
}

//     Home Intrface EJB obiekta 
//public interface IFornitoreHome extends EJBHome
public interface  IFornitoreHome extends  EJBHome
{
   public IFornitore create(
    String RAG_SOC_FOR_AZL,
  	String CAG_FOR,
  	String IDZ_FOR,
  	String CIT_FOR,
		String QLF_RSP_FOR,
		String NOM_RSP_FOR,
		long COD_AZL,
		long COD_STA
   ) throws RemoteException, CreateException;
   public void remove(Object primaryKey);
   public IFornitore findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;
   public Collection findAll() throws RemoteException, FinderException;
   // opredelenie view metodov
   public Collection getFornitore_Categoria_RagSoc_View(long AZL_ID);
	 
	 public Collection getChimicalAgentoByFORAZLID_View(long FOR_AZL_ID);
	 public Collection getMacchinaByFORAZLID_View(long FOR_AZL_ID);

	 public Collection findEx(  
	 												long lCOD_AZL,
													String strRAG_SOC_FOR_AZL,
													String strCAG_FOR,
											    String strIDZ_FOR,
													String strNUM_CIC_FOR,
													String strCIT_FOR,
													String strPRV_FOR,
													String strCAP_FOR,
													String strQLF_RSP_FOR,
													String strNOM_RSP_FOR,
													String strIDZ_PSA_ELT_RSP,
													String strSIT_INT_FOR,
												int iOrderParameter //not used for now
												);
												
}

/*public*/
// view metodi   

class Fornitore_Categoria_RagSoc_View implements java.io.Serializable{
	public long COD_FOR_AZL;
	public String  CAG_FOR,RAG_SOC_FOR_AZL;
}

class ChimicalAgentoByFORAZLID_View implements java.io.Serializable{
	public long COD_SOS_CHI;
	public String DES_SOS, NOM_COM_SOS;
}

class MacchinaByFORAZLID_View implements java.io.Serializable{
	public long COD_MAC;
	public String IDE_MAC, DES_MAC;
}

%>


