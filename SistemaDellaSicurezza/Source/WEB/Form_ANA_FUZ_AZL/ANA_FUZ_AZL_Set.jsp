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
    <version number="1.0" date="20/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="20/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi ANA_ALA_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.FunzioniAziendali.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>
 var err = false;
 var isNew = false;
</script>
<%	String ReqMODE="";	// parameter of request%>

<%
IFunzioniAziendali funzioniAziendali=null;
long THIS_ID=0;
if(request.getParameter("SBM_MODE")!=null){
	ReqMODE=request.getParameter("SBM_MODE");
	Checker c = new Checker();
	//- checking for required fields
	String strNOM_FUZ_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_FUZ_AZL"),true);   
  
	//- checking for not required fields		
	String strDES_FUZ_AZL=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_FUZ_AZL"),false);
	  if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

//=======================================================================================
  if(ReqMODE.equals("edt"))
	{
		// editing of funzioniAziendali--------------------
		// gettinf of object 
		Long lCOD_FUZ_AZL=new Long(c.checkLong("Funzioni Aziendali ID",request.getParameter("COD_FUZ_AZL"),true));
  	if (c.isError){
			String err = c.printErrors();
			out.println("<script>alert(\""+err+"\");err=true;</script>");
			return;
		}

		IFunzioniAziendaliHome home=(IFunzioniAziendaliHome)PseudoContext.lookup("FunzioniAziendaliBean");
		funzioniAziendali = home.findByPrimaryKey(lCOD_FUZ_AZL);
		//getting of parameters and set the new object variables
		try{
            funzioniAziendali.setNOM_FUZ_AZL(strNOM_FUZ_AZL);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
		}
		THIS_ID=funzioniAziendali.getCOD_FUZ_AZL();
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new funzioniAziendali--------------------------
	// creating of object 
		IFunzioniAziendaliHome home=(IFunzioniAziendaliHome)PseudoContext.lookup("FunzioniAziendaliBean");
		try{
            funzioniAziendali=home.create(strNOM_FUZ_AZL);
            THIS_ID=funzioniAziendali.getCOD_FUZ_AZL();
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		
		%>
		<script>isNew=true;</script>
		<%
	}
//=======================================================================================
  if (funzioniAziendali!=null){
	//   *Not require Fields*
		try{
            funzioniAziendali.setDES_FUZ_AZL(strDES_FUZ_AZL);
        }catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	}
}
%>	
<script>
if (!err){
  if(isNew){
			Alert.Success.showCreated();
		}else{
			Alert.Success.showSaved();}
  if(isNew) parent.ToolBar.OnNew("ID=<%=THIS_ID%>"); 
}
</script>
