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
class Report_REP_ANA_UNI_ORG extends Report{
	public long lCOD_AZL=0;
	public long lCOD_UNI_ORG=0;
	
	
	public Report_REP_ANA_UNI_ORG(){
	}
	
	public void doReport() throws DocumentException, IOException, BadElementException, Exception
		{ //----------------------------------------------------------------------
		
			
			IUnitaOrganizzativaHome home_uni=(IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
			IUnitaOrganizzativa  bean_uni=home_uni.findByPrimaryKey(new Long(lCOD_UNI_ORG));
			lCOD_AZL = bean_uni.getCOD_AZL();
						
			IAziendaHome  home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
			IAzienda bean_az=home.findByPrimaryKey(new Long(lCOD_AZL));
			
			initDocument("the doc", null, ApplicationConfigurator.LanguageManager.getString("Organigramma.unità.organizzativa"), bean_az.getRAG_SCL_AZL(), null);
		
                        AddImage();                        
			writeTitle("\n\n" + ApplicationConfigurator.LanguageManager.getString("Organigramma.unità.organizzativa"));
			
			{
				CenterMiddleTable tbl=new CenterMiddleTable(1);
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"));
					tbl.addCell(bean_az.getRAG_SCL_AZL());
					tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile.azienda"));
					tbl.addCell(bean_az.getNOM_RSP_AZL());
				m_document.add(tbl);
			}
			{
				
				CenterMiddleTable tbl=new CenterMiddleTable(2);
				
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Descrizione.unità.organizzativa"));
				tbl.addHeaderCellB(ApplicationConfigurator.LanguageManager.getString("Responsabile"));
				tbl.endHeaders();
				tbl.toLeft();
				tbl.addCell(bean_uni.getNOM_UNI_ORG());
				tbl.addCell(getResponsabile(bean_uni));
				drawChildren(tbl, home_uni, bean_uni, 0);
					
				m_document.add(tbl);
			}
			closeDocument();	
	}
	
	
	String getResponsabile(IUnitaOrganizzativa bean_uni){
		ResponsabileView w=bean_uni.getResponsabile(lCOD_AZL);
		if(w!=null) return w.strNOM_DPD+" " + w.strCOG_DPD;
		return "";
	}
	
	void drawChildren(CenterMiddleTable tbl, IUnitaOrganizzativaHome home_uni, IUnitaOrganizzativa bean_uni, int iLevel) throws Exception{
		long lCOD_AZL=bean_uni.getCOD_AZL();
		Iterator it=bean_uni.getChildren(lCOD_AZL).iterator();
		while(it.hasNext()){
				UnitaOrganizzativaView uw=(UnitaOrganizzativaView)it.next();
				String strTemp="";
				for(int i=0; i<iLevel; i++){
					strTemp+="  ";
				}
				tbl.addCell(strTemp +" - "+uw.strNOM_UNI_ORG);
				
				IUnitaOrganizzativa bean_u=home_uni.findByPrimaryKey(new Long(uw.lCOD_UNI_ORG));
				tbl.addCell(getResponsabile(bean_u));
				drawChildren(tbl, home_uni, bean_u, iLevel+1);
		}
		
	}

}
%>
