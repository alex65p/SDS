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
    <version number="1.0" date="18/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="18/02/2004" author="Treskina Mary">
				RischioFattore
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">
<% long lCOD_FOR_AZL=0, lCOD_AZL=0;
   String s;
	IFornitore bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IFornitoreHome home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_FOR_AZL=bean.getCOD_FOR_AZL();
		lCOD_AZL=bean.getCOD_AZL();
	}catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){
		String strCOD_FOR_AZL = new Long(lCOD_FOR_AZL).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			IFornitoreTelefonoHome tel_home=(IFornitoreTelefonoHome)PseudoContext.lookup("FornitoreTelefonoBean");
			s=BuildTelephoneTab(tel_home, strCOD_FOR_AZL);
			out.print(s);
		}
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			ILottiDPIHome ldpi_home=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean");
			
			String strCOD_AZL = new Long(lCOD_AZL).toString();
			out.print("strCOD_AZL="+strCOD_AZL);
			s=BuildLottiDPITab( ldpi_home, strCOD_FOR_AZL, strCOD_AZL );
			out.print(s);
		}
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			IFornitoreHome ca_home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
			s=BuildChimicalAgentoTab(ca_home, strCOD_FOR_AZL);
			out.print(s);
		}
		else if(request.getParameter("TAB_NAME").equals("tab4")){
			IFornitoreHome m_home=(IFornitoreHome)PseudoContext.lookup("FornitoreBean");
			s=BuildMacchinaTab( m_home,  strCOD_FOR_AZL );
			out.print(s);
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
//---------------FUNCTIONS FOR TABS-------------------------
/* 	--- Numero Telefonici
  IFornitoreTelefonoHome home = Home intarface of FornitoreTelefono
	String COD_FOR_AZL = COD_FOR_AZL of current Fornitore
*/
String BuildTelephoneTab(IFornitoreTelefonoHome home, String COD_FOR_AZL)
{
	String str;
	java.util.Collection col_tel = home.getFornitoreTelefonoByFORAZLID_View(new Long(COD_FOR_AZL).longValue());
	 
	str="<table border='0' align='left' width='758' id='TelefonoFornitoreHeader' class='dataTableHeader'  cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='379'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
	str+="<td width='379'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='758' id='TelefonoFornitore' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_FOR_AZL)+"'><td class='dataTd'><input type='text' name='TPL_NUM_TEL' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='NUM_TEL' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_FOR_AZL.equals("") ){
		java.util.Iterator it_tel = col_tel.iterator();
 		while(it_tel.hasNext()){
			FornitoreTelefonoByFORAZLID_View tel=(FornitoreTelefonoByFORAZLID_View)it_tel.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_FOR_AZL)+"' ID='"+tel.COD_NUM_TEL_FOR_AZL+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 379px;' class='inputstyle'  value=\""+Formatter.format(tel.TPL_NUM_TEL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 379px;' class='inputstyle'  value=\""+Formatter.format(tel.NUM_TEL)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
}

/* 	--- Lotti DPI --- 
  ILottiDPIhome = Home intarface of LottiDPI
	String COD_FOR_AZL = COD_FOR_AZL of current Fornitore
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildLottiDPITab(ILottiDPIHome home, String COD_FOR_AZL, String COD_AZL)
{
	String str;
	java.util.Collection col_ldpi = home.getLottiDPIByFORAZLID_View(new Long(COD_FOR_AZL).longValue(), new Long(COD_AZL).longValue());
	
	str="<table border='0' align='left' width='758' id='LottiDPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='199'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong></td>";
	str+="<td width='199'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
	str+="<td width='120'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qtà.fornita") + "</strong></td>";
	str+="<td width='120'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qtà.assegnata") + "</strong></td>";
	str+="<td width='120'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qtà.disponibile") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='758' id='LottiDPI' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_FOR_AZL)+"'><td width='199' class='dataTd'><input type='text' name='IDE_LOT_DPI' class='dataInput' readonly  value=''></td>";
	str+="<td width='199' class='dataTd'><input type='text' name='NOM_TPL_DPI' readonly class='dataInput'  value=''></td>";
  str+="<td width='120' class='dataTd'><input type='text' name='QTA_FRT' readonly class='dataInput'  value=''></td>";
	str+="<td width='120' class='dataTd'><input type='text' name='QTA_AST' readonly class='dataInput'  value=''></td>";
	str+="<td width='120' class='dataTd'><input type='text' name='QTA_DSP' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_FOR_AZL.equals("") ){
		java.util.Iterator it_ldpi = col_ldpi.iterator();
 		while(it_ldpi.hasNext()){
			LottiDPIByFORAZLID_View ldpi=(LottiDPIByFORAZLID_View)it_ldpi.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_FOR_AZL)+"' ID='"+ldpi.COD_LOT_DPI+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 199px;' class='inputstyle'  value=\""+Formatter.format(ldpi.IDE_LOT_DPI)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 199px;' class='inputstyle'  value=\""+Formatter.format(ldpi.NOM_TPL_DPI)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 120px;' class='inputstyle'  value=\""+Formatter.format(ldpi.QTA_FRT)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 120px;' class='inputstyle'  value=\""+Formatter.format(ldpi.QTA_AST)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 120px;' class='inputstyle'  value=\""+Formatter.format(ldpi.QTA_DSP)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

/* 	--- Agento Chimici --- 
  IFornitoreHomehome = Home intarface of Fornitore
	String COD_FOR_AZL = COD_FOR_AZL of current Fornitore
*/
String BuildChimicalAgentoTab(IFornitoreHome home, String COD_FOR_AZL)
{
	String str;
	java.util.Collection col_ca = home.getChimicalAgentoByFORAZLID_View(new Long(COD_FOR_AZL).longValue());
	
	str="<table border='0' align='left' width='758' id='ChimicalAgentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='379'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str+="<td width='379'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='758' id='ChimicalAgento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_FOR_AZL)+"'><td width='379' class='dataTd'><input type='text' name='DES_SOS' class='dataInput' readonly  value=''></td>";
	str+="<td width='379' class='dataTd'><input type='text' name='NOM_COM_SOS' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_FOR_AZL.equals("") ){
		java.util.Iterator it_ca = col_ca.iterator();
 		while(it_ca.hasNext()){
			ChimicalAgentoByFORAZLID_View ca=(ChimicalAgentoByFORAZLID_View)it_ca.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_FOR_AZL)+"' ID='"+ca.COD_SOS_CHI+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 379px;' class='inputstyle'  value=\""+Formatter.format(ca.DES_SOS)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 379px;' class='inputstyle'  value=\""+Formatter.format(ca.NOM_COM_SOS)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

/* 	--- Macchina --- 
  IFornitoreHomehome = Home intarface of Fornitore
	String COD_FOR_AZL = COD_FOR_AZL of current Fornitore
*/
String BuildMacchinaTab(IFornitoreHome home, String COD_FOR_AZL)
{
	String str;
	java.util.Collection col_mac = home.getMacchinaByFORAZLID_View(new Long(COD_FOR_AZL).longValue());
	
	str="<table border='0' align='left' width='758' id='MacchinaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong></td>";
	str+="<td width='558'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='758' id='Macchina' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_FOR_AZL)+"'><td width='200' class='dataTd'><input type='text' name='IDE_MAC' class='dataInput' readonly  value=''></td>";
	str+="<td width='558' class='dataTd'><input type='text' name='DES_MAC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_FOR_AZL.equals("") ){
		java.util.Iterator it_mac = col_mac.iterator();
 		while(it_mac.hasNext()){
			MacchinaByFORAZLID_View mac=(MacchinaByFORAZLID_View)it_mac.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_FOR_AZL)+"' ID='"+mac.COD_MAC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(mac.IDE_MAC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 558px;' class='inputstyle'  value=\""+Formatter.format(mac.DES_MAC)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
} 
%>
