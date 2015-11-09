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
    <version number="1.0" date="18/02/2004" author="Khomenko Juliya">
    <comments>
    <comment date="18/02/2004" author="Khomenko Juliya">
    <description>Create ANA_DOC_VLU_Tabs.jsp</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_DOC_VLU_Util.jsp" %>

<script>
    var err=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<div id="dContent">
    <%
        long lCOD_DOC_VLU = 0;
        IValutazioneRischi bean = null;
        IValutazioneRischiHome home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
        String strID = (String) request.getParameter("ID_PARENT");

        try {
            bean = home.findByPrimaryKey(new Long(strID));
            lCOD_DOC_VLU = bean.getCOD_DOC_VLU();
        } catch (Exception ex) {
            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
            return;
        }
        try {
            if (bean != null) {
                // Sezioni
                if (request.getParameter("TAB_NAME").equals("tab1")) {
                    out.println(ValutazioneRischiSezioniTab(home, Formatter.format(lCOD_DOC_VLU)));
                // Allegati
                } else if (request.getParameter("TAB_NAME").equals("tab2")) {
                    out.println(ValutazioneRischiAllegatiTab(home, Formatter.format(lCOD_DOC_VLU)));
                // Archivio
                } else if (request.getParameter("TAB_NAME").equals("tab3")) {
                    out.println(ValutazioneRischiArchivioTab(home, lCOD_DOC_VLU, Security.getAzienda()));
                } else {
                    return;
                }
            }
        } catch (Exception ex) {
            out.print(printErrAlert("divErr", "Error.alert", ex));
            ex.printStackTrace();
            return;
        }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
</script>
