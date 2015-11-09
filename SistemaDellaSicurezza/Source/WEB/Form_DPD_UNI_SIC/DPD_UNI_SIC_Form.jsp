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
            <version number="1.0" date="24/02/2004" author="Alexey Kolesnik">
            <comments>
            <comment date="24/02/2004" author="Alexey Kolesnik">
            <description>Shablon formi DPD_UNI_SIC_Form.jsp</description>
            </comment>		
            <comment date="24/02/2004" author="Alexey Kolesnik">
            <description>Forma DPD_UNI_SIC_Form.jsp</description>
            </comment>		
            </comments> 
            </version>
            </versions>
            </file> 
             */
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>
<%@ page import="com.apconsulting.luna.ejb.RuoliSicurezza.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="./DPD_UNI_SIC_Util.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>

<%
    boolean uni_sic_4_dip =
            ApplicationConfigurator.isModuleEnabled(MODULES.UNI_SIC_4_DIP);
%>
<html>
    <head>
        <title><%=uni_sic_4_dip==true?
                    ApplicationConfigurator.LanguageManager.getString("Associazione.lavoratori.unita.sicurezza"):
                    ApplicationConfigurator.LanguageManager.getString("Associativa.unità.organizzative/sicurezza")%></title>
        <link rel="stylesheet" href="../_styles/tabs.css">
        <script type="text/javascript" src="../_scripts/tabs.js"></script>
        <script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
        <LINK REL=STYLESHEET TYPE="text/css" HREF="../_styles/style.css" >
    </head>
    <script type="text/javascript">
        window.dialogWidth="550px";
        window.dialogHeight="300px";
    </script>
    <body>

        <%
            long lCOD_UNI_SIC = 0;
            long lCOD_DPD = 0;
            long lCOD_AZL = Security.getAzienda();
            long lCOD_UNI_ORG = 0;
            long lCOD_RUO_SIC = 0;

            String strNOM_DPD = "";
            String strMTR_DPD = "";
            String strCOG_DPD = "";

            IUnitaSicurezza bean = null;
            IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");

            IUnitaOrganizzativa uoBean = null;
            IUnitaOrganizzativaHome uoHome = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");

            IRuoliSicurezzaHome rsHome = (IRuoliSicurezzaHome) PseudoContext.lookup("RuoliSicurezzaBean");

            if (request.getParameter("ID_PARENT") != null) {
                lCOD_UNI_SIC = new Long(request.getParameter("ID_PARENT"));

                if (request.getParameter("ID") != null && request.getParameter("ID2") != null) {
                    bean = home.findByPrimaryKey(new Long(lCOD_UNI_SIC));
                    lCOD_DPD = new Long(request.getParameter("ID")).longValue();

                    AssociativaView w = null;
                    if (uni_sic_4_dip){
                        lCOD_RUO_SIC = new Long(request.getParameter("ID2"));
                        w = bean.getDIP(lCOD_RUO_SIC, lCOD_DPD);
                    } else {
                        lCOD_UNI_ORG = new Long(request.getParameter("ID2"));
                        w = bean.getUO(lCOD_UNI_ORG, lCOD_DPD);
                    }
                    strNOM_DPD = w.strNOM_DPD;
                    strMTR_DPD = w.strMTR_DPD;
                    strCOG_DPD = w.strCOG_DPD;
                }
            }
        %>
        <form action="DPD_UNI_SIC_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;" >
            <input name="SBM_MODE" type="Hidden" value="<%=(lCOD_UNI_ORG == 0 && lCOD_RUO_SIC == 0) ? "new" : "edt"%>">
            <input name="COD_UNI_SIC" type="Hidden" value="<%=lCOD_UNI_SIC%>">
            <input name="COD_AZL" type="Hidden" value="<%=lCOD_AZL%>">
            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="title" colspan="100%" style="height:10px">
                        <%=uni_sic_4_dip==true?
                            ApplicationConfigurator.LanguageManager.getString("Associazione.lavoratori.unita.sicurezza"):
                            ApplicationConfigurator.LanguageManager.getString("Associativa.unità.organizzative/sicurezza")%>
                    </td>
                </tr>
                <tr valign=top>
                    <td  valign="top">
                        <table>
                            <tr>
                                <td>
                            <%@ include file="../_include/ToolBar.jsp" %>
                            <%
            ToolBar.bShowSearch = false;
            ToolBar.bShowPrint = false;
            ToolBar.bShowDelete = false;
            ToolBar.bShowReturn = false;
            ToolBar.bCanReturn = true;
                            %>
                            <%=ToolBar.build(3)%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%">
                            <tr><td>
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.associazione")%></legend>
                                        <table style="width:100%" >
                                            <tr>
                                                <td rowspan="100%">&nbsp;&nbsp;&nbsp;</td>
                                                <td id="RESP">
                                                    <br>
                                                    <Fieldset>
                                                        <legend><%=uni_sic_4_dip==true?
                                                            ApplicationConfigurator.LanguageManager.getString("Lavoratore"):
                                                            ApplicationConfigurator.LanguageManager.getString("Responsabile")%></legend>
                                                        <table width="100%" cellpadding="0" cellspacing="2" border="0">
                                                            <tr>
                                                                <td rowspan="100%">&nbsp;&nbsp;</td>
                                                                <td align="right" ><strong><%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</strong></td>
                                                                <td width="100%">
                                                                    <input type="text" size="15" maxlength="20" readonly  name="MTR_DPD" value="<%= Formatter.format(strMTR_DPD)%>">
                                                                </td>
                                                                <td rowspan="100%">&nbsp;&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</strong></td>
                                                                <td  nowrap>
                                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td width="100%"><input type="text" readonly style="width:100%" maxlength="20"  name="COG_DPD" value="<%= Formatter.format(strCOG_DPD)%>"></td>
                                                                            <td><button class="getlist" onclick="getDipenedentiList()" id="btnGetDipendenti">
                                                                                    <strong>&middot;&middot;&middot;</strong>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</strong></td>
                                                                <td>
                                                                    <table width="100%" cellpadding="0" border="0" cellspacing="0">
                                                                        <tr>
                                                                            <td width="100%">
                                                                                <input type="hidden" size="20" maxlength="20"  name="COD_DPD" value="<%=Formatter.format(lCOD_DPD)%>">
                                                                                <input type="text" readonly style="width:100%" maxlength="20"  name="NOM_DPD" value="<%= Formatter.format(strNOM_DPD)%>">
                                                                            </td>
                                                                            <td><button class="getlist" style="visibility:hidden" >
                                                                                    <strong>&middot;&middot;&middot;</strong>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </Fieldset>
                                                </td>
                                                <td rowspan="100%">&nbsp;&nbsp;&nbsp;</td>
                                            </tr>
                                            <tr style="display:<%=uni_sic_4_dip==true?"none":"yes"%>">
                                                <td>
                                                    <br>
                                                    <Fieldset>
                                                        <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa")%></b></legend>
                                                        <table border="0" cellpadding="2" cellspacing="3" width="100%">
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td width="100%">
                                                                    <select name="COD_UNI_ORG" style="width:100%">
                                                                        <option value="">  </option>
                                                                        <%
                                                                         String nodes = uoHome.buildTreeNodes(uoBean, uoHome, 0, lCOD_UNI_ORG,lCOD_AZL,false);
                                                                         out.println(nodes);
                                                                        %>
                                                                    </select>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </Fieldset>
                                                </td>
                                            </tr>
                                            <tr style="display:<%=uni_sic_4_dip==true?"yes":"none"%>">
                                                <td>
                                                    <br>
                                                    <Fieldset>
                                                        <legend><b><%=ApplicationConfigurator.LanguageManager.getString("Ruoli.sicurezza")%></b></legend>
                                                        <table border="0" cellpadding="2" cellspacing="3" width="100%">
                                                            <tr>
                                                                <td>&nbsp;</td>
                                                                <td width="100%">
                                                                    <select name="COD_RUO_SIC" style="width:100%">
                                                                        <option value="">  </option>
                                                                        <%
                out.print(BuildRuoliSicurezzaComboBox(rsHome, lCOD_RUO_SIC));
                                                                        %>
                                                                    </select>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </Fieldset>
                                                </td>
                                            </tr>
                                        </table>
                                        <BR>
                                    </fieldset>
                                </td></tr>
                        </table>
                    </td>
                </tr>
            </table>
    </form>
    <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" id="ifrmWork"></iframe>
    <script type="text/javascript">
        var ifrmWork = document.all["ifrmWork"];
        function getDipenedentiList(){
            var obj=new Object();
            var url="Form_ANA_DPD/ANA_DPD_View.jsp";
            if(showSearch(url, obj, "dialogHeight:30; dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
                ifrmWork.src="DPD_UNI_SIC_Responsabile.jsp?ID="+obj.ID;
            }
        }
    </script>
</body>
</html>
