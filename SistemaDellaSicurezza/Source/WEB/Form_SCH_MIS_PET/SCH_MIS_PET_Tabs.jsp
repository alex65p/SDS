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
    <version number="1.0" date="01/03/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="01/03/2004" author="Alexey Kolesnik">
				   <description> Template created </description>
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
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%
Checker c = new Checker();
	
	long lCOD_AZL = 0;
	String strNB_APL_A = "";
	String strNB_GROUP = "";
	long lCOD_MIS_PET = 0;
	long lCOD_TPL_MIS_PET = 0;
	String strNB_NOM_MIS_PET = "";
	String strNB_NOM_RSO = "";
	String strNB_DES_TPL_MIS_PET = "";
	long lCOD_MIS_PET_LUO_MAN = 0;
	java.sql.Date dNB_DAT_PNZ_MIS_PET_DAL = null;
	java.sql.Date dNB_DAT_PNZ_MIS_PET_AL = null;
	java.sql.Date dNB_DAT_CMP_DAL = null;
	java.sql.Date dNB_DAT_CMP_AL = null;
	String strSORT_DAT_PAR_ADT = "X";
	
	if (request.getParameter("COD_AZL")!=null) lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZL"),false);
	if (request.getParameter("NB_APL_A")!=null) strNB_APL_A=c.checkString("Azienda",request.getParameter("NB_APL_A"),false);
		if (strNB_APL_A == null || strNB_APL_A.equals("")) { strNB_APL_A = "M"; }
	if (request.getParameter("NB_GROUP")!=null) strNB_GROUP=c.checkString("Azienda",request.getParameter("NB_GROUP"),false);
		if (strNB_GROUP == null || strNB_GROUP.equals("")) { strNB_GROUP = "N"; }
	if (request.getParameter("COD_MIS_PET")!=null) lCOD_MIS_PET = c.checkLong("Misura di Prevenzione",request.getParameter("COD_MIS_PET"),false);
	if (request.getParameter("COD_TPL_MIS_PET")!=null) lCOD_TPL_MIS_PET = c.checkLong("Misura di Prevenzione",request.getParameter("COD_TPL_MIS_PET"),false);

  if (request.getParameter("NB_DAT_PNZ_MIS_PET_DAL")!=null) dNB_DAT_PNZ_MIS_PET_DAL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.pianificazione.dal"),request.getParameter("NB_DAT_PNZ_MIS_PET_DAL"),false);
  if (request.getParameter("NB_DAT_PNZ_MIS_PET_AL")!=null) dNB_DAT_PNZ_MIS_PET_AL=c.checkDate(ApplicationConfigurator.LanguageManager.getString("al"),request.getParameter("NB_DAT_PNZ_MIS_PET_AL"),false);

  //------ by Juli ---------
  if (request.getParameter("NOM_RSO")!=null)  strNB_NOM_RSO=c.checkString("NB_NOM_RSO",request.getParameter("NOM_RSO"),false);
  if (request.getParameter("NOM_MIS_PET")!=null)  strNB_NOM_MIS_PET=c.checkString("NB_NOM_MIS_PET",request.getParameter("NOM_MIS_PET"),false);
  if (request.getParameter("NB_DES_TPL_MIS_PET")!=null)  strNB_DES_TPL_MIS_PET=c.checkString("NB_DES_TPL_MIS_PET",request.getParameter("NB_DES_TPL_MIS_PET"),false);
  if (request.getParameter("COD_MIS_PET_LUO_MAN")!=null)  lCOD_MIS_PET_LUO_MAN=c.checkLong("COD_MIS_PET_LUO_MAN",request.getParameter("COD_MIS_PET_LUO_MAN"),false);
  //-------------------------
	if (request.getParameter("SORT_DAT_PAR_ADT")!=null) strSORT_DAT_PAR_ADT=c.checkString("Data Pianif.",request.getParameter("SORT_DAT_PAR_ADT"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

if ((dNB_DAT_PNZ_MIS_PET_DAL!=null)&&(dNB_DAT_PNZ_MIS_PET_AL!=null)){
	if (dNB_DAT_PNZ_MIS_PET_DAL.compareTo(dNB_DAT_PNZ_MIS_PET_AL)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		return;
	}
}
//	IMisuraPreventiva bean = null;
	IMisuraPreventivaHome MisuraHome=(IMisuraPreventivaHome)PseudoContext.lookup("MisuraPreventivaBean");
	
//--- create table
	String str;
	out.println("<br>lCOD_AZL="+lCOD_AZL);
	out.println("<br>strNB_APL_A="+strNB_APL_A);
	out.println("<br>strNB_GROUP="+strNB_GROUP);
	out.println("<br>lCOD_MIS_PET="+lCOD_MIS_PET);
	out.println("<br>lCOD_TPL_MIS_PET="+lCOD_TPL_MIS_PET);
	out.println("<br>strNB_NOM_MIS_PET="+strNB_NOM_MIS_PET);
	out.println("<br>strNB_NOM_RSO="+strNB_NOM_RSO);
	out.println("<br>strNB_DES_TPL_MIS_PET="+strNB_DES_TPL_MIS_PET);
	out.println("<br>lCOD_MIS_PET_LUO_MAN="+lCOD_MIS_PET_LUO_MAN);
	out.println("<br>dNB_DAT_PNZ_MIS_PET_DAL="+dNB_DAT_PNZ_MIS_PET_DAL);
	out.println("<br>dNB_DAT_PNZ_MIS_PET_AL="+dNB_DAT_PNZ_MIS_PET_AL);
//	return;

	java.util.Collection col_nr = MisuraHome.getMisuraPreventiva_to_SCH_MIS_PET_View(lCOD_AZL, strNB_APL_A, strNB_NOM_RSO, lCOD_MIS_PET_LUO_MAN, strNB_NOM_MIS_PET, strNB_DES_TPL_MIS_PET,  dNB_DAT_CMP_DAL, dNB_DAT_CMP_AL, dNB_DAT_PNZ_MIS_PET_DAL, dNB_DAT_PNZ_MIS_PET_AL, strNB_GROUP, strSORT_DAT_PAR_ADT);

	java.util.Date cdt=new java.util.Date();
	java.sql.Date dtDAT_REV = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());
	String strImg="";
	String strCOLOR="";
	long difTime=0;
	long i = 1;
//	out.print(dtDAT_REV);

	out.print("<div id=divFile><table border='0' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0' width='796'>");

		java.util.Iterator it_nr = col_nr.iterator();
		if (it_nr.hasNext()) {
			//out.print("<script>if (parent.curOpen==1) parent.curOpen=2;</script>");
                        out.print("<script>if (parent.curOpen==1)parent.document.all['imgDP'].style.display=''; parent.curOpen=2;</script>");
		}

 		while(it_nr.hasNext()){
			MisuraPreventiva_to_SCH_MIS_PET_View nr=(MisuraPreventiva_to_SCH_MIS_PET_View)it_nr.next();

			strImg="&nbsp;";
			strCOLOR="green";
			strImg="<img src='../_images/blank-r.gif' width=32 height=10 alt=''>";
			if (nr.DAT_PNZ_MIS_PET!=null) {
  			difTime = dtDAT_REV.getTime()-nr.DAT_PNZ_MIS_PET.getTime();
  			difTime = difTime/1000/3600/24;
  			//if (nr.DAT_PNZ_MIS_PET!=null) strCOLOR="green"; 
  			if (dtDAT_REV.compareTo(nr.DAT_PNZ_MIS_PET)==0)  strCOLOR="blue";
  			if (nr.DAT_PNZ_MIS_PET.compareTo(dtDAT_REV)<0) {
  				strCOLOR="red";
  				if (difTime==1) strImg="<img src='../_images/1-r.gif' alt='1'>";
  				else if (difTime==2) strImg="<img src='../_images/2-r.gif' alt='2'>";
  				else if (difTime==3) strImg="<img src='../_images/3-r.gif' alt='3'>";
  				else if (difTime==4) strImg="<img src='../_images/4-r.gif' alt='4'>";
  				else if (difTime>=5) strImg="<img src='../_images/5-r.gif' alt='5'>";
  			}
			}

	    i++;
			out.print("<tr INDEX=\""+Formatter.format(nr.COD_AZL)+"\" ID=\"tr"+i+"\" class=listTr onclick='selTrSCH_MIS_PET(4,"+i+")' ondblclick='showDetailSCH_MIS_PET()'>");
			out.print("<td width='40' >"+strImg+"&nbsp;</td>");
			out.print("<td class='sdataTd'><input type='text' id='inp1"+i+"' readonly class='dataInput' style='width:140; color:"+strCOLOR+";'  value=\""+Formatter.format(nr.DAT_PNZ_MIS_PET)+"\">");
			if (strNB_APL_A.equals("L")) {
				 			out.print("<input type='hidden' id='nCOD_MIS_RSO_LUO"+i+"' value=\""+nr.COD_MIS_RSO_LUO+"\">");
				 			out.print("<input type='hidden' id='nCOD_RSO_LUO_FSC"+i+"' value=\""+nr.COD_RSO_LUO_FSC+"\">");
				 			out.print("<input type='hidden' id='nCOD_LUO_FSC"+i+"' value=\""+nr.COD_LUO_FSC+"\">");
			} else {
				 			out.print("<input type='hidden' id='nCOD_MIS_PET_MAN"+i+"' value=\""+nr.COD_MIS_PET_MAN+"\">");
				 			out.print("<input type='hidden' id='nCOD_RSO_MAN"+i+"' value=\""+nr.COD_RSO_MAN+"\">");
				 			out.print("<input type='hidden' id='nCOD_MAN"+i+"' value=\""+nr.COD_MAN+"\">");
			}
			out.print("</td>");
			out.print("<td class='sdataTd'><input type='text' id='inp2"+i+"' readonly class='dataInput' style='width:180; color:"+strCOLOR+";' value=\""+Formatter.format(nr.DES_TPL_MIS_PET)+"\"></td>");
			out.print("<td class='sdataTd'><input type='text' id='inp3"+i+"' readonly class='dataInput' style='width:246; color:"+strCOLOR+";' value=\""+Formatter.format(nr.NOM_MIS_PET)+"\"></td>");
			out.print("<td class='sdataTd'><input type='text' id='inp4"+i+"' readonly class='dataInput' style='width:190; color:"+strCOLOR+";' value=\""+Formatter.format(nr.RAG_SCL_AZL)+"\"></td>");
			out.print("</tr>");
  	}
	out.print("</table></div>");

%>


<script>
	<%
	if (strNB_APL_A.equals("L")) {
	%>
	parent.document.all['tabNome'].innerHTML = "<strong>Nome Luogo Fisico</strong>";
	<%
	} else {
	%>
	parent.document.all['tabNome'].innerHTML = "<strong>Nome Mansione</strong>";
	<%
	}
	%>
  if (parent.document.all['div_s'] && document.all['divFile']) {
		 parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
	}
</script>
