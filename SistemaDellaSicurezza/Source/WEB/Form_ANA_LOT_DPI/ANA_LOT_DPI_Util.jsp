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
    <version number="1.0" date="25/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="25/01/2004" author="Treskina Maria">
				   <description>ANA_LOT_DPI_Util.jsp-functions for ANA_LOT_DPI</description>
				   <description>Functions for comboboxes and tab</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//===================== combobox ===================
//====================================================
// ------------ combobox for fornitore ---------------
/* 	IFornitoreHome home = home interface of FornitoreBean
	long SELECTED_ID = ID (COD_FOR_AZL) of current fornitore, if not exists then =0
*/
String BuildFornitoreComboBox(IFornitoreHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	long lCOD_AZL = Security.getAzienda();
	java.util.Collection col = home.getFornitore_Categoria_RagSoc_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Fornitore_Categoria_RagSoc_View  dt = (Fornitore_Categoria_RagSoc_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_FOR_AZL){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.COD_FOR_AZL)+"\">"+Formatter.format(dt.RAG_SOC_FOR_AZL)+"</option>";
  	}
	return str;
}

// ------------ combobox for fornitore ---------------
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
