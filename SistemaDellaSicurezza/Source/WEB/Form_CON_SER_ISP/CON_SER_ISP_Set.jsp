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
    Document   : CON_SER_ISP_Set
    Created on : 19-mag-2008, 12.32.38
    Author     : Giancarlo Servadei
--%>
<%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache");        //HTTP 1.0
            response.setDateHeader("Expires", 0);          //prevents caching at the proxy server
%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean_Interfaces.jsp"%>
<%@ include file="../src/com/apconsulting/luna/ejb/ContServIspezioni/ContServIspezioniBean.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ page import="org.apache.commons.fileupload.*"%>

<%!
    String ReqMODE; // parameter of request 
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
    var isNew = false;
    var err=false;
    </script>
<%
    java.util.Hashtable hs = new java.util.Hashtable();
    try{
        // Create a new file upload handler
        DiskFileUpload  upload = new DiskFileUpload();
	
        // Set upload parameters
        upload.setSizeMax(999999999L);

        List items = upload.parseRequest(request);
	    
        Iterator iter = items.iterator();
        while (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();
            if (item.isFormField()){
                hs.put(item.getFieldName(), item.getString());
            }
            else{
                hs.put(item.getFieldName(), item);
            }
        }
    }
    catch(Exception ex){
%>
    <div id="divErr">
            <%=ex%>
    </div>
<%
        System.err.println("Eccezione:" + ex.getMessage());
        ex.printStackTrace(System.err);
        out.print("<script>err=true;alert(divErr.innerText);</script>");
    }
%>

<%
            IContServIspezioniHome home = (IContServIspezioniHome) PseudoContext.lookup("ContServIspezioniBean");
            IContServIspezioni bean = null;
            long lCOD_SRV = 0;
            long lCOD_ISP = 0;
            String strFILE_NAME = "";

            if ((String)hs.get("SBM_MODE") != null) {
                ReqMODE = (String)hs.get("SBM_MODE");

                Checker c = new Checker();

                FileItem f = (FileItem)hs.get("FILE_NAME");
                //- checking for required fields
                lCOD_SRV = c.checkLong(ApplicationConfigurator.LanguageManager.getString("ID.Servizio.commissionato"), (String)hs.get("COD_SRV"), true);
                lCOD_ISP = c.checkLong("", (String)hs.get("COD_ISP"), false);
                strFILE_NAME = c.checkString("Documento", f.getName(), true);
                
                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                if (ReqMODE.equals("edt")) {
                    bean = home.findByPrimaryKey(new ContServIspezioniPK(lCOD_SRV, lCOD_ISP));
                    try {
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                }

                if (ReqMODE.equals("new")) {
                    out.print("<script>isNew=true;</script>");
                    try {
                        bean = home.create(lCOD_SRV, strFILE_NAME, f.getContentType(), f.get());
                        lCOD_ISP = bean.getCOD_ISP();
                    } catch (Exception ex) {
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        ex.printStackTrace();
                        return;
                    }

                }
            }
%>
<script>
    if (!err){  
        if(isNew) {
            Alert.Success.showCreated();
            parent.ToolBar.OnNew("ID=<%=lCOD_ISP%>");
            }
            else{
                Alert.Success.showSaved(); 
            }
        }
        </script>
