/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

package s2s.luna.util.combobuilder;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */

import java.util.*;
import s2s.utils.Formatter;


public class ComboBuilder{
        IComboParser m_parser;
        java.util.Collection m_col;
        public String strName;
        public String strStyle;
        long m_lSelectedIndex;
        String m_strSelectedIndex;
        public String strExtra;
        int iSize=1;
        boolean bShowBlanck=true;
        boolean bMultiple =false;
        boolean bOnlyText=false;
        public long tabIndex =1;
        public ComboBuilder( long lSelectedIndex, IComboParser parser, Collection col){
                m_parser=parser;
                m_col=col;
                m_lSelectedIndex=lSelectedIndex;
        }

        public ComboBuilder( String  strSelectedIndex, IComboParser parser, Collection col){
                m_parser=parser;
                m_col=col;
                m_strSelectedIndex=strSelectedIndex;
                bOnlyText=true;
        }


        public String build( ){
                        StringBuffer str=new StringBuffer();
                        ComboItem item = new ComboItem();
                        str.append("<SELECT name=\""+strName+"\" size='"+iSize+"' style='"+strStyle+"' tabindex='"+tabIndex+"' "+strExtra+" ");
                        str.append(bMultiple?"multiple":"");
                        str.append(">\n");
                        if(bShowBlanck) str.append("<OPTION></OPTION>");

                        if(m_col!=null){//------------------------------------------------------------------
                                java.util.Iterator  it = m_col.iterator();
                                while(it.hasNext()){
                                        m_parser.parse(it.next(), item);
                                        str.append("<OPTION ");
                                        if(bOnlyText){
                                                if(m_strSelectedIndex.equals(item.strValue)) str.append(" selected ");
                                        }
                                        else{
                                                if(m_lSelectedIndex==item.lIndex) str.append(" selected ");
                                                str.append("value=\""+item.lIndex+"\"");
                                        }
                                        //if(item.strIndex!=null)
                                        str.append(">");
                                        str.append(Formatter.format(item.strValue));
                                        str.append("</OPTION>");
                                }
                        }//--------------------------------------------------------------------------------

                        str.append("</SELECT>");
                        return str.toString();
        }

        public String buildEx(){
                        StringBuffer str=new StringBuffer();
                        java.util.Iterator  it = m_col.iterator();
                        ComboItem item = new ComboItem();

                        str.append(bMultiple?"multiple":"");
                        str.append(">\n");
                        if(bShowBlanck) str.append("<OPTION></OPTION>");
                        while(it.hasNext()){

                                m_parser.parse(it.next(), item);
                                str.append("<OPTION ");
                                if(m_lSelectedIndex==item.lIndex) str.append(" selected ");
                                //if(item.strIndex!=null)
                                str.append("value=\""+item.lIndex+"\"");
                                str.append(">");
                                str.append(Formatter.format(item.strValue));
                                str.append("</OPTION>");
                        }
                        str.append("</SELECT>");
                        return str.toString();
        }


}
