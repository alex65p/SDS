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
// BASE TABLE: ANA_AZL_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  IChimicoAgento extends EJBObject
public interface IChimicoAgento extends EJBObject
{
  //   *Require Fields*
  //1 COD_SOS_CHI (ChimicoAgento ID)
  public long getCOD_SOS_CHI();
  //2 DES_SOS (descr)
  public String getDES_SOS();
  public void setDES_SOS(String newDES_SOS);
  //3 NOM_COM_SOS (name)
  public String getNOM_COM_SOS();
  public void setNOM_COM_SOS(String newNOM_COM_SOS);
  //4 COD_STA_FSC (cod of )
  public long getCOD_STA_FSC();
  public void setCOD_STA_FSC(long newCOD_STA_FSC);
  //5 COD_STA (cod of )
  public long getCOD_CLF_SOS();
  public void setCOD_CLF_SOS(long newCOD_CLF_SOS);
  //6 COD_PTA_FSC 
  public long getCOD_PTA_FSC();
  public void setCOD_PTA_FSC(long newCOD_PTA_FSC);
  //   *Not require Fields*
  //6 FRS_R ()
  public String getFRS_R();
  public void setFRS_R(String newFRS_R);
  //7 FRS_S ()
  public String getFRS_S();
  public void setFRS_S(String newFRS_S);
  //8 SIM_RIS (cod )
  public String getSIM_RIS();
  public void setSIM_RIS(String newSIM_RIS);
  //9 COD_SIM ()
  public long getCOD_SIM();
  public void setCOD_SIM(long newCOD_SIM);
}

//     Home Intrface EJB obiekta 
//public interface IChimicoAgentoHome extends EJBHome
public interface   IChimicoAgentoHome extends  EJBHome
{
   public IChimicoAgento create(
    String strDES_SOS,
		String strNOM_COM_SOS,
		String strFRS_R,
		long lCOD_STA_FSC,
		long lCOD_CLF_SOS,
		long lCOD_PTA_FSC
   ) throws CreateException;
   public void remove(Object primaryKey);
   public IChimicoAgento findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   //public Collection getChimicoAgento_Name_Desc_View();
   //public Collection getFornitoreTelefonoByFORAZLID_View(long FOR_AZL_ID);
}
/*
/*public*/
// view metodi   
class ChimicoAgento_Name_Desc_View implements java.io.Serializable
{
	public long COD_SOS_CHI;
	public String DES_SOS,NOM_COM_SOS;
}
%>
