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
    <version number="1.0" date="16/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="16/02/2004" author="Roman Chumachenko">
				<description>RSO_MAN_Set.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssMisuraAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<%! String ReqMODE;	// parameter of request %>

<%
//--------------------------------------
Checker c = new Checker();
//---required fields
long lCOD_MAN=c.checkLong("COD_MAN",request.getParameter("COD_MAN"),true);
long lCOD_RSO=c.checkLong("COD_RSO",request.getParameter("COD_RSO"),true);
long lCOD_AZL=c.checkLong("COD_AZL",request.getParameter("COD_AZL"),true);
/*
java.sql.Date dtDAT_INZ=c.checkDate("Data Inizio",request.getParameter("DAT_INZ"),true);
java.sql.Date dtDAT_FIE=c.checkDate("Data Fine",request.getParameter("DAT_FIE"),false);
String strPRS_RSO=c.checkString("PRS_RSO",request.getParameter("PRS_RSO"),true);
String strSTA_RSO=c.checkString("STA_RSO",request.getParameter("STA_RSO"),true);
*/
//-----
String strNOM_RIL_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nominativo.rilevatore"),request.getParameter("NOM_RIL_RSO"),true);
String strCLF_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Classificazione.rischio"),request.getParameter("CLF_RSO"),true);
long lPRB_EVE_LES=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Probabilità.dell'evento.lesivo"),request.getParameter("PRB_EVE_LES"),true);
long lENT_DAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Entità.del.danno"),request.getParameter("ENT_DAN"),true);
float lSTM_NUM_RSO=c.checkFloat(ApplicationConfigurator.LanguageManager.getString("Stima.numerica.del.rischio"),request.getParameter("STM_NUM_RSO"),true);
java.sql.Date dtDAT_RFC_VLU_RSO=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.rifacimento.valutazione.rischio"),request.getParameter("DAT_RFC_VLU_RSO"),true);

long lFRQ_RIP_ATT_DAN=0;
long lNUM_INC_INF=0;

if (Security.getAziendaModalitaCalcoloRischio()==Azienda_MOD_CLC_RSO.MOD_EXTENDED){
    lFRQ_RIP_ATT_DAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Frequenza.dell'attività.a.rischio"),request.getParameter("FRQ_RIP_ATT_DAN"),true);
    lNUM_INC_INF=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Numero.di.incidenti/infortuni.(negli.ultimi.3.anni)"),request.getParameter("NUM_INC_INF"),true);
}

//---
if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
%>
<script src="../_scripts/Alert.js"></script>
<script>
  var err=false;
</script>
<%
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	IAssRischioAttivitaHome home=(IAssRischioAttivitaHome)PseudoContext.lookup("AssRischioAttivitaBean");
	IAssMisuraAttivitaHome misura_home=(IAssMisuraAttivitaHome)PseudoContext.lookup("AssMisuraAttivitaBean");
	IAssRischioAttivita bean=null;
	IAssMisuraAttivita misura_bean=null;
	ReqMODE=request.getParameter("SBM_MODE");
  	if(ReqMODE.equals("edt"))
	{
		// gettinf of object 
		String strCOD_RSO_MAN=request.getParameter("COD_RSO_MAN");
		Long id=new Long(strCOD_RSO_MAN);
		bean = home.findByPrimaryKey(id);
		//*Not require Fields*
		/*
		bean.setDAT_INZ(dtDAT_FIE);
		bean.setDAT_FIE(dtDAT_FIE);
		*/
		bean.setNOM_RIL_RSO(strNOM_RIL_RSO);
		bean.setCLF_RSO(strCLF_RSO);
		bean.setDAT_RFC_VLU_RSO(dtDAT_RFC_VLU_RSO);
		bean.setPRB_EVE_LES(lPRB_EVE_LES);
		bean.setENT_DAN(lENT_DAN);
		bean.setSTM_NUM_RSO(lSTM_NUM_RSO);
                
                bean.setFRQ_RIP_ATT_DAN(lFRQ_RIP_ATT_DAN);
                bean.setNUM_INC_INF(lNUM_INC_INF);
		
		//-----
		//-- array of ids mesures---
		java.util.Date dt=new java.util.Date();
		java.sql.Date CUR_DAT=new java.sql.Date( dt.getTime() );
		String[] CHK_ITEMS=request.getParameterValues("CHK_PRS_MIS_HID");
		if (CHK_ITEMS != null){
                    for(int i=0; i<CHK_ITEMS.length; i++){
                            out.print( CHK_ITEMS[i] + "<br>" );
                            Long id_misura=new Long(CHK_ITEMS[i]);
                            misura_bean=misura_home.findByPrimaryKey(id_misura);
                            misura_bean.setPRS_MIS_PET("N");
                            misura_bean.setDAT_FIE(CUR_DAT);
                    }
                }
		//-----
	}
//=========================================================================
}
out.print("Saving ok");
%>
<script>
//------------------------------------------------
if(!err){	
	parent.returnValue="OK";
	Alert.Success.showSaved();
}else{
	parent.returnValue="ERROR";	
}	
//-------------------------------------------------	
</script>
