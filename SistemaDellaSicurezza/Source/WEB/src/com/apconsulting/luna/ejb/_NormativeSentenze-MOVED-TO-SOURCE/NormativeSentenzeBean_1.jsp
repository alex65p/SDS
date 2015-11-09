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

public class NormativeSentenzeBean extends BMPEntityBean implements INormativeSentenze, INormativeSentenzeHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
	long COD_NOR_SEN;
	String TIT_NOR_SEN;
	String DES_NOR_SEN;
	java.sql.Date DAT_NOR_SEN;
	long COD_ORN;
	long COD_SET;
	long COD_TPL_NOR_SEN;
	long COD_SOT_SET;
  //-----------------------------
	String NUM_DOC_NOR_SEN;
	String FON_NOR_SEN;
  //-----------------------------
	// Link Table DOC_NOR_SEN_TAB
    long newCOD_DOC;
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
 private NormativeSentenzeBean()
  {
	//System.err.println("NormativeSentenzeBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public INormativeSentenze create(
        String TIT_NOR_SEN,
  		String DES_NOR_SEN,
  		java.sql.Date DAT_NOR_SEN,
  		long COD_ORN,
  		long COD_SET,
  		long COD_TPL_NOR_SEN,
  		long COD_SOT_SET
   ) throws CreateException
  {
 	 NormativeSentenzeBean bean =  new  NormativeSentenzeBean();
	 try{
	 Object primaryKey=bean.ejbCreate(TIT_NOR_SEN, DES_NOR_SEN, DAT_NOR_SEN, COD_ORN, COD_SET, COD_TPL_NOR_SEN, COD_SOT_SET);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(TIT_NOR_SEN, DES_NOR_SEN, DAT_NOR_SEN, COD_ORN, COD_SET, COD_TPL_NOR_SEN, COD_SOT_SET);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	NormativeSentenzeBean iNormativeSentenzeBean=new  NormativeSentenzeBean();
    try
	{
    	Object obj=iNormativeSentenzeBean.ejbFindByPrimaryKey((Long)primaryKey);
        iNormativeSentenzeBean.setEntityContext(new EntityContextWrapper(obj));
        iNormativeSentenzeBean.ejbActivate();
        iNormativeSentenzeBean.ejbLoad();
        iNormativeSentenzeBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public INormativeSentenze findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	NormativeSentenzeBean bean =  new  NormativeSentenzeBean();
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


  // (Home Intrface) VIEWS  getNormativeSentenze_List_View()
  public Collection getNormativeSentenze_List_View()
  {
  	return (new  NormativeSentenzeBean()).ejbGetNormativeSentenze_List_View();
 }

  // (Home Intrface) VIEWS  getNormativeSentenzeDocumenteByDOCID_View()
  public Collection getNormativeSentenzeDocumenteByDOCID_View(long COD_NOR_SEN)
  {
  	return (new  NormativeSentenzeBean()).ejbGetNormativeSentenzeDocumenteByDOCID_View(COD_NOR_SEN);
 }


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</INormativeSentenzeHome-implementation>
  public Long ejbCreate(
        String TIT_NOR_SEN,
  		String DES_NOR_SEN,
  		java.sql.Date DAT_NOR_SEN,
  		long COD_ORN,
  		long COD_SET,
  		long COD_TPL_NOR_SEN,
  		long COD_SOT_SET)
  {
    this.TIT_NOR_SEN=TIT_NOR_SEN;
    this.DES_NOR_SEN=DES_NOR_SEN;
    this.DAT_NOR_SEN=DAT_NOR_SEN;
    this.COD_ORN=COD_ORN;
    this.COD_SET=COD_SET;
    this.COD_TPL_NOR_SEN=COD_TPL_NOR_SEN;
    this.COD_SOT_SET=COD_SOT_SET;
    this.COD_NOR_SEN=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_nor_sen_tab (cod_nor_sen,tit_nor_sen,des_nor_sen,dat_nor_sen,cod_orn,cod_set,cod_tpl_nor_sen,cod_sot_set) VALUES(?,?,?,?,?,?,?,?)");

         ps.setLong   (1, COD_NOR_SEN);
         ps.setString (2, TIT_NOR_SEN);
         ps.setString (3, DES_NOR_SEN);
         ps.setDate   (4, DAT_NOR_SEN);
         ps.setLong   (5, COD_ORN);
         ps.setLong   (6, COD_SET);
         ps.setLong   (7, COD_TPL_NOR_SEN);
         ps.setLong   (8, COD_SOT_SET);

         ps.executeUpdate();
         return new Long(COD_NOR_SEN);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(
        String TIT_NOR_SEN,
  		String DES_NOR_SEN,
  		java.sql.Date DAT_NOR_SEN,
  		long COD_ORN,
  		long COD_SET,
  		long COD_TPL_NOR_SEN,
  		long COD_SOT_SET) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_nor_sen FROM ana_nor_sen_tab ");
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
    this.COD_NOR_SEN=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_NOR_SEN=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_nor_sen_tab  WHERE cod_nor_sen=?");
           ps.setLong (1, COD_NOR_SEN);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){

            this.TIT_NOR_SEN=rs.getString("TIT_NOR_SEN");
            this.DES_NOR_SEN=rs.getString("DES_NOR_SEN");
            this.DAT_NOR_SEN=rs.getDate("DAT_NOR_SEN");
            this.COD_ORN=rs.getLong("COD_ORN");
            this.COD_SET=rs.getLong("COD_SET");
            this.COD_TPL_NOR_SEN=rs.getLong("COD_TPL_NOR_SEN");;
            this.COD_SOT_SET=rs.getLong("COD_SOT_SET");;
            this.NUM_DOC_NOR_SEN=rs.getString("NUM_DOC_NOR_SEN");
            this.FON_NOR_SEN=rs.getString("FON_NOR_SEN");

           }
           else{
              throw new NoSuchEntityException("NormativeSentenze con ID="+COD_NOR_SEN+" non &egrave trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_nor_sen_tab  WHERE cod_nor_sen=?");
          ps.setLong (1, COD_NOR_SEN);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("NormativeSentenze con ID="+COD_NOR_SEN+" non &egrave trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_nor_sen_tab  SET tit_nor_sen=?, des_nor_sen=?, dat_nor_sen=?, cod_orn=?, cod_set=?, cod_tpl_nor_sen=?, cod_sot_set=?, num_doc_nor_sen=?, fon_nor_sen=? WHERE cod_nor_sen=?");

          ps.setString(1, TIT_NOR_SEN);
          ps.setString(2, DES_NOR_SEN);
          ps.setDate  (3, DAT_NOR_SEN);
		  ps.setLong  (4, COD_ORN);
		  ps.setLong  (5, COD_SET);
		  ps.setLong  (6, COD_TPL_NOR_SEN);
		  ps.setLong  (7, COD_SOT_SET);
          ps.setString(8, NUM_DOC_NOR_SEN);
		  ps.setString(9, FON_NOR_SEN);
		  ps.setLong  (10, COD_NOR_SEN);

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("NormativeSentenze con ID="+COD_NOR_SEN+" non &egrave trovata");
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
	public long getCOD_NOR_SEN(){
      return COD_NOR_SEN;
    }
	//2
  	 public void setTIT_NOR_SEN(String newTIT_NOR_SEN){
      if(TIT_NOR_SEN!=null) if( TIT_NOR_SEN.equals(newTIT_NOR_SEN) ) return;
      TIT_NOR_SEN = newTIT_NOR_SEN;
      setModified();
    }
    public String getTIT_NOR_SEN(){
      return (TIT_NOR_SEN!=null)?TIT_NOR_SEN:"";
    }
	//3
  	 public void setDES_NOR_SEN(String newDES_NOR_SEN){
      if(DES_NOR_SEN!=null) if( DES_NOR_SEN.equals(newDES_NOR_SEN) ) return;
      DES_NOR_SEN = newDES_NOR_SEN;
      setModified();
    }
    public String getDES_NOR_SEN(){
      return (DES_NOR_SEN!=null)?DES_NOR_SEN:"";
    }
    //4
    public void setDAT_NOR_SEN(java.sql.Date dtDAT_NOR_SEN){
		if(DAT_NOR_SEN==dtDAT_NOR_SEN) return;
		DAT_NOR_SEN=dtDAT_NOR_SEN;
		setModified();
	}

	public java.sql.Date getDAT_NOR_SEN(){
		return DAT_NOR_SEN;
	}
    //5
	public void setCOD_ORN(long newCOD_ORN){
		if( COD_ORN == newCOD_ORN ) return;
		COD_ORN = newCOD_ORN;
		setModified();
	}
	public long getCOD_ORN(){
		return COD_ORN;
	}
    //6
	public void setCOD_SET(long newCOD_SET){
		if( COD_SET == newCOD_SET ) return;
		COD_SET = newCOD_SET;
		setModified();
	}
	public long getCOD_SET(){
		return COD_SET;
	}
    //7
	public void setCOD_TPL_NOR_SEN(long newCOD_TPL_NOR_SEN){
		if( COD_TPL_NOR_SEN == newCOD_TPL_NOR_SEN ) return;
		COD_TPL_NOR_SEN = newCOD_TPL_NOR_SEN;
		setModified();
	}
	public long getCOD_TPL_NOR_SEN(){
		return COD_TPL_NOR_SEN;
	}
    //8
	public void setCOD_SOT_SET(long newCOD_SOT_SET){
		if( COD_SOT_SET == newCOD_SOT_SET ) return;
		COD_SOT_SET = newCOD_SOT_SET;
		setModified();
	}
	public long getCOD_SOT_SET(){
		return COD_SOT_SET;
	}
    //-----------------------------

	//9
  	 public void setNUM_DOC_NOR_SEN(String newNUM_DOC_NOR_SEN){
      if(NUM_DOC_NOR_SEN!=null) if( NUM_DOC_NOR_SEN.equals(newNUM_DOC_NOR_SEN) ) return;
      NUM_DOC_NOR_SEN = newNUM_DOC_NOR_SEN;
      setModified();
    }
    public String getNUM_DOC_NOR_SEN(){
      return (NUM_DOC_NOR_SEN!=null)?NUM_DOC_NOR_SEN:"";
    }
	//10
  	 public void setFON_NOR_SEN(String newFON_NOR_SEN){
      if(FON_NOR_SEN!=null) if( FON_NOR_SEN.equals(newFON_NOR_SEN) ) return;
      FON_NOR_SEN = newFON_NOR_SEN;
      setModified();
    }
    public String getFON_NOR_SEN(){
      return (FON_NOR_SEN!=null)?FON_NOR_SEN:"";
    }

    //-----------------------------#############################################
    // %%%Link%%% Table DOC_NOR_SEN_TAB
    public void addCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO doc_nor_sen_tab (cod_nor_sen,cod_doc) VALUES(?,?)");

           ps.setLong   (1, COD_NOR_SEN);
           ps.setLong	(2, newCOD_DOC);

           ps.executeUpdate();
           //return new Long(COD_NOR_SEN);
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
    // %%%UNLink%%% Table DOC_NOR_SEN_TAB
    public void removeCOD_DOC(long newCOD_DOC){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM doc_nor_sen_tab WHERE cod_nor_sen=? AND cod_doc=?");
         ps.setLong (1, COD_NOR_SEN);
         ps.setLong (2, newCOD_DOC);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Documento con ID="+newCOD_DOC+" non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}
    //-----------------------------#############################################

   //</comment>

   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetNormativeSentenze_List_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_nor_sen,tit_nor_sen,num_doc_nor_sen,dat_nor_sen FROM ana_nor_sen_tab ORDER BY dat_nor_sen,tit_nor_sen,num_doc_nor_sen ");

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            NormativeSentenze_List_View obj=new NormativeSentenze_List_View();
            obj.COD_NOR_SEN=rs.getLong(1);
            obj.TIT_NOR_SEN=rs.getString(2);
						obj.NUM_DOC_NOR_SEN=rs.getString(3);
						obj.DAT_NOR_SEN=rs.getDate(4);
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

   public Collection ejbGetNormativeSentenzeDocumenteByDOCID_View(long COD_NOR_SEN){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT dnst.cod_nor_sen, dnst.cod_doc, adt.tit_doc, adt.rsp_doc, adt.dat_rev_doc FROM doc_nor_sen_tab dnst, ana_doc_tab adt WHERE dnst.cod_doc=adt.cod_doc AND dnst.cod_nor_sen=? order by adt.tit_doc");
					ps.setLong(1, COD_NOR_SEN);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            NormativeSentenzeDocumenteByDOCID_View obj=new NormativeSentenzeDocumenteByDOCID_View();
            obj.COD_NOR_SEN=rs.getLong(1);
            obj.COD_DOC    =rs.getLong(2);
            obj.TIT_DOC    =rs.getString(3);
            obj.RSP_DOC    =rs.getString(4);
            obj.DAT_REV_DOC=rs.getDate(5);
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

  public  Collection findEx(
  		String TIT_NOR_SEN,
		String DES_NOR_SEN,
		java.sql.Date DAT_NOR_SEN,
		Long COD_ORN,
		Long COD_SET,
		Long COD_TPL_NOR_SEN,
		Long COD_SOT_SET,
		String NUM_DOC_NOR_SEN,
		String FON_NOR_SEN,
		int iOrderBy)
  {
  		return  ejbFindEx( TIT_NOR_SEN, DES_NOR_SEN, DAT_NOR_SEN, COD_ORN, COD_SET, COD_TPL_NOR_SEN,
		COD_SOT_SET, NUM_DOC_NOR_SEN, FON_NOR_SEN, iOrderBy);
  }
  
  public Collection ejbFindEx(
		String TIT_NOR_SEN,
		String DES_NOR_SEN,
		java.sql.Date DAT_NOR_SEN,
		Long COD_ORN,
		Long COD_SET,
		Long COD_TPL_NOR_SEN,
		Long COD_SOT_SET,
		String NUM_DOC_NOR_SEN,
		String FON_NOR_SEN,
		int iOrderBy
	)
	{
	SearchHelper hlp= new SearchHelper("SELECT cod_nor_sen,tit_nor_sen,num_doc_nor_sen,dat_nor_sen FROM ana_nor_sen_tab ");
		hlp.addW(TIT_NOR_SEN, "ana_nor_sen_tab.TIT_NOR_SEN");
		hlp.addW(DES_NOR_SEN, "ana_nor_sen_tab.DES_NOR_SEN");
		hlp.addW(DAT_NOR_SEN, "ana_nor_sen_tab.DAT_NOR_SEN");
		
		hlp.addW(COD_ORN, "ana_nor_sen_tab.COD_ORN");
		hlp.addW(COD_SET, "ana_nor_sen_tab.COD_SET");
		
		hlp.addW(COD_TPL_NOR_SEN, "ana_nor_sen_tab.COD_TPL_NOR_SEN");
		hlp.addW(COD_SOT_SET, "ana_nor_sen_tab.COD_SOT_SET");
		hlp.addW(NUM_DOC_NOR_SEN, "ana_nor_sen_tab.NUM_DOC_NOR_SEN");
		hlp.addW(FON_NOR_SEN, "ana_nor_sen_tab.FON_NOR_SEN");
		
	 hlp.orderBy(iOrderBy);
	 
	  BMPConnection bmp=getConnection();
	  try{
	          PreparedStatement ps=bmp.prepareStatement(hlp.toString());
			  hlp.startBind(ps, 1);
			  {
			  	hlp.bind(TIT_NOR_SEN);
			  	hlp.bind(DES_NOR_SEN);
				hlp.bind(DAT_NOR_SEN);
			  	hlp.bind(COD_ORN);
			  	hlp.bind(COD_SET);
			  	hlp.bind(COD_TPL_NOR_SEN);
			  	hlp.bind(COD_SOT_SET);
			  	hlp.bind(NUM_DOC_NOR_SEN);
			  	hlp.bind(FON_NOR_SEN);		
			  }
			  ResultSet rs=ps.executeQuery();
	          java.util.ArrayList al=new java.util.ArrayList();
	          while(rs.next()){
		            NormativeSentenze_List_View obj=new NormativeSentenze_List_View();
		            obj.COD_NOR_SEN=rs.getLong(1);
		            obj.TIT_NOR_SEN=rs.getString(2);
								obj.NUM_DOC_NOR_SEN=rs.getString(3);
								obj.DAT_NOR_SEN=rs.getDate(4);
		            al.add(obj);
	          }
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
}//<comment description="end of implementation  NormativeSentenzeBean"/>
%>

<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("NormativeSentenzeBean", new NormativeSentenzeBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
