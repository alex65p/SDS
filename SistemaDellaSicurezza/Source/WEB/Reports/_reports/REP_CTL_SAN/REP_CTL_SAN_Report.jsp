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

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>
<%
class Report_REP_CTL_SAN extends Report{
	public long lCOD_CTL_SAN=0;
	public long lCOD_AZL=0;

	
	public Report_REP_CTL_SAN(long lCOD_CTL_SAN){
		this.lCOD_CTL_SAN=lCOD_CTL_SAN;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			ICartelleSanitarieHome home_san=(ICartelleSanitarieHome)PseudoContext.lookup("CartelleSanitarieBean");
			ICartelleSanitarie bean_san=home_san.findByPrimaryKey(new Long(lCOD_CTL_SAN));
			
			IDipendenteHome home_dpd=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			IDipendente		bean_dpd=home_dpd.findByPrimaryKey(new Long(bean_san.getCOD_DPD()));
			
			String strTmp=bean_dpd.getNOM_DPD()+" "+ bean_dpd.getCOG_DPD();
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("CARTELLA.SANITARIA"), bean.getRAG_SCL_AZL(), strTmp);
             
                        AddImage();                        
                        writeIndent();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("CARTELLA.SANITARIA"));
					tbl.addTitleCell(strTmp);
				m_document.add(tbl);
			}
			{
			 	CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {30,79};
				tbl.setWidths(width);
						
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("N.Matr."));// ok
				tbl.addCell(Formatter.format(bean_dpd.getMTR_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Medico.responsabile"));// ok
				tbl.addCell(Formatter.format(bean_san.getNOM_MED_RSP_CTL_SAN()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Creazione.cartella.sanitaria"));// ok
				tbl.addCell(Formatter.format(bean_san.getDAT_CRE_CTL_SAN()));				
				
				m_document.add(tbl);
			}
			{//documenti allegati
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {60,26,14};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Documenti.allegati"));
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Revisione"));
				
				Iterator it=home_san.getDocumentiCartelle_View(lCOD_CTL_SAN).iterator();
				while(it.hasNext()){
					DocumentiCartelle_View w=(DocumentiCartelle_View)it.next();
					tbl.toLeft();
					tbl.addCell(Formatter.format(w.NB_TIT_DOC));
					tbl.addCell(Formatter.format(w.NB_RSP_DOC));
					tbl.toCenter();
					tbl.addCell(Formatter.format(w.NB_DAT_REV_DOC));
				}
				m_document.add(tbl);
			}
			{//Protocoli sanitari
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {60,40};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Protocolli.sanitari"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Documenti.allegati"));
				
				Iterator it=home_san.getProtocolliSanitari_View(lCOD_CTL_SAN).iterator();
				while(it.hasNext()){
					ProtocolliSanitari_View w=(ProtocolliSanitari_View)it.next();
					tbl.addCell(Formatter.format(w.NOM_PRO_SAN));
					tbl.addCell(Formatter.format(""));
					//tbl.addCell(Formatter.format(w.NB_DAT_REV_DOC));
				}
				m_document.add(tbl);
			}
			{//VisiteIdoneita
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {70,25};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Visite.di.idoneita"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.svolgimento"));
				
				Iterator it=home_san.getReportVisiteIdoneita_View(lCOD_CTL_SAN).iterator();
				while(it.hasNext()){
					ReportVisiteIdoneita_View w=(ReportVisiteIdoneita_View)it.next();
					tbl.toLeft();
					tbl.addCell(Formatter.format(w.NOM_VST_IDO));
					tbl.toCenter();
					tbl.addCell(Formatter.format(w.DAT_EFT_VST_IDO));
				}
				m_document.add(tbl);
			}
			{//VisiteMedice
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {70,25};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Visite.mediche"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.svolgimento"));
				
				Iterator it=home_san.getReportVisiteMediche_View(lCOD_CTL_SAN).iterator();
				while(it.hasNext()){
					ReportVisiteMediche_View w=(ReportVisiteMediche_View)it.next();
					tbl.toLeft();
					tbl.addCell(Formatter.format(w.NOM_VST_MED));
					tbl.toCenter();
					tbl.addCell(Formatter.format(w.DAT_EFT_VST_MED));
				}
				m_document.add(tbl);
			}
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();
		
long lCOD_CTL_SAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Cartella"), request.getParameter("ID"), true);


if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();
Report_REP_CTL_SAN report = new Report_REP_CTL_SAN(lCOD_CTL_SAN);

report.doReport(request, response);
%>
