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
        <version number="1.0" date="13/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="13/05/2008" author="Dario Massaroni">
                    <description>Create CON_SER_LUO_ESE_Form.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnaContServ.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.ContServLuoghiEsecuzione.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../_include/ToolBar.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<html>
<head>
<title><%=ApplicationConfigurator.LanguageManager.getString("Luoghi.esecuzione")%></title>
<LINK REL=STYLESHEET
      HREF="../_styles/style.css"
      TYPE="text/css">
</head>
<script type="text/javascript">
    window.dialogWidth="450px";
    window.dialogHeight="310px";
</script>
<body>
<%
    String strCOD_SRV = request.getParameter("ID_PARENT");
    String strCOD_LUO_FSC = request.getParameter("ID");
    String strPRO_CON = "";
    String strDES_CON = "";
    String strDES_SER="";
    String strNOM_LUO_FSC="";
    
    IContServLuoghiEsecuzioneHome home = (IContServLuoghiEsecuzioneHome) PseudoContext.lookup("ContServLuoghiEsecuzioneBean"); 
    IContServLuoghiEsecuzione bean = null;
    
    IAnaContServHome con_ser_home = (IAnaContServHome) PseudoContext.lookup("AnaContServBean");
    IAnaContServ con_ser_bean = con_ser_home.findByPrimaryKey(Long.parseLong(strCOD_SRV));
    
    strPRO_CON = Formatter.format(con_ser_bean.getPRO_CON());
    strDES_CON = Formatter.format(con_ser_bean.getDES_CON());
    
    if (strCOD_LUO_FSC != null)
    {
        bean = home.findByPrimaryKey(new ContServLuoghiEsecuzionePK(Long.parseLong(strCOD_SRV), Long.parseLong(strCOD_LUO_FSC)));

        // getting of object variables
        strDES_SER = Formatter.format(bean.getDES_SER());
        
        // estraggo la descrizione del luogo fisico
        IAnagrLuoghiFisiciHome homeLuogoFisico = (IAnagrLuoghiFisiciHome) PseudoContext.lookup("AnagrLuoghiFisiciBean"); 
        IAnagrLuoghiFisici beanLuogoFisico = null;
        
        beanLuogoFisico = homeLuogoFisico.findByPrimaryKey(Long.valueOf(strCOD_LUO_FSC));
        strNOM_LUO_FSC = beanLuogoFisico.getNOM_LUO_FSC();
    } else {
        strCOD_LUO_FSC = "";
    }
%>

<script type="text/javascript">
    function getLuoghiFisiciList(){
        var obj = new Object();
        var url="Form_ANA_LUO_FSC/ANA_LUO_FSC_View.jsp?noFindEx=1";
        if(showSearch(url, obj, "dialogHeight:30; dialogWidth:50;help:no;resizable:yes;status:yes;scroll:no;")=="OK"){
            document.forms[0].COD_LUO_FSC.value = obj.ID;
            document.forms[0].NOM_LUO_FSC.value = obj.CELLS[1];
        }
    }

</script>

<form action="CON_SER_LUO_ESE_Set.jsp"  method="POST" target="ifrmWork" style="margin:0 0 0 0;">
<input name="SBM_MODE" type="Hidden" value="<%=(strCOD_LUO_FSC == null || strCOD_LUO_FSC.equals("")) ? "new" : "edt"%>">
<input type="hidden" name="COD_LUO_FSC" value="<%=strCOD_LUO_FSC%>">
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
                            <%=ApplicationConfigurator.LanguageManager.getString("Luoghi.esecuzione")%>
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
                    <table  width="100%" border="0" cellpadding="0" cellspacing="10">
                    <tr>
                        <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Progressivo.contratto/servizio")%></b></td>
                        <td style="width:70%;" align="left"><input type="text" name="PRO_CON" readonly value="<%=strPRO_CON%>" /></td>
                    </tr>
                    
                    <tr>
                        <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Descrizione")%></b></td>
                        <td style="width:70%;" align="left"><textarea cols="38" rows="2" name="DES_CON" readonly><%=strDES_CON%></textarea></td>
                    </tr> 
                    </table>
                </fieldset>
                
                <br>
                
                <fieldset>
                <legend>
                    <%=ApplicationConfigurator.LanguageManager.getString("Luogo.esecuzione")%>
                </legend>
                <table width="100%" border="0" cellpadding="0" cellspacing="10">
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><b><%=ApplicationConfigurator.LanguageManager.getString("Luogo.fisico")%></b></td>
                    <td style="width:65%;" align="left"><input type="text" size="48" maxlength="50"  name="NOM_LUO_FSC" value="<%=strNOM_LUO_FSC%>" readonly /></td>
                    <td style="width:5%;" align="left"><button class="getlist" onclick="getLuoghiFisiciList()" id="btnGetLuoghiFisici" <%=strCOD_LUO_FSC != null && !strCOD_LUO_FSC.equals("")?"disabled":""%>>
                            <strong>&middot;&middot;&middot;</strong></button></td>
                </tr>
                <tr>
                    <td style="width:30%;" valign="middle" align="right"><%=ApplicationConfigurator.LanguageManager.getString("Servizio")%></td>
                    <td style="width:70%;" align="left" colspan="2"><input type="text" size="48" maxlength="50"  name="DES_SER" value="<%=strDES_SER%>" /></td>
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
