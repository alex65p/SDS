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

<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>

<%@ include file="../Report.jsp"%>

<%
class Report_REP_PRO_SAN extends Report{
	public long lCOD_PRO_SAN=0;
	public long lCOD_AZL=0;

	
	public Report_REP_PRO_SAN(long lCOD_PRO_SAN){
		this.lCOD_PRO_SAN=lCOD_PRO_SAN;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			IProtocoleSanitareHome home_pro=(IProtocoleSanitareHome)PseudoContext.lookup("ProtocoleSanitareBean");
			IProtocoleSanitare bean_pro=home_pro.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, lCOD_PRO_SAN));
			
			//IDipendenteHome home_dpd=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			//IDipendente		bean_dpd=home_dpd.findByPrimaryKey(new Long(bean_san.getCOD_DPD()));
			
			//String strTmp=bean_pro.getNOM_DPD()+" "+ bean_dpd.getCOG_DPD();
			String strTmp = "";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("PROTOCOLLO.SANITARIO"), bean.getRAG_SCL_AZL(), strTmp);
                        AddImage();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("DOCUMENTO.PROTOCOLLO.SANITARIO"));
				
				m_document.add(tbl);
			}
			writeIndent();
			{
			 	CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toCenter();
				int width[] = {20,80};
				tbl.setWidths(width);

				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.protocollo.sanitario"), 2);
				//tbl.addTitleCell(strTmp);
				tbl.toLeft();	
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nominativo"));// ok
				tbl.addCell(Formatter.format(bean_pro.getNOM_PRO_SAN()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));// ok
				tbl.addCell(Formatter.format(bean_pro.getDES_PRO_SAN()));

				m_document.add(tbl);
			}
			{//Visite Mediche
				writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Elenco.visite.mediche"));
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {70,15,10};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nominativo"));
				tbl.toCenter();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Periodicità"));
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Mesi"));
				
				Iterator it=home_pro.getVisiteMedicheByPROSANID_View(lCOD_AZL, lCOD_PRO_SAN).iterator();
				while(it.hasNext()){
					VisiteMedicheByPROSANID_View w=(VisiteMedicheByPROSANID_View)it.next();
					tbl.toLeft();
					tbl.addCell(Formatter.format(w.NOM_VST_MED));
					tbl.toCenter();
					String strFAT_PER="-";
					if (w.FAT_PER.equals("S")) 
						strFAT_PER = ApplicationConfigurator.LanguageManager.getString("Si");
					else if (w.FAT_PER.equals("N"))
						strFAT_PER = ApplicationConfigurator.LanguageManager.getString("No");
					else 
						strFAT_PER = "-";	
					tbl.addCell(Formatter.format(strFAT_PER));
					tbl.addCell(Formatter.format(w.PER_VST));
				}
				m_document.add(tbl);
			}
			{//Protocoli sanitari
				writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Elenco.visite.d'idoneità"));
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {70,15,10};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nominativo"));
				tbl.toCenter();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Periodicità"));
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Mesi"));
				
				Iterator it=home_pro.getVisiteIdoneiteByPROSANID_View(lCOD_AZL, lCOD_PRO_SAN).iterator();
				while(it.hasNext()){
					VisiteIdoneiteByPROSANID_View w=(VisiteIdoneiteByPROSANID_View)it.next();
					tbl.toLeft();
					tbl.addCell(Formatter.format(w.NOM_VST_IDO));
					tbl.toCenter();
					String strFAT_PER="-";
					if (w.FAT_PER.equals("S")) 
						strFAT_PER = ApplicationConfigurator.LanguageManager.getString("Si");
					else if (w.FAT_PER.equals("N"))
						strFAT_PER = ApplicationConfigurator.LanguageManager.getString("No");
					else 
						strFAT_PER = "-";	
					tbl.addCell(Formatter.format(strFAT_PER));
					tbl.addCell(Formatter.format(w.PER_VST));
				}
				m_document.add(tbl);
			}
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();
		
long lCOD_PRO_SAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Protocollo"), request.getParameter("ID"), true);


if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();
Report_REP_PRO_SAN report = new Report_REP_PRO_SAN(lCOD_PRO_SAN);

report.doReport(request, response);
%>
