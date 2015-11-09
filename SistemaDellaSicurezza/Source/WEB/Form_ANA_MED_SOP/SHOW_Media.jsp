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

<%@page import="com.apconsulting.luna.ejb.Media.IMedia"%>
<%@page import="com.apconsulting.luna.ejb.Media.IMediaHome"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServDUVRI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%
    Checker c = new Checker();

    String sCOD_MED_SOP = "";
    long lCOD_MED_SOP = 0;
    Long lCOD_MED = null;
    String sCOD_MED = null;
    String sNOM_MED = "";
    String sDES_MED = "";
    String sFILE = "";

    if (c.isError) {
	out.print("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
	return;
    }

    IMediaHome home_med = null;
    IMedia media = null;

    try {

	byte[] btContent = null;

	if (request.getParameter("COD_MED") != null) {
	    sCOD_MED_SOP = (String) request.getParameter("COD_MED");
	    lCOD_MED_SOP = Long.parseLong(sCOD_MED_SOP);

	    home_med = (IMediaHome) PseudoContext.lookup("MediaBean");
	    media = home_med.findByPrimaryKey(lCOD_MED_SOP);

	    sNOM_MED = media.getNOM_MED();
	    sDES_MED = media.getDES_MED();
	    sFILE = media.getFILE();
	    btContent = media.getMediadata();
	}

	out.clearBuffer();
	response.reset();

	if (btContent == null) {
	    response.setContentType("text/html");
	    ServletOutputStream out1 = response.getOutputStream();
	    out1.write(("<h1>" + ApplicationConfigurator.LanguageManager.getString("L'allegato.risulta.essere.di.dimensione.nulla") + "<p>" + ApplicationConfigurator.LanguageManager.getString("Impossibile.visualizzare") + "</h1>").getBytes());
	    out1.flush();
	    out1.close();
	} else {
	    response.setContentType(media.getMIME());
	    response.setContentLength(media.getMediadata().length);
	    response.setHeader("Content-disposition", "attachment;filename=\"" + media.getFILE() + "\";");
	    ServletOutputStream out1 = response.getOutputStream();
	    out1.write(btContent);
	    out1.flush();
	    out1.close();
	}
    } catch (Exception ex) {
	ex.printStackTrace();
%>
<div id="divErr"><%=ex%></div>
<%
    }
%>
