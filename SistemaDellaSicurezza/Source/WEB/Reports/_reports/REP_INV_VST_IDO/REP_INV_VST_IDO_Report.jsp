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

<%@ page import="com.apconsulting.luna.ejb.GestioneVisiteIdoneita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="java.text.* " %>


<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_INV_VST_IDO extends Report{
	public long lCOD_CTL_SAN=0;
	public long lCOD_DPD=0;
	public long lCOD_VST_IDO=0;
    public java.sql.Date dtDAT_PIF_VST=null;

	
	public Report_INV_VST_IDO(long lCOD_VST_IDO, long lCOD_DPD, long lCOD_CTL_SAN,java.sql.Date dtDAT_PIF_VST){
		this.lCOD_VST_IDO=lCOD_VST_IDO;
		this.lCOD_DPD=lCOD_DPD;
		this.lCOD_CTL_SAN=lCOD_CTL_SAN;
        this.dtDAT_PIF_VST=dtDAT_PIF_VST;

	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			IGestioneVisiteIdoneitaHome home_ido=(IGestioneVisiteIdoneitaHome)PseudoContext.lookup("GestioneVisiteIdoneitaBean");
			//IProtocoleSanitare bean_pro=home_pro.findByPrimaryKey(new Long(lCOD_PRO_SAN));
			
			IDipendenteHome home_dpd=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			IDipendente		bean_dpd=home_dpd.findByPrimaryKey(new Long(lCOD_DPD));
			
			//String strTmp=bean_pro.getNOM_DPD()+" "+ bean_dpd.getCOG_DPD();
			
            VisitaIdoneitaDipendenteView vis =  home_ido.getVisitaIdoneitaDipendenteView(lCOD_DPD, lCOD_CTL_SAN, lCOD_VST_IDO,dtDAT_PIF_VST);
			String strTmp = "";
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("VISITA.D'IDONEITA'"), bean.getRAG_SCL_AZL(), strTmp);
                        AddImage();
                        {
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("INVITO.ALLA.VISITA.D'IDONEITA'"));
				
				m_document.add(tbl);
			}
			writeIndent();
			{// destinatario
			 	
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toCenter();
				int width[] = {13,87};
				tbl.setWidths(width);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Destinatario.dell'invito"),2);
				tbl.toLeft();	
				//tbl.addTitleCell(strTmp);
				tbl.toLeft();	
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Cognome"));// ok
				tbl.addCell(Formatter.format(bean_dpd.getCOG_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nome"));// ok
				tbl.addCell(Formatter.format(bean_dpd.getNOM_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Matricola"));// ok
				tbl.addCell(Formatter.format(bean_dpd.getMTR_DPD()));
				String indirizzo=bean_dpd.getIDZ_DPD() + ", " + bean_dpd.getNUM_CIC_DPD();
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Indirizzo"));// ok
				tbl.addCell(Formatter.format(indirizzo));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("C.A.P."));// ok
				tbl.addCell(Formatter.format(bean_dpd.getCAP_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Città"));// ok
				tbl.addCell(Formatter.format(bean_dpd.getCIT_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Prov."));// ok
				tbl.addCell(Formatter.format("( " + bean_dpd.getPRV_DPD() + " )"));
				m_document.add(tbl);
			}
			{//visita idoneita
				
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Informazioni.generali.sulla.visita.d'idoneità"),2);
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Medico"));
					tbl.addCell(Formatter.format(vis.NOM_MED_RSP_CTL_SAN));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Dt.Visita"));
					tbl.addCell(Formatter.format(vis.DAT_PIF_VST_IDO));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Visita.d'idoneità") + ":");
					tbl.addCell(Formatter.format(vis.NOM_VST_IDO));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Tip.Accertamento") + ":");
					tbl.addCell(Formatter.format(vis.TPL_ACR_VLU_RSO));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Note") + ":");
					tbl.addCell(Formatter.format(vis.NOT_VST_IDO));
				m_document.add(tbl);
			}
			
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();

SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
java.sql.Date sqlDate =java.sql.Date.valueOf(request.getParameter("dat_pif_vst_ido"));
String toDaySt = formatter.format(sqlDate);

long lCOD_VST_IDO=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Visita"), request.getParameter("ID"), true);		
long lCOD_CTL_SAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Controllo"), request.getParameter("CTL_SAN"), true);
long lCOD_DPD =c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"), request.getParameter("DPD"), true);
java.sql.Date dtDAT_PIF_VST= c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), toDaySt, true);
if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_INV_VST_IDO report = new Report_INV_VST_IDO(lCOD_VST_IDO, lCOD_DPD, lCOD_CTL_SAN,dtDAT_PIF_VST);
report.doReport(request, response);
%>
