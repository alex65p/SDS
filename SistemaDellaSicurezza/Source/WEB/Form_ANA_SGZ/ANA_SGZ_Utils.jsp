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


<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%!
String BuildImmobiliComboBox(IImmobili3lvHome home, long SELECTED_ID, long COD_AZL)
{
	String str="";
	String strSEL="";
	java.util.Collection<Immobili3liv_View> col = home.findEx
                (COD_AZL, null, null, null, null, null, null, null, null, 0);
 	for (Immobili3liv_View immobile: col){
            strSEL="";
            if(SELECTED_ID!=0){if(SELECTED_ID==immobile.COD_IMM){strSEL="selected";} }
            str+="<option "+strSEL+" value='"+immobile.COD_IMM+"'>"+Formatter.format(immobile.NOM_IMM)+"</option>";
        }
	return str;
}

String BuildLuoghiFisiciComboBox(IAnagrLuoghiFisiciHome home, long SELECTED_ID, Long COD_IMM_3LV, long COD_AZL)
{
	String str="";
	String strSEL="";
	java.util.Collection<AnagrLuoghiFisici_List_View> col = home.findEx
                (COD_AZL, null, null, null, null, COD_IMM_3LV, null, null, null, null, null, null, 0);
 	for (AnagrLuoghiFisici_List_View luogoFisico: col){
            strSEL="";
            if(SELECTED_ID!=0){if(SELECTED_ID==luogoFisico.COD_LUO_FSC){strSEL="selected";} }
            str+="<option "+strSEL+" value='"
                    +luogoFisico.COD_LUO_FSC+"' COD_IMM_3LV='"
                    +luogoFisico.COD_IMM_3LV+"'>"
                    +Formatter.format(luogoFisico.NOM_LUO_FSC)+"</option>";
        }
	return str;
}
%>
