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
<%@ page import="com.apconsulting.luna.ejb.RischioCantiere.*" %>
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
                        IRischioCantiere bean = null;
                        try {
                            IRischioCantiereHome home = (IRischioCantiereHome) PseudoContext.lookup("RischioCantiereBean");
                            bean = home.findByPrimaryKey(new RischioPK(Security.getAzienda(), lCOD_RSO));
                        } catch (Exception ex) {
                            ex.printStackTrace();
                            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                            ex.printStackTrace();
                            return;
                        }
                        try {
                            if (bean != null) {
                                if ((ApplicationConfigurator.isModuleEnabled(MODULES.TIT_4) == true) && (request.getParameter("TAB_NAME").equals("tab1"))) {
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
