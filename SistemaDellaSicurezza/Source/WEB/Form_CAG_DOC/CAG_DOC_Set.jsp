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

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean_Interfaces.jsp" %>
<%@ include file="../src/com/apconsulting/luna/ejb/CategoriaDocumento/CategoriaDocumentoBean.jsp" %>

<%@ include file="../_include/Checker.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<%!    String ReqMODE;    // parameter of request%>
<script>
 var err = false;
 var isNew = false;
</script>
<script language="JavaScript" src="../_scripts/Alert.js"></script>
<%ICategoriaDocumento CategoriaDocumento=null;
long THIS_ID=0;
String strDES_CAG_DOC="";
if(request.getParameter("SBM_MODE")!=null){
    ReqMODE=request.getParameter("SBM_MODE");
    Checker c = new Checker();
    //- checking for required fields
    String strNOM_CAG_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Nome"),request.getParameter("NOM_CAG_DOC"),true);
    //- checking for not required fields
    strDES_CAG_DOC=c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"),request.getParameter("DES_CAG_DOC"),false);
 if (c.isError){
	String err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}

//=======================================================================================
  if(ReqMODE.equals("edt"))
    {
        // editing of CategoriaDocumento--------------------
        // gettinf of object
        Long lCOD_CAG_DOC=new Long(c.checkLong("Funzioni Aziendali ID",request.getParameter("COD_CAG_DOC"),true));
      if (c.isError){
            String err = c.printErrors();
            out.println("<script>alert(\""+err+"\");</script>");
            return;
        }      /**/

        ICategoriaDocumentoHome home=(ICategoriaDocumentoHome)PseudoContext.lookup("CategoriaDocumentoBean");
        CategoriaDocumento = home.findByPrimaryKey(lCOD_CAG_DOC);
        //getting of parameters and set the new object variables
        try{
        CategoriaDocumento.setNOM_CAG_DOC(strNOM_CAG_DOC);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }
        THIS_ID=CategoriaDocumento.getCOD_CAG_DOC();
    }
//=======================================================================================
    if(ReqMODE.equals("new"))
    {
    // new CategoriaDocumento--------------------------
    // creating of object
        ICategoriaDocumentoHome home=(ICategoriaDocumentoHome)PseudoContext.lookup("CategoriaDocumentoBean");
        try{
        CategoriaDocumento=home.create(strNOM_CAG_DOC);
        %>
        <script>isNew=true;</script>
        <%
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }
        THIS_ID=CategoriaDocumento.getCOD_CAG_DOC();

    }
//=======================================================================================

}
if (CategoriaDocumento!=null){
    //   *Not require Fields*
        try{
    CategoriaDocumento.setDES_CAG_DOC(strDES_CAG_DOC);
        }catch(Exception ex){
            out.print("<script>Alert.Error.showDublicate();err=true;</script>");
            return;
        }
%>
<script>
if (!err){
  if(isNew)
  { Alert.Success.showCreated();
    parent.ToolBar.OnNew("ID=<%=THIS_ID%>");
  }
    else
    {
    Alert.Success.showSaved();}
}
</script>

<%}%>
