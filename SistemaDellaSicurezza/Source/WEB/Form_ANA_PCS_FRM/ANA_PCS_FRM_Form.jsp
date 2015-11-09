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
    <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
    <comments>
    <comment date="25/01/2004" author="Khomenko Juliya">
    <description>Shablon formi ANA_PCS_FRM_Form.jsp</description>
    </comment>		
    <comment date="25/02/2004" author="Khomenko Juliya">
    <description>Create dinamic tab</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_PCS_FRM_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuFormazione,2) + "</title>");
        </script>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="570px";
    </script>
    <body>

        <%
            IAzienda azienda;
            IPercorsiFormativi PercorsiFormativi = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            long lCOD_PCS_FRM = 0;			    //1 
            String strNOM_PCS_FRM = "";			//2
            String strDES_PCS_FRM = "";			//3
            long lCOD_AZL = Security.getAzienda();	 //4


            if (request.getParameter("ID") != null) {
                String strCOD_PCS_FRM = request.getParameter("ID");
                //lCOD_PCS_FRM = request.getParameter("ID");

                IPercorsiFormativiHome home = (IPercorsiFormativiHome) PseudoContext.lookup("PercorsiFormativiBean");
                Long PCS_FRM_id = new Long(strCOD_PCS_FRM);
                PercorsiFormativi = home.findByPrimaryKey(PCS_FRM_id);

                lCOD_PCS_FRM = PCS_FRM_id.longValue(); 						//1
                strNOM_PCS_FRM = Formatter.format(PercorsiFormativi.getNOM_PCS_FRM());		//2
                strDES_PCS_FRM = Formatter.format(PercorsiFormativi.getDES_PCS_FRM());		//3 - Nullable
                lCOD_AZL = PercorsiFormativi.getCOD_AZL(); 						  //4
            }
            // Get Aziende/Ente
            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            String strRAG_SCL_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
        %>

        <!-- form for addind  piano-->
        <form action="ANA_PCS_FRM_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_PCS_FRM == 0) ? "new" : "edt"%>">
            <input type="hidden" name="PCS_FRM_ID" value="<%=lCOD_PCS_FRM%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">

                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                        (SubMenuFormazione,2,<%=request.getParameter("ID")%>));
                                    </script>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <!-- ############################ -->  
                                    <table width="100%" border="0">
                                        <%@ include file="../_include/ToolBar.jsp" %>      
                                        <%ToolBar.bCanDelete = (PercorsiFormativi != null);%>		
                                        <%=ToolBar.build(2)%> 
                                    </table>		
                                    <!-- ########################### -->
                                    <br>
                                    <fieldset> 
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.percorso.formativo")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                <td ><input readonly style="width:100%;" type="text" value="<%=strRAG_SCL_AZL%>">
                                                </td></tr>
                                            <tr>
                                                <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</b></td> 
                                                <td ><input tabindex="1" style="width:100%;" type="text" maxlength="50" name="NOME" value="<%=strNOM_PCS_FRM%>">
                                                </td></tr>
                                            <tr>
                                                <td width="15%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</td>
                                                <td><textarea style="width:100%;" tabindex="2" rows="5" cols="87" name="DESC"><%=strDES_PCS_FRM%></textarea>
                                                </td></tr>
                                        </table>	 
                                    </fieldset>
                                </td></tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr> 
                        </table>
                    </td>
                </tr>  
            </table>
        </form>
        <!-- /form for addind  piano-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs--------------------
            if (PercorsiFormativi != null) {
                /*	String s;
                //
                IPercorsiFormativiHome phome=(IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");
                s=PercorsiFormativiCorsiTab(phome, Formatter.format(lCOD_PCS_FRM));
                out.print(s);
                //	out.print("<script>alert(\""+s+"\");</script>");*/
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
            btnParams[1] = {"id":"btnEdit", 
                "onmousedown":btnDown, 	
                "onmouseup":btnOver,
                "onmouseover":btnOver,
                "onmouseout":btnOut,
                "onclick":editRow,
                "src":"../_images/EDIT.gif", 
                "action":"Edit"
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
            //--------creating tabs--------------------------
            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
            var btnBar = new ButtonPanel("batPanel1", btnParams);
            tabbar.addButtonBar(btnBar);        
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Corsi")%>", tabbar));
	
            //------adding dinamic tables to tabs-----------------------        
            tabbar.idParentRecord = <%= lCOD_PCS_FRM%>;
            tabbar.refreshTabUrl="ANA_PCS_FRM_Tabs.jsp";	
            tabbar.RefreshAllTabs();

            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams = {
                "Feachures": ANA_COR_Feachures,
                "AddNew":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_PCS_FRM/ANA_PCS_FRM_Attach.jsp&ATTACH_SUBJECT=COR", 
                    "buttonIndex":0					 						
                },
                "Delete":	{"url":"../Form_ANA_COR/ANA_COR_Delete.jsp?LOCAL_MODE=COR",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                },		
                "Edit":	{"url":"../Form_ANA_COR/ANA_COR_Form.jsp?ATTACH_URL=Form_ANA_PCS_FRM/ANA_PCS_FRM_Attach.jsp&ATTACH_SUBJECT=COR",
                    "buttonIndex":1
                }			  	
            }; 
        </script> 
        <%} else {%>
        <script>
            window.dialogWidth="700px";
            window.dialogHeight="340px";
        </script>
        <%}%>
    </body>
</html>
