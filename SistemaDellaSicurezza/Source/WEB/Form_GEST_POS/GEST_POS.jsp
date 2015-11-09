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
    Document   : getNextRev
    Created on : 6-mag-2011, 16.22.09
    Author     : Alessandro
--%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.AnagrDocumentoGestioneCantieri_View"%>
<%@ page import="com.apconsulting.luna.ejb.SezioneGenerale.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedediSicurezza.*" %>
<%@ page import="com.apconsulting.luna.ejb.SezioneParticolare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Fascicolo.*" %>
<%@ page import="s2s.utils.Alphabet" %>
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    </head>
    <body>
        <%
            IAnagrDocumentiGestioneCantieriHome home = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");
            String COD_DOC = request.getParameter("COD_DOC");
            long lCOD_DOC = StringManager.isEmpty(COD_DOC)?0:Long.parseLong(COD_DOC);

            String pro = "";
            String ope = "";
            String can = "";
            long cod_pro = 0;
            long cod_ope = 0;
            long cod_can = 0;
            
            if (lCOD_DOC != 0){
                Collection<AnagrDocumentoGestioneCantieri_View> col = home.getPRO_OPE_CAN(lCOD_DOC);
                AnagrDocumentoGestioneCantieri_View element = col.iterator().next();

                pro = Formatter.format(element.strNOM_PRO);
                ope = Formatter.format(element.strNOM_OPE);
                can = Formatter.format(element.strNOM_CAN);
                cod_pro = element.lCOD_PRO;
                cod_ope = element.lCOD_OPE;
                cod_can = element.lCOD_CAN;
            }
        %>
        <script>
            parent.document.getElementById('PRO').value="<%=pro%>";
            parent.document.getElementById('OPE').value="<%=ope%>";
            parent.document.getElementById('CAN').value="<%=can%>";
            parent.document.getElementById('COD_PRO').value="<%=cod_pro%>";
            parent.document.getElementById('COD_OPE').value="<%=cod_ope%>";
            parent.document.getElementById('COD_CAN').value="<%=cod_can%>";
        </script>
    </body>
</html>
