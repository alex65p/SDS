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

<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteMediche.*" %>
<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.*" %>
<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<% //-------SCADENZARIO MACCHINE/ATTREZZATURE------- %>
<%@ page import="s2s.luna.reports.Report_SCD_MAC" %>
<% //-------SCADENZARIO SEGNALAZIONE D'AUDIT------- %>
<%@ page import="s2s.luna.reports.Report_SCD_ADT" %>
<% //----- SCADENZARIO VISITE IDONEITA'------- %>
<%@ page import="s2s.luna.reports.Report_SCD_VST_IDO" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>

<% //------SCADENZARIO MISURE DI PREVENZIONE/PROTEZIONE-------- %>
<%@ include file="../SCD_MIS_PET/REP_SCD_MIS_PET_Report.jsp"%>

<% //------SCADENZARIO MISURE DI PREVENZIONE/PROTEZIONE AZIENDALE-------- %>
<%@ include file="../SCD_MIS_PET_AZL/REP_SCD_MIS_PET_AZL_Report.jsp"%>

<% //------SCADENZARIO INTERVENTI DI AUDIT-------- %>
<%@ include file="../SCD_INR_ADT/REP_SCD_INR_ADT_Report.jsp"%>

<% //------SCADENZARIO CORSI-------- %>
<%@ include file="../SCD_COR/REP_SCD_COR_Report.jsp"%>

<% //------SCADENZARIO DOCUMENTI VERSIONI-------- %>
<%@ include file="../SCD_DOC/REP_SCD_DOC_Report.jsp"%>

<% //-------SCADENZARIO RIVALUTAZIONE RISCHI------- %>
<%@ include file="../REP_SCD_RIV_RSO/SCD_RIV_RSO_Report.jsp"%>

<% //-------SCADENZARIO PRESIDI ANTINCENDIO------- %>
<%@ include file="../REP_SCD_PSD_ACD/SCD_PSD_ACD_Report.jsp"%>

<% //-------SCADENZARIO DPI------- %>
<%@ include file="../SCD_DPI/REP_SCD_DPI_Report.jsp"%>

<% //-------------- %>
<%@ include file="../Report.jsp"%>

<% 	class ScadenzarioReport extends Report
	{
		public long repType=0;
		public java.util.ArrayList IDS=null;
		public String strRepName="";

		public ScadenzarioReport(){
			this.IDS = new java.util.ArrayList();
		}

		public void doReport() throws DocumentException, IOException, BadElementException, Exception{ 	
			if (repType==0) return;
			Long ID;
			Report report=getReportByType(this.repType);
			initDocument("the doc", null, strRepName, ApplicationConfigurator.LanguageManager.getString("MULTIAZIENDA"), "");

                        writeIndent();
			CenterMiddleTable tbl=new CenterMiddleTable(1);
			tbl.addHeaderCellB(strRepName);
			m_document.add(tbl);
			Iterator it = IDS.iterator();
			if (it!=null){
				while (it.hasNext()){
					ID = (Long)it.next();
					report = getReportByType(this.repType);
					report.lCOD_AZL = ID.longValue();
					report.request = request;
					report.response= response;
					report.bStandAlone = false;
					report.doReport(m_out, m_document);
					if (it.hasNext()) writePage();
				}
			}
			closeDocument();	
		}// do Report()
		
		//=========================================================
		Report getReportByType(long repType)throws Exception{
			Report report=null;
			if (repType==1){
				Report_SCD_VST_IDO rpt = new Report_SCD_VST_IDO();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.VISITE.IDONEITA'");
				Security.accessModule("/WEB/Reports/ScadenzarioVisitaIdoneita.jsp");
			}
			if (repType==2){
				Report_SCD_MIS_PET rpt = new Report_SCD_MIS_PET();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.MISURE.DI.PREVENZIONE/PROTEZIONE");
				Security.accessModule("/WEB/Reports/ScadenzarioMisurePreventive.jsp");
			}	
			if (repType==3){
				Report_SCD_MIS_PET_AZL rpt = new Report_SCD_MIS_PET_AZL();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.MISURE.DI.PREVENZIONE/PROTEZIONE");
				Security.accessModule("/WEB/Reports/ScadenzarioMisurePreventiveAz.jsp");
			}
			if (repType==4){
				Report_SCD_INR_ADT rpt = new Report_SCD_INR_ADT();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.INTERVENTI.DI.AUDIT");
				Security.accessModule("/WEB/Reports/ScadenzarioInterventiAudit.jsp");
			}
			if (repType==5){
				Report_SCD_COR rpt = new Report_SCD_COR();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.CORSI");
				Security.accessModule("/WEB/Reports/ScadenzarioCorsi.jsp");
			}
			if (repType==6){
				Report_SCD_DOC rpt = new Report_SCD_DOC();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.DOCUMENTI/VERSIONI");
				Security.accessModule("/WEB/Reports/ScadenzarioDocumenti.jsp");
			}
			if (repType==7){
				Report_SCD_RIV_RSO rpt = new Report_SCD_RIV_RSO();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.RIVALUTAZIONE.RISCHI");
				Security.accessModule("/WEB/Reports/ScadenzarioRivalutazioneRischi.jsp");
			}
			if (repType==9){
				Report_SCD_ADT rpt = new Report_SCD_ADT();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.SEGNALAZIONE.D'AUDIT");
				Security.accessModule("/WEB/Reports/ScadenzarioAttivitaSegnalazione.jsp");
			}
			if (repType==10){
				Report_SCD_PSD_ACD rpt = new Report_SCD_PSD_ACD();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.PRESIDI.ANTINCENDIO");
				Security.accessModule("/WEB/Reports/ScadenzarioPresidiAntincendio.jsp");
			}						
			if (repType==11){
				Report_SCD_MAC rpt = new Report_SCD_MAC();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString(
                                        ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                                            ?"Scadenzario.macchine.attrezzature.impianti"
                                            :"Scadenzario.macchine/attrezzature"
                                        ).toUpperCase();
				Security.accessModule("/WEB/Reports/ScadenzarioMacchineAttrezzature.jsp");
			}	
			if (repType==12){
				Report_SCD_DPI rpt = new Report_SCD_DPI();
				report=rpt;
				strRepName=ApplicationConfigurator.LanguageManager.getString("SCADENZARIO.D.P.I.");
				Security.accessModule("/WEB/Reports/ScadenzarioDPIManutenzioe.jsp");
			}
			return report;
		}
		//--------------------------------------------------------
} 

Checker c = new Checker();
long repType = c.checkLong("rep type", request.getParameter("REP_TYPE"), true);
String[] aziendaIDs = request.getParameterValues("AZIENDA_ID");
if ( c.isError){
	%>
	<html><body>
		<h2><%=c.printErrors()%></h2>
	</body></html>
	<%
	return;
}
Security.accessRequest("AZIENDA_ID");
//if(true) return;
out.clearBuffer();

ScadenzarioReport report = new ScadenzarioReport();
java.util.ArrayList arlist =  c.checkAlLong("aziendaIDs",  request.getParameterValues("AZIENDA_ID"));
report.IDS = arlist;
report.repType = repType;
report.doReport(request, response);
%>
