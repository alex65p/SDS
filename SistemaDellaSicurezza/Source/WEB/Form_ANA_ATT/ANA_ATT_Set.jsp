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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@page import="com.apconsulting.luna.ejb.AnagrAttivitaCantieri.*"%>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="org.apache.commons.fileupload.*"%>

<%!    String ReqMODE;	// parameter of request %>
<script type="text/javascript">
    var err=false;
    var isNew=false;
    var bRefresh=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    java.util.Hashtable hs = new java.util.Hashtable();

    try {
        // Create a new file upload handler
        DiskFileUpload upload = new DiskFileUpload();

        // Set upload parameters
        upload.setSizeMax(999999999L);
        //upload.setSizeThreshold(100000);
        //upload.setRepositoryPath(null);

        List items = upload.parseRequest(request);
        //if(true) return;

        Iterator iter = items.iterator();
        while (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();
            out.println(item.getFieldName() + "<br>");
            if (item.isFormField()) {
                hs.put(item.getFieldName(), item.getString());
            } else {
                hs.put(item.getFieldName(), item);
            }
        }
    } catch (Exception ex) {
%>
<div id="divErr">
    <%=ex%>
</div>
<%
        System.err.println("Eccezione:" + ex.getMessage());
        ex.printStackTrace(System.err);
        out.print("<script>err=true;alert(divErr.innerText);</script>");
    }

    IAnagrAttivitaCantieri bean = null;
    IAnagrAttivitaCantieriHome home = (IAnagrAttivitaCantieriHome) PseudoContext.lookup("AnagrAttivitaCantieriBean");
    Checker c = new Checker();

    //- checking for required fields
    Long lCOD_DOC = c.checkLong("COD_DOC", (String) hs.get("COD_DOC"), true);
    String strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), (String) hs.get("COD"), true);
    String strNOM_ATT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), (String) hs.get("NOM_ATT"), true);                                 //3
    String strDES_ATT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), (String) hs.get("DES_ATT"), false);
    long lCOD_AZL = Security.getAzienda();//c.checkLong("COD_AZL",(String)hs.get("COD_AZL"),false);

    if (c.isError) {
%>
<div id="divError"></div>
<%
        out.print("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    if ((String) hs.get("SBM_MODE") != null) {
        try {
            ReqMODE = (String) hs.get("SBM_MODE");
            out.println(ReqMODE);

            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new Long(lCOD_DOC));
                bean.setstrDES_ATT(strDES_ATT);
                bean.setstrCOD(strCOD);
                bean.setstrNOM_ATT(strNOM_ATT);
            } else {
                bean = home.create(strDES_ATT, strCOD, strNOM_ATT, lCOD_AZL);
                lCOD_DOC = bean.getlCOD_DOC();
%>
<script type="text/javascript">
    isNew=true;
</script>
<%
    }
    if (bean != null) {
        bean.setstrDES_ATT(strDES_ATT);
        bean.setstrNOM_ATT(strNOM_ATT);
        bean.setstrCOD(strCOD);
    }
    // --------------- UPLOAD -------------------------

    if (hs.get("ATTACHMENT_ACTION") == null) {
        FileItem item = (FileItem) hs.get("ATTACHMENT_FILE");
        if (item != null && item.getName() != null && !item.getName().equals("")) {
            bean.deleteFile();

            String str = item.getName();
            str = str.substring(str.lastIndexOf('/') + 1, str.length());
            str = str.substring(str.lastIndexOf('\\') + 1, str.length());

            bean.uploadFile(str, item.getContentType(), item.get());
%>
<script type="text/javascript">bRefresh=true;</script><%
    }
} else if ("delete".equals(hs.get("ATTACHMENT_ACTION"))) {
    bean.deleteFile();
%><script type="text/javascript">bRefresh=true;</script><%
    }//--------------- UPLOAD -------------------------

// Inizio modifica gestione link esterno documenti
    if (hs.get("ATTACHMENT_ACTION_LINK") == null) {
        FileItem item = (FileItem) hs.get("ATTACHMENT_FILE_LINK");
        if (item != null && item.getName() != null && !item.getName().equals("")) {
            bean.deleteFileLink();
            String str = item.getName();
            bean.uploadFileLink(str, item.getContentType(), item.get());
            out.println("<script>bRefresh=true;</script>");
        }
    } else if ("delete".equals(hs.get("ATTACHMENT_ACTION_LINK"))) {
        bean.deleteFileLink();
        out.println("<script>bRefresh=true;</script>");
    }

// Fine modifica gestione link esterno documenti
} catch (Exception ex) {
%>
<div id="divErr">
    <%=ex%>
</div>
<script type="text/javascript">err=true;</script>
<%
            System.err.println("Eccezione:" + ex.getMessage());
            ex.printStackTrace(System.err);
        }
    }
%>
<script type="text/javascript">
    if (!err){
        if(isNew){
            Alert.Success.showCreated()
            parent.ToolBar.OnNew("ID=<%=lCOD_DOC%>");
        }
        else{
            Alert.Success.showSaved();
            if (bRefresh) parent.ToolBar.OnNew("ID=<%=lCOD_DOC%>");
        }
    }
    else{
        Alert.Error.showDublicate();
    }
</script>
