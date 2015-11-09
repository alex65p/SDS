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
    <version number="1.0" date="19/02/2004" author="Juli khomenko">		
      <comments>
			   <comment date="19/02/2004" author="Juli Khomenko">
				   <description>Realizazija EJB dlia objecta DipendenteConsegneDPI</description>
			   </comment>
				 <comment date="24/02/2004" author="Podmasteriev Alexandr">
				   <description>Zakonchil formu do konca</description>
			   </comment>				
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="DPI_DPD_Util.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%
	String strCOD_CSG_DPI="";
	long lCOD_DPD=0;
	String dtDAT_CSG_DPI="";
	String strNOM_RSP_CSG_DPI="";
	String strEFT_CSG_SCH_DPI="S";
	long lQTA_CSG=0;
	String strTPL_CSG="F";
	long lCOD_LOT_DPI=0;
	long lCOD_TPL_DPI=0;
	long lCOD_AZL=0;
	long lCOD_CSG_DPI=0;
  IDipendenteConsegneDPI DipendenteConsegneDPI=null;
  String strCOD_DPD=request.getParameter("ID_PARENT");
	lCOD_DPD=new Long(strCOD_DPD).longValue();
	if(request.getParameter("ID")!=null)
	{
		strCOD_CSG_DPI= request.getParameter("ID");

		Long COD_CSG_DPI_id=new Long(strCOD_CSG_DPI);
		IDipendenteConsegneDPIHome home=(IDipendenteConsegneDPIHome)PseudoContext.lookup("DipendenteConsegneDPIBean");
		DipendenteConsegneDPI = home.findByPrimaryKey(COD_CSG_DPI_id);

		lCOD_CSG_DPI=DipendenteConsegneDPI.getCOD_CSG_DPI();
		//lCOD_DPD=DipendenteConsegneDPI.getCOD_DPD();
		dtDAT_CSG_DPI=Formatter.format(DipendenteConsegneDPI.getDAT_CSG_DPI());
		strNOM_RSP_CSG_DPI=DipendenteConsegneDPI.getNOM_RSP_CSG_DPI();
		strEFT_CSG_SCH_DPI=DipendenteConsegneDPI.getEFT_CSG_SCH_DPI();
		lQTA_CSG=DipendenteConsegneDPI.getQTA_CSG();
		strTPL_CSG=DipendenteConsegneDPI.getTPL_CSG();
		lCOD_LOT_DPI=DipendenteConsegneDPI.getCOD_LOT_DPI();
		lCOD_TPL_DPI=DipendenteConsegneDPI.getCOD_TPL_DPI();
		lCOD_AZL=DipendenteConsegneDPI.getCOD_AZL();
		
		
	
	}	
	 //azienda--
		  IAzienda azienda=null;
	    IAziendaHome AziendaHome=(IAziendaHome)PseudoContext.lookup("AziendaBean");
		  lCOD_AZL=Security.getAzienda();
			Long azl_id=new Long(lCOD_AZL);
    	azienda = AziendaHome.findByPrimaryKey(azl_id);
	    String strRAG_SCL_AZL= azienda.getRAG_SCL_AZL();
		//---------
%>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Consegne.D.P.I.")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
    <!-- autocompose data field -->
    <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
    <!-- import the calendar script -->
    <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
    <!-- import the language module -->
    <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
    <!-- import calendar utility function -->
    <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
    <!-- style sheet for calendar -->
    <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
 </head>

<script>
window.dialogWidth="800px";
window.dialogHeight="420px";
</script>
<body>
<script type="text/javascript">
<!--
function ChangeSelect(id_sel){
var obj=document.all["COD_TPL_DPI"];
document.all["ifrmWork"].src="DPI_DPD_frame.jsp?ID="+obj.value+"&ID_SEL="+id_sel;
}
// -->
</script>
<!-- form for addind  corbean-->
<form action="DPI_DPD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_CSG_DPI==0)?"new":"edt"%>">
<input type="hidden" name="COD_CSG_DPI" value="<%=lCOD_CSG_DPI%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr>
    <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Consegne.D.P.I.")%></td>
  </tr>
  <tr>
	<td>
	<table width="100">
	<!-- ############################ -->  		
    <%ToolBar.bCanDelete=(DipendenteConsegneDPI!=null);%>	
    <%ToolBar.bShowReturn=false;	
     ToolBar.bShowSearch=false;%>
    <%=ToolBar.build(2)%> 
<!-- ########################### --> 
</table>
  <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.consegna")%></legend>
   <table  width="100%" border="0">  
    <tr>
        <td align="right" valign="top" width="108px"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
        <td colspan="3"><input type="text" size="108" maxlength="50" readonly  name="C" value="<%=strRAG_SCL_AZL%>"></td>
    </tr>
    <tr>
        <td colspan="4"> 
	 <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.tipologia")%></legend>
      <table  width="100%" border="0">  
			<tr>
			  <td width="14%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.")%>&nbsp;</b></td>
			    <td>
					<select name="COD_TPL_DPI" id="COD_TPL_DPI" style="width:567px" onchange="ChangeSelect(0);">
					<option></option>
					<%
     		  ITipologiaDPIHome t_home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
		   		String t_cb=BuildTipologiaDPIComboBox(t_home, lCOD_TPL_DPI);
    			out.print(t_cb);
					
	 	      %>
					</select></td>
			</tr>
			<tr>
			  <td width="14%"  align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Lotto")%>&nbsp;</b></td>
			    <td><select name="COD_LOT_DPI" id="COD_LOT_DPI" style="width:220px">
					<option value=""></option>
					</select>
					</td>
			</tr>
      </table>
	 </fieldset>
        </td>
    </tr>
    <tr>
        <td colspan="4">
	 <fieldset>
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></legend>
      <table  width="100%" border="0">  
			<tr>
			  <td width="14%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Lavoratore")%>&nbsp;</b></td>
			    <td>
					<select name="COD_DPD" style="width:567px">
					<% 
    			      IDipendenteHome d_home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
		    	      out.print(BuildDipendenteComboBox(d_home, lCOD_DPD, lCOD_AZL));
						%>
					</select>
					</td>
			</tr>
      </table>
	 </fieldset>
	</td>
    </tr>
    <tr>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%>&nbsp;</b></td>
        <td colspan="3">
            <input type="text" size="40" maxlength="100"  name="NOM_RSP_CSG_DPI" value="<%=Formatter.format(strNOM_RSP_CSG_DPI)%>">
	 </td>
    </tr>
    <tr>
        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</b></td>
        <td><s2s:Date id="DAT_CSG_DPI"  name="DAT_CSG_DPI" value="<%=Formatter.format(dtDAT_CSG_DPI)%>"/></td>
        <td align="right" width="35%"><b><%=ApplicationConfigurator.LanguageManager.getString("Quantità.consegnata.in.pezzi")%>&nbsp;</b></td>
        <td><input type="text" size="20" maxlength="20"  name="QTA_CSG" value="<%=Formatter.format(lQTA_CSG)%>"></td>
    </tr>
    <tr align="center">
        <td colspan="4">
	 <fieldset style="width:150">
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Scheda.D.P.I.consegnata")%></legend>
     <input class="checkbox" name="EFT_CSG_SCH_DPI" <%=(strEFT_CSG_SCH_DPI.equals("S"))?"checked":""%> value="S" type="radio">
     &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Si")%>
     <input class="checkbox" name="EFT_CSG_SCH_DPI" <%=(strEFT_CSG_SCH_DPI.equals("N"))?"checked":""%> value="N" type="radio">
     &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("No")%>
	 </fieldset>
        </td>
    </tr>
    <tr>
        <td align="right" valign="top"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipo.consegna")%>&nbsp;</b></td>
	<td align="justify">
            <input class="checkbox" name="TPL_CSG" type="radio" <%=(strTPL_CSG.equals("F")) ? "checked" : ""%> value="F" >
            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Prima.fornitura")%>
        </td>
        <td>
            <input class="checkbox" name="TPL_CSG" type="radio" <%=(strTPL_CSG.equals("P"))?"checked":""%> value="P">
            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Reintegro.periodico")%>
        </td>
        <td>
            <input class="checkbox" name="TPL_CSG" type="radio" <%=(strTPL_CSG.equals("S"))?"checked":""%> value="S">
            &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Reintegro.straordinario")%>
        </td>
   </tr>
   </table>	   
	 </fieldset>
	</td></tr>
  </table>
 </td>
</tr>  
</table>
</form>
<!-- /form for addind  corbean-->
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script type="text/javascript">
<!--
<%if(lCOD_LOT_DPI!=0){%>
	ChangeSelect(<%=lCOD_LOT_DPI%>);
<%}%>
// -->
</script>
</body>
</html>
