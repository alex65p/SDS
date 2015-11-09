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
class Report_SCH_PSD_ACD extends Report{
	public long lCOD_AZL=0;
	public long lCOD_PSD_ACD=0;

	
	public Report_SCH_PSD_ACD(long lCOD_PSD_ACD){
		this.lCOD_PSD_ACD=lCOD_PSD_ACD;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			IPresidiHome pre_home=(IPresidiHome)PseudoContext.lookup("PresidiBean");
			ICategoriePresideHome cat_pre_home=(ICategoriePresideHome)PseudoContext.lookup("CategoriePresideBean"); 
			
			String strTmp = "";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.DI.VERIFICA"), bean.getRAG_SCL_AZL(), strTmp);
                        AddImage();
                                
                                {

				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.DI.VERIFICA"));
				m_document.add(tbl);
			}
			writeIndent();
			{// dipendente
				PresidioView w = pre_home.getPresidio(lCOD_PSD_ACD);
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toCenter();
				int width[] = {22,78};
				tbl.setWidths(width);
				
				tbl.toLeft();	
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.presidio.antincendio"),2);
				tbl.toLeft();	
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Categoria"));// ok
				tbl.addCell(Formatter.format(w.strNOM_CAG_PSD_ACD));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Identificativo"));// ok
				tbl.addCell(Formatter.format(w.strIDE_PSD_ACD));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Dt.Ult.Controllo"));// ok
				tbl.addCell(Formatter.format(w.dtDAT_ULT_CTL));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Esi.Ult.Controllo"));// ok
				tbl.addCell(Formatter.format(w.strESI_ULT_CTL));
				m_document.add(tbl);
			}
			{
				writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Dati.schede.d'intervento"));
				CenterMiddleTable tbl_2=new CenterMiddleTable(4);
				int width3[] = {20,20,40,20};
				tbl_2.setWidths(width3);
				tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Pianificata"));
				tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Effettuata"));
				tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl_2.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Esito"));
				Collection c_int = cat_pre_home.getInterventoByPresidiView(lCOD_PSD_ACD);
				Iterator it2 = c_int.iterator();
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
			}
			/*{//schede d'intervento
				
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB("Dati Infortunio / Incidenti ",2);
					tbl.addCell("Luogo Fisico");
					tbl.addCell(Formatter.format(ino.strNOM_LUO_FSC));
					tbl.addCell("Tipo Infortunio");
					tbl.addCell(Formatter.format(ino.strNOM_TPL_FRM_INO));
					tbl.addCell("Agente Materiale");
					tbl.addCell(Formatter.format(ino.strNOM_AGE_MAT));
					tbl.addCell("Sede Lesione");
					tbl.addCell(Formatter.format(ino.strNOM_SED_LES));
					tbl.addCell("Natura Lesione");
					tbl.addCell(Formatter.format(ino.strNOM_NAT_LES));
				m_document.add(tbl);
			}
			{//testimoni
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				
				tbl.toLeft();
					tbl.addHeaderCellB("Elenco Testimoni ");
				Iterator it = tst.iterator();
				if (it!=null){
					while (it.hasNext()){
						Testimone_View w = (Testimone_View)it.next();
						//tbl.addCell("Nome:");
						tbl.addCell(Formatter.format(w.strNOM_TST_EVE));
					}	
				}	
			  m_document.add(tbl);	
			}*/
			
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();

long lCOD_PSD_ACD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Infortunio"), request.getParameter("ID"), true);		

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_SCH_PSD_ACD report = new Report_SCH_PSD_ACD(lCOD_PSD_ACD);
report.doReport(request, response);
%>
