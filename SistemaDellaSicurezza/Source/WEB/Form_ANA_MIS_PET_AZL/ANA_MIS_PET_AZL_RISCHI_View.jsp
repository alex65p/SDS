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

<%@ page import="com.apconsulting.luna.ejb.AttivitaLavorative.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>
<%@ page import="javax.ejb.FinderException" %>

<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../_include/Checker.jsp" %>
<% 
long lCOD_AZL=Security.getAzienda();
IMisurePreventProtettiveAz mis=null;
IMisurePreventProtettiveAzHome misHome=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");

IAttivitaLavorative attLav;
IAttivitaLavorativeHome atHome=(IAttivitaLavorativeHome)PseudoContext.lookup("AttivitaLavorativeBean"); 
 
IAnagrLuoghiFisici luoghi;
IAnagrLuoghiFisiciHome luoHome=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
 
String err = new String(); 
String str = "";
String COD_RSO_LUO_FSC="0";
String COD_RSO_MAN="0";

Checker c = new Checker(); 
String t = c.checkString("type", request.getParameter("type"), true);
String objID = c.checkString("object",request.getParameter("objID"), true);
long INDEX = c.checkLong("cod_azl",request.getParameter("COD_AZL"), true);
long ANA_MAN = c.checkLong("ana_man",request.getParameter("ANA_MAN"), true);
long LUO_FSC = c.checkLong("luo_fsc",request.getParameter("LUO_FSC"), true);
String NOM_RSO = c.checkString("rischio", request.getParameter("LUO_FSC"), false);
String STA = c.checkString("sta", request.getParameter("STA"), false);


out.println(LUO_FSC+"<br>");
out.println(INDEX+"<br>");
if (c.isError){
	err = c.printErrors();
	%><script>alert("<%=err%>");</script><%
	return;
}
NOM_RSO +="%";
if (ANA_MAN!=0){
	try{
		if (t.equals("r")){
			attLav = atHome.findByPrimaryKey(new AttivitaLavorativePK(lCOD_AZL, ANA_MAN));
			java.util.Collection col = attLav.getRischiByAttivataLavorativaView(INDEX);
			java.util.Iterator it = col.iterator();
	 		str="<select style='width:100%' name='RSO' id='RSO' onchange='enableMisura()' ><option value='0'></option>";
			while(it.hasNext()){
				RischiByAttivataLavorativaView view=(RischiByAttivataLavorativaView)it.next();
				str+="<option value='"+view.lCOD_RSO_MAN+"' cod_rso='"+view.lCOD_RSO+"'>"+view.strNOM_RSO+"</option>";	
			}	
			str+="</select>	";
		}
		if (t.equals("m")){
			Collection col = misHome.getMisureByAttivitaAndRischiView(INDEX, ANA_MAN,  STA, NOM_RSO);
			Iterator it = col.iterator();
			str = "<select style='width:100%' id='SEL_RSO' id='SEL_RSO' >";
			while (it.hasNext()){
				MisureByParamsView view = (MisureByParamsView)it.next();
				str+="<option value='"+Formatter.format(view.lCOD_MIS_PET_AZL)+"'>"+Formatter.format(view.strNOM_MIS_PET_AZL)+"</option>";
			}
			str+="</select>	";
		}
	}
		catch (FinderException ex){
			err+= ex.getMessage(); 
	}
	catch (Exception ex){
		err+=ex.getMessage();
	}	
}
else if(LUO_FSC!=0){
	try{
		if (t.equals("r")){
			luoghi = luoHome.findByPrimaryKey(new Long(LUO_FSC));
			out.print(luoghi.getNOM_LUO_FSC());
			java.util.Collection col = luoghi.getRischiByLuoghiFisiciView(INDEX);
			java.util.Iterator it = col.iterator();
	 		str="<select style='width:100%' name='RSO' id='RSO' onchange='enableMisura()'><option value=''></option>";
			while(it.hasNext()){
				RischiByLuoghiFisiciView view=(RischiByLuoghiFisiciView)it.next();
				str+="<option value='"+view.lCOD_RSO_LUO_FSC+"' cod_rso='"+view.lCOD_RSO+"'>"+view.strNOM_RSO+"</option>";	
			}	
			str+="</select>";
		}
		
		if (t.equals("m")){
			Collection col = misHome.getMisureByLuoghiAndRischiView(INDEX, ANA_MAN,  STA, NOM_RSO);
			Iterator it = col.iterator();
			str = "<select style='width:100%' id='SEL_RSO' id='SEL_RSO' >";
			while (it.hasNext()){
				MisureByParamsView view = (MisureByParamsView)it.next();
				str+="<option value='"+Formatter.format(view.lCOD_MIS_PET_AZL)+"'>"+Formatter.format(view.strNOM_MIS_PET_AZL)+"</option>";
			}
			str+="</select>	";
		}
	}
	catch (FinderException ex){
		err+= ex.getMessage(); 
	}
	catch (Exception ex){
		err+=ex.getMessage();
	}	
}
if (!str.equals("")){
	out.print(str);
	%>
	
	<script>
		str="<%= str %>";
		parent.showRischi(str);
	</script>
	<%
}
else{
	%>
	<script>
		str=arraylng["MSG_0045"];
		parent.alert(str);
	</script>
	<%
}
%>
