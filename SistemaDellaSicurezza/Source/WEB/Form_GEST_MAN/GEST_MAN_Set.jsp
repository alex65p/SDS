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

<%@ page import="java.util.Collection"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Vector"%>
<%
    /*
     <file>
     <versions>	
     <version number="1.0" date="10/02/2004" author="Kushkarov Jura">
     <comments>
     <comment date="10/02/2004" author="Kushkarov Jura">
     <description>Shablon formi ANA_SCH_SCH_PRG_Form.jsp</description>
     </comment>		
     </comments> 
     </version>
     </versions>
     </file> 
     */
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.OperazioneSvolta.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.*" %>
<%@ page import="com.apconsulting.luna.ejb.ProtocoleSanitare.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisuraPreventiva.*" %>
<%@ page import="com.apconsulting.luna.ejb.AssRischioAttivita.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<script src="../_scripts/Alert.js"></script>
<script>
    var err = false;
    var isNew = false;
</script>

<%!  String str = "";%>

<%
    IAnagrLuoghiFisici ana_bean = null;
    IAttivitaLavorative bean = null;
    ICorsi cor_bean = null;
    IOperazioneSvolta os_bean = null;
    IProtocoleSanitare ps_bean = null;
    ITipologiaDPI tpl_bean = null;
    IMisuraPreventiva mis_pet_bean = null;
    IAssRischioAttivita rischioAttivitaBean = null;
    ILuogoFisicoRischio rischioLuogoFisicoBean = null;

    IAnagrLuoghiFisiciHome AnagrLuoghihome = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean");
    IAttivitaLavorativeHome home = (IAttivitaLavorativeHome) PseudoContext.lookup("AttivitaLavorativeBean");
    ICorsiHome Corsihome = (ICorsiHome) PseudoContext.lookup("CorsiBean");
    IOperazioneSvoltaHome Operazionehome = (IOperazioneSvoltaHome) PseudoContext.lookup("OperazioneSvoltaBean");
    IProtocoleSanitareHome ProtocoleSanitarehome = (IProtocoleSanitareHome) PseudoContext.lookup("ProtocoleSanitareBean");
    ITipologiaDPIHome TipologiaDPIhome = (ITipologiaDPIHome) PseudoContext.lookup("TipologiaDPIBean");
    IMisuraPreventivaHome MisuraPreventivahome = (IMisuraPreventivaHome) PseudoContext.lookup("MisuraPreventivaBean");
    IMacchinaHome mac_home = (IMacchinaHome) PseudoContext.lookup("MacchinaBean");
    IAssociativaAgentoChimicoHome sos_chi_home = (IAssociativaAgentoChimicoHome) PseudoContext.lookup("AssociativaAgentoChimicoBean");
    IAssRischioAttivitaHome rischioAttivitaHome =(IAssRischioAttivitaHome)PseudoContext.lookup("AssRischioAttivitaBean");
    ILuogoFisicoRischioHome rischioLuogoFisicoHome = (ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");

    String strCOD = "";
    String str = "";
    String str1 = "";
    Long lCOD_MAN = null;
    String strCOD_MAC = "";
    String TYPE_MAN = "";
    long lCOD_AZL = Security.getAzienda();
    long lCOD_SOS_CHI = 0;
    long lCOD_RSO = 0;
    Checker c = new Checker();
    String strDEL = c.checkString("DEL", request.getParameter("DEL"), false);
    long lCOD_MAC = 0;
    long lCOD_OPE_SVO = 0;
    String res = "";
    String res2 = "";
    java.util.ArrayList AZIENDA_ID = null;
    java.util.ArrayList col_lCOD_LUO_FSC = null;
    java.util.ArrayList col_lCOD_MAN = null;

    String strTPL_CLF_RSO = c.checkString("tpl_clf_rso", request.getParameter("TPL_CLF_RSO"), false);

    java.util.Date cdt = new java.util.Date();
    java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());

    strCOD = request.getParameter("COD");
    TYPE_MAN = request.getParameter("TYPE_MAN");
    long lCOD_PAR = new Long(strCOD).longValue();
    Long COD_PAR = new Long(strCOD);
    lCOD_RSO = c.checkLong("rso", request.getParameter("COD_RSO"), false);
    lCOD_SOS_CHI = c.checkLong("sos chi", request.getParameter("COD_SOS_CHI"), false);
    lCOD_MAC = c.checkLong("mac", request.getParameter("COD_MAC"), false);
    lCOD_OPE_SVO = c.checkLong("ope svo", request.getParameter("COD_OPE_SVO"), false);

    col_lCOD_LUO_FSC = c.checkAlLong("Luoghi fisici ", request.getParameterValues("cbCOD_LUO_FSC"));
    col_lCOD_MAN = c.checkAlLong("Attivita lavorative ", request.getParameterValues("cbCOD_MAN"));

    if (Security.isExtendedMode()) {
        AZIENDA_ID = c.checkAlLong("aziendaIDs", request.getParameterValues("AZIENDA_ID"));
    }
    if (TYPE_MAN.equals("cor")) {
        cor_bean = Corsihome.findByPrimaryKey(COD_PAR);
        cor_bean.removeLUO_FSC_COR();
        cor_bean.removeGEST_MAN_COR();
    }
    if (TYPE_MAN.equals("dpi")) {
        tpl_bean = TipologiaDPIhome.findByPrimaryKey(COD_PAR);
        tpl_bean.removeLUO_FSC_DPI();
        tpl_bean.removeGEST_MAN_DPI();
    }
    if (TYPE_MAN.equals("pro_san")) {
        ps_bean = ProtocoleSanitarehome.findByPrimaryKey(new ProtocoleSanitarePK(lCOD_AZL, COD_PAR.longValue()));
        ps_bean.removeLUO_FSC_PRO_SAN();
        ps_bean.removeGEST_MAN_PRO_SAN();
    }
    if (TYPE_MAN.equals("mis_pet")) {
        mis_pet_bean = MisuraPreventivahome.findByPrimaryKey(new MisuraPreventivaPK(lCOD_AZL, COD_PAR.longValue()));
        mis_pet_bean.removeLUO_FSC_MIS_PET();
        mis_pet_bean.removeGEST_MAN_MIS_PET();
    }
    if (TYPE_MAN.equals("ope_svo")) {
        os_bean = Operazionehome.findByPrimaryKey(COD_PAR);
        os_bean.removeGEST_MAN_OPE_SVO();
    }

    Iterator it_man = col_lCOD_MAN.iterator();
    if (it_man != null) {
        while (it_man.hasNext()) {
            Long lngCOD_MAN = (Long) it_man.next();
            bean = home.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, lngCOD_MAN.longValue()));
            try {
                Vector DPI_Associati_Originale = null;
                if (TYPE_MAN.equals("dpi") || TYPE_MAN.equals("ope_svo")) {
                    DPI_Associati_Originale = new Vector();
                    Iterator it = bean.getDPI_View().iterator();
                    while (it.hasNext()) {
                        DPI_Associati_Originale.add(new Long(((AttLav_DPI_View) it.next()).COD_TPL_DPI));
                    }
                }
                if (TYPE_MAN.equals("cor")) {
                    bean.addGEST_MAN_COR(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("dpi")) {
                    bean.addGEST_MAN_DPI(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("pro_san")) {
                    bean.addGEST_MAN_PRO_SAN(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("mis_pet")) {
                    // Estraggo il legame "Attività lavorativa / Rischio"
                    rischioAttivitaBean = rischioAttivitaHome.findByUniqueKey(lngCOD_MAN, lCOD_RSO, lCOD_AZL);
                    // Lego (specializzo) la misura all'attività lavorativa
                    String returnString = rischioAttivitaBean.addExMesurePreventive(new String[] {Long.toString(lCOD_PAR)});
                }
                if (TYPE_MAN.equals("ope_svo")) {
                    bean.addGEST_MAN_OPE_SVO(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("dpi") || TYPE_MAN.equals("ope_svo")) {
                    String SendedMail = SendMail4AddedDPI_ANA_RSO(lngCOD_MAN.toString(), DPI_Associati_Originale);
                    if (!SendedMail.trim().equals("")) {
                        out.println("<script>alert('" + SendedMail + "')</script>");
                    }
                }
                /*if (TYPE_MAN.equals("mac_ope_svo"))
                 {
                 strCOD_MAC = request.getParameter("COD_MAC");
                 if (strDEL.equals("")){
                 out.println("ADD RISCHI");
                 out.println("cod_mac-"+strCOD_MAC+"<br>");
                 Collection col  = mac_home.getRischioMacchina_View(strCOD_MAC);		
                 Iterator it = col.iterator();
                 if (it!=null){
                 while (it.hasNext()){
                 RischioMacchina_View v = (RischioMacchina_View)it.next();
                 //out.println("cod_rso-"+v.COD_RSO+"<br>");
                 bean.addXRischioAssociations(v.COD_RSO, lCOD_AZL);
                 out.println("bean.addXRischioAssociations("+v.COD_RSO+", "+lCOD_AZL+");");
                 }
                 }
                 }
                 else if (strDEL.equals("1")){
                 out.println("DEL RISCHI");
                 Collection col  = mac_home.getRischioMacchina_View(strCOD_MAC);		
                 out.println("cod_mac-"+strCOD_MAC+"<br>");
                 Iterator it = col.iterator();
                 if (it!=null){
                 while (it.hasNext()){
                 RischioMacchina_View v = (RischioMacchina_View)it.next();
                 out.println(v.COD_RSO+"<br>");
                 bean.deleteXRischioAssociations(v.COD_RSO, lCOD_AZL);
                 }
                 }
                 }
                 }	*/
                /*if (TYPE_MAN.equals("sos_chi_ope_svo")){
                 if (strDEL.equals("")){
                 out.println("ADD RISCHI");
                 out.println("cod_sos_chi-"+lCOD_SOS_CHI+"<br>");
                 Collection col  = sos_chi_home.getRischioSostanza_View(lCOD_SOS_CHI);		
                 Iterator it = col.iterator();
                 if (it!=null){
                 while (it.hasNext()){
                 RischioSostanza_View v = (RischioSostanza_View)it.next();
                 //out.println("cod_rso-"+v.COD_RSO+"<br>");
                 bean.addXRischioAssociations(v.lCOD_RSO, lCOD_AZL);
                 out.println("bean.addXRischioAssociations("+v.lCOD_RSO+", "+lCOD_AZL+");");
                 }
                 }
                 }
                 else if (strDEL.equals("1")){
                 out.println("DEL RISCHI");
                 Collection col  = sos_chi_home.getRischioSostanza_View(lCOD_SOS_CHI);		
                 out.println("cod_sos_chi-"+lCOD_SOS_CHI+"<br>");
                 Iterator it = col.iterator();
                 if (it!=null){
                 while (it.hasNext()){
                 RischioSostanza_View v = (RischioSostanza_View)it.next();
                 out.println(v.lCOD_RSO+"<br>");
                 bean.deleteXRischioAssociations(v.lCOD_RSO, lCOD_AZL);
                 }
                 }
                 }
                 }*/

            } catch (Exception ex) {
                out.println("<script>err=true;alert(\"" + ex.toString() + "\");</script>");
            }

            //	oldPos=pos+1;
        }
        //<alex date="10/04/2004">
        //-------add macchina to operazione svolta ---------------
        if (TYPE_MAN.equals("mac_ope_svo")) {
            strCOD_MAC = request.getParameter("COD_MAC");
            if (strDEL.equals("")) {
                res = home.addMacchinaToOperazioneSvolta(lCOD_AZL, lCOD_MAC, lCOD_OPE_SVO, AZIENDA_ID, col_lCOD_MAN);
                out.print("<br>" + res);
                if (res.indexOf("FAILED") != -1) {
                    out.println("<script>err=true;alert(arraylng[\"MSG_0070\"]);</script>");
                }
            }
        }
        if (TYPE_MAN.equals("sos_chi_ope_svo")) {
            out.println("ADD RISCHI");
            out.println("cod_sos_chi-" + lCOD_SOS_CHI + "<br>");
            if (strDEL.equals("")) {
                res = home.addSostanzaToOperazioneSvolta(lCOD_AZL, lCOD_SOS_CHI, lCOD_OPE_SVO, AZIENDA_ID, col_lCOD_MAN);
                out.print("<br>" + res);
                if (res.indexOf("FAILED") != -1) {
                    out.println("<script>err=true;alert(arraylng[\"MSG_0071\"]);</script>");
                }
            }
        }


        //</alex>
    }

    Iterator it_luo = col_lCOD_LUO_FSC.iterator();
    if (it_luo != null) {
        while (it_luo.hasNext()) {
            Long lngCOD_LUO_FSC = (Long) it_luo.next();
            ana_bean = AnagrLuoghihome.findByPrimaryKey(lngCOD_LUO_FSC);
            try {
                if (TYPE_MAN.equals("cor")) {
                    ana_bean.addLUO_FSC_COR(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("dpi")) {
                    ana_bean.addLUO_FSC_DPI(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("pro_san")) {
                    ana_bean.addLUO_FSC_PRO_SAN(lCOD_PAR, dtDAT_INZ);
                }
                if (TYPE_MAN.equals("mis_pet")) {
                    // Estraggo il legame "Luogo fisico / Rischio"
                    rischioLuogoFisicoBean = rischioLuogoFisicoHome.findByUniqueKey(lCOD_RSO, lCOD_AZL, lngCOD_LUO_FSC);
                    // Lego (specializzo) la misura al luogo fisico
                    String returnString = rischioLuogoFisicoBean.addExMesurePreventive(new String[] {Long.toString(lCOD_PAR)});
                }
            } catch (Exception ex) {
                out.println("<script>Alert.Error.showDublicate();err=true;</script>");
            }
        }
    }

//<alex date="13/04/2004">
//------add rischio to macchina . Multiazienda/Monoazienda mode ---//
    try {
        if (TYPE_MAN.equals("macchina_rischio")) {
            out.println("add rischio to macchina <br>");
            if (strDEL.equals("")) {
                out.println("adding...<br>");
                out.println(strTPL_CLF_RSO);
                //if (strTPL_CLF_RSO.equals("O/T") || strTPL_CLF_RSO.equals("O")){
                res = home.addRischioToMacchina(lCOD_AZL, lCOD_MAC, lCOD_RSO, strTPL_CLF_RSO, AZIENDA_ID, col_lCOD_MAN, col_lCOD_LUO_FSC);
                //}

                out.print("<br>" + res);
                if (res.indexOf("FAILED") != -1) {
                    out.println("<script>err=true;alert(arraylng[\"MSG_0072\"]);</script>");
                } else {
                    out.println("<br>SUCCESS!");
                }
            } else if (strDEL.equals("1")) {
            }
        }

        //-------add rischio to sastanza chimica. multiazienda mode
        if (TYPE_MAN.equals("sos_chi_rischio")) {
            out.println("add sos chi to rischio <br>");
            if (strDEL.equals("")) {
                out.println("adding...<br>");
                out.println(strTPL_CLF_RSO);
                //		if (strTPL_CLF_RSO.equals("O/T")||strTPL_CLF_RSO.equals("O")){
                res = home.addRischioToSostanzeChimiche(lCOD_AZL, lCOD_SOS_CHI, lCOD_RSO, strTPL_CLF_RSO, AZIENDA_ID, col_lCOD_MAN, col_lCOD_LUO_FSC);
                //		}
                out.print("<br>" + res);
                out.print("<br>" + res2);
                if (res.indexOf("FAILED") != -1) {
                    out.println("<script>err=true;alert(arraylng[\"MSG_0072\"]);</script>");
                }
            } else if (strDEL.equals("1")) {
            }
        }
    } catch (Exception ex) {
        out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    }
//</alex>
%>
<script>
    if (!err) {
        Alert.Success.showSaved();
        window.close();
    } else {
        parent.returnValue = "ERROR";
        window.close();
    }
</script>


