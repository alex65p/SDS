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
class Report_REP_MAC_ATT extends Report{
	public long lCOD_AZL=0;
	public long lCOD_MAC=0;
        private boolean IncludeLogo=true;

	
	public Report_REP_MAC_ATT(long lCOD_MAC){
		this.lCOD_MAC=lCOD_MAC;
	}
	
         public Report_REP_MAC_ATT(long lCOD_MAC, boolean _IncludeLogo){
		this(lCOD_MAC);
                this.IncludeLogo = _IncludeLogo;
	}
        
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
		
			IMacchinaHome home= (IMacchinaHome)PseudoContext.lookup("MacchinaBean");
			IMacchina bean=home.findByPrimaryKey(new MacchinaPK(Security.getAziendaR(), lCOD_MAC));
			lCOD_AZL = bean.getCOD_AZL();
			IAziendaHome  home_az=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean_az=home_az.findByPrimaryKey(new Long(lCOD_AZL));
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Scheda").toUpperCase() + "\n"
                                + ApplicationConfigurator.LanguageManager.getString("MACCHINA/ATTREZZATURA"), bean_az.getRAG_SCL_AZL(), bean.getDES_MAC());
			
                        if (IncludeLogo){
                            AddImage();
                        }  
                        
			writeIndent();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					if(bStandAlone){
						tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
						tbl.addCell(bean_az.getRAG_SCL_AZL());
					}
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.MACCHINA/ATTREZZATURA"));
					tbl.addTitleCell(bean.getDES_MAC());
					m_document.add(tbl);
			}
			
			{
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				int width[] = {20,80};
				tbl.setWidths(width);
				tbl.setDefaultColspan(2);
				// tbl.addHeaderCellB("", 2);
				tbl.setDefaultColspan(1);
				
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Modello"));
					tbl.addCell(bean.getMDL_MAC());
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Identificativo"));
					tbl.addCell(bean.getMDL_MAC());
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Anno.costruzione"));
					long lTemp=bean.getYEA_CST_MAC();
					if (lTemp!=0){
						tbl.addCell(Formatter.format(lTemp));
					}
					else{
						tbl.addCell("");
					}

					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Targa"));
					tbl.addCell(Formatter.format(bean.getTAR_MAC()));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Marcatura"));
					tbl.addCell(Formatter.format(bean.getMRC_MAC()));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Catalogo"));
					tbl.addCell(Formatter.format(bean.getCAT_MAC()));
					
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Portata"));
					lTemp=bean.getPRT_MAC();
					if (lTemp!=0){
						tbl.addCell(Formatter.format(lTemp));
					}
					else{
						tbl.addCell("");
					}
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Pres."));
					tbl.addCell(Formatter.format(bean.getPRE_MAC()));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Tipologia.d'appartenenza"));
					lTemp=bean.getPRT_MAC();
					{
						ITipologieMacchineHome h=(ITipologieMacchineHome)PseudoContext.lookup("TipologieMacchineBean");
						ITipologieMacchine b=h.findByPrimaryKey(new Long(bean.getCOD_TPL_MAC()));
						tbl.addCell(b.getDES_TPL_MAC());
					}
					
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Ditta.costruttrice"));
					tbl.addCell(Formatter.format(bean.getDIT_CST_MAC()));
					tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Fabbrica"));
					tbl.addCell(Formatter.format(bean.getFBR_MAC()));
					
					m_document.add(tbl);
			 }
			 {//Luoghi fisice
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Luoghi.fisici.di.utilizzo"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Qualifica.resp."));
				
				Iterator it=bean.getLuoghiFisiciView().iterator();
				while(it.hasNext()){
					Macchina_LuoghiFisiciView w=(Macchina_LuoghiFisiciView)it.next();
					tbl.addCell(Formatter.format(w.strNOM_LUO_FSC));
					tbl.addCell(Formatter.format(w.strNOM_RSP_LUO_FSC));
					tbl.addCell(Formatter.format(w.strQLF_RSP_LUO_FSC));
				}
				m_document.add(tbl);
			}
			{//Normative sentenze
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				int width[] = {60,20,20};
				tbl.setWidths(width);
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Normative.e.sentenze.emesse"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("N.Documento"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Documento"));
				tbl.toLeft();
				tbl.endHeaders();
				//NUM_DOC_NOR_SEN
				
				Iterator it=bean.getNormativeSentenzeViewEx().iterator();
				while(it.hasNext()){
					NormativeSentenzeViewEx w=(NormativeSentenzeViewEx)it.next();
					tbl.addCell(Formatter.format(w.strTIT_NOR_SEN));
					tbl.addCell(Formatter.format(w.strNUM_DOC_NOR_SEN));
					tbl.toCenter();
					tbl.addCell(Formatter.format(w.dtDAT_NOR_SEN));
					tbl.toLeft();
				}
				m_document.add(tbl);
			}
			{//Normative sentenze
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				int width[] = {60,20,20};
				tbl.setWidths(width);
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Documenti.associati"));
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Rev.Doc."));
				tbl.toLeft();
				tbl.endHeaders();
				//NUM_DOC_NOR_SEN
				
				Iterator it=bean.getAnagraficaDocumentiView().iterator();
				while(it.hasNext()){
					AnagraficaDocumentiView w=(AnagraficaDocumentiView)it.next();
					tbl.addCell(Formatter.format(w.strTIT_DOC));
					tbl.addCell(Formatter.format(w.strRSP_DOC));
					tbl.toCenter();
					tbl.addCell(Formatter.format(w.dtDAT_REV_DOC));
					tbl.toLeft();
				}
				m_document.add(tbl);
			}
			{//Rischi associate
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				int width[] = {60,20,20};
				tbl.setWidths(width);
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Classificazione.dei.rischi.associati"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Entità.danno"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Ril.Val."));
				tbl.endHeaders();
				//NUM_DOC_NOR_SEN
				
				Iterator it=bean.getReportRischioMacchinaView().iterator();
				while(it.hasNext()){
					ReportRischioMacchinaView w=(ReportRischioMacchinaView)it.next();
					tbl.toLeft();
						tbl.addCell(Formatter.format(w.strCLF_RSO));
					tbl.toCenter();
						tbl.addCell(Formatter.format(w.lENT_DAN));
						tbl.addCell(Formatter.format(w.dtDAT_RIL));
				}
				m_document.add(tbl);
			}
			{//Fornitori associate
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toLeft();
				int width[] = {60,20,20};
				tbl.setWidths(width);
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Elenco.fornitori.associati"));
				tbl.toCenter();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Categoria"));
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl.endHeaders();
				//NUM_DOC_NOR_SEN
				
				Iterator it=bean.getFornitoriMacView().iterator();
				while(it.hasNext()){
					FornitoriMacView w=(FornitoriMacView)it.next();
						tbl.addCell(Formatter.format(w.strRAG_SOZ_FOR_AZL));
					tbl.toCenter();
						tbl.addCell(Formatter.format(w.strCAG_FOR));
					tbl.toLeft();
						tbl.addCell(Formatter.format(w.strNOM_RSP_FOR));
				}
				m_document.add(tbl);
			}
			
			closeDocument();	
	}
}
//==========================================================
%>
