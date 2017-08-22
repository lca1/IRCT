/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package edu.harvard.hms.dbmi.i2b2.api.crc.xml.loader;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for processing_idType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="processing_idType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="processing_id">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;enumeration value="D"/>
 *               &lt;enumeration value="P"/>
 *               &lt;enumeration value="T"/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *         &lt;element name="processing_mode">
 *           &lt;simpleType>
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string">
 *               &lt;enumeration value="A"/>
 *               &lt;enumeration value="R"/>
 *               &lt;enumeration value="I"/>
 *               &lt;enumeration value=""/>
 *             &lt;/restriction>
 *           &lt;/simpleType>
 *         &lt;/element>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "processing_idType", namespace = "http://www.i2b2.org/xsd/hive/msg/1.1/", propOrder = {
    "processingId",
    "processingMode"
})
public class ProcessingIdType {

    @XmlElement(name = "processing_id", required = true)
    protected String processingId;
    @XmlElement(name = "processing_mode", required = true)
    protected String processingMode;

    /**
     * Gets the value of the processingId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessingId() {
        return processingId;
    }

    /**
     * Sets the value of the processingId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessingId(String value) {
        this.processingId = value;
    }

    /**
     * Gets the value of the processingMode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessingMode() {
        return processingMode;
    }

    /**
     * Sets the value of the processingMode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessingMode(String value) {
        this.processingMode = value;
    }

}