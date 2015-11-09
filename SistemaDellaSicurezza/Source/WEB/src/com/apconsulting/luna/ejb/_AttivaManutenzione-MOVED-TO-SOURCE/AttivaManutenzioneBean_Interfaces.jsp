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

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="25/01/2004" author="Podmasteriev Alexandr">
				   <description>Bean dla tablici ANA_ATI_MNT_MAC</description>
				 </comment>		
				  <comment date="16/02/2004" author="Alex Kyba">
				   		<description>
							 dobavil polia v AttivaManutenzione_UserID_View
							 method home interface getAttivaManutenzioneByMacchina(long lCOD_MAC)
						</description>
				  <comment date="29/01/2004" author="Mike Kondratyuk">
				   <description>Peredelal na FindEX()</description>
				  </comment> 
      </comments> 
    </version>
  </versions>
</file> 
*/
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
//public interface  IAttivaManutenzione extends EJBObject
public interface IAttivaManutenzione extends EJBObject 
{
	//   *require Fields*
	public long getCOD_MNT_MAC();
	
  public String getDES_ATI_MNT_MAC();
  public void setDES_ATI_MNT_MAC(String newDES_ATI_MNT_MAC);
//-----3
	public void setATI_MNT_PER(String newATI_MNT_PER);
  public String getATI_MNT_PER();
//-----4
	public void setCOD_MAC(long newCOD_MAC);
  public long getCOD_MAC();
//-----5  
	public void setPER_ATI_MNT_MES(long newPER_ATI_MNT_MES);
  public long getPER_ATI_MNT_MES();
//-----6   
	public void setDAT_PAR_MNT_MAC(java.sql.Date newDAT_PAR_MNT_MAC);
	public java.sql.Date getDAT_PAR_MNT_MAC();
}

//     Home Intrface EJB obiekta 
public interface IAttivaManutenzioneHome extends EJBHome
{
   public IAttivaManutenzione create(
    String DES_ATI_MNT_MAC,
		long COD_MAC
   ) throws RemoteException, CreateException;
   public void remove(Object primaryKey);
   public IAttivaManutenzione findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;
   public Collection findAll() throws RemoteException, FinderException;
   // opredelenie view metodov
   public Collection getAttivaManutenzione_UserID_View();
	 public Collection getAttivaManutenzione_TAB_View(long newCOD_MAC, long newCOD_MNT_MAC);

	public Collection getAttivaManutenzioneByMacchina(long lCOD_MAC);
	public Collection findEx(String		strDES_ATI_MNT_MAC,
  							Long		lCOD_MAC,
  							java.sql.Date	DAT_PAR_MNT_MAC,
  							Long		lPER_ATI_MNT_MES,
  							String		strATI_MNT_PER,
							int iOrderParameter /*not used for now*/);
}

/*public*/
// view metodi   

class AttivaManutenzione_UserID_View implements java.io.Serializable{
	public long COD_MNT_MAC;
	public long COD_MAC;
	public String  DES_ATI_MNT_MAC;
	//---- dobavlennye polia ----------------
	public String  strPER_ATI_MNT_MES;
	public String strATI_MNT_PER;
	public String strNB_ATI_MNT_PER;
	public java.sql.Date dtDAT_PAR_MNT_MAC;
	public String strDES_MAC;
	//--------------------------------------
}

class AttivaManutenzione_TAB_View implements java.io.Serializable{
	public long COD_SCH_ATI_MNT;
	public String ATI_SVO;
  public String ESI_ATI_MNT;
  public java.sql.Date DAT_ATI_MNT;
  public java.sql.Date DAT_PIF_INR;
}
%>
