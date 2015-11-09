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


	var da=parent.dialogArguments;
	if(da!=null){	
				da.ID="<%=Formatter.format(lCOD_DOC)%>";
				da.COD_DOC="<%=Formatter.format(lCOD_DOC)%>";
				da.RSP_DOC="<%=Formatter.format(strRSP_DOC)%>";
				da.APV_DOC="<%=Formatter.format(strAPV_DOC)%>";
				da.EMS_DOC="<%=Formatter.format(strEMS_DOC)%>";
				da.NUM_DOC="<%=Formatter.format(strNUM_DOC)%>";
				da.EDI_DOC="<%=Formatter.format(lEDI_DOC)%>";
				da.REV_DOC="<%=Formatter.format(strREV_DOC)%>";
				da.DAT_REV_DOC="<%=Formatter.format(dtDAT_REV_DOC)%>";
				da.MES_REV_DOC="<%=Formatter.format(lMES_REV_DOC)%>";
				da.DAT_FUT_REV_DOC="<%=Formatter.format(dtDAT_FUT_REV_DOC)%>";
				da.DES_REV_DOC="<%=Formatter.format(strDES_REV_DOC)%>";
				da.PRG_RIF_DOC="<%=Formatter.format(strPRG_RIF_DOC)%>";
				da.PGN_RIF_DOC="<%=Formatter.format(strPGN_RIF_DOC)%>";
				da.TIT_DOC="<%=Formatter.format(strTIT_DOC)%>";
				da.COD_CAG_DOC="<%=Formatter.format(lCOD_CAG_DOC)%>";
				da.COD_TPL_DOC="<%=Formatter.format(lCOD_TPL_DOC)%>";
				da.COD_LUO_FSC="<%=Formatter.format(lCOD_LUO_FSC)%>";
				da.NOT_LUO_CON="<%=Formatter.format(strNOT_LUO_CON)%>";
				da.PER_CON_YEA="<%=Formatter.format(lPER_CON_YEA)%>";
				da.COD_AZL="<%=Formatter.format(lCOD_AZL)%>";
	}
