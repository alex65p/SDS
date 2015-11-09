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
String BuildQTAComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getQTA_View(home.getCOD_ALG());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		QTA_View obj=(QTA_View) it.next();
		str+="<option ";
		if(obj.COD_QTA == home.getCOD_QTA())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_QTA)+"\">"+Formatter.format(obj.DES_QTA)+"</option>\n";
	}
	return str;
}
String BuildCCPComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getCCP_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		CCP_View obj=(CCP_View) it.next();
		str+="<option ";
		if(obj.COD_CCP == home.getCOD_CCP())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_CCP)+"\">"+Formatter.format(obj.DES_CCP)+"</option>\n";
	}
	return str;
}
String BuildTIPComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getTIP_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TIP_View obj=(TIP_View) it.next();
		str+="<option ";
		if(obj.COD_TIP == home.getCOD_TIP())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_TIP)+"\">"+Formatter.format(obj.DES_TIP)+"</option>\n";
	}
	return str;
}
String BuildCTRComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getCTR_View(home.getCOD_ALG());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		CTR_View obj=(CTR_View) it.next();
		str+="<option ";
		if(obj.COD_CTR == home.getCOD_CTR())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_CTR)+"\">"+Formatter.format(obj.DES_CTR)+"</option>\n";
	}
	return str;
}
String BuildTMPComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getTMP_ESP_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TMP_ESP_View obj=(TMP_ESP_View) it.next();
		str+="<option ";
		if(obj.COD_TMP_ESP == home.getCOD_TMP_ESP())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_TMP_ESP)+"\">"+Formatter.format(obj.DES_TMP_ESP)+"</option>\n";
	}
	return str;
}

String BuildDISComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getDIS_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		DIS_View obj=(DIS_View) it.next();
		str+="<option ";
		if(obj.COD_DIS == home.getCOD_DIS())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_DIS)+"\">"+Formatter.format(obj.DES_DIS)+"</option>\n";
	}
	return str;
}

String BuildALGComboBox(IRischioChimicoBean home)
{
	String str="";
	java.util.Collection col = home.getALG_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		ALG_View obj=(ALG_View) it.next();
		str+="<option ";
		if(obj.COD_ALG == home.getCOD_ALG())
			str+=" selected ";
		str+=" value=\""+Formatter.format(obj.COD_ALG)+"\">"+Formatter.format(obj.DES_ALG)+"</option>\n";
	}
	return str;
}
%>
