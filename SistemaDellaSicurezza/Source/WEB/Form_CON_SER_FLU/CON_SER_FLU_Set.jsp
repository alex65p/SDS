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
        <version number="1.0" date="19/05/2008" author="Giancarlo Servadei">
            <comments>
                <comment date="19/05/2008" author="Giancarlo Servadei">
                    <description>Create CON_SER_FLU_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServFluidi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%!
    String ReqMODE; // parameter of request 
%>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var isNew = false;
    var err=false;
</script>
<%
    IContServFluidiHome home = (IContServFluidiHome) PseudoContext.lookup("ContServFluidiBean");
    IContServFluidi bean = null;
    
    IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");            
    IAnaContServ con_ser_bean = null;
    
    String strCOD_FLU = null;
    long lCOD_FLU = 0;
    long lCOD_SRV = 0;
       
    if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

        Checker c = new Checker();
        
        //- checking for required fields
        strCOD_FLU = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Fluido"), request.getParameter("COD_FLU"), false);
        lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), false);
        
        //- checking for not required fields
        String strTIP_FLU_DIS = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipo.di.fluido"), request.getParameter("TIP_FLU_DIS"), true);
        String strLUO_COL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.di.collegamento"), request.getParameter("LUO_COL"), false);
        java.sql.Date dtDAT_INI_CON = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio.consegna"), request.getParameter("DAT_INI_CON"), false);
        java.sql.Date dtDAT_FIN_CON = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine.consegna"), request.getParameter("DAT_FIN_CON"), false);

        String strFLU_DES_1 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.alta"), request.getParameter("FLU_DES_1"), false);
        String strFLU_DES_2 = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.bassa"), request.getParameter("FLU_DES_2"), false);
        
        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }
        
        con_ser_bean = con_ser_home.findByPrimaryKey(lCOD_SRV);
            
        if (ReqMODE.equals("edt")) {
            lCOD_FLU = Long.parseLong(strCOD_FLU);
            bean = home.findByPrimaryKey(new ContServFluidiPK(lCOD_SRV, lCOD_FLU));
            try {
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        } else if (ReqMODE.equals("new")) {
            out.print("<script>isNew=true;</script>");
            try {
                bean = home.create(lCOD_SRV, strTIP_FLU_DIS);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            lCOD_FLU = bean.getCOD_FLU();
        }
        
        if (bean != null) {
                // *Not require Fields*
                bean.setTIP_FLU_DIS(strTIP_FLU_DIS);
                bean.setLUO_COL(strLUO_COL);
                bean.setDAT_INI_CON(dtDAT_INI_CON);
                bean.setDAT_FIN_CON(dtDAT_FIN_CON);
                
                con_ser_bean.setFLU_DES_1(strFLU_DES_1);
                con_ser_bean.setFLU_DES_2(strFLU_DES_2);
        }
    }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_FLU%>");
        }
        else{
            Alert.Success.showSaved(); 
        }
    }
</script>
