<?xml version="1.0" encoding="UTF-8"?>
<!--
   UniStyles - XSLT transforms for rendering UBL documents.
   Copyright (C) 2019-present, Unimaze ehf.

   render-billing-3.xsl - render invoice and credit note of PEPPOL BIS EN16931 (UBL 2.1 format).

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.
 
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
  
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.
-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fcn="urn:sfti:se:xsl:functions"
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
    xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2"
    xmlns:cdl="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2"
    xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2"
    xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cdl cac cbc ccts sdt udt">
    <xsl:import href="billing-3/CommonTemplates.xsl"/>
    <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>
    <xsl:variable name="borderColor">
        <xsl:choose>
            <xsl:when test="/Invoice !=''">
                <!-- THIS DOESN'T WORK -->
						#A6C3D1
            </xsl:when>
            <xsl:otherwise>
						#FF0000
					</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="backgroundColor">
				#F4FBFE
			</xsl:variable>
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
                        margin: 1em;
					}

					p {
						margin: 0;
						padding: 0;
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

					.blue_box {
						border: 1px solid #A6C3D1;
						background-color: #F4FBFE;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}
					.red_box {
						border: 1px solid #CDA1B6;
						background-color: #FEF5F9;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}

					.blue_box_no_back {
						border: 1px solid #A6C3D1;
						padding: 0.5em;
					}

					.red_box_no_back {
						border: 1px solid #CDA1B6;
						padding: 0.5em;
					}

					.text_center {
						padding: 0.5em;
						text-align: center;
					}
					.text_right {
						text-align: right;
					}

                    .blue_title,
                    .red_title {
                        padding: 0.8em 0 0.4em 0.4em;
                        text-align: left;
                        font-size: 1.2em;
                        font-weight: bold;
                    }
                    .blue_title {
                        color: #5f92a8;
                    }
                    .red_title {
                        color: #8F5873;
                    }

                    .document_info {
                        font-size:1.2em;
                    }

                    .document_info span {
                        display: inline-block;
                        min-width: 4em;
                    }

                    .main_header .seller {
                        align-items: flex-end;
                    }

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

                    .buyer_payment_info_holder {
                        display: flex;
                        flex-direction: column;
                    }
                    .buyer_payment_info_holder .amount_payable .blue_box {
                        margin-bottom: 0.3em;
                    }

                    .buyer_payment_info_holder .credit_note_buyer_payment_info_wrapper,
                    .credit_note_buyer_payment_info_wrapper .date_holder {
                        display: flex;
                        flex-direction: column;
                    }

                    .credit_note_buyer_payment_info_wrapper .red_box{
                        position: relative;
                        height: 80px;
                    }
                    .credit_note_buyer_payment_info_wrapper .grid_spliter {
                        display: grid;
                        grid-template-columns: repeat(2,1fr);
                        grid-gap: 1em;
                    }

                    .credit_note_buyer_payment_info_wrapper .red_box .currency{
                        position: absolute;
                        right: 1px;
                        bottom: -1.8em;
                    }

                    .table_header, .credit_note_table_header {
                        font-weight: normal;
						background-color: #F4FBFE;
                        padding: 0.5em;
                        border-bottom: 1px solid #A6C3D1;
                    } 

                    .table_header {
						background-color: #F4FBFE;
                    } 

                    .credit_note_table_header {
                        background-color: #FEF5F9;
                    } 

                    .table_body {
                        font-weight: normal;
                        padding: 0 0.5em;
                    } 

					.buyer_info {
						margin: 1.2em 0 1.2em 1.2em;
					}

					.title {
						margin: 0.1em 0 0.6em 0;
						text-transform: capitalize;
						font-size: 0.9em;
					}

                    .payment_table .blue_box_no_back, 
                    .payment_table .red_box_no_back {
                        padding: 0;
                        border-top: none;
                    }

                    .payment_table .payment_table_header {
                        display: grid;
                        grid-template-columns: 50% 50%;
                        margin-bottom: 0.5em;
                    }

					.payment_table .red_box_no_back .payment_table_header {
                        border-top: 1px solid #CDA1B6;
					}

					.payment_table .blue_box_no_back .payment_table_header {
                        border-top: 1px solid #A6C3D1;
					}

                    .payment_table .payment_table_header_title:last-child {
                        margin-right: none;
                    }

                    .payment_table .payment_table_body {
                        min-height: 5em;
                    }
                    
                    .payment_table .payment_table_body_data:last-of-type {
                        margin-bottom: 1em;
                    }

                    .transfer {
                        padding: 0.5em;
                    }

					.payment_table_header .transfer {
                        border-bottom: 1px solid #A6C3D1;
                        border-left: 1px solid #A6C3D1;
                        border-top: none;
					}

					.blue_box_no_back .payment_table_header .transfer {
                        border-color: #A6C3D1;
					}

					.red_box_no_back .payment_table_header .transfer {
                        border-color: #CDA1B6;
					}
                    

					.payment_table .payment_table_body .table_body {
                        display: flex;
                        justify-content: space-between;
                        background: #fff;
                        border-bottom: none;
					}

					.payment_table .payment_table_body .payment_table_cell {
                        display: flex;
                        flex-direction: column;
                        justify-content: space-between;
					}
                    
					.payment_table .payment_table_body .payment_table_cell:last-of-type {
                        text-align: right;
					}
					.payment_table .payment_table_body .payment_table_cell:first-of-type {
                        text-align: left;
					}

					.payment_table .payment_table_body .payment_table_body_data {
                        margin-bottom: 1em;
					}

                    .payment_table_row_blue {
                        border-top: 1px solid #A6C3D1;
                    }

                    .credit_note_description {
                        height: fit-content;
                    }

                    .invoice_table .blue_box_no_back, 
                    .invoice_table .red_box_no_back {
                        padding:0;
                    }

                    .invoice_table .invoice_table_body_data_name_column_header {
                        width: 100%;
                        margin-bottom: 0.5em;
                    }

                    .invoice_table .invoice_table_body_data_name_column_body {
                        width: 150%;
                    }

                    .payable_amount {
                        font-weight: 700;
                    }

                    .document_info_currency {
                        text-align: right;
                    }

                    .tax_amount .grid_spliter {
                        display: grid;
                        grid-template-columns: 2fr 1fr;
                        padding-right: 26%;
                    }
                    <!-- HIDE-SHOW TABLE DETAILS -->
                    .invoice_table_body_data label,
                    .collapse_expand_all_label {
                        cursor:pointer;
                    }
                    .invoice_table_body_data label {
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

                    .hide_content_input:checked + .invoice_table_body_holder .invoice_table_body_data .expand_arrow,
                    .hide_all_content_input:checked + .invoice_table_header .invoice_table_header_title .collapse_expand_all_label .double_expand_arrow {
                        transition: all .3s;
                        transform: rotate(-180deg);
                        -webkit-transform: rotate(-180deg);
                        -moz-transform: rotate(-180deg);
                        -ms-transform: rotate(-180deg);
                        -o-transform: rotate(-180deg);
                    }

                    .hide_content {
                        min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                        overflow: hidden;
                        transition: all 0.3s ease;
                    }

                    .hide_content_input, .hide_all_content_input {
                        display: none;
                    }           
                    
                    .invoice_table_body > .hide_content_input:checked + .invoice_table_body_holder .invoice_table_body_data .hide_content,
                    .invoice_table .hide_all_content_input:checked ~ .invoice_table_body .invoice_table_body_holder .invoice_table_body_data .hide_content {
                        min-height: 0;
                        height: 0;
                        opacity: 0;
                        display: block;
                        transition: all 0.3s ease;
                    }
                    <!-- /HIDE-SHOW TABLE DETAILS -->

                    .invoice_table_header {
                        display: grid;
                        grid-template-columns: 7% 10% auto 10% 12% 6% 10% 12%;
                        align-items: center;
                    }

                    .invoice_table_body_holder {
                        display: grid;
                        padding: 0.5em;
                        grid-template-columns: 7% 10% auto 10% 12% 6% 10% 12%;
                        align-items: flex-start;
                    }


                    .tax_table .blue_box_no_back,
                    .tax_table .red_box_no_back {
                        padding: 0;
                    }

                    .tax_table .table_header,
                    .tax_table .credit_note_table_header {
                        display: grid;
                        grid-template-columns: 1fr 3fr 3fr 3fr;
                        padding: 0.5em 0;
                    }

                    .tax_table .table_body {
                        display: grid;
                        padding: 0;
                    }

                    .tax_table .table_header .tax_table_header_title,
                    .tax_table .credit_note_table_header .tax_table_header_title {
                        justify-self: flex-end;
                        padding: .5em;
                        text-align: right;
                    }


                    .tax_table .table_body .table_body_data_row1 {
                        display: grid;
                        grid-template-columns: 1fr 3fr 3fr 3fr;
                        border-bottom: 1px solid #A6C3D1;
                    }

                    .tax_table .table_body .table_body_data_row2 {
                        display: flex;
                        justify-content: flex-end;
                    }

                    .tax_table .table_body .tax_table_body_data {
                        justify-self: flex-end;
                        padding: .5em;
                        margin-right: 0.2em;
                    }


                    .information_banner .blue_box,
                    .information_banner .red_box {
                        min-height:4em;
                    }

                    .information_banner .blue_box .blue_title,
                    .information_banner .red_box .red_title {
                        font-size:1.5em;
                        margin:0;
                    }

					
                    @media print {
                        .container {
                            width:80em;
                        }

                        .hide_content_input:checked + .invoice_table_body_holder .invoice_table_body_data .expand_arrow,
                        .expand_arrow,
                        .collapse_expand_all_label {
                            transform: rotate(0);
                            display: none;
                        }
                        .invoice_table_body > .hide_content_input:checked + .invoice_table_body_holder .invoice_table_body_data .hide_content,
                        .invoice_table .hide_all_content_input:checked ~ .invoice_table_body .invoice_table_body_holder .invoice_table_body_data .hide_content {
                            min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                            overflow: hidden;
                            height: unset;
                            opacity: 1;
                        }    
                    }
                    <!-- /GENERAL CSS -->
                    <!-- GRID CSS -->
					.space_between {
						display: flex;
						justify-content: space-between;
					}

                    .grid_big_2fr_spliter {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        grid-gap: 2em;
                    }
                    
                    .grid_small_2fr_spliter {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        grid-gap: 1em;
                    }
                    <!-- /GRID CSS -->
                </style>
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="{$stylesheet_url}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="n1:Invoice | n2:CreditNote">
        <!-- Start HTML -->
        <html>
            <xsl:if test="/Invoice !=''"></xsl:if>
            <xsl:call-template name="doc-head" />
            <head>
                <link rel="Stylesheet" type="text/css" href="PEPPOL.css" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title>PEPPOL BIS-BILLING 3 Invoice AND CREDIT NOTE</title>
            </head>
            <body>
                <div class="container">
                    <header class="main_header grid_big_2fr_spliter">
                        <div class="seller grid_small_2fr_spliter">
                            <!-- SELLER -->
                            <div class="seller_info">
                                <p class="title">
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BG-4'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <p>
                                    <xsl:call-template name="Seller"/>
                                </p>
                            </div>
                            <div class="seller-contact">
                                <xsl:choose>
                                    <xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
                                        <br/>
                                        <p>
                                            <xsl:call-template name="SellerContact" />
                                        </p>
                                        <p>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-31'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        &#160;
                                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID" />
                                        </p>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <br/>
                                        <span class="UBLElectronicMail">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-31'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                            &#160;
                                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
                                        </span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                            <!-- /SELLER -->
                        </div>
                        <div class="document_details">
                            <br/>
                            <!-- DOCUMENT DETAILS -->
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <h1>
                                    <xsl:call-template name="DocumentHeader">
                                        <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                    </xsl:call-template>
                                </h1>
                                <xsl:if test="cbc:InvoiceTypeCode !='380'">
                                    <h3>
                                        <xsl:call-template name="DocumentCode">
                                            <xsl:with-param name="DCode" select="cbc:InvoiceTypeCode"/>
                                        </xsl:call-template>
                                    </h3>
                                </xsl:if>
                                <p>
                                    <b class="document_info">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-1'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>&#160;
                                        <!-- Inserting Invoice ID -->
                                        <span>
                                            <xsl:value-of select="cbc:ID" />
                                        </span>
                                    </b>
                                </p>
                                <xsl:if test="((cac:OrderReference/cbc:ID !='') and (cac:OrderReference/cbc:ID != 'Unknown'))">
                                    <p>
                                        <b class="document_info">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-13'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                            <!-- Inserting Order reference number  -->
                                            <span>
                                                <xsl:value-of select="cac:OrderReference/cbc:ID"/>
                                            </span>
                                        </b>
                                        <br/>
                                    </p>
                                </xsl:if>
                                <xsl:if test="((cbc:BuyerReference !='') and (cbc:BuyerReference != 'Unknown'))">
                                    <p>
                                        <b class="document_info">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-10'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                            <!-- Inserting Buyer Reference::  -->
                                            <span>
                                                <xsl:value-of select="cbc:BuyerReference"/>
                                            </span>
                                        </b>
                                        <br/>
                                    </p>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <h1>
                                    <xsl:call-template name="DocumentHeader">
                                        <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                    </xsl:call-template>
                                </h1>
                                <xsl:if test="cbc:CreditNoteTypeCode != '381'">
                                    <h3>
                                        <xsl:call-template name="DocumentCode">
                                            <xsl:with-param name="DCode" select="cbc:CreditNoteTypeCode"/>
                                        </xsl:call-template>
                                    </h3>
                                </xsl:if>
                                <p>
                                    <b class="document_info">
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-019'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                        <!-- Inserting Invoice ID -->
                                        <span>
                                            <xsl:value-of select="cbc:ID" />
                                        </span>
                                    </b>
                                </p>
                                <xsl:if test="((cac:OrderReference/cbc:ID !='') and (cac:OrderReference/cbc:ID != 'Unknown'))">
                                    <p>
                                        <b class="document_info">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-13'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                            <!-- Inserting Order reference number  -->
                                            <span>
                                                <xsl:value-of select="cac:OrderReference/cbc:ID"/>
                                            </span>
                                        </b>
                                        <br/>
                                    </p>
                                </xsl:if>
                                <xsl:if test="((cbc:BuyerReference !='') and (cbc:BuyerReference != 'Unknown'))">
                                    <p>
                                        <b class="document_info">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-10'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                            <!-- Inserting Buyer Reference::  -->
                                            <span>
                                                <xsl:value-of select="cbc:BuyerReference"/>
                                            </span>
                                        </b>
                                        <br/>
                                    </p>
                                </xsl:if>
                            </xsl:if>
                            <!-- /DOCUMENT DETAILS -->
                        </div>
                    </header>
                    <br/>
                    <br/>
                    <!-- buyer_and_due_dates_holder -->
                    <div class="grid_big_2fr_spliter">
                        <div class="buyer">
                            <!-- BUYER -->
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <div class="blue_box">
                                    <p class="title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-7'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="buyer_info">
                                        <p>
                                            <b>
                                                <xsl:call-template name="BuyerPartyName" />
                                            </b>
                                        </p>
                                        <xsl:call-template name="BuyerPostalAddress" />
                                    </div>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <div class="red_box">
                                    <p class="title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-7'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="buyer_info">
                                        <p>
                                            <b>
                                                <xsl:call-template name="BuyerPartyName" />
                                            </b>
                                        </p>
                                        <xsl:call-template name="BuyerPostalAddress" />
                                    </div>
                                </div>
                            </xsl:if>
                            <!-- /BUYER -->
                        </div>
                        <xsl:if test="local-name(.) = 'Invoice'">
                            <div class="buyer_payment_info_holder">
                                <div class="grid_small_2fr_spliter">
                                    <div class="blue_box corner_title_center_content">
                                        <!-- Inserting Due Date Label:  -->
                                        <h1>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-9'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </h1>
                                        <!-- Inserting Due Date:  -->
                                        <div>
                                            <xsl:choose>
                                                <xsl:when test="cac:PaymentMeans/cbc:PaymentDueDate !=''">
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="dateTime" select="cac:PaymentMeans/cbc:PaymentDueDate" />
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="dateTime" select="cbc:DueDate" />
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </div>
                                    <div class="blue_box corner_title_center_content">
                                        <h1>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-002'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </h1>
                                        <div>
                                            <xsl:if test="cac:PaymentTerms/cac:SettlementPeriod/cbc:StartDate !=''">
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cac:PaymentTerms/cac:SettlementPeriod/cbc:StartDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </xsl:if>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid_small_2fr_spliter">
                                    <div>
                                        <p align="left">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-2'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br />
                                            <!-- Inserting Invoice Date -->
                                            <small>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cbc:IssueDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </small>
                                            <br />
                                        </p>
                                        <xsl:if test="cac:InvoicePeriod !=''">
                                            <p align="left">
                                                <xsl:if test="((cac:InvoicePeriod/cbc:StartDate !='') and (cac:InvoicePeriod/cbc:EndDate !=''))">
                                                    <b>
                                                        <small>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-011'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </small>
                                                    </b>
                                                </xsl:if>
                                            </p>
                                            <p align="left">
                                                <xsl:if test="((cac:InvoicePeriod/cbc:StartDate !='') and (cac:InvoicePeriod/cbc:EndDate !=''))">
                                                    <small>
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="dateTime" select="cac:InvoicePeriod/cbc:StartDate" />
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </small> - 
                                                    <small>
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="dateTime" select="cac:InvoicePeriod/cbc:EndDate" />
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </small>
                                                </xsl:if>
                                            </p>
                                        </xsl:if>
                                        <p>
                                            <xsl:if test="cbc:TaxPointDate !=''">
                                                <b>
                                                    <small>
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-7'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </small>
                                                </b>
                                                <br />
                                                <small>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="dateTime" select="cbc:TaxPointDate" />
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </small>
                                            </xsl:if>
                                            <xsl:if test="cac:InvoicePeriod/cbc:DescriptionCode != ''">
                                                <br />
                                                <b>
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-8'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <xsl:call-template name="UBLDescriptionCode">
                                                    <xsl:with-param name="Code" select="cac:InvoicePeriod/cbc:DescriptionCode"/>
                                                </xsl:call-template> [
                                                <xsl:value-of select="cac:InvoicePeriod/cbc:DescriptionCode"/>
                                                ]
                                                <br />
                                            </xsl:if>
                                        </p>
                                    </div>
                                    <div class="amount_payable">
                                        <div class="blue_box corner_title_center_content">
                                            <!-- Inserting Total Payable amount  -->
                                            <xsl:choose>
                                                <xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                                    <p align="left">
                                                        <h1 style="color:red">
                                                            <xsl:call-template name="LabelName">
                                                                <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </h1>
                                                        <div style="color:red" class="payable_amount">
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </div>
                                                    </p>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <p align="left">
                                                        <h1>
                                                            <xsl:call-template name="LabelName">
                                                                <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </h1>
                                                        <div class="payable_amount">
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
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
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-007'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </small>
                                                <xsl:value-of select="cbc:DocumentCurrencyCode" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </xsl:if>
                        <xsl:if test="local-name(.) = 'CreditNote'">
                            <div class="buyer_payment_info_holder">
                                <div class="credit_note_buyer_payment_info_wrapper">
                                    <div class="grid_spliter">
                                        <!-- Credit Note Dates -->
                                        <div class="date_holder">
                                            <div class="red_box corner_title_center_content">
                                                <p align="left">
                                                    <b>
                                                        <small>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-015'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </small>
                                                    </b>
                                                    <br />
                                                    <!-- Inserting Invoice Date -->
                                                    <div>
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="dateTime" select="cbc:IssueDate" />
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </div>
                                                    <br />
                                                </p>
                                            </div>
                                            <div>
                                                <xsl:if test="cac:PaymentMeans/cbc:PaymentDueDate !=''">
                                                    <p align="left">
                                                        <b>
                                                            <small>
                                                                <xsl:call-template name="LabelName">
                                                                    <xsl:with-param name="BT-ID" select="'BT-9'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </small>
                                                        </b>
                                                    </p>
                                                    <p align="left">
                                                        <small>
                                                            <xsl:call-template name="formatDate">
                                                                <xsl:with-param name="dateTime" select="cac:PaymentMeans[1]/cbc:PaymentDueDate" />
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </small>
                                                    </p>
                                                </xsl:if>
                                                <xsl:if test="cac:InvoicePeriod !=''">
                                                    <p align="left">
                                                        <xsl:if test="((cac:InvoicePeriod/cbc:StartDate !='') and (cac:InvoicePeriod/cbc:EndDate !=''))">
                                                            <b>
                                                                <small>
                                                                    <xsl:call-template name="UMZLabelName">
                                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-011'"/>
                                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                    </xsl:call-template>
                                                                </small>
                                                            </b>
                                                        </xsl:if>
                                                    </p>
                                                    <p align="left">
                                                        <xsl:if test="((cac:InvoicePeriod/cbc:StartDate !='') and (cac:InvoicePeriod/cbc:EndDate !=''))">
                                                            <small>
                                                                <xsl:call-template name="formatDate">
                                                                    <xsl:with-param name="dateTime" select="cac:InvoicePeriod/cbc:StartDate" />
                                                                    <xsl:with-param name="country" select="$languageCode" />
                                                                </xsl:call-template>
                                                            </small> -
                                                            <small>
                                                                <xsl:call-template name="formatDate">
                                                                    <xsl:with-param name="dateTime" select="cac:InvoicePeriod/cbc:EndDate" />
                                                                    <xsl:with-param name="country" select="$languageCode" />
                                                                </xsl:call-template>
                                                            </small>
                                                        </xsl:if>
                                                    </p>
                                                </xsl:if>
                                                <xsl:if test="cbc:TaxPointDate !=''">
                                                    <p align="left">
                                                        <b>
                                                            <small>
                                                                <xsl:call-template name="LabelName">
                                                                    <xsl:with-param name="BT-ID" select="'BT-7'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                                </xsl:call-template>
                                                            </small>
                                                        </b>
                                                    </p>
                                                    <p align="left">
                                                        <small>
                                                            <xsl:call-template name="formatDate">
                                                                <xsl:with-param name="dateTime" select="cbc:TaxPointDate" />
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </small>
                                                    </p>
                                                </xsl:if>
                                                <xsl:if test="cac:InvoicePeriod/cbc:DescriptionCode != ''">
                                                    <p align="left">
                                                        <b>
                                                            <small>
                                                                <xsl:call-template name="LabelName">
                                                                    <xsl:with-param name="BT-ID" select="'BT-8'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                                </xsl:call-template>
                                                            </small>
                                                        </b>
                                                    </p>
                                                    <p align="left">
                                                        <small>
                                                            <xsl:call-template name="UBLDescriptionCode">
                                                                <xsl:with-param name="Code" select="cac:InvoicePeriod/cbc:DescriptionCode"/>
                                                            </xsl:call-template> [
                                                            <xsl:value-of select="cac:InvoicePeriod/cbc:DescriptionCode"/>
                                                ]
                                                        </small>
                                                    </p>
                                                </xsl:if>
                                            </div>
                                        </div>
                                        <!-- Credit Note Dates END -->
                                        <div class="red_box corner_title_center_content">
                                            <h1>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-012'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </h1>
                                            <div>
                                                <xsl:choose>
                                                    <xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount !=''">
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </div>
                                            <p class="currency text_right">
                                                <small>
                                                    <span>
                                                        <xsl:call-template name="UMZLabelName">
                                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-014'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </span>
                                                    <xsl:value-of select="cbc:DocumentCurrencyCode" />
                                                </small>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </xsl:if>
                    </div>
                    <!-- /buyer_and_due_dates_holder -->
                    <xsl:if test="local-name(.) = 'Invoice'">
                        <br/>
                        <div class="grid_big_2fr_spliter">
                            <xsl:if test="cac:PaymentMeans != ''">
                                <div class="payment_table">
                                    <div class="blue_box_no_back">
                                        <xsl:for-each select="cac:PaymentMeans">
                                            <div class="payment_table_header">
                                                <div class="payment" data-name="payment">
                                                    <xsl:if test="position()=1">
                                                        <p class="text_center">
                                                            <b>
                                                                <xsl:call-template name="LabelName">
                                                                    <xsl:with-param name="BT-ID" select="'BG-16'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </b>
                                                        </p>
                                                    </xsl:if>
                                                </div>
                                                <div class="transfer" data-name="transfer">
                                                    <p>
                                            ( 
                                                        <xsl:apply-templates select="cbc:PaymentMeansCode"/>
                                                )
                                                        <xsl:choose>
                                                            <xsl:when test="cac:PaymentMeans/cbc:PaymentMeansCode/@name != ''">
                                                                <xsl:apply-templates select="cac:PaymentMeans/cbc:PaymentMeansCode/@name"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:call-template name="PaymentMeansCode">
                                                                    <xsl:with-param name="PaymentCode" select="cac:PaymentMeans/cbc:PaymentMeansCode"/>
                                                                </xsl:call-template>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:choose>
                                                            <xsl:when test="cbc:PaymentMeansCode/@name != ''">
                                                                <xsl:apply-templates select="cbc:PaymentMeansCode/@name"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:call-template name="PaymentMeansCode">
                                                                    <xsl:with-param name="PaymentCode" select="cbc:PaymentMeansCode"/>
                                                                </xsl:call-template>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="payment_table_body">
                                                <xsl:if test="cac:PayeeFinancialAccount !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:PayeeFinancialAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                        <xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
                                                            <small>
                                                                <xsl:call-template name="cac:PaymentMeans"/>
                                                            </small>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                                <xsl:if test="cac:CardAccount !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:CardAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                                <xsl:if test="cac:PaymentMandate !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:CardAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </div>
                            </xsl:if>
                            <div class="blue_box_no_back description">
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
                                <p>
                                    <small>
                                        <xsl:if test="cac:Delivery/cbc:ActualDeliveryDate != ''">
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
                                        </xsl:if>
                                    </small>
                                </p>
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
                            </div>
                        </div>
                        <br/>
                    </xsl:if>
                    <!-- Start on PAYMENT MEANS information -->
                    <xsl:if test="local-name(.) = 'CreditNote'">
                        <xsl:if test="cac:PaymentMeans != ''">
                            <br/>
                        </xsl:if>
                        <div class="grid_big_2fr_spliter">
                            <div class="payment_table">
                                <xsl:if test="cac:PaymentMeans != ''">
                                    <div class="red_box_no_back">
                                        <xsl:for-each select="cac:PaymentMeans">
                                            <div class="payment_table_header">
                                                <div class="payment" data-name="payment">
                                                    <xsl:if test="position()=1">
                                                        <p class="text_center">
                                                            <b>
                                                                <xsl:call-template name="LabelName">
                                                                    <xsl:with-param name="BT-ID" select="'BG-16'"/>
                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                </xsl:call-template>
                                                            </b>
                                                        </p>
                                                    </xsl:if>
                                                </div>
                                                <div class="transfer" data-name="transfer">
                                                    <p>
                                            (
                                                        <xsl:apply-templates select="cbc:PaymentMeansCode"/>
                                                )
                                                        <xsl:choose>
                                                            <xsl:when test="cac:PaymentMeans/cbc:PaymentMeansCode/@name != ''">
                                                                <xsl:apply-templates select="cac:PaymentMeans/cbc:PaymentMeansCode/@name"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:call-template name="PaymentMeansCode">
                                                                    <xsl:with-param name="PaymentCode" select="cac:PaymentMeans/cbc:PaymentMeansCode"/>
                                                                </xsl:call-template>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <xsl:choose>
                                                            <xsl:when test="cbc:PaymentMeansCode/@name != ''">
                                                                <xsl:apply-templates select="cbc:PaymentMeansCode/@name"/>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:call-template name="PaymentMeansCode">
                                                                    <xsl:with-param name="PaymentCode" select="cbc:PaymentMeansCode"/>
                                                                </xsl:call-template>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="payment_table_body">
                                                <xsl:if test="cac:PayeeFinancialAccount !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:PayeeFinancialAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                        <xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
                                                            <small>
                                                                <xsl:call-template name="cac:PaymentMeans"/>
                                                            </small>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                                <xsl:if test="cac:CardAccount !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:CardAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                                <xsl:if test="cac:PaymentMandate !=''">
                                                    <div class="table_body">
                                                        <xsl:if test="cac:CardAccount !=''">
                                                            <xsl:call-template name="cac:PaymentMeans"/>
                                                        </xsl:if>
                                                    </div>
                                                </xsl:if>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                </xsl:if>
                            </div>
                            <div class="red_box_no_back credit_note_description">
                                <p>
                                    <small>
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-005'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                        <xsl:if test="cbc:Note !=''">
                                            <xsl:value-of select="cbc:Note" />
                                        </xsl:if>
                                    </small>
                                </p>
                                <br/>
                                <br/>
                                <p>
                                    <small>
                                        <xsl:if test="cac:ContractDocumentReference !=''">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-12'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                            <xsl:apply-templates select="cac:ContractDocumentReference"/>
                                        </xsl:if>
                                    </small>
                                </p>
                                <p>
                                    <small>
                                        <xsl:if test="cbc:AccountingCost !=''">
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-013'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                            <xsl:value-of select="cbc:AccountingCost" />
                                        </xsl:if>
                                    </small>
                                </p>
                                <p>
                                    <small>
                                        <xsl:if test="cbc:ID !=''">
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-018'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                            <xsl:value-of select="cbc:ID" />
                                        </xsl:if>
                                    </small>
                                </p>
                            </div>
                        </div>
                    </xsl:if>
                    <br/>
                    <div>
                        <!--Start Invoiceline-->
                        <div class="invoice_table">
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <div class="blue_box_no_back">
                                    <input type="checkbox" name="collapse_expand_all" class="hide_all_content_input" id="collapse_expand_all"/>
                                    <div class="invoice_table_header table_header">
                                        <div class="invoice_table_header_title">
                                            <label for="collapse_expand_all" class="collapse_expand_all_label">
                                                <div class="double_expand_arrow">&#171;</div>
                                            </label>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-155'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-153'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-129'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-146'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-151'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title text_right">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-131'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title text_right">
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-006'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                                <br/>
                                            </b>
                                        </div>
                                    </div>
                                    <div class="invoice_table_body">
                                        <xsl:apply-templates select="cac:InvoiceLine"/>
                                    </div>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <div class="red_box_no_back">
                                    <input type="checkbox" name="collapse_expand_all" class="hide_all_content_input" id="collapse_expand_all"/>
                                    <div class="invoice_table_header credit_note_table_header">
                                        <div class="invoice_table_header_title">
                                            <label for="collapse_expand_all" class="collapse_expand_all_label">
                                                <div class="double_expand_arrow">&#171;</div>
                                            </label>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-155'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-153'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-129'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-146'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-151'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title text_right">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-131'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="invoice_table_header_title text_right">
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-006'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                                <br/>
                                            </b>
                                        </div>
                                    </div>
                                    <div class="invoice_table_body">
                                        <xsl:apply-templates select="cac:CreditNoteLine"/>
                                    </div>
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                    <!--End Invoiceline-->
                    <!-- class="blue_box_no_back" -->
                    <br/>
                    <!-- Start VAT Breakdown: -->
                    <div class="grid_big_2fr_spliter">
                        <div class="tax_table">
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <div class="blue_box_no_back">
                                    <div class="table_header">
                                        <div class="tax_table_header_title"></div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-118'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-116'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-117'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                    </div>
                                    <div class="table_body">
                                        <div class="table_body_data_row1">
                                            <xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>
                                        </div>
                                        <div class="table_body_data_row2">
                                            <div class="tax_table_body_data">
                                                <xsl:if test="cac:TaxTotal/cbc:TaxAmount">
                                                    <xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
                                                        <b>
                                                            <xsl:call-template name="LabelName">
                                                                <xsl:with-param name="BT-ID" select="'BT-110'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                            </xsl:call-template>
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]"/>
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </b>
                                                    </xsl:if>
                                                </xsl:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <div class="red_box_no_back">
                                    <div class="credit_note_table_header">
                                        <div class="tax_table_header_title"></div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-118'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-116'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div class="tax_table_header_title">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-117'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                    </div>
                                    <div class="table_body">
                                        <div class="table_body_data_row1">
                                            <xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>
                                        </div>
                                        <div class="table_body_data_row2">
                                            <div class="tax_table_body_data">
                                                <xsl:if test="cac:TaxTotal/cbc:TaxAmount">
                                                    <xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
                                                        <b>
                                                            <xsl:call-template name="LabelName">
                                                                <xsl:with-param name="BT-ID" select="'BT-110'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                            </xsl:call-template>
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]"/>
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </b>
                                                    </xsl:if>
                                                </xsl:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- Start Tax Amount: -->
                        <div class="tax_amount">
                            <!-- Start sum of invoice line net amount: -->
                            <div class="grid_spliter" id="sum">
                                <div>
                                    <p align="right">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-106'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                </div>
                                <div>
                                    <p align="right">
                                        <xsl:call-template name="Currency">
                                            <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/>
                                            <xsl:with-param name="country" select="$languageCode" />
                                        </xsl:call-template>
                                    </p>
                                </div>
                            </div>
                            <!-- End Sum of invoice line net amount -->
                            <xsl:if test="cbc:TaxCurrencyCode !=''">
                                <div class="grid_spliter">
                                    <div>
                                        <p align="right">
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-6'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                    </div>
                                    <div>
                                        <p align="right">
                                            <xsl:value-of select="cbc:TaxCurrencyCode"/>
                                        </p>
                                    </div>
                                </div>
                            </xsl:if>
                            <xsl:if test="cac:TaxTotal/cbc:TaxAmount">
                                <xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
                                    <div class="grid_spliter">
                                        <div>
                                            <p align="right">
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BT-110'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </p>
                                        </div>
                                        <div>
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
                            <div class="grid_spliter">
                                <div>
                                    <p align="right">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-109'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                </div>
                                <div>
                                    <p align="right">
                                        <xsl:call-template name="Currency">
                                            <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/>
                                            <xsl:with-param name="country" select="$languageCode" />
                                        </xsl:call-template>
                                    </p>
                                </div>
                            </div>
                            <!-- End TaxExclusive Amount -->
                            <!-- Start TaxInclusive Amount: -->
                            <div class="grid_spliter">
                                <div>
                                    <p align="right">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-112'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                </div>
                                <div>
                                    <p align="right">
                                        <b>
                                            <xsl:call-template name="Currency">
                                                <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/>
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                </div>
                            </div>
                            <!-- End TaxInclusive Amount -->
                            <!-- Start Prepaid Amount: -->
                            <xsl:if test="cac:LegalMonetaryTotal/cbc:PrepaidAmount !='' ">
                                <div class="grid_spliter">
                                    <div>
                                        <p align="right">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-113'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                    <div>
                                        <p align="right">
                                            <xsl:call-template name="Currency">
                                                <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PrepaidAmount"/>
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                </div>
                            </xsl:if>
                            <!-- End Prepaid Amount -->
                            <!-- Start Rounding Amount: -->
                            <xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">
                                <div class="grid_spliter">
                                    <div>
                                        <p align="right">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-114'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                    <div>
                                        <p align="right">
                                            <xsl:call-template name="Currency">
                                                <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount"/>
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </p>
                                    </div>
                                </div>
                            </xsl:if>
                            <!-- Start Payable Amount: -->
                            <div class="grid_spliter">
                                <xsl:choose>
                                    <xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                        <div>
                                            <b>
                                                <p align="right">
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </p>
                                            </b>
                                        </div>
                                        <div>
                                            <b>
                                                <p align="right">
                                                    <xsl:call-template name="Currency">
                                                        <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
                                                        <xsl:with-param name="country" select="$languageCode" />
                                                    </xsl:call-template>
                                                </p>
                                            </b>
                                        </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div>
                                            <b>
                                                <p align="right">
                                                    <xsl:call-template name="LabelName">
                                                        <xsl:with-param name="BT-ID" select="'BT-115'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </p>
                                            </b>
                                        </div>
                                        <div>
                                            <b>
                                                <p align="right">
                                                    <xsl:call-template name="Currency">
                                                        <xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/>
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
                        <xsl:if test="local-name(.)  = 'Invoice'">
                            <div class="blue_box">
                                <h1 class="blue_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                    </xsl:call-template>
                                </h1>
                            </div>
                        </xsl:if>
                        <xsl:if test="local-name(.)  = 'CreditNote'">
                            <div class="red_box">
                                <h1 class="red_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                    </xsl:call-template>
                                </h1>
                            </div>
                        </xsl:if>
                    </div>
                    <!-- Delivery Location and Payee-->
                    <xsl:if test="local-name(.)  = 'Invoice'">
                        <div class="grid_big_2fr_spliter">
                            <div class="delivery_location">
                                <xsl:if test="cac:Delivery != ''">
                                    <p class="blue_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-15'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="blue_box_no_back">
                                        <xsl:apply-templates select="cac:Delivery/cac:DeliveryLocation"/>
                                        <xsl:call-template name="ActualDeliveryDate"/>
                                    </div>
                                </xsl:if>
                            </div>
                            <div>
                                <xsl:if test="cac:PayeeParty != ''">
                                    <p class="blue_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-10'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="blue_box_no_back">
                                        <xsl:call-template name="PayeeParty"/>
                                    </div>
                                </xsl:if>
                            </div>
                        </div>
                    </xsl:if>
                    <xsl:if test="local-name(.)  = 'CreditNote'">
                        <div class="grid_big_2fr_spliter">
                            <div class="delivery_location">
                                <xsl:if test="cac:Delivery != ''">
                                    <p class="red_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-15'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="red_box_no_back">
                                        <xsl:apply-templates select="cac:Delivery/cac:DeliveryLocation"/>
                                        <xsl:call-template name="ActualDeliveryDate"/>
                                    </div>
                                </xsl:if>
                            </div>
                            <div>
                                <xsl:if test="cac:PayeeParty != ''">
                                    <p class="red_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-10'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="red_box_no_back">
                                        <xsl:call-template name="PayeeParty"/>
                                    </div>
                                </xsl:if>
                            </div>
                        </div>
                    </xsl:if>
                    <br/>
                    <!-- /Delivery Location and Payee -->
                    <!-- Additional Information -->
                    <div class="grid_big_2fr_spliter">
                        <div class="seller_information">
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <p class="blue_title">
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="blue_box_no_back">
                                    <xsl:if test="(cac:AccountingSupplierParty/cac:Party/cac:Contact !='') or (cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName !='')">
                                        <p>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BG-6'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                    </xsl:if>
                                    <p>
                                        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName !=''">
                                            <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName"/>
                                        </xsl:if>
                                    </p>
                                    <xsl:call-template name="SellerAdditionalInfo" />
                                    <p>
                                        <xsl:call-template name="SellerContact" />
                                    </p>
                                    <p>
                                        <xsl:call-template name="SellerID" />
                                    </p>
                                    <p>
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-34'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                    <p>
                                        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
                                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
                                            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' "> 
                                            (
                                                <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>
                                            )
                                            </xsl:if>
                                        </xsl:if>
                                    </p>
                                    <xsl:if test="cac:TaxRepresentativeParty !=''">
                                        <br/>
                                        <p>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BG-11'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                        <xsl:apply-templates select="cac:TaxRepresentativeParty"/>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <p class="red_title">
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="red_box_no_back">
                                    <p>
                                        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName !=''">
                                            <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName"/>
                                        </xsl:if>
                                    </p>
                                    <xsl:call-template name="SellerAdditionalInfo" />
                                    <xsl:if test="(cac:AccountingSupplierParty/cac:Party/cac:Contact !='') or (cac:AccountingSupplierParty/cac:Party/cac:Person/cbc:FirstName !='')">
                                        <p>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BG-6'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                    </xsl:if>
                                    <p>
                                        <xsl:call-template name="SellerContact" />
                                    </p>
                                    <p>
                                        <xsl:call-template name="SellerPostalID" />
                                    </p>
                                    <p>
                                        <xsl:call-template name="SellerID" />
                                    </p>
                                    <p>
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-34'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                    <p>
                                        <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
                                            <xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
                                            <xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' ">(
                                                <xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>
                                                )
                                            </xsl:if>
                                        </xsl:if>
                                    </p>
                                    <xsl:if test="cac:TaxRepresentativeParty !=''">
                                        <br/>
                                        <p>
                                            <b>
                                                <xsl:call-template name="LabelName">
                                                    <xsl:with-param name="BT-ID" select="'BG-11'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                        </p>
                                        <xsl:apply-templates select="cac:TaxRepresentativeParty"/>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                        </div>
                        <div class="buyer_information">
                            <xsl:if test="local-name(.)  = 'Invoice'">
                                <p class="blue_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="blue_box_no_back">
                                    <xsl:call-template name="BuyerAdditionalInfo" />
                                    <xsl:call-template name="BuyerID" />
                                    <p>
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-49'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                    <p>
                                        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
                                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
                                            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' "> (
                                                <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>
                                                )
                                            </xsl:if>
                                        </xsl:if>
                                    </p>
                                </div>
                                <br/>
                                <!-- Additional Supporting Documents -->
                                <div class="supporting_documents">
                                    <xsl:if test="cac:AdditionalDocumentReference !=''">
                                        <p class="blue_title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-24'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="blue_box_no_back">
                                            <xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode != '130' and cbc:DocumentTypeCode != '50' or  not(cbc:DocumentTypeCode)]" mode="Supporting"/>
                                            <xsl:if test="cac:BillingReference !=''">
                                                <xsl:for-each select="cac:BillingReference/cac:InvoiceDocumentReference">
                                                    <br/>
                                                    <b>
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-25'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </b>
                                                    <!-- Inserting Preceding invoice number  -->
                                                    <xsl:value-of select="cbc:ID"/>
                                                    <!-- Inserting Preceding Invoice Issue Date  -->
                                                    <xsl:if test="cbc:IssueDate != ''">
										 ( 
                                                        
                                                        <xsl:value-of select="cbc:IssueDate"/> )
                                                    
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:if>
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
                                        </div>
                                    </xsl:if>
                                </div>
                                <!-- /Additional Supporting Documents -->
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'CreditNote'">
                                <p class="red_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="red_box_no_back">
                                    <p>
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-016'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                    <xsl:call-template name="BuyerPostalID"/>
                                    <xsl:call-template name="BuyerID"/>
                                    <p>
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-49'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                    </p>
                                    <p>
                                        <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
                                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
                                            <xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' "> (
                                                <xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>
                                                )
                                            </xsl:if>
                                        </xsl:if>
                                    </p>
                                </div>
                                <br/>
                                <!-- Additional Supporting Documents -->
                                <div class="supporting_documents">
                                    <xsl:if test="cac:AdditionalDocumentReference !=''">
                                        <p class="red_title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-24'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="red_box_no_back">
                                            <xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode != '130' and cbc:DocumentTypeCode != '50' or  not(cbc:DocumentTypeCode)]" mode="Supporting"/>
                                            <xsl:if test="cac:BillingReference !=''">
                                                <xsl:for-each select="cac:BillingReference/cac:InvoiceDocumentReference">
                                                    <br/>
                                                    <b>
                                                        <xsl:call-template name="LabelName">
                                                            <xsl:with-param name="BT-ID" select="'BT-25'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                        </xsl:call-template>
                                                    </b>
                                                    <!-- Inserting Preceding invoice number  -->
                                                    <xsl:value-of select="cbc:ID"/>
                                                    <!-- Inserting Preceding Invoice Issue Date  -->
                                                    <xsl:if test="cbc:IssueDate != ''">
										 ( 
                                                        <xsl:value-of select="cbc:IssueDate"/> )
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </xsl:if>
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
                                        </div>
                                    </xsl:if>
                                </div>
                                <!-- /Additional Supporting Documents -->
                            </xsl:if>
                        </div>
                    </div>
                    <!-- /Additional Information -->
                    <br/>
                    <br/>
                    <br/>
                    <br/>
                    <br/>
                </div>
            </body>
        </html>
        <!-- END HTML -->
    </xsl:template>
</xsl:stylesheet>