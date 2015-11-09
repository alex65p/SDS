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
            class Report_SCD_PSD_ACD extends Report {

                private JspWriter myOut;

                public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
                    long lCOD_CAG_PSD_ACD = 0;
                    String SCH_PSD_ACD = "";
                    String strSTA_INT = "";
                    String strCAG_DOC = "";
                    String strNOM_RSP_INR = "";
                    String strNOM_CAG_PSD_ACD = "";
                    String strIDE_PSD_ACD = "";
                    //--- per sort
                    String strRAGGRUPPATI = "";
                    String strSORT_PIF = ", a.dat_pif_inr desc ";
                    String strSORT_INT = "X";
                    String strSORT_RSP = "X";

                    java.sql.Date dDAT_PIF_INR_DAL = null;
                    java.sql.Date dDAT_PIF_INR_AL = null;
                    java.sql.Date dDAT_INR_DAL = null;
                    java.sql.Date dDAT_INR_AL = null;
                    Checker c = new Checker();

                    if (bStandAlone) {
                        lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
                    }
                    if (request.getParameter("COD_CAG_PSD_ACD") != null) {
                        lCOD_CAG_PSD_ACD = c.checkLong("COD_CAG_PSD_ACD", request.getParameter("COD_CAG_PSD_ACD"), false);
                    }

                    SCH_PSD_ACD = request.getParameter("SCH_PSD_ACD");
                    if (request.getParameter("STA_INT") != null) {
                        strSTA_INT = c.checkString("STA_INT", request.getParameter("STA_INT"), false);
                    }
                    if (request.getParameter("CAG_DOC") != null) {
                        strCAG_DOC = c.checkString("CAG_DOC", request.getParameter("CAG_DOC"), false);
                    }
                    if (request.getParameter("NOM_RSP_INR") != null) {
                        strNOM_RSP_INR = c.checkString(ApplicationConfigurator.LanguageManager.getString("Dati.categorie"), request.getParameter("NOM_RSP_INR"), false);
                    }
                    if (request.getParameter("NOM_CAG_PSD_ACD") != null) {
                        strNOM_CAG_PSD_ACD = c.checkString("NOM_CAG_PSD_ACD", request.getParameter("NOM_CAG_PSD_ACD"), false);
                    }
                    if (request.getParameter("IDE_PSD_ACD") != null) {
                        strIDE_PSD_ACD = c.checkString("IDE_PSD_ACD", request.getParameter("IDE_PSD_ACD"), false);
                    }

                    if (request.getParameter("DAT_PIF_INR_DAL") != null) {
                        dDAT_PIF_INR_DAL = c.checkDate("DAT_PIF_INR_DAL", request.getParameter("DAT_PIF_INR_DAL"), false);
                    }
                    if (request.getParameter("DAT_PIF_INR_AL") != null) {
                        dDAT_PIF_INR_AL = c.checkDate("DAT_PIF_INR_AL", request.getParameter("DAT_PIF_INR_AL"), false);
                    }
                    if (request.getParameter("DAT_INR_DAL") != null) {
                        dDAT_INR_DAL = c.checkDate("DAT_INR_DAL", request.getParameter("DAT_INR_DAL"), false);
                    }
                    if (request.getParameter("DAT_INR_AL") != null) {
                        dDAT_INR_AL = c.checkDate("DAT_INR_AL", request.getParameter("DAT_INR_AL"), false);
                    }
                    //---- per sort
                    if (request.getParameter("RAGGRUPPATI") != null) {
                        strRAGGRUPPATI = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati"), request.getParameter("RAGGRUPPATI"), false);
                    }
                    if (request.getParameter("SORT_PIF") != null) {
                        strSORT_PIF = c.checkString("SORT_PIF", request.getParameter("SORT_PIF"), false);
                    }
                    if (request.getParameter("SORT_INT") != null) {
                        strSORT_INT = c.checkString("SORT_INT", request.getParameter("SORT_INT"), false);
                    }
                    if (request.getParameter("SORT_RSP") != null) {
                        strSORT_RSP = c.checkString("SORT_RSP", request.getParameter("SORT_RSP"), false);
                    }
                    if (bStandAlone) {
                        lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
                    }

                    if (c.isError) {
                        String err = c.printErrors();
                        /*
                        writeText2(err);
                        closeDocument();
                        return;
                         */
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dDAT_PIF_INR_DAL != null) && (dDAT_PIF_INR_AL != null)) {
                        if (dDAT_PIF_INR_DAL.compareTo(dDAT_PIF_INR_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079"));
                            return;
                             */
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0079") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    if (strSTA_INT.equals("D")) {
                        dDAT_INR_DAL = null;
                        dDAT_INR_AL = null;
                    } else {
                        if ((dDAT_INR_DAL != null) && (dDAT_INR_AL != null)) {
                            if (dDAT_INR_DAL.compareTo(dDAT_INR_AL) > 0) {
                                /*
                                writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0085"));
                                return;
                                 */
                                myOut.print("<script>alert(\"" +
                                        ApplicationConfigurator.LanguageManager.getString("MSG_0085") +
                                        "\");close();</script>");
                                return;
                            }
                        }
                    }
                    IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));

                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.PRESIDI.ANTINCENDIO"), bean.getRAG_SCL_AZL(), "");
                    AddImage();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(bean.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.PRESIDI.ANTINCENDIO"));
                        }
                        m_document.add(tbl);
                    }
                    writeIndent();
                    {// report
                        IPresidiHome home_pre = (IPresidiHome) PseudoContext.lookup("PresidiBean");
                        java.util.Collection col_psd = home_pre.getPresidi_to_SCH_PSD_ACD_View(SCH_PSD_ACD, lCOD_AZL, strSTA_INT, strCAG_DOC, strNOM_RSP_INR, lCOD_CAG_PSD_ACD, strNOM_CAG_PSD_ACD, strIDE_PSD_ACD, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_INR_DAL, dDAT_INR_AL, strRAGGRUPPATI, strSORT_PIF, strSORT_INT, strSORT_RSP);
                        java.util.Iterator it_view = col_psd.iterator();
                        CenterMiddleTable tbl = new CenterMiddleTable(3);
                        tbl.toCenter();
                        int width[] = {22, 20, 58};
                        tbl.setWidths(width);
                        tbl.toCenter();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianificata"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.intervento"));// ok
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));// ok
                        tbl.endHeaders();
                        if (it_view.hasNext()) {
                            while (it_view.hasNext()) {
                                Presidi_to_SCH_PSD_ACD_View psd = (Presidi_to_SCH_PSD_ACD_View) it_view.next();
                                tbl.addCell(Formatter.format(psd.DAT_PIF_INR));
                                tbl.addCell(Formatter.format(psd.DAT_INR));
                                tbl.addCell(Formatter.format(psd.NOM_RSP_INR));
                            }
                        }
                        m_document.add(tbl);
                    }

                    closeDocument();
                }
            }
//==========================================================
/*
        Checker c = new Checker();
        long lCOD_INO=c.checkLong("infortunio", request.getParameter("ID"), true);		
        if ( c.isError){
        return;
        }
        out.clearBuffer();
        Report_SCD_ADT report = new Report_INO(lCOD_INO);
        report.doReport(request, response);*/
%>
