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

<div id="div_s">
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
//-----------------------------------------------------------------------------------------

// String RG_GROUP, long NB_COC_MAC, long NB_COC_DPD, String NB_ATI_SVO
long lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
String strTYPE="";
String strSCH_MAC="";
String strSTA_INT="";
String NB_COD_MAC="0";
String NB_COD_DPD="0";
String NB_ATI_SVO="";
String RG_GROUP="";
java.sql.Date dDAT_PIF_INR_DAL=null;
java.sql.Date dDAT_PIF_INR_AL;
java.sql.Date dDAT_ATI_MNT_DAL=null;
java.sql.Date dDAT_ATI_MNT_AL=null;
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
  strTYPE=request.getParameter("TYPE");
}
//out.print(strTYPE);
  strSTA_INT=request.getParameter("STA_INT");
	RG_GROUP=request.getParameter("R_T");
	strSCH_MAC=request.getParameter("SCH_MAC");
	NB_COD_MAC=request.getParameter("COD_MAC");
  dDAT_PIF_INR_AL=c.checkDate("Data Pianif. AL",request.getParameter("DAT_PIF_AL"),false);
	dDAT_PIF_INR_DAL=c.checkDate("Data Pianif. DAL",request.getParameter("DAT_PIF_DAL"),false);
	dDAT_ATI_MNT_AL=c.checkDate("Data Intervento al",request.getParameter("DAT_EFT_AL"),false);
	dDAT_ATI_MNT_DAL=c.checkDate("Data Intervento dal",request.getParameter("DAT_EFT_DAL"),false);
	NB_COD_DPD=request.getParameter("COD_DPD");
	NB_ATI_SVO=request.getParameter("ATI_SVO");
	if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
	if ((dDAT_ATI_MNT_DAL!=null)&&(dDAT_ATI_MNT_AL!=null))
	{
	  if (dDAT_ATI_MNT_DAL.compareTo(dDAT_ATI_MNT_AL)>0)
		{
		  out.print("<script>parent.alert(arraylng[\"MSG_0085\"]);</script>");
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
	int i=0;
ISchedaAttivitaSegnalazioneHome home=(ISchedaAttivitaSegnalazioneHome)PseudoContext.lookup("SchedaAttivitaSegnalazioneBean");
	  java.util.Collection col = home.getMacchina_for_SCHMAC_View(lCOD_AZL, strSCH_MAC, strSTA_INT, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_ATI_MNT_DAL, dDAT_ATI_MNT_AL, RG_GROUP, new Long(NB_COD_MAC).longValue(), new Long(NB_COD_DPD).longValue(), NB_ATI_SVO, strTYPE);
	  out.print("<table border='0' class='dataTable' cellpadding='0' cellspacing='0' width='861'>");
	    java.util.Iterator it = col.iterator();
 		  while(it.hasNext()){
			  COLOR_TXT="";
				IMAGE="";
				Macchina_for_SCHMAC_View d=(Macchina_for_SCHMAC_View)it.next();
				out.print("<tr class='listTr' ID='tr"+d.COD_SCH_ATI_MNT+"' ondblclick='goSCH_MNT();' onclick='selTabStr("+d.COD_SCH_ATI_MNT+", 5, \"COD_SCH_ATI_MNT\")'>");
				if((dtDAT_INZ.compareTo(d.DAT_PIF_INR)>0)&&(d.DAT_ATI_MNT==null))
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
				if((dtDAT_INZ.compareTo(d.DAT_PIF_INR)==0)&&(d.DAT_ATI_MNT==null))
				{
				  COLOR_TXT="style='color:blue;'";
				}
				if(d.DAT_ATI_MNT!=null)
				{
				  COLOR_TXT="style='color:green;'";
				}
				out.print("<td width='40' style='border-left:none;border-bottom:none;border-top:none;'>");
				if (COLOR_TXT.equals("style='color:red;'"))
				{
				out.print("<img src='"+IMAGE+"'>");
				}
				out.print("</td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp1"+d.COD_SCH_ATI_MNT+"' readonly style='width: 120px;' class='dataInput' value=\""+Formatter.format(d.DAT_PIF_INR)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp2"+d.COD_SCH_ATI_MNT+"' readonly style='width: 120px;' class='dataInput' value=\""+Formatter.format(d.DAT_ATI_MNT)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp3"+d.COD_SCH_ATI_MNT+"' readonly style='width: 191px;' class='dataInput' value=\""+Formatter.format(d.DIP)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp4"+d.COD_SCH_ATI_MNT+"' readonly style='width: 190px;' class='dataInput' value=\""+Formatter.format(d.DES_MAC)+"\"></td>");
				out.print("<td class='sdataTd'><input "+COLOR_TXT+" type='text' id='inp5"+d.COD_SCH_ATI_MNT+"' readonly style='width: 200px;' class='dataInput' value=\""+Formatter.format(d.RAG_SCL_AZL)+"\"></td>");
				out.print("</tr>");
  			//out.print(d.SQL_QUY);
				i++;
				
			}
	out.print("</table>");
	//out.print(str);
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
