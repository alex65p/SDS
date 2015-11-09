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
    <version number="1.0" date="24/02/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="24/02/2004" author="Roman Chumachenko">
				   <description>GEST_RSO_MAN_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<head>
    <script>
	window.dialogWidth="706px";
	window.dialogHeight="280px";
</script>
	<title><%=ApplicationConfigurator.LanguageManager.getString("Gestione.fattori.di.rischio.per.attività.lavorative")%></title>
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<body style="margin:0 0 0 0;">
<%
	Checker c = new Checker();		//
	long lCOD_MAN=0;     				//1
	long lCOD_AZL=0;     				//2
	//
//if (true) return;
IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
if(request.getParameter("ID_PARENT")!=null)
{
	lCOD_MAN=Long.parseLong( request.getParameter("ID_PARENT") );
	lCOD_AZL=Security.getAzienda();
}
%>
<table cellpadding="0" cellspacing="0" border="0" width="700">
<tr><td align="center" class="title"><%=ApplicationConfigurator.LanguageManager.getString("Gestione.fattori.di.rischio.per.attività.lavorative")%></td></tr>    
<tr>
    <td valign="top" style="border:2px solid #4B6A89">
<!-- ##################################################################################### -->
	<table border=0>
            <tr><td  width="100%">
                    <%@ include file="../_include/ToolBar.jsp" %>
                    <%ToolBar.bShowNew=false;%>
                    <%ToolBar.bShowSave=true;%>
                    <%ToolBar.bShowSearch=false;%>
                    <%ToolBar.bShowDelete=false;%>
                    <%ToolBar.bShowPrint=false;%>
                    <%ToolBar.bShowReturn=false;%>
                    
                    <%=ToolBar.build(3)%>
            </td></tr>
             <tr><td>&nbsp;</td></tr>
	</table>
<!-- ##################################################################################### -->
	<form action="GEST_FAT_RSO_MAN_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
	
            <table width="100%"><tr><td>
                        <table border='0' id="Header" class='dataTableHeader' cellpadding='2' cellspacing='0' width="100%">
                            <tr>
                                <td><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio")%></strong></td>
                                <td><strong>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Abilita")%></strong></td>
                            </tr>
                            <tr style="background-color:D7D6E6;" >
                                <td align='center' width='300' style="border-bottom:2px solid #4B6A89"></td>
                                <td align='center' width='30' style="border-bottom:2px solid #4B6A89"><input name="CHK_ALL" id="CHK_ALL" type="checkbox" class='dataInput2'  onclick="CheckAll(this)"></td>
                            </tr>
                        </table>
                        <div class="tabScrDiv" >
                            <table id="DataTable" class='dataTable' cellpadding='1' cellspacing='0' border="0">
                                <%
                                java.util.Collection col = home.getFattoriWithoutRischiView(lCOD_AZL, lCOD_MAN);;
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                FattoreRischio_View obj=(FattoreRischio_View)it.next();
                                String checked = "";
                                if (obj.lFlag==1) checked="checked"; 
                                %>
                                <tr>
                                    <td class='dataTd' align="center" ><input readonly type="Text" value="<%=Formatter.format(obj.NOM_FAT_RSO)%>" class='inputstyle'></td>
                                    <td align="center">&nbsp;<input name="CHK_ITEM" <%= checked %> id="CHK_ITEM" type="checkbox" class='dataInput2' value="<%= Formatter.format(obj.COD_FAT_RSO) %>"></td>
                                </tr>
                                <%
                                }
                                %>
                            </table>
                        </div>
                        <input type="Hidden" value="<%=Formatter.format(lCOD_MAN)%>" name="COD_MAN">
                    </td>
                </tr>
            </table>
            
	</form> 
        
	</td>
 </tr>
</table>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<script>
// -- OnReturn --
function OnReturn(){
	document.forms(0).submit();
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// -- table correction --
adaptTable(document.all["Header"], document.all["DataTable"]);

function adaptTable(tableHeader, table){
	counter = new Object();
	counter.i=0;
	counter.y=0;
	counter.z=0;	
	for (counter.i=0; counter.i< table.rows.length; counter.i++){
		for (counter.y=0; counter.y<table.rows[counter.i].cells.length; counter.y++){
			iCol = table.rows[counter.i].cells[counter.y].getElementsByTagName("INPUT");
			for (counter.z=0; counter.z< iCol.length; counter.z++){
				if (iCol[counter.z].type=="text"){
					width = tableHeader.rows[0].cells[counter.y].offsetWidth;
					iCol[counter.z].width= width;
					table.rows[counter.i].cells[counter.y].style.width=width;
					break;
				}
			}
		}
	}
	counter=null;
}
// --- check all ---
function CheckAll(selector){
	//selector.checked=!selector.checked;
	if(selector.checked==true){
		for(i=1; i < document.forms(0).elements.length; i++ ){
			obj_type=document.forms(0).elements(i).type;
			obj		=document.forms(0).elements(i);
			if(obj_type=="checkbox"){
				obj.checked = true ;
			}	
		}
	}else{
		for(i=1; i < document.forms(0).elements.length; i++ ){
			obj_type=document.forms(0).elements(i).type;
			obj		=document.forms(0).elements(i);
			if(obj_type=="checkbox"){
				obj.checked = false ;
			}	
		}
	}
}
//------------------------------------------------------------
</script>
</body>
</html>
