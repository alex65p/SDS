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
            <version number="1.0" date="13/03/2004" author="Roman Chumachenko">
            <comments>
            <comment date="13/03/2004" author="Roman Chumachenko">
            <description>REP_SCD_COR_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_COR extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    java.sql.Date dDAT_PIF_EGZ_COR_DAL = null;
                    java.sql.Date dDAT_PIF_EGZ_COR_AL = null;
                    java.sql.Date dEFF_DAT_DAL = null;
                    java.sql.Date dEFF_DAT_AL = null;
                    long lNOM_COR = 0;
                    String lNOM_DCT = "";
                    String strRAGGRUPPATI = "N";
                    String strSTA_INT = "";
                    //--- per sort
                    String strTYPE = "";

                    //------------------------------------
                    if (request.getParameter("TYPE") != null) {
                        strTYPE = request.getParameter("TYPE");
                    }
                    if (request.getParameter("NOM_DCT") != null) {
                        lNOM_DCT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Corso.docente"), request.getParameter("NOM_DCT"), false);
                    }
                    if (request.getParameter("NOM_COR") != null) {
                        lNOM_COR = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Corso.nome"), request.getParameter("NOM_COR"), false);
                    }
                    if (request.getParameter("DAT_PIF_EGZ_COR_DAL") != null) {
                        dDAT_PIF_EGZ_COR_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.dal"), request.getParameter("DAT_PIF_EGZ_COR_DAL"), false);
                    }
                    if (request.getParameter("DAT_PIF_EGZ_COR_AL") != null) {
                        dDAT_PIF_EGZ_COR_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.al"), request.getParameter("DAT_PIF_EGZ_COR_AL"), false);
                    }
                    if (request.getParameter("EFF_DAT_DAL") != null) {
                        dEFF_DAT_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.dal"), request.getParameter("EFF_DAT_DAL"), false);
                    }
                    if (request.getParameter("EFF_DAT_AL") != null) {
                        dEFF_DAT_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.al"), request.getParameter("EFF_DAT_AL"), false);
                    }
                    if (request.getParameter("R_RAGGRUPPATI") != null) {
                        strRAGGRUPPATI = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati"), request.getParameter("R_RAGGRUPPATI"), false);
                    }
                    if (request.getParameter("STA_INT") != null) {
                        strSTA_INT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"), request.getParameter("STA_INT"), false);
                    }

                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors());
                        closeDocument();
                        return;
                         */
                        //Il codice sopra commentato dava luogo a bug simile all'1.84
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL != null)) {
                        if (dEFF_DAT_DAL.compareTo(dEFF_DAT_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0078"));
                            closeDocument();
                            return;
                             */
                            //Il codice sopra commentato dava luogo a bug simile all'1.84
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0078") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    if ((dDAT_PIF_EGZ_COR_DAL != null) && (dDAT_PIF_EGZ_COR_AL != null)) {
                        if (dDAT_PIF_EGZ_COR_DAL.compareTo(dDAT_PIF_EGZ_COR_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079"));
                            closeDocument();
                            return;
                             */
                            //Il codice sopra commentato dava luogo a bug simile all'1.84
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0079") +
                                    "\");close();</script>");
                            return;
                        }
                    }
                    
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    if (bStandAlone) {
                        lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
                    }
                    IAziendaHome azienda_home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda azienda = azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
                    String CA = "";
                    if (bStandAlone) {
                        CA = azienda.getRAG_SCL_AZL();
                    }
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.corsi"), "", null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.corsi"));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                    {
                        IErogazioneCorsiHome home = (IErogazioneCorsiHome) PseudoContext.lookup("ErogazioneCorsiBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getScadenzario_Corsi_View(lCOD_AZL, lNOM_COR, lNOM_DCT, dDAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_AL, strSTA_INT, dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE);
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {15, 20, 30, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianif."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.effet."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Docente"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome.del.corso"));
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            Scadenzario_Corsi_View nr = (Scadenzario_Corsi_View) it_nr.next();
                            tbl.addCell(Formatter.format(nr.DAT_PIF_EGZ_COR));
                            tbl.addCell(Formatter.format(nr.DAT_EFT_EGZ_COR));
                            tbl.addCell(Formatter.format(nr.NOM_DCT));
                            tbl.addCell(Formatter.format(nr.NOM_COR));
                        }
                        m_document.add(tbl);
                    }

                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
