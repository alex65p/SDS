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
            <version number="1.0" date="11/02/2004" author="Artur Denysenko">
            <comments>
            <comment date="11/02/2004" author="Artur Denysenko">
            Associate il documento Correttive e Preventive all'Infortunio
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
            response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            long id_attachment = 0;
            IInfortuniIncidenti bean = null;
            String strID = (String) request.getParameter("ID_PARENT");
            try {
                IInfortuniIncidentiHome home = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
                Long id = new Long(strID);
                bean = home.findByPrimaryKey(id);
                id_attachment = Long.parseLong((String) request.getParameter("ID"));

            } catch (Exception ex) {
                //out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                ex.printStackTrace();

                return;
            }
            String strSubject = (String) request.getParameter("ATTACH_SUBJECT");
            try {
                if ("DOCUMENTO".equals(strSubject)) {
                    bean.addINO_DOC(id_attachment);
                }

            } catch (Exception ex) {
                out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
                return;
            }
%>
<script type="text/javascript">
    parent.ToolBar.Return.Do();
</script>
