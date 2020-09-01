<?xml version="1.0"?>
<!--
   UniStyles - XSLT transforms for rendering UBL documents.
   Copyright (C) 2019-present, Unimaze ehf.

   render-order.xsl - render order of PEPPOL BIS EN16931 (UBL 2.1 format).

   Copyright (C) 2008-2019 Unimaze Software (www.unimaze.com)
   info[at]unimaze[dot]com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Order-2"
                exclude-result-prefixes="n1 cac cbc ext fn">
    <xsl:import href="../billing-3/CommonTemplates.xsl"/>
    <!-- <xsl:import href="../unimaze-common.xsl" /> -->
    <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>
    <xsl:param name="requestedContentFormat" />
    <xsl:template name="doc-head">
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
        <xsl:choose>
            <xsl:when test="$stylesheet_url = 'NONE'">
                <style>
                    <!-- GENERAL CSS -->
					* {
						box-sizing: border-box;
					}

					body {
						font-family: verdana, Helvetica, sans-serif;
						font-size: 76%;
                        margin: 0 !important;
                        padding: 0 !important;
					}

					p {
						margin: 0;
						padding: 0;
					}

                    .wrapper {
                        margin: 1em;
                    }

                    .container {
                        min-width:775px;
                        margin: 3em auto 0;
                    }

					.corner_title_center_content>h1 {
						padding: 0;
						margin: 0;
						font-size: 0.8em;
						font-weight: 700;
					}

					.corner_title_center_content>div {
						font-family: arial, verdana, Helvetica, sans-serif;
						text-align: center;
						line-height: 240%;
						font-size: 1.7em;
					}

					.green_box {
						border: 1px solid #8fb195;
						background-color: #ddebe0;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}

					.green_box_no_back {
						border: 1px solid #8fb195;
						padding: 0.5em;
					}

					.text_center {
						padding: 0.5em;
						text-align: center;
					}

					.text_right {
						text-align: right;
					}

                    .green_title {
                        color: #8fb195;
                        padding: 0.8em 0 0.4em 0.4em;
                        text-align: left;
                        font-size: 1.2em;
                        font-weight: bold;
                    }
                    
					.title {
						margin: 0.1em 0 0.6em 0;
						text-transform: capitalize;
						font-size: 0.9em;
					}
                    
                    .table_header {
                        font-weight: normal;
						background-color: #ddebe0;
                        padding: 0.5em;
                        border-bottom: 1px solid #8fb195;
                    } 

                    .table_body {
                        font-weight: normal;
                        padding: 0 0.5em;
                    } 

					.box_with_margin {
						margin: 1.2em 0 1.2em 1.2em;
					}

                    .box_with_top_margin {
                        margin-top: 0.3em;
                    }
                    <!-- /GENERAL CSS -->

                    .main_header .document_details {
						font-family: arial, verdana, Helvetica, sans-serif;
                        justify-self: flex-end;
                        align-self: flex-end;
                        text-align: right;
                    }

                    .main_header .document_details h1{
						margin: 0 0 .2em 0;
                        font-size: 1.6em;
                    }

                    .main_header .buyer {
                        align-items: flex-end;
                    }

                    .seller .green_box {
                        margin-bottom: 0;
                    }

                    .payment_info_holder {
                        display: flex;
                        flex-direction: column;
                    }

                    .payment_info_holder .green_box {
                        height: 80px;
                        margin-bottom: 0.3em;
                    }

                    .payable_amount {
                        font-weight: 700;
                    }

                    .document_info_currency {
                        text-align: right;
                        position: absolute;
                        right: 0;
                    }

                    .amount_payable {
                        position: relative;
                    }

                    .items_table .green_box_no_back {
                        padding:0;
                    }

                    .items_table .items_table_body_data_name_column_header {
                        width: 100%;
                        margin-bottom: 0.1em;
                    }

                    .items_table .items_table_body_data_name_column_body {
                        width: 150%;
                    }

                    .items_table .items_table_body_data:first-of-type {
                        height: 15px;
                    }

                    .items_table_header_title:nth-child(1),
                    .items_table_body_data:nth-child(1) {
                        width: 7%;
                    }
                    .items_table_header_title:nth-child(2),
                    .items_table_body_data:nth-child(2) {
                        width: 10%;
                    }
                    .items_table_header_title:nth-child(3),
                    .items_table_body_data:nth-child(3) {
                        width: 30%;
                    }
                    .items_table_header_title:nth-child(4),
                    .items_table_body_data:nth-child(4) {
                        width: 10%;
                    }
                    .items_table_header_title:nth-child(5),
                    .items_table_body_data:nth-child(5) {
                        width: 11%;
                    }
                    .items_table_header_title:nth-child(6),
                    .items_table_body_data:nth-child(6) {
                        width: 10%;
                    }
                    .items_table_header_title:nth-child(7),
                    .items_table_body_data:nth-child(7) {
                        width: 10%;
                    }
                    .items_table_header_title:nth-child(8),
                    .items_table_body_data:nth-child(8) {
                        width: 12%;
                    }

                    .items_table_body_holder {
                        padding: 0.3em 0.5em;
                    }

                    .items_table_body_holder:first-of-type {
                        padding-top: 0.6em;
                    }

                    .items_table_body_holder:last-of-type {
                        padding-bottom: 0.6em;
                    }

                    .num_of_lines {
                        margin-left: 15%;
                    }

                    .tax_amount .row {
                        padding-right: 25%;
                    }

                    .information_banner .green_box {
                        min-height:4em;
                    }

                    .information_banner .green_box .green_title {
                        font-size:1.5em;
                        margin:0;
                    }

                    .seller_information .seller_contact_label {
                        display: none;
                    }

					
                    @media print {
                        .container {
                            width:80em;
                        }

                        .hide_content_input:checked + .items_table_body_holder .items_table_body_data .expand_arrow,
                        .expand_arrow,
                        .collapse_expand_all_label {
                            transform: rotate(0);
                            display: none !important;
                        }
                        .items_table_body > .hide_content_input:checked + .items_table_body_holder .items_table_body_data .hide_content,
                        .items_table .hide_all_content_input:checked ~ .items_table_body .items_table_body_holder .items_table_body_data .hide_content {
                            min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                            overflow: hidden;
                            height: unset;
                            opacity: 1;
                        }

                        .items_table_body_data label {
                            top: 0 !important;
                        }    
                    }

                    <!-- LAYOUT -->
                    .row {
                        display: flex;
                        page-break-inside: avoid;
                        width: 100%;
                        justify-content: flex-start;
                        align-items: flex-start;
                        flex-direction: row;
                        align-items: stretch;
                        }

                    .col-10 {
                        width: 10%;
                        }

                    .col-25 {
                        width: 25%;
                        }

                    .col-30 {
                        width: 30%;
                        }
                        
                    .col-33 {
                        width: 33%;
                        }

                    .col-50 {
                        width: 50%;
                        }
                        
                    .col-66 {
                        width: 66%;
                        }

                    .col-75 {
                        width: 75%;
                        }
                    
                    .col-50.margin-right-big:only-child {
                        width: calc(50% - 1em)
                        }

                    .col-50.margin-right-small:only-child {
                        width: calc(50% - 0.5em)
                        }

                    .margin-right-big {
                        margin-right: 2em;
                        }

                    .margin-right-small {
                        margin-right: 1em;
                        }

                    .margin-right-big:last-of-type,
                    .margin-right-small:last-of-type {
                        margin-right: 0;
                        }

                    .align-center {
                        align-items: center;
                    }
                    <!-- /LAYOUT -->

                    <!-- HIDE-SHOW TABLE DETAILS -->
                    .items_table_body_data label,
                    .collapse_expand_all_label {
                        cursor:pointer;
                    }
                    .items_table_body_data label {
                        position: relative;
                        top: -1.2em;
                    }

                    .expand_arrow, .double_expand_arrow {
                        font-size: 2.2em;
                        font-weight: bold;
                        display: inline-block;
                        transition: all .3s;
                        transform: rotate(-90deg);
                        -webkit-transform: rotate(-90deg);
                        -moz-transform: rotate(-90deg);
                        -ms-transform: rotate(-90deg);
                        -o-transform: rotate(-90deg);
                        filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
                        margin-right:5px;
                        user-select: none;
                        position: relative;
                        top: 6px;
                    }

                    .double_expand_arrow {
                        padding: 3px 3px 3px 0;
                        box-sizing: content-box;
                        font-size: 2em;
                        left: -0.2em;
                        top: 0;
                    }

                    .hide_content_input:checked + .items_table_body_holder .items_table_body_data .expand_arrow,
                    .hide_all_content_input:checked + .items_table_header .items_table_header_title .collapse_expand_all_label .double_expand_arrow {
                        transition: all .3s;
                        transform: rotate(-180deg);
                        -webkit-transform: rotate(-180deg);
                        -moz-transform: rotate(-180deg);
                        -ms-transform: rotate(-180deg);
                        -o-transform: rotate(-180deg);
                    }

                    .hide_all_content_input:checked ~ .items_table_body .items_table_body_holder .items_table_body_data .expand_arrow {
                        cursor: default;
                        transition: all .3s;
                        opacity: 0;
                    }

                    .hide_content {
                        min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                        overflow: hidden;
                        transition: all 0.3s ease;
                    }

                    .hide_content_input, .hide_all_content_input {
                        display: none;
                    }           
                    
                    .items_table_body > .hide_content_input:checked + .items_table_body_holder .items_table_body_data .hide_content,
                    .items_table .hide_all_content_input:checked ~ .items_table_body .items_table_body_holder .items_table_body_data .hide_content {
                        min-height: 0;
                        height: 0;
                        opacity: 0;
                        display: block;
                        transition: all 0.3s ease;
                    }
                    
                    <!-- /HIDE-SHOW TABLE DETAILS -->
                </style>
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="{$stylesheet_url}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="n1:Order">
        <!-- Start HTML -->
        <html>
            <xsl:call-template name="doc-head" />
            <head>
                <link rel="Stylesheet" type="text/css" href="PEPPOL.css" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title>ORDER</title>
            </head>
            <body>
                <xsl:if test="$requestedContentFormat!='pdf'">
                    <!-- <xsl:call-template name="UnimazeHeader"/> -->
                </xsl:if>
                <div class="wrapper">
                    <div class="container">
                        <header class="main_header row">
                            <!-- Buyer  -->
                            <div class="buyer row col-50 margin-right-big">
                                <div class="col-50 margin-right-small">
                                    <p class="title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-7'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <p>
                                        <b>
                                            <xsl:call-template name="BuyerCustomerPartyName" />
                                        </b>
                                        <xsl:call-template name="BuyerCustomerPostalAddress" />
                                        <br/>
                                        <xsl:call-template name="BuyerCustomerPartyID" />
                                    </p>
                                </div>
                                <div class="contact col-50 margin-right-small">
                                    <xsl:choose>
                                        <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:Contact !=''">
                                            <br/>
                                            <small>
                                                <xsl:call-template name="BuyerCustomerPartyContact">
                                                    <xsl:with-param name="ShowLabel" select="'true'"/>
                                                </xsl:call-template>
                                            </small>
                                            <br/>
                                            <small>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-032'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>&#160;
                                                </b>
                                                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
                                            </small>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <br/>
                                            <span class="UBLElectronicMail">
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-032'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                                &#160;
                                                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
                                            </span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                            <!-- /Buyer  -->
                            <div class="document_details col-50 margin-right-big">
                                <br/>
                                <!-- DOCUMENT DETAILS -->
                                <xsl:if test="local-name(.)  = 'Order'">
                                    <h1>
                                        <xsl:call-template name="DocumentHeader">
                                            <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                        </xsl:call-template>&#160;
                                        
                                        <xsl:value-of select="cbc:ID" />
                                    </h1>
                                    <xsl:if test="cbc:OrderTypeCode !='220'">
                                        <b>
                                            <p>
                                                <xsl:call-template name="DocumentCode">
                                                    <xsl:with-param name="DCode" select="cbc:OrderTypeCode"/>
                                                </xsl:call-template>
                                            </p>
                                        </b>
                                    </xsl:if>
                                    <xsl:if test="((cac:OrderReference/cbc:ID !='') and (cac:OrderReference/cbc:ID != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-13'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                            <!-- Inserting Order reference number  -->
                                            <span>
                                                <xsl:value-of select="cac:OrderReference/cbc:ID"/>
                                            </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cbc:BuyerReference !='') and (cbc:BuyerReference != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-10'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                                <!-- Inserting Buyer Reference::  -->
                                                <span>
                                                    <xsl:value-of select="cbc:BuyerReference"/>
                                                </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cbc:SalesOrderID !='') and (cbc:SalesOrderID != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-14'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                                <!-- Inserting Sales Order Reference::  -->
                                                <span>
                                                    <xsl:value-of select="cbc:SalesOrderID"/>
                                                </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cbc:CustomerReference !='') and (cbc:CustomerReference != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-029'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                                <!-- Inserting Customer Reference::  -->
                                                <span>
                                                    <xsl:value-of select="cbc:CustomerReference"/>
                                                </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cbc:AccountingCost !='') and (cbc:AccountingCost != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-030'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                                <!-- Inserting Accounting Cost::  -->
                                                <span>
                                                    <xsl:value-of select="cbc:AccountingCost"/>
                                                </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cac:Contract/cbc:ID !='') and (cac:Contract/cbc:ID != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-12'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                                <!-- Inserting Quotation Document reference number  -->
                                                <span>
                                                    <xsl:value-of select="cac:Contract/cbc:ID"/>
                                                </span>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                    <xsl:if test="((cbc:Note !='') and (cbc:Note != 'Unknown'))">
                                        <small>
                                            <b>
                                                <xsl:value-of select="cbc:Note"/>
                                            </b>
                                            <br/>
                                        </small>
                                    </xsl:if>
                                </xsl:if>
                                <!-- /DOCUMENT DETAILS -->
                            </div>
                        </header>
                        <br/>
                        <br/>
                        <!-- invoicee_and_issue_date_holder -->
                        <div class="row">
                            <!-- INVOICEE -->
                            <!-- <div class="invoicee">
                                <xsl:if test="local-name(.)  = 'Order'">
                                    <div class="green_box">
                                        <p class="title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-7'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="box_with_margin">
                                            <b>
                                                <xsl:call-template name="BuyerCustomerPartyName" />
                                            </b>
                                            <xsl:call-template name="BuyerCustomerPostalAddress" />
                                            <br/>
                                            <xsl:call-template name="BuyerCustomerPartyID" />
                                        </div>
                                    </div>
                                </xsl:if>
                            </div> -->
                            <!-- /INVOICEE -->

                            <!-- SELLER -->
                            <div class="seller col-50 margin-right-big">
                                <xsl:if test="local-name(.)  = 'Order'">
                                    <div class="green_box">
                                        <p class="title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-4'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="box_with_margin">
                                            <p>
                                                <b>
                                                    <xsl:call-template name="SellerSupplierPartyName" />
                                                </b>
                                            </p>
                                            <xsl:call-template name="SellerSupplierPostalAddress" />
                                            <br/>
                                            <xsl:call-template name="SellerSupplierPartyLegalEntity" />
                                        </div>
                                    </div>
                                </xsl:if>
                            </div>
                            <!-- /SELLER -->

                            <xsl:if test="local-name(.) = 'Order'">
                                <div class="payment_info_holder col-50 margin-right-big">
                                    <div class="row">
                                        <div class="issue_date col-50 margin-right-small">
                                            <div class="green_box corner_title_center_content">
                                                <!-- Inserting Issue date Label:  -->
                                                <h1>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-037'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </h1>
                                                <!-- Inserting Issue date:  -->
                                                <div>
                                                    <xsl:if test="cbc:IssueDate !=''">
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="dateTime" select="cbc:IssueDate" />
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </xsl:if>
                                                </div>
                                            </div>
                                            <div>
                                                <small>
                                                <!-- Inserting Issue time:  -->
                                                    <p align="left">
                                                        <b>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-044'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </b>
                                                    </p>
                                                    <p align="left">
                                                        <xsl:value-of select="cbc:IssueTime"/>
                                                    </p>
                                                <!-- Inserting ValidityPeriod:  -->
                                                    <xsl:if test="cac:ValidityPeriod/cbc:EndDate != ''">
                                                        <p align="left">
                                                            <b>
                                                                <xsl:call-template name="UMZLabelName">
                                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-073'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </b>
                                                        </p>
                                                        <p align="left">
                                                            <xsl:value-of select="cac:ValidityPeriod/cbc:EndDate"/>
                                                        </p>
                                                    </xsl:if>
                                                </small>
                                            </div>
                                        </div>
                                        <div class="amount_payable col-50 margin-right-small">
                                            <div class="green_box corner_title_center_content">
                                                <!-- Inserting Payable amount  -->
                                                <xsl:choose>
                                                    <xsl:when test="cac:AnticipatedMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                                        <p align="left">
                                                            <h1 style="color:red">
                                                                <xsl:call-template name="UMZLabelName">
                                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-038'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </h1>
                                                            <div style="color:red" class="payable_amount">
                                                                <xsl:call-template name="Currency">
                                                                    <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PayableAmount"/>
                                                                    <xsl:with-param name="country" select="$languageCode" />
                                                                </xsl:call-template>
                                                            </div>
                                                        </p>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <p align="left">
                                                            <h1>
                                                                <xsl:call-template name="UMZLabelName">
                                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-038'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </h1>
                                                            <div class="payable_amount">
                                                                <xsl:call-template name="Currency">
                                                                    <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PayableAmount"/>
                                                                    <xsl:with-param name="country" select="$languageCode" />
                                                                </xsl:call-template>
                                                            </div>
                                                        </p>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </div>
                                            <div class="document_info_currency">
                                                <div>
                                                    <small>
                                                        <xsl:call-template name="UMZLabelName">
                                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-039'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </small>
                                                    <xsl:value-of select="cbc:DocumentCurrencyCode" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="green_box_no_back description">
                                        <p>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-004'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </small>
                                        </p>
                                        <p>
                                            <small>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-005'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </small>
                                        </p>
                                        <br/>
                                        <p>
                                            <small>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-003'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <xsl:choose>
                                                    <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification !=''">
                                                        <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification" />
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:apply-templates
                                                            select="cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:CompanyID" />
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </small>
                                        </p>
                                        <xsl:if test="cac:Delivery/cbc:ActualDeliveryDate != ''">
                                            <p>
                                                <small>
                                                    <b>
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-72'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </b>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="dateTime" select="cac:Delivery/cbc:ActualDeliveryDate" />
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </small>
                                            </p>
                                        </xsl:if>
                                        <xsl:if test="cac:PaymentTerms != ''">
                                            <p>
                                                <small>
                                                    <b>
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-20'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </b>
                                                    <xsl:apply-templates select="cac:PaymentTerms"/>
                                                </small>
                                            </p>
                                        </xsl:if>
                                    </div>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- /invoicee_and_issue_date_holder -->

                        <!-- seller and allowance charge -->
                        <div class="row">
                            <!-- SELLER -->
                            <div class="seller col-50 margin-right-big">
                                <!-- <xsl:if test="local-name(.)  = 'Order'">
                                    <div class="green_box">
                                        <p class="title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-4'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="box_with_margin">
                                            <p>
                                                <b>
                                                    <xsl:call-template name="SellerSupplierPartyName" />
                                                </b>
                                            </p>
                                            <xsl:call-template name="SellerSupplierPostalAddress" />
                                            <br/>
                                            <xsl:call-template name="SellerSupplierPartyLegalEntity" />
                                        </div>
                                    </div>
                                </xsl:if> -->
                            </div>
                            <!-- /SELLER -->
                            <xsl:if test="cac:AllowanceCharge !=''">
                                <div class="col-50 margin-right-big">
                                <br/>
                                    <div class="green_box_no_back">
                                        <b>
                                            <small>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BG-20'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </small>
                                        </b>
                                        <br/>
                                        <br/>
                                        <xsl:apply-templates select="cac:AllowanceCharge" mode="LineLevel-new"/>
                                    </div>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- /seller and allowance charge -->
                        <br/>
                        <div>
                            <!--Start Orderline-->
                            <div class="items_table">
                                <xsl:if test="local-name(.)  = 'Order'">
                                    <div class="green_box_no_back">
                                        <input type="checkbox" name="collapse_expand_all" class="hide_all_content_input" id="collapse_expand_all"/>
                                        <div class="items_table_header table_header row align-center">
                                            <div class="items_table_header_title">
                                                <label for="collapse_expand_all" class="collapse_expand_all_label">
                                                    <div class="double_expand_arrow">&#171;</div>
                                                </label>
                                            </div>
                                            <div class="items_table_header_title">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-155'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-153'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title text_right">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-129'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title text_right">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-146'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title text_right">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-102'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title text_right">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-131'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </div>
                                            <div class="items_table_header_title text_right">
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-006'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                    <br/>
                                                </b>
                                            </div>
                                        </div>
                                        <div class="items_table_body">
                                            <xsl:apply-templates select="cac:OrderLine/cac:LineItem"/>
                                        </div>
                                    </div>
                                </xsl:if>
                            </div>
                        </div>
                        <!--End Orderline-->
                        <!-- class="green_box_no_back" -->
                        <br/>
                        <!-- Start VAT Breakdown: -->
                        <div class="row">
                            <div class="col-50 margin-right-big">
                                <small class="num_of_lines">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-042'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                    <xsl:call-template name="NumberFormat">
                                        <xsl:with-param name="value" select="count(cac:OrderLine/cac:LineItem/cbc:ID)" />
                                        <xsl:with-param name="decimalDigits" select="2" />
                                        <xsl:with-param name="country" select="$languageCode" />
                                    </xsl:call-template>
                                    &#160;&#160;&#160;&#160;&#160;&#160;&#160;
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-043'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </small>
                            </div>
                            <!-- Start Tax Amount: -->
                            <div class="tax_amount col-50 margin-right-big">
                                <!-- Start sum of invoice line net amount: -->
                                <div class="row" id="sum">
                                    <div class="col-66">
                                        <p align="right">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-106'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                    <div class="col-33">
                                        <p align="right">
                                            <xsl:call-template name="Currency">
                                                <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:LineExtensionAmount"/>
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                </div>
                                <!-- End Sum of invoice line net amount -->
                                <xsl:if test="cbc:TaxCurrencyCode !=''">
                                    <div class="row">
                                        <div class="col-66">
                                            <p align="right">
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-6'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </p>
                                        </div>
                                        <div class="col-33">
                                            <p align="right">
                                                <xsl:value-of select="cbc:TaxCurrencyCode"/>
                                            </p>
                                        </div>
                                    </div>
                                </xsl:if>
                                <xsl:if test="cac:TaxTotal/cbc:TaxAmount">
                                    <xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
                                        <div class="row">
                                            <div class="col-66">
                                                <p align="right">
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-110'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </p>
                                            </div>
                                            <div class="col-33">
                                                <p align="right">
                                                    <xsl:call-template name="Currency">
                                                        <xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]"/>
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </p>
                                            </div>
                                        </div>
                                    </xsl:if>
                                </xsl:if>
                                <!-- End Tax Amount -->
                                <!-- Start TaxExclusive Amount: -->
                                <div class="row">
                                    <div class="col-66">
                                        <p align="right">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-109'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                    <div class="col-33">
                                        <p align="right">
                                            <xsl:call-template name="Currency">
                                                <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:TaxExclusiveAmount"/>
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                </div>
                                <!-- End TaxExclusive Amount -->
                                <!-- Start TaxInclusive Amount: -->
                                <div class="row">
                                    <div class="col-66">
                                        <p align="right">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-112'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                    <div class="col-33">
                                        <p align="right">
                                            <b>
                                                <xsl:call-template name="Currency">
                                                    <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:TaxInclusiveAmount"/>
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                    </div>
                                </div>
                                <!-- End TaxInclusive Amount -->
                                <!-- Start Prepaid Amount: -->
                                <xsl:if test="cac:AnticipatedMonetaryTotal/cbc:PrepaidAmount !='' ">
                                    <div class="row">
                                        <div class="col-66">
                                            <p align="right">
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-113'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </p>
                                        </div>
                                        <div class="col-33">
                                            <p align="right">
                                                <xsl:call-template name="Currency">
                                                    <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PrepaidAmount"/>
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </p>
                                        </div>
                                    </div>
                                </xsl:if>
                                <!-- End Prepaid Amount -->
                                <!-- Start Rounding Amount: -->
                                <xsl:if test="cac:AnticipatedMonetaryTotal/cbc:PayableRoundingAmount !='' ">
                                    <div class="row">
                                        <div class="col-66">
                                            <p align="right">
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-114'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </p>
                                        </div>
                                        <div class="col-33">
                                            <p align="right">
                                                <xsl:call-template name="Currency">
                                                    <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PayableRoundingAmount"/>
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </p>
                                        </div>
                                    </div>
                                </xsl:if>
                                <!-- Start Payable Amount: -->
                                <div class="row">
                                    <xsl:choose>
                                        <xsl:when test="cac:AnticipatedMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                            <div class="col-66">
                                                <b>
                                                    <p align="right">
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </p>
                                                </b>
                                            </div>
                                            <div class="col-33">
                                                <b>
                                                    <p align="right">
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PayableAmount"/>
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </p>
                                                </b>
                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div class="col-66">
                                                <b>
                                                    <p align="right">
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </p>
                                                </b>
                                            </div>
                                            <div class="col-33">
                                                <b>
                                                    <p align="right">
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cac:AnticipatedMonetaryTotal/cbc:PayableAmount"/>
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </p>
                                                </b>
                                            </div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                        </div>
                        <!--End VAT Breakdown -->
                        <!-- End Payable Amount -->
                        <!-- End Rounding Amount -->
                        <br/>
                        <div class="information_banner">
                            <xsl:if test="local-name(.)  = 'Order'">
                                <div class="green_box">
                                    <h1 class="green_title">
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>
                                    </h1>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- Additional Information -->
                        <xsl:if test="local-name(.)  = 'Order'">
                            <div class="row">
                                <div class="invoicee_information col-33 margin-right-big">
                                    <p class="green_title">
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-041'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="green_box_no_back">
                                        <xsl:call-template name="BuyerAdditionalInfo" />
                                    </div>
                                    <xsl:if test="cac:OriginatorCustomerParty != ''">
                                        <div>
                                            <p class="green_title">
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-027'" />
                                                    <xsl:with-param name="Colon-Suffix" select="'false'" />
                                                </xsl:call-template>
                                            </p>
                                            <div class="green_box_no_back">
                                                <xsl:call-template name="OriginatorCustomerParty"/>
                                            </div>
                                        </div>
                                    </xsl:if>
                                </div>
                                <div class="seller_information col-33 margin-right-big">
                                    <p class="green_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="green_box_no_back">
                                        <xsl:call-template name="SellerSupplierPartyAdditionalInfo" />
                                    </div>
                                </div>
                                <div class="buyer_information col-33 margin-right-big">
                                    <p class="green_title">
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="green_box_no_back">
                                        <xsl:call-template name="BuyerCustomerPartyAdditionalInfo" />
                                    </div>
                                </div>
                            </div>
                        </xsl:if>
                        <!-- /Additional Information -->
                        <br/>
                        <!-- Delivery Location and Additional Supporting Documents-->
                        <xsl:if test="local-name(.)  = 'Order'">
                            <div class="row">
                                <div class="delivery_location col-50 margin-right-big">
                                    <xsl:if test="cac:Delivery != ''">
                                        <p class="green_title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-13'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="green_box_no_back">
                                            <xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>
                                        </div>
                                    </xsl:if>
                                </div>
                                <!-- Additional Supporting Documents -->
                                <div class="supporting_documents col-50 margin-right-big">
                                    <xsl:if test="cac:AdditionalDocumentReference !=''">
                                        <p class="green_title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-24'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="green_box_no_back">
                                            <xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode != '130' and cbc:DocumentTypeCode != '50' or  not(cbc:DocumentTypeCode)]" mode="Supporting"/>
                                            <xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode='130' or cbc:DocumentTypeCode='50']" mode="InvoicedObject"/>
                                            <xsl:if test="cac:DespatchDocumentReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-16'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting Despatch advice reference  -->
                                                <xsl:value-of select="cac:DespatchDocumentReference/cbc:ID"/>
                                            </xsl:if>
                                            <xsl:if test="cac:ReceiptDocumentReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-15'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting Receipt advice reference  -->
                                                <xsl:value-of select="cac:ReceiptDocumentReference/cbc:ID"/>
                                            </xsl:if>
                                            <xsl:if test="cac:OriginatorDocumentReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-17'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting Originator advice reference  -->
                                                <xsl:value-of select="cac:OriginatorDocumentReference/cbc:ID"/>
                                            </xsl:if>
                                            <xsl:if test="cac:ProjectReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-11'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting Project advice reference  -->
                                                <xsl:value-of select="cac:ProjectReference/cbc:ID"/>
                                            </xsl:if>
                                            <xsl:if test="cac:QuotationDocumentReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-047'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting QuotationDocumentReference  -->
                                                <xsl:value-of select="cac:QuotationDocumentReference/cbc:ID"/>
                                            </xsl:if>
                                            <xsl:if test="cac:OrderDocumentReference/cbc:ID">
                                                <br/>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-048'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <!-- Inserting OrderDocumentReference  -->
                                                <xsl:value-of select="cac:OrderDocumentReference/cbc:ID"/>
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                </div>
                                <!-- /Additional Supporting Documents -->
                            </div>
                        </xsl:if>
                        <br/>
                        <!-- /Delivery Location and Additional Supporting Documents -->
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                    </div>
                </div>
            </body>
        </html>
        <!-- END HTML -->
    </xsl:template>
</xsl:stylesheet>