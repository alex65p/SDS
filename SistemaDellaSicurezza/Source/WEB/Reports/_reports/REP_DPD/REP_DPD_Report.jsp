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

<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.DipendenteCorsi.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="com.apconsulting.luna.ejb.Nazionalita.*" %>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../../../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../../../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteTelefono/DipendenteTelefonoBean_Interfaces.jsp"%>

<%@ include file="../../../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean_Interfaces.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/ejb/TitoliStudio/TitoliStudioBean.jsp"%>

<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean_Interfaces.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteLingueStraniere/DipendenteLingueStraniereBean.jsp"%>

<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendentePrecedenti/DipendentePrecedentiBean_Interfaces.jsp"%>

<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean_Interfaces.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/ejb/DipendenteConsegneDPI/DipendenteConsegneDPIBean.jsp"%>

<%@ include file="../../../src/com/apconsulting/luna/util/FormatterPlain.jsp"%>
<%@ include file="../../../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../../../_include/Checker.jsp" %>
<%@ include file="../Report.jsp"%>
<%
class Report_DPD extends Report{
	public long lCOD_AZL=0;
	public long lCOD_DPD=0;

	
	public Report_DPD(long lCOD_DPD){
		this.lCOD_DPD=lCOD_DPD;
		
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
	{ 
	//----------------------------------------------------------------------
			long lCOD_DOC = lCOD_DPD;
			String strNOM_STA="";
			String strNUMS_TEL = "";
			Image img1=null;
			byte[] btContent=null;
			
			lCOD_AZL=Security.getAziendaR();
			
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean=home.findByPrimaryKey(new Long(lCOD_AZL));

			IDipendenteHome home_dpd=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
			IDipendente dpd = home_dpd.findByPrimaryKey(new Long(lCOD_DPD));
			
			IAnagrDocumentoHome home_doc=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
			IAnagrDocumento bean_doc=null;
			
			IDipendenteTelefonoHome home_tel = (IDipendenteTelefonoHome)PseudoContext.lookup("DipendenteTelefonoBean");
			
			ITitoliStudioHome home_tit = (ITitoliStudioHome)PseudoContext.lookup("TitoliStudioBean");
			
			IDipendenteLingueStraniereHome home_lng=(IDipendenteLingueStraniereHome)PseudoContext.lookup("DipendenteLingueStraniereBean");

			IDipendenteCorsiHome home_cor = (IDipendenteCorsiHome)PseudoContext.lookup("DipendenteCorsiBean");			
			IPercorsiFormativiHome home_pcs = (IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");	
			
			IDipendentePrecedentiHome home_ditte = (IDipendentePrecedentiHome)PseudoContext.lookup("DipendentePrecedentiBean");	
			
			IDipendenteConsegneDPIHome home_dpd_dpi = (IDipendenteConsegneDPIHome)PseudoContext.lookup("DipendenteConsegneDPIBean");
			
			INazionalitaHome home_naz = (INazionalitaHome)PseudoContext.lookup("NazionalitaBean");

			IAttivitaLavorativeHome home_att = (IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
			
			if (dpd.getCOD_STA()!=0){
				INazionalita naz = home_naz.findByPrimaryKey(new Long(dpd.getCOD_STA()));
				strNOM_STA = naz.getNOM_STA();
			}
			try{
				btContent=home_doc.downloadFileU("ANA_DPD_TAB", lCOD_DOC);		
			}
			catch (Exception Ex){
			}

			String strTmp =dpd.getCOG_DPD()+" "+ dpd.getNOM_DPD();
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("SCHEDA.DIPENDENTE"), bean.getRAG_SCL_AZL(), strTmp);
                        
                        
                        AddImage();                        
                        {
				CenterMiddleTable tbl=new CenterMiddleTable(1);					
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("SCHEDA.DIPENDENTE"));
				m_document.add(tbl);
			}
			try{
				if (btContent!=null){
					img1 = Image.getInstance(btContent); 
					img1.scaleAbsolute(170, 200);
					img1.setAbsolutePosition(380,470);
					m_document.add(img1);
				}
			}
			catch(Exception ex){}
			writeIndent();
			{// dipendente
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				tbl.toCenter();
				int width[] = {25,48,25};
				tbl.setWidths(width);
				
				tbl.toLeft();	
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dati.dipendente"),3);
				//tbl.addTitleCell(strTmp);
				tbl.toLeft();	
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nome"));// ok
				tbl.addCell(Formatter.format(dpd.getNOM_DPD()));
				Cell cc = new Cell();
				cc.setRowspan(9);
				tbl.toCenter();
				tbl.addCell(cc);
				tbl.toLeft();	
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Cognome"));// ok
				tbl.addCell(Formatter.format(dpd.getCOG_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Codice.fiscale"));// ok
				tbl.addCell(Formatter.format(dpd.getCOD_FIS_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Luogo.e.Data.nascita"));// ok
				tbl.addCell(Formatter.format(dpd.getLUO_NAS_DPD()) + " " + Formatter.format(dpd.getDAT_NAS_DPD()));
				//tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Luogo.nascita"));// ok
				//tbl.addCell(Formatter.format(dpd.getLUO_NAS_DPD()));
				//tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Indirizzo"));// ok
				//tbl.addCell(Formatter.format(dpd.getIDZ_DPD()));
				//tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Città.C.A.P."));// ok
				//tbl.addCell(Formatter.format(dpd.getCIT_DPD())+" - "+ Formatter.format(dpd.getCAP_DPD()));
				//tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Provincia"));// ok
				//tbl.addCell(Formatter.format(dpd.getPRV_DPD()));
				//tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Nazione"));// ok
				//tbl.addCell(Formatter.format(strNOM_STA));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Stato.attuale"));// ok
				String stato = "";
				if (dpd.getSTA_DPD() != null){
                    if (dpd.getSTA_DPD().equals("1")){
                        stato=ApplicationConfigurator.LanguageManager.getString("Attivo");
                    }
                    else
                    if (dpd.getSTA_DPD().equals("0")){
                        stato=ApplicationConfigurator.LanguageManager.getString("Disattivo");
                    }
                }
				tbl.addCell(Formatter.format(stato));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Matricola"));// ok
				tbl.addCell(Formatter.format(dpd.getMTR_DPD()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Numeri.utili"));// ok
				Collection col = home_tel.getDipendenteTelefono_Tipology_Number_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while(it.hasNext()){
						DipendenteTelefono_Tipology_Number_View w =(DipendenteTelefono_Tipology_Number_View)it.next();
						strNUMS_TEL+=w.NUM_TEL;
						if (it.hasNext()) strNUMS_TEL+=", ";
					}
				}
				tbl.addCell(Formatter.format(strNUMS_TEL));
				//
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("Funzione.aziendale"));
				tbl.addCell(Formatter.format(dpd.getNOM_FUZ_AZL()));
				tbl.addCell(ApplicationConfigurator.LanguageManager.getString("RLS"));
				tbl.addCell(Formatter.format( (dpd.getRAP_LAV_AZL().equalsIgnoreCase("S") ? ApplicationConfigurator.LanguageManager.getString("Si") : ApplicationConfigurator.LanguageManager.getString("No")) ));
				//
				m_document.add(tbl);
			}
			writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Istruzione"));
			{//TITOLI STUDIO
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {50,50};
				tbl.setWidths(width);
				tbl.toLeft();
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Titolo.di.studio"));
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia.del.titolo.di.studio"));
					
					Collection col = home_tit.getDipendente_TitoliStudio_View(lCOD_DPD);
					Iterator it = col.iterator();
					if (it!=null){
						while(it.hasNext()){
							Dipendente_TitoliStudio_View w =(Dipendente_TitoliStudio_View)it.next();
							tbl.addCell(Formatter.format(w.NOM_TIT_STU_SPC));
							tbl.addCell(Formatter.format(w.TLP_TIT_STU_SPC));
						}
					}
				m_document.add(tbl);
			}
			{//lingue straniere
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {50,50};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Lingue.straniere.conosciute"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Livello.di.conoscenza"));
				
				Collection col = home_lng.getDipendenteLingueStraniere_View(lCOD_DPD, lCOD_AZL);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						DipendenteLingueStraniere_View w = (DipendenteLingueStraniere_View)it.next();
						tbl.addCell(Formatter.format(w.NOM_LNG_STR_DPD));
						tbl.addCell(Formatter.format(w.LIV_CSC_LNG_STR));
					}	
				}
			  	m_document.add(tbl);
			}
			writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Formazione"));
			{//corsi
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {25,60,15};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Corsi.effettuati"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.del.corso"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.corso"));				
				Collection col = home_cor.getDipendenteCorsi_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						DipendenteCorsi_View w = (DipendenteCorsi_View)it.next();
						tbl.addCell(Formatter.format(w.strNOM_COR));
						tbl.addCell(Formatter.format(w.strDES_COR));
						tbl.addCell(Formatter.format(w.dtDAT_EFT_COR));
					}	
				}
				m_document.add(tbl);
			}
			{//percorsi formativi
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {40,60};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Percorsi.formativi.seguiti"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.del.percorso.formativo"));
				Collection col = home_pcs.getDipendentePercorsi_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						DipendentePercorsi_View w = (DipendentePercorsi_View)it.next();
						tbl.addCell(Formatter.format(w.strNOM_PCS));
						tbl.addCell(Formatter.format(w.strDES_PCS));
					}	
				}
				m_document.add(tbl);
			}
			{//ditte precedenti
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				int width[] = {30,60};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Ditte.precedenti"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Attività.svolte"));
				
				Collection col = home_ditte.getDipendentePrecedenti_Tipology_Number_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						DipendentePrecedenti_Tipology_Number_View w = (DipendentePrecedenti_Tipology_Number_View)it.next();
						tbl.addCell(Formatter.format(w.RAG_SCL_DIT_PRC));
						tbl.addCell(Formatter.format(w.DES_ATI_SVO_DIT_PRC));
					}	
				}
				m_document.add(tbl);
			}
			writeParagraph1(ApplicationConfigurator.LanguageManager.getString("Aspetti.professionali"));
			{//mansioni
				boolean DPD_UO_MAN_TPL_CON = ApplicationConfigurator.isModuleEnabled(MODULES.DPD_UO_MAN_TPL_CON);
                                CenterMiddleTable tbl = new CenterMiddleTable(DPD_UO_MAN_TPL_CON?5:4);
				if (DPD_UO_MAN_TPL_CON){
                                    int width[] = {25,25,15,15,20};
                                    tbl.setWidths(width);
                                }
                                else {
                                    int width[] = {35,35,15,15};
                                    tbl.setWidths(width);
                                }
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Attività.svolte"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Unità.org.appartenenza"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.inizio"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Data.fine"));
                                if (DPD_UO_MAN_TPL_CON)
                                    tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Tipologia.contrattuale"));
				
				Collection col = home_att.getAttivitaLavorativaByDipendente_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						AttivitaLavorativaByDipendente_View w = (AttivitaLavorativaByDipendente_View)it.next();
						tbl.addCell(Formatter.format(w.strNOM_MAN));
						tbl.addCell(Formatter.format(w.strNOM_UNI_ORG));
						tbl.addCell(Formatter.format(w.dtDAT_INZ));
						tbl.addCell(Formatter.format(w.dtDAT_FIE));
                                                if (DPD_UO_MAN_TPL_CON)
                                                    tbl.addCell(Formatter.format(w.strNOM_TPL_CON));
						}	
				}
				m_document.add(tbl);
			}
			{//mansioni
				CenterMiddleTable tbl=new CenterMiddleTable(3);
				int width[] = {48,31, 19};
				tbl.setWidths(width);
				tbl.toLeft();
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dispositivi.di.protezione.assegnati"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.D.P.I."));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Dt.Consegna"));
				
				Collection col = home_dpd_dpi.getResponsabileDPI_View(lCOD_DPD);
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						Dipendenti_DPI_View w = (Dipendenti_DPI_View)it.next();
						tbl.addCell(Formatter.format(w.NOM_TPL_DPI));
						tbl.addCell(Formatter.format(w.NOM_RSP_CSG_DPI));
						tbl.addCell(Formatter.format(w.DAT_CSG_DPI));
					}
				}
				m_document.add(tbl);
			}
			closeDocument();	
	}
}
//==========================================================

Checker c = new Checker();

long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"), request.getParameter("ID"), true);		

if ( c.isError){
	%>
		<html><body>
			<h2><%=c.printErrors()%></h2>
		</body></html>
	<%
	return;
}

out.clearBuffer();

Report_DPD report = new Report_DPD(lCOD_DPD);
report.doReport(request, response);
%>
