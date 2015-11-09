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
    <version number="1.0" date="22/03/2004" author="Khomenko Juli">
      <comments>
               <comment date="22/03/2004" author="Khomenko Juli">
                   <description>CRM_PRO_SAN_Set.jsp</description>
               </comment>
      </comments>
    </version>
  </versions>
</file>
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IProtocoleSanitareHome home=(IProtocoleSanitareHome)PseudoContext.lookup("ProtocoleSanitareBean");

    long lCOD_AZL = Security.getAzienda();

    if("caricaDbProtocolli".equals(request.getParameter("LOCAL_MODE"))){

        String []ar_strCOD_PRO_SAN = request.getParameterValues("COD_PRO_SAN");

        int i, status = 0;

        if(ar_strCOD_PRO_SAN != null)
        {
            for(i = 0; i < ar_strCOD_PRO_SAN.length; i++)
            {
                long lCOD_PRO_SAN = new Long(ar_strCOD_PRO_SAN[i]).longValue();

                if(home.caricaDbProtocolli(lCOD_AZL, lCOD_PRO_SAN)){
                    out.print(lCOD_PRO_SAN+" - OK");
                    status++;
                }
                else{
                    out.print(lCOD_PRO_SAN+" - Error");
                }
                out.print("<br>");
            }
            if(status == i){
                out.print("<script>Alert.Success.showAllRepositoryImport();</script>");
            }
            else if(status == 0){
                out.print("<script>Alert.Error.showErrorRepositoryImport();</script>");
            }
            else {
                out.print("<script>Alert.Success.showAllRepositoryImport("+status+");</script>");
            }
            out.print("<script>parent.goSearch();</script>");
        }
    }
    if("caricaRpProtocolli".equals(request.getParameter("LOCAL_MODE"))){
        String strNOM_PRO_SAN = request.getParameter("NOM_PRO_SAN");
        if(home.caricaRpProtocolli(lCOD_AZL, strNOM_PRO_SAN)){
            out.print(strNOM_PRO_SAN+" - OK");
            out.print("<script>Alert.Success.showRepositoryExport();</script>");
        }
        else{
            out.print(strNOM_PRO_SAN+" - Error");
            out.print("<script>Alert.Error.showErrorRepositoryExport();</script>");
        }
    }
%>
