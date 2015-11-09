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
            <description>REP_SCD_MIS_PET_AZL_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_MIS_PET_AZL extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    long lCOD_MIS_PET_LUO_MAN = 0;
                    String strAPL_A = "";
                    String strNOM_MIS_PET = "";
                    String strDES_TPL_MIS_PET = "";
                    String strNOM_RSO = "";
                    java.sql.Date dDAT_PNZ_MIS_PET_DAL = null;
                    java.sql.Date dDAT_PNZ_MIS_PET_AL = null;
                    String strGROUP = "";
                    String strVAR_PAR_ADT = "";
                    //-------------------------------------------
                    if (request.getParameter("NB_COD_MIS_PET_LUO_MAN") != null) {
                        lCOD_MIS_PET_LUO_MAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Misura"), request.getParameter("NB_COD_MIS_PET_LUO_MAN"), false);
                    }
                    if (request.getParameter("NB_APL_A") != null) {
                        strAPL_A = c.checkString("", request.getParameter("NB_APL_A"), false);
                    }
                    if (request.getParameter("NB_NOM_MIS_PET") != null) {
                        strNOM_MIS_PET = c.checkString(ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione/protezione"), request.getParameter("NB_NOM_MIS_PET"), false);
                    }
                    if (request.getParameter("NB_DES_TPL_MIS_PET") != null) {
                        strDES_TPL_MIS_PET = c.checkString(ApplicationConfigurator.LanguageManager.getString("Tipologia"), request.getParameter("NB_DES_TPL_MIS_PET"), false);
                    }
                    if (request.getParameter("NB_NOM_RSO") != null) {
                        strNOM_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rischio"), request.getParameter("NB_NOM_RSO"), false);
                    }
                    if (request.getParameter("NB_DAT_PNZ_MIS_PET_DAL") != null) {
                        dDAT_PNZ_MIS_PET_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"), request.getParameter("NB_DAT_PNZ_MIS_PET_DAL"), false);
                    }
                    if (request.getParameter("NB_DAT_PNZ_MIS_PET_AL") != null) {
                        dDAT_PNZ_MIS_PET_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.al"), request.getParameter("NB_DAT_PNZ_MIS_PET_AL"), false);
                    }
                    if (request.getParameter("NB_GROUP") != null) {
                        strGROUP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"), request.getParameter("NB_GROUP"), false);
                    }
                    if (request.getParameter("VAR_PAR_ADT") != null) {
                        strVAR_PAR_ADT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Order.by"), request.getParameter("VAR_PAR_ADT"), false);
                    }
                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors());
                        closeDocument();
                        return;
                        */
                        //Il codice sopra commentato dava luogo al bug 1.83
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }
                    
                    if ((dDAT_PNZ_MIS_PET_DAL != null) && (dDAT_PNZ_MIS_PET_AL != null)) {
                        if (dDAT_PNZ_MIS_PET_DAL.compareTo(dDAT_PNZ_MIS_PET_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0081"));
                            return;
                            */
                            //Il codice sopra commentato dava luogo al bug 1.83
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
                        IMisurePreventProtettiveAzHome home = (IMisurePreventProtettiveAzHome) PseudoContext.lookup("MisurePreventProtettiveAzBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getMisurePreventProtettiveAz_foo_View(lCOD_AZL, lCOD_MIS_PET_LUO_MAN, strAPL_A, strNOM_MIS_PET, strDES_TPL_MIS_PET, strNOM_RSO, dDAT_PNZ_MIS_PET_DAL, dDAT_PNZ_MIS_PET_AL, strGROUP, strVAR_PAR_ADT);
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {20, 15, 30, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.comp."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianif."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Misura.di.prev./prot."));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            MisurePreventProtettiveAz_foo_View nr = (MisurePreventProtettiveAz_foo_View) it_nr.next();
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
