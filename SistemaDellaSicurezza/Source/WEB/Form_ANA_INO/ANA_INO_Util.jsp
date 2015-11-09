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
    <version number="1.0" date="28/02/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="28/02/2004" author="Mike Kondratyuk">
				   <description>ANA_INO_Util.jsp-functions for ANA_INO</description>
				   <description>Functions for comboboxes and tab</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
/*	ISediLesioneHome home = home interface of DipendenteBean
	long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
*/
String BuildSediLesioneComboBox(ISediLesioneHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getANA_SED_LES_TAB_ByNOM_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		ANA_SED_LES_TAB_ByNOM_View  dt = (ANA_SED_LES_TAB_ByNOM_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_SED_LES){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_SED_LES)+"'>"+Formatter.format(dt.NOM_SED_LES)+" "+Formatter.format(dt.TPL_SED_LES)+"</option>";
  	}
	return str;
}

/*	INaturaLesioneHome home = home interface of DipendenteBean
	long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
*/
String BuildNaturaLesioneComboBox(INaturaLesioneHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getANA_NAT_LES_TAB_ByNOM_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		ANA_NAT_LES_TAB_ByNOM_View  dt = (ANA_NAT_LES_TAB_ByNOM_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_NAT_LES){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_NAT_LES)+"'>"+Formatter.format(dt.NOM_NAT_LES)+"</option>";
  	}
	return str;
}

/*	ITipologieFormeDinfortunioHome home = home interface of DipendenteBean
	long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
*/
String BuildTipologieFormeDinfortunioComboBox(ITipologieFormeDinfortunioHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getTipologieFormeDinfortunio_UserID_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		TipologieFormeDinfortunio_UserID_View  dt = (TipologieFormeDinfortunio_UserID_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_TPL_FRM_INO){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_TPL_FRM_INO)+"'>"+Formatter.format(dt.TIP_TPL_FRM_INO)+" "+Formatter.format(dt.NOM_TPL_FRM_INO)+"</option>";
  	}
	return str;
}

/*	IAgenteMaterialeHome home = home interface of DipendenteBean
	long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
*/
String BuildAgenteMaterialeComboBox(IAgenteMaterialeHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getAgenti_Materiali_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Agenti_Materiali_View dt = (Agenti_Materiali_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_AGE_MAT){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_AGE_MAT)+"'>"+Formatter.format(dt.NOM_AGE_MAT)+" "+Formatter.format(dt.NOM_CAG_AGE_MAT)+"</option>";
  	}
	return str;
}

/*	ILuogoFisicoHome home = home interface of DipendenteBean
	long SELECTED_ID = ID (COD_DPD) of current Dipendente, if not exists then =0
*/
String BuildLuogoFisicoComboBox(IAnagrLuoghiFisiciHome home, long SELECTED_ID, long FILTER_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getAnagrLuoghiFisici_List_View(FILTER_ID);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AnagrLuoghiFisici_List_View dt = (AnagrLuoghiFisici_List_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_LUO_FSC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_LUO_FSC)+"'>"+Formatter.format(dt.NOM_LUO_FSC)+"</option>";
  	}
	return str;
}
%>
