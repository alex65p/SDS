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
    <version number="1.0" date="20/02/2004" author="Yuriy Kushkarov">
	      <comments>
				  <comment date="20/02/2004" author="Yuriy Kushkarov">
				   <description>Shablon formi COR_DPD_Form.jsp</description>
				  </comment>		
        </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Dipendente.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp"%>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
	String ReqMODE;	// parameter of request 
%>

<script>
    var err=false;
    var isNew=false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%
    IDipendente bean=null;
    //-----start check section--------------------------------
    Checker c = new Checker();

    long lCOD_DPD=c.checkLong("Dipendente",request.getParameter("COD_DPD"),true);//
    long lCOD_AZL=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Azienda/Ente"),request.getParameter("AZL_ID"),true);
    long lCOD_COR=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("COR_DPD"),true);
    java.sql.Date dtDAT_CSG_MAT=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.consegna.materiale"),request.getParameter("DAT_CSG_MAT"),false);
    java.sql.Date dtDAT_EFT_TES_VRF=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.test"),request.getParameter("DAT_EFT_TES_VRF"),false);
    java.sql.Date dtDAT_EFT_COR=c.checkDate(ApplicationConfigurator.LanguageManager.getString("Data.corso"),request.getParameter("DAT_EFT_COR"),true);
    String sESI_TES_VRF=c.checkString(ApplicationConfigurator.LanguageManager.getString("Esito.test"),request.getParameter("ESI_TES_VRF"),true);

    String sMAT_CSG=c.checkString(ApplicationConfigurator.LanguageManager.getString("Mat.Cons."),
            request.getParameter("MAT_CSG")==null?"":request.getParameter("MAT_CSG"),true);
    String sATE_FRE_DPD=c.checkString(ApplicationConfigurator.LanguageManager.getString("Att.Freq."),
            request.getParameter("ATE_FRE_DPD")==null?"":request.getParameter("ATE_FRE_DPD"),true);

    long lPTG_OTT_DPD=c.checkLong(ApplicationConfigurator.LanguageManager.getString("Punteggio"),request.getParameter("PTG_OTT_DPD"),false);

    if (c.isError){
      String err = c.printErrors();
      out.print("<script>err=true;alert(\""+err+"\");</script>");
      return;
    }

    IDipendenteHome home=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");

//------end check section--------------------------------
try{
    if(request.getParameter("SBM_MODE")!=null)
    {
        ReqMODE=request.getParameter("SBM_MODE");

        bean = home.findByPrimaryKey(new Long(lCOD_DPD));
        if(ReqMODE.equals("new"))
        {
            bean.addCOR_DPD(sATE_FRE_DPD, sESI_TES_VRF, sMAT_CSG, lCOD_COR,dtDAT_EFT_COR);
            %>
            <script>isNew=true;</script>
            <%
        }
        if(bean!=null){
            java.sql.Date oldDAT_EFT_COR = null;
            if (request.getParameter("oldDAT_EFT_COR") == null ||
                request.getParameter("oldDAT_EFT_COR").equals("") ||
                request.getParameter("oldDAT_EFT_COR").equals("null")){
                    oldDAT_EFT_COR = dtDAT_EFT_COR;
            } else {
                oldDAT_EFT_COR =
                    java.sql.Date.valueOf(
                             request.getParameter("oldDAT_EFT_COR"));
            }
              bean.editCOR_DPD(lCOD_COR, sMAT_CSG, sESI_TES_VRF, sATE_FRE_DPD, dtDAT_CSG_MAT, dtDAT_EFT_COR,
                             dtDAT_EFT_TES_VRF, lPTG_OTT_DPD, oldDAT_EFT_COR);
        }
        else {
            throw new Exception("Invalid operation");
        }
    }
}
catch(Exception ex)
{
        ex.printStackTrace();
%>
		<div id="divErr">
			<%=ex.getMessage()%>
		</div>
		<script>
		err=true;
		</script>
<%
}
%>
<script>
if (err) Alert.Error.showDublicate();
 if(!err){	
		parent.returnValue="OK";
		if(isNew){
			Alert.Success.showCreated();

            parent.ToolBar.OnNew('COD_COR=<%=lCOD_COR%>&dat_eft_cor=<%=dtDAT_EFT_COR%>');

		}else{
			Alert.Success.showSaved();
		}
	}else{
		parent.returnValue="ERROR";	
	}	
</script>
