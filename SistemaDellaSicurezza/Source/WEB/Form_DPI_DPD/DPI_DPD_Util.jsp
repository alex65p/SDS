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
    <version number="1.0" date="20/02/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="20/02/2004" author="Podmasteriev Alexandr">
				   <description>DPI_DPD_Util.jsp-functions for DPI_DPD_From</description>
				   <description>Functions for comboboxes </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%!
//===================== combobox ===================
/* 	ITipologiaDPIHome home = home interface of TipologiaDPIBean
	long SELECTED_ID = ID (COD_TPL_DPI) of current tipologia DPI, if not exists then =0
*/
String BuildTipologiaDPIComboBox(ITipologiaDPIHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getTipologiaDPI_Name_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		TipologiaDPI_Name_View  dt = (TipologiaDPI_Name_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_TPL_DPI){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.COD_TPL_DPI)+"\">"+Formatter.format(dt.NOM_TPL_DPI)+"</option>";
  	}
	return str;
}
%>
