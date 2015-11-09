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
        <version number="1.0" date="16/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="16/05/2008" author="Dario Massaroni">
                    <description>Create CON_SER_RIS_INT_Form.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServRischiInterferenza/ContServRischiInterferenzaBean.jsp"%>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/S2STagLib.tld" prefix="s2s"%>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Rischi.interferenza")%></title>
<script language="JavaScript" src="../_scripts/textarea.js"></script>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
</head>
<script type="text/javascript">
    window.dialogWidth="530px";
    window.dialogHeight="660px";
</script>
<body>
<%
    String strCOD_SRV = request.getParameter("ID_PARENT");
    String strCOD_RIS_INT = request.getParameter("ID");
    String strPRO_CON = "";
    String strDES_CON = "";
    String strFAS_LAV="";
    String strTIP_INT="";
    String strIMP_INT="";
    String strRIS="";
    String strMIS_PRE="";
    
    IContServRischiInterferenzaHome home = (IContServRischiInterferenzaHome) PseudoContext.lookup("ContServRischiInterferenzaBean"); 
    IContServRischiInterferenza bean = null;
    
    IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
    IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));
    
    strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
    strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
    
    if (strCOD_RIS_INT != null)
    {
        bean = home.findByPrimaryKey(new ContServRischiInterferenzaPK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_RIS_INT)));

        // getting of object variables
        strFAS_LAV = Formatter.format(bean.getFAS_LAV());
        strTIP_INT = Formatter.format(bean.getTIP_INT());
        strIMP_INT = Formatter.format(bean.getIMP_INT());
        strRIS = Formatter.format(bean.getRIS());
        strMIS_PRE = Formatter.format(bean.getMIS_PRE());
    } else {
        strCOD_RIS_INT = "";
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
    function getDitteEsterne(){
        var obj = new Object();
        var url="Form_ANA_DTE/ANA_DTE_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30;dialogWidth:35;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].IMP_INT.value = obj.CELLS[1];
        }
    }
    function getMisureList(){
        var obj = new Object();
        var url="Form_ANA_MIS_PET/ANA_MIS_PET_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30;dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].MIS_PRE.value = obj.CELLS[2];
        }
    }
</script>

<form action="CON_SER_RIS_INT_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_RIS_INT == null || strCOD_RIS_INT.equals("")) ? "new" : "edt"%>">
<input type="hidden" name="COD_RIS_INT" value="<%=strCOD_RIS_INT%>">
<input type="hidden" name="COD_SRV" value="<%=strCOD_SRV%>">
<table width="100%" border="0">
<tr>
<td valign="top">
    <table  width="100%">
        <tr>
            <td>
                <table width="100%" border="0">
                    <tr> 
                        <td class="title" style="width:100%;">
                            <%=ApplicationConfigurator.LanguageManager.getString("Rischi.interferenza")%>
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
                    <%=ApplicationConfigurator.LanguageManager.getString("Servizio.commissionato")%>
                </legend>
                <table  width="100%" border="0" cellspacing="5">
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%>&nbsp;</b></td>
                    <td style="width:70%;" align="left"><input type="text" name="PRO_CON" readonly value="<%=strPRO_CON%>" />

                    </td>
                </tr>
                    
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%>&nbsp;</b></td>
                    <td style="width:70%;" align="left"><textarea size="60" cols="38" rows="2" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                </tr> 
                </table>
                </fieldset>
                
                <br>
                    
                <fieldset>
                <legend>
                    <%=ApplicationConfigurator.LanguageManager.getString("Rischio.interferenza")%>
                </legend>
                <table  width="100%" border="0" cellspacing="5">
                <tr><td><br /></td></tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Fase.di.lavoro")%>&nbsp;</td>
                    <td style="width:65%;" align="left">
                            <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="1" maxlength="3500" name="FAS_LAV"><%=strFAS_LAV%></s2s:textarea>

                    </td>
                    <td style="width:5%;" align="left"><button tabindex="2" class="getlist" onclick="getFasiList()" id="btnGetFasi">
                                                    <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Tipo.di.interferenza")%>&nbsp;</td>
                    <td style="width:70%;" colspan="2">
                            <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="3" maxlength="3500" name="TIP_INT"><%=strTIP_INT%></s2s:textarea>

                    </td>
                </tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Impresa.interessata")%>&nbsp;</td>
                    <td style="width:65%;" align="left">
                                 <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="4" maxlength="3500" name="IMP_INT"><%=strIMP_INT%></s2s:textarea>

                    </td>
                    <td style="width:5%;" align="left"><button tabindex="5" class="getlist" onclick="getDitteEsterne()" id="btnGetDitteEsterne">
                                        <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Rischio")%>&nbsp;</b></td>
                    <td style="width:65%;" align="left">
                           <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="5" maxlength="4000" name="RIS"><%=strRIS%></s2s:textarea>

                    </td>
                    <td style="width:5%;" align="left"><button tabindex="6" class="getlist" onclick="getRischiList()" id="btnGetRischi">
                                        <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione")%>&nbsp;</td>
                    <td style="width:65%;" align="left">
                           <s2s:textarea style="width:326px;" cols="1" rows="4" tabindex="7" maxlength="4000" name="MIS_PRE"><%=strMIS_PRE%></s2s:textarea>

                    </td>
                    <td style="width:5%;" align="left"><button tabindex="8" class="getlist" onclick="getMisureList()" id="btnGetMisure">
                                        <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr><td><br /></td></tr>
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
