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

<%-- 
    Document   : ANA_SOP_Util
    Created on : 23-mar-2011, 10.38.31
    Author     : Alessandro
--%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.jbVRCS"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.jbODSS"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.DocumentiAssociati_Sopralluogo_View"%>
<%@page import="com.apconsulting.luna.ejb.Media.jbMedia"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.jbCollegamento"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.jbConstatazione"%>
<%@page import="com.apconsulting.luna.ejb.Sopraluogo.ISopraluogoHome"%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*"%>
<%@ page import="com.apconsulting.luna.ejb.Procedimento.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrOpere.*" %>
<%@ page import="com.apconsulting.luna.ejb.Cantiere.*" %>
<%@ page import="s2s.utils.Alphabet" %>
<%!
    String BuildPersonaleRMTab(IDipendenteHome home, String sCOD_SOP) {
	String str = "";
	java.util.Collection col_dip = home.getDipendentiBySOP_View(new Long(sCOD_SOP).longValue());
	str = "<table border='0' align='left' width='837' id='PersonaleRMHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>";
	str += "<td width='240'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Funzione.aziendale") + "</strong></td>";
	str += "<td width='297'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("E-mail") + "</strong></td>";
	str += "</tr>";
	str += "</table>";
	str += "<table border='0' align='left' width='837' id='PersonaleRM' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(sCOD_SOP) + "'>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "</tr>";
	if (!sCOD_SOP.equals("")) {
	    java.util.Iterator it_dip = col_dip.iterator();
	    while (it_dip.hasNext()) {
		DipendentiBySOP_View dt = (DipendentiBySOP_View) it_dip.next();
		String nomin = Formatter.format(dt.COG_DPD) + " " + Formatter.format(dt.NOM_DPD);
		str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + dt.COD_DPD + "'>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + nomin + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 240px;' class='inputstyle'  value=\"" + Formatter.format(dt.NOM_FUZ_AZL) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 297px;' class='inputstyle'  value=\"" + Formatter.format(dt.IDZ_PSA_ELT_DPD) + "\"></td>";
		str += "</tr>";
	    }
	}
	str = str + "</table>";

	return str;
    }

    String BuildPersonaleImpreseTab(IDipendenteHome home, String sCOD_SOP) {
	String str = "";
	java.util.Collection col_dip = home.getDipendentiEstBySOP_View(new Long(sCOD_SOP).longValue());
	str = "<table border='0' align='left' width='837' id='PersonaleImpreseHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str += "<tr>";
	str += "    <td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Impresa") + "</strong></td>";
	str += "    <td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>";
	str += "    <td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Funzione.aziendale") + "</strong></td>";
	str += "    <td width='297'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("E-mail") + "</strong></td>";
	str += "</tr>";
	str += "</table>";
	str += "<table border='0' align='left' width='837' id='PersonaleImprese' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(sCOD_SOP) + "'>";
	str += "<td width='200' class='dataTd'>&nbsp;</td>";
	str += "<td width='140' class='dataTd'>&nbsp;</td>";
	str += "<td width='200' class='dataTd'>&nbsp;</td>";
	str += "<td width='297' class='dataTd'>&nbsp;</td>";
	str += "</tr>";
	if (!sCOD_SOP.equals("")) {
	    java.util.Iterator it_dip = col_dip.iterator();
	    while (it_dip.hasNext()) {
		DipendentiBySOP_View dt = (DipendentiBySOP_View) it_dip.next();
		String nomin = Formatter.format(dt.COG_DPD) + " " + Formatter.format(dt.NOM_DPD);
		str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + dt.COD_DPD + "'>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\"" + Formatter.format(dt.IMPRESA) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + nomin + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\"" + Formatter.format(dt.NOM_FUZ_AZL) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 297px;' class='inputstyle'  value=\"" + Formatter.format(dt.IDZ_PSA_ELT_DPD) + "\"></td>";
		str += "</tr>";
	    }
	}
	str = str + "</table>";
	return str;
    }

    String BuildRapportoTab(ISopraluogoHome home, String sCOD_SOP) {
	String str = "";
	java.util.Collection col = home.getConstatazioniSop(new Long(sCOD_SOP));
	str = "<table border='0' align='left' width='837' id='RapportoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str += "<tr>";
	str += "<td width='20'><strong>&nbsp;</strong></td>";
        str += "<td width='410'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Constatazioni") + "</strong></td>";
	str += "<td width='407'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Disposizioni") + "</strong></td>";
	str += "</tr>";
	str += "</table>";
	str += "<table border='0' align='left' width='837' id='Rapporto' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(sCOD_SOP) + "'>";
	str += "<td class='dataTd'>&nbsp;</td>";
        str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "</tr>";
	if (!sCOD_SOP.equals("")) {
	    java.util.Iterator it = col.iterator();
	    Alphabet lGenerator = new Alphabet();
            String sElement="1";
            while (it.hasNext()) {
		sElement = lGenerator.getNextElement(sElement);
                jbConstatazione dt = (jbConstatazione) it.next();
		str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + dt.lCOD_SOP_CST + "'>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 20px;' class='inputstyle'  value=\"" + sElement + "\"></td>";
                str += "<td class='dataTd'><input type='text' readonly style='width: 410px;' class='inputstyle'  value=\"" + Formatter.format(dt.sDESC) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 407px;' class='inputstyle'  value=\"" + Formatter.format(dt.sDIS_GEN) + "\"></td>";
		str += "</tr>";
	    }
	}
	str = str + "</table>";

	return str;
    }

    //-----------------------------------------------
    
    String BuildCollegamentiTab(ISopraluogoHome home, String sCOD_SOP) {
	String str = "";
	Long lCOD_SOP = new Long(sCOD_SOP);
	
	java.util.Collection colODS = home.buildCollegamentiTab(lCOD_SOP);

	str = "<table border='0' align='left' width='837' id='RapportoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str += "<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
        str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>";
	str += "<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("N.Documento") + "</strong></td>";
	str += "<td width='437'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str += "</tr>";
	str += "</table>";
	str += "<table border='0' align='left' width='837' id='Rapporto' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(sCOD_SOP) + "'>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "<td class='dataTd'>&nbsp;</td>";
	str += "</tr>";
	if (!sCOD_SOP.equals("")) {

	    java.util.Iterator itODS = colODS.iterator();
	    while (itODS.hasNext()) {
		jbCollegamento dt = (jbCollegamento) itODS.next();
		str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + dt.lCOD_OGG_COL + "'>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 150;' class='inputstyle'  value=\"" + Formatter.format(dt.NOM_TPL_DOC) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 100;' class='inputstyle'  value=\"" + Formatter.format(dt.dDAT_DOC) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly style='width: 150;' class='inputstyle'  value=\"" + Formatter.format(dt.sNUM_DOC) + "\"></td>";
		str += "<td class='dataTd'><input type='text' readonly  style='width: 437;' class='inputstyle'   value=\"" + Formatter.format(dt.sTIT_DOC) + "\"></td>";
		str += "</tr>";
	    }
            
	}
	str = str + "</table>";

	return str;
    }

    String BuildFotoTab(ISopraluogoHome home, String sCOD_SOP) {
	String str = "";

	java.util.Collection col = home.getMediaSOP(new Long(sCOD_SOP).longValue());
	str += "<table border='0' align='left' width='837' id='DocAssociatiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str += "<td width='20'></td>"; // <strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Immagine") + "</strong></td>";
	str += "<td width='350'>&nbsp;<strong>" + ApplicationConfigurator.LanguageManager.getString("Nome.file") + "</strong></td>";
	str += "<td width='467'>&nbsp;<strong>" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str += "</tr>";
	str += "</table>";
	str += "<table border='1' align='left' width='837' id='DocAssociati' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX='" + Formatter.format(sCOD_SOP) + "'>";
	str += "<td width='20' class='dataTd'>&nbsp;</td>";
	str += "<td width='350' class='dataTd'>&nbsp;</td>";
	str += "<td width='467' class='dataTd'>&nbsp;</td>";
	str += "</tr>";
	if (home != null) {
	    java.util.Iterator it = col.iterator();
	    while (it.hasNext()) {
		jbMedia rc = (jbMedia) it.next();
		str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + rc.lCOD_MED + "'>";
		str += "<td class='dataTd' width='20'><a href='../Form_ANA_MED_SOP/SHOW_Media.jsp?COD_MED=" + rc.lCOD_MED + "'><img src='../_images/EDIT.gif' height='20'></img></a></td>";
		str += "<td class='dataTd' width='350'><input type='text' readonly style='width: 350px;'  class='inputstyle'  value=\"" + Formatter.format(rc.sFile) + "\" ></td>";
		str += "<td class='dataTd' width='467'><input type='text' readonly style='width: 462px;' class='inputstyle'  value=\"" + Formatter.format(rc.sDES_MED) + "\"></td>";
		str += "</tr>";
	    }
	}
	str += "</table>";

	return str;
    }

    String BuildDocumentiTab(ISopraluogoHome home, String sCOD_SOP) {
	String str = "";
	java.util.Collection col = home.getDocumentiCantiereSOP(new Long(sCOD_SOP).longValue());
	str += "<table border='1' align='left' width='837' id='FotoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str += "<td width='300'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia.documento") + "</strong></td>";
	str += "<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("N.Documento") + "</strong></td>";
	str += "<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>";
	str += "<td width='297'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str += "</tr></table>";
	str += "<table border='0' align='left' width='837' id='Foto' class='dataTable' cellpadding='0' cellspacing='0'>";
	str += "<tr style='display:none' ID='' INDEX=''>";
	str += "<td width='300' class='dataTd'><input type='text' name='' class='dataInput' readonly  value=''></td>";
	str += "<td width='140' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str += "<td width='100' class='dataTd'><input type='text' name='' readonly class='dataInput '  value=''></td>";
	str += "<td width='297' class='dataTd'><input type='text' name='' readonly class='dataInput '  value=''></td></tr>";
	java.util.Iterator it = col.iterator();
	while (it.hasNext()) {
	    DocumentiAssociati_Sopralluogo_View obj = (DocumentiAssociati_Sopralluogo_View) it.next();
	    str += "<tr INDEX='" + Formatter.format(sCOD_SOP) + "' ID='" + obj.lCOD_DOC + "'>";
	    str += "<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\"" + Formatter.format(obj.NOM_TPL_DOC) + "\"></td>";
	    str += "<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\"" + Formatter.format(obj.NUM_DOC) + "\"></td>";
	    str += "<td class='dataTd'><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\"" + Formatter.format(obj.DAT_DOC) + "\"></td>";
	    str += "<td class='dataTd'><input type='text' readonly style='width: 297px;' class='inputstyle'  value=\"" + Formatter.format(obj.TIT_DOC) + "\"></td>";
	    str += "</tr>";
	}
	str += "</table>";
	return str;
    }

    String BuildCollegamentiForm(ISopraluogoHome home,long lCOD_AZL) {
    int rowCount = 0;
    StringBuilder str = new StringBuilder();
    java.util.Collection col = home.buildCollegamentiForm(lCOD_AZL, null);
    java.util.Iterator it = col.iterator();
    str.append("<table>");
    while(it.hasNext()){
       jbCollegamento  row = (jbCollegamento)it.next();
       str.append("<tr class=\"VIEW_TR\" valign=\"top\" INDEX=\""+row.lCOD_SOP_COL+"\" onclick=\"OnRowClick(this)\">");
         str.append(     "<td width=\"16%\">").append(Formatter.format(row.NOM_TPL_DOC)).append("</td>")
            .append(     "<td width=\"11%\">").append(Formatter.format(row.dDAT_DOC)).append("</td>")
            .append(     "<td width=\"14%\">").append(Formatter.format(row.sNUM_DOC)).append("</td>")
            .append(     "<td width=\"15%\">").append(Formatter.format(row.sTIT_DOC)).append("</td>")
            .append(     "<td width=\"14%\">").append(Formatter.format(row.sProcedimento)).append("</td>")
            .append(     "<td width=\"16%\">").append(Formatter.format(row.sCantiere)).append("</td>")
            .append(     "<td width=\"14%\">").append(Formatter.format(row.sOpera)).append("</td>")
            .append("</tr>");
        rowCount++;
    }
    str.append("</table>");
    return str.toString();
}
%>
