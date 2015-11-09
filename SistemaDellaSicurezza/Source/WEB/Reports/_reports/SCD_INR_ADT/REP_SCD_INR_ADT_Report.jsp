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
            <description>REP_SCD_INR_ADT_Report.jsp</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */
%>

<%
            class Report_SCD_INR_ADT extends Report {

                private JspWriter myOut;
                //------------------------------------------------------------------------------------------
                public void doReport() throws DocumentException, IOException, BadElementException, Exception {
                    //----------------------------------------------------------------------
                    Checker c = new Checker();
                    //-------------------------------------
                    String strTYPE = "";
                    String newNOM_MAN = "";
                    String strNOM_MIS_PET = "";
                    String strDES_INTERVENTO = "";
                    String strNOM_LUO_FSC = "";
                    String strNOM_MIS_PET_LUO_MAN = "";
                    String strNOM_RSP_INR = "";
                    java.sql.Date dtDT_EFT_DAL = null;
                    java.sql.Date dtDT_EFT_AL = null;
                    java.sql.Date dtDT_PIF_DAL = null;
                    java.sql.Date dtDT_PIF_AL = null;
                    String strSTA_INT = "";
                    String strRG_GROUP = "";
                    String strINR_ADT_AZL = "";
                    String strNB_APL_A = "";
                    //------------------------------------
                    if (request.getParameter("TYPE") != null) {
                        strTYPE = c.checkString("Type", request.getParameter("TYPE"), false);
                    }
                    if (request.getParameter("STA_INT") != null) {
                        strSTA_INT = c.checkString("STA_INT", request.getParameter("STA_INT"), false);
                    }
                    if (request.getParameter("R_T") != null) {
                        strRG_GROUP = c.checkString("R_T", request.getParameter("R_T"), false);
                    }
                    if (request.getParameter("INR_ADT_AZL") != null) {
                        strINR_ADT_AZL = c.checkString("INR_ADT_AZL", request.getParameter("INR_ADT_AZL"), false);
                    }
                    if (!"N".equals(strINR_ADT_AZL)) {
                        strINR_ADT_AZL = "S";
                    }
                    if (request.getParameter("R_APL_A") != null) {
                        strNB_APL_A = c.checkString("R_APL_A", request.getParameter("R_APL_A"), false);
                    }
                    dtDT_PIF_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianif.al"), request.getParameter("DAT_PIF_AL"), false);
                    dtDT_PIF_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianif.dal"), request.getParameter("DAT_PIF_DAL"), false);
                    dtDT_EFT_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.al"), request.getParameter("DAT_EFT_AL"), false);
                    dtDT_EFT_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuata.dal"), request.getParameter("DAT_EFT_DAL"), false);
                    strNOM_RSP_INR = c.checkString("COD_DPD", request.getParameter("COD_DPD"), false);
                    strNOM_MIS_PET_LUO_MAN = c.checkString("COD_MIS_PET_LUO_MAN", request.getParameter("COD_MIS_PET_LUO_MAN"), false);
                    strNOM_LUO_FSC = c.checkString("COD_LUO_FSC", request.getParameter("COD_LUO_FSC"), false);
                    strNOM_MIS_PET = c.checkString("COD_MIS_PET", request.getParameter("COD_MIS_PET"), false);
                    if (request.getParameter("DES_INTER") != null) {
                        strDES_INTERVENTO = c.checkString("DES_INTER", request.getParameter("DES_INTER"), false);
                    }
                    
                    // ---- Errors ---
                    if (c.isError) {
                        /*
                        writeText2(c.printErrors());
                        closeDocument();
                        return;
                         */
                        //Il codice sopra commentato dava luogo al bug 1.84
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }
                    
                    if ((dtDT_EFT_DAL != null) && (dtDT_EFT_AL != null)) {
                        if (dtDT_EFT_DAL.compareTo(dtDT_EFT_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0078"));
                            closeDocument();
                            return;
                             */
                            //Il codice sopra commentato dava luogo al bug 1.84
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0078") +
                                    "\");close();</script>");
                            return;
                        }
                    }
                    
                    if ((dtDT_PIF_DAL != null) && (dtDT_PIF_AL != null)) {
                        if (dtDT_PIF_DAL.compareTo(dtDT_PIF_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0079"));
                            closeDocument();
                            return;
                             */
                            //Il codice sopra commentato dava luogo al bug 1.84
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

                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scadenzario.interventi.di.audit"), CA, null);

                    AddImage();
                    writeIndent();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(azienda.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scadenzario.interventi.di.audit"));
                        }
                        m_document.add(tbl);
                    }
                    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    {
                        IInterventoAudutHome home = (IInterventoAudutHome) PseudoContext.lookup("InterventoAudutBean");
                        //--- create table ----
                        //-------------------------------------------------------------------------
                        java.util.Collection col = home.getGestioneInterventoAudit_SCH_View(lCOD_AZL, strNOM_MIS_PET_LUO_MAN, dtDT_PIF_DAL, dtDT_PIF_AL, dtDT_EFT_DAL, dtDT_EFT_AL, strNOM_MIS_PET, strNOM_RSP_INR, strNOM_LUO_FSC, strDES_INTERVENTO, strSTA_INT, strRG_GROUP, strINR_ADT_AZL, strNB_APL_A, strTYPE);
                        CenterMiddleTable tbl = new CenterMiddleTable(5);
                        tbl.toLeft();
                        int width[] = {15, 15, 30, 25, 15};
                        tbl.setWidths(width);
                        tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                        //--- table header ---
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Pianific."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Interv."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lavoratore"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Misura.prev./prot."));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"));
                        tbl.endHeaders();
                        //--- table body ---
                        java.util.Iterator it_nr = col.iterator();
                        while (it_nr.hasNext()) {
                            GestioneInterventoAudit_SCH_View nr = (GestioneInterventoAudit_SCH_View) it_nr.next();
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
                            tbl.addCell(Formatter.format(nr.DAT_PIF_INR));
                            tbl.addCell(Formatter.format(nr.DAT_ADT));
                            tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
                            tbl.addCell(nr.COG_DPD + " " + nr.NOM_DPD);
                            tbl.addCell(nr.NOM_MIS_PET);
                            tbl.addCell(nr.NOM_LUO_FSC);
                        }
                        m_document.add(tbl);
                    }
                    //---------------------------------------------------------------------------
                    closeDocument();
                }
            }
%>
