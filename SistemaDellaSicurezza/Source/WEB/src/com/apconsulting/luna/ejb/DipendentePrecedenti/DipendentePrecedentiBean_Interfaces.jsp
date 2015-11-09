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
// BASE TABLE: ANA_DPD
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IDipendentePrecedenti extends EJBObject
{
  //   *Require Fields*
  //1 COD_DIT_PRC_DPD (DipendentePrecedenti ID)
  public long getCOD_DIT_PRC_DPD();
  //2 RAG_SCL_DIT_PRC (Ragione Sociale)
  public String getRAG_SCL_DIT_PRC();
  //3 COD_DPD (dipendente)
  public long getCOD_DPD();
  //public void setCOD_DPD (long newCOD_DPD);
	
	public void setRAG_SCL_DIT_PRC__COD_DPD(String newRAG_SCL_DIT_PRC,long newCOD_DPD);
	
  //4 COD_AZL ()
  public long getCOD_AZL();
  public void setCOD_AZL (long newCOD_AZL);
	
  //   *not Require Fields*
	//5 DES_ATI_SVO_DIT_PRC (Attivita' svolte)
  public String getDES_ATI_SVO_DIT_PRC();
  public void setDES_ATI_SVO_DIT_PRC (String newDES_ATI_SVO_DIT_PRC);
	//6 IDZ_DIT_PRC
  public String getIDZ_DIT_PRC();
  public void setIDZ_DIT_PRC(String newIDZ_DIT_PRC);
	//7 NUM_CIC_DIT_PRC
  public String getNUM_CIC_DIT_PRC();
  public void setNUM_CIC_DIT_PRC(String newNUM_CIC_DIT_PRC);
	//8 CIT_DIT_PRC
  public String getCIT_DIT_PRC();
  public void setCIT_DIT_PRC(String newCIT_DIT_PRC);
	//9 PRV_DIT_PRC
  public String getPRV_DIT_PRC();
  public void setPRV_DIT_PRC(String newPRV_DIT_PRC);
	//10 CAP_DIT_PRC
  public String getCAP_DIT_PRC();
  public void setCAP_DIT_PRC(String newCAP_DIT_PRC);
	//11 STA_DIT_PRC
  public String getSTA_DIT_PRC();
  public void setSTA_DIT_PRC(String newSTA_DIT_PRC);
}

//     Home Intrface EJB obiekta 
public interface IDipendentePrecedentiHome extends EJBHome
{
   public IDipendentePrecedenti create(
    String strRAG_SCL_DIT_PRC,
		long lCOD_DPD,
		long lCOD_AZL
   ) throws CreateException;
   
	 public void remove(Object primaryKey);
   
	 public IDipendentePrecedenti findByPrimaryKey(Long primaryKey) throws FinderException;
   
	 public Collection findAll() throws FinderException;
   
	 // opredelenie view metodov
    public Collection getDipendentePrecedenti_Tipology_Number_View(long lCOD_DPD);
    public Collection getDipendenteAziende_Precedenti_View(String strCOD_FIS_DPD, long lCOD_DPD, long lCOD_AZL);
}

/*public*/
// view metodi   
class DipendentePrecedenti_Tipology_Number_View implements java.io.Serializable{
	public long COD_DPD;
	public long COD_AZL;
	public String RAG_SCL_DIT_PRC,DES_ATI_SVO_DIT_PRC;
	public long COD_DIT_PRC_DPD;
        public boolean AZL_PRE;
}
%>
