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
    <version number="1.0" date="15/01/2004" author="Treskina Maria">
    <comments>
    <comment date="15/01/2004" author="Treskina Maria">
    <description>Shablon formi ANA_FOR_Delete.jsp</description>
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
<%@ page import="com.apconsulting.luna.ejb.Fornitore.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/FornitoreTelefono/FornitoreTelefonoBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script type="text/javascript">
    var err=false;
</script>

<%
    Checker c = new Checker();

    long ID;
    long lCOD_NUM_TEL_FOR = 0, lCOD_LOT_DPI = 0, lCOD_SOS_CHI = 0, lCOD_MAC = 0;


    String LOCAL_MODE = request.getParameter("LOCAL_MODE");
    if (LOCAL_MODE != null) {
        ID = c.checkLong("Fornitore", request.getParameter("ID_PARENT"), true);

        if (LOCAL_MODE.equals("t")) {
            lCOD_NUM_TEL_FOR = c.checkLong("Numero telefono", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("l")) {
            lCOD_LOT_DPI = c.checkLong("Lotti DPI", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("ac")) {
            lCOD_SOS_CHI = c.checkLong("Agento chimici", request.getParameter("ID"), true);
        }
        if (LOCAL_MODE.equals("m")) {
            lCOD_MAC = c.checkLong(
                    ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)
                        ?"Macchina.attrezzatura.impianto"
                        :"Macchina/Attrezzatura"
                    , request.getParameter("ID"), true);
        }
    } else {
        ID = c.checkLong("Tipologia DPI", request.getParameter("ID"), true);
    }

    if (c.isError) {
        out.println("<script>err=true;alert(\"" + c.printErrors() + "\");</script>");
        return;
    }

    IFornitore fornitore = null;
    IFornitoreHome home = (IFornitoreHome) PseudoContext.lookup("FornitoreBean");

    IFornitoreTelefono Tel = null;
    IFornitoreTelefonoHome homeTel = (IFornitoreTelefonoHome) PseudoContext.lookup("FornitoreTelefonoBean");

    ILottiDPI lottiDPI = null;
    ILottiDPIHome homeLottiDPI = (ILottiDPIHome) PseudoContext.lookup("LottiDPIBean");

    try {
        if (LOCAL_MODE != null) {
            fornitore = home.findByPrimaryKey(new Long(ID));

            if (lCOD_NUM_TEL_FOR != 0) {
                homeTel.remove(new Long(lCOD_NUM_TEL_FOR));
            } else if (lCOD_LOT_DPI != 0) {
                homeLottiDPI.remove(new Long(lCOD_LOT_DPI));
            } else if (lCOD_SOS_CHI != 0) {
                fornitore.removeCOD_SOS_CHI(lCOD_SOS_CHI);
            } else if (lCOD_MAC != 0) {
                fornitore.removeCOD_MAC(lCOD_MAC);
            } else {
                throw new Exception("Invalid operation");
            }
        } else {
            home.remove(new Long(ID));
        }
    } catch (Exception ex) {
 	manageException(request, out, ex);
%>
<script>err=true;</script>
<%    }

    /*
    if(request.getParameter("ID")!=null)
    {	
    //
    String ID_TO_DEL=request.getParameter("ID");
    
    Long azl_id=new Long(ID_TO_DEL);
    try{
    home.remove(azl_id);
    }catch(Exception ex){
    out.print("<script>alert(arraylng[\"MSG_0049\"]);err=true;</script>");
    return;
    }
    
    //
    }	*/
%>
<script>
    /*if (err) 
        alert(divErr.innerText);	
                else{		  
        alert(arraylng["MSG_0050"]);	  
        parent.ToolBar.OnDelete(); 
}*/
    if (err) 
        Alert.Error.showDelete();

    <%
        if (LOCAL_MODE == null) {
    %>
        //else parent.g_Handler.OnRefresh();
        else{
            Alert.Success.showDeleted();
            parent.g_Handler.OnRefresh();
            //parent.ToolBar.OnDelete();
        }
    <%} else {
    %>
	
        else{
            parent.del_localRow();
            Alert.Success.showDeleted();
        }	
	   
    <%    }
    %>

</script>
