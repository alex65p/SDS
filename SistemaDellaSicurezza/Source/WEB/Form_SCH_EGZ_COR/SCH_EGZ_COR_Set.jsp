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
            <version number="1.0" date="28/01/2004" author="Kushkarov Yura">
            <comments>
            <comment date="28/01/2004" author="Kushkarov Yura">
            <description>Shablon formi ANA_ALA_Form.jsp</description>
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

<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;
    </script>

<%!	String ReqMODE;	// parameter of request%>

<%IErogazioneCorsi ErogazioneCorsi = null;
            long THIS_ID = 0;
            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                Checker c = new Checker();
                //- checking for required fields
                long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);            //2
                long lCOD_COR = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dati.corso"), request.getParameter("COD_COR"), true);
                java.sql.Date dtDAT_PIF_EGZ_COR = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione"), request.getParameter("DAT_PIF_EGZ_COR2"), true);        //6
                java.sql.Date dtDAT_EFT_EGZ_COR = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.erogazione"), request.getParameter("DAT_EFT_EGZ_COR"), false);        //7

                // Stato Erogazione
                String strSTA_EGZ_COR = request.getParameter("STA_EGZ_COR");
                strSTA_EGZ_COR = strSTA_EGZ_COR == null ? "" : strSTA_EGZ_COR;
                strSTA_EGZ_COR = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.erogazione"), strSTA_EGZ_COR, true); 

//-------------------------------------------------
                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");err=true;</script>");
                    return;
                }

//=======================================================================================
                if (ReqMODE.equals("edt")) {
                    // editing of SchedeIntervento--------------------
                    // gettinf of object 
                    Long lCOD_SCH_EGZ_COR = new Long(c.checkLong("SchedeIntervento ID", request.getParameter("COD_SCH_EGZ_COR"), true));

                    IErogazioneCorsiHome home = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
                    ErogazioneCorsi = home.findByPrimaryKey(lCOD_SCH_EGZ_COR);
                    //getting of parameters and set the new object variables
                    ErogazioneCorsi.setCOD_AZL(lCOD_AZL);
                    ErogazioneCorsi.setCOD_COR(lCOD_COR);
                    ErogazioneCorsi.setSTA_EGZ_COR(strSTA_EGZ_COR);
                    ErogazioneCorsi.setDAT_PIF_EGZ_COR(dtDAT_PIF_EGZ_COR);
                    THIS_ID = ErogazioneCorsi.getCOD_SCH_EGZ_COR();
                //----------
                }
//=======================================================================================
                if (ReqMODE.equals("new")) {
                    // new SchedeIntervento--------------------------
                    // creating of object 
                    IErogazioneCorsiHome home = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
                    ErogazioneCorsi = home.create(lCOD_COR, lCOD_AZL, strSTA_EGZ_COR, dtDAT_PIF_EGZ_COR);
                    THIS_ID = ErogazioneCorsi.getCOD_SCH_EGZ_COR();
%>
<script>isNew=true;</script>
<%
                }
//=======================================================================================
                if (ErogazioneCorsi != null) {
//   *Not require Fields*
                    ErogazioneCorsi.setDAT_EFT_EGZ_COR(dtDAT_EFT_EGZ_COR);
                }
            }
%>	
<script>
    if (!err){
        if(isNew){
            Alert.Success.showCreated();
        }else{
        Alert.Success.showSaved();}
    if(isNew) parent.ToolBar.OnNew("ID=<%=THIS_ID%>"); 
    }
    </script>
