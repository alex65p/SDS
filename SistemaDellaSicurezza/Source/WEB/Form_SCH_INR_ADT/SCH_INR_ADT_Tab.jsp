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

<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//-----------------------------------------------------------------------------------------------

long			  lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
String strTYPE="";
String newNOM_MAN="";
String strNOM_MIS_PET="";
String strDES_INTERVENTO="";
String strNOM_LUO_FSC="";
String strNOM_MIS_PET_LUO_MAN="";
String strNOM_RSP_INR="";
java.sql.Date dtDT_EFT_DAL=null;
java.sql.Date dtDT_EFT_AL=null;
java.sql.Date dtDT_PIF_DAL=null;
java.sql.Date dtDT_PIF_AL=null;
String strSTA_INT="";
String strRG_GROUP=""; 
String strINR_ADT_AZL=""; 
String strNB_APL_A="";
String str="";
String strSel="";
String COLOR_TXT="";
Checker c = new Checker();
java.util.Date cdt=new java.util.Date();
java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
//out.print(lCOD_AZL);
String IMAGE="";
long range=0;
if (request.getParameter("TYPE")!=null)
{
  strTYPE=c.checkString("type",request.getParameter("TYPE"),false);
}
out.print(strTYPE);
  if(request.getParameter("STA_INT")!=null)strSTA_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.intervento"),request.getParameter("STA_INT"),false);
	strRG_GROUP=c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"),request.getParameter("R_T"),true);
	strINR_ADT_AZL=c.checkString("Intervento Aziendali",request.getParameter("INR_ADT_AZL"),false);
    if(!"N".equals(strINR_ADT_AZL))
	{
	  strINR_ADT_AZL="S";
	}
   
	strNB_APL_A=c.checkString("Luogo Fisico/Attivita lavorativa radio",request.getParameter("R_APL_A"),true);
    if(request.getParameter("DAT_PIF_AL")!=null)dtDT_PIF_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_PIF_AL"),false);
	if(request.getParameter("DAT_PIF_DAL")!=null)dtDT_PIF_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"),request.getParameter("DAT_PIF_DAL"),false);
	if(request.getParameter("DAT_EFT_AL")!=null)dtDT_EFT_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_EFT_AL"),false);
	if(request.getParameter("DAT_EFT_DAL")!=null)dtDT_EFT_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal"),request.getParameter("DAT_EFT_DAL"),false);
	if(request.getParameter("COD_DPD")!=null)strNOM_RSP_INR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"),request.getParameter("COD_DPD"),false);
	if(request.getParameter("COD_MIS_PET_LUO_MAN")!=null)strNOM_MIS_PET_LUO_MAN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Misura"),request.getParameter("COD_MIS_PET_LUO_MAN"),false);
	if(request.getParameter("COD_LUO_FSC")!=null)strNOM_LUO_FSC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),request.getParameter("COD_LUO_FSC"),false);
	if(request.getParameter("DES_INTER")!=null)strDES_INTERVENTO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.intervento"),request.getParameter("DES_INTER"),false);
	if(request.getParameter("COD_MIS_PET")!=null)strNOM_MIS_PET=c.checkString("Luogo Fisico",request.getParameter("COD_MIS_PET"),false);
	//out.print("str="+strNOM_MIS_PET_LUO_MAN);
	if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
	if ((dtDT_EFT_DAL!=null)&&(dtDT_EFT_AL!=null))
	{
	  if (dtDT_EFT_DAL.compareTo(dtDT_EFT_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0078\"]);</script>");
		  return;
		}
	}
	if ((dtDT_PIF_DAL!=null)&&(dtDT_PIF_AL!=null))
	{
	  if (dtDT_PIF_DAL.compareTo(dtDT_PIF_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		  return;
		}
	}
	int i=0;
IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
      
	  java.util.Collection col = home.getGestioneInterventoAudit_SCH_View(lCOD_AZL, strNOM_MIS_PET_LUO_MAN, dtDT_PIF_DAL, dtDT_PIF_AL, dtDT_EFT_DAL, dtDT_EFT_AL, strNOM_MIS_PET, strNOM_RSP_INR, strNOM_LUO_FSC, strDES_INTERVENTO, strSTA_INT, strRG_GROUP, strINR_ADT_AZL,strNB_APL_A, strTYPE);
      %><div id="div_s"><%
		out.print("<table border='0' align=left' width='862' class='dataTable' cellpadding='0' cellspacing='0'>");
	    java.util.Iterator it = col.iterator();
        while(it.hasNext()){
			  COLOR_TXT="";
				IMAGE="";
				GestioneInterventoAudit_SCH_View d=(GestioneInterventoAudit_SCH_View)it.next();
				out.print("<tr class='listTr' ID='tr"+d.COD_INR_ADT+"' ondblclick='goINR_ADT();' onclick='selTabStr("+d.COD_INR_ADT+", 5, \"COD_ADT\")'>");
				if((dtDAT_INZ.compareTo(d.DAT_PIF_INR)>0)&&(d.DAT_ADT==null))
				{
				  COLOR_TXT="style='color:red;'";
					range=dtDAT_INZ.getTime() - d.DAT_PIF_INR.getTime();
                
					if(range/ (1000*3600*24)==1)
					{
					  IMAGE="../_images/1-r.gif";
					}
					if(range/( 1000*3600*24)==2)
					{
					  IMAGE="../_images/2-r.gif";
					}
					if(range/ (1000*3600*24)==3)
					{
					  IMAGE="../_images/3-r.gif";
					}
					if(range/ (1000*3600*24)==4)
					{
					  IMAGE="../_images/4-r.gif";
					}
					if(range/ (1000*3600*24)>=5)
					{
					  IMAGE="../_images/5-r.gif";
					}
				}
				if((dtDAT_INZ.compareTo(d.DAT_PIF_INR)==0)&&(d.DAT_ADT==null))
				{
				  COLOR_TXT="style='color:blue;'";
				}
				if(d.DAT_ADT!=null)
				{
				  COLOR_TXT="style='color:green;'";
				}
				out.print("<td width='40' style='border-left:none;border-bottom:none;border-top:none;'>");
				if (COLOR_TXT.equals("style='color:red;'"))
				{
				out.print("<img src='"+IMAGE+"'>");
				}
                out.print("</td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp1"+d.COD_INR_ADT+"' readonly style='width: 140px;' class='dataInput' value=\""+Formatter.format(d.DAT_PIF_INR)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp2"+d.COD_INR_ADT+"' readonly style='width: 140px;' class='dataInput' value=\""+Formatter.format(d.DAT_ADT)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp3"+d.COD_INR_ADT+"' readonly style='width: 182px;' class='dataInput' value=\""+Formatter.format(d.COG_DPD)+"&nbsp;"+Formatter.format(d.NOM_DPD)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp4"+d.COD_INR_ADT+"' readonly style='width: 180px;' class='dataInput' value=\""+Formatter.format(d.RAG_SCL_AZL)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp5"+d.COD_INR_ADT+"' readonly style='width: 180px;' class='dataInput' value=\""+Formatter.format(d.NOM_LUO_FSC)+"\"></td>");
                out.print("</tr>");
  				i++;}
	out.print("</table>");

out.print("<script>parent.document.all['kolTr'].value="+i+";</script>");

%>
</div>
<script>
  parent.document.all['divFile'].innerHTML=document.all['div_s'].innerHTML;
</script>
<%
if(i>0)
{
%>
<script>
if(parent.document.all['first'].value!="1")
{
  parent.document.all['pifTd'].style.cursor='hand';
  parent.document.all['adtTd'].style.cursor='hand';
  parent.document.all['pifDw'].style.display='';
  parent.document.all['first'].value="1";
}
</script>
<%
}
%>
