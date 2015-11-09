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

/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="25/01/2004" author="Treskina Maria">
				   <description>Bean Interfejs dla TPL_DPI_TAB</description>
				 </comment>
				 <comment date="25/02/2004" author="Pogrebnoy Yura">
				   <description>removeLUO_FSC_DPI, removeGEST_MAN_DPI</description>
				 </comment>
				 <comment date="27/03/2004" author="Treskina Mary">
				   <description>FindEx dla search</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file> 
*/ 
%>

<%!
// BASE TABLE: ANA_AZL_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface  ITipologiaDPI extends EJBObject
{
  	//   *Require Fields*
  	//1 COD_TPL_DPI (TipologiaDPI ID)
  	public long getCOD_TPL_DPI();
  	//2 NOM_TPL_DPI (tipologia)
	public void setNOM_TPL_DPI(String newNOM_TPL_DPI);
 	 public String getNOM_TPL_DPI();
  	//3 DES_CAR_DPI (number)
	public void setDES_CAR_DPI(String newDES_CAR_DPI);
  	public String getDES_CAR_DPI();
	//   *not Require Fields*
	//4 MDL_PTR_UTI_DPI ()
	public void setMDL_PTR_UTI_DPI(String newMDL_PTR_UTI_DPI);
  	public String getMDL_PTR_UTI_DPI();
	//5 IMG_CSI_DPI ()
	public void setIMG_CSI_DPI(String newIMG_CSI_DPI);
  	public String getIMG_CSI_DPI();
  	//6 CAG_DPI ()
	public void setCAG_DPI(long newCAG_DPI);
  	public long getCAG_DPI();
	//7 PER_MES_SST ()
	public void setPER_MES_SST(long newPER_MES_SST);
  	public long getPER_MES_SST();
	//8 PER_MES_MNT ()
	public void setPER_MES_MNT(long newPER_MES_MNT);
  	public long getPER_MES_MNT();
	
	// Link Table NOR_SEN_TPL_DPI_TAB
	//9 COD_NOR_SEN
  	public void addCOD_NOR_SEN(long newCOD_NOR_SEN);
  	public void removeCOD_NOR_SEN(long newCOD_NOR_SEN);
	// Link Table DOC_DPI_TAB
	public void addCOD_DOC(long newCOD_DOC);
	public void removeCOD_DOC(long newCOD_DOC);

	public void removeLUO_FSC_DPI();
	public void removeGEST_MAN_DPI();
}

//     Home Intrface EJB obiekta 
public interface ITipologiaDPIHome extends EJBHome
{
   	public ITipologiaDPI create(
		String strNOM_TPL_DPI, 
		String strDES_CAR_DPI 
   	) throws CreateException;
   	public void remove(Object primaryKey);
   	public ITipologiaDPI findByPrimaryKey(Long primaryKey) throws FinderException;
   	public Collection findAll() throws FinderException;
   	// opredelenie view metodov
 	public Collection getTipologiaDPI_Name_View();
	public Collection getNormativeSentenzeByTPLID_View(long COD_TPL);
	public Collection getDocumentByTPLDPIID_View(long COD_TPL_DPI);
	public Collection findEx(  
		String strNOM_TPL_DPI,
		String strDES_CAR_DPI,
		int iOrderParameter //not used for now
	);
}

/*public*/
// view metodi  
class TipologiaDPI_Name_View implements java.io.Serializable
{
	public long COD_TPL_DPI;
	public String NOM_TPL_DPI;
	public long PER_MES_SST;
	public long PER_MES_MNT;
}
//
class TipologiaDPI_Name_Desc implements java.io.Serializable
{
	public long COD_TPL_DPI;
	public String NOM_TPL_DPI, DES_CAR_DPI, MDL_PTR_UTI_DPI;
}
//
class NormativeSentenzeByTPLID_View implements java.io.Serializable
{
	public long COD_NOR_SEN;
	public String TIT_NOR_SEN,NUM_DOC_NOR_SEN;
	public java.sql.Date DAT_NOR_SEN;
}
//
class DocumentByTPLDPIID_View implements java.io.Serializable
{
	public long COD_DOC;
	public String TIT_DOC,RSP_DOC;
	public java.sql.Date DAT_REV_DOC;
}
%>
