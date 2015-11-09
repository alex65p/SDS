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
    <version number="1.0" date="13/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="13/02/2004" author="Treskina Mary">
					RischioFattore
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">

<% long lCOD_LOT_DPI=0;
	ILottiDPI bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		ILottiDPIHome home=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_LOT_DPI=bean.getCOD_LOT_DPI();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			////out.println(BuildCorsiTab(bean.getCorsiView(), lCOD_LOT_DPI));
			String s;
			ISchedeInterventoDPIHome si_home=(ISchedeInterventoDPIHome)PseudoContext.lookup("SchedeInterventoDPIBean");
			s=BuildSchedeInterventoDPITab(si_home, new Long(lCOD_LOT_DPI).toString());
			out.println(s);
		}
		else{
			return;
		}
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
	 %>
</div>	
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
 
<%! 
/* 	--- SchedeIntervento --- 
  ISchedeInterventoDPIhome = Home intarface of SchedeInterventoDPI
	String COD_LOT_DPI = COD_LOT_DPI of current Lotti DPI
*/
String BuildSchedeInterventoDPITab(ISchedeInterventoDPIHome home, String COD_LOT_DPI)
{
	String str;
	java.util.Collection col_ldpi = home.getSchedeInterventoDPIByLOTDPIID_View(new Long(COD_LOT_DPI).longValue());
	
	str="<table border='0' align='left' width='908' id='SchedeInterventoDPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='188'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia.intervento") + "</strong></td>";
	str+="<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.pianificaz.") + "</strong></td>";
  str+="<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.interv.") + "</strong></td>";
	str+="<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.svolta") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='908'  id='SchedeInterventoDPI' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_LOT_DPI)+"'><td width='188' class='dataTd'><input type='text' name='NOM_TPL_DPI' class='dataInput' readonly  value=''></td>";
	str+="<td width='180' class='dataTd'><input type='text' name='DAT_PIF_INR' readonly class='dataInput'  value=''></td>";
  str+="<td width='180' class='dataTd'><input type='text' name='DAT_INR' readonly class='dataInput'  value=''></td>";
	str+="<td width='180' class='dataTd'><input type='text' name='NOM_RSP_INR' readonly class='dataInput'  value=''></td>";
	str+="<td width='180' class='dataTd'><input type='text' name='ANI_INR' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_LOT_DPI.equals("") ){
		java.util.Iterator it_ldpi = col_ldpi.iterator();
 		while(it_ldpi.hasNext()){
			SchedeInterventoDPIByLOTDPIID_View ldpi=(SchedeInterventoDPIByLOTDPIID_View)it_ldpi.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_LOT_DPI)+"' ID='"+ldpi.COD_SCH_INR_DPI+"'>";
			str+="<td class='dataTd' width='25%'><input type='text' readonly style='width: 188px;' class='inputstyle'  value=\""+Formatter.format(ldpi.NOM_TPL_DPI)+"\"></td>";
			str+="<td class='dataTd' width='15%'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\""+Formatter.format(ldpi.DAT_PIF_INR)+"\"></td>";
			str+="<td class='dataTd' width='10%'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\""+Formatter.format(ldpi.DAT_INR)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\""+Formatter.format(ldpi.NOM_RSP_INR)+"\"></td>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\""+Formatter.format(ldpi.ANI_INR)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
 %>
