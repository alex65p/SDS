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
    <version number="1.0" date="14/12/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="14/12/2004" author="Roman Chumachenko">
				   <description>Shablon formi ANA_AZL_Set.jsp</description>
				 </comment>
				 <comment date="14/12/2004" author="Alexander Kyba">
				   <description>Dopisivanie Cheker.jsp</description>
				 </comment>
				 <comment date="31/01/2004" author="Roman Chumachenko">
					<description>Rebiuld for new UI (TabBar)</description>
				 <comment date="03/02/2004" author="Pogrebnoy Yura">
					<description>Priem ID_PARENT v lCOD_COU & svyazivanie Consulente 
					i Aziende v novoj zapisi & Izmenenie dialog.Arguments & izmenenie statusa buttonov
					</description>
 				 <comment date="18/02/2004" author="Malyuk Sergey">
					<description>Rebiuld for dinamic tabs</description>
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
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>	

<%
IAzienda bean=null;
//-----start check section--------------------------------
Checker c = new Checker();

//---required fields
Long azl_id=new Long(c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda"),request.getParameter("AZL_ID"), false));
String strRAG_SCL_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("AZIENDA"),true);
String strDES_ATI_SVO_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Attività.svolta"),request.getParameter("ATTIVITA_SVOLTA"), true); 
String strIDZ_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Indirizzo"),request.getParameter("INDIRIZZO"), true);
String strCIT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Città"),request.getParameter("CITTA"), true);
long lCOD_STA=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nazionalità"),request.getParameter("NAZIONALITA"), true);
short sMOD_CLC_RSO=c.checkShort(ApplicationConfigurator.LanguageManager.getString("Modalità.di.calcolo.del.rischio"),request.getParameter("MOD_CLC_RSO"), true);

//----not required fields
String strCAG_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Categoria"),request.getParameter("CATEGORIA"), false);
String strCOD_IST_TAT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice.ISTAT"),request.getParameter("COD_ISAT"), false);
String strNUM_CIC_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Numero.civico"),request.getParameter("NCIVOCO"), false);
String strPRV_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Provincia"),request.getParameter("PROVINCIA"), false); 
String strCAP_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("C.a.p."),request.getParameter("CAP"), false); 
String strQLF_RSP_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Qualifica.del.datore.lavoro"),request.getParameter("QUALIFICA"), false);
String strNOM_RSP_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Datore.di.lavoro"),request.getParameter("DATORE"), false);
String strNOM_RSP_SPP_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile.S.P.P."),request.getParameter("RESPONSABLE"), false);
String strNOM_MED_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Medico.competente"),request.getParameter("MEDICO"), false);
long lCOD_AZL_ASC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda.associata"),request.getParameter("AZIENDA_ASC"), false);
String strIDZ_PSA_ELT_RSP_AZL=c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"),request.getParameter("EMAIL"), false);
String strSIT_INT_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Sito.internet"),request.getParameter("SITOINTERNET"), false);
String strCOD_FIS_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice.fiscale"),request.getParameter("COD_FIS_AZL"), false);
String strPAR_IVA_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Partita.iva"),request.getParameter("PAR_IVA_AZL"), false);


if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
  var err=false;
  var isNew=false;  
</script>
<%
//------end check section--------------------------------

if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	// editing of azienda--------------------
		
                // gettinf of object 
		IAziendaHome home=(IAziendaHome)PseudoContext.lookup("AziendaBean");
		bean = home.findByPrimaryKey(azl_id);

                if (sMOD_CLC_RSO != bean.getMOD_CLC_RSO() && home.CheckRischiExists(azl_id.longValue())){
                    out.println("<script>alert(arraylng[\"MSG_0047\"]);</script>");
                    return;
                }
                        
                //getting of parameters and set the new object variables
		try{
			bean.setRAG_SCL_AZL(strRAG_SCL_AZL);		//1
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}	
		bean.setDES_ATI_SVO_AZL(strDES_ATI_SVO_AZL);	//2
		bean.setIDZ_AZL(strIDZ_AZL);					//3
		bean.setCIT_AZL(strCIT_AZL);					//4
		bean.setCOD_STA(lCOD_STA);						//5
                Security.setAziendaModalitaCalcoloRischio(sMOD_CLC_RSO);
                //----------------------------
        }
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new azienda--------------------------
		// creating of object
		if(Security.isUser()) return;
		try{
			%><script>isNew=true;</script><%
                        IAziendaHome home=(IAziendaHome)PseudoContext.lookup("AziendaBean");

                        if (ApplicationConfigurator.MAX_AZL_NUMS > 0 && home.getAziendeCount() >= ApplicationConfigurator.MAX_AZL_NUMS){
                            out.println("<script>");
                            out.println("alert(arraylng[\"MSG_0048\"]);");
                            out.println("window.parent.window.close();");
                            out.println("</script>");
                            return;
                        }
                        
                        bean=home.create(strRAG_SCL_AZL,strDES_ATI_SVO_AZL,strIDZ_AZL,strCIT_AZL,lCOD_STA,sMOD_CLC_RSO);
                                
                        if (Security.isConsultant()){
				String strCOD_COU = Security.getUserPrincipal().getName();
				long lCOD_COU = 0;
				IConsultantHome home_consultant=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
				IConsultant  bean_consultant = home_consultant.findByPrimaryKey(strCOD_COU);
				bean_consultant.addCOD_AZL( bean.getCOD_AZL() );
			}
		}catch(Exception ex){
			out.println("<script>Alert.Error.showDublicate();</script>");
			return;
		}
	}
	if(bean!=null){
		// -- setting of not required fields
			bean.setCAG_AZL(strCAG_AZL);							//7
			bean.setCOD_IST_TAT_AZL(strCOD_IST_TAT_AZL);			//8
			bean.setNUM_CIC_AZL(strNUM_CIC_AZL);					//9
			bean.setPRV_AZL(strPRV_AZL);							//10
			bean.setCAP_AZL(strCAP_AZL);							//11
			bean.setQLF_RSP_AZL(strQLF_RSP_AZL);					//12
			bean.setNOM_RSP_AZL(strNOM_RSP_AZL);					//13
			bean.setNOM_RSP_SPP_AZL(strNOM_RSP_SPP_AZL);			//14
			bean.setNOM_MED_AZL(strNOM_MED_AZL);					//15
			bean.setCOD_AZL_ASC(lCOD_AZL_ASC);						//16
			bean.setIDZ_PSA_ELT_RSP_AZL(strIDZ_PSA_ELT_RSP_AZL);	//17
			bean.setSIT_INT_AZL(strSIT_INT_AZL);					//18
                        bean.setMOD_CLC_RSO(sMOD_CLC_RSO);         //19
           bean.setCOD_FIS_AZL(strCOD_FIS_AZL );                    //20
           bean.setPAR_IVA_AZL(strPAR_IVA_AZL );                    //20


              					//5
		//----------------------------------------------------------------------
	}
}
out.print("Saving ok");
%>
<script>
if(parent.dialogArguments){
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.Return.OnClick();
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
 }else{
 	//------------------------------------------------
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_AZL()%>");
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
 }//---------------------------------------------------	
</script>
