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
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.RischioChimico.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
    var isNew=false;
</script>
<%
            IRischioChimicoBean bean = (IRischioChimicoBean) PseudoContext.lookup("RischioChimicoBean");

            Checker c = new Checker();

            long lCOD_OPE_SVO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Operazione.svolta"), request.getParameter("COD_OPE_SVO"), true);
            long lCOD_SOS_CHI = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sostanza.chimica"), request.getParameter("COD_SOS_CHI"), true);
            long lCOD_MAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività"), request.getParameter("COD_MAN"), true);

            long lCOD_QTA = Long.parseLong(request.getParameter("COD_QTA"));
            long lCOD_CCP = Long.parseLong(request.getParameter("COD_CCP"));
            long lCOD_TIP = Long.parseLong(request.getParameter("COD_TIP"));
            long lCOD_CTR = Long.parseLong(request.getParameter("COD_CTR"));
            long lCOD_TMP_ESP = Long.parseLong(request.getParameter("COD_TMP_ESP"));
            long lCOD_DIS = Long.parseLong(request.getParameter("COD_DIS"));
            long lCOD_ALG = Long.parseLong(request.getParameter("COD_ALG"));

            if (c.isError) {
                String err = c.printErrors();
%><script type="text/javascript">alert("<%=err%>");</script><%
                return;
            }
//------end check section--------------------------------

// gettinf of object 
            bean.findByPrimaryKey(lCOD_MAN, lCOD_OPE_SVO, lCOD_SOS_CHI);
//getting of parameters and set the new object variables
            try {
                bean.setCOD_QTA(lCOD_QTA);
                bean.setCOD_CCP(lCOD_CCP);
                bean.setCOD_TIP(lCOD_TIP);
                bean.setCOD_CTR(lCOD_CTR);
                bean.setCOD_TMP_ESP(lCOD_TMP_ESP);
                bean.setCOD_DIS(lCOD_DIS);
                bean.setCOD_ALG(lCOD_ALG);
                //bean.setIDX_RSO_CHI(lCOD_TIP);
                bean.store();
            } catch (Exception ex) {
                out.println("<script>Alert.Error.showDublicate();</script>");
                return;
            }
%>
<script type="text/javascript">
    if (!err){
        Alert.Success.showSaved();
    }
</script>

