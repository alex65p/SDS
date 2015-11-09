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
        < file>
        < versions>
        < version number="1.0" date="18/02/2003" author="EJBun 1.0">
        < comments>
        < comment date="18/02/2003" author="EJBun 1.0">
        < description>Realizazija EJB dlia objecta UnitaOrganizzativa</description>
        < /comment>
        < /comments>
        < /version>
        < /versions>
        < /file>
         */
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp"%>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var err=false;
</script>

<%
        IUnitaOrganizzativa bean = null;
//-----start check section--------------------------------
        Checker c = new Checker();

        long lCOD_UNI_ORG = c.checkLong("COD_UNI_ORG", request.getParameter("COD_UNI_ORG"), true);
        String strNOM_UNI_ORG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.unità"), request.getParameter("NOM_UNI_ORG"), true);
        String strDES_UNI_ORG = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DES_UNI_ORG"), false);
        String strEMAIL = c.checkEmail(ApplicationConfigurator.LanguageManager.getString("E-mail"), request.getParameter("EMAIL"), false);
        long lCOD_TPL_UNI_ORG = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia"), request.getParameter("COD_TPL_UNI_ORG"), true);
        long lCOD_UNI_ORG_ASC = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome"), request.getParameter("COD_UNI_ORG_ASC"), false);//Nome
        long lCOD_DPD = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Responsabile"), request.getParameter("COD_DPD"), true);

        long lCOD_AZL = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"), request.getParameter("COD_AZL"), true);
        String strDVR = c.checkTrigger(ApplicationConfigurator.LanguageManager.getString("D.V.R."), request.getParameter("DVR"));

        if (c.isError) {
            String err = c.printErrors();
            out.print("<script>err=true;alert(\"" + err + "\");</script>");
            return;
        }

        boolean ChangeData = false;
        IUnitaOrganizzativaHome home = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
        IValutazioneRischiHome doc_vlu_home = (IValutazioneRischiHome) PseudoContext.lookup("ValutazioneRischiBean");
        
//------end check section--------------------------------
        out.println(request.getParameter("SBM_MODE"));
        try {
            if (request.getParameter("SBM_MODE") != null) {
                boolean UOinTree = false;
                ReqMODE = request.getParameter("SBM_MODE");
                if (ReqMODE.equals("edt")) {
                    bean = home.findByPrimaryKey(new Long(lCOD_UNI_ORG));
                    if (bean.getNOM_UNI_ORG().equals(strNOM_UNI_ORG) == false) {
                        ChangeData = true;
                    }
                    if (bean.getCOD_UNI_ORG_ASC() != lCOD_UNI_ORG_ASC) {
                        ChangeData = true;
                        if (lCOD_UNI_ORG_ASC != 0) {
                            ArrayList ListUO = new ArrayList();
                            GetUOTree(lCOD_UNI_ORG, ListUO, lCOD_AZL);
                            Iterator it_ListUO = ListUO.iterator();

                            while (it_ListUO.hasNext()) {
                                UnitaOrganizzativaView UO = (UnitaOrganizzativaView) it_ListUO.next();
                                if (lCOD_UNI_ORG_ASC == UO.lCOD_UNI_ORG) {
                                    UOinTree = true;
                                    break;
                                }
                            }
                        }
                    }
                } else {
                    out.println(strNOM_UNI_ORG + "<br>");
                    out.println(lCOD_TPL_UNI_ORG + "<br>");
                    out.println(lCOD_DPD + "<br>");
                    out.println(lCOD_AZL + "<br>");

                    bean = home.create(strNOM_UNI_ORG, lCOD_TPL_UNI_ORG, lCOD_DPD, lCOD_AZL);
                    lCOD_UNI_ORG = bean.getCOD_UNI_ORG();
                }
                if (bean != null) {
                    // Controllo che l'unità organizzativa corrente non abbia
                    // se stessa come "Unità organizzativa associata"

                    // Se trovo questo tipo di associazione avviso l'utente 
                    // e annullo l'operazione corrente.
                    if (bean.getCOD_UNI_ORG() == lCOD_UNI_ORG_ASC) {
                        out.println("<script>alert(arraylng[\"MSG_0060\"]);</script>");
                        return;
                    }
                    
                    // Controllo che l'unità organizzativa corrente non sia
                    // associata, all'interno della gerarchia delle U.O.,
                    // ad una "Unità organizzativa associata" a lei figlia.

                    // Se trovo questo tipo di associazione avviso l'utente
                    // e annullo l'operazione corrente.
                    else if (UOinTree) {
                        out.println("<script>alert(arraylng[\"MSG_0061\"]);</script>");
                        return;
                    }

                    // Controllo che il flag "D.V.R." dell'unità organizzativa
                    // corrente non sia stato deselezionato, a fronte di una
                    // precedente selezione.

                    // Se trovo questo scenario, controllo che l'unità
                    // organizzativa corrente non sia associata ad uno o più
                    // D.V.R.
                    else if (bean.getDVR() != null && bean.getDVR().equals("S") && strDVR.equals("N") &&
                            doc_vlu_home.findEx(Security.getAzienda(), null, null, null, bean.getCOD_UNI_ORG(), 0).isEmpty() == false){
                                out.println("<script>alert(arraylng[\"MSG_0188\"]);</script>");
                                return;
                    }

                    else {
                        bean.setNOM_UNI_ORG(strNOM_UNI_ORG);
                        bean.setCOD_TPL_UNI_ORG(lCOD_TPL_UNI_ORG);
                        bean.setCOD_DPD__COD_AZL(lCOD_DPD, lCOD_AZL);
                        bean.setDES_UNI_ORG(strDES_UNI_ORG);
                        bean.setCOD_UNI_ORG_ASC(lCOD_UNI_ORG_ASC);
                        bean.setDVR(strDVR);
                        bean.setEMAIL(strEMAIL);
                    }
                }
            }
        } catch (Exception ex) {
%>
<div id="divErr">
    <%=ex.getMessage()%>
</div>
<script>
    err=true;
</script>
<%
        }
%>
<%!
// A partire dalla UO passata in input, 
// scrive nel parametro ListUO una lista con tutte le voci del ramo figlio.
    void GetUOTree(long lCOD_UNI_ORG, Collection ListUO, long lCOD_AZL) throws Exception {
        IUnitaOrganizzativaHome homeTemp = (IUnitaOrganizzativaHome) PseudoContext.lookup("UnitaOrganizzativaBean");
        IUnitaOrganizzativa beanTemp = homeTemp.findByPrimaryKey(new Long(lCOD_UNI_ORG));
        if (beanTemp != null) {
            Collection UOChildren = beanTemp.getChildren(lCOD_AZL);
            if (UOChildren != null) {
                Iterator it_UOChildren = UOChildren.iterator();
                while (it_UOChildren.hasNext()) {
                    UnitaOrganizzativaView UO = (UnitaOrganizzativaView) it_UOChildren.next();
                    ListUO.add(UO);
                    GetUOTree(UO.lCOD_UNI_ORG, ListUO, lCOD_AZL);
                }
            }
        }
    }
%>
<script>
    if (!err){
        Alert.Success.showSaved();
        //if(isNew) parent.ToolBar.OnNew("ID=<%//=lCOD_UNI_SIC%>");
        parent.getNode(<%= lCOD_UNI_ORG%>);
    <% if (!ReqMODE.equals("edt") || ChangeData) {%>
            parent.getNodes();
    <% }%>
        }
        else{

            Alert.Error.showDublicate();
        }
</script>
