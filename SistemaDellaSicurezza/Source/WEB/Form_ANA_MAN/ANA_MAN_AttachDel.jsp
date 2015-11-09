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

<%@page import="s2s.utils.Date.DateManager"%>
<%
            /*
            <file>
            <versions>
            <version number="1.0" date="12/02/2004" author="Roman Chumachenko">
            <comments>
            <comment date="12/02/2004" author="Roman Chumachenko">
            <description>ANA_MAN_AttachDel.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            Checker c = new Checker();
            long lCOD_AZL = Security.getAzienda();
            long id_attachment = 0;
            long lCOD_MAN = 0;

            //
            String strID = c.checkString("ID_ATTIVITA", (String) request.getParameter("ID_PARENT"), true);
            String strSubject = c.checkString("ATTACH_SUBJECT", (String) request.getParameter("ATTACH_SUBJECT"), true);
            String strID_ITEM = c.checkString("ID_ITEM", (String) request.getParameter("ID"), true);
            id_attachment = Long.parseLong(strID_ITEM);
            //
            java.util.ArrayList AZIENDA_ID_LIST = null;// List od COD_AZL
            if (Security.isExtendedMode()) {
                AZIENDA_ID_LIST = c.checkAlLong("AziendaIDs", request.getParameterValues("AZIENDA_ID"));
            }
            //
            if (c.isError) {
                String err = c.printErrors();
%><script type="text/javascript">alert("<%=err%>");</script><%
                return;
            }
            //
            IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
            IAssRischioAttivitaHome ass_home = (IAssRischioAttivitaHome) PseudoContext.lookup("AssRischioAttivitaBean");
            IAttivitaLavorative bean = null;
            IAssRischioAttivita bean2 = null;
            //
            try {
                lCOD_MAN = new Long(strID).longValue();
                bean = home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lCOD_MAN));
                if ("RISC".equals(strSubject)) {
                    Long ass_id = new Long(strID_ITEM);
                    bean2 = ass_home.findByPrimaryKey(ass_id);
                }
            } catch (Exception ex) {
                out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                return;
            }
            //-------------------------------------------------------------------------
            try {
                if ("OPERAZIONE".equals(strSubject)) {
                    //bean.removeOperazioneSvolte(id_attachment, Security.getAzienda() );
                    out.println("lCOD_OPE_SVO (id_attachment):" + id_attachment + "<br>");
                    out.println("lCOD_MAN (lCOD_MAN):" + lCOD_MAN + "<br>");
                    out.println("lCOD_AZL (lCOD_AZL):" + lCOD_AZL + "<br>");
                    out.println("DELETING OPERAZIONE OK");
                    //---------------------------------------------------
                    String res = home.EXdeleteAssociationOfOpSvoltaFromAttLavorativa(
                            id_attachment, lCOD_AZL, lCOD_MAN, AZIENDA_ID_LIST);
                    out.print("RESULT:" + res);
                    if (res.indexOf("...FAILED") != -1) {
                        throw new Exception();
                    }
                    //
%><script type="text/javascript">
    parent.tabbar.tabs[1].tabObj.Refresh();
    parent.tabbar.tabs[2].tabObj.Refresh();
    parent.tabbar.tabs[3].tabObj.Refresh();
    parent.tabbar.tabs[4].tabObj.Refresh();
</script>
<%
                }
                if ("RISC".equals(strSubject)) {
                    //-------------------------
                    long lngCOD_RSO = bean2.getCOD_RSO();
                    bean.deleteXRischioAssociations(lngCOD_RSO, lCOD_AZL);
                    out.println("DELETING RISC OK");
%><script type="text/javascript">
    parent.tabbar.tabs[2].tabObj.Refresh();
    parent.tabbar.tabs[3].tabObj.Refresh();
    parent.tabbar.tabs[4].tabObj.Refresh();
</script>
<%
                }
                //==========================================

                if ("CORSO".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.removeCorso(id_attachment);
                    out.println("DELETING CORSO OK");
                } else if ("PROTOCOLO".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.removeProtocoloSanitario(id_attachment);
                    out.println("DELETING PROTOCOLO OK");
                } else if ("DPI".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.removeDPI(id_attachment);
                    out.println("DELETING DPI OK");
                } else /* Metodi per la cancellazione dell'associazione diretta di
                CORSI, DPI, PROTOCOLLI SANITARI
                 * all'attività lavorativa
                 * INIZIO
                 */ if ("CORSO_EXTENDED".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.deleteCOR_MAN_Ex(id_attachment, AZIENDA_ID_LIST);
                    out.println("DELETING CORSO OK");
                } else if ("PROTOCOLLO_EXTENDED".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.deletePRO_SAN_MAN_Ex(id_attachment, AZIENDA_ID_LIST);
                    out.println("DELETING PROTOCOLO OK");
                } else if ("DPI_EXTENDED".equals(strSubject)) {
                    out.println(strID + "<br>");
                    out.println(id_attachment + "<br>");
                    bean.deleteDPI_MAN_Ex(id_attachment, AZIENDA_ID_LIST);
                    out.println("DELETING DPI OK");
                } else /* Metodi per la cancellazione dell'associazione diretta di
                CORSI, DPI, PROTOCOLLI SANITARI
                 * all'attività lavorativa
                 * FINE
                 */ if ("MACCHINA".equals(strSubject)) {
                    bean.removeMacchina(id_attachment);
                }
                if ("DOCUMENTO".equals(strSubject)) {
                    bean.removeDocumenti(id_attachment);
                }
                if ("AGENTECHIMICO".equals(strSubject)) {
                    bean.removeAGENTECHIMICO(id_attachment);
                }
                //-------------------------------------------------------------------
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDelete();</script>");
                return;
            }
%>
<script type="text/javascript">
    parent.del_localRow();
    Alert.Success.showDeleted();
</script>
