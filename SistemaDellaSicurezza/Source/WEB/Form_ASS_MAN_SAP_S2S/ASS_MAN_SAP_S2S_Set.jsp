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
        <version number="1.0" date="17/10/2007" author="Dario Massaroni">
            <comments>
                <comment date="17/10/2007" author="Dario Massaroni">
                    <description>ASS_MAN_SAP_S2S_Set.jsp</description>
                </comment>
            </comments> 
        </version>
    </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache");        //HTTP 1.0
response.setDateHeader ("Expires", 0); 		//prevents caching at the proxy server
%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="javax.ejb.FinderException"%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.SediAziendali.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
Checker c = new Checker();
IDipendenteHome homeDipendente = (IDipendenteHome)PseudoContext.lookup("DipendenteBean");
IDipendente beanDipendente = null;
AssociazioneMansioniSAP_S2SHome homeAssocia = (AssociazioneMansioniSAP_S2SHome)PseudoContext.lookup("AssociazioneMansioniSAP_S2SBean");
IAnagrLuoghiFisiciHome homeLuogoFisico = (IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
IUnitaOrganizzativaHome homeUnitaOrganizzativa = (IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");
IUnitaOrganizzativa beanUnitaOrganizzativa = null;
ISitaAziendeHome homeSitoAziendale = (ISitaAziendeHome)PseudoContext.lookup("SitaAziendeBean");

String[] lista_sap_ID = request.getParameterValues("sap_rowsSelected_ID");
String[] lista_sap_COD_DPD_S2S = request.getParameterValues("sap_rowsSelected_COD_DPD_S2S");
String[] lista_sap_COD_MAN_SAP_DAT_INI = request.getParameterValues("sap_rowsSelected_COD_MAN_SAP_DAT_INI");
String[] lista_sap_COD_MAN_SAP_DAT_FIN = request.getParameterValues("sap_rowsSelected_COD_MAN_SAP_DAT_FIN");
String[] lista_sap_DES_LUO_FSC_S2S = request.getParameterValues("sap_rowsSelected_DES_LUO_FSC_S2S");

long lID_SAP = 0;
Long lCOD_DPD_S2S = null;
Date dtCOD_MAN_SAP_DAT_INI = null;
Date dtCOD_MAN_SAP_DAT_FIN = null;

Collection LuogoFisico = null;
long lCOD_LUO_FSC = 0;
String strDES_LUO_FSC = null;

String Operation = request.getParameter("Operation");
long lCOD_AZL = Security.getAzienda();
long lCOD_UNI_ORG = 0;
long lCOD_MAN = 0;
if (Operation.equals("Save")){
    lCOD_UNI_ORG = Long.parseLong(request.getParameter("s2S_rowSelected_COD_UNI_ORG"));
    lCOD_MAN = Long.parseLong(request.getParameter("s2S_rowSelected_COD_MAN"));
}

boolean refresh=false;
boolean aggiornamento_parziale=false;
        
if (lista_sap_COD_DPD_S2S != null){
    
    // Stò effettuando un salvataggio
    if (Operation.equals("Save")){
        
        // Per ogni dipendente SAP selezionato...
        for (int i=1; i<=lista_sap_COD_DPD_S2S.length; i++){
            lID_SAP = Long.parseLong(lista_sap_ID[i-1]);
            lCOD_DPD_S2S = Long.valueOf(lista_sap_COD_DPD_S2S[i-1]);
            dtCOD_MAN_SAP_DAT_INI = c.checkDate("",lista_sap_COD_MAN_SAP_DAT_INI[i-1],false);
            dtCOD_MAN_SAP_DAT_FIN = c.checkDate("",lista_sap_COD_MAN_SAP_DAT_FIN[i-1],false);
            if (dtCOD_MAN_SAP_DAT_INI == null){
                dtCOD_MAN_SAP_DAT_INI = new Date(new java.util.Date().getTime());
            }
            beanDipendente = homeDipendente.findByPrimaryKey(lCOD_DPD_S2S);
            
            // ...verifico che il dipendente non sia già associato all'attività 
            // lavorativa selezionata, se non è ancora associato...
            if (homeDipendente.findDipendenteAttivitaLavorativaByCOD_UNI_ORG(lCOD_AZL, lCOD_DPD_S2S.longValue(), lCOD_MAN, lCOD_UNI_ORG, null, true).isEmpty()){
                
                // ...lo associo (aggiungo un attività lavorativa al dipendente.)
                beanDipendente.addCOD_MAN(lCOD_UNI_ORG, lCOD_MAN, dtCOD_MAN_SAP_DAT_INI, dtCOD_MAN_SAP_DAT_FIN, 0);

                // Segno l'avvenuta associazione della mansione al dipendente,
                // in questo modo questa non comparirà più nella lista delle mansioni 
                // da assegnare.
                homeAssocia.AggiornaAssociazioneSAP_S2S(lID_SAP, lCOD_UNI_ORG, lCOD_MAN);

                // Gestisco il Luogo Fisico.
                strDES_LUO_FSC = c.checkString("", lista_sap_DES_LUO_FSC_S2S[i-1], false);
                if ( strDES_LUO_FSC != null && !strDES_LUO_FSC.equals("")){
                    // Verifico che in s2s esista il luogo fisico del dipendente scaricato da sap.
                    LuogoFisico = homeLuogoFisico.getAnagrLuoghiFisici_NOM_List_View(strDES_LUO_FSC.toUpperCase(), lCOD_AZL);

                    // se non esiste...
                    if (LuogoFisico.isEmpty()){
                        // Gestisco il sito Aziendale Fittizio, se non esiste lo inserisco.
                        try {
                            homeSitoAziendale.findByPrimaryKey(new Long(-1));
                        } 
                        catch (FinderException ex){
                            homeSitoAziendale.create(-1, lCOD_AZL, "Sito Aziendale Fittizio - Import dei dati SAP", "-", "-");
                        }
                        // Inserisco il luogo fisico nell'anagrafica luoghi fisici.
                        lCOD_LUO_FSC = homeLuogoFisico.create(-1, lCOD_AZL, strDES_LUO_FSC, 0, 0, 0, 0, "", "", "", "").getCOD_LUO_FSC();
                    } else {
                        lCOD_LUO_FSC = ((AnagrLuoghiFisici_List_View)(LuogoFisico.iterator().next())).COD_LUO_FSC;
                    }

                    // Lego il luogo fisico alla mansione alla quale il dipendente è stato associato, 
                    // solo se questo legame non è già esistente.
                    beanUnitaOrganizzativa = homeUnitaOrganizzativa.findByPrimaryKey(new Long(lCOD_UNI_ORG));
                    if (beanUnitaOrganizzativa.getLuogoFisico(lCOD_LUO_FSC).isEmpty()){
                        beanUnitaOrganizzativa.addLuogoFisico(lCOD_LUO_FSC);                    
                    }
                }
                refresh=true;
            } else {
                aggiornamento_parziale=true;;
            }
        }
    // Stò effettuando una cancellazione logica
    } else if (Operation.equals("Delete")){
        
        long UO_MAN_FITTIZIA = 99999;
        // Per ogni dipendente SAP selezionato...
        for (int i=1; i<=lista_sap_COD_DPD_S2S.length; i++){
            lID_SAP = Long.parseLong(lista_sap_ID[i-1]);
            
            // Segno l'avvenuta cancellazione logica del dipendente, impostando
            // ad un codice fittizio, 99999, la propria unità organizzativa e 
            // attività lavorativa. 
            // In questo modo il dipente non comparirà più nella lista delle mansioni 
            // da assegnare.
            homeAssocia.AggiornaAssociazioneSAP_S2S(lID_SAP, UO_MAN_FITTIZIA, UO_MAN_FITTIZIA);
        }
        refresh=true;
    }
}
%>
<script type="text/javascript">
<% 
     if (Operation.equals("Save")){
        if (aggiornamento_parziale) {
            out.println("alert(arraylng[\"MSG_0068\"]);");
        }else{
            out.println("alert(arraylng[\"MSG_0067\"]);");
        }
     } else 
     if (Operation.equals("Delete")){
         out.println("alert(arraylng[\"MSG_0181\"]);");
     }
         
    if (refresh) {
        out.println("parent.form_ass_man_sap_s2s.action=\"ASS_MAN_SAP_S2S_Form.jsp\";");
        out.println("parent.form_ass_man_sap_s2s.target='_ass_man_sap_s2s';");
        out.println("parent.form_ass_man_sap_s2s.submit();");
    }
%>
</script>
