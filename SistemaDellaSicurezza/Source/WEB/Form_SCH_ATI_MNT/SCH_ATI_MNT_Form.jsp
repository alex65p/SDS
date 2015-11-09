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
            <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
            <comments>
            <comment date="25/01/2004" author="Podmasteriev Alexandr">
            <description>Shablon formi SCH_ATI_MNT_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivaManutenzione.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="SCH_ATI_MNT_Util.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Schede.attività.di.segnalazione")%></title>
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
        
        <link rel="stylesheet" href="../_styles/style.css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>
        
    </head>
    <script>
        window.dialogWidth="650px";
        window.dialogHeight="630px";
    </script>
    <body>
        <%
            String lCOD_SCH_ATI_MNT = "";
            String lCOD_MNT_MAC = "";
            long lCOD_MAC = 0;
            long lCOD_DPD = 0;
            String strATI_SVO = "";
            String dtDAT_ATI_MNT = "";
            String strESI_ATI_MNT = "P";
            String strPBM_ATI_MNT = "";
            String dtDAT_PIF_INR = "";
            String strTPL_ATI = "M";
            long lCOD_AZL = 0;
            String strRAG_SCL_AZL = "";
            lCOD_AZL = Security.getAzienda();

            IAzienda azienda = null;
            IAziendaHome AziendaHome = (IAziendaHome) PseudoContext.lookup("AziendaBean");

            ISchedaAttivitaSegnalazione SchedaAttivitaSegnalazione = null;
            IAttivaManutenzione AttivaManutenzione = null;



            if (request.getParameter("ID") != null) {
                lCOD_SCH_ATI_MNT = request.getParameter("ID");
                ISchedaAttivitaSegnalazioneHome home = (ISchedaAttivitaSegnalazioneHome) PseudoContext.lookup("SchedaAttivitaSegnalazioneBean");
                Long for_id = new Long(lCOD_SCH_ATI_MNT);
                SchedaAttivitaSegnalazione = home.findByPrimaryKey(for_id);
                // getting of object variables
                strATI_SVO = SchedaAttivitaSegnalazione.getATI_SVO();//good
                dtDAT_ATI_MNT = Formatter.format(SchedaAttivitaSegnalazione.getDAT_ATI_MNT());
                strESI_ATI_MNT = SchedaAttivitaSegnalazione.getESI_ATI_MNT();
                strPBM_ATI_MNT = SchedaAttivitaSegnalazione.getPBM_ATI_MNT();
                dtDAT_PIF_INR = Formatter.format(SchedaAttivitaSegnalazione.getDAT_PIF_INR());
                strTPL_ATI = SchedaAttivitaSegnalazione.getTPL_ATI();
                lCOD_DPD = SchedaAttivitaSegnalazione.getCOD_DPD();

                lCOD_MNT_MAC = Formatter.format(SchedaAttivitaSegnalazione.getCOD_MAC());//added by Podmasteriev dlya sovmestimosti s SCH_COR_Form
                lCOD_MAC = SchedaAttivitaSegnalazione.getCOD_MNT_MAC();//added by Podmasteriev dlya sovmestimosti s SCH_COR_Form
            //--- 
            }
            Long azl_id = new Long(lCOD_AZL);
            azienda = AziendaHome.findByPrimaryKey(azl_id);
            strRAG_SCL_AZL = azienda.getRAG_SCL_AZL();


            if (request.getParameter("ID_PARENT") != null)//IF added by Podmasteriev dlya sovmestimosti s SCH_COR_Form
            {
                IAttivaManutenzioneHome home_mac = (IAttivaManutenzioneHome) PseudoContext.lookup("AttivaManutenzioneBean");
                lCOD_MNT_MAC = request.getParameter("ID_PARENT");
                Long man_id = new Long(lCOD_MNT_MAC);
                AttivaManutenzione = home_mac.findByPrimaryKey(man_id);
                // getting of object variables
                lCOD_MAC = AttivaManutenzione.getCOD_MAC();
            }
        %>
        
        <!-- form for addind azienda --> 
        <form action="SCH_ATI_MNT_Set.jsp" method="POST" target="ifrmWork" >
            <table width="100%" border="0">
            <tr>
            <td valign="top">
            <table  width="100%"  border="0">
                <tr>
                    <td class="title"> 
                        <%=ApplicationConfigurator.LanguageManager.getString("Schede.attività.di.segnalazione")%>
                        <input name="SBM_MODE" type="Hidden" value="<%if (lCOD_SCH_ATI_MNT == "") {
                out.print("new");
            } else {
                out.print("edt");
            }%>">
                        <input name="COD_SCH_ATI_MNT" type="Hidden" value="<%=lCOD_SCH_ATI_MNT%>">
                        <input name="COD_MAC" type="Hidden" value="<%=lCOD_MAC%>">
                        <input name="COD_MNT_MAC" type="Hidden" value="<%=lCOD_MNT_MAC%>">
                        <input name="COD_AZL" type="Hidden" value="<%=lCOD_AZL%>">
                        
                    </td>
                </tr>
                <tr>
                    <td>
                        <!-- ############################ -->
                        <table border="0" width="100%">
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%ToolBar.bCanDelete = (SchedaAttivitaSegnalazione != null);%>	
                            <%//ToolBar.bShowReturn=false;%>
                            <%ToolBar.bShowSearch = false;%>
                            <%=ToolBar.build(2)%> 
                        </table>
                        <!-- ########################### -->
                        <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.segnalazione")%></legend>
                            <table  width="100%" border="0">
                                <tr>
                                    <td align="center" >
                                        <fieldset style="width:30%">
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></legend>
                                            <table border="0" width="100%" align="center">
                                                <tr>
                                                    <td><input name="TPL_ATI"  type="radio" class="checkbox" value="M" <%if (strTPL_ATI.equals("M")) {
                out.print("checked");
            }%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%></td>
                                                    <td><input name="TPL_ATI" type="radio" class="checkbox" value="S" <%if (strTPL_ATI.equals("S")) {
                out.print("checked");
            }%>>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%></td>								 
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" >
                                        <fieldset style="width:100%">
                                            <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore")%></b></legend>
                                            <table border="0" width="100%" align="center">
                                                <tr>
                                                    <td width="15%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</b></td>
                                                    <td width="85%"><input type="" size="97" name="" readonly value="<%=strRAG_SCL_AZL%>"></td>								 
                                                </tr>
                                                <tr>
                                                    <td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Dipendente")%>&nbsp;</b></td>
                                                    <td>
                                                        <select name="COD_DPD" style="width:510;">
                                                            <option value=''>  </option>
                                                            <%
            IDipendenteHome d_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
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
                                    <td>
                                        <table border="0" width="100%" align="center">
                                            <tr>
                                                <td align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.attività")%>&nbsp;</td>
                                                <td><s2s:Date id="DAT_ATI_MNT" name="DAT_ATI_MNT" value="<%=dtDAT_ATI_MNT%>"/></td>
                                                <td nowrap align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificazione")%>&nbsp;</b></td>
                                                <td><s2s:Date id="DAT_PIF_INR" name="DAT_PIF_INR" value="<%=dtDAT_PIF_INR%>"/></td>
                                                <td nowrap align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Esito.attività")%>&nbsp;</b></td>
                                                <td>
                                                    <select name="ESI_ATI_MNT">
                                                        <option value="P" <%if (strESI_ATI_MNT.equals("P")) {
                out.print("selected");
            }%> ><%=ApplicationConfigurator.LanguageManager.getString("POSITIVO")%></option>
                                                        <option value="N" <%if (strESI_ATI_MNT.equals("N")) {
                out.print("selected");
            }%> ><%=ApplicationConfigurator.LanguageManager.getString("NEGATIVO")%></option>
                                                    </select>
                                                </td>								 
                                            </tr>
                                            <tr>
                                                <td nowrap colspan="1"  align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;
                                                </td>
                                                <td colspan="5">
                                                    <textarea rows="3" cols="90" name="ATI_SVO" style="width:510;"><%=strATI_SVO%></textarea>
                                                </td>								 
                                            </tr>
                                            <tr>
                                                <td nowrap colspan="1" align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Problemi.attività")%>&nbsp;
                                                </td>
                                                <td colspan="5">
                                                    <textarea rows="3" cols="90" name="PBM_ATI_MNT" style="width:510;"><%=strPBM_ATI_MNT%></textarea>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset> 
                    </td> 
                </tr>
                <tr>
                    <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                </tr> 
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%
            //-------Loading of Tabs--------------------
            if (SchedaAttivitaSegnalazione != null) {
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
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Documenti")%>", tabbar));
            
            //------adding dinamic tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_SCH_ATI_MNT%>;
            tabbar.refreshTabUrl="SCH_ATI_MNT_Tabs.jsp";	
            tabbar.RefreshAllTabs();
            
            //----add action parameters to tabs
            tabbar.tabs[0].tabObj.actionParams =
            {
                "Feachures":ANA_DOC_Feachures,
                "AddNew":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_SCH_ATI_MNT/SCH_ATI_MNT_Attach.jsp&ATTACH_SUBJECT=DOC",
                    "buttonIndex":0
                },
                "Delete":	{"url":"../Form_SCH_ATI_MNT/SCH_ATI_MNT_Delete.jsp?LOCAL_MODE=DOC",
                    "buttonIndex":2, 
                    "target_element":document.all["ifrmWork"]
                },		
                "Edit":	{"url":"../Form_ANA_DOC/ANA_DOC_Form.jsp?ATTACH_URL=Form_SCH_ATI_MNT/SCH_ATI_MNT_Attach.jsp&ATTACH_SUBJECT=DOC",
                    "buttonIndex":1
                }
                
            }; 
            //-----activate first tab--------------------------
            tabbar.tabs[0].center.click();
            
        </script>
        <%} else {%>
        <script>
            window.dialogWidth="650px";
            window.dialogHeight="435px";
        </script>
        <%}%>
        
        
        <!-- /form for addind azienda -->
        
        
    </body>
</html>
