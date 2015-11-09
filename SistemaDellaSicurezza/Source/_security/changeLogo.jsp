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


<script type="text/javascript">
 /*
 * Document     : SDS
 * Type         : Java script controllo login
 * Created on   : 29-Lugl-2015
 * Author       : Agnese
 */
/* parent.window.location = parent.window.location;*/
   
/* CAMBIO LOGO IN RELAZIONE ALL'UTENTE*/  
function LoadLogoCliente(obj) {
        
        //alert (document.getElementById("idLogo").src);
        //alert(obj.id);
        //alert(obj.value);
        var nome_logo=obj.value;
        var percorso=document.getElementById("idLogo").src;
        //alert(percorso);
        var prefisso = percorso.split('logoCliente');
        //alert(prefisso[0]);
        
        prefisso=prefisso[0]+"logoCliente/"+nome_logo+".png";
        
        //alert(prefisso);
        /*console.log(prefisso);*/

        /*var logo = document.getElementById("PROFILE_SELECTOR").value;*/
        document.getElementById("idLogo").src = prefisso;

        

                        
                        }

   
</script>
