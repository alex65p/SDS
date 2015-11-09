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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOS"%>
<%@page import="com.apconsulting.luna.ejb.AnagrPOS.IAnagrPOSHome"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script>
    var err=false;
    var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
            IAnagrPOS bean = null;
 
           if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                out.println(ReqMODE);

                Checker c = new Checker();
                //- checking for required fields
		
                Long lCOD_DOC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Documento.di.acquisizione"),request.getParameter("COD_DOC"),true);
                String strTIT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), request.getParameter("TIT"), true);
                Long lCOD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Impresa"),request.getParameter("COD_IMP"),true);
                java.sql.Date datData = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DATA"), true);
                Long lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"),request.getParameter("COD_PRO"),false);
                Long lCOD_OPE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Opera"),request.getParameter("COD_OPE"),false);
                Long lCOD_CAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Cantiere"),request.getParameter("COD_CAN"),false);
                String strUFF = c.checkString(ApplicationConfigurator.LanguageManager.getString("Ufficio"), request.getParameter("UFF"), false);                                 //3
                String strSTA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stanza"), request.getParameter("STA"), false);
                String strFAL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Faldone"), request.getParameter("FAL"), false); 
                String strPRO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Progressivo"), request.getParameter("PRG"), false);
                
                if (c.isError) {
                    String err = c.printErrors();
//		err = err.replace('\"','\'');
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
//=======================================================================================
                if (ReqMODE.equals("edt")) {
                    Long lCOD_POS = new Long(c.checkLong("POS", request.getParameter("COD_POS"), true));
                    IAnagrPOSHome home = (IAnagrPOSHome) PseudoContext.lookup("AnagrPOSBean");            
                    bean = home.findByPrimaryKey(lCOD_POS);                    
                    bean.setlCOD_DOC(lCOD_DOC);
                    bean.setlCOD_PRO(lCOD_PRO);
                    bean.setlCOD_OPE(lCOD_OPE);
                    bean.setlCOD_CAN(lCOD_CAN);
                    bean.setlCOD_DTE(lCOD_DTE);
                    bean.setstrFAL(strFAL);
                    bean.setstrPRO(strPRO);
                    bean.setstrSTA(strSTA);
                    bean.setstrTIT(strTIT);
                    bean.setstrUFF(strUFF);
                    bean.setdatData(datData);
                    
                    try {
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        return;
                    }
                }
//=======================================================================================
                if (ReqMODE.equals("new")) {
                    IAnagrPOSHome home = (IAnagrPOSHome) PseudoContext.lookup("AnagrPOSBean");
                    try {
                        bean = home.create(
                                lCOD_DTE, lCOD_DOC,strTIT, strUFF, strSTA, 
                                strFAL, strPRO, lCOD_PRO, lCOD_OPE, lCOD_CAN, 
                                datData, Security.getAzienda());
%><script>isNew=true;</script><%
                                            } catch (Exception ex) {
                                                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                                                ex.printStackTrace();
                                                return;
                                            }
                                        }
//=======================================================================================
  
                                    }
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getlCOD_POS()%>");

        }else{
            Alert.Success.showSaved();
        }
    }else{
        //Alert.Error.showCreated();
    }
</script>
