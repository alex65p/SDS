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
    <description>Shablon formi ANA_ATI_MNT_MAC_Form.jsp</description>
    </comment>
    <comment date="25/01/2004" author="Podmasteriev Alexandr">
    <description>Dodelal vse ostalnoe</description>
    </comment>		
    <comment date="17/02/2004" author="Khomenko Juliya">
    <description>Create dinamic tab</description>
    </comment>		
    <comment date="16/02/2004" author="Alex Kyba">
    <description>
    Cod, ogranichivayuschiy vybor Descrizione Macchine/Attrezzature
    </description>
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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivaManutenzione.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="ANA_ATI_MNT_MAC_Util.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%
    long lCOD_MNT_MAC = 0;
    //*require Fields*
    String strDES_ATI_MNT_MAC = "";
    long COD_MAC = 0;
    String strCOD_MNT_MAC = "";
    //* no require Fields*
    String strATI_MNT_PER = "N";
    long iPER_ATI_MNT_MES = 0;
    String DAT_PAR_MNT_MAC = "";
    boolean isCOD_MAC = false;
    String strCOD_MAC = "";
    IAttivaManutenzione AttivaManutenzione = null;
//-------------------------------------------------------------
//------- proveriaem, esli forma byla vyzvana iz ANA_DOC ------
    if (request.getParameter("ATTACH_SUBJECT") != null) {
        String strAttSubj = request.getParameter("ATTACH_SUBJECT");
        if (strAttSubj.equals("ATT_MNT")) {
            strCOD_MAC = request.getParameter("ID_PARENT");
            isCOD_MAC = true;
        }
    }
//----------------------------------------------------------

    if (request.getParameter("ID") != null) {
        strCOD_MNT_MAC = request.getParameter("ID");
        // editing of AttivaManutenzione
        //getting of AttivaManutenzione object
        IAttivaManutenzioneHome home = (IAttivaManutenzioneHome) PseudoContext.lookup("AttivaManutenzioneBean");
        Long man_id = new Long(strCOD_MNT_MAC);
        lCOD_MNT_MAC = man_id.longValue();
        AttivaManutenzione = home.findByPrimaryKey(man_id);
        // getting of object variables
        iPER_ATI_MNT_MES = AttivaManutenzione.getPER_ATI_MNT_MES();
        COD_MAC = AttivaManutenzione.getCOD_MAC();
        strATI_MNT_PER = AttivaManutenzione.getATI_MNT_PER();
        strDES_ATI_MNT_MAC = AttivaManutenzione.getDES_ATI_MNT_MAC();
        DAT_PAR_MNT_MAC = Formatter.format(AttivaManutenzione.getDAT_PAR_MNT_MAC());
        if (strATI_MNT_PER == null) {
            strATI_MNT_PER = "";
        }
    }%>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuMacchinari,2) + "</title>");
        </script>
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

        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script language="JavaScript" src="../_scripts/tabs.js"></script>
        <script language="JavaScript" src="../_scripts/tabbarButtonFunctions.js"></script>

    </head>
    <script>
        window.dialogWidth="700px";
        window.dialogHeight="530px";
    </script>

    <body>

        <!-- form for addind  AttivaManutenzione--> 
        <form action="ANA_ATI_MNT_MAC_Set.jsp" id="frm1"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_MNT_MAC == "") ? "new" : "edt"%>">
            <input type="hidden" name="COD_MNT_MAC" value="<%=strCOD_MNT_MAC%>">
            <table width="100%" border="0">
                <!-- posizione precedente della toolbar -->

                <tr>

                    <td valign="top">
                        <table border="0" width="100%">
                            <tr><td class="title">
                                    <script>
        document.write(getCompleteMenuPathFunction
        (SubMenuMacchinari,2,<%=request.getParameter("ID")%>));
                                    </script>
                                </td></tr>
                            <tr><td>
                                    <table  width="100%" border="0">
                                        <tr>
                                            <!--inserimento toolbar -->
                                            <td colspan="9" align="left" > 
                                                <table width="100%" border="0">
                                                    <tr> 
                                                        <!-- toolbar --> 
                                                        <!-- ############################ -->
                                                        <%@ include file="../_include/ToolBar.jsp" %>
                                                        <%ToolBar.bCanDelete = (AttivaManutenzione != null);
                                                            if (isCOD_MAC) {
                                                                ToolBar.strSearchUrl = ToolBar.strSearchUrl.replace('&', '|');
                                                            }
                                                            ToolBar.bShowReturn = (request.getParameter("ID_PARENT") != null);
                                                            ToolBar.bCanReturn = true;
                                                            ToolBar.bShowSearch = true;
                                                            ToolBar.bCanSearch = true;
                                                        %>	
                                                        <%=ToolBar.build(3)%> 
                                                        <!-- ########################### -->
                                                    </tr> </table>
                                                <fieldset>
                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.attività.di.manutenzione")%></legend>
                                                    <table cellspacing="4">


                                                        <tr>
                                                            <!--fine  inserimento -->

                                                            <td colspan="100">
                                                                <fieldset>
                                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString(
                                                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                                                            ?"Dati.macchina.attrezzatura.impianto"
                                                                            :"Dati.macchina/attrezzatura"
                                                                    )%></legend>
                                                                    <table  width="100%" border="0">
                                                                        <tr>
                                                                            <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                                                                            <td>
                                                                                <select  tabindex="1" name="COD_MAC" style="width:100%;">
                                                                                    <option value=''></option>
                                                                                    <%
                                                                                        IMacchinaHome d_home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
                                                                                        // -- esli forma vyzvana iz ANA_MAC vybiraem dannye o sootvetstvuyuschey mashine ---
                                                                                        if (isCOD_MAC) {
                                                                                            IMacchina macchina = d_home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), Long.parseLong(strCOD_MAC)));
                                                                                            out.println("<option selected value='" + macchina.getCOD_MAC() + "'>" + macchina.getDES_MAC() + "</option>");
                                                                                        } // -- esli forma vyzvanna iz menu - vybiraem dannye o vseh mashinah ---
                                                                                        else {
                                                                                            out.print(BuildMacchinaComboBox(d_home, COD_MAC));
                                                                                        }
                                                                                    %>
                                                                                </select>
                                                                            </td></tr>
                                                                    </table>
                                                                </fieldset>
                                                            </td></tr>
                                                        <tr><td colspan="100" >
                                                                <fieldset>
                                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.attività.di.manutenzione")%></legend>
                                                                    <table  width="100%" border="0">
                                                                        <tr align="left"> 
                                                                            <td width="22%" align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Attività.periodica")%>&nbsp;</td>
                                                                            <td width="17%" align="left">
                                                                                <input tabindex="2" type="checkbox" value="S" class="checkbox" name="ATI_MNT_PER" <%=(strATI_MNT_PER.equals("S")) ? "checked" : " "%>></td>
                                                                            <td width="17%" align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.mensile")%>&nbsp;</td>
                                                                            <td width="17%" align="left"> 
                                                                                <input tabindex="3" size="6" type="text" maxlength="17" name="PER_ATI_MNT_MES" value="<%=iPER_ATI_MNT_MES%>"></td>
                                                                            <td width="17%" align="right" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Data.di.partenza")%>&nbsp;</td>
                                                                            <td width="17%" align="left"> 
                                                                                <s2s:Date tabindex="4" id="DAT_PAR_MNT_MAC" name="DAT_PAR_MNT_MAC" value="<%=DAT_PAR_MNT_MAC%>"/></td>
                                                                        </tr>
                                                                    </table>	 
                                                                </fieldset>
                                                            </td></tr>
                                                        <tr>
                                                            <td align="right" width="20%"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione.attività")%>&nbsp;</b></td>
                                                            <td ><input tabindex="5" style="width:100%;" type="text" maxlength="150" name="DES_ATI_MNT_MAC" value="<%=strDES_ATI_MNT_MAC%>">
                                                            </td></tr>
                                                    </table>
                                                </fieldset>
                                            </td></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="100%"><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr> 
                        </table>
                        </form>
                        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"  ></iframe>
                        <%
                        //-------Loading of Tabs--------------------
                            if (AttivaManutenzione != null) {
                        // -----------------------------------------
                        %>
                        <script language="JavaScript" src="../_scripts/index.js"></script>
                        <script language="JavaScript">
                            //--------BUTTONS description-----------------------
                            btnParams = new Array();
                            btnParams[0] = {"id":"btnNew", 
                                "onclick":addRow,
                                "action":"AddNew"
                            };
                            btnParams[2] = {"id":"btnCancel", 
                                "onclick":delRow,
                                "action":"Delete"
                            };
                            btnParams[1] = {"id":"btnEdit", 
                                "onclick":editRow,
                                "action":"Edit"
                            };
					
                            //--------creating tabs--------------------------
                            var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
                            var btnBar = new ButtonPanel("batPanel1", btnParams);
    tabbar.addButtonBar(btnBar);                        
                            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Schede.attività.di.segnalazione")%>", tabbar));
    //------adding dinamic tables to tabs-----------------------                        
                            tabbar.idParentRecord = <%= lCOD_MNT_MAC%>;
                            tabbar.refreshTabUrl="ANA_ATI_MNT_MAC_Tabs.jsp";	
                            tabbar.RefreshAllTabs();
                            //----add action parameters to tabs
                            tabbar.tabs[0].tabObj.actionParams ={
                                "Feachures":SCH_ATI_MNT_Feachures,
                                "AddNew":	{"url":"../Form_SCH_ATI_MNT/SCH_ATI_MNT_Form.jsp?ATTACH_URL=Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Attach.jsp",
                                    "buttonIndex":0
                                },
                                "Delete":	
                                    {"url":"../Form_SCH_ATI_MNT/SCH_ATI_MNT_Delete.jsp?LOCAL_MODE=MAC",
                                    "buttonIndex":2,
                                    "target_element":document.all["ifrmWork"]
                                },		
                                "Edit":	{"url":"../Form_SCH_ATI_MNT/SCH_ATI_MNT_Form.jsp?ATTACH_URL=Form_ANA_ATI_MNT_MAC/ANA_ATI_MNT_MAC_Attach.jsp",
                                    "buttonIndex":1
                                }
                            }; 
                            tabbar.tabs[0].center.click();	
                        </script>
                        <%} else {%>
                        <script>
                            window.dialogWidth="700px";
                            window.dialogHeight="300px";
                        </script>
                        <%}%>
                        <%
                        //---------esli forma vyzvanna iz ANA_MAC, pereopredeliaem obrabotchik knopki Return
                            if (isCOD_MAC) {
                        %>
                        <script>
                            function saveChanges(){
                                document.all["frm1"].action=document.all["frm1"].action+"?returnData=1"
                                document.all["frm1"].submit();
                                window.close();
                            }
                            btnObj=ToolBar.Return.getButton();
                            btnObj.onclick=saveChanges;
                        </script>
                        <%            }
                        %>
                        <!-- /form for addind  AttivaManutenzione-->
                        </body>
                        </html> 

