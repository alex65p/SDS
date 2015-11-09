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
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Bean dla tablici CAG_PSD_ACD</description>
				 </comment>
	             <comment date="09/03/2004" author="Pogrebnoy Yura">
	             	<description>getCAG_Lov(lCOD_AZL, strNOM_CAG_PSD_ACD)</description>
                 </comment>
					<comment date="27/03/2004" author="Treskina Maria">
				   <description>Search</description>
				  </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  ICategoriePreside extends EJBObject
public interface   ICategoriePreside extends EJBObject
{
	//   *require Fields*
	public String getNOM_CAG_PSD_ACD();
	public void setNOM_CAG_PSD_ACD(String newNOM_CAG_PSD_ACD);
	public long getCOD_CAG_PSD_ACD();
	
	//   *Not require Fields*
	public void setDES_CAG_PSD_ACD(String newDES_CAG_PSD_ACD);
	public String getDES_CAG_PSD_ACD();
	public void setPER_MES_SST(long newPER_MES_SST);
	public long getPER_MES_SST();
	public void setPER_MES_MNT(long newPER_MES_MNT);
	public long getPER_MES_MNT();
//<report>
	//public Collection 	getPresidiByCategoriaView(long lCOD_CAG_PSD_ACD)
}

//     Home Intrface EJB obiekta 
//public interface ICategoriePresideHome extends EJBHome
public interface  ICategoriePresideHome extends  EJBHome
{
   public ICategoriePreside create(String strNOM_CAG_PSD_ACD) throws RemoteException, CreateException;
   public void removeCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD);
   public void addCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD);
   public void remove(Object primaryKey);
   public ICategoriePreside findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;
   public Collection findAll() throws RemoteException, FinderException;
   // opredelenie view metodov
   public Collection getCategoriePreside_Categoria_RagSoc_View() ;
   public Collection getResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD);
   public Collection getResronsabiliti__View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD, long FOR_COD_DPD);
//<report>
	public Collection getCategoriePresidiView(long lCOD_CAG_PSD_ACD); 
	public Collection getPresidiByCategoriaView(long lCOD_CAG_PSD_ACD, long lCOD_PSD_ACD); 
	public Collection getInterventoByPresidiView(long lCOD_PSD_ACD); 
	//
	public Collection getCAG_Lov(long lCOD_AZL, String strNOM_CAG_PSD_ACD);
	public Collection findEx(
		String strNOM_CAG_PSD_ACD, 
		String strDES_CAG_PSD_ACD, 
		Long lPER_MES_SST, 
		Long lPER_MES_MNT,
		int iOrderParameter //not used for now
	);
}

/*public*/
// view metodi   
class CategoriePreside_Categoria_RagSoc_View implements java.io.Serializable{
	public long COD_CAG_PSD_ACD;
	public String  NOM_CAG_PSD_ACD;
}
//
class ResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View implements java.io.Serializable{
	public long COD_DPD;
	public String COG_DPD, NOM_DPD, MTR_DPD;
}
//
class Resronsabiliti__View implements java.io.Serializable{
	public long COD_DPD;
	public String COG_DPD, NOM_DPD, MTR_DPD;
}
//<report>
class CategoriePresidiView implements java.io.Serializable{
	public long lCOD_CAG_PSD_ACD;
    public String strNOM_CAG_PSD_ACD;
    public String strDES_CAG_PSD_ACD;
    public long lPER_MES_SST;
    public long lPER_MES_MNT;
	public String strNOM_LUO_FSC;
	public long lCOD_PSD_ACD;
}
//
class PresidiByCategoriaView implements java.io.Serializable{
	public long lCOD_PSD_ACD ;
	public String strIDE_PSD_ACD;
	public long lCOD_LUO_FSC;
	public java.sql.Date dtDAT_ULT_CTL;
	public String strESI_ULT_CTL; 
 } 
//
class InterventoByPresidiView implements java.io.Serializable{
   public java.sql.Date dtDAT_PIF_INR;
   public java.sql.Date dtDAT_INR;
   public String strNOM_RSP_INR;
   public String strESI_INR;
 } 
//</report>
class CAG_Lov implements java.io.Serializable{
   public long   COD_CAG_PSD_ACD;
   public String NOM_CAG_PSD_ACD;
   public long   PER_MES_SST;
   public long   PER_MES_MNT;
}
//============================================
%>
