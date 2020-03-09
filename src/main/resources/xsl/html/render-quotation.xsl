<?xml version="1.0" encoding="UTF-8"?>
<!--
   UniStyles - XSLT transforms for rendering UBL documents.
   Copyright (C) 2019-present, Unimaze ehf.

   render-quotation.xsl - render quotation and request quotation of PEPPOL BIS EN16931 (UBL 2.1 format).

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
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Quotation-2" 
    xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:RequestForQuotation-2" 
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" 
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" 
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="n1 n2 cac cbc ext xsi">
    <xsl:import href="billing-3/CommonTemplates.xsl"/>
    <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>
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

					.orange_box {
						border: 1px solid #c7a390;
						background-color: #fff6f0;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}

					.dark_orange_box {
						border: 1px solid #b0856f;
						background-color: #f5ebe4;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}

					.orange_box_no_back {
						border: 1px solid #c7a390;
						padding: 0.5em;
					}

					.dark_orange_box_no_back {
						border: 1px solid #b0856f;
						padding: 0.5em;
					}

					.text_center {
						padding: 0.5em;
						text-align: center;
					}
					.text_right {
						text-align: right;
					}

                    .orange_title,
                    .dark_orange_title {
                        padding: 0.8em 0 0.4em 0.4em;
                        text-align: left;
                        font-size: 1.2em;
                        font-weight: bold;
                    }
                    .orange_title {
                        color: #c7a390;
                    }
                    .dark_orange_title {
                        color: #b0856f;
                    }

                    .box_with_top_margin {
                        margin-top: 0.3em;
                    }

                    .box_with_margin {
						margin: 1.2em 0 1.2em 1.2em;
					}

                    .main_header .buyer {
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

                    .payment_info_holder {
                        display: flex;
                        flex-direction: column;
                    }

                    .payment_info_holder .orange_box {
                        height: 80px;
                    }

                    .payment_info_holder .amount_payable .orange_box,
                    .payment_info_holder .amount_payable .dark_orange_box {
                        margin-bottom: 0.3em;
                    }

                    .amount_payable {
                        position: relative;
                    }

                    .table_header {
                        font-weight: normal;
                        background-color: #fff6f0;
                        padding: 0.5em;
                        border-bottom: 1px solid #c7a390;
                    }

                    .dark_orange_box_no_back .table_header {
						background-color: #f5ebe4;
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

                    .quotation_items_table .orange_box_no_back, 
                    .quotation_items_table .dark_orange_box_no_back {
                        padding:0;
                    }

                    .quotation_items_table .quotation_items_table_body_data:first-of-type {
                        height: 15px;
                    }

                    .quotation_items_table .quotation_items_table_body_data_name_column_header {
                        width: 100%;
                        margin-bottom: 0.1em;
                    }

                    .quotation_items_table .quotation_items_table_body_data_name_column_body {
                        width: 150%;
                    }

                    .payable_amount {
                        font-weight: 700;
                    }

                    .document_info_currency {
                        text-align: right;
                        position: absolute;
                        right: 0;
                    }

                    <!-- HIDE-SHOW TABLE DETAILS -->
                    .quotation_items_table_body_data label,
                    .collapse_expand_all_label {
                        cursor:pointer;
                    }
                    .quotation_items_table_body_data label {
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

                    .hide_content_input:checked + .quotation_items_table_body_holder .quotation_items_table_body_data .expand_arrow,
                    .hide_all_content_input:checked + .quotation_items_table_header .quotation_items_table_header_title .collapse_expand_all_label .double_expand_arrow {
                        transition: all .3s;
                        transform: rotate(-180deg);
                        -webkit-transform: rotate(-180deg);
                        -moz-transform: rotate(-180deg);
                        -ms-transform: rotate(-180deg);
                        -o-transform: rotate(-180deg);
                    }

                    .hide_all_content_input:checked ~ .quotation_items_table_body .quotation_items_table_body_holder .quotation_items_table_body_data .expand_arrow {
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
                    
                    .quotation_items_table_body > .hide_content_input:checked + .quotation_items_table_body_holder .quotation_items_table_body_data .hide_content,
                    .quotation_items_table .hide_all_content_input:checked ~ .quotation_items_table_body .quotation_items_table_body_holder .quotation_items_table_body_data .hide_content {
                        min-height: 0;
                        height: 0;
                        opacity: 0;
                        display: block;
                        transition: all 0.3s ease;
                    }
                    <!-- /HIDE-SHOW TABLE DETAILS -->

                    .quotation_items_table_header {
                        display: grid;
                        grid-template-columns: 7% 10% auto 15% 13% 10%;
                        align-items: center;
                        page-break-inside: avoid;
                    }

                    .dark_orange_box_no_back .quotation_items_table_header {
                        grid-template-columns: 7% 15% auto 15% 15%;
                    }

                    .quotation_items_table_body_holder {
                        display: grid;
                        padding: 0.3em 0.5em;
                        grid-template-columns: 7% 10% auto 15% 13% 10%;
                        align-items: flex-start;
                    }

                    .dark_orange_box_no_back .quotation_items_table_body_holder {
                        grid-template-columns: 7% 15% auto 15% 15%;
                    }

                    .quotation_items_table_body_holder:first-of-type {
                        padding-top: 0.6em;
                    }

                    .quotation_items_table_body_holder:last-of-type {
                        padding-bottom: 0.6em;
                    }

                    .information_banner .orange_box,
                    .information_banner .dark_orange_box {
                        min-height:4em;
                    }

                    .information_banner .orange_box .orange_title,
                    .information_banner .dark_orange_box .dark_orange_title {
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

                        .hide_content_input:checked + .quotation_items_table_body_holder .quotation_items_table_body_data .expand_arrow,
                        .expand_arrow,
                        .collapse_expand_all_label {
                            transform: rotate(0);
                            display: none;
                        }
                        .quotation_items_table_body > .hide_content_input:checked + .quotation_items_table_body_holder .quotation_items_table_body_data .hide_content,
                        .quotation_items_table .hide_all_content_input:checked ~ .quotation_items_table_body .quotation_items_table_body_holder .quotation_items_table_body_data .hide_content {
                            min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                            overflow: hidden;
                            height: unset;
                            opacity: 1;
                        }
                        .quotation_items_table_body_data label {
                            top: 0;
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
                        page-break-inside: avoid;
                    }
                    
                    .grid_small_2fr_spliter {
                        display: grid;
                        grid-template-columns: 1fr 1fr;
                        grid-gap: 1em;
                        page-break-inside: avoid;
                    }
                    <!-- /GRID CSS -->
                </style>
            </xsl:when>
            <xsl:otherwise>
                <link rel="stylesheet" href="{$stylesheet_url}"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="cac:QuotationLine | cac:RequestForQuotationLine">
        <input type="checkbox" name="collapse_expand_all" class="hide_all_content_input" id="collapse_expand_all"/>
        <div class="quotation_items_table_header table_header">
            <div class="quotation_items_table_header_title">
                <label for="collapse_expand_all" class="collapse_expand_all_label">
                    <div class="double_expand_arrow">&#171;</div>
                </label>
            </div>
            <div class="quotation_items_table_header_title">
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-155'"/>
                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                    </xsl:call-template>
                </b>
            </div>
            <div class="quotation_items_table_header_title">
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-153'"/>
                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                    </xsl:call-template>
                </b>
            </div>
            <div class="quotation_items_table_header_title">
                <b>
                    <xsl:call-template name="LabelName">
                        <xsl:with-param name="BT-ID" select="'BT-129'"/>
                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                    </xsl:call-template>
                </b>
            </div>
            <xsl:if test="local-name(.) = 'QuotationLine'">
                <div class="quotation_items_table_header_title">
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-146'"/>
                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                        </xsl:call-template>
                    </b>
                </div>
                <div class="quotation_items_table_header_title text_right">
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-131'"/>
                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                        </xsl:call-template>
                    </b>
                </div>
            </xsl:if>
            <xsl:if test="local-name(.) = 'RequestForQuotationLine'">
                <div class="quotation_items_table_header_title text_right">
                    <b>
                        <xsl:call-template name="LabelName">
                            <xsl:with-param name="BT-ID" select="'BT-146'"/>
                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                        </xsl:call-template>
                    </b>
                </div>
            </xsl:if>
        </div>
        <div class="quotation_items_table_body">
            <!--QuotationLine start: -->
            <xsl:for-each select="cac:LineItem">
                <input type="checkbox" name="one" class="hide_content_input">
                    <xsl:attribute name="id">
                        <xsl:apply-templates select="cbc:ID" />
                    </xsl:attribute>
                </input>
                <div class="quotation_items_table_body_holder">
                    <div class="quotation_items_table_body_data">
                        <label>
                            <xsl:attribute name="for">
                                <xsl:apply-templates select="cbc:ID" />
                            </xsl:attribute>
                            <div class="expand_arrow">&#8249;</div>
                            <xsl:apply-templates select="cbc:ID" />.
                        </label>
                    </div>
                    <div class="quotation_items_table_body_data">
                        <xsl:apply-templates select="cac:Item/cac:SellersItemIdentification" />
                    </div>
                    <div class="quotation_items_table_body_data">
                        <div class="quotation_items_table_body_data_name_column_header">
                            <xsl:apply-templates select="cac:Item/cbc:Name" />
                        </div>
                        <small class="hide_content quotation_items_table_body_data_name_column_body">
                            <xsl:if test="../cac:LineItem !=''">
                                <xsl:if test="../cbc:Note !=''">
                                    <b>
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-127'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="../cbc:Note" />
                                    <br />
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="../cac:LineItem !=''">
                                <xsl:if test="../cbc:RequestForQuotationLineID !=''">
                                    <b>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-067'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="../cbc:RequestForQuotationLineID" />
                                    <br />
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:StandardItemIdentification/cbc:ID !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-157'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID" />
                                <xsl:choose>
                                    <xsl:when test="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID !=''">
                                        <small>
                                            &#160;[<xsl:apply-templates select="cac:Item/cac:StandardItemIdentification/cbc:ID/@schemeID" />]
                                        </small>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <small>&#160;[No schemeID]</small>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Item/cbc:Description !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-154'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:Item/cbc:Description" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:AdditionalItemProperty !=''">
                                <xsl:apply-templates select="cac:Item/cac:AdditionalItemProperty" />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:ItemInstance !=''">
                                <xsl:if test="cac:Item/cac:ItemInstance/cbc:SerialID !=''">
                                    <b>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-033'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="cac:Item/cac:ItemInstance/cbc:SerialID" />
                                    <br />
                                </xsl:if>
                                <xsl:if test="cac:Item/cac:ItemInstance/cac:LotIdentification/cbc:LotNumberID !=''">
                                    <b>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-034'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="cac:Item/cac:ItemInstance/cac:LotIdentification/cbc:LotNumberID" />
                                    <br />
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="cbc:Note !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-127'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cbc:Note" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:CommodityClassification !=''">
                                <xsl:apply-templates select="cac:Item/cac:CommodityClassification" />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:ItemSpecificationDocumentReference/cbc:ID != ''">
                                <b>
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-040'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:Item/cac:ItemSpecificationDocumentReference/cbc:ID" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:BuyersItemIdentification/cbc:ID != ''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-156'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:Item/cac:BuyersItemIdentification/cbc:ID" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cbc:AccountingCost !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-19'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cbc:AccountingCost" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:InvoicePeriod !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BG-14'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:InvoicePeriod" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Price/cac:AllowanceCharge !=''">
                                <xsl:apply-templates select="cac:Price/cac:AllowanceCharge" mode="PriceUnit-new" />
                            </xsl:if>
                            <xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-159'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode" />
                                <xsl:if test="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID !=''">
                                    <small>
                                        &#160;[<xsl:apply-templates select="cac:Item/cac:OriginCountry/cbc:IdentificationCode/@listID" />]
                                    </small>
                                </xsl:if>
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:OrderLineReference/cbc:LineID !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-132'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:OrderLineReference/cbc:LineID" />
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:DocumentReference/cbc:ID !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-128'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:apply-templates select="cac:DocumentReference/cbc:ID" />
                                    [<xsl:apply-templates select="cac:DocumentReference/cbc:ID/@schemeID" />]
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:AllowanceCharge !=''">
                                <xsl:for-each select="cac:AllowanceCharge">
                                    <xsl:if test="position()!=1">
                                        <br />
                                    </xsl:if>
                                    <b>
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-27'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:if test="cbc:AllowanceChargeReason !=''">
                                        <xsl:apply-templates select="cbc:AllowanceChargeReason" />
                                    </xsl:if>
                                    <xsl:if test="cbc:AllowanceChargeReasonCode !=''">
                                        [<xsl:apply-templates select="cbc:AllowanceChargeReasonCode" />]
                                    </xsl:if>
                                    <xsl:if test="cbc:MultiplierFactorNumeric !=''">
                                        <xsl:apply-templates select="cbc:MultiplierFactorNumeric" />%
                                    </xsl:if>
                                    <br />
                                    <xsl:if test="cbc:Amount !=''">
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-136'" />
                                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                                            </xsl:call-template>
                                        </b>
                                        <xsl:apply-templates select="cbc:Amount" />
                                    </xsl:if>
                                    <xsl:if test="cbc:BaseAmount !=''">
                                        <br />
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-035'" />
                                                <xsl:with-param name="Colon-Suffix" select="'true'" />
                                            </xsl:call-template>
                                        </b>
                                        <xsl:apply-templates select="cbc:BaseAmount" />
                                    </xsl:if>
                                </xsl:for-each>
                                <br />
                            </xsl:if>
                            <xsl:if test="cac:Delivery/cac:RequestedDeliveryPeriod !=''">
                                <b>
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BG-13'" />
                                        <xsl:with-param name="Colon-Suffix" select="'false'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:call-template name="RequestedDeliveryPeriod"/>
                            </xsl:if>
                            <xsl:if test="cac:OriginatorParty !=''">
                                <b>
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-036'" />
                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                    </xsl:call-template>
                                </b>
                                <xsl:if test="cac:OriginatorParty/cac:PartyName/cbc:Name">
                                    <xsl:apply-templates select="cac:OriginatorParty/cac:PartyName/cbc:Name"/>&#160;
                                </xsl:if>
                                <xsl:if test="cac:OriginatorParty/cac:PartyIdentification/cbc:ID">
                                    <xsl:apply-templates select="cac:OriginatorParty/cac:PartyIdentification/cbc:ID"/>
                                    <xsl:if test="cac:OriginatorParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                                        [<xsl:value-of select="cac:OriginatorParty/cac:PartyIdentification/cbc:ID/@schemeID"/>]
                                    </xsl:if>
                                </xsl:if>
                                <br />
                            </xsl:if>
                        </small>
                    </div>
                    <div class="quotation_items_table_body_data">
                        <xsl:if test="cbc:InvoicedQuantity !=''">
                            <xsl:apply-templates select="cbc:InvoicedQuantity" />&#160;
                            <xsl:if test="cbc:InvoicedQuantity/@unitCode !=''">
                                <xsl:value-of select="cbc:InvoicedQuantity/@unitCode" />
                                <small class="hide_content">
                                    <br/>
                                    [<xsl:call-template name="UNECECode">
                                        <xsl:with-param name="Code" select="cbc:InvoicedQuantity/@unitCode" />
                                    </xsl:call-template>]
                                </small>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="cbc:CreditedQuantity !=''">
                            <xsl:apply-templates select="cbc:CreditedQuantity" />&#160;
                            <xsl:if test="cbc:CreditedQuantity/@unitCode !=''">
                                <xsl:value-of select="cbc:CreditedQuantity/@unitCode" />
                                <small class="hide_content">
                                    <br/>
                                    [<xsl:call-template name="UNECECode">
                                        <xsl:with-param name="Code" select="cbc:CreditedQuantity/@unitCode" />
                                    </xsl:call-template>]
                                </small>
                            </xsl:if>
                        </xsl:if>
                        <xsl:if test="cbc:Quantity !=''">
                            <xsl:apply-templates select="cbc:Quantity" />&#160;
                            <xsl:if test="cbc:Quantity/@unitCode !=''">
                                <xsl:value-of select="cbc:Quantity/@unitCode" />
                                <small class="hide_content">
                                    <br />
                                    [<xsl:call-template name="UNECECode">
                                        <xsl:with-param name="Code" select="cbc:Quantity/@unitCode" />
                                    </xsl:call-template>]
                                </small>
                            </xsl:if>
                        </xsl:if>
                    </div>
                    <xsl:if test="local-name(..) = 'QuotationLine'">
                        <div class="quotation_items_table_body_data">
                            <xsl:call-template name="Currency">
                                <xsl:with-param name="currencyvalue" select="cac:Price/cbc:PriceAmount" />
                                <xsl:with-param name="country" select="$languageCode" />
                            </xsl:call-template>
                            <xsl:if test="cac:Price/cbc:BaseQuantity">
                                <small class="hide_content">
                                    <br />
                                    <b>
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-149'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="cac:Price/cbc:BaseQuantity" />
                                </small>
                            </xsl:if>
                        </div>
                        <div class="quotation_items_table_body_data text_right">
                            <xsl:call-template name="Currency">
                                <xsl:with-param name="currencyvalue" select="../../cac:QuotedMonetaryTotal/cbc:PayableAmount" />
                                <xsl:with-param name="country" select="$languageCode" />
                            </xsl:call-template>
                        </div>
                    </xsl:if>
                    <xsl:if test="local-name(..) = 'RequestForQuotationLine'">
                        <div class="quotation_items_table_body_data text_right">
                            <xsl:call-template name="Currency">
                                <xsl:with-param name="currencyvalue" select="cac:Price/cbc:PriceAmount" />
                                <xsl:with-param name="country" select="$languageCode" />
                            </xsl:call-template>
                            <xsl:if test="cac:Price/cbc:BaseQuantity">
                                <small class="hide_content">
                                    <br />
                                    <b>
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BT-149'" />
                                            <xsl:with-param name="Colon-Suffix" select="'true'" />
                                        </xsl:call-template>
                                    </b>
                                    <xsl:apply-templates select="cac:Price/cbc:BaseQuantity" />
                                </small>
                            </xsl:if>
                        </div>
                    </xsl:if>
                </div>
            </xsl:for-each>
            <!--QuotationLine end: -->
        </div>
    </xsl:template>


    <xsl:template match="n1:Quotation | n2:RequestForQuotation">
        <!-- Start HTML -->
        <html>
            <!-- <xsl:if test="/Invoice !=''"></xsl:if> -->
            <xsl:call-template name="doc-head" />
            <head>
                <link rel="Stylesheet" type="text/css" href="PEPPOL.css" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title>QUOTATION AND REQUEST FOR QUOTATION</title>
            </head>
            <body>
                <div class="container">
                    <header class="main_header grid_big_2fr_spliter">
                        <!-- Buyer  -->
                        <div class="buyer grid_small_2fr_spliter">
                            <div>
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
                            <div class="contact">
                                <xsl:choose>
                                    <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:Contact !=''">
                                        <br/>
                                        <small>
                                            <xsl:call-template name="BuyerCustomerPartyContact">
                                                <xsl:with-param name="ShowLabel" select="'true'"/>
                                            </xsl:call-template>
                                        </small>
                                        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID !=''">
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
                                        </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID !=''">
                                            <br/>
                                            <span class="UBLElectronicMail">
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-032'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                                &#160;
                                                <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID"/>
                                            </span>
                                        </xsl:if>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                        </div>
                        <!-- /Buyer  -->
                        <div class="document_details">
                            <br/>
                            <!-- DOCUMENT DETAILS -->
                            <xsl:if test="local-name(.)  = 'Quotation'">
                                <h1>
                                    <xsl:call-template name="DocumentHeader">
                                        <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                    </xsl:call-template>&#160;
                                    <xsl:value-of select="cbc:ID" />
                                </h1>
                                <xsl:if test="cbc:QuotationTypeCode !='310'">
                                    <h3>
                                        <xsl:call-template name="DocumentCode">
                                            <xsl:with-param name="DCode" select="cbc:QuotationTypeCode"/>
                                        </xsl:call-template>
                                    </h3>
                                </xsl:if>
                                <xsl:if test="((cac:RequestForQuotationDocumentReference/cbc:ID !='') and (cac:RequestForQuotationDocumentReference/cbc:ID != 'Unknown'))">
                                    <small>
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-066'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </b>
                                        <!-- Inserting Request For Quotation Document Reference number  -->
                                        <span>
                                            <xsl:value-of select="cac:RequestForQuotationDocumentReference/cbc:ID"/>
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
                            <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                                <h1>
                                    <xsl:call-template name="DocumentHeader">
                                        <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                    </xsl:call-template>&#160;
                                    <xsl:value-of select="cbc:ID" />
                                </h1>
                                <xsl:if test="cbc:RequestForQuotationTypeCode != '311'">
                                    <h3>
                                        <xsl:call-template name="DocumentCode">
                                            <xsl:with-param name="DCode" select="cbc:RequestForQuotationTypeCode"/>
                                        </xsl:call-template>
                                    </h3>
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
                    <!-- buyer_and_due_dates_holder -->
                    <div class="grid_big_2fr_spliter">
                        <div class="seller">
                            <!-- SELLER -->
                            <xsl:if test="local-name(.)  = 'Quotation'">
                                <div class="orange_box">
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
                                        <xsl:call-template name="SellerSupplierPartyID" />
                                    </div>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                                <div class="dark_orange_box">
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
                                        <xsl:call-template name="SellerSupplierPartyID" />
                                    </div>
                                </div>
                            </xsl:if>
                            <!-- /SELLER -->
                        </div>
                        <div class="payment_info_holder">
                            <div class="grid_small_2fr_spliter">
                                <div class="issue_date">
                                    <xsl:if test="local-name(.) = 'Quotation'">
                                        <div class="orange_box corner_title_center_content">
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
                                    </xsl:if>
                                    <xsl:if test="local-name(.) = 'RequestForQuotation'">
                                        <div class="dark_orange_box corner_title_center_content">
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
                                    </xsl:if>
                                    <div>
                                        <small>
                                            <xsl:if test="cbc:IssueTime !=''">
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
                                                    <xsl:call-template name="formatTime">
                                                        <xsl:with-param name="time" select="cbc:IssueTime" />
                                                    </xsl:call-template>
                                                </p>
                                            </xsl:if>
                                            <!-- Inserting ValidityPeriod:  -->
                                            <xsl:if test="cac:ValidityPeriod/cbc:EndDate != ''">
                                                <p align="left">
                                                    <b>
                                                        <xsl:call-template name="UMZLabelName">
                                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-049'"/>
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
                                <div class="amount_payable">
                                    <xsl:if test="local-name(.) = 'Quotation'">
                                        <div class="orange_box corner_title_center_content">
                                            <!-- Inserting Payable amount  -->
                                            <xsl:choose>
                                                <xsl:when test="cac:QuotedMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                                    <p align="left">
                                                        <h1 style="color:red">
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-068'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </h1>
                                                        <div style="color:red" class="payable_amount">
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:QuotedMonetaryTotal/cbc:PayableAmount"/>
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </div>
                                                    </p>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <p align="left">
                                                        <h1>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-068'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </h1>
                                                        <div class="payable_amount">
                                                            <xsl:call-template name="Currency">
                                                                <xsl:with-param name="currencyvalue" select="cac:QuotedMonetaryTotal/cbc:PayableAmount"/>
                                                                <xsl:with-param name="country" select="$languageCode" />
                                                            </xsl:call-template>
                                                        </div>
                                                    </p>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="local-name(.) = 'RequestForQuotation'">
                                        <div class="dark_orange_box corner_title_center_content">
                                            <!-- Inserting Payable amount  -->
                                            <xsl:choose>
                                                <xsl:when test="cac:QuotedMonetaryTotal != ''">
                                                    <xsl:choose>
                                                        <xsl:when test="cac:QuotedMonetaryTotal/cbc:PayableAmount &lt; '0'">
                                                            <p align="left">
                                                                <h1 style="color:red">
                                                                    <xsl:call-template name="UMZLabelName">
                                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-068'"/>
                                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                    </xsl:call-template>
                                                                </h1>
                                                                <div style="color:red" class="payable_amount">
                                                                    <xsl:call-template name="Currency">
                                                                        <xsl:with-param name="currencyvalue" select="cac:QuotedMonetaryTotal/cbc:PayableAmount"/>
                                                                        <xsl:with-param name="country" select="$languageCode" />
                                                                    </xsl:call-template>
                                                                </div>
                                                            </p>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <p align="left">
                                                                <h1>
                                                                    <xsl:call-template name="UMZLabelName">
                                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-068'"/>
                                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                    </xsl:call-template>
                                                                </h1>
                                                                <div class="payable_amount">
                                                                    <xsl:call-template name="Currency">
                                                                        <xsl:with-param name="currencyvalue" select="cac:QuotedMonetaryTotal/cbc:PayableAmount"/>
                                                                        <xsl:with-param name="country" select="$languageCode" />
                                                                    </xsl:call-template>
                                                                </div>
                                                            </p>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <p align="left">
                                                        <h1>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-068'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </h1>
                                                        <div class="payable_amount">
                                                            /
                                                        </div>
                                                    </p>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </div>
                                    </xsl:if>
                                    <div class="document_info_currency">
                                        <div>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-069'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </small>
                                            <xsl:value-of select="cbc:PricingCurrencyCode" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br/>
                            <xsl:if test="cac:RequestForQuotationDocumentReference != ''">
                                <xsl:if test="local-name(.) = 'Quotation'">
                                    <div class="orange_box_no_back description">
                                        <b>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-021'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </small>
                                        </b>
                                        <xsl:if test="cac:RequestForQuotationDocumentReference/cbc:ID != ''">
                                            <small>
                                                [<xsl:apply-templates select="cac:RequestForQuotationDocumentReference/cbc:ID"/>]&#160;
                                            </small>
                                        </xsl:if>
                                        <xsl:if test="cac:RequestForQuotationDocumentReference/cbc:IssueDate != ''">
                                            <br/>
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-037'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <small>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cac:RequestForQuotationDocumentReference/cbc:IssueDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </small>
                                        </xsl:if>
                                    </div>
                                </xsl:if>
                                <xsl:if test="local-name(.) = 'RequestForQuotation'">
                                    <div class="dark_orange_box_no_back description">
                                        <b>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-021'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </small>
                                        </b>
                                        <xsl:if test="cac:RequestForQuotationDocumentReference/cbc:ID != ''">
                                            <small>
                                                [<xsl:apply-templates select="cac:RequestForQuotationDocumentReference/cbc:ID"/>]&#160;
                                            </small>
                                        </xsl:if>
                                        <xsl:if test="cac:RequestForQuotationDocumentReference/cbc:IssueDate != ''">
                                            <br/>
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-037'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <small>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cac:RequestForQuotationDocumentReference/cbc:IssueDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </small>
                                        </xsl:if>
                                    </div>
                                </xsl:if>
                            </xsl:if>
                        </div>

                    </div>
                    <!-- /buyer_and_due_dates_holder -->
                    <br/>
                    <div>
                        <!--Start Quotationline-->
                        <div class="quotation_items_table">
                            <xsl:if test="local-name(.)  = 'Quotation'">
                                <div class="orange_box_no_back">
                                    <xsl:apply-templates select="cac:QuotationLine"/>
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                                <div class="dark_orange_box_no_back">
                                    <xsl:apply-templates select="cac:RequestForQuotationLine"/>
                                    <!-- <xsl:call-template name="QuotationLineTable"/> -->
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                    <!--End QuotationLine-->
                    <!-- class="orange_box_no_back" -->

                    <br/>
                    <div class="information_banner">
                        <xsl:if test="local-name(.)  = 'Quotation'">
                            <div class="orange_box">
                                <h1 class="orange_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                    </xsl:call-template>
                                </h1>
                            </div>
                        </xsl:if>
                        <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                            <div class="dark_orange_box">
                                <h1 class="dark_orange_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                    </xsl:call-template>
                                </h1>
                            </div>
                        </xsl:if>
                    </div>
                    <!-- Delivery Location and Payee-->
                    <div class="grid_big_2fr_spliter">
                        <xsl:if test="local-name(.)  = 'Quotation'">
                            <div class="delivery_location">
                                <xsl:if test="cac:Delivery != ''">
                                    <p class="orange_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-15'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="orange_box_no_back">
                                        <xsl:apply-templates select="cac:Delivery/cac:DeliveryLocation"/>
                                        <xsl:call-template name="ActualDeliveryDate"/>
                                    </div>
                                </xsl:if>
                            </div>
                            <div>
                                <xsl:if test="cac:PayeeParty != ''">
                                    <p class="orange_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-10'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="orange_box_no_back">
                                        <xsl:call-template name="PayeeParty"/>
                                    </div>
                                </xsl:if>
                            </div>
                        </xsl:if>
                        <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                            <div class="delivery_location">
                                <xsl:if test="cac:Delivery != ''">
                                    <p class="dark_orange_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-15'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="dark_orange_box_no_back">
                                        <xsl:apply-templates select="cac:Delivery/cac:DeliveryLocation"/>
                                        <xsl:call-template name="ActualDeliveryDate"/>
                                    </div>
                                </xsl:if>
                            </div>
                            <div>
                                <xsl:if test="cac:PayeeParty != ''">
                                    <p class="dark_orange_title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-10'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="dark_orange_box_no_back">
                                        <xsl:call-template name="PayeeParty"/>
                                    </div>
                                </xsl:if>
                            </div>
                        </xsl:if>
                    </div>
                    <br/>
                    <!-- /Delivery Location and Payee -->
                    <!-- Additional Information -->
                    <div class="grid_big_2fr_spliter">
                        <div class="seller_information">
                            <xsl:if test="local-name(.)  = 'Quotation'">
                                <p class="orange_title">
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="orange_box_no_back">
                                    <xsl:call-template name="SellerSupplierPartyAdditionalInfo" />
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                                <p class="dark_orange_title">
                                    <xsl:call-template name="LabelName">
                                        <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="dark_orange_box_no_back">
                                    <xsl:call-template name="SellerSupplierPartyAdditionalInfo" />
                                </div>
                            </xsl:if>
                        </div>
                        <div class="buyer_information">
                            <xsl:if test="local-name(.)  = 'Quotation'">
                                <p class="orange_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="orange_box_no_back">
                                    <xsl:call-template name="BuyerCustomerPartyAdditionalInfo" />
                                </div>
                            </xsl:if>
                            <xsl:if test="local-name(.)  = 'RequestForQuotation'">
                                <p class="dark_orange_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="dark_orange_box_no_back">
                                    <xsl:call-template name="BuyerCustomerPartyAdditionalInfo" />
                                </div>
                            </xsl:if>
                            <br/>
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