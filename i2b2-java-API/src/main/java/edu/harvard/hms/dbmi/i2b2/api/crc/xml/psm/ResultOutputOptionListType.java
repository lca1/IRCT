/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package edu.harvard.hms.dbmi.i2b2.api.crc.xml.psm;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for result_output_optionListType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="result_output_optionListType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="result_output" type="{http://www.i2b2.org/xsd/cell/crc/psm/1.1/}result_output_optionType" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "result_output_optionListType", propOrder = {
    "resultOutput"
})
public class ResultOutputOptionListType {

    @XmlElement(name = "result_output")
    protected List<ResultOutputOptionType> resultOutput;

    /**
     * Gets the value of the resultOutput property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the resultOutput property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getResultOutput().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ResultOutputOptionType }
     * 
     * 
     */
    public List<ResultOutputOptionType> getResultOutput() {
        if (resultOutput == null) {
            resultOutput = new ArrayList<ResultOutputOptionType>();
        }
        return this.resultOutput;
    }

}
