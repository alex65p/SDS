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

<%-- 
    Document   : CON_SER_DUV_Generate
    Created on : 30-mag-2008, 15.56.30
    Author     : Giancarlo Servadei
--%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>
<!-- Import per la parte di generazione pdf del duvri -->
<%@ page import="java.io.*"%>
<%@ page import="java.sql.Date"%>

<!-- SAX classes. -->
<%@ page import="org.xml.sax.*"%>
<%@ page import="org.xml.sax.helpers.*"%>

<!-- JAXP 1.1 -->
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="javax.xml.transform.*"%>
<%@ page import="javax.xml.transform.stream.*"%>
<%@ page import="javax.xml.transform.sax.*"%>
<!-- FINE -->

<%@ page import="s2s.fop.XML2PDF"%>
<%@ page import="s2s.luna.conf.ApplicationConstants"%>
<%@ page import="s2s.file.io.BynaryFileReader"%>
<%@ page import="s2s.utils.text.StringManager"%>

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.AziendaTelefono.*" %>

<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.SubAppAnalisiRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServDUVRI.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServSubApp.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServCentriEmergenza.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServServiziSanitari.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServFluidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.AppProdottiSostanze.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServReferentiLoco/ContServReferentiLocoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppReferentiLoco/AppReferentiLocoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppPersonaleCoinvolto/AppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/AppAnalisiRischi/AppAnalisiRischiBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppPersonaleCoinvolto/SubAppPersonaleCoinvoltoBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/SubAppProdottiSostanze/SubAppProdottiSostanzeBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServPrestitoMateriali/ContServPrestitoMaterialiBean.jsp"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>

<script type="text/javascript">
    var err=false;
</script>

<%
    Collection col;
    Iterator it;
    Collection colInt;
    Iterator itInt;

    int iCount = 0;
    int iCountIncr = 0;
    int iCountSubApp = 0;
    int iCountIncrSubApp = 0;
    int recCount = 0;
    
    IAnaContServHome ContrattoOriginale_Home = 
                (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
    IAnaContServ ContrattoOriginale_Bean = null;
    
    IContServDUVRIHome DUVRIOriginale_Home = 
            (IContServDUVRIHome) PseudoContext.lookup("ContServDUVRIBean");
    IContServDUVRI DUVRIOriginale_Bean = null;
    IContServDUVRI NuovoDUVRI_Bean = null;
    
    IUnitaOrganizzativaHome uni_org_home =
            (IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
    IUnitaOrganizzativa uni_org_bean = null;
    
    IAziendaHome azl_home =
            (IAziendaHome)PseudoContext.lookup("AziendaBean");
    IAzienda azl_bean = null;
    
    IAziendaTelefonoHome azl_tel_home =
            (IAziendaTelefonoHome)PseudoContext.lookup("AziendaTelefonoBean");
    IAziendaTelefono azl_tel_bean = null;
    AziendaTelefoniCellulariFax_View num_tel = null;
    
    IDittaEsternaHome dte_app_home =
            (IDittaEsternaHome)PseudoContext.lookup("DittaEsternaBean");
    IDittaEsterna dte_app_bean = null;
    
    IContServLuoghiEsecuzioneHome luo_ese_home =
            (IContServLuoghiEsecuzioneHome)PseudoContext.lookup("ContServLuoghiEsecuzioneBean");
    IContServLuoghiEsecuzione luo_ese_bean = null;
    ContServLuoghiEsecuzione_View luo_ese = null;
    
    IContServIspezioniHome isp_home =
            (IContServIspezioniHome)PseudoContext.lookup("ContServIspezioniBean");
    IContServIspezioni isp_bean = null;
    Ispezioni_View isp = null;
    
    IDipendenteHome dpd_home =
            (IDipendenteHome)PseudoContext.lookup("DipendenteBean");
    IDipendente dpd_bean = null;
    
    IContServReferentiLocoHome ref_loc_cmt_home =
            (IContServReferentiLocoHome)PseudoContext.lookup("ContServReferentiLocoBean");
    IContServReferentiLoco ref_loc_cmt_bean = null;
    ComReferentiLoco_View ref_loc_cmt = null;
    
    IAppReferentiLocoHome ref_loc_app_home =
            (IAppReferentiLocoHome)PseudoContext.lookup("AppReferentiLocoBean");
    IAppReferentiLoco ref_loc_app_bean = null;
    AppReferentiLoco_View ref_loc_app = null;
    
    IContServSubAppHome sub_app_home =
            (IContServSubAppHome)PseudoContext.lookup("ContServSubAppBean");
    IContServSubApp sub_app_bean = null;
    SubApp_View sub_app = null;
    
    IContServCentriEmergenzaHome cen_eme_home =
            (IContServCentriEmergenzaHome)PseudoContext.lookup("ContServCentriEmergenzaBean");
    IContServCentriEmergenza cen_eme_bean = null;
    CentriEmergenza_View cen_eme = null;
    
    IAppPersonaleCoinvoltoHome per_coi_app_home =
            (IAppPersonaleCoinvoltoHome)PseudoContext.lookup("AppPersonaleCoinvoltoBean");
    IAppPersonaleCoinvolto per_coi_app_bean = null;
    AppPersonaleCoinvolto_View per_coi_app = null;
    
    IAppProdottiSostanzeHome pro_sos_app_home =
            (IAppProdottiSostanzeHome)PseudoContext.lookup("AppProdottiSostanzeBean");
    IAppProdottiSostanze pro_sos_app_bean = null;
    ProdottiSostanzeApp_View pro_sos_app = null;
    
    IAppAnalisiRischiHome ana_ris_app_home =
            (IAppAnalisiRischiHome)PseudoContext.lookup("AppAnalisiRischiBean");
    IAppAnalisiRischi ana_ris_app_bean = null;
    AnalisiRischiApp_View ana_ris_app = null;
    
    ISubAppPersonaleCoinvoltoHome per_coi_sub_app_home =
            (ISubAppPersonaleCoinvoltoHome)PseudoContext.lookup("SubAppPersonaleCoinvoltoBean");
    ISubAppPersonaleCoinvolto per_coi_sub_app_bean = null;
    SubAppPersonaleCoinvolto_View per_coi_sub_app = null;
    
    ISubAppProdottiSostanzeHome pro_sos_sub_app_home =
            (ISubAppProdottiSostanzeHome)PseudoContext.lookup("SubAppProdottiSostanzeBean");
    ISubAppProdottiSostanze pro_sos_sub_app_bean = null;
    ProdottiSostanzeSubApp_View pro_sos_sub_app = null;
    
    ISubAppAnalisiRischiHome ana_ris_sub_app_home =
            (ISubAppAnalisiRischiHome)PseudoContext.lookup("SubAppAnalisiRischiBean");
    ISubAppAnalisiRischi ana_ris_sub_app_bean = null;
    AnalisiRischiSubApp_View ana_ris_sub_app = null;
    
    IContServRischiInterferenzaHome ris_int_home =
            (IContServRischiInterferenzaHome)PseudoContext.lookup("ContServRischiInterferenzaBean");
    IContServRischiInterferenza ris_int_bean = null;
    ContServRischiInterferenza_View ris_int = null;
    
    IContServServiziSanitariHome ser_san_home =
            (IContServServiziSanitariHome)PseudoContext.lookup("ContServServiziSanitariBean");
    IContServServiziSanitari ser_san_bean = null;
    ServiziSanitari_View ser_san = null;
    
    IContServFluidiHome flu_home =
            (IContServFluidiHome)PseudoContext.lookup("ContServFluidiBean");
    IContServFluidi flu_bean = null;
    Fluidi_View flu = null;
    
    IContServPrestitoMaterialiHome pre_mat_home =
            (IContServPrestitoMaterialiHome)PseudoContext.lookup("ContServPrestitoMaterialiBean");
    IContServPrestitoMateriali pre_mat_bean = null;
    PrestitoMateriali_View pre_mat = null;
    
    Checker c = new Checker();

    long lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Contratto/Servizio"), request.getParameter("ID_PARENT"), false);

    if (c.isError) {
        String err = c.printErrors();
        out.println(
                "<script>" +
                "alert(\"" + err + "\");" +
                "err=true;" +
                "</script>");
        return;
    }
    
    //-------------------------------------------------------------------------
    //---------------------------- INIZIALIZZAZIONE ---------------------------
    //-------------------------------------------------------------------------
    
    String returnMessage = null;
    try {
        // Area di appoggio per i file xml e pdf generati
        String xslDir = ApplicationConfigurator.getApplicationPath() + "WEB/xsl/";
        String TempWorkingDir = ApplicationConfigurator.getTempWorkingPath();

        // Lettura della data di sistema
        java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());

        // Estraggo il progressivo contratto
        String strPRO_CON = ContrattoOriginale_Home.getProConOnCodSrv(Security.getAzienda(), lCOD_SRV);

        // Ottengo il progressivo per il nuovo DUVRI.
        String strPRO_DUV = DUVRIOriginale_Home.getProgressivoDUVRI(Security.getAzienda(),
                lCOD_SRV,
                strPRO_CON);

        XML2PDF DuvriPDFGenerate = new XML2PDF();

        DuvriPDFGenerate.setXSLDir(xslDir);
        DuvriPDFGenerate.setXMLDir(TempWorkingDir);
        DuvriPDFGenerate.setOutDir(TempWorkingDir);

        long fileNamePrefix = now.getTime();
        DuvriPDFGenerate.setXslFileName(ApplicationConstants.DUVRI_XSL_FILE_NAME);
        DuvriPDFGenerate.setXmlFileName(fileNamePrefix + ApplicationConstants.DUVRI_XML_FILE_NAME);
        DuvriPDFGenerate.setPdfFileName(fileNamePrefix + ApplicationConstants.DUVRI_PDF_FILE_NAME);

        //-------------------------------------------------------------------------
        //------------------------ GENERAZIONE DEL FILE XML -----------------------
        //-------------------------------------------------------------------------

        // Estraggo il contratto..
        ContrattoOriginale_Bean = 
                ContrattoOriginale_Home.findByPrimaryKey(lCOD_SRV);

        // Print output to a text file
        FileOutputStream fos = new FileOutputStream
                (DuvriPDFGenerate.getXMLDir() + DuvriPDFGenerate.getXmlFileName());
        StreamResult streamResult = new StreamResult(fos);
        SAXTransformerFactory tf = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
        // SAX2.0 ContentHandler.
        TransformerHandler hd = tf.newTransformerHandler();
        Transformer serializer = hd.getTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING,"ISO-8859-1");
        //serializer.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM,"users.dtd");
        serializer.setOutputProperty(OutputKeys.INDENT,"yes");
        hd.setResult(streamResult);
        hd.startDocument();
        AttributesImpl atts = new AttributesImpl();
        
       
    //-------------------- GENERAZIONE DEL FILE XML: Facciata 1 del DUVRI -------------------
    hd.startElement("","","DUVRI",atts);
        // DUVRI_01 tag
        hd.startElement("","","DUVRI_01",atts);
           
            // DUVRI tag
            hd.startElement("","","DUVRI",atts);
                // PRO_DUV tag
                hd.startElement("","","PRO_DUV",atts);
                hd.characters(strPRO_DUV.toCharArray(), 0, strPRO_DUV.length());
                hd.endElement("","","PRO_DUV");
                // DAT_DUV tag
                
                hd.startElement("","","DAT_DUV",atts);
                hd.characters((Formatter.format(now)).toCharArray(), 0, (Formatter.format(now)).length());
                hd.endElement("","","DAT_DUV");
                // NOM_UNI_ORG tag
                if(ContrattoOriginale_Bean.getCOD_UNI_ORG()!= 0) {
                hd.startElement("","","NOM_UNI_ORG",atts);
                uni_org_bean = uni_org_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOD_UNI_ORG());
                hd.characters(uni_org_bean.getNOM_UNI_ORG().toCharArray(), 0, uni_org_bean.getNOM_UNI_ORG().length());
                hd.endElement("","","NOM_UNI_ORG");
                }
            
            hd.endElement("","","DUVRI");

            
            // COMMITTENTE tag
            hd.startElement("","","COMMITTENTE",atts);
                // RAG_SCL_AZL tag
                hd.startElement("","","RAG_SCL_AZL",atts);
                azl_bean = azl_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOD_AZL());
                hd.characters(azl_bean.getRAG_SCL_AZL().toCharArray(), 0, azl_bean.getRAG_SCL_AZL().length());
                hd.endElement("","","RAG_SCL_AZL");
                // IDZ_AZL tag
                hd.startElement("","","IDZ_AZL",atts);
                hd.characters(azl_bean.getIDZ_AZL().toCharArray(), 0, azl_bean.getIDZ_AZL().length());
                hd.endElement("","","IDZ_AZL");
                // NUM_CIC_AZL tag
                hd.startElement("","","NUM_CIC_AZL",atts);
                if((azl_bean.getNUM_CIC_AZL() == null)||(azl_bean.getNUM_CIC_AZL().equals(""))) {
                    hd.characters(azl_bean.getNUM_CIC_AZL().toCharArray(), 0, azl_bean.getNUM_CIC_AZL().length());
                } else {
                    hd.characters((", ".concat(azl_bean.getNUM_CIC_AZL())).toCharArray(), 0, (", ".concat(azl_bean.getNUM_CIC_AZL())).length());
                }
                hd.endElement("","","NUM_CIC_AZL");
                // CAP_AZL tag
                hd.startElement("","","CAP_AZL",atts);
                if((azl_bean.getCAP_AZL() == null)||(azl_bean.getCAP_AZL().equals(""))) {
                    hd.characters(azl_bean.getCAP_AZL().toCharArray(), 0, azl_bean.getCAP_AZL().length());
                } else {
                    hd.characters(((azl_bean.getCAP_AZL()).concat(" - ")).toCharArray(), 0, ((azl_bean.getCAP_AZL()).concat(" - ")).length());
                }
                hd.endElement("","","CAP_AZL");
                // CIT_AZL tag
                hd.startElement("","","CIT_AZL",atts);
                hd.characters(azl_bean.getCIT_AZL().toCharArray(), 0, azl_bean.getCIT_AZL().length());
                hd.endElement("","","CIT_AZL");
                // PRV_AZL tag
                hd.startElement("","","PRV_AZL",atts);
                if((azl_bean.getPRV_AZL() == null)||(azl_bean.getPRV_AZL().equals(""))) {
                    hd.characters(azl_bean.getPRV_AZL().toCharArray(), 0, azl_bean.getPRV_AZL().length());
                } else {
                    hd.characters((" (".concat(azl_bean.getPRV_AZL()).concat(") ")).toCharArray(), 0, (" (".concat(azl_bean.getPRV_AZL()).concat(") ")).length());
                }
                hd.endElement("","","PRV_AZL");
                // IDZ_PSA_ELT_RSP_AZL tag
                hd.startElement("","","IDZ_PSA_ELT_RSP_AZL",atts);
                hd.characters(azl_bean.getIDZ_PSA_ELT_RSP_AZL().toCharArray(), 0, azl_bean.getIDZ_PSA_ELT_RSP_AZL().length());
                hd.endElement("","","IDZ_PSA_ELT_RSP_AZL");

                // Contatti_fissi tag
                hd.startElement("","","Contatti_fissi",atts);
                    col = azl_tel_home.getAziendaTelefoniCellulariFax_View(Security.getAzienda(), "FISSO");
                    it = col.iterator();
                    while (it.hasNext()){
                    num_tel = (AziendaTelefoniCellulariFax_View)it.next();
                        // Numeri_telefono tag
                        hd.startElement("","","Numeri_telefono",atts);
                            // Numero_telefono tag
                            hd.startElement("","","Numero_telefono",atts);
                                // NUM_TEL tag
                                hd.startElement("","","NUM_TEL",atts);
                                hd.characters(num_tel.NUM_TEL.toCharArray(), 0, num_tel.NUM_TEL.length());
                                hd.endElement("","","NUM_TEL");
                            hd.endElement("","","Numero_telefono");
                        hd.endElement("","","Numeri_telefono");
                    }
                hd.endElement("","","Contatti_fissi");
                // Contatti_mobili tag
                hd.startElement("","","Contatti_mobili",atts);
                    col = azl_tel_home.getAziendaTelefoniCellulariFax_View(Security.getAzienda(), "CELLULARE");
                    it = col.iterator();
                    while (it.hasNext()){
                    num_tel = (AziendaTelefoniCellulariFax_View)it.next();
                        // Numeri_cellulare tag
                        hd.startElement("","","Numeri_cellulare",atts);
                            // Numero_cellulare tag
                            hd.startElement("","","Numero_cellulare",atts);
                                // CELLULARE tag
                                hd.startElement("","","CELLULARE",atts);
                                hd.characters(num_tel.NUM_TEL.toCharArray(), 0, num_tel.NUM_TEL.length());
                                hd.endElement("","","CELLULARE");
                            hd.endElement("","","Numero_cellulare");
                        hd.endElement("","","Numeri_cellulare");
                    }
                hd.endElement("","","Contatti_mobili");
                // Contatti_fax tag
                hd.startElement("","","Contatti_fax",atts);
                    col = azl_tel_home.getAziendaTelefoniCellulariFax_View(Security.getAzienda(), "FAX");
                    it = col.iterator();
                    while (it.hasNext()){
                    num_tel = (AziendaTelefoniCellulariFax_View)it.next();
                        // Numeri_fax tag
                        hd.startElement("","","Numeri_fax",atts);
                            // Numero_fax tag
                            hd.startElement("","","Numero_fax",atts);
                                // FAX tag
                                hd.startElement("","","FAX",atts);
                                hd.characters(num_tel.NUM_TEL.toCharArray(), 0, num_tel.NUM_TEL.length());
                                hd.endElement("","","FAX");
                            hd.endElement("","","Numero_fax");
                        hd.endElement("","","Numeri_fax");
                    }
                hd.endElement("","","Contatti_fax");
            hd.endElement("","","COMMITTENTE");

            // APPALTATRICE tag
            hd.startElement("","","APPALTATRICE",atts);
                // RAG_SCL_DTE tag
                hd.startElement("","","RAG_SCL_DTE",atts);
                dte_app_bean = dte_app_home.findByPrimaryKey(ContrattoOriginale_Bean.getAPP_COD_DTE());
                hd.characters(dte_app_bean.getRAG_SCL_DTE().toCharArray(), 0, dte_app_bean.getRAG_SCL_DTE().length());
                hd.endElement("","","RAG_SCL_DTE");
                // IDZ_DTE tag
                hd.startElement("","","IDZ_DTE",atts);
                hd.characters(dte_app_bean.getIDZ_DTE().toCharArray(), 0, dte_app_bean.getIDZ_DTE().length());
                hd.endElement("","","IDZ_DTE");
                // NUM_CIC_DTE tag
                hd.startElement("","","NUM_CIC_DTE",atts);
                if((dte_app_bean.getNUM_CIC_DTE() == null)||(dte_app_bean.getNUM_CIC_DTE().equals(""))) {
                    hd.characters(dte_app_bean.getNUM_CIC_DTE().toCharArray(), 0, dte_app_bean.getNUM_CIC_DTE().length());
                } else {
                    hd.characters((", ".concat(dte_app_bean.getNUM_CIC_DTE())).toCharArray(), 0, (", ".concat(dte_app_bean.getNUM_CIC_DTE())).length());
                }
                hd.endElement("","","NUM_CIC_DTE");
                // CAP_DTE tag
                hd.startElement("","","CAP_DTE",atts);
                if((dte_app_bean.getCAP_DTE() == null)||(dte_app_bean.getCAP_DTE().equals(""))) {
                    hd.characters(dte_app_bean.getCAP_DTE().toCharArray(), 0, dte_app_bean.getCAP_DTE().length());
                } else {
                    hd.characters(((dte_app_bean.getCAP_DTE()).concat(" - ")).toCharArray(), 0, ((dte_app_bean.getCAP_DTE()).concat(" - ")).length());
                }
                hd.endElement("","","CAP_DTE");
                // CIT_DTE tag
                hd.startElement("","","CIT_DTE",atts);
                hd.characters(dte_app_bean.getCIT_DTE().toCharArray(), 0, dte_app_bean.getCIT_DTE().length());
                hd.endElement("","","CIT_DTE");
		// PRV_DTE tag
                hd.startElement("","","PRV_DTE",atts);
                if((dte_app_bean.getPRV_DTE() == null) || (dte_app_bean.getPRV_DTE().equals(""))) {
                    hd.characters(dte_app_bean.getPRV_DTE().toCharArray(), 0, dte_app_bean.getPRV_DTE().length());
                } else {
                    hd.characters((" (".concat(dte_app_bean.getPRV_DTE()).concat(") ")).toCharArray(), 0, (" (".concat(dte_app_bean.getPRV_DTE()).concat(") ")).length());
                }
                hd.endElement("","","PRV_DTE");
                // APP_TEL tag
                if(ContrattoOriginale_Bean.getAPP_TEL() != null) {
                hd.startElement("","","APP_TEL",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_TEL().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_TEL().length());
                hd.endElement("","","APP_TEL");
                }
                // APP_FAX tag
                if(ContrattoOriginale_Bean.getAPP_FAX() != null) {
                hd.startElement("","","APP_FAX",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_FAX().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_FAX().length());
                hd.endElement("","","APP_FAX");
                }
                // APP_EMAIL tag
                if(ContrattoOriginale_Bean.getAPP_EMAIL() != null) {
                hd.startElement("","","APP_EMAIL",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_EMAIL().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_EMAIL().length());
                hd.endElement("","","APP_EMAIL");
                }
                // RIF_CON tag
                if(ContrattoOriginale_Bean.getRIF_CON() != null) {
                hd.startElement("","","RIF_CON",atts);
                hd.characters(ContrattoOriginale_Bean.getRIF_CON().toCharArray(), 0, ContrattoOriginale_Bean.getRIF_CON().length());
                hd.endElement("","","RIF_CON");
                }
                // DES_CON tag
                if(ContrattoOriginale_Bean.getDES_CON() != null) {
                hd.startElement("","","DES_CON",atts);
                hd.characters(ContrattoOriginale_Bean.getDES_CON().toCharArray(), 0, ContrattoOriginale_Bean.getDES_CON().length());
                hd.endElement("","","DES_CON");
                }
                // Luoghi_esecuzione tag
                recCount = 0;
                hd.startElement("","","Luoghi_esecuzione",atts);
                    col = luo_ese_home.getContServLuoghiEsecuzione_View(ContrattoOriginale_Bean.getCOD_SRV());
                    it = col.iterator();
                    while (it.hasNext()){
                        luo_ese = (ContServLuoghiEsecuzione_View) it.next();
                        // Luoghi_fisici tag
                        hd.startElement("","","Luoghi_fisici",atts);
                            // Luogo_fisico tag
                            hd.startElement("","","Luogo_fisico",atts);
                                // NOM_LUO_FSC tag
                                hd.startElement("","","NOM_LUO_FSC",atts);
                                hd.characters(luo_ese.NOM_LUO_FSC.toCharArray(), 0, luo_ese.NOM_LUO_FSC.length());
                                hd.endElement("","","NOM_LUO_FSC");
                                // DES_SER tag
                                hd.startElement("","","DES_SER",atts);
                                characters(hd, luo_ese.DES_SER);
                                hd.endElement("","","DES_SER");
                            hd.endElement("","","Luogo_fisico");
                        hd.endElement("","","Luoghi_fisici");
                        recCount++;
                    }

                    // al fine di ottenere un miglior layout,
                    // garantisco la stampa di almeno 4 righe
                    // a prescindere dalla presenza o meno di 4 record.
                    for (int i=recCount; i<4; i++) {
                        hd.startElement("","","Luoghi_fisici",atts);
                        hd.startElement("","","Luogo_fisico",atts);
                        // NOM_LUO_FSC tag
                        hd.startElement("","","NOM_LUO_FSC",atts);
                        hd.characters("".toCharArray(), 0, "".length());
                        hd.endElement("","","NOM_LUO_FSC");
                        // DES_SER tag
                        hd.startElement("","","DES_SER",atts);
                        hd.characters("".toCharArray(), 0, "".length());
                        hd.endElement("","","DES_SER");
                        hd.endElement("","","Luogo_fisico");
                        hd.endElement("","","Luoghi_fisici");
                    }

                hd.endElement("","","Luoghi_esecuzione");
                
            hd.endElement("","","APPALTATRICE");

            // INFO_LAVORI tag
            hd.startElement("","","INFO_LAVORI",atts);
                // DAT_INI_LAV tag
                if(ContrattoOriginale_Bean.getDAT_INI_LAV() != null) {
                hd.startElement("","","DAT_INI_LAV",atts);
                hd.characters((Formatter.format(ContrattoOriginale_Bean.getDAT_INI_LAV())).toCharArray(), 0, (Formatter.format(ContrattoOriginale_Bean.getDAT_INI_LAV())).length());
                hd.endElement("","","DAT_INI_LAV");
                }
                // DAT_FIN_LAV tag
                if(ContrattoOriginale_Bean.getDAT_FIN_LAV() != null) {
                hd.startElement("","","DAT_FIN_LAV",atts);
                hd.characters((Formatter.format(ContrattoOriginale_Bean.getDAT_FIN_LAV())).toCharArray(), 0, (Formatter.format(ContrattoOriginale_Bean.getDAT_FIN_LAV())).length());
                hd.endElement("","","DAT_FIN_LAV");
                }
                // ORA_LAV tag
                if(ContrattoOriginale_Bean.getORA_LAV() != null) {
                hd.startElement("","","ORA_LAV",atts);
                hd.characters(ContrattoOriginale_Bean.getORA_LAV().toCharArray(), 0, ContrattoOriginale_Bean.getORA_LAV().length());
                hd.endElement("","","ORA_LAV");
                }
                // LAV_NOT tag
                if(ContrattoOriginale_Bean.getLAV_NOT() != null) {
                    hd.startElement("","","LAV_NOT",atts);
                    if (ContrattoOriginale_Bean.getLAV_NOT().equals("S")) {
                        hd.characters("SI".toCharArray(), 0, "SI".length());
                    } else {
                        hd.characters("NO".toCharArray(), 0, "NO".length());
                    }
                    hd.endElement("","","LAV_NOT");
                }
                // NUM_LAV_PRE tag
                hd.startElement("","","NUM_LAV_PRE",atts);
                hd.characters(String.valueOf(ContrattoOriginale_Bean.getNUM_LAV_PRE()).toCharArray(), 0, String.valueOf(ContrattoOriginale_Bean.getNUM_LAV_PRE()).length());
                hd.endElement("","","NUM_LAV_PRE");
            hd.endElement("","","INFO_LAVORI");
        hd.endElement("","","DUVRI_01");

        //-------------------- GENERAZIONE DEL FILE XML: Facciata 2 del DUVRI -------------------
        // DUVRI_02 tag
        hd.startElement("","","DUVRI_02",atts);
        // COMMITTENTE_02 tag
        hd.startElement("","","COMMITTENTE_02",atts);
        azl_bean = azl_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOD_AZL());
        hd.characters(azl_bean.getRAG_SCL_AZL().toCharArray(), 0, azl_bean.getRAG_SCL_AZL().length());
        hd.endElement("","","COMMITTENTE_02");
        
        // ALLEGATI_ISPEZIONI tag
        hd.startElement("","","ALLEGATI_ISPEZIONI",atts);
        col = isp_home.findEx_Ispezioni(ContrattoOriginale_Bean.getCOD_SRV());
        it = col.iterator();
        while (it.hasNext()){
        isp = (Ispezioni_View) it.next();
            // Ispezioni tag
            hd.startElement("","","Ispezioni",atts);
                // Ispezione tag
                hd.startElement("","","Ispezione",atts);
                    // FILE_NAME tag
                    hd.startElement("","","FILE_NAME",atts);
                    hd.characters((" - ".concat(isp.FILE_NAME)).toCharArray(), 0, (" - ".concat(isp.FILE_NAME)).length());
                    hd.endElement("","","FILE_NAME");
                hd.endElement("","","Ispezione");
            hd.endElement("","","Ispezioni");
        }
        hd.endElement("","","ALLEGATI_ISPEZIONI");
            // RESPONSABILI_CMT tag
            hd.startElement("","","RESPONSABILI_CMT",atts);
                // COG_DPD_RSP tag
                if(ContrattoOriginale_Bean.getCOM_COD_DPD() != 0) {
                hd.startElement("","","COG_DPD_RSP",atts);
                dpd_bean = dpd_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOM_COD_DPD());
                hd.characters(dpd_bean.getCOG_DPD().toCharArray(), 0, dpd_bean.getCOG_DPD().length());
                hd.endElement("","","COG_DPD_RSP");
                // NOM_DPD_RSP tag
                hd.startElement("","","NOM_DPD_RSP",atts);
                hd.characters(dpd_bean.getNOM_DPD().toCharArray(), 0, dpd_bean.getNOM_DPD().length());
                hd.endElement("","","NOM_DPD_RSP");
                // NOM_FUZ_AZL_RSP tag
                hd.startElement("","","NOM_FUZ_AZL_RSP",atts);
                hd.characters(dpd_bean.getNOM_FUZ_AZL().toCharArray(), 0, dpd_bean.getNOM_FUZ_AZL().length());
                hd.endElement("","","NOM_FUZ_AZL_RSP");
                // COM_RES_TEL tag
                hd.startElement("","","COM_RES_TEL",atts);
                hd.characters(ContrattoOriginale_Bean.getCOM_RES_TEL().toCharArray(), 0, ContrattoOriginale_Bean.getCOM_RES_TEL().length());
                hd.endElement("","","COM_RES_TEL");
                }
                // Referenti_loco_cmt tag
                hd.startElement("","","Referenti_loco_cmt",atts);
                
                // Conto i record presenti
                col = ref_loc_cmt_home.findEx_ReferentiLocoCmt(Security.getAzienda(),ContrattoOriginale_Bean.getCOD_SRV(), 0L, null);
                it = col.iterator();
                iCount = 0;
                recCount = 0;
                while (it.hasNext()) {
                    ref_loc_cmt = (ComReferentiLoco_View) it.next();
                    recCount = ++iCount;
                }

                // inserisco, regolarmente, i dati nell'xml
                col = ref_loc_cmt_home.findEx_ReferentiLocoCmt(Security.getAzienda(),ContrattoOriginale_Bean.getCOD_SRV(), 0L, null);
                it = col.iterator();
                while (it.hasNext()){
                ref_loc_cmt = (ComReferentiLoco_View) it.next();
                    // Referenti tag
                    hd.startElement("","","Referenti",atts);
                        // Referente tag
                        hd.startElement("","","Referente",atts);
                            // COG_DPD_REF_CMT tag
                            hd.startElement("","","COG_DPD_REF_CMT",atts);
                            hd.characters(ref_loc_cmt.COG_DPD.toCharArray(), 0, ref_loc_cmt.COG_DPD.length());
                            hd.endElement("","","COG_DPD_REF_CMT");
                            // NOM_DPD_REF_CMT tag
                            hd.startElement("","","NOM_DPD_REF_CMT",atts);
                            hd.characters(ref_loc_cmt.NOM_DPD.toCharArray(), 0, ref_loc_cmt.NOM_DPD.length());
                            hd.endElement("","","NOM_DPD_REF_CMT");
                            // NOM_FUZ_AZL_REF_CMT tag
                            hd.startElement("","","NOM_FUZ_AZL_REF_CMT",atts);
                            hd.characters(ref_loc_cmt.NOM_FUZ_AZL.toCharArray(), 0, ref_loc_cmt.NOM_FUZ_AZL.length());
                            hd.endElement("","","NOM_FUZ_AZL_REF_CMT");
                            // TEL_REF_CMT tag
                            hd.startElement("","","TEL_REF_CMT",atts);
                            characters(hd, ref_loc_cmt.TEL);
                            hd.endElement("","","TEL_REF_CMT");
                        hd.endElement("","","Referente");
                    hd.endElement("","","Referenti");
                }
                
                // al fine di ottenere un miglior layout,
                // garantisco la stampa di almeno 4 righe
                // a prescindere dalla presenza o meno di 4 record.
                for (int i=recCount; i<4; i++) {
                    hd.startElement("","","Referenti",atts);
                    hd.startElement("","","Referente",atts);
                    // COG_DPD_REF_CMT tag
                    hd.startElement("","","COG_DPD_REF_CMT",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","COG_DPD_REF_CMT");
                    // NOM_DPD_REF_CMT tag
                    hd.startElement("","","NOM_DPD_REF_CMT",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","NOM_DPD_REF_CMT");
                    // NOM_FUZ_AZL_REF_CMT tag
                    hd.startElement("","","NOM_FUZ_AZL_REF_CMT",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","NOM_FUZ_AZL_REF_CMT");
                    // TEL_REF_CMT tag
                    hd.startElement("","","TEL_REF_CMT",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","TEL_REF_CMT");
                    hd.endElement("","","Referente");
                    hd.endElement("","","Referenti");
                }
                
                hd.endElement("","","Referenti_loco_cmt");
            hd.endElement("","","RESPONSABILI_CMT");
            
            // APPALTATRICE_02 tag
            hd.startElement("","","APPALTATRICE_02",atts);
            dte_app_bean = dte_app_home.findByPrimaryKey(ContrattoOriginale_Bean.getAPP_COD_DTE());
            hd.characters(dte_app_bean.getRAG_SCL_DTE().toCharArray(), 0, dte_app_bean.getRAG_SCL_DTE().length());
            hd.endElement("","","APPALTATRICE_02");

            // RESPONSABILI_CMT tag
            hd.startElement("","","RESPONSABILI_APP",atts);
                // APP_RES_NOM tag
                if(ContrattoOriginale_Bean.getAPP_RES_NOM() != null) {
                hd.startElement("","","APP_RES_NOM",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_NOM().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_NOM().length());
                hd.endElement("","","APP_RES_NOM");
                }
                // APP_RES_NOM tag
                if(ContrattoOriginale_Bean.getAPP_RES_QUA() != null) {
                hd.startElement("","","APP_RES_QUA",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_QUA().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_QUA().length());
                hd.endElement("","","APP_RES_QUA");
                }
                // APP_RES_TEL tag
                if(ContrattoOriginale_Bean.getAPP_RES_TEL() != null) {
                hd.startElement("","","APP_RES_TEL",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_TEL().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_TEL().length());
                hd.endElement("","","APP_RES_TEL");
                }
                // Referenti_loco_app tag
                hd.startElement("","","Referenti_loco_app",atts);
                
                // Conto i record presenti
                col = ref_loc_app_home.findEx_ReferentiLocoApp(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, 0);
                it = col.iterator();
                iCount = 0;
                recCount = 0;
                while (it.hasNext()) {
                    ref_loc_app = (AppReferentiLoco_View) it.next();
                    recCount = ++iCount;
                }

                // inserisco, regolarmente, i dati nell'xml
                col = ref_loc_app_home.findEx_ReferentiLocoApp(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, 0);
                it = col.iterator();
                while (it.hasNext()){
                ref_loc_app = (AppReferentiLoco_View) it.next();
                    // Referenti tag
                    hd.startElement("","","Referenti",atts);
                        // Referente tag
                        hd.startElement("","","Referente",atts);
                            // NOM tag
                            hd.startElement("","","NOM",atts);
                            hd.characters(ref_loc_app.NOM.toCharArray(), 0, ref_loc_app.NOM.length());
                            hd.endElement("","","NOM");
                            // QUA tag
                            hd.startElement("","","QUA",atts);
                            characters(hd, ref_loc_app.QUA);
                            hd.endElement("","","QUA");
                            // TEL tag
                            hd.startElement("","","TEL",atts);
                            characters(hd, ref_loc_app.TEL);
                            hd.endElement("","","TEL");
                        hd.endElement("","","Referente");
                    hd.endElement("","","Referenti");
                }
                
                // al fine di ottenere un miglior layout,
                // garantisco la stampa di almeno 4 righe
                // a prescindere dalla presenza o meno di 4 record.
                for (int i=recCount; i<4; i++) {
                    hd.startElement("","","Referenti",atts);
                    hd.startElement("","","Referente",atts);
                    // NOM tag
                    hd.startElement("","","NOM",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","NOM");
                    // QUA tag
                    hd.startElement("","","QUA",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","QUA");
                    // TEL tag
                    hd.startElement("","","TEL",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","TEL");
                    hd.endElement("","","Referente");
                    hd.endElement("","","Referenti");
                }
                
                hd.endElement("","","Referenti_loco_app");
            hd.endElement("","","RESPONSABILI_APP");
        hd.endElement("","","DUVRI_02");


        //-------------------- GENERAZIONE DEL FILE XML: Facciata 3 del DUVRI -------------------
        // DUVRI_03 tag
        hd.startElement("","","DUVRI_03",atts);
            // IMPRESE_SUBAPPALTATRICI tag
            hd.startElement("","","SUBAPPALTATRICI",atts);
                // Imprese_subappaltatrici tag
                hd.startElement("","","Imprese_subappaltatrici",atts);
                
                // Conto i record presenti
                col = sub_app_home.findEx_SubApp(Security.getAzienda(), ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
                it = col.iterator();
                iCount = 0;
                recCount = 0;
                while (it.hasNext()) {
                    sub_app = (SubApp_View) it.next();
                    recCount = ++iCount;
                }

                // inserisco, regolarmente, i dati nell'xml
                col = sub_app_home.findEx_SubApp(Security.getAzienda(), ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
                it = col.iterator();
                iCount = 0;
                iCountIncr = 0;
                while (it.hasNext()){
                    sub_app = (SubApp_View) it.next();
                    // Imprese tag
                    hd.startElement("","","Imprese",atts);
                        // Impresa tag
                        hd.startElement("","","Impresa",atts);
                            // SUB_APP_num tag
                            hd.startElement("","","SUB_APP_num",atts);
                            iCountIncr = ++iCount;
                            hd.characters(String.valueOf(iCountIncr).toCharArray(), 0, String.valueOf(iCountIncr).length());
                            hd.endElement("","","SUB_APP_num");
                            // RAG_SCL_DTE tag
                            hd.startElement("","","RAG_SCL_DTE",atts);
                            hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
                            hd.endElement("","","RAG_SCL_DTE");
                            // INT_ASS_DES tag
                            if(sub_app.INT_ASS_DES != null) {
                                hd.startElement("","","INT_ASS_DES",atts);
                                hd.characters(sub_app.INT_ASS_DES.toCharArray(), 0, sub_app.INT_ASS_DES.length());
                                hd.endElement("","","INT_ASS_DES");
                            }
                        hd.endElement("","","Impresa");
                    hd.endElement("","","Imprese");
                }
                
                // al fine di ottenere un miglior layout,
                // garantisco la stampa di almeno 5 righe
                // a prescindere dalla presenza o meno di 5 record.
                for (int i=recCount; i<5; i++) {
                    hd.startElement("","","Imprese",atts);
                    hd.startElement("","","Impresa",atts);
                    // SUB_APP_num tag
                    hd.startElement("","","SUB_APP_num",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","SUB_APP_num");
                    // RAG_SCL_DTE tag
                    hd.startElement("","","RAG_SCL_DTE",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","RAG_SCL_DTE");
                    // INT_ASS_DES tag
                    hd.startElement("","","INT_ASS_DES",atts);
                    hd.characters("".toCharArray(), 0, "".length());
                    hd.endElement("","","INT_ASS_DES");
                    hd.endElement("","","Impresa");
                    hd.endElement("","","Imprese");
                }
                
                hd.endElement("","","Imprese_subappaltatrici");
            hd.endElement("","","SUBAPPALTATRICI");

            // CENTRI_INFORMATIVI_CMT tag
            hd.startElement("","","CENTRI_INFORMATIVI_CMT",atts);
                // Centri_informativi tag
                hd.startElement("","","Centri_informativi",atts);
                col = cen_eme_home.findEx_CentriEmergenza(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, 0);
                it = col.iterator();
                while (it.hasNext()) {
                    cen_eme = (CentriEmergenza_View) it.next();
                    // Centri_emergenza tag
                    hd.startElement("","","Centri_emergenza",atts);
                        // Centro_emergenza tag
                        hd.startElement("","","Centro_emergenza",atts);
                         // DES tag
                            hd.startElement("","","DES",atts);
                            characters(hd, cen_eme.DES);
                            hd.endElement("","","DES");
                            // RIF tag
                            hd.startElement("","","RIF",atts);
                            hd.characters(cen_eme.RIF.toCharArray(), 0, cen_eme.RIF.length());
                            hd.endElement("","","RIF");
                           
                        hd.endElement("","","Centro_emergenza");
                    hd.endElement("","","Centri_emergenza");
                }
                hd.endElement("","","Centri_informativi");
                // CEN_EME_DES tag
                if(ContrattoOriginale_Bean.getCEN_EME_DES() != null) {
                hd.startElement("","","CEN_EME_DES",atts);
                hd.characters(ContrattoOriginale_Bean.getCEN_EME_DES().toCharArray(), 0, ContrattoOriginale_Bean.getCEN_EME_DES().length());
                hd.endElement("","","CEN_EME_DES");
                }
            hd.endElement("","","CENTRI_INFORMATIVI_CMT");
        hd.endElement("","","DUVRI_03");


        //-------------------- GENERAZIONE DEL FILE XML: Facciata 4 del DUVRI -------------------
        // DUVRI_04 tag
        hd.startElement("","","DUVRI_04",atts);
            // DESCRIZIONE_SERVIZI_APP tag
            hd.startElement("","","DESCRIZIONE_SERVIZI_APP",atts);
                // RAG_SCL_DTE tag
                hd.startElement("","","RAG_SCL_DTE",atts);
                //dte_app_bean = dte_app_home.findByPrimaryKey(ContrattoOriginale_Bean.getAPP_COD_DTE());
                hd.characters(dte_app_bean.getRAG_SCL_DTE().toCharArray(), 0, dte_app_bean.getRAG_SCL_DTE().length());
                hd.endElement("","","RAG_SCL_DTE");
                // APP_RES_NOM tag
                if(ContrattoOriginale_Bean.getAPP_RES_NOM() != null) {
                hd.startElement("","","APP_RES_NOM",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_NOM().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_NOM().length());
                hd.endElement("","","APP_RES_NOM");
                }
                // APP_RES_QUA tag
                if(ContrattoOriginale_Bean.getAPP_RES_QUA() != null) {
                hd.startElement("","","APP_RES_QUA",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_QUA().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_QUA().length());
                hd.endElement("","","APP_RES_QUA");
                }
                // APP_RES_TEL tag
                if(ContrattoOriginale_Bean.getAPP_RES_TEL() != null) {
                hd.startElement("","","APP_RES_TEL",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_RES_TEL().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_RES_TEL().length());
                hd.endElement("","","APP_RES_TEL");
                }
                // APP_INT_ASS_DES tag
                if(ContrattoOriginale_Bean.getAPP_INT_ASS_DES() != null) {
                hd.startElement("","","APP_INT_ASS_DES",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_INT_ASS_DES().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_INT_ASS_DES().length());
                hd.endElement("","","APP_INT_ASS_DES");
                }
                // APP_INT_ASS_ORA_LAV tag
                if(ContrattoOriginale_Bean.getAPP_INT_ASS_DES() != null) {
                hd.startElement("","","APP_INT_ASS_ORA_LAV",atts);
                hd.characters(ContrattoOriginale_Bean.getAPP_INT_ASS_ORA_LAV().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_INT_ASS_ORA_LAV().length());
                hd.endElement("","","APP_INT_ASS_ORA_LAV");
                }
                // APP_INT_ASS_COD_CON tag
                if (ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON() != 0) {
                    hd.startElement("","","APP_INT_ASS_COD_CON",atts);
                    if (ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON() == 1) {
                        hd.characters("ELETTRICA".toCharArray(), 0, "ELETTRICA".length());
                    }
                    if (ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON() == 2) {
                        hd.characters("MECCANICA".toCharArray(), 0, "MECCANICA".length());
                    }
                    if (ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON() == 3) {
                        hd.characters("FIAMMA LIBERA".toCharArray(), 0, "FIAMMA LIBERA".length());
                    }
                    if (ContrattoOriginale_Bean.getAPP_INT_ASS_COD_CON() == 4) {
                        //hd.characters("ALTRO:".toCharArray(), 0, "ALTRO:".length());
                        // APP_INT_ASS_CON_DES tag
                        hd.startElement("","","APP_INT_ASS_CON_DES",atts);
                        hd.characters(ContrattoOriginale_Bean.getAPP_INT_ASS_CON_DES().toCharArray(), 0, ContrattoOriginale_Bean.getAPP_INT_ASS_CON_DES().length());
                        hd.endElement("","","APP_INT_ASS_CON_DES");
                    }
                hd.endElement("","","APP_INT_ASS_COD_CON");
                }
                // Personale_coinvolto_app tag
                hd.startElement("","","Personale_coinvolto_app",atts);
                
                // Conto i record presenti
                col = per_coi_app_home.findEx_PersonaleCoinvoltoApp(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, 0);
                it = col.iterator();
                iCount = 0;
                recCount = 0;
                while (it.hasNext()) {
                    per_coi_app = (AppPersonaleCoinvolto_View) it.next();
                    recCount = ++iCount;
                }
                
                // inserisco, regolarmente, i dati nell'xml
                col = per_coi_app_home.findEx_PersonaleCoinvoltoApp(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, 0);
                it = col.iterator();
                iCount = 0;
                iCountIncr = 0;
                while (it.hasNext()) {
                    per_coi_app = (AppPersonaleCoinvolto_View) it.next();
                    // Personale tag
                    hd.startElement("","","Personale",atts);
                        // Persona tag
                        hd.startElement("","","Persona",atts);
                            // NOM_num tag
                            hd.startElement("","","NOM_num",atts);
                            iCountIncr = ++iCount;
                            hd.characters(((String.valueOf(iCountIncr)).concat(".")).toCharArray(), 0, ((String.valueOf(iCountIncr)).concat(".")).length());
                            hd.endElement("","","NOM_num");
                            // NOM tag
                            hd.startElement("","","NOM",atts);
                            hd.characters(per_coi_app.NOM.toCharArray(), 0, per_coi_app.NOM.length());
                            hd.endElement("","","NOM");
                            // QUA tag
                            hd.startElement("","","QUA",atts);
                            characters(hd, per_coi_app.QUA);
                            hd.endElement("","","QUA");
                        hd.endElement("","","Persona");
                    hd.endElement("","","Personale");
                }
                
                // al fine di ottenere un miglior layout,
                // garantisco la stampa di almeno 10 righe
                // a prescindere dalla presenza o meno di 10 record.
                for (int i=recCount; i<10; i++) {
                    hd.startElement("","","Personale",atts);
                        hd.startElement("","","Persona",atts);
                            // NOM_num tag
                            hd.startElement("","","NOM_num",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","NOM_num");
                            // NOM tag
                            hd.startElement("","","NOM",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","NOM");
                            // QUA tag
                            hd.startElement("","","QUA",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","QUA");
                        hd.endElement("","","Persona");
                    hd.endElement("","","Personale");
                }
                hd.endElement("","","Personale_coinvolto_app");
                // ProdottiSostanze_app tag
                hd.startElement("","","ProdottiSostanze_app",atts);
                col = pro_sos_app_home.findEx_ProdottiSostanzeApp(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
                it = col.iterator();
                while (it.hasNext()) {
                    pro_sos_app = (ProdottiSostanzeApp_View) it.next();
                    // ProdottiSostanze tag
                    hd.startElement("","","ProdottiSostanze",atts);
                        // ProdottoSostanza tag
                        hd.startElement("","","ProdottoSostanza",atts);
                            // DES tag
                            hd.startElement("","","DES",atts);
                            
                            hd.characters(("- ".concat(pro_sos_app.DES)).toCharArray(), 0, ("- ".concat(pro_sos_app.DES)).length());
                            hd.endElement("","","DES");
                        hd.endElement("","","ProdottoSostanza");
                    hd.endElement("","","ProdottiSostanze");
                }
                hd.endElement("","","ProdottiSostanze_app");
                // PRO_SOS_DES tag
                if(ContrattoOriginale_Bean.getPRO_SOS_DES() != null) {
                hd.startElement("","","PRO_SOS_DES",atts);
                hd.characters(ContrattoOriginale_Bean.getPRO_SOS_DES().toCharArray(), 0, ContrattoOriginale_Bean.getPRO_SOS_DES().length());
                hd.endElement("","","PRO_SOS_DES");
                }
            hd.endElement("","","DESCRIZIONE_SERVIZI_APP");
        hd.endElement("","","DUVRI_04");


        //-------------------- GENERAZIONE DEL FILE XML: Facciata 5 del DUVRI -------------------
        // DUVRI_05 tag
        hd.startElement("","","DUVRI_05",atts);
        // ANALISI_RISCHI_APP tag
        hd.startElement("","","ANALISI_RISCHI_APP",atts);
        
        // APPALTATRICE_05 tag
        hd.startElement("","","APPALTATRICE_05",atts);
        //dte_app_bean = dte_app_home.findByPrimaryKey(ContrattoOriginale_Bean.getAPP_COD_DTE());
        hd.characters(dte_app_bean.getRAG_SCL_DTE().toCharArray(), 0, dte_app_bean.getRAG_SCL_DTE().length());
        hd.endElement("","","APPALTATRICE_05");
            
        // Analisi_rischi tag
        hd.startElement("","","Analisi_rischi",atts);

        // Conto i record presenti
        col = ana_ris_app_home.findEx_AnalisiRischiApp(ContrattoOriginale_Bean.getCOD_SRV());
        it = col.iterator();
        iCount = 0;
        recCount = 0;
        while (it.hasNext()) {
            ana_ris_app = (AnalisiRischiApp_View) it.next();
            recCount = ++iCount;
        }
        

        // inserisco, regolarmente, i dati nell'xml
        col = ana_ris_app_home.findEx_AnalisiRischiApp(ContrattoOriginale_Bean.getCOD_SRV());
        it = col.iterator();
        while (it.hasNext()){
            ana_ris_app = (AnalisiRischiApp_View) it.next();
            // Rischi tag
            hd.startElement("","","Rischi",atts);
            // Rischio tag
            hd.startElement("","","Rischio",atts);
            // FAS_LAV tag
            if (ana_ris_app.FAS_LAV != null) {
                hd.startElement("","","FAS_LAV",atts);
                hd.characters(ana_ris_app.FAS_LAV.toCharArray(), 0, ana_ris_app.FAS_LAV.length());
                hd.endElement("","","FAS_LAV");
            }
            // MOD_OPE tag
            if (ana_ris_app.MOD_OPE != null) {
                hd.startElement("","","MOD_OPE",atts);
                hd.characters(ana_ris_app.MOD_OPE.toCharArray(), 0, ana_ris_app.MOD_OPE.length());
                hd.endElement("","","MOD_OPE");
            }
            // MAT_PRO_IMP tag
            if (ana_ris_app.MAT_PRO_IMP != null) {
                hd.startElement("","","MAT_PRO_IMP",atts);
                hd.characters(ana_ris_app.MAT_PRO_IMP.toCharArray(), 0, ana_ris_app.MAT_PRO_IMP.length());
                hd.endElement("","","MAT_PRO_IMP");
            }
            // RIS tag
            hd.startElement("","","RIS",atts);
            hd.characters(ana_ris_app.RIS.toCharArray(), 0, ana_ris_app.RIS.length());
            hd.endElement("","","RIS");
            // MIS_PRE_PRO tag
            hd.startElement("","","MIS_PRE_PRO",atts);
            characters(hd, ana_ris_app.MIS_PRE_PRO);
            hd.endElement("","","MIS_PRE_PRO");
            hd.endElement("","","Rischio");
            hd.endElement("","","Rischi");
        }
				
        // al fine di ottenere un miglior layout, solo nel caso di assenza di dati,
        // garantisco la stampa di 10 righe vuote in tabella
        if (recCount == 0) {
            for (int i=0; i<10; i++) {
                hd.startElement("","","Rischi",atts);
                hd.startElement("","","Rischio",atts);
                // FAS_LAV tag
                hd.startElement("","","FAS_LAV",atts);
                hd.characters("".toCharArray(), 0, "".length());
                hd.endElement("","","FAS_LAV");
                // MOD_OPE tag
                hd.startElement("","","MOD_OPE",atts);
                hd.characters("".toCharArray(), 0, "".length());
                hd.endElement("","","MOD_OPE");
                // MAT_PRO_IMP tag
                hd.startElement("","","MAT_PRO_IMP",atts);
                hd.characters("".toCharArray(), 0, "".length());
                hd.endElement("","","MAT_PRO_IMP");
                // RIS tag
                hd.startElement("","","RIS",atts);
                hd.characters("".toCharArray(), 0, "".length());
                hd.endElement("","","RIS");
                // MIS_PRE_PRO tag
                hd.startElement("","","MIS_PRE_PRO",atts);
                hd.characters("".toCharArray(), 0, "".length());
                hd.endElement("","","MIS_PRE_PRO");
                hd.endElement("","","Rischio");
                hd.endElement("","","Rischi");
            }
        }
				
        hd.endElement("","","Analisi_rischi");
        hd.endElement("","","ANALISI_RISCHI_APP");
        hd.endElement("","","DUVRI_05");


        //-------------------- GENERAZIONE DEL FILE XML: Facciata 6 del DUVRI -------------------
    // DUVRI_06 tag
    hd.startElement("","","DUVRI_06",atts);
        // DESCRIZIONE_SERVIZI_SUB_APP tag
        hd.startElement("","","DESCRIZIONE_SERVIZI_SUB_APP",atts);
            // Descrizioni_sub_app tag
            //hd.startElement("","","Descrizioni_sub_app",atts);
            col = sub_app_home.findEx_SubApp(Security.getAzienda(), ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
            it = col.iterator();
            iCountSubApp = 0;
            iCountIncrSubApp = 0;
            while (it.hasNext()) {
                sub_app = (SubApp_View) it.next();
                // Subappaltatrici tag
                hd.startElement("","","Subappaltatrici",atts);
                    // Subappaltatrice tag
                    hd.startElement("","","Subappaltatrice",atts);
                    // SUB_APP_num tag
                    hd.startElement("","","SUB_APP_num",atts);
                    iCountIncrSubApp = ++iCountSubApp;
                    hd.characters(String.valueOf(iCountIncrSubApp).toCharArray(), 0, String.valueOf(iCountIncrSubApp).length());
                    hd.endElement("","","SUB_APP_num");
                        // SUBAPPALTATRICE_06 tag
                        //if(sub_app_bean.getCOD_SUB_APP() != 0) {
                        hd.startElement("","","SUBAPPALTATRICE_06",atts);
                        hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
                        hd.endElement("","","SUBAPPALTATRICE_06");
                        //}
                        // RAG_SCL_DTE tag
                        //if(sub_app_bean.getCOD_SUB_APP() != 0) {
                        hd.startElement("","","RAG_SCL_DTE",atts);
                        hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
                        hd.endElement("","","RAG_SCL_DTE");
                        //}
                        // TEL tag
                        if(sub_app.TEL != null) {
                        hd.startElement("","","TEL",atts);
                        hd.characters(sub_app.TEL.toCharArray(), 0, sub_app.TEL.length());
                        hd.endElement("","","TEL");
                        }
                        // FAX tag
                        if(sub_app.FAX != null) {
                        hd.startElement("","","FAX",atts);
                        hd.characters(sub_app.FAX.toCharArray(), 0, sub_app.FAX.length());
                        hd.endElement("","","FAX");  
                        }
                        // EMAIL tag
                        if(sub_app.EMAIL != null) {
                        hd.startElement("","","EMAIL",atts);
                        hd.characters(sub_app.EMAIL.toCharArray(), 0, sub_app.EMAIL.length());
                        hd.endElement("","","EMAIL");
                        }
                        // RES_LOC_NOM tag
                        if(sub_app.RES_LOC_NOM != null) {
                        hd.startElement("","","RES_LOC_NOM",atts);
                        hd.characters(sub_app.RES_LOC_NOM.toCharArray(), 0, sub_app.RES_LOC_NOM.length());
                        hd.endElement("","","RES_LOC_NOM");
                        }
                        // RES_LOC_QUA tag
                        if(sub_app.RES_LOC_QUA != null) {
                        hd.startElement("","","RES_LOC_QUA",atts);
                        hd.characters(sub_app.RES_LOC_QUA.toCharArray(), 0, sub_app.RES_LOC_QUA.length());
                        hd.endElement("","","RES_LOC_QUA");
                        }
                        // RES_LOC_TEL tag
                        if(sub_app.RES_LOC_TEL != null) {
                        hd.startElement("","","RES_LOC_TEL",atts);
                        hd.characters(sub_app.RES_LOC_TEL.toCharArray(), 0, sub_app.RES_LOC_TEL.length());
                        hd.endElement("","","RES_LOC_TEL");
                        }
                        // INT_ASS_DES tag
                        if(sub_app.INT_ASS_DES != null) {
                        hd.startElement("","","INT_ASS_DES",atts);
                        hd.characters(sub_app.INT_ASS_DES.toCharArray(), 0, sub_app.INT_ASS_DES.length());
                        hd.endElement("","","INT_ASS_DES");
                        }
                        // DAT_INI_LAV tag
                        if(sub_app.DAT_INI_LAV != null) {
                            hd.startElement("","","DAT_INI_LAV",atts);
                            hd.characters(Formatter.format(sub_app.DAT_INI_LAV).toCharArray(), 0, Formatter.format(sub_app.DAT_INI_LAV).length());
                            hd.endElement("","","DAT_INI_LAV");
                        }
                        // DAT_FIN_LAV tag
                        if(sub_app.DAT_FIN_LAV != null) {
                            hd.startElement("","","DAT_FIN_LAV",atts);
                            hd.characters(Formatter.format(sub_app.DAT_FIN_LAV).toCharArray(), 0, Formatter.format(sub_app.DAT_FIN_LAV).length());
                            hd.endElement("","","DAT_FIN_LAV");
                        }
                        // LAV_NOT tag
                        if(sub_app.LAV_NOT != null) {
                            hd.startElement("","","LAV_NOT",atts);
                            if (sub_app.LAV_NOT.equals("S")) {
                                hd.characters("SI".toCharArray(), 0, "SI".length());
                            } else {
                                hd.characters("NO".toCharArray(), 0, "NO".length());
                            }
                            hd.endElement("","","LAV_NOT");
                        }
                        // ORA_LAV tag
                        if(sub_app.ORA_LAV != null) {
                        hd.startElement("","","ORA_LAV",atts);
                        hd.characters(sub_app.ORA_LAV.toString().toCharArray(), 0, sub_app.ORA_LAV.toString().length());
                        hd.endElement("","","ORA_LAV");
                        }
                        // COD_CON tag
                        if(sub_app.COD_CON != 0) {
                            hd.startElement("","","COD_CON",atts);
                            if (sub_app.COD_CON == 1) {
                                hd.characters("ELETTRICA".toCharArray(), 0, "ELETTRICA".length());
                            }
                            if (sub_app.COD_CON == 2) {
                                hd.characters("MECCANICA".toCharArray(), 0, "MECCANICA".length());
                            }
                            if (sub_app.COD_CON == 3) {
                                hd.characters("FIAMMA LIBERA".toCharArray(), 0, "FIAMMA LIBERA".length());
                            }
                            if (sub_app.COD_CON == 4) {
                                //hd.characters("ALTRO:".toCharArray(), 0, "ALTRO:".length());
                                // CON_DES tag
                                hd.startElement("","","CON_DES",atts);
                                hd.characters(sub_app.CON_DES.toCharArray(), 0, sub_app.CON_DES.length());
                                hd.endElement("","","CON_DES");
                            }
                            hd.endElement("","","COD_CON");
                        }
                    // Personale_coinvolto_sub_app tag
                    hd.startElement("","","Personale_coinvolto_sub_app",atts);
                    
                    // Conto i record presenti
                    colInt = per_coi_sub_app_home.findEx_PersonaleCoinvoltoSubApp(sub_app.COD_SUB_APP, 0L, null, null, 0);
                    itInt = colInt.iterator();
                    iCount = 0;
                    recCount = 0;
                    while (itInt.hasNext()) {
                        per_coi_sub_app = (SubAppPersonaleCoinvolto_View) itInt.next();
                        recCount = ++iCount;
                    }

                    // inserisco, regolarmente, i dati nell'xml
                    colInt = per_coi_sub_app_home.findEx_PersonaleCoinvoltoSubApp(sub_app.COD_SUB_APP, 0L, null, null, 0);
                    itInt = colInt.iterator();
                    iCount = 0;
                    iCountIncr = 0;
                    while (itInt.hasNext()) {
                        per_coi_sub_app = (SubAppPersonaleCoinvolto_View) itInt.next();
                        // Personale tag
                        hd.startElement("","","Personale",atts);
                        // Persona tag
                        hd.startElement("","","Persona",atts);
                        // NOM_num tag
                        hd.startElement("","","NOM_num",atts);
                        iCountIncr = ++iCount;
                        hd.characters(((String.valueOf(iCountIncr)).concat(".")).toCharArray(), 0, ((String.valueOf(iCountIncr)).concat(".")).length());
                        hd.endElement("","","NOM_num");
                        // NOM tag
                        hd.startElement("","","NOM",atts);
                        hd.characters(per_coi_sub_app.NOM.toCharArray(), 0, per_coi_sub_app.NOM.length());
                        hd.endElement("","","NOM");
                        // QUA tag
                        hd.startElement("","","QUA",atts);
                        characters(hd, per_coi_sub_app.QUA);
                        hd.endElement("","","QUA");
                        hd.endElement("","","Persona");
                        hd.endElement("","","Personale");
                    }
                    
                    // al fine di ottenere un miglior layout,
                    // garantisco la stampa di almeno 6 righe
                    // a prescindere dalla presenza o meno di 6 record.
                    for (int i=recCount; i<6; i++) {
                        hd.startElement("","","Personale",atts);
                        hd.startElement("","","Persona",atts);
                        // NOM_num tag
                        hd.startElement("","","NOM_num",atts);
                        hd.characters("".toCharArray(), 0, "".length());
                        hd.endElement("","","NOM_num");
                        // NOM tag
                        hd.startElement("","","NOM",atts);
                        hd.characters("".toCharArray(), 0, "".length());
                        hd.endElement("","","NOM");
                        // QUA tag
                        hd.startElement("","","QUA",atts);
                        hd.characters("".toCharArray(), 0, "".length());
                        hd.endElement("","","QUA");
                        hd.endElement("","","Persona");
                        hd.endElement("","","Personale");
                    }
                    hd.endElement("","","Personale_coinvolto_sub_app");
                    // ProdottiSostanze_sub_app tag
                    hd.startElement("","","ProdottiSostanze_sub_app",atts);
                    colInt = pro_sos_sub_app_home.findEx_ProdottiSostanzeSubApp(sub_app.COD_SUB_APP, 0L, null, 0);
                    itInt = colInt.iterator();
                    while (itInt.hasNext()) {
                        pro_sos_sub_app = (ProdottiSostanzeSubApp_View) itInt.next();
                        // ProdottiSostanze tag
                        hd.startElement("","","ProdottiSostanze",atts);
                        // ProdottoSostanza tag
                        hd.startElement("","","ProdottoSostanza",atts);
                        // DES tag
                        hd.startElement("","","DES",atts);
                        hd.characters(("- ".concat(pro_sos_sub_app.DES)).toCharArray(), 0, ("- ".concat(pro_sos_sub_app.DES)).length());
                        hd.endElement("","","DES");
                        hd.endElement("","","ProdottoSostanza");
                        hd.endElement("","","ProdottiSostanze");
                    }
                    hd.endElement("","","ProdottiSostanze_sub_app");
                    // PRO_SOS_DES tag
                    if(ContrattoOriginale_Bean.getPRO_SOS_SUB_APP_DES() != null) {
                        hd.startElement("","","PRO_SOS_SUB_APP_DES",atts);
                        hd.characters(ContrattoOriginale_Bean.getPRO_SOS_SUB_APP_DES().toCharArray(), 0, ContrattoOriginale_Bean.getPRO_SOS_SUB_APP_DES().length());
                        hd.endElement("","","PRO_SOS_SUB_APP_DES");
                    }
                    // SUB_APP_numero tag
                    hd.startElement("","","SUB_APP_numero",atts);
                    //iCountIncrSubApp = ++iCountSubApp;
                    hd.characters(String.valueOf(iCountIncrSubApp).toCharArray(), 0, String.valueOf(iCountIncrSubApp).length());
                    hd.endElement("","","SUB_APP_numero");
                    
                    // SUBAPPALTATRICE_07 tag
                    hd.startElement("","","SUBAPPALTATRICE_07",atts);
                    hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
                    hd.endElement("","","SUBAPPALTATRICE_07");
                    
                    hd.startElement("","","Analisi_rischi",atts);
                    
                    // Conto i record presenti
                    colInt = ana_ris_sub_app_home.findEx_AnalisiRischiSubApp(sub_app.COD_SUB_APP);
                    itInt = colInt.iterator();
                    iCount = 0;
                    recCount = 0;
                    while (itInt.hasNext()) {
                        ana_ris_sub_app = (AnalisiRischiSubApp_View) itInt.next();
                        recCount = ++iCount;
                    }

                    // inserisco, regolarmente, i dati nell'xml
                    colInt = ana_ris_sub_app_home.findEx_AnalisiRischiSubApp(sub_app.COD_SUB_APP);
                    itInt = colInt.iterator();
                    while (itInt.hasNext()) {
                        ana_ris_sub_app = (AnalisiRischiSubApp_View) itInt.next();
                        // Rischi tag
                        hd.startElement("","","Rischi",atts);
                        // Rischio tag
                        hd.startElement("","","Rischio",atts);
                        // FAS_LAV tag
                        hd.startElement("","","FAS_LAV",atts);
                        characters(hd, ana_ris_sub_app.FAS_LAV);
                        hd.endElement("","","FAS_LAV");
                        // MOD_OPE tag
                        hd.startElement("","","MOD_OPE",atts);
                        characters(hd, ana_ris_sub_app.MOD_OPE);
                        hd.endElement("","","MOD_OPE");
                        // MAT_PRO_IMP tag
                        hd.startElement("","","MAT_PRO_IMP",atts);
                        characters(hd, ana_ris_sub_app.MAT_PRO_IMP);
                        hd.endElement("","","MAT_PRO_IMP");
                        // RIS tag
                        hd.startElement("","","RIS",atts);
                        hd.characters(ana_ris_sub_app.RIS.toCharArray(), 0, ana_ris_sub_app.RIS.length());
                        hd.endElement("","","RIS");
                        // MIS_PRE_PRO tag
                        hd.startElement("","","MIS_PRE_PRO",atts);
                        characters(hd, ana_ris_sub_app.MIS_PRE_PRO);
                        hd.endElement("","","MIS_PRE_PRO");
                        hd.endElement("","","Rischio");
                        hd.endElement("","","Rischi");
                    }
                    
                    // al fine di ottenere un miglior layout, solo nel caso di assenza di dati,
                    // garantisco la stampa di 10 righe vuote
                    if (recCount == 0) {
                        for (int i=recCount; i<10; i++) {
                            hd.startElement("","","Rischi",atts);
                            hd.startElement("","","Rischio",atts);
                            // FAS_LAV tag
                            hd.startElement("","","FAS_LAV",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","FAS_LAV");
                            // MOD_OPE tag
                            hd.startElement("","","MOD_OPE",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","MOD_OPE");
                            // MAT_PRO_IMP tag
                            hd.startElement("","","MAT_PRO_IMP",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","MAT_PRO_IMP");
                            // RIS tag
                            hd.startElement("","","RIS",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","RIS");
                            // MIS_PRE_PRO tag
                            hd.startElement("","","MIS_PRE_PRO",atts);
                            hd.characters("".toCharArray(), 0, "".length());
                            hd.endElement("","","MIS_PRE_PRO");
                            hd.endElement("","","Rischio");
                            hd.endElement("","","Rischi");
                        }
                    }
                    hd.endElement("","","Analisi_rischi");
                hd.endElement("","","Subappaltatrice");
            hd.endElement("","","Subappaltatrici");
            }
            //hd.endElement("","","Descrizioni_sub_app");
        hd.endElement("","","DESCRIZIONE_SERVIZI_SUB_APP");
    hd.endElement("","","DUVRI_06");      


    //-------------------- GENERAZIONE DEL FILE XML: Facciata 8 del DUVRI -------------------
    // DUVRI_08 tag
    hd.startElement("","","DUVRI_08",atts);
        // RISCHI_GENERICI_CMT tag
        hd.startElement("","","RISCHI_GENERICI_CMT",atts);
        hd.endElement("","","RISCHI_GENERICI_CMT");
    hd.endElement("","","DUVRI_08");
        

    //-------------------- GENERAZIONE DEL FILE XML: Facciata 9 del DUVRI -------------------
    // DUVRI_09 tag
    hd.startElement("","","DUVRI_09",atts);
    // RISCHI_GENERICI_CMT tag
    hd.startElement("","","RISCHI_CONNESSI_INTERFERENZA",atts);
    
    // Conto i record presenti
    col = ris_int_home.getContServRischiInterferenza_View(ContrattoOriginale_Bean.getCOD_SRV());
    it = col.iterator();
    iCount = 0;
    recCount = 0;
    while (it.hasNext()) {
        ris_int = (ContServRischiInterferenza_View) it.next();
        recCount = ++iCount;
    }

    // inserisco, regolarmente, i dati nell'xml
    col = ris_int_home.getContServRischiInterferenza_View(ContrattoOriginale_Bean.getCOD_SRV());
    it = col.iterator();
    while (it.hasNext()) {
        ris_int = (ContServRischiInterferenza_View) it.next();
        // Rischi_interferenza tag
        hd.startElement("","","Rischi_interferenza",atts);
        // Rischio_interferenza tag
        hd.startElement("","","Rischio_interferenza",atts);
        // FAS_LAV tag
        hd.startElement("","","FAS_LAV",atts);
        characters(hd, ris_int.FAS_LAV);
        hd.endElement("","","FAS_LAV");
        // TIP_INT tag
        hd.startElement("","","TIP_INT",atts);
        characters(hd, ris_int.TIP_INT);
        hd.endElement("","","TIP_INT");
        // IMP_INT tag
        hd.startElement("","","IMP_INT",atts);
        characters(hd, ris_int.IMP_INT);
        hd.endElement("","","IMP_INT");
        // RIS tag
        hd.startElement("","","RIS",atts);
        hd.characters(ris_int.RIS.toCharArray(), 0, ris_int.RIS.length());
        hd.endElement("","","RIS");
        // MIS_PRE tag
        hd.startElement("","","MIS_PRE",atts);
        characters(hd, ris_int.MIS_PRE);
        hd.endElement("","","MIS_PRE");
        hd.endElement("","","Rischio_interferenza");
        hd.endElement("","","Rischi_interferenza");
    }
    
    // al fine di ottenere un miglior layout, solo in caso di assenza di dati,
    // garantisco la stampa di 10 righe
    if (recCount == 0) {
        for (int i=recCount; i<10; i++) {
            hd.startElement("","","Rischi_interferenza",atts);
            hd.startElement("","","Rischio_interferenza",atts);
            // FAS_LAV tag
            hd.startElement("","","FAS_LAV",atts);
            hd.characters("".toCharArray(), 0, "".length());
            hd.endElement("","","FAS_LAV");
            // TIP_INT tag
            hd.startElement("","","TIP_INT",atts);
            hd.characters("".toCharArray(), 0, "".length());
            hd.endElement("","","TIP_INT");
            // IMP_INT tag
            hd.startElement("","","IMP_INT",atts);
            hd.characters("".toCharArray(), 0, "".length());
            hd.endElement("","","IMP_INT");
            // RIS tag
            hd.startElement("","","RIS",atts);
            hd.characters("".toCharArray(), 0, "".length());
            hd.endElement("","","RIS");
            // MIS_PRE tag
            hd.startElement("","","MIS_PRE",atts);
            hd.characters("".toCharArray(), 0, "".length());
            hd.endElement("","","MIS_PRE");
            hd.endElement("","","Rischio_interferenza");
            hd.endElement("","","Rischi_interferenza");
        }
    }
    hd.endElement("","","RISCHI_CONNESSI_INTERFERENZA");
    hd.endElement("","","DUVRI_09");
    
    
    //-------------------- GENERAZIONE DEL FILE XML: Facciata 10 del DUVRI -------------------
    // DUVRI_10 tag
    hd.startElement("","","DUVRI_10",atts);
    // DISPOSIZIONE_SERVIZI_SANITARI tag
    hd.startElement("","","DISPOSIZIONE_SERVIZI_SANITARI",atts);
    // SER_SAN_DES_1 tag
    if(ContrattoOriginale_Bean.getSER_SAN_DES_1() != null) {
    hd.startElement("","","SER_SAN_DES_1",atts);
    hd.characters(ContrattoOriginale_Bean.getSER_SAN_DES_1().toCharArray(), 0, ContrattoOriginale_Bean.getSER_SAN_DES_1().length());
    hd.endElement("","","SER_SAN_DES_1");
    }
    
    // Conto i record presenti
    col = ser_san_home.findEx_ServiziSanitari(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    iCount = 0;
    recCount = 0;
    while (it.hasNext()) {
        ser_san = (ServiziSanitari_View) it.next();
        recCount = ++iCount;
    }

    // inserisco, regolarmente, i dati nell'xml
    col = ser_san_home.findEx_ServiziSanitari(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    while (it.hasNext()) {
        ser_san = (ServiziSanitari_View) it.next();
        // Servizi_sanitari tag
        hd.startElement("","","Servizi_sanitari",atts);
        // Servizio_sanitario tag
        hd.startElement("","","Servizio_sanitario",atts);
        // DES_SRV_VIT tag
        hd.startElement("","","DES_SRV_VIT",atts);
        hd.characters(ser_san.DES_SRV_VIT.toCharArray(), 0, ser_san.DES_SRV_VIT.length());
        hd.endElement("","","DES_SRV_VIT");
        // DAT_INI_IMP tag
        hd.startElement("","","DAT_INI_IMP",atts);
        hd.characters(Formatter.format(ser_san.DAT_INI_IMP).toCharArray(), 0, Formatter.format(ser_san.DAT_INI_IMP).length());
        hd.endElement("","","DAT_INI_IMP");
        // DAT_FIN_IMP tag
        hd.startElement("","","DAT_FIN_IMP",atts);
        hd.characters(Formatter.format(ser_san.DAT_FIN_IMP).toCharArray(), 0, Formatter.format(ser_san.DAT_FIN_IMP).length());
        hd.endElement("","","DAT_FIN_IMP");
        // ORA_IMP tag
        hd.startElement("","","ORA_IMP",atts);
        characters(hd, ser_san.ORA_IMP);
        hd.endElement("","","ORA_IMP");
        hd.endElement("","","Servizio_sanitario");
        hd.endElement("","","Servizi_sanitari");
    }
    
    // al fine di ottenere un miglior layout,
    // garantisco la stampa di almeno 6 righe
    // a prescindere dalla presenza o meno di 6 record.
    for (int i=recCount; i<6; i++) {
        hd.startElement("","","Servizi_sanitari",atts);
        hd.startElement("","","Servizio_sanitario",atts);
        // DES_SRV_VIT tag
        hd.startElement("","","DES_SRV_VIT",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","DES_SRV_VIT");
        // DAT_INI_IMP tag
        hd.startElement("","","DAT_INI_IMP",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","DAT_INI_IMP");
        // DAT_FIN_IMP tag
        hd.startElement("","","DAT_FIN_IMP",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","DAT_FIN_IMP");
        // ORA_IMP tag
        hd.startElement("","","ORA_IMP",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","ORA_IMP");
        hd.endElement("","","Servizio_sanitario");
        hd.endElement("","","Servizi_sanitari");
    }
    // SER_SAN_DES_2 tag
    if(ContrattoOriginale_Bean.getSER_SAN_DES_2() != null) {
    hd.startElement("","","SER_SAN_DES_2",atts);
    hd.characters(ContrattoOriginale_Bean.getSER_SAN_DES_2().toCharArray(), 0, ContrattoOriginale_Bean.getSER_SAN_DES_2().length());
    hd.endElement("","","SER_SAN_DES_2");
    }
    // SER_SAN_DES_3 tag
    if(ContrattoOriginale_Bean.getSER_SAN_DES_3() != null) {
    hd.startElement("","","SER_SAN_DES_3",atts);
    hd.characters(ContrattoOriginale_Bean.getSER_SAN_DES_3().toCharArray(), 0, ContrattoOriginale_Bean.getSER_SAN_DES_3().length());
    hd.endElement("","","SER_SAN_DES_3");
    }
    
    hd.endElement("","","DISPOSIZIONE_SERVIZI_SANITARI");
    hd.endElement("","","DUVRI_10");
    
    
    //-------------------- GENERAZIONE DEL FILE XML: Facciata 11 del DUVRI -------------------
    // DUVRI_11 tag
    hd.startElement("","","DUVRI_11",atts);
    // DISPOSIZIONE_FLUIDI tag
    hd.startElement("","","DISPOSIZIONE_FLUIDI",atts);
    // FLU_DES_1 tag
    if(ContrattoOriginale_Bean.getFLU_DES_1() != null) {
    hd.startElement("","","FLU_DES_1",atts);
    hd.characters(ContrattoOriginale_Bean.getFLU_DES_1().toCharArray(), 0, ContrattoOriginale_Bean.getFLU_DES_1().length());
    hd.endElement("","","FLU_DES_1");
    }
    
    // Conto i record presenti
    col = flu_home.findEx_Fluidi(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    iCount = 0;
    recCount = 0;
    while (it.hasNext()) {
        flu = (Fluidi_View) it.next();
        recCount = ++iCount;
    }

    // inserisco, regolarmente, i dati nell'xml
    col = flu_home.findEx_Fluidi(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    iCount = 0;
    while (it.hasNext()) {
        flu = (Fluidi_View) it.next();
        // Fluidi tag
        hd.startElement("","","Fluidi",atts);
        // Fluido tag
        hd.startElement("","","Fluido",atts);
        // TIP_FLU_DIS tag
        hd.startElement("","","TIP_FLU_DIS",atts);
        hd.characters(flu.TIP_FLU_DIS.toCharArray(), 0, flu.TIP_FLU_DIS.length());
        hd.endElement("","","TIP_FLU_DIS");
        // LUO_COL tag
        hd.startElement("","","LUO_COL",atts);
        characters(hd, flu.LUO_COL);
        hd.endElement("","","LUO_COL");
        // DAT_INI_CON tag
        if(flu.DAT_INI_CON != null) {
        hd.startElement("","","DAT_INI_CON",atts);
        hd.characters(Formatter.format(flu.DAT_INI_CON).toCharArray(), 0, Formatter.format(flu.DAT_INI_CON).length());
        hd.endElement("","","DAT_INI_CON");
        }
        // DAT_FIN_CON tag
        if(flu.DAT_FIN_CON != null) {
        hd.startElement("","","DAT_FIN_CON",atts);
        hd.characters(Formatter.format(flu.DAT_FIN_CON).toCharArray(), 0, Formatter.format(flu.DAT_FIN_CON).length());
        hd.endElement("","","DAT_FIN_CON");
        }
        hd.endElement("","","Fluido");
        hd.endElement("","","Fluidi");
    }
    // al fine di ottenere un miglior layout,
    // garantisco la stampa di almeno 5 righe
    // a prescindere dalla presenza o meno di 5 record.
    for (int i=recCount; i<5; i++) {
        hd.startElement("","","Fluidi",atts);
        hd.startElement("","","Fluido",atts);
        // TIP_FLU_DIS tag
        hd.startElement("","","TIP_FLU_DIS",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","TIP_FLU_DIS");
        // LUO_COL tag
        hd.startElement("","","LUO_COL",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","LUO_COL");
        // DAT_INI_CON tag
        //if(flu.DAT_INI_CON != null) {
        hd.startElement("","","DAT_INI_CON",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","DAT_INI_CON");
        //}
        // DAT_FIN_CON tag
        //if(flu.DAT_FIN_CON != null) {
        hd.startElement("","","DAT_FIN_CON",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","DAT_FIN_CON");
        //}
        hd.endElement("","","Fluido");
        hd.endElement("","","Fluidi");
    }
    // FLU_DES_2 tag
    if(ContrattoOriginale_Bean.getFLU_DES_2() != null) {
    hd.startElement("","","FLU_DES_2",atts);
    hd.characters(ContrattoOriginale_Bean.getFLU_DES_2().toCharArray(), 0, ContrattoOriginale_Bean.getFLU_DES_2().length());
    hd.endElement("","","FLU_DES_2");
    }
    hd.endElement("","","DISPOSIZIONE_FLUIDI");
    hd.endElement("","","DUVRI_11");
    
    
    //-------------------- GENERAZIONE DEL FILE XML: Facciata 12 del DUVRI -------------------
    // DUVRI_12 tag
    hd.startElement("","","DUVRI_12",atts);
    // DISPOSIZIONE_MATERIALI tag
    hd.startElement("","","PRESTITO_MATERIALI",atts);
    // PRE_MAT_DES_1 tag
    if(ContrattoOriginale_Bean.getPRE_MAT_DES_1() != null) {
    hd.startElement("","","PRE_MAT_DES_1",atts);
    hd.characters(ContrattoOriginale_Bean.getPRE_MAT_DES_1().toCharArray(), 0, ContrattoOriginale_Bean.getPRE_MAT_DES_1().length());
    hd.endElement("","","PRE_MAT_DES_1");
    }
    
    // Conto i record presenti
    col = pre_mat_home.findEx_PrestitoMateriali(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    iCount = 0;
    recCount = 0;
    while (it.hasNext()) {
        pre_mat = (PrestitoMateriali_View) it.next();
        recCount = ++iCount;
    }

    // inserisco, regolarmente, i dati nell'xml
    col = pre_mat_home.findEx_PrestitoMateriali(ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, null, null, null, 0);
    it = col.iterator();
    while (it.hasNext()) {
        pre_mat = (PrestitoMateriali_View) it.next();
        // Materiali tag
        hd.startElement("","","Materiali",atts);
        // Materiale tag
        hd.startElement("","","Materiale",atts);
        // TIP_MAT tag
        if(pre_mat.TIP_MAT != null) {
            hd.startElement("","","TIP_MAT",atts);
            hd.characters(pre_mat.TIP_MAT.toCharArray(), 0, pre_mat.TIP_MAT.length());
            hd.endElement("","","TIP_MAT");
        }
        // LUO_MES_DIS tag
        if(pre_mat.LUO_MES_DIS != null) {
            hd.startElement("","","LUO_MES_DIS",atts);
            hd.characters(pre_mat.LUO_MES_DIS.toCharArray(), 0, pre_mat.LUO_MES_DIS.length());
            hd.endElement("","","LUO_MES_DIS");
        }
        // DAT_INI_PRE tag
        if(pre_mat.DAT_INI_PRE != null) {
            hd.startElement("","","DAT_INI_PRE",atts);
            hd.characters(Formatter.format(pre_mat.DAT_INI_PRE).toCharArray(), 0, Formatter.format(pre_mat.DAT_INI_PRE).length());
            hd.endElement("","","DAT_INI_PRE");
        }
        // DAT_FIN_PRE tag
        if(pre_mat.DAT_FIN_PRE != null) {
            hd.startElement("","","DAT_FIN_PRE",atts);
            hd.characters(Formatter.format(pre_mat.DAT_FIN_PRE).toCharArray(), 0, Formatter.format(pre_mat.DAT_FIN_PRE).length());
            hd.endElement("","","DAT_FIN_PRE");
        }
        hd.endElement("","","Materiale");
        hd.endElement("","","Materiali");
    }
    
    // al fine di ottenere un miglior layout,
    // garantisco la stampa di almeno 5 righe
    // a prescindere dalla presenza o meno di 5 record.
    for (int i=recCount; i<5; i++) {
        hd.startElement("","","Materiali",atts);
        hd.startElement("","","Materiale",atts);
        // TIP_MAT tag
        hd.startElement("","","TIP_MAT",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","TIP_MAT");
        // LUO_MES_DIS tag
        hd.startElement("","","LUO_MES_DIS",atts);
        hd.characters("".toCharArray(), 0, "".length());
        hd.endElement("","","LUO_MES_DIS");
        // DAT_INI_PRE tag
        hd.startElement("","","DAT_INI_PRE",atts);
        hd.characters("".toString().toCharArray(), 0, "".toString().length());
        hd.endElement("","","DAT_INI_PRE");
        // DAT_FIN_PRE tag
        hd.startElement("","","DAT_FIN_PRE",atts);
        hd.characters("".toCharArray(), 0, "".toString().length());
        hd.endElement("","","DAT_FIN_PRE");
        hd.endElement("","","Materiale");
        hd.endElement("","","Materiali");
    }
    // PRE_MAT_ASS_APP_RAD tag
    if(ContrattoOriginale_Bean.getPRE_MAT_ASS_APP_RAD() != null) {
    hd.startElement("","","PRE_MAT_ASS_APP_RAD",atts);
        if(ContrattoOriginale_Bean.getPRE_MAT_ASS_APP_RAD().equals("S")) {
            hd.characters("SI".toCharArray(), 0, "SI".length());
        } else {
            hd.characters("NO".toCharArray(), 0, "NO".length());
        }
        hd.endElement("","","PRE_MAT_ASS_APP_RAD");
    }
    // PRE_MAT_ASS_TEL_CEL tag
    if(ContrattoOriginale_Bean.getPRE_MAT_ASS_TEL_CEL() != null) {
    hd.startElement("","","PRE_MAT_ASS_TEL_CEL",atts);
        if(ContrattoOriginale_Bean.getPRE_MAT_ASS_TEL_CEL().equals("S")) {
            hd.characters("SI".toCharArray(), 0, "SI".length());
        } else {
            hd.characters("NO".toCharArray(), 0, "NO".length());
        }
        hd.endElement("","","PRE_MAT_ASS_TEL_CEL");
    }
    // PRE_MAT_DES_2 tag
    if(ContrattoOriginale_Bean.getPRE_MAT_DES_2() != null) {
        hd.startElement("","","PRE_MAT_DES_2",atts);
        hd.characters(ContrattoOriginale_Bean.getPRE_MAT_DES_2().toCharArray(), 0, ContrattoOriginale_Bean.getPRE_MAT_DES_2().length());
        hd.endElement("","","PRE_MAT_DES_2");
    }
    hd.endElement("","","PRESTITO_MATERIALI");
    hd.endElement("","","DUVRI_12");
    
    //-------------------- GENERAZIONE DEL FILE XML: Facciata 13 del DUVRI -------------------
    // DUVRI_13 tag
    hd.startElement("","","DUVRI_13",atts);
    // ACCORDO TRA LE DIVERSE PARTI tag
    hd.startElement("","","ACCORDO_TRA_PARTI",atts);
    // RAG_SCL_AZL tag
    // if(ContrattoOriginale_Bean.getPRE_MAT_DES_1() != null) {
        hd.startElement("","","RAG_SCL_AZL",atts);
        azl_bean = azl_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOD_AZL());
        hd.characters(azl_bean.getRAG_SCL_AZL().toCharArray(), 0, azl_bean.getRAG_SCL_AZL().length());
        hd.endElement("","","RAG_SCL_AZL");
    //}
    // RAG_SCL_DTE_app tag
    // if(ContrattoOriginale_Bean.getPRE_MAT_DES_1() != null) {
        hd.startElement("","","RAG_SCL_DTE_app",atts);
        hd.characters(ContrattoOriginale_Bean.getRAG_SCL_DTE().toCharArray(), 0, ContrattoOriginale_Bean.getRAG_SCL_DTE().length());
        hd.endElement("","","RAG_SCL_DTE_app");
    //}
    col = sub_app_home.findEx_SubApp(Security.getAzienda(), ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
    it = col.iterator();
    iCountSubApp = 0;
    iCountIncrSubApp = 0;
    while (it.hasNext()) {
        sub_app = (SubApp_View) it.next();
        // Subappaltatrici tag
        hd.startElement("","","Subappaltatrici",atts);
        // Subappaltatrice tag
        hd.startElement("","","Subappaltatrice",atts);
        // SUB_APP_num tag
        hd.startElement("","","SUB_APP_num",atts);
        iCountIncrSubApp = ++iCountSubApp;
        hd.characters(String.valueOf(iCountIncrSubApp).toCharArray(), 0, String.valueOf(iCountIncrSubApp).length());
        hd.endElement("","","SUB_APP_num");
        // RAG_SCL_DTE_sub_app tag
        hd.startElement("","","RAG_SCL_DTE_sub_app",atts);
        hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
        hd.endElement("","","RAG_SCL_DTE_sub_app");
        hd.endElement("","","Subappaltatrice");
        hd.endElement("","","Subappaltatrici");
    }
    // RAG_SCL_AZL tag
    //if(ContrattoOriginale_Bean.getPRE_MAT_DES_1() != null) {
    hd.startElement("","","RAG_SCL_AZL_nota",atts);
    azl_bean = azl_home.findByPrimaryKey(ContrattoOriginale_Bean.getCOD_AZL());
    hd.characters(azl_bean.getRAG_SCL_AZL().toCharArray(), 0, azl_bean.getRAG_SCL_AZL().length());
    hd.endElement("","","RAG_SCL_AZL_nota");
   // }
    // RAG_SCL_DTE_app tag
   // if(ContrattoOriginale_Bean.getPRE_MAT_DES_1() != null) {
    hd.startElement("","","RAG_SCL_DTE_app_nota",atts);
    hd.characters(ContrattoOriginale_Bean.getRAG_SCL_DTE().toCharArray(), 0, ContrattoOriginale_Bean.getRAG_SCL_DTE().length());
    hd.endElement("","","RAG_SCL_DTE_app_nota");
   // }
    col = sub_app_home.findEx_SubApp(Security.getAzienda(), ContrattoOriginale_Bean.getCOD_SRV(), 0L, null, 0);
    it = col.iterator();
    iCountSubApp = 0;
    iCountIncrSubApp = 0;
    while (it.hasNext()) {
        sub_app = (SubApp_View) it.next();
        // Subappaltatrici tag
        hd.startElement("","","Subappaltatrici_nota",atts);
        // Subappaltatrice tag
        hd.startElement("","","Subappaltatrice_nota",atts);
        // RAG_SCL_DTE_sub_app tag
        hd.startElement("","","RAG_SCL_DTE_sub_app_nota",atts);
        hd.characters(sub_app.RAG_SCL_DTE.toCharArray(), 0, sub_app.RAG_SCL_DTE.length());
        hd.endElement("","","RAG_SCL_DTE_sub_app_nota");
        hd.endElement("","","Subappaltatrice_nota");
        hd.endElement("","","Subappaltatrici_nota");
    }
    hd.endElement("","","ACCORDO_TRA_PARTI");
    hd.endElement("","","DUVRI_13");
    //test
             String p = ApplicationConfigurator.getApplicationURI()+"_security/626.gif";
               hd.startElement("","","IMAGE",atts);
                hd.characters(p.toCharArray(), 0, p.length());
                hd.endElement("","","IMAGE");

            //test
hd.endElement("","","DUVRI");
          
    hd.endDocument();
    fos.close();

        //-------------------------------------------------------------------------
        //------------------ GENERAZIONE DEL DUVRI IN FORMATO PDF -----------------
        //-------------------------------------------------------------------------

        DuvriPDFGenerate.ConvertXML2PDF();

        //-------------------------------------------------------------------------
        //--------------------------- SALVATAGGIO NEL DB --------------------------
        //-------------------------------------------------------------------------

        BynaryFileReader fileRead = new BynaryFileReader();

        File pdfFile = new File(DuvriPDFGenerate.getOutDir() + DuvriPDFGenerate.getPdfFileName());
        File xmlFile = new File(DuvriPDFGenerate.getXMLDir() + DuvriPDFGenerate.getXmlFileName());

        // Inserisco il nuovo DUVRI.
        NuovoDUVRI_Bean = DUVRIOriginale_Home.create(
                lCOD_SRV,
                strPRO_DUV,
                now,
                fileRead.getBytesFromFile(pdfFile),
                fileRead.getBytesFromFile(xmlFile)
            );

        pdfFile.delete();
        xmlFile.delete();

        // Produzione del duvri effettuata con successo.
        returnMessage = ApplicationConfigurator.LanguageManager.getString("Duvri.generate.msg.1");
    } catch (Exception e) {
        returnMessage =
                ApplicationConfigurator.LanguageManager.getString("Error.msg.1")
                + "\\n"
                + (StringManager.isEmpty(e.getMessage())
                    ?
                    ApplicationConfigurator.LanguageManager.getString("Errore.non.determinabile").toUpperCase()
                    :
                    StringManager.prepareForJavaScript(e.getMessage()))
                + "\\n\\n"
                + ApplicationConfigurator.LanguageManager.getString("Duvri.generate.msg.2");
        e.printStackTrace();
        out.println("<script>err=true;</script>");        
    }
%>
<%!
    private void characters(TransformerHandler hd, Object field) throws Exception{
        field = field==null?"":field;
        hd.characters(((String)field).toCharArray(),0,(((String)field).length()));
    }
%>
<script type="text/javascript">
    alert("<%=returnMessage%>");
    if (err==false){
        parent.RefreshTab();
    }
</script>
