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
     <version number="1.0" date="22/01/2004" author="Pogrebnoy Yura">
     <comments>
     <comment date="22/01/2004" author="Pogrebnoy Yura">
     <description>Shablon formi ANA_RST_Delete.jsp</description>
     </comment>		
     <comment date="25/01/2004" author="Alexey Kolesnik">
     <description> Podpravleno ydalenie: dobavlena obrabotka oshibok </description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Risposta/RispostaBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err = false;</script>

<%        IDomande domande = null;

    if (request.getParameter("ID") != null) {
        String COD_RST_DEL = request.getParameter("ID");
        String COD_DMD_DEL = request.getParameter("ID_PARENT");
        if (COD_DMD_DEL != null && !COD_DMD_DEL.equals("") && !COD_DMD_DEL.equals("null")) {
            long lCOD_RST_DEL = Long.parseLong(COD_RST_DEL);
            Long lCOD_DMD_DEL = new Long(COD_DMD_DEL);
            IDomandeHome dhome = (IDomandeHome) PseudoContext.lookup("DomandeBean");
            domande = dhome.findByPrimaryKey(lCOD_DMD_DEL);
            try {
                domande.removeCOD_RST(lCOD_RST_DEL);
            } catch (Exception ex) {
                out.print("<script>err=true; errDescr = 'Integrity violation';</script>");
            }
        } else {
            IRispostaHome home = (IRispostaHome) PseudoContext.lookup("RispostaBean");
            Long lCOD_RST = new Long(COD_RST_DEL);
            try {
                home.remove(lCOD_RST);
            } catch (Exception ex) {
                manageException(request, out, ex);
            }
        }
    } else {
        out.print("<script>err=true;</script>");
    }
%>

<script>
    if (!err) {
        Alert.Success.showDeleted();
        if (parent.dialogArguments) {
            parent.del_localRow();
        } else {
            parent.ToolBar.OnDelete();
        }
        parent.returnValue = "OK";
    } else {
        Alert.Error.showDelete();
        parent.returnValue = "CANCEL";
    }
</script>
