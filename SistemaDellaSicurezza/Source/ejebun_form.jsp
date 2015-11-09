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
	if(request.getParameter("GENERATE")!=null){
	%>
		<jsp:forward page="ejebun.jsp" />
	<%
	}
%>

<%@ include file="/WEB/src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="/WEB/src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="/WEB/src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%
class Fetcher extends BMPEntityBean{
	public void ejbRemove(){}
	public void ejbLoad(){}
	public void ejbStore(){}
	
	public void ejbActivate(){}
	public void ejbPassivate(){}
	
	
	protected ResultSetMetaData getMemebers(String strTable) throws Exception{
		PreparedStatement ps=getConnection().prepareStatement("SELECT * FROM " + (strTable));
		ResultSetMetaData md=ps.executeQuery().getMetaData();
		return md;
	}
}
%>

<h1><font color="red" >EJBun 1.0</font></h1>
<form method="post">
<table>
	<tr>
		<td>Table</td>
		<td><input type="text" name="TABLE" value="<%=request.getParameter("TABLE")%>"></td>
	</tr>
	<tr>
		<td>Key</td>
		<td><input type="text" name="KEY" value="<%=request.getParameter("KEY")%>"></td>
	</tr>
	<tr>
		<td>EJB Name</td>
		<td><input type="text" name="NAME" value="<%=request.getParameter("NAME")%>"></td>
	</tr>	
</table>
<br>
<input type="submit" name="REFRESH" value="LOAD TABLE"> <input type="submit" name="GENERATE" value="GENERATE"> 
<br>
<br>
<%
	ResultSetMetaData md=null;
	try{
		md = (new Fetcher()).getMemebers(request.getParameter("TABLE"));
	}
	catch(Exception ex){
		out.println(ex.getMessage());
		return;
	}
%>
<table border=1>
		<tr>
			<th>Required</th>
			<th>Name</th>
		</tr>
	<%

	for(int i=1; i<=md.getColumnCount(); i++){
	%>
		<tr>
			<td><input type="checkbox" name="<%=md.getColumnName(i).toUpperCase()%>"></td>
			<td><%=md.getColumnName(i).toUpperCase()%></td>
		</tr>
		<%
	}
	%>
</table>
</form>
</body>
