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

package s2s.utils;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */

public class Formatter{

        private static String html_encode(String s){
                return org.webmacro.util.HTMLEscaper1.escape(s);
        }

        public static String format(boolean b){
                return html_encode(s2s.utils.plain.Formatter.format(b));
        }

        public static String format(char c){
                return html_encode( s2s.utils.plain.Formatter.format(c));
        }

        public static String format(double d){
                return html_encode(s2s.utils.plain.Formatter.format(d));
        }

        public static String format(float f){
                return html_encode(s2s.utils.plain.Formatter.format(f));
        }

        public static String format(int i){
                return html_encode(s2s.utils.plain.Formatter.format(i));
        }

        public static String format(short s){
                return html_encode(s2s.utils.plain.Formatter.format(s));
        }

        public static String format(long l){
                return html_encode(s2s.utils.plain.Formatter.format(l));
        }

        public static String format(java.util.Date dt){
                return html_encode(s2s.utils.plain.Formatter.format(dt));
        }

        public static String format(Object obj){
                return html_encode(s2s.utils.plain.Formatter.format(obj));
        }

        public static String format(String s){
                return html_encode(s2s.utils.plain.Formatter.format(s));
        }
       public static String formatYYYYMMDD(java.util.Date dt){
                return html_encode(s2s.utils.plain.Formatter.formatYYYYMMDD(dt));
        }

}
