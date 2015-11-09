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
    Document   : ANA_CON_SER_Util
    Created on : 24-apr-2008, 15.45.01
    Author     : Giancarlo Servadei
--%>

<%!

    //Servizio responsabile:
    String BuildServizioResponsabileCombo(IUnitaOrganizzativaHome home, long SELECTED_ID, long AZL_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getComboView(AZL_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            UnitaOrganizzativa_ComboView uni = (UnitaOrganizzativa_ComboView) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == uni.lCOD_UNI_ORG) {
                    strSEL = "selected";
                }
            }
            str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(uni.lCOD_UNI_ORG)
                    .append("\">")
                    .append(uni.strNOM_UNI_ORG)
                    .append("</option>");
        }
        return str.toString();
    }


        //Copia Da:
        String BuildCopiaDaCombo(IAnaContServHome home, long AZL_ID) {
            StringBuilder str = new StringBuilder();
            java.util.Collection col = home.getCopiaDa_Form(AZL_ID);
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                AnaContServ_CopiaDa_Form dt = (AnaContServ_CopiaDa_Form) it.next();
                     str.append("<option ")
                        .append(" value=\"")
                        .append(dt.COD_SRV)
                        .append("\">")
                        .append(dt.PRO_CON)
                        // .append((dt.DES_CON != null && dt.DES_CON.equals("") == false)?" - " + dt.DES_CON:"")
                        .append("</option>");                
            }
            return str.toString();
        }
    

        //Ditta Appaltatrice:
        String BuildDittaAppaltatriceCombo(IDittaEsternaHome home, long SELECTED_ID, long AZL_ID) {
        StringBuilder str = new StringBuilder();
        String strSEL = "";
        java.util.Collection col = home.getRagSclDteByCodDte(AZL_ID);
        java.util.Iterator it = col.iterator();
        while (it.hasNext()) {
            RagSclDteByCodDte dt = (RagSclDteByCodDte) it.next();
            strSEL = "";
            if (SELECTED_ID != 0) {
                if (SELECTED_ID == dt.COD_DTE) {
                    strSEL = "selected";
                }
            }
                 str.append("<option ")
                    .append(strSEL)
                    .append(" value=\"")
                    .append(dt.COD_DTE)
                    .append("\">")
                    .append(dt.RAG_SCL_DTE)
                    .append("</option>");
        }
        return str.toString();
    }

%>
