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
    Document   : ANA_PRO_Set
    Created on : 8-apr-2011, 14.46.27
    Author     : Alessandro
--%>

<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrProcedimento.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script>
    var err=false;
    var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
            IAnagrProcedimento bean = null;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                out.println(ReqMODE);

                Checker c = new Checker();

                //- checking for required fields
                long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);         //7
                String strCOD = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("COD"), true);                  //5
                String strDES = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES"), true);                  //3
                
                //- checking for not required fields
                // lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"),request.getParameter("PRO_ID"),false);         //2
                String strNOM_RUP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.RUP"), request.getParameter("NOM_RUP"), false);                 //4
                java.sql.Date dtDAT_AMM = c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"), request.getParameter("DAT_AMM"), false);        //6

                if (c.isError) {
                    String err = c.printErrors();
//		err = err.replace('\"','\'');
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
//=======================================================================================
                if (ReqMODE.equals("edt")) {
                    Long lCOD_PRO = new Long(c.checkLong("Procedimento", request.getParameter("PRO_ID"), true));
                    //String strPRO=request.getParameter("PRO_ID");
                    IAnagrProcedimentoHome home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
                    //Long pro_id=new Long(lCOD_PRO);
                    //bean.setlCOD_PRO(lCOD_PRO);            //1
                    bean = home.findByPrimaryKey(lCOD_PRO);
                    bean.setstrDES(strDES);                //2
                    bean.setstrNOM_RUP(strNOM_RUP);        //3
                    bean.setstrCOD(strCOD);                //4
                    try {
                        //CartelleSanitarie.setCOD_DPD(lCOD_DPD);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        return;
                    }
                    bean.setlCOD_AZL(lCOD_AZL);
                }
//=======================================================================================
                if (ReqMODE.equals("new")) {
                    // new CartelleSanitarie--------------------------
                    // creating of object
                    IAnagrProcedimentoHome home = (IAnagrProcedimentoHome) PseudoContext.lookup("AnagrProcedimentoBean");
                    try {
                        bean = home.create(strDES, strNOM_RUP, dtDAT_AMM, strCOD, lCOD_AZL);
%><script>isNew=true;</script><%
                                            } catch (Exception ex) {
                                                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                                                return;
                                            }
                                        }
//=======================================================================================
        /*if (!=null){
                                        //   *No require Fields*
                                        }*/
                                    }
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=bean.getlCOD_PRO()%>");

        }else{
            Alert.Success.showSaved();
        }
    }else{
        //Alert.Error.showCreated();
    }
</script>
