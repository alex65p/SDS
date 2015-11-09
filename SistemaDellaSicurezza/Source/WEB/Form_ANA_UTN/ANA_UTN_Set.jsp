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
    <version number="1.0" date="15/01/2004" author="Treskina Maria">
      <comments>
                 <comment date="15/01/2004" author="Treskina Maria">
                   <description>Shablon formi ANA_FOR_Form.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Consulente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%!
    String ReqMODE;    // parameter of request
%>
<script>
 var err = false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IConsultantHome Chome=(IConsultantHome)PseudoContext.lookup("ConsultantBean");
IUtente utente=null;
long THIS_ID=0;
if(request.getParameter("SBM_MODE")!=null)
{
    ReqMODE=request.getParameter("SBM_MODE");

        Checker c = new Checker();
        //- checking for required fields
        String strUSD_UTN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Userid"),request.getParameter("USER_ID"),true);
        String strPSW_UTN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Password"),request.getParameter("PASSWORD"),true);
        String strSTA_UTN=c.checkString(ApplicationConfigurator.LanguageManager.getString("Stato.utenza"),request.getParameter("STATO"),true);

        long lCOD_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Dipendente"),request.getParameter("COD_DPD"),true);
        long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("COD_AZIENDA"),true);

        //- checking for not required fields
        java.sql.Date    dDAT_ATT = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.attivazione"),request.getParameter("DATA_ATT"),false);
        java.sql.Date    dDAT_DIS = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.disattivazione"),request.getParameter("DATA_DIS"),false);

    if (c.isError)
        {
            String err = c.printErrors();
            out.println("<script>alert(\""+err+"\");</script>");
            return;
        }
//=======================================================================================

String ERRORER = "0";
Collection col = Chome.getConsultantUTN_View();
Iterator it = col.iterator();
 while(it.hasNext()){
     ConsultantiUSD_UTN_View view = (ConsultantiUSD_UTN_View)it.next();
		 if (strUSD_UTN.equals(view.USD_COU))
		 {
		   ERRORER="1";
		 }
	}
 if ("0".equals(ERRORER))
 {
  if(ReqMODE.equals("edt"))
    {
        // editing of utente--------------------
        // gettinf of object
        IUtenteHome home=(IUtenteHome)PseudoContext.lookup("UtenteBean");

        Long utn_id=new Long(c.checkLong("Utente ID",request.getParameter("UTN_ID"),true));

        if (c.isError)
        {
            String err = c.printErrors();
            out.print("for_id="+err);
            out.println("<script>alert(\""+err+"\");</script>");
            return;
        }
        utente = home.findByPrimaryKey(utn_id);
        //getting of parameters and set the new object variables

        try{
            utente.setUSD_UTN(strUSD_UTN);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }

        utente.setPSW_UTN(strPSW_UTN);
        utente.setSTA_UTN(strSTA_UTN);
        utente.setCOD_DPD(lCOD_DPD);
        utente.setCOD_AZL(lCOD_AZL);
        THIS_ID=utente.getCOD_UTN();
    }
//=======================================================================================
    if(ReqMODE.equals("new"))
    {
    // new utente--------------------------
    // creating of object
        IUtenteHome home=(IUtenteHome)PseudoContext.lookup("UtenteBean");
        try{
        utente=home.create(strUSD_UTN,strPSW_UTN,strSTA_UTN, lCOD_DPD, lCOD_AZL);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();</script>");
            return;
        }
        THIS_ID=utente.getCOD_UTN();
        %>
        <script>isNew=true;</script>
        <%
    }
//=======================================================================================
  if (utente!=null){
    //   *Not require Fields*
        utente.setDAT_ATT(dDAT_ATT);
        utente.setDAT_DIS(dDAT_DIS);
    }
  }
 else
 {
   out.print("<script>Alert.Error.showDublicate();err=true;</script>");
	 return;
 }
}
%>
<script>
if (!err){
  if(isNew){
            Alert.Success.showCreated();
        }else{
            Alert.Success.showSaved(); }
  if(isNew) parent.ToolBar.OnNew("ID=<%=THIS_ID%>");
}
</script>
