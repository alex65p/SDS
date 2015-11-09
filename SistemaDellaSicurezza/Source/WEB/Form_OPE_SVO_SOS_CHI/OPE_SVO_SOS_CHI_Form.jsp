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
<%@ page import="com.apconsulting.luna.ejb.RischioChimico.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="OPE_SVO_SOS_CHI_Util.jsp" %>

<html>
    <head><title><%=ApplicationConfigurator.LanguageManager.getString("Parametri.rischi.chimici")%></title></head>
    <link rel="stylesheet" href="../_styles/style.css">
    <script type="text/javascript">
        window.dialogWidth="400px";
        window.dialogHeight="300px";
    </script>
    <body style="margin:0 0 0 0;">
        <%
                    long lCOD_MAN = 0;
                    long lCOD_OPE_SVO = 0;
                    long lCOD_SOS_CHI = 0;
                    String sID = request.getParameter("ID");

                    Checker c = new Checker();
                    String[] asID = sID.split(",");
                    if (asID.length == 2) {
                        lCOD_OPE_SVO = c.checkLong("OperazioneSvolta", asID[0], true);
                        lCOD_SOS_CHI = c.checkLong("Sostanza", asID[1], true);
                    }
                    lCOD_MAN = c.checkLong("Attivita", request.getParameter("ID_PARENT"), true);

                    IRischioChimicoBean home = (IRischioChimicoBean) PseudoContext.lookup("RischioChimicoBean");
                    home.findByPrimaryKey(lCOD_MAN, lCOD_OPE_SVO, lCOD_SOS_CHI);
        %>

        <form name="frm" action="OPE_SVO_SOS_CHI_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <input name="SBM_MODE" type="hidden" value="<%if (lCOD_SOS_CHI != 0) {
                            out.print("edt");
                        } else {
                            out.print("new");
                        }%>">
            <input name="COD_MAN" type="hidden" value="<%=lCOD_MAN%>">
            <input name="COD_OPE_SVO" type="hidden" value="<%=lCOD_OPE_SVO%>">
            <input name="COD_SOS_CHI" type="hidden" value="<%=lCOD_SOS_CHI%>">
            <table border='0'  width='100%' style='height:150px;'>
                <tr>
                    <td align="center"  valign="top" >
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td align="center" class="title" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Parametri.rischio.chimico")%></td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="0">
                                        <!-- ############################################################################## -->
                                        <%@ include file="../_include/ToolBar.jsp" %>
                                        <%ToolBar.bShowNew = false;%>
                                        <%ToolBar.bShowSearch = false;%>
                                        <%ToolBar.bShowDelete = false;%>
                                        <%ToolBar.bShowPrint = false;%>
                                        <%ToolBar.bShowReturn = false;%>
                                        <%//ToolBar.bShowExit=false;%>
                                        <%=ToolBar.build(2)%>
                                        <!-- ############################################################################## -->
                                    </table>

                                    <fieldset style="padding:10px 10px 10px 10px;">
                                        <table   border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Quantità")%></td>
                                                <td>
                                                    <select tabindex="1" name="COD_QTA" style="width:200px">
                                                        <%=BuildQTAComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Esposizione.cutanea")%></td>
                                                <td>
                                                    <select tabindex="1" name="COD_CCP" style="width:200px">
                                                        <%=BuildCCPComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.d.uso")%></td>
                                                <td>
                                                    <select tabindex="2" name="COD_TIP" style="width:200px">
                                                        <%=BuildTIPComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.di.controllo")%></td>
                                                <td>
                                                    <select tabindex="3" name="COD_CTR" style="width:200px">
                                                        <%=BuildCTRComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Tempo.di.esposizione")%></td>
                                                <td>
                                                    <select tabindex="4" name="COD_TMP_ESP" style="width:200px">
                                                        <%=BuildTMPComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Distanza")%></td>
                                                <td>
                                                    <select tabindex="5" name="COD_DIS" style="width:200px">
                                                        <%=BuildDISComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Tipo.algoritmo")%></td>
                                                <td>
                                                    <select tabindex="6" name="COD_ALG" style="width:200px" onChange="ricaricaCBX();">
                                                        <%=BuildALGComboBox(home)%>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><%=ApplicationConfigurator.LanguageManager.getString("Indice.di.rischio")%></td>
                                                <td>
                                                    <input style="width:200px" readonly name="IDX_RSO_CHI" align="center" value="<%=home.getIDX_RSO_CHI() + " - " + home.getDescRischio(home.getIDX_RSO_CHI())%>"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <script type="text/javascript">
            ToolBar.Return.setEnabled(false);
	
            optsCTR = new Array();
            optsCTRB = new Array();
            optsQTA = new Array();
            optsQTAB = new Array();

            <%
                        {
                            int i = 0;
                            java.util.Collection col = home.getCTR_View(1);
                            java.util.Iterator it = col.iterator();
                            while (it.hasNext()) {
                                String str = "";
                                CTR_View obj = (CTR_View) it.next();
                                out.println("optsCTR[" + i + "] = new Array(\"" + obj.DES_CTR + "\", \"" + obj.COD_CTR + "\");");
                                i++;
                            }
                            i = 0;
                            col = home.getCTR_View(2);
                            it = col.iterator();
                            while (it.hasNext()) {
                                String str = "";
                                CTR_View obj = (CTR_View) it.next();
                                out.println("optsCTRB[" + i + "] = new Array(\"" + obj.DES_CTR + "\", \"" + obj.COD_CTR + "\");");
                                i++;
                            }
                            //
                            i = 0;
                            col = home.getQTA_View(1);
                            it = col.iterator();
                            while (it.hasNext()) {
                                String str = "";
                                QTA_View obj = (QTA_View) it.next();
                                out.println("optsQTA[" + i + "] = new Array(\"" + obj.DES_QTA + "\", \"" + obj.COD_QTA + "\");");
                                i++;
                            }
                            i = 0;
                            col = home.getQTA_View(2);
                            it = col.iterator();
                            while (it.hasNext()) {
                                String str = "";
                                QTA_View obj = (QTA_View) it.next();
                                out.println("optsQTAB[" + i + "] = new Array(\"" + obj.DES_QTA + "\", \"" + obj.COD_QTA + "\");");
                                i++;
                            }
                        }
            %>
                function ricaricaCBX(){
                    fCTR = new Array();
                    fQTA = new Array();
                    if(frm.COD_ALG.value==1)
                    {
                        fCTR = optsCTR;
                        fQTA = optsQTA;
                    }
                    else
                    {
                        fCTR = optsCTRB;
                        fQTA = optsQTAB;
                    }
                    frm.COD_CTR.options.length=0;
                    for(i=0; i<fCTR.length; i++)
                        frm.COD_CTR.options[i] = new Option(fCTR[i][0], fCTR[i][1], false, false);

                    frm.COD_QTA.options.length=0;
                    for(i=0; i<fQTA.length; i++)
                        frm.COD_QTA.options[i] = new Option(fQTA[i][0], fQTA[i][1], false, false);
                }
        </script>
    </body>
</html>
