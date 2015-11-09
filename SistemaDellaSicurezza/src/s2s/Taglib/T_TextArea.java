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

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package s2s.Taglib;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 *
 * @author Dario
 */
public class T_TextArea extends BodyTagSupport {
    
    // Obbligatori
    private int cols = 0;
    private int rows = 0;
    
    // Facoltativi
    private String name = "";
    private int tabindex = 0;
    private String style = "";
    private boolean disabled = false;
    private boolean readonly = false;
    
    // Nuovi (non presenti nell'oggetto html textarea standard)
    private long maxlength = 0;
    
    /** 
     * Creates new instance of tag handler 
     */
    public T_TextArea() {
        super();
    }

    ////////////////////////////////////////////////////////////////
    ///                                                          ///
    ///   User methods.                                          ///
    ///                                                          ///
    ///   Modify these methods to customize your tag handler.    ///
    ///                                                          ///
    ////////////////////////////////////////////////////////////////
    /**
     * Method called from doStartTag().
     * Fill in this method to perform other operations from doStartTag().
     *
     */
    private void otherDoStartTagOperations() {
    //
    // TODO: code that performs other operations in doStartTag
    //       should be placed here.
    //       It will be called after initializing variables, 
    //       finding the parent, setting IDREFs, etc, and 
    //       before calling theBodyShouldBeEvaluated(). 
    //
    //       For example, to print something out to the JSP, use the following:
    //
    //   try {
    //       JspWriter out = pageContext.getOut();
    //       out.println("something");
    //   } catch (IOException ex) {
    //       // do something
    //   }
    //
    //
    }

    /**
     * Method called from doEndTag()
     * Fill in this method to perform other operations from doEndTag().
     *
     */
    private void otherDoEndTagOperations() {
    //
    // TODO: code that performs other operations in doEndTag
    //       should be placed here.
    //       It will be called after initializing variables,
    //       finding the parent, setting IDREFs, etc, and
    //       before calling shouldEvaluateRestOfPageAfterEndTag().
    //
    }

    /**
     * Fill in this method to process the body content of the tag.
     * You only need to do this if the tag's BodyContent property
     * is set to "JSP" or "tagdependent."
     * If the tag's bodyContent is set to "empty," then this method
     * will not be called.
     */
    private void writeTagBodyContent(JspWriter out, BodyContent bodyContent) throws IOException {
        //
        // TODO: insert code to write html before writing the body content.
        // e.g.:
        //
        // out.println("<strong>" + attribute_1 + "</strong>");
        // out.println("   <blockquote>");

        //
        // write the body content (after processing by the JSP engine) on the output Writer
        //
        bodyContent.writeOut(out);

        //
        // Or else get the body content as a string and process it, e.g.:
        //     String bodyStr = bodyContent.getString();
        //     String result = yourProcessingMethod(bodyStr);
        //     out.println(result);
        //

        // TODO: insert code to write html after writing the body content.
        // e.g.:
        //
        // out.println("   </blockquote>");


        // clear the body content for the next time through.
        bodyContent.clearBody();
    }

    ////////////////////////////////////////////////////////////////
    ///                                                          ///
    ///   Tag Handler interface methods.                         ///
    ///                                                          ///
    ///   Do not modify these methods; instead, modify the       ///
    ///   methods that they call.                                ///
    ///                                                          ///
    ////////////////////////////////////////////////////////////////
    /**
     * This method is called when the JSP engine encounters the start tag,
     * after the attributes are processed.
     * Scripting variables (if any) have their values set here.
     * @return EVAL_BODY_BUFFERED if the JSP engine should evaluate the tag body, otherwise return SKIP_BODY.
     * This method is automatically generated. Do not modify this method.
     * Instead, modify the methods that this method calls.
     */
    @Override
    public int doStartTag() throws JspException, JspException {
        otherDoStartTagOperations();
        
        try {
            JspWriter out = pageContext.getOut();
            
            // Definizione della tabella che conterrà 
            // - il campo data
            // - il pulsante di selezione della data tramite il calendario
            out.println("<textarea ");
            out.println("   id=\""+id+"\"");
            out.println("   cols=\""+cols+"\"");
            out.println("   rows=\""+rows+"\"");
            if (!this.name.trim().equals("")){
                out.println("   name=\""+name+"\"");
            }
            if (this.tabindex > -1 && this.tabindex < 32768){
                out.println("   tabindex=\""+tabindex+"\"");
            }
            if (!this.style.trim().equals("")){
                out.println("   style=\""+style+"\"");
            }
            if (this.disabled){
                out.println("               disabled");
            }
            if (this.readonly){
                out.println("               readonly");
            }
            if (this.maxlength > 0){
                out.println("   onkeypress=\"return checkMaxLength_onKeyPress(this, " + this.maxlength + ")\"");
                out.println("   onblur=\"return checkMaxlength_onBlur(this, " + this.maxlength + ")\"");
            }
            out.println(">");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (theBodyShouldBeEvaluated()) {
            return EVAL_BODY_BUFFERED;
        } else {
            return SKIP_BODY;
        }
    }

    /**
     * This method is called after the JSP engine finished processing the tag.
     * @return EVAL_PAGE if the JSP engine should continue evaluating the JSP page, otherwise return SKIP_PAGE.
     * This method is automatically generated. Do not modify this method.
     * Instead, modify the methods that this method calls.
     */
    @Override
    public int doEndTag() throws JspException, JspException {
        otherDoEndTagOperations();
        if (shouldEvaluateRestOfPageAfterEndTag()) {
            return EVAL_PAGE;
        } else {
            return SKIP_PAGE;
        }
    }

    /**
     * This method is called after the JSP engine processes the body content of the tag.
     * @return EVAL_BODY_AGAIN if the JSP engine should evaluate the tag body again, otherwise return SKIP_BODY.
     * This method is automatically generated. Do not modify this method.
     * Instead, modify the methods that this method calls.
     */
    @Override
    public int doAfterBody() throws JspException {
        try {
            //
            // This code is generated for tags whose bodyContent is "JSP"
            //
            JspWriter out = bodyContent.getEnclosingWriter();
            writeTagBodyContent(out, bodyContent);
            out.println("</textarea>");
        } catch (Exception ex) {
            handleBodyContentException(ex);
        }

        if (theBodyShouldBeEvaluatedAgain()) {
            return EVAL_BODY_AGAIN;
        } else {
            return SKIP_BODY;
        }
    }

    /**
     * Handles exception from processing the body content.
     */
    private void handleBodyContentException(Exception ex) throws JspException {
        // Since the doAfterBody method is guarded, place exception handing code here.
        throw new JspException("error in NewTag: " + ex);
    }

    /**
     * Fill in this method to determine if the rest of the JSP page
     * should be generated after this tag is finished.
     * Called from doEndTag().
     */
    private boolean shouldEvaluateRestOfPageAfterEndTag() {
        //
        // TODO: code that determines whether the rest of the page
        //       should be evaluated after the tag is processed
        //       should be placed here.
        //       Called from the doEndTag() method.
        //
        return true;
    }

    /**
     * Fill in this method to determine if the tag body should be evaluated
     * again after evaluating the body.
     * Use this method to create an iterating tag.
     * Called from doAfterBody().
     */
    private boolean theBodyShouldBeEvaluatedAgain() {
        //
        // TODO: code that determines whether the tag body should be
        //       evaluated again after processing the tag
        //       should be placed here.
        //       You can use this method to create iterating tags.
        //       Called from the doAfterBody() method.
        //
        return false;
    }

    private boolean theBodyShouldBeEvaluated() {
//
// TODO: code that determines whether the body should be
//       evaluated should be placed here.
//       Called from the doStartTag() method.
//
        return true;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setTabindex(int tabindex) {
        this.tabindex = tabindex;
    }
    
    public void setCols(int cols) {
        this.cols = cols;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }
    
    public void setMaxlength(long maxlength) {
        this.maxlength = maxlength;
    }
    
    public void setStyle(String style) {
        this.style = style;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    public void setReadonly(boolean readonly) {
        this.readonly = readonly;
    }
}
