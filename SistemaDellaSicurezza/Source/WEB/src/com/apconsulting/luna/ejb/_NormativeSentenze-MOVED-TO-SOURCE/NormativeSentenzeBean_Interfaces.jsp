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
// BASE TABLE: ANA_NOR_SEN_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  INormativeSentenze extends EJBObject
{
  //   *Require Fields*
  //1 COD_NOR_SEN (NormativeSentenze ID) INDEX
  public long getCOD_NOR_SEN();
  //2 TIT_NOR_SEN (Nome) UNIQUE
  public String getTIT_NOR_SEN();
  public void setTIT_NOR_SEN(String newTIT_NOR_SEN);
  //3 DES_NOR_SEN (Descrizione)
  public String getDES_NOR_SEN();
  public void setDES_NOR_SEN(String newDES_NOR_SEN);
  //4 DAT_NOR_SEN (Data)
  public java.sql.Date getDAT_NOR_SEN();
  public void setDAT_NOR_SEN(java.sql.Date newDAT_NOR_SEN);
	//5 COD_ORN
  public long getCOD_ORN();
  public void setCOD_ORN(long newCOD_ORN);
	//6 COD_SET
  public long getCOD_SET();
  public void setCOD_SET(long newCOD_SET);
	//7 COD_TPL_NOR_SEN
  public long getCOD_TPL_NOR_SEN();
  public void setCOD_TPL_NOR_SEN(long newCOD_TPL_NOR_SEN);
	//8 COD_SOT_SET
  public long getCOD_SOT_SET();
  public void setCOD_SOT_SET(long newCOD_SOT_SET);
//-----------------------------

  //9 NUM_DOC_NOR_SEN
  public String getNUM_DOC_NOR_SEN();
  public void setNUM_DOC_NOR_SEN(String newNUM_DOC_NOR_SEN);
	//10 FON_NOR_SEN
  public String getFON_NOR_SEN();
  public void setFON_NOR_SEN(String newFON_NOR_SEN);
//-----------------------------

	// Link Table DOC_NOR_SEN_TAB
	//11 COD_DOC
  public void addCOD_DOC(long newCOD_DOC);
  public void removeCOD_DOC(long newCOD_DOC);
}

//     Home Intrface EJB obiekta
public interface INormativeSentenzeHome extends EJBHome
{
   public INormativeSentenze create(
  		String TIT_NOR_SEN,
  		String DES_NOR_SEN,
  		java.sql.Date DAT_NOR_SEN,
  		long COD_ORN,
  		long COD_SET,
  		long COD_TPL_NOR_SEN,
  		long COD_SOT_SET
   ) throws CreateException;

	 public void remove(Object primaryKey);
	 public INormativeSentenze findByPrimaryKey(Long primaryKey) throws FinderException;
	 public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getNormativeSentenze_List_View();
   public Collection getNormativeSentenzeDocumenteByDOCID_View(long COD_NOR_SEN);

   //<search>
	  public  Collection findEx(
	  		String TIT_NOR_SEN,
			String DES_NOR_SEN,
			java.sql.Date DAT_NOR_SEN,
			Long COD_ORN,
			Long COD_SET,
			Long COD_TPL_NOR_SEN,
			Long COD_SOT_SET,
			String NUM_DOC_NOR_SEN,
			String FON_NOR_SEN,
			int iOrderBy);
   //</search>
   
}

/*public*/
// view metodi
class NormativeSentenze_List_View implements java.io.Serializable
{
	public long COD_NOR_SEN;
	public String TIT_NOR_SEN, NUM_DOC_NOR_SEN;
	public java.sql.Date DAT_NOR_SEN;
}
class NormativeSentenzeDocumenteByDOCID_View implements java.io.Serializable
{
	public long COD_NOR_SEN;
	public long COD_DOC;
	public String TIT_DOC;
	public String RSP_DOC;
	public java.sql.Date DAT_REV_DOC;
}
%>
