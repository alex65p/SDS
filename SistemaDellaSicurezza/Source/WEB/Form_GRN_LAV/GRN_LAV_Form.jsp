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
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.GiorniLavorati.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
        window.dialogWidth="320px";
        window.dialogHeight="180px";
    </script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Giorni lavorati</title>
    </head>
    <link rel="stylesheet" href="../_styles/style.css">
    <body style="margin:0 0 0 0;">
        <%
            String strANNO = "";
            long lANNOID = 0;
            String strGRN_LAV = "";
            IGiorniLavorati bean = null;
            IGiorniLavoratiHome GioLavHome = (IGiorniLavoratiHome) PseudoContext.lookup("GiorniLavoratiBean");
            long lCOD_AZL = new Long(request.getParameter("ID_PARENT"));

            if (request.getParameter("ID") != null) {
                // getting parameters of azienda
                Long ID = new Long(request.getParameter("ID"));
                bean = GioLavHome.findByPrimaryKey(new GiorniLavoratiPK(lCOD_AZL, ID));
                strANNO = Formatter.format(bean.getANNO());
                strGRN_LAV = Formatter.format(bean.getGRN_LAV());
                lANNOID = (bean.getANNO());
            }// if request
%>
        <form action="GRN_LAV_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
            <table border='0'  width='100%' style='height:200'>
	<tr>
  	<td align="center"  valign="top" >
   	<table   border="0" cellpadding="0" cellspacing="0" width="100%">
    	<tr>
				<td align="center" class="title" valign="top" >
				<%=ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati")%>
            <input name="SBM_MODE" type="Hidden" value="<%=(strANNO == "") ? "new" : "edt"%>">
            <input type="hidden" name="COD_AZL" value="<%=lCOD_AZL%>">


            </td>
			</tr>
   	 	<tr>
			  <td>


            <table border="0">
                <!-- ############################################################################## -->
                <%@ include file="../_include/ToolBar.jsp" %>
                <%ToolBar.bShowNew = true;%>
                <%ToolBar.bShowSearch = false;%>
                <%ToolBar.bShowDelete = true;%>
                <%ToolBar.bShowPrint = false;%>
                <%ToolBar.bShowReturn = false;%>
                <%//ToolBar.bShowExit=false;%>
                <%=ToolBar.build(3)%>
                <!-- ############################################################################## -->
            </table>
            <fieldset style="padding:10px 10px 10px 10px">
                <legend><%=ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati")%></legend>
                <table   border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Anno")%>&nbsp;</td>
                        <td><input size="30" id="ANNO" name="ANNO" maxlength="15" value="<%=strANNO%>"></td>
                    </tr>
                    <tr>
                        <td align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati")%>&nbsp;</td>
                        <td><input size="30"  type="text" id="GRN_LAV" name="GRN_LAV" maxlength="15" value="<%=strGRN_LAV%>"></td>
                    </tr>
                    <tr>
                        <td><input size="30"  type="hidden" id="ANNO" name="ANNOID" maxlength="15" value="<%=strANNO%>"></td>
                    </tr>
                </table>
            </fieldset>
                    </td>
			</tr>
   	</table>
	 	</td>
	</tr>
        </form>
        <iframe name="ifrmWork" class="ifrmWork" src="../empty.txt" ></iframe>
        <script>
            ToolBar.Return.setEnabled(false);
        </script>
    </body>
</html>

