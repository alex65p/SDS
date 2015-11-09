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
<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="s2s.utils.Date.DateManager" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            Checker c = new Checker();
                long lCOD_MAN = 0;				// lCOD_MAN
                long ID = 0;                                // ID
                long lCOD_AZL = Security.getAzienda();	// lCOD_AZL Current
                java.util.ArrayList AZIENDA_ID_LIST = null;	// List od COD_AZL

                lCOD_MAN = c.checkLong("Attività Lavorativa", (String) request.getParameter("ID_PARENT"), true);
                ID = c.checkLong("ID", (String) request.getParameter("ID"), true);

                if (Security.isExtendedMode()) {
                    AZIENDA_ID_LIST = c.checkAlLong("AziendaIDs", request.getParameterValues("AZIENDA_ID"));
                }

                //-------------------------------------------------------------------
                IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
                IAttivitaLavorative bean = home.findByPrimaryKey(new AttivitaLavorativePK(Security.getAzienda(), lCOD_MAN));
                String strSubject = (String) request.getParameter("ATTACH_SUBJECT");
                try {
                    if ("OPERAZIONE".equals(strSubject)) {
                        Collection DPI_Associati_Originale = bean.getDPI_View();
                        Vector DPI_Associati_Originale_Vector = new Vector();
                        Iterator it = DPI_Associati_Originale.iterator();
                        while (it.hasNext()) {
                            DPI_Associati_Originale_Vector.add(new Long(((AttLav_DPI_View) it.next()).COD_TPL_DPI));
                        }

                        //bean.addOperazioneSvolte(id_attachment, lCOD_AZL);
                        out.print("<br>lCOD_AZL:" + lCOD_AZL);
                        out.print("<br>lCOD_MAN:" + lCOD_MAN);
                        out.print("<br>lCOD_OPE_SVO:" + ID);
                        out.println("<br>ADDING OPERAZIONE");
                    //--------------------------------------

                        //Ricavo i DPI Originali
                        Collection dpiOriginale = bean.getDPI_View();
                        String res = home.EXaddAssociationOfOpSvoltaToAttLavorativa(
                                lCOD_MAN, ID, lCOD_AZL, AZIENDA_ID_LIST);
                        out.println("<br>RESULT:" + res);
                        if (res.indexOf("...FAILED") != -1) {
                            throw new Exception();
                        } else {
                            String SendedMail = SendMail4AddedOPE_SVO_ANA_MAN(new Long(lCOD_MAN), dpiOriginale);
                            if (!SendedMail.trim().equals("")) {
                                out.println("<script>alert('" + SendedMail + "')</script>");
                            }
                        }
                        /* Metodi per la gestione dell'associazione diretta di
                         CORSI, DPI, PROTOCOLLI SANITARI
                         * all'attività lavorativa
                         * INIZIO
                         */
                        if (res.indexOf("...ATTIVITA ESISTENTE") != -1) {
                            out.print(printErrAlert("divErr", "Error.showDublicateChild", new Exception()));
                        }
                    } else if ("CORSO_EXTENDED".equals(strSubject)) {
                        bean.addCOR_MAN_Ex(ID, DateManager.getCurrentSQLDate(), AZIENDA_ID_LIST);
                    } else if ("PROTOCOLLO_EXTENDED".equals(strSubject)) {
                        bean.addPRO_SAN_MAN_Ex(ID, DateManager.getCurrentSQLDate(), AZIENDA_ID_LIST);
                    } else if ("DPI_EXTENDED".equals(strSubject)) {
                        bean.addDPI_MAN_Ex(ID, DateManager.getCurrentSQLDate(), AZIENDA_ID_LIST);
                        /* Metodi per la gestione dell'associazione diretta di
                         CORSI, DPI, PROTOCOLLI SANITARI
                         * all'attività lavorativa
                         * FINE
                         */
                    } else if ("MACCHINA".equals(strSubject)) {
                        bean.addCOD_MAC(ID);
                    } else if ("DOCUMENTO".equals(strSubject)) {
                        bean.addDocumenti(ID);
                    } else if ("AGENTECHIMICO".equals(strSubject)) {
                        bean.addAGENTECHIMICO(ID);
                    }

                } //--------------------------------------------------------------------
                catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate();</script>");
                    return;
                }
%>
<script type="text/javascript">
    parent.ToolBar.Return.Do();
</script>
