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

<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server


	long lCOD_AZL=new Long(request.getParameter("COD_AZL")).longValue();	

	java.sql.Date dDAT_PIF_INR_DAL=null;
	java.sql.Date dDAT_PIF_INR_AL=null;
	java.sql.Date dEFF_DAT_DAL=null;
	java.sql.Date dEFF_DAT_AL=null;
	long lNOM_RES=0;
	String lNOM_COR="";
	String strRAGGRUPPATI="N";
	String strSTA_INT="";
	String FR=request.getParameter("strFROM");
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

if (request.getParameter("NOM_COR")!=null)  lNOM_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile"),request.getParameter("NOM_COR"),false);

if (request.getParameter("NOM_RES")!=null) lNOM_RES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.D.P.I."),request.getParameter("NOM_RES"),false);

if (request.getParameter("DAT_PIF_INR_DAL")!=null) dDAT_PIF_INR_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"),request.getParameter("DAT_PIF_INR_DAL"),false);

if (request.getParameter("DAT_PIF_INR_AL")!=null) dDAT_PIF_INR_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("DAT_PIF_INR_AL"),false);

if (request.getParameter("EFF_DAT_DAL")!=null) dEFF_DAT_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.effettuazione.dal"),request.getParameter("EFF_DAT_DAL"),false);

if (request.getParameter("EFF_DAT_AL")!=null) dEFF_DAT_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("EFF_DAT_AL"),false);

if (request.getParameter("R_RAGGRUPPATI")!=null) strRAGGRUPPATI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Raggruppati.per"),request.getParameter("R_RAGGRUPPATI"),false);

//************************ SORT ******************* 
//if (request.getParameter("SORT_DAT_PIF")!=null) strSORT_DAT_PIF=c.checkString("",request.getParameter("SORT_DAT_PIF"),false);

//if (request.getParameter("SORT_DAT_EFT")!=null) strSORT_DAT_EFT=c.checkString("",request.getParameter("SORT_DAT_EFT"),false);

if (request.getParameter("STA_INT")!=null)  strSTA_INT=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.misura"),request.getParameter("STA_INT"),false);
//<comment>Added by Podmasteriev at 10/03/2004
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
//</comment>

  out.println("<br>lCOD_AZL="+lCOD_AZL);
	out.println("<br>lNOM_COR="+lNOM_COR);
	out.println("<br>lNOM_RES="+lNOM_RES);
	out.println("<br>dDAT_PIF_INR_DAL="+dDAT_PIF_INR_DAL);
	out.println("<br>dDAT_PIF_INR_AL="+dDAT_PIF_INR_AL);
	out.println("<br>strSTA_INT="+strSTA_INT);
	out.println("<br>dEFF_DAT_DAL="+dEFF_DAT_DAL);
	out.println("<br>dEFF_DAT_AL="+dEFF_DAT_AL);
	out.println("<br>FR="+FR);

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
	if ((dDAT_PIF_INR_DAL!=null)&&(dDAT_PIF_INR_AL!=null))
	{
	  if (dDAT_PIF_INR_DAL.compareTo(dDAT_PIF_INR_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		  return;
		}
	}

//String , String , String , String 
	
IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
	
//--- create table
	//String str;
	out.print(strTYPE);
	//return;
	java.util.Collection col_nr = home.getScadenzario_DPI_View(lCOD_AZL,lNOM_RES  ,lNOM_COR, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, strSTA_INT,  dEFF_DAT_DAL, dEFF_DAT_AL, strRAGGRUPPATI, strTYPE, FR);
	out.print("<div id=divFile>");
	
	//long	COD_CTL_SAN, COD_VST_MED, COD_DPD, COD_AZL;
	
	
	
	out.print("<table border='0' align='left' width='856' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
		java.util.Iterator it_nr = col_nr.iterator();
		int i=1;
 		while(it_nr.hasNext()){
		Scadenzario_DPI_View nr=(Scadenzario_DPI_View)it_nr.next();
	  	 	COLOR_TXT="";
				IMAGE="";
				out.print("<tr class='listTr' ID='tr"+nr.COD_SCH_INR_DPI+"_"+i+"' ondblclick='goEGZ_COR();' onclick='selTabStr("+nr.COD_SCH_INR_DPI+", 5, \"COD_SCH_INR_DPI\", "+i+")'>");
			if((dtDAT_INZ.compareTo(nr.DAT_PIF_INR)>0)&&(nr.DAT_INR==null))
				{
				  COLOR_TXT="style='color:red;'";
					range=dtDAT_INZ.getTime() - nr.DAT_PIF_INR.getTime();
					
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
				if((dtDAT_INZ.compareTo(nr.DAT_PIF_INR)==0)&&(nr.DAT_INR==null))
				{
				  COLOR_TXT="style='color:blue;'";
				}
				if(nr.DAT_INR!=null)
				{
				  COLOR_TXT="style='color:green;'";
				}
				out.print("<td width='40'>");
				if (COLOR_TXT.equals("style='color:red;'"))
				{
				out.print("<img src='"+IMAGE+"'>");
				}
				else
								{
				out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
				}
				out.print("</td>");
				out.print("<td class='sdataTd'><input id='inp1"+nr.COD_SCH_INR_DPI+"_"+i+"' "+COLOR_TXT+" type='text' readonly class='dataInput' style='width:140' value=\""+Formatter.format(nr.DAT_PIF_INR)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp2"+nr.COD_SCH_INR_DPI+"_"+i+"' "+COLOR_TXT+" type='text' readonly class='dataInput' style='width:140' value=\""+Formatter.format(nr.DAT_INR)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp3"+nr.COD_SCH_INR_DPI+"_"+i+"' "+COLOR_TXT+" type='text' readonly class='dataInput' style='width:180' value=\""+Formatter.format(nr.IDE_LOT_DPI)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp4"+nr.COD_SCH_INR_DPI+"_"+i+"' type='text' "+COLOR_TXT+" readonly class='dataInput' style='width:178' value=\""+Formatter.format(nr.NOM_TPL_DPI)+"\"></td>");
				out.print("<td class='sdataTd'><input id='inp5"+nr.COD_SCH_INR_DPI+"_"+i+"' type='text' "+COLOR_TXT+" readonly class='dataInput' style='width:178' value=\""+Formatter.format(nr.RAG_SCL_AZL)+"\"></td>");
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
