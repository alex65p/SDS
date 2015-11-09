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
    <version number="1.0" date="20/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="20/01/2004" author="Mike Kondratyuk">
				   <description>DipendenteLinguestraniereBean_Interfaces.jsp</description>
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
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  IDipendenteLingueStraniere extends EJBObject
{
  //   *Require Fields*
  // COD_LNG_STR_DPD
  public long getCOD_LNG_STR_DPD();
  public void setCOD_LNG_STR_DPD(long newCOD_LNG_STR_DPD);

  // NOM_LNG_STR_DPD
  public String getNOM_LNG_STR_DPD();
  public void setNOM_LNG_STR_DPD(String newNOM_LNG_STR_DPD);

  // LIV_CSC_LNG_STR
  public String getLIV_CSC_LNG_STR();
  public void setLIV_CSC_LNG_STR(String newLIV_CSC_LNG_STR);

  // COD_DPD
  public long getCOD_DPD();
  public void setCOD_DPD(long newCOD_DPD);

  // COD_AZL
  public long getCOD_AZL();
  public void setCOD_AZL(long newCOD_AZL);
}

//     Home Intrface EJB obiekta 
public interface IDipendenteLingueStraniereHome extends EJBHome
{
   public IDipendenteLingueStraniere create(
		String	strNOM_LNG_STR_DPD,
		String	strLIV_CSC_LNG_STR,
		long	lCOD_DPD,
		long	lCOD_AZL
   ) throws CreateException;
   
	 public void remove(Object primaryKey);
   
	 public IDipendenteLingueStraniere findByPrimaryKey(Long primaryKey) throws FinderException;
   
	 public Collection findAll() throws FinderException;
   
	 // opredelenie view metodov
     public Collection getDipendenteLingueStraniere_View(long lCOD_DPD, long lCOD_AZL);
}

/*public*/
// view metodi   
class DipendenteLingueStraniere_View implements java.io.Serializable{
	long 	COD_LNG_STR_DPD;
	String	NOM_LNG_STR_DPD;
	String	LIV_CSC_LNG_STR;
}
%>
