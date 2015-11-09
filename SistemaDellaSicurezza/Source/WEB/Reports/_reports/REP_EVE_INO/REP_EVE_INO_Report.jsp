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
<%@ page import="com.apconsulting.luna.ejb.InfortuniIncidenti.*" %>
<%@ page import="com.apconsulting.luna.ejb.Testimone.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_EVE_INO extends Report{
	public long lCOD_AZL=0;
	public java.sql.Date dtDAT_DAL = null; 
	public java.sql.Date dtDAT_AL = null;
	
	public Report_EVE_INO(java.sql.Date dtDAT_DAL, java.sql.Date dtDAT_AL){
		this.dtDAT_DAL =  dtDAT_DAL;
		this.dtDAT_AL = dtDAT_AL;
	}

	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			String strDAT_DAL = Security.Replace(dtDAT_DAL.toString(), "-", "");
			String strDAT_AL = Security.Replace(dtDAT_AL.toString(), "-", "");			
			
			IInfortuniIncidentiHome home_ino=(IInfortuniIncidentiHome)PseudoContext.lookup("InfortuniIncidentiBean");
			Collection col = home_ino.getElencoInfortuniIncidentiView(lCOD_AZL, strDAT_DAL, strDAT_AL);
			//SchedaInfortunioIncidenteView ino = home_ino.getSchedaInfortunioIncidenteView(lCOD_AZL, lCOD_INO);
		
			//IDipendenteHome home_dpd=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			//DipendenteFunzioneView dpd=home_dpd.getDipendenteFunzioneView(ino.lCOD_DPD);
			
			//ITestimoneHome home_tst = (ITestimoneHome)PseudoContext.lookup("TestimoneBean");
			//Collection tst = home_tst.getTestimone_View(lCOD_INO);
			
			String strTmp = "";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("INFORTUNI/INCIDENTI"), bean.getRAG_SCL_AZL(), strTmp);
                	
                        AddImage();                        
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("ELENCO.INFORTUNI/INCIDENTI"));
				m_document.add(tbl);
			}
			writeIndent();
			
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);					
					int width[] = {10,90};
					tbl.setWidths(width);
					tbl.toLeft();	
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Intervallo.temporale"),2);
					
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Dal"));
					tbl.addCell(Formatter.format(dtDAT_DAL));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Al"));
					tbl.addCell(Formatter.format(dtDAT_AL));
				m_document.add(tbl);
			}
			writeIndent();
			
			{//elenco
				/*
                                CenterMiddleTable tbl=new CenterMiddleTable(4);
				int width[] = {20,30,20,30};
                                */
                                CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {30,40,30};
                                tbl.setWidths(width);
				tbl.toCenter();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sede.lesione"));
					// tbl.addHeaderCellB("Natura Lesione");
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.lesione"));
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"));
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						SchedaInfortunioIncidenteView w = (SchedaInfortunioIncidenteView)it.next();
						tbl.addCell(Formatter.format(w.strNOM_SED_LES));
						// tbl.addCell(Formatter.format(w.strNOM_NAT_LES));
						tbl.addCell(Formatter.format(w. dtDAT_EVE_INO));
						tbl.addCell(Formatter.format(w.strNOM_LUO_FSC));
					}	
				}	
			  m_document.add(tbl);	
			}
			{//total
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {35,65};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Totale.incidenti/infortuni"));
					tbl.addCell("  "+Formatter.format(col.size()));
				m_document.add(tbl);
			}
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();

java.sql.Date  dtDAT_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("data.dal"), request.getParameter("DAT_DAL"), true);		
java.sql.Date  dtDAT_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("data.al"), request.getParameter("DAT_AL"), true);		

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_EVE_INO report = new Report_EVE_INO(dtDAT_DAL, dtDAT_AL);
String strDAT_DAL = Security.Replace(dtDAT_DAL.toString(), "-", "");
String strDAT_AL = Security.Replace(dtDAT_AL.toString(), "-", "");	

report.doReport(request, response);
%>
