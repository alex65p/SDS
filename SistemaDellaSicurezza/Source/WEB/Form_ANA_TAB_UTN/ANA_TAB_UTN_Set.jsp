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
< file>
  < versions>	
    < version number="1.0" date="09/02/2004" author="Malyuk Sergey">		
      < comments>
			   < comment date="09/02/2004" author="Malyuk Sergey">
				   < description>Realizazija EJB dlia objecta GestioneTabellare
			   < /comment>
			   < comment date="10/02/2004" author="Juli khomenko">
				   < description>Dobavila View for Paragrafo
				 < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.GestioneTabellare.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script>
var err=false;
var isNew=false;
</script>

<%!
	String ReqMODE;	// parameter of request 
%>
	
<%
IGestioneTabellare bean=null;
//-----start check section--------------------------------
Checker c = new Checker();
String[] arr=new String[5];
 
long lCOD_TAB_UTN=c.checkLong("COD_TAB_UTN",request.getParameter("COD_TAB_UTN"),true);
String strTIT_TAB=c.checkString(ApplicationConfigurator.LanguageManager.getString("Titolo"),request.getParameter("TIT_TAB"),false);
long lNUM_CLN=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Numero.di.colonne"),request.getParameter("NUM_CLN"),true);
long lCOD_PRG=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Paragrafo"),request.getParameter("ID_PARENT"),true);
String strNOM_TIT_1=c.checkString("NOM_TIT_1",request.getParameter("NOM_TIT_1"),false);
String strNOM_TIT_2=c.checkString("NOM_TIT_2",request.getParameter("NOM_TIT_2"),false);
String strNOM_TIT_3=c.checkString("NOM_TIT_3",request.getParameter("NOM_TIT_3"),false);
String strNOM_TIT_4=c.checkString("NOM_TIT_4",request.getParameter("NOM_TIT_4"),false);
String strNOM_TIT_5=c.checkString("NOM_TIT_5",request.getParameter("NOM_TIT_5"),false);
String ID_PARENT="";
if (request.getParameter("ID_PARENT")!=null)
		 {
		 	ID_PARENT = request.getParameter("ID_PARENT");
		 }

if (c.isError)
	 {
	  String err = c.printErrors();
	  out.print("<script>alert(\""+err+"\");</script>");
	  return;
	 }

IGestioneTabellareHome home=(IGestioneTabellareHome)PseudoContext.lookup("GestioneTabellareBean");

//------end check section--------------------------------
if(request.getParameter("SBM_MODE")!=null)
{
	ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
		bean = home.findByPrimaryKey(new Long(lCOD_TAB_UTN));

 		bean.setNUM_CLN(lNUM_CLN);
		bean.setCOD_PRG(lCOD_PRG);	
	}
	else
	{
				%><script>isNew=true;</script><%
		bean=home.create(lNUM_CLN, lCOD_PRG);
	  

	}
	if(bean!=null){
 		bean.setTIT_TAB(strTIT_TAB);
	  bean.setNOM_TIT_1(strNOM_TIT_1);
		bean.setNOM_TIT_2(strNOM_TIT_2);
		bean.setNOM_TIT_3(strNOM_TIT_3);
		bean.setNOM_TIT_4(strNOM_TIT_4);
		bean.setNOM_TIT_5(strNOM_TIT_5);
		int i=1;
		int j=1;
		int k=0;
		long lCOD_REC=1;//System.currentTimeMillis();
		bean.delCLN(lCOD_TAB_UTN);
		while ((request.getParameter("NOM_CLN_"+i+"_"+j)!=null)&&(request.getParameter("NOM_CLN_"+i+"_"+j)!=""))
			 {
		 	 lCOD_REC= lCOD_REC+1;
			 for (i=0;i<=4;i++)
			 		 {
					 k=i+1;
					 if ((request.getParameter("NOM_CLN_"+k+"_"+j)!=null)&&(!(request.getParameter("NOM_CLN_"+k+"_"+j).equals(""))))
					 		{
							 		arr[i]=request.getParameter("NOM_CLN_"+k+"_"+j);
							}
							else
							{
							arr[i]="";
							}
							
					 }
  		 if (!arr[0].equals("")) 
			 		{
					bean.setCLN(arr,lCOD_REC);
			 		}
 			 i=1;
			 j++;
			 }
	}
}
%>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<script>

if(parent.dialogArguments)
{
	if(!err)
	{
		da = parent.dialogArguments;
		da.ID = "<%=bean.getCOD_TAB_UTN()%>";
		da.titolo = "<%=bean.getTIT_TAB()%>";
		da.codTit = "<%=ID_PARENT%>";
		
		parent.window.returnValue="OK";

		if(isNew) {
		  Alert.Success.showCreated();
		  parent.ToolBar.OnNew("ID=<%=bean.getCOD_TAB_UTN()%>");
		} else {
		  Alert.Success.showSaved();
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
 	//------------------------------------------------
 	if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();
			parent.ToolBar.OnNew("ID=<%=bean.getCOD_TAB_UTN()%>"); 
		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
}
</script> 
