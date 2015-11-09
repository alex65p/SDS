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
    <version number="1.0" date="24/01/2004" author="Podmasteriev Alexandr">
        <comments>
            <comment date="24/01/2004" author="Podmasteriev Alexandr">
                <description>Shablon formi ANA_CAP_Form.jsp</description>
            </comment>		
	<comments>
            <comment date="21/01/2004" author="Podmasteriev Alexandr">
		<description>polychenie dannih ANA_CAP_Form.jsp</description>
            </comment>	
      </comments> 
    </version>
  </versions>
</file> 
*/
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Capitoli.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ include file="../_menu/menu/menuStructure.jsp" %>

<html>
<head>
<script>
    document.write("<title>" + getCompleteMenuPath(SubMenuDVR,1) + "</title>");
</script>
<LINK REL=STYLESHEET HREF="../_styles/style.css" TYPE="text/css">

</head>
<script>
	window.dialogWidth = "608px";
	window.dialogHeight = "165px";
</script>

<body>

<%
    String strCOD_CPL="";
    String strNOM_CPL="";

    ICapitoli Capitoli=null;
    if(request.getParameter("ID")!=null)
    {
        strCOD_CPL = request.getParameter("ID");
	
	//getting of Capitoli object
        ICapitoliHome home=(ICapitoliHome)PseudoContext.lookup("CapitoliBean"); 
        Long cpl_id=new Long(strCOD_CPL);
        Capitoli = home.findByPrimaryKey(cpl_id);
		
        // getting of object variables
        strNOM_CPL=Capitoli.getNOM_CPL();
    }	
%>

    <!-- form for addind  Utenzei-->
    <form name="forma" action="ANA_CPL_Set.jsp"  method="POST" target="ifrmWork">
    <input name="SBM_MODE" type="Hidden" value="<%=(strCOD_CPL=="")?"new":"edt"%>">
    <input type="hidden" name="CPL_ID" value="<%=strCOD_CPL%>">

        <table width="100%" border="0" cellspacing='5' cellpadding='0'>
            <tr>
                <td>
                    <table width="100%" border='0' cellspacing='5'>
                        <tr>
                            <td class="title">
                                <script>
                                    document.write(getCompleteMenuPathFunction
                                        (SubMenuDVR,1,<%=request.getParameter("ID")%>));
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <!-- inizio Toolbar -->
                                <table width="100%" border="0" cellspacing='0' cellpadding='0'>
                                    <tr><td>
                                    <%ToolBar.bCanDelete=(Capitoli!=null);%>	
                                    <%=ToolBar.build(2)%>
                                    </td></tr>
                                <!-- fine Toolbar -->
                                </table>
                            </td>
                        </tr>
                    </table>

                    <table width="100%" border="0" cellspacing='5'>
                        <tr>
                            <td>

                                <fieldset>
                                <legend><%=ApplicationConfigurator.LanguageManager.getString("Gestione.capitolo")%></legend>
                                    <table width="100%" border="0" cellspacing='5'>
                                        <tr>
                                            <td align="right" width="10%"><b><%=ApplicationConfigurator.LanguageManager.getString("Titolo")%></b></td>
                                            <td align="left" width="90%"><input tabindex="1" size="100" type="text" name="NOM_CPL" maxlength="100" value="<%=strNOM_CPL%>"></td>
                                            <!--td align="center"-->
                                                <!--fieldset valign="middle" style="margin: 0 0 0 8; width:100%;height:100%;">
                                                <legend>
                                                    Repository
                                                </legend>	
                                                    <table  border="0" style="width:100%; height:100%">
                                                        <tr>
                                                            <td width="50%" align="center"><button tabindex="5" onclick="CaricaDbRischio()"><img src="../_images/new/connect1.gif"/></button></td>
                                                            <td width="50%" align="center"><button tabindex="6" onclick="CaricaRpRischio()"><img src="../_images/new/pen2.gif"/></button></td>
                                                        </tr>
                                                    </table>
                                                </fieldset-->
                                            <!--/td-->
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <!--
            <tr>
                <td colspan="100%" align="center"><input type="Submit" value=" save"><input type="button" value=" Cancel " onclick="window.returnValue='CANCEL';window.close();"></td>
            </tr>
            -->
        </table>
    </form>
    <!-- /form for addind  Utenzei-->
    <iframe name="ifrmWork" src="../empty.txt" class="ifrmWork"></iframe>
</body>

<script language="JavaScript">
    
    function CaricaDbRischio() {
    //  window.open("../Form_CRM_CPL/CRM_CPL_Form.jsp");
        window.showModalDialog("../Form_CRM_CPL/CRM_CPL_Form.jsp", 0, "dialogWidth:470px;dialogHeight:340px;status:no;help:no;scroll:no;");
    }

    function CaricaRpRischio() {
        document.all['ifrmWork'].src="../Form_ANA_CPL/ANA_CPL_Repository.jsp?NOM_CPL="+document.all.forma.NOM_CPL.value;
    }
</script>

</html>
