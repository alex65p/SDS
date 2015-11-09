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

<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="s2s.ejb.pseudoejb.PseudoContext" %>
<%@ page import="javax.ejb.EJBException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="s2s.luna.util.ExceptionInfo" %>
<%@ page import="s2s.luna.util.ExceptionInfo.exceptionType" %>
<%@ page import="com.apconsulting.luna.ejb.exception.*" %>
<%@ page import="s2s.ejb.pseudoejb.BMPConnection" %>
<%@ page import="s2s.ejb.pseudoejb.BMPConnection.ConnectionType" %>

<%@ include file="../conf/ApplicationConfigurator.jsp" %>

<script src='../_scripts/help.js' language='JavaScript1.2' type='text/javascript'></script>
<%!
    private String getFKNameFromExceptionMessage(String exceptionMessage, String subStringToFindStart, String subStringToFindEnd){
        int startKeyIndex = 0;
        int endKeyIndex = 0;
        String FK_KeyName = "";
        
        startKeyIndex = exceptionMessage.lastIndexOf(subStringToFindStart) + subStringToFindStart.length();
        endKeyIndex = exceptionMessage.indexOf(subStringToFindEnd, startKeyIndex);
        FK_KeyName = exceptionMessage.substring(startKeyIndex, endKeyIndex);
        return FK_KeyName;
    }
            
    public void manageException(HttpServletRequest request, JspWriter out, Exception ex) throws Exception {
        ex.printStackTrace();
        
        String errore = "- ";
        boolean deleteMsgExtended = ApplicationConfigurator.isModuleEnabled(MODULES.DEL_MSG_EXT);
        exceptionType errorType = new ExceptionInfo(ex).getExceptionType();
        
        if (errorType == ExceptionInfo.exceptionType.INTEGRITY_CONSTRAINT_VIOLATION) {

            EJBException exception = (EJBException) ex;
            String exMessage = exception.getMessage();
                       
            /*
                Determino il nome della constraint che ha generato l'errore a partire dal messaggio dell'eccezione.
                
                Tale messaggio varia a seconda del database con in quale sto utilizzando il "Sistema dela sicurezza",
                per questo motivo il meccanismo in questione è stato implementato in maniera distinta per ognuno 
                dei diversi database supportati.
            */
            ConnectionType DataBaseConnectionType = BMPConnection.getConnectionType();
            String FK_KeyName = "";
            /*
               La parte relativa a DB2 è da implementare. Al momento viene utilizzata quella di default (PostGreeSQL) 
            */
            if (DataBaseConnectionType == ConnectionType.ORACLE){
              FK_KeyName = getFKNameFromExceptionMessage(exMessage, ".",")");  
            // } else if (DataBaseConnectionType == ConnectionType.DB2){
            } else {
              // POSTGRE
              FK_KeyName = getFKNameFromExceptionMessage(exMessage, "foreign key constraint \"","\"");  
            }

            IExceptionHome home = (IExceptionHome) PseudoContext.lookup("ExceptionBean");
            String FK_KeyDesc = "";

            try {
                IException bean = home.findByPrimaryKey(FK_KeyName);
                FK_KeyDesc = bean.getFK_DESC();
                if (StringManager.isNotEmpty(FK_KeyDesc) && FK_KeyDesc.equals("TAB")) {
                    out.println("<script>Alert.Error.showDelete();document.execCommand('Stop');</script>");
                } else {
                    if (deleteMsgExtended){
                        errore += StringManager.isNotEmpty(bean.getFK_DESC())
                                ?   ApplicationConfigurator.LanguageManager.getString(bean.getFK_DESC())
                                :   ApplicationConfigurator.LanguageManager.getString("Informazione.non.determinabile").toUpperCase() + "\n\n" + 
                                    ApplicationConfigurator.LanguageManager.getString("Errore.interno.db").toUpperCase() + "\n" 
                                    + "------------------------------------".toUpperCase() + "\n" + ex.getMessage() + ")";
                        out.println("<script>"
                                + "Alert.Error.showIntegrityConstraintViolation('" + StringManager.prepareForJavaScript(errore) + "');document.execCommand('Stop');"
                                + "</script>");
                    } else {
                        out.println("<script>Alert.Error.showDelete();document.execCommand('Stop');</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                if (deleteMsgExtended){
                    errore += ApplicationConfigurator.LanguageManager.getString("Informazione.non.determinabile.1");
                    out.println("<script>"
                        + "Alert.Error.showIntegrityConstraintViolation('" + StringManager.prepareForJavaScript(errore) + "');document.execCommand('Stop');"
                        + "</script>");
                } else {
                    out.println("<script>Alert.Error.showDelete();document.execCommand('Stop');</script>");
                }
            }
        } else if (errorType == ExceptionInfo.exceptionType.NOT_DETERMINABLE) {
            // Gestisco errori di cui non è stato possibile determinare la natura.
            if (deleteMsgExtended){
                out.println("<script>"
                    + "Alert.Error.showGenericError('" + StringManager.prepareForJavaScript(ex.getMessage()) + "');document.execCommand('Stop');"
                    // + "Alert.Error.showNotDeterminableError();document.execCommand('Stop');"
                    + "</script>");
            } else {
                out.println("<script>Alert.Error.showDelete();document.execCommand('Stop');</script>");
            }
        } else {
            // Gestisco il verificarsi di tutte le eventuali altre tipologie di errore 
            // diverse da quelle trattate nei blocchi precedenti, mostrandone il relativo messaggio.
            if (deleteMsgExtended){
                out.println("<script>"
                    + "Alert.Error.showGenericError('" + StringManager.prepareForJavaScript(ex.getMessage()) + "');document.execCommand('Stop');"
                    + "</script>");
            } else {
                out.println("<script>Alert.Error.showDelete();document.execCommand('Stop');</script>");
            }
        }
    }
%>
