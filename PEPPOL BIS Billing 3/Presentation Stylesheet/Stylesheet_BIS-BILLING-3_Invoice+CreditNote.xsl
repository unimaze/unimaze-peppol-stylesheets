<?xml version="1.0" encoding="UTF-8"?>
<!--
******************************************************************************************************************

		PEPPOLInstance Documentation - reference stylesheet 	Version of this reference stylesheet: 1.0 [also c.f. Headlines.xml, TechFooter3]

		title= PEPPOL_BIS_HTML Stylesheet_2014.xsl	
		publisher= "SFTI tekniska kansli"
		Creator= SFTI/SL
		created= 2018-XX-XX
		conformsTo= UBL-Invoice-2.1.xsd and UBL-CreditNote-2.1.xsd
		description= "Stylesheet for PEPPOL BIS BILLING 3, covering Invoice and Credit Note.
		This stylesheet was drawn up to serve developers and end-users as a neutral reference tool when
		assessing transaction content. The purpose of the reference stylesheet is
		- To visualise all data structures, including all their occurrences, in transaction instances 
		  compliant to BIS BILLING 3; 
		- To show all data as is, i.e. without any editing;
		- To show relevant attributes: that is, attributes are displayed only to the extent that they have 
		  any impact on the understanding or interpretation of an element value. For example, a fix listID  
		  (like UNCL1001) would not be displayed. 

		The assumption is that is that the stylesheet is applied to messages that are formally correct, i.e. 
		messages that comply with XML schema and schematron rules. However, as this reference stylesheet is 
		likely to be used also in test environments, some basic validation features have been included, 
		and any consequential errors are displayed as needed."
		
		all terms derived from http://dublincore.org/documents/dcmi-terms/

		Derived from work by OIOUBL, Denmark. For more information, see www.sfti.se or email tekniskt.kansli@skl.se
		
******************************************************************************************************************
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fcn="urn:sfti:se:xsl:functions" xmlns:n1="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2" xmlns:n2="urn:oasis:names:specification:ubl:schema:xsd:CreditNote-2" xmlns:cdl="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2" xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2" xmlns:ccts="urn:oasis:names:specification:ubl:schema:xsd:CoreComponentParameters-2" xmlns:sdt="urn:oasis:names:specification:ubl:schema:xsd:SpecializedDatatypes-2"
xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2" exclude-result-prefixes="n1 n2 cdl cac cbc ccts sdt udt">
	<xsl:import href="CommonTemplates.xsl"/>
	<xsl:output method="html" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd" indent="yes"/>
	<xsl:strip-space elements="*"/>
	<xsl:param name="stylesheet_url" select="'NONE'"/>
	<xsl:template name="doc-head">
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
		<xsl:choose>
			<xsl:when test="$stylesheet_url = 'NONE'">
				<style>* {
    box-sizing: border-box;
}

:root {
  --white: #ffffff;
  --grey: #f3f3f2;
  --Line-color: #979797;
  --font-color: #484848;
}

/* Text styles */

h1 {
  font-family: Helvetica;
  font-size: 3.3vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 3.5vw;
  letter-spacing: normal;
  color: #484848;
}

h2 {
  font-family: Helvetica;
  font-size: 2.4vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 2.5vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}

h3 {
  font-family: Helvetica;
  font-size: 1.9vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 2vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}


h4 {
  font-family: Helvetica;
  font-size: 1.3vw;
  font-weight: bold;
  font-style: normal;
  font-stretch: normal;
  line-height: 1.5vw;
  letter-spacing: normal;
  color: #484848;
  margin:0px;
}

p,th,td {
  font-family: Helvetica;
  font-size: 1.2vw;
  font-weight: normal;
  font-style: normal;
  font-stretch: normal;
  line-height: 1.5vw;
  letter-spacing: normal;
  color: #484848;
  margin-top:0.5vw;
  margin-bottom:0.5vw;
}


table
{
	
	/*border: 2px solid black;*/
	width: 100%;
	
}
table, th, td
{
border-collapse: collapse;
}
tr
{
	vertical-align: top;
}
tr:nth-child(even) {
    background-color: #f3f3f2;
}

td
{
	vertical-align: top;
	border-bottom:1px solid #979797;
	/*border:2px solid black;*/
}


th
{
	border-bottom: 2px solid #979797;
	font-weight:normal;
}


td.UBLLine
{
	color:#979797;
	margin: 0em;
}

hr
{
color:var(--Line-color);

}



.col-1 {width: 8.33%;}
.col-2 {width: 16.66%;}
.col-3 {width: 25%;}
.col-4 {width: 33.33%;}
.col-5 {width: 41.66%;}
.col-6 {width: 50%;}
.col-7 {width: 58.33%;}
.col-8 {width: 66.66%;}
.col-9 {width: 75%;}
.col-10 {width: 83.33%;}
.col-11 {width: 91.66%;}
.col-12 {width: 100%;}

[class*="col-"] {
    float: left;
    padding: 1px;
	margin-top:1px;
	border: solid 0px #979797;
}

.row::after {
    content: "";
    clear: both;
    display: table;
}
#bottomrow{

border-bottom:2px solid #979797;
}
#wrapper{
padding:1vw;
border: 1px solid #979797;
}
#footer
{
border-top: 2px solid #979797;
background-color: #f3f3f2;
padding:0px;
margin-top:1vw;
}
#header
{
padding: 0.5vw;
}
#headerrow
{
padding-top:1vw;
border-bottom:1px solid #979797;
}
#tablerow
{
padding-top:1vw;
}

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
			<xsl:call-template name="doc-head"/>
			<head>
				<link rel="Stylesheet" type="text/css" href="PEPPOL.css"/>
				<meta name="viewport" content="width=device-width,initial-scale=1"/>
				<title>PEPPOL BIS-BILLING 3 Invoice AND CREDIT NOTE</title>
			</head>
			<body>
				<div id="wrapper">
					<!-- Start on Invoice Type row-->
					<div class="row" id="bottomrow">
						<div class="col-6">
							<!--<xsl:value-of select="fcn:LabelName('BT-3', 'true')"/>-->
							<xsl:if test="local-name(.)  = 'Invoice'">
								<h2 style="margin-bottom:0px">
									<xsl:call-template name="DocumentHeader"><xsl:with-param name="DocumentCode" select="local-name(.)" /></xsl:call-template>
								</h2>
								<xsl:if test="cbc:InvoiceTypeCode !='380'">
									<h3 style="margin-top:0px">
										<xsl:call-template name="DocumentCode"><xsl:with-param name="DCode" select="cbc:InvoiceTypeCode"/></xsl:call-template>
									</h3>
								</xsl:if>
							</xsl:if>
							<xsl:if test="local-name(.)  = 'CreditNote'">
								<h2 style="margin-bottom:0px">
									<xsl:call-template name="DocumentHeader"><xsl:with-param name="DocumentCode" select="local-name(.)"/></xsl:call-template>
								</h2>
								<xsl:if test="cbc:CreditNoteTypeCode != '381'">
									<h3 style="margin-top:0px">
										<xsl:call-template name="DocumentCode"><xsl:with-param name="DCode" select="cbc:CreditNoteTypeCode"/></xsl:call-template>
									</h3>
								</xsl:if>
							</xsl:if>
							<h1>
								<xsl:choose>
									<xsl:when test="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name !=''">
										<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName"/>
									</xsl:otherwise>
								</xsl:choose>
							</h1>
						</div>
						<div class="col-6" id="header">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-2'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<!-- Inserting Invoice Date -->
									<xsl:value-of select="cbc:IssueDate"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-9'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<!-- Inserting Due Date:  -->
									<xsl:if test="local-name(.) = 'CreditNote'">
											<!--xsl:for-each select="cac:PaymentMeans">
												<xsl:if test="cbc:PaymentDueDate !=''">
													<item><xsl:value-of select="cbc:PaymentDueDate"/></item>
												</xsl:if>
											</xsl:for-each-->
									<xsl:value-of select="cac:PaymentMeans[1]/cbc:PaymentDueDate"/>
									</xsl:if>
									<xsl:if test="local-name(.) = 'Invoice'">
										<xsl:value-of select="cbc:DueDate"/>
									</xsl:if>
									<br/>
								</p>
								<xsl:if test="cac:InvoicePeriod !=''">
									<xsl:if test="cac:InvoicePeriod/cbc:StartDate !=''">
										<p align="left">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-73'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
											<br/>
											<xsl:apply-templates select="cac:InvoicePeriod/cbc:StartDate"/>
											<br/>
										</p>
									</xsl:if>
									<xsl:if test="cac:InvoicePeriod/cbc:EndDate !='' ">
										<p align="left">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-74'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
											<br/>
											<xsl:apply-templates select="cac:InvoicePeriod/cbc:EndDate"/>
										</p>
									</xsl:if>
								</xsl:if>
							</div>
							<!--Start of invoice Header Information:-->
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-1'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<!-- Inserting Invoice ID -->
									<br/>
									<xsl:value-of select="cbc:ID"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-13'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<!-- Inserting Order reference number  -->
									<xsl:value-of select="cac:OrderReference/cbc:ID"/>
									<br/>
								</p>
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-10'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<!-- Inserting Buyer Reference::  -->
									<xsl:value-of select="cbc:BuyerReference"/>
									<br/>
								</p>
								<xsl:choose>
									<xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
										<p align="left" style="color:red">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-115'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
											<br/>
											<!-- Inserting Total Payable amount  -->
											
											<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/></xsl:call-template>&#160;<xsl:value-of select="cbc:DocumentCurrencyCode"/>
											<br/>
										</p>
									</xsl:when>
									<xsl:otherwise>
										<p align="left">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-115'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
											<br/>
											<!-- Inserting Total Payable amount  -->
											
											<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/></xsl:call-template>&#160;<xsl:value-of select="cbc:DocumentCurrencyCode"/>
											<br/>
										</p>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</div>
						<!--End of invoice Header Information-->
					</div>
					<div class="row" id="headerrow">
						<div class="col-3">
							<!-- Inserting Accounting Customer Party -->
							<p>
								<b>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-7'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
								</b>
								<br/>
								<xsl:apply-templates select="cac:AccountingCustomerParty"/>
							</p>
						</div>
						<div class="col-3">
						<p>
							<xsl:if test="cac:AccountingCustomerParty/cac:Party/cac:Contact !='' or cbc:AccountingCost !=''">
								<!-- Inserting Contact information-->
								
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-9'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<xsl:call-template name="BuyerContact"/>
							</xsl:if>
							<xsl:if test="cbc:AccountingCost !=''">
										<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-19'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
									<xsl:value-of select="cbc:AccountingCost"/>
							</xsl:if>
							</p>
						</div>
						<div class="col-6">
						<xsl:if test="cac:ContractDocumentReference !=''">
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-12'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
									<xsl:apply-templates select="cac:ContractDocumentReference"/>
								</p>
							</xsl:if>
							<xsl:if test="cbc:Note[.!='']">
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-22'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<xsl:apply-templates select="cbc:Note"/>
								</p>
							</xsl:if>
							
						</div>
						<!--Start of Payee Row-->
					</div>
					<div class="row" id="headerrow">
						<div class="col-3">
							<xsl:apply-templates select="cac:Delivery" mode="DocumentHeader"/>
							<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=' '">
								<xsl:if test="cac:Delivery/cbc:ActualDeliveryDate !=''">
									<p>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-72'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
										<xsl:apply-templates select="cac:Delivery/cbc:ActualDeliveryDate"/>
									</p>
								</xsl:if>
							</xsl:if>
						</div>
						<div class="col-3">
							<xsl:if test="cac:PayeeParty !=''">
								<!-- Inserting Payee Party -->
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-10'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<xsl:call-template name="PayeeParty"/>
								</p>
							</xsl:if>
						</div>
						<div class="col-6">
						<p>
							<xsl:if test="cac:AdditionalDocumentReference !=''">
								
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-24'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode != '130' and cbc:DocumentTypeCode != '50' or  not(cbc:DocumentTypeCode)]" mode="Supporting"/>
								
							</xsl:if>
							<xsl:if test="cac:BillingReference !=''">
								
									<xsl:for-each select="cac:BillingReference/cac:InvoiceDocumentReference">
										<br/>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-25'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
										<!-- Inserting Preceding invoice number  -->
										<xsl:value-of select="cbc:ID"/>
										<!-- Inserting Preceding Invoice Issue Date  -->
										<xsl:if test="cbc:IssueDate != ''">
										 ( <xsl:value-of select="cbc:IssueDate"/> )
										 </xsl:if>
									</xsl:for-each>
								
							</xsl:if>
							<xsl:if test="cac:AdditionalDocumentReference !=''">
								
									<xsl:apply-templates select="cac:AdditionalDocumentReference[cbc:DocumentTypeCode='130' or cbc:DocumentTypeCode='50']" mode="InvoicedObject"/>
								
							</xsl:if>
							<xsl:if test="cac:DespatchDocumentReference/cbc:ID">
								
									<br/>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-16'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
									<!-- Inserting Despatch advice reference  -->
									<xsl:value-of select="cac:DespatchDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:ReceiptDocumentReference/cbc:ID">
								
										<br/>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-15'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
										<!-- Inserting Receipt advice reference  -->
										<xsl:value-of select="cac:ReceiptDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:OriginatorDocumentReference/cbc:ID">
								
									<br/>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-17'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
										<!-- Inserting Originator advice reference  -->
										<xsl:value-of select="cac:OriginatorDocumentReference/cbc:ID"/>
								
							</xsl:if>
							<xsl:if test="cac:ProjectReference/cbc:ID">
									
										<br/>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-11'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
										<!-- Inserting Project advice reference  -->
										<xsl:value-of select="cac:ProjectReference/cbc:ID"/>
									
							</xsl:if>
							</p>
						
						</div>
					</div>
					<!--Start Invoiceline-->
					<div class="row" id="tablerow">
						<div class="col-12">
							<table>
								<tr class="UBLInvoiceLineHeader">
									<th align="left" valign="top" width="5%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-126'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-155'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="left" valign="top" width="35%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-153'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th valign="top" align="left" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-129'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-146'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-151'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="left" valign="top" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-28'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template><br/><xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-27'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
									<th align="right" valign="top" width="10%">
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-131'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
									</th>
								</tr>
								<xsl:if test="cac:InvoiceLine != ''">
									<xsl:apply-templates select="cac:InvoiceLine"/>
								</xsl:if>
								<xsl:if test="cac:CreditNoteLine != ''">
									<xsl:apply-templates select="cac:CreditNoteLine"/>
								</xsl:if>
							</table>
						</div>
					</div>
					<!--End Invoiceline-->
					<!-- Start sum of invoice line net amount: -->
					<div class="row" id="sum">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-106'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<b>
									<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:LineExtensionAmount/@currencyID"/>
								</b>
							</p>
						</div>
					</div>
					<!-- End Sum of invoice line net amount -->
					<!-- Start Allowances and charges on document level: -->
					<!--Start Document allowances-->
					<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='false']">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-20'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
								</h3>
								<table>
									<tr>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-105'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-104'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-102'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="right" valign="top" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-93'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th valign="top" align="right" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-99'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:AllowanceCharge">
										<xsl:if test="cbc:ChargeIndicator ='false'">
											<xsl:call-template name="Allowance"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</div>
						</div>
					</xsl:if>
					<!--End Document allowances-->
					<!-- Start AllowanceTotal Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount !='' ">
						<div class="row" id="sum">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-107'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<b>
										<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount/@currencyID"/>
									</b>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End AllowanceTotal Amount -->
					<!--Start Document Charges-->
					<xsl:if test="cac:AllowanceCharge[cbc:ChargeIndicator ='true']">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-21'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
								</h3>
								<table>
									<tr>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-98'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-97'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-95'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="right" valign="top" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-100'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th valign="top" align="right" width="20%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-92'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:AllowanceCharge">
										<xsl:if test="cbc:ChargeIndicator ='true'">
											<xsl:call-template name="Charge"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</div>
						</div>
					</xsl:if>
					<!--End Document Charges-->
					<!-- Start ChargeTotal Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount !='' ">
						<div class="row" id="sum">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-108'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<b>
										<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:ChargeTotalAmount/@currencyID"/>
									</b>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End ChargeTotal Amount -->
					<!-- Start VAT Breakdown: -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<h3>
								<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-23'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
							</h3>
							<p>
								<xsl:if test="cbc:TaxPointDate !=''">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-7'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
									<xsl:value-of select="cbc:TaxPointDate"/>
								</xsl:if>
								<xsl:if test="cac:InvoicePeriod/cbc:DescriptionCode != ''">
										<br/>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-8'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
										</b>
										<xsl:call-template name="UBLDescriptionCode"><xsl:with-param name="Code" select="cac:InvoicePeriod/cbc:DescriptionCode"/></xsl:call-template> [<xsl:value-of select="cac:InvoicePeriod/cbc:DescriptionCode"/>]
<br/>
								</xsl:if>
									
								
							</p>
						</div>
					</div>
					<div class="row" id="tablerow">
						<div class="col-12">
							<table>
								<xsl:if test="cac:TaxTotal">
									<tr class="TAXInformationHeader">
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-118'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-120'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2" width="25%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-116'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<!--th valign="top" align="right">
										<b>
											<xsl:value-of select="fcn:LabelName('BT-111', 'true')"/>
										</b>
									</th-->
										<th valign="top" align="right" width="25%">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-117'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:apply-templates select="cac:TaxTotal/cac:TaxSubtotal"/>
								</xsl:if>
							</table>
						</div>
					</div>
					<!--End VAT Breakdown -->
					<!-- Start Tax Amount: -->
					<xsl:if test="cbc:TaxCurrencyCode !=''">
						<div class="row">
							<div class="col-12">
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-6'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
									<xsl:value-of select="cbc:TaxCurrencyCode"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<xsl:if test="cac:TaxTotal/cbc:TaxAmount">
						<xsl:if test="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]">
							<div class="row" id="headerrow">
								<div class="col-6">
									<p>
										<b>
											<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-110'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										</b>
									</p>
								</div>
								<div class="col-3">
									<p align="right">
										<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:TaxCurrencyCode]/@currencyID"/>
									</p>
								</div>
								<div class="col-3">
									<p align="right">
										<b>
											<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:TaxTotal/cbc:TaxAmount[@currencyID=../../cbc:DocumentCurrencyCode]/@currencyID"/>
										</b>
									</p>
								</div>
							</div>
						</xsl:if>
					</xsl:if>
					<!-- End Tax Amount -->
					<!-- Start TaxExclusive Amount: -->
					<div class="row" id="headerrow">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-109'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount"/></xsl:call-template>
							</p>
						</div>
					</div>
					<!-- End TaxExclusive Amount -->
					<!-- Start TaxInclusive Amount: -->
					<div class="row" id="headerrow">
						<div class="col-6">
							<p align="left">
								<b>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-112'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								</b>
							</p>
						</div>
						<div class="col-6">
							<p align="right">
								<b>
									<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount"/></xsl:call-template>
								</b>
							</p>
						</div>
					</div>
					<!-- End TaxInclusive Amount -->
					<!-- Start Prepaid Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:PrepaidAmount !='' ">
						<div class="row" id="headerrow">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-113'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PrepaidAmount"/></xsl:call-template>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End Prepaid Amount -->
					<!-- Start Rounding Amount: -->
					<xsl:if test="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount !='' ">
						<div class="row" id="headerrow">
							<div class="col-6">
								<p align="left">
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-114'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</b>
								</p>
							</div>
							<div class="col-6">
								<p align="right">
									<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableRoundingAmount"/></xsl:call-template>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- End Rounding Amount -->
					<!-- Start Payable Amount: -->
					<div class="row" id="headerrow">
						<xsl:choose>
							<xsl:when test="cac:LegalMonetaryTotal/cbc:PayableAmount &lt; '0'">
								<div class="col-6">
									<h2 align="left" style="color:red">
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-115'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</h2>
								</div>
								<div class="col-6">
									<h2 align="right" style="color:red">
										<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
									</h2>
								</div>
							</xsl:when>
							<xsl:otherwise>
								<div class="col-6">
									<h2 align="left">
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-115'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
									</h2>
								</div>
								<div class="col-6">
									<h2 align="right">
										<xsl:call-template name="Currency"><xsl:with-param name="currencyvalue" select="cac:LegalMonetaryTotal/cbc:PayableAmount"/></xsl:call-template>&#160;<xsl:apply-templates select="cac:LegalMonetaryTotal/cbc:PayableAmount/@currencyID"/>
									</h2>
								</div>
							</xsl:otherwise>
						</xsl:choose>
					</div>
					<!-- End Payable Amount -->
					<!-- Start document totals: -->
					<!-- Start on PAYMENT TERMS information -->
					<xsl:if test="cac:PaymentTerms !=''">
						<div class="row" id="tablerow">
							<div class="col-12">
								<h3>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-20'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								</h3>
								<p>
									<xsl:apply-templates select="cac:PaymentTerms"/>
								</p>
							</div>
						</div>
					</xsl:if>
					<!-- Start on PAYMENT MEANS information -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<h3>
								<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-16'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
							</h3>
							<xsl:if test="cac:PaymentMeans/cac:PayeeFinancialAccount !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-81'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-86'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-84'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
											
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-85'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-83'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:PayeeFinancialAccount !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
										<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="not(cac:PaymentMandate) and not(cac:CardAccount) and not(cac:PayeeFinancialAccount)">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
							<xsl:if test="cac:PaymentMeans/cac:CardAccount !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-81'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-86-1'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-87'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-88'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-83'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:CardAccount !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								</table>
							</xsl:if>
							<xsl:if test="cac:PaymentMeans/cac:PaymentMandate !=''">
								<table>
									<tr>
										<th align="left" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-81'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>&#160;&#160;
								</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-91'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-89'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="left" valign="top" colspan="2">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-90'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
										<th align="right" valign="top">
											<b>
												<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-83'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
											</b>
										</th>
									</tr>
									<xsl:for-each select="cac:PaymentMeans">
										<xsl:if test="cac:PaymentMandate !=''">
											<xsl:call-template name="cac:PaymentMeans"/>
										</xsl:if>
									</xsl:for-each>
								
								</table>
							</xsl:if>
						</div>
					</div>
					<!-- End of PAYMENT MEANS information -->
					<!-- Seller Row starts here-->
					<div class="row" id="footer">
						<div class="col-4">
							<!-- Inserting Accounting Supplier Party-->
							<p>
								<b>
									<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-4'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
								</b>
								<br/>
								<xsl:apply-templates select="cac:AccountingSupplierParty"/>
							</p>
						</div>
						<div class="col-4">
							<!-- Inserting contact information -->
							<xsl:if test="cac:AccountingSupplierParty/cac:Party/cac:Contact !=''">
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-6'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<xsl:call-template name="SellerContact"/>
								</p>
							</xsl:if>
							<xsl:if test="cac:OrderReference/cbc:SalesOrderID">
								<p align="left">
									<b><xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-14'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template></b>
									<!-- Inserting Sales order reference number  -->
									<xsl:value-of select="cac:OrderReference/cbc:SalesOrderID"/>
									<br/>
								</p>
							</xsl:if>
							
						</div>
						<div class="col-4">
							<xsl:if test="cac:TaxRepresentativeParty !=''">
								<p>
									<b>
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BG-11'"/><xsl:with-param name="Colon-Suffix" select="'false'"/></xsl:call-template>
									</b>
									<br/>
									<xsl:apply-templates select="cac:TaxRepresentativeParty"/>
								</p>
							</xsl:if>
						</div>
					</div>
					<!-- End of Invoice Note information -->
					<!-- Start on technical stylesheet footer - for all transactions -->
					<div class="row" id="tablerow">
						<div class="col-12">
							<p>
							<small>
								<xsl:value-of select="cbc:UBLVersionID"/>
								<br/>
								<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-23'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								<xsl:value-of select="cbc:ProfileID"/>
								<br/>
								<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-24'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
								<xsl:value-of select="cbc:CustomizationID"/>
								<xsl:if test="cbc:UUID !=''">
									<xsl:value-of select="cbc:UUID"/>
									<br/>
								</xsl:if>
								<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
									<br/>
								
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-34'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										<xsl:apply-templates select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID"/>
										<xsl:if test="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
											[<xsl:value-of select="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID/@schemeID"/>]
										</xsl:if>
								
								</xsl:if>
								<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
									<br/>
								
										<xsl:call-template name="LabelName"><xsl:with-param name="BT-ID" select="'BT-49'"/><xsl:with-param name="Colon-Suffix" select="'true'"/></xsl:call-template>
										<xsl:apply-templates select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID"/>
										<xsl:if test="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID !='' ">
										[<xsl:value-of select="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID/@schemeID"/>]
										</xsl:if>
										</xsl:if>
					<br/>This invoice visualization is generated from SFTI BIS Billing 3 XSL Stylesheet Version 1.0.3<br/>
					This stylesheet uses business terms defined the CEN/EN16931-1 and is reproduced with permission from CEN. CEN bears no liability from the use of the content and implementation of this stylesheet and gives no warranties expressed or implied for any purpose.<br/>
					
					
								
								</small>
							</p>
						</div>
					</div>
					<!-- End of technical stylesheet footer-->
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
