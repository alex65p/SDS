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

<% /*
            <file>
            <versions>
            <version number="1.0" date="09/02/2004" author="Alex Kyba">
            <comments>
            <comment date="09/02/2004" author="Alex Kyba">
            <description>Kod dlia refresha tabov</description>
            </comment>
            </comments>
            </version>
            </versions>
            </file>
             */%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    err = false;
</script>
<div id="dContent">
    <%
                String nameTab = new String();
                String err = new String();
                String str = new String();
                String curTab = new String();
                boolean isError = false;
                java.util.Collection col;
                java.util.Iterator it;

                IMacchina bean = null;
                IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");

                if (request.getParameter("ID_PARENT") != null) {
                    Long ID = new Long(request.getParameter("ID_PARENT"));
                    out.println(ID);
                    try {
                        bean = home.findByPrimaryKey(new MacchinaPK(Security.getAzienda(), ID.longValue()));
                    } catch (Exception ex) {
                        err = "Cannot find record with ID=" + ID.toString();
                        err += "<br>" + ex.getMessage();
                        out.println("<script>err = true</script>");
                        out.print("<div id='errContent'>" + err + "</div>");
                        //return;
                    }
                }

                if (request.getParameter("TAB_NAME") != null) {
                    nameTab = request.getParameter("TAB_NAME");
                } else {
                    err = "Parameter TAB_NAME not defined";
                    out.print("<script>err = true</script>");
                }
                try {
                    if (!isError && nameTab.equals("tab1")) {
                        curTab = "Rischio Mac./Attr";
                        out.println("tab1");
                        str = BuildRischioMacchineTab(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab2")) {
                        curTab = "Luogo Fisico";
                        out.println("tab2");
                        str = BuildLuogoFisicoTab(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab3")) {
                        curTab = "Att. Manutenzione";
                        out.println("tab3");
                        str = BuildAttManutenzioneTab(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab5")) {
                        curTab = "Documenti";
                        out.println("tab5");
                        str = BuildAnagraficaDocumentiTab(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab4")) {
                        curTab = "Normative Sentenze";
                        out.println("tab4");
                        str = BuildNormativeSentenzeView(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab6")) {
                        curTab = "Fornitori Mac./Attr";
                        out.println("tab6");
                        str = BuildFornitoriMacchineTab(bean);
                        out.print(str);
                    }
                    if (!isError && nameTab.equals("tab7")) {
                        out.println("tab7");
                        str = BuildUtilizzatori(bean);
                        out.print(str);
                    }
                } catch (Exception ex) {
                    out.println("</div>");
                    err = "Impossible rebuild " + curTab + " tab content";
                    err += "<br>" + ex.getMessage();
                    out.println("<script>err = true</script>");
                    out.print("<div id='errContent'>" + err + "</div>");
                    //return;
                }
    %>
</div>
<script>
    if (!err){
        parent.tabbar.ReloadTabTable(document);
    }
    else{
        alert(errContent.innerText);
    }
 
</script>

<%!     String BuildRischioMacchineTab(IMacchina bean) {
        String str = "";
        java.util.Collection col = bean.getRischioMacchinaView(Security.getAzienda());

        str = "<table border='0' align='left' width='862' id='RischioHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='340'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.del.rischio") + "</strong></td>";
        str += "<td width='182'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("PxD(Probabilità.x.Danno)") + "</strong></td>";
        str += "<td width='340'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio.per") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='862' id='Rischio' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='STM_NUM_RSO' readonly class='dataInput'  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='RFC_VLU_RSO' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            RischioMacchinaView view = (RischioMacchinaView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_RSO) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='NOM_RSO' class='inputstyle' readonly style='width: 340px;'  value=\"" + Formatter.format(view.strNOM_RSO) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='STM_NUM_RSO' readonly style='width: 182px;' class='inputstyle'  value=\"" + Formatter.format(view.strSTM_NUM_RSO) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='RFC_VLU_RSO' readonly style='width: 340px;' class='inputstyle'  value=\"" + Formatter.format(view.strRFC_VLU_RSO) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildLuogoFisicoTab(IMacchina bean) {
        String str = "";
        java.util.Collection col = bean.getLuoghiFisiciView();

        str = "<table border='0' align='left' width='862' id='LuoFscHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='34%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString(
                ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                    ?"Luogo.fisico.macchine.attrezzature.impianti"
                    :"Luogo.fisico.macchine/attrezzature"
                ) + "</strong></td>";
        str += "<td width='33%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.dirigente.preposto") + "</strong></td>";
        str += "<td width='33%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qualifica") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='1' id='LuoFsc' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td width='30%' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=''></td>";
        str += "<td width='30%' class='dataTd'><input type='text' name='NOM_RSP_LUO_FSC' readonly class='dataInput'  value=''></td>";
        str += "<td width='30%' class='dataTd'><input type='text' name='QLF_RSP_LUO_FSC' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Macchina_LuoghiFisiciView view = (Macchina_LuoghiFisiciView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_LUO_FSC) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td width='30%' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=\"" + Formatter.format(view.strNOM_LUO_FSC) + "\"></td>";
            str += "<td width='30%' class='dataTd'><input type='text' name='NOM_RSP_LUO_FSC' readonly class='dataInput'  value=\"" + Formatter.format(view.strNOM_RSP_LUO_FSC) + "\"></td>";
            str += "<td width='30%' class='dataTd'><input type='text' name='QLF_RSP_LUO_FSC' readonly class='dataInput'  value=\"" + Formatter.format(view.strQLF_RSP_LUO_FSC) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildAttManutenzioneTab(IMacchina bean) {
        String str = "";
        java.util.Collection col = bean.getAttivitaMntView();

        str = "<table border='0' align='left' width='862' id='AttMntHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='350'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
        str += "<td width='350'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Periodicità") + "</strong></td>";
        str += "<td width='162'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='862' id='AttMnt' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='DES_ATI_MNT_MAC' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='NB_PER_ATI_MNT_MES' readonly class='dataInput'  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='DAT_PAR_MNT_MAC' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AttivitaMntView view = (AttivitaMntView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_MNT_MAC) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='DES_ATI_MNT_MAC' class='inputstyle' readonly style='width: 350px;'  value=\"" + Formatter.format(view.strDES_ATI_MNT_MAC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='PER_ATI_MNT_MES' readonly style='width: 350px;' class='inputstyle'  value=\"" + Formatter.format(view.strNB_PER_ATI_MNT_MES) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='DAT_PAR_MNT_MAC' readonly style='width: 162px;' class='inputstyle'  value=\"" + Formatter.format(view.dtDAT_PAR_MNT_MAC) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildNormativeSentenzeView(IMacchina bean) {
        String str;
        java.util.Collection col = bean.getNormativeSentenzeView();

        str = "<table border='0' align='left' width='862' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='700'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza") + "</strong></td>";
        str += "<td width='162'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.normativa/sentenza") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='862' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            NormativeSentenzeView view = (NormativeSentenzeView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_NOR_SEN) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td width='70%' class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 700px;'  value=\"" + Formatter.format(view.strTIT_NOR_SEN) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 162px;' class='inputstyle'  value=\"" + Formatter.format(view.dtDAT_NOR_SEN) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildAnagraficaDocumentiTab(IMacchina bean) {
        String str;
        java.util.Collection col = bean.getAnagraficaDocumentiView();

        str = "<table border='0' align='left' width='862' id='AnagraficaDocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='350'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
        str += "<td width='350'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
        str += "<td width='162'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='862' id='AnagraficaDocumenti' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnagraficaDocumentiView view = (AnagraficaDocumentiView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_DOC) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td width='40%' class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 350px;'  value=\"" + Formatter.format(view.strTIT_DOC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 350px;' class='inputstyle'  value=\"" + Formatter.format(view.strRSP_DOC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly style='width: 162px;' class='inputstyle'  value=\"" + Formatter.format(view.dtDAT_REV_DOC) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildFornitoriMacchineTab(IMacchina bean) {
        String str = "";
        java.util.Collection col = bean.getFornitoriMacView();

        str = "<table border='0' align='left' width='862' id='ForMactHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr><td width='217'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ragione.sociale") + "</strong></td>";
        str += "<td width='215'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Categoria") + "</strong></td>";
        str += "<td width='215'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Città") + "</strong></td>";
        str += "<td width='215'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='862' id='ForMac' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='RAG_SOZ_FOR_AZL' class='dataInput' readonly  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='CAG_FOR' readonly class='dataInput'  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='CIT_FOR' readonly class='dataInput'  value=''></td>";
        str += "<td class='dataTd'><input type='text' name='NOM_RSP_FOR' readonly class='dataInput'  value=''></td></tr>";

        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            FornitoriMacView view = (FornitoriMacView) it.next();
            str += "<tr style='display:' ID='" + Formatter.format(view.lCOD_FOR_AZL) + "' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'><td class='dataTd'><input type='text' name='RAG_SOZ_FOR_AZL' class='inputstyle' readonly style='width: 217px;'  value=\"" + Formatter.format(view.strRAG_SOZ_FOR_AZL) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='CAG_FOR' readonly style='width: 215px;' class='inputstyle'  value=\"" + Formatter.format(view.strCAG_FOR) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='CIT_FOR' readonly style='width: 215px;' class='inputstyle'  value=\"" + Formatter.format(view.strCIT_FOR) + "\"></td>";
            str += "<td class='dataTd'><input type='text' name='NOM_RSP_FOR' readonly style='width: 215px;' class='inputstyle'  value=\"" + Formatter.format(view.strNOM_RSP_FOR) + "\"></td></tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildUtilizzatori(IMacchina bean) {
        String str = "";
        java.util.Collection col = bean.getAttivitaLavorativeMacchineView();
        str += "<table border='0' align='left' width='862' id='' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str += "<td width='862'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.operazione") + "</strong></td>";
        str += "</tr></table>";
        str += "<table border='0' align='left' width='784' id='' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(bean.getCOD_MAC()) + "'>";
        str += "<td width='862' class='dataTd'><input type='text' name='NOM_ATT_LAV' class='inputstyle' readonly  value=''></td></tr>";
        if (bean != null) {
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                UtilizzatoriView rc = (UtilizzatoriView) it.next();
                str += "<tr INDEX='" + Formatter.format(bean.getCOD_MAC()) + "' ID='" + Formatter.format(rc.COD_MAN) + "'>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 862px;' class='inputstyle' value=\"" + Formatter.format(rc.NOM_MAN) + "\" ></td>";
                str += "</tr>";
            }
        }// bean = null
        //----------------------
        str += "</table>";
        return str;
    }

%>
