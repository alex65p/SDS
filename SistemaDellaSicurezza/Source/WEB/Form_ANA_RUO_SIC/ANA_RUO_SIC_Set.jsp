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
        <version number="1.0" date="02/09/2009" author="Dario Massaroni">
            <comments>
                <comment date="02/09/2009" author="Dario Massaroni">
                    <description>Set</description>
                </comment>
            </comments>
        </version>
    </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.RuoliSicurezza.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err = false;
    var isNew = false;
</script>

<%
    String ReqMODE="";	// parameter of request

    IRuoliSicurezza RuoliSicurezza=null;
    long THIS_ID=0;

    if (request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();

        //- checking for required fields
	String strNOM_RUO_SIC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_RUO_SIC"),true);
  
	//- checking for not required fields		
	String strDES_RUO_SIC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_RUO_SIC"),false);
        if (c.isError){
            String err = c.printErrors();
            out.println("<script>alert(\""+err+"\");err=true;</script>");
            return;
        }

        if (ReqMODE.equals("edt")) {
            // editing of RuoliSicurezza--------------------
            // gettinf of object 
            Long lCOD_RUO_SIC = new Long(c.checkLong("Ruoli Sicurezza ID", request.getParameter("COD_RUO_SIC"), true));
            if (c.isError) {
                String err = c.printErrors();
                out.println("<script>alert(\"" + err + "\");err=true;</script>");
                return;
            }

            IRuoliSicurezzaHome home = (IRuoliSicurezzaHome) PseudoContext.lookup("RuoliSicurezzaBean");
            RuoliSicurezza = home.findByPrimaryKey(lCOD_RUO_SIC);

            //getting of parameters and set the new object variables
            try {
                RuoliSicurezza.setNOM_RUO_SIC(strNOM_RUO_SIC);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            THIS_ID = RuoliSicurezza.getCOD_RUO_SIC();
        }

        if (ReqMODE.equals("new")) {
            // new RuoliSicurezza--------------------------
            // creating of object
            IRuoliSicurezzaHome home = (IRuoliSicurezzaHome) PseudoContext.lookup("RuoliSicurezzaBean");
            try {
                RuoliSicurezza = home.create(strNOM_RUO_SIC);
                THIS_ID = RuoliSicurezza.getCOD_RUO_SIC();
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
            %>
                <script>isNew=true;</script>
            <%
        }

        if (RuoliSicurezza != null) {
            //   *Not require Fields*
            try {
                RuoliSicurezza.setDES_RUO_SIC(strDES_RUO_SIC);
            } catch (Exception ex) {
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
        }
}
%>	
<script>
    if (!err){
        if(isNew){
            Alert.Success.showCreated();
        }else{
            Alert.Success.showSaved();
        }
  if (isNew)
      parent.ToolBar.OnNew("ID=<%=THIS_ID%>");
}
</script>
