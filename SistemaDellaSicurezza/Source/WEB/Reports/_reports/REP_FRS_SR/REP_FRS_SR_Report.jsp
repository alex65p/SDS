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

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/ejb/FraseS/FraseSBean_Interfaces.jsp" %>
<%@ include file="../../../src/com/apconsulting/luna/ejb/FraseS/FraseSBean.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/ejb/FraseR/FraseRBean_Interfaces.jsp" %>
<%@ include file="../../../src/com/apconsulting/luna/ejb/FraseR/FraseRBean.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>

<%@ include file="../Report.jsp"%>


<%
class Report_REP_FRS_S extends Report{
	public long lCOD_AZL=0;
	boolean bFraseS=true;
	
	public Report_REP_FRS_S(long lCOD_AZL){
		this.lCOD_AZL=lCOD_AZL;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			String strTemp="";
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			strTemp= bFraseS?"S":"R";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scheda.frase") + " '" + strTemp + "'", bean.getRAG_SCL_AZL(), null);
                        AddImage();
                        writeIndent();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Scheda.frase") + " '" + strTemp + "'");

				m_document.add(tbl);
			}
			
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {15,85};
				tbl.setWidths(width);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Frase") + " '" + strTemp + "'");
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.toLeft();
				if(bFraseS){
					IFraseSHome h=(IFraseSHome)PseudoContext.lookup("FraseSBean");
					Iterator it=h.getFraseS_View().iterator();
					while(it.hasNext()){
						FraseS_View w=(FraseS_View)it.next();
						tbl.addCell(Formatter.format(w.strNUM_FRS_S));
						tbl.addCell(Formatter.format(w.strDES_FRS_S));
					}
				}else{
					IFraseRHome h=(IFraseRHome)PseudoContext.lookup("FraseRBean");
					Iterator it=h.getFraseR_View().iterator();
					while(it.hasNext()){
						FraseR_View w=(FraseR_View)it.next();
						tbl.addCell(Formatter.format(w.strNUM_FRS_R));
						tbl.addCell(Formatter.format(w.strDES_FRS_R));
					}
				}
				m_document.add(tbl);
			
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();
		
long lCOD_AZL=Security.getAziendaR();


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
Report_REP_FRS_S report = new Report_REP_FRS_S(lCOD_AZL);
report.bFraseS=bFraseS;

report.doReport(request, response);
%>
