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
    <version number="1.0" date="18/02/2004" author="Khomenko Juliya">
          <comments>
                  <comment date="18/02/2004" author="Khomenko Juliya">
                   <description>Create ANA_DOC_VLU_Attach.jsp</description>
                  </comment>
        </comments>
    </version>
  </versions>
</file>
*/
%>
<%@ page import="com.apconsulting.luna.ejb.ValutazioneRischi.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="ANA_DOC_VLU_Util.jsp" %>
<script>
  var err=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%

    long id_attachment=0;
    long priority=0;
  IValutazioneRischi bean=null;

    String strID = (String)request.getParameter("ID_PARENT");

    String strSubject=(String)request.getParameter("ATTACH_SUBJECT");
  if(strSubject.equals("DOC_VLU")){
        try{
        IValutazioneRischiHome home=(IValutazioneRischiHome)PseudoContext.lookup("ValutazioneRischiBean");
            bean = home.findByPrimaryKey(new Long(Long.parseLong(strID)));
            id_attachment = Long.parseLong((String)request.getParameter("ID"));
            priority = Long.parseLong((String)request.getParameter("PRT"));
        }catch(Exception ex){
            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
            return;
        }
        try{
              bean.addCOD_ARE(id_attachment, priority);
        }
        catch(Exception ex){
            out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
            return;
        }
  }
    else if(strSubject.equals("DOC")){
        try{
        IValutazioneRischiHome home=(IValutazioneRischiHome)PseudoContext.lookup("ValutazioneRischiBean");
            bean = home.findByPrimaryKey(new Long(Long.parseLong(strID)));
            id_attachment = Long.parseLong((String)request.getParameter("ID"));
        }catch(Exception ex){
            out.print(printErrAlert("divErr", "Error.showNotFound", ex));
            return;
        }
        try{
              bean.addCOD_DOC(id_attachment);
        }
        catch(Exception ex){
            out.print(printErrAlert("divErr", "Error.showDublicateChild",ex));
            return;
        }
  }
    else{
       return;
    }
%>

<script>
    parent.ToolBar.Return.Do();
</script>
