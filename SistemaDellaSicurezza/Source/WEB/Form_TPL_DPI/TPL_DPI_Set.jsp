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
    <version number="1.0" date="27/01/2004" author="Treskina Maria">
	  <comments>
				 <comment date="27/01/2004" author="Treskina Maria">
				   <description>vnesenie dannih v ANA_TPL_DPI</description>
				 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script type="text/javascript">
var err=false;
var isNew=false;
var bRefresh=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%!
	String ReqMODE;	// parameter of request
%>

<%
	java.util.Hashtable hs = new java.util.Hashtable();

	try{
	    // Create a new file upload handler
	    DiskFileUpload  upload = new DiskFileUpload();

	    // Set upload parameters
	    upload.setSizeMax(999999999L);
	    //upload.setSizeThreshold(100000);
	    //upload.setRepositoryPath(null);

	    List items = upload.parseRequest(request);
		//if(true) return;


	    Iterator iter = items.iterator();
	    while (iter.hasNext()) {
	        FileItem item = (FileItem) iter.next();
			out.println(item.getFieldName()+"<br>");
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
				<%=ex/*.getMessage()*/%>
			</div>
		<%
		out.print("<script>err=true;alert(divErr.innerText);</script>");
	}
%>

<%
IAnagrDocumento anagrDoc=null;
IAnagrDocumentoHome homeanagrDoc=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");

ITipologiaDPI tipologiaDPI=null;
if((String)hs.get("SBM_MODE")!=null)
{
	ReqMODE=(String)hs.get("SBM_MODE");

//- checking for required fields
	Checker c = new Checker();
	String strNOM_TPL_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),(String)hs.get("NOME"),true);
	String strDES_CAR_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Caratteristica"),(String)hs.get("CARRATTERISTICA"),true);

	String strMDL_PTR_UTI_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Modalità.particolare.d'utilizzo"),(String)hs.get("MODALITA"),false);
	String strIMG_CSI_DPI=c.checkString(ApplicationConfigurator.LanguageManager.getString("Impiego.consigliato"),(String)hs.get("IMPIEGO"),false);
	long lCAG_DPI=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria"),(String)hs.get("CATEGORIA"),false);
	long lPER_MES_SST=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Sostituzione"),(String)hs.get("SOSTITUZIONE"),false);
	long lPER_MES_MNT=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Manutenzione"),(String)hs.get("MANUTENZIONE"),false);

	out.print(lCAG_DPI+"==="+lPER_MES_SST+"++++"+lPER_MES_MNT);

	if (c.isError)
		{
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of lotti DPI--------------------
		// gettinf of object
		ITipologiaDPIHome home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");

		Long tpl_dpi_id=new Long(c.checkLong("Tipologia DPI ID",(String)hs.get("TPL_DPI_ID"),true));

		if (c.isError)
		{
			String err = c.printErrors();
			out.print("for_id="+err);
			out.println("<script>alert(\""+err+"\");</script>");
			return;
		}
		tipologiaDPI = home.findByPrimaryKey(tpl_dpi_id);
		//getting of parameters and set the new object variables
		try{
				tipologiaDPI.setNOM_TPL_DPI(strNOM_TPL_DPI);
		}
		  catch(Exception ex){
			  out.println("<script>Alert.Error.showDublicate();err=true;</script>");
				return;
		}
		tipologiaDPI.setDES_CAR_DPI(strDES_CAR_DPI);
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new lotti DPI--------------------------
	// creating of object
	  ITipologiaDPIHome home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
		try{
		  tipologiaDPI=home.create(strNOM_TPL_DPI, strDES_CAR_DPI);
		}
		  catch(Exception ex){
			  out.println("<script>Alert.Error.showDublicate();err=true;</script>");
				return;
		}
		out.print("<script>isNew=true;</script>");
	}
//===================================================================================
  if (tipologiaDPI!=null){
	//   *Not require Fields*
		tipologiaDPI.setMDL_PTR_UTI_DPI(strMDL_PTR_UTI_DPI);
		tipologiaDPI.setIMG_CSI_DPI(strIMG_CSI_DPI);
		tipologiaDPI.setCAG_DPI(lCAG_DPI);
		tipologiaDPI.setPER_MES_SST(lPER_MES_SST);
		tipologiaDPI.setPER_MES_MNT(lPER_MES_MNT);
	}
		// --------------- UPLOAD -------------------------
		long lCOD_TPL_DPI = tipologiaDPI.getCOD_TPL_DPI();
		if(hs.get("ATTACHMENT_ACTION")==null){
			FileItem item=(FileItem)hs.get("ATTACHMENT_FILE");
			if(item != null && item.getName()!=null && !item.getName().equals("")){
				homeanagrDoc.deleteFileU("TPL_DPI_TAB",lCOD_TPL_DPI);

				String str=item.getName();
				str=str.substring(str.lastIndexOf('/') + 1, str.length());
				str=str.substring(str.lastIndexOf('\\') + 1, str.length());

				homeanagrDoc.uploadFileU("TPL_DPI_TAB",lCOD_TPL_DPI, str, item.getContentType(), item.get());
				%><script>bRefresh=true;</script><%
			}
		}
		else if ("delete".equals(hs.get("ATTACHMENT_ACTION"))){
			homeanagrDoc.deleteFileU("TPL_DPI_TAB",lCOD_TPL_DPI);
			%><script>bRefresh=true;</script><%
		}//--------------- UPLOAD -------------------------
                
// Inizio modifica gestione link esterno documenti
                if(hs.get("ATTACHMENT_ACTION_LINK")==null){
			FileItem item=(FileItem)hs.get("ATTACHMENT_FILE_LINK");
			if(item != null && item.getName()!=null && !item.getName().equals("")){
				homeanagrDoc.deleteFileULink("TPL_DPI_TAB",lCOD_TPL_DPI);

				String str=item.getName();
				//str=str.substring(str.lastIndexOf('/') + 1, str.length());
				//str=str.substring(str.lastIndexOf('\\') + 1, str.length());

				homeanagrDoc.uploadFileULink("TPL_DPI_TAB",lCOD_TPL_DPI, str, item.getContentType(), item.get());
				%><script>bRefresh=true;</script><%
			}
		}
		else if ("delete".equals(hs.get("ATTACHMENT_ACTION_LINK"))){
			homeanagrDoc.deleteFileULink("TPL_DPI_TAB",lCOD_TPL_DPI);
			%><script>bRefresh=true;</script><%
		}
                
                
// Fine modifica gestione link esterno documenti                

}
%>
<script>
if (!err){
	if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=tipologiaDPI.getCOD_TPL_DPI()%>");
		}else{
			Alert.Success.showSaved();
			if (bRefresh) parent.ToolBar.OnNew("ID=<%=tipologiaDPI.getCOD_TPL_DPI()%>");
		}
}
</script>
