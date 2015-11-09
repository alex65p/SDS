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
    <version number="1.0" date="05/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="05/03/2004" author="Roman Chumachenko">
				   <description>REP_PNG_GRD_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_PNG_GRD extends Report{
	public long lCOD_AZL=0;
	public long lCOD_DOC=0;
	//---------------------------------------
	public Report_REP_PNG_GRD(long lCOD_DOC){
		this.lCOD_DOC=lCOD_DOC;
	}
	//------------------------------------------------------------------------------------------
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			lCOD_AZL = Security.getAziendaR();
			IAziendaHome  azienda_home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda azienda=azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
			//
			IAnagrDocumentoHome  document_home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
			IAnagrDocumento document=document_home.findByPrimaryKey(new Long(lCOD_DOC));
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("PAGINA.DI.GUARDIA"), azienda.getRAG_SCL_AZL(), null);
                        AddImage();
                        writeIndent();
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
				tbl.addCell(azienda.getRAG_SCL_AZL());
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("PAGINA.DI.GUARDIA"));
				tbl.addCell(document.getTIT_DOC());
				m_document.add(tbl);
			 }
			 //
			 writeParagraph1(ApplicationConfigurator.LanguageManager.getString("REGISTRO.DELLE.REVISIONI"));
 			 {
				CenterMiddleTable tbl=new CenterMiddleTable(5);
				tbl.toLeft();
				int width[] = {10,10,20,35,35};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ed."));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rev."));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rif.Parag."));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rif.Parag."));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rif.Pagine"));
				tbl.addCell( Formatter.format(document.getEDI_DOC()) );
				tbl.addCell( Formatter.format(document.getREV_DOC()) );
				tbl.addCell( Formatter.format(document.getDAT_REV_DOC()) );
				tbl.addCell( Formatter.format(document.getPRG_RIF_DOC()) );
				tbl.addCell( Formatter.format(document.getPGN_RIF_DOC()) );
				m_document.add(tbl);	
			 }
			 //
			 {
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Motivo.revisione"));
				tbl.addCell( Formatter.format(document.getDES_REV_DOC()) );
				m_document.add(tbl);	
			  }
			  //
			  {
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				int width[] = {25,25,25};
				tbl.setWidths(width);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				if (ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)){
                                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Redattore"));
                                } else {
                                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
                                }
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Emissione"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Approvazione"));
				tbl.addCell( Formatter.format(document.getRSP_DOC()) );
				tbl.addCell( Formatter.format(document.getEMS_DOC()) );
				tbl.addCell( Formatter.format(document.getAPV_DOC()) );
				m_document.add(tbl);
			  }
			  //
			  writeParagraph1(ApplicationConfigurator.LanguageManager.getString("LISTA.DI.DISTRIBUZIONE"));
			  {
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Destinatari"));
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				java.util.Iterator it=document.getDocDestinatari_List_View().iterator();
				String dest;
				while(it.hasNext())
				{	
				DOC_Destinatari_View w=(DOC_Destinatari_View)it.next();
					dest="";
					dest+=Formatter.format(w.DESTINATARI_A)+" ";
					dest+=Formatter.format(w.DESTINATARI_B)+" ";
					dest+=Formatter.format(w.DESTINATARI_C)+" ";
					dest+=Formatter.format(w.DESTINATARI_D)+" ";
					dest+=Formatter.format(w.DESTINATARI_E)+" ";
					dest+="\n" + ApplicationConfigurator.LanguageManager.getString("Data.consegna") + ": " + Formatter.format(w.DAT_CONSEGNA)+ "   ";
					dest+=ApplicationConfigurator.LanguageManager.getString("Firma");
					
					tbl.addCell( dest );
					
				}
				m_document.add(tbl);	
			  }
			  //
			  writeText2(ApplicationConfigurator.LanguageManager.getString("NON.ESISTONO.DESTINATARI"));
			  {
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"), 2);
			    tbl.endHeaders();
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				IAnagrLuoghiFisiciHome  luo_home=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
				java.util.Iterator it=luo_home.getAnagrLuoghiFisici_List_View(this.lCOD_AZL).iterator();
				while(it.hasNext())
				{	
					AnagrLuoghiFisici_List_View w=(AnagrLuoghiFisici_List_View)it.next();
					tbl.addCell(w.NOM_LUO_FSC);
					tbl.addCell(w.DES_LUO_FSC);
				}
				m_document.add(tbl);	
			  }
			closeDocument();
	}
}
//==========================================================
Checker c = new Checker();
long lCOD_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Documentazione.ID"), request.getParameter("ID"), true);
if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}
out.clearBuffer();
Report_REP_PNG_GRD report = new Report_REP_PNG_GRD(lCOD_DOC);
report.doReport(request, response);
%>
