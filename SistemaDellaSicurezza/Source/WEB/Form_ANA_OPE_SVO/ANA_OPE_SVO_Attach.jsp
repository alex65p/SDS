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
    <version number="1.0" date="11/02/2004" author="Roman Chumachenko">
	   <comments>
		  <comment date="11/02/2004" author="Roman Chumachenko">
			<description>ANA_OPE_SVO_Attach.jsp</description>
		  </comment>
       </comments> 
    </version>
  </versions>
</file> 
*/

response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server

%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js"></script>
<%
	Checker c = new Checker();
	long COD_AZL=Security.getAzienda();
	long id_attachment=0;
	long lCOD_OPE_SVO=0;
	long lCOD_MAN=0;
        
	//---
	IOperazioneSvolta bean=null;
	IOperazioneSvoltaHome home=(IOperazioneSvoltaHome)PseudoContext.lookup("OperazioneSvoltaBean");
	IAssociativaAgentoChimicoHome sos_chi_home =(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	IAttivitaLavorativeHome att_home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	//---
	String strCOD_MAN = (String)request.getParameter("COD_MAN");
	lCOD_MAN=c.checkLong("cod attivita", request.getParameter("COD_MAN"), false);
	long lCOD_SOS_CHI = c.checkLong("cod sostanza", request.getParameter("COD_SOS_CHI"), false);
	boolean isCurrentOperazione = (c.checkTrigger("Cur macchina", request.getParameter("CUR_OPE")).equals("S"));
	out.print("strCOD_MAN:"+strCOD_MAN);
	String strID = (String)request.getParameter("ID_PARENT");
	out.print("lCOD_MAN: "+lCOD_MAN);
	try{
		Long id=new Long(strID);
		lCOD_OPE_SVO=id.longValue();
		bean = home.findByPrimaryKey(id);
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}
//-------------------------------------------------------------------
	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	//++++++++++++++++++++++++++++++++++++++++++
	if (request.getParameter("MODE_MONO") != null) {
                out.print("<br>MODE_MONO<br>");
                try {
                    String res = att_home.EXaddAssociationOfRiscToOperazionaSvolta(
                            lCOD_OPE_SVO, lCOD_MAN, COD_AZL, id_attachment, null, null);
                    out.print("RESULT:" + res);
                    if (res.indexOf("...FAILED") != -1) {
                        throw new Exception();
                    } else if (res.indexOf("...ATTIVITA ESISTENTE") != -1) {
                        out.print(printErrAlert("divErr", "Error.showDublicateChild", new Exception()));
                    }
                } catch (Exception ex) {
                    out.print("<script>Alert.Error.showDublicate();</script>");
                    return;
                }
            } else {
	//+++++++++++++++++++++++++++++++++++++++++++
	%>
	<form action="ANA_OPE_SVO_Attach.jsp" method="POST">
	<input type="Text" value="<%=strCOD_MAN%>" name="COD_MAN">
	<input type="Text" value="<%=lCOD_SOS_CHI%>" name="COD_SOS_CHI">
	<input type="Text" value="<%=strID%>" name="ID_PARENT">
	<input type="Text" value="<%=id_attachment%>" name="ID">
	<input type="Text" value="<%=strSubject%>" name="ATTACH_SUBJECT">
	<input type="Text" value="<%="MODE_MONO"%>" name="MODE_MONO">
	</form>
	<%
	try{
		if ("DOCUMENT".equals(strSubject)){
			bean.addDocument(id_attachment);
		}
		if ("RISC".equals(strSubject)){
		//-------------------------------------
		//---OTHERS ATTIVITE checking---
			out.println("ATTACH_SUBJECT=RISC<br>");
			//bean.addRisc(id_attachment, COD_AZL);
			long Control=0;
				//if( !strCOD_MAN.equals("0") ){Control=1;}
			long cnt=att_home.getCountAttivitaLavorativeByCOD_OPE_SVO( Long.parseLong(strID), COD_AZL );
			if(cnt > Control){%>
			<script>
			cnf=confirm(arraylng["MSG_0034"]);
			if(cnf){
				frs="dialogHeight:350px;dialogWidth:720px;help:no;resizable:no;status:no;scroll:no;unadorned:yes;";
				url="../Form_GEST_ATTIVITA/GEST_ATTIVITA_Form.jsp";
				url+="?ID=<%=strID%>&COD_RSO=<%=id_attachment%>&COD_MAN=<%=strCOD_MAN%>";
				res = window.showModalDialog(url,"",frs);
				//window.open(url);
				if(res=="OK"){
					parent.ToolBar.Return.Do();
				}
			}else{
				document.forms[0].submit();		
			}
			</script>
			<%}
			else
			{
                                try {
                                    String res = att_home.EXaddAssociationOfRiscToOperazionaSvolta(
                                            lCOD_OPE_SVO, lCOD_MAN, COD_AZL, id_attachment, null, null);
                                    out.print("RESULT:" + res);
                                    if (res.indexOf("...FAILED") != -1) {
                                        throw new Exception();
                                    } else if (res.indexOf("...ATTIVITA ESISTENTE") != -1) {
                                        out.print(printErrAlert("divErr", "Error.showDublicateChild", new Exception()));
                                    }
                                } catch (Exception ex) {
                                    out.print("<script>Alert.Error.showDublicate();</script>");
                                    return;
                                }
                            }
			//---------------------------------------------------
		}
		if ("AGENTI".equals(strSubject)){
			//bean.addAgenteChimico(id_attachment);
			//sos_chi_home.addSostanzeRischiToOperazione(lCOD_OPE_SVO,id_attachment,COD_AZL);
			out.println("added ope svo");
			int iCOD_MAN = 0;
			out.println(lCOD_MAN+"<br>");
			/*if (lCOD_MAN!=0){
				IAttivitaLavorative at_bean = att_home.findByPrimaryKey(new AttivitaLavorativePK(COD_AZL ,lCOD_MAN));
				iCOD_MAN=1;
				Collection col  = sos_chi_home.getRischioSostanza_View(id_attachment);		
				Iterator it = col.iterator();
				if (it!=null){
					while (it.hasNext()){
						RischioSostanza_View v = (RischioSostanza_View)it.next();
						out.println(v.lCOD_RSO+"<br>");
						at_bean.addXRischioAssociations(v.lCOD_RSO, COD_AZL);
					}
				}
			}*/
			if(!isCurrentOperazione){
				if(att_home.getCountAttivitaLavorativeByCOD_OPE_SVO(lCOD_OPE_SVO, COD_AZL)>iCOD_MAN){
				%>
				<script>
					 res=showGestMan(<%=lCOD_OPE_SVO%>,"sos_chi_ope_svo",<%= lCOD_MAN %>,<%= id_attachment  %>);
					 if (!res){
						url="ANA_OPE_SVO_Attach.jsp?ATTACH_SUBJECT=AGENTI&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_OPE=S&COD_OPE_SVO=<%= lCOD_OPE_SVO %>";
						document.location.assign(url);
					 }
				</script>
				<%
				}
				else{
					sos_chi_home.addSostanzeRischiToOperazione(lCOD_OPE_SVO,id_attachment,COD_AZL);
				}
			}
			else{
				sos_chi_home.addSostanzeRischiToOperazione(lCOD_OPE_SVO,id_attachment,COD_AZL);
			}
		}
		if ("MACCHINA".equals(strSubject)){
			//bean.addMacchina(id_attachment);
		}
//-------------------------------------------------------------------------
	}
	catch(Exception ex){
		out.print("<script>Alert.Error.showDublicateChild();</script>");
		return;
	}
 //
}//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%>
<script>    
	parent.ToolBar.Return.Do();
</script>
