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

<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.AnagrCantieri_All_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.IAnagrCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.CauseInfortuni.ICauseInfortuniHome"%>
<%@page import="com.apconsulting.luna.ejb.SediLesioneCantiere.ISediLesioneCantiereHome"%>
<%!
String BuildSediLesioneCantiereComboBox(ISediLesioneCantiereHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getANA_SED_LES_TAB_ByNOM_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		ANA_SED_LES_CAN_TAB_ByNOM_View  dt = (ANA_SED_LES_CAN_TAB_ByNOM_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_SED_LES){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_SED_LES)+"'>"+Formatter.format(dt.NOM_SED_LES)+" "+Formatter.format(dt.TPL_SED_LES)+"</option>";
  	}
	return str;
}

String BuildCauseInfortunioComboBox(ICauseInfortuniHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getTipologieFormeDinfortunio_UserID_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		CauseInfortuni_UserID_View  dt = (CauseInfortuni_UserID_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_TPL_FRM_INO){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_TPL_FRM_INO)+"'>"+Formatter.format(dt.TIP_TPL_FRM_INO)+" "+Formatter.format(dt.NOM_TPL_FRM_INO)+"</option>";
  	}
	return str;
}

String BuildCantiere1ComboBox(IAnagrCantieriHome home, long SELECTED_ID, long FILTER_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getAnagrCantieri_List_View(FILTER_ID);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AnagrCantieri_All_View dt = (AnagrCantieri_All_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_CAN){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_CAN)+"'>"+Formatter.format(dt.NOM_CAN)+"</option>";
  	}
	return str;
}
%>
