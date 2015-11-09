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
    Document   : generalControl_ANA_DPD
    Created on : 28-nov-2014, 12.41.30
    Author     : BDP
 Gestione dell'etichetta che rileva il numero dei Dipendenti Attivi e Cessati per l'Azienda 
--%>

    <%
       
        if(ifMsr){
              String[] colCount= home.getCountDipendenteAttiviCessati(Security.getAzienda());
             if(colCount!=null){
              labelDipendentiAttiviCessati +="<br/> <font style='color:blue;font-weight: bold;'> "+ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore.in");      
              labelDipendentiAttiviCessati += " "+ Formatter.format(Security.getAziendaNameEx());
              labelDipendentiAttiviCessati +=" "+ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore.presenti");   
              labelDipendentiAttiviCessati +=" "+colCount[1];
              labelDipendentiAttiviCessati +=" "+ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore.attivo");   
              labelDipendentiAttiviCessati +=" "+colCount[0]+" </font>";
              labelDipendentiAttiviCessati +=" <font style='color:red;font-weight: bold;'>"+ApplicationConfigurator.LanguageManager.getString("Dati.lavoratore.cessato")+"</font>";   
             }
          }
    %>
