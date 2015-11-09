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

<%@ page import="s2s.utils.Formatter"%>
<%!
	public String printErrDiv(String strName, String ex ){
		return "<div id='"+strName+"'>"+Formatter.format(ex)+"</div>";
	}
	
	public String printErrDiv(String strName, Exception ex ){
		return printErrDiv(strName, ex.toString());
	}
	
	public String printErrAlert(String strName, String strAlertType, Exception ex ){
		return printErrDiv(strName, ex)+"<script>err=true;Alert."+strAlertType+"("+strName+".innerText);</script>";
	}
	
	public String printErrAlert(String strName, String strAlertType, String ex ){
		return printErrDiv(strName, ex)+"<script>err=true;Alert."+strAlertType+"("+strName+".innerHtml);</script>";
	}
	
	
	public String printScriptIsNew(){
		return 	"<script>isNew=true;</script>";
	}
	
%>
