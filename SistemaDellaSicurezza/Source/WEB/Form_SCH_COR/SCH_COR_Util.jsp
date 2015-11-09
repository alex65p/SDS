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
String BuildNomeComboBox(ICorsiHome home,long lCOD_AZL)
{
	String str="";
	java.util.Collection col = home.getCorsoNome_VIEW(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		CorsoNome_VIEW  uni = (CorsoNome_VIEW)it.next();
		str=str+"<option  value='"+uni.COD_COR+"'>"+uni.NOM_COR+"</option>";
  	}
	return str;
} 
String BuildDocenteComboBox(IDocentiCorsoHome home,long lCOD_AZL)
{
	String str="";
    String strSEL="";
	java.util.Collection col = home.getCorsoDocenti_VIEW(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		CorsoDocenti_VIEW  uni = (CorsoDocenti_VIEW)it.next();
        str=str+"<option  value='"+uni.NOM_DCT+"'>"+uni.NOM_DCT+"</option>";

  	}
	return str;
}

%>
