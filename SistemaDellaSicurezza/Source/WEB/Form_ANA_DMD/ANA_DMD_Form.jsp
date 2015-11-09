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
    <version number="1.0" date="23/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="23/01/2004" author="Khomenko Juliya">
				   <description>Shablon formi ANA_DMD_Form.jsp</description>
				 </comment>
				  <comment date="23/01/2004" author="Alexey Kolesnik">
				   <description> beans are added </description>
				 </comment>
				  <comment date="23/01/2004" author="Alexey Kolesnik">
				   <description> tab added </description>
				 </comment>
				 <comment date="23/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>
				  <comment date="31/01/2004" author="Alexey Kolesnik">
				   <description> Added new toolbar </description>
				 </comment>
				  <comment date="26/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars </description>
				  </comment>
					<comment date="27/02/2004" author="Alexey Kolesnik">
				   <description> Rebuild for dynamic tabbars pri vizove iz ANA_TES_VRF </description>
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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="ANA_DMD_Util.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuTestVerifica,1) + "</title>");
</script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
</head>
<script>
window.dialogWidth="750px";
window.dialogHeight="520px";
</script>
<link rel="stylesheet" href="../_styles/tabs.css">
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" src="../_scripts/tabs.js"></script>
<script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>


<body>

<%
  	long   COD_DMD = 0;				//UID Domande
	String strNOM_DMD = "";			//UNIC Nome Domande
	//-----------------------------
	String strDES_DMD = "";			// Descrisione Domande
	boolean isCOD_TES_VRF=false;
	String strNUM_PTG_DMD="";
	String strNUM_PTG_DMDreadonly="";
%>
<%
		IDomande domande = null;
		ITestVerifica beanTestVerifica=null;
		Long lCOD_TES_VRF = null;
		long COD_NUM_PTG = 0;
		String strCOD_TES_VRF=request.getParameter("ID_PARENT");
		if (strCOD_TES_VRF!=null && !strCOD_TES_VRF.equals("") && !strCOD_TES_VRF.equals("null"))
		{
			lCOD_TES_VRF = new Long (request.getParameter("ID_PARENT"));
			isCOD_TES_VRF=true;
			strNUM_PTG_DMD=request.getParameter("NUM_PTG_DMD");
			if (strNUM_PTG_DMD== null) strNUM_PTG_DMD="";
		}

//////////////////////////////////////////////////
	/*if (request.getParameter("ATTACH_SUBJECT")!=null){
  	String strAttSubj=request.getParameter("ATTACH_SUBJECT");
		if (strAttSubj.equals("DOMANDA_TES_VRF")){
				strCOD_TES_VRF=request.getParameter("ID_PARENT");
				isCOD_TES_VRF=true;
		}
	}*/
//out.print(isCOD_TES_VRF);
//////////////////////////////////////////////////
if(request.getParameter("ID")!=null)
{
	String strCOD_DMD = request.getParameter("ID");
// editing of domande
	IDomandeHome home=(IDomandeHome)PseudoContext.lookup("DomandeBean");
	try{
			domande = home.findByPrimaryKey(new Long(strCOD_DMD));
	}catch(Exception ex){
		out.print("<script>Alert.Error.showNotFound(); window.close();</script>");
		return;
	}
	COD_DMD=domande.getCOD_DMD();
	if (isCOD_TES_VRF && strNUM_PTG_DMD=="")
	{
		try{
			strNUM_PTG_DMD = Formatter.format(domande.getNUM_PTG_DMD(lCOD_TES_VRF.longValue()));
			strNUM_PTG_DMDreadonly = "readonly";
		}catch(Exception ex){
			strNUM_PTG_DMD = "";
		}
	}
	strNOM_DMD=domande.getNOM_DMD();
	strDES_DMD=domande.getDES_DMD();
}// if request
 %>

<!-- form for addind  piano-->
<form name='frm1' action="ANA_DMD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(COD_DMD==0)?"new":"edt"%>">
<input type="hidden" name="COD_DMD" value="<%=COD_DMD%>">
<input type="hidden" name="ID_PARENT" value="<%=strCOD_TES_VRF%>">
<table  width="100%">
  <tr><td class="title">
    <script>
        document.write(getCompleteMenuPathFunction
            (SubMenuTestVerifica,1,<%=request.getParameter("ID")%>));
    </script>
  </td></tr>
  <tr>
  	<table width="100%" border="0">
	<!-- ############################ -->
	<%@ include file="../_include/ToolBar.jsp" %>
	<%ToolBar.bCanDelete=(domande!=null); ToolBar.Debug=DEBUG;%>
	<%=ToolBar.build(2)%>
	<%
		if(request.getParameter("ID_PARENT")!=null)
		{
			ToolBar.strSearchUrl=ToolBar.strSearchUrl.replace('&', '|');
		}
	%>
	<!-- ########################### -->
	</table>
        <table border="0" width="100%">
        <tr>
        <td>
            <fieldset>
            <legend><%=ApplicationConfigurator.LanguageManager.getString("Domanda")%></legend>
            <table  width="100%" border="0" align="center">
            <tr>
                <td align="right" valign="top" width="15%"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                    <td width="73%">
                        <!--<table border="2" cellpadding="0" cellspacing="0">
	 <tr>
	  <td width="300"> -->
                        <textarea tabindex="1" rows="3" style="width:100%;"  id="NOM_DMD" name="NOM_DMD" cols="70%"><%=strNOM_DMD%></textarea>
                    </td>
                    <% if(strCOD_TES_VRF!=null){%>
                    <script>
                    window.dialogHeight="550px";
                    </script>
                    <tr>
                        <td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Num.Punteggio.domanda")%>&nbsp;</td>
                        <td  valign="top">
                            <input tabindex="2" maxlength="7" size="5" type="text" name="NUM_PTG_DMD" maxlength="5" value="<%=strNUM_PTG_DMD%>" onblur="changeNumero()" <%//strNUM_PTG_DMDreadonly%> >
                            <!-- //if(COD_NUM_PTG!=0){out.print(COD_NUM_PTG);} -->
                            <br>
                        </td>
                    </tr>
                    <%}%>
                    
                </tr>
                <tr><td valign="top" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                    <td><textarea tabindex="3" rows="3" cols="70%" id="DES_DMD" name="DES_DMD" ><%=strDES_DMD%></textarea>
                    </td>
                </tr>
        </td></tr>
        </table>
    </fieldset></td></tr></table>
  <tr>
  	<td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
  </tr>
  </table>
 </td>
</tr>
</table>

<!-- /form for addind  piano-->
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

<%
//---------esli forma vyzvanna iz ANA_TES_VRF, pereopredeliaem obrabotchik knopki Return
if (isCOD_TES_VRF){
	%>
<script>
function changeNumero(){
//alert(tb_url_Attach);
	strUrl=tb_url_Attach;
	posNew=strUrl.indexOf("&NUM_PTG_DMD=",0);
	if (posNew!=-1){
		str1=strUrl.substring(0,posNew+13);
		str2=strUrl.substring(posNew+13,strUrl.length);
		posNew=str2.indexOf("&",0);
		str2=str2.substring(posNew,str2.length);
		//alert(str2);
		strUrl=str1+document.all["NUM_PTG_DMD"].value;//+str2;
  	//alert(strUrl);
		tb_url_Attach=strUrl;
	}
	else{
		tb_url_Attach+="&NUM_PTG_DMD="+document.all["NUM_PTG_DMD"].value;
	}
<%if(DEBUG) out.print("alert(tb_url_Attach);");%>
}
</script>
	<%
}
 %>

<%
//-------Loading of Tabs--------------------
if(domande!=null)

{
// -----------------------------------------
%>
<script language="JavaScript" src="../_scripts/index.js"></script>
<script language="JavaScript">
	btnParams = new Array();
	btnParams[0] = {"id":"btnNew",
					"onclick":addRow,
					"action":"AddNew"
					};
	btnParams[1] = {"id":"btnEdit",
					"onclick":editRow,
					"action":"Edit"
					};
	btnParams[2] = {"id":"btnCancel",
					"onclick":delRow,
					"action":"Delete"
					};
    //--------creating tabs--------------------------
	var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Risposte")%>", tabbar));
	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%=COD_DMD%>;
	tabbar.refreshTabUrl="ANA_DMD_Tabs.jsp";
	tabbar.RefreshAllTabs();
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										 "Feachures":ANA_RST_Feachures,
										 "AddNew":	{"url":"../Form_ANA_RST/ANA_RST_Form.jsp?ATTACH_URL=Form_ANA_DMD/ANA_DMD_Attach.jsp",
													"alert": null,
													"buttonIndex":0,
													"disabled": false
												  },
										 "Edit":	{"url":"../Form_ANA_RST/ANA_RST_Form.jsp?ATTACH_URL=Form_ANA_DMD/ANA_DMD_Attach.jsp",
													"alert": null,
													"buttonIndex":1,
													"disabled": false
										 			},
										 "Delete":	{"url":"../Form_ANA_DMD/ANA_DMD_Delete.jsp?LOCAL_MODE=ris",
													"target_element":document.all["ifrmWork"],
													"alert": null,
													"buttonIndex":2,
													"disabled": false
										 			}
										};
//------------------------------------------------------------------------

</script>
<%}else{%>
    <% if(strCOD_TES_VRF!=null){%>
        <script>
            window.dialogHeight="320px";
        </script>
    <%} else {%>
        <script>
            window.dialogHeight="280px";
        </script>
    <%}%>
<%}%>
</form>
</body>
</html>
