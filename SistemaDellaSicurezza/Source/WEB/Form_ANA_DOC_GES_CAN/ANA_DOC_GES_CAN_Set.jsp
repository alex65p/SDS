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
     * <file> <versions> <version number="1.0" date="05/02/2004" author="Artur
     * Denysenko"> <comments> <comment date="05/02/2004" author="Artur
     * Denysenko"> <description>Realizazija EJB dlia objecta AnagrDocumento
     * </comment> </comments> </version> </versions> </file>
     */
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.Sopraluogo.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ page import="org.apache.commons.fileupload.*"%>

<%!    String ReqMODE;	// parameter of request
%>
<script  type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
    var isNew=false;
    var bRefresh=false;
</script>

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
    <%=ex/*
             * .getMessage()
             */%>
</div>
<%
        System.err.println("Eccezione:" + ex.getMessage());
        ex.printStackTrace(System.err);
        out.print("<script>err=true;alert(divErr.innerText);</script>");
    }
%>
<%
//-----start check section--------------------------------
    Checker c = new Checker();

    long lCOD_DOC = c.checkLong("COD_DOC", (String) hs.get("ID"), true);
    long lCOD_TPL_DOC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia"), (String) hs.get("COD_TPL_DOC"), true);
    String strTIT_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"), (String) hs.get("TIT_DOC"), true);
    java.sql.Date dtDAT_DOC = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), (String) hs.get("DAT_DOC"), true);
    String strNUM_DOC = c.checkString(ApplicationConfigurator.LanguageManager.getString("N.Documento"), (String) hs.get("NUM_DOC"), true);
    long lCOD_SOP = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sopralluogo"), (String) hs.get("COD_SOP"), false);
    long lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"), (String) hs.get("procedimento"), true);
    long lCOD_CAN = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Cantiere"), (String) hs.get("cantiere"), true);
    long lCOD_OPE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Opera"), (String) hs.get("opera"), false);
    String strDES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), (String) hs.get("DES"), false);

    long lCOD_AZL = Security.getAzienda();//c.checkLong("COD_AZL",(String)hs.get("COD_AZL"),false);

    boolean isGlobal = (1 == c.checkLong(ApplicationConfigurator.LanguageManager.getString("Globale"), (String) hs.get("IS_GLOBAL"), false));

    if (c.isError) {
%>
<div id="divError"></div>
<%
        out.print("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    if (Security.isConsultant()) {
        if (isGlobal) {
            lCOD_AZL = 0;
        }
    }

    IAnagrDocumentiGestioneCantieriHome home = (IAnagrDocumentiGestioneCantieriHome) PseudoContext.lookup("AnagrDocumentiGestioneCantieriBean");
    IAnagrDocumentiGestioneCantieri bean = null;
    ISopraluogoHome home_sop = (ISopraluogoHome) PseudoContext.lookup("SopraluogoBean");
//------end check section--------------------------------
    if ((String) hs.get("SBM_MODE") != null) {
        try {
            ReqMODE = (String) hs.get("SBM_MODE");
            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new Long(lCOD_DOC));

                bean.setTIT_DOC(strTIT_DOC);
                bean.setNUM_DOC(strNUM_DOC);
                bean.setDES(strDES);
                bean.setDAT_DOC(dtDAT_DOC);
                bean.setCOD_TPL_DOC(lCOD_TPL_DOC);
                bean.setCOD_SOP(lCOD_SOP);
                
                bean.setCOD_PRO_CAN_OPE(lCOD_PRO,lCOD_CAN,lCOD_OPE);                
                
                Integer irc = home_sop.chkPOC_SOP(lCOD_PRO, lCOD_OPE, lCOD_CAN);
                if (irc == 1) {
                    //bean=home.create(strTIT_DOC,strNUM_DOC, dtDAT_DOC,lCOD_TPL_DOC,lCOD_SOP,lCOD_OPE,lCOD_CAN,lCOD_PRO, strDES, lCOD_AZL);
                    //	lCOD_DOC=bean.getCOD_DOC();
                } else {
                    out.println("<script>alert(\"La relazione tra Procedimento - Opera - Cantiere non è corretta\");</script>");
                    return;
                }
            } else {
                Integer irc = home_sop.chkPOC_SOP(lCOD_PRO, lCOD_OPE, lCOD_CAN);
                if (irc == 1) {
                    bean = home.create(strTIT_DOC, strNUM_DOC, dtDAT_DOC, lCOD_TPL_DOC, lCOD_SOP, lCOD_OPE, lCOD_CAN, lCOD_PRO, strDES, lCOD_AZL);
                    lCOD_DOC = bean.getCOD_DOC();
                } else {
                    out.println("<script>alert(\"La relazione tra Procedimento - Opera - Cantiere non è corretta\");</script>");
                    return;
                }
%>
<script type="text/javascript">
    isNew=true;
</script>
<%
    }
    if (bean != null) {
        /*
         * bean.setDES_REV_DOC(strDES_REV_DOC);
         * bean.setDAT_REV_DOC(dtDAT_REV_DOC);
         * bean.setDAT_FUT_REV_DOC(dtDAT_FUT_REV_DOC);
         * bean.setPRG_RIF_DOC(strPRG_RIF_DOC);
         * bean.setPGN_RIF_DOC(strPGN_RIF_DOC);
         * bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
         * bean.setNOT_LUO_CON(strNOT_LUO_CON);
         * bean.setPER_CON_YEA(lPER_CON_YEA); bean.setCOD_AZL(lCOD_AZL);
         */
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

%><script type="text/javascript">bRefresh=true;</script><%
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
    <%=ex/*
             * .getMessage()
             */%>
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
        //< %@ include file="ANA_DOC_Obj.jsp" %>
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
