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
    <version number="1.0" date="06/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="06/02/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_TAB_UTN_Form.jsp</description>
				  </comment>
					<comment date="06/02/2004" author="Malyuk Sergey">
				   <description>Realizaciya formi</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Paragrafo.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/ToolBar.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Tabelle")%></title>
  <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
	<link rel="stylesheet" href="../_styles/tabs.css">
	<script language="JavaScript" src="../_scripts/tabs.js"></script>
	<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

</head>
<script>
	window.dialogWidth="820px";
	window.dialogHeight="470px";
</script>
<body>
<script language="JavaScript">
var is_new=false;
var rows=1;
function abil_tit()
		 {
		 document.forma.NOM_TIT_1.disabled=true;
		 document.forma.NOM_TIT_2.disabled=true;
		 document.forma.NOM_TIT_3.disabled=true;
		 document.forma.NOM_TIT_4.disabled=true;
		 document.forma.NOM_TIT_5.disabled=true;
		 	switch (document.forma.NUM_CLN.value)
					 {
					  case '1': document.forma.NOM_TIT_1.disabled=false;
								 			document.forma.NOM_TIT_2.disabled=true;
											document.forma.NOM_TIT_3.disabled=true;						
											document.forma.NOM_TIT_4.disabled=true;
											document.forma.NOM_TIT_5.disabled=true;											
											break;
  				  case '2': document.forma.NOM_TIT_1.disabled=false;
								 			document.forma.NOM_TIT_2.disabled=false;
											document.forma.NOM_TIT_3.disabled=true;
											document.forma.NOM_TIT_4.disabled=true;
											document.forma.NOM_TIT_5.disabled=true;
											break;
					  case '3': document.forma.NOM_TIT_1.disabled=false;
								 			document.forma.NOM_TIT_2.disabled=false;
											document.forma.NOM_TIT_3.disabled=false;
											document.forma.NOM_TIT_4.disabled=true;
											document.forma.NOM_TIT_5.disabled=true;
											break;
					  case '4': document.forma.NOM_TIT_1.disabled=false;
								 			document.forma.NOM_TIT_2.disabled=false;
											document.forma.NOM_TIT_3.disabled=false;
											document.forma.NOM_TIT_4.disabled=false;
											document.forma.NOM_TIT_5.disabled=true;
											break;
					  case '5': document.forma.NOM_TIT_1.disabled=false;
								 			document.forma.NOM_TIT_2.disabled=false;
											document.forma.NOM_TIT_3.disabled=false;
											document.forma.NOM_TIT_4.disabled=false;
											document.forma.NOM_TIT_5.disabled=false;
											break;
						}				
	   }
function getnew()
				 {
				 if (is_new==false)
				 			 		{
									document.forma.sel.disabled=true;
				 		 		 	var str;
						 		 	var k=1;
						 		 	var z=document.forma.NUM_CLN.value;
				 		 		 	var i=rows+1;
				 		 		 	str=document.all.res.innerHTML.substring(0,document.all.res.innerHTML.length-8);
				 		 		 	str+="<!--"+rows+"--><tr align='center'>";
						 		 	for (k;k<=5;k++)
						 		 		 	{
								 		 	if (k<=z)
								 		 		 {
												 if (k!=z)
											 		 	{
  		 		 		 			 	 		 	 str+="<td><input size='25' name='NOM_CLN_"+k+"_"+rows+"' maxlength='30' type='text' onfocus=getnew();is_new=true;></td>";
											 		 	}
											 			else
											 			{
  		 		 		 			 	 			str+="<td><input size='25' name='NOM_CLN_"+k+"_"+rows+"' maxlength='30' type='text' onfocus=getnew();is_new=true; onblur=losefocus();></td>";											 
											 			}								
												 }else
												 {
										 		 str+="<td><input size='25' name='NOM_CLN_"+k+"_"+rows+"' maxlength='30' type='text' onfocus='getnew();is_new=true;' disabled></td>";
												 }
											}
				 		 			str+="</tr></table>"
				 		 			document.all.res.innerHTML=str;
		  			 			rows++;
						 			if (rows!=2)
						 				 {
						 		 		 	is_new=true;
										 }																	
									}
  			 }
function losefocus()
				 {
				 if (document.forma.elements[document.forma.elements.length-10].value+
				 		 document.forma.elements[document.forma.elements.length-9].value+
						 document.forma.elements[document.forma.elements.length-8].value+
						 document.forma.elements[document.forma.elements.length-7].value+
				 			document.forma.elements[document.forma.elements.length-6].value=='')
							{
	  				  var str;
  						rows--;
							str=document.all.res.innerHTML.substring(0,document.all.res.innerHTML.indexOf("<!--"+rows+"-->"));
							str+="</table>"
							document.all.res.innerHTML=str;
							is_new=false;		 
							}
							else
							{
							is_new=false;
				  	  }		 
				 }
function sel_num_cln()
				 {
			 		document.forma.NUM_CLN.value=document.forma.sel.value;
				 }				 		
</script>
<%!
	boolean EdFlag=false;		//flag of editing
%>
<%
IGestioneTabellare GestioneTabellare=null;
long lCOD_TAB_UTN = 0;
long lCOD_PRG = 0;
long lNUM_CLN = 0;
String strCOD_TAB_UTN="";
String strTIT_TAB = ""; 
String strNOM_TIT_1 = "";				 					  
String strNOM_TIT_2 = "";
String strNOM_TIT_3 = "";
String strNOM_TIT_4 = "";
String strNOM_TIT_5 = "";
Long ID_PARENT=null;
Long tab_utn_id=null;
if (request.getParameter("ID_PARENT")!=null)
	 {
	 	ID_PARENT =new Long(request.getParameter("ID_PARENT"));
	 }
if (request.getParameter("ID")!=null)
	{ 
	strCOD_TAB_UTN = "0";	
	strCOD_TAB_UTN = request.getParameter("ID");	
	EdFlag=true;
	IGestioneTabellareHome home=(IGestioneTabellareHome)PseudoContext.lookup("GestioneTabellareBean");
	tab_utn_id=new Long(strCOD_TAB_UTN);
	GestioneTabellare = home.findByPrimaryKey(tab_utn_id);
	// getting of object variables
	lCOD_TAB_UTN = tab_utn_id.longValue();
	lNUM_CLN=GestioneTabellare.getNUM_CLN();
	lCOD_PRG=GestioneTabellare.getCOD_PRG();
	// ---
	strTIT_TAB=Formatter.format(GestioneTabellare.getTIT_TAB()); 
	strNOM_TIT_1=Formatter.format(GestioneTabellare.getNOM_TIT_1());
	strNOM_TIT_2=Formatter.format(GestioneTabellare.getNOM_TIT_2());
	strNOM_TIT_3=Formatter.format(GestioneTabellare.getNOM_TIT_3());
	strNOM_TIT_4=Formatter.format(GestioneTabellare.getNOM_TIT_4());
	strNOM_TIT_5=Formatter.format(GestioneTabellare.getNOM_TIT_5());
}
IParagrafo Paragrafo=null;
IParagrafoHome ParagrafoHome=(IParagrafoHome)PseudoContext.lookup("ParagrafoBean");
Paragrafo = ParagrafoHome.findByPrimaryKey(ID_PARENT);
%>
<form action="ANA_TAB_UTN_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;" name="forma">
<input name="SBM_MODE" type="Hidden" value="<%=(lCOD_TAB_UTN==0)?"new":"edt"%>">
<input type="hidden" name="COD_TAB_UTN" value="<%=lCOD_TAB_UTN%>">
<input type="hidden" name="ID_PARENT" value="<%=ID_PARENT%>">
<input type="hidden" name="NUM_CLN" value="<%if(lNUM_CLN!=0) {out.print(lNUM_CLN);}%>">
<table width="100%" border="0">
<tr>
 <td valign="top">
  <table  width="100%" border="0">
  <tr>
  <td nowrap width="100%" class="title" ><%=ApplicationConfigurator.LanguageManager.getString("Tabelle")%></td></tr>
  </table>
  </td>
  </tr>
   <tr>
    <td>
   <table width="100" border="0">
   <tr>
   <td>
   <!-- ############################ -->  		
<%ToolBar.bCanDelete=(GestioneTabellare!=null);  
ToolBar.bShowPrint=false;
ToolBar.bShowReturn=false;
ToolBar.strSearchUrl=ToolBar.strSearchUrl.replace('&', '|');
%>	
<%=ToolBar.build(2)%>
<!-- ########################### --> 
</td>
</tr>
   </table>
   
	<table width="100%">
		<tr>
			<td width="7%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Paragrafo")%>&nbsp;</b></td>
			<td width="93%" align="left"><input size="70" maxlength="50" type="text" name="COD_PRG" value="<%=Paragrafo.getNOM_PRG()%>" readonly>
			</td>
		</tr>  
	</table>   	
	
	<tr><td colspan="2">
  <fieldset>
  
  
	 <legend><%=ApplicationConfigurator.LanguageManager.getString("Tabella")%></legend>
   <table  width="100%" border="0">
   <tr>
   <td align="right" width="8%"><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>&nbsp;</td>
	 <td align="left" width="92%"><input size="70" maxlength="50" type="text" name="TIT_TAB" value="<%=strTIT_TAB%>">
	 &nbsp;&nbsp;&nbsp;<b><%=ApplicationConfigurator.LanguageManager.getString("Numero.di.colonne")%>&nbsp;</b>
	 								 <select name="sel" style="width:50" onchange=sel_num_cln();abil_tit();getnew();>
									 				 <option value=""></option>
									 				 <option name="sel" value="1" <%=(lNUM_CLN==1)?"selected":"" %>>1</option>
													 <option name="sel" value="2" <%=(lNUM_CLN==2)?"selected":"" %>>2</option>
													 <option name="sel" value="3" <%=(lNUM_CLN==3)?"selected":"" %>>3</option>
													 <option name="sel" value="4" <%=(lNUM_CLN==4)?"selected":"" %>>4</option>
													 <option name="sel" value="5" <%=(lNUM_CLN==5)?"selected":"" %>>5</option>								
	 								 </select>
   </td></tr>
	 <tr>
	 		<td colspan="100%" width="100%" height="50px" align="center">
								<table width="100%">
								 <tr>
								 		 <td>
										 <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>
										 </td>
								 		 <td>
										 <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>
										 </td>
								 		 <td>
										 <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>
										 </td>
								 		 <td>
										 <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>
										 </td>
								 		 <td>
										 <%=ApplicationConfigurator.LanguageManager.getString("Titolo")%>
										 </td>										 										 										 										 
								 </tr>
								 <tr>
								 		 <td>
										 		 <input size="25" name="NOM_TIT_1"  maxlength="30" type="text" value="<%=Formatter.format(strNOM_TIT_1)%>" >
										 </td>					 		
								 		 <td>
										 		 <input size="25" name="NOM_TIT_2"  maxlength="30" type="text" value="<%=Formatter.format(strNOM_TIT_2)%>" >
										 </td>
								 		 <td>
										 		 <input size="25" name="NOM_TIT_3"  maxlength="30" type="text" value="<%=Formatter.format(strNOM_TIT_3)%>" >
										 </td>
								 		 <td>
										 		 <input size="25" name="NOM_TIT_4"  maxlength="30" type="text" value="<%=Formatter.format(strNOM_TIT_4)%>" >
										 </td>
								 		 <td>
										 		 <input size="25" name="NOM_TIT_5"  maxlength="30" type="text" value="<%=Formatter.format(strNOM_TIT_5)%>" >
										 </td>										 										 										 										 
								 </tr>
							</table>
			<div height="50px" id="res" style="overflow-y : scroll;height : 200px;">
					 <table  colspan="100%" width="100%" height="50px">							 
								 <tr>
								 		 <td colspan="100%">
										 		 <br>
										 </td>
								 </tr>
					</table>
				</div>
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
<%
if (lCOD_TAB_UTN!=0)
	 {
	 IGestioneTabellareHome home_cln=(IGestioneTabellareHome)PseudoContext.lookup("GestioneTabellareBean");
	   java.util.Collection col_cln = home_cln.getCLN_View(tab_utn_id.longValue());
		 java.util.Iterator it_cln= col_cln.iterator();
	int i=1;
	out.print("<script>");
	while (it_cln.hasNext())
	 			{
				CLN_View cln=(CLN_View)it_cln.next();
				out.print("getnew();");
				out.print("document.forma.NOM_CLN_1_"+i+".value="+"\""+Formatter.format(cln.NOM_CLN_1)+"\";");
				out.print("document.forma.NOM_CLN_2_"+i+".value="+"\""+Formatter.format(cln.NOM_CLN_2)+"\";");
				out.print("document.forma.NOM_CLN_3_"+i+".value="+"\""+Formatter.format(cln.NOM_CLN_3)+"\";");
				out.print("document.forma.NOM_CLN_4_"+i+".value="+"\""+Formatter.format(cln.NOM_CLN_4)+"\";");
				out.print("document.forma.NOM_CLN_5_"+i+".value="+"\""+Formatter.format(cln.NOM_CLN_5)+"\";");
				out.print("is_new=false;");
				i++;
				}
	out.print("getnew();");
	out.print("</script>");
	  }
%>
<script>
				abil_tit();		 
</script>		 
  <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
