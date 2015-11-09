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
    <version number="1.0" date="03/03/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="03/03/2004" author="Khomenko Juliya">
				   <description>Create SCH_PSD_ACD_Tabs.jsp</description>
				  </comment>
        </comments>
    </version>
  </versions>
</file>
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%@ page import="com.apconsulting.luna.ejb.Presidi.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>



<%
	long lCOD_AZL=0;
	long lCOD_CAG_PSD_ACD=0;
	String SCH_PSD_ACD="";
	String strSTA_INT="";
	String strCAG_DOC="";
	String strNOM_RSP_INR="";
	String strNOM_CAG_PSD_ACD="";
	String strIDE_PSD_ACD="";
	//--- per sort
	String strRAGGRUPPATI="";
	String strSORT_PIF=", a.dat_pif_inr desc ";
	String strSORT_INT="X";
	String strSORT_RSP="X";

	java.sql.Date dDAT_PIF_INR_DAL=null;
	java.sql.Date dDAT_PIF_INR_AL=null;
	java.sql.Date dDAT_INR_DAL=null;
	java.sql.Date dDAT_INR_AL=null;
	//--- per imagine

Checker c = new Checker();

if (request.getParameter("COD_AZL")!=null) lCOD_AZL=c.checkLong("Azienda",request.getParameter("COD_AZL"),true);
if (request.getParameter("COD_CAG_PSD_ACD")!=null) lCOD_CAG_PSD_ACD=c.checkLong("COD_CAG_PSD_ACD",request.getParameter("COD_CAG_PSD_ACD"),false);

SCH_PSD_ACD=request.getParameter("SCH_PSD_ACD");
if (request.getParameter("STA_INT")!=null)  strSTA_INT=c.checkString("STA_INT",request.getParameter("STA_INT"),false);
if (request.getParameter("CAG_DOC")!=null) strCAG_DOC=c.checkString("CAG_DOC",request.getParameter("CAG_DOC"),false);
if (request.getParameter("NOM_RSP_INR")!=null)  strNOM_RSP_INR=c.checkString("Dati Categorie",request.getParameter("NOM_RSP_INR"),false);
if (request.getParameter("NOM_CAG_PSD_ACD")!=null) strNOM_CAG_PSD_ACD=c.checkString("NOM_CAG_PSD_ACD",request.getParameter("NOM_CAG_PSD_ACD"),false);
if (request.getParameter("IDE_PSD_ACD")!=null)  strIDE_PSD_ACD=c.checkString("IDE_PSD_ACD",request.getParameter("IDE_PSD_ACD"),false);

if (request.getParameter("DAT_PIF_INR_DAL")!=null) dDAT_PIF_INR_DAL=c.checkDate("DAT_PIF_INR_DAL",request.getParameter("DAT_PIF_INR_DAL"),false);
if (request.getParameter("DAT_PIF_INR_AL")!=null) dDAT_PIF_INR_AL=c.checkDate("DAT_PIF_INR_AL",request.getParameter("DAT_PIF_INR_AL"),false);
if (request.getParameter("DAT_INR_DAL")!=null) dDAT_INR_DAL=c.checkDate("DAT_INR_DAL",request.getParameter("DAT_INR_DAL"),false);
if (request.getParameter("DAT_INR_AL")!=null) dDAT_INR_AL=c.checkDate("DAT_INR_AL",request.getParameter("DAT_INR_AL"),false);
//---- per sort
if (request.getParameter("RAGGRUPPATI")!=null) strRAGGRUPPATI=c.checkString("RAGGRUPPATI",request.getParameter("RAGGRUPPATI"),false);
if (request.getParameter("SORT_PIF")!=null) strSORT_PIF=c.checkString("SORT_PIF",request.getParameter("SORT_PIF"),false);
if (request.getParameter("SORT_INT")!=null) strSORT_INT=c.checkString("SORT_INT",request.getParameter("SORT_INT"),false);
if (request.getParameter("SORT_RSP")!=null) strSORT_RSP=c.checkString("SORT_RSP",request.getParameter("SORT_RSP"),false);
//out.println("<script>alert(\""+request.getParameter("SCH_PSD_ACD")+"\");</script>");
	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

IPresidiHome home=(IPresidiHome)PseudoContext.lookup("PresidiBean");

if ((dDAT_PIF_INR_DAL!=null)&&(dDAT_PIF_INR_AL!=null)){
	if (dDAT_PIF_INR_DAL.compareTo(dDAT_PIF_INR_AL)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		return;
	}
}

if (strSTA_INT.equals("D")){
    dDAT_INR_DAL=null;
		dDAT_INR_AL=null;
} else {
  if ((dDAT_INR_DAL!=null)&&(dDAT_INR_AL!=null)){
	  if (dDAT_INR_DAL.compareTo(dDAT_INR_AL)>0) {
		  out.print("<script>parent.alert(arraylng[\"MSG_0085\"]);</script>");
		  return;
	  }
  }
}

//--- create table
	String str="";

//	out.println("<br>home.getPresidi_to__View("+lCOD_AZL+","+ strTPL_DOC+","+ strCAG_DOC+","+ strTit_psd+","+ strRSP_DOC+","+ strREV_DOC+","+ dDAT_REV_D+","+ dDAT_REV_A+","+ strNB_ORDER);
	java.util.Collection col_psd = home.getPresidi_to_SCH_PSD_ACD_View(SCH_PSD_ACD, lCOD_AZL, strSTA_INT, strCAG_DOC, strNOM_RSP_INR, lCOD_CAG_PSD_ACD, strNOM_CAG_PSD_ACD,  strIDE_PSD_ACD, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_INR_DAL, dDAT_INR_AL, strRAGGRUPPATI, strSORT_PIF, strSORT_INT, strSORT_RSP);

	java.util.Date cdt=new java.util.Date();
	java.sql.Date dtDAT_REV = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());

	String strImg="";
	String strCOLOR="";
	long difTime=0;

	out.print("<div id=divFile>");
	out.print("<table border='0' align='left' width='753' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
		java.util.Iterator it_psd = col_psd.iterator();
		if (it_psd.hasNext()) {
			out.print("<script>if (parent.curOpen==1) parent.document.all['imgPIF'].style.display='';parent.curOpen=2;parent.document.all['TDsortPIF'].style.cursor='hand';  parent.document.all['TDsortINT'].style.cursor='hand';  parent.document.all['TDsortRSP'].style.cursor='hand';</script>");
		} else {
		out.print("<script>	parent.document.all['TDsortPIF'].style.cursor='';  parent.document.all['TDsortINT'].style.cursor='';  parent.document.all['TDsortRSP'].style.cursor='';</script>");
		}

 		while(it_psd.hasNext()){
			Presidi_to_SCH_PSD_ACD_View psd=(Presidi_to_SCH_PSD_ACD_View)it_psd.next();
//--- per imagine
      strImg="&nbsp;";
			strCOLOR="";
      difTime = dtDAT_REV.getTime()-psd.DAT_PIF_INR.getTime();
	    difTime = difTime/1000/3600/24;
			if (psd.DAT_INR!=null) strCOLOR="green";
			if (dtDAT_REV.compareTo(psd.DAT_PIF_INR)==0 && psd.DAT_INR==null )  strCOLOR="blue";
			if (psd.DAT_PIF_INR.compareTo(dtDAT_REV)<0  && psd.DAT_INR==null ) {
				strCOLOR="red";
	      if (difTime==1) strImg="<img src='../_images/1-r.gif' alt='1'>";
	      else if (difTime==2) strImg="<img src='../_images/2-r.gif' alt='2'>";
	      else if (difTime==3) strImg="<img src='../_images/3-r.gif' alt='3'>";
	      else if (difTime==4) strImg="<img src='../_images/4-r.gif' alt='4'>";
	      else if (difTime>=5) strImg="<img src='../_images/5-r.gif' alt='5'>";
			}
	    out.print("<tr ID='tr"+psd.COD_PSD_ACD+"' class=listTr ondblclick='goDOC();' onclick='selTabStr("+psd.COD_PSD_ACD+",5, \"COD_PSD_ACD\")'>");
			out.print("<td width='40' >"+strImg+"&nbsp;</td>");
			out.print("<td class='sdataTd'><input id='inp1"+psd.COD_PSD_ACD+"' style='width:110; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(psd.DAT_PIF_INR)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp2"+psd.COD_PSD_ACD+"' style='width:110; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(psd.DAT_INR)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp3"+psd.COD_PSD_ACD+"' style='width:165; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(psd.NOM_RSP_INR)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp4"+psd.COD_PSD_ACD+"' style='width:164; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(psd.NOM_CAG_PSD_ACD)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp5"+psd.COD_PSD_ACD+"' style='width:164; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(psd.RAG_SCL_AZL)+"\"></td>");
			out.print("</tr>");
  		}
	out.print("</table></div>");
	//out.print(str);
%>

<script>
  parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>
