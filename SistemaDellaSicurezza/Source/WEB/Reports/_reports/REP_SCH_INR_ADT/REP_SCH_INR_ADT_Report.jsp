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
    <version number="1.0" date="10/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="10/03/2004" author="Roman Chumachenko">
				   <description>REP_SCH_INR_ADT_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_SCH_INR_ADT extends Report{
	public long lCOD_AZL=0;
	public long lCOD_INR_ADT=0;
	
	//---------------------------------------
	public Report_REP_SCH_INR_ADT(long lCOD_INR_ADT){
		this.lCOD_INR_ADT=lCOD_INR_ADT;
	}
	//------------------------------------------------------------------------------------------
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			lCOD_AZL = Security.getAziendaR();
			IAziendaHome  azienda_home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda azienda=azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
			//
			IInterventoAudutHome  home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
			IInterventoAudut bean=home.findByPrimaryKey(new Long(lCOD_INR_ADT));
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.D'INTERVENTO.D'AUDIT"), azienda.getRAG_SCL_AZL(), null);
                        AddImage();
                        writeIndent();
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
				tbl.addCell(azienda.getRAG_SCL_AZL());
				m_document.add(tbl);
			 }
			 //
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {25,75};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.d'intervento.d'audit"),2);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Dt.Pianificata"));
				tbl.addCell(Formatter.format(bean.getDAT_PIF_INR()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Dt.Audit"));
				tbl.addCell(Formatter.format(bean.getDAT_ADT()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("N.Visite.ispettive"));
				tbl.addCell(Formatter.format(bean.getNUM_VIS_ISP()));
				//
				String sec=ApplicationConfigurator.LanguageManager.getString("SI");
				if(bean.getSEC_PNO_YEA().equals("N"))
					sec=ApplicationConfigurator.LanguageManager.getString("NO");
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Secondo.piano.annuale"));
				tbl.addCell(sec);
				//
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Punt.Teorico"));
				tbl.addCell(Formatter.format(bean.getPNG_TEO()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Punt.Rilevato"));
				tbl.addCell(Formatter.format(bean.getPNG_RIL()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Punt.Perc."));
				tbl.addCell(Formatter.format(bean.getPNG_PCT()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.addCell(Formatter.format(bean.getDES_INR_ADT()));
				m_document.add(tbl);
			}
			closeDocument();
	}
}
//==========================================================
Checker c = new Checker();
long lCOD_INR_ADT = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Intervento.audit.ID"), request.getParameter("ID"), true);
if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}
out.clearBuffer();
Report_REP_SCH_INR_ADT report = new Report_REP_SCH_INR_ADT(lCOD_INR_ADT);
report.doReport(request, response);
%>
