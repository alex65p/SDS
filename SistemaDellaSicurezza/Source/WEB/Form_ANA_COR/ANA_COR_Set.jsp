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
    <version number="1.0" date="28/01/2004" author="Mike Kondratyuk">		
      <comments>
			   <comment date="28/01/2004" author="Mike Kondratyuk">
				   <description>Realizazija EJB dlia objecta Corsi </description>
			   </comment>		
			   <comment date="29/01/2004" author="Juliya Khomenko">
				   <description>Realizazija Tabi Corsi </description>
			   </comment>		
				   <comment date="26/02/2004" author="Podmasteriev Alexander">
				   <description>Izmenen set fail s uchetom dinamicheskih tabov</description>
				 </comment>				 
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Corsi.*" %>
<%@ page import="com.apconsulting.luna.ejb.PercorsiFormativi.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
var err=false;
var isNew=false;  
</script>

<script language="JavaScript" src="../_scripts/Alert.js"></script>

<%!
	String ReqMODE;	// parameter of request 
%>
	
<%
ICorsi Corsi=null;

	Long lCOD_PCS_FRM = null;
	long ID_PARENT=0;
	long COD_COR=0;
	String strCOD_PCS_FRM = request.getParameter("ID_PARENT");
	//out.print("<script>alert(\"bvbc-"+request.getParameter("ID_PARENT")+"\");</script>");
	if (strCOD_PCS_FRM!=null && !strCOD_PCS_FRM.equals("") && !strCOD_PCS_FRM.equals("null")){
		lCOD_PCS_FRM = new Long (request.getParameter("ID_PARENT"));
		//out.print("<script>alert("+lCOD_PCS_FRM+");</script>");
	}

//-----start check section--------------------------------
Checker c = new Checker();
String strDES_COR="";
long lCOD_COR=c.checkLong("COD_COR",request.getParameter("COD_COR"),true);
long lDUR_COR_GOR=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Durata.corso.(h)"),request.getParameter("DUR_COR_GOR"),true);
String strNOM_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome.corso"),request.getParameter("NOM_COR"),true);
strDES_COR=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione.corso"),request.getParameter("DES_COR"),false);
String strUSO_ATE_FRE_COR;
if(request.getParameter("USO_ATE_FRE_COR") == null){
	strUSO_ATE_FRE_COR = "N";
}
else{
	strUSO_ATE_FRE_COR = request.getParameter("USO_ATE_FRE_COR");
}
String strUSO_PTG_COR;
if(request.getParameter("USO_PTG_COR") == null){
	strUSO_PTG_COR = "N";
}
else{
	strUSO_PTG_COR = request.getParameter("USO_PTG_COR");
}
long lCOD_TPL_COR=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Tipologia.corso"),request.getParameter("COD_TPL_COR"),true);
//ID_PARENT=c.checkLong("",request.getParameter("ID_PARENT"),false);
if (c.isError){
	String err = c.printErrors();
	out.print("<script>alert(\""+err+"\");</script>");
	return;
}
try{
ICorsiHome home=(ICorsiHome)PseudoContext.lookup("CorsiBean");
//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		Corsi = home.findByPrimaryKey(new Long(lCOD_COR));
 		Corsi.setDUR_COR_GOR(lDUR_COR_GOR);
   	try{
			Corsi.setNOM_COR(strNOM_COR);
   	}catch(Exception ex){
   		out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    		return;
    	}	
		Corsi.setCOD_TPL_COR(lCOD_TPL_COR);	
	}
	else{
   	try{
		%><script>isNew=true;</script><%		
			Corsi=home.create(lDUR_COR_GOR, strNOM_COR, lCOD_TPL_COR);
   	 }
		 catch(Exception ex){
   		out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    		return;
    	}	
			
    	///////////////////////////////////////
    	// adding link on anagrafica PercorsiFormativi //
    	///////////////////////////////////////
    	/*if (lCOD_PCS_FRM!=null){
      	COD_COR = Corsi.getCOD_COR();
      	IPercorsiFormativi PercorsiFormativi=null;
      	IPercorsiFormativiHome dhome=(IPercorsiFormativiHome)PseudoContext.lookup("PercorsiFormativiBean");
      	PercorsiFormativi = dhome.findByPrimaryKey(lCOD_PCS_FRM);
     		try{
    			PercorsiFormativi.addCOD_COR(Corsi.getCOD_COR());
    		}catch(Exception ex){
    			out.println("<script>Alert.Error.showDublicate();err=true;</script>");
    			return;
    		}	
    	}*/
	}
	 if(Corsi!=null){
 		 Corsi.setDES_COR(strDES_COR);
		 Corsi.setUSO_ATE_FRE_COR(strUSO_ATE_FRE_COR);
		 Corsi.setUSO_PTG_COR(strUSO_PTG_COR);
	 }
}

}catch(Exception ex){
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>err=true;</script>
<%
}
%>

<script>
/*
Dlya tabi
*/
/*if(parent.dialogArguments)
{
	if(!err)
	{
		da = parent.dialogArguments;
		da.ID = "<%=Corsi.getCOD_COR()%>";
		da.nome = "<%=Corsi.getNOM_COR()%>";
		da.des = "<%=Corsi.getDES_COR()%>";		
		da.codPCS = "<%=ID_PARENT%>";
		
		parent.window.returnValue="OK";
		if(isNew) {
		  alert(arraylng["MSG_0037"]); 
		  parent.ToolBar.OnNew("ID=<%=Corsi.getCOD_COR()%>");
		} else {
		  alert(arraylng["MSG_0038"]);
      parent.ToolBar.Exit.setEnabled(false);
      parent.ToolBar.Return.setEnabled(true);			 
		}

	}
	else
	{
		parent.window.returnValue="ERROR";
	}
	parent.close();
}
else
{
	if (!err)
	{
		alert(arraylng["MSG_0039"]);
	}
}
*/
 if (!err){  
 						 if(isNew) {Alert.Success.showCreated();
						 					 parent.ToolBar.OnNew("ID=<%=Corsi.getCOD_COR()%>");
						 }
						 else
						 {Alert.Success.showSaved(); }
					}
					else
					{
					alert(divErr.innerText);
					}
</script>
