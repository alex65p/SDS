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
class Report_REP_FAT_RSO extends Report{
	public long lCOD_AZL=0;
	public long lCOD_FAT_RSO=0;
        private boolean IncludeLogo=true;
	
	public Report_REP_FAT_RSO(long lCOD_FAT_RSO){
		this.lCOD_FAT_RSO=lCOD_FAT_RSO;
	}
	
	public Report_REP_FAT_RSO(long lCOD_FAT_RSO, boolean _IncludeLogo){
		this(lCOD_FAT_RSO);
                this.IncludeLogo = _IncludeLogo;
	}
        
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
		
			long lTemp=0;
			IRischioFattoreHome home=(IRischioFattoreHome)PseudoContext.lookup("RischioFattoreBean");
			IRischioFattore bean=home.findByPrimaryKey(new Long(lCOD_FAT_RSO));
			
			String strCOD_FAT_RSO=new Long(bean.getCOD_FAT_RSO()).toString(); //?? jo, DJ
			
			lCOD_AZL = Security.getAziendaR();
			//IAziendaHome  home_az=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			//IAzienda bean_az=home_az.findByPrimaryKey(new Long(lCOD_AZL));
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.FATTORE.DI.RISCHIO"), null, bean.getNOM_FAT_RSO());
                        if (IncludeLogo){
                            AddImage();
                        }
                        //writeTitle(bean_lf.getNOM_LUO_FSC());
			writeIndent();
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					//tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					//tbl.addCell(bean_az.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.FATTORE.DI.RISCHIO"));
					tbl.addTitleCell(bean.getNOM_FAT_RSO());
					
					m_document.add(tbl);
					//writeLine();
			 }
			 {
				CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.endHeaders();
				tbl.addCell(Formatter.format(bean.getDES_FAT_RSO()));
				m_document.add(tbl);
			 }

			 {//Documenti
			 	CenterMiddleTable tbl=new CenterMiddleTable(1);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0008"));
				tbl.endHeaders();
				
				IAnagrDocumentoHome h=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
				Iterator it = h.getAnagraficaDocumente_View(strCOD_FAT_RSO).iterator();
				while(it.hasNext()){
					Documente_View w=(Documente_View)it.next();
					tbl.addCell(Formatter.format(w.TIT_DOC));
				}
				m_document.add(tbl);
			 }
			 
			 {// URLs
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("MSG_REP_0009"), 2);
				tbl.addHeaderCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.addHeaderCell(ApplicationConfigurator.LanguageManager.getString("Collegamento"));
				tbl.endHeaders();
				ICollegamentoInternetHome h=(ICollegamentoInternetHome)PseudoContext.lookup("CollegamentoInternetBean");
				Iterator it = h.getCollegamentoInternet_View(strCOD_FAT_RSO).iterator();
				while(it.hasNext()){
					CollegamentoInternet_View w=(CollegamentoInternet_View)it.next();
					tbl.addCell(Formatter.format(w.DES_COL_INT));
					tbl.addCellUrl(Formatter.format(w.IDZ_COL_INT));
				}
				m_document.add(tbl);
			 }

			 {// Emails
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Posta.elettronica") +
                                        ":\n" +
                                        ApplicationConfigurator.LanguageManager.getString("MSG_REP_0010"),2);
				
				tbl.addHeaderCell(ApplicationConfigurator.LanguageManager.getString("Descrizione"));
				tbl.addHeaderCell(ApplicationConfigurator.LanguageManager.getString("Posta.elettronica"));
				
				tbl.endHeaders();
				IIndirizzoPostaElettronicaHome h=(IIndirizzoPostaElettronicaHome)PseudoContext.lookup("IndirizzoPostaElettronicaBean");
				Iterator it = h.getIndirizzoPostaElettronica_View(strCOD_FAT_RSO).iterator();
				while(it.hasNext()){
					IndirizzoPostaElettronica_View w=(IndirizzoPostaElettronica_View)it.next();
					tbl.addCell(w.DES_IDZ_PSA_ELT);
					tbl.addCellUrl(Formatter.format(w.IDZ_PSA_ELT));
				}
				m_document.add(tbl);
			 }
			  
			 closeDocument();	
	}
}
//==========================================================
%>
