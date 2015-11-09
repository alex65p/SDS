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
    Document   : CON_SER_SUB_APP_Util
    Created on : 13-mag-2008, 12.28.53
    Author     : Giancarlo Servadei
--%>

<%!
    //Il seguente metodo costruisce la comboBox 'Progressivo Contratto/Servizio'
    //e popola il campo text 'Descrizione'
    //fornendo la descrizione corrispondente a ciascun progr. cont/serv
    String BuildProgrContr_DescrizioneText(IAnaContServHome home, long SELECTED_ID, long AZL_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getDesConOnProCon(AZL_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            AnaContServ_DesConOnProCon objDES = (AnaContServ_DesConOnProCon) it.next();
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == objDES.COD_SRV) {
                    strSEL = "selected";
                }
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(objDES.COD_SRV)
                    .append("\"")
                    .append(" valueDES=\"")
                    .append(Formatter.format(objDES.DES_CON))
                    .append("\">").append(Formatter.format(objDES.PRO_CON))
                    .append("</option>");
        }
        return str.toString();
    }

    
    
    String BuildRagioneSociale_IndirizzoText(IDittaEsternaHome home, long SELECTED_ID, long AZL_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getIdzDteOnRagSclDte(AZL_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            DittaEsterna_IdzDteOnRagSclDte objIDZ = (DittaEsterna_IdzDteOnRagSclDte) it.next();
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == objIDZ.COD_DTE) {
                    strSEL = "selected ";
                }
            }
            str.append("<option ").append(strSEL).append(" value=\"").append(Formatter.format(objIDZ.COD_DTE)).append("\"").append(" valueIDZ=\"").append(Formatter.format(objIDZ.IDZ_DTE)).append("\">").append(Formatter.format(objIDZ.RAG_SCL_DTE)).append("</option>");
        }
        return str.toString();
    }
%>






