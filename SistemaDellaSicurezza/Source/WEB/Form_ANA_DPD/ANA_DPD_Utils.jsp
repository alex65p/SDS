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

<%!
String BuildNazionalitaComboBox(INazionalitaHome home, long SELECTED_ID, long COD_LNG)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getNazionalita_Names_View(COD_LNG);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Nazionalita_Names_View  dt = (Nazionalita_Names_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_STA){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_STA)+"'>"+Formatter.format(dt.NOM_STA)+"</option>";
  	}
	return str;
}

String BuildFunzAziendale(IFunzioniAziendaliHome fHome, long SELECTED_ID){
	String str="";
	java.util.Collection col = fHome.getFunzioniAziendali_Name_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		FunzioniAziendali_Name_View dt=(FunzioniAziendali_Name_View)it.next();
		String strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_FUZ_AZL){strSEL="selected";} }
	    str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_FUZ_AZL)+"'>"+Formatter.format(dt.NOM_FUZ_AZL)+"</option>";
  	}
	return str; 
}



%>
