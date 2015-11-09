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
            class Report_SCD_RIV_RSO extends Report {

                private JspWriter myOut;

                public void doReport() throws DocumentException, IOException, BadElementException, Exception { //----------------------------------------------------------------------
                    long lCOD_RSO = 0;
                    long lCOD_FAT_RSO = 0;

                    String strSTA_RSO = "";
                    java.sql.Date dtDT_RIV_DAL = null;
                    java.sql.Date dtDT_RIV_AL = null;
                    String strRG_GROUP = "";
                    String strRG_TIP_RSO = "";
                    String strVAR_RIV = "";
                    java.util.Date cdt = new java.util.Date();
                    java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());

                    Checker c = new Checker();

                    if (bStandAlone) {
                        lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
                    }
                    lCOD_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Rischio"), request.getParameter("COD_RSO"), false);
                    lCOD_FAT_RSO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"), request.getParameter("COD_FAT_RSO"), false);
                    strRG_GROUP = c.checkString("Order", request.getParameter("RG_GROUP"), false);
                    dtDT_RIV_AL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.riv.al"), request.getParameter("DAT_RFC_VLU_RSO_AL"), false);
                    dtDT_RIV_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.riv.dal"), request.getParameter("DAT_RFC_VLU_RSO_DAL"), false);
                    strSTA_RSO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"), request.getParameter("STA_RSO"), false);
                    strRG_TIP_RSO = c.checkString("Type", request.getParameter("RG_TIP_RSO"), false);
                    strVAR_RIV = request.getParameter("TYPE");

                    if (c.isError) {
                        String err = c.printErrors();
                        /*
                        writeText2(err);
                        closeDocument();
                        return;
                         */
                        //Il codice sopra commentato dava luogo al bug 1.86
                        myOut.print("<script>err=true;alert(\"" + err + "\");</script>");
                        return;
                    }

                    if ((dtDT_RIV_DAL != null) && (dtDT_RIV_AL != null)) {
                        if (dtDT_RIV_DAL.compareTo(dtDT_RIV_AL) > 0) {
                            /*
                            writeText2(ApplicationConfigurator.LanguageManager.getString("MSG_0086"));
                            return;
                             */
                            //Il codice sopra commentato dava luogo al bug 1.86
                            myOut.print("<script>alert(\"" +
                                    ApplicationConfigurator.LanguageManager.getString("MSG_0086") +
                                    "\");close();</script>");
                            return;
                        }
                    }


                    IAziendaHome home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                    IAzienda bean = home.findByPrimaryKey(new Long(lCOD_AZL));
                    IRischioHome home_rso = (IRischioHome) PseudoContext.lookup("RischioBean");
                    String strTmp = "";
                    initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.RIVALUTAZIONE.RISCHI"), "", strTmp);
                    AddImage();
                    {
                        CenterMiddleTable tbl = new CenterMiddleTable(1);
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
                        tbl.addCell(bean.getRAG_SCL_AZL());
                        if (bStandAlone) {
                            tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.RIVALUTAZIONE.RISCHI"));
                        }
                        m_document.add(tbl);
                    }
                    writeIndent();
                    {// report
                        java.util.Collection col_view = home_rso.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDT_RIV_DAL, dtDT_RIV_AL, strRG_TIP_RSO, strRG_GROUP, strVAR_RIV);
                        java.util.Iterator it_view = col_view.iterator();
                        CenterMiddleTable tbl = new CenterMiddleTable(3);
                        tbl.toCenter();
                        int width[] = {22, 58, 20};
                        tbl.setWidths(width);
                        tbl.toCenter();
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.rivalutazione"));
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rischio"));// ok
                        tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio"));// ok
                        tbl.endHeaders();
                        if (it_view.hasNext()) {
                            while (it_view.hasNext()) {
                                Rischio_foo_SCHRIVRSO_View obj = (Rischio_foo_SCHRIVRSO_View) it_view.next();
                                tbl.addCell(Formatter.format(obj.dtDAT_RFS_VLU_RSO));
                                tbl.addCell(Formatter.format(obj.strNOM_RSO));
                                tbl.addCell(Formatter.format(obj.strNOM_FAT_RSO));
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
