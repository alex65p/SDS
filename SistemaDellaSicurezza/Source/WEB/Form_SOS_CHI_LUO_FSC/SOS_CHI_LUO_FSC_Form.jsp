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
    <version number="1.0" date="11/02/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="11/02/2004" author="Pogrebnoy Yura">
				   <description>Shablon formi SOS_CHI_LUO_FSC_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="500px";
window.dialogHeight="240px";
</script>
<body style="margin:0 0 0 0;">
<%
	//   *require Fields*
	String strCOD_SOS_CHI="";
  String strCOD_LUO_FSC="";
	String strQTA_GIA="";
	String strQTA_USO="";
	String strTPL_QTA="";
	String strNB_AZL="";
	String strNB_NOM_LUO_FSC="";

  IAssociativaAgentoChimico chim=null;
	IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	IAnagrLuoghiFisici luofsc=null;
	IAnagrLuoghiFisiciHome lhome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
	IAzienda azl=null;
	IAziendaHome ahome=(IAziendaHome)PseudoContext.lookup("AziendaBean");

	long lCOD_AZL = Security.getAzienda();
	azl=ahome.findByPrimaryKey(new Long(lCOD_AZL));
	strNB_AZL=Formatter.format(azl.getRAG_SCL_AZL());

if(request.getParameter("ID_PARENT")!=null){
  strCOD_SOS_CHI = request.getParameter("ID_PARENT");

	if( request.getParameter("ID")!=null){
		strCOD_LUO_FSC = request.getParameter("ID");
		luofsc=lhome.findByPrimaryKey(new Long(strCOD_LUO_FSC));
  	strNB_NOM_LUO_FSC=Formatter.format(luofsc.getNOM_LUO_FSC());
		long COD_SOS_CHI=new Long(strCOD_SOS_CHI).longValue();
    long COD_LUO_FSC=new Long(strCOD_LUO_FSC).longValue();
		java.util.Collection col = home.getSOS_CHI_LUO_FSC_View(COD_SOS_CHI,COD_LUO_FSC);
		java.util.Iterator it = col.iterator();
		while(it.hasNext()){
			SOS_CHI_LUO_FSC_View obj=(SOS_CHI_LUO_FSC_View)it.next();
      strQTA_GIA=Formatter.format(obj.QTA_GIA);
		  strQTA_USO=Formatter.format(obj.QTA_USO);
		  strTPL_QTA=Formatter.format(obj.TPL_QTA);
    }
  }
}
%>
<table border="0" width="100%"><tr>
<td class="title" width="100%">
  <%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici")%>
  </td>
 <td width="10" height="100%" valign="top">
<%@ include file="../_include/ToolBar.jsp" %>
<%ToolBar.bCanDelete=(chim!=null);
     ToolBar.bShowSearch=false;
		 ToolBar.bShowDelete=false;
     ToolBar.bShowReturn=false;
     ToolBar.bShowPrint=false;%>
<%=ToolBar.build(2)%>
 </td>
<form action="SOS_CHI_LUO_FSC_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width="100%" border="0">
<tr>

 <td valign="top">
  <table  width="100%">
<input name="SBM_MODE" type="Hidden" value="<%=(strQTA_GIA.equals(""))?"new":"edt"%>">
<input name="COD_SOS_CHI" type="Hidden" value="<%=strCOD_SOS_CHI%>">
<input name="ID_PARENT" type="Hidden" value="<%=strCOD_LUO_FSC%>">
  <tr>
	<td align="left">
  <fieldset>
   <table border="0" align="center">
   <tr>
     <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
	   <td colspan="4"><input style="width:300px" type="text" readonly maxlength="50" name="NB_AZL" value="<%=strNB_AZL%>"></td>
	 </tr>
	 <tr><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%>&nbsp;</b></td>
       <td colspan="4"><select name="NB_NOM_LUO_FSC" style="width:300px;">
         	 	<option value=''></option>
<%
 String str="";
 java.util.Collection lcol = lhome.getAnagrLuoghiFisici_List_View(lCOD_AZL);//findAll();
 java.util.Iterator it = lcol.iterator();
 int iCount=0;
 while(it.hasNext()){
   AnagrLuoghiFisici_List_View i=(AnagrLuoghiFisici_List_View)it.next();
   luofsc = lhome.findByPrimaryKey(new Long(i.COD_LUO_FSC));
	  String selstr="";
		if(strNB_NOM_LUO_FSC.equals(Formatter.format(luofsc.getNOM_LUO_FSC())))selstr="selected";
    str=str+"<option "+selstr+" value=\""+Formatter.format(luofsc.getCOD_LUO_FSC())+"\">"+Formatter.format(luofsc.getNOM_LUO_FSC())+"</option>";
 }
 out.print(str);
%>
      	</select></td>
	 </tr>
   <tr><td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Quantità.in.uso")%>&nbsp;</b></td>
	   <td colspan="4"><input style="width:129px" type="text" name="QTA_USO" value="<%=strQTA_USO%>"></td>
	 </tr>
	 <tr><td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Quantità.in.giacenza")%>&nbsp;</b></td>
	   <td width="160px"><input width="90px" type="text" name="QTA_GIA" value="<%=strQTA_GIA%>"></td>
		 <td align="right" width="80px"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%>&nbsp;</b></td>
       <td width="60px"><select name="TPL_QTA" style="width:50px;">
         	 	<option <%if(strTPL_QTA.equals(""))out.print("selected");%> value=''></option>
         	 	<option <%if(strTPL_QTA.equals("Kg"))out.print("selected");%> value='Kg'><%=ApplicationConfigurator.LanguageManager.getString("kg")%></option>
         	 	<option <%if(strTPL_QTA.equals("L"))out.print("selected");%> value='L'><%=ApplicationConfigurator.LanguageManager.getString("litri")%></option>
      	</select></td>
	 </tr>
   </table>
	 </fieldset></td></tr>
  </table>
 </td>
</tr>
</table>
 </td>
</tr>
</table>
</form>
<!-- /form for addind  -->

<iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
</body>
</html>
