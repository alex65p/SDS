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
    <version number="1.0" date="18/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="18/01/2004" author="Roman Chumachenko">
				   <description>ANA_AZL_Util.jsp-functions for ANA_AZL_Form.jsp</description>
				   <description>Functions for comboboxes</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IAziendaTelefonoHome home = Home intarface of AziendaTelefono
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildTelephoneTab(IAziendaTelefonoHome home, String COD_AZL)
{
	String str;
	java.util.Collection col_tel = home.getAziendaTelefoniByAZLID_View(new Long(COD_AZL).longValue());
	str="<table border='0' width='855' align='left' id='TelefonoAziendaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='425'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
	str+="<td width='430'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' id='TelefonoAzienda' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_AZL)+"'>";
	str+="<td class='dataTd'><input type='text' name='TPL_NUM_TEL' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='NUM_TEL' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_tel = col_tel.iterator();
 		while(it_tel.hasNext()){
			AziendaTelefoniByAZLID_View tel=(AziendaTelefoniByAZLID_View)it_tel.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_AZL)+"' ID='"+tel.COD_NUM_TEL_AZL+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 425px;' height: ' class='inputstyle'  value=\""+Formatter.format(tel.TPL_NUM_TEL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 430px;' class='inputstyle'  value=\""+Formatter.format(tel.NUM_TEL)+"\"></td>";
			str+="</tr>";
  		}
	}// azienda = null	
	str+="</table>";
	return str;
}


//----------------------------------------
/* 	IDittaEsternaHome home = Home intarface of DittaEsterna
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildDitteEsterneTab(IDittaEsternaHome home, String COD_AZL)
{
	String str;
	java.util.Collection col_dt = home.getDittaEsterneByAZLID_View(new Long(COD_AZL).longValue());
	str="<table border='0' align='left' width='855' id='DitteEsterneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='225'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Ragione.sociale") + "</strong></td>";
	str+="<td width='210'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Categoria") + "</strong></td>";
	str+="<td width='210'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro") + "</strong></td>";
	str+="<td width='210'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Città") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' id='DitteEsterne' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+COD_AZL+"'>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_dt = col_dt.iterator();
 		while(it_dt.hasNext()){
			DittaEsterneByAZLID_View dt=(DittaEsterneByAZLID_View)it_dt.next();
			str+="<tr INDEX='"+COD_AZL+"' ID='"+dt.COD_DTE+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 225px;' class='inputstyle'  value=\""+Formatter.format(dt.RAG_SCL_DTE)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 210px;' class='inputstyle'  value=\""+Formatter.format(dt.CAG_DTE)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 210px;' class='inputstyle'  value=\""+Formatter.format(dt.NOM_RSP_DTE)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 210px;' class='inputstyle'  value=\""+Formatter.format(dt.CIT_DTE)+"\"></td>";
			str+="</tr>";
  		}
	}// azienda = null	
	str+="</table>";
	return str;
}

//----------------------------------------
/*	IConsultantHome home = Home intarface of Consultant
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildConsultantTab(IConsultantHome home, String COD_AZL)
{
	String str;
	java.util.Collection col_cons = home.getConsultantiByAZLID_View(new Long(COD_AZL).longValue());
	str="<table border='0' align='left' width='855' id='ConsultantiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='280'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo") + "</strong></td>";
	str+="<td width='275'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Funzione") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.attivazione") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.disattivazione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' id='Consultanti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none'><td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_cons = col_cons.iterator();
 		while(it_cons.hasNext()){
			ConsultantiByAZLID_View dt=(ConsultantiByAZLID_View)it_cons.next();
			str+="<tr>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 280px;' class='inputstyle'  value=\""+Formatter.format(dt.NOM_COU)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 275px;' class='inputstyle'  value=\""+Formatter.format(dt.RUO_COU)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(dt.DAT_ATT)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(dt.DAT_DIS)+"\"></td>";
			str+="</tr>";
  		}
	}//azienda = null
	str+="</table>";
	return str;
}


//----------------------------------------
/*	ISitaAziendeHome home = Home intarface of SitaAziende
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildSitaAziendeTab(ISitaAziendeHome home, String COD_AZL)
{
	String str;
	java.util.Collection col_sa = home.getSiteAziendaleByAZLID_View(new Long(COD_AZL).longValue());
	str="<table border='0' align='left' width='855' id='SiteAziendeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='260'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo.del.sito") + "</strong></td>";
	str+="<td width='245'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Indirizzo") + "</strong></td>";
	str+="<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero.civico.abbreviazione") + "</strong></td>";
	str+="<td width='50'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("C.a.p.") + "</strong></td>";
	str+="<td width='180'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Città") + "</strong></td>";
	str+="<td width='70'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Provincia") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' id='SiteAziende' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+COD_AZL+"'>";
	str+="<td class='dataTd'></td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_sa = col_sa.iterator();
 		while(it_sa.hasNext()){
			SiteAziendaleByAZLID_View dt=(SiteAziendaleByAZLID_View)it_sa.next();
			str+="<tr INDEX='"+COD_AZL+"' ID='"+dt.COD_SIT_AZL+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 260px;' class='inputstyle'  value=\""+Formatter.format(dt.NOM_SIT_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 245px;' class='inputstyle'  value=\""+Formatter.format(dt.IDZ_SIT_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\""+Formatter.format(dt.NUM_CIC_SIT_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 50px;' class='inputstyle'  value=\""+Formatter.format(dt.CAP_SIT_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 180px;' class='inputstyle'  value=\""+Formatter.format(dt.CIT_SIT_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 70px;' class='inputstyle'  value=\""+Formatter.format(dt.PRV_SIT_AZL)+"\"></td>";
			str+="</tr>";
  		}
	}// azienda = null
	str=str+"</table>";
	return str;
}

//----------------------------------------
/*	IDipendenteHome home = Home intarface of Dipendente
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildDipendentiTab(IDipendenteHome home, String COD_AZL)
{
	String str;
	java.util.Collection col_dip = home.getDipendentiByAZLID_RLS_View(new Long(COD_AZL).longValue());
	str="<table border='0' align='left' width='855' id='DipendentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Cognome") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str+="<td width='305'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Indirizzo") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Matricola") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='855' id='Dipendenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none'><td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td>";
	str+="<td class='dataTd'>&nbsp;</td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_dip = col_dip.iterator();
 		while(it_dip.hasNext()){
			DipendentiByAZLID_View dt=(DipendentiByAZLID_View)it_dip.next();
			str+="<tr>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value='"+Formatter.format(dt.COG_DPD)+"'></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(dt.NOM_DPD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 305px;' class='inputstyle'  value=\""+Formatter.format(dt.IDZ_DPD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(dt.MTR_DPD)+"\"></td>";
			str+="</tr>";
  		}
	}// azienda = null
	str=str+"</table>";
	return str;
}

//----------------------------------------
/*	IDipendenteHome home = Home intarface of Dipendente
	String COD_AZL = COD_AZL of current Azienda
*/
String BuildGiorniLavoratiTab(IGiorniLavoratiHome gl_home, String COD_AZL)
{
	String str;
	java.util.Collection col_grn= gl_home.getGiorniLavoratiByAZLID_View(new Long(COD_AZL).longValue());
	str="<table border='0' align='left' width='855' id='GiorniLavoratiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='225'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Anno") + "</strong></td>";
	str+="<td width='630'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Giorni.Lavorati") + "</strong></td>";
	str+="</table>";
	str+="<table border='0' align='left' width='430' id='GiorniLavorati' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_AZL)+"'>";
	str+="<td class='dataTd'><input type='text' name='ANNO' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='GRN_LAV' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_AZL.equals("") ){
		java.util.Iterator it_dip = col_grn.iterator();
 		while(it_dip.hasNext()){
			GiorniLavoratiByAZLID_View gl=(GiorniLavoratiByAZLID_View)it_dip.next();
                        str+="<tr INDEX='"+Formatter.format(COD_AZL)+"' ID='"+gl.ANNO+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 225px;' class='inputstyle'  value='"+Formatter.format(gl.ANNO)+"'></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 630px;' class='inputstyle'  value='"+String.format("%,d%n",gl.GRN_LAV)+"'+></td>";
			str+="</tr>";
  		}
	}// azienda = null
	str=str+"</table>";
	return str;
}


//===============================================================================================================
// ------------ combobox for assotiated aziendas ---------------
/* 	IAziendaHome home = home interface of current azienda
	long BesidesID = COD_AZL of current azienda
	long SELECTED_ID = COD_AZL_ASC of current azienda, if it not exists then =0
*/
String BuildAziendasComboBox(IAziendaHome home, long BesidesID, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getAzienda_Name_BesidesID_View(BesidesID);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Azienda_Name_BesidesID_View dt=(Azienda_Name_BesidesID_View)it.next();
		String strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_AZL){strSEL="selected";} }
	    str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_AZL)+"'>"+Formatter.format(dt.RAG_SCL_AZL)+"</option>";
  	}
	return str;
}
// for new azienda 
String BuildAziendasComboBoxNew(IAziendaHome home,java.util.ArrayList WHE_IN_AZL)
{
	String str="";
	java.util.Collection col = home.getAzienda_Name_Address_View(WHE_IN_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Azienda_Name_Address_View dt=(Azienda_Name_Address_View)it.next();
		str=str+"<option value='"+Formatter.format(dt.COD_AZL)+"'>"+Formatter.format(dt.RAG_SCL_AZL)+"</option>";
  	}
	return str;
}
//======================================================================================
// ------------ combobox for nazionalita ---------------
/* 	INazionalitaHome home = home interface of NazionalitaBean
	long SELECTED_ID = ID (COD_STA) of current azienda, if not exists then =0
*/
String BuildNazionalitaComboBox(INazionalitaHome home, long SELECTED_ID,long COD_LNG)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getNazionalita_Names_View(COD_LNG);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Nazionalita_Names_View dt=(Nazionalita_Names_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_STA){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_STA)+"'>"+Formatter.format(dt.NOM_STA)+"</option>";
  	}
	return str;
}
//=========================================================================================
%>
