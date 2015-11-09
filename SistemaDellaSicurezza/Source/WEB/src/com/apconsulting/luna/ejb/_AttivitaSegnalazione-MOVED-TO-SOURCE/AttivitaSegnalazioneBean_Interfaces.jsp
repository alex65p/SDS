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
< file>
  < versions>	
    < version number="1.0" date="27/02/2004" author="Artur Denysenko">		
      < comments>
			   < comment date="27/02/2004" author="Artur Denysenko">
				   Interfaces dlia objecta AttivitaSegnalazione
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="java.util.*"%>

<%!
//< ejb-interfaces description="EJB Interfaces">

public interface  IAttivitaSegnalazione extends EJBObject
{
  	public long getCOD_ATI_SGZ();
	//
	public String getDES_ATI_SGZ();
	public void setDES_ATI_SGZ(String strDES_ATI_SGZ);
	//
	public java.sql.Date getDAT_SCA();
	public void setDAT_SCA(java.sql.Date dtDAT_SCA);
	//
	public java.sql.Date getDAT_VER();
	public void setDAT_VER(java.sql.Date dtDAT_VER);
	//
	public long getCOD_SGZ();
	public void setCOD_SGZ(long lCOD_SGZ);
	//
	public long getCOD_DPD();
	public void setCOD_DPD(long lCOD_DPD);
	//
	public long getCOD_AZL();
	public void setCOD_AZL(long lCOD_AZL);
	// Link Table DOC_ATI_SGZ_TAB
  	public void addCOD_DOC(long newCOD_DOC);
  	public void removeCOD_DOC(long newCOD_DOC);
}
//
public interface IAttivitaSegnalazioneHome extends EJBHome
{
  public IAttivitaSegnalazione create(
  	String strDES_ATI_SGZ, 
	java.sql.Date dtDAT_SCA, 
	long lCOD_SGZ, 
	long lCOD_DPD, 
	long lCOD_AZL
  ) throws CreateException;
  public IAttivitaSegnalazione findByPrimaryKey(Long primaryKey) throws  FinderException;
  public Collection findAll() throws FinderException;
  public void remove(Object primaryKey);
  public Collection getAnagraficaDocumenti_List_ID_View(long lCOD_SGZ);
}
//
class AnagraficaDocumenti_List_ID_View implements java.io.Serializable
{
	public long COD_DOC;
	public String RSP_DOC;
	public String TIT_DOC;
	public java.sql.Date DAT_REV_DOC;
}
//< ejb-interfaces>
%>

