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
     <version number="1.0" date="29/01/2004" author="Artur Denysenko">
     <comments>
     <comment date="29/01/2004" author="Artur Denysenko">
     <description>Shablon formi MULTIAZIENDA</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.OpzioniUtilizzatore.*" %>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>var err = false;</script>
<%
    Checker c = new Checker();
    
    String strFOX_PTH = "";
    String strFOX_PTH_READONLY = request.getParameter("FOX_PTH-READONLY");
    
    if (StringManager.isEmpty(strFOX_PTH_READONLY)){
        // Verifico che il campo non sia vuoto
        strFOX_PTH = c.checkString(ApplicationConfigurator.LanguageManager.getString("Firefox.path"), request.getParameter("FOX_PTH"), true);
        // Verifico che il campo non contenga spazi bianchi
        strFOX_PTH = c.checkEmptySpaces(ApplicationConfigurator.LanguageManager.getString("Firefox.path"), request.getParameter("FOX_PTH"), true);
        // Verifico che il campo punti al file eseguibile corretto "FirefoxPortable.exe"
        if (strFOX_PTH.indexOf("FirefoxPortable.exe")==-1){
            c.addCustomError(ApplicationConfigurator.LanguageManager.getString("Firefox.path"), ApplicationConfigurator.LanguageManager.getString("Firefox.name.error"));
        }
    } else {
        strFOX_PTH = strFOX_PTH_READONLY;
    }
            
    if (c.isError) {
        String err = c.printErrors();
%>
<script>alert("<%=err%>");</script>
<%
    return;
} else {
    try {
        IUtenteHome utenteHome = (IUtenteHome)PseudoContext.lookup("UtenteBean");
        
        IOpzioniUtilizzatoreHome home = (IOpzioniUtilizzatoreHome) PseudoContext.lookup("OpzioniUtilizzatoreBean");
        IOpzioniUtilizzatore bean = null;
        
        // Determino il codice dell'utente connesso.
        long lCOD_UTN = 
                ((view_sc_users)utenteHome.getUserS2S(Security.getUserPrincipal().getName()).iterator().next()).CODICE;
    
        // Verifico se esiste la proprietà "FOX_PTH" e se non esiste la creo.
        try {
            bean = home.findByPrimaryKey(new OpzioniUtilizzatorePK(lCOD_UTN, "FOX_PTH"));
        } catch (Exception ex) {
            bean = home.create(lCOD_UTN, "FOX_PTH");
        }
        bean.setOPZ_VAL(strFOX_PTH);

    } catch (Exception ex) {
%>
<div id="divError1">
    <%=ex%>
</div>
<script>alert(divError1.innerText);
    err = true;</script>
    <%
            }
        }
    %>
<script>
    if (!err) {
        Alert.Success.showSaved();
        parent.returnValue = "OK";
        parent.ToolBar.OnNew("");
    } else {
        Alert.Error.showSaved();
        parent.returnValue = "ERROR";
    }
</script>

