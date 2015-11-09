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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
	      <comments>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.CartelleSanitarie.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
var err = false;
</script>

<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
 ICartelleSanitarie bean = null;
        ICartelleSanitarieHome home = (ICartelleSanitarieHome) PseudoContext.lookup("CartelleSanitarieBean");
        long lCOD_VST_IDO = 0;
        Long ID_PARENT = new Long(request.getParameter("ID_PARENT"));
        long lCOD_CTL_SAN = ID_PARENT.longValue();
        String dtDAT_PIF_VST = null;
        String dtDAT_EFT_VST = null;
        String IDO_VST = "";
        String strTPL_ACR_VLU_MED = "";
        String strTPL_ACR_VLU_RSO = "";
        String strTPL_ACR_EFT = "";
        String strNOT_VST_IDO = "";
        bean = home.findByPrimaryKey(ID_PARENT);
        long lCOD_AZL = bean.getCOD_AZL();
        long lCOD_DPD = bean.getCOD_DPD();
       

if(request.getParameter("ID")!=null)
{	
	String strID=request.getParameter("ID");
    lCOD_VST_IDO = new Long(strID).longValue();
    dtDAT_PIF_VST = request.getParameter("dat_pif_vst_ido");
	try{
            bean.removeCOD_VST_IDO(lCOD_VST_IDO,lCOD_DPD, lCOD_CTL_SAN,lCOD_AZL,java.sql.Date.valueOf(dtDAT_PIF_VST));
		}catch(Exception ex){
		out.print("<script>err=true;</script>");
  	}
	
	//
}	
%>

<script>
if (!err) {
			<%if (request.getParameter("LOCAL_MODE")!=null){%> 	
					 parent.del_localRow();
			<%}else{%>
			Alert.Success.showDeleted();
			parent.g_Handler.OnRefresh();
			<%}%>
		} else {
			Alert.Error.showDelete();
		} 
</script>
