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
    <version number="1.0" date="20/02/2004" author="Malyuk Sergey">		
      <comments>
			   <comment date="20/02/2004" author="Malyuk Sergey">
				   Interfaces dlia objecta UnitaSicurezza
			   </comment>		
			    <comment date="24/02/2004" author="Malyuk Sergey">
				   dobavleny methody dlia otobrazheniya dereva
			   </comment>
			   <comment date="24/02/2004" author="Alexey Kolesnik">
                     View for DPD_UNI_SIC (OrganizzativaByAZLID_View)
                     View for DPD_UNI_SIC (OrganizzativaByUNI_SICID_View)
               </comment>
               <comment date="25/02/2004" author="Alexey Kolesnik">
                    Added addCOD_UNI_ORG (Organizzativa link)
              </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="java.util.*"%>

<%!
//< ejb-interfaces description="EJB Interfaces">
public interface  IUnitaSicurezza extends EJBObject
{
  	public long getCOD_UNI_SIC();
	//
	public String getNOM_UNI_SIC();
	public void setNOM_UNI_SIC(String strNOM_UNI_SIC);
	//
	public String getDES_UNI_SIC();
	public void setDES_UNI_SIC(String strDES_UNI_SIC);
	//
	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);
	//
	public long getCOD_UNI_SIC_ASC();
	public void setCOD_UNI_SIC_ASC(long lCOD_UNI_SIC_ASC);
	//------------------<ALEX>--------------------
	public void setNOM_UNI_SIC__COD_AZL(String strNOM_UNI_SIC, long lCOD_AZL);
	public Collection getChildren(long lCOD_AZL); 	
	public AssociativaView getAssociativa(long lCOD_UNI_ORG, long lCOD_DPD);
	//<report>
		public Collection getResponsabile();
	//</report>
	//------------------</ALEX>-------------------
    public void addOrganizzativa(long lC_U_S, long lC_D, long lC_U_O, long lC_A);
    public void removeOrganizzativa(long lC_U_S, long lC_D, long lC_U_O, long lC_A);
  }

  public interface IUnitaSicurezzaHome extends EJBHome
  {
     public IUnitaSicurezza create(String strNOM_UNI_SIC, long lCOD_AZL) throws CreateException;
     public IUnitaSicurezza findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	 public Collection getOrganizativaByUNISICID_View(long UNI_SIC_ID);
	//--------------<ALEX>-------------------
	 public Collection getTopOfTree(long lCOD_AZL);
	//--------------</ALEX>------------------
	public Collection getOrganizzativaByAZLID_View(long COD_AZL);
    public Collection findOrganizzativaByCOD_UNI_SIC(long COD_UNI_SIC, long COD_UNI_ORG);
  	public Collection getUnitaSicurezza_View(long COD_AZL);
  }

//-----------<ALEX>----------------------
class UnitaSicurezzaView implements java.io.Serializable{
	public long lCOD_UNI_SIC;
	public String strNOM_UNI_SIC; 
	public String strDES_UNI_SIC ; 
	public long lCOD_AZL; 
	public long lCOD_UNI_SIC_ASC;
}	
class AssociativaView implements java.io.Serializable{
	public long lCOD_DPD ;
	public String strNOM_DPD ;
	public String strMTR_DPD;
	public String strCOG_DPD;
	public long lCOD_UNI_ORG;
	public AssociativaView(){
		lCOD_DPD=0;
		strNOM_DPD="";
		strMTR_DPD="";
		strCOG_DPD="";
		lCOD_UNI_ORG=0;
	}
}
//------------</ALEX>--------------------
 class Organizativa_View implements java.io.Serializable{
 	public long COD_UNI_ORG;
  	public String NOM_UNI_ORG;
	public long COD_DPD;
 }
//
class OrganizzativaByAZLID_View implements java.io.Serializable{
   public long COD_UNI_ORG;
   public String NOM_UNI_ORG;
}
class OrganizzativaByCOD_UNI_SIC implements java.io.Serializable{
    public long lCOD_UNI_SIC;
    public long lCOD_AZL;
    public long lCOD_DPD;
    public long lCOD_UNI_ORG;
}
//
class USResponsabileView implements java.io.Serializable{
	public long lCOD_DPD ;
	public String strNOM_DPD ;
	public String strCOG_DPD;
}
//< ejb-interfaces>
%>
