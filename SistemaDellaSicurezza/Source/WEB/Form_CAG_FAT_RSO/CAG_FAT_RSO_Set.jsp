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
    <version number="1.0" date="24/01/2004" author="Malyuk Sergey">
          <comments>
                  <comment date="24/01/2004" author="Malyuk Sergey">
                   <description></description>
                 </comment>
      </comments>
    </version>
  </versions>
</file>
*/
%>
<script>
//JS peremennaja vistvliemaja v true esli bila sozdana new zapis'
var isNew = false;
var err = false;
</script>
<script src="../_scripts/Alert.js"></script>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.CategorieFattoreRischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!
    String ReqMODE;    // parameter of request
%>
<%
ICategorioRischio CategorioRischio=null;
long lCOD_CAG_FAT_RSO=0;
if(request.getParameter("SBM_MODE")!=null)
{
    ReqMODE=request.getParameter("SBM_MODE");
    //out.println(ReqMODE);

        Checker c = new Checker();

    //- checking for required fields
    String strNOM_CAG_FAT_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("nome"),true);

    //- checking for not required fields
    String strDES_CAG_FAT_RSO="";
    strDES_CAG_FAT_RSO=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("descr"),false);


    if (c.isError)
        {
            String err = c.printErrors();
            out.println("<script>alert(\""+err+"\");</script>");
            return;
        }
//=======================================================================================
  if(ReqMODE.equals("edt"))
    {
        // editing of CategorioRischio--------------------
        // gettinf of object
        String strCOD_CAG_FAT_RSO=request.getParameter("CAG_FAT_RSO_ID");                    //ID of CategorioRischio
        ICategorioRischioHome home=(ICategorioRischioHome)PseudoContext.lookup("CategorioRischioBean");
        Long cag_fat_rso_id=new Long(strCOD_CAG_FAT_RSO);
        CategorioRischio = home.findByPrimaryKey(cag_fat_rso_id);
        try{
            CategorioRischio.setNOM_CAG_FAT_RSO(strNOM_CAG_FAT_RSO);
        }catch(Exception ex){
            out.print("<script>err=true; Alert.Error.showDublicate();</script>");
            return;
        }

    }
//=======================================================================================
    if(ReqMODE.equals("new"))
    {
    // new CategorioRischio--------------------------
    // creating of object
        ICategorioRischioHome home=(ICategorioRischioHome)PseudoContext.lookup("CategorioRischioBean");
        try{
        CategorioRischio=home.create(strNOM_CAG_FAT_RSO);
        out.print("<script>isNew=true;</script>");
        }catch(Exception ex){
            out.print("<script>err=true; Alert.Error.showDublicate();</script>");
            return;
        }
        lCOD_CAG_FAT_RSO = CategorioRischio.getCOD_CAG_FAT_RSO();
    }
//=======================================================================================
    if (CategorioRischio!=null){
    //   *Not require Fields*
        CategorioRischio.setDES_CAG_FAT_RSO(strDES_CAG_FAT_RSO);
    //out.print("<script>isNew=true;</script>");
    }
}
 %>
<script>
if (!err){
   if(isNew) {
        parent.ToolBar.OnNew("ID=<%=lCOD_CAG_FAT_RSO%>");
        Alert.Success.showCreated();
   }
   else
   {
        Alert.Success.showSaved();
   }

}
</script>
