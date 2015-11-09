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
<%@ page import="java.util.*"%>

<%!
public class AzioniCorrectivePreventiveBean extends BMPEntityBean implements IAzioniCorrectivePreventive, IAzioniCorrectivePreventiveHome
{
  //<member-varibles description="Member Variables">
	long lCOD_AZN_CRR_PET;
	long lCOD_INR_ADT;
	String strDES_AZN_RCH;
	String strRCH_AZN_CRR_PET;
	java.sql.Date dtDAT_RCH;
	String strTPL_ATT;
	String strMTZ_ATT;
	String strDES_AZN_CRR_PET;
	String strTPL_AZN;
	String strMTZ_AZN;
	java.sql.Date dtDAT_AZN;
	long lCOD_AZL;
  //</member-varibles>

 //<IAzioniCorrectivePreventiveHome-implementation>
      public static final String BEAN_NAME="AzioniCorrectivePreventiveBean";
      public AzioniCorrectivePreventiveBean(){}

      public void remove(Object primaryKey){
            AzioniCorrectivePreventiveBean bean=new AzioniCorrectivePreventiveBean();
            try{
              Object obj=bean.ejbFindByPrimaryKey((Long)primaryKey);
              bean.setEntityContext(new EntityContextWrapper(obj));
              bean.ejbActivate();
              bean.ejbLoad();
              bean.ejbRemove();
            }
            catch(Exception ex){
            	ex.printStackTrace(System.err);
              throw new EJBException(ex.getMessage());
            }
      }
//-----------------------------------------------------------------------------------------------
      public IAzioniCorrectivePreventive create(String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, long lCOD_AZL) throws javax.ejb.CreateException
			{
         	AzioniCorrectivePreventiveBean bean=new AzioniCorrectivePreventiveBean();
             try{
			  Object primaryKey=bean.ejbCreate(strDES_AZN_RCH, strRCH_AZN_CRR_PET, dtDAT_RCH, lCOD_AZL);
              bean.setEntityContext(new EntityContextWrapper(primaryKey));
              bean.ejbPostCreate(strDES_AZN_RCH, strRCH_AZN_CRR_PET, dtDAT_RCH, lCOD_AZL);
              return bean;
            }
            catch(Exception ex){
            	ex.printStackTrace(System.err);
              throw new javax.ejb.CreateException(ex.getMessage());
            }
      }
//-------------------------------------------------------------------------------
      public IAzioniCorrectivePreventive findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException{
      AzioniCorrectivePreventiveBean bean=new AzioniCorrectivePreventiveBean();
			try{
					bean.setEntityContext(new EntityContextWrapper(primaryKey));
					bean.ejbActivate();
					bean.ejbLoad();
					return bean;
			}
           catch(Exception ex){
           	ex.printStackTrace(System.err);
              throw new javax.ejb.FinderException(ex.getMessage());
            }
      }
//------------------------------------------------------------------
      public Collection findAll() throws javax.ejb.FinderException {
			try{
				return this.ejbFindAll();
			}
			catch(Exception ex){
				ex.printStackTrace(System.err);
				throw new javax.ejb.FinderException(ex.getMessage());
			}
      }
 //
//------------------------------------------------------------------
   //<VIEWS>
    public Collection getDocumentByAZN_CRR_ID_View(long COD_AZN_CRR_PET)
    {
    	return (new  AzioniCorrectivePreventiveBean()).ejbGetDocumentByAZN_CRR_ID_View(COD_AZN_CRR_PET);
    }
	//-----------------------------------------------------------------
    public Collection getAzioniCorrectivePreventive_AZL_View(long lCOD_AZL)
    {
    	return (new  AzioniCorrectivePreventiveBean()).ejbGetAzioniCorrectivePreventive_AZL_View(lCOD_AZL);
    }
	public Collection getAzioniCorrectivePreventive_View()
    {
    	return (new  AzioniCorrectivePreventiveBean()).ejbGetAzioniCorrectivePreventive_View();
    }
   	public Collection findEx_AZL(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH,String strTPL_ATT,String strDES_AZN_CRR_PET,String strTPL_AZN,java.sql.Date dtDAT_AZN, int iOrderParameter /*not used for now*/)    
	{		
    	return (new  AzioniCorrectivePreventiveBean()). ejbFindEx_AZL(lCOD_AZL,lCOD_INR_ADT,strDES_AZN_RCH,strRCH_AZN_CRR_PET,dtDAT_RCH,strTPL_ATT,strDES_AZN_CRR_PET,strTPL_AZN,dtDAT_AZN,iOrderParameter /*not used for now*/);
	}
	public Collection findEx(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH, int iOrderParameter /*not used for now*/)
	{
	  	return (new  AzioniCorrectivePreventiveBean()). ejbFindEx(lCOD_AZL,lCOD_INR_ADT,strDES_AZN_RCH,strRCH_AZN_CRR_PET,dtDAT_RCH,iOrderParameter);
	}
  //</VIEWS>


  public Long ejbCreate(String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, long lCOD_AZL)
  {
	this.lCOD_AZN_CRR_PET= NEW_ID();
	this.strDES_AZN_RCH=strDES_AZN_RCH;
	this.strRCH_AZN_CRR_PET=strRCH_AZN_CRR_PET;
	this.dtDAT_RCH=dtDAT_RCH;
	this.lCOD_AZL=lCOD_AZL;
	this.unsetModified();
	BMPConnection bmp=getConnection();
	try{
		PreparedStatement ps=bmp.prepareStatement(
		" INSERT INTO azn_crr_pet_tab "+
		" (cod_azn_crr_pet, des_azn_rch, rch_azn_crr_pet, dat_rch, cod_azl) "+
		" VALUES(?,?,?,?,?)"
		);
			ps.setLong	(1, this.lCOD_AZN_CRR_PET);
			ps.setString(2, this.strDES_AZN_RCH);
			ps.setString(3, this.strRCH_AZN_CRR_PET);
			ps.setDate	(4, this.dtDAT_RCH);
			ps.setLong	(5, this.lCOD_AZL);
			ps.executeUpdate();
		return new Long(this.lCOD_AZN_CRR_PET);
	}
	catch(Exception ex){
		ex.printStackTrace(System.err);
		throw new EJBException(ex);
	}
	finally{bmp.close();}
  }

  public void ejbPostCreate(String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, long lCOD_AZL) { }

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_azn_crr_pet FROM azn_crr_pet_tab");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
          }
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }

  public void ejbActivate(){
    this.lCOD_AZN_CRR_PET=((Long)this.getEntityKey()).longValue();
  }

  public void ejbPassivate(){
      this.lCOD_AZN_CRR_PET=-1;
  }

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT cod_azn_crr_pet,cod_inr_adt,des_azn_rch,rch_azn_crr_pet,dat_rch,tpl_att,mtz_att,des_azn_crr_pet,tpl_azn,mtz_azn,dat_azn,cod_azl FROM azn_crr_pet_tab WHERE cod_azn_crr_pet=?");
           ps.setLong(1, lCOD_AZN_CRR_PET);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              		lCOD_AZN_CRR_PET=rs.getLong(1);
			lCOD_INR_ADT=rs.getLong(2);
			strDES_AZN_RCH=rs.getString(3);
			strRCH_AZN_CRR_PET=rs.getString(4);
			dtDAT_RCH=rs.getDate(5);
			strTPL_ATT=rs.getString(6);
			strMTZ_ATT=rs.getString(7);
			strDES_AZN_CRR_PET=rs.getString(8);
			strTPL_AZN=rs.getString(9);
			strMTZ_AZN=rs.getString(10);
			dtDAT_AZN=rs.getDate(11);
			lCOD_AZL=rs.getLong(12);
           }
           else{
              throw new NoSuchEntityException("AzioniCorrectivePreventive with ID="+lCOD_AZN_CRR_PET+" not found");
           }
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM azn_crr_pet_tab WHERE cod_azn_crr_pet=?");
         ps.setLong(1, lCOD_AZN_CRR_PET);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("AzioniCorrectivePreventive with ID="+lCOD_AZN_CRR_PET+" not found");
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE azn_crr_pet_tab SET cod_azn_crr_pet=?, cod_inr_adt=?, des_azn_rch=?, rch_azn_crr_pet=?, dat_rch=?, tpl_att=?, mtz_att=?, des_azn_crr_pet=?, tpl_azn=?, mtz_azn=?, dat_azn=?, cod_azl=? WHERE cod_azn_crr_pet=?");
			ps.setLong(1, lCOD_AZN_CRR_PET);
			if(lCOD_INR_ADT==0) ps.setNull(2,java.sql.Types.BIGINT); else ps.setLong(2, lCOD_INR_ADT);
			ps.setString(3, strDES_AZN_RCH);
			ps.setString(4, strRCH_AZN_CRR_PET);
			ps.setDate(5, dtDAT_RCH);
			ps.setString(6, strTPL_ATT);
			ps.setString(7, strMTZ_ATT);
			ps.setString(8, strDES_AZN_CRR_PET);
			ps.setString(9, strTPL_AZN);
			ps.setString(10, strMTZ_AZN);
			ps.setDate(11, dtDAT_AZN);
			ps.setLong(12, lCOD_AZL);
			ps.setLong(13, lCOD_AZN_CRR_PET);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("AzioniCorrectivePreventive with ID="+lCOD_AZN_CRR_PET+" not found");
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//---------------------------------------------------------------------------------------------------

  //<setter-getters>

	public long getCOD_AZN_CRR_PET(){
		return lCOD_AZN_CRR_PET;
	}

	public long getCOD_INR_ADT(){
		return lCOD_INR_ADT;
	}
	public void setCOD_INR_ADT(long lCOD_INR_ADT){
		if(this.lCOD_INR_ADT==lCOD_INR_ADT) return;
		this.lCOD_INR_ADT=lCOD_INR_ADT;
		setModified();
	}

	public String getDES_AZN_RCH(){
		if(strDES_AZN_RCH==null) return "";
		return strDES_AZN_RCH;
	}
	public void setDES_AZN_RCH(String strDES_AZN_RCH){
		if(  (this.strDES_AZN_RCH!=null) && (this.strDES_AZN_RCH.equals(strDES_AZN_RCH))  ) return;
		this.strDES_AZN_RCH=strDES_AZN_RCH;
		setModified();
	}

	public String getRCH_AZN_CRR_PET(){
		if(strRCH_AZN_CRR_PET==null) return "";
		return strRCH_AZN_CRR_PET;
	}
	public void setRCH_AZN_CRR_PET(String strRCH_AZN_CRR_PET){
		if(  (this.strRCH_AZN_CRR_PET!=null) && (this.strRCH_AZN_CRR_PET.equals(strRCH_AZN_CRR_PET))  ) return;
		this.strRCH_AZN_CRR_PET=strRCH_AZN_CRR_PET;
		setModified();
	}

	public java.sql.Date getDAT_RCH(){
		return dtDAT_RCH;
	}
	public void setDAT_RCH(java.sql.Date dtDAT_RCH){
		if(this.dtDAT_RCH==dtDAT_RCH) return;
		this.dtDAT_RCH=dtDAT_RCH;
		setModified();
	}

	public String getTPL_ATT(){
		if(strTPL_ATT==null) return "";
		return strTPL_ATT;
	}
	public void setTPL_ATT(String strTPL_ATT){
		if(  (this.strTPL_ATT!=null) && (this.strTPL_ATT.equals(strTPL_ATT))  ) return;
		this.strTPL_ATT=strTPL_ATT;
		setModified();
	}

	public String getMTZ_ATT(){
		if(strMTZ_ATT==null) return "";
		return strMTZ_ATT;
	}
	public void setMTZ_ATT(String strMTZ_ATT){
		if(  (this.strMTZ_ATT!=null) && (this.strMTZ_ATT.equals(strMTZ_ATT))  ) return;
		this.strMTZ_ATT=strMTZ_ATT;
		setModified();
	}

	public String getDES_AZN_CRR_PET(){
		if(strDES_AZN_CRR_PET==null) return "";
		return strDES_AZN_CRR_PET;
	}
	public void setDES_AZN_CRR_PET(String strDES_AZN_CRR_PET){
		if(  (this.strDES_AZN_CRR_PET!=null) && (this.strDES_AZN_CRR_PET.equals(strDES_AZN_CRR_PET))  ) return;
		this.strDES_AZN_CRR_PET=strDES_AZN_CRR_PET;
		setModified();
	}

	public String getTPL_AZN(){
		if(strTPL_AZN==null) return "";
		return strTPL_AZN;
	}
	public void setTPL_AZN(String strTPL_AZN){
		if(  (this.strTPL_AZN!=null) && (this.strTPL_AZN.equals(strTPL_AZN))  ) return;
		this.strTPL_AZN=strTPL_AZN;
		setModified();
	}

	public String getMTZ_AZN(){
		if(strMTZ_AZN==null) return "";
		return strMTZ_AZN;
	}
	public void setMTZ_AZN(String strMTZ_AZN){
		if(  (this.strMTZ_AZN!=null) && (this.strMTZ_AZN.equals(strMTZ_AZN))  ) return;
		this.strMTZ_AZN=strMTZ_AZN;
		setModified();
	}

	public java.sql.Date getDAT_AZN(){
		return dtDAT_AZN;
	}
	public void setDAT_AZN(java.sql.Date dtDAT_AZN){
		if(this.dtDAT_AZN==dtDAT_AZN) return;
		this.dtDAT_AZN=dtDAT_AZN;
		setModified();
	}

	public long getCOD_AZL(){
		return lCOD_AZL;
	}
	public void setCOD_AZL(long lCOD_AZL){
		if(this.lCOD_AZL==lCOD_AZL) return;
		this.lCOD_AZL=lCOD_AZL;
		setModified();
	}
  //</setter-getters>


  //<views>
   public Collection ejbGetDocumentByAZN_CRR_ID_View(long COD_AZN_CRR_PET){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT dacpt.cod_azn_crr_pet, dacpt.cod_doc, adt.tit_doc, adt.rsp_doc, adt.dat_rev_doc FROM doc_azn_crr_pet_tab dacpt, ana_doc_tab adt WHERE dacpt.cod_doc=adt.cod_doc AND dacpt.cod_azn_crr_pet=? ");
          ps.setLong(1, COD_AZN_CRR_PET);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DocumentByAZN_CRR_ID_View obj=new DocumentByAZN_CRR_ID_View();
            obj.COD_AZN_CRR_PET=rs.getLong(1);
            obj.COD_DOC=rs.getLong(2);
            obj.TIT_DOC=rs.getString(3);
            obj.RSP_DOC=rs.getString(4);
            obj.DAT_REV_DOC=rs.getDate(5);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  //</views>
    public void addDOC_GEST_AZN_CRR_PET(long lCOD_DOC){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO doc_azn_crr_pet_tab (cod_doc,cod_azn_crr_pet) VALUES(?,?)");
         ps.setLong   (1, lCOD_DOC);
		 ps.setLong   (2, lCOD_AZN_CRR_PET);
         ps.executeUpdate();
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
	public void removeDOC_GEST_AZN_CRR_PET(String strCOD_DOC){
		BMPConnection bmp=getConnection();
		try {
			PreparedStatement ps=bmp.prepareStatement("DELETE FROM doc_azn_crr_pet_tab  WHERE cod_doc=? AND cod_azn_crr_pet=?");
			ps.setString (1, strCOD_DOC);
			ps.setLong   (2, lCOD_AZN_CRR_PET);
			ps.executeUpdate();
		}
		catch(Exception ex) {
			ex.printStackTrace(System.err);
		  throw new EJBException(ex);
		}
		finally{bmp.close();}
	}
//-------------------------------------------------------------------
   public Collection ejbGetAzioniCorrectivePreventive_AZL_View(long lCOD_AZL){
      BMPConnection bmp=getConnection();
      try{
      //  PreparedStatement ps=bmp.prepareStatement("SELECT cod_azn_crr_pet, des_azn_rch, dat_rch FROM azn_crr_pet_tab WHERE cod_azl = ? ORDER BY des_azn_rch ");
  		PreparedStatement ps=bmp.prepareStatement
                (SQLContainer.getEjbGetAzioniCorrectivePreventive_AZL_View());
          ps.setLong(1, lCOD_AZL);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
          AzioniCorrectivePreventive_View obj=new AzioniCorrectivePreventive_View();
          obj.COD_AZN_CRR_PET=rs.getLong(1);
					obj.RCH_AZN_CRR_PET=rs.getString(2);
					obj.TPL_ATT=rs.getString(3);
					obj.TPL_AZN=rs.getString(4);
					obj.DES_INR_ADT=rs.getString(5);
					obj.DAT_RCH=rs.getDate(6);
					obj.DAT_AZN=rs.getDate(7);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
	 
   public Collection ejbFindEx_AZL(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH,String strTPL_ATT,String strDES_AZN_CRR_PET,String strTPL_AZN,java.sql.Date dtDAT_AZN, int iOrderParameter ){
      BMPConnection bmp=getConnection();
//			String strSQL="SELECT cod_azn_crr_pet, des_azn_rch, dat_rch FROM azn_crr_pet_tab WHERE cod_azl = ? ";
			String strSQL = SQLContainer.getEjbGetAzioniCorrectivePreventive_AZL_View();
/*			if (lCOD_INR_ADT!=null)
				 {
				 strSQL+=" AND azn_crr_pet_tab.cod_inr_adt= ?";
				 }
*/
			if (strDES_AZN_RCH!=null)
				 {
	 				 strSQL+=" AND UPPER(des_azn_rch) LIKE ?";
				 }
			if (strRCH_AZN_CRR_PET!=null)
				 {
 	 				 strSQL+=" AND  UPPER(rch_azn_crr_pet) LIKE ?";
				 }
			if (dtDAT_RCH!=null)
				 {
 				 strSQL+=" AND dat_rch= ?";
				 }
			if (strTPL_ATT!=null)
				 {
  				 strSQL+=" AND UPPER(tpl_att) LIKE ?";
				 }
			if (strDES_AZN_CRR_PET!=null)
				 {
 	 				 strSQL+=" AND UPPER(des_azn_crr_pet) LIKE ?";
				 }
			if (strTPL_AZN!=null)
				 {
	 				 strSQL+=" AND UPPER(tpl_azn) LIKE ?";
				 }
			if (dtDAT_AZN!=null)
				 {
	 				 strSQL+=" AND dat_azn= ?";
		 		 }
			strSQL+=" ORDER BY UPPER(azn_crr_pet_tab.rch_azn_crr_pet), azn_crr_pet_tab.dat_rch";
			int i=1;
      try{
		  		PreparedStatement ps=bmp.prepareStatement(strSQL);
          ps.setLong(i++, lCOD_AZL);
/*					if (lCOD_INR_ADT!=null)
						 {
				 		 	ps.setLong(i++,lCOD_INR_ADT.longValue());
				 		}
*/
					if (strDES_AZN_RCH!=null)
				 		 {
	 				 	 ps.setString(i++,strDES_AZN_RCH.toUpperCase());
				 		 }
					if (strRCH_AZN_CRR_PET!=null)
				 		 {
	 				 	 ps.setString(i++,strRCH_AZN_CRR_PET.toUpperCase());
				 		 }
					if (dtDAT_RCH!=null)
				 		 {
	 				 	 ps.setDate(i++,dtDAT_RCH);
				 		 }
					if (strTPL_ATT!=null)
				 		 {
	 				 	 ps.setString(i++,strTPL_ATT.toUpperCase());
				 		 }
					if (strDES_AZN_CRR_PET!=null)
				 		 {
	 				 	 ps.setString(i++,strDES_AZN_CRR_PET.toUpperCase());
				 		 }
					if (strTPL_AZN!=null)
				 		 {
	 				 	 ps.setString(i++,strTPL_AZN.toUpperCase());
				 		 }
					if (dtDAT_AZN!=null)
				 		 {
	 				 	 ps.setDate(i++,dtDAT_AZN);
				 		 }

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
          AzioniCorrectivePreventive_View obj=new AzioniCorrectivePreventive_View();
          obj.COD_AZN_CRR_PET=rs.getLong(1);
					obj.RCH_AZN_CRR_PET=rs.getString(2);
					obj.TPL_ATT=rs.getString(3);
					obj.TPL_AZN=rs.getString(4);
					obj.DES_INR_ADT=rs.getString(5);
					obj.DAT_RCH=rs.getDate(6);
					obj.DAT_AZN=rs.getDate(7);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
        throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

	  public Collection ejbGetAzioniCorrectivePreventive_View(){
      BMPConnection bmp=getConnection();
      try{
  //      PreparedStatement ps=bmp.prepareStatement("SELECT cod_azn_crr_pet, des_azn_rch, dat_rch FROM azn_crr_pet_tab WHERE cod_azl = ? ORDER BY des_azn_rch ");
		  		PreparedStatement ps=bmp.prepareStatement
                        (SQLContainer.getEjbGetAzioniCorrectivePreventive_View());
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
          AzioniCorrectivePreventive_View obj=new AzioniCorrectivePreventive_View();
          obj.COD_AZN_CRR_PET=rs.getLong(1);
					obj.RCH_AZN_CRR_PET=rs.getString(2);
					obj.TPL_ATT=rs.getString(3);
					obj.TPL_AZN=rs.getString(4);
					obj.DES_INR_ADT=rs.getString(5);
					obj.DAT_RCH=rs.getDate(6);
					obj.DAT_AZN=rs.getDate(7);
          al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
        throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

	  public Collection ejbFindEx(long lCOD_AZL,Long lCOD_INR_ADT,String strDES_AZN_RCH,String strRCH_AZN_CRR_PET,java.sql.Date dtDAT_RCH, int iOrderParameter /*not used for now*/){
			String strSQL = SQLContainer.getEjbGetAzioniCorrectivePreventive_View();
/*			if (lCOD_INR_ADT!=null)
				 {
				 strSQL+=" AND azn_crr_pet_tab.cod_inr_adt= ?";
				 }
*/
			if (strDES_AZN_RCH!=null)
				 {
	 				 strSQL+=" AND UPPER(des_azn_rch) LIKE ?";
				 }
			if (strRCH_AZN_CRR_PET!=null)
				 {
 	 				 strSQL+=" AND  UPPER(rch_azn_crr_pet) LIKE ?";
				 }
			if (dtDAT_RCH!=null)
				 {
 				 strSQL+=" AND dat_rch= ?";
				 }

			strSQL+=" ORDER BY azn_crr_pet_tab.rch_azn_crr_pet	,azn_crr_pet_tab.dat_rch";
			int i=1;

      BMPConnection bmp=getConnection();
      try{
//        PreparedStatement ps=bmp.prepareStatement("SELECT cod_azn_crr_pet, des_azn_rch, dat_rch FROM azn_crr_pet_tab WHERE cod_azl = ? ORDER BY des_azn_rch ");
		  		PreparedStatement ps=bmp.prepareStatement(strSQL);
					//ps.setLong(i++,lCOD_AZL);
/*					if (lCOD_INR_ADT!=null)
						 {
				 		 	ps.setLong(i++,lCOD_INR_ADT.longValue());
				 		}
*/
					if (strDES_AZN_RCH!=null)
				 		 {
	 				 	 ps.setString(i++,strDES_AZN_RCH);
				 		 }
					if (strRCH_AZN_CRR_PET!=null)
				 		 {
	 				 	 ps.setString(i++,strRCH_AZN_CRR_PET);
				 		 }
					if (dtDAT_RCH!=null)
				 		 {
	 				 	 ps.setDate(i++,dtDAT_RCH);
				 		 }

          ResultSet rs=ps.executeQuery();
          
		  java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
          AzioniCorrectivePreventive_View obj=new AzioniCorrectivePreventive_View();
          obj.COD_AZN_CRR_PET=rs.getLong(1);
					obj.RCH_AZN_CRR_PET=rs.getString(2);
					obj.TPL_ATT=rs.getString(3);
					obj.TPL_AZN=rs.getString(4);
					obj.DES_INR_ADT=rs.getString(5);
					obj.DAT_RCH=rs.getDate(6);
					obj.DAT_AZN=rs.getDate(7);
          al.add(obj);
          }
		  bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
	
//-----------------------------------------------------------------------
	public String getInterventiAuditDesc(){
		String result="";
		if(this.lCOD_INR_ADT==0){
		 	return result;
		}else{

			BMPConnection bmp=getConnection();
      		try{
          		PreparedStatement ps=bmp.prepareStatement(
				"SELECT des_inr_adt FROM ana_inr_adt_tab WHERE cod_inr_adt = ? "
				);
          		ps.setLong(1, this.lCOD_INR_ADT);
          		ResultSet rs=ps.executeQuery();
				rs.next();
				result=rs.getString(1);
          		bmp.close();
      			}
      			catch(Exception ex){
      				ex.printStackTrace(System.err);
          			throw new EJBException(ex);
      			}
     			finally{bmp.close();}
				return result;
		}
	}
//-----------------------------------------------------------------------
	public Collection getDocumenti_List_View(){
	 BMPConnection bmp=getConnection();
      try{
        PreparedStatement ps=bmp.prepareStatement(
		"SELECT cod_doc FROM doc_azn_crr_pet_tab WHERE cod_azn_crr_pet = ? "
		);
          ps.setLong(1, lCOD_AZN_CRR_PET);
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            AZN_Documenti_List_View obj=new AZN_Documenti_List_View();
            obj.COD_DOC=rs.getLong(1);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
      	ex.printStackTrace(System.err);
          throw new EJBException(ex);
      }
     finally{bmp.close();}
	}
	//=========================================

}
%>
<%
//////////////////////////////////////////  ///////////////////////////////////////////////////////
PseudoContext.bind(AzioniCorrectivePreventiveBean.BEAN_NAME, new AzioniCorrectivePreventiveBean());
//////////////////////////////////////////  ///////////////////////////////////////////////////////
%>
