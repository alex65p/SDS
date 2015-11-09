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
    <version number="1.0" date="12/02/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="12/02/2004" author="Khomenko Juliya">
				   <description>Create ANA_PRG_Attach.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
  var err=false;
</script>
<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js" type="text/javascript"></script>
<%
	
	long id_attachment=0;
	IAssociativaAgentoChimico bean=null;
	IAssociativaAgentoChimicoHome home=(IAssociativaAgentoChimicoHome)PseudoContext.lookup("AssociativaAgentoChimicoBean");
	String strID = (String)request.getParameter("ID_PARENT");
	String strTPL_CLF_RSO=(String)request.getParameter("TPL_CLF_RSO");
	long lCOD_SOS_CHI=0;
	java.util.ArrayList AZIENDA_ID;
	long lCOD_AZL = Security.getAzienda();
	Checker c = new Checker();
	boolean isCurrentSostanza = (c.checkTrigger("Cur sostanza", request.getParameter("CUR_SOSTANZA")).equals("S"));
	out.println(isCurrentSostanza+"<br>");
	if (Security.isExtendedMode()){
		AZIENDA_ID=c.checkAlLong("aziendaIDs",  request.getParameterValues("AZIENDA_ID"));
	} 
	String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
	try{
		bean = home.findByPrimaryKey(new Long(strID));
		id_attachment = Long.parseLong((String)request.getParameter("ID"));
		lCOD_SOS_CHI = Long.parseLong(strID);
	}catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound",ex));
		return;
	}
	if(strSubject.equals("RSO")){
		try{
			if (strTPL_CLF_RSO.equals("")) strTPL_CLF_RSO="O";
			//IRischioHome rso_home=(IRischioHome)PseudoContext.lookup("RischioBean");
			//IRischio rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment)); //new Long(request.getParameter("ID")));
			//long lCOD_AZL = rso_bean.getCOD_AZL();
			//bean.addCOD_RSO(id_attachment, lCOD_AZL, strTPL_CLF_RSO);
			out.println(strTPL_CLF_RSO);
			if (!isCurrentSostanza){
				if (strTPL_CLF_RSO.equals("T")){
					long count=home.getCountLuoghiForSostanza(lCOD_SOS_CHI, lCOD_AZL);
					out.println(count);
					
						if (count>0 ){
							%>
							<script>
							 res=showGestMan(<%= lCOD_SOS_CHI%>,"sos_chi_rischio",<%= id_attachment%>, "T");
							 alert(res);
							 if (!res){
								url="ANA_SOS_CHI_Attach.jsp?ATTACH_SUBJECT=RSO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_SOSTANZA=S&TPL_CLF_RSO=T";
								document.location.assign(url);
								
							}
							</script>
							<%
						}
						else {
							IRischioHome rso_home=(IRischioHome)PseudoContext.lookup("RischioBean");
							IRischio rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment)); 
							out.println("adding rischio only to sostanza current");
							bean.addCOD_RSO(id_attachment, lCOD_AZL, strTPL_CLF_RSO);
						}
				}
				else if (strTPL_CLF_RSO.equals("O") && !isCurrentSostanza){
					out.println("clf_tpl");
					long count = home.getCountAttivitaForSostanza(lCOD_SOS_CHI, lCOD_AZL);
					out.println(count);
					if (count>0){
						%>
					<script>
						 res=showGestMan(<%= lCOD_SOS_CHI%>,"sos_chi_rischio",<%= id_attachment%>, "O");
						 if (!res){
							url="ANA_SOS_CHI_Attach.jsp?ATTACH_SUBJECT=RSO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_SOSTANZA=S&TPL_CLF_RSO=O";
							document.location.assign(url);
						}
					</script>
					<%
					}
					else{
						IRischioHome rso_home=(IRischioHome)PseudoContext.lookup("RischioBean");
						IRischio rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment)); 
						out.println("adding rischio only to sostanza current");
						bean.addCOD_RSO(id_attachment, lCOD_AZL, strTPL_CLF_RSO);
					}
				}
				else if (strTPL_CLF_RSO.equals("O/T") && !isCurrentSostanza){
					if (home.getCountAttivitaForSostanza(lCOD_SOS_CHI, lCOD_AZL)>0 || home.getCountLuoghiForSostanza(lCOD_SOS_CHI, lCOD_AZL)>0){
						%>
					<script>
						 res=showGestMan(<%= lCOD_SOS_CHI%>,"sos_chi_rischio",<%= id_attachment%>, "O/T");
						 if (!res){
							url="ANA_SOS_CHI_Attach.jsp?ATTACH_SUBJECT=RSO&ID_PARENT=<%= strID %>&ID=<%= id_attachment %>&CUR_SOSTANZA=S&TPL_CLF_RSO=O/T";
							document.location.assign(url);
						}
					</script>
						<%
					}
					else{
						IRischioHome rso_home=(IRischioHome)PseudoContext.lookup("RischioBean");
						IRischio rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment)); 
						bean.addCOD_RSO(id_attachment, lCOD_AZL, strTPL_CLF_RSO);
					}
				}
			}
			else{
					IRischioHome rso_home=(IRischioHome)PseudoContext.lookup("RischioBean");
					IRischio rso_bean = rso_home.findByPrimaryKey(new RischioPK( Security.getAzienda(), id_attachment)); 
					out.println("adding rischio only to sostanza current");
					bean.addCOD_RSO(id_attachment, lCOD_AZL, strTPL_CLF_RSO);
			}
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
	}
	else
	if(strSubject.equals("FRS_R")){
		try{
			bean.addCOD_FRS_R(id_attachment);
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
	}
	else
	if(strSubject.equals("FRS_S")){
		try{
			bean.addCOD_FRS_S(id_attachment);
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
	}
	else
	if(strSubject.equals("DOC")){
		try{
			bean.addCOD_DOC(id_attachment);
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
	}
	else
	if(strSubject.equals("NOR_SEN")){
		try{
			bean.addCOD_NOR_SEN(id_attachment);
		}
		catch(Exception ex){
			out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
			return;
		}
	}
	else
	   return;
%>

<script>
    parent.ToolBar.Return.Do();
</script>
