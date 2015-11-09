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
    < version number="1.0" date="26/01/2004" author="Artur Denysenko">		
      < comments>
			   < comment date="26/01/2004" author="Pogrebnoy Yura">
				   Popolzovalsya EJBun v.1.0
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
public interface  IFattoriRischio extends EJBObject {
  //--Ruquire fields
  //--COD_FAT_RSO
 	public long getCOD_FAT_RSO();
	//--NOM_FAT_RSO
	public String getNOM_FAT_RSO();
	public void setNOM_FAT_RSO(String strNOM_FAT_RSO);
	//--NUM_FAT_RSO
	public long getNUM_FAT_RSO();
	public void setNUM_FAT_RSO(long lNUM_FAT_RSO);
	//--COD_CAG_FAT_RSO
	public long getCOD_CAG_FAT_RSO();
	public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO);

  //--Not ruquire fields
	//--COD_NOR_SEN
	public long getCOD_NOR_SEN();
	public void setCOD_NOR_SEN(long lCOD_NOR_SEN);
	//DES_FAT_RSO
	public String getDES_FAT_RSO();
	public void setDES_FAT_RSO(String strDES_FAT_RSO);
}

public interface IFattoriRischioHome extends EJBHome{
     public IFattoriRischio create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws CreateException;
     public IFattoriRischio findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	 
	 //<alex "19/03/2004">
	 public Collection getFattoriWithoutRischi(long lCOD_AZL, long lCOD_MAN);
	 //<report>
	 public Collection getFattoriRischioView();
}
  
//< ejb-interfaces>

//<report>
class FattoriRischioView implements java.io.Serializable{
	public long	lCOD_FAT_RSO;
	public String	strNOM_FAT_RSO;
	public String strDES_FAT_RSO;
	public long	lNUM_FAT_RSO;
	public long	lCOD_CAG_FAT_RSO;
	public long	lCOD_NOR_SEN;
	public long lIndex;
}
%>
