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
    <version number="1.0" date="10/02/2004" author="Pogrebnoy Yura">
    <comments>
    <comment date="10/02/2004" author="Pogrebnoy Yura">
    <description>MAC_OPE_SVO_Return.jsp</description>
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
    var err=false;
    var isNew = false;
</script>
<script src="../_scripts/Alert.js"></script>
<script src="../_scripts/call_GEST_MAN.js"></script>
<%
    IMacchina mac = null;
    IMacchinaHome home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
    Checker c = new Checker();
    //long lCOD_TPL_MAC = c.checkLong("Descrizione tipologia",request.getParameter("COD_TPL_MAC"),true);   
    //String strDES_MAC = c.checkString("Descrizione",request.getParameter("DES_MAC"),true);
    //String strMDL_MAC = c.checkString("Modello",request.getParameter("MDL_MAC"),true);
    //String strIDE_MAC = c.checkString("Identificativo",request.getParameter("IDE_MAC"),true);
    long lCOD_MAC = c.checkLong(
            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                ?"Macchina.attrezzatura.impianto"
                :"Macchina/Attrezzatura"
            , request.getParameter("COD_MAC"), true);
    long lCOD_MAN = c.checkLong("Attivita Lavorativa", request.getParameter("COD_MAN"), false);
    String strCOD_MAC = c.checkString(
            ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                ?"Macchina.attrezzatura.impianto"
                :"Macchina/Attrezzatura"
            , request.getParameter("COD_MAC"), true);
    long lCOD_AZL = Security.getAzienda();
    boolean isCurrentOperazione = (c.checkTrigger("Cur macchina", request.getParameter("CUR_OPE")).equals("S"));
    String strID_PARENT = Formatter.format(request.getParameter("ID_PARENT"));
    long lID_PARENT = new Long(strID_PARENT).longValue();

    String NomeParent = request.getParameter("NomeParent");

    if (c.isError) {
        String err = c.printErrors();
        out.println("<script>alert(\"" + err + "\");</script>");
        return;
    }
//-------------------------------------------------------------------------------------------------------
//from ANA_OPE_SVO_Form
    if ("MACCHINA".equals(NomeParent)) {
        try {
            //out.print("addRSO_OPE_SVO("+lID_PARENT+", "+lCOD_AZL+", "+lCOD_MAC+")"+"<br>");
            //home.addRSO_OPE_SVO(lID_PARENT, lCOD_AZL, lCOD_MAC);
            //out.print("Added Macchine to Operazione Svolta ok!");
            out.print(lCOD_MAN);
            int iCOD_MAN = 0;

            if (!isCurrentOperazione) {
                if ((home.getOPE_SVO_MAN_View(strID_PARENT) != iCOD_MAN)) {
%>
<script>
    res=showGestMan(<%=strID_PARENT%>,"mac_ope_svo",<%= lCOD_MAN%>, <%= lCOD_MAC%>);
    if (!res){
        url="MAC_OPE_SVO_Return.jsp?NomeParent=MACCHINA&ID_PARENT=<%= strID_PARENT%>&CUR_OPE=S&COD_MAC=<%= lCOD_MAC%>";
        document.location.assign(url);
    }
</script>
<%
                } else {
                    home.addRSO_OPE_SVO(lID_PARENT, lCOD_AZL, lCOD_MAC);
                }
            } else {
                out.print("addRSO_OPE_SVO(" + lID_PARENT + ", " + lCOD_AZL + ", " + lCOD_MAC + ")" + "<br>");
                home.addRSO_OPE_SVO(lID_PARENT, lCOD_AZL, lCOD_MAC);
            }
        } catch (Exception ex) {
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }
    }
//from ANA_LUO_FSC_Form
    if ("MACCHINE".equals(NomeParent)) {
//Carica rischio
        try {
            out.print("addRischioAssociations(" + lID_PARENT + ", " + lCOD_AZL + ", " + lCOD_MAC + ")" + "<br>");
            home.addRischioAssociations(lID_PARENT, lCOD_AZL, lCOD_MAC);
            out.print("Added Macchine to Luogo Fisico ok!");
        } catch (Exception ex) {
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }
    }
//---------------------------------------------------------------------------
%>
<script>
    <!--
    if(!err){	
        parent.returnValue="OK";
        parent.ToolBar.Return.Do();
    }else{
        parent.returnValue="ERROR";	
    }	
    //-->
</script>
