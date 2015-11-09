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

<%@page import="s2s.utils.text.StringManager"%>
<%
    /*
    <file>
    <versions>	
    <version number="1.0" date="21/05/2007" author="Dario Massaroni">
    <comments>
    <comment date="21/05/2007" author="Dario Massaroni">
    <description>Shablon formi ANA_ORN_Form.jsp</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
    <head>
        <script>
            document.write("<title>" + getCompleteMenuPath(SubMenuAnagraficagenerale,3) + "</title>");
        </script>
        <link rel="stylesheet" href="../_styles/style.css">
        <link rel="stylesheet" href="../_styles/index.css" type="text/css">
    </head>
    <body>
        <table border="0" style="width:290px">
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" class="title" width="100%">
                                <script>
                                    document.write(getCompleteMenuPath(SubMenuAnagraficagenerale,3));
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%@ include file="../_include/ToolBar.jsp" %>
                                <%=ToolBar.buildForHelp(3)%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset>
                        <table border="0">
                            <tr>
                                <td>
                                    <div align="justify" style="width:375px;height:455px;overflow:auto; border:0px solid black;">
                                        <%
                                            IAnagrAttivitaCantieriHome home = (IAnagrAttivitaCantieriHome) PseudoContext.lookup("AnagrAttivitaCantieriBean");
                                            Collection col = home.findEx(null, null, null, Security.getAzienda());
                                        %>
                                        <table class="VIEW_TABLE" border=0 width="100%">
                                            <tr class="VIEW_HEADER_TR">
                                                <td>&nbsp;Num.&nbsp;</td>
                                                <td>&nbsp;Cod.&nbsp;</td>
                                                <td>&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</td>
                                                <td>&nbsp;Descr.&nbsp;</td>
                                                <td>&nbsp;File&nbsp;</td>
                                            </tr>
                                            <%                    
                                                Iterator it = col.iterator();
                                                int i = 1;
                                                while (it.hasNext () 
                                                    ) {
                                                    AnagrAttivitaCantieri_All_View att = (AnagrAttivitaCantieri_All_View) it.next();
                                            %>
                                            <tr class="VIEW_TR" valign="top" INDEX="<%=att.COD_DOC%>">
                                                <td>&nbsp;<%=i++%>&nbsp;</td>
                                                <td>&nbsp;<%=Formatter.format(att.COD)%>&nbsp;</td>
                                                <td>&nbsp;<%=Formatter.format(att.NOM_ATT)%>&nbsp;</td>
                                                <td>&nbsp;<%=Formatter.format(att.DES_ATT)%>&nbsp;</td>
                                                <td>&nbsp;
                                                    <%
                                                        if (StringManager.isNotEmpty(att.FILE_LINK)){
                                                            // DA IMPLEMENTARE FORSE SUCCESSIVAMENTE
                                                        } else
                                                        if (StringManager.isNotEmpty(att.FILE)){
                                                            out.print("<a href=\"ANA_ATT_File.jsp?ID="+att.COD_DOC+"&TYPE=FILE\">"+att.FILE+"</a>");
                                                        }
                                                    %>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <%}%>
                                        </table>                                    
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </body>
</html>
