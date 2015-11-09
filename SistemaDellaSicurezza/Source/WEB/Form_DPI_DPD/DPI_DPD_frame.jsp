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
    <version number="1.0" date="23/02/2004" author="POdmasteriev Alexandr">		
      <comments>
			   <comment date="23/02/2004" author="POdmasteriev Alexandr">
				   <description>Fail pegruzki select COD_LOT_DPI 
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>


<%@ include file="../_include/Checker.jsp" %>
<script>
var obj2=parent.document.all["COD_LOT_DPI"];
obj2.options.length=0;
<%
//-----start check section--------------------------------
ILottiDPIHome l_home=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean");
String str;
long i=0;
String lCOD_TPL_DPI=request.getParameter("ID");
long COD_SEL=new Long(request.getParameter("ID_SEL")).longValue();

  	java.util.Collection col_nr = l_home.getLottiDPIByTPLDPIID_View(new Long(lCOD_TPL_DPI).longValue());
	java.util.Iterator it_nr = col_nr.iterator();
 	while(it_nr.hasNext()){
		LottiDPIByTPLDPIID_View nr=(LottiDPIByTPLDPIID_View)it_nr.next();
		out.println("var oOption"+i+"=document.createElement('OPTION');");
		if (nr.COD_LOT_DPI==COD_SEL){
			out.println("oOption"+i+".text='"+nr.IDE_LOT_DPI+"'; oOption"+i+".value='"+nr.COD_LOT_DPI+"'; oOption"+i+".selected=true; obj2.add(oOption"+i+");");
		}else{
			out.println("oOption"+i+".text='"+nr.IDE_LOT_DPI+"'; oOption"+i+".value='"+nr.COD_LOT_DPI+"'; obj2.add(oOption"+i+");");}  
			i=i+1;
  		}
%>
</script>
