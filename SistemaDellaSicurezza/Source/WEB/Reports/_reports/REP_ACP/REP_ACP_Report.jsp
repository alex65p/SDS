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
				   <description>REP_ACP_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.AzioniCorrectivePreventive.*" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_ACP extends Report{
	public long lCOD_AZL=0;
	public long lCOD_AZN_CRR_PET=0;
	
	//---------------------------------------
	public Report_REP_ACP(long lCOD_AZN_CRR_PET){
		this.lCOD_AZN_CRR_PET=lCOD_AZN_CRR_PET;
	}
	//------------------------------------------------------------------------------------------
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			lCOD_AZL = Security.getAziendaR();
			IAziendaHome  azienda_home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda azienda=azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
			//
			IAzioniCorrectivePreventiveHome  tes_home=(IAzioniCorrectivePreventiveHome)PseudoContext.lookup("AzioniCorrectivePreventiveBean");
			IAzioniCorrectivePreventive bean=tes_home.findByPrimaryKey(new Long(lCOD_AZN_CRR_PET));
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Richiesta.di.azione") +
                                "\n" + ApplicationConfigurator.LanguageManager.getString("correttiva/preventiva-RACP"), azienda.getRAG_SCL_AZL(), null);
             
                        AddImage();                        
			writeIndent();
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
				tbl.addCell(azienda.getRAG_SCL_AZL());
				m_document.add(tbl);
			}
			
			// Richiesta
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Richiesta"), 2);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.addCell(Formatter.format(bean.getDES_AZN_RCH()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Richiesta.di"));
				//
				String str=ApplicationConfigurator.LanguageManager.getString("AZIONE.CORRETTIVA.(RAC)");
				if( bean.getRCH_AZN_CRR_PET().equals("P") )
					str=ApplicationConfigurator.LanguageManager.getString("AZIONE.PREVENTIVA.(RAP)");
				tbl.addCell(str);
				//
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Doc.Allegati"));
				String docs="";
				java.util.Iterator it=bean.getDocumenti_List_View().iterator();
					while(it.hasNext())
					{
						AZN_Documenti_List_View doc=(AZN_Documenti_List_View)it.next();
						docs+=doc.COD_DOC+",";
					}
				if(docs.length()>2)
					docs=docs.substring(0,docs.length()-1);
				tbl.addCell(docs);
				//
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Data"));
				tbl.addCell( Formatter.format( bean.getDAT_RCH() ) );
				m_document.add(tbl);
			}
			writeText2(ApplicationConfigurator.LanguageManager.getString("Firma") +
                                ": ....................................................");
			writeIndent();
			// Attivazione
			{	
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {25,75};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Attivazione"),2);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("La.richiesta.è"));
				String str=ApplicationConfigurator.LanguageManager.getString("ATTIVATA.CON.URGENZA");
				if(bean.getTPL_ATT().equals("R"))
					str=ApplicationConfigurator.LanguageManager.getString("RIMANDATA");
				if(bean.getTPL_ATT().equals("E"))
					str=ApplicationConfigurator.LanguageManager.getString("RESPINTA");
				tbl.addCell( str );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Motivazione"));
				tbl.addCell( Formatter.format( bean.getTPL_ATT() ) );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Descrizione.generale"));
				tbl.addCell( Formatter.format( bean.getDES_AZN_CRR_PET() ) );
				m_document.add(tbl);
			}
			// Verifica Efficacia Finale
			{	
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {25,75};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Verifica.efficacia.finale"),2);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("L'azione.è"));
				String str=ApplicationConfigurator.LanguageManager.getString("CONCLUSA.EFFICACEMENTE");
				if(bean.getTPL_AZN().equals("N"))
					str=ApplicationConfigurator.LanguageManager.getString("NON.RISOLTA");
				if(bean.getTPL_AZN().equals("S"))
					str=ApplicationConfigurator.LanguageManager.getString("SOSPESA");
				tbl.addCell( str );
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Motivazione"));
				tbl.addCell( Formatter.format( bean.getMTZ_AZN() ) );
				m_document.add(tbl);
			}
			//
			writeText2(ApplicationConfigurator.LanguageManager.getString("Resp.Assicurazione.sicurezza") +
                                ": ......................................................................... " +
                                ApplicationConfigurator.LanguageManager.getString("Data") + " " +
                                Formatter.format( bean.getDAT_AZN() ));
			closeDocument();
	}
}
//==========================================================
Checker c = new Checker();
long lCOD_AZN_CRR_PET = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Richiesta.di.azione.ID"), request.getParameter("ID"), true);
if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}
out.clearBuffer();
Report_REP_ACP report = new Report_REP_ACP(lCOD_AZN_CRR_PET);
report.doReport(request, response);
%>
