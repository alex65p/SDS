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



<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpere"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpereHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

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
            IAnagrOpere bean = null;
 
            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                out.println(ReqMODE);

                Checker c = new Checker();

                //- checking for required fields
                //			lCOD_PRO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Procedimento"),request.getParameter("PRO_ID"),false);         //2
                String strDES_OPE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_OPE"), false);
                String strNOM_OPE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("NOM_OPE"), true);                                 //3
                String strCOD_OPE = c.checkString(ApplicationConfigurator.LanguageManager.getString("Codice"), request.getParameter("COD_OPE"), true);                  //5

                //- checking for not required fields

                if (c.isError) {
                    String err = c.printErrors();
//		err = err.replace('\"','\'');
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }
//=======================================================================================
                if (ReqMODE.equals("edt")) {
                    Long lCOD_OPE = new Long(c.checkLong("Opere", request.getParameter("OPE_ID"), true));
                    //String strPRO=request.getParameter("PRO_ID");
                    IAnagrOpereHome home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
                    //Long pro_id=new Long(lCOD_PRO);
                    //bean.setlCOD_PRO(lCOD_PRO);            
                    bean = home.findByPrimaryKey(lCOD_OPE);
                    bean.setstrDES_OPE(strDES_OPE);  
                    bean.setstrNOM_OPE(strNOM_OPE);
                    try {
                        //CartelleSanitarie.setCOD_DPD(lCOD_DPD);
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        return;
                    }
                }
//=======================================================================================
                if (ReqMODE.equals("new")) {
                    // new CartelleSanitarie--------------------------
                    // creating of object
                    IAnagrOpereHome home = (IAnagrOpereHome) PseudoContext.lookup("AnagrOpereBean");
                    try {
                        bean = home.create(strDES_OPE,strNOM_OPE, Security.getAzienda());
%><script>isNew=true;</script><%
                                            } catch (Exception ex) {
                                                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                                                ex.printStackTrace();
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
            parent.ToolBar.OnNew("ID=<%=bean.getlCOD_OPE()%>");

        }else{
            Alert.Success.showSaved();
        }
    }else{
        //Alert.Error.showCreated();
    }
</script>
