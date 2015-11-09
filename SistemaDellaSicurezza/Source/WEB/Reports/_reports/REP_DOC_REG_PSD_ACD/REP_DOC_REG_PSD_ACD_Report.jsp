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

<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>
<%@ page import="com.apconsulting.luna.ejb.CategoriePreside.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_DOC_REG_PSD_ACD extends Report{
	public long lCOD_AZL=0;
	public long lCOD_CAG_PSD_ACD=0;

	
	public Report_DOC_REG_PSD_ACD(long lCOD_CAG_PSD_ACD){
		this.lCOD_CAG_PSD_ACD=lCOD_CAG_PSD_ACD;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			Collection col;
			Iterator it;
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			ICategoriePresideHome pre_home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean"); 
			
			//ICategoriePreside pre = pre_home.findByPrimaryKey(new Long(lCOD_PSD_ACD));			
			
			String strTmp = "";
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("REGISTRO.ANTINCENDIO"), bean.getRAG_SCL_AZL(), strTmp);
                        AddImage();
                        {
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("DOCUMENTO.DI.REGISTRO.ANTINCENDIO"));
				m_document.add(tbl);
			}
			writeIndent();
			{// ctegoria presidio
				CenterMiddleTable tbl;
				col = pre_home.getCategoriePresidiView(lCOD_CAG_PSD_ACD);
				it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						tbl=new CenterMiddleTable(2);
						tbl.toLeft();
						tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("CATEGORIA.PRESIDIO"),2);
						int width[] = {28,72};
						tbl.setWidths(width);
						CategoriePresidiView w = (CategoriePresidiView)it.next();
						tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nominat."));// ok
						tbl.addCell(Formatter.format(w.strNOM_CAG_PSD_ACD));
						tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descr."));// ok
						tbl.addCell(Formatter.format(w.strDES_CAG_PSD_ACD));
						tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Freq.Sostituzione(mesi)"));// ok
						tbl.addCell(Formatter.format(w.lPER_MES_SST));
						tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Freq.Manutenzione(mesi)"));// ok
						tbl.addCell(Formatter.format(w.lPER_MES_MNT));
						tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"));// ok
						tbl.addCell(Formatter.format(w.strNOM_LUO_FSC));
						tbl.addCellB("",1,2);
						m_document.add(tbl);
						//---dati presidio
						Collection c_pr = pre_home.getPresidiByCategoriaView(lCOD_CAG_PSD_ACD, w.lCOD_PSD_ACD);
						writeParagraph1(ApplicationConfigurator.LanguageManager.getString("DATI.SCHEDE.D'INTERVENTO"));
						CenterMiddleTable tbl_1=new CenterMiddleTable(3);
						int width2[] = {17,18,55};
						tbl_1.setWidths(width2);
						tbl_1.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Identificativo"));
						tbl_1.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ult.controllo"));
						tbl_1.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esito"));
						Iterator it2 = c_pr.iterator();
						if (it2!=null){
							while (it2.hasNext()){
								PresidiByCategoriaView w2 = (PresidiByCategoriaView)it2.next();
								tbl_1.addCell(Formatter.format(w2.strIDE_PSD_ACD));
								tbl_1.addCell(Formatter.format(w2.dtDAT_ULT_CTL));
								tbl_1.addCell(Formatter.format(w2.strESI_ULT_CTL));
							}
						}	
						m_document.add(tbl_1);
						writeParagraph1(ApplicationConfigurator.LanguageManager.getString("DATI.PRESIDI"));
						CenterMiddleTable tbl_2=new CenterMiddleTable(4);
						int width3[] = {20,20,40,20};
						tbl_2.setWidths(width3);
						tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Pianificata"));
						tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Effettuata"));
						tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
						tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esito"));
						Collection c_int = pre_home.getInterventoByPresidiView( w.lCOD_PSD_ACD);
						it2 = c_int.iterator();
						if (it2!=null){
							while (it2.hasNext()){
								InterventoByPresidiView w3 = (InterventoByPresidiView)it2.next();
								tbl_2.addCell(Formatter.format(w3.dtDAT_PIF_INR));
								tbl_2.addCell(Formatter.format(w3.dtDAT_INR));
								tbl_2.addCell(Formatter.format(w3.strNOM_RSP_INR));
								tbl_2.addCell(Formatter.format(w3.strESI_INR));
							}
						}	
						m_document.add(tbl_2);
						writeIndent();
					}	
				}	
				//tbl.addTitleCell(strTmp);
				
				 
				
			}
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();

long lCOD_CAG_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria.presidio.antincendio"), request.getParameter("ID"), true);		

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_DOC_REG_PSD_ACD report = new Report_DOC_REG_PSD_ACD(lCOD_CAG_PSD_ACD);
report.doReport(request, response);
%>
