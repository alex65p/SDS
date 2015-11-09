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
    <version number="1.0" date="05/02/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="05/02/2004" author="Artur Denysenko">
				   <description>Realizazija EJB dlia objecta AnagrDocumento
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrDocumento.*" %>
<%@ page import="s2s.luna.conf.ModuleManager.MODULES" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%@ page import="org.apache.commons.fileupload.*"%>

<%!
	String ReqMODE;	// parameter of request 
%>
<script  type="text/javascript" src="../_scripts/Alert.js"></script>
<script type="text/javascript">
var err=false;
var isNew=false;
var bRefresh=false;
</script>

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
		System.err.println("Eccezione:" + ex.getMessage());
		ex.printStackTrace(System.err);
		out.print("<script>err=true;alert(divErr.innerText);</script>");
	}
%>


<%
//-----start check section--------------------------------
Checker c = new Checker();

long lCOD_DOC=c.checkLong("COD_DOC", (String)hs.get("ID"),true);
long lCOD_TPL_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia"),(String)hs.get("COD_TPL_DOC"),true);
long lCOD_CAG_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Categoria"),(String)hs.get("COD_CAG_DOC"),true);
String strNUM_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("N.Documento"),(String)hs.get("NUM_DOC"),true);
long lEDI_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Edizione"),(String)hs.get("EDI_DOC"),true);
String strTIT_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),(String)hs.get("TIT_DOC"),true);
String strRSP_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString(ApplicationConfigurator.isModuleEnabled(MODULES.MOD_FORM_GSE)?"Redattore":"Responsabile"),(String)hs.get("RSP_DOC"),true);
String strAPV_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile.approvazione.no.br"),(String)hs.get("APV_DOC"),true);
String strEMS_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Responsabile.emissione.no.br"),(String)hs.get("EMS_DOC"),true);
java.sql.Date dtDAT_REV_DOC=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data"),(String)hs.get("DAT_REV_DOC"),true);
long lMES_REV_DOC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Mese"),(String)hs.get("MES_REV_DOC"),true);
String strREV_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Revisione"),(String)hs.get("REV_DOC"),true);

java.sql.Date dtDAT_FUT_REV_DOC=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.futura"),(String)hs.get("DAT_FUT_REV_DOC"),false);
String strDES_REV_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),(String)hs.get("DES_REV_DOC"),false);
String strPRG_RIF_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Paragrafo.di.riferimento"),(String)hs.get("PRG_RIF_DOC"),false);
String strPGN_RIF_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Pag.rif"),(String)hs.get("PGN_RIF_DOC"),false);
long lCOD_LUO_FSC=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Luogo.fisico"),(String)hs.get("COD_LUO_FSC"),false);
String strNOT_LUO_CON=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),(String)hs.get("NOT_LUO_CON"),false);
long lPER_CON_YEA=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Periodicità.annuale"),(String)hs.get("PER_CON_YEA"),false);
long lCOD_AZL=Security.getAzienda();//c.checkLong("COD_AZL",(String)hs.get("COD_AZL"),false);

boolean isGlobal=(1==c.checkLong(ApplicationConfigurator.LanguageManager.getString("Globale"),(String)hs.get("IS_GLOBAL"),false));

if (c.isError){
	%>
		<div id="divError"></div>
	<%
	out.print("<script>err=true;alert(\""+c.printErrors()+"\");</script>");
	return;
}

if(Security.isConsultant()){
	if(isGlobal) lCOD_AZL=0;
}


IAnagrDocumentoHome home=(IAnagrDocumentoHome)PseudoContext.lookup("AnagrDocumentoBean");
IAnagrDocumento bean=null;

//------end check section--------------------------------
if((String)hs.get("SBM_MODE")!=null)
{
	try{
		ReqMODE=(String)hs.get("SBM_MODE");
		if(ReqMODE.equals("edt"))
		{
			bean = home.findByPrimaryKey(new Long(lCOD_DOC));
			
	 		bean.setRSP_DOC(strRSP_DOC);
			bean.setAPV_DOC(strAPV_DOC);
			bean.setEMS_DOC(strEMS_DOC);
			bean.setNUM_DOC(strNUM_DOC);
			bean.setREV_DOC(strREV_DOC);
			bean.setMES_REV_DOC(lMES_REV_DOC);
			bean.setDES_REV_DOC(strDES_REV_DOC);
			
			bean.setEDI_DOC__TIT_DOC(lEDI_DOC, strTIT_DOC);
			
			bean.setCOD_CAG_DOC(lCOD_CAG_DOC);
			bean.setCOD_TPL_DOC(lCOD_TPL_DOC);	
		}
		else{
			bean=home.create( strRSP_DOC, strAPV_DOC, 
				strEMS_DOC, strNUM_DOC, lEDI_DOC, 
				strREV_DOC, dtDAT_REV_DOC, lMES_REV_DOC, 
				strTIT_DOC, lCOD_CAG_DOC, lCOD_TPL_DOC);
				lCOD_DOC=bean.getCOD_DOC();
				%>
                                    <script type="text/javascript">
                                        isNew=true;
                                    </script>
				<%
		}
		if(bean!=null){		
			bean.setDES_REV_DOC(strDES_REV_DOC);
	 		bean.setDAT_REV_DOC(dtDAT_REV_DOC);
			bean.setDAT_FUT_REV_DOC(dtDAT_FUT_REV_DOC);
			bean.setPRG_RIF_DOC(strPRG_RIF_DOC);
			bean.setPGN_RIF_DOC(strPGN_RIF_DOC);
			bean.setCOD_LUO_FSC(lCOD_LUO_FSC);
			bean.setNOT_LUO_CON(strNOT_LUO_CON);
			bean.setPER_CON_YEA(lPER_CON_YEA);
			bean.setCOD_AZL(lCOD_AZL);
		}
		// --------------- UPLOAD -------------------------
		
		if(hs.get("ATTACHMENT_ACTION")==null){
			FileItem item=(FileItem)hs.get("ATTACHMENT_FILE");
                        if(item != null && item.getName()!=null && !item.getName().equals("")){
				bean.deleteFile();
				
				String str=item.getName();
				str=str.substring(str.lastIndexOf('/') + 1, str.length());
				str=str.substring(str.lastIndexOf('\\') + 1, str.length());
				
				bean.uploadFile(str, item.getContentType(), item.get());	

				%><script type="text/javascript">bRefresh=true;</script><%
			}
		}
		else if("delete".equals(hs.get("ATTACHMENT_ACTION"))){
			bean.deleteFile();
			%><script type="text/javascript">bRefresh=true;</script><%
		}//--------------- UPLOAD -------------------------

// Inizio modifica gestione link esterno documenti
                if(hs.get("ATTACHMENT_ACTION_LINK") == null) {
                    FileItem item=(FileItem)hs.get("ATTACHMENT_FILE_LINK");
                    if(item != null && item.getName()!=null && !item.getName().equals("")){
                        bean.deleteFileLink();
                        String str=item.getName();
                        bean.uploadFileLink(str, item.getContentType(), item.get());
                        out.println("<script>bRefresh=true;</script>");
                    }
                }
                else if("delete".equals(hs.get("ATTACHMENT_ACTION_LINK"))){
			bean.deleteFileLink();
                        out.println("<script>bRefresh=true;</script>");
		}
                
// Fine modifica gestione link esterno documenti
	}
	catch(Exception ex){
		%>
			<div id="divErr">
				<%=ex/*.getMessage()*/%>
			</div>
			<script type="text/javascript">err=true;</script>
		<%
		System.err.println("Eccezione:" + ex.getMessage());
		ex.printStackTrace(System.err);
	}
}

%>
<script type="text/javascript">
if (!err){
  //< %@ include file="ANA_DOC_Obj.jsp" %> 
  if(isNew){
   Alert.Success.showCreated()
   parent.ToolBar.OnNew("ID=<%=lCOD_DOC%>");
  }
  else{
  	Alert.Success.showSaved();
	if (bRefresh) parent.ToolBar.OnNew("ID=<%=lCOD_DOC%>");
  }
}
else{
	Alert.Error.showDublicate();
}
</script>
