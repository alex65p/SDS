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

<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedeInterventoDPI.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_SCH_INR_DPI extends Report{
	public long lCOD_AZL=0;
	public long lCOD_SCH_INR_DPI;
	
	public Report_REP_SCH_INR_DPI(long lCOD_AZL, long lCOD_SCH_INR_DPI){
		this.lCOD_AZL=lCOD_AZL;
		this.lCOD_SCH_INR_DPI=lCOD_SCH_INR_DPI;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			String strTemp="";
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			ISchedeInterventoDPIHome  h=(ISchedeInterventoDPIHome)PseudoContext.lookup("SchedeInterventoDPIBean");

			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.D'INTERVENTO.D.P.I."), bean.getRAG_SCL_AZL(), null);
                        AddImage();
                        
                        writeIndent();
			{ 
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.D'INTERVENTO.D.P.I."));
					
				m_document.add(tbl);
			}
			    CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.intervento"), 2);
				tbl.toLeft();
				ReportSchedeInterventoDPIView w= h.getReportSchedeInterventoDPIView(lCOD_SCH_INR_DPI);
				if(w!=null){
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Tipologia"));
					tbl.addCell(Formatter.format(w.strNOM_TPL_DPI));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Ident.Lotto"));
					tbl.addCell(Formatter.format(w.strIDE_LOT_DPI));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Attività"));
					tbl.addCell(Formatter.format(w.strATI_INR));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Data"));
					tbl.addCell(Formatter.format(w.dtDAT_INR));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Esito"));
					tbl.addCell(Formatter.format(w.strESI_INR));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Prob.Riscontrati"));
					tbl.addCell(Formatter.format(w.strPBM_RSC));
				}
				m_document.add(tbl);
			
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();
		
long lCOD_AZL=Security.getAziendaR();

long lCOD_SCH_INR_DPI=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Intervento.D.P.I."), request.getParameter("ID"), true);

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

//external boolean bFraseS=true;
Report_REP_SCH_INR_DPI report = new Report_REP_SCH_INR_DPI(lCOD_AZL, lCOD_SCH_INR_DPI);

report.doReport(request, response);
%>
