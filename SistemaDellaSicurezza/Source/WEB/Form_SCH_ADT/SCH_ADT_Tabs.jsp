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

<%@ page import="com.apconsulting.luna.ejb.RapportiniSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%//@ include file="../src/com/apconsulting/luna/ejb/AttivitaSegnalazione/AttivitaSegnalazioneBean_Interfaces.jsp" %>
<%//@ include file="../src/com/apconsulting/luna/ejb/AttivitaSegnalazione/AttivitaSegnalazioneBean.jsp" %>

<%
Checker c = new Checker();
	long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),true);
	long lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Lavoratore"),request.getParameter("COD_DPD"),false);
	String strTIT_SGZ     = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),request.getParameter("TIT_SGZ"),false);
	String strNOM_RIL_SGZ = c.checkString(ApplicationConfigurator.LanguageManager.getString("Rilevatore"),request.getParameter("NOM_RIL_SGZ"),false);
	java.sql.Date dDAT_SGZ_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.segnalazione.dal"),request.getParameter("DAT_SGZ_DAL"),false);
	java.sql.Date dDAT_SGZ_AL  = c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_SGZ_AL"),false);
	java.sql.Date dDAT_SCA_DAL = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.scadenza.dal"),request.getParameter("DAT_SCA_DAL"),false);
	java.sql.Date dDAT_SCA_AL  = c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_SCA_AL"),false);
	String strRG_GROUP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"),request.getParameter("RG_GROUP"),true);
	String strSTA_INT  = c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"),request.getParameter("STA_INT"),false);
if (c.isError){
	String err = c.printErrors();
	out.print("<script>err=true;alert(\""+err+"\");</script>");
	return;
}
if ((dDAT_SGZ_DAL!=null)&&(dDAT_SGZ_AL!=null)){
	if (dDAT_SGZ_DAL.compareTo(dDAT_SGZ_AL)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0076\"]);</script>");
		return;
	}
}
if ((dDAT_SCA_DAL!=null)&&(dDAT_SCA_AL!=null)){
	if (dDAT_SCA_DAL.compareTo(dDAT_SCA_AL)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0077\"]);</script>");
		return;
	}
}
String strVAR_SGZ=request.getParameter("SORT_DAT_SGZ");
String strVAR_SCA=request.getParameter("SORT_DAT_SCA");

IRapportiniSegnalazione      bean = null;
IRapportiniSegnalazioneHome  home = (IRapportiniSegnalazioneHome)PseudoContext.lookup("RapportiniSegnalazioneBean");
	String str="";
	java.util.Collection col_view = home.getRapportini_View(lCOD_AZL, lCOD_DPD, strTIT_SGZ, strNOM_RIL_SGZ, dDAT_SGZ_DAL, dDAT_SGZ_AL, dDAT_SCA_DAL, dDAT_SCA_AL, strRG_GROUP, strSTA_INT, strVAR_SGZ, strVAR_SCA);
	java.util.Iterator it_view = col_view.iterator();

	out.print("<div id=divFile><table border='0' id='ListTableHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='844'>");
  out.print("<tr><td width='40'></td>");
	out.print("<td width='150' ");
	  if( strRG_GROUP.equals("N") && (it_view.hasNext()) ) out.print("onclick=\"orderColumn('dsgz')\" style='cursor:hand'");
		out.print("><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.segnalazione.dal") + "</strong>&nbsp;");
	out.print("<img src='");
	
	  if( strVAR_SGZ.equals(" DESC ") && strRG_GROUP.equals("N") ){out.print("../_images/ORDINE_UP.GIF' alt='up");
	  }else out.print("../_images/ORDINE_DOWN.gif' alt='down");
	  if( strVAR_SGZ.equals("X") || (!strRG_GROUP.equals("N")) || (!it_view.hasNext()) ) out.print("' style='display:none");
	  out.print("' id='imgDataSegnal'></td>");
  out.print("<td width='140' ");
	  if( strRG_GROUP.equals("N") && (it_view.hasNext()) ) out.print("onclick=\"orderColumn('dsca')\" style='cursor:hand'");
		out.print("><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.scadenza.dal") + "</strong>&nbsp;");
	out.print("<img src='");
	  if( strVAR_SCA.equals(" DESC ") && strRG_GROUP.equals("N") ){out.print("../_images/ORDINE_UP.GIF' alt='up");
	  }else out.print("../_images/ORDINE_DOWN.gif' alt='down");
	  if( strVAR_SCA.equals("X") || (!strRG_GROUP.equals("N")) || (!it_view.hasNext()) ) out.print("' style='display:none");
	  out.print("' id='imgDataScad'></td>");
  out.print("<td width='243'><strong>" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>");
  out.print("<td width='253'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Azienda/Ente") + "</strong></td>");
 // out.print("<td width='18'></td>");
	out.print("</tr></table>");
	
	out.print("<table border='0' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0' width=''>");
	out.print("<tr style='display:none' ID='' >");
	out.print("<td class='dataTd'><input type='text' name='DAT_SGZ'      readonly class='dataInput' value='' size=10></td>");
	out.print("<td class='dataTd'><input type='text' name='DAT_SCA'      readonly class='dataInput' value='' size=10></td>");
	out.print("<td class='dataTd'><input type='text' name='tNOM_RSP_INR' readonly class='dataInput' value=''></td>");
	out.print("<td class='dataTd'><input type='text' name='tAZL'         readonly class='dataInput' value=''></td></tr>");
//Block vibora tsveta stroki zakomentirovan v sootvetstvii s ishodnikom
	java.util.Date cdt=new java.util.Date();
	java.sql.Date dtDAT = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
	long difTime=0;

 	while(it_view.hasNext()){
		Rapportini_View view=(Rapportini_View)it_view.next();
		String strImg="&nbsp;";
		String strCOLOR="";
    difTime = dtDAT.getTime()-view.DAT_SGZ.getTime();
	  difTime = difTime/1000/3600/24;
		if (difTime==0 && view.DAT_SCA==null) strCOLOR="blue";
		if (view.DAT_SCA!=null)  strCOLOR="green";
		if (difTime>0 && view.DAT_SCA==null) {
			strCOLOR="red";
	    if (difTime==1) strImg="<img src='../_images/1-r.gif' alt='1'>";
	    else if (difTime==2) strImg="<img src='../_images/2-r.gif' alt='2'>";
	    else if (difTime==3) strImg="<img src='../_images/3-r.gif' alt='3'>";
	    else if (difTime==4) strImg="<img src='../_images/4-r.gif' alt='4'>";
	    else if (difTime>=5) strImg="<img src='../_images/5-r.gif' alt='5'>";
		}

    out.print("<tr ID='tr"+Formatter.format(view.COD_ATI_SGZ)+"' ");
		out.print(" class=listTr onclick=\"selTrSCH_ADT(4,"+view.COD_ATI_SGZ+","+Formatter.format(view.COD_SGZ)+")\" ondblclick='showDetailSCH_ADT()'>");
		out.print("<td width='40' style='border-left:none;border-bottom:none;border-top:none;'>"+strImg+"</td>");
		out.print("<td class='dataTd'><input id='inp1"+view.COD_ATI_SGZ+"' type='text' readonly style='width:150; name='DAT_SGZ' class='dataInput'  value='"+Formatter.format(view.DAT_SGZ)+"' style='color:"+strCOLOR+"'></td>");
		out.print("<td class='dataTd'><input id='inp2"+view.COD_ATI_SGZ+"' type='text' readonly style='width:140; name='DAT_SCA' class='dataInput'  value='"+Formatter.format(view.DAT_SCA)+"' style='color:"+strCOLOR+"'></td>");
		out.print("<td class='dataTd'><input id='inp3"+view.COD_ATI_SGZ+"' type='text' readonly style='width:243; name='NOM_RSP_INR' class='dataInput' value='"+Formatter.format(view.NOM_DPD)+" "+Formatter.format(view.COG_DPD)+"' style='color:"+strCOLOR+"'></td>");
		out.print("<td class='dataTd'><input id='inp4"+view.COD_ATI_SGZ+"' type='text' readonly style='width:253; name='AZL' class='dataInput'  value='"+Formatter.format(view.RAG_SCL_AZL)+"' style='color:"+strCOLOR+"'></td>");
		out.print("</tr>");
 	}
	out.print("</table></div>");
//	out.print(str);
%>
<script>
 parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
