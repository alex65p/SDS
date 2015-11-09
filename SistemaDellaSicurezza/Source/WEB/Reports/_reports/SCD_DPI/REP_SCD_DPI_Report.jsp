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
            <version number="1.0" date="15/03/2004" author="Roman Chumachenko">
            <comments>
            <comment date="15/03/2004" author="Roman Chumachenko">
            <description>REP_SCD_DPI_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_DPI extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    java.sql.Date dDAT_PIF_INR_DAL = null;
                    java.sql.Date dDAT_PIF_INR_AL = null;
                    java.sql.Date dEFF_DAT_DAL = null;
                    java.sql.Date dEFF_DAT_AL = null;
                    long lNOM_RES = 0;
                    String lNOM_COR = "";
                    String strRAGGRUPPATI = "N";
                    String strSTA_INT = "";
                    String FR = request.getParameter("strFROM");
                    //--- per sort
                    String strTYPE = "";
                    //----------------------------------------
                    if (request.getParameter("TYPE") != null) {
                        strTYPE = request.getParameter("TYPE");
                    }
                    if (request.getParameter("NOM_COR") != null) {
                        lNOM_COR = c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"), request.getParameter("NOM_COR"), false);
                    }
                    if (request.getParameter("NOM_RES") != null) {
                        lNOM_RES = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."), request.getParameter("NOM_RES"), false);
                    }
                    if (request.getParameter("DAT_PIF_INR_DAL") != null) {
                        dDAT_PIF_INR_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.dal"), request.getParameter("DAT_PIF_INR_DAL"), false);
                    }
                    if (request.getParameter("DAT_PIF_INR_AL") != null) {
                        dDAT_PIF_INR_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.al"), request.getParameter("DAT_PIF_INR_AL"), false);
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
                    // ---- Errors ---
                    if (c.isError) {
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dEFF_DAT_DAL != null) && (dEFF_DAT_AL != null)) {
                        if (dEFF_DAT_DAL.compareTo(dEFF_DAT_AL) > 0) {
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0078") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    if ((dDAT_PIF_INR_DAL != null) && (dDAT_PIF_INR_AL != null)) {
                        if (dDAT_PIF_INR_DAL.compareTo(dDAT_PIF_INR_AL) > 0) {
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
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.D.P.I."), "", null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.D.P.I."));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                    {

                        IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getScadenzario_DPI_View(lCOD_AZL, lNOM_RES, lNOM_COR, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, strSTA_INT, dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE, FR);
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {20, 20, 30, 30};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Pianific."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Interv."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lotto"));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            Scadenzario_DPI_View nr = (Scadenzario_DPI_View) it_nr.next();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                            tbl.addCell(Formatter.format(nr.DAT_PIF_INR));
                            tbl.addCell(Formatter.format(nr.DAT_INR));
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                            tbl.addCell(Formatter.format(nr.NOM_TPL_DPI));
                            tbl.addCell(Formatter.format(nr.IDE_LOT_DPI));
                        }
                        m_document.add(tbl);
                    }

                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
