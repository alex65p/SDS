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
	class ComboParser2 implements IComboParser{
		public void parse(Object obj, ComboItem item){
			Dipendenti_Names_View w= (Dipendenti_Names_View)obj;
			item.lIndex=w.COD_DPD;
			item.strValue=w.COG_DPD+" "+w.NOM_DPD;
		}
	}
long lCOD_AZL2 = Security.getAzienda();
Collection col=null;
if(bean!=null){
	IDipendenteHome h2=(IDipendenteHome)PseudoContext.lookup("DipendenteBean");
	col=h2.getDipendenteByDitta(lCOD_AZL2, lCOD_DTE);
}

ComboBuilder b2=new ComboBuilder( lCOD_DPD, new ComboParser2(), col);
b2.strName="COD_DPD";
%>
<%=b2.build()%>
