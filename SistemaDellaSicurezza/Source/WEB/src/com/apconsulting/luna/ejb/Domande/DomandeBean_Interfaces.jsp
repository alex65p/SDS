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
// BASE TABLE: ANA_DMD_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  IDomande extends EJBObject
{
  //   *Require Fields*
  //1 COD_DMD (Domande ID)
  public long getCOD_DMD();
  //2 NOM_DMD (Nome) UNIQUE
  public String getNOM_DMD();
  public void setNOM_DMD(String newNOM_DMD);
//-----------------------------
  //3 DES_DMD (Descrizione) NULLABLE
  public String getDES_DMD();
  public void setDES_DMD(String newDES_DMD);
//-----------------------------
// Link Table RST_DMD_TAB
	//4 COD_RST 
  public void addCOD_RST(long newCOD_RST, String newRST_ESI);
	public void editCOD_RST(String newCOD_RST); //--- mary
	public void clearCOD_RST(); //--- mary
  public void removeCOD_RST(long newCOD_RST);
	public long getNUM_PTG_DMD(long newCOD_TES_VRF);
	public void setNUM_PTG_DMD(long newNUM_PTG_DMD, long newCOD_TES_VRF);
}

//     Home Intrface EJB obiekta
public interface IDomandeHome extends EJBHome
{
   public IDomande create(
      String NOM_DMD
    , String DES_DMD
   ) throws CreateException;

	 public void remove(Object primaryKey);

	 public IDomande findByPrimaryKey(Long primaryKey) throws FinderException;

	 public Collection findAll() throws FinderException;

	 // opredelenie view metodov
   public Collection getDomande_List_View();
	 public Collection getDomandeRisposteByDMDID_View(long COD_DMD);
	 public Collection findEx(	
	 							Long lCOD_TES_VRF,
								String strNOM_DMD,
								String strDES_DMD,
								int iOrderBy /*not used for now*/
							);

}

/*public*/
// view metodi
class Domande_List_View implements java.io.Serializable{
	public long COD_DMD;
	public String NOM_DMD,DES_DMD;
}

class DomandeRisposteByDMDID_View implements java.io.Serializable{
	public long COD_DMD;
	public long COD_RST;
	public String NOM_RST;
	public String RST_ESI;
}
%>
