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
    Document   : menu_secondario
    Created on : 20-lug-2015, 15.39.52
    Author     : acavola
--%>
<!-- questo TD è quello che contiene il menu secodnario -->


 
<td valign="top"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="5px" height="40px"  >
        <tr align="center">
    <!-- Link per cambio utente e logout  logo SDS e S2S- INIZIO -->
        <!--CAMBIO UTENTE /ESCI-->
            <td nowrap width="10%" style=" padding-right:10px;">
                
                <a href="http://www.s2sprodotti.it/" target="_blank" title="S2SProdotti">
                    <img src="_images/logo_multicolore.gif"  alt="S2S prodotti" style="height: 30px; border:0px; padding-right:20px;">
                </a> 
                

            </td>
                                                                                
        <!--CAMBIO UTENTE /ESCI-->
            <td nowrap width="10%" >
                
                <a href="_include/logout.jsp?logoutOrChange=change">
                    <img src="_images/icon/cambio_user.png" alt="Cambia Utente"  style="height: 30px; border:0px; padding-right:20px;"> 
                </a>
                
                <a href="_include/logout.jsp?logoutOrChange=logout">
                    <img src="_images/icon/logout.png" alt="Esci" style="height: 30px; border:0px; padding-right:10px;">                           
                </a>
            </td> 
                                        
        <!-- SPAZIO--> 
            <td width="80%">                                            
                <!--<img src="_images/nostre img/sds.gif" alt="Sistema della Sicurezza" height="40px">-->
                                            
            </td>
                                        
        <!-- LOGO S2S-->                                
            <td nowrap width="10%">
                <img src="<%=logo%>" alt="<%=logoDesc%>" style="height: 40px; border:0px;"> 
             
            </td>
                              
        <!-- HELP
            <td nowrap width="5%" >
                <a href="http://www.s2sprodotti.it/">
                    <img src="_images/icon/help.png" alt="help" width="30px" border="0" >                           
                </a>
            </td>
        </tr>-->
    <!-- Link per cambio utente e logout logo SDS S2S- FINE -->
     <!--</table>   
</td>-->
