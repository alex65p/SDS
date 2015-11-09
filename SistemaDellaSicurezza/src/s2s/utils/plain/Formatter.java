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

package s2s.utils.plain;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: AP Consulting</p>
 * @author Artur Denysenko
 * @version 1.0
 */
public class Formatter {

    public static String format(boolean b) {
        return Boolean.toString(b);
    }

    public static String format(char c) {
        return Character.toString(c);
    }

    public static String format(double d) {
        return Double.toString(d);
    }

    public static String format(float f) {
        return Float.toString(f);
    }

    public static String format(short s) {
        return Short.toString(s);
    }

    public static String format(int i) {
        return Integer.toString(i);
    }

    public static String format(long l) {
        return Long.toString(l);
    }

    public static String format(java.util.Date dt) {
        if (dt == null) {
            return "";
        }
        return new java.text.SimpleDateFormat("dd/MM/yyyy").format(dt);
    }

    public static String format(java.sql.Date dt) {
        if (dt == null) {
            return "";
        }
        return new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(dt.getTime()));
    }

    public static String format(Object obj) {
        if (obj == null) {
            return "";
        } else {
            return obj.toString();
        }
    }

    public static String format(String s) {
        if (s == null) {
            return "";
        }
        return s;
    }

    public static String format(String s, int n) {
        if (s == null) {
            return "";
        }
        if (s.length() <= n) {
            return s;
        }
        return s.substring(0, n);
    }
    public static String formatYYYYMMDD(java.util.Date dt) {
        if (dt == null) {
            return "";
        }
        return new java.text.SimpleDateFormat("yyyy/MM/dd").format(dt);
    }
}
