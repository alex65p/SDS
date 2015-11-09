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

<%@ page import="com.apconsulting.luna.ejb.ErogazioneCorsi.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

  out.print("ok");
	long lCOD_AZL=new Long(request.getParameter("COD_AZL")).longValue();
	java.sql.Date dDAT_PIF_EGZ_COR_DAL=null;
	java.sql.Date dDAT_PIF_EGZ_COR_AL=null;
	java.sql.Date dEFF_DAT_DAL=null;
	java.sql.Date dEFF_DAT_AL=null;
	long lNOM_COR=0;
	String lNOM_DCT="";
	String strRAGGRUPPATI="N";
	String strSTA_INT="";
	//--- per sort
  String strTYPE="";
java.util.Date cdt=new java.util.Date();
java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
Checker c = new Checker();
String COLOR_TXT="";
String IMAGE="";
long range=0;
if (request.getParameter("TYPE")!=null)
{
  strTYPE=request.getParameter("TYPE");
}
out.print(strTYPE);
if (request.getParameter("NOM_DCT")!=null)  lNOM_DCT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Docente"),request.getParameter("NOM_DCT"),false);

if (request.getParameter("NOM_COR")!=null) lNOM_COR=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_COR"),false);

if (request.getParameter("DAT_PIF_EGZ_COR_DAL2")!=null) dDAT_PIF_EGZ_COR_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"),request.getParameter("DAT_PIF_EGZ_COR_DAL2"),false);

if (request.getParameter("DAT_PIF_EGZ_COR_AL2")!=null) dDAT_PIF_EGZ_COR_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_PIF_EGZ_COR_AL2"),false);

if (request.getParameter("EFF_DAT_DAL2")!=null) dEFF_DAT_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal"),request.getParameter("EFF_DAT_DAL2"),false);

if (request.getParameter("EFF_DAT_AL2")!=null) dEFF_DAT_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("EFF_DAT_AL2"),false);

if (request.getParameter("R_RAGGRUPPATI")!=null) strRAGGRUPPATI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"),request.getParameter("R_RAGGRUPPATI"),false);

//************************ SORT ******************* 

if (request.getParameter("STA_INT")!=null)  strSTA_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"),request.getParameter("STA_INT"),false);

if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
  out.println("<br>lCOD_AZL="+lCOD_AZL);
	out.println("<br>lNOM_DCT="+lNOM_DCT);
	out.println("<br>lNOM_COR="+lNOM_COR);
	out.println("<br>dDAT_PIF_EGZ_COR_DAL="+dDAT_PIF_EGZ_COR_DAL);
	out.println("<br>dDAT_PIF_EGZ_COR_AL="+dDAT_PIF_EGZ_COR_AL);
	out.println("<br>strSTA_INT="+strSTA_INT);
	out.println("<br>dEFF_DAT_DAL="+dEFF_DAT_DAL);
	out.println("<br>dEFF_DAT_AL="+dEFF_DAT_AL);
	
	out.println("<br>strRAGGRUPPATI="+strRAGGRUPPATI);
	out.println("<br>strTYPE="+strTYPE);

	if ((dEFF_DAT_DAL!=null)&&(dEFF_DAT_AL!=null))
	{
	  if (dEFF_DAT_DAL.compareTo(dEFF_DAT_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0078\"]);</script>");
		  return;
		}
	}
	if ((dDAT_PIF_EGZ_COR_DAL!=null)&&(dDAT_PIF_EGZ_COR_AL!=null))
	{
	  if (dDAT_PIF_EGZ_COR_DAL.compareTo(dDAT_PIF_EGZ_COR_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		  return;
		}
	}

//String , String , String , String 
	
IErogazioneCorsiHome home=(IErogazioneCorsiHome)PseudoContext.lookup("ErogazioneCorsiBean");
	
//--- create table
	String str;
//out.print(strTYPE);
	//return;
	java.util.Collection col_nr = home.getScadenzario_Corsi_View(lCOD_AZL, lNOM_COR, lNOM_DCT, dDAT_PIF_EGZ_COR_DAL, dDAT_PIF_EGZ_COR_AL, strSTA_INT,  dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE);
	
	out.print("<div id=divFile>");
	
	//long	COD_CTL_SAN, COD_VST_MED, COD_DPD, COD_AZL;
	
	out.print("<table border='0' align='left' width='816' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
		java.util.Iterator it_nr = col_nr.iterator();
		int i=0;
 		while(it_nr.hasNext()){
		COLOR_TXT="";
				IMAGE="";
		Scadenzario_Corsi_View nr=(Scadenzario_Corsi_View)it_nr.next();
	  	 	out.print("<tr class='listTr' ID='tr"+nr.COD_SCH_EGZ_COR+"_"+i+"' ondblclick='goEGZ_COR();' onclick='selTabStr("+nr.COD_SCH_EGZ_COR+", 5, \"COD_SCH_EGZ_COR\", "+i+")'>");
			if((dtDAT_INZ.compareTo(nr.DAT_PIF_EGZ_COR)>0)&&(nr.DAT_EFT_EGZ_COR==null))
				{
				  COLOR_TXT="style='color:red;'";
					range=dtDAT_INZ.getTime() - nr.DAT_PIF_EGZ_COR.getTime();
					
					if(range/ (1000*3600*24)==1)
					{
					  IMAGE="../_images/1-r.gif";
					}
					if(range/ (1000*3600*24)==2)
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
				if((dtDAT_INZ.compareTo(nr.DAT_PIF_EGZ_COR)==0)&&(nr.DAT_EFT_EGZ_COR==null))
				{
				  COLOR_TXT="style='color:blue;'";
				}
				if(nr.DAT_EFT_EGZ_COR!=null)
				{
				  COLOR_TXT="style='color:green;'";
				}
				out.print("<td width='40' style='border-left:none;border-bottom:none;border-top:none;'>");
				if (COLOR_TXT.equals("style='color:red;'"))
				{
				out.print("<img src='"+IMAGE+"'>");
				}
				out.print("</td>");
				out.print("<td class='sdataTd'><input id='inp1"+nr.COD_SCH_EGZ_COR+"_"+i+"' "+COLOR_TXT+" type='text' readonly style='width: 140px;' class='dataInput'  style='width:90'  value=\""+Formatter.format(nr.DAT_PIF_EGZ_COR)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp2"+nr.COD_SCH_EGZ_COR+"_"+i+"' "+COLOR_TXT+" type='text' readonly style='width: 140px;' class='dataInput' style='width:150' value=\""+Formatter.format(nr.DAT_EFT_EGZ_COR)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp3"+nr.COD_SCH_EGZ_COR+"_"+i+"' "+COLOR_TXT+" type='text' readonly style='width: 166px;' class='dataInput' style='width:190' value=\""+Formatter.format(nr.NOM_DCT)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp4"+nr.COD_SCH_EGZ_COR+"_"+i+"' type='text' "+COLOR_TXT+" readonly style='width: 165px;' class='dataInput' style='width:190' value=\""+Formatter.format(nr.NOM_COR)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp5"+nr.COD_SCH_EGZ_COR+"_"+i+"' type='text' "+COLOR_TXT+" readonly style='width: 165px;' class='dataInput' style='width:156' value=\""+Formatter.format(nr.RAG_SCL_AZL)+"\"></td>");
				out.print("</tr>");
				i++;
  		}
	out.print("<script>parent.document.all['kolTr'].value="+i+";</script>");
	out.print("</table></div>");
	//out.print(str);
%>

<script>
parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
<%
if(i>0)
{
%>
<script>
if(parent.document.all['first'].value!="1")
{
  parent.document.all['pifTd'].style.cursor='hand';
  parent.document.all['eftTd'].style.cursor='hand';
  parent.document.all['pifDw'].style.display='';
  parent.document.all['first'].value="1";
}
</script>
<%
}
%>
