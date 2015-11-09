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
// BASE TABLE: ANA_DPD
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  IStruttAnagraficaImmobili extends EJBObject
abstract class IStruttAnagraficaImmobili extends BMPEntityBean
{
  //   *Require Fields*
  //1 COD_DIT_PRC_DPD (StruttAnagraficaImmobili ID)
  public abstract long getCOD_DIT_PRC_DPD();
  //2 RAG_SCL_DIT_PRC (Ragione Sociale)
  public abstract String getRAG_SCL_DIT_PRC();
  public abstract void setRAG_SCL_DIT_PRC(String newRAG_SCL_DIT_PRC);
  //3 DES_ATI_SVO_DIT_PRC (Attivita' svolte)
  public abstract String getDES_ATI_SVO_DIT_PRC();
  public abstract void setDES_ATI_SVO_DIT_PRC (String newDES_ATI_SVO_DIT_PRC);
  //4 COD_DPD (dipendente)
  public abstract long getCOD_DPD();
  public abstract void setCOD_DPD (long newCOD_DPD);
  //5 COD_AZL ()
  public abstract long getCOD_AZL();
  public abstract void setCOD_AZL (long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
//public interface IStruttAnagraficaImmobiliHome extends EJBHome
abstract class IStruttAnagraficaImmobiliHome extends  IStruttAnagraficaImmobili
{
   public abstract IStruttAnagraficaImmobili create(
    String strRAG_SCL_DIT_PRC,
		String strDES_ATI_SVO_DIT_PRC,
		long lCOD_DPD,
		long lCOD_AZL
   ) throws CreateException;
   public void remove(Object primaryKey) throws FinderException;
   public IStruttAnagraficaImmobili findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getStruttAnagraficaImmobili_Tipology_Number_View() throws FinderException;
}

/*public*/
// view metodi
class StruttAnagraficaImmobili_Tipology_Number_View implements java.io.Serializable{
	public long COD_DPD;
	public long COD_AZL;
	public String RAG_SCL_DIT_PRC,DES_ATI_SVO_DIT_PRC;
	public long COD_DIT_PRC_DPD;
}
%>
