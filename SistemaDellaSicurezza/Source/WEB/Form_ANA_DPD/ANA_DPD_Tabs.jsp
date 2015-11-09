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
     <version number="1.0" date="18/02/2004" author="Mike Kondratyuk">
     <comments>
     <comment date="18/02/2004" author="Mike Kondratyuk">
     <description>Create ANA_DPD_Tabs.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script>
    var err = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script language="JavaScript" src="../_scripts/utility.js"></script>
<div id="dContent">
    <%    boolean dipCessato = false;
        if (request.getParameter("dipCessato") != null) {
            dipCessato = Boolean.valueOf(request.getParameter("dipCessato")).booleanValue();
        }

        long lCOD_DPD = new Long(request.getParameter("ID_PARENT")).longValue();
        String strCOD_FIS_DPD = request.getParameter("strCOD_FIS_DPD");
        
        String columnOrdered = request.getParameter("columnOrdered");
        String orderType = request.getParameter("orderType");
        
        try {
            if (request.getParameter("TAB_NAME").equals("tab1")) {
                IDipendenteTelefonoHome home = (IDipendenteTelefonoHome) PseudoContext.lookup("DipendenteTelefonoBean");
                out.println(BuildDipendenteTelefonoTab(home, lCOD_DPD));
            } else if (request.getParameter("TAB_NAME").equals("tab2")) {
                IDipendentePrecedentiHome home = (IDipendentePrecedentiHome) PseudoContext.lookup("DipendentePrecedentiBean");
                out.println(BuildDipendentePrecedentiTab(home, lCOD_DPD, strCOD_FIS_DPD, dipCessato));
            } else if (request.getParameter("TAB_NAME").equals("tab3")) {
                IDipendenteLingueStraniereHome home = (IDipendenteLingueStraniereHome) PseudoContext.lookup("DipendenteLingueStraniereBean");
                out.println(BuildDipendenteLingueStraniereTab(home, lCOD_DPD));
            } else if (request.getParameter("TAB_NAME").equals("tab4")) {
                ITitoliStudioHome home = (ITitoliStudioHome) PseudoContext.lookup("TitoliStudioBean");
                out.println(BuildTitoliStudioTab(home, lCOD_DPD));
            } else if (request.getParameter("TAB_NAME").equals("tab5")) {
                IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                out.println(BuildPercorsiFormativiTab(home, lCOD_DPD));
            } else if (request.getParameter("TAB_NAME").equals("tab6")) {
                IDipendenteCorsiHome home = (IDipendenteCorsiHome) PseudoContext.lookup("DipendenteCorsiBean");
                out.println(BuildDipendenteCorsiTab(home, lCOD_DPD, columnOrdered, orderType));
            } else if (request.getParameter("TAB_NAME").equals("tab7")) {
                IDipendenteConsegneDPIHome home = (IDipendenteConsegneDPIHome) PseudoContext.lookup("DipendenteConsegneDPIBean");
                out.println(BuildDipendenteConsegneDPITab(home, lCOD_DPD));
            } else if (request.getParameter("TAB_NAME").equals("tab8")) {
                IDipendenteHome home = (IDipendenteHome) PseudoContext.lookup("DipendenteBean");
                out.println(BuildDipendenteAttivitaLavorativeTab(home, lCOD_DPD, columnOrdered, orderType));
            } else {
                return;
            }
        } catch (Exception ex) {
            out.print(printErrAlert("divErr", "Error.alert", ex));
            return;
        }

    %>
</div>
<script>
    if (!err) {
        parent.tabbar.ReloadTabTable(document);
    }
</script>
<%!    String BuildDipendenteTelefonoTab(IDipendenteTelefonoHome home, long lCOD_DPD) {
        String str;
        java.util.Collection col = home.getDipendenteTelefono_Tipology_Number_View(lCOD_DPD);

        str = "<table border='0' align='left' width='870' id='DipendenteTelefonoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='DipendenteTelefono' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='435' class='dataTd'><input type='text' name='TPL_NUM_TEL' class='dataInput' readonly  value=''></td>";
        str += "<td width='435' class='dataTd'><input type='text' name='NUM_TEL' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendenteTelefono_Tipology_Number_View obj = (DipendenteTelefono_Tipology_Number_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + obj.COD_NUM_TEL_DPD + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.TPL_NUM_TEL) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.NUM_TEL) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildDipendentePrecedentiTab(IDipendentePrecedentiHome home, long lCOD_DPD, String strCOD_FIS_DPD, boolean dipCessato) {
        String str;
        java.util.Collection col = home.getDipendentePrecedenti_Tipology_Number_View(lCOD_DPD);

        java.util.Collection aziende_precedenti = home.getDipendenteAziende_Precedenti_View(strCOD_FIS_DPD, lCOD_DPD, Security.getAzienda());
        col.addAll(aziende_precedenti);

        str = "<table border='0' align='left' width='870' id='DipendentePrecedentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ragione.sociale") + "</strong></td>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.svolta") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='DipendentePrecedenti' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='435' class='dataTd'><input type='text' name='RAG_SCL_DIT_PRC' class='dataInput' readonly  value=''></td>";
        str += "<td width='435' class='dataTd'><input type='text' name='DES_ATI_SVO_DIT_PRC' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        String InputStyle = "";
        String personalizedUrl = "";
        long ID = 0;
        boolean rowDetailEnabled = false;
        while (it.hasNext()) {
            DipendentePrecedenti_Tipology_Number_View obj = (DipendentePrecedenti_Tipology_Number_View) it.next();
            if (obj.AZL_PRE == false) {
                InputStyle = "dataInput";
                personalizedUrl = "";
                ID = obj.COD_DIT_PRC_DPD;
                rowDetailEnabled = !dipCessato;
            } else {
                // GESTIONE DELLE PARTE RIGUARDANTE LA LISTA DELLE AZIENDE PRECEDENTI DEL GRUPPO
                InputStyle = "dataInput_AZL_PRE";
                personalizedUrl = "../Form_ANA_DPD/ANA_DPD_Form.jsp?azlPre=true";
                ID = obj.COD_DPD;
                rowDetailEnabled = true;
            }
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + ID + "' personalizedUrl='" + personalizedUrl + "' rowDetailEnabled='" + rowDetailEnabled + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle' fixedStyle value=\"" + Formatter.format(obj.RAG_SCL_DIT_PRC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle' fixedStyle value=\"" + Formatter.format(obj.DES_ATI_SVO_DIT_PRC) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildDipendenteLingueStraniereTab(IDipendenteLingueStraniereHome home, long lCOD_DPD) {
        String str;
        java.util.Collection col = home.getDipendenteLingueStraniere_View(lCOD_DPD, Security.getAzienda());

        str = "<table border='0' align='left' width='870' id='DipendenteLingueStraniereHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Lingue.straniere") + "</strong></td>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Livello.di.conoscenza") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='DipendenteLingueStraniere' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='435' class='dataTd'><input type='text' name='NOM_LNG_STR_DPD' class='dataInput' readonly  value=''></td>";
        str += "<td width='435' class='dataTd'><input type='text' name='LIV_CSC_LNG_STR' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendenteLingueStraniere_View obj = (DipendenteLingueStraniere_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + obj.COD_LNG_STR_DPD + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_LNG_STR_DPD) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.LIV_CSC_LNG_STR) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildTitoliStudioTab(ITitoliStudioHome home, long lCOD_DPD) {
        String str;
        java.util.Collection col = home.getDipendente_TitoliStudio_View(lCOD_DPD);

        str = "<table border='0' align='left' width='870' id='TitoliStudioHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.di.studio") + "</strong></td>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='TitoliStudio' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='435' class='dataTd'><input type='text' name='NOM_TIT_STU_SPC' class='dataInput' readonly  value=''></td>";
        str += "<td width='435' class='dataTd'><input type='text' name='TLP_TIT_STU_SPC' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendente_TitoliStudio_View obj = (Dipendente_TitoliStudio_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + obj.COD_TIT_STU_SPC + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_TIT_STU_SPC) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.TLP_TIT_STU_SPC) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildPercorsiFormativiTab(IDipendenteHome home, long lCOD_DPD) {
        String str;
        java.util.Collection col = home.getDipendentePercorsiFormativi_View(lCOD_DPD);

        str = "<table border='0' align='left' width='870' id='PercorsiFormativiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.del.percorso") + "</strong></td>";
        str += "<td width='435'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='PercorsiFormativi' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='435' class='dataTd'><input type='text' name='NOM_PCS_FRM' class='dataInput' readonly  value=''></td>";
        str += "<td width='435' class='dataTd'><input type='text' name='DES_PCS_FRM' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendentePercorsiFormativi_View obj = (DipendentePercorsiFormativi_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + obj.COD_PCS_FRM + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_PCS_FRM) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 435px;' class='inputstyle'  value=\"" + Formatter.format(obj.DES_PCS_FRM) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }
    /*
     String BuildDipendenteTelefonoTab(IDipendenteTelefonoHome home, long lCOD_DPD)
     {
     String str;
     java.util.Collection col = home.getDipendenteTelefono_Tipology_Number_View(lCOD_DPD);
	
     str="<table border='0' id='DipendenteTelefonoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
     str+="<tr>";
     str+="<td  align='center' width='100%'><strong>Tipologia</strong></td>";
     str+="<td  align='center' width='100%'><strong>N. di Telefono</strong></td>";
     str+="</tr>";
     str+="</table>";
     str+="<table border='1' id='DipendenteTelefono' class='dataTable' cellpadding='0' cellspacing='0'>";
     str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_DPD)+"'>";
     str+="<td width='100%' class='dataTd'><input type='text' name='TPL_NUM_TEL' class='dataInput' readonly  value=''></td>";
     str+="<td width='100%' class='dataTd'><input type='text' name='NUM_TEL' class='dataInput' readonly  value=''></td>";
     str+="</tr>";
     java.util.Iterator it = col.iterator();
     while(it.hasNext()){
     DipendenteTelefono_Tipology_Number_View obj=(DipendenteTelefono_Tipology_Number_View)it.next();
     str+="<tr INDEX='"+Formatter.format(lCOD_DPD)+"' ID='"+obj.COD_NUM_TEL_DPD+"'>";
     str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.TPL_NUM_TEL)+"\"></td>";
     str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NUM_TEL)+"\"></td>";
     str+="</tr>";
     }
     str+="</table>";
     return str;
     }
     */

    String BuildDipendenteConsegneDPITab(IDipendenteConsegneDPIHome home, long lCOD_DPD) {
        String str;
        java.util.Collection col = home.getDipendenti_DPI_View(lCOD_DPD);

        str = "<table border='0' align='left' width='870' id='DipendenteConsegneDPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='600'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.") + "</strong></td>";
        str += "<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Qtà.consegnata") + "</strong></td>";
        str += "<td width='130'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.consegna") + "</strong></td>";
        str += "</tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='DipendenteConsegneDPI' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='600' class='dataTd'><input type='text' name='NOM_TPL_DPI' class='dataInput' readonly  value=''></td>";
        str += "<td width='140' class='dataTd'><input type='text' name='QTA_CSG' class='dataInput' readonly  value=''></td>";
        str += "<td width='130' class='dataTd'><input type='text' name='DAT_CSG_DPI' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendenti_DPI_View obj = (Dipendenti_DPI_View) it.next();
            str += "<tr INDEX='" + Formatter.format(lCOD_DPD) + "' ID='" + obj.COD_CSG_DPI + "'>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 600px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_TPL_DPI) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.QTA_CSG) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 130px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_CSG_DPI) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildDipendenteCorsiTab(IDipendenteCorsiHome home, long lCOD_DPD, String columnOrdered, String orderType) {
        String str = "";
        java.util.Collection col = home.getDipendenteCorsi_View(lCOD_DPD, columnOrdered, orderType);

        str = "<table border='0' align='left' width='870' id='DipendenteCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='370'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.del.corso") + "</strong></td>";
        str += "<td width='370'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
        str += "<td width='130' ordered='true'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.corso") + "</strong></td>";
        str += "</tr>";
        str += "</table>";

        str += "<table border='0' align='left' width='870' id='DipendenteCorsi' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='370' class='dataTd'><input type='text' name='strNOM_COR' class='dataInput' readonly  value=''></td>";
        str += "<td width='370' class='dataTd'><input type='text' name='strDES_COR' class='dataInput' readonly  value=''></td>";
        str += "<td width='130' class='dataTd'><input type='text' name='dtDAT_EFT_COR' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DipendenteCorsi_View obj = (DipendenteCorsi_View) it.next();
            str += "<tr INDEX='" + lCOD_DPD + "' ID='" + obj.lCOD_COR + "' paramsList=dat_eft_cor=" + obj.dtDAT_EFT_COR + ">";
            str += "<td class='dataTd'><input type='text' readonly style='width: 370px;' class='inputstyle'  value=\"" + Formatter.format(obj.strNOM_COR) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 370px;' class='inputstyle'  value=\"" + Formatter.format(obj.strDES_COR) + "\"></td>";
            java.text.Format df = new java.text.SimpleDateFormat("dd/MM/yyyy");
            String dataStringa = df.format(obj.dtDAT_EFT_COR);
            if (dataStringa.equals("01/01/1900")) {
                obj.dtDAT_EFT_COR = null;
                str += "<td class='dataTd'><input type='text' readonly style='width: 130px;' class='inputstyle'  value=\"" + Formatter.format(obj.dtDAT_EFT_COR) + "\"></td>";
            } else {
                str += "<td class='dataTd'><input type='text' readonly style='width: 130px;' class='inputstyle'  value=\"" + Formatter.format(obj.dtDAT_EFT_COR) + "\"></td>";
            }

            str += "</tr>";
        }
        str += "</table>";
        return str;
    }

    String BuildDipendenteAttivitaLavorativeTab(IDipendenteHome home, long lCOD_DPD, String columnOrdered, String orderType) {
        String str = "";
        java.util.Collection col = home.getDipendenti_Lavoratori_View(lCOD_DPD, columnOrdered, orderType);
        str = "<table border='0' align='left' width='870' id='DipendenteAttivitaLavorativeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
        str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa") + "</strong></td>";
        str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa") + "</strong></td>";
        str += "<td width='135'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio") + "</strong></td>";
        str += "<td width='135'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine") + "</strong></td></tr>";
        str += "</table>";
        str += "<table border='0' align='left' width='870' id='DipendenteAttivitaLavorative' class='dataTable' cellpadding='0' cellspacing='0'>";
        str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(lCOD_DPD) + "'>";
        str += "<td width='300' class='dataTd'><input type='text' name='NOM_MAN' class='dataInput' readonly  value=''></td>";
        str += "<td width='300' class='dataTd'><input type='text' name='NOM_UNI_ORG' class='dataInput' readonly  value=''></td>";
        str += "<td width='135' class='dataTd'><input type='text' name='DAT_INZ' class='dataInput' readonly  value=''></td>";
        str += "<td width='135' class='dataTd'><input type='text' name='DAT_FIE' class='dataInput' readonly  value=''></td>";
        str += "</tr>";
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            Dipendenti_Lavoratori_View obj = (Dipendenti_Lavoratori_View) it.next();

            str += "<tr INDEX='" + lCOD_DPD + "' ID='" + obj.COD_UNI_ORG + "|" + obj.COD_MAN + "' paramsList=dat_inz=" + obj.DAT_INZ + "&dat_fie=" + obj.DAT_FIE + ">";
            str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_MAN) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_UNI_ORG) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 135px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_INZ) + "\"></td>";
            str += "<td class='dataTd'><input type='text' readonly style='width: 135px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_FIE) + "\"></td>";
            str += "</tr>";
        }
        str += "</table>";
        return str;

    }
%>
