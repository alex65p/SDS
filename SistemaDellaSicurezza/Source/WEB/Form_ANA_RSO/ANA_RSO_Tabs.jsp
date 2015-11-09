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
           <version number="1.0" date="26/01/2004" author="Artur Denysenko">
           <comments>
           <comment date="26/01/2004" author="Artur Denysenko">
           RischioFattore
           </comment>
           </comments>
           </version>
           </versions>
           </file>
            */
           response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
           response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
           response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<html>
    <body>
        <script src="../_scripts/Alert.js"></script>
        <script>
            var err = false;
        </script>
        <div id="dContent">
            <%

                        Checker c = new Checker();

                        long lCOD_RSO = c.checkLong("Rischio", request.getParameter("ID_PARENT"), true);

                        if (c.isError) {
                            String err = c.printErrors();
            %><script>alert("<%=err%>");</script><%
                            return;
                        }

                        ////////////////////////////////////////////////////////////////////////////////////////////////
                        IRischio bean = null;
                        try {
                            IRischioHome home = (IRischioHome) PseudoContext.lookup("RischioBean");
                            bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), lCOD_RSO));
                        } catch (Exception ex) {
                            ex.printStackTrace();
                            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                            ex.printStackTrace();
                            return;
                        }
                        try {
                            if (bean != null) {
                                if ((ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV) == false) && (request.getParameter("TAB_NAME").equals("tab1"))) {
                                    out.println(BuildCorsiTab(bean.getCorsiView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR) == false) && (request.getParameter("TAB_NAME").equals("tab2"))) {
                                    out.println(BuildNormativeTab(bean.getNormativeSentenzeView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV) == false) && (request.getParameter("TAB_NAME").equals("tab3"))) {
                                    out.println(BuildDpiTab(bean.getDpiView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV) == false) && (request.getParameter("TAB_NAME").equals("tab4"))) {
                                    out.println(BuildProtocolliTab(bean.getProtocolliSanitariView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR) == false) && (request.getParameter("TAB_NAME").equals("tab5"))) {
                                    out.println(BuildMisurePpTab(bean.getMisurePpView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR) == false) && (request.getParameter("TAB_NAME").equals("tab6"))) {
                                    out.println(BuildDocumentiTab(bean.getDocumentiView(), lCOD_RSO));
                                } else if ((ApplicationConfigurator.isModuleEnabled(MODULES.MOD_DVR_MSR) == true) && (request.getParameter("TAB_NAME").equals("tab1"))) {
                                    out.println(BuildMisurePpTab(bean.getMisurePpView(), lCOD_RSO));
                                }else if ((ApplicationConfigurator.isModuleEnabled(MODULES.TIT_4) == true) && (request.getParameter("TAB_NAME").equals("tab7"))) {
                                    out.println(BuildArt_LeggeTab(bean.getArt_Legge_View(), lCOD_RSO));
                                } else {
                                    return;
                                }
                            }

                        } catch (Exception ex) {
                            ex.printStackTrace();
            %><%
                        }
            %>
        </div>

        <script>
            if (!err){
                parent.tabbar.ReloadTabTable(document);
            }
            else{
                Alert.Error.showNotFound();
            }
        </script>
        <%!
        String BuildCorsiTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='RischioCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Durata") + "</strong>");
                                str.append("<input type='hidden' name='COD_COR' value=''></td>");
                                str.append("<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>");
                                str.append("<td width='514'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
	
                str.append("<table border='0' align='left' width='814' id='RischioCorsi' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioCorso_Durata_Nome_Tipologia_View v=(RischioCorso_Durata_Nome_Tipologia_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_COR+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_COR' value='"+Formatter.format(v.lCOD_COR)+"'>");
                                                str.append("<input type='text' class='inputstyle' readonly style='width: 100px;' class='dataInput' value='"+Formatter.format(v.lDUR_COR_GOR)+"'></td>");
                                                str.append("<td class='dataTd'><input class='inputstyle' type='text' readonly style='width: 200px;' class='dataInput'  value=\""+Formatter.format(v.strNOM_COR)+"\"></td>");
                                                str.append("<td class='dataTd'><input class='inputstyle' type='text' readonly style='width: 514px;' class='dataInput'  value=\""+Formatter.format(v.strNOM_TPL_COR)+"\"></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildNormativeTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='BuildNormativeTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='534'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong>");
                                str.append("<input type='hidden' name='COD_NOR_SEN' value=''></td>");
                                str.append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero.documento") + "</strong></td>");
                                str.append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildNormativeTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioNormativeSentenze_Titolo_Numero_Data_View v=(RischioNormativeSentenze_Titolo_Numero_Data_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_NOR_SEN+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_NOR_SEN' value='"+Formatter.format(v.lCOD_NOR_SEN)+"'>");
                                                str.append("<input type='text' class='inputstyle' readonly style='width: 534px;' class='dataInput'  value=\""+Formatter.format(v.strTIT_NOR_SEN)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 140px;' class='dataInput'  value='"+Formatter.format(v.strNUM_DOC_NOR_SEN)+"'></td>");
                                                str.append("<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 140px;' class='dataInput'  value='"+Formatter.format(v.dtDAT_NOR_SEN)+"'></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildDpiTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='BuildDpiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='534'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong>");
                                str.append("<input type='hidden' name='COD_TPL_DPI' value=''></td>");
                                str.append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Sostituzione") + "</strong></td>");
                                str.append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Manutenzione") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildDpiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioDpi_Tipologia_Sostuzione_Manutenzione_View v=(RischioDpi_Tipologia_Sostuzione_Manutenzione_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_TPL_DPI+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_TPL_DPI' value='"+Formatter.format(v.lCOD_TPL_DPI)+"'>");
                                                str.append("<input type='text' class='inputstyle' readonly style='width: 534px;' class='dataInput'  value=\""+Formatter.format(v.strNOM_TPL_DPI)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 140px;' class='dataInput'  value='"+Formatter.format(v.lPER_MES_SST)+"'></td>");
                                                str.append("<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 140px;' class='dataInput'  value='"+Formatter.format(v.lPER_MES_MNT)+"'></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildProtocolliTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0'align='left' width='814' id='BuildProtocolliTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='814'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong>");
                                str.append("<input type='hidden' name='COD_PRO_SAN' value=''></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildProtocolliTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd' width='814'><input type='text' class='inputstyle' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioProtocolliSanitari_Nome_View v=(RischioProtocolliSanitari_Nome_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_PRO_SAN+"'>");
                                                str.append("<td class='dataTd' width='100%'><input type='hidden' name='COD_PRO_SAN' value='"+Formatter.format(v.lCOD_PRO_SAN)+"'>");
                                                str.append("<input type='text' class='inputstyle' readonly style='width: 814px;' class='dataInput'  value=\""+Formatter.format(v.strNOM_PRO_SAN)+"\"></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildMisurePpTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='BuildMisurePpTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='407'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong>");
                                str.append("<input type='hidden' name='COD_MIS_PET' value=''></td>");
                                str.append("<td width='407'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildMisurePpTab1' class='dataTable' cellpadding='0' cellspacing='0' style='border:1'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioMisurePp_Nome_Descrizione_View v=(RischioMisurePp_Nome_Descrizione_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_MIS_PET+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_MIS_PET' value='"+Formatter.format(v.lCOD_MIS_PET)+"'>");
                                                str.append("<input type='text' class='inputstyle' readonly style='width: 407px;' value=\""+Formatter.format(v.strNOM_MIS_PET)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' class='inputstyle' readonly style='width: 407px;' value=\""+Formatter.format(v.strDES_MIS_PET)+"\"></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildDocumentiTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='BuildDocumentiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='474'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong>");
                                str.append("<input type='hidden' name='COD_DOC' value=''></td>");
                                str.append("<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>");
                                str.append("<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildDocumentiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");
		
                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        RischioDocumenti_View v=(RischioDocumenti_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.lCOD_DOC+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_DOC' value='"+Formatter.format(v.lCOD_DOC)+"'>");
                                                str.append("<input type='text' readonly style='width: 474px;' class='inputstyle' value=\""+Formatter.format(v.strTIT_DOC)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(v.strRSP_DOC)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' readonly style='width: 140px;'  class='inputstyle'  value=\""+Formatter.format(v.dtDAT_REV_DOC)+"\"></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        String BuildArt_LeggeTab(java.util.Collection col, long lCOD_RSO)
        {
                StringBuffer str = new StringBuffer();
                str.append("<table border='0' align='left' width='814' id='BuildDocumentiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
                        str.append("<tr>");
                                str.append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Art") + "</strong>");
                                str.append("<input type='hidden' name='COD_DOC' value=''></td>");
                                str.append("<td width='714'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>");
                        str.append("</tr>");
                str.append("</table>");
                str.append("<table border='0' align='left' width='814' id='BuildDocumentiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
                        str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO)+"'>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                                        str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
                        str.append("</tr>");

                                java.util.Iterator it = col.iterator();
                                while(it.hasNext()){
                                        Rischio_Art_Legge_View v=(Rischio_Art_Legge_View)it.next();
                                str.append("<tr INDEX='"+Formatter.format(lCOD_RSO)+"' ID='"+v.COD_ARL+"'>");
                                                str.append("<td class='dataTd'><input type='hidden' name='COD_ARL' value='"+Formatter.format(v.COD_ARL)+"'>");
                                                str.append("<input type='text' readonly style='width: 100px;' class='inputstyle' value=\""+Formatter.format(v.NOM_ARL)+"\"></td>");
                                                str.append("<td class='dataTd'><input type='text' readonly style='width: 714px;' class='inputstyle'  value=\""+Formatter.format(v.DES_ARL)+"\"></td>");
                                        str.append("</tr>");
                                }
                        str.append("</table>");
                return str.toString();
        }

        %>
