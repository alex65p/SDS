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
// ------------ combobox for nazionalita ---------------
/* 	INazionalitaHome home = home interface of NazionalitaBean
	long SELECTED_ID = ID (NOM_STA) of current fornitore, if not exists then =0
*/
String BuildNazionalitaComboBox(INazionalitaHome home, String SELECTED_NOM,long COD_LNG)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getNazionalita_Names_View(COD_LNG);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Nazionalita_Names_View  dt = (Nazionalita_Names_View)it.next();
		strSEL="";
		if(SELECTED_NOM!=null && SELECTED_NOM.equals(dt.NOM_STA)){strSEL="selected";} 
		str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.NOM_STA)+"\">"+Formatter.format(dt.NOM_STA)+"</option>";
  	}
	return str;
} %>
