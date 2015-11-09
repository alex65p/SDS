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
            class Report_SCD_ADT extends Report {

                private JspWriter myOut;

                public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------

                    Checker c = new Checker();

                    if (bStandAlone) {
                        lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
                    }
                    long lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"), request.getParameter("COD_DPD"), false);
                    String strTIT_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), request.getParameter("TIT_SGZ"), false);
                    String strNOM_RIL_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rilevatore"), request.getParameter("NOM_RIL_SGZ"), false);
                    java.sql.Date dDAT_SGZ_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.segnalazione.dal"), request.getParameter("DAT_SGZ_DAL"), false);
                    java.sql.Date dDAT_SGZ_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.segnalazione.al"), request.getParameter("DAT_SGZ_AL"), false);
                    java.sql.Date dDAT_SCA_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.scadenza.dal"), request.getParameter("DAT_SCA_DAL"), false);
                    java.sql.Date dDAT_SCA_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.scadenza.al"), request.getParameter("DAT_SCA_AL"), false);
                    String strRG_GROUP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati"), request.getParameter("RG_GROUP"), true);
                    String strSTA_INT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"), request.getParameter("STA_INT"), false);
                    String strVAR_SGZ = request.getParameter("SORT_DAT_SGZ");
                    String strVAR_SCA = request.getParameter("SORT_DAT_SCA");

                    if ("".equals(strSTA_INT)) {
                        strSTA_INT = "N";
                    }

                    if (c.isError) {
                        String err = c.printErrors();
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dDAT_SGZ_DAL != null) && (dDAT_SGZ_AL != null)) {
                        if (dDAT_SGZ_DAL.compareTo(dDAT_SGZ_AL) > 0) {
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0076") +
                                    "\");close();</script>");
                            return;
                        }
                    }

                    if ((dDAT_SCA_DAL != null) && (dDAT_SCA_AL != null)) {
                        if (dDAT_SCA_DAL.compareTo(dDAT_SCA_AL) > 0) {
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0077") +
                                    "\");close();</script>");
                            return;
                        }
                    }
                    IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));
                    IRapportiniSegnalazioneHome home_rap = (IRapportiniSegnalazioneHome) PseudoContext.lookup("RapportiniSegnalazioneBean");
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.SEGNALAZIONE.D'AUDIT"), "", "");
                    AddImage();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(bean.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.SEGNALAZIONE.D'AUDIT"));
                        }
                        m_document.add(tbl);
                    }
                    writeIndent();
                    {// report
                        java.util.Collection col_view = home_rap.getRapportini_View(lCOD_AZL, lCOD_DPD, strTIT_SGZ, strNOM_RIL_SGZ, dDAT_SGZ_DAL, dDAT_SGZ_AL, dDAT_SCA_DAL, dDAT_SCA_AL, strRG_GROUP, strSTA_INT, strVAR_SGZ, strVAR_SCA);
                        java.util.Iterator it_view = col_view.iterator();
                        CenterMiddleTable tbl = new CenterMiddleTable(3);
                        tbl.toCenter();
                        int width[] = {22, 20, 58};
                        tbl.setWidths(width);
                        tbl.toCenter();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Segnalazione"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.scadenza"));// ok
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));// ok
                        tbl.endHeaders();
                        if (it_view.hasNext()) {
                            while (it_view.hasNext()) {
                                Rapportini_View view = (Rapportini_View) it_view.next();
                                tbl.addCell(Formatter.format(view.DAT_SGZ));
                                tbl.addCell(Formatter.format(view.DAT_SCA));
                                tbl.addCell(Formatter.format(view.NOM_DPD));
                            }
                        }

                        m_document.add(tbl);
                    }
                    closeDocument();
                }
            }
//==========================================================
%>
