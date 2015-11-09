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
    response.setHeader("Cache-Control","no-cache");     //HTTP 1.1
    response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 		//prevents caching at the proxy server
%>
<%@ page import="java.text.*"%>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>

<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/ComboBuilder.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaDocumenti/TipologiaDocumentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TipologiaDocumenti/TipologiaDocumentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
    <script type="text/javascript">
    document.write("<title>" + getCompleteMenuPath(SubMenuDocumenti,2) + "</title>");
    </script>
    <!-- autocompose data field -->
    <script type="text/javascript" src="../_scripts/calendar/utility.js"></script>
    <!-- import the calendar script -->
    <script type="text/javascript" src="../_scripts/calendar/calendar.js"></script>
    <!-- import the language module -->
    <script type="text/javascript" src="../_scripts/calendar/lang.js"></script>
    <!-- import calendar utility function -->
    <script type="text/javascript" src="../_scripts/calendar/showCalendar.js"></script>
    <!-- style sheet for calendar -->
    <link rel="stylesheet" type="text/css" media="all" href="../_styles/calendar/skins/aqua/theme.css" title="Aqua" />
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script type="text/javascript" src="../_scripts/tabs.js"></script>
<script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    window.dialogWidth="1000px";
    window.dialogHeight="780px"; // Dimensioni del form sull'Edit
</script>

<body style="margin:0 0 0 0;" onload="">
<%
    long lCOD_DOC = 0;
    String strRSP_DOC = "";
    String strAPV_DOC = "";
    String strEMS_DOC = "";
    String strNUM_DOC = "";
    long lEDI_DOC = 0;
    String strREV_DOC = "";
    java.sql.Date dtDAT_REV_DOC = null;
    long lMES_REV_DOC = 0;
    java.sql.Date dtDAT_FUT_REV_DOC = null;
    String strDES_REV_DOC = "";
    String strPRG_RIF_DOC = "";
    String strPGN_RIF_DOC = "";
    String strTIT_DOC = "";
    long lCOD_CAG_DOC = 0;
    long lCOD_TPL_DOC = 0;
    long lCOD_LUO_FSC = 0;
    String strNOT_LUO_CON = "";
    long lPER_CON_YEA = 0;
    long lCOD_AZL = 0;
%>
<%
AnagDocumentoFileInfo info=null;
AnagDocumentoFileInfo infoLink=null;
IAnagrDocumentoHome home=null;
IAnagrDocumento bean=null;

String strID="";
if(request.getParameter("ID")!=null) {
    // getting parameters of azienda
    strID = (String)request.getParameter("ID");
    try {
        home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
        Long id=new Long(strID);
        bean = home.findByPrimaryKey(id);
        lCOD_DOC=bean.getCOD_DOC();
        strRSP_DOC=bean.getRSP_DOC();
        strAPV_DOC=bean.getAPV_DOC();
        strEMS_DOC=bean.getEMS_DOC();
        strNUM_DOC=bean.getNUM_DOC();
        lEDI_DOC=bean.getEDI_DOC();
        strREV_DOC=bean.getREV_DOC();
        dtDAT_REV_DOC=bean.getDAT_REV_DOC();
        lMES_REV_DOC=bean.getMES_REV_DOC();
        dtDAT_FUT_REV_DOC=bean.getDAT_FUT_REV_DOC();
        strDES_REV_DOC=bean.getDES_REV_DOC();
        strPRG_RIF_DOC=bean.getPRG_RIF_DOC();
        strPGN_RIF_DOC=bean.getPGN_RIF_DOC();
        strTIT_DOC=bean.getTIT_DOC();
        lCOD_CAG_DOC=bean.getCOD_CAG_DOC();
        lCOD_TPL_DOC=bean.getCOD_TPL_DOC();
        lCOD_LUO_FSC=bean.getCOD_LUO_FSC();
        strNOT_LUO_CON=bean.getNOT_LUO_CON();
        lPER_CON_YEA=bean.getPER_CON_YEA();
        lCOD_AZL=bean.getCOD_AZL();
        info=bean.getFileInfo();
        infoLink = bean.getFileInfoLink();
    } catch(Exception ex) {
%>
<script type="text/javascript">Alert.Error.showNotFound()</script>
<%
    }
}// if request
%>

<!--script--><!--%@ include file="ANA_DOC_Obj.jsp"%--><!--/script-->

    <form action="ANA_DOC_Set.jsp" method="POST"  target="ifrmWork" style="margin:0 0 0 0;" ENCTYPE="multipart/form-data">
        <table width="100%" border="0" cellpadding="0" cellspacing="5">
            <tr>
                <td>
    
                    <table width="100%" border="0" cellpadding="0" cellspacing="5" >
                        <tr>
                            <td class="title">
                                <script type="text/javascript">
                                    document.write(getCompleteMenuPathFunction(SubMenuDocumenti,2,<%=request.getParameter("ID")%>));
                                </script>      
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <!-- ########################################################################################################## -->
                                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <%ToolBar.bCanDelete=(bean!=null);%>
                                            <%ToolBar.strPrintUrl="SchedaDocumento.jsp?";%>
                                            <%=ToolBar.build(2)%>
                                        </td>
                                    </tr>
                                </table>
                                <!-- ########################################################################################################## -->
                            </td>
                        </tr>
                    </table>
        
                    <table width="100%" border="0" cellpadding="0" cellspacing="5">
                        <tr>
                            <td>
                            <fieldset>
                            <legend><%=ApplicationConfigurator.LanguageManager.getString("Anagrafica.documento")%></legend>
                                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                        <% if (bean!=null){%>
                                        <input name="SBM_MODE" type="Hidden" value="edt">
                                        <% } else { %>
                                        <input name="SBM_MODE" type="Hidden" value="new">
                                        <% } %>
                                            <input name="ID" type="hidden" value="<%=Formatter.format(lCOD_DOC)%>">
                                    <tr>
                                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Tipologia")%></td>
                                        <td width="40%" align="left">
                                            <%
                                            class ComboParser1 implements IComboParser{
                                                public void parse(Object obj, ComboItem item){
                                                    TipologiaDocumenti_ComboView w= (TipologiaDocumenti_ComboView)obj;
                                                    item.lIndex=w.lCOD_TPL_DOC;
                                                    item.strValue=w.strNOM_TPL_DOC;
                                                }
                                            }

                                            ITipologiaDocumentiHome h1=(ITipologiaDocumentiHome)PseudoContext.lookup("TipologiaDocumentiBean");
                                            ComboBuilder b1=new ComboBuilder( lCOD_TPL_DOC, new ComboParser1(), h1.getComboView());
                                            b1.strName="COD_TPL_DOC";
                                            b1.tabIndex=1;
                                            %>
                                            <%=b1.build()%>
                                        </td>
                                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%></b></td>
                                        <td width="40%" align="left" colspan="3">
                                            <%
                                            class ComboParser2 implements IComboParser{
                                                public void parse(Object obj, ComboItem item){
                                                    CategoriaDocumento_ComboView w= (CategoriaDocumento_ComboView)obj;
                                                    item.lIndex=w.lCOD_CAT_DOC;
                                                    item.strValue=w.strNOM_CAT_DOC;
                                                }
                                            }

                                            ICategoriaDocumentoHome h2=(ICategoriaDocumentoHome)PseudoContext.lookup("CategoriaDocumentoBean");
                                            ComboBuilder b2=new ComboBuilder( lCOD_CAG_DOC, new ComboParser2(), h2.getComboView());
                                            b2.strName="COD_CAG_DOC";
                                            b2.tabIndex=2;
                                            %>
                                            <%=b2.build()%>
                                        </td>	 
                                    </tr>
                                    
                                    <tr>
                                        <td width="10%" align="right" nowrap><b><%=ApplicationConfigurator.LanguageManager.getString("N.Documento")%></b></td>
                                        <td width="40%" align="left"><input tabindex="3" type="text" size="32" maxlength="100" name="NUM_DOC" value="<%=Formatter.format(strNUM_DOC)%>"></td>
                                            <% if(Security.isConsultant()) { %>
                                        <td width="10%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Globale")%></td>
                                        <td width="13%" align="left"><input tabindex="4" type="checkbox"  <%=lCOD_AZL==0 && bean!=null?"checked":""%> name="IS_GLOBAL" class="checkbox" value="1"></td>
                                            <% } %>
                                        <td width="20%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Edizione")%></b></td>
                                        <td width="7%" align="left"><input tabindex="5" type="text" size="15" maxlength="20" name="EDI_DOC" value="<%=bean==null?"":Formatter.format(lEDI_DOC)%>"></td>
                                    </tr>
            
                                    <tr>
                                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%></b></td>
                                        <td colspan="5" align="left" nowrap><input tabindex="6" type="text" size="116" maxlength="100"  name="TIT_DOC" value="<%=Formatter.format(strTIT_DOC)%>"></td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString(ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)?"Redattore":"Responsabile")%></b></td>
                                        <td colspan="5" align="left">
                                            <%
                                            class ComboParser3 implements IComboParser{
                                                public void parse(Object obj, ComboItem item){
                                                    Dipendenti_Names_View w= (Dipendenti_Names_View)obj;
                                                    item.strValue = w.MTR_DPD + " " + w.COG_DPD + " " + w.NOM_DPD;
                                                }
                                            }

                                            IDipendenteHome h3=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
                                            Collection col_dep=h3.getDipendenti_Names_View(Security.getAzienda());
                                            ComboParser3 parser_dep=new ComboParser3();
                                            ComboBuilder b3=new ComboBuilder( strRSP_DOC, parser_dep, col_dep);
                                            b3.strName="RSP_DOC";
                                            b3.tabIndex=7;
                                            %>
                                            <%=b3.build()%>
                                        </td>
                                    </tr>
            
                                    <tr>
                                        <td width="10%" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.approvazione")%></b></td>
                                        <td width="40%" align="left">
                                            <%
                                            ComboBuilder b5=new ComboBuilder( strAPV_DOC, parser_dep, col_dep);
                                            b5.strName="APV_DOC";
                                            b5.tabIndex=9;
                                            %>
                                            <%=b5.build()%>
                                        </td>
                                        <td width="10%" align="right" NOWRAP><b><%=ApplicationConfigurator.LanguageManager.getString("Responsabile.emissione")%></b></td>
                                        <td width="40%" align="left" colspan="3">
                                            <%
                                            ComboBuilder b4=new ComboBuilder( strEMS_DOC, parser_dep, col_dep);
                                            b4.strName="EMS_DOC";
                                            b4.tabIndex=8;
                                            %>
                                            <%=b4.build()%>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </table>
        
                        <table width="100%" border="0" cellspacing="5" cellpadding="0">    
                            <tr>
                                <td width="100%">
                                    <fieldset>
                                    <legend><%=ApplicationConfigurator.LanguageManager.getString("Dati.revisione")%></legend>		
                                        <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                            <tr>
                                                <td align="right" width="10.5%"><%=ApplicationConfigurator.LanguageManager.getString("Pag.rif")%></td>
                                                <td align="left" width="8%"><input tabindex="10" type="text" size="10" maxlength="20"  name="PGN_RIF_DOC" value="<%=Formatter.format(strPGN_RIF_DOC)%>"></td>
                                                <td align="right" width="10.5%"><b><%=ApplicationConfigurator.LanguageManager.getString("Data")%></b></td>
                                                <td align="left" width="10.5%"><s2s:Date tabindex="11" id="DAT_REV_DOC" name="DAT_REV_DOC" value='<%=bean==null?"":Formatter.format(dtDAT_REV_DOC)%>'/>
                                                <td align="right" width="10.5%"><b><%=ApplicationConfigurator.LanguageManager.getString("Mese")%></b></td>
                                                <td align="left" width="10.5%"><input tabindex="12" type="text" size="4" maxlength="2" name="MES_REV_DOC" value="<%=bean==null?"":Formatter.format(lMES_REV_DOC)%>"></td>
                                                <td align="right" width="10.5%"><%=ApplicationConfigurator.LanguageManager.getString("Data.futura")%></td>
                                                <td align="left" width="10.5%"><s2s:Date tabindex="13" id="DAT_FUT_REV_DOC" name="DAT_FUT_REV_DOC" value="<%=Formatter.format(dtDAT_FUT_REV_DOC)%>"/></td>
                                                <td align="right" width="10.5%"><b><%=ApplicationConfigurator.LanguageManager.getString("Revisione")%></b></td>
                                                <td align="left" width="8%"><input tabindex="15" type="text" size="10" maxlength="10"  name="REV_DOC" value="<%=Formatter.format(strREV_DOC)%>"></td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="right" width="10.5%"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                                <td align="left" width="89.5%" colspan="9"><TEXTAREA tabindex="14" cols="70" rows="2"  name="DES_REV_DOC"><%=Formatter.format(strDES_REV_DOC)%></TEXTAREA></td>
                                            </tr>
                                            
                                            <tr>
                                                <td align="right" width="10.5%"><%=ApplicationConfigurator.LanguageManager.getString("Paragrafo.di.riferimento")%></td>
                                                <td align="left" width="89.5%" colspan="9"><TEXTAREA tabindex="16" cols="70" rows="2" name="PRG_RIF_DOC"><%=Formatter.format(strPRG_RIF_DOC)%></TEXTAREA></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </table>
                
                                <table border="0" width="100%" cellspacing="5" cellpadding="0"><!-- tabella esterna-->
                                    <tr>
                                            <% 
                                                if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)){
                                                    out.println("<td align=\"left\" width=\"50%\">");
                                                } else {
                                                    out.println("<td align=\"left\" width=\"50%\">");
                                                }
                                            %>
                
                                            <fieldset>
                                            <legend><%=ApplicationConfigurator.LanguageManager.getString("File")%></legend>		

                                                <div style="overflow:hidden;">
                                                <table width=100% border="0" cellspacing="5" cellpadding="0">
                                                    <%
                                                        if (info!=null){
                                                            NumberFormat nf = NumberFormat.getInstance();
                                                            nf.setMinimumFractionDigits(2);
                                                            nf.setMaximumFractionDigits(3);
                                                    %>	
                                                    <tr>
                                                        <td align="center" width="15%"><input tabindex="17" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%></td>
                                                        <td align="center" width="40%"><a href="ANA_DOC_File.jsp?ID=<%=lCOD_DOC%>&TYPE=FILE"><%=info.strName%></a></td>
                                                        <td align="left" width="30%"><%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float)info.lSize/1024))%></td>
                                                        <td align="left" width="15%"><%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(info.dtModified)%></td>
                                                    </tr>
                                                    <% } else { %>
                                                    <tr>		
                                                        <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE" type="file" style="width:100%"></td>
                                                    </tr>
                                                    <% } %>
                                                </table>
                                                </div>
                                            </fieldset>
                                        </td>
                                        
                                        <% 
                                            if (ApplicationConfigurator.isModuleEnabled(MODULES.DOC_LINK)){
                                                out.println("<td width=\"50%\">");
                                            } else {
                                                out.println("<td width=\"50%\" style=\"display:none\">");
                                            }
                                        %>
                                        <!-- Inizio modifica gestione link esterno documenti-->
                                            <fieldset>
                                                <legend><%=ApplicationConfigurator.LanguageManager.getString("File.link")%></legend>		
                                                    <div style="overflow:hidden;">
                                                    <table width="100%" border="0" cellspacing="5" cellpadding="0">
                                                        <%
                                                            if (infoLink != null) {
                                                                NumberFormat nf = NumberFormat.getInstance();
                                                                nf.setMinimumFractionDigits(2);
                                                                nf.setMaximumFractionDigits(3);
                                                        %>
                                                        <tr>
                                                            <td align="center" width="15%">
                                                                <input tabindex="17" type="checkbox" class="checkbox" name="ATTACHMENT_ACTION_LINK" value="delete"><%=ApplicationConfigurator.LanguageManager.getString("Delete")%>
                                                            </td>
                                                            <td align="center" width="40%">
                                                                <!--a href="ANA_DOC_File.jsp?ID=<%=lCOD_DOC%>&TYPE=FILE_LINK"><%=infoLink.strName%></a-->
                                                                <a href="file:///<%=infoLink.strLinkDocument%>" target="_blank"><%=infoLink.strName%></a>
                                                            </td>
                                                            <td align="left" width="30%">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Dimensione.(KB)")%>:&nbsp;&nbsp;<%=Formatter.format(nf.format((float)infoLink.lSize/1024))%>
                                                            </td>
                                                            <td align="left" width="15%">
                                                                <%=ApplicationConfigurator.LanguageManager.getString("Ultima.modifica")%>:&nbsp;&nbsp;<%=Formatter.format(infoLink.dtModified)%>
                                                            </td>
                                                        </tr>
                                                        <% } else { %>
                                                        <tr>		
                                                            <td width="100%"><input tabindex="18" name="ATTACHMENT_FILE_LINK" type="file" style="width:100%" ></td>
                                                        </tr>
                                                        <% } %>
                                                    </table>
                                                    </div>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    <!-- Fine modifica gestione link esterno documenti-->

                                        <tr>
                                            <td colspan="2">
                                                <table width="100%" border="0" id="XXX2" cellspacing="5" cellpadding="0">
                                                    <tr>
                                                        <td align="right" width="9.7%" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%></td>
                                                        <td align="left" width="35%">
                                                            <%			
                                                            class ComboLuogo implements IComboParser{
                                                                public void parse(Object obj, ComboItem item){
                                                                    AnagrLuoghiFisici_List_View w= (AnagrLuoghiFisici_List_View)obj;
                                                                    item.lIndex=w.COD_LUO_FSC;
                                                                    item.strValue=w.NOM_LUO_FSC;
                                                                }
                                                            }

                                                            IAnagrLuoghiFisiciHome hlf=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
                                                            ComboBuilder blf=new ComboBuilder( lCOD_LUO_FSC, new ComboLuogo(), hlf.getAnagrLuoghiFisici_List_View(Security.getAzienda()));
                                                            blf.strName="COD_LUO_FSC";
                                                            blf.tabIndex=19;
                                                            %>
                                                            <%=blf.build()%>					
                                                        </td>
                                                        <td align="right" width=12%" nowrap><%=ApplicationConfigurator.LanguageManager.getString("Periodicità.annuale")%></td>
                                                        <td align="left" width="43.5%"><input tabindex="20" type="text" size="11" maxlength="19" name="PER_CON_YEA" value="<%=bean==null?"":Formatter.format(lPER_CON_YEA)%>"></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="9.7%" align="right" valign="top"><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></td>
                                                        <td width="90.3%" align="left" colspan="3"><TEXTAREA tabindex="21" cols="140" rows="4" name="NOT_LUO_CON"><%=Formatter.format(strNOT_LUO_CON)%></TEXTAREA></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                        <table>
                            <tr>
                                <td><div id="dContainer" class="mainTabContainer" style="width:100%"></div></td>
                            </tr>
                        </table> 

</form>
<form action="ANA_DOC_File.jsp" name="frmFile">
    <input type="hidden" name="ID" value="<%=lCOD_DOC%>">
</form>

<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>

<%
//-------Loading of Tabs--------------------
if(bean!=null){                              
// -----------------------------------------
%>
<script type="text/javascript" src="../_scripts/index.js"></script>
<script type="text/javascript">

    btnParams = new Array();

	btnParams[0] = {"id":"btnNew", 
					"onclick":addRow,
					"action":"AddNew"
					};

	btnParams[1] = {"id":"btnEdit", 
					"onclick":editRow,
					"action":"Edit"
					};		
	btnParams[2] = {"id":"btnCancel", 
					"onclick":delRow,
					"action":"Delete"
					};		
					
        //--------creating tabs--------------------------
	var tabbar = new TabBar("tbr1",document.all["dContainer"]);
	var btnBar = new ButtonPanel("batPanel1", btnParams);
	tabbar.addButtonBar(btnBar);
	tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Destinatari.documenti")%>", tabbar));
	tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici.di.conservazione")%>", tabbar));

	//------adding tables to tabs-----------------------
	tabbar.idParentRecord = <%= lCOD_DOC %>;
	tabbar.tabs[0].tabObj.refreshTabUrl="ANA_DOC_Tabs.jsp";	
	tabbar.tabs[0].tabObj.Refresh();
	
	tabbar.tabs[1].tabObj.addTable( document.all["XXX2"],document.all["XXX2"], false);
		
	//----add action parameters to tabs
	tabbar.tabs[0].tabObj.actionParams ={
										"Feachures":LST_DSI_DOC_Feachures,
													
										"AddNew":	{"url":"../Form_LST_DSI_DOC/LST_DSI_DOC_Form.jsp", 
													"buttonIndex":0,
													"disabled": false
												  	},
										"Edit":         {"url":"../Form_LST_DSI_DOC/LST_DSI_DOC_Form.jsp", 
													"buttonIndex":1,
													"disabled": false
										 			},
										"Delete":	{"url":"../Form_ANA_DOC/ANA_DOC_Delete.jsp?LOCAL_MODE=c",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": false	
										 			}
										}; 
	//-------------------------------------------------
	tabbar.tabs[1].tabObj.actionParams ={	
                                                                                "Feachures":LST_DSI_DOC_Feachures,
										"AddNew":	{"url":"", 
													"buttonIndex":0,
													"disabled": true
												  	},
										"Edit":         {   "url":"",
													"buttonIndex":1,
													"disabled": true
										 			},
										"Delete":	{"url":"../Form_ANA_RSO/ANA_RSO_Delete.jsp?LOCAL_MODE=n",
													"target_element":document.all["ifrmWork"],
													"buttonIndex":2,
													"disabled": true	
										 			}	
										}; 						
</script>
<% } else { %>
<script type="text/javascript">
    window.dialogHeight="660px"; // Dimensione del form con riferimento al New
</script>
<% } %>
</body>
</html>
