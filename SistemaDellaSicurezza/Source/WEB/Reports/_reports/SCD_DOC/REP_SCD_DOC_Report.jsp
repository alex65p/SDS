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
            class Report_SCD_DOC extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    String strTPL_DOC = "";
                    String strCAG_DOC = "";
                    java.sql.Date dDAT_REV_D = null;
                    java.sql.Date dDAT_REV_A = null;
                    String strTIT_DOC = "";
                    String strRSP_DOC = "";
                    String strREV_DOC = "";
                    String strNB_ORDER = "";
                    //--- per sort
                    String strSORT_DAT_REV = ", 'a'.'dat_rev_doc' desc ";
                    String strSORT_TPL_DOC = "X";
                    //------------------------------------
                    if (request.getParameter("COD_AZL") != null) {
                        lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda"), request.getParameter("COD_AZL"), true);
                    }
                    if (request.getParameter("TPL_DOC") != null) {
                        strTPL_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Dati.tipologie"), request.getParameter("TPL_DOC"), false);
                    }
                    if (request.getParameter("CAG_DOC") != null) {
                        strCAG_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Dati.categorie"), request.getParameter("CAG_DOC"), false);
                    }
                    if (request.getParameter("DAT_REV_D") != null) {
                        dDAT_REV_D = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.revisione.dal"), request.getParameter("DAT_REV_D"), false);
                    }
                    if (request.getParameter("DAT_REV_A") != null) {
                        dDAT_REV_A = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.revisione.al"), request.getParameter("DAT_REV_A"), false);
                    }
                    if (request.getParameter("TIT_DOC") != null) {
                        strTIT_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), request.getParameter("TIT_DOC"), false);
                    }
                    if (request.getParameter("RSP_DOC") != null) {
                        strRSP_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"), request.getParameter("RSP_DOC"), false);
                    }
                    if (request.getParameter("REV_DOC") != null) {
                        strREV_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Revisione"), request.getParameter("REV_DOC"), false);
                    }
                    if (request.getParameter("NB_ORDER") != null) {
                        strNB_ORDER = c.checkString(ApplicationConfigurator.LanguageManager.getString("Order.by"), request.getParameter("NB_ORDER"), false);
                    }
                    //---- per sort
                    if (request.getParameter("SORT_DAT_REV") != null) {
                        strSORT_DAT_REV = c.checkString("", request.getParameter("SORT_DAT_REV"), false);
                    }
                    if (request.getParameter("SORT_TPL_DOC") != null) {
                        strSORT_TPL_DOC = c.checkString("", request.getParameter("SORT_TPL_DOC"), false);
                    }

                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors()); 
                        closeDocument();
                        return;
                         */
                        //Il codice sopra commentato dava luogo al bug 1.85
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dDAT_REV_D != null) && (dDAT_REV_A != null)) {
                        if (dDAT_REV_D.compareTo(dDAT_REV_A) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0081"));
                            closeDocument();
                            return;
                             */
                            //Il codice sopra commentato dava luogo al bug 1.85
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0081") +
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
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.documenti/versioni"), "", null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.documenti/versioni"));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    {
                        IAnagrDocumentoHome home = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getAnagrDocumento_to_SCH_DOC_View(lCOD_AZL, strTPL_DOC, strCAG_DOC, strTIT_DOC, strRSP_DOC, strREV_DOC, dDAT_REV_D, dDAT_REV_A, strNB_ORDER, strSORT_DAT_REV, strSORT_TPL_DOC);
                        CenterMiddleTable tbl = new CenterMiddleTable(3);
                        tbl.toLeft();
                        int width[] = {15, 50, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.rev."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia.documento"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Categoria"));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            AnagrDocumento_to_SCH_DOC_View nr = (AnagrDocumento_to_SCH_DOC_View) it_nr.next();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                            tbl.addCell(Formatter.format(nr.DAT_REV_DOC));
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                            tbl.addCell(Formatter.format(nr.NOM_TPL_DOC));
                            tbl.addCell(Formatter.format(nr.NOM_CAG_DOC));
                        }
                        m_document.add(tbl);
                    }
                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
