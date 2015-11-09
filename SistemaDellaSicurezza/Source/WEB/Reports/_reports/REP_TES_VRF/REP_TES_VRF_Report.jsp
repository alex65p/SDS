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
    <version number="1.0" date="09/03/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="09/03/2004" author="Roman Chumachenko">
				   <description>REP_TES_VRF_Report.jsp</description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../../../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>

<%
class Report_REP_TES_VRF extends Report{
	public long lCOD_AZL=0;
	public long lCOD_TES_VRF=0;
	//---------------------------------------
	public Report_REP_TES_VRF(long lCOD_TES_VRF){
		this.lCOD_TES_VRF=lCOD_TES_VRF;
	}
	//------------------------------------------------------------------------------------------
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			lCOD_AZL = Security.getAziendaR();
			IAziendaHome  azienda_home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda azienda=azienda_home.findByPrimaryKey(new Long(lCOD_AZL));
			//
			ITestVerificaHome  tes_home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
			ITestVerifica tes=tes_home.findByPrimaryKey(new Long(lCOD_TES_VRF));
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("TEST.DI.VERIFICA"), azienda.getRAG_SCL_AZL(), null);
                        AddImage();
                        writeIndent();
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
				tbl.addCell(azienda.getRAG_SCL_AZL());
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("TEST.DI.VERIFICA"));
				tbl.addCell(tes.getNOM_TES_VRF());
				m_document.add(tbl);
			 }
			 //
			
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_CENTER);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore"));
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				String lav_str=" " +
                                        ApplicationConfigurator.LanguageManager.getString("Lavoratore") +
                                        ": ________________________________________\n";
				lav_str+=" " +
                                        ApplicationConfigurator.LanguageManager.getString("Matricola") +
                                        ": _________________________________________\n\n";
				lav_str+="      __ " +
                                        ApplicationConfigurator.LanguageManager.getString("Test.entrata") +
                                        "            __ " +
                                        ApplicationConfigurator.LanguageManager.getString("Test.uscita") +
                                        " \n ";
				tbl.addCell( lav_str );
				m_document.add(tbl);
			}
			//Domande e Risposte
			
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				//---------------------------
				
				int i=1;
				java.util.Iterator it=tes.getTestDomandi_List_View().iterator();
				while(it.hasNext())
				{
					TES_TestDR_List_View dmd=(TES_TestDR_List_View)it.next();
					writeText2(i + "." + dmd.NOM_DMD + "\n");
					//------------------------------------------------------
					java.util.Iterator it_rst=tes.getTestDomandeRisposti_List_View(dmd.COD_DMD).iterator();
					while(it_rst.hasNext())
					{
						TES_TestDR_List_View rst=(TES_TestDR_List_View)it_rst.next();
						writeText2("  __ " + rst.NOM_RST + "\n");
					}
					//------------------------------------------------------
					i++;
				}
				//---------------------------
				m_document.add(tbl);
			}
			//
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.setDefaultHorizontalAlignment(Element.ALIGN_LEFT);
				String lav_str=" " +
                                        ApplicationConfigurator.LanguageManager.getString("Docente") +
                                        ": _______________________________________________\n";
				lav_str+=" " +
                                        ApplicationConfigurator.LanguageManager.getString("Domande.corrette") +
                                        ": __________  " +
                                        ApplicationConfigurator.LanguageManager.getString("Totale.domande") +
                                        ": " + Formatter.format(tes.getTotaleDomande()) + "\n";
				lav_str+=" " +
                                        ApplicationConfigurator.LanguageManager.getString("Punteggio") +
                                        ":___________________ " +
                                        ApplicationConfigurator.LanguageManager.getString("Esito.del.test") +
                                        ":________________________\n \n";
				lav_str+="                                                                                           Firma\n ";
				lav_str+="                                                                           ___________________________\n  ";
				tbl.addCell( lav_str );
				m_document.add(tbl);
			}
			closeDocument();
	}
}
//==========================================================
Checker c = new Checker();
long lCOD_TES_VRF = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Test.di.verifica.ID"), request.getParameter("ID"), true);
if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}
out.clearBuffer();
Report_REP_TES_VRF report = new Report_REP_TES_VRF(lCOD_TES_VRF);
report.doReport(request, response);
%>
