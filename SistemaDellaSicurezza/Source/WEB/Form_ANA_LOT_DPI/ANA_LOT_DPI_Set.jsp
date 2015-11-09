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
     * <file> <versions> <version number="1.0" date="25/01/2004"
     * author="Treskina Maria"> <comments> <comment date="25/01/2004"
     * author="Treskina Maria"> <description>vnesenie dannih v
     * ANA_LOT_DPI</description> </comment> <comment date="6/02/2004"
     * author="Kushkarov Yura"> <description>Sdelal Return +
     * alerti</description> </comment> </comments> </version> </versions>
     * </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
>
<!-- per tab LottiDPI in Form_TPL_DPI -->
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;
</script>

<%!    String ReqMODE;	// parameter of request 
%>

<%
    ILottiDPI lottiDPI = null;
    IFornitore fornitore = null;

    String strRAG_SCL_AZL = "";

    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");

//- checking for required fields
        Checker c = new Checker();
        long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZIENDA"), true);
        long lCOD_TPL_DPI = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."), request.getParameter("COD_TIPOLOGIA"), true);
        String strIDE_LOT_DPI = c.checkString(ApplicationConfigurator.LanguageManager.getString("Identificativo"), request.getParameter("IDENTIFICATIVO"), true);
        java.sql.Date dDAT_CSG_LOT = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.consegna"), request.getParameter("DATA_CONSEGNA"), true);
        long lCOD_FOR_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fornitore"), request.getParameter("COD_FORNITORE"), true);
        long lQTA_FRT = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fornita"), request.getParameter("Q_FORNITA"), true);
        long lQTA_AST = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Assegnata"), request.getParameter("Q_ASSEGNATA"), true);
        long lQTA_DSP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Disponibile"), request.getParameter("Q_DISPONIBILE"), true);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        try {
            if (ReqMODE.equals("edt")) {
                // editing of lotti DPI--------------------
                // gettinf of object 
                ILottiDPIHome home = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");

                Long lot_dpi_id = new Long(c.checkLong("Lotti DPI ID", request.getParameter("LOT_DPI_ID"), true));

                if (c.isError) {
                    String err = c.printErrors();
                    out.print("for_id=" + err);
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                lottiDPI = home.findByPrimaryKey(lot_dpi_id);
                //getting of parameters and set the new object variables
                lottiDPI.setCOD_TPL_DPI(lCOD_TPL_DPI);
                lottiDPI.setIDE_LOT_DPI(strIDE_LOT_DPI);
                lottiDPI.setDAT_CSG_LOT(dDAT_CSG_LOT);
                lottiDPI.setQTA_FRT(lQTA_FRT);
                lottiDPI.setQTA_AST(lQTA_AST);
                lottiDPI.setQTA_DSP(lQTA_DSP);
                lottiDPI.setCOD_FOR_AZL(lCOD_FOR_AZL);
                lottiDPI.setCOD_AZL(lCOD_AZL);
            }

//=======================================================================================
            if (ReqMODE.equals("new")) {

                // new lotti DPI--------------------------
                // creating of object 
                ILottiDPIHome home = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");
                lottiDPI = home.create(lCOD_TPL_DPI, strIDE_LOT_DPI, dDAT_CSG_LOT, lQTA_FRT, lQTA_AST, lQTA_DSP, lCOD_FOR_AZL, lCOD_AZL);
                out.print("<script>isNew=true;</script>");
            }

//--- return RAG_SCL_AZL fornitore per tab LottiDPI TPL_DPI_TAB
            IFornitoreHome FornitoreHome = (IFornitoreHome) PseudoContext.lookup("FornitoreBean");

            Long for_azl_id = new Long(lCOD_FOR_AZL);
            fornitore = FornitoreHome.findByPrimaryKey(for_azl_id);
            strRAG_SCL_AZL = fornitore.getRAG_SOC_FOR_AZL();
        } catch (Exception ex) {
            ex.printStackTrace();
%>
<script>
    err=true;
</script>
<%        }
    }
%>
<script>
    /*
if (parent.dialogArguments){
        if (!err){	
                        da=parent.dialogArguments;
                        da.ID = "<%= lottiDPI.getCOD_LOT_DPI()%>";
                        da.codTplDpi="<%= lottiDPI.getCOD_TPL_DPI()%>";
                        da.fornitore="<%= strRAG_SCL_AZL%>";
                        da.identificativo = "<%= lottiDPI.getIDE_LOT_DPI()%>" 	
                        da.dataConsegna = "<%= Formatter.format(lottiDPI.getDAT_CSG_LOT())%>" 	
                        parent.returnValue="OK";
                        if(isNew){
                        Alert.Success.showCreated();
                        //parent.ToolBar.Return.OnClick();
                        parent.ToolBar.OnNew("ID=<%=lottiDPI.getCOD_LOT_DPI()%>");
                  }else{
                        Alert.Success.showSaved();
                        parent.ToolBar.Exit.setEnabled(false);
                        parent.ToolBar.Return.setEnabled(true);
                        }
                }
}	
else{*/
    if (!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lottiDPI.getCOD_LOT_DPI()%>");
        }else{
            Alert.Success.showSaved();
        }
        /*parent.ToolBar.Exit.setEnabled(true);
        parent.ToolBar.Return.setEnabled(false); */
    }
    else
    {Alert.Error.showDublicate()
    }
</script>
