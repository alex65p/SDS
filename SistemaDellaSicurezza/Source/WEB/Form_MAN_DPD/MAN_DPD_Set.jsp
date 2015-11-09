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
    < version number="1.0" date="09/02/2004" author="Malyuk Sergey">
      < comments>
               < comment date="09/02/2004" author="Malyuk Sergey">
                   < description>Realizazija EJB dlia objecta Dipendente
               < /comment>
               < comment date="10/02/2004" author="Juli khomenko">
                   < description>Dobavila View for Paragrafo
                 < /comment>
      < /comments>
    < /version>
  < /versions>
< /file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../Form_ANA_MAN/ANA_MAN_Mail.jsp"%>

<script type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
    var isNew=false;
</script>

<%!
    String ReqMODE;    // parameter of request
%>

<%
//-----start check section--------------------------------
Checker c = new Checker();

Long lCOD_DPD=new Long(request.getParameter("COD_DPD"));
long lCOD_UNI_ORG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Unità.organizzativa"),request.getParameter("COD_UNI_ORG"),true);
long lCOD_MAN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa"),request.getParameter("COD_MAN"),true);
java.sql.Date dtDAT_INZ=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.inizio"),request.getParameter("DAT_INZ"),true);
java.sql.Date dtDAT_FIE=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.fine"),request.getParameter("DAT_FIE"),false);
long lCOD_TPL_CON=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.contrattuale"),request.getParameter("COD_TPL_CON"),false);

if (c.isError)
     {
      String err = c.printErrors();
      out.print("<script>alert(\""+err+"\");</script>");
      return;
     }
if (request.getParameter("DAT_FIE")==null)
     {dtDAT_FIE=null;}
if ((dtDAT_INZ!=null)&&(dtDAT_FIE!=null)){
    if (dtDAT_INZ.compareTo(dtDAT_FIE)>0) {
        out.print("<script>parent.alert(arraylng[\"MSG_0073\"]);</script>");
        return;
    }
}

IDipendente bean=null;
IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
bean = home.findByPrimaryKey(lCOD_DPD);

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
    ReqMODE=request.getParameter("SBM_MODE");
    long oldCOD_UNI_ORG = 0;
    long oldCOD_MAN = 0;
    java.sql.Date oldDAT_INZ=null;
    if(ReqMODE.equals("edt"))
    {
        oldCOD_UNI_ORG=c.checkLong("COD_UNI_ORG",request.getParameter("oldCOD_UNI_ORG"),false);
        oldCOD_MAN=c.checkLong("COD_MAN",request.getParameter("oldCOD_MAN"),false);
        oldDAT_INZ=java.sql.Date.valueOf(request.getParameter("oldDAT_INZ"));
        out.print(oldCOD_UNI_ORG);
        out.print(oldCOD_MAN);
        out.print(oldDAT_INZ);
        out.print(lCOD_UNI_ORG);
        out.print(lCOD_MAN);
        out.print(dtDAT_INZ);

        bean.removeCOD_MAN(oldCOD_MAN,oldCOD_UNI_ORG,oldDAT_INZ);
        bean.addCOD_MAN(lCOD_UNI_ORG,lCOD_MAN,dtDAT_INZ,dtDAT_FIE,lCOD_TPL_CON);
    }
    else
    {
        %><script type="text/javascript">isNew=true;</script><%
            try{
            bean.addCOD_MAN(lCOD_UNI_ORG,lCOD_MAN,dtDAT_INZ,dtDAT_FIE,lCOD_TPL_CON);
            }catch(Exception ex){
                out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                return;
            }
    }
    if (lCOD_UNI_ORG != oldCOD_UNI_ORG || lCOD_MAN != oldCOD_MAN){
        java.util.Date currentDate = new java.util.Date();
        if (dtDAT_FIE == null || dtDAT_FIE.compareTo(currentDate) > 0){
           String SendedMail = SendMail4AddedDPI_ANA_DPD(lCOD_UNI_ORG, lCOD_MAN, lCOD_DPD.longValue());
           if (!SendedMail.trim().equals("") ){
                out.println("<script>alert('" + SendedMail + "')</script>");                                               
           }
        }
    }
}
%>

<script>
if(!err){
        parent.returnValue="OK";
        if (isNew)
             {
                 Alert.Success.showCreated();
                 parent.ToolBar.OnNew('ID=<%=lCOD_UNI_ORG+"|"+lCOD_MAN%>&dat_inz=<%=dtDAT_INZ%>');
             }else{
                        Alert.Success.showSaved();
                    }
    }else{
        parent.returnValue="ERROR";
}
</script>
