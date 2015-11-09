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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.RischioFattore.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_LST_RSO extends Report{
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			IRischioFattoreHome home_fat_rso= (IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
			
			IRischioHome home_rso = (IRischioHome)PseudoContext.lookup("RischioBean");
			String strTmp = "";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("RISCHI.NEL.REPOSITORY"), null, strTmp);
                        AddImage();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("ELENCO.RISCHI.PRESENTI.NEL.REPOSITORY"));
				m_document.add(tbl);
			}
			writeIndent();
			{// fattori di rischio
				Collection col = home_fat_rso.getFattoreRischio_View();
				Iterator it = col.iterator();
				if (it!=null){
					while(it.hasNext()){
						FattoreRischio_View w = (FattoreRischio_View)it.next();
						writeParagraph1(w.NOM_FAT_RSO);
						Collection col2 = home_rso.getRischiRepositoryView(w.COD_FAT_RSO);
						Iterator it2=col2.iterator();
						if(it2!=null){
			  // rischi
							while(it2.hasNext()){
								Rischio_ComboBox w2=(Rischio_ComboBox)it2.next();
								{
									CenterMiddleTable tbl=new CenterMiddleTable(4);
									tbl.toCenter();
									tbl.setAlignment("right");
									int width[] = {40,20,20,20};
									tbl.setWidth(90);
									tbl.setWidths(width);
									tbl.toLeft();
									tbl.addCell("");
									tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Probabilità"));
									tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Danno"));
									tbl.addHeaderCellI(ApplicationConfigurator.LanguageManager.getString("Rischio.(PxD)"));
									tbl.addCell(Formatter.format(w2.strNOM_RSO));
									tbl.addCell(Formatter.format(w2.lPRB_EVE_LES));
									tbl.addCell(Formatter.format(w2.lENT_DAN));
									tbl.addCell(Formatter.format(w2.lSTM_NUM_RSO));
									tbl.addCell(Formatter.format(w2.strDES_RSO), 1, 4);
									m_document.add(tbl);
								}
								
							}
						}
					}
				}
			}
			closeDocument();
		}
}
//==========================================================

Checker c = new Checker();

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_LST_RSO report = new Report_LST_RSO();
report.doReport(request, response);
%>
