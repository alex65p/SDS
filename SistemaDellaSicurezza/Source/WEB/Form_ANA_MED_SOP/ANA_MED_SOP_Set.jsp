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
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); 		//HTTP 1.0
    response.setDateHeader("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="s2s.utils.text.StringManager" %>
<%@ page import="com.apconsulting.luna.ejb.Media.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;	// parameter of request 
%>	
<script  type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err=false;
var isNew=false;
var bRefresh=false;
</script>
<%
    Long lCOD_MED_SOP = null;
    String sNOM_MED = null;
    String sDES_MED = null;
    String sFILE = "";
    String sMIME = null;
    String strCOD_SOP = null;
    Long lCOD_SOP = null;
    byte[] mediadata = null;
    java.sql.Date dDATA = new java.sql.Date(System.currentTimeMillis());
    Time tOra = new java.sql.Time(System.currentTimeMillis());
    Long lLen = 0L;

// TORNO I VALORI DEI CAMPI PRESENTI NELLA REQUEST, COMPRESO, SE PRESENTE, 
// IL FILE DA UPLOADARE - INIZIO
    Long MAX_LEN_FILE = new Long(10000000L);
    Hashtable ht = new Hashtable();

    try {
	// Create a new file upload handler
	DiskFileUpload upload = new DiskFileUpload();

	boolean bol = upload.isMultipartContent(request);
	if (bol == true) {
	    upload.setSizeMax(MAX_LEN_FILE);
	    upload.setSizeThreshold(1096);

	    List fileItems = upload.parseRequest(request);
	    Iterator i = fileItems.iterator();

	    InputStream in = null;
	    int size = 0;
	    while (i.hasNext()) {
		FileItem fi = (FileItem) i.next();
		if (fi.isFormField()) {
		    ht.put(fi.getFieldName(), fi.getString());
		} else {
		    in = fi.getInputStream();
		    size = (int) fi.getSize();
		    if (in != null && size > 0) {
			ht.put("filetype", fi.getContentType());
			ht.put("filename", fi.getName());
			ht.put(fi.getFieldName(), fi);
		    }
		}
	    }
	}
    } catch (Exception ex) {
	System.err.println(ex.getMessage());
	ex.printStackTrace(System.err);
	out.print("<script>alert(divErr.innerText);</script>");
        return;
    }
// TORNO I VALORI DEI CAMPI PRESENTI NELLA REQUEST, COMPRESO, SE PRESENTE, 
// IL FILE DA UPLOADARE - FINE

// CONTROLLO LA PRESENZA E LA VALIDITA' DEI CAMPI, OBBLIGATORI E OPZIONALI - INIZIO.
    Checker c = new Checker();

    strCOD_SOP = c.checkString(ApplicationConfigurator.LanguageManager.getString("Sopralluogo"), (String)ht.get("ID_PARENT"), true);
    sFILE = c.checkString(
            ApplicationConfigurator.LanguageManager.getString("File"), 
            (String)ht.get("filename")!=null?(String)ht.get("filename"):"", 
            StringManager.isEmptyOrZero((String)ht.get("COD_MED_SOP"))?true:false);
    sMIME = c.checkString("filetype", (String)ht.get("filetype"), false);
    sNOM_MED = c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"), (String)ht.get("NOM_MED_SOP"), false);
    sDES_MED = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), (String)ht.get("DES_MED_SOP"), false);
    
    if (c.isError) {
        String err = c.printErrors();
        out.println("<script>alert(\"" + err + "\");</script>");
        return;
    }
// CONTROLLO LA PRESENZA E LA VALIDITA' DEI CAMPI, OBBLIGATORI E OPZIONALI - FINE.
    
// VERIFICO CHE LA DIMENSIONE DEL FILE SIA ENTRO IL LIMITE CONSENTITO - INIZIO
    if (ht.get("ATTACHMENT_ACTION") == null) {
	FileItem item = (FileItem) ht.get("ATTACHMENT_FILE");
	if (item != null && item.getName() != null && !item.getName().equals("")) {
            
            mediadata = item.get();
	    lLen = new Long(mediadata.length);
            
            if (lLen >= MAX_LEN_FILE){
		out.print("<script>alert(arraylng[\"MSG_0213\"]);</script>");
		return;
	    }
	}
    }
// VERIFICO CHE LA DIMENSIONE DEL FILE SIA ENTRO IL LIMITE CONSENTITO - FINE
    
// VERIFICO CHE IL FILE CHE SI STA' CERCANDO DI UPLOADARE SIA DEL TIPO SUPPORTATO - INIZIO
    if (StringManager.isNotEmpty(sFILE) && StringManager.isNotEmpty(sMIME)) {
	if (!(sMIME.equalsIgnoreCase("image/bmp") ||
            sMIME.equalsIgnoreCase("image/gif") ||
            sMIME.equalsIgnoreCase("image/jpeg") ||
            sMIME.equalsIgnoreCase("image/pjpeg") ||
            sMIME.equalsIgnoreCase("image/png") ||
            sMIME.equalsIgnoreCase("image/x-png") ||
            sMIME.equalsIgnoreCase("image/tiff") ||
            sMIME.equalsIgnoreCase("image/tif") ||
            sMIME.equalsIgnoreCase("image/x-wmf"))){
	    out.print("<script>alert(arraylng[\"MSG_0214\"]);</script>");
	    return;
	}
    }
// VERIFICO CHE IL FILE CHE SI STA' CERCANDO DI UPLOADARE SIA DEL TIPO SUPPORTATO - INIZIO
   
    lCOD_MED_SOP = new Long((String) ht.get("COD_MED_SOP"));
    lCOD_SOP = new Long(strCOD_SOP);
    dDATA = new java.sql.Date(System.currentTimeMillis());
    tOra = new java.sql.Time(System.currentTimeMillis());

    IMediaHome home = (IMediaHome) PseudoContext.lookup("MediaBean");
    IMedia bean = null;

    if ((String) ht.get("SBM_MODE") != null) {
	try {
	    ReqMODE = (String) ht.get("SBM_MODE");
	    sFILE = StringManager.isNotEmpty(sFILE)
                    ?sFILE.substring(sFILE.lastIndexOf(File.separatorChar)+1)
                    :sFILE;
            if (ReqMODE.equals("edt")) {
		bean = home.findByPrimaryKey(new Long(lCOD_MED_SOP));
		bean.setCOD_SOP(lCOD_SOP);
		bean.setNOM_MED(sNOM_MED);
		bean.setDES_MED(sDES_MED);
		if (StringManager.isNotEmpty(sFILE)) {
		    bean.setFILE(sFILE);
		    bean.setMIME(sMIME);
		    bean.setLEN(lLen);
                    bean.setMediadata(mediadata);
		}
		bean.ejbStore();
	    } else {
		bean = home.create(sNOM_MED, sDES_MED, sFILE, 1, lCOD_SOP, null, mediadata, dDATA, tOra, sMIME, lLen);
		lCOD_MED_SOP=bean.getCOD_MED();
                %><script>isNew=true;</script><%
                 }
	} catch (Exception ex) {
	    System.err.println(ex.getMessage());
	    ex.printStackTrace(System.err);
	}
    }
    //--------------- UPLOAD -------------------------
%>
<script>
    if(!err){
        if(isNew){
            Alert.Success.showCreated();
        }else{
            Alert.Success.showSaved();
        }
        parent.ToolBar.OnNew("ID=<%=lCOD_MED_SOP%>");
    }else{
        Alert.Error.showErrSaved();
    }
</script>
