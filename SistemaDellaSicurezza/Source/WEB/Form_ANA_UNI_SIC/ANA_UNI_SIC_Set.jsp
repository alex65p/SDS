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
    <version number="1.0" date="20/02/2004" author="Malyuk Sergey">		
    <comments>
    < comment date="20/02/2004" author="Malyuk Sergey">
    < description>Realizazija EJB dlia objecta UnitaSicurezza
    </comment>		
    </comments> 
    </version>
    </versions>
    </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
    var isNew=false;
</script>
<%
    IUnitaSicurezza bean = null;
//-----start check section--------------------------------
    Checker c = new Checker();

    long lCOD_UNI_SIC = c.checkLong("COD_UNI_SIC", request.getParameter("COD_UNI_SIC"), true);
    String strNOM_UNI_SIC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.unità.sic."), request.getParameter("NOM_UNI_SIC"), true);
    String strDES_UNI_SIC = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_UNI_SIC"), false);
    long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
    long lCOD_UNI_SIC_ASC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome"), request.getParameter("COD_UNI_SIC_ASC"), false);

    if (c.isError) {
        String err = c.printErrors();
        out.print("<script>err=true;alert(\"" + err + "\");</script>");
        return;
    }
    out.print(request.getParameter("SBM_MODE") + "asdasdasd");
    out.print("new");
    IUnitaSicurezzaHome home = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");

//------end check section--------------------------------
    try {
        if (request.getParameter("SBM_MODE") != null) {
            ReqMODE = request.getParameter("SBM_MODE");
            if (ReqMODE.equals("edt")) {
                bean = home.findByPrimaryKey(new Long(lCOD_UNI_SIC));
            } else {
                out.print("new");
                bean = home.create(strNOM_UNI_SIC, lCOD_AZL);
            }
            if (bean != null) {
                // Controllo che l'unità di sicurezza corrente non abbia
                // se stessa come "Unità sicurezza associata"

                // Se trovo questo tipo di associazione avviso l'utente,
                // non salvo questa relazione, ma proseguo l'operazione corrente.
                if (lCOD_UNI_SIC_ASC == bean.getCOD_UNI_SIC()){
                    out.println("<script>alert(arraylng[\"MSG_0207\"]);</script>");
                    return;
                }
                
                // Controllo che l'unità di sicurezza corrente non sia
                // associata, all'interno della gerarchia delle U.S.,
                // ad una "Unità sicurezza associata" a lei figlia.

                // Se trovo questo tipo di associazione avviso l'utente
                // non salvo questa relazione, ma proseguo l'operazione corrente.
                if (lCOD_UNI_SIC_ASC != 0) {
                    ArrayList ListUS = new ArrayList();
                    GetUSTree(bean.getCOD_UNI_SIC(), ListUS, lCOD_AZL);
                    Iterator it_ListUS = ListUS.iterator();

                    while (it_ListUS.hasNext()) {
                        UnitaSicurezzaView US = (UnitaSicurezzaView) it_ListUS.next();
                        if (lCOD_UNI_SIC_ASC == US.lCOD_UNI_SIC) {
                            out.println("<script>alert(arraylng[\"MSG_0061\"]);</script>");
                            return;
                        }
                    }
               } 
                
                bean.setNOM_UNI_SIC__COD_AZL(strNOM_UNI_SIC, lCOD_AZL);
                bean.setDES_UNI_SIC(strDES_UNI_SIC);
                bean.setCOD_UNI_SIC_ASC(lCOD_UNI_SIC_ASC);
                
                out.print("<script>isNew=true;</script>");
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
%>
<div id="divErr">
    <%=ex%>
</div>
<script>
    err=true;
</script>
<%
    }
%>
<%!
// A partire dalla Unità di sicurezza passata in input, 
// scrive nel parametro ListUS una lista con tutte le voci del ramo figlio.
    void GetUSTree(long lCOD_UNI_SIC, Collection ListUS, long lCOD_AZL) throws Exception {
        IUnitaSicurezzaHome homeTemp = (IUnitaSicurezzaHome) PseudoContext.lookup("UnitaSicurezzaBean");
        IUnitaSicurezza beanTemp = homeTemp.findByPrimaryKey(new Long(lCOD_UNI_SIC));
        if (beanTemp != null) {
            Collection USChildren = beanTemp.getChildren(lCOD_AZL);
            if (USChildren != null) {
                Iterator it_USChildren = USChildren.iterator();
                while (it_USChildren.hasNext()) {
                    UnitaSicurezzaView US = (UnitaSicurezzaView) it_USChildren.next();
                    ListUS.add(US);
                    GetUSTree(US.lCOD_UNI_SIC, ListUS, lCOD_AZL);
                }
            }
        }
    }
%>
<script>
    if (!err){
            parent.getNode(<%=lCOD_UNI_SIC%>);
            <% if (!ReqMODE.equals("edt")) {%>
                        Alert.Success.showCreated();
            <% } else {%>
                        Alert.Success.showSaved();  
            <% }%>
            parent.getNodes();
        }
        else{
            Alert.Error.showDublicate();
        }
</script>
