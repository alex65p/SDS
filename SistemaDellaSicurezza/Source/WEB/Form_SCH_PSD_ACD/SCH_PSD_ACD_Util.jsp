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

<%! 
String BuildAziendeComboBox(IAziendaHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getAzienda_Name_ByID_View(Security.getAziende());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Azienda_Name_ByID_View obj=(Azienda_Name_ByID_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_AZL)) strSEL="selected";
	    str=str+"<option "+strSEL+" value=\""+Formatter.format(obj.COD_AZL)+"\">"+Formatter.format(obj.RAG_SCL_AZL)+"</option>";
  	}
	return str;
}

String BuildCAGComboBox(ICategoriaDocumentoHome cag_home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = cag_home.getComboView();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		CategoriaDocumento_ComboView  cag = (CategoriaDocumento_ComboView)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==cag.lCOD_CAT_DOC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+cag.strNOM_CAT_DOC+"\">"+cag.strNOM_CAT_DOC+"</option>";
  	}
	return str;
}

String BuildIDEComboBox(IPresidiHome cag_home, long SELECTED_ID)
{
	String str="";/*
	String strSEL="";
	java.util.Collection col = cag_home.getPresidio();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		PresidioView  ide = (PresidioView)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==ide.lCOD_CAT_DOC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+ide.strNOM_CAT_DOC+"\">"+ide.strNOM_CAT_DOC+"</option>";
  	}*/
	return str;
}

String Build_CAG_Lov(ICategoriePresideHome chome,long COD_AZL,String strNOM_CAG_PSD_ACD){
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"40%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Categoria.presidio") + "</b></td>";
	str=str+" <td width=\"30%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Periodicità.mesi.sostituzione") + "</b></td>";
	str=str+" <td width=\"30%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Periodicità.mesi.manutenzione") + "</b></td>";
	str=str+"</tr>";

	java.util.Collection col = chome.getCAG_Lov(COD_AZL, strNOM_CAG_PSD_ACD);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		CAG_Lov obj=(CAG_Lov)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.COD_CAG_PSD_ACD+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"40%\">&nbsp;"+Formatter.format(obj.NOM_CAG_PSD_ACD)+"</td>";
		str += "<td width=\"30%\">&nbsp;"+Formatter.format(obj.PER_MES_SST)+"</td>";
		str += "<td width=\"30%\">&nbsp;"+Formatter.format(obj.PER_MES_MNT)+"</td>";
		str += "</tr>";
  }
	return str;
}
String Build_PSD_Lov(IPresidiHome phome,long COD_AZL,long COD_CAG_PSD_ACD,long COD_PSD_ACD,String strNOM_CAG_PSD_ACD,String strIDE_PSD_ACD){
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"25%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Categoria.presidio") + "</b></td>";
	str=str+" <td width=\"12%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</b></td>";
	str=str+" <td width=\"13%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ultimo.controllo") + "</b></td>";
	str=str+" <td width=\"50%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Esito") + "</b></td>";
	str=str+"</tr>";

	java.util.Collection col = phome.getPSD_Lov(COD_AZL,COD_CAG_PSD_ACD,COD_PSD_ACD,strNOM_CAG_PSD_ACD,strIDE_PSD_ACD);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		PSD_Lov obj=(PSD_Lov)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.COD_PSD_ACD+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"25%\">&nbsp;"+Formatter.format(obj.NOM_CAG_PSD_ACD)+"</td>";
		str += "<td width=\"12%\">&nbsp;"+Formatter.format(obj.IDE_PSD_ACD)+"</td>";
		str += "<td width=\"13%\">&nbsp;"+Formatter.format(obj.DAT_ULT_PSD)+"</td>";
		str += "<td width=\"50%\">&nbsp;"+Formatter.format(obj.ESI_ULT_PSD)+"</td>";
		str += "</tr>";
  }
	return str;
}
String Build_DPD_Lov(ISchedeInterventoPSDHome dhome, long COD_PSD_ACD, String WHE_IN_AZL){
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"100%\"><b>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</b></td>";
	str=str+"</tr>";

	java.util.Collection col = dhome.getSchedeInterventoPSD_Responsabile_View(COD_PSD_ACD, WHE_IN_AZL);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		SchedeInterventoPSD_Responsabile_View obj=(SchedeInterventoPSD_Responsabile_View)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_PSD_ACD+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"100%\">&nbsp;"+Formatter.format(obj.strNOM_RSP_INR)+"</td>";
		str += "</tr>";
  }
	return str;
}
%>
