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
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class DipendentePrecedentiBean extends BMPEntityBean implements IDipendentePrecedenti, IDipendentePrecedentiHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  String RAG_SCL_DIT_PRC;
  long COD_DPD;
  long COD_AZL;
  long COD_DIT_PRC_DPD;
	
	String DES_ATI_SVO_DIT_PRC;
	String IDZ_DIT_PRC;
	String NUM_CIC_DIT_PRC;
	String CIT_DIT_PRC;
	String PRV_DIT_PRC;
	String CAP_DIT_PRC;
	String STA_DIT_PRC;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
private DipendentePrecedentiBean()
  {
	//System.err.println("DipendentePrecedentiBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDipendentePrecedenti create(String strRAG_SCL_DIT_PRC,long lCOD_DPD,long lCOD_AZL) throws CreateException
  {
 	 DipendentePrecedentiBean bean =  new  DipendentePrecedentiBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strRAG_SCL_DIT_PRC,lCOD_DPD,lCOD_AZL);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strRAG_SCL_DIT_PRC,lCOD_DPD,lCOD_AZL);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	DipendentePrecedentiBean iDipendentePrecedentiBean=new  DipendentePrecedentiBean();
    try
	{
    	Object obj=iDipendentePrecedentiBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDipendentePrecedentiBean.setEntityContext(new EntityContextWrapper(obj));
        iDipendentePrecedentiBean.ejbActivate();
        iDipendentePrecedentiBean.ejbLoad();
        iDipendentePrecedentiBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDipendentePrecedenti findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DipendentePrecedentiBean bean =  new  DipendentePrecedentiBean();
	try
	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS  getDipendentePrecedenti_Tipology_Number_View()
  public Collection getDipendentePrecedenti_Tipology_Number_View(long lCOD_DPD)
  {
  	return (new  DipendentePrecedentiBean()).ejbGetDipendentePrecedenti_Tipology_Number_View(lCOD_DPD);
 }
  
  public Collection getDipendenteAziende_Precedenti_View(String strCOD_FIS_DPD, long lCOD_DPD, long lCOD_AZL)
  {
      return (new  DipendentePrecedentiBean()).ejbGetDipendenteAziende_Precedenti_View(strCOD_FIS_DPD, lCOD_DPD, lCOD_AZL);
 }
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IDipendentePrecedentiHome-implementation>
  public Long ejbCreate(String strRAG_SCL_DIT_PRC,long lCOD_DPD,long lCOD_AZL)
  {
    this.RAG_SCL_DIT_PRC=strRAG_SCL_DIT_PRC;
    this.COD_DPD=lCOD_DPD;
		this.COD_AZL=lCOD_AZL;
    this.COD_DIT_PRC_DPD=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO dit_prc_dpd_tab (cod_dit_prc_dpd,rag_scl_dit_prc, cod_dpd, cod_azl) VALUES(?,?,?,?)");
         ps.setLong   (1, COD_DIT_PRC_DPD);
         ps.setString (2, RAG_SCL_DIT_PRC);
         ps.setLong (3, COD_DPD);
         ps.setLong (4, COD_AZL);
         ps.executeUpdate();
         return new Long(COD_DIT_PRC_DPD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strRAG_SCL_DIT_PRC,long lCOD_DPD,long lCOD_AZL) { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dit_prc_dpd FROM dit_prc_dpd_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

//-----------------------------------------------------------
  	
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_DIT_PRC_DPD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_DIT_PRC_DPD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM dit_prc_dpd_tab  WHERE cod_dit_prc_dpd=?");
           ps.setLong (1, COD_DIT_PRC_DPD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            this.RAG_SCL_DIT_PRC=rs.getString("RAG_SCL_DIT_PRC");
  			   	this.DES_ATI_SVO_DIT_PRC=rs.getString("DES_ATI_SVO_DIT_PRC");
						this.IDZ_DIT_PRC=rs.getString("IDZ_DIT_PRC");
						this.NUM_CIC_DIT_PRC=rs.getString("NUM_CIC_DIT_PRC");
						this.CIT_DIT_PRC=rs.getString("CIT_DIT_PRC");
						this.PRV_DIT_PRC=rs.getString("PRV_DIT_PRC");
						this.CAP_DIT_PRC=rs.getString("CAP_DIT_PRC");
						this.STA_DIT_PRC=rs.getString("STA_DIT_PRC");
    		 		this.COD_DPD=rs.getLong("COD_DPD");
	  				this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("DipendentePrecedenti con ID="+COD_DIT_PRC_DPD+" non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM dit_prc_dpd_tab  WHERE cod_dit_prc_dpd=?");
          ps.setLong (1, COD_DIT_PRC_DPD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendentePrecedenti con ID="+COD_DIT_PRC_DPD+" non è trovata");
      }
      catch(Exception ex)
	  {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }  
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE dit_prc_dpd_tab  SET rag_scl_dit_prc=?, des_ati_svo_dit_prc=?, idz_dit_prc=?, num_cic_dit_prc=?, cit_dit_prc=?, prv_dit_prc=?, cap_dit_prc=?, sta_dit_prc=?, cod_dpd=?,cod_azl=? WHERE cod_dit_prc_dpd=?");
          ps.setString(1, RAG_SCL_DIT_PRC);
          ps.setString(2, DES_ATI_SVO_DIT_PRC);
					ps.setString(3, IDZ_DIT_PRC);
					ps.setString(4, NUM_CIC_DIT_PRC);
					ps.setString(5, CIT_DIT_PRC);
					ps.setString(6, PRV_DIT_PRC);
					ps.setString(7, CAP_DIT_PRC);
					ps.setString(8, STA_DIT_PRC);
          ps.setLong  (9, COD_DPD);
          ps.setLong  (10, COD_AZL);	
		  		ps.setLong  (11, COD_DIT_PRC_DPD);

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendentePrecedenti con ID="+COD_DIT_PRC_DPD+" non &egrave trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">  
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">  
	//1
		public long getCOD_DIT_PRC_DPD(){
      return COD_DIT_PRC_DPD;
    }
	//2
  	/* public void setRAG_SCL_DIT_PRC(String newRAG_SCL_DIT_PRC){
      if( RAG_SCL_DIT_PRC.equals(newRAG_SCL_DIT_PRC) ) return;
      RAG_SCL_DIT_PRC = newRAG_SCL_DIT_PRC;
      setModified();
    }*/
    public String getRAG_SCL_DIT_PRC(){
      return RAG_SCL_DIT_PRC;
    }
	//3
    /*public void setCOD_DPD(long newCOD_DPD){
      if( COD_DPD == newCOD_DPD ) return;
      COD_DPD = newCOD_DPD;
	  	setModified();
    }*/
    public long getCOD_DPD(){
      return COD_DPD;
    }
		
		public void setRAG_SCL_DIT_PRC__COD_DPD(String newRAG_SCL_DIT_PRC, long newCOD_DPD){
		  if( (RAG_SCL_DIT_PRC.equals(newRAG_SCL_DIT_PRC)) &&  ( COD_DPD == newCOD_DPD )) return;
			RAG_SCL_DIT_PRC = newRAG_SCL_DIT_PRC;
			COD_DPD = newCOD_DPD;
	  	setModified();
		}
	//4
	  public void setCOD_AZL(long newCOD_AZL){
      if( COD_AZL == newCOD_AZL ) return;
      COD_AZL = newCOD_AZL;
      setModified();
    }
    public long getCOD_AZL(){
      return COD_AZL;
    }
//**not required fields
		//5
	  public void setDES_ATI_SVO_DIT_PRC(String newDES_ATI_SVO_DIT_PRC){
      if(DES_ATI_SVO_DIT_PRC != null) if( DES_ATI_SVO_DIT_PRC.equals(newDES_ATI_SVO_DIT_PRC) ) return;
      DES_ATI_SVO_DIT_PRC = newDES_ATI_SVO_DIT_PRC;
      setModified();
    }
    public String getDES_ATI_SVO_DIT_PRC(){
      return DES_ATI_SVO_DIT_PRC;
    }
		//6
	  public void setIDZ_DIT_PRC(String newIDZ_DIT_PRC){
      if(IDZ_DIT_PRC != null) if( IDZ_DIT_PRC.equals(newIDZ_DIT_PRC) ) return;
      IDZ_DIT_PRC = newIDZ_DIT_PRC;
      setModified();
    }
    public String getIDZ_DIT_PRC(){
      return IDZ_DIT_PRC;
    }
		//7
	  public void setNUM_CIC_DIT_PRC(String newNUM_CIC_DIT_PRC){
      if(NUM_CIC_DIT_PRC!= null) if( NUM_CIC_DIT_PRC.equals(newNUM_CIC_DIT_PRC) ) return;
      NUM_CIC_DIT_PRC = newNUM_CIC_DIT_PRC;
      setModified();
    }
    public String getNUM_CIC_DIT_PRC(){
      return NUM_CIC_DIT_PRC;
    }
		//8
	  public void setCIT_DIT_PRC(String newCIT_DIT_PRC){
      if( CIT_DIT_PRC!= null) if( CIT_DIT_PRC.equals(newCIT_DIT_PRC) ) return;
      CIT_DIT_PRC = newCIT_DIT_PRC;
      setModified();
    }
    public String getCIT_DIT_PRC(){
      return CIT_DIT_PRC;
    }
		//9
	  public void setPRV_DIT_PRC(String newPRV_DIT_PRC){
      if( PRV_DIT_PRC!= null) if( PRV_DIT_PRC.equals(newPRV_DIT_PRC) ) return;
      PRV_DIT_PRC = newPRV_DIT_PRC;
      setModified();
    }
    public String getPRV_DIT_PRC(){
      return PRV_DIT_PRC;
    }
		//10
	  public void setCAP_DIT_PRC(String newCAP_DIT_PRC){
      if( CAP_DIT_PRC!= null) if( CAP_DIT_PRC.equals(newCAP_DIT_PRC) ) return;
      CAP_DIT_PRC = newCAP_DIT_PRC;
      setModified();
    }
    public String getCAP_DIT_PRC(){
      return CAP_DIT_PRC;
    }
		//11
	  public void setSTA_DIT_PRC(String newSTA_DIT_PRC){
      if(STA_DIT_PRC!= null) if( STA_DIT_PRC.equals(newSTA_DIT_PRC) ) return;
      STA_DIT_PRC = newSTA_DIT_PRC;
      setModified();
    }
    public String getSTA_DIT_PRC(){
      return STA_DIT_PRC;
    }
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetDipendentePrecedenti_Tipology_Number_View(long lCOD_DPD){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dit_prc_dpd,rag_scl_dit_prc,des_ati_svo_dit_prc,cod_dpd,cod_azl FROM dit_prc_dpd_tab WHERE cod_dpd=? order by rag_scl_dit_prc");
		  ps.setLong(1, lCOD_DPD);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendentePrecedenti_Tipology_Number_View obj=new DipendentePrecedenti_Tipology_Number_View();
            obj.COD_DIT_PRC_DPD=rs.getLong(1);
            obj.RAG_SCL_DIT_PRC=rs.getString(2);
            obj.DES_ATI_SVO_DIT_PRC=rs.getString(3);
            obj.COD_DPD=rs.getLong(4);
            obj.COD_AZL=rs.getLong(5);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
  
   public Collection ejbGetDipendenteAziende_Precedenti_View(String strCOD_FIS_DPD, long lCOD_DPD, long lCOD_AZL){
        BMPConnection bmp=getConnection();
        try{
            PreparedStatement ps=bmp.prepareStatement(
                "select " +
                "   distinct a.cod_dpd, a.mtr_dpd, a.cod_azl, b.rag_scl_azl " +
                "from " +
                "   ana_dpd_tab a, ana_azl_tab b " +
                "where " +
                "   a.cod_azl = b.cod_azl " +
                "   and a.cod_fis_dpd = ? " +
                "   and a.cod_dpd < ? " +
                "   and a.cod_azl < ? " +
                "order by " +
                "   a.cod_dpd, b.rag_scl_azl");
                
            ps.setString(1, strCOD_FIS_DPD);
            ps.setLong(2, lCOD_DPD);
            ps.setLong(3, lCOD_AZL);

            ResultSet rs=ps.executeQuery();
            java.util.ArrayList al=new java.util.ArrayList();
            while(rs.next()){
                DipendentePrecedenti_Tipology_Number_View obj=new DipendentePrecedenti_Tipology_Number_View();
                obj.RAG_SCL_DIT_PRC=rs.getString(4);
                obj.COD_DPD=rs.getLong(1);
                obj.COD_AZL=rs.getLong(3);
                obj.AZL_PRE=true;
                al.add(obj);
            }
            bmp.close();
            return al;
        }
        catch(Exception ex){
            throw new EJBException(ex);
        }
        finally{bmp.close();}
  }

  //-------------------
  //</comment>         

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  DipendentePrecedentiBean"/>
%>

<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DipendentePrecedentiBean", new DipendentePrecedentiBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
