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

<%@ include file="src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="_include/Checker.jsp" %>
<%@ include file="_include/Global.jsp" %>

<%@ include file="_include/ComboBuilder.jsp" %>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%!
	String formatPathLink(String strPath){
		strPath=parseVirtual(strPath);
		return "<a href='acl_editor.jsp?path="+strPath+"'>"+strPath+"</a>";
	}
	String formatPathLink(String strName, String strPath){
		strPath=parseVirtual(strPath);
		return "<a href='acl_editor.jsp?path="+strPath+"'>"+strName+"</a>";
	}
	
	String parseVirtual(String strPath){
		return Security.Replace(strPath, strVirtualPath, "" );
	}
	
	String strVirtualPath;
	Collection permissions=null;
	
	class ComboParser1 implements IComboParser{
		public void parse(Object obj, ComboItem item){
			SecurityUserPermission w= (SecurityUserPermission)obj;
			item.lIndex=0;
			item.strValue=w.strName;
		}
	}
	String buildPermissionList(String strName, String strSelectedName) throws Exception{
		if(permissions==null) permissions=Security.getSecurityHome().getAllPermissions();
		ComboBuilder b1=new ComboBuilder( strSelectedName, new ComboParser1(), permissions);
		b1.strName=strName;
		return b1.build();
	}
	
%>
<%
	String strPath=request.getServletPath();
	String strRealPath=request.getRealPath(strPath);
	
	strPath=Security.Replace(strPath,"/", File.separator );
	strVirtualPath=Security.Replace(strRealPath, strPath, "" );

	File directory;
	strPath=request.getParameter("path");
	if(strPath==null){
			 //new File(  request.getRealPath(request.getServletPath()) )).getParent()
		directory=new File(  new File(  request.getRealPath(request.getServletPath())  ).getParent()  );
	}
	else{
		directory=new File(strVirtualPath+strPath);
	}
	strPath=directory.getCanonicalPath();
	
	File[] arrFiles =directory.listFiles();
	String strParentPath=directory.getParentFile().toString();
	
	ISecurityHome home=Security.getSecurityHome();
	
	
%>
<form METHOD=post target="setter" action="acl_setter.jsp">
<input type="submit" value="SAVE" >
<table border=1 width=100%>
	
	<tr bgcolor="#ffff00" align="left">
		<th colspan=1>
			<%if(!strVirtualPath.equals(strParentPath)){%>
				<%=formatPathLink(strParentPath)%>
			<%}else{%>
				ROOT
			<%}%>
			\<%=directory.getName()%>
		</th>
		<th>Permission</th>
		<th>Create</th>
		<th>Save</th>
		<th>List</th>
		<th>Delete</th>
		<th>AssociateCreate</th>
		<th>AssociateDelete</th>
		<th>Print</th>
		<th>Print2</th>
		<th>Detalize</th>
		<th>Request</th>
	</tr>
	
	<%
	if(arrFiles!=null){%>
		<%for(int i=0; i<arrFiles.length; i++){
			if (arrFiles[i].isDirectory()) continue;
				
		%>
		<tr>

				<td><%=arrFiles[i].getName()%></td>
				<%
				
				String strName=parseVirtual(arrFiles[i].toString());
				strName=Security.Replace(strName, File.separator, "/" );
				SecurityModule module=home.getSecurityModule(strName);
				if(module==null){
					 module= new SecurityModule();
					 module.strName=strName;
					 module.strPermission="";
				}
				%>
				<%//if(true) continue;%> 
				<td>
				<input type="hidden" name="MODULE" value="<%=strName%>">
				<%
					//strName=strName.hashCode()+"";
				%>
				
				<%=buildPermissionList(module.strName+"_Permission", module.strPermission+"")%></td>
				
				<td><input type="checkbox" name="<%=strName%>_RequireCreate"   value="1" <%if(module.bRequireCreate) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireSave"   value="1" <%if(module.bRequireSave) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireList"   value="1" <%if(module.bRequireList) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireDelete"   value="1" <%if(module.bRequireDelete) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireAssociateCreate"   value="1" <%if(module.bRequireAssociateCreate) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireAssociateDelete"   value="1" <%if(module.bRequireAssociateDelete) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequirePrint"   value="1" <%if(module.bRequirePrint) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequirePrint2"   value="1" <%if(module.bRequirePrint2) out.print("checked");%>></td>
				<td><input type="checkbox" name="<%=strName%>_RequireDetalize"   value="1" <%if(module.bRequireDetalize) out.print("checked");%>></td>
				<td><input type="text" name="<%=strName%>_Request"   value="<%=Formatter.format(module.strRequest)%>"></td>
		</tr>
		<%}%>
		
		<%for(int i=0; i<arrFiles.length; i++){
			if (!arrFiles[i].isDirectory()) continue;
		%>
				<tr>
					<td colspan=12><%=formatPathLink(arrFiles[i].getName(), arrFiles[i].toString())%></td>
				</tr>
		<%}%>
		
	<%}%>
</table>
</form>
<iframe name="setter" src="empty.txt" width=100%></iframe>
