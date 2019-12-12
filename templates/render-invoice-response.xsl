<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
    xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
    xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:ApplicationResponse-2"
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

					.violet_box {
						border: 1px solid #d1a6ce;
						background-color: #fbeaf8;
						padding: 0.2em;
						min-height: 6em;
						margin-bottom: 0.8em;
                        -webkit-print-color-adjust: exact;
					}

					.violet_box_no_back {
						border: 1px solid #d1a6ce;
						padding: 0.5em;
					}

					.text_center {
						padding: 0.5em;
						text-align: center;
					}

					.text_right {
						text-align: right;
					}

                    .violet_title {
                        padding: 0.8em 0 0.4em 0.4em;
                        text-align: left;
                        font-size: 1.2em;
                        font-weight: bold;
                        color: #9b549c;
                    }

                    .box_with_margin {
						margin: 1.2em 0 1.2em 1.2em;
					}

                    .box_with_top_margin {
						margin-top: 0.3em;
					}
                    
                    .box_with_bottom_margin {
						margin-bottom: 0.3em;
					}

					.title {
						margin: 0.1em 0 0.6em 0;
						text-transform: capitalize;
						font-size: 0.9em;
					}

                    .align_items_bottom {
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

                    .issue_date_holder {
                        display: flex;
                        flex-direction: column;
                    }

                    .issue_date_holder .violet_box {
                        height: 80px;
                    }

                    .issue_date {
                        position: relative;
                    }

                    .issue_time {
                        position: absolute;
                        left: 0;
                    }

                    .table_header {
                        font-weight: normal;
						background-color: #fbeaf8;
                        padding: 0.5em;
                        border-bottom: 1px solid #d1a6ce;
                    } 

                    .table_body {
                        font-weight: normal;
                        padding: 0 0.5em;
                    } 

                    .document_response_table .violet_box_no_back {
                        padding: 0;
                        border-top: none;
                    }

                    .document_response_table .document_response_table_header {
                        display: grid;
                        grid-template-columns: 50% 50%;
                        <!-- margin-bottom: 0.5em; -->
                        border-top: 1px solid #d1a6ce;
                        
                    }

                    .document_response_table .document_response_table_header_title:last-child {
                        margin-right: none;
                    }

					.document_response_table_header .response_code {
                        border-bottom: 1px solid #d1a6ce;
                        border-left: 1px solid #d1a6ce;
                        border-top: none;
                        padding: 0.5em;
					}                    

					.document_response_table .document_response_table_body .table_body {
                        display: flex;
                        justify-content: space-between;
                        background: #fff;
                        border-bottom: none;
					}

					.document_response_table .document_response_table_body .table_body:first-of-type {
                        margin-top: 0.5em;
					}

					.document_response_table .document_response_table_body .document_response_table_cell {
                        display: flex;
                        flex-direction: column;
                        justify-content: space-between;
					}
                    
					.document_response_table .document_response_table_body .document_response_table_cell:last-of-type {
                        text-align: right;
					}

					.document_response_table .document_response_table_body .document_response_table_cell:first-of-type {
                        text-align: left;
					}

                    .document_response_action_table .violet_box_no_back {
                        padding: 0;
                    }

                    .document_response_action_table .document_response_action_table_header,
                    .document_response_action_table .document_response_action_table_body {
                        display: grid;
                        grid-template-columns: repeat(3, 1fr);
                        align-items: flex-start;
                        page-break-inside: avoid;
                    }
                    
            <!-- .document_response_action_table .document_response_action_table_header div:last-child {
                        text-align: right;
                    } -->

                    .document_response_action_table .document_response_action_table_body .document_response_action_table_cell {
                        margin: 0.5em 0;
                    }
                    
            <!-- .document_response_action_table .document_response_action_table_body .document_response_action_table_cell:last-of-type {
                        text-align: right;
                    } -->

                    .document_reference {
                        min-height: 35px;
                        display: flex;
                        justify-content: flex-start;
                        align-items: center;
                    }

                     .information_banner .violet_box {
                        min-height:4em;
                    }

                    .information_banner .violet_box .violet_title {
                        font-size:1.5em;
                        margin:0;
                    }
            
            <!-- GRID CSS -->
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

            <!-- PRINT STYLE -->
                    @media print {
                        .container {
                            width:80em;
                        }
                    }
            <!-- /PRINT STYLE -->

            <!-- /GENERAL CSS -->
        </style>
    </xsl:template>
    <xsl:template match="n1:ApplicationResponse">
        <!-- Start HTML -->
        <html>
            <xsl:call-template name="doc-head" />
            <head>
                <link rel="Stylesheet" type="text/css" href="PEPPOL.css" />
                <meta name="viewport" content="width=device-width,initial-scale=1" />
                <title>APPLICATION RESPONSE</title>
            </head>
            <body>
                <div class="container">
                    <header class="main_header grid_big_2fr_spliter">
                        <div>
                        <!-- SENDER -->
                            <xsl:if test="cac:SenderParty != ''">
                                <p class="title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-049'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div>
                                    <p>
                                        <b>
                                            <xsl:if test="cac:SenderParty/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                                                <xsl:apply-templates select="cac:SenderParty/cac:PartyLegalEntity/cbc:RegistrationName" />
                                            </xsl:if>
                                        </b>
                                    </p>
                                    <xsl:if test="cac:SenderParty/cac:PartyIdentification/cbc:ID">
                                        <xsl:apply-templates select="cac:SenderParty/cac:PartyIdentification/cbc:ID" />
                                        <xsl:if test="cac:SenderParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                                            &#160;[<xsl:apply-templates select="cac:SenderParty/cac:PartyIdentification/cbc:ID/@schemeID" />]
                                        </xsl:if>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                        <!-- /SENDER -->
                        </div>
                        <!-- DOCUMENT DETAILS -->
                        <div class="document_details">
                            <br/>
                            <h1>
                                <xsl:choose>
                                    <xsl:when test="cac:DocumentReference/cbc:DocumentTypeCode !='380'">
                                        <xsl:call-template name="DocumentHeader">
                                            <xsl:with-param name="DocumentCode" select="'CreditNoteResponse'" />
                                        </xsl:call-template>&#160;
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:call-template name="DocumentHeader">
                                            <xsl:with-param name="DocumentCode" select="'InvoiceResponse'" />
                                        </xsl:call-template>&#160;
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:value-of select="cbc:ID" />
                            </h1>
                            <xsl:if test="((cbc:Note !='') and (cbc:Note != 'Unknown'))">
                                <small>
                                    <b>
                                        <xsl:value-of select="cbc:Note"/>
                                    </b>
                                    <br/>
                                </small>
                            </xsl:if>
                        </div>
                        <!-- /DOCUMENT DETAILS -->
                    </header>
                    <br/>
                    <br/>
                    <!--receiver_and_dates_holder -->
                    <div class="grid_big_2fr_spliter">
                        <xsl:if test="((cac:SenderParty != '') or (cac:ReceiverParty != ''))">
                            <div class="violet_box">
                                <!-- RECEIVER-->
                                <xsl:if test="cac:ReceiverParty != ''">
                                    <div>
                                        <p class="title">
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-050'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </p>
                                        <div class="box_with_margin">
                                            <p>
                                                <b>
                                                    <xsl:if test="cac:ReceiverParty/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                                                        <xsl:apply-templates select="cac:ReceiverParty/cac:PartyLegalEntity/cbc:RegistrationName" />
                                                    </xsl:if>
                                                </b>
                                            </p>
                                            <xsl:if test="cac:ReceiverParty/cac:PartyIdentification/cbc:ID">
                                                <xsl:apply-templates select="cac:ReceiverParty/cac:PartyIdentification/cbc:ID" />
                                                <xsl:if test="cac:ReceiverParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                                                    &#160;[<xsl:apply-templates select="cac:ReceiverParty/cac:PartyIdentification/cbc:ID/@schemeID" />]
                                                </xsl:if>
                                            </xsl:if>
                                        </div>
                                    </div>
                                </xsl:if>
                                <!-- /RECEIVER -->
                            </div>
                        </xsl:if>
                        <div class="issue_date_holder">
                            <div class="grid_small_2fr_spliter">
                                <div class="issue_date">
                                    <xsl:if test="cbc:IssueDate !=''">
                                        <div class="violet_box corner_title_center_content">
                                            <!-- Inserting Issue date Label:  -->
                                            <h1>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-037'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </h1>
                                            <!-- Inserting Issue date:  -->
                                            <div>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cbc:IssueDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </div>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="cbc:IssueTime !=''">
                                        <div class="issue_time">
                                            <small>
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-044'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                                <br />
                                                <xsl:call-template name="formatTime">
                                                    <xsl:with-param name="time" select="cbc:IssueTime" />
                                                </xsl:call-template>
                                            </small>
                                        </div>
                                    </xsl:if>
                                </div>
                                <div class="violet_box corner_title_center_content">
                                    <!-- Inserting Effective date Label:  -->
                                    <h1>
                                        <xsl:call-template name="UMZLabelName">
                                            <xsl:with-param name="BT-ID" select="'UMZ-BT-060'"/>
                                            <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                        </xsl:call-template>
                                    </h1>
                                    <!-- Inserting Effective date:  -->
                                    <xsl:choose>
                                        <xsl:when test="cac:DocumentResponse/cac:Response/cbc:EffectiveDate !=''">
                                            <div>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="dateTime" select="cac:DocumentResponse/cac:Response/cbc:EffectiveDate" />
                                                    <xsl:with-param name="country" select="$languageCode" />
                                                </xsl:call-template>
                                            </div>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <div>/</div>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- receiver_and_dates_holder -->
                    <!-- DocumentResponse and DocumentReference -->
                    <div class="grid_big_2fr_spliter align_items_bottom">
                        <xsl:if test="cac:DocumentResponse != ''">
                            <div>
                                <div class="document_response_table">
                                    <div class="violet_box_no_back">
                                        <div class="document_response_table_header">
                                            <p class="text_center">
                                                <b>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-054'"/>
                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                    </xsl:call-template>
                                                </b>
                                            </p>
                                            <xsl:if test="cac:DocumentResponse/cac:Response/cbc:ResponseCode != ''">
                                                <div class="response_code">
                                                    <p>
                                                        [<xsl:apply-templates select="cac:DocumentResponse/cac:Response/cbc:ResponseCode"/>]
                                                        <xsl:call-template name="ApplicationResponseCode">
                                                            <xsl:with-param name="ResponseCode" select="cac:DocumentResponse/cac:Response/cbc:ResponseCode"/>
                                                        </xsl:call-template>
                                                    </p>
                                                </div>
                                            </xsl:if>
                                        </div>
                                        <div class="document_response_table_body">
                                            <xsl:if test="cac:DocumentResponse/cac:Response/cac:Status != ''">
                                                <xsl:choose>
                                                    <xsl:when test="cac:DocumentResponse/cac:Response/cac:Status/cbc:StatusReasonCode/@listID = 'OPStatusReason'">
                                                        <xsl:for-each select="cac:DocumentResponse/cac:Response/cac:Status">
                                                            <xsl:choose>
                                                                <xsl:when test="cbc:StatusReasonCode != ''">
                                                                    <xsl:if test="cbc:StatusReasonCode/@listID = 'OPStatusReason'">
                                                                        <div class="table_body">
                                                                            <div class="document_response_table_cell">
                                                                                <small>
                                                                                    <p>
                                                                                        <b>
                                                                                            <xsl:call-template name="UMZLabelName">
                                                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-057'"/>
                                                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                                            </xsl:call-template>
                                                                                        </b>
                                                                                    </p>
                                                                                    <p>
                                                                                        <xsl:call-template name="StatusClarificationReason">
                                                                                            <xsl:with-param name="Code" select="cbc:StatusReasonCode"/>
                                                                                        </xsl:call-template>
                                                                                        [<xsl:apply-templates select="cbc:StatusReasonCode"/>]
                                                                                    </p>
                                                                                </small>
                                                                            </div>
                                                                            <xsl:if test="cbc:StatusReason != ''">
                                                                                <small>
                                                                                    <p>
                                                                                        <b>
                                                                                            <xsl:call-template name="UMZLabelName">
                                                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-005'"/>
                                                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                                            </xsl:call-template>
                                                                                        </b>
                                                                                    </p>
                                                                                    <xsl:apply-templates select="cbc:StatusReason"/>
                                                                                </small>
                                                                            </xsl:if>
                                                                            <xsl:if test="cac:Condition != ''">
                                                                                <xsl:if test="(cac:Condition/cbc:AttributeID != '') or (cac:Condition/cbc:Description != '')">
                                                                                    <div class="document_response_table_cell">
                                                                                        <small>
                                                                                            <p>
                                                                                                <b>
                                                                                                    <xsl:call-template name="UMZLabelName">
                                                                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-058'"/>
                                                                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                                                    </xsl:call-template>
                                                                                                </b>
                                                                                            </p>
                                                                                            <xsl:for-each select="cac:Condition">
                                                                                                <p>
                                                                                                    <xsl:choose>
                                                                                                        <xsl:when test="((starts-with(cbc:AttributeID ,'BT-')) or (starts-with(cbc:AttributeID ,'BG-')))">
                                                                                                            <xsl:call-template name="LabelName">
                                                                                                                <xsl:with-param name="BT-ID" select="cbc:AttributeID"/>
                                                                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                                                            </xsl:call-template>
                                                                                                            [<xsl:apply-templates select="cbc:AttributeID" />]
                                                                                                        </xsl:when>
                                                                                                        <xsl:otherwise>
                                                                                                            [<xsl:apply-templates select="cbc:AttributeID" />]
                                                                                                        </xsl:otherwise>
                                                                                                    </xsl:choose>
                                                                                                </p>
                                                                                                <p class="box_with_bottom_margin">
                                                                                                    <small>
                                                                                                        <b>
                                                                                                            <xsl:call-template name="UMZLabelName">
                                                                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-065'"/>
                                                                                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                                                                            </xsl:call-template>
                                                                                                        </b>
                                                                                                        <xsl:apply-templates select="cbc:Description" />
                                                                                                    </small>
                                                                                                </p>
                                                                                            </xsl:for-each>
                                                                                        </small>
                                                                                    </div>
                                                                                </xsl:if>
                                                                            </xsl:if>
                                                                        </div>
                                                                        <br/>
                                                                    </xsl:if>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <div class="table_body">
                                                                        <div class="document_response_table_cell">
                                                                            <small>
                                                                                <xsl:apply-templates select="cbc:StatusReason"/>
                                                                            </small>
                                                                        </div>
                                                                    </div>
                                                                    <br/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                        </xsl:for-each>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <div class="table_body">
                                                            <div class="document_response_table_cell">
                                                                <small>
                                                                    <p>
                                                                        <b>
                                                                            <xsl:call-template name="UMZLabelName">
                                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-057'"/>
                                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                            </xsl:call-template>
                                                                        </b>
                                                                    </p>
                                                                    <xsl:call-template name="UMZLabelName">
                                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-061'"/>
                                                                        <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                    </xsl:call-template>
                                                                </small>
                                                                <br/>
                                                            </div>
                                                        </div>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </xsl:if>
                        <xsl:if test="cac:DocumentResponse/cac:DocumentReference != ''">
                            <div>
                                <br/>
                                <div class="violet_box_no_back document_reference">
                                    <b>
                                        <small>
                                            <xsl:call-template name="UMZLabelName">
                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-021'"/>
                                                <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                            </xsl:call-template>
                                        </small>
                                    </b>
                                    <xsl:if test="cac:DocumentResponse/cac:DocumentReference/cbc:ID != ''">
                                        <small>
                                            [<xsl:apply-templates select="cac:DocumentResponse/cac:DocumentReference/cbc:ID"/>]&#160;
                                            <xsl:call-template name="formatDate">
                                                <xsl:with-param name="dateTime" select="cac:DocumentResponse/cac:DocumentReference/cbc:IssueDate" />
                                                <xsl:with-param name="country" select="$languageCode" />
                                            </xsl:call-template>
                                        </small>
                                    </xsl:if>
                                </div>
                            </div>
                        </xsl:if>
                    </div>
                    <!-- /DocumentResponse and DocumentReference -->
                    <!-- Document Response Action Table -->
                    <xsl:if test="cac:DocumentResponse/cac:Response/cac:Status != ''">
                        <br/>
                        <div>
                            <div class="document_response_action_table">
                                <div class="violet_box_no_back">
                                    <div class="table_header document_response_action_table_header">
                                        <div>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-059'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-005'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                        <div>
                                            <b>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-058'"/>
                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                </xsl:call-template>
                                            </b>
                                        </div>
                                    </div>
                                        <xsl:choose>
                                            <xsl:when test="cac:DocumentResponse/cac:Response/cac:Status/cbc:StatusReasonCode/@listID = 'OPStatusAction'">
                                                <xsl:for-each select="cac:DocumentResponse/cac:Response/cac:Status">
                                                    <div class="document_response_action_table_body table_body">
                                                        <xsl:choose>
                                                            <xsl:when test="cbc:StatusReasonCode != ''">
                                                                <xsl:if test="cbc:StatusReasonCode/@listID = 'OPStatusAction'">
                                                                    <div class="document_response_action_table_cell">
                                                                        <p>
                                                                            <xsl:call-template name="StatusClarificationAction">
                                                                                <xsl:with-param name="Code" select="cbc:StatusReasonCode"/>
                                                                            </xsl:call-template>
                                                                            [<xsl:apply-templates select="cbc:StatusReasonCode"/>]
                                                                        </p>
                                                                    </div>
                                                                    <div class="document_response_action_table_cell">
                                                                        <xsl:if test="cbc:StatusReason != ''">
                                                                            <xsl:apply-templates select="cbc:StatusReason"/>
                                                                        </xsl:if>
                                                                    </div>
                                                                    <xsl:if test="cac:Condition != ''">
                                                                        <div class="document_response_action_table_cell">
                                                                            <xsl:if test="(cac:Condition/cbc:AttributeID != '') or (cac:Condition/cbc:Description != '')">
                                                                                <xsl:for-each select="cac:Condition">
                                                                                    <p>
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="((starts-with(cbc:AttributeID ,'BT-')) or (starts-with(cbc:AttributeID ,'BG-')))">
                                                                                                <xsl:call-template name="LabelName">
                                                                                                    <xsl:with-param name="BT-ID" select="cbc:AttributeID"/>
                                                                                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                                                                </xsl:call-template>
                                                                                                [<xsl:apply-templates select="cbc:AttributeID" />]
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                [<xsl:apply-templates select="cbc:AttributeID" />]
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </p>
                                                                                    <p class="box_with_bottom_margin">
                                                                                        <small>
                                                                                            <b>
                                                                                                <xsl:call-template name="UMZLabelName">
                                                                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-065'"/>
                                                                                                    <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                                                                                </xsl:call-template>
                                                                                            </b>
                                                                                            <xsl:apply-templates select="cbc:Description" />
                                                                                        </small>
                                                                                    </p>
                                                                                </xsl:for-each>
                                                                            </xsl:if>
                                                                        </div>
                                                                    </xsl:if>
                                                                </xsl:if>
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <div class="document_response_action_table_cell">
                                                                    <small>
                                                                        <xsl:apply-templates select="cbc:StatusReason"/>
                                                                    </small>
                                                                </div>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </div>
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <div class="document_response_action_table_body table_body">
                                                    <div class="document_response_action_table_cell">
                                                        <small>
                                                            <xsl:call-template name="UMZLabelName">
                                                                <xsl:with-param name="BT-ID" select="'UMZ-BT-062'"/>
                                                                <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                                            </xsl:call-template>
                                                        </small>
                                                    </div>
                                                </div>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>
                            </div>
                        </div>
                    </xsl:if>
                    <!-- /Document Response Action Table -->
                    <br/>
                    <div class="information_banner">
                        <div class="violet_box">
                            <h1 class="violet_title">
                                <xsl:call-template name="UMZLabelName">
                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-008'"/>
                                    <xsl:with-param name="Colon-Suffix" select="'false'"/>
                                </xsl:call-template>
                            </h1>
                        </div>
                    </div>
                    <div class="grid_big_2fr_spliter">
                        <!-- Additional sender's information -->
                        <div>
                            <xsl:if test="((cac:SenderParty/cac:PartyLegalEntity/cbc:RegistrationName !='') or (cac:SenderParty/cac:Contact) or (cac:SenderParty/cac:PartyIdentification/cbc:ID != '') or (cac:SenderParty/cbc:EndpointID != ''))">
                                <p class="violet_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-063'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="violet_box_no_back">
                                    <xsl:if test="cac:SenderParty/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                                        <b>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                </xsl:call-template>
                                            </small>
                                        </b>
                                        <p>
                                            <xsl:apply-templates select="cac:SenderParty/cac:PartyLegalEntity/cbc:RegistrationName" />
                                        </p>
                                    </xsl:if>
                                    <xsl:if test="cac:SenderParty/cac:Contact !=''">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-053'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:if test="cac:SenderParty/cac:Contact/cbc:Name !=''">
                                                <p class="UBLName">
                                                    <xsl:apply-templates select="cac:SenderParty/cac:Contact/cbc:Name"/>
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:SenderParty/cac:Contact/cbc:Telephone !=''">
                                                <p class="UBLTelephone">
                                                    <xsl:apply-templates select="cac:SenderParty/cac:Contact/cbc:Telephone" />
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:SenderParty/cac:Contact/cbc:Telefax !=''">
                                                <p class="UBLTelefax">
                                                    <xsl:apply-templates select="cac:SenderParty/cac:Contact/cbc:Telefax" />
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:SenderParty/cac:Contact/cbc:ElectronicMail !=''">
                                                <p class="UBLElectronicMail">
                                                    <xsl:apply-templates select="cac:SenderParty/cac:Contact/cbc:ElectronicMail" />
                                                </p>
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="cac:SenderParty/cac:PartyIdentification/cbc:ID">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-051'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:apply-templates select="cac:SenderParty/cac:PartyIdentification/cbc:ID" />
                                            <xsl:if test="cac:SenderParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                                                &#160;[<xsl:apply-templates select="cac:SenderParty/cac:PartyIdentification/cbc:ID/@schemeID" />]
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="cac:SenderParty/cbc:EndpointID">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-052'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:apply-templates select="cac:SenderParty/cbc:EndpointID"/>
                                            <xsl:if test="cac:SenderParty/cbc:EndpointID/@schemeID !='' ">
                                                [<xsl:value-of select="cac:SenderParty/cbc:EndpointID/@schemeID"/>]
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- /Additional sender's information -->
                        <!-- Additional receiver's information -->
                        <div>
                            <xsl:if test="((cac:ReceiverParty/cac:PartyLegalEntity/cbc:RegistrationName !='') or (cac:ReceiverParty/cac:Contact) or (cac:ReceiverParty/cac:PartyIdentification/cbc:ID != '') or (cac:ReceiverParty/cbc:EndpointID != ''))">
                                <p class="violet_title">
                                    <xsl:call-template name="UMZLabelName">
                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-064'"/>
                                        <xsl:with-param name="Colon-Suffix" select="'true'"/>
                                    </xsl:call-template>
                                </p>
                                <div class="violet_box_no_back">
                                    <xsl:if test="cac:ReceiverParty/cac:PartyLegalEntity/cbc:RegistrationName !=''">
                                        <b>
                                            <small>
                                                <xsl:call-template name="UMZLabelName">
                                                    <xsl:with-param name="BT-ID" select="'UMZ-BT-026'" />
                                                    <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                </xsl:call-template>
                                            </small>
                                        </b>
                                        <p>
                                            <xsl:apply-templates select="cac:ReceiverParty/cac:PartyLegalEntity/cbc:RegistrationName" />
                                        </p>
                                    </xsl:if>
                                    <xsl:if test="cac:ReceiverParty/cac:Contact !=''">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-053'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:if test="cac:ReceiverParty/cac:Contact/cbc:Name !=''">
                                                <p class="UBLName">
                                                    <xsl:apply-templates select="cac:ReceiverParty/cac:Contact/cbc:Name"/>
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:ReceiverParty/cac:Contact/cbc:Telephone !=''">
                                                <p class="UBLTelephone">
                                                    <xsl:apply-templates select="cac:ReceiverParty/cac:Contact/cbc:Telephone" />
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:ReceiverParty/cac:Contact/cbc:Telefax !=''">
                                                <p class="UBLTelefax">
                                                    <xsl:apply-templates select="cac:ReceiverParty/cac:Contact/cbc:Telefax" />
                                                </p>
                                            </xsl:if>
                                            <xsl:if test="cac:ReceiverParty/cac:Contact/cbc:ElectronicMail !=''">
                                                <p class="UBLElectronicMail">
                                                    <xsl:apply-templates select="cac:ReceiverParty/cac:Contact/cbc:ElectronicMail" />
                                                </p>
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="cac:ReceiverParty/cac:PartyIdentification/cbc:ID">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-051'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:apply-templates select="cac:ReceiverParty/cac:PartyIdentification/cbc:ID" />
                                            <xsl:if test="cac:ReceiverParty/cac:PartyIdentification/cbc:ID/@schemeID !='' ">
                                                &#160;[<xsl:apply-templates select="cac:ReceiverParty/cac:PartyIdentification/cbc:ID/@schemeID" />]
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                    <xsl:if test="cac:ReceiverParty/cbc:EndpointID">
                                        <div class="box_with_top_margin">
                                            <b>
                                                <small>
                                                    <xsl:call-template name="UMZLabelName">
                                                        <xsl:with-param name="BT-ID" select="'UMZ-BT-052'" />
                                                        <xsl:with-param name="Colon-Suffix" select="'true'" />
                                                    </xsl:call-template>
                                                </small>
                                            </b>
                                            <br/>
                                            <xsl:apply-templates select="cac:ReceiverParty/cbc:EndpointID"/>
                                            <xsl:if test="cac:ReceiverParty/cbc:EndpointID/@schemeID !='' ">
                                                [<xsl:value-of select="cac:ReceiverParty/cbc:EndpointID/@schemeID"/>]
                                            </xsl:if>
                                        </div>
                                    </xsl:if>
                                </div>
                            </xsl:if>
                        </div>
                        <!-- /Additional receiver's information -->
                    </div>
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