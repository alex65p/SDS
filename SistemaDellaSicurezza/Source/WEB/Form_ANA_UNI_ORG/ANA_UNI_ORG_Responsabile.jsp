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
    <version number="1.0" date="19/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="19/02/2004" author="AlexKyba">
				   <description>function, stroyaschaya strukturu unita organizzativa</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>


<%

//-------------------------------------------------
String strRAG_SCL_AZL = new String();

//------------------
long lCOD_DPD=0;
String strCOD_DPD="";
String strNOM_DPD="";
String strMTR_DPD="";
String strCOG_DPD="";
//---------------------------

//------------------------------------------------------------------
//----------------Interfaces & Beans--------------------------------
//------------------------------------------------------------------

//------ Dipendente ---
IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
IDipendente bean=null;
String RespID = request.getParameter("RESP_ID");

if(RespID!=null && !RespID.trim().equals("") && !RespID.equals("0"))
{
    // getting parameters of azienda
    try{
            Long RESP_ID = new Long(RespID);
            bean=home.findByPrimaryKey(RESP_ID);
            lCOD_DPD=bean.getCOD_DPD();
            strCOD_DPD=(lCOD_DPD>0)?Long.toString(lCOD_DPD):"";
            strNOM_DPD=bean.getNOM_DPD();
            strMTR_DPD = bean.getMTR_DPD();
            strCOG_DPD = bean.getCOG_DPD();
            strNOM_DPD=bean.getNOM_DPD();
    }
    catch(Exception ex){
            out.print("<strong>"+ex.getMessage()+"</strong>");
            return;
    }
}
%>
<div id="resp_divContent">
<fieldset>
    <legend><%=ApplicationConfigurator.LanguageManager.getString("Responsabile")%></legend>
        <table width="100%" cellpadding="0" cellspacing="2" border="0">
            <tr>
                <td width="15%" align="right" valign="top"><strong><%=ApplicationConfigurator.LanguageManager.getString("Nome")%>&nbsp;</strong></td>
                <td width="55%" align="left" valign="top"> 
			<input type="hidden" size="20" maxlength="20"  name="COD_DPD" value="<%=Formatter.format(strCOD_DPD)%>">
			<input type="text" style="width:100%" maxlength="20" readonly  name="NOM_DPD" value="<%= Formatter.format(strNOM_DPD) %>">
		</td>
                <td width="12%" align="right" valign="top"><strong><%=ApplicationConfigurator.LanguageManager.getString("Matricola")%>&nbsp;</strong></td>
                <td width="18%" align="right" valign="top"> 
			<input type="text" style="width:100%" maxlength="20" readonly name="MTR_DPD" value="<%= Formatter.format(strMTR_DPD) %>">
		</td>
            </tr>
            <tr>
                <td align="right" valign="top" width="15%"><strong><%=ApplicationConfigurator.LanguageManager.getString("Cognome")%>&nbsp;</strong></td>
                <td  align="left" colspan="3" valign="top" nowrap width="85%"> 
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td width="64%" align="left">
                                <input  type="text" readonly style="width:100%" maxlength="20"  name="COG_DPD" value="<%= Formatter.format(strCOG_DPD) %>">
                            </td>
                            <td align="left" width="36%">
                                <button tabindex="6" class="getlist" onclick="getDipenedentiList()" id="btnGetDipendenti" <%if(RespID == null){out.print("disabled");}%>>
                                    <strong>&middot;&middot;&middot;</strong>
                                </button>
                            </td>	
                        </tr>
                    </table>
                   
		</td>
            </tr>
        </table>
    </fieldset>
</div>
<script>
    parent.RESP.innerHTML=document.all["resp_divContent"].innerHTML;
</script>
