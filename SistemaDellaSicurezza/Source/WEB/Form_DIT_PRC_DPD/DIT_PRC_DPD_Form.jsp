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
            <version number="1.0" date="19/01/2004" author="Khomenko Juliya">
            <comments>
            <comment date="19/01/2004" author="Khomenko Juliya">
            <description>Shablon formi DIT_PRC_DPD_Form.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>


<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="DIT_PRC_DPD_Util.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<html>
    <head>
        <title><%=ApplicationConfigurator.LanguageManager.getString("Ditte.precedenti")%></title>
        <LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
    </head>

    <script type="text/javascript">
        window.dialogWidth="730px";
        window.dialogHeight="570px";
    </script>
    <body>
        <%
                    long lCOD_DIT_PRC_DPD = 0;
                    String strDES_ATI_SVO_DIT_PRC = "";
                    String strRAG_SCL_DIT_PRC = "";
                    String strIDZ_DIT_PRC = "";
                    String strNUM_CIC_DIT_PRC = "";
                    String strCIT_DIT_PRC = "";
                    String strPRV_DIT_PRC = "";
                    String strCAP_DIT_PRC = "";
                    String strSTA_DIT_PRC = "";
                    String idParent=(request.getParameter("ID_PARENT")!=null?request.getParameter("ID_PARENT").toString():"0");
                    long lCOD_DPD = new Long(idParent).longValue();
                    long lCOD_AZL = Security.getAzienda();

                    IDipendentePrecedenti bean = null;
                    IDipendentePrecedentiHome home = (IDipendentePrecedentiHome) PseudoContext.lookup("DipendentePrecedentiBean");

                    if (request.getParameter("ID") != null) {
                        String strCOD_DIT_PRC_DPD = request.getParameter("ID");

                        Long cod_id = new Long(strCOD_DIT_PRC_DPD);
                        bean = home.findByPrimaryKey(cod_id);

                        //lCOD_PRG = cod_id.longValue();

                        lCOD_DIT_PRC_DPD = bean.getCOD_DIT_PRC_DPD();
                        strDES_ATI_SVO_DIT_PRC = Formatter.format(bean.getDES_ATI_SVO_DIT_PRC());
                        strRAG_SCL_DIT_PRC = bean.getRAG_SCL_DIT_PRC();
                        strIDZ_DIT_PRC = bean.getIDZ_DIT_PRC();
                        strNUM_CIC_DIT_PRC = bean.getNUM_CIC_DIT_PRC();
                        strCIT_DIT_PRC = bean.getCIT_DIT_PRC();
                        strPRV_DIT_PRC = bean.getPRV_DIT_PRC();
                        strCAP_DIT_PRC = bean.getCAP_DIT_PRC();
                        strSTA_DIT_PRC = bean.getSTA_DIT_PRC();
                        lCOD_DPD = bean.getCOD_DPD();
                        lCOD_AZL = bean.getCOD_AZL();/**/
                    }

        %>

        <!-- form for addind  corbean-->
        <form action="DIT_PRC_DPD_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_DIT_PRC_DPD == 0) ? "new" : "edt"%>">
            <input type="hidden" name="COD_DIT_PRC_DPD" value="<%=lCOD_DIT_PRC_DPD%>">
            <input type="hidden" name="COD_DPD" value="<%=lCOD_DPD%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">
            <table width="100%" border="0">
                <!-- ############################ -->
                <tr>
                    <td valign="top">
                        <table  width="100%">
                            <tr>
                                <td class="title"><%=ApplicationConfigurator.LanguageManager.getString("Ditte.precedenti")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="100%">
                                        <%
                                                    ToolBar.bCanDelete = (bean != null);
                                        %>
                                        <%=ToolBar.build(2)%>
                                        <!-- ########################### -->

                                    </table>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Ditta.precedente")%></legend>
                                        <table  width="100%" border="0">
                                            <tr>
                                                <td align="right" width="15%" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;</td>
                                                <td colspan="3">
                                                    <textarea rows="5" cols="110" name="DES_ATI_SVO_DIT_PRC"><%=strDES_ATI_SVO_DIT_PRC%></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" ><b><%=ApplicationConfigurator.LanguageManager.getString("Ragione.sociale")%>&nbsp;</b> </td>
                                                <td colspan="3">
                                                    <input type="text" size="118" maxlength="50"  name="RAG_SCL_DIT_PRC" value="<%=Formatter.format(strRAG_SCL_DIT_PRC)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</td>
                                                <td>
                                                    <input type="text" size="50" maxlength="50"  name="IDZ_DIT_PRC" value="<%=Formatter.format(strIDZ_DIT_PRC)%>">
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>
                                                </td>
                                                <td>
                                                    <input type="text" size="10" maxlength="30"  name="NUM_CIC_DIT_PRC" value="<%=Formatter.format(strNUM_CIC_DIT_PRC)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
                                                <td>
                                                    <input type="text" size="15" maxlength="15"  name="CAP_DIT_PRC" value="<%=Formatter.format(strCAP_DIT_PRC)%>">
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp;
                                                </td>
                                                <td>
                                                    <input type="text" size="30" maxlength="30"  name="CIT_DIT_PRC" value="<%=Formatter.format(strCIT_DIT_PRC)%>">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;
                                                </td>
                                                <td>
                                                    <input type="text" size="2" maxlength="2"  name="PRV_DIT_PRC" value="<%=Formatter.format(strPRV_DIT_PRC)%>">
                                                </td>
                                                <td align="right">
                                                    <%=ApplicationConfigurator.LanguageManager.getString("Stato")%>&nbsp;
                                                </td>
                                                <td>
                                                    <select name="STA_DIT_PRC" style="width:180px;">
                                                        <option value=''></option>
                                                        <%
                                                                    INazionalitaHome n_home = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
                                                                    //if(strSTA_DIT_PRC.equals("")){strSTA_DIT_PRC="0";}
                                                                    long COD_LNG = Localization.getCurrentLanguageCode();
                                                                    String n_cb = BuildNazionalitaComboBox(n_home, strSTA_DIT_PRC, COD_LNG);
                                                                    out.print(n_cb);
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td></tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <!-- /form for addind  corbean-->
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%if (bean == null) {%>
        <script type="text/javascript">
            window.dialogHeight="330px";
        </script>
        <%return;
                    }%>
        <script type="text/javascript" src="../_scripts/index.js"></script>
        <script type="text/javascript">

            //--------BUTTONS description-----------------------
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
            tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Attività.lavorative.precedenti")%>", tabbar));
            //------adding tables to tabs-----------------------
            tabbar.idParentRecord = <%= lCOD_DIT_PRC_DPD%>;
            tabbar.refreshTabUrl="DIT_PRC_DPD_Tabs.jsp";
            tabbar.RefreshAllTabs();
            //----add action parameters to tabs

            tabbar.tabs[0].tabObj.actionParams ={
                "Feachures":MAN_DIT_PRC_Feachures,
                "AddNew":	{"url":"../Form_MAN_DIT_PRC/MAN_DIT_PRC_Form.jsp?COD_DPD=<%=lCOD_DPD%>",
                    "buttonIndex":0
                },
                "Edit":	{"url":"../Form_MAN_DIT_PRC/MAN_DIT_PRC_Form.jsp?COD_DPD=<%=lCOD_DPD%>",
                    "buttonIndex":1
                },
                "Delete":	{"url":"../Form_DIT_PRC_DPD/DIT_PRC_DPD_Delete.jsp?LOCAL_MODE=md",
                    "buttonIndex":2,
                    "target_element":document.all["ifrmWork"]
                }
            };
            //------------------------------------------------
        </script>


    </body>
</html>
