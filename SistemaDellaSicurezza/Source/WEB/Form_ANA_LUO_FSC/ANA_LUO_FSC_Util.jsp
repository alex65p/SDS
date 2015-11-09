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
    <version number="1.0" date="22/01/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="22/01/2004" author="Alexey Kolesnik">
				   <description>ANA_LUO_FSC_Util.jsp-functions for ANA_LUO_FSC_Util.jsp</description>
				 </comment>		
				  <comment date="05/02/2004" author="Alexey Kolesnik">
				   <description> Added functions for comboboxes </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>
<%@ page import="com.apconsulting.luna.ejb.Piano.*" %>
<%@ page import="com.apconsulting.luna.ejb.Ala.*" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------

String BuildSitoAzlComboBox(ISitaAziendeHome home, long SELECTED_ID, long FILTER_ID)
{
	String str = "";

	java.util.Collection col = home.getSiteAziendaleByAZLID_View(FILTER_ID);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		SiteAziendaleByAZLID_View obj = (SiteAziendaleByAZLID_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_SIT_AZL) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_SIT_AZL)+"'>"+Formatter.format(obj.NOM_SIT_AZL)+"</option>";
  	}
	
	return str;
}

String BuildAlaComboBox(IAlaHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getAla_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Ala_View obj = (Ala_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_ALA) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_ALA)+"'>"+Formatter.format(obj.NOM_ALA)+"</option>";
  	}
	
	return str;
}

String BuildPianoComboBox(IPianoHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getPiano_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Piano_View obj = (Piano_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_PNO) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_PNO)+"'>"+Formatter.format(obj.NOM_PNO)+"</option>";
  	}
	
	return str;
}

String BuildImmobiliComboBox(IImmobiliHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getImmobili_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Immobili_View obj = (Immobili_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_IMO) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_IMO)+"'>"+Formatter.format(obj.NOM_IMO)+"</option>";
  	}
	
	return str;
}

String BuildImmobili3lvComboBox(IImmobili3lvHome home, long COD_AZL, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.findEx
                (COD_AZL, null, null, null, null, null, null, null, null, 0);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Immobili3liv_View obj = (Immobili3liv_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_IMM) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_IMM)+"'>"+Formatter.format(obj.NOM_IMM)+"</option>";
  	}

	return str;
}
%>
