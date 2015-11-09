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
            <version number="1.0" date="12/03/2004" author="Roman Chumachenko">
            <comments>
            <comment date="12/03/2004" author="Roman Chumachenko">
            <description>REP_SCD_VST_IDO_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_VST_IDO extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    long lCOD_UNI_ORG = 0;
                    String strVISITA = "M";
                    String strSTATO = "N";
                    java.sql.Date dDAT_PIF_VST_D = null;
                    java.sql.Date dDAT_PIF_VST_A = null;
                    java.sql.Date dDAT_EFT_VST_D = null;
                    java.sql.Date dDAT_EFT_VST_A = null;
                    String strTPL_ACR_VLU_RSO = "";
                    String strRAGGRUPPATI = "N";
                    String strSTA_INT = "";
                    //----
                    String strSORT_DAT_PIF = ", 'a'.'dat_pif_vst_med' asc ";
                    String strSORT_DAT_EFT = "X";
                    String strSORT_TPL_ACC = "X";
                    //------------------------------------
                    if (request.getParameter("COD_UNI_ORG") != null) {
                        lCOD_UNI_ORG = c.checkLong("COD Unita Organizzativa", request.getParameter("COD_UNI_ORG"), false);
                    }
                    if (request.getParameter("R_VISITA") != null) {
                        strVISITA = c.checkString(ApplicationConfigurator.LanguageManager.getString("Visita"), request.getParameter("R_VISITA"), false);
                    }
                    if (request.getParameter("R_STATO") != null) {
                        strSTATO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"), request.getParameter("R_STATO"), false);
                    }
                    if (request.getParameter("STA_INT") != null) {
                        strSTA_INT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"), request.getParameter("STA_INT"), false);
                    }
                    if (request.getParameter("TPL_ACR_VLU_RSO") != null) {
                        strTPL_ACR_VLU_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia.accertamento"), request.getParameter("TPL_ACR_VLU_RSO"), false);
                    }
                    if (request.getParameter("DAT_PIF_VST_D") != null) {
                        dDAT_PIF_VST_D = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.dal"), request.getParameter("DAT_PIF_VST_D"), false);
                    }
                    if (request.getParameter("DAT_PIF_VST_A") != null) {
                        dDAT_PIF_VST_A = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.al"), request.getParameter("DAT_PIF_VST_A"), false);
                    }
                    if (request.getParameter("DAT_EFT_VST_D") != null) {
                        dDAT_EFT_VST_D = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.dal"), request.getParameter("DAT_EFT_VST_D"), false);
                    }
                    if (request.getParameter("DAT_EFT_VST_A") != null) {
                        dDAT_EFT_VST_A = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.al"), request.getParameter("DAT_EFT_VST_A"), false);
                    }
                    //************************ SORT ******************* 
                    if (request.getParameter("SORT_DAT_PIF") != null) {
                        strSORT_DAT_PIF = c.checkString("", request.getParameter("SORT_DAT_PIF"), false);
                    }
                    if (request.getParameter("SORT_DAT_EFT") != null) {
                        strSORT_DAT_EFT = c.checkString("", request.getParameter("SORT_DAT_EFT"), false);
                    }
                    if (request.getParameter("SORT_TPL_ACC") != null) {
                        strSORT_TPL_ACC = c.checkString("", request.getParameter("SORT_TPL_ACC"), false);
                    }


                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors()); 
                        closeDocument();
                        return;
                        */
                        //Il codice sopra commentato dava luogo al bug 1.81
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }


                    if ((dDAT_PIF_VST_D != null) && (dDAT_PIF_VST_A != null)) {
                        if (dDAT_PIF_VST_D.compareTo(dDAT_PIF_VST_A) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079")); 
                            closeDocument();
                            return;
                            */
                            //Il codice sopra commentato dava luogo al bug 1.81
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0079") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    if ((dDAT_EFT_VST_D != null) && (dDAT_EFT_VST_A != null)) {
                        if (dDAT_EFT_VST_D.compareTo(dDAT_EFT_VST_A) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0078"));
                            closeDocument();
                            return;
                            */
                            //Il codice sopra commentato dava luogo al bug 1.81
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0078") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    if (bStandAlone) {
                        lCOD_AZL = new Long(request.getParameter("COD_AZIENDA")).longValue();
                    }
                    IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
                    String CA = "";
                    if (bStandAlone) {
                        CA = azienda.getRAG_SCL_AZL();
                    }

                    String docTitle = "";
                    if (strVISITA.equals("M")){
                        docTitle = ApplicationConfigurator.LanguageManager.getString("Scadenzario.visite.mediche");
                    } else
                    if (strVISITA.equals("I")){
                        docTitle = ApplicationConfigurator.LanguageManager.getString("Scadenzario.visite.idoneità");
                    }
                    initDocument("the doc", null, docTitle, CA, null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(docTitle);
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    {
                        IGestioneVisiteMedicheHome homeM = (IGestioneVisiteMedicheHome) PseudoContext.lookup("GestioneVisiteMedicheBean");
                        IGestioneVisiteIdoneitaHome homeI = (IGestioneVisiteIdoneitaHome) PseudoContext.lookup("GestioneVisiteIdoneitaBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col_nr = null;
                        if (strVISITA.equals("M")) {
                            col_nr = homeM.getVisiteMediche_foo_SCHVST_View(lCOD_AZL, lCOD_UNI_ORG, strTPL_ACR_VLU_RSO, strSTATO, dDAT_PIF_VST_D, dDAT_PIF_VST_A, strSTA_INT, dDAT_EFT_VST_D, dDAT_EFT_VST_A, strRAGGRUPPATI, strSORT_DAT_PIF, strSORT_DAT_EFT, strSORT_TPL_ACC);
                        }
                        if (strVISITA.equals("I")) {
                            col_nr = homeI.getVisiteIdoneita_for_SCHVST_View(lCOD_AZL, lCOD_UNI_ORG, strTPL_ACR_VLU_RSO, strSTATO, dDAT_PIF_VST_D, dDAT_PIF_VST_A, strSTA_INT, dDAT_EFT_VST_D, dDAT_EFT_VST_A, strRAGGRUPPATI, strSORT_DAT_PIF, strSORT_DAT_EFT, strSORT_TPL_ACC);
                        }
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {15, 20, 30, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianif."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.effettiva"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Accertamento.medico"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dipendente"));
                        tbl.endHeaders();
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        //--- table body ---
                        java.util.Iterator it_nr = col_nr.iterator();
                        while (it_nr.hasNext()) {
                            VisiteMediche_foo_SCHVST_View nr;
                            if (strVISITA.equals("M")) {
                                nr = (VisiteMediche_foo_SCHVST_View) it_nr.next();
                            } else {
                                VisiteIdoneita_for_SCHVST_View nr1 = (VisiteIdoneita_for_SCHVST_View) it_nr.next();
                                nr = new VisiteMediche_foo_SCHVST_View();
                                nr.COD_CTL_SAN = nr1.COD_CTL_SAN;
                                nr.COD_VST = nr1.COD_VST;
                                nr.COD_DPD = nr1.COD_DPD;
                                nr.COD_AZL = nr1.COD_AZL;
                                nr.DAT_PIF_VST_MED = nr1.DAT_PIF_VST_MED;
                                nr.DAT_EFT_VST_MED = nr1.DAT_EFT_VST_MED;
                                nr.TPL_ACR_VLU_RSO = nr1.TPL_ACR_VLU_RSO;
                                nr.DPD = nr1.DPD;
                                nr.RAG_SCL_AZL = nr1.RAG_SCL_AZL;
                            }
                            tbl.addCell(Formatter.format(nr.DAT_PIF_VST_MED));
                            tbl.addCell(Formatter.format(nr.DAT_EFT_VST_MED));
                            tbl.addCell(Formatter.format(nr.TPL_ACR_VLU_RSO));
                            tbl.addCell(Formatter.format(nr.DPD));
                        }
                        m_document.add(tbl);
                    }
                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
