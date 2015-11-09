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
//---------------FUNCTIONS FOR TABS----------------------------
/* 	IAttivitaLavorative bean = exsempliar of AttivitaLavorative
*/
String BuildOperazioniSvolteTab(IAttivitaLavorative bean)
{
        String str="";
        java.util.Collection col = bean.getOperazioniSvolte_View();
        str+="<table border='0' align='left' width='784' id='OperazioniSvolteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str+="<td width='784'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.operazione") + "</strong></td>";
        str+="</tr></table>";
        str+="<table border='0' align='left' width='784' id='OperazioniSvolte' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
        str+="<td width='784' class='dataTd'><input type='text' name='NOM_OPE_SVO' class='inputstyle' readonly  value=''></td></tr>";
        if ( bean!=null ){
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_OperazioniSvolte_View rc=(AttLav_OperazioniSvolte_View)it.next();
                str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_OPE_SVO+"'>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 784px;' class='inputstyle' value=\""+Formatter.format(rc.NOM_OPE_SVO)+"\" ></td>";
                        str+="</tr>";
                }
        }// bean = null
        //----------------------
        str+="</table>";
        return str;
}
//------------------------------------------------------------------------

/* 	IAttivitaLavorative bean = exsempliar of AttivitaLavorative
*/
String BuildRischiTab(IAttivitaLavorative bean, long lCOD_AZL)
{
        String str="";
        java.util.Collection col = bean.getRischi_View(lCOD_AZL);
        str+="<table border='0' align='left' width='784' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str+="<td width='392'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
        str+="<td width='392'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fattore.di.rischio") + "</strong></td>";
        str+="</tr></table>";
        str+="<table border='0' align='left' width='784' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
        str+="<td width='392' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
        str+="<td width='392' class='dataTd'><input type='text' name='NOM_FAT_RSO' class='dataInput' readonly  value=''></td></tr>";
        if ( bean!=null ){
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_Rischi_View rc=(AttLav_Rischi_View)it.next();
                str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_RSO_MAN+"'>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 392px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_RSO)+"\" ></td>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 392px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_FAT_RSO)+"\" ></td>";
                        str+="</tr>";
                }
        }// bean = null
        //----------------------
        str+="</table>";
        return str;
}
//------------------------------------------------------------------------

/* 	IAttivitaLavorative bean = exsempliar of AttivitaLavorative
*/
String BuildCorsiTab(IAttivitaLavorative bean)
{
        String str="";
        java.util.Collection col = bean.getCorsi_View();
        str+="<table border='0' align='left' width='784' id='CorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str+="<td width='392'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.corso") + "</strong></td>";
        str+="<td width='392'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia.corso") + "</strong></td>";
        str+="</tr></table>";
        str+="<table border='0' align='left' width='784' id='Corsi' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
        str+="<td width='392' class='dataTd'><input type='text' name='NOM_COR' class='dataInput' readonly  value=''></td>";
        str+="<td width='392' class='dataTd'><input type='text' name='NOM_TPL_COR' class='dataInput' readonly  value=''></td></tr>";
        if ( bean!=null ){
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_Corsi_View rc=(AttLav_Corsi_View)it.next();
                str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_COR+"'>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 392px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_COR)+"\" ></td>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 392px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_TPL_COR)+"\" ></td>";
                        str+="</tr>";
                }
        }// bean = null
        //----------------------
        str+="</table>";
        return str;
}
//------------------------------------------------------------------------

/* 	IAttivitaLavorative bean = exsempliar of AttivitaLavorative
*/
String BuildProtocoliSanitariTab(IAttivitaLavorative bean)
{
        String str="";
        java.util.Collection col = bean.getProtocoliSanitari_View();
        str+="<table border='0' align='left' width='784' id='ProtocoliSanitariHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str+="<td width='784'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
        str+="</tr></table>";
        str+="<table border='0' align='left' width='784' id='ProtocoliSanitari' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
        str+="<td width='784' class='dataTd'><input type='text' name='NOM_PRO_SAN' class='dataInput' readonly  value=''></td></tr>";
        if ( bean!=null ){
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_ProtocoliSanitari_View rc=(AttLav_ProtocoliSanitari_View)it.next();
                str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_PRO_SAN+"'>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 784px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_PRO_SAN)+"\" ></td>";
                        str+="</tr>";
                }
        }// bean = null
        //----------------------
        str+="</table>";
        return str;
}
//------------------------------------------------------------------------

/* 	IAttivitaLavorative bean = exsempliar of AttivitaLavorative
*/
String BuildDPITab(IAttivitaLavorative bean)
{
        String str="";
        java.util.Collection col = bean.getDPI_View();
        str+="<table border='0' align='left' width='784' id='DPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
        str+="<td width='784'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I.") + "</strong></td>";
        str+="</tr></table>";
        str+="<table border='0' align='left' width='784' id='DPI' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
        str+="<td width='784' class='dataTd'><input type='text' name='NOM_TPL_DPI' class='dataInput' readonly  value=''></td></tr>";
        if ( bean!=null ){
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_DPI_View rc=(AttLav_DPI_View)it.next();
                str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_TPL_DPI+"'>";
                        str+="<td class='dataTd'><input type='text' readonly style='width: 784px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_TPL_DPI)+"\" ></td>";
                        str+="</tr>";
                }
        }// bean = null
        //----------------------
        str+="</table>";
        return str;
}

/* 	RischioChimico
*/
String BuildRischioChimicoTab(IAttivitaLavorative bean)
{
        String str="";
        try{
                java.util.Collection col = bean.getRischioChimico_View();
                str+="<table border='0' align='left' width='784' id='RischioChimicoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
                str+="<td width='300' nowrap><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Operazione.svolta") + "</strong></td>";
                str+="<td width='300' nowrap><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Agente.chimico") + "</strong></td>";
                str+="<td width='184' nowrap><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Indice.di.rischio") + "</strong></td>";
                str+="</tr></table>";
                str+="<table border='0' align='left' width='784' id='RischioChimico' class='dataTable' cellpadding='0' cellspacing='0'>";
                str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
                str+="<td width='300' class='dataTd'><input type='text' name='NOM_OPE_SVO' class='dataInput' readonly  value=''></td>";
                str+="<td width='300' class='dataTd'><input type='text' name='DES_SOS' class='dataInput' readonly  value=''></td></tr>";
                if ( bean!=null )
                {
                        java.util.Iterator it = col.iterator();
                        while(it.hasNext()){
                                AttLav_RischioChimico_View rc=(AttLav_RischioChimico_View)it.next();

                    str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_OPE_SVO+","+rc.COD_SOS_CHI+"'>";
                                str+="<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_OPE_SVO)+"\" ></td>";
                                str+="<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_COM_SOS)+"\" ></td>";
                                str+="<td class='dataTd'><input type='text' readonly style='width: 184px;' class='inputstyle'  value=\""+Formatter.format(rc.IDX_RSO_CHI)+"\"></td>";
                                str+="</tr>";
                }
                }
                str+="</table>";
        }
        catch(Exception e){
                e.printStackTrace();
        }
        return str;
}

String BuildMacchinaTab(IAttivitaLavorative bean) {
        String str;
        java.util.Collection col = bean.getMacchina_View();

        str="<table border='0' align='left' width='784' id='MacchinaHeader1' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str+="<tr><td width='558'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong></td>";
        str+="<td width='226'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td></tr>";
        str+="</table>";
        str+="<table border='0' align='left' width='784' id='Macchina1' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'><td width='558' class='dataTd'><input type='text' name='IDE_MAC' class='dataInput' readonly  value=''></td>";
        str+="<td width='226' class='dataTd'><input type='text' name='DES_MAC' readonly class='dataInput'  value=''></td></tr>";
if ( bean!=null )
                {
                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        MacchinaByAttivitaLavorative_View view=(MacchinaByAttivitaLavorative_View)it.next();
                        str+="<tr style='display:' ID='"+Formatter.format(view.COD_MAC)+"' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>"
                                + "<td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 558px;'  value=\""+Formatter.format(view.IDE_MAC)+"\"></td>";
                        str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 226px;' class='inputstyle'  value=\""+Formatter.format(view.DES_MAC)+"\"></td></tr>";
        }}
        str+="</table>";
        return str;
}

String BuildDocumentiTab(IAttivitaLavorative bean) {
        String str;
        java.util.Collection col = bean.getDocumenti_View();

        str="<table border='0' align='left' width='784' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
        str+="<tr><td width='445'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
        str+="<td width='239'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
                str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
        str+="</table>";
        str+="<table border='0' align='left' width='784' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
        str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'><td width='445' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
        str+="<td width='239' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
        str+="<td width='100' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";

                java.util.Iterator it = col.iterator();
                while(it.hasNext()){
                        AttLav_Documenti_View view=(AttLav_Documenti_View)it.next();
                        str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_DOC)+"' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'><td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 445px;'  value=\""+Formatter.format(view.strTIT_DOC)+"\"></td>";
                        str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 239px;' class='inputstyle'  value=\""+Formatter.format(view.strRSP_DOC)+"\"></td>";
                        str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(view.dtDAT_REV_DOC)+"\"></td></tr>";
        }
        str+="</table>";
        return str;
}

String BuildAgentiChimiciTab(IAttivitaLavorative bean)
{
	String str="";
	java.util.Collection col = bean.getAgentiChimici_View();
	str+="<table border='0' align='left' width='784' id='AgentiChimiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='394'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.sostanza") + "</strong></td>";
	str+="<td width='390'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='784' id='AgentiChimici' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MAN())+"'>";
	str+="<td width='394' class='dataTd'><input type='text' name='NOM_COM_SOS' class='dataInput' readonly  value=''></td>";
	str+="<td width='390' class='dataTd'><input type='text' name='DES_CLF_SOS' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			Attivitalavorativa_AgentiChimici_View rc=(Attivitalavorativa_AgentiChimici_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_MAN())+"' ID='"+rc.COD_SOS_CHI+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 394px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_COM_SOS)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 390px;' class='inputstyle'  value=\""+Formatter.format(rc.DES_CLF_SOS)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null
	str+="</table>";
	return str;
}

//====================================================================================================
%>
