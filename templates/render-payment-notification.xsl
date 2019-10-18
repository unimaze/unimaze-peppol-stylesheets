<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:RemittanceAdvice-2"
                exclude-result-prefixes="n1 cac cbc ext fn">
    <xsl:import href="billing-3/CommonTemplates.xsl"/>
    <xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="stylesheet_url" select="'NONE'"/>
    <xsl:template name="doc-head">
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
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

					.yellow_box {
						border: 1px solid #b7d1a6;
						background-color: #fefef4;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
					}

					.yellow_box_no_back {
						border: 1px solid #b7d1a6;
						padding: 0.5em;
					}

					.text_center {
						padding: 0.5em;
						text-align: center;
					}
					.text_right {
						text-align: right;
					}

                    .yellow_title {
                        padding: 0.8em 0 0.4em 0.4em;
                        text-align: left;
                        font-size: 1.2em;
                        font-weight: bold;
                        color: #9fa85f;
                    }

                    .box_with_top_margin {
                        margin-top: 0.3em;
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

                    .payment_info_holder {
                        display: flex;
                        flex-direction: column;
                    }

                    .payment_info_holder .yellow_box {
                        height: 80px;
                    }

                    .payment_info_holder .amount_payable .yellow_box {
                        margin-bottom: 0.3em;
                    }

                    .amount_payable {
                        position: relative;
                    }

                    .table_header {
						background-color: #fefef4;
                    } 

                    .table_body {
                        font-weight: normal;
                        padding: 0 0.5em;
                    } 

					.box_with_margin {
						margin: 1.2em 0 1.2em 1.2em;
					}

					.title {
						margin: 0.1em 0 0.6em 0;
						text-transform: capitalize;
						font-size: 0.9em;
					}

                    .payment_table .yellow_box_no_back, 
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

					.payment_table .yellow_box_no_back .payment_table_header {
                        border-top: 1px solid #b7d1a6;
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

                    .payment_means_code {
                        padding: 0.5em;
                    }

					.payment_table_header .payment_means_code {
                        border-bottom: 1px solid #b7d1a6;
                        border-left: 1px solid #b7d1a6;
                        border-top: none;
					}

					.yellow_box_no_back .payment_table_header .payment_means_code {
                        border-color: #b7d1a6;
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

                    .payment_table_row_yellow {
                        border-top: 1px solid #b7d1a6;
                    }

                    .remittance_advice_line_table .yellow_box_no_back {
                        padding:0;
                    }

                    .remittance_advice_line_table .remittance_advice_line_table_body_data_name_column_header {
                        width: 100%;
                        margin-bottom: 0.1em;
                    }

                    .remittance_advice_line_table_header {
                        display: grid;
                        grid-template-columns: 1fr 2fr 5fr 4fr 2fr;
                        align-items: center;
                        padding: 1em 0.5em;
                    }

                    .remittance_advice_line_table_body_holder {
                        display: grid;
                        padding: 0.5em;
                        grid-template-columns: 1fr 2fr 5fr 4fr 2fr;
                        align-items: flex-start;
                    }

                    .remittance_advice_line_table .remittance_advice_line_table_body_data_name_column_body {
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

                    .total_amount .grid_spliter {
                        display: grid;
                        grid-template-columns: 2fr 1fr;
                        padding-right: 0.5em;
                    }

                    .information_banner .yellow_box {
                        min-height:4em;
                    }

                    .information_banner .yellow_box .yellow_title {
                        font-size:1.5em;
                        margin:0;
                    }

                    .seller_information .seller_contact_label {
                        display: none;
                    }

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
            
            <!-- HIDE-SHOW TABLE DETAILS -->
            <!-- .remittance_advice_line_table_body_data label,
                    .collapse_expand_all_label {
                        cursor:pointer;
                    }
                    .remittance_advice_line_table_body_data label {
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
                        transform-origin: center;
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

                    .hide_content_input:checked + .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .expand_arrow,
                    .hide_all_content_input:checked + .remittance_advice_line_table_header .remittance_advice_line_table_header_title .collapse_expand_all_label .double_expand_arrow {
                        transition: all .3s;
                        transform: rotate(-180deg);
                        -webkit-transform: rotate(-180deg);
                        -moz-transform: rotate(-180deg);
                        -ms-transform: rotate(-180deg);
                        -o-transform: rotate(-180deg);
                        transform-origin: center;
                    }

                    .hide_all_content_input:checked ~ .remittance_advice_line_table_body .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .expand_arrow {
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
                    
                    .remittance_advice_line_table_body > .hide_content_input:checked + .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .hide_content,
                    .remittance_advice_line_table .hide_all_content_input:checked ~ .remittance_advice_line_table_body .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .hide_content {
                        min-height: 0;
                        height: 0;
                        opacity: 0;
                        display: block;
                        transition: all 0.3s ease;
                    }
             -->
            <!-- /HIDE-SHOW TABLE DETAILS -->
					

                    <!-- PRINT STYLE -->
                    @media print {
                        .container {
                            width:80em;
                        }

            <!-- 
                        .hide_content_input:checked + .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .expand_arrow,
                        .expand_arrow,
                        .collapse_expand_all_label {
                            transform: rotate(0);
                            transform-origin: center;
                            display: none;
                        }
                        .remittance_advice_line_table_body > .hide_content_input:checked + .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .hide_content,
                        .remittance_advice_line_table .hide_all_content_input:checked ~ .remittance_advice_line_table_body .remittance_advice_line_table_body_holder .remittance_advice_line_table_body_data .hide_content {
                            min-height: 2em; /* any arbitrary height but best at the minimum initial height you would want. */
                            overflow: hidden;
                            height: unset;
                            opacity: 1;
                        }     -->
                    }
                    
            <!-- /GENERAL CSS -->
        </style>
    </xsl:template>
    <xsl:template match="n1:RemittanceAdvice">
        <!-- Start HTML -->
        <html>
            <xsl:call-template name="doc-head" />
            <head>
                <link rel="Stylesheet" type="text/css" href="PEPPOL.css" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title>PAYMENT NOTIFICATION</title>
            </head>
            <body>
                <div class="container">
                    <header class="main_header grid_big_2fr_spliter">
                        <!-- BUYER -->
                        <div>
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
                        <!-- /BUYER -->
                        <div class="document_details">
                            <br/>
                            <!-- DOCUMENT DETAILS -->
                            <h1>
                                <xsl:call-template name="DocumentHeader">
                                    <xsl:with-param name="DocumentCode" select="local-name(.)" />
                                </xsl:call-template>&#160;
                                <xsl:value-of select="cbc:ID" />
                            </h1>
                            <xsl:if test="((cbc:InvoicingPartyReference !='') and (cbc:InvoicingPartyReference != 'Unknown'))">
                                <small>
                                    <b>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-023'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                        <!-- Inserting InvoicingPartyReference:  -->
                                        <span>
                                            <xsl:value-of select="cbc:InvoicingPartyReference"/>
                                        </span>
                                    </b>
                                    <br/>
                                </small>
                            </xsl:if>
                            <!-- /DOCUMENT DETAILS -->
                        </div>
                    </header>
                    <br/>
                    <br/>
                    <!-- seller_and_due_dates_holder -->
                    <div class="grid_big_2fr_spliter">
                        <div class="yellow_box">
                            <div class="grid_small_2fr_spliter">
                                <!-- SELLER -->
                                <div class="seller">
                                    <p class="title">
                                        <xsl:call-template name="LabelName">
                                            <xsl:with-param name="BT-ID" select="'BG-4'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                        </xsl:call-template>
                                    </p>
                                    <div class="box_with_margin">
                                        <p>
                                            <xsl:call-template name="Seller"/>
                                        </p>
                                    </div>
                                </div>
                                <!-- /SELLER -->
                                <!-- PAYEE-->
                                <div>
                                    <xsl:if test="cac:PayeeParty != ''">
                                        <p class="title">
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-10'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="box_with_margin">
                                            <b>
                                                <xsl:if test="cac:PayeeParty/cac:PartyName !=''">
                                                    <xsl:apply-templates select="cac:PayeeParty/cac:PartyName" />
                                                </xsl:if>
                                            </b>
                                            <xsl:if test="cac:PayeeParty/cac:PartyIdentification/cbc:ID !='' ">
                                                <br />
                                                <xsl:apply-templates select="cac:PayeeParty/cac:PartyIdentification/cbc:ID" />
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                </div>
                                <!-- /PAYEE -->
                            </div>
                        </div>
                        <div class="payment_info_holder">
                            <div class="grid_small_2fr_spliter">
                                <div class="yellow_box corner_title_center_content">
                                    <!-- Inserting Issue date Label:  -->
                                    <h1>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-022'"/>
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
                                <div class="amount_payable">
                                    <div class="yellow_box corner_title_center_content">
                                        <!-- Inserting Total Payable amount  -->
                                        <xsl:choose>
                                            <xsl:when test="cbc:TotalPaymentAmount &lt; '0'">
                                                <p align="left">
                                                    <h1 style="color:red">
                                                        <xsl:call-template name="UMZLabelName">
                                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-025'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                        </xsl:call-template>
                                                    </h1>
                                                    <div style="color:red" class="payable_amount">
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cbc:TotalPaymentAmount"/>
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </div>
                                                </p>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <p align="left">
                                                    <h1>
                                                        <xsl:call-template name="UMZLabelName">
                                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-025'"/>
                                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                        </xsl:call-template>
                                                    </h1>
                                                    <div class="payable_amount">
                                                        <xsl:call-template name="Currency">
                                                            <xsl:with-param name="currencyvalue" select="cbc:TotalPaymentAmount"/>
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
                    </div>
                    <!-- /seller_and_due_dates_holder -->
                    <br/>
                    <div class="grid_big_2fr_spliter">
                        <xsl:if test="cac:PaymentMeans != ''">
                            <div class="payment_table">
                                <div class="yellow_box_no_back">
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
                                            <div class="payment_means_code" data-name="transfer">
                                                <p>
                                                    [<xsl:apply-templates select="cbc:PaymentMeansCode"/>]
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
                        <!-- Description -->
                        <div class="yellow_box_no_back description">
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
                                    <xsl:choose>
                                        <xsl:when test="cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification !=''">
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-003'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
                                            <xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cac:PartyIdentification" />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-003'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </b>
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
                    <br/>
                    <!-- End on PAYMENT MEANS information -->
                    <br/>
                    <div>
                        <!--Start RemittanceAdviceLine-->
                        <div class="remittance_advice_line_table">
                            <div class="yellow_box_no_back">
                                <!-- <input type="checkbox" name="collapse_expand_all" class="hide_all_content_input" id="collapse_expand_all"/> -->
                                <div class="remittance_advice_line_table_header table_header">
                                    <div class="remittance_advice_line_table_header_title">
                                        <!-- <label for="collapse_expand_all" class="collapse_expand_all_label"><div class="double_expand_arrow">&#171;</div></label> -->
                                    </div>
                                    <div class="remittance_advice_line_table_header_title">
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-023'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </b>
                                    </div>
                                    <div class="remittance_advice_line_table_header_title">
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BG-7'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </b>
                                    </div>
                                    <div class="remittance_advice_line_table_header_title">
                                        <b>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-021'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </b>
                                    </div>
                                    <div class="remittance_advice_line_table_header_title text_right">
                                        <b>
                                            <xsl:call-template name="LabelName">
                                                <xsl:with-param name="BT-ID" select="'BT-131'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                            </xsl:call-template>
                                        </b>
                                    </div>
                                </div>
                                <div class="remittance_advice_line_table_body">
                                    <xsl:for-each select="cac:RemittanceAdviceLine">
                                        <!-- <input type="checkbox" name="one" class="hide_content_input"><xsl:attribute name="id"><xsl:apply-templates select="cbc:ID" /></xsl:attribute></input> -->
                                        <div class="remittance_advice_line_table_body_holder">
                                            <div class="remittance_advice_line_table_body_data">
                                                <!-- <label><xsl:attribute name="for"><xsl:apply-templates select="cbc:ID" /></xsl:attribute><div class="expand_arrow">&#8249;</div></label> -->
                                                <xsl:apply-templates select="cbc:ID" />.
                                            
                                            </div>
                                            <div class="remittance_advice_line_table_body_data">
                                                <xsl:apply-templates select="cbc:InvoicingPartyReference" />
                                            </div>
                                            <div class="remittance_advice_line_table_body_data">
                                                <div class="remittance_advice_line_table_body_data_name_column_header">
                                                    <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyName/cbc:Name" />
                                                    <xsl:if test="cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID !=''">
                                                            <xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID" /> - 
                                                        <xsl:choose>
                                                            <xsl:when test="cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID !=''">
                                                                    &#160;[<xsl:apply-templates select="cac:BuyerCustomerParty/cac:Party/cac:PartyIdentification/cbc:ID/@schemeID" />]
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                    &#160;[No schemeID]
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                        <br />
                                                    </xsl:if>
                                                </div>
                                            </div>
                                            <div class="remittance_advice_line_table_body_data">
                                                <xsl:if test="cac:DocumentReference !=''">
                                                    <xsl:if test="cac:DocumentReference/cbc:DocumentType !=''">
                                                        <xsl:apply-templates select="cac:DocumentReference/cbc:DocumentType" />&#160;
                                                    </xsl:if>
                                                    <xsl:if test="cac:DocumentReference/cbc:ID !=''">
                                                        <xsl:apply-templates select="cac:DocumentReference/cbc:ID" />&#160;
                                                    </xsl:if>
                                                    [<xsl:if test="cac:DocumentReference//cbc:IssueDate !=''">
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="dateTime" select="cac:DocumentReference/cbc:IssueDate" />
                                                            <xsl:with-param name="country" select="$languageCode" />
                                                        </xsl:call-template>
                                                    </xsl:if>]
                                                </xsl:if>
                                            </div>
                                            <div class="remittance_advice_line_table_body_data text_right">
                                                <xsl:call-template name="Currency">
                                                    <xsl:with-param name="currencyvalue" select="cbc:BalanceAmount" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </div>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End RemittanceAdviceLine-->
                    <br/>
                    <div class="grid_big_2fr_spliter">
                        <div></div>
                        <!-- Start Total Amount: -->
                        <div class="total_amount">
                            <div class="grid_spliter">
                                <xsl:if test="cbc:TotalPaymentAmount != ''">
                                    <div>
                                        <b>
                                            <p align="right">
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-025'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                </xsl:call-template>
                                            </p>
                                        </b>
                                    </div>
                                    <div>
                                        <b>
                                            <p align="right">
                                                <xsl:call-template name="Currency">
                                                    <xsl:with-param name="currencyvalue" select="cbc:TotalPaymentAmount"/>
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </p>
                                        </b>
                                    </div>
                                </xsl:if>
                            </div>
                        </div>
                    </div>
                    <!-- Information Banner -->
                    <br/>
                    <div class="information_banner">
                        <div class="yellow_box">
                            <h1 class="yellow_title">
                                <xsl:call-template name="UMZLabelName">
                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                </xsl:call-template>
                            </h1>
                        </div>
                    </div>
                    <br/>
                    <!-- Additional Information -->
                    <div class="grid_big_2fr_spliter">
                        <div class="seller_information">
                            <p class="yellow_title">
                                <xsl:call-template name="LabelName">
                                    <xsl:with-param name="BT-ID" select="'BT-33'"/>
                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                </xsl:call-template>
                            </p>
                            <div class="yellow_box_no_back">
                                <xsl:call-template name="SellerAdditionalInfo" />
                            </div>
                        </div>
                        <div class="buyer_information">
                            <p class="yellow_title">
                                <xsl:call-template name="UMZLabelName">
                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-009'"/>
                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                </xsl:call-template>
                            </p>
                            <div class="yellow_box_no_back">
                                <xsl:call-template name="BuyerAdditionalInfo" />
                            </div>
                            <br/>
                        </div>
                    </div>
                    <!-- /Additional Information -->
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