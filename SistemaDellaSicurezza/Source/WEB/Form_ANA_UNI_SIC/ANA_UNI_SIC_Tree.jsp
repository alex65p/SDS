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
    <version number="1.0" date="25/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="25/02/2004" author="AlexKyba">
				   <description>function, stroyaschaya strukturu unita sicurezza</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>
<%@ page import="com.apconsulting.luna.ejb.UnitaSicurezza.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<script>
	parent.dTreeVew.innerText="Costruzioe dell'albero...";
</script>
<% 
IUnitaSicurezza bean=null;
IUnitaSicurezzaHome home=(IUnitaSicurezzaHome)PseudoContext.lookup("UnitaSicurezzaBean");
String strTreeNodes=buildTreeNodes(bean, home, 0); 
	%>
<script>
<% if (!isError){ %>
	tree_nodes=[<%= strTreeNodes %>];
<% }else{ %>
	tree_nodes=['<%= strError %>', null, null];
<% } %>
	parent.buildTree(tree_nodes);
</script>	

<%!
boolean isError=false;
String strError=""; 
String buildTreeNodes(IUnitaSicurezza bean, IUnitaSicurezzaHome home, long n){
	Collection c;
	Iterator i;
	long azienda = Security.getAzienda();
	String strNodes="";
	try{
		if (n==0){
			c=home.getTopOfTree(azienda);
			i=c.iterator();
			if (i!=null){
				while (i.hasNext()){
					n++;
					UnitaSicurezzaView view = (UnitaSicurezzaView)i.next();
					
					String strNOM_UNI_SIC= view.strNOM_UNI_SIC;
					long lCOD_UNI_SIC= view.lCOD_UNI_SIC;
					strNodes+="['"+strNOM_UNI_SIC+"', 'getNode("+lCOD_UNI_SIC+")', null";
					bean = home.findByPrimaryKey(new Long(lCOD_UNI_SIC));
					strNodes+=  buildTreeNodes(bean, home, n);
					if (isError) return "";
					if (i.hasNext())
						strNodes+="],";
					else
						strNodes+="]";
				}
			}
		}
		else{
			c=bean.getChildren(azienda);
			i=c.iterator();
			if (i!=null){
				while (i.hasNext()){
					n++;
				 	UnitaSicurezzaView view = (UnitaSicurezzaView)i.next();
					String strNOM_UNI_SIC= view.strNOM_UNI_SIC;
					long lCOD_UNI_SIC= view.lCOD_UNI_SIC;
					strNodes+=",['"+strNOM_UNI_SIC+"', 'getNode("+lCOD_UNI_SIC+")', null";
					bean = home.findByPrimaryKey(new Long(view.lCOD_UNI_SIC));
					strNodes+=buildTreeNodes(bean, home, n);
					if (isError) return "";
					strNodes+="]";
				}
			}
		}
	}
	catch(Exception ex){
		strError+=ex.getMessage();
		return "";
	}	
	return strNodes;
}
%>
