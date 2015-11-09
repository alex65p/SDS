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
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
    response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="javax.servlet.RequestDispatcher" %>
<%@ page import="s2s.ldap.LdapUtility" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="s2s.luna.conf.ApplicationConfigurator" %>
<%@ page import="com.novell.ldap.LDAPEntry" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.Utente.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="s2s.utils.text.StringManager" %>

<%@ include file="../WEB/src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../WEB/src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../WEB/src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../WEB/src/com/apconsulting/luna/util/Security.jsp" %>

<%
String username = request.getParameter("j_username");
String password = request.getParameter("j_password");
boolean ldapError = false;

// CONTROLLO LDAP
LdapUtility ldapUtility = new LdapUtility();
String nextJSP = null;
String loginMode = ApplicationConfigurator.LOGINMODE;
IUtenteHome home = (IUtenteHome)PseudoContext.lookup("UtenteBean");

if (loginMode != null){
    try{
        // Cerco su LDAP un utenza con le credenziali (utente e password)
        // inserite a sistema in fase di login. Se la trovo...
        if(ldapUtility.checkLdapLoginCredential(
                ApplicationConfigurator.ESCAPE_BACKSLASH
                    ?username.replace("\\", "\\\\")
                    :username, password)) {

            // ... verifico l'esistenza di un utente con le stesse
            // credenziali (solo lo username) anche sul sistema della sicurezza.
            Collection listaUtenti = home.getUserS2S(username);

            // se non esiste ...
            if (listaUtenti.isEmpty()){
                // ... messaggio di errore.
                throw new Exception(ApplicationConfigurator.LanguageManager.getString("LDAP.Msg1"));
            // se esiste ...
            } else {
                password = ((view_sc_users)listaUtenti.iterator().next()).PASSWORD;
            }
        // se non trovo corrispondenza (utente e password non trovati su
        // ldap)..
        } else {
            // ... verifico l'esistenza di un utente sul sistema della sicurezza
            // con le ceredenziali immesse in fase di login.
            Collection listaUtenti = home.getUserS2S(username, password);
            if (!listaUtenti.isEmpty()){
                // ... se esiste verifico che sia un consulente
                view_sc_users utente = (view_sc_users)listaUtenti.iterator().next();
                // ... se lo è proseguo con la procedura di login, in quanto,
                // i consulenti, anche se non presenti in LDAP, possono accedere
                // al sistema
                if (utente.LOGIN_AS.equals("CON") == false){
                    throw new Exception(
                        ApplicationConfigurator.LanguageManager.getString("LDAP.Msg4"));
                }
            } else {
                throw new Exception(
                    ApplicationConfigurator.LanguageManager.getString("LDAP.Msg4"));
            }
        }
        session.setAttribute("ldapVerified", 1);
        nextJSP =
                    "/_security/logon.jsp?" +
                    "j_username=" + URLEncoder.encode(username, "UTF-8") +
                    "&j_password=" + URLEncoder.encode(password, "UTF-8");
    } catch (Exception e){
        String errorMessage = "";
        Throwable t = e.getCause();
        while (t != null){
            errorMessage += t.getMessage() + " ";
            t = t.getCause();
        }
        errorMessage += e.getMessage();
        nextJSP = "/_security/logon.jsp?ldapError="+errorMessage;
        ldapError = true;
        e.printStackTrace();
    }
} else {
    nextJSP = "/_security/logon.jsp?ldapError=" +
            ApplicationConfigurator.LanguageManager.getString("LDAP.Msg3");
    ldapError = true;    
}

// Imposto il profilo selezionato in fase di login
String PROFILE = request.getParameter("PROFILE_SELECTOR");
if (!ldapError && !StringManager.isEmpty(PROFILE)){
    ApplicationConfigurator.setProfileByName(PROFILE);
}

response.sendRedirect(ApplicationConfigurator.getApplicationURI() + nextJSP);
%>
