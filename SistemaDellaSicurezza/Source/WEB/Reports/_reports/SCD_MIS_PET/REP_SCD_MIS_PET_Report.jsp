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
            <description>REP_SCD_MIS_PET_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_MIS_PET extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    String strNB_APL_A = "";
                    String strNB_GROUP = "";
                    long lCOD_MIS_PET = 0;
                    long lCOD_TPL_MIS_PET = 0;
                    String strNB_NOM_MIS_PET = "";
                    String strNB_NOM_RSO = "";
                    String strNB_DES_TPL_MIS_PET = "";
                    long lCOD_MIS_PET_LUO_MAN = 0;
                    java.sql.Date dNB_DAT_PNZ_MIS_PET_DAL = null;
                    java.sql.Date dNB_DAT_PNZ_MIS_PET_AL = null;
                    java.sql.Date dNB_DAT_CMP_DAL = null;
                    java.sql.Date dNB_DAT_CMP_AL = null;
                    String strSORT_DAT_PAR_ADT = "X";
                    //-------------------------------------------
                    if (request.getParameter("NB_APL_A") != null) {
                        strNB_APL_A = c.checkString(ApplicationConfigurator.LanguageManager.getString("Azienda"), request.getParameter("NB_APL_A"), false);
                    }
                    if (strNB_APL_A == null || strNB_APL_A.equals("")) {
                        strNB_APL_A = "M";
                    }
                    if (request.getParameter("NB_GROUP") != null) {
                        strNB_GROUP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Azienda"), request.getParameter("NB_GROUP"), false);
                    }
                    if (strNB_GROUP == null || strNB_GROUP.equals("")) {
                        strNB_GROUP = "N";
                    }
                    if (request.getParameter("COD_MIS_PET") != null) {
                        lCOD_MIS_PET = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione"), request.getParameter("COD_MIS_PET"), false);
                    }
                    if (request.getParameter("COD_TPL_MIS_PET") != null) {
                        lCOD_TPL_MIS_PET = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione"), request.getParameter("COD_TPL_MIS_PET"), false);
                    }
                    if (request.getParameter("NB_DAT_PNZ_MIS_PET_DAL") != null) {
                        dNB_DAT_PNZ_MIS_PET_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.dal"), request.getParameter("NB_DAT_PNZ_MIS_PET_DAL"), false);
                    }
                    if (request.getParameter("NB_DAT_PNZ_MIS_PET_AL") != null) {
                        dNB_DAT_PNZ_MIS_PET_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificata.al"), request.getParameter("NB_DAT_PNZ_MIS_PET_AL"), false);
                    }
                    //----------------------------------------
                    if (request.getParameter("NOM_RSO") != null) {
                        strNB_NOM_RSO = c.checkString("NB_NOM_RSO", request.getParameter("NOM_RSO"), false);
                    }
                    if (request.getParameter("NOM_MIS_PET") != null) {
                        strNB_NOM_MIS_PET = c.checkString("NB_NOM_MIS_PET", request.getParameter("NOM_MIS_PET"), false);
                    }
                    if (request.getParameter("NB_DES_TPL_MIS_PET") != null) {
                        strNB_DES_TPL_MIS_PET = c.checkString("NB_DES_TPL_MIS_PET", request.getParameter("NB_DES_TPL_MIS_PET"), false);
                    }
                    if (request.getParameter("COD_MIS_PET_LUO_MAN") != null) {
                        lCOD_MIS_PET_LUO_MAN = c.checkLong("COD_MIS_PET_LUO_MAN", request.getParameter("COD_MIS_PET_LUO_MAN"), false);
                    }
                    if (request.getParameter("SORT_DAT_PAR_ADT") != null) {
                        strSORT_DAT_PAR_ADT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Data.pianif."), request.getParameter("SORT_DAT_PAR_ADT"), false);
                    }

                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors());
                        closeDocument();
                        return;
                        */
                        //Il codice sopra commentato dava luogo al bug 1.82
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }
                    
                    if ((dNB_DAT_PNZ_MIS_PET_DAL != null) && (dNB_DAT_PNZ_MIS_PET_AL != null)) {
                        if (dNB_DAT_PNZ_MIS_PET_DAL.compareTo(dNB_DAT_PNZ_MIS_PET_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079"));
                            return;
                            */
                            //Il codice sopra commentato dava luogo al bug 1.82
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
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.misure.di.prevenzione/protezione"), CA, null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.misure.di.prevenzione/protezione"));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    {
                        IMisuraPreventivaHome MisuraHome = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col_nr = MisuraHome.getMisuraPreventiva_to_SCH_MIS_PET_View(lCOD_AZL, strNB_APL_A, strNB_NOM_RSO, lCOD_MIS_PET_LUO_MAN, strNB_NOM_MIS_PET, strNB_DES_TPL_MIS_PET, dNB_DAT_CMP_DAL, dNB_DAT_CMP_AL, dNB_DAT_PNZ_MIS_PET_DAL, dNB_DAT_PNZ_MIS_PET_AL, strNB_GROUP, strSORT_DAT_PAR_ADT);
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {20, 15, 30, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.comp."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianif."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione"));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col_nr.iterator();
                        while (it_nr.hasNext()) {
                            MisuraPreventiva_to_SCH_MIS_PET_View nr = (MisuraPreventiva_to_SCH_MIS_PET_View) it_nr.next();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                            tbl.addCell(Formatter.format(nr.DAT_CMP));
                            tbl.addCell(Formatter.format(nr.DAT_PNZ_MIS_PET));
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                            tbl.addCell(Formatter.format(nr.DES_TPL_MIS_PET));
                            tbl.addCell(Formatter.format(nr.NOM_MIS_PET));
                        }
                        m_document.add(tbl);
                    }
                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
