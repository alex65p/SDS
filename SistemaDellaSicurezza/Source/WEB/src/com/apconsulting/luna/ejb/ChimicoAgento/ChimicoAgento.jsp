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

//public class ChimicoAgentoBean extends BMPEntityBean implements IChimicoAgentoRemote
public class ChimicoAgentoBean extends BMPEntityBean implements IChimicoAgento, IChimicoAgentoHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
	long COD_SOS_CHI;   //1
	String DES_SOS;  	//2
	String NOM_COM_SOS; //3
	long COD_STA_FSC;   //4
	long COD_CLF_SOS;   //5
	long COD_PTA_FSC;
	String TIP_RSO="N";
//---------------
	String FRS_R; 		//6
	String FRS_S;     	//7
	String SIM_RIS;   	//8
	long COD_SIM;   	//9
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private ChimicoAgentoBean(){}
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IChimicoAgento create(String strDES_SOS,String strNOM_COM_SOS,String strFRS_R,long lCOD_STA_FSC,long lCOD_CLF_SOS,long lCOD_PTA_FSC, sTIP_RSO) throws CreateException
  {
 	 ChimicoAgentoBean bean =  new  ChimicoAgentoBean();
	 try{
	 Object primaryKey=bean.ejbCreate(strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(strDES_SOS, strNOM_COM_SOS, lCOD_STA_FSC, lCOD_CLF_SOS, lCOD_PTA_FSC, sTIP_RSO);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey) 
  {
  	ChimicoAgentoBean iChimicoAgentoBean=new  ChimicoAgentoBean();
    try{
    	Object obj=iChimicoAgentoBean.ejbFindByPrimaryKey((Long)primaryKey);
        iChimicoAgentoBean.setEntityContext(new EntityContextWrapper(obj));
        iChimicoAgentoBean.ejbActivate();
        iChimicoAgentoBean.ejbLoad();
        iChimicoAgentoBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex); 
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IChimicoAgento findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	ChimicoAgentoBean bean =  new  ChimicoAgentoBean();
	try{
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
  	try{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS  getChimicoAgento_Name_Desc_View()
  public Collection getChimicoAgento_Name_Desc_View()
  {
  	return (new  ChimicoAgentoBean()).ejbGetChimicoAgento_Name_Desc_View();
 }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IChimicoAgentoHome-implementation>
  public Long ejbCreate(String strDES_SOS,String strNOM_COM_SOS,long lCOD_STA_FSC,long lCOD_CLF_SOS,long lCOD_PTA_FSC, String sTIP_RSO)
  {
    this.DES_SOS=strDES_SOS;
    this.NOM_COM_SOS=strNOM_COM_SOS;
	this.COD_STA_FSC=lCOD_STA_FSC;
	this.COD_CLF_SOS=lCOD_CLF_SOS;
    this.COD_SOS_CHI=NEW_ID();
		this.COD_PTA_FSC=lCOD_PTA_FSC;
		this.TIP_RSO = sTIP_RSO;
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_sos_chi_tab (cod_sos_chi,des_sos, nom_com_sos, cod_sta_fsc, cod_clf_sos, cod_pta_fsc, tip_rso) VALUES(?,?,?,?,?,?,?)");
         ps.setLong   (1, COD_SOS_CHI);
         ps.setString (2, DES_SOS);
         ps.setString (3, NOM_COM_SOS);
         ps.setLong   (4, COD_STA_FSC);
         ps.setLong   (5, COD_CLF_SOS);
         ps.setLong   (6, COD_PTA_FSC);
         ps.setString (7, TIP_RSO);
         ps.executeUpdate();
         return new Long(COD_SOS_CHI);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String strDES_SOS,String strNOM_COM_SOS,long lCOD_STA_FSC,long lCOD_CLF_SOS,long lCOD_PTA_FSC, String sTIP_RSO) { 
  }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sos_chi FROM ana_sos_chi_tab ");
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
    this.COD_SOS_CHI=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_SOS_CHI=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_sos_chi_tab  WHERE cod_sos_chi=?");
           ps.setLong (1, COD_SOS_CHI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
               	this.DES_SOS=rs.getString("DES_SOS");
				this.NOM_COM_SOS=rs.getString("NOM_COM_SOS");
				this.FRS_R=rs.getString("FRS_R");
				this.FRS_S=rs.getString("FRS_S");
				this.SIM_RIS=rs.getString("SIM_RIS");
				this.COD_SIM=rs.getLong("COD_SIM");
				this.COD_STA_FSC=rs.getLong("COD_STA_FSC");
				this.COD_CLF_SOS=rs.getLong("COD_CLF_SOS");
				this.COD_PTA_FSC=rs.getLong("COD_PTA_FSC");
				this.TIP_RSO=rs.getString("TIP_RSO");
           }
           else{
              throw new NoSuchEntityException("ChimicoAgento con ID= non è trovato");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_sos_chi_tab  WHERE cod_sos_chi=?");
          ps.setLong (1, COD_SOS_CHI);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Agente Chimico con ID= non è trovato");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_sos_chi_tab  SET des_sos=?, nom_com_sos=?, frs_r=?,frs_s=?,sim_ris=?,cod_sim=?,cod_sta_fsc=?,cod_clf_sos=?,cod_pta_fsc=?,tip_rso=?	 WHERE cod_sos_chi=?");
				ps.setString(1, DES_SOS);
				ps.setString(2, NOM_COM_SOS);
				ps.setString(3, FRS_R);
				ps.setString(4, FRS_S);
				ps.setString(5, SIM_RIS);
		  		ps.setLong  (6, COD_SIM);
				ps.setLong  (7, COD_STA_FSC);
				ps.setLong  (8, COD_CLF_SOS);
				ps.setLong  (9, COD_PTA_FSC);
				ps.setString(10, TIP_RSO);
				ps.setLong  (11, COD_SOS_CHI);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("ChimicoAgento con ID= non è trovato");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">  
	//1
  	 public void setRAG_SCL_AZL(String newRAG_SCL_AZL){
      if( RAG_SCL_AZL.equals(newRAG_SCL_AZL) ) return;
      RAG_SCL_AZL = newRAG_SCL_AZL;
      setModified();
    }
    public String getRAG_SCL_AZL(){
      return RAG_SCL_AZL;
    }
	//2
	  public void setDES_ATI_SVO_AZL(String newDES_ATI_SVO_AZL){
      if( DES_ATI_SVO_AZL.equals(newDES_ATI_SVO_AZL) ) return;
      DES_ATI_SVO_AZL = newDES_ATI_SVO_AZL;
      setModified();
    }
    public String getDES_ATI_SVO_AZL(){
      return DES_ATI_SVO_AZL;
    }
	//3
	  public void setIDZ_AZL(String newIDZ_AZL){
      if( IDZ_AZL.equals(newIDZ_AZL) ) return;
      IDZ_AZL = newIDZ_AZL;
      setModified();
    }
    public String getIDZ_AZL(){
      return IDZ_AZL;
    }
	//4
	  public void setCIT_AZL(String newCIT_AZL){
      if( CIT_AZL.equals(newCIT_AZL) ) return;
      CIT_AZL = newCIT_AZL;
      setModified();
    }
    public String getCIT_AZL(){
      return CIT_AZL;
    }
	//5
	  public void setCOD_STA(long newCOD_STA){
      if( COD_STA == newCOD_STA ) return;
      COD_STA = newCOD_STA;
      setModified();
    }
    public long getCOD_STA(){
      return COD_STA;
    }
	//6
	public long getCOD_AZL(){
      return COD_AZL;
    }
	//============================================
	// not required field
	//7
  	public void setCAG_AZL(String newCAG_AZL){
      if(CAG_AZL!=null){
	  	if( CAG_AZL.equals(newCAG_AZL) ) return;
	  }
	  CAG_AZL = newCAG_AZL;
	  setModified();
    }
    public String getCAG_AZL(){
      return CAG_AZL;
    }
	//8
  	public void setCOD_IST_TAT_AZL(String newCOD_IST_TAT_AZL){
      if(COD_IST_TAT_AZL!=null){
      	if( COD_IST_TAT_AZL.equals(newCOD_IST_TAT_AZL) ) return;
      }
	  COD_IST_TAT_AZL = newCOD_IST_TAT_AZL;
	  setModified();
    }
    public String getCOD_IST_TAT_AZL(){
      return COD_IST_TAT_AZL;
    }
	//9
    public void setNUM_CIC_AZL(String newNUM_CIC_AZL){
      if(NUM_CIC_AZL!=null){
	      if( NUM_CIC_AZL.equals(newNUM_CIC_AZL) ) return;
      }
	  NUM_CIC_AZL = newNUM_CIC_AZL;
	  setModified();
    }
    public String getNUM_CIC_AZL(){
      return NUM_CIC_AZL;
    }
	//10
    public void setPRV_AZL(String newPRV_AZL){
      if(PRV_AZL!=null){
	      if( PRV_AZL.equals(newPRV_AZL) ) return;
      }
	  PRV_AZL = newPRV_AZL;
	  setModified();
    }
    public String getPRV_AZL(){
      return PRV_AZL;
    }
	//11
    public void setCAP_AZL(String newCAP_AZL){
      if(CAP_AZL!=null){
	      if( CAP_AZL.equals(newCAP_AZL) ) return;
      }
	  CAP_AZL = newCAP_AZL;
	  setModified();
    }
    public String getCAP_AZL(){
      return CAP_AZL;
    }
	//12
    public void setQLF_RSP_AZL(String newQLF_RSP_AZL){
      if(QLF_RSP_AZL!=null){
    	  if( QLF_RSP_AZL.equals(newQLF_RSP_AZL) ) return;
	  }
	  QLF_RSP_AZL = newQLF_RSP_AZL;
	  setModified();
    }
    public String getQLF_RSP_AZL(){
      return QLF_RSP_AZL;
    }
	//13
    public void setNOM_RSP_AZL(String newNOM_RSP_AZL){
      if(NOM_RSP_AZL!=null){
	      if( NOM_RSP_AZL.equals(newNOM_RSP_AZL) ) return;
      }
	  NOM_RSP_AZL = newNOM_RSP_AZL;
	  setModified();
    }
    public String getNOM_RSP_AZL(){
      return NOM_RSP_AZL;
    }
	//14
    public void setNOM_RSP_SPP_AZL(String newNOM_RSP_SPP_AZL){
      if(NOM_RSP_SPP_AZL!=null){
	      if( NOM_RSP_SPP_AZL.equals(newNOM_RSP_SPP_AZL) ) return;
      }
	  NOM_RSP_SPP_AZL = newNOM_RSP_SPP_AZL;
	  setModified();
    }
    public String getNOM_RSP_SPP_AZL(){
      return NOM_RSP_SPP_AZL;
    }
	//15
    public void setNOM_MED_AZL(String newNOM_MED_AZL){
      if(NOM_MED_AZL!=null){
	      if( NOM_MED_AZL.equals(newNOM_MED_AZL) ) return;
      }
	  NOM_MED_AZL = newNOM_MED_AZL;
	  setModified();
    }
    public String getNOM_MED_AZL(){
      return NOM_MED_AZL;
    }
	//16
    public void setCOD_AZL_ASC(long newCOD_AZL_ASC){
      if( COD_AZL_ASC == newCOD_AZL_ASC ) return;
      COD_AZL_ASC = newCOD_AZL_ASC;
	  setModified();
    }
    public long getCOD_AZL_ASC(){
      return COD_AZL_ASC;
    }
	//17
    public void setIDZ_PSA_ELT_RSP_AZL(String newIDZ_PSA_ELT_RSP_AZL){
      if(IDZ_PSA_ELT_RSP_AZL!=null){
	      if( IDZ_PSA_ELT_RSP_AZL.equals(newIDZ_PSA_ELT_RSP_AZL) ) return;
      }
	  IDZ_PSA_ELT_RSP_AZL = newIDZ_PSA_ELT_RSP_AZL;
	  setModified();
    }
    public String getIDZ_PSA_ELT_RSP_AZL(){
      return IDZ_PSA_ELT_RSP_AZL;
    }
	//18
    public void setSIT_INT_AZL(String newSIT_INT_AZL){
      if(SIT_INT_AZL!=null){
	      if( SIT_INT_AZL.equals(newSIT_INT_AZL) ) return;
      }
	  SIT_INT_AZL = newSIT_INT_AZL;
	  setModified();
    }
    public String getSIT_INT_AZL(){
      return SIT_INT_AZL;
    }
	
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetChimicoAgento_Name_Desc_View()
   {
     BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_azl,rag_scl_azl,idz_azl FROM ana_azl_tab ");
          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            ChimicoAgento_Name_Desc_View obj=new ChimicoAgento_Name_Desc_View();
            obj.COD_AZL=rs.getLong(1);
            obj.RAG_SCL_ACL=rs.getString(2);
            obj.IDZ_AZL=rs.getString(3);
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

///////////ATTENTION!!//////////////////////////////////////////////
}//<comment description="end of implementation  ChimicoAgentoBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////
PseudoContext.bind("ChimicoAgentoBean", new ChimicoAgentoBean());////////
////////////////////////////////////////// </BINDING>////////////////////
%>
