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
<version number="1.0" date="05/02/2004" author="Artur Denysenko">
<comments>
<comment date="05/02/2004" author="Artur Denysenko">
<description>Realizazija EJB dlia objecta AnagrDocumento</description>
</comment>
<comment date="01/07/2004" author="Roman Chumachenko">
<description>Realisation of downloading document</description>
</comment>
</comments>
</version>
</versions>
</file>
*/
%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServDUVRI.*" %>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%
Checker c = new Checker();
String strNOM_TAB=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.tabella"), request.getParameter("NOM_TAB"),true);
long lCOD_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Codice.documento"), request.getParameter("ID"),true);

if (c.isError){
    out.print("<script>err=true;alert(\""+c.printErrors()+"\");</script>");
    return;
}
try{
    String fileType = request.getParameter("TYPE");

    IAnagrDocumentoHome home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
    IContServIspezioniHome homeIsp=(IContServIspezioniHome)PseudoContext.lookup("ContServIspezioniBean");
    IContServDUVRIHome homeDuvri=(IContServDUVRIHome)PseudoContext.lookup("ContServDUVRIBean");
    IValutazioneRischiHome homeDvr = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
    AnagDocumentoFileInfo info = null;
    Ispezioni_FileInfo infoIspezioni = null;
    
    // Estraggo le informazioni del file.
    if (fileType.equals("FILE")){
        info=home.getFileInfoU(strNOM_TAB, lCOD_DOC);
    } else
    if (fileType.equals("FILE_LINK")){
        info=home.getFileInfoULink(strNOM_TAB, lCOD_DOC);
    } else
    if (fileType.equals("FILE_ISP")){
        infoIspezioni=homeIsp.getFileInfo(lCOD_DOC);
    }    
    if (fileType.equals("FILE_DUVRI") == false && fileType.equals("FILE_DVR") == false){
        if (info==null && infoIspezioni==null) throw new 
            Exception(ApplicationConfigurator.LanguageManager.getString("File.non.trovato"));
    }
    
    out.clearBuffer();
    response.reset();
    
    // Estraggo il contenuto del file.
    byte[] btContent = null;
    if (fileType.equals("FILE")){
        btContent=home.downloadFileU(strNOM_TAB, lCOD_DOC);
    } else
    if (fileType.equals("FILE_LINK")){
        btContent=home.downloadFileULink(strNOM_TAB, lCOD_DOC);
    } else
    if (fileType.equals("FILE_ISP")){
        btContent=homeIsp.downloadFile(lCOD_DOC);
    } else
    if (fileType.equals("FILE_DUVRI")){
        btContent=homeDuvri.downloadFile(lCOD_DOC);
    } else
    if (fileType.equals("FILE_DVR")){
        btContent=homeDvr.downloadFileArchivio(lCOD_DOC);
    }
           
    if( btContent == null ) {
        response.setContentType("text/html");
        ServletOutputStream out1 = response.getOutputStream();
        out1.write(("<h1>"+ApplicationConfigurator.LanguageManager.getString("L'allegato.risulta.essere.di.dimensione.nulla")+"<p>"+ApplicationConfigurator.LanguageManager.getString("Impossibile.visualizzare")+"</h1>").getBytes());
        out1.flush();
        out1.close();
    } else {
        response.setContentLength(btContent.length);
        if (fileType.equals("FILE_ISP")){
            response.setContentType(infoIspezioni.strContentType);
            response.setHeader("Content-disposition", "attachment;filename=\""+infoIspezioni.strName+"\";");
        } else 
        if (fileType.equals("FILE_DUVRI")){
            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "attachment;filename=\"duvri.pdf\";");
        } else 
        if (fileType.equals("FILE_DVR")){
            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "attachment;filename=\"dvr.pdf\";");
        } else {
            response.setContentType(info.strContentType);
            response.setHeader("Content-disposition", "attachment;filename=\""+info.strName+"\";");
        }
        ServletOutputStream out1 = response.getOutputStream();
        out1.write(btContent);
        out1.flush();
        out1.close();
    }
} catch(Exception ex){
    ex.printStackTrace();
%>
<div id="divErr"><%=ex%></div>
<%
}
%>
