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
    <version number="1.0" date="11/02/2004" author="Alex Kyba">		
      <comments>
			   <comment date="11/02/2004" author="Alex Kyba">

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
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js" type="text/javascript"></script>
<%
	long id_attachment=0;
	long lCOD_AZL = Security.getAzienda();
	String strID = (String)request.getParameter("ID_PARENT");
	String strTPL_CLF_RSO="O";
	long  lCOD_MAC=0;
	IMacchina bean=null;
	IMacchinaHome home=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");
	Collection col;
	Iterator it;
	Checker c = new Checker();
	boolean isCurrentMacchina = (c.checkTrigger("Cur macchina", request.getParameter("CUR_MACCHINA")).equals("S"));
	try{
		Long id=new Long(strID);
		lCOD_MAC = id.longValue();
		bean = home.findByPrimaryKey( new MacchinaPK(lCOD_AZL, id.longValue()) );
		id_attachment=Long.parseLong((String)request.getParameter("ID"));
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	
	try{
		if ("DOC".equals(strSubject)){
			bean.addDocument(id_attachment);
			//return;
		}
		if ("NOR_SEN".equals(strSubject)){
			bean.addNormativa(id_attachment);
		}
		if ("RISCHIO".equals(strSubject)){
			out.println("rischio");
			lCOD_AZL = Security.getAzienda();
			//out.println(request.getQueryString());
			out.println(request.getParameter("TPL_CLF_RSO"));
			if (request.getParameter("TPL_CLF_RSO")!=null){
				strTPL_CLF_RSO=request.getParameter("TPL_CLF_RSO");
			}
			else{
				strTPL_CLF_RSO="O";
			}
			/*out.println(strTPL_CLF_RSO);
			out.println(id_attachment);
			try{
				bean.deleteRischio(id_attachment);
				bean.addRischio(id_attachment, strTPL_CLF_RSO);
			}
			catch(Exception ex){
					bean.addRischio(id_attachment, strTPL_CLF_RSO);
			}*/
			out.println("lCOD_MAC"+lCOD_MAC+"<br>");
			out.println(home.getCountAttivitaForMacchina(lCOD_MAC, lCOD_AZL)+"<br>");
			out.println(home.getCountLuoghiForMacchina(lCOD_MAC, lCOD_AZL));
			if (!isCurrentMacchina){	
				if (strTPL_CLF_RSO.equals("T")){
					long count=home.getCountLuoghiForMacchina(lCOD_MAC, lCOD_AZL);
					out.println(count);
					if (count>0){
						%>
					<script>
						 res=showGestMan(<%= lCOD_MAC%>,"macchina_rischio",<%= id_attachment%>, "T");
						 if (!res){
							url="ANA_MAC_Attach.jsp?ATTACH_SUBJECT=RISCHIO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_MACCHINA=S&TPL_CLF_RSO=T";
							document.location.assign(url);
						}
					</script>
						<%
					}
					else{
						bean.addRischio(id_attachment, strTPL_CLF_RSO);
					}
				}
				else if (strTPL_CLF_RSO.equals("O")){
					long count = home.getCountAttivitaForMacchina(lCOD_MAC, lCOD_AZL);
					out.println(count);
					if (count>0){
						%>
					<script>
						 showGestMan(<%= lCOD_MAC%>,"macchina_rischio",<%= id_attachment%>, "O");
						 if (!res){
							url="ANA_MAC_Attach.jsp?ATTACH_SUBJECT=RISCHIO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_MACCHINA=S&TPL_CLF_RSO=O";
							document.location.assign(url);
						}
					</script>
						<%
					}
					else{
						bean.addRischio(id_attachment, strTPL_CLF_RSO);
					}
				}
				else if (strTPL_CLF_RSO.equals("O/T")){
					if (home.getCountAttivitaForMacchina(lCOD_MAC, lCOD_AZL)>0 || home.getCountLuoghiForMacchina(lCOD_MAC, lCOD_AZL)>0){
						%>
					<script>
						 showGestMan(<%= lCOD_MAC%>,"macchina_rischio",<%= id_attachment%>, "O/T");
						 if (!res){
							url="ANA_MAC_Attach.jsp?ATTACH_SUBJECT=RISCHIO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_MACCHINA=S&TPL_CLF_RSO=O/T";
							document.location.assign(url);
						}						 
					</script>
						<%
					}
					else{
						bean.addRischio(id_attachment, strTPL_CLF_RSO);
					}
				}
			}
			else{
				bean.addRischio(id_attachment, strTPL_CLF_RSO);
			}
		}
		if ("ATT_MNT".equals(strSubject)){
			// ne delaem nichego, poskol'ku vsio sdelalos' v AMA_ATI_MNT_MAC_SET.jsp
		}
		if ("FOR_MAC".equals(strSubject)){
			bean.addFornitore(id_attachment);
		}
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
		return;
	}
%>
<script>
        parent.ToolBar.Return.Do();
</script>
