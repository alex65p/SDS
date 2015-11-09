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
    <version number="1.0" date="23/01/2004" author="Alexey Kolesnik">
	      <comments>
					<comment date="23/01/2004" author="Alexey Kolesnik">
				   <description> Shablon formi ANA_DMD_Set.jsp </description>
				 	</comment>
				  <comment date="24/01/2004" author="Malyuk Sergey">
				   <description></description>
				 	</comment>
				  <comment date="31/01/2004" author="Alexey Kolesnik">
				   <description> Added new toolbar </description>
				 	</comment>
				 	<comment date="24/03/2004" author="Treskina Maria">
				   <description> Update rst_dmd_tab </description>
				 	</comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/Domande/DomandeBean.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/TestVerifica/TestVerificaBean.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script language="JavaScript" type="text/javascript">
<!--
		var err=false;
		var isNew = false;
//-->
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
IDomande Domande=null;
//
Long lCOD_TES_VRF = null;
String strCOD_TES_VRF=null;
if (request.getParameter("ID_PARENT")!=null)
{
	strCOD_TES_VRF = request.getParameter("ID_PARENT");
	if (strCOD_TES_VRF!=null && !strCOD_TES_VRF.equals("") && !strCOD_TES_VRF.equals("null"))
	 {
		 lCOD_TES_VRF = new Long (request.getParameter("ID_PARENT"));
	 }
}
//
long lNUM_PTG_DMD=0;
long lNUM_MIN_PTG=0;
long lNUM_MAX_PTG=0;
long lSUM_NUM_PTG=0;
long lCOD_DMD=0;
//
if(request.getParameter("SBM_MODE")!=null)
{
	Checker c = new Checker();
	String[] ar_strCOD_RST = request.getParameterValues("CHK_RIPOSTA");						//--- mary
	lCOD_DMD =c.checkLong("DMD ID",request.getParameter("COD_DMD"),true);					//0 
	String	 strNOM_DMD =c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_DMD"),true);		//1 Domande
	String	 strDES_DMD =c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_DMD"),false);//2 Nullable
	if (request.getParameter("NUM_PTG_DMD")!=null)
	{
	 	lNUM_PTG_DMD =c.checkLong(ApplicationConfigurator.LanguageManager.getString("Num.Punteggio.domanda"),request.getParameter("NUM_PTG_DMD"),false);
	}
	if (c.isError)
	{
		String err = c.printErrors();
		out.println("<script>alert(\""+err+"\");</script>");
		return;
	}
//------------------------------------------------------------------------------
	String 	 ReqMODE=request.getParameter("SBM_MODE");
	if(ReqMODE.equals("edt"))
	{
	// editing of Domande--------------------
		out.println("edt");
		// gettinf of object
		IDomandeHome home=(IDomandeHome)PseudoContext.lookup("DomandeBean");
		Domande = home.findByPrimaryKey( new Long(lCOD_DMD) );
		//set the object variables
		try{
			Domande.setNOM_DMD(strNOM_DMD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
		if (request.getParameter("NUM_PTG_DMD")!=null)
			 {
	 		 	ITestVerifica TestVerifica=null;
				ITestVerificaHome teshome=(ITestVerificaHome)PseudoContext.lookup("TestVerificaBean");
				TestVerifica = teshome.findByPrimaryKey(lCOD_TES_VRF);
				lNUM_MIN_PTG=TestVerifica.getNUM_MIN_PTG();
				
				if (lNUM_PTG_DMD>=lNUM_MIN_PTG)
			 	{	
					try{
						out.println("setNUM_PTG_DMD("+lNUM_PTG_DMD+", "+lCOD_TES_VRF.longValue()+")" );
						Domande.setNUM_PTG_DMD(lNUM_PTG_DMD, lCOD_TES_VRF.longValue());
						lSUM_NUM_PTG=TestVerifica.sumNUM_PTG_DMD();
						TestVerifica.setNUM_MAX_PTG(lSUM_NUM_PTG);
					}catch(Exception ex){}
			 	}else{
			 		 out.print("<script>alert(arraylng[\"MSG_0040\"]);err=true;</script>");
			 	}
		}
		Domande.setDES_DMD(strDES_DMD);
		//----------------------------
		//--- update rst_dmd_tab --- begin - mary 
		Domande.clearCOD_RST();
		if(ar_strCOD_RST != null)
		{
			String strListCOD_RST="";
			int iCOD_RST = 0;
			for(iCOD_RST = 0; iCOD_RST < ar_strCOD_RST.length; iCOD_RST++)
			{
				strListCOD_RST = strListCOD_RST + new Long(ar_strCOD_RST[iCOD_RST]).toString()+",";
			}
			strListCOD_RST=strListCOD_RST.substring(0,strListCOD_RST.length()-1);
			Domande.editCOD_RST(strListCOD_RST);
		}
		//--- update rst_dmd_tab --- end - mary 
	}
//=======================================================================================
	if(ReqMODE.equals("new"))
	{
	// new Domande--------------------------
		out.println("<script>isNew=true;</script>");
		//---------------------------
		// creating of object
		IDomandeHome home=(IDomandeHome)PseudoContext.lookup("DomandeBean");
		try{
			Domande=home.create(strNOM_DMD, strDES_DMD);
		}catch(Exception ex){
			out.print("<script>Alert.Error.showDublicate();err=true;</script>");
			return;
		}
	 }
}
%>
<script language="JavaScript" type="text/javascript">
<!--
if (!err){
	if(isNew){
		parent.tb_url_Query=parent.tb_url_Query+"&NUM_PTG_DMD="+<%=lNUM_PTG_DMD%>;
		parent.ToolBar.OnNew("ID=<%=Domande.getCOD_DMD()%>");
		Alert.Success.showCreated();
	}else{
		Alert.Success.showSaved();
	}
}
</script>
