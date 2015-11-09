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
    <version number="1.0" date="01/03/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="01/03/2004" author="Khomenko Juliya">
				   <description>Create SCH_DOC_Tabs.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
	long lCOD_AZL=0;	
	String strTPL_DOC="";
	String strCAG_DOC="";
	java.sql.Date dDAT_REV_D=null;
	java.sql.Date dDAT_REV_A=null;
	String strTIT_DOC="";
	String strRSP_DOC="";
	String strREV_DOC="";
	String strNB_ORDER="";
	//--- per sort
	String strSORT_DAT_REV = ", 'a'.'dat_rev_doc' desc ";
  String strSORT_TPL_DOC = "X";
	//--- per imagine
	
Checker c = new Checker();

if (request.getParameter("COD_AZL")!=null) lCOD_AZL=c.checkLong("Azienda",request.getParameter("COD_AZL"),true);
if (request.getParameter("TPL_DOC")!=null) strTPL_DOC=c.checkString("Dati Tipologie",request.getParameter("TPL_DOC"),false);
if (request.getParameter("CAG_DOC")!=null)  strCAG_DOC=c.checkString("Dati Categorie",request.getParameter("CAG_DOC"),false);
if (request.getParameter("DAT_REV_D")!=null) dDAT_REV_D=c.checkDate("Data Revisione dal",request.getParameter("DAT_REV_D"),false);
if (request.getParameter("DAT_REV_A")!=null) dDAT_REV_A=c.checkDate("Data Revisione al",request.getParameter("DAT_REV_A"),false);
if (request.getParameter("TIT_DOC")!=null) strTIT_DOC=c.checkString("Titolo",request.getParameter("TIT_DOC"),false);
if (request.getParameter("RSP_DOC")!=null)  strRSP_DOC=c.checkString("Responsabile",request.getParameter("RSP_DOC"),false);
if (request.getParameter("REV_DOC")!=null)  strREV_DOC=c.checkString("Revisione",request.getParameter("REV_DOC"),false);
if (request.getParameter("NB_ORDER")!=null)  strNB_ORDER=c.checkString("Order by",request.getParameter("NB_ORDER"),false);
//---- per sort
if (request.getParameter("SORT_DAT_REV")!=null) strSORT_DAT_REV=c.checkString("",request.getParameter("SORT_DAT_REV"),false);
if (request.getParameter("SORT_TPL_DOC")!=null) strSORT_TPL_DOC=c.checkString("",request.getParameter("SORT_TPL_DOC"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

IAnagrDocumentoHome home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");

if ((dDAT_REV_D!=null)&&(dDAT_REV_A!=null)){
	if (dDAT_REV_D.compareTo(dDAT_REV_A)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0081\"]);</script>");
		return;
	}
}

//--- create table
	String str="";
//	out.println("<br>home.getAnagrDocumento_to_SCH_DOC_View("+lCOD_AZL+","+ strTPL_DOC+","+ strCAG_DOC+","+ strTIT_DOC+","+ strRSP_DOC+","+ strREV_DOC+","+ dDAT_REV_D+","+ dDAT_REV_A+","+ strNB_ORDER);
	java.util.Collection col_doc = home.getAnagrDocumento_to_SCH_DOC_View(lCOD_AZL, strTPL_DOC, strCAG_DOC, strTIT_DOC, strRSP_DOC, strREV_DOC, dDAT_REV_D, dDAT_REV_A, strNB_ORDER, strSORT_DAT_REV, strSORT_TPL_DOC);

	java.util.Date cdt=new java.util.Date();
	java.sql.Date dtDAT_REV = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());

	String strImg="";
	String strCOLOR="";
	long difTime=0;

	out.print("<div id=divFile>");
	out.print("<table border='0' align='left' width='873' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
	java.util.Iterator it_doc = col_doc.iterator();
		if (it_doc.hasNext()) {
			out.print("<script>if (parent.curOpen==1) parent.document.all['imgDR'].style.display='';parent.curOpen=2;parent.document.all['TDsortDR'].style.cursor='hand';  parent.document.all['TDsortTD'].style.cursor='hand';</script>");
		} else {
		out.print("<script>	parent.document.all['TDsortDR'].style.cursor='';  parent.document.all['TDsortTD'].style.cursor='';</script>");
		}

 		while(it_doc.hasNext()){
			AnagrDocumento_to_SCH_DOC_View doc=(AnagrDocumento_to_SCH_DOC_View)it_doc.next();
//--- per imagine
      strImg="&nbsp;";
			strCOLOR="";
      difTime = dtDAT_REV.getTime()-doc.DAT_REV_DOC.getTime();
	    difTime = difTime/1000/3600/24;
			if (doc.DAT_REV_DOC!=null) strCOLOR="black";
			if (dtDAT_REV.compareTo(doc.DAT_REV_DOC)==0)  strCOLOR="blue";
			if (doc.DAT_REV_DOC.compareTo(dtDAT_REV)<0) {
				strCOLOR="red";
	      if (difTime==1) strImg="<img src='../_images/1-r.gif' alt='1'>";
	      else if (difTime==2) strImg="<img src='../_images/2-r.gif' alt='2'>";
	      else if (difTime==3) strImg="<img src='../_images/3-r.gif' alt='3'>";
	      else if (difTime==4) strImg="<img src='../_images/4-r.gif' alt='4'>";
	      else if (difTime>=5) strImg="<img src='../_images/5-r.gif' alt='5'>";
			}
	    out.print("<tr ID='tr"+doc.COD_DOC+"' class=listTr ondblclick='goDOC();' onclick='selTabStr("+doc.COD_DOC+", 4, \"COD_DOC\")'>");
			out.print("<td width='40' >"+strImg+"&nbsp;</td>");
			out.print("<td class='sdataTd'><input id='inp1"+doc.COD_DOC+"' style='width:140; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(doc.DAT_REV_DOC)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp2"+doc.COD_DOC+"' style='width:231; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(doc.NOM_TPL_DOC)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp3"+doc.COD_DOC+"' style='width:231; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(doc.NOM_CAG_DOC)+"\"></td>");
			out.print("<td class='sdataTd'><input id='inp4"+doc.COD_DOC+"' style='width:231; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(doc.RAG_SCL_AZL)+"\"></td>");
			out.print("</tr>");
  		}
	out.print("</table></div>");
	//out.print(str);
%>

<script>
  parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>

