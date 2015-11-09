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
    Document   : SUB_APP_ANA_RIS_Form
    Created on : 29-mag-2008, 09.15.30
    Author     : Giancarlo Servadei
--%>
<%@ page import="com.apconsulting.luna.ejb.SubAppAnalisiRischi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Analisi.dei.rischi")%></title>
<link rel=STYLESHEET href="../_styles/style.css" type="text/css">
<script language="JavaScript" src="../_scripts/textarea.js"></script>
</head>
<script type="text/javascript">
    window.dialogWidth="545px";
    window.dialogHeight="480px";
</script>
<body>
<%
    String strCOD_SUB_APP = request.getParameter("ID_PARENT");
    String strCOD_RSO = request.getParameter("ID");
    String strFAS_LAV = "";
    String strMOD_OPE = "";
    String strMAT_PRO_IMP = "";
    String strRIS = "";
    String strMIS_PRE_PRO = "";
    
    ISubAppAnalisiRischiHome home = (ISubAppAnalisiRischiHome) PseudoContext.lookup("SubAppAnalisiRischiBean"); 
    ISubAppAnalisiRischi bean = null;
    
    if (strCOD_RSO != null)
    {
        bean = home.findByPrimaryKey(new SubAppAnalisiRischiPK(Long.parseLong(strCOD_SUB_APP), Long.parseLong(strCOD_RSO)));

        // getting of object variables
        strFAS_LAV = Formatter.format(bean.getFAS_LAV());
        strMOD_OPE = Formatter.format(bean.getMOD_OPE());
        strMAT_PRO_IMP = Formatter.format(bean.getMAT_PRO_IMP());
        strRIS = Formatter.format(bean.getRIS());
        strMIS_PRE_PRO = Formatter.format(bean.getMIS_PRE_PRO());
    } else {
        strCOD_RSO = "";
    }
%>

<script type="text/javascript">
    function getFasiList(){
        var obj = new Object();
        var url="Form_ANA_OPE_SVO/ANA_OPE_SVO_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30;dialogWidth:30;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].FAS_LAV.value = obj.CELLS[1];
        }
    }
    function getRischiList(){
        var obj = new Object();
        var url="Form_ANA_RSO/ANA_RSO_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30;dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].RIS.value = obj.CELLS[1];
        }
    }
    function getMisureList(){
        var obj = new Object();
        var url="Form_ANA_MIS_PET/ANA_MIS_PET_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30;dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].MIS_PRE_PRO.value = obj.CELLS[2];
        }
    }
</script>

<form action="SUB_APP_ANA_RIS_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_RSO == null || strCOD_RSO.equals("")) ? "new" : "edt"%>">
<input type="hidden" name="COD_RSO" value="<%=strCOD_RSO%>">
<input type="hidden" name="COD_SUB_APP" value="<%=strCOD_SUB_APP%>">
<table width="100%" border="0">
<tr>
<td valign="top">
    <table  width="100%">
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr> 
                        <td class="title" width="100%">
                            <%=ApplicationConfigurator.LanguageManager.getString("Analisi.dei.rischi")%>
                        </td> 
                        <td>   
                            <%
                                ToolBar.bShowDelete = true;
                                ToolBar.bCanDelete = (bean != null);
                                ToolBar.bShowPrint = false;
                                ToolBar.bShowReturn = false;
                                ToolBar.bShowSearch = false;
                            %>	
                            <%=ToolBar.build(2)%> 
                        </td>
                    </tr>
                </table>
                    
                <fieldset>
                <legend>
                    <%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>
                </legend>
                <table  width="100%" border="0">
                <br>
                <tr>
                    <td width="35%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fase.di.lavoro")%>&nbsp;</td>
                    <td width="62%" align="left">
                            <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="1" maxlength="3500" name="FAS_LAV"><%=strFAS_LAV%></s2s:textarea>
                    </td>
                    <td width="3%" align="left"><button tabindex="2" class="getlist" onclick="getFasiList()" id="btnGetFasi">
                                                    <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td width="35%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Modalità.operative")%>&nbsp;</td>
                    <td width="65%" colspan="2">
                                <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="3" maxlength="3500" name="MOD_OPE"><%=strMOD_OPE%></s2s:textarea>
                
                    </td>
                </tr>
                <tr>
                    <td width="35%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Materiali/Prodotti.impiegati")%>&nbsp;</td>
                    <td width="65%" align="left">
                        <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="4" maxlength="3500" name="MAT_PRO_IMP"><%=strMAT_PRO_IMP%></s2s:textarea>

                    </td>
                </tr>
                <tr>
                    <td width="35%" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</b></td>
                    <td width="62%" align="left">
                          <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="5" maxlength="4000" name="RIS"><%=strRIS%></s2s:textarea>

                    </td>
                    <td width="3%" align="left"><button tabindex="6" class="getlist" onclick="getRischiList()" id="btnGetRischi">
                                        <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td width="35%" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Misure.di.prevenzione.e.protezione.adottate")%>&nbsp;</td>
                    <td width="62%" align="left">
                                 <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="7" maxlength="4000" name="MIS_PRE_PRO"><%=strMIS_PRE_PRO%></s2s:textarea>

                    </td>
                    <td width="3%" align="left"><button tabindex="8" class="getlist" onclick="getMisureList()" id="btnGetMisure">
                                        <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                </table>	 
                </fieldset>
            </td>
        </tr>
        </table>
        </td>
    </tr>  
</table>
</form>
<iframe name="ifrmWork" class="ifrmWork" src="../empty.txt"></iframe>
</body>
</html>
