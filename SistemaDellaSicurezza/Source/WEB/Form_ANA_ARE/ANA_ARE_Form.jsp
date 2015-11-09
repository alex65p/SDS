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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioniSezioni.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="ANA_ARE_Util.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<script>
    function getLOV(){
        var obj=new Object();
        var url="Form_ANA_ARE/ANA_ARE_Lovs.jsp?";
        if(showSearch(url, obj)=="OK"){
            document.all['ifrmWork'].src="ANA_ARE_LovSet.jsp?ID="+obj.ID;           
        }
    }
</script>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuDVR,0) + "</title>");
        </script>
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="415px";
    </script>
    <body>

        <%
            IAzienda azienda;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            IGestioniSezioni GestioniSezioni = null;
            IGestioniSezioniHome home = (IGestioniSezioniHome) PseudoContext.lookup("GestioniSezioniBean");
            Checker c = new Checker();
            long lCOD_ARE = 0;			//1 
            long lCOD_AZL = Security.getAzienda();	//2 
            String strNOM_ARE = "";			//3
            String strIDZ_ARE = "";			//4
            String strNUM_CIC_ARE = "";		//5
            String strCIT_ARE = "";			//6
            String strPRV_ARE = "";			//7
            String strCAP_ARE = "";			//8
            String strCOD_ARE = "";
            String ID_PARENT = "";
            ID_PARENT = (String) request.getParameter("ID_PARENT");
            long lngID_PARENT = 0;
            lngID_PARENT = c.checkLong("ID_PARENT", request.getParameter("ID_PARENT"), false);

            if (request.getParameter("ID") != null) {
                strCOD_ARE = request.getParameter("ID");

                Long ARE_id = new Long(strCOD_ARE);
                GestioniSezioni = home.findByPrimaryKey(ARE_id);

                lCOD_ARE = ARE_id.longValue(); 						//1
                lCOD_AZL = GestioniSezioni.getCOD_AZL();			//2 
                strNOM_ARE = GestioniSezioni.getNOM_ARE();			//3
            }

            // Get Aziende/Ente
            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            String strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();
            if (Security.getCurrentDvrUniOrgName() != null) {
                strRAG_SCL_AZL += ", " + Security.getCurrentDvrUniOrgName();
            }
        %>

        <!-- form for addind azienda -->
        <form action="ANA_ARE_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input type="hidden" name="SBM_MODE" value="<%=(lCOD_ARE == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_ARE" value="<%=lCOD_ARE%>">
            <input type="hidden" name="COD_ARE_R" id="COD_ARE_R" value="">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <input type="hidden" name="ID_PARENT" value="<%=request.getParameter("ID_PARENT")%>">
            <table width="100%" border="0">

                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuDVR,0,<%=request.getParameter("ID")%>));
                                    </script>      
                                </td></tr>
                            <tr>
                                <td><table>

                                        <!-- 	********************************** -->
                                        <table width="100%" border="0">
                                            <%@ include file="../_include/ToolBar.jsp" %>
                                            <%ToolBar.bCanDelete = (GestioniSezioni != null);%>
                                            <%=ToolBar.build(3)%>
                                        </table>
                                        <!-- 	********************************** -->



                                        <%
                                            //---------esli forma vyzvanna iz ANA_TES_VRF, pereopredeliaem obrabotchik knopki Return
                                            if (ID_PARENT != null && ID_PARENT != "") {
                                        %>
                                        <script>
                                            function changeNumero(){
                                                strUrl=tb_url_Attach;
                                                posNew=strUrl.indexOf("&PRT=",0);
                                                if (posNew!=-1){
                                                    str1=strUrl.substring(0,posNew+5);
                                                    posNew1=strUrl.indexOf("&",posNew+5);
                                                    str2=strUrl.substring(posNew1,strUrl.length);
                                                    str2=str2.replace("PRT=", "PRTXXX=");
                                                    strUrl=str1+document.all["PRT"].value;//+str2;
                                                    tb_url_Attach=strUrl;
                                                }
                                                else{
                                                    tb_url_Attach+="&PRT="+document.all["PRT"].value;
                                                }
                                            <%if (DEBUG) {
                                                    out.print("alert(tb_url_Attach);");
                                                }%>
                                                    }
                                        </script>
                                        <%
                                            }
                                        %>

                                    </table>
                            <tr>
                                <td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Sezione")%></legend>
                                        <table  width="100%" border="0" cellspacing='5' cellpadding='0'>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td><input tabindex="1" size="110" type="text" readonly value="<%=strRAG_SCL_AZL%>">
                                                </td></tr>
                                            <tr>
                                                <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td>
                                                <td align="left"><input tabindex="2" size="110" type="text" maxlength="100" name="NOM_ARE" id="NOM_ARE" value="<%=strNOM_ARE%>"></td>
                                            </tr>
                                            </td></tr>

                                            <%if (ID_PARENT != null && ID_PARENT != "" && GestioniSezioni != null) {
                                                    out.print("<tr><td align='right' width='18%'>Priorit&agrave;</td>");
                                                    out.print("<td><input tabindex='1' size='10%' type='text' maxlength='100' onblur='changeNumero();' id='PRT' name='PRT' value='" + GestioniSezioni.getARE_DOC_VLU_Priority(lngID_PARENT, lCOD_ARE) + "'></td></tr>");
                                                    out.print("<script>changeNumero();</script>");

                                            %>
                                            <script>
                                                window.dialogWidth="700px";
                                                window.dialogHeight="470px";
                                            </script>
                                            <%}%>
                                        </table>	 
                                    </fieldset></td></tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                </tr> 
            </table>
        </form>
        <!-- /form for addind Dipendente -->

        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" >none</iframe>

        <%
            //-------Loading of Tabs--------------------
            if (GestioniSezioni != null) {
                /*
                 * String s; // s=BuildGestioniSezioniTab(home, lCOD_ARE,
                 * lCOD_AZL); out.print(s);
                 */
                // -----------------------------------------
%>
        <script language="JavaScript" src="../_scripts/index.js"></script>
        <script language="JavaScript">
            //--------BUTTONS description-----------------------
            btnParams = new Array();
            btnParams[0] = {"id":"btnNew", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":addRow,
                "src":"../_images/NUOVO.gif", 
                "action":"AddNew"
            };
            btnParams[2] = {"id":"btnCancel", 
                "onmousedown":btnDown, 
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":delRow,
                "src":"../_images/DEL_DET.gif",
                "action":"Delete"
            };
            btnParams[1] = {"id":"btnEdit", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":editRow,
                "src":"../_images/EDIT.gif",
                "action":"Edit"
            };				
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);        
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Associazioni.capitolo/sezione")%>", tabbar));
        
            tabbar.idParentRecord = <%=lCOD_ARE%>;
            tabbar.refreshTabUrl="ANA_ARE_Tabs.jsp";	
            tabbar.RefreshAllTabs();
	
            tabbar.tabs[0].tabObj.actionParams ={"AddNew":	{"url":"../Form_CPL_ARE/CPL_ARE_Form.jsp?ATTACH_URL=Form_ANA_ARE/ANA_ARE_Attach.jsp", 
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_CPL_ARE/CPL_ARE_Delete.jsp?DELETE_FROM_AREA=true",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]	
                },		
                "Edit":	{"url":"../Form_CPL_ARE/CPL_ARE_Form.jsp?ATTACH_URL=Form_ANA_ARE/ANA_ARE_Attach.jsp",
                    "buttonIndex":1
                },
                "Feachures":CPL_ARE_Feachures
            }; 
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
        </script>
        <%} else {%>
        <script>
            window.dialogWidth="700px";
            window.dialogHeight="210px";
        </script>
        <%}%>
        <script type="text/javascript">
            if (document.all("ID_PARENT").value== "") {
                ToolBar.Return.setEnabled(false);
            }
        </script>

    </body>
</html>
