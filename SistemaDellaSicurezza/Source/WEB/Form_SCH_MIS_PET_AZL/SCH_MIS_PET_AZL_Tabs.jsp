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
    <version number="1.0" date="04/03/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="04/03/2004" author="Mike Kondratyuk">
				   <description>Create SCH_MIS_PET_AZL_Tabs.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
	long lCOD_AZL=0;
	long lCOD_MIS_PET_LUO_MAN=0;
	String strAPL_A="";
	String strNOM_MIS_PET="";
	String strDES_TPL_MIS_PET="";
	String strNOM_RSO="";
	java.sql.Date dDAT_PNZ_MIS_PET_DAL=null;
	java.sql.Date dDAT_PNZ_MIS_PET_AL=null;
	String strGROUP="";
	String strVAR_PAR_ADT="X";

Checker c = new Checker();
out.print(request.getParameter("NB_DES_TPL_MIS_PET")+"<br>");

if (request.getParameter("COD_AZL")!=null) lCOD_AZL=c.checkLong("Azienda",request.getParameter("COD_AZL"),true);
if (request.getParameter("NB_COD_MIS_PET_LUO_MAN")!=null) lCOD_MIS_PET_LUO_MAN=c.checkLong("Misura",request.getParameter("NB_COD_MIS_PET_LUO_MAN"),false);
if (request.getParameter("NB_APL_A")!=null)  strAPL_A=c.checkString("",request.getParameter("NB_APL_A"),false);
if (request.getParameter("NB_NOM_MIS_PET")!=null) strNOM_MIS_PET=c.checkString("Misura di Prevenzione/Protezione",request.getParameter("NB_NOM_MIS_PET"),false);
if (request.getParameter("NB_DES_TPL_MIS_PET")!=null) strDES_TPL_MIS_PET=c.checkString("Tipologia",request.getParameter("NB_DES_TPL_MIS_PET"),false);
if (request.getParameter("NB_NOM_RSO")!=null) strNOM_RSO=c.checkString("Rischio",request.getParameter("NB_NOM_RSO"),false);
if (request.getParameter("NB_DAT_PNZ_MIS_PET_DAL")!=null) dDAT_PNZ_MIS_PET_DAL=c.checkDate("Data Pianificazione dal",request.getParameter("NB_DAT_PNZ_MIS_PET_DAL"),false);
if (request.getParameter("NB_DAT_PNZ_MIS_PET_AL")!=null) dDAT_PNZ_MIS_PET_AL=c.checkDate("Data Pianificazione al",request.getParameter("NB_DAT_PNZ_MIS_PET_AL"),false);
if (request.getParameter("NB_GROUP")!=null)  strGROUP=c.checkString("Raggruppati per",request.getParameter("NB_GROUP"),false);
if (request.getParameter("VAR_PAR_ADT")!=null)  strVAR_PAR_ADT=c.checkString("Order by",request.getParameter("VAR_PAR_ADT"),false);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}

IMisurePreventProtettiveAzHome home=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");

if ((dDAT_PNZ_MIS_PET_DAL!=null)&&(dDAT_PNZ_MIS_PET_AL!=null)){
	if (dDAT_PNZ_MIS_PET_DAL.compareTo(dDAT_PNZ_MIS_PET_AL)>0) {
		out.print("<script>parent.alert(arraylng[\"MSG_0079\"]);</script>");
		return;
	}
}

//--- create table
	String str="";
//	out.println("<br>home.getAnagrDocumento_to_SCH_DOC_View("+lCOD_AZL+","+ strTPL_DOC+","+ strCAG_DOC+","+ strTIT_DOC+","+ strRSP_DOC+","+ strREV_DOC+","+ dDAT_REV_D+","+ dDAT_REV_A+","+ strNB_ORDER);
	java.util.Collection col = home.getMisurePreventProtettiveAz_foo_View(lCOD_AZL, lCOD_MIS_PET_LUO_MAN, strAPL_A, strNOM_MIS_PET, strDES_TPL_MIS_PET,strNOM_RSO, dDAT_PNZ_MIS_PET_DAL, dDAT_PNZ_MIS_PET_AL, strGROUP, strVAR_PAR_ADT);

	java.util.Date cdt=new java.util.Date();
	java.sql.Date dtDAT_REV = new java.sql.Date(cdt.getYear(),cdt.getMonth(),cdt.getDate());

	String strImg="&nbsp;";
	String strCOLOR="";
	long difTime=0;

	out.print("<div id=divFile>");
	out.print("<table border='0' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
	out.print("<tr style='display:none' ID=''>");
	out.print("<td width='30'>&nbsp;</td>");
	out.print("<td width='110' class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td>");
	out.print("<td width='200' class='dataTd'><input type='text' name='NOM_TPL_DOC' readonly class='dataInput'  value=''></td>");
	out.print("<td width='200' class='dataTd'><input type='text' name='NOM_CAG_DOC' readonly class='dataInput'  value=''></td>");
	out.print("<td width='160' class='dataTd'><input type='text' name='NB_AZL_DOC' readonly class='dataInput'  value=''></td></tr>");
		java.util.Iterator it_doc = col.iterator();
		if (it_doc.hasNext()) {
			//out.print("<script>if (parent.curOpen==1) parent.curOpen=2;parent.document.all['sort_SCH_MIS_PET_AZL'].style.cursor='hand';</script>");
                         out.print("<script>if (parent.curOpen==1)parent.document.all['imgDR'].style.display=''; parent.curOpen=2;</script>");
		}
		else{
			out.print("<script>parent.document.all['sort_SCH_MIS_PET_AZL'].style.cursor='';</script>");
		}

 		while(it_doc.hasNext()){
			MisurePreventProtettiveAz_foo_View obj=(MisurePreventProtettiveAz_foo_View)it_doc.next();
//--- per imagine
			strImg="&nbsp;";
			strCOLOR="";
			difTime = dtDAT_REV.getTime()-obj.DAT_PNZ_MIS_PET.getTime();
			difTime = difTime/1000/3600/24;
			if (obj.DAT_PNZ_MIS_PET!=null) strCOLOR="green"; 
			if (dtDAT_REV.compareTo(obj.DAT_PNZ_MIS_PET)==0)  strCOLOR="blue";
			if (obj.DAT_PNZ_MIS_PET.compareTo(dtDAT_REV)<0) {
				strCOLOR="red";
				if (difTime==1) strImg="<img src='../_images/1-r.gif' alt='1'>";
				else if (difTime==2) strImg="<img src='../_images/2-r.gif' alt='2'>";
				else if (difTime==3) strImg="<img src='../_images/3-r.gif' alt='3'>";
				else if (difTime==4) strImg="<img src='../_images/4-r.gif' alt='4'>";
				else if (difTime>=5) strImg="<img src='../_images/5-r.gif' alt='5'>";
			}
         		out.print("<tr ID='tr"+obj.COD_MIS_PET_AZL+"' class=listTr ondblclick='goMIS_PET_AZL();' onclick='selTabStr("+obj.COD_MIS_PET_AZL+", 4, \"COD_MIS_PET_AZL\")'>");
			out.print("<td width='40' >"+strImg+"&nbsp;</td>");
			out.print("<td class='sdataTd' ><input id='inp1"+obj.COD_MIS_PET_AZL+"' style='width:110; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_PNZ_MIS_PET)+"\"></td>");
			out.print("<td class='sdataTd' ><input id='inp2"+obj.COD_MIS_PET_AZL+"' style='width:200; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DES_TPL_MIS_PET)+"\"></td>");
			out.print("<td class='sdataTd' ><input id='inp3"+obj.COD_MIS_PET_AZL+"' style='width:200; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOM_MIS_PET)+"\"></td>");
			out.print("<td class='sdataTd' ><input id='inp4"+obj.COD_MIS_PET_AZL+"' style='width:160; color:"+strCOLOR+"' type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.RAG_SCL_AZL)+"\"></td>");
			out.print("</tr>");
  		}
	out.print("</table></div>");
	//out.print(str);
%>

<script>
  parent.document.all['div_s'].innerHTML=document.all['divFile'].innerHTML;
</script>

