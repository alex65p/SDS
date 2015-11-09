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
    <version number="1.0" date="26/02/2004" author="Treskina Mary">
      <comments>
               <comment date="26/02/2004" author="Treskina Mary">
                LottiDPI
               </comment>
      </comments>
    </version>
  </versions>
</file>
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<%
    long id_attachment=0;
    Checker c = new Checker();
    long lNUM_PTG_DMD = c.checkLong("Numero Punteggio Domanda",request.getParameter("NUM_PTG_DMD"),true);
    if (c.isError)
    {
        String err = c.printErrors();
        out.println("<script>alert(\""+err+"\");</script>");
        return;
    }
    ITestVerifica bean=null;
    String strID = (String)request.getParameter("ID_PARENT");
    try{
        ITestVerificaHome home=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
        bean = home.findByPrimaryKey(new Long(strID));
        id_attachment=Long.parseLong((String)request.getParameter("ID"));
    }
    catch(Exception ex){
        out.print(printErrAlert("divErr", "Error.showNotFound", ex));
        return;
    }

    String strSubject=(String)request.getParameter("ATTACH_SUBJECT");

    try{
        if ("DOMANDA_TES_VRF".equals(strSubject)){
            //long lCOD_DMD_TES_VRF = id_attachment;

            //Long COD_DMD = new Long(id_attachment);
            //Domande = home.findByPrimaryKey(COD_DMD);

            long lNUM_MIN_PTG=bean.getNUM_MIN_PTG();
            long lNUM_MAX_PTG=bean.getNUM_MAX_PTG();
//out.print("lNUM_MIN_PTG="+lNUM_MIN_PTG+";lNUM_MAX_PTG="+lNUM_MAX_PTG+";lNUM_PTG_DMD="+lNUM_PTG_DMD);
            if (lNUM_PTG_DMD>=lNUM_MIN_PTG){
                 try{
                bean.addCOD_DMD(id_attachment, lNUM_PTG_DMD);
                    long lSUM_NUM_PTG=bean.sumNUM_PTG_DMD();
                    bean.setNUM_MAX_PTG(lSUM_NUM_PTG);
                }catch(Exception ex){
                out.println("<script>Alert.Error.showDublicate();err=true;</script>");
                }
                out.print ("<script>isNew=true;</script>");
            } else {
                out.println("<script>alert(arraylng[\"MSG_0040\"]);err=true;</script>");
                return;
            }
            //bean.addCOD_NOR_SEN(id_attachment);
        }
        else{
            return;
        }
    }
    catch(Exception ex){
        out.print(printErrAlert("divErr", "Error.showDublicateChild", ex));
        return;
    }
%>
<script>
    parent.ToolBar.Return.Do();
</script>
