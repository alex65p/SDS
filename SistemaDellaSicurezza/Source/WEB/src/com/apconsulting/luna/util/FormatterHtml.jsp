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

<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%
/*
<file>
  <versions>	
    <version number="1.0" date="16/01/2004" author="Artur Denysenko">		
      <comments>
			   <comment date="16/01/2004" author="Artur Denysenko">
				   <description>Formatter, to, o chom tak dolgo govorili</description>
				</comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
class FormatterWrapper{

	public String formatPlain(boolean b){
		return Boolean.toString(b);
	}

	public String formatPlain(char c){
		return Character.toString(c);
	}

	public String formatPlain(double d){
		return Double.toString(d);
	}

	public String formatPlain(float f){
		return Float.toString(f);
	}

	public String formatPlain(int i){
		return Integer.toString(i);
	}

	public String formatPlain(long l){
		return Long.toString(l);
	}

	public String formatPlain(java.util.Date dt){
		if (dt==null) return "";
    		return new java.text.SimpleDateFormat("dd/MM/yyyy").format(dt);
	}

	public String formatPlain(Object obj){
		if (obj==null) return "";
		else return obj.toString();
	}

	public String formatPlain(String s){
		if (s==null) return "";
		return s;
	}
	
	public String formatPlain(String s, int n){
		if (s==null) return "";
		if(s.length()<=n) return s;
		return s.substring(0,n);
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////
	
	private String html_encode(String s){
		return org.webmacro.util.HTMLEscaper.escape(s);
	}
	
	public String format(boolean b){
		return html_encode(formatPlain(b));
	}

	public String format(char c){
		return html_encode(formatPlain(c));
	}

	public String format(double d){
		return html_encode(formatPlain(d));
	}

	public String format(float f){
		return html_encode(formatPlain(f));
	}

	public String format(int i){
		return html_encode(formatPlain(i));
	}

	public String format(long l){
		return html_encode(formatPlain(l));
	}

	public String format(java.util.Date dt){
		return html_encode(formatPlain(dt));
	}

	public String format(Object obj){
		return html_encode(formatPlain(obj));
	}

	public String format(String s){
		return html_encode(formatPlain(s));
	}
	
}
	final FormatterWrapper Formatter = new FormatterWrapper();
	
	// _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_ _!_
%>
<%//=Formatter.format("><ujhjhjhjh ~")%>
<%//=Formatter.format(new java.sql.Date(new java.util.Date().getTime()))%>
<%//=Formatter.format(121)%>
<%//=Formatter.format(211221122112L)%>
<%//=Formatter.format(12.1221)%>
<%//=Formatter.format(true)%>
<%//=Formatter.format(new java.util.Hashtable())%>
<%//=Formatter.format( new java.net.Socket())%>

