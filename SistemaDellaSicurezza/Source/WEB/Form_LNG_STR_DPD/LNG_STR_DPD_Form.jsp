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
    <version number="1.0" date="19/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="19/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi LNG_STR_DPD_Form.jsp</description>
				  </comment>
					 <comment date="20/02/2004" author="Podmasteriev Alexandr ">
				   <description>Zapolnenie kontentom formu</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Lingue.straniere")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">

</head>
<script>
window.dialogWidth="450px";
window.dialogHeight="200px";
</script>
<body>
<!-- 
  "cod_lng_str_dpd" int8 NOT NULL, 
  "nom_lng_str_dpd" varchar(30) NOT NULL, 
  "liv_csc_lng_str" varchar(50) NOT NULL, 
  "cod_dpd" int8 NOT NULL, 
  "cod_azl" int8 NOT NULL,
---> 
<%
	String 	strCOD_LNG_STR_DPD="";			    //1 
	String 	strNOM_LNG_STR_DPD="";//with cod_dpd unique
	String	strLIV_CSC_LNG_STR="";
	String	lCOD_DPD="";
	long	lCOD_AZL=0;

lCOD_DPD=request.getParameter("ID_PARENT");
IDipendenteLingueStraniere DipendenteLingueStraniere=null;
if(request.getParameter("ID")!=null)
{
		strCOD_LNG_STR_DPD = request.getParameter("ID");
		//getting of DipendenteLingueStraniere object
		IDipendenteLingueStraniereHome home=(IDipendenteLingueStraniereHome)PseudoContext.lookup("DipendenteLingueStraniereBean"); 
		Long cpl_id=new Long(strCOD_LNG_STR_DPD);
		DipendenteLingueStraniere = home.findByPrimaryKey(cpl_id);
		
		// getting of object variables
			strNOM_LNG_STR_DPD=DipendenteLingueStraniere.getNOM_LNG_STR_DPD();
			strLIV_CSC_LNG_STR=DipendenteLingueStraniere.getLIV_CSC_LNG_STR();
			lCOD_AZL=Security.getAzienda();
}

%>


<form action="LNG_STR_DPD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_LNG_STR_DPD=="")?"new":"edt"%>">
<input type="hidden" name="COD_LNG_STR_DPD" value="<%=strCOD_LNG_STR_DPD%>">
<input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%">
  <tr>
	<td>
<table width="100%">
<!-- ############################ -->  		
<table width="100%"><tr> 
       <td class="title" width="100%"><%=ApplicationConfigurator.LanguageManager.getString("Lingue.straniere")%></td> 
    
    <td>   
            <%
            ToolBar.bCanDelete=(DipendenteLingueStraniere!=null);
            ToolBar.bShowPrint=false;
            ToolBar.bShowReturn=false;
            ToolBar.bShowSearch=false;
            ToolBar.bShowDelete=false;
            %>	
            <%=ToolBar.build(2)%> 
            <!-- ########################### --> 
    
        </td>
    </tr>
</table>	
  <fieldset>
          <legend><%=ApplicationConfigurator.LanguageManager.getString("Lingua.straniera")%></legend>
   		<table  width="100%" border="0">
   <tr>
       <br>
   <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Lingua.straniera")%>&nbsp;</b></td>
	 <td ><input type="text" size="50" maxlength="30"  name="NOM_LNG_STR_DPD" value="<%=Formatter.format(strNOM_LNG_STR_DPD)%>">
   </td></tr>
	 <tr><td valign="top" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Livello.di.conoscenza")%>&nbsp;</b></td>
	 <td><input type="text" size="50" maxlength="50"  name="LIV_CSC_LNG_STR" value="<%=Formatter.format(strLIV_CSC_LNG_STR)%>">
	 </td>
	 </tr>
   </td></tr>
   </table>	 
	 </fieldset></td></tr>
  </table>
 </td>
</tr>  
</table>
</form>
   <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

</body>
</html>
 
