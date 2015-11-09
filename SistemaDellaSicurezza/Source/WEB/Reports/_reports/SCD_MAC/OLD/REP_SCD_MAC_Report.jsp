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
            <description>REP_SCD_MAC_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_MAC extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    String strTYPE = "";
                    String strSCH_MAC = "";
                    String strSTA_INT = "";
                    String NB_COD_MAC = "0";
                    String NB_COD_DPD = "0";
                    String NB_ATI_SVO = "";
                    String RG_GROUP = "";
                    java.sql.Date dDAT_PIF_INR_DAL = null;
                    java.sql.Date dDAT_PIF_INR_AL;
                    java.sql.Date dDAT_ATI_MNT_DAL = null;
                    java.sql.Date dDAT_ATI_MNT_AL = null;
                    //------------------------------------
                    if (request.getParameter("TYPE") != null) {
                        strTYPE = request.getParameter("TYPE");
                    }

                    strSTA_INT = c.checkString("STA_INT", request.getParameter("STA_INT"), false);
                    RG_GROUP = c.checkString("RG_GROUP", request.getParameter("R_T"), false);
                    strSCH_MAC = c.checkString("strSCH_MAC", request.getParameter("SCH_MAC"), false);
                    NB_COD_MAC = c.checkString("NB_COD_MAC", request.getParameter("COD_MAC"), false);
                    dDAT_PIF_INR_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianif.al"), request.getParameter("DAT_PIF_AL"), false);
                    dDAT_PIF_INR_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianif.dal"), request.getParameter("DAT_PIF_DAL"), false);
                    dDAT_ATI_MNT_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.intervento.al"), request.getParameter("DAT_EFT_AL"), false);
                    dDAT_ATI_MNT_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.intervento.dal"), request.getParameter("DAT_EFT_DAL"), false);
                    NB_COD_DPD = c.checkString("NB_COD_DPD", request.getParameter("COD_DPD"), false);
                    NB_ATI_SVO = c.checkString("NB_ATI_SVO", request.getParameter("ATI_SVO"), false);

                    // ---- Errors ---
                    if (c.isError) {
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dDAT_ATI_MNT_DAL != null) && (dDAT_ATI_MNT_AL != null)) {
                        if (dDAT_ATI_MNT_DAL.compareTo(dDAT_ATI_MNT_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0085"));
                            closeDocument();
                            return;
                             */
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0085") +
                                    "\");close();</script>");
                            return;
                        }
                    }
                    if ((dDAT_PIF_INR_DAL != null) && (dDAT_PIF_INR_AL != null)) {
                        if (dDAT_PIF_INR_DAL.compareTo(dDAT_PIF_INR_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079"));
                            closeDocument();
                            return;
                             */
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
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.macchine/attrezzature"), "", null);
                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.macchine/attrezzature"));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


                    {

                        ISchedaAttivitaSegnalazioneHome home = (ISchedaAttivitaSegnalazioneHome) PseudoContext.lookup("SchedaAttivitaSegnalazioneBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getMacchina_for_SCHMAC_View(lCOD_AZL, strSCH_MAC, strSTA_INT, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_ATI_MNT_DAL, dDAT_ATI_MNT_AL, RG_GROUP, new Long(NB_COD_MAC).longValue(), new Long(NB_COD_DPD).longValue(), NB_ATI_SVO, strTYPE);
                        CenterMiddleTable tbl = new CenterMiddleTable(4);
                        tbl.toLeft();
                        int width[] = {15, 15, 35, 35};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.pianif."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.interv."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Macchina/Attrezzatura"));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            Macchina_for_SCHMAC_View nr = (Macchina_for_SCHMAC_View) it_nr.next();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                            tbl.addCell(Formatter.format(nr.DAT_PIF_INR));
                            tbl.addCell(Formatter.format(nr.DAT_ATI_MNT));
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                            tbl.addCell(Formatter.format(nr.DIP));
                            tbl.addCell(Formatter.format(nr.DES_MAC));
                        }
                        m_document.add(tbl);
                    }
                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
