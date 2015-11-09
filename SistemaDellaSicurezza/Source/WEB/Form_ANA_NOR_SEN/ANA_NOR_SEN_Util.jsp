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
    <version number="1.0" date="27/01/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="27/01/2004" author="Alexey Kolesnik">
				   <description>ANA_NOR_SEN_FSC_Util.jsp-functions for ANA_NOR_SEN_FSC_Form.jsp</description>
				 </comment>		
				<comment date="04/02/2004" author="Alexey Kolesnik">
					<description> added new functions to build comboboxes </description>
				</comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!


String BuildTipologieNomativeSentenzeComboBox(ITipologieNomativeSentenzeHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getTipologieNomativeSentenze_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TipologieNomativeSentenze_View obj = (TipologieNomativeSentenze_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_TPL_NOR_SEN) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_TPL_NOR_SEN)+"'>"+Formatter.format(obj.NOM_TPL_NOR_SEN)+"</option>";
  	}
	return str;
}

String BuildOrganiComboBox(IOrganiHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getOrgani_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Organi_View obj = (Organi_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_ORN) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_ORN)+"'>"+Formatter.format(obj.NOM_ORN)+"</option>";
  	}
	return str;
}

String BuildSettoriComboBox(ISettoriHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getSettori_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Settori_View obj = (Settori_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_SET) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_SET)+"'>"+Formatter.format(obj.NOM_SET)+"</option>";
  	}
	return str;
}

String BuildSottosettoriComboBox(ISottosettoriHome home, long SELECTED_ID)
{
	String str = "";
	java.util.Collection col = home.getSottosettori_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Sottosettori_View obj = (Sottosettori_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_SOT_SET) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_SOT_SET)+"'>"+Formatter.format(obj.NOM_SOT_SET)+"</option>";
  	}
	return str;
}

%>
