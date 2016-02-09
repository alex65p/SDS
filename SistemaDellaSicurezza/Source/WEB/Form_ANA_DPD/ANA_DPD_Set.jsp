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
     <version number="1.0" date="14/01/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="14/01/2004" author="Mike Kondratyuk">
     <description>Shablon formi ANA_DPD_Set.jsp</description>
     </comment>
     <comment date="25/02/2004" author="Treskina Mary">
     <description>Upload</description>
     </comment>
     </comments>
     </version>
     </versions>
     </file>
     */
%>
<%@ page import="java.util.regex.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript">
    var err = false;
    var isNew = false;
    var bRefresh = true;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%    java.util.Hashtable hs = new java.util.Hashtable();
    try {
        // Create a new file upload handler
        DiskFileUpload upload = new DiskFileUpload();

        // Set upload parameters
        upload.setSizeMax(999999999L);

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
    <%=ex/*.getMessage()*/%>
</div>
<%
        out.print("<script>err=true;alert(divErr.innerText);</script>");
    }

    IAnagrDocumentoHome homeanagrDoc = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
    IDipendente Dipendente = null;

    if ((String) hs.get("SBM_MODE") != null) {
        Checker c = new Checker();
        String ReqMODE = (String) hs.get("SBM_MODE");

        long lCOD_DPD = c.checkLong("DPD ID", (String) hs.get("COD_DPD"), true);					//0
        long lCOD_AZL = c.checkLong("AZL ID", (String) hs.get("COD_AZL"), true);
        String strss = c.checkString("DTE ID", (String) hs.get("ATTACH_SUBJECT"), false);				//1
        long lCOD_DTE = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Fornitore.personale/servizi"), (String) hs.get("COD_DTE"), (strss.equals("DPD_EST") ? true : false));					//2 - Nullable

        System.out.println(strss);				//2 - Nullable
        long lCOD_FUZ_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Funz.Aziendale"), (String) hs.get("COD_FUZ_AZL"), true);		//3
        String strSTA_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato"), (String) hs.get("STA_DPD"), true);					//4
        String strMTR_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Matricola"), (String) hs.get("MTR_DPD"), (strss.equals("DPD_EST") ? false : true));				//5
        String strCOG_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Cognome"), (String) hs.get("COG_DPD"), true);				//6
        String strNOM_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), (String) hs.get("NOM_DPD"), true);					//7
        String strCOD_FIS_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Cod.fiscale"), (String) hs.get("COD_FIS_DPD"), false);	//8 - Nullable
        String strSEX_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Sesso"), (String) hs.get("SEX_DPD"), false);
        long lCOD_STA = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nazione"), (String) hs.get("COD_STA"), false);				//9 - Nullable
        String strLUO_NAS_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.di.nascita"), (String) hs.get("LUO_NAS_DPD"), false);//10 - Nullable
        java.sql.Date DAT_NAS_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.di.nascita"), (String) hs.get("DAT_NAS_DPD"), (strss.equals("DPD_EST") ? false : true));		//11
        String strIDZ_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"), (String) hs.get("IDZ_DPD"), false);			//12 - Nullable
        String strNUM_CIC_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"), (String) hs.get("NUM_CIC_DPD"), false);	//13 - Nullable
        String strCAP_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."), (String) hs.get("CAP_DPD"), false);					//14 - Nullable
        String strCIT_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"), (String) hs.get("CIT_DPD"), false);				//15 - Nullable
        String strPRV_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"), (String) hs.get("PRV_DPD"), false);			//16 - Nullable
        String strIDZ_PSA_ELT_DPD = c.checkEmail(ApplicationConfigurator.LanguageManager.getString("Posta.elettronica"), (String) hs.get("IDZ_PSA_ELT_DPD"), false);//17 - Nullable
        java.sql.Date DAT_ASS_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.assunzione"), (String) hs.get("DAT_ASS_DPD"), false);		//19 - Nullable
        String strLIV_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Livello"), (String) hs.get("LIV_DPD"), false);		//20 - Nullable
        java.sql.Date DAT_CES_DPD = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.cessazione"), (String) hs.get("DAT_CES_DPD"), false);		//21 - Nullable
        String NOT_DPD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Note"), (String) hs.get("NOT_DPD"), false);

        if (c.isError) {
            String err = c.printErrors();
            out.println("<script>alert(\"" + err + "\");</script>");
            return;
        }

        String strRAP_LAV_AZL = (String) hs.get("RAP_LAV_AZL");
        if (strRAP_LAV_AZL != null && (strRAP_LAV_AZL.equals("on") || strRAP_LAV_AZL.equals("S"))) {
            strRAP_LAV_AZL = "S";
        } else {
            strRAP_LAV_AZL = "N";
        }

        out.println("strCOD_FIS_DPD::" + (String) hs.get("COD_FIS_DPD") + "<br>");
        if (!strCOD_FIS_DPD.equals("")) {
            if (strCOD_FIS_DPD.length() < 16) {
                out.println("<script>alert(arraylng[\"MSG_0041\"]);</script>");
                if (true) {
                    return;
                }
            }
        }

        if (strPRV_DPD != null) {
            Pattern compiledRegex = null;
            Matcher regexMatcher;
            compiledRegex = Pattern.compile("[0-9]");
            regexMatcher = compiledRegex.matcher(strPRV_DPD);
            if (regexMatcher != null) {
                if (regexMatcher.find()) {
                    out.println("<script>alert(arraylng[\"MSG_0042\"]);</script>");
                    return;
                }
            }
        }

        IDipendenteHome home_temp = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
        if (home_temp.CodiceFiscaleExists(strCOD_FIS_DPD, lCOD_AZL, strMTR_DPD, lCOD_DPD)) {
            out.println("<script>alert(arraylng[\"MSG_0043\"]);</script>");
            return;
        }

        if (ReqMODE.equals("edt")) {
            // editing of Dipendente--------------------
            out.println("edt");
            // gettinf of object
            IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            Long COD_DPD = new Long(lCOD_DPD);
            Dipendente = home.findByPrimaryKey(COD_DPD);

            //Fase preliminare 1: prima aggiorno i 3 campi dei Responsabili Documenti
            homeanagrDoc = (IAnagrDocumentoHome) PseudoContext.lookup("AnagrDocumentoBean");
            homeanagrDoc.updateMtrCogNom_DOC(Dipendente.getMTR_DPD(), Dipendente.getCOG_DPD(), Dipendente.getNOM_DPD(), strMTR_DPD, strCOG_DPD, strNOM_DPD);

            //Fase preliminare 2: poi aggiorno i 2 campi dei Responsabili Azienda
            IAziendaHome homeAzl = (IAziendaHome) PseudoContext.lookup("AziendaBean");
            homeAzl.updateMtrCogNom_AZL(Dipendente.getMTR_DPD(), Dipendente.getCOG_DPD(), Dipendente.getNOM_DPD(), strMTR_DPD, strCOG_DPD, strNOM_DPD);

            //Fase 3: poi aggiorno i campi del Dipendente
            Dipendente.setCOD_AZL(lCOD_AZL);
            Dipendente.setCOD_DTE(lCOD_DTE);
            Dipendente.setCOD_FUZ_AZL(lCOD_FUZ_AZL);
            Dipendente.setSTA_DPD(strSTA_DPD);
            Dipendente.setMTR_DPD(strMTR_DPD);
            Dipendente.setCOG_DPD(strCOG_DPD);
            Dipendente.setNOM_DPD(strNOM_DPD);
            Dipendente.setDAT_NAS_DPD(DAT_NAS_DPD);
            Dipendente.setRAP_LAV_AZL(strRAP_LAV_AZL);
            Dipendente.setCOD_STA(lCOD_STA);/**/
            Dipendente.setSEX_DPD(strSEX_DPD);
            //----------------------------

        }
//=======================================================================================
        if (ReqMODE.equals("new")) {
            // new Dipendente--------------------------
            out.println("new");
            //---------------------------
            // creating of object
            out.print("<script>isNew=true;</script>");
            IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
            Dipendente = home.create(lCOD_AZL, lCOD_FUZ_AZL, strSTA_DPD, strMTR_DPD, strCOG_DPD, strNOM_DPD, DAT_NAS_DPD, strRAP_LAV_AZL);
        }
        if (Dipendente != null) {
            // -- setting of not required fields
            try {
                Dipendente.setCOD_FIS_DPD(strCOD_FIS_DPD);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            Dipendente.setLUO_NAS_DPD(strLUO_NAS_DPD);
            Dipendente.setIDZ_DPD(strIDZ_DPD);
            Dipendente.setNUM_CIC_DPD(strNUM_CIC_DPD);
            Dipendente.setCAP_DPD(strCAP_DPD);
            Dipendente.setCIT_DPD(strCIT_DPD);
            Dipendente.setPRV_DPD(strPRV_DPD);
            Dipendente.setCOD_STA(lCOD_STA);
            Dipendente.setCOD_DTE(lCOD_DTE);
            Dipendente.setIDZ_PSA_ELT_DPD(strIDZ_PSA_ELT_DPD);/**/

            Dipendente.setDAT_ASS_DPD(DAT_ASS_DPD);
            Dipendente.setLIV_DPD(strLIV_DPD);
            Dipendente.setDAT_CES_DPD(DAT_CES_DPD);
            Dipendente.setNOT_DPD(NOT_DPD);
            Dipendente.setSEX_DPD(strSEX_DPD);
            //----------------------------------------------------------------------
            // --------------- UPLOAD -------------------------
            lCOD_DPD = Dipendente.getCOD_DPD();
            if (hs.get("ATTACHMENT_ACTION") == null) {
                FileItem item = (FileItem) hs.get("ATTACHMENT_FILE");

                if (item != null && item.getName() != null && !item.getName().equals("")) {
                    homeanagrDoc.deleteFileU("ANA_DPD_TAB", lCOD_DPD);

                    String str = item.getName();
                    str = str.substring(str.lastIndexOf('/') + 1, str.length());
                    str = str.substring(str.lastIndexOf('\\') + 1, str.length());

                    homeanagrDoc.uploadFileU("ANA_DPD_TAB", lCOD_DPD, str, item.getContentType(), item.get());
%><script type="text/javascript">bRefresh = true;</script><%
    }
} else if ("delete".equals(hs.get("ATTACHMENT_ACTION"))) {
    homeanagrDoc.deleteFileU("ANA_DPD_TAB", lCOD_DPD);
%><script type="text/javascript">bRefresh = true;</script><%
    }
    //--------------- UPLOAD -------------------------

// Inizio modifica gestione link esterno documenti
    if (hs.get("ATTACHMENT_ACTION_LINK") == null) {
        FileItem item = (FileItem) hs.get("ATTACHMENT_FILE_LINK");

        if (item != null && item.getName() != null && !item.getName().equals("")) {
            homeanagrDoc.deleteFileULink("ANA_DPD_TAB", lCOD_DPD);

            String str = item.getName();
            //str=str.substring(str.lastIndexOf('/') + 1, str.length());
            //str=str.substring(str.lastIndexOf('\\') + 1, str.length());

            homeanagrDoc.uploadFileULink("ANA_DPD_TAB", lCOD_DPD, str, item.getContentType(), item.get());
%><script type="text/javascript">bRefresh = true;</script><%
    }
} else if ("delete".equals(hs.get("ATTACHMENT_ACTION_LINK"))) {
    homeanagrDoc.deleteFileULink("ANA_DPD_TAB", lCOD_DPD);
%><script type="text/javascript">bRefresh = true;</script><%
            }
// Fine modifica gestione link esterno documenti                
        }
    }
%>
<script type="text/javascript">
    if (!err) {
        if (isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=Dipendente.getCOD_DPD()%>");
        } else {
            Alert.Success.showSaved();
            if (bRefresh)
                parent.ToolBar.OnNew("ID=<%=Dipendente.getCOD_DPD()%>");
        }
    }
</script>
