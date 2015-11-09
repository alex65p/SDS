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
/*
<file>
  <versions>	
    <version number="1.0" date="28/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="28/01/2004" author="Kushkarov Yura">
				   <description>SCH_EGZ_COR_Util.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/

String ErogazioneCorsiTab(IErogazioneCorsiHome home, long COD_SCH_EGZ_COR, String RAG_AZL)
{
	String str;
	String sRAG_SCL="";
	java.util.Collection col_rst = home.getErogazioneCorsi_ForTabDPD_View(COD_SCH_EGZ_COR);
	str="<table border='0' align='left' width='750' id='ErogazioneCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td  align='center' width=''><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo.lavoratore") + "</strong></td>";
	str+="<td align='center' width=''><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Azienda/Ente") + "</strong></td>";
	str+="<td align='center' width=''><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Matricola") + "</strong></td></tr>";
	str+="</table>";
	
	str+="<table border='1' id='ErogazioneCorsi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_SCH_EGZ_COR)+"\"><td width='47%' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='33%' class='dataTd'><input type='text' name='TIT_DOC' readonly class='dataInput'  value=''></td><td width='' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( COD_SCH_EGZ_COR!=0 ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			ErogazioneCorsi_ForTabDPD_View rst=(ErogazioneCorsi_ForTabDPD_View)it_rst.next();
	    if (rst.COD_AZL!=0)
	     {
				   sRAG_SCL = home.getErogazioneCorsi_ForTabByAZL_View(rst.COD_AZL);
	     }
			else
			 {
			   if (rst.COD_DTE!=0){
			     sRAG_SCL=home.getErogazioneCorsi_ForTabByDTE_View(rst.COD_DTE);
			   }
			 }
	    str+="<tr INDEX=\""+Formatter.format(COD_SCH_EGZ_COR)+"\" ID=\""+rst.COD_DPD+"\">";
			str+="<td class='dataTd' width='47%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.COG_DPD)+" "+Formatter.format(rst.NOM_DPD)+"\"></td>";
			str+="<td class='dataTd' width='33%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(RAG_AZL)+"\"></td>";
			str+="<td class='dataTd' width=''><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.MTR_DPD)+"\"></td>";
			str+="</tr>";
  		}
	}// 	
	str+="</table>";
	return str;
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
String BuildCORBox(IErogazioneCorsiHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getErogazioneCorsi_SelectData_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
	  ErogazioneCorsi_SelectData_View  dt = (ErogazioneCorsi_SelectData_View)it.next();
	  long var1=dt.COD_COR;
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==var1){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+var1+"\">"+dt.NOM_COR+"</option>";
		//+"&nbsp;&nbsp;/&nbsp;&nbsp;"+dt.NOM_TPL_COR+"&nbsp;&nbsp;/&nbsp;&nbsp;"+dt.DUR_COR_GOR+"
  	}
	return str;
}


%>
