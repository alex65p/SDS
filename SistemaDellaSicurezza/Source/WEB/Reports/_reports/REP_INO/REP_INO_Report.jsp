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


<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
            class Report_INO extends Report {

                public long lCOD_AZL = 0;
                public long lCOD_INO = 0;

                public Report_INO(long lCOD_INO) {
                    this.lCOD_INO = lCOD_INO;
                }

                public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
                    lCOD_AZL = Security.getAziendaR();

                    IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));

                    IInfortuniIncidentiHome home_ino = (IInfortuniIncidentiHome) PseudoContext.lookup("InfortuniIncidentiBean");
                    SchedaInfortunioIncidenteView ino = home_ino.getSchedaInfortunioIncidenteView(lCOD_AZL, lCOD_INO);

                    IDipendenteHome home_dpd = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                    DipendenteFunzioneView dpd = home_dpd.getDipendenteFunzioneView(ino.lCOD_DPD);

                    ITestimoneHome home_tst = (ITestimoneHome) PseudoContext.lookup("TestimoneBean");
                    Collection tst = home_tst.getTestimone_View(lCOD_INO);

                    //IAnagrDocumentoHome home_doc = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
                    Collection doc = home_ino.getDocumenti_View(lCOD_INO, lCOD_AZL);

                    String strTmp = "";
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("INFORTUNIO/INCIDENTE"), bean.getRAG_SCL_AZL(), strTmp);
                    AddImage();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(bean.getRAG_SCL_AZL());
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.INFORTUNIO/INCIDENTE"));
                        m_document.add(tbl);
                    }
                    writeIndent();
                    {// dipendente
                        CenterMiddleTable tbl = new CenterMiddleTable(2);
                        tbl.toCenter();
                        int width[] = {22, 78};
                        tbl.setWidths(width);

                        tbl.toLeft();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.dipendente"), 2);
                        //tbl.addTitleCell(strTmp);
                        tbl.toLeft();
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Cognome"));// ok
                        tbl.addCell(Formatter.format(dpd.strCOG_DPD));
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nome"));// ok
                        tbl.addCell(Formatter.format(dpd.strNOM_DPD));
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Codice.fiscale"));// ok
                        tbl.addCell(Formatter.format(dpd.strCOD_FIS_DPD));
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Matricola"));// ok
                        tbl.addCell(Formatter.format(dpd.strMTR_DPD));
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Funzione.aziendale"));// ok
                        tbl.addCell(Formatter.format(dpd.strNOM_FUZ_AZL));


                        m_document.add(tbl);
                    }
                    {//incidente

                        CenterMiddleTable tbl = new CenterMiddleTable(2);
                        int width[] = {20, 80};
                        tbl.setWidths(width);
                        tbl.toLeft();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.infortunio/incidente"), 2);
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"));
                        tbl.addCell(Formatter.format(ino.strNOM_LUO_FSC));
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Tipo.infortunio"));
                        tbl.addCell(Formatter.format(ino.strNOM_TPL_FRM_INO));
                        /*
                        tbl.addCell("Agente Materiale");
                        tbl.addCell(Formatter.format(ino.strNOM_AGE_MAT));
                         */
                        tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Sede.lesione"));
                        tbl.addCell(Formatter.format(ino.strNOM_SED_LES));
                        /*
                        tbl.addCell("Natura Lesione");
                        tbl.addCell(Formatter.format(ino.strNOM_NAT_LES));
                         */
                        m_document.add(tbl);
                    }
                    if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_REPORT_MSR) == false) {
                        {//testimoni
                            writePage();
                            CenterMiddleTable tbl = new CenterMiddleTable(1);

                            tbl.toLeft();
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.testimoni"));
                            Iterator it = tst.iterator();
                            if (it != null) {
                                while (it.hasNext()) {
                                    Testimone_View w = (Testimone_View) it.next();
                                    //tbl.addCell("Nome:");
                                    tbl.addCell(Formatter.format(w.strNOM_TST_EVE));
                                }
                            }
                            m_document.add(tbl);
                        }
                    } else {
                        {//documenti associati
                            writePage();
                            CenterMiddleTable tbl = new CenterMiddleTable(1);

                            tbl.toLeft();
                            
                            Iterator it = doc.iterator();
                            if (it != null) {
                                if (it.hasNext()){
                                tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.documenti.associati"));
                               }
                                while (it.hasNext()) {
                                    InfortuniIncidenti_Documenti_View w = (InfortuniIncidenti_Documenti_View) it.next();
                                    //tbl.addCell("Nome:");
                                    tbl.addCell(Formatter.format(w.strTIT_DOC));
                                    
                                }

                            }
                            m_document.add(tbl);
                        }
                    }

                    closeDocument();
                }
            }
//==========================================================

            Checker c = new Checker();

            long lCOD_INO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Infortunio"), request.getParameter("ID"), true);

            if (c.isError) {
%>
<html><body>
        <h2><%=c.printErrors()%></h2>
    </body></html>
<%
                return;
            }

            out.clearBuffer();

            Report_INO report = new Report_INO(lCOD_INO);
            report.doReport(request, response);
%>
