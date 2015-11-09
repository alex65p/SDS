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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
          <comments>
                  <comment date="24/01/2004" author="Malyuk Sergey">
                   <description></description>
                 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<script>
//JS peremennaja vistvliemaja v true esli bila sozdana new zapis'
var isNew = false;
var err = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
    String ReqMODE;    // parameter of request
%>
<%
ITestVerifica TestVerifica=null;
long lCOD_TES_VRF=0;
String strDES_TES_VRF ="";
String    strNOM_TES_VRF="";
long lNUM_MIN_PTG =0;
long lNUM_MAX_PTG =0;
if(request.getParameter("SBM_MODE")!=null)
{
    ReqMODE=request.getParameter("SBM_MODE");
    //out.println(ReqMODE);

    Checker c = new Checker();
    //- checking for required fields
    strNOM_TES_VRF=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.test"),request.getParameter("Nome"),true);
    //- checking for not required fields
    strDES_TES_VRF = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.test"),request.getParameter("DESC"),false);
    lNUM_MIN_PTG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio.minimo.per.approvazione"),request.getParameter("MIN"),false);
    lNUM_MAX_PTG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio.massimo.del.test"),request.getParameter("MAX"),false);

    if (c.isError)
    {
        String err = c.printErrors();
        out.println("<script>alert(\""+err+"\");</script>");
        return;
    }
//=======================================================================================
  if(ReqMODE.equals("edt"))
    {
        // editing of TestVerifica--------------------
        // gettinf of object
        String strCOD_TES_VRF=request.getParameter("TES_VRF_ID");                    //ID of TestVerifica
        ITestVerificaHome home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
        Long tes_vrf_id=new Long(strCOD_TES_VRF);
        TestVerifica = home.findByPrimaryKey(tes_vrf_id);
        try{
            TestVerifica.setNOM_TES_VRF(strNOM_TES_VRF);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }

    }
//=======================================================================================
    if(ReqMODE.equals("new"))
    {
    // new TestVerifica--------------------------
    // creating of object
        ITestVerificaHome home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
        try{
        TestVerifica=home.create(strNOM_TES_VRF);
        out.print("<script>isNew=true;</script>");
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();</script>");
            return;
        }
        lCOD_TES_VRF = TestVerifica.getCOD_TES_VRF();
    }
//=======================================================================================
}
    if (TestVerifica!=null){
    //   *Not require Fields*
        try{
        TestVerifica.setDES_TES_VRF(strDES_TES_VRF);
        TestVerifica.setNUM_MIN_PTG(lNUM_MIN_PTG);
        TestVerifica.setNUM_MAX_PTG(lNUM_MAX_PTG);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();</script>");
            return;
        }
%>
<script>
if (!err){
  if(isNew)
  { 
  	Alert.Success.showCreated();
    parent.ToolBar.OnNew("ID=<%=lCOD_TES_VRF%>");
  }else{
    Alert.Success.showSaved();
  }
}
</script>
<%}%>
