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
    Document   : GEST_POS_Util
    Created on : 18-giu-2011, 11.06.11
    Author     : Administrator
--%>


<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.AnagrDocumentoGestioneCantieri_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri.IAnagrDocumentiGestioneCantieri"%>
<%@page import="com.apconsulting.luna.ejb.TipologiaDocumentiCantiere.ITipologiaDocumentiCantiereHome"%>
<%@page import="com.apconsulting.luna.ejb.ErogazioneCorsi.ErogazioneCorsi_DTEGet_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrProcedimento.IAnagrProcedimentoHome"%>
<%@page import="com.apconsulting.luna.ejb.ErogazioneCorsi.IErogazioneCorsiHome"%>


<%!
  String BuildFornitoriComboBox(IErogazioneCorsiHome home, long lCOD_DTE) {
        String str = "";
        String strSEL = "";
        java.util.Collection col = home.getErogazioneCorsi_DTEGet_View();
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            ErogazioneCorsi_DTEGet_View dt = (ErogazioneCorsi_DTEGet_View) it.next();
            strSEL = "";
            long var1 = dt.COD_DTE;
            if (lCOD_DTE == var1) {
               strSEL = "selected";
             } else {
             strSEL = "";
             }
            str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.RAG_SCL_DTE + "</option>";
        }
        return str;
    }

  String BuildDocumentoComboBox(IAnagrDocumentiGestioneCantieriHome home, long lCOD_DOC, long lCOD_AZL) {
        String str = "";
        String strSEL = "";
        java.util.Collection col = home.getDocumentiGet_View(lCOD_AZL);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnagrDocumentoGestioneCantieri_View dt = (AnagrDocumentoGestioneCantieri_View) it.next();
            strSEL = "";
            long var1 = dt.lCOD_DOC;
            if (lCOD_DOC == var1) {
               strSEL = "selected";
             } else {
             strSEL = "";
             }
            str = str + "<option " + strSEL + " value=\"" + var1 + "\">" + dt.strNOM_TPL_DOC + "_" +dt.strNUM_DOC+ "_" +dt.dtDAT_DOC+ "_" +dt.strTIT_DOC+" </option>";
        }
        return str;
    }

%>
