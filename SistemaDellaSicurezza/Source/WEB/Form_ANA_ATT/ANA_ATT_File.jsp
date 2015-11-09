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

<%@page import="com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo"%>
<%

%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%
Checker c = new Checker();
long lCOD_DOC=c.checkLong("Codice Documento", request.getParameter("ID"),true);

if (c.isError){
	out.print("<script>err=true;alert(\""+c.printErrors()+"\");</script>");
	return;
}
	try{
		String fileType = request.getParameter("TYPE");
                IAnagrAttivitaCantieriHome home=(IAnagrAttivitaCantieriHome)PseudoContext.lookup("AnagrAttivitaCantieriBean");
		IAnagrAttivitaCantieri bean=home.findByPrimaryKey(new Long(lCOD_DOC));
                AnagDocumentoFileInfo info = null;

                // Estraggo le informazioni del file.
                if (fileType.equals("FILE")){
                    info=bean.getFileInfo();
                } else
                if (fileType.equals("FILE_LINK")){
                    info=bean.getFileInfoLink();
                }
		if (info==null) throw new Exception("No file found!");

                out.clearBuffer();
		response.reset();

                // Estraggo il contenuto del file.
                byte[] btContent = null;
                if (fileType.equals("FILE")){
                    btContent=bean.downloadFile();
                } else
                if (fileType.equals("FILE_LINK")){
                    btContent=bean.downloadFileLink();
                }

                if( btContent == null )
		{
			response.setContentType("text/html");
			ServletOutputStream out1 = response.getOutputStream();
			out1.write("<h1>L'allegato risulta essere di dimensione nulla.<p>Impossibile visualizzare.</h1>".getBytes());
			out1.flush();
			out1.close();
		}
		else
		{
			response.setContentType(info.strContentType);
			response.setContentLength(btContent.length);
			response.setHeader("Content-disposition", "attachment;filename=\""+info.strName+"\";");
			ServletOutputStream out1 = response.getOutputStream();
			out1.write(btContent);
			out1.flush();
			out1.close();
		}
	}
	catch(Exception ex){
		%>
			<div id="divErr"><%=ex%></div>
		<%
	}
%>
