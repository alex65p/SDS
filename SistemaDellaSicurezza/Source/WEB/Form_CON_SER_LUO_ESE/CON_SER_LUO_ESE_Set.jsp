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
        <version number="1.0" date="13/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="13/05/2008" author="Dario Massaroni">
                    <description>Create CON_SER_LUO_ESE_Form.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
    String ReqMODE; // parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var isNew = false;
    var err=false;
</script>
<%
    IContServLuoghiEsecuzioneHome home = (IContServLuoghiEsecuzioneHome) 
            PseudoContext.lookup("ContServLuoghiEsecuzioneBean");
    IContServLuoghiEsecuzione bean = null;
    String strCOD_LUO_FSC = null;
    long lCOD_LUO_FSC = 0;
    long lCOD_SRV = 0;
       
    if (request.getParameter("SBM_MODE") != null) {
        ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        strCOD_LUO_FSC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"), request.getParameter("COD_LUO_FSC"), true);
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
        
        //- checking for not required fields
        String strDES_SER = c.checkString("", request.getParameter("DES_SER"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        lCOD_LUO_FSC = Long.parseLong(strCOD_LUO_FSC);    

        if (ReqMODE.equals("edt")) {
            bean = home.findByPrimaryKey(new ContServLuoghiEsecuzionePK(lCOD_SRV, lCOD_LUO_FSC));
            try {
                bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
                bean.setDES_SER(strDES_SER);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
        
        if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, lCOD_LUO_FSC, strDES_SER);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            lCOD_LUO_FSC = bean.getCOD_LUO_FSC();
        }
    }
%>
<script>
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_LUO_FSC%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
