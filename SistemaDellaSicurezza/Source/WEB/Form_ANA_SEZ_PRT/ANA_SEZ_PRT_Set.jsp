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

<%-- 
    Document   : ANA_SEZ_PRT_Set
    Created on : 15-apr-2011, 17.20.31
    Author     : Alessandro
--%>

<%@ page import="com.apconsulting.luna.ejb.SezioneParticolare.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
	String ReqMODE;	// parameter of request
%>
<script>
  var err=false;
  var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
ISezioneParticolare bean=null;
Long lCOD_PSC = null;
String strCOD_PSC = request.getParameter("ID_PARENT");
if (strCOD_PSC!=null && !strCOD_PSC.equals("") && !strCOD_PSC.equals("null")){
		lCOD_PSC = new Long (request.getParameter("ID_PARENT"));
	}
Long lCOD_PRO = null;
String strCOD_PRO = request.getParameter("COD_PRO");
if (strCOD_PRO!=null && !strCOD_PRO.equals("") && !strCOD_PRO.equals("null")){
		lCOD_PRO = new Long (request.getParameter("COD_PRO"));
	}
long lCOD_AZL=Security.getAzienda() ;
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	out.println(ReqMODE);

	Checker c = new Checker();

        long                    lCOD_SEZ_PAR=c.checkLong("COD_SEZ_PAR",request.getParameter("COD_SEZ_PAR"),false);
        String			strREV = c.checkString(ApplicationConfigurator.LanguageManager.getString("Revisione"),request.getParameter("REV"),true);                  //1
        String			strOGG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Oggetto"),request.getParameter("OGG"),false);                 //2
        String			strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"),request.getParameter("COD"),true);                  //3
        String			strTIT = c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),request.getParameter("TIT"),true);                  //3
	java.sql.Date	        dtDAT_EMI = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.emissione"),request.getParameter("DAT_EMI"),false);        //4
        java.sql.Date	        dtDAT_PRO = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.protocollo"),request.getParameter("DAT_PRO"),false);        //5
        String			strDOC_COL = c.checkString(ApplicationConfigurator.LanguageManager.getString("Documento.collegato"),request.getParameter("ATTACHMENT_FILE"),true);                  //6
        String strDOC_COL_CB = c.checkString("Documento collegato check box", request.getParameter("ATTACHMENT_ACTION_LINK"), false);                  //7
      //  long                    lCOD_PRO = c.checkLong("",request.getParameter("COD_PRO"),false);         //6

         if (strREV.equals("In lavorazione")) {
                    strREV = "0";
                }
                if (strREV.equals("Emissione")) {
                    strREV = "1";
                }

	if (c.isError)
	{
		String err = c.printErrors();
//		err = err.replace('\"','\'');
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		ISezioneParticolareHome home=(ISezioneParticolareHome)PseudoContext.lookup("SezioneParticolareBean");
		Long sez_par_id=new Long(lCOD_SEZ_PAR);
		bean = home.findByPrimaryKey(sez_par_id);
		bean.setlCOD_SEZ_PAR(lCOD_SEZ_PAR);            //1
		bean.setstrCOD(strCOD);        //2
		bean.setstrTIT(strTIT);        //3
		bean.setstrOGG(strOGG);    //4
		bean.setstrREV(strREV);    //5
		bean.setdtDAT_EMI(dtDAT_EMI);    //6
		bean.setdtDAT_PRO(dtDAT_PRO);    //7
		if(strDOC_COL_CB.equals("delete")){
                        bean.setstrDOC_COL("");    //8
                    }else{
                        bean.setstrDOC_COL(strDOC_COL);    //8
                    }
		try{

		}catch(Exception ex){
                    ex.printStackTrace();
                    return;
		}
		bean.setlCOD_AZL(lCOD_AZL);
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
		ISezioneParticolareHome home=(ISezioneParticolareHome)PseudoContext.lookup("SezioneParticolareBean");
		try{                                                                        
			bean=home.create(strOGG, strCOD, strTIT, strREV, dtDAT_EMI, dtDAT_PRO, strDOC_COL, lCOD_PSC, lCOD_PRO, lCOD_AZL);
			%><script>isNew=true;</script><%
		}catch(Exception ex){
                    ex.printStackTrace();
			//out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
//=======================================================================================

}
%>
<script>
 	if(!err){
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getlCOD_SEZ_PAR()%>");
		}else{
	     Alert.Success.showSaved();
		}
	}else{
		//Alert.Error.showCreated();
	}
</script>
