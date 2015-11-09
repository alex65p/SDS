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
class Report_REP_LUO_FSC extends Report{
	public long lCOD_AZL=0;
	public long lCOD_LUO_FSC=0;
        private boolean IncludeLogo=true;       

	
	public Report_REP_LUO_FSC(long lCOD_LUO_FSC){
		this.lCOD_LUO_FSC=lCOD_LUO_FSC;
	}
        
        public Report_REP_LUO_FSC(long lCOD_LUO_FSC,  boolean _IncludeLogo){
		this(lCOD_LUO_FSC);
                this.IncludeLogo = _IncludeLogo;
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
		
			IAnagrLuoghiFisiciHome home_lf= (IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
			IAnagrLuoghiFisici bean_lf=home_lf.findByPrimaryKey(new Long(lCOD_LUO_FSC));
			lCOD_AZL = bean_lf.getCOD_AZL();
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean_az=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.LUOGO.FISICO"), bean_az.getRAG_SCL_AZL(), bean_lf.getNOM_LUO_FSC());
                        
                        if (IncludeLogo){
                            AddImage();
                        }  		           
                                                
                                                
			//writeTitle(bean_lf.getNOM_LUO_FSC());
			writeIndent();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					if(bStandAlone){
						tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
						tbl.addCell(bean_az.getRAG_SCL_AZL());
					}
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.LUOGO.FISICO"));
					tbl.addTitleCell(bean_lf.getNOM_LUO_FSC());
					
					m_document.add(tbl);
					writeLine();
			 }
			 {
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.luogo.fisico"));
				tbl.addCell(bean_lf.getDES_LUO_FSC());
				
				m_document.add(tbl);
			}
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.del.luogo.fisico"), 2);
				
				tbl.setDefaultColspan(1);
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Nome/Cognome/Qualifica"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("E-mail"));
				tbl.endHeaders();
				tbl.addCell(bean_lf.getNOM_RSP_LUO_FSC() + "/" + bean_lf.getQLF_RSP_LUO_FSC());
				tbl.addCell(bean_lf.getIDZ_PSA_ELT_RSP_LUO_FSC());
				
				m_document.add(tbl);
			}
			{
				ISitaAziendeHome h= (ISitaAziendeHome)PseudoContext.lookup("SitaAziendeBean");
				ISitaAziende b=h.findByPrimaryKey(new Long(bean_lf.getCOD_SIT_AZL()));
				
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Sito.aziendale"));
				tbl.endHeaders();
				tbl.addCell(b.getNOM_SIT_AZL());
				
				m_document.add(tbl);
			}
			{
				CenterMiddleTable t=new CenterMiddleTable(2);
				t.toLeft();
				t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lista.dei.rischi.associati"), 2);
				
				t.setDefaultColspan(1);
				t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Rischio"));
				t.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				t.endHeaders();
				
				Iterator it= bean_lf.getReportAnagrLuoghiFisici_Rischi_View().iterator();
				while(it.hasNext()){
					ReportAnagrLuoghiFisici_Rischi_View w = (ReportAnagrLuoghiFisici_Rischi_View)it.next();
					t.addCell(w.strNOM_RSO);
					t.addCell(w.strDES_RSO);
				}
				
				m_document.add(t);
			}
			closeDocument();	
	}
}
//==========================================================
%>
