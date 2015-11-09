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
    <version number="1.0" date="08/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="08/03/2004" author="Roman Chumachenko">
				   <description>REP_INV_COR_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>


<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_INV_COR extends Report{
	public long lCOD_AZL=0;
	public long lCOD_SCH_EGZ_COR=0;
	public long lCOD_DPD=0;
	//---------------------------------------
	public Report_REP_INV_COR(long lCOD_SCH_EGZ_COR, long lCOD_DPD){
		this.lCOD_SCH_EGZ_COR=lCOD_SCH_EGZ_COR;
		this.lCOD_DPD=lCOD_DPD;
	}
	//------------------------------------------------------------------------------------------
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			lCOD_AZL = Security.getAziendaR();
			IAziendaHome  azienda_home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda azienda=azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
			//
			IErogazioneCorsiHome  erc_home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
			IErogazioneCorsi erc=erc_home.findByPrimaryKey(new Long(lCOD_SCH_EGZ_COR));
			java.util.Iterator it_erc=erc.getErogazioneForCorso_View().iterator();
			ErogazioneForCorso_View erc_view=(ErogazioneForCorso_View)it_erc.next();
			//----------------------------------------------------------------------
			IDipendenteHome dpd_home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			IDipendente dipendente=dpd_home.findByPrimaryKey(new Long(lCOD_DPD));

			//--------------------------------------------------------
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Invito.al.corso"), azienda.getRAG_SCL_AZL(), null);
                        AddImage();
                        writeIndent();
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
				tbl.addCell(azienda.getRAG_SCL_AZL());
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Invito.al.corso"));
				m_document.add(tbl);
			 }
			 //
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {25,75};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Destinatario.dell'invito"),2);
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nome/Cognome"));
				tbl.addCell( dipendente.getCOG_DPD() + "  " + dipendente.getNOM_DPD() );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Matricola"));
				tbl.addCell( Formatter.format(dipendente.getMTR_DPD() ) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Indirizzo"));
				tbl.addCell( dipendente.getIDZ_DPD() + ", " + dipendente.getNUM_CIC_DPD() );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("C.A.P."));
				tbl.addCell( Formatter.format(dipendente.getCAP_DPD() ) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Città"));
				tbl.addCell( Formatter.format(dipendente.getCIT_DPD() ) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Provincia"));
				tbl.addCell( Formatter.format(dipendente.getPRV_DPD() ) );

				m_document.add(tbl);
			 }
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {25,75};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Informazioni.sul.corso/Erogazione"),2);
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Corso"));
				tbl.addCell( Formatter.format(erc_view.NOM_COR) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Durata"));
				tbl.addCell( Formatter.format(erc_view.DUR_COR) + " " + ApplicationConfigurator.LanguageManager.getString("ore"));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.addCell( Formatter.format(erc_view.DES_COR) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Uso.punteggio"));
				tbl.addCell( Formatter.format(erc_view.USO_PTG_COR) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Attestato.di.frequenza"));
				tbl.addCell( Formatter.format(erc_view.USO_ATE_FRE_COR) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Data.pianificata"));
				tbl.addCell( Formatter.format(erc_view.DAT_PIF_EGZ_COR) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Data.effettiva"));
				tbl.addCell( Formatter.format(erc_view.DAT_EFT_EGZ_COR) );

				m_document.add(tbl);
			 }
			writeIndent();
			writeText2(ApplicationConfigurator.LanguageManager.getString("Data.di.consegna") +
                                ":___________________                          " +
                                ApplicationConfigurator.LanguageManager.getString("Per.ricevuta")+
                                ":___________________");
			
			
			
			
			//----------------------
			closeDocument();
	}
}
//==========================================================
Checker c = new Checker();
long lCOD_SCH_EGZ_COR=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Corso.ID"), request.getParameter("ID"), true);
long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Corso.ID"), request.getParameter("COD_DPD"), true);

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}
out.clearBuffer();
Report_REP_INV_COR report = new Report_REP_INV_COR(lCOD_SCH_EGZ_COR, lCOD_DPD);
report.doReport(request, response);
%>
