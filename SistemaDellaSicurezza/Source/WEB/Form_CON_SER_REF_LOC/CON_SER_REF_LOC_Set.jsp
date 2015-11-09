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

<%-- 
    Document   : CON_SER_REF_LOC_Set
    Created on : 27-mag-2008, 10.35.49
    Author     : Giancarlo Servadei
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean.jsp"%>

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
            IContServReferentiLocoHome home = (IContServReferentiLocoHome) PseudoContext.lookup("ContServReferentiLocoBean");
            IContServReferentiLoco bean = null;

            long lCOD_AZL = Security.getAzienda();
            
            String strCOD_SRV = null;
            long lCOD_SRV = 0;
            
            String strCOD_DPD = null;
            long lCOD_DPD = 0;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");

                Checker c = new Checker();

                //- checking for required fields
                strCOD_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo"), request.getParameter("COD_DPD"), true);
                strCOD_SRV = c.checkString(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("COD_SRV"), true);
                String strTEL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Telefono"), request.getParameter("TEL"), false);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
                
                lCOD_DPD = Long.parseLong(strCOD_DPD);
                lCOD_SRV = Long.parseLong(strCOD_SRV);

                if (ReqMODE.equals("edt")) {
                    bean = home.findByPrimaryKey(new ContServReferentiLocoPK(lCOD_AZL, lCOD_SRV, lCOD_DPD));
                    try {
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        ex.printStackTrace();
                        return;
                    }
                } else if (ReqMODE.equals("new")) {
                    out.print("<script>isNew=true;</script>");
                    try {
                        bean = home.create(lCOD_AZL, lCOD_SRV, lCOD_DPD);
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        ex.printStackTrace();
                        return;
                    }
                    //lCOD_DPD = bean.getCOD_DPD();
                }

                if (bean != null) {
                    // *Not require Fields*  
                    bean.setTEL(strTEL);
                }
            }
%>
<script type="text/javascript">
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_DPD%>");
            }
            else{
                Alert.Success.showSaved(); 
            }
        }
        </script>
