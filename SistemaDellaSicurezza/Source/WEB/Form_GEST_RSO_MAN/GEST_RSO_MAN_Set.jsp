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

<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%
/*
<file>
  <versions>	
    <version number="1.0" date="26/02/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="26/02/2004" author="Roman Chumachenko">
				   <description>GEST_RSO_MAN_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<script src="../_scripts/Alert.js"></script>
<script>
	var err=false;
</script>

<%!
	String ReqMODE;	// parameter of request 
%>	

<%
long lCOD_AZL=Security.getAzienda();
if(request.getParameterValues("CHK_ITEM")!=null)
{
	Long COD_MAN=new Long( request.getParameter("COD_MAN") );
	//out.println(COD_MAN);
	IAttivitaLavorative bean=null;
	IAttivitaLavorativeHome home=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean");
	bean=home.findByPrimaryKey( new AttivitaLavorativePK(lCOD_AZL, COD_MAN.longValue()) );
	//-- array of ids ---
	String[] CHK_ITEMS=request.getParameterValues("CHK_ITEM");
	for(int i=0; i<CHK_ITEMS.length; i++){
		out.print( CHK_ITEMS[i] +"<br>");
	}
	
	//------------------------------------------
	if(request.getParameter("SBM_MODE")!=null)
	{
	ReqMODE=request.getParameter("SBM_MODE");
	//---------------------------------------
        Vector DPI_Associati_Originale = null;
	if (ReqMODE.equals("RISC") || ReqMODE.equals("DPI")){
            DPI_Associati_Originale = new Vector();
            Iterator it = bean.getDPI_View().iterator();
            while (it.hasNext()){
                DPI_Associati_Originale.add(new Long(((AttLav_DPI_View)it.next()).COD_TPL_DPI));
            }
        }
        if(ReqMODE.equals("RISC"))
	{
		out.println("RISC");
		try{
			String res=bean.addExRischi(CHK_ITEMS, lCOD_AZL );
			out.println("RISCHI ARE ADDED OK<br>");
			out.println("RESULTAT: "+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}	
	}
	//---------------------------------------
	if(ReqMODE.equals("CORSO"))
	{
		out.println("CORSO");
		try{
			String res=bean.addExCorsi(CHK_ITEMS, lCOD_AZL );
			out.println("CORSI ARE ADDED OK<br>");
			out.println("RESULTAT:"+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}
	}
	//---------------------------------------
	if(ReqMODE.equals("PROTOCOLO"))
	{
		out.println("PROTOCOLO");
		try{
			String res=bean.addExProtocoli(CHK_ITEMS, lCOD_AZL );
			out.println("PROTOCOLLI ARE ADDED OK<br>");
			out.println("RESULTAT:"+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}
	}
	//---------------------------------------
	if(ReqMODE.equals("DPI"))
	{
		out.println("DPI");
		try{
                        String res=bean.addExDPI(CHK_ITEMS, lCOD_AZL );
                        out.println("DPI ARE ADDED OK<br>");
			out.println("RESULTAT:"+res);
		}catch(Exception ex){
			out.println("<script>Alert.Error.showSaved();</script>");
			return;
		}
	}
        if (ReqMODE.equals("RISC") || ReqMODE.equals("DPI")){
            String SendedMail = SendMail4AddedDPI_ANA_MAN(COD_MAN, DPI_Associati_Originale);
            if (!SendedMail.trim().equals("")){
                out.println("<script>alert('" + SendedMail + "')</script>");                                               
            }
        }
}// end of main block
//=====================================================================
%>
<script>
 	if(!err){	
		parent.returnValue="OK";
		parent.ToolBar.Return.Do();
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
<%}%>
