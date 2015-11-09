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
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DittaEsterna.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.GiorniLavorati.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AziendaTelefono.*" %>
<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Localization.jsp"%>
<%@ include file="ANA_AZL_Util.jsp" %>
<%@ include file="../_include/ComboBox-Dipendente.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_menu/menu/menuStructure.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>

<html>
<head>
    <script type="text/javascript">
        document.write("<title>" + getCompleteMenuPath(SubMenuAzienda,0) + "</title>");
    </script>
</head>
<link rel="stylesheet" href="../_styles/style.css">
<link rel="stylesheet" href="../_styles/tabs.css">
<script type="text/javascript" src="../_scripts/tabs.js"></script>
<script type="text/javascript" src="../_scripts/tabbarButtonFunctions.js"></script>
<script type="text/javascript" src="../_scripts/textarea.js"></script>
<script type="text/javascript">
    window.dialogWidth="900px";
    window.dialogHeight="685px";
</script>
<script type="text/javascript">
    function ApriLegenda(){
        window.showModalDialog
        ("../Form_ANA_RSO/LegendaCalcoloRischio.jsp", 0, "dialogWidth:570px;dialogHeight:180px;status:no;help:no;scroll:no;");                    
    }
</script>
<body  style="margin:0 0 0 0;">
<%
            String strCOD_AZL = "";		//ID of Azienda
            String strRAG_SCL_AZL = "";     	//1  name
            String strDES_ATI_SVO_AZL = ""; 	//2  description
            String strIDZ_AZL = "";         	//3  address
            String strCIT_AZL = "";         	//4  city
            String strCOD_STA = "";           //5  nation
            String sMOD_CLC_RSO = Short.toString(Azienda_MOD_CLC_RSO.MOD_BASE); //19 Modalità di calcolo del rischio
//----------------------------
            String strCAG_AZL = "";            //7  category
            String strCOD_IST_TAT_AZL = "";    //8
            String strNUM_CIC_AZL = "";        //9
            String strPRV_AZL = "";            //10 province
            String strCAP_AZL = "";            //11 cap code
            String strQLF_RSP_AZL = "";        //12
            String strNOM_RSP_AZL = "";        //13 dattore di lavoro
            String strNOM_RSP_SPP_AZL = "";    //14 responsible
            String strNOM_MED_AZL = "";        //15 medico responde
            String strCOD_AZL_ASC = "";        //16 associated azienda
            String strIDZ_PSA_ELT_RSP_AZL = "";//17 e mail
            String strSIT_INT_AZL = "";        //18 internet address
            String strCOD_FIS_AZL ="";         // ?
            String strPAR_IVA_AZL ="";         // ?
            IAziendaHome home = null;
            IAzienda azienda = null;

//stub for debuging
//strCOD_AZL="1042315978732";
            if (request.getParameter("ID") != null) {
// getting parameters of azienda
                strCOD_AZL = (String) request.getParameter("ID");
                //getting of azienda object
                home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                Long azl_id = new Long(strCOD_AZL);
                azienda = home.findByPrimaryKey(azl_id);
                // getting of object variables
                strRAG_SCL_AZL = Formatter.format(azienda.getRAG_SCL_AZL());
                strDES_ATI_SVO_AZL = Formatter.format(azienda.getDES_ATI_SVO_AZL());
                strIDZ_AZL = Formatter.format(azienda.getIDZ_AZL());
                strCIT_AZL = Formatter.format(azienda.getCIT_AZL());
                strCOD_STA = Formatter.format(azienda.getCOD_STA());
                sMOD_CLC_RSO = Formatter.format(azienda.getMOD_CLC_RSO());
                // ---
                strCAG_AZL = Formatter.format(azienda.getCAG_AZL());
                strCOD_IST_TAT_AZL = Formatter.format(azienda.getCOD_IST_TAT_AZL());
                strNUM_CIC_AZL = Formatter.format(azienda.getNUM_CIC_AZL());
                strPRV_AZL = Formatter.format(azienda.getPRV_AZL());
                strCAP_AZL = Formatter.format(azienda.getCAP_AZL());
                strQLF_RSP_AZL = Formatter.format(azienda.getQLF_RSP_AZL());
                strNOM_RSP_AZL = Formatter.format(azienda.getNOM_RSP_AZL());
                strNOM_RSP_SPP_AZL = Formatter.format(azienda.getNOM_RSP_SPP_AZL());
                strNOM_MED_AZL = Formatter.format(azienda.getNOM_MED_AZL());
                strCOD_AZL_ASC = Formatter.format(azienda.getCOD_AZL_ASC());
                strIDZ_PSA_ELT_RSP_AZL = Formatter.format(azienda.getIDZ_PSA_ELT_RSP_AZL());
                strSIT_INT_AZL = Formatter.format(azienda.getSIT_INT_AZL());
                strCOD_FIS_AZL = Formatter.format(azienda.getCOD_FIS_AZL());
                strPAR_IVA_AZL = Formatter.format(azienda.getPAR_IVA_AZL());
                if (Security.isMultimodeConsultant()) {
                    Security.setCurrentAzienda(azl_id.longValue());
                    Security.setAziendaName(strRAG_SCL_AZL);
                }

            }// if request
            java.util.ArrayList WHE_IN_AZL = Security.getAziende();
%>
<br>
<form action="ANA_AZL_Set.jsp" method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<table width='100%' cellpadding="0" cellspacing="5" border="0">
<!-- ############################################################################################### -->
                 <!--%@ include file="../_include/ToolBar.jsp" %-->
                 <!--%ToolBar.strPrintUrl="SchedaAziendale.jsp?";%-->
                 <!--% if(Security.isUser()){
                         ToolBar.bCanNew=false;
                         ToolBar.bCanDelete=false;
                    }
                 %-->
                 <!--%=ToolBar.build(2)%>    -->
<!-- ################################################################################################ -->
<tr><td>


<table border="0" cellpadding="0" cellspacing="0"  width='100%'>
<tr>
    <td align="center" class="title">
        <script type="text/javascript">
            document.write(getCompleteMenuPathFunction
                (SubMenuAzienda,0,<%=request.getParameter("ID")%>));
        </script>
    </td>
</tr>
<tr>
<td>
<table width="100%" border="0">
    <!-- ########################################### IMMAGINI #################################################### -->
            <%@ include file="../_include/ToolBar.jsp" %> <%ToolBar.strPrintUrl = "SchedaAziendale.jsp?";%> <% if (Security.isUser()) {
                ToolBar.bCanNew = false;
                ToolBar.bCanDelete = false;
            }%> <%=ToolBar.build(2)%>
    <!-- ################################################################################################ -->
</table>
<fieldset>
<legend><%=ApplicationConfigurator.LanguageManager.getString("Azienda")%></legend>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td colspan="10" align="left">
        <table width="100%" border="0">
            <tr>
                <td>
                    
                </td>
            </tr>
    </table></td>
</tr>
<tr>
    <td width="143" align="left"> <input name="SBM_MODE" type="Hidden" value="<%if (!strCOD_AZL.equals("")) {
                out.print("edt");
            } else {
                out.print("new");
            }%>"></td>
</tr>
<tr>
    <td align="left"> <input name="AZL_ID" type="Hidden" value="<%if (!strCOD_AZL.equals("")) {
                out.print(strCOD_AZL);
            }%>"></td>
</tr>
<!-- Azienda/Ente Categoria -->
<tr>
    <td width="10%" align="right"><strong> &nbsp;&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Azienda/Ente")%>&nbsp;</strong></td>
    <td align="left" width="40%" colspan="2">
    <input tabindex="1" style="width:100%;" type="text" name="AZIENDA" maxlength="50" value="<%=strRAG_SCL_AZL%>"></td>
    <td width="18%" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Categoria")%>&nbsp;</td>
    <td width="40%" colspan="6">
        <input tabindex="2" size="25" type="text" name="CATEGORIA" maxlength="30" value="<%=strCAG_AZL%>">
    </td>
</tr>
<!-- Indirizzo N.Civico -->
<tr>
    <td height="21" align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Indirizzo")%>&nbsp;</strong></td>
    <td colspan="2">
    <input tabindex="3" style="width:100%;" type="text" name="INDIRIZZO" maxlength="50" value="<%=strIDZ_AZL%>"></td>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Numero.civico")%>&nbsp;</td>
    <td colspan="3"><input tabindex="4"  size="25" type="text" name="NCIVOCO" maxlength="30" value="<%=strNUM_CIC_AZL%>">
    </td>
</tr>
<!-- Citta Provincia CAP -->
<tr>
    <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Città")%>&nbsp</strong></td>
    <td colspan="2">
    <input tabindex="5" style="width:100%;" type="text" name="CITTA" maxlength="30" value="<%=strCIT_AZL%>"></td>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Provincia")%>&nbsp;</td>
    <td width="80"> <input tabindex="6" size="2" type="text" name="PROVINCIA" maxlength="2" value="<%=strPRV_AZL%>">
    </td>
    <td width="40" align="right"><%=ApplicationConfigurator.LanguageManager.getString("C.a.p.")%>&nbsp;</td>
    <td width="152" align="left"> <input tabindex="7" style="width:80%;" size="14" type="text" name="CAP" maxlength="15" value="<%=strCAP_AZL%>">
    </td>
</tr>
<!-- Nazionalita -->
<tr>
    <td align="right"><strong><%=ApplicationConfigurator.LanguageManager.getString("Nazionalità")%>&nbsp;</strong></td>
    <td colspan="2">
        <select  tabindex="8" style="width:100%;" name="NAZIONALITA">
            <option value=''></option>
            <%
            INazionalitaHome nz_home = (INazionalitaHome) PseudoContext.lookup("NazionalitaBean");
            if (strCOD_STA.equals("")) {
                strCOD_STA = "0";
            }
            long COD_LNG = Localization.getCurrentLanguageCode();
            String nz_cb = BuildNazionalitaComboBox(nz_home, new Long(strCOD_STA).longValue(), COD_LNG);
            out.print(nz_cb);
            %>
    </select> </td>
</tr>
<!-- Attivita Svolta -->
<tr>
    <td align="right" valign="top"><strong><%=ApplicationConfigurator.LanguageManager.getString("Attività.svolta")%>&nbsp;</strong></td>
    <td colspan="9">
        <s2s:textarea tabindex="9" style="width:96.5%;" name="ATTIVITA_SVOLTA" rows="3" cols="118" maxlength="3500"><%=strDES_ATI_SVO_AZL%></s2s:textarea>
    </td>
</tr>
<!-- Datore di lavoro Qualifica D.d.l. -->
<tr>
<td align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro")%>&nbsp;</td>
<td colspan="2">
<SELECT tabindex="10" name="DATORE" style="width:100%;" <%if (azienda == null) {
                out.print(" disabled ");
            }%> >
        <option value=''></option>
    <%
            if (azienda != null) {
                IDipendenteHome dp_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                out.print(BuildDipendenteComboBox(dp_home, strNOM_RSP_AZL, new Long(strCOD_AZL).longValue()));
            }
    %>
</SELECT> </td>
<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro")%>&nbsp;</td>
<td colspan="6">
    <input tabindex="11" style="width:90%;" type="text" name="QUALIFICA" maxlength="50" value="<%=strQLF_RSP_AZL%>">
</td>


</tr>
<!-- Responsable SPP Medico Competente -->
<tr>
<td  align="right">&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P.")%>&nbsp;</td>
<td colspan="2">
<SELECT tabindex="12" name="RESPONSABLE" style="width:100%;" <%if (azienda == null) {
                out.print(" disabled ");
            }%> >
        <option value=''></option>
    <%
            if (azienda != null) {
                IDipendenteHome dps_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                out.print(BuildDipendenteComboBox(dps_home, strNOM_RSP_SPP_AZL, new Long(strCOD_AZL).longValue()));
            }
    %>
</SELECT> </td>
<td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Medico.competente")%>&nbsp;</td>
<td colspan="6">
    <input tabindex="13" style="width:90%;"  type="text" name="MEDICO" maxlength="50" value="<%=strNOM_MED_AZL%>">
</td>
</tr>
<!-- EMail  Sito Internet -->
<tr>
    <td  align="right"><%=ApplicationConfigurator.LanguageManager.getString("E-mail")%>&nbsp;</td>
    <td colspan="2">
    <input tabindex="14" style="width:100%;" type="text" name="EMAIL" maxlength="50" value="<%=strIDZ_PSA_ELT_RSP_AZL%>"></td>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Sito.internet")%>&nbsp;</td>
    <td colspan="6">
        <input tabindex="15" style="width:90%;" type="text" name="SITOINTERNET" id="SITOINTERNET" maxlength="50" value="<%=strSIT_INT_AZL%>">
        <!--<input type="Button" value="...">-->
    </td>
</tr>
<!-- Azienda Associata  Cod ISAT -->
<tr>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Azienda.associata")%>&nbsp;</td>
    <td colspan="2">
        <SELECT tabindex="16" name="AZIENDA_ASC" style="width:100%;">
            <option value=''></option>
            <%
            String cb = "";
            if (home != null) {
                cb = BuildAziendasComboBox(home, new Long(strCOD_AZL).longValue(), new Long(strCOD_AZL_ASC).longValue());
                out.print(cb);
            } else {
                home = (IAziendaHome) PseudoContext.lookup("AziendaBean");
                cb = BuildAziendasComboBoxNew(home, WHE_IN_AZL);
                out.print(cb);
            }
            %>
    </SELECT> </td>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Codice.ISTAT")%>&nbsp;</td>
    <td colspan="6">
    <input tabindex="17" size="15" type="text" name="COD_ISAT" maxlength="15" value="<%=strCOD_IST_TAT_AZL%>"></td>
</tr>
<!--
<tr>
    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Codice.fiscale")%>&nbsp;</td>
    <td colspan="2">
    <input tabindex="18" size="30" type="text" name="COD_FIS_AZL" maxlength="16" value="<%=strCOD_FIS_AZL%>"></td>

    <td align="right"><%=ApplicationConfigurator.LanguageManager.getString("Partita.iva")%>&nbsp;</td>
    <td colspan="6">
    <input tabindex="19" size="30" type="text" name="PAR_IVA_AZL" maxlength="11" value="<%=strPAR_IVA_AZL%>"></td>
</tr>
<tr>
-->
<td align="right" colspan="1" nowrap><b>&nbsp;&nbsp;<%=ApplicationConfigurator.LanguageManager.getString("Modalità.di.calcolo.del.rischio")%>&nbsp;</b></td>
<td colspan="1">
    <input type="radio" tabindex="20" align="left" name="MOD_CLC_RSO" value=<%=Short.toString(Azienda_MOD_CLC_RSO.MOD_BASE)%>
           <% if (sMOD_CLC_RSO.equals(Short.toString(Azienda_MOD_CLC_RSO.MOD_BASE))) {
                out.print(" checked");
            }%>>
           &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("E.D.*P.E.L.")%>
           <br>
    <input type="radio" tabindex="21" align="left" name="MOD_CLC_RSO" value=<%=Short.toString(Azienda_MOD_CLC_RSO.MOD_EXTENDED)%>
           <% if (sMOD_CLC_RSO.equals(Short.toString(Azienda_MOD_CLC_RSO.MOD_EXTENDED))) {
                out.print(" checked");
            }%>>
           &nbsp;<%=ApplicationConfigurator.LanguageManager.getString("E.D.*F.A.R.*P.E.L.*F.M.")%>&nbsp;&nbsp;&nbsp;&nbsp;
           <A HREF="#" ONCLICK="ApriLegenda();"><%=ApplicationConfigurator.LanguageManager.getString("Legenda")%></A>
</td>
<td colspan="6">
    &nbsp;
</td>
</tr>
<tr>
    <td colspan="8">
        &nbsp;
    </td>    
</tr>
</table>
</fieldset></td></tr>
<tr>
    <td><div id="dContainer" class="mainTabContainer" style=""></div></td>
</tr>
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
<%
//-------Loading of Tabs--------------------
            if (azienda != null) {

                IAziendaTelefonoHome tel_home = (IAziendaTelefonoHome) PseudoContext.lookup("AziendaTelefonoBean");
                out.print(BuildTelephoneTab(tel_home, strCOD_AZL));
                IDittaEsternaHome de_home = (IDittaEsternaHome) PseudoContext.lookup("DittaEsternaBean");
                out.print(BuildDitteEsterneTab(de_home, strCOD_AZL));
                IConsultantHome ct_home = (IConsultantHome) PseudoContext.lookup("ConsultantBean");
                out.print(BuildConsultantTab(ct_home, strCOD_AZL));
                ISitaAziendeHome sa_home = (ISitaAziendeHome) PseudoContext.lookup("SitaAziendeBean");
                out.print(BuildSitaAziendeTab(sa_home, strCOD_AZL));
                IDipendenteHome dp_home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                out.print(BuildDipendentiTab(dp_home, strCOD_AZL));
                IGiorniLavoratiHome gl_home = (IGiorniLavoratiHome) PseudoContext.lookup("GiorniLavoratiBean");
                out.print(BuildGiorniLavoratiTab(gl_home, strCOD_AZL));

// -----------------------------------------
%>
<script type="text/javascript">
    function NumTelDialogParams(){
        obj = new DialogParameters();
        obj.TPL_NUM_TEL = null;
        obj.NUM_TEL = null;
        obj.COD_AZL = null;
        obj.toRow = function (row){
            if(this.TPL_NUM_TEL==null) return;
            row.id = this.ID;
            row.INDEX = this.COD_AZL;
            colInput=row.getElementsByTagName("INPUT");
            colInput[0].value=this.TPL_NUM_TEL;
            colInput[1].value=this.NUM_TEL;
            return row;
        }
        return obj;
    }
    //--------BUTTONS description-----------------------
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
    /* btnParams[3] = {"id":"btnHelp", 
    "onmousedown":btnDown, 	
    "onmouseup":btnOver,
    "onmouseover":btnOver,
    "onmouseout":btnOut,
    "onclick":windowHelp,
    "src":"../_images/HELP.GIF",
    "action":"Help"
    };	 */
    //--------creating tabs--------------------------
    var	tabbar = new TabBar("tbr1",document.all["dContainer"]);
    var btnBar = new ButtonPanel("batPanel1", btnParams);
    
    tabbar.addButtonBar(btnBar);
    tabbar.addTab(new Tab("tab1", "<%=ApplicationConfigurator.LanguageManager.getString("Numeri.telefonici")%>", tabbar));
    tabbar.addTab(new Tab("tab2", "<%=ApplicationConfigurator.LanguageManager.getString("Fornitori.personale/servizi")%>", tabbar));
    tabbar.addTab(new Tab("tab3", "<%=ApplicationConfigurator.LanguageManager.getString("Consulenti")%>", tabbar));
    tabbar.addTab(new Tab("tab4", "<%=ApplicationConfigurator.LanguageManager.getString("Sedi")%>", tabbar));
    tabbar.addTab(new Tab("tab5", "<%=ApplicationConfigurator.LanguageManager.getString("R.L.S.")%>", tabbar));
    tabbar.addTab(new Tab("tab6", "<%=ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati")%>", tabbar));
    //------adding tables to tabs-----------------------
    tabbar.tabs[0].tabObj.addTable( document.all["TelefonoAziendaHeader"],document.all["TelefonoAzienda"], true);
    tabbar.tabs[1].tabObj.addTable( document.all["DitteEsterneHeader"],document.all["DitteEsterne"], true);
    tabbar.tabs[2].tabObj.addTable( document.all["ConsultantiHeader"],document.all["Consultanti"], true);
    tabbar.tabs[3].tabObj.addTable( document.all["SiteAziendeHeader"],document.all["SiteAziende"], true);
    tabbar.tabs[4].tabObj.addTable( document.all["DipendentiHeader"],document.all["Dipendenti"], true);
    tabbar.tabs[5].tabObj.addTable( document.all["GiorniLavoratiHeader"],document.all["GiorniLavorati"], true);
    //----add action parameters to tabs
    tabbar.idParentRecord = <%=Formatter.format(strCOD_AZL)%>;
    tabbar.refreshTabUrl="ANA_AZL_RefreshTabs.jsp";
    //tabbar.DEBUG_TABS_IFRM = true;
    //-------------------------------------------------------------------------------------------
    tabbar.tabs[0].tabObj.actionParams ={"Feachures":NUM_TEL_FOR_Feachures,
        "AddNew":	{"url":"../Form_NUM_TEL/NUM_TEL_Form.jsp",
            "buttonIndex":0,
            "disabled": false
        },
        "Edit":	{"url":"../Form_NUM_TEL/NUM_TEL_Form.jsp",
            "buttonIndex":1,
            "disabled": false
        },
        "Delete":	{"url":"../Form_NUM_TEL/NUM_TEL_Delete.jsp",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": false
        },
        "Help":	{"url":"../Form_NUM_TEL/NUM_TEL_Help.jsp",
            "buttonIndex":3,
            "disabled": false	
        }	
    };
    //-------------------------------------------------------------------------------------------
    tabbar.tabs[1].tabObj.actionParams ={"Feachures":ANA_DTE_Feachures,
        "AddNew":	{"url":"../Form_ANA_DTE/ANA_DTE_Form.jsp?ATTACH_URL=Form_ANA_AZL/ANA_AZL_Attach.jsp&ATTACH_SUBJECT=DITTA",
            "buttonIndex":0,
            "disabled": false
        },
        "Edit":	{"url":"../Form_ANA_DTE/ANA_DTE_Form.jsp?ATTACH_URL=Form_ANA_AZL/ANA_AZL_Attach.jsp&ATTACH_SUBJECT=DITTA",
            "buttonIndex":1,
            "disabled": false
        },
        "Delete":	{"url":"ANA_AZL_AttachDel.jsp?ATTACH_SUBJECT=DITTA",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": false
        },
        "Help":	{"url":"../Form_ANA_DTE/ANA_DTE_Help.jsp",
            "buttonIndex":3,
            "disabled": false	
        }	
    };
    //-------------------------------------------------------------------------------------------
    tabbar.tabs[2].tabObj.actionParams ={"Feachures":NUM_TEL_FOR_Feachures,
        "AddNew":	{"url":"",
            "whidth":"350px",
            "height":"175px",
            "addDialogParameters":new NumTelDialogParams(),
            "alert": null,
            "buttonIndex":0,
            "disabled": true
        },
        "Edit":	{"url":"",
            "whidth":"350px",
            "height":"175px",
            "editDialogParameters":new NumTelDialogParams(),
            "alert": null,
            "buttonIndex":1,
            "disabled": true
        },
        "Delete":	{"url":"",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": true
        },
        "Help":	{"url":"../Form_ANA_COU/ANA_COU_Help.jsp",
            "buttonIndex":3,
            "disabled": false	
        }
    };
    //-------------------------------------------------------------------------------------------
    tabbar.tabs[3].tabObj.actionParams ={"Feachures":ANA_SIT_AZL_Feachures,
        "AddNew":	{"url":"../Form_ANA_SIT_AZL/ANA_SIT_AZL_Form.jsp?ATTACH_URL=Form_ANA_AZL/ANA_AZL_Attach.jsp&ATTACH_SUBJECT=SITA",
            "buttonIndex":0,
            "disabled": false
        },
        "Edit":	{"url":"../Form_ANA_SIT_AZL/ANA_SIT_AZL_Form.jsp?ATTACH_URL=Form_ANA_AZL/ANA_AZL_Attach.jsp&ATTACH_SUBJECT=SITA",
            "buttonIndex":1,
            "disabled": false
        },
        "Delete":	{"url":"ANA_AZL_AttachDel.jsp?ATTACH_SUBJECT=SITA",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": false
        },
        "Help":	{"url":"../Form_ANA_SIT_AZL/ANA_SIT_AZL_Help.jsp",
            "buttonIndex":3,
            "disabled": false	
        }	 
    };
    //-------------------------------------------------------------------------------------------
    tabbar.tabs[4].tabObj.actionParams ={"AddNew":	{"url":"",
        "whidth":"350px",
        "height":"175px",
        "addDialogParameters":new NumTelDialogParams(),
        "alert": null,
        "buttonIndex":0,
        "disabled": true
    },
    "Edit":	{"url":"",
        "whidth":"350px",
        "height":"175px",
        "editDialogParameters":new NumTelDialogParams(),
        "alert": null,
        "buttonIndex":1,
        "disabled": true
    },
    "Delete":	{"url":"",
        "target_element":document.all["ifrmWork"],
        "buttonIndex":2,
        "disabled": true
    },
    "Help":	{"url":"../Form_ANA_AZL/RLS_Help.jsp",
        "buttonIndex":3,
        "disabled": false	
    }	
};
tabbar.tabs[5].tabObj.actionParams ={"Feachures":GRN_LAV_Feachures,
        "AddNew":	{"url":"../Form_GRN_LAV/GRN_LAV_Form.jsp",
            "buttonIndex":0,
            "disabled": false
        },
        "Edit":	{"url":"../Form_GRN_LAV/GRN_LAV_Form.jsp",
            "buttonIndex":1,
            "disabled": false
        },
        "Delete":	{"url":"../Form_GRN_LAV/GRN_LAV_Delete.jsp?LOCAL_MODE=AL",
            "target_element":document.all["ifrmWork"],
            "buttonIndex":2,
            "disabled": false
        },
        "Help":	{"url":"../Form_NUM_TEL/NUM_TEL_Help.jsp",
            "buttonIndex":3,
            "disabled": false
        }
    };
//-------------------------------------------------------------------------------------------

</script>
<%} else {%>
<script type="text/javascript">
    window.dialogWidth="900px";
    window.dialogHeight="445px";
</script>
<%}%>
</body>
</html>
