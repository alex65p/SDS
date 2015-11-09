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

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
<head>
<% 	if (request.getParameter("t").equals("edit")){ %>
	<title><%=ApplicationConfigurator.LanguageManager.getString("Editor")%></title>
<% }
else { %>
		<title><%=ApplicationConfigurator.LanguageManager.getString("Cerca/Sostituisci")%></title>
<% } %>
</head>


<style>
.editor{
    width:100%;
    height:100%;	

}
.editorTab{
	width:100%;
	height:100%;	
}       
.txtArea{
	width:100%;
	height:100%;	
	overflow:auto;
	border:1px inset white;
}
.search{
	width:100%;
	height:100%;
}
input.button{
	background-color:#cccccc;
	border:1px outset white; 
}
</style>
<link rel="stylesheet" href="../_styles/style.css">
</HEAD>

<BODY BGCOLOR="white">
<% 
	if (request.getParameter("t").equals("edit")){
 %>	
	<div class="editor">
		<table class="editorTab" id="text"  border="0">
		  <tr>
		    <td height="100%" colspan="3">
		    	<textarea id="txtArea" class="txtArea"></textarea>
		    </td>
		  </tr>
		  <tr><td colspan="3"></td></tr>
		  <tr>
		    <td align="right"><input class="button" type="button" style="width:75px" value=<%=ApplicationConfigurator.LanguageManager.getString("Ok")%> onclick="onOk()"> </td>
		    <td align="left"><input class="button" type="button" style="width:75px" value=<%=ApplicationConfigurator.LanguageManager.getString("Annulla")%> onclick="onAnnula()"> </td>
		    <td align="right" width="100%"><input class="button" type="button" style="width:75px" value=<%=ApplicationConfigurator.LanguageManager.getString("Cerca")%> onclick="onSearch()"> </td>
		  </tr>
		  
		</table>
	</div>
	<script language="JavaScript">
	function onSearch(){
		res= window.showModelessDialog("editor.jsp?t=search" ,document.all["txtArea"] , l_getFeachures())		
	}
	function onAnnula(){
		window.returnValue="CANCEL";
		window.close();
	}
	function onOk(){
		if (window.dialogArguments){
			
			window.dialogArguments.value = document.all["txtArea"].value;   
			window.returnValue="OK";
			window.close();
		}	
	}
	function getText(){
		if (window.dialogArguments){
			document.all["txtArea"].value = window.dialogArguments.value;
		}
	}
	function l_getFeachures(){
		return "dialogHeight:120px; dialogWidth:500px;help:no;resizable:no;status:no;scroll:no;";
	}
	
	document.body.onload=getText;
</script>
<% } else
	 if (request.getParameter("t").equals("search")) {%>	
	<div id="search" class="search">
		<table style="width:100%; height:100%" border="0">
			<tr><td colspan="100%"></td></tr>
			<tr>
				<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Cerca")%></td><td width="100%"><input style="width:100%" type="text" id="searchText" onclick=""></td>
			</tr>
			<tr>
				<td nowrap align="right"><%=ApplicationConfigurator.LanguageManager.getString("Sostituisci.con")%></td><td width="100%"><input style="width:100%" type="text" id="replaceText"></td>
			</tr>
			<tr>
				<td colspan="2">
					<table width="100%">
						<tr>
							<td width="100%"><input type="button" class="button" style="width:75px" value="<%=ApplicationConfigurator.LanguageManager.getString("Annulla")%>" onclick="closeSearch()"></td>
							<td><input type="button" class="button" style="width:75px" value="<%=ApplicationConfigurator.LanguageManager.getString("Cerca")%>" onclick="searchText()"></td>
							<td><input type="button" class="button" style="width:100px" value="<%=ApplicationConfigurator.LanguageManager.getString("Sostituisci")%>" onclick="replaceText()"></td>
							<td><input type="button" class="button" style="width:130px" value="<%=ApplicationConfigurator.LanguageManager.getString("Sostituisci.tutto")%>" onclick="replaceAllText()"></td>
                                                 </tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
<script language="JavaScript">
function closeSearch(){
		window.close();
	}
function searchText(){
	sText = document.all["searchText"].value;
	text = window.dialogArguments.value;
	if (sText=="") {
		alert(arraylng["MSG_0089"]);
		return;
	}	
	obj=window.dialogArguments;
	findInPage(sText, obj, "",false, false);
}	
function replaceText(){
	sText = document.all["searchText"].value;
	rText = document.all["replaceText"].value;
	text = window.dialogArguments.value;
	if (sText.length==0 ) {
		return;
	}	
	obj=window.dialogArguments;
	findInPage(sText, obj, rText, true, false);
}
function replaceAllText(){
	sText = document.all["searchText"].value;
	rText = document.all["replaceText"].value;
	if (sText=="") {
		return;
	}
	text = window.dialogArguments.value;
	obj=window.dialogArguments;
	findInPage(sText, obj, rText, false, true);
}
var n = 0; 
var a = 0;
function findInPage(strFind, obj, strReplace, isReplace, isReplaceAll) { 
	var txt, i, found; 
	if (strFind == "") return false; 
	txt = obj.createTextRange();
  
	try{
		for (i = 0; i <= n && (found = txt.findText(strFind)) != false; i++) { 
			txt.moveStart("character", 1); 
			txt.moveEnd("textedit"); 
		} 

		if (found) { 
			
			txt.moveStart("character", -1); 
			txt.findText(strFind); 
			txt.select(); 
			//-----------addition for replace----
			if (isReplaceAll){
				txt.text = strReplace;
				n++;a++;
				findInPage(strFind, obj, strReplace, isReplace, isReplaceAll);
				return;
			}
			if (isReplace){
				if (confirm(arraylng["MSG_0093"])) {
					txt.text = strReplace; 
				}	
				else{
					n++;
					return;				
				}
				txt.moveStart("character", -strReplace.length); 
				n=0;
				txt.findText(strReplace);
				txt.select();			
				return;
			}
			//---------------
			txt.scrollIntoView(); 
			n++;
		} 
		else { 
			if (n > 0) { 
				n = 0; 
				findInPage(strFind, obj, strReplace, isReplace, isReplaceAll);
			} 
			else{
				if (!isReplaceAll && !isReplace ){
					alert(arraylng["MSG_0091"]);
				}else if(isReplace){
					alert(arraylng["MSG_0090"]);
				}else if(isReplaceAll){
					if (a!=0)
						alert(a + " " + arraylng["MSG_0092"]);
					else
						alert(arraylng["MSG_0090"]);					
				}
				a=0;	
			}	
		}
	}	
	catch(e){
		return;
	}	
}	


</script>
	<% } %>


</body>
</html>
