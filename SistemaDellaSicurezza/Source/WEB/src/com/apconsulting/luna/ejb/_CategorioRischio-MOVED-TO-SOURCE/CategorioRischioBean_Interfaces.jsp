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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
			<comment date="24/01/2004" author="Malyuk Sergey">
			  <description></description>
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
// BASE TABLE: TPL_COR_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
//public interface  ICategorioRischio extends EJBObject
public interface ICategorioRischio extends EJBObject
{
  // *Require Fields*
  //1 COD_CAG_FAT_RSO (CategorioRischio ID)
  public long getCOD_CAG_FAT_RSO();
  //2 NOM_CAG_FAT_RSO (name)
  public String getNOM_CAG_FAT_RSO();
  public void setNOM_CAG_FAT_RSO(String newNOM_CAG_FAT_RSO);
  // *Not require Fields*
  //3 DES_CAG_FAT_RSO (descr)
  public String getDES_CAG_FAT_RSO();
  //
  public void setDES_CAG_FAT_RSO (String newDES_CAG_FAT_RSO);
}

//     Home Intrface EJB obiekta
public interface ICategorioRischioHome extends EJBHome
//public interface ICategorioRischioHome extends  ICategorioRischio
{
   public ICategorioRischio create(String strNOM_CAG_FAT_RSO) throws CreateException;
   public void remove(Object primaryKey);
   public ICategorioRischio findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getCategorioRischio_Name_Address_View() throws FinderException;
   public Collection getCategorio_FattoriRischio_View(long COD_CAG_FAT_RSO) throws FinderException;
   public Collection findEx( String strNOM_CAG_RSO,int iOrderParameter /*not used for now*/);
   //<report>
   public Collection getCategorioRischio_LuogiFisici_View(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO);
   public Collection getCategorioRischio_Rischio_View(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_CAG_FAT_RSO);
   //</report>
}

/*public*/
// view metodi
class CategorioRischio_Name_Address_View implements java.io.Serializable{
	public long COD_CAG_FAT_RSO;
	public String NOM_CAG_FAT_RSO;
	public String DES_CAG_FAT_RSO;
}
class Categorio_FattoriRischio_View implements java.io.Serializable{
  	public long COD_CAG_FAT_RSO;
	public String NOM_CAG_FAT_RSO;
}
//<report>
class CategorioRischio_LuogiFisici_View implements java.io.Serializable{
  	public long lCOD_LUO_FSC;
	public String strNOM_LUO_FSC;
}
class CategorioRischio_Rischio_View implements java.io.Serializable{
  	public long lCOD_RSO;
	public String strNOM_RSO;
	public String strDES_RSO;
	public long lPRB_EVE_LES;
	public long lENT_DAN;
	public long lSTM_NUM_RSO;
}
//</report>
%>
