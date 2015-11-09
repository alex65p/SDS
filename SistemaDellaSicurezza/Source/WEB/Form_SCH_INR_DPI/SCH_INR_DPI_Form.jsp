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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="SCH_INR_DPI_Util.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<html>
    <head>
        <script language="JavaScript" type="text/javascript" src="SCH_INR_DPI_Script.js"></script>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuDPI,2) + "</title>");
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
        
        <LINK REL=STYLESHEET
              HREF="../_styles/style.css"
              TYPE="text/css">
        
    </head>
    <script>
        window.dialogWidth="890px";
        window.dialogHeight="530px";
    </script>
    <body>
        <%
            long lCOD_AZL = Security.getAzienda();
            String strCOD_SCH_INR_DPI = ""; //1
            long lCOD_LOT_DPI = 0;     	//2
            long lCOD_TPL_DPI = 0;     	//3
            String strTPL_INR_DPI = "";  	//4
            String strATI_INR = "";      	//5
            String strDAT_PIF_INR = "";  	//6
//-------------------------------------------------
            String strDAT_INR = "";   		//7
            String strESI_INR = "";   		//8
            String strPBM_RSC = "";
            String strNOM_RSP_INR = "";		//9
//-------------------------------------------------
            String strRAG_SOC_FOR_AZL = "";	//10
            String strDAT_CSG_LOT = "";
            long strQTA_FRT = 0;
            long strQTA_AST = 0;
            long strQTA_DSP = 0;
            String MChecked = "";
            String SChecked = "";
            String PSel = "";
            String NSel = "";
            String strNOM_TPL_DPI = "tipologia DPI";
            String strDisIdent = "";
//--- mary for tab
            String strID_PARENT = ""; // ANA_LOT_DPI_TAB.COD_LOT_DPI
            strID_PARENT = request.getParameter("ID_PARENT"); // ANA_LOT_DPI_TAB.COD_LOT_DPI
            if (strID_PARENT != null) {
                lCOD_LOT_DPI = new Long(strID_PARENT).longValue();
                strDisIdent = "disabled";
            }
            ILottiDPIHome LottiDPIHome = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");
            ILottiDPI LottiDPI;

            ITipologiaDPIHome TipologiaDPIHome = (ITipologiaDPIHome) PseudoContext.lookup("TipologiaDPIBean");
            ITipologiaDPI TipologiaDPI;

            IFornitoreHome FornitoreHome = (IFornitoreHome) PseudoContext.lookup("FornitoreBean");
            IFornitore Fornitore;

            IDipendenteHome DipendenteHome = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            IDipendente Dipendente;

            ISchedeInterventoDPI SchedeInterventoDPI = null;
            if (request.getParameter("ID") != null) {
                strCOD_SCH_INR_DPI = request.getParameter("ID");
                // editing of ala
                //getting of ala object
                ISchedeInterventoDPIHome home = (ISchedeInterventoDPIHome) PseudoContext.lookup("SchedeInterventoDPIBean");
                Long COD_SCH_INR_DPI = new Long(strCOD_SCH_INR_DPI);
                SchedeInterventoDPI = home.findByPrimaryKey(COD_SCH_INR_DPI);
                // getting of object variables
                lCOD_LOT_DPI = SchedeInterventoDPI.getCOD_LOT_DPI();
                //lCOD_TPL_DPI=SchedeInterventoDPI.getCOD_TPL_DPI();
                strTPL_INR_DPI = SchedeInterventoDPI.getTPL_INR_DPI();
                strATI_INR = SchedeInterventoDPI.getATI_INR();
                strDAT_PIF_INR = Formatter.format(SchedeInterventoDPI.getDAT_PIF_INR());
                //-----------------------------
                strDAT_INR = Formatter.format(SchedeInterventoDPI.getDAT_INR());
                strESI_INR = SchedeInterventoDPI.getESI_INR();
                strPBM_RSC = SchedeInterventoDPI.getPBM_RSC();
                strNOM_RSP_INR = SchedeInterventoDPI.getNOM_RSP_INR();
            }
            if (lCOD_LOT_DPI != 0) {
                Long LottiDPI_id = new Long(lCOD_LOT_DPI);
                LottiDPI = LottiDPIHome.findByPrimaryKey(LottiDPI_id);
                lCOD_TPL_DPI = LottiDPI.getCOD_TPL_DPI();
                Long Fornitore_id = new Long(LottiDPI.getCOD_FOR_AZL());
                Fornitore = FornitoreHome.findByPrimaryKey(Fornitore_id);
                strRAG_SOC_FOR_AZL = Fornitore.getRAG_SOC_FOR_AZL();
                strDAT_CSG_LOT = Formatter.format(LottiDPI.getDAT_CSG_LOT());
                strQTA_FRT = LottiDPI.getQTA_FRT();
                strQTA_AST = LottiDPI.getQTA_AST();
                strQTA_DSP = LottiDPI.getQTA_DSP();
                Long TipologiaDPI_id = new Long(lCOD_TPL_DPI);
                TipologiaDPI = TipologiaDPIHome.findByPrimaryKey(TipologiaDPI_id);
                strNOM_TPL_DPI = TipologiaDPI.getNOM_TPL_DPI();/**/
            }
        %>
        
        <!-- form for addind  -->
        <form action="SCH_INR_DPI_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table width="100%" border="0">
                
                <tr>
                    <td width="10" height="100%" valign="top">
                        <!-- <button type="button" class="menu" >&nbsp;1&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;2&nbsp;</button>
 <button type="button" class="menu">&nbsp;3&nbsp;</button><br>
 <button type="button" class="menu">&nbsp;4&nbsp;</button>
 <button type="button" class="menu">&nbsp;5&nbsp;</button><br>
 -->

                    </td>
                    <td valign="top">
                        <table  width="100%" border="0">
                            <tr><td class="title">
                                    <script>
                                        document.write(getCompleteMenuPathFunction
                                            (SubMenuDPI,2,<%=request.getParameter("ID")%>));
                                    </script>
                            </td></tr>
                            
                            <input name="SBM_MODE" type="hidden" value="<%if (strCOD_SCH_INR_DPI == "") {
                out.print("new");
            } else {
                out.print("edt");
            }%>">
                            <input name="COD_SCH_INR_DPI" type="hidden" value="<%=strCOD_SCH_INR_DPI%>">
                            <input name="COD_TPL_DPI" id="COD_TPL_DPI" type="Hidden" value="<%=lCOD_TPL_DPI%>">
                            <input name="NOM_TPL_DPI" id="NOM_TPL_DPI" type="hidden" value="<%=strNOM_TPL_DPI%>">
                            <tr>
                                <td>
                                <table>
                                    <tr>
                                        <td>
                                            <!-- ############################ -->
                                 <%@ include file="../_include/ToolBar.jsp" %>
                                 <%
            ToolBar.bCanDelete = (SchedeInterventoDPI != null);
            ToolBar.strPrintUrl = "SchedaInterventoDPI.jsp?";

            if (strID_PARENT != null) {
                ToolBar.bShowSearch = false;
                ToolBar.bCanDelete = (SchedeInterventoDPI != null);
                ToolBar.bShowNew = true;
                ToolBar.bShowExit = true;
            }
                                 %>		
                                 <%=ToolBar.build(2)%>
                                            <!-- ########################### -->
                                        </td>
                                    </tr>
                                </table>
                            </tr>
                            <tr>	
                                <td width="100%">
                                    <fieldset>
                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.scheda.d'intervento")%></legend>
                                        <table width="100%" border="0"><tr width="100%"><td width="100%">
                                                    <fieldset>
                                                        <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.lotto")%></legend>
                                                        <table border="0" width="100%">
                                                            <tr>
                                                                <td align="right" valign="top" width="20%"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Identificativo")%>&nbsp;</b></div></td>
                                                                <td valign="top" ><!-- <input type="text" value="<%=lCOD_LOT_DPI%>"> -->
                                                                    <select <%=strDisIdent%> name="COD_LOT_DPI" style="width:605px" id="COD_LOT_DPI" onchange="changeFields();">
                                                                        <option value="0"></option>
                                                                        <%
            String LottiDPI_cb = BuildIdentLotComboBox(LottiDPIHome, lCOD_LOT_DPI, lCOD_AZL);
            out.print(LottiDPI_cb);%>
                                                                </select></td>
                                                            </tr>
                                                            <%if (strDisIdent.equals("disabled")) {%>
                                                            <input type="hidden" value="<%=lCOD_LOT_DPI%>" name="COD_LOT_DPI">
                                                            <%}%>
                                                            <tr>
                                                                <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fornitore")%>&nbsp;</div></td>
                                                                <td width="120" valign="top" align="left"><input readonly size="117" type="text" name="RAG_SOC_FOR_AZL" value="<%=strRAG_SOC_FOR_AZL%>"></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <table border="0" width="100%">
                                                                        <tr>
                                                                            <td align="right" valign="bottom" width="20%">
                                                                            <div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.consegna")%>&nbsp;</div></td>
                                                                            <td valign="bottom" width="12%">
                                                                            <s2s:Date readonly="True" id="DAT_CSG_LOT" name="DAT_CSG_LOT" value="<%=strDAT_CSG_LOT%>"/></td>
                                                                                <!--<input readonly size="10" type="text" name="DAT_CSG_LOT" id="DAT_CSG_LOT" value="<%=strDAT_CSG_LOT%>"></td>-->
                                                                            <td>
                                                                                <fieldset>
                                                                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Quantità.in.pezzi")%></legend>
                                                                                    <table border="0" width="100%">
                                                                                        <tr>
                                                                                            <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fornita")%>&nbsp;</div></td>
                                                                                            <td valign="top"><input readonly size="10" type="text" name="QTA_FRT" id="QTA_FRT" value="<%=strQTA_FRT%>"></td>
                                                                                            <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Assegnata")%>&nbsp;</div></td>
                                                                                            <td valign="top"><input readonly size="10" type="text" name="QTA_AST" id="QTA_AST" value="<%=strQTA_AST%>"></td>
                                                                                            <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Disponibile")%>&nbsp;</div></td>
                                                                                            <td valign="top" align="left" width="23%"><input readonly size="10" type="text" name="QTA_DSP" id="QTA_DSP" value="<%=strQTA_DSP%>"></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </fieldset>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>		 							
                                                    </fieldset>
                                        </td></tr></table>
                                        <table  width="100%" border="0">
                                            <%
            if ((strTPL_INR_DPI != null) && (strTPL_INR_DPI.equals("M"))) {
                MChecked = "checked";
            }
            if ((strTPL_INR_DPI != null) && (strTPL_INR_DPI.equals("S"))) {
                SChecked = "checked";
            }
            if ((strESI_INR != null) && (strESI_INR.equals("P"))) {
                PSel = "selected";
            }
            if ((strESI_INR != null) && (strESI_INR.equals("N"))) {
                NSel = "selected";
            }
                                            %>
                                            <tr>
                                                <td width="20%" valign="top" align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia.d'intervento")%>&nbsp;</b></div></td>
                                                <td valign="top" align="left" colspan="2"><input class="checkbox" type="radio" name="TPL_INR_DPI" id="TPL_INR_DPI" value="M" <%=MChecked%>>
                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Manutenzione")%>&nbsp;&nbsp;<input class="checkbox" type="radio" name="TPL_INR_DPI" id="TPL_INR_DPI" value="S" <%=SChecked%>>
                                                &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Sostituzione")%></td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Data.pianificata")%>&nbsp;</b></div></td>
                                                <td valign="top"><s2s:Date name="DAT_PIF_INR" id="DAT_PIF_INR" value="<%=strDAT_PIF_INR%>"/></td>                                             
                                                <td valign="top" align="right"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Data.intervento")%>&nbsp;</div></td>
                                                <td valign="top"><s2s:Date  name="DAT_INR" id="DAT_INR" value="<%=strDAT_INR%>"/></td>                                            
                                                <td valign="top" align="right"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Esito")%>&nbsp;</div></td>
                                                <td valign="top" width="16%"><select name="ESI_INR" id="ESI_INR">
                                                        <option value=""></option>
                                                        <option value="P" <%=PSel%>><%=ApplicationConfigurator.LanguageManager.getString("POSITIVO")%></option>
                                                        <option value="N" <%=NSel%>><%=ApplicationConfigurator.LanguageManager.getString("NEGATIVO")%></option>
                                                </select></td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><div align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%></b></div></td>
                                                <td colspan="100" valign="top"><textarea cols="120" style="height:'50'" name="ATI_INR"><%=strATI_INR%></textarea></td>
                                            </tr>
                                            <tr>
                                                <td align="right" valign="top"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.intervento")%></div></td>
                                                <td valign="top">
                                                    <select width="20" name="NOM_RSP_INR" id="NOM_RSP_INR">
                                                        <option></option>
                                                        <%
            out.print(BuildDipendenteComboBox(DipendenteHome, strNOM_RSP_INR, lCOD_AZL));
                                                        %>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" align="right"><div align="right"><%=ApplicationConfigurator.LanguageManager.getString("Problemi.riscontrati")%></div></td>
                                                <td colspan="100" valign="top"><textarea cols="120" style="height:'50'" name="PBM_RSC" ><%=strPBM_RSC%></textarea></td>
                                            </tr>
                                        </table>	 
                            </fieldset></td></tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
        <!-- /form for addind  -->
        
        <iframe id="ifrmWork" name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
        <%if (strID_PARENT != null) {%>
        <script>
        </script>
        <%}%>
    </body>
</html>
